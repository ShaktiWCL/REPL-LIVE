pageextension 50026 SalesRecevbleSetupExt extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Posted Credit Memo Nos.")
        {
            field("Project Charter Nos"; Rec."Project Charter Nos")
            {
                ApplicationArea = all;
            }
            field("Temp Customer Nos"; Rec."Temp Customer Nos")
            {
                ApplicationArea = all;
            }
            field("Sales Debit Nos"; Rec."Sales Debit Nos")
            {
                ApplicationArea = all;
            }
            field("Posting Sales Debit Nos"; Rec."Posting Sales Debit Nos")
            {
                ApplicationArea = all;
            }
        }
    }
}
