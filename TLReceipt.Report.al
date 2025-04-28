report 50082 "TL-Receipt"
{
    // Actual Receipt (Parent Proj)
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TLReceipt.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Project Manager" = FILTER(true));
            column(GetCompanyInfo_Name; CompanyNameText)
            {
            }
            column(GetCompanyInfo_Picture; GetCompanyInfo.Picture)
            {
            }
            column(GetCompanyInfo_Address; GetCompanyInfo.Address)
            {
            }
            column(GetCompanyInfo_Address2; GetCompanyInfo."Address 2")
            {
            }
            column(Start_Date; FORMAT(StartDate))
            {
            }
            column(End_Date; FORMAT(EndDate))
            {
            }
            column(SNo_Cap; SNoCap)
            {
            }
            column(EmpCode_Cap; EmpCodeCap)
            {
            }
            column(EmpName_Cap; EmpNameCap)
            {
            }
            column(TypeOfProject_Cap; TypeOfProjectCap)
            {
            }
            column(ProjectCode_Cap; ProjectCodeCap)
            {
            }
            column(ProjectName_Cap; ProjectNameCap)
            {
            }
            column(RcptNo_Cap; RcptNoCap)
            {
            }
            column(RcptDate_Cap; RcptDateCap)
            {
            }
            column(RcptAmount_Cap; RcptAmountCap)
            {
            }
            column(SPRcpt_Cap; SPRcptCap)
            {
            }
            column(PMCRcpt_Cap; PMCRcptCap)
            {
            }
            column(SPExp_Cap; SPExpCap)
            {
            }
            column(PMCExp_Cap; PMCExpCap)
            {
            }
            column(NetRcpt_Cap; NetRcptCap)
            {
            }
            column(Total_Cap; TotalCap)
            {
            }
            column(TLDetail_Cap; TLDetailCap)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Amount (LCY)";
                DataItemTableView = SORTING("Entry No.")
                                    WHERE("Source Code" = FILTER('BANKRCPTV'));
                dataitem(DetailedCustLedgEntry_1; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Posting Date")
                                        WHERE("Entry Type" = FILTER(Application),
                                              "Document Type" = FILTER(Invoice));

                    trigger OnAfterGetRecord()
                    begin
                        CLEAR(ProjectReceiptAmt);
                        CLEAR(ProjectInfo);
                        ProjectValue := 0;

                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                        IF SalesInvoiceLine.FINDSET THEN BEGIN

                            //AD_RCPT
                            GetProject.RESET;
                            GetProject.SETRANGE(GetProject."Global Dimension 1 Code", SalesInvoiceLine."Shortcut Dimension 1 Code");
                            GetProject.SETRANGE("Project Manager", Employee."No.");
                            IF GetProject.FINDFIRST THEN BEGIN
                                ProjectReceiptAmt[1] := "Amount (LCY)";
                                IF ProjectInfo[1] = '' THEN BEGIN
                                    ProjectInfo[1] := GetProject."No.";
                                    ProjectInfo[2] := GetProject.Description;
                                    ProjectType := GetProject."Type Of Project";
                                END;
                            END;
                            //AD_RCPT

                            //AD_SP_Rcpt
                            GetProject.RESET;
                            GetProject.SETRANGE("Global Dimension 1 Code", SalesInvoiceLine."Shortcut Dimension 1 Code");
                            IF GetProject.FINDFIRST THEN BEGIN
                                ProjectValue := GetProject."Project Value";
                                GetProject1.SETRANGE("Type Of Project", GetProject1."Type Of Project"::"Sub Project");
                                GetProject1.SETRANGE("Parent Project Code", GetProject."No.");
                                GetProject1.SETRANGE("Project Manager", Employee."No.");
                                IF GetProject1.FINDSET THEN BEGIN
                                    REPEAT
                                        ProjectReceiptAmt[2] += ("Amount (LCY)" * ((GetProject1."Project Value" * 100) / ProjectValue)) / 100;
                                    UNTIL GetProject1.NEXT = 0;
                                    IF ProjectInfo[1] = '' THEN BEGIN
                                        ProjectInfo[1] := GetProject1."No.";
                                        ProjectInfo[2] := GetProject1.Description;
                                        ProjectType := GetProject1."Type Of Project";
                                    END;
                                END;
                            END;
                            //AD_SP_Rcpt

                            //AD_SP_Exp
                            GetProject.RESET;
                            GetProject.SETRANGE("Global Dimension 1 Code", SalesInvoiceLine."Shortcut Dimension 1 Code");
                            GetProject.SETRANGE("Project Manager", Employee."No.");
                            IF GetProject.FINDFIRST THEN BEGIN
                                GetProject1.RESET;
                                GetProject1.SETRANGE("Type Of Project", GetProject1."Type Of Project"::"Sub Project");
                                GetProject1.SETRANGE("Parent Project Code", GetProject."No.");
                                IF GetProject1.FINDSET THEN BEGIN
                                    REPEAT
                                        ProjectValue := ((GetProject1."Project Value" * 100) / GetProject."Project Value");
                                        ProjectReceiptAmt[4] += ("Amount (LCY)" * ProjectValue / 100);
                                    UNTIL GetProject1.NEXT = 0;
                                    IF ProjectInfo[1] = '' THEN BEGIN
                                        ProjectInfo[1] := GetProject1."No.";
                                        ProjectInfo[2] := GetProject1.Description;
                                        ProjectType := GetProject1."Type Of Project";
                                    END;
                                END;
                            END;
                            //AD_SP_Exp

                            REPEAT
                                //AD_PMC
                                GetProjectTask.RESET;
                                GetProjectTask.SETRANGE("Job No.", SalesInvoiceLine."Job No.");
                                GetProjectTask.SETRANGE(Milestone, SalesInvoiceLine.Milestone);
                                IF GetProjectTask.FINDFIRST THEN BEGIN
                                    GetProject1.RESET;
                                    GetProject1.SETRANGE("Type Of Project", GetProject1."Type Of Project"::"PMC Project");
                                    GetProject1.SETRANGE("Parent Project Code", GetProjectTask."JOb No.");
                                    GetProject1.SETRANGE("Project Manager", Employee."No.");
                                    IF GetProject1.FINDSET THEN BEGIN
                                        REPEAT
                                            GetProjectTask1.RESET;
                                            GetProjectTask1.SETRANGE("Job No.", GetProject1."No.");
                                            GetProjectTask1.SETRANGE("Planned Bill Date", CALCDATE('-CM', GetProjectTask."Planned Bill Date"), CALCDATE('CM', GetProjectTask."Planned Bill Date"));
                                            IF GetProjectTask1.FINDFIRST THEN BEGIN
                                                ProjectValue := ((GetProjectTask1.Amount * 100) / GetProjectTask.Amount);
                                                ProjectReceiptAmt[3] += ("Amount (LCY)" * ProjectValue / 100);
                                            END;
                                        UNTIL GetProject1.NEXT = 0;
                                        IF ProjectInfo[1] = '' THEN BEGIN
                                            ProjectInfo[1] := GetProject1."No.";
                                            ProjectInfo[2] := GetProject1.Description;
                                            ProjectType := GetProject1."Type Of Project";
                                        END;
                                    END;
                                END;
                            //AD_PMC
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;

                        ProjectReceiptAmt[5] := 0; //Discuss logic for this col. pending

                        NetReceipt := (ProjectReceiptAmt[1] + ProjectReceiptAmt[2] + ProjectReceiptAmt[3]) - (ProjectReceiptAmt[4] - ProjectReceiptAmt[5]);

                        IF (ProjectReceiptAmt[1] = 0) AND (ProjectReceiptAmt[2] = 0) AND (ProjectReceiptAmt[3] = 0) AND (ProjectReceiptAmt[4] = 0) THEN
                            CurrReport.SKIP;

                        SNo += 1;

                        TempCashFlowBuffer.INIT;
                        TempCashFlowBuffer."Entry No." += 1;
                        TempCashFlowBuffer."Code 1" := "Cust. Ledger Entry"."Document No.";
                        TempCashFlowBuffer."Code 2" := ProjectInfo[1];
                        TempCashFlowBuffer."Code 3" := Employee."No.";
                        TempCashFlowBuffer."Decimal 1" := ABS("Cust. Ledger Entry"."Amount (LCY)");
                        TempCashFlowBuffer."Decimal 2" := ProjectReceiptAmt[1];
                        TempCashFlowBuffer."Decimal 3" := ProjectReceiptAmt[2];
                        TempCashFlowBuffer."Decimal 4" := ProjectReceiptAmt[3];
                        TempCashFlowBuffer."Decimal 5" := ProjectReceiptAmt[4];
                        TempCashFlowBuffer."Decimal 6" := ProjectReceiptAmt[5];
                        TempCashFlowBuffer."Decimal 7" := NetReceipt;
                        TempCashFlowBuffer."Text 1" := ProjectInfo[2];
                        TempCashFlowBuffer."Text 2" := FORMAT(ProjectType);
                        TempCashFlowBuffer."Text 3" := Employee."First Name";
                        TempCashFlowBuffer."Date 1" := "Cust. Ledger Entry"."Posting Date";
                        TempCashFlowBuffer."Integer 1" := SNo;
                        IF TempCashFlowBuffer.INSERT THEN
                            Counter += 1;
                    end;
                }
                dataitem(DetailedCustLedgEntry_2; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Posting Date")
                                        WHERE("Entry Type" = FILTER(Application),
                                              "Initial Document Type" = FILTER(Invoice));

                    trigger OnAfterGetRecord()
                    begin
                        CLEAR(ProjectReceiptAmt);
                        CLEAR(ProjectInfo);
                        ProjectValue := 0;

                        CustLedgerEntry.GET("Cust. Ledger Entry No.");
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                        IF SalesInvoiceLine.FINDSET THEN BEGIN

                            //AD_RCPT
                            GetProject.RESET;
                            GetProject.SETRANGE(GetProject."Global Dimension 1 Code", SalesInvoiceLine."Shortcut Dimension 1 Code");
                            GetProject.SETRANGE("Project Manager", Employee."No.");
                            IF GetProject.FINDFIRST THEN BEGIN
                                ProjectReceiptAmt[1] := -("Amount (LCY)");
                                IF ProjectInfo[1] = '' THEN BEGIN
                                    ProjectInfo[1] := GetProject."No.";
                                    ProjectInfo[2] := GetProject.Description;
                                    ProjectType := GetProject."Type Of Project";
                                END;
                            END;
                            //AD_RCPT

                            //AD_SP_Rcpt
                            GetProject.RESET;
                            GetProject.SETRANGE("Global Dimension 1 Code", SalesInvoiceLine."Shortcut Dimension 1 Code");
                            IF GetProject.FINDFIRST THEN BEGIN
                                ProjectValue := GetProject."Project Value";
                                GetProject1.SETRANGE("Type Of Project", GetProject1."Type Of Project"::"Sub Project");
                                GetProject1.SETRANGE("Parent Project Code", GetProject."No.");
                                GetProject1.SETRANGE("Project Manager", Employee."No.");
                                IF GetProject1.FINDSET THEN BEGIN
                                    REPEAT
                                        ProjectReceiptAmt[2] += -("Amount (LCY)" * ((GetProject1."Project Value" * 100) / ProjectValue)) / 100;
                                    UNTIL GetProject1.NEXT = 0;
                                    IF ProjectInfo[1] = '' THEN BEGIN
                                        ProjectInfo[1] := GetProject1."No.";
                                        ProjectInfo[2] := GetProject1.Description;
                                        ProjectType := GetProject1."Type Of Project";
                                    END;
                                END;
                            END;
                            //AD_SP_Rcpt

                            //AD_SP_Exp
                            GetProject.RESET;
                            GetProject.SETRANGE("Global Dimension 1 Code", SalesInvoiceLine."Shortcut Dimension 1 Code");
                            GetProject.SETRANGE("Project Manager", Employee."No.");
                            IF GetProject.FINDFIRST THEN BEGIN
                                GetProject1.RESET;
                                GetProject1.SETRANGE("Type Of Project", GetProject1."Type Of Project"::"Sub Project");
                                GetProject1.SETRANGE("Parent Project Code", GetProject."No.");
                                IF GetProject1.FINDSET THEN BEGIN
                                    REPEAT
                                        ProjectValue := ((GetProject1."Project Value" * 100) / GetProject."Project Value");
                                        ProjectReceiptAmt[4] += -("Amount (LCY)" * ProjectValue / 100);
                                    UNTIL GetProject1.NEXT = 0;
                                    IF ProjectInfo[1] = '' THEN BEGIN
                                        ProjectInfo[1] := GetProject1."No.";
                                        ProjectInfo[2] := GetProject1.Description;
                                        ProjectType := GetProject1."Type Of Project";
                                    END;
                                END;
                            END;
                            //AD_SP_Exp

                            REPEAT
                                //AD_PMC
                                GetProjectTask.RESET;
                                GetProjectTask.SETRANGE("Job No.", SalesInvoiceLine."Job No.");
                                GetProjectTask.SETRANGE(Milestone, SalesInvoiceLine.Milestone);
                                IF GetProjectTask.FINDFIRST THEN BEGIN
                                    GetProject1.RESET;
                                    GetProject1.SETRANGE("Type Of Project", GetProject1."Type Of Project"::"PMC Project");
                                    GetProject1.SETRANGE("Parent Project Code", GetProjectTask."JOb No.");
                                    GetProject1.SETRANGE("Project Manager", Employee."No.");
                                    IF GetProject1.FINDSET THEN BEGIN
                                        REPEAT
                                            GetProjectTask1.RESET;
                                            GetProjectTask1.SETRANGE("Job No.", GetProject1."No.");
                                            GetProjectTask1.SETRANGE("Planned Bill Date", CALCDATE('-CM', GetProjectTask."Planned Bill Date"), CALCDATE('CM', GetProjectTask."Planned Bill Date"));
                                            IF GetProjectTask1.FINDFIRST THEN BEGIN
                                                ProjectValue := ((GetProjectTask1.Amount * 100) / GetProjectTask.Amount);
                                                ProjectReceiptAmt[3] += -("Amount (LCY)" * ProjectValue / 100);
                                            END;
                                        UNTIL GetProject1.NEXT = 0;
                                        IF ProjectInfo[1] = '' THEN BEGIN
                                            ProjectInfo[1] := GetProject1."No.";
                                            ProjectInfo[2] := GetProject1.Description;
                                            ProjectType := GetProject1."Type Of Project";
                                        END;
                                    END;
                                END;
                            //AD_PMC
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;

                        ProjectReceiptAmt[5] := 0; //Discuss logic for this col. pending

                        NetReceipt := (ProjectReceiptAmt[1] + ProjectReceiptAmt[2] + ProjectReceiptAmt[3]) - (ProjectReceiptAmt[4] - ProjectReceiptAmt[5]);

                        IF (ProjectReceiptAmt[1] = 0) AND (ProjectReceiptAmt[2] = 0) AND (ProjectReceiptAmt[3] = 0) AND (ProjectReceiptAmt[4] = 0) THEN
                            CurrReport.SKIP;

                        SNo += 1;

                        TempCashFlowBuffer.INIT;
                        TempCashFlowBuffer."Entry No." += 1;
                        TempCashFlowBuffer."Code 1" := "Cust. Ledger Entry"."Document No.";
                        TempCashFlowBuffer."Code 2" := ProjectInfo[1];
                        TempCashFlowBuffer."Code 3" := Employee."No.";
                        TempCashFlowBuffer."Decimal 1" := ABS("Cust. Ledger Entry"."Amount (LCY)");
                        TempCashFlowBuffer."Decimal 2" := ProjectReceiptAmt[1];
                        TempCashFlowBuffer."Decimal 3" := ProjectReceiptAmt[2];
                        TempCashFlowBuffer."Decimal 4" := ProjectReceiptAmt[3];
                        TempCashFlowBuffer."Decimal 5" := ProjectReceiptAmt[4];
                        TempCashFlowBuffer."Decimal 6" := ProjectReceiptAmt[5];
                        TempCashFlowBuffer."Decimal 7" := NetReceipt;
                        TempCashFlowBuffer."Text 1" := ProjectInfo[2];
                        TempCashFlowBuffer."Text 2" := FORMAT(ProjectType);
                        TempCashFlowBuffer."Text 3" := Employee."First Name";
                        TempCashFlowBuffer."Date 1" := "Cust. Ledger Entry"."Posting Date";
                        TempCashFlowBuffer."Integer 1" := SNo;
                        IF TempCashFlowBuffer.INSERT THEN
                            Counter += 1;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    IF (StartDate = 0D) OR (EndDate = 0D) THEN
                        ERROR('Date must not be blank');

                    SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                end;
            }

            trigger OnPreDataItem()
            begin
                GetEmployee.GET(USERID);
                IF GetEmployee."TL Report" THEN BEGIN
                    IF ManagerCode <> '' THEN
                        SETFILTER(Employee."No.", '%1', ManagerCode);
                END;

                IF ManagerCode = '' THEN BEGIN
                    IF (GetEmployee."Project Manager") AND (GetEmployee."TL Report" = FALSE) THEN BEGIN
                        ManagerCode := GetEmployee."No.";
                        SETFILTER(Employee."No.", '%1', ManagerCode);
                    END;
                END;
            end;
        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(Employee_Code; TempCashFlowBuffer."Code 3")
            {
            }
            column(Employee_Name; TempCashFlowBuffer."Text 3")
            {
            }
            column(Bank_Receipt_No; TempCashFlowBuffer."Code 1")
            {
            }
            column(BankRcpt_Amount; TempCashFlowBuffer."Decimal 1")
            {
            }
            column(Rcpt_Date; FORMAT(TempCashFlowBuffer."Date 1"))
            {
            }
            column(S_No; TempCashFlowBuffer."Integer 1")
            {
            }
            column(Project_No; TempCashFlowBuffer."Code 2")
            {
            }
            column(Project_Name; TempCashFlowBuffer."Text 1")
            {
            }
            column(Type_Project; TempCashFlowBuffer."Text 2")
            {
            }
            column(ProjectReceipt_Amt1; TempCashFlowBuffer."Decimal 2")
            {
            }
            column(ProjectReceipt_Amt2; TempCashFlowBuffer."Decimal 3")
            {
            }
            column(ProjectReceipt_Amt3; TempCashFlowBuffer."Decimal 4")
            {
            }
            column(ProjectReceipt_Amt4; TempCashFlowBuffer."Decimal 5")
            {
            }
            column(ProjectReceipt_Amt5; TempCashFlowBuffer."Decimal 6")
            {
            }
            column(Net_Receipt; TempCashFlowBuffer."Decimal 7")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number <> 1 THEN BEGIN
                    TempCashFlowBuffer.NEXT;
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Number, 1, Counter);
                IF TempCashFlowBuffer.FINDFIRST THEN;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Project Manager Code"; ManagerCode)
                {
                    TableRelation = Employee."No." WHERE("Project Manager for Cash Flow" = CONST(true));

                    trigger OnValidate()
                    begin
                        GetEmployee.GET(USERID);
                        IF NOT GetEmployee."TL Report" THEN
                            ERROR('You are not authorized for using this filter');
                    end;
                }
                field("Start Date"; StartDate)
                {

                    trigger OnValidate()
                    begin
                        IF EndDate <> 0D THEN
                            IF StartDate > EndDate THEN
                                ERROR(Text13703);
                    end;
                }
                field("End Date"; EndDate)
                {

                    trigger OnValidate()
                    begin
                        IF StartDate <> 0D THEN
                            IF StartDate > EndDate THEN
                                ERROR(Text13700);
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        GetCompanyInfo.GET;
        GetCompanyInfo.CALCFIELDS(Picture);
        TempCashFlowBuffer.DELETEALL;

        GetCompanyInfo.GET;
        GetCompanyInfo.CALCFIELDS(Picture);
        IF GetCompanyInfo."New Name Date" <> 0D THEN BEGIN
            IF EndDate >= GetCompanyInfo."New Name Date" THEN
                CompanyNameText := GetCompanyInfo.Name
            ELSE
                CompanyNameText := GetCompanyInfo."Old Name";
        END ELSE
            CompanyNameText := GetCompanyInfo.Name;
    end;

    var
        StartDate: Date;
        EndDate: Date;
        ManagerCode: Code[20];
        SalesInvoiceLine: Record "Sales Invoice Line";
        GetProject: Record Job;
        GetProject1: Record Job;
        ProjectReceiptAmt: array[20] of Decimal;
        InvoiceAmount: Decimal;
        DateFilterCap: Label 'Date Filter';
        ProjectValue: Decimal;
        GetCompanyInfo: Record "Company Information";
        SNo: Integer;
        SNoCap: Label 'S. No.';
        EmpCodeCap: Label 'Employee Code';
        EmpNameCap: Label 'Employee Name';
        TypeOfProjectCap: Label 'Type of Project';
        ProjectCodeCap: Label 'Project Code';
        ProjectNameCap: Label 'Project Name';
        RcptNoCap: Label 'Rcpt. No.';
        RcptDateCap: Label 'Rcpt. Date';
        RcptAmountCap: Label 'Rcpt. Amount';
        SPRcptCap: Label 'SP Rcpt.';
        PMCRcptCap: Label 'PMC Rcpt.';
        SPExpCap: Label 'SP Expense';
        PMCExpCap: Label 'PMC Expense';
        NetRcptCap: Label 'Net Rcpt.';
        TotalCap: Label 'Total';
        TLDetailCap: Label 'TL Receipt Summary';
        Text13700: Label 'End Date cannot be before Start Date.';
        Text13703: Label 'Start Date cannot be after End Date.';
        ProjectInfo: array[10] of Text[250];
        ProjectType: Option " ","Main Project","Sub Project","PMC Project","BD Project";
        GetProjectTask: Record "Job Task";
        GetProjectTask1: Record "Job Task";
        NetReceipt: Decimal;
        GetEmployee: Record Employee;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TempCashFlowBuffer: Record "Cash Flow Buffer" temporary;
        Counter: Integer;
        CompanyNameText: Text;
}

