pageextension 50024 PostedPurchaseInvoiceList extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field("Total CGST Amount"; Rec."Total CGST Amount")
            {
                ApplicationArea = all;
            }
            field("Total SGST Amount"; Rec."Total SGST Amount")
            {
                ApplicationArea = all;
            }
            field("Total IGST Amount"; Rec."Total IGST Amount")
            {
                ApplicationArea = all;
            }
            field("TDS Amount"; Rec."TDS Amount")
            {
                ApplicationArea = all;
            }
        }

    }
}
