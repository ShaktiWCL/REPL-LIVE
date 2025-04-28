pageextension 50020 JournalExt extends "Journal Voucher"
{
    layout
    {
        addafter("Shortcut Dimension 1 Code")
        {
            field("Emp.Code"; Rec."Emp.Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
