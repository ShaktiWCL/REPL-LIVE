pageextension 50031 FASetupExt extends "Fixed Asset Setup"
{
    layout
    {
        addafter("Automatic Insurance Posting")
        {
            field("Salvage Value %"; Rec."Salvage Value %")
            {
                ApplicationArea = all;
            }
        }
    }
}
