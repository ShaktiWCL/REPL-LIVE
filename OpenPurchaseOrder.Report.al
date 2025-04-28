report 50023 "Open Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/OpenPurchaseOrder.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Descending)
                                WHERE("Document Type" = FILTER(Order),
                                      Status = FILTER(Open | "Pending Approval"));
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("No.")
                                    ORDER(Descending);
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

