pageextension 50002 CustomerPageExt extends "Customer Card"
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
        addafter("Last Date Modified")
        {
            field("Old Customer No."; Rec."Old Customer No.")
            {
                ApplicationArea = all;
            }
            field("TDS %"; Rec."TDS %")
            {
                ApplicationArea = all;
            }
        }
        modify(General)
        {
            Editable = IsEditable;
        }
        modify("Address & Contact")
        {
            Editable = IsEditable;
        }
        modify(Invoicing)
        {
            Editable = IsEditable;
        }
        modify(Payments)
        {
            Editable = IsEditable;
        }
        modify(Shipping)
        {
            Editable = IsEditable;
        }
        modify("Tax Information")
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
