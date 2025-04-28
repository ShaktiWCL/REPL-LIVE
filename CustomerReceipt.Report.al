report 50148 "Customer Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CustomerReceipt.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                                    ORDER(Ascending)
                                    WHERE("Source Code" = FILTER('BANKRCPTV'));
                RequestFilterFields = "Document No.";
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Posting Date")
                                        ORDER(Ascending)
                                        WHERE("Entry Type" = FILTER(Application),
                                              "Initial Document Type" = FILTER(Invoice));
                    column(DocumentNo_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Document No.")
                    {
                    }
                    column(CustomerNo_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Customer No.")
                    {
                    }
                    column(CustName; CustName)
                    {
                    }
                    column(ProjectCode; ProjectCode)
                    {
                    }
                    column(PostingDate_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Posting Date")
                    {
                    }
                    column(AmountLCY_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Amount (LCY)")
                    {
                    }
                    column(AppliedInvoiceNo; AppliedInvoiceNo)
                    {
                    }
                    column(ReceiptAmount; ReceiptAmount)
                    {
                    }
                    column(CostCenter; CostCenter)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CustName := '';
                        IF Cust.GET("Detailed Cust. Ledg. Entry"."Customer No.") THEN
                            CustName := Cust.Name;

                        AppliedInvoiceNo := '';
                        ReceiptAmount := 0;
                        CostCenter := '';

                        IF CustLedgEntry.GET("Cust. Ledger Entry No.") THEN BEGIN
                            AppliedInvoiceNo := CustLedgEntry."Document No.";
                            ReceiptAmount := CustLedgEntry."Amount (LCY)";
                            CostCenter := CustLedgEntry."Global Dimension 1 Code";
                        END;

                        ProjectCode := '';
                        Project.RESET;
                        Project.SETRANGE("Global Dimension 1 Code", "Initial Entry Global Dim. 1");
                        IF Project.FINDFIRST THEN
                            ProjectCode := Project."No.";
                    end;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Cust: Record Customer;
        CustName: Text;
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        ReceiptPaidAmount: Decimal;
        OtherPaidAmount: Decimal;
        RcptNo: Text;
        RcptDate: Text;
        AppliedInvoiceNo: Code[50];
        ReceiptAmount: Decimal;
        CostCenter: Text;
        AppliedProdject: Code[40];
        Project: Record Job;
        ProjectCode: Text;
}

