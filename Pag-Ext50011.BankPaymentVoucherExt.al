pageextension 50011 "BankPaymentVoucherExt" extends "Bank Payment Voucher"
{
    layout
    {
        addafter("Shortcut Dimension 1 Code")
        {
            field("Emp.Code"; Rec."Emp.Code")
            {
                ApplicationArea = all;
            }
        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetBatchName();
    end;

    local procedure SetBatchName()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GeneralLedgerSetup.GET;
        IF GeneralLedgerSetup."Activate OU Filter" THEN
            Rec."Journal Batch Name" := 'Default';
    end;

}
