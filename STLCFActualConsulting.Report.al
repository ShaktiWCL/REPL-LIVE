report 50075 "STLCF-Actual_Consulting"
{
    // Actual Receipt (Parent Proj)
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/STLCFActualConsulting.rdl';
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
            column(Start_Date; FORMAT(StartDate))
            {
            }
            column(End_Date; FORMAT(EndDate))
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemTableView = WHERE("Source Code" = FILTER('BANKPYMTV'));
                dataitem(Actual_Consulting; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Entry No.")
                                        WHERE("Entry Type" = FILTER(Application),
                                              "Document Type" = FILTER(Invoice));

                    trigger OnAfterGetRecord()
                    begin
                        ProjectReceiptAmt := 0;
                        InvoiceAmount := 0;
                        ExchangeRate := 0;

                        PurchInvLine.RESET;
                        PurchInvLine.SETRANGE("Document No.", "Document No.");
                        IF PurchInvLine.FINDFIRST THEN BEGIN
                            PurchInvHeader.GET(PurchInvLine."Document No.");
                            IF PurchInvHeader."Currency Code" <> '' THEN
                                ExchangeRate := 1 / PurchInvHeader."Currency Factor"
                            ELSE
                                ExchangeRate := 1;

                            REPEAT
                                GetProject.RESET;
                                GetProject.SETRANGE(GetProject."Global Dimension 1 Code", PurchInvLine."Shortcut Dimension 1 Code");
                                GetProject.SETRANGE("Project Manager", Employee."No.");
                                IF GetProject.FINDFIRST THEN
                                    ProjectReceiptAmt += -("Amount (LCY)");

                                InvoiceAmount += ROUND((PurchInvLine.Amount * ExchangeRate), 0.01);
                            UNTIL PurchInvLine.NEXT = 0;
                        END;

                        IF ProjectReceiptAmt = 0 THEN
                            CurrReport.SKIP;

                        TempCashFlowBuffer.INIT;
                        TempCashFlowBuffer."Entry No." += 1;
                        TempCashFlowBuffer."Code 1" := "Vendor Ledger Entry"."Document No.";
                        TempCashFlowBuffer."Code 2" := "Document No.";
                        TempCashFlowBuffer."Code 3" := GetProject."No.";
                        TempCashFlowBuffer."Decimal 1" := ABS("Vendor Ledger Entry"."Amount (LCY)");
                        TempCashFlowBuffer."Decimal 2" := -("Amount (LCY)");
                        TempCashFlowBuffer."Decimal 3" := InvoiceAmount;
                        TempCashFlowBuffer."Decimal 4" := ProjectReceiptAmt;
                        TempCashFlowBuffer."Text 1" := Employee."First Name";
                        IF TempCashFlowBuffer.INSERT THEN
                            Counter += 1;
                    end;
                }
                dataitem(Actual_Consulting1; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Entry No.")
                                        WHERE("Entry Type" = FILTER(Application),
                                              "Initial Document Type" = FILTER(Invoice));

                    trigger OnAfterGetRecord()
                    begin
                        ProjectReceiptAmt := 0;
                        InvoiceAmount := 0;
                        ExchangeRate := 0;

                        VendorLedgerEntry.GET("Vendor Ledger Entry No.");
                        VendorLedgerEntry.CALCFIELDS("Amount (LCY)");
                        PurchInvLine.RESET;
                        PurchInvLine.SETRANGE("Document No.", VendorLedgerEntry."Document No.");
                        IF PurchInvLine.FINDFIRST THEN BEGIN
                            PurchInvHeader.GET(PurchInvLine."Document No.");
                            IF PurchInvHeader."Currency Code" <> '' THEN
                                ExchangeRate := 1 / PurchInvHeader."Currency Factor"
                            ELSE
                                ExchangeRate := 1;
                            REPEAT
                                GetProject.RESET;
                                GetProject.SETRANGE(GetProject."Global Dimension 1 Code", PurchInvLine."Shortcut Dimension 1 Code");
                                GetProject.SETRANGE("Project Manager", Employee."No.");
                                IF GetProject.FINDFIRST THEN
                                    ProjectReceiptAmt += "Amount (LCY)";

                                InvoiceAmount += ROUND((PurchInvLine.Amount * ExchangeRate), 0.01);
                            UNTIL PurchInvLine.NEXT = 0;
                        END;

                        IF ProjectReceiptAmt = 0 THEN
                            CurrReport.SKIP;

                        TempCashFlowBuffer.INIT;
                        TempCashFlowBuffer."Entry No." += 1;
                        TempCashFlowBuffer."Code 1" := "Vendor Ledger Entry"."Document No.";
                        TempCashFlowBuffer."Code 2" := VendorLedgerEntry."Document No.";
                        TempCashFlowBuffer."Code 3" := GetProject."No.";
                        TempCashFlowBuffer."Decimal 1" := ABS("Vendor Ledger Entry"."Amount (LCY)");
                        TempCashFlowBuffer."Decimal 2" := "Amount (LCY)";
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
            column(Employee_FirstName; TempCashFlowBuffer."Text 1")
            {
            }
            column(Bank_Receipt_No; TempCashFlowBuffer."Code 1")
            {
            }
            column(BankRcpt_Amount; TempCashFlowBuffer."Decimal 1")
            {
            }
            column(Invoice_No; TempCashFlowBuffer."Code 2")
            {
            }
            column(Adjusted_Amount; TempCashFlowBuffer."Decimal 2")
            {
            }
            column(Invoice_Amount; TempCashFlowBuffer."Decimal 3")
            {
            }
            column(ProjectReceipt_Amt; TempCashFlowBuffer."Decimal 4")
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
        PurchInvLine: Record "Purch. Inv. Line";
        GetProject: Record Job;
        GetProject1: Record Job;
        ProjectReceiptAmt: Decimal;
        InvoiceAmount: Decimal;
        DateFilterCap: Label 'Date Filter';
        TotalCap: Label 'Total';
        ProjectValue: Decimal;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        TempCashFlowBuffer: Record "Cash Flow Buffer" temporary;
        Counter: Integer;
        PurchInvHeader: Record "Purch. Inv. Header";
        ExchangeRate: Decimal;
}

