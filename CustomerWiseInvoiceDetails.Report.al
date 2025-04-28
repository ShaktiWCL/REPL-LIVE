report 50044 "Customer Wise Invoice Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CustomerWiseInvoiceDetails.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = WHERE("Type Of Note" = FILTER(' '));
            RequestFilterFields = "Sell-to Customer No.", "No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code";
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(AmounttoCustomer_SalesInvoiceHeader; ROUND(("Sales Invoice Header".Amount * ExchangeRate), 0.01))
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(ProjectCode; ProjectCode)
            {
            }
            column(ProjectName; ProjectName)
            {
            }
            column(InvoiceStatus; InvoiceStatus)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(SrNo; SrNo)
            {
            }
            column(Adjust_Amount; PaidAmount)
            {
            }
            column(Outstanding_Amt; Outstanding)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Currency Code" <> '' THEN
                    ExchangeRate := 1 / "Currency Factor"
                ELSE
                    ExchangeRate := 1;

                CALCFIELDS(Amount);
                ProjectCode := '';
                ProjectName := '';

                SrNo += 1;
                Project.SETRANGE("Global Dimension 1 Code", "Shortcut Dimension 1 Code");
                IF Project.FINDFIRST THEN BEGIN
                    ProjectCode := Project."No.";
                    ProjectName := Project.Description;
                END;


                InvoiceStatus := '';
                Outstanding := 0;
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETFILTER("Document No.", "No.");
                IF CustLedgerEntry.FINDFIRST THEN BEGIN
                    CustLedgerEntry.CALCFIELDS("Amount (LCY)");
                    CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                    IF CustLedgerEntry."Remaining Amt. (LCY)" = 0 THEN
                        InvoiceStatus := 'FULLY ADJUSTED';
                    IF CustLedgerEntry."Amount (LCY)" = CustLedgerEntry."Remaining Amt. (LCY)" THEN
                        InvoiceStatus := 'Authorized';
                    IF (CustLedgerEntry."Remaining Amt. (LCY)" <> 0) AND (CustLedgerEntry."Amount (LCY)" <> CustLedgerEntry."Remaining Amt. (LCY)") THEN
                        InvoiceStatus := 'PARTLY ADJUSTED';
                    Outstanding := CustLedgerEntry."Remaining Amt. (LCY)";
                END;

                //Condition 1
                PaidAmount := 0;
                CustLedgEntry.RESET;
                CustLedgEntry.SETRANGE("Document No.", "No.");
                IF CustLedgEntry.FINDFIRST THEN BEGIN
                    DetailedCustLedgEntry.RESET;
                    DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
                    DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                    DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
                    DetailedCustLedgEntry.SETFILTER("Initial Document Type", '%1', DetailedCustLedgEntry."Initial Document Type"::Invoice);
                    IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            CustLedgEntry1.RESET;
                            CustLedgEntry1.SETRANGE("Document No.", DetailedCustLedgEntry."Document No.");
                            CustLedgEntry1.SETFILTER("Source Code", '%1', 'BANKRCPTV');
                            IF CustLedgEntry1.FINDFIRST THEN
                                PaidAmount += -(DetailedCustLedgEntry."Amount (LCY)");
                        UNTIL DetailedCustLedgEntry.NEXT = 0;
                    END;
                END;
                //Condition 1

                //Condition 2
                CustLedgEntry.RESET;
                CustLedgEntry.SETRANGE("Document No.", "No.");
                IF CustLedgEntry.FINDFIRST THEN BEGIN
                    DetailedCustLedgEntry.RESET;
                    DetailedCustLedgEntry.SETCURRENTKEY("Document No.");
                    DetailedCustLedgEntry.SETRANGE("Document No.", CustLedgEntry."Document No.");
                    DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
                    DetailedCustLedgEntry.SETFILTER("Document Type", '%1', DetailedCustLedgEntry."Document Type"::Invoice);
                    IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            CustLedgEntry1.GET(DetailedCustLedgEntry."Cust. Ledger Entry No.");
                            IF CustLedgEntry1."Source Code" = 'BANKRCPTV' THEN
                                PaidAmount += (DetailedCustLedgEntry."Amount (LCY)");
                        UNTIL DetailedCustLedgEntry.NEXT = 0;
                    END;
                END;
                //Condition 2
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Posting Date", StartDate, EndDate);
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

    trigger OnInitReport()
    begin
        StartDate := CALCDATE('-CM', TODAY);
        EndDate := CALCDATE('CM', TODAY);
    end;

    var
        Project: Record Job;
        ProjectCode: Code[20];
        ProjectName: Text;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        InvoiceStatus: Text;
        StartDate: Date;
        EndDate: Date;
        SrNo: Integer;
        PaidAmount: Decimal;
        CustLedgEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry1: Record "Cust. Ledger Entry";
        ReceiptAmount: Decimal;
        Outstanding: Decimal;
        ExchangeRate: Decimal;

    procedure GetReceiptAmt(DocumentNo: Code[20]) ReceiptAmt: Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        CustLedgerEntry.SETFILTER("Document No.", DocumentNo);
        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                DetailedCustLedgEntry.SETRANGE("Document No.", DocumentNo);
                DetailedCustLedgEntry.SETRANGE("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
                DetailedCustLedgEntry.SETFILTER("Initial Document Type", '<>%1', DetailedCustLedgEntry."Initial Document Type"::Invoice);
                IF DetailedCustLedgEntry.FINDFIRST THEN
                    REPEAT
                        IF DetailedCustLedgEntry."Initial Document Type" <> DetailedCustLedgEntry."Initial Document Type"::"Credit Memo" THEN
                            ReceiptAmt += ABS(DetailedCustLedgEntry."Amount (LCY)");
                    UNTIL DetailedCustLedgEntry.NEXT = 0;
            /*
            CustLedgerEntry2.RESET;
            CustLedgerEntry2.SETRANGE("Closed by Entry No.",CustLedgerEntry."Entry No.");
            CustLedgerEntry2.SETFILTER("Document Type",'<>%1',CustLedgerEntry2."Document Type"::"Credit Memo");
            IF CustLedgerEntry2.FINDFIRST THEN
             REPEAT
              CustLedgerEntry2.CALCFIELDS("Amount (LCY)");
              ReceiptAmt += ABS(CustLedgerEntry2."Amount (LCY)");
             UNTIL CustLedgerEntry2.NEXT = 0;
             */
            UNTIL CustLedgerEntry.NEXT = 0;

        EXIT(ReceiptAmt);

    end;

    procedure GetAdjustAmt(DocumentNo: Code[20]) ReceiptAmt: Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        CustLedgerEntry.SETFILTER("Document No.", DocumentNo);
        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                DetailedCustLedgEntry.SETRANGE("Document No.", DocumentNo);
                DetailedCustLedgEntry.SETRANGE("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
                DetailedCustLedgEntry.SETFILTER("Initial Document Type", '<>%1', DetailedCustLedgEntry."Initial Document Type"::Invoice);
                IF DetailedCustLedgEntry.FINDFIRST THEN
                    REPEAT
                        IF DetailedCustLedgEntry."Initial Document Type" = DetailedCustLedgEntry."Initial Document Type"::"Credit Memo" THEN
                            ReceiptAmt += ABS(DetailedCustLedgEntry."Amount (LCY)");
                    UNTIL DetailedCustLedgEntry.NEXT = 0;

            /*
            CustLedgerEntry2.RESET;
            CustLedgerEntry2.SETRANGE("Closed by Entry No.",CustLedgerEntry."Entry No.");
            CustLedgerEntry2.SETFILTER("Document Type",'%1',CustLedgerEntry2."Document Type"::"Credit Memo");
            IF CustLedgerEntry2.FINDFIRST THEN
             REPEAT
              CustLedgerEntry2.CALCFIELDS("Amount (LCY)");
              ReceiptAmt += ABS(CustLedgerEntry2."Amount (LCY)");
             UNTIL CustLedgerEntry2.NEXT = 0;
             */
            UNTIL CustLedgerEntry.NEXT = 0;

        EXIT(ReceiptAmt);

    end;
}

