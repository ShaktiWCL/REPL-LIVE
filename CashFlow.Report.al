report 50029 "Cash Flow"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CashFlow.rdl';

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
            column(ExpectedBilling; ExpectedBillAmt)
            {
            }
            column(ExpectedReceipt; ExpectedReceiptAmt)
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

            trigger OnAfterGetRecord()
            begin
                ExpectedBillAmt := 0;
                ExpectedReceiptAmt := 0;
                ExpectedBillDetails.RESET;
                ExpectedBillDetails.SETRANGE("HOD Code", "HOD Code");
                ExpectedBillDetails.SETRANGE("Manager Code", "Manager Code");
                ExpectedBillDetails.SETRANGE("Bill Date", StartDate, EndDate);
                ExpectedBillDetails.SETFILTER("Save Record", '%1', TRUE);
                IF ExpectedBillDetails.FINDFIRST THEN BEGIN
                    ExpectedBillAmt := ExpectedBillDetails."Expected Billing";
                    ExpectedReceiptAmt := ExpectedBillDetails."Expected Receipt";
                END;
            end;
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

                    trigger OnValidate()
                    begin
                        IF StartDate > TODAY THEN
                            ERROR('Please enter right date');

                        StartDate := CALCDATE('-CM', StartDate);
                        IF StartDate < CALCDATE('-CM', TODAY) THEN
                            EndDate := CALCDATE('CM', StartDate)
                        ELSE
                            EndDate := TODAY;
                    end;
                }
                field("End Date"; EndDate)
                {
                    Caption = 'End Date';
                    Editable = false;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            StartDate := CALCDATE('-CM', TODAY);
            EndDate := TODAY;
        end;
    }

    labels
    {
    }

    var
        ExpectedBillDetails: Record "Expected Bill Details";
        StartDate: Date;
        EndDate: Date;
        ExpectedBillAmt: Decimal;
        ExpectedReceiptAmt: Decimal;

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
    begin
        Project.SETRANGE("Project Manager", ManagerCode);
        IF Project.FINDSET THEN
            REPEAT
                Project2.SETRANGE("Type Of Project", Project2."Type Of Project"::"Sub Project");
                Project2.SETRANGE("Parent Project Code", Project."No.");
                IF Project2.FINDSET THEN
                    REPEAT
                        IF Project2."Global Dimension 1 Code" <> '' THEN BEGIN
                            IF CostCenter <> '' THEN
                                CostCenter += '|' + Project2."Global Dimension 1 Code"
                            ELSE
                                CostCenter := Project2."Global Dimension 1 Code";
                        END;
                    UNTIL Project2.NEXT = 0;
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

    procedure GetPMCProjectReceiptAmt(ManagerCode: Code[20]) ProjectReceiptAmt: Decimal
    var
        Project: Record Job;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        CostCenter: Text;
        Project2: Record Job;
    begin
        Project.SETRANGE("Project Manager", ManagerCode);
        IF Project.FINDSET THEN
            REPEAT
                Project2.SETRANGE("Type Of Project", Project2."Type Of Project"::"PMC Project");
                Project2.SETRANGE("Parent Project Code", Project."No.");
                IF Project2.FINDSET THEN
                    REPEAT
                        IF Project2."Global Dimension 1 Code" <> '' THEN BEGIN
                            IF CostCenter <> '' THEN
                                CostCenter += '|' + Project2."Global Dimension 1 Code"
                            ELSE
                                CostCenter := Project2."Global Dimension 1 Code";
                        END;
                    UNTIL Project2.NEXT = 0;
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

    procedure GetProjectExpensesAmt(ManagerCode: Code[20]): Decimal
    var
        Project: Record Job;
        GLEntry: Record "G/L Entry";
        CostCenter: Text;
        ProjectJVExpensesAmt: Decimal;
        PurchInvHeader: Record "Purch. Inv. Header";
        ProjectPurchExpensesAmt: Decimal;
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
            GLEntry.SETFILTER("Global Dimension 1 Code", CostCenter);
            GLEntry.SETFILTER("Source Code", 'JV');
            GLEntry.SETFILTER(Amount, '>%1', 0);
            GLEntry.SETRANGE("Posting Date", StartDate, EndDate);
            IF GLEntry.FINDFIRST THEN
                REPEAT
                    ProjectJVExpensesAmt += GLEntry.Amount;
                UNTIL GLEntry.NEXT = 0;

            PurchInvHeader.SETFILTER("Shortcut Dimension 1 Code", CostCenter);
            PurchInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
            IF PurchInvHeader.FINDFIRST THEN
                REPEAT
                    //PurchInvHeader.CALCFIELDS(PurchInvHeader."Amount to Vendor");
                    ProjectPurchExpensesAmt += PurchInvHeader.Amount;
                UNTIL PurchInvHeader.NEXT = 0;
        END;

        EXIT(ProjectJVExpensesAmt + ProjectPurchExpensesAmt);
    end;
}

