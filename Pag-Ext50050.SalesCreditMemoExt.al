pageextension 50050 "Sales Credit MemoExt" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Payment Discount %")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = all;
                Editable = true;
            }
        }
    }
}
