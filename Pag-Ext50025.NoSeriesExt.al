pageextension 50025 NoSeriesExt extends "No. Series"
{
    layout
    {
        addafter(Description)
        {
            field("Location Code"; Rec."Location Code")
            {
                Editable = IsEditable;
                ApplicationArea = all;
            }
            field("Filter not Applicable"; Rec."Filter not Applicable")
            {
                ApplicationArea = all;
                Editable = IsEditable;
            }
        }
        modify(Code)
        {
            Editable = IsEditable;
        }
        modify(Description)
        {
            Editable = IsEditable;
        }
        modify(StartNo)
        {
            Editable = IsEditable;
        }
        modify(EndNo)
        {
            Editable = IsEditable;
        }
        modify(StartDate)
        {
            Editable = IsEditable;
        }
        modify(LastDateUsed)
        {
            Editable = IsEditable;
        }
        modify(LastNoUsed)
        {
            Editable = IsEditable;
        }
        modify("Default Nos.")
        {
            Editable = IsEditable;
        }
        modify("Manual Nos.")
        {
            Editable = IsEditable;
        }
        modify("Date Order")
        {
            Editable = IsEditable;
        }
        modify(AllowGapsCtrl)
        {
            Editable = IsEditable;
        }
    }

    var
        [InDataSet]
        IsEditable: Boolean;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        IsEditableOn();
        Rec.FILTERGROUP(2);
        ActivateLocationWiseNoSeries;
        Rec.FILTERGROUP(0);
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        IsEditableOn();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF NOT IsEditable THEN
            ERROR('');
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF NOT IsEditable THEN
            ERROR('');
    end;

    procedure ActivateLocationWiseNoSeries()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        GeneralLedgerSetup.GET;
        IF GeneralLedgerSetup."Activate OU Filter" THEN BEGIN
            UserSetup.GET(USERID);
            IF NOT UserSetup."Admin User" THEN BEGIN
                ResponsibilityCenter.GET(UserSetup."Responsibility Center");
                IF NOT Rec."Filter not Applicable" THEN
                    Rec.SETRANGE("Location Code", ResponsibilityCenter."Location Code");
            END;
        end;
    END;

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
