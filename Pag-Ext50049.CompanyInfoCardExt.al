pageextension 50049 "Company Info CardExt" extends "Company Information"
{
    layout
    {
        addafter("Company Status")
        {
            field("Fusion Hub"; Rec."Fusion Hub")
            {
                ApplicationArea = All;
            }
        }
    }
}
