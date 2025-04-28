report 50024 "None Close Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/NoneClosePurchaseOrder.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Order),
                                      Status = FILTER(Released));
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("No.")
                                    ORDER(Descending)
                                    WHERE("Outstanding Amount" = FILTER(<> 0));
                column(DocumentNo_PurchaseLine; "Purchase Line"."Document No.")
                {
                }
                column(BuyfromVendorNo_PurchaseLine; "Purchase Line"."Buy-from Vendor No.")
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(Description2_PurchaseLine; "Purchase Line"."Description 2")
                {
                }
                column(AmountToVendor_PurchaseLine; ROUND(("Purchase Line".Amount * ExchangeRate), 0.01))
                {
                }
                column(OutstandingAmount_PurchaseLine; ROUND(("Purchase Line"."Outstanding Amount" * ExchangeRate), 0.01))
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF "Currency Code" <> '' THEN
                    ExchangeRate := 1 / "Currency Factor"
                ELSE
                    ExchangeRate := 1;
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
        ExchangeRate: Decimal;
}

