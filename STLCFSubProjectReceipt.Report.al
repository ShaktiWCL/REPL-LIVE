report 50072 "STLCF-Sub_Project_Receipt"
{
    // Actual Receipt (Parent Proj)
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/STLCFSubProjectReceipt.rdl';
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
                dataitem(Sub_Project_Receipt; "Detailed Cust. Ledg. Entry")
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
                            SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
                            IF SalesInvoiceHeader."Currency Code" <> '' THEN
                                ExchangeRate := 1 / SalesInvoiceHeader."Currency Factor"
                            ELSE
                                ExchangeRate := 1;

                            GetProject.RESET;
                            GetProject.SETRANGE("Global Dimension 1 Code", SalesInvoiceLine."Shortcut Dimension 1 Code");
                            IF GetProject.FINDFIRST THEN BEGIN
                                ProjectValue := GetProject."Project Value";
                                GetProject1.SETRANGE("Type Of Project", GetProject1."Type Of Project"::"Sub Project");
                                GetProject1.SETRANGE("Parent Project Code", GetProject."No.");
                                GetProject1.SETRANGE("Project Manager", Employee."No.");
                                IF GetProject1.FINDSET THEN BEGIN
                                    REPEAT
                                        ProjectReceiptAmt += ("Amount (LCY)" * ((GetProject1."Project Value" * 100) / ProjectValue)) / 100;
                                    UNTIL GetProject1.NEXT = 0;
                                END;
                            END;
                            REPEAT
                                InvoiceAmount += ROUND((SalesInvoiceLine.Amount * ExchangeRate), 0.01);
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;

                        IF ROUND(ProjectReceiptAmt, 1) = 0 THEN
                            CurrReport.SKIP;


                        TempCashFlowBuffer.INIT;
                        TempCashFlowBuffer."Entry No." += 1;
                        TempCashFlowBuffer."Code 1" := "Cust. Ledger Entry"."Document No.";
                        TempCashFlowBuffer."Code 2" := "Document No.";
                        TempCashFlowBuffer."Code 3" := GetProject."No.";
                        TempCashFlowBuffer."Code 4" := GetProject1."No.";
                        TempCashFlowBuffer."Decimal 1" := ABS("Cust. Ledger Entry"."Amount (LCY)");
                        TempCashFlowBuffer."Decimal 2" := "Amount (LCY)";
                        TempCashFlowBuffer."Decimal 3" := InvoiceAmount;
                        TempCashFlowBuffer."Decimal 4" := ProjectReceiptAmt;
                        TempCashFlowBuffer."Text 1" := Employee."First Name";
                        IF TempCashFlowBuffer.INSERT THEN
                            Counter += 1;
                    end;
                }
                dataitem(Sub_Project_Receipt1; "Detailed Cust. Ledg. Entry")
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

                        CustLedgerEntry.GET("Cust. Ledger Entry No.");
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                            SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
                            IF SalesInvoiceHeader."Currency Code" <> '' THEN
                                ExchangeRate := 1 / SalesInvoiceHeader."Currency Factor"
                            ELSE
                                ExchangeRate := 1;

                            GetProject.RESET;
                            GetProject.SETRANGE("Global Dimension 1 Code", SalesInvoiceLine."Shortcut Dimension 1 Code");
                            IF GetProject.FINDFIRST THEN BEGIN
                                ProjectValue := GetProject."Project Value";
                                GetProject1.SETRANGE("Type Of Project", GetProject1."Type Of Project"::"Sub Project");
                                GetProject1.SETRANGE("Parent Project Code", GetProject."No.");
                                GetProject1.SETRANGE("Project Manager", Employee."No.");
                                IF GetProject1.FINDSET THEN BEGIN
                                    REPEAT
                                        ProjectReceiptAmt += -("Amount (LCY)" * ((GetProject1."Project Value" * 100) / ProjectValue)) / 100;
                                    UNTIL GetProject1.NEXT = 0;
                                END;
                            END;
                            REPEAT
                                InvoiceAmount += ROUND((SalesInvoiceLine.Amount * ExchangeRate), 0.01);
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;


                        IF ROUND(ProjectReceiptAmt, 1) = 0 THEN
                            CurrReport.SKIP;

                        TempCashFlowBuffer.INIT;
                        TempCashFlowBuffer."Entry No." += 1;
                        TempCashFlowBuffer."Code 1" := "Cust. Ledger Entry"."Document No.";
                        TempCashFlowBuffer."Code 2" := CustLedgerEntry."Document No.";
                        TempCashFlowBuffer."Code 3" := GetProject."No.";
                        TempCashFlowBuffer."Code 4" := GetProject1."No.";
                        TempCashFlowBuffer."Decimal 1" := ABS("Cust. Ledger Entry"."Amount (LCY)");
                        TempCashFlowBuffer."Decimal 2" := -"Amount (LCY)";
                        TempCashFlowBuffer."Decimal 3" := InvoiceAmount;
                        TempCashFlowBuffer."Decimal 4" := ProjectReceiptAmt;
                        TempCashFlowBuffer."Text 1" := Employee."First Name";
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
                IF ManagerCode <> '' THEN
                    SETFILTER(Employee."No.", '%1', ManagerCode);
            end;
        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(ProjectManagerName_Cap; ProjectManagerNameCap)
            {
            }
            column(Employee_No; Employee."No.")
            {
            }
            column(Employee_FirstName; Employee."First Name")
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
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ExchangeRate: Decimal;
}

