pageextension 50004 GLAccountList extends "G/L Account List"
{
    layout
    {
        addafter("No.")
        {
            field("Old Code(Ramco)"; Rec."Old Code(Ramco)")
            {
                ApplicationArea = all;
            }
        }
    }
}

