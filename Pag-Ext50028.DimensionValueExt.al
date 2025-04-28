pageextension 50028 DimensionValueExt extends "Dimension Values"
{
    layout
    {
        // modify(Code)
        // {

        //     Editable = IsEditable;
        // }

        addafter(Totaling)
        {
            field("Responsibility Center Code"; Rec."Responsibility Center Code")
            {
                ApplicationArea = all;
            }
        }
    }

    var
        IsEditable: Boolean;

    procedure IsEditableOn()
    var
        GetUserId: Record "User Setup";
    begin
        GetUserId.GET(USERID);
        IF GetUserId."Admin User" THEN
            IsEditable := TRUE
        ELSE
            IsEditable := FALSE;
    end;
}
