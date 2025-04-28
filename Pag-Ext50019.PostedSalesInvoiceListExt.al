pageextension 50019 PostedSalesInvoiceListExt extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Ship-to Contact")
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
        }
        addafter("Shipment Date")
        {
            field("Project Code"; Rec."Project Code")
            {
                ApplicationArea = all;
            }
            field("Project Name"; Rec."Project Name")
            {
                ApplicationArea = all;
            }
            field("Invoice Type"; Rec."Invoice Type")
            {
                ApplicationArea = all;
            }
            field("IRN Hash"; Rec."IRN Hash")
            {
                ApplicationArea = all;
            }
            field("Acknowledgement No."; Rec."Acknowledgement No.")
            {
                ApplicationArea = all;
            }
            field("Acknowledgement Date"; Rec."Acknowledgement Date")
            {
                ApplicationArea = all;
            }
            field("E-Inv. Cancelled Date"; Rec."E-Inv. Cancelled Date")
            {
                ApplicationArea = all;
            }
            field("Cancel Reason"; Rec."Cancel Reason")
            {
                ApplicationArea = all;
            }
        }
    }
}
