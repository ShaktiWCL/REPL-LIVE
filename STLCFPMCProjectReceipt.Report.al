report 50073 "STLCF-PMC_Project_Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/STLCFPMCProjectReceipt.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Project Manager" = FILTER(true));
            column(DateFilterCap; DateFilterCap)
            {
            }
            column(CashFlowDetail_Cap; CashFlowDetailCap)
            {
            }
            column(BankRcptNo_Cap; BankRcptNoCap)
            {
            }
            column(BankRcptAmt_Cap; BankRcptAmtCap)
            {
            }
            column(InvAmt_Cap; InvAmtCap)
            {
            }
            column(AdjustedAmt_Cap; AdjustedAmtCap)
            {
            }
            column(InvNo_Cap; InvNoCap)
            {
            }
            column(Total_Cap; TotalCap)
            {
            }
            column(ParentProject_Cap; ParentProjectCap)
            {
            }
            column(SubProject_Cap; SubProjectCap)
            {
            }
            column(ParentAdjustedAmt_Cap; ParentAdjustedAmtCap)
            {
            }
            column(Start_Date; FORMAT(StartDate))
            {
            }
            column(End_Date; FORMAT(EndDate))
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Amount (LCY)";
                DataItemTableView = SORTING("Entry No.")
                                    WHERE("Source Code" = FILTER('BANKRCPTV'));
                dataitem(PMC_Project_Receipt; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Posting Date")
                                        WHERE("Entry Type" = FILTER(Application),
                                              "Document Type" = FILTER(Invoice));

                    trigger OnAfterGetRecord()
                    begin
                        ProjectValue := 0;
                        ProjectReceiptAmt := 0;
                        InvoiceAmount := 0;
                        ExchangeRate := 0;
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                            IF SalesInvHeader.GET("Document No.") THEN BEGIN
                                IF SalesInvHeader."Currency Code" <> '' THEN
                                    ExchangeRate := 1 / SalesInvHeader."Currency Factor"
                                ELSE
                                    ExchangeRate := 1;
                                SalesInvHeader.CALCFIELDS(Amount);
                                InvoiceAmount := ROUND((SalesInvHeader.Amount * ExchangeRate), 0.01);
                            END;
                            REPEAT
                                GetProjectTask.RESET;
                                GetProjectTask.SETRANGE("Job No.", SalesInvoiceLine."Job No.");
                                GetProjectTask.SETRANGE(Milestone, SalesInvoiceLine.Milestone);
                                IF GetProjectTask.FINDFIRST THEN BEGIN
                                    GetProject1.RESET;
                                    GetProject1.SETRANGE("Type Of Project", GetProject1."Type Of Project"::"PMC Project");
                                    GetProject1.SETRANGE("Parent Project Code", GetProjectTask."Job No.");
                                    GetProject1.SETRANGE("Project Manager", Employee."No.");
                                    IF GetProject1.FINDSET THEN BEGIN
                                        REPEAT
                                            GetProjectTask1.RESET;
                                            GetProjectTask1.SETRANGE("Job No.", GetProject1."No.");
                                            GetProjectTask1.SETRANGE("Planned Bill Date", CALCDATE('-CM', GetProjectTask."Planned Bill Date"), CALCDATE('CM', GetProjectTask."Planned Bill Date"));
                                            IF GetProjectTask1.FINDFIRST THEN BEGIN
                                                ProjectValue := ((GetProjectTask1.Amount * 100) / GetProjectTask.Amount);

                                                IF GetProjectTask1."Project Manager" = Employee."No." THEN
                                                    ProjectReceiptAmt := ("Amount (LCY)" * ProjectValue / 100);
                                                TempCashFlowBuffer.INIT;
                                                TempCashFlowBuffer."Entry No." += 1;
                                                TempCashFlowBuffer."Code 1" := "Cust. Ledger Entry"."Document No.";
                                                TempCashFlowBuffer."Code 2" := "Document No.";
                                                TempCashFlowBuffer."Code 3" := GetProject1."Parent Project Code";
                                                TempCashFlowBuffer."Code 4" := GetProjectTask1."Job No.";
                                                TempCashFlowBuffer."Decimal 1" := ABS("Cust. Ledger Entry"."Amount (LCY)");
                                                TempCashFlowBuffer."Decimal 2" := "Amount (LCY)";
                                                TempCashFlowBuffer."Decimal 3" := InvoiceAmount;
                                                TempCashFlowBuffer."Decimal 4" := ProjectReceiptAmt;
                                                TempCashFlowBuffer."Text 1" := Employee."First Name";
                                                TempCashFlowBuffer."Decimal 3" := InvoiceAmount;
                                                IF TempCashFlowBuffer.INSERT THEN
                                                    Counter += 1;

                                            END;
                                        UNTIL GetProject1.NEXT = 0;
                                    END;
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;

                        IF ProjectReceiptAmt = 0 THEN
                            CurrReport.SKIP;
                    end;
                }
                dataitem(PMC_Project_Receipt1; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Posting Date")
                                        WHERE("Entry Type" = FILTER(Application),
                                              "Initial Document Type" = FILTER(Invoice));

                    trigger OnAfterGetRecord()
                    begin
                        ProjectValue := 0;
                        ProjectReceiptAmt := 0;
                        InvoiceAmount := 0;
                        ExchangeRate := 0;

                        CustLedgerEntry.GET("Cust. Ledger Entry No.");
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                            IF SalesInvHeader.GET("Document No.") THEN BEGIN
                                IF SalesInvHeader."Currency Code" <> '' THEN
                                    ExchangeRate := 1 / SalesInvHeader."Currency Factor"
                                ELSE
                                    ExchangeRate := 1;
                                SalesInvHeader.CALCFIELDS(Amount);
                                InvoiceAmount := ROUND((SalesInvHeader.Amount * ExchangeRate), 0.01);
                            END;
                            REPEAT
                                GetProjectTask.RESET;
                                GetProjectTask.SETRANGE("Job No.", SalesInvoiceLine."Job No.");
                                GetProjectTask.SETRANGE(Milestone, SalesInvoiceLine.Milestone);
                                IF GetProjectTask.FINDFIRST THEN BEGIN
                                    GetProject1.RESET;
                                    GetProject1.SETRANGE("Type Of Project", GetProject1."Type Of Project"::"PMC Project");
                                    GetProject1.SETRANGE("Parent Project Code", GetProjectTask."Job No.");
                                    GetProject1.SETRANGE("Project Manager", Employee."No.");
                                    IF GetProject1.FINDSET THEN BEGIN
                                        REPEAT
                                            GetProjectTask1.RESET;
                                            GetProjectTask1.SETRANGE("Job No.", GetProject1."No.");
                                            GetProjectTask1.SETRANGE("Planned Bill Date", CALCDATE('-CM', GetProjectTask."Planned Bill Date"), CALCDATE('CM', GetProjectTask."Planned Bill Date"));
                                            IF GetProjectTask1.FINDFIRST THEN BEGIN

                                                ProjectValue := ((GetProjectTask1.Amount * 100) / GetProjectTask.Amount);

                                                IF GetProjectTask1."Project Manager" = Employee."No." THEN
                                                    ProjectReceiptAmt := -("Amount (LCY)" * ProjectValue / 100);

                                                TempCashFlowBuffer.INIT;
                                                TempCashFlowBuffer."Entry No." += 1;
                                                TempCashFlowBuffer."Code 1" := "Cust. Ledger Entry"."Document No.";
                                                TempCashFlowBuffer."Code 2" := CustLedgerEntry."Document No.";
                                                TempCashFlowBuffer."Code 3" := GetProject1."Parent Project Code";
                                                TempCashFlowBuffer."Code 4" := GetProjectTask1."Job No.";
                                                TempCashFlowBuffer."Decimal 1" := ABS("Cust. Ledger Entry"."Amount (LCY)");
                                                TempCashFlowBuffer."Decimal 2" := -("Amount (LCY)");
                                                TempCashFlowBuffer."Decimal 4" := ProjectReceiptAmt;
                                                TempCashFlowBuffer."Text 1" := Employee."First Name";
                                                IF TempCashFlowBuffer.INSERT THEN
                                                    Counter += 1;
                                            END;
                                        UNTIL GetProject1.NEXT = 0;
                                    END;
                                END;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;

                        IF ProjectReceiptAmt = 0 THEN
                            CurrReport.SKIP;
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
                IF ManagerCode <> '' THEN
                    SETFILTER(Employee."No.", '%1', ManagerCode);
            end;
        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(Employee_No; Employee."No.")
            {
            }
            column(Employee_FirstName; TempCashFlowBuffer."Text 1")
            {
            }
            column(ProjectManagerName_Cap; ProjectManagerNameCap)
            {
            }
            column(Bank_Receipt_No; TempCashFlowBuffer."Code 1")
            {
            }
            column(BankRcpt_Amount; TempCashFlowBuffer."Decimal 1")
            {
            }
            column(Parent_Project_No; TempCashFlowBuffer."Code 3")
            {
            }
            column(Sub_Project_No; TempCashFlowBuffer."Code 4")
            {
            }
            column(Invoice_No_1; TempCashFlowBuffer."Code 2")
            {
            }
            column(Adjusted_Amount_1; TempCashFlowBuffer."Decimal 2")
            {
            }
            column(Invoice_Amount_1; TempCashFlowBuffer."Decimal 3")
            {
            }
            column(ProjectReceipt_Amt_1; TempCashFlowBuffer."Decimal 4")
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
                }
                field("Start Date"; StartDate)
                {
                }
                field("End Date"; EndDate)
                {
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
        TempCashFlowBuffer.DELETEALL;
    end;

    var
        StartDate: Date;
        EndDate: Date;
        CashFlowDetailCap: Label 'Cash Flow Detail';
        ProjectManagerNameCap: Label 'Project Manager';
        BankRcptNoCap: Label 'Bank Receipt No.';
        BankRcptAmtCap: Label 'Bank Receipt Amount';
        InvNoCap: Label 'Invoice No.';
        InvAmtCap: Label 'Invoice Amount';
        AdjustedAmtCap: Label 'Adjusted Amount';
        ManagerCode: Code[20];
        SalesInvoiceLine: Record "Sales Invoice Line";
        GetProject: Record Job;
        GetProject1: Record Job;
        GetProjectTask: Record "Job Task";
        GetProjectTask1: Record "Job Task";
        ProjectReceiptAmt: Decimal;
        InvoiceAmount: Decimal;
        DateFilterCap: Label 'Date Filter';
        TotalCap: Label 'Total';
        ProjectValue: Decimal;
        ParentProjectCap: Label 'Parent Project';
        SubProjectCap: Label 'Sub Project';
        ParentAdjustedAmtCap: Label 'Parent Adjusted Amount';
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TempCashFlowBuffer: Record "Cash Flow Buffer" temporary;
        Counter: Integer;
        SalesInvHeader: Record "Sales Invoice Header";
        ExchangeRate: Decimal;
}

