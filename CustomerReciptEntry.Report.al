report 50034 "Customer Recipt Entry"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CustomerReciptEntry.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = WHERE("Journal Batch Name" = FILTER('BANKDATA'));
            RequestFilterFields = "Posting Date";
            column(Cust_NO; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(Name; Name)
            {
            }
            column(RemoCstomer_No; RemoCustNo)
            {
            }
            column(Date; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(Amount; "Cust. Ledger Entry"."Credit Amount")
            {
            }
            column(Recipt_No; "Cust. Ledger Entry"."Document No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("Cust. Ledger Entry"."Customer No.") THEN BEGIN
                    Name := Cust.Name;
                    RemoCustNo := Cust."Old No.(Ramco)";
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Document Type", '%1|%2|%3|%4|%5', "Document Type"::Payment, "Document Type"::"Finance Charge Memo", "Document Type"::Reminder, "Document Type"::Refund, "Document Type"::" ");
            end;
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
        Name: Text;
        RemoCustNo: Code[20];
}

