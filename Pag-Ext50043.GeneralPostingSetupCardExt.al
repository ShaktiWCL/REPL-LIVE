pageextension 50043 "General Posting Setup CardExt" extends "General Posting Setup Card"
{
    layout
    {
        modify(General)
        {
            Editable = IsEditable;
        }
        modify(Sales)
        {
            Editable = IsEditable;
        }
        modify(Purchases)
        {
            Editable = IsEditable;
        }
        modify(Inventory)
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

    trigger OnDeleteRecord(): Boolean
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
