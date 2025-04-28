pageextension 50033 AssesseeCodeExt extends "Assessee Codes"
{
    layout
    {
        addafter(Type)
        {
            field("Dedcutee Code"; Rec."Dedcutee Code")
            {
                ApplicationArea = all;
            }
        }
    }

}

