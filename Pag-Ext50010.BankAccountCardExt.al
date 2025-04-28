pageextension 50010 BankAccountCardExt extends "Bank Account Card"
{
    layout
    {
        addafter("No.")
        {
            field("Old No.(Ramco)"; Rec."Old No.(Ramco)")
            {
                ApplicationArea = all;
            }
        }
        modify(General)
        {
            Editable = IsEditable;
        }
        modify(Communication)
        {
            Editable = IsEditable;
        }
        modify(Posting)
        {
            Editable = IsEditable;
        }
        modify(Transfer)
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
