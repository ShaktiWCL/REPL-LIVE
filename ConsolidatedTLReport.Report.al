report 50030 "Consolidated TL Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/ConsolidatedTLReport.rdl';

    dataset
    {
        dataitem("HOD & Manager Setup"; "HOD & Manager Setup")
        {
            column(HODCode_HODManagerSetup; "HOD & Manager Setup"."HOD Code")
            {
            }
            column(HODName_HODManagerSetup; "HOD & Manager Setup"."HOD Name")
            {
            }
            column(ManagerCode_HODManagerSetup; "HOD & Manager Setup"."Manager Code")
            {
            }
            column(ManagerName_HODManagerSetup; "HOD & Manager Setup"."Manager Name")
            {
            }
            column(TotalProjectValue; GetProjectValue("HOD & Manager Setup"."Manager Code"))
            {
            }
            column(ActualBillValue; GetActualBillValue("HOD & Manager Setup"."Manager Code"))
            {
            }
            column(ProjectReceiptAmt; GetProjectReceiptAmt("HOD & Manager Setup"."Manager Code"))
            {
            }
            column(SubProjectReceiptAmt; GetSubProjectReceiptAmt("HOD & Manager Setup"."Manager Code"))
            {
            }
            column(PMCProjectReceiptAmt; GetPMCProjectReceiptAmt("HOD & Manager Setup"."Manager Code"))
            {
            }
            column(ProjectExpensesAmt; GetProjectExpensesAmt("HOD & Manager Setup"."Manager Code"))
            {
            }
            column(TLProjectReceiptAmt; GetProjectReceiptAmt("HOD & Manager Setup"."Manager Code") + GetSubProjectReceiptAmt("HOD & Manager Setup"."Manager Code") + GetPMCProjectReceiptAmt("HOD & Manager Setup"."Manager Code") - (GetProjectExpensesAmt("HOD & Manager Setup"."Manager Code")))
            {
            }
            column(OutstandingValue; GetOutstandingValue("HOD & Manager Setup"."Manager Code"))
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                    Caption = 'Start Date';
                }
                field("End Date"; EndDate)
                {
                    Caption = 'End Date';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            Month := DATE2DMY(TODAY, 2);
            Fyear := DATE2DMY(TODAY, 3);
            IF Month IN [1, 2, 3] THEN
                Fyear1 := Fyear - 1
            ELSE
                Fyear1 := Fyear;

            StartDate := DMY2DATE(1, 4, Fyear1);
            EndDate := DMY2DATE(31, 3, Fyear1 + 1);
        end;
    }

    labels
    {
    }

    var
        ExpectedBillDetails: Record "Expected Bill Details";
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Fyear: Integer;
        Fyear1: Integer;

    procedure GetActualBillValue(ManagerCode: Code[20]) ActualBillValue: Decimal
    var
        Project: Record Job;
        ProjectPlanningInvoice: Record "Job Planning Line Invoice";
    begin
        Project.SETRANGE("Project Manager", ManagerCode);
        IF Project.FINDSET THEN
            REPEAT
                ProjectPlanningInvoice.SETRANGE("Job No.", Project."No.");
                ProjectPlanningInvoice.SETRANGE("Document Type", ProjectPlanningInvoice."Document Type"::"Posted Invoice");
                ProjectPlanningInvoice.SETRANGE("Invoiced Date", StartDate, EndDate);
                IF ProjectPlanningInvoice.FINDFIRST THEN
                    REPEAT
                        ProjectPlanningInvoice.CALCFIELDS(ProjectPlanningInvoice."Invoiced Amount Incl. Tax");
                        ActualBillValue += ProjectPlanningInvoice."Invoiced Amount Incl. Tax";
                    UNTIL ProjectPlanningInvoice.NEXT = 0;
            UNTIL Project.NEXT = 0;

        EXIT(ActualBillValue);
    end;

    procedure GetProjectReceiptAmt(ManagerCode: Code[20]) ProjectReceiptAmt: Decimal
    var
        Project: Record Job;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        CostCenter: Text;
    begin
        Project.SETRANGE("Project Manager", ManagerCode);
        IF Project.FINDSET THEN
            REPEAT
                IF Project."Global Dimension 1 Code" <> '' THEN BEGIN
                    IF CostCenter <> '' THEN
                        CostCenter += '|' + Project."Global Dimension 1 Code"
                    ELSE
                        CostCenter := Project."Global Dimension 1 Code";
                END;
            UNTIL Project.NEXT = 0;

        IF CostCenter <> '' THEN BEGIN
            BankAccountLedgerEntry.SETFILTER("Global Dimension 1 Code", CostCenter);
            BankAccountLedgerEntry.SETFILTER("Source Code", 'BANKRCPTV');
            BankAccountLedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
            IF BankAccountLedgerEntry.FINDFIRST THEN
                REPEAT
                    ProjectReceiptAmt += BankAccountLedgerEntry."Amount (LCY)";
                UNTIL BankAccountLedgerEntry.NEXT = 0;
        END;

        EXIT(ProjectReceiptAmt);
    end;

    procedure GetSubProjectReceiptAmt(ManagerCode: Code[20]) ProjectReceiptAmt: Decimal
    var
        Project: Record Job;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        CostCenter: Text;
        Project2: Record Job;
        SubProjectPercentage: Decimal;
        SubProjectValue: Decimal;
    begin
        Project.SETRANGE("Project Manager", ManagerCode);
        Project.SETRANGE("Type Of Project", Project."Type Of Project"::"Sub Project");
        IF Project.FINDSET THEN
            REPEAT
                IF Project2.GET(Project."Parent Project Code") THEN
                    IF Project2."Project Value" <> 0 THEN BEGIN
                        SubProjectPercentage := (Project."Project Value" * 100) / Project2."Project Value";
                        SubProjectValue += (GetProjectReceiptAmt(Project."Project Manager") * SubProjectPercentage) / 100;
                    END;
            UNTIL Project.NEXT = 0;
        ProjectReceiptAmt := SubProjectValue;
        EXIT(ProjectReceiptAmt);
    end;

    procedure GetPMCProjectReceiptAmt(ManagerCode: Code[20]) ProjectReceiptAmt: Decimal
    var
        Project: Record Job;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        CostCenter: Text;
        Project2: Record Job;
        PMCProjectPercentage: Decimal;
        PMCProjectValue: Integer;
    begin
        Project.SETRANGE("Project Manager", ManagerCode);
        Project.SETRANGE("Type Of Project", Project."Type Of Project"::"PMC Project");
        IF Project.FINDSET THEN
            REPEAT
                IF Project2.GET(Project."Parent Project Code") THEN
                    IF Project2."Project Value" <> 0 THEN BEGIN
                        PMCProjectPercentage := (Project."Project Value" * 100) / Project2."Project Value";
                        PMCProjectValue += (GetProjectReceiptAmt(Project."Project Manager") * PMCProjectPercentage) / 100;
                    END;
            UNTIL Project.NEXT = 0;
        ProjectReceiptAmt := PMCProjectValue;
        EXIT(ProjectReceiptAmt);
    end;

    procedure GetProjectExpensesAmt(ManagerCode: Code[20]): Decimal
    var
        Project: Record Job;
        GLEntry: Record "G/L Entry";
        CostCenter: Text;
        ProjectJVExpensesAmt: Decimal;
        PurchInvHeader: Record "Purch. Inv. Header";
        ProjectPurchExpensesAmt: Decimal;
        Project2: Record Job;
    begin
        Project.SETRANGE("Project Manager", ManagerCode);
        IF Project.FINDSET THEN
            REPEAT
                Project2.SETRANGE("Parent Project Code", Project."No.");
                IF Project2.FINDFIRST THEN
                    REPEAT
                        IF Project2."Type Of Project" = Project2."Type Of Project"::"Sub Project" THEN
                            ProjectJVExpensesAmt += GetSubProjectReceiptAmt(Project2."Project Manager")
                        ELSE
                            ProjectPurchExpensesAmt += GetPMCProjectReceiptAmt(Project2."Project Manager");
                    UNTIL Project2.NEXT = 0;
            /*
            IF Project."Global Dimension 1 Code" <> '' THEN BEGIN
              IF CostCenter <> '' THEN
               CostCenter += '|'+Project."Global Dimension 1 Code"
              ELSE
               CostCenter := Project."Global Dimension 1 Code";
            END;
            */
            UNTIL Project.NEXT = 0;
        /*
        IF CostCenter <>'' THEN BEGIN
          GLEntry.SETFILTER("Global Dimension 1 Code",CostCenter);
          GLEntry.SETFILTER("Source Code",'JV');
          GLEntry.SETFILTER(Amount,'>%1',0);
          GLEntry.SETRANGE("Posting Date",StartDate,EndDate);
          IF GLEntry.FINDFIRST THEN
           REPEAT
            ProjectJVExpensesAmt += GLEntry.Amount;
           UNTIL GLEntry.NEXT =0;
        
          PurchInvHeader.SETFILTER("Shortcut Dimension 1 Code",CostCenter);
          PurchInvHeader.SETRANGE("Posting Date",StartDate,EndDate);
          IF PurchInvHeader.FINDFIRST THEN
           REPEAT
            PurchInvHeader.CALCFIELDS(PurchInvHeader."Amount to Vendor");
            ProjectPurchExpensesAmt += PurchInvHeader."Amount to Vendor";
           UNTIL PurchInvHeader.NEXT = 0;
        END;
        */
        EXIT(ProjectJVExpensesAmt + ProjectPurchExpensesAmt);

    end;

    procedure GetProjectValue(ManagerCode: Code[20]) TotalProjectValue: Decimal
    var
        Project: Record Job;
        ProjectPlanningInvoice: Record "Job Planning Line Invoice";
        ActualBillValue: Decimal;
        ActualBillValue1: Decimal;
    begin
        Project.SETRANGE("Project Manager", ManagerCode);
        IF Project.FINDSET THEN
            REPEAT
                ProjectPlanningInvoice.SETRANGE("Job No.", Project."No.");
                ProjectPlanningInvoice.SETRANGE("Document Type", ProjectPlanningInvoice."Document Type"::"Posted Invoice");
                ProjectPlanningInvoice.SETRANGE("Invoiced Date", 0D, StartDate - 1);
                IF ProjectPlanningInvoice.FINDFIRST THEN
                    REPEAT
                        ProjectPlanningInvoice.CALCFIELDS(ProjectPlanningInvoice."Invoiced Amount Incl. Tax");
                        ActualBillValue += ProjectPlanningInvoice."Invoiced Amount Incl. Tax";
                    UNTIL ProjectPlanningInvoice.NEXT = 0;
                ActualBillValue1 += ActualBillValue;
                TotalProjectValue += Project."Project Value";
            UNTIL Project.NEXT = 0;

        EXIT(TotalProjectValue - ActualBillValue1);
    end;

    procedure GetOutstandingValue(ManagerCode: Code[20]) ActualBillValue: Decimal
    var
        Project: Record Job;
        ProjectPlanningInvoice: Record "Job Planning Line Invoice";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        Project.SETRANGE("Project Manager", ManagerCode);
        IF Project.FINDSET THEN
            REPEAT
                ProjectPlanningInvoice.SETRANGE("Job No.", Project."No.");
                ProjectPlanningInvoice.SETRANGE("Document Type", ProjectPlanningInvoice."Document Type"::"Posted Invoice");
                ProjectPlanningInvoice.SETRANGE("Invoiced Date", StartDate, EndDate);
                IF ProjectPlanningInvoice.FINDFIRST THEN
                    REPEAT
                        DetailedCustLedgEntry.SETRANGE("Document No.", ProjectPlanningInvoice."Document No.");
                        IF DetailedCustLedgEntry.FINDFIRST THEN
                            REPEAT
                                ActualBillValue += DetailedCustLedgEntry.Amount;
                            UNTIL DetailedCustLedgEntry.NEXT = 0;
                    UNTIL ProjectPlanningInvoice.NEXT = 0;
            UNTIL Project.NEXT = 0;

        EXIT(ActualBillValue);
    end;
}

