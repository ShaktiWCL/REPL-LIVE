pageextension 50041 "Item Card PageExt" extends "Item Card"
{
    layout
    {
        modify(Item)
        {
            Editable = IsEditable;
        }
        modify(Inventory)
        {
            Editable = IsEditable;
        }
        modify("Costs & Posting")
        {
            Editable = IsEditable;
        }
        modify("Prices & Sales")
        {
            Editable = IsEditable;
        }
        modify(Replenishment)
        {
            Editable = IsEditable;
        }
        modify(Planning)
        {
            Editable = IsEditable;
        }
        modify(ItemTracking)
        {
            Editable = IsEditable;
        }
        modify(Warehouse)
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
