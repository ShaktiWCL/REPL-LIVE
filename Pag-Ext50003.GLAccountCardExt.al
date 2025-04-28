pageextension 50003 "GL AccountCardExt" extends "G/L Account Card"
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
        modify(General)
        {
            Editable = IsEditable;
        }
        modify(Posting)
        {
            Editable = IsEditable;
        }
        modify(Consolidation)
        {
            Editable = IsEditable;
        }
        modify(Reporting)
        {
            Editable = IsEditable;
        }
        modify("Cost Accounting")
        {
            Editable = IsEditable;
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        IsEditableOn();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        IsEditableOn();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        IF NOT IsEditable THEN
            ERROR('');
    end;

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
