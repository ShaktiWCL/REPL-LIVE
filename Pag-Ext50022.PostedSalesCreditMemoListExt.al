pageextension 50022 PostedSalesCreditMemoListExt extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Ship-to Country/Region Code")
        {
            field("IRN Hash"; Rec."IRN Hash")
            {
                ApplicationArea = all;
            }
            field("Project Code"; Rec."Project Code")
            {
                ApplicationArea = all;
            }
            field("Project Name"; Rec."Project Name")
            {
                ApplicationArea = all;
            }
            field("Project Desc (SUDA)"; Rec."Project Desc (SUDA)")
            {
                ApplicationArea = all;
            }
        }
    }
}
