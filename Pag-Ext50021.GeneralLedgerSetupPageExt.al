pageextension 50021 "General Ledger Setup PageExt" extends "General Ledger Setup"
{
    layout
    {
        addafter(EnableDataCheck)
        {
            field("Temp Account Nos."; Rec."Temp Account Nos.")
            {
                ApplicationArea = All;
            }
            field("TDS Posting No. for Debit Note"; Rec."TDS Posting No. for Debit Note")
            {
                ApplicationArea = All;
            }
            field("Date Set for Posting Rights"; Rec."Date Set for Posting Rights")
            {
                ApplicationArea = All;
            }
            field("Activate OU Filter"; Rec."Activate OU Filter")
            {
                ApplicationArea = All;
            }
            field("JV Posting Nos"; Rec."JV Posting Nos")
            {
                ApplicationArea = All;
            }
            field(JVAccountNo; Rec.JVAccountNo)
            {
                ApplicationArea = All;
            }
            field("TDS Recv Batch Name"; Rec."TDS Recv Batch Name")
            {
                ApplicationArea = All;
            }
            field("TDS Recv Template Name"; Rec."TDS Recv Template Name")
            {
                ApplicationArea = All;
            }
        }
        modify(General)
        {
            Editable = IsEditable;
        }
        modify(Control1900309501)
        {
            Editable = IsEditable;
        }
        modify("Background Posting")
        {
            Editable = IsEditable;
        }
        modify(Reporting)
        {
            Editable = IsEditable;
        }
        modify(Application)
        {
            Editable = IsEditable;
        }
        modify("Tax Information")
        {
            Editable = IsEditable;
        }
        modify(TCS)
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
