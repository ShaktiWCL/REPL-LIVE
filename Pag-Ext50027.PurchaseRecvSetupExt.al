pageextension 50027 PurchaseRecvSetupExt extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Posted Invoice Nos.")
        {
            field("Temp Vendor Nos"; Rec."Temp Vendor Nos")
            {
                ApplicationArea = all;
            }
            field("Purch. Credit Nos"; Rec."Purch. Credit Nos")
            {
                ApplicationArea = all;

            }
            field("Posting Purch. Credit Nos"; Rec."Posting Purch. Credit Nos")
            {
                ApplicationArea = all;
            }
        }
    }
}
