pageextension 50001 "LocationCard.Ext" extends "Location Card"
{
    layout
    {
        addafter("Phone No.")
        {
            field("Location Sales Invoice No."; Rec."Location Sales Invoice No.")
            {
                ApplicationArea = all;
            }
            field("Sales Debit Nos"; Rec."Sales Debit Nos")
            {
                ApplicationArea = all;
            }
            field("Posting Sales Debit Nos"; Rec."Posting Sales Debit Nos")
            {
                ApplicationArea = all;
            }
            field("Purch. Credit Nos"; Rec."Purch. Credit Nos")
            {
                ApplicationArea = all;
            }
            field("Posting Purch. Credit Nos"; Rec."Posting Purch. Credit Nos")
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
        modify(Warehouse)
        {
            Editable = IsEditable;
        }
        modify(Bins)
        {
            Editable = IsEditable;
        }
        modify("Bin Policies")
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
