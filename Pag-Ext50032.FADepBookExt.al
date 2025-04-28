pageextension 50032 FADepBookExt extends "FA Depreciation Books"
{
    layout
    {
        addafter("Depr. Ending Date (Custom 1)")
        {
            field("Remaining Life (Year)"; Rec."Remaining Life (Year)")
            {
                ApplicationArea = all;
            }
        }
    }
}
