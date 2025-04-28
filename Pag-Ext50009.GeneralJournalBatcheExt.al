pageextension 50009 GeneralJournalBatcheExt extends "General Journal Batches"
{
    layout
    {
        addafter("Allow Payment Export")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = all;
            }
            Field("Approver Id 1"; Rec."Approver Id 1")
            {
                ApplicationArea = all;
            }
            field("Approver Id 2"; Rec."Approver Id 2")
            {
                ApplicationArea = all;
            }
            field("Pending for Auth."; Rec."Pending for Auth.")
            {
                ApplicationArea = all;
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //Rec.Reset();
        IsEditableOn;

        Rec.FILTERGROUP(2);
        ActivateLocationWiseNoSeries;
        Rec.FILTERGROUP(0);
    end;

    var
        IsEditable: Boolean;

    local procedure IsEditableOn()
    var
        GetUserId: Record "User Setup";
    begin
        GetUserId.GET(USERID);
        IF GetUserId."Admin User" THEN
            IsEditable := TRUE
        ELSE
            IsEditable := FALSE;
    end;

    local procedure ActivateLocationWiseNoSeries()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        GeneralLedgerSetup.GET;
        IF GeneralLedgerSetup."Activate OU Filter" THEN BEGIN
            UserSetup.GET(USERID);
            IF NOT UserSetup."Admin User" THEN BEGIN
                IF NOT UserSetup."View Batches" THEN BEGIN
                    ResponsibilityCenter.GET(UserSetup."Responsibility Center");
                    Rec.SETRANGE("Responsibility Center", UserSetup."Responsibility Center");
                    Rec.SETRANGE("Location Code", ResponsibilityCenter."Location Code");
                    //IF COMPANYNAME = 'Z-RIPL' THEN BEGIN
                    IF UserSetup."Voucher Approver 1" THEN
                        Rec.SETRANGE("Approver Id 1", USERID)
                    ELSE
                        IF UserSetup."Voucher Approver 2" THEN
                            Rec.SETRANGE("Approver Id 2", USERID)
                        ELSE
                            Rec.SETRANGE("User ID", USERID);
                END ELSE
                    Rec.SETRANGE("User ID", USERID);
                //END;
            END;
        END;
    end;
}
