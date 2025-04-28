pageextension 50005 CustLedgerEntryExt extends "Customer Ledger Entries"

{
    layout
    {
        addafter("Customer Name")
        {
            field("Cust. Group Code"; Rec."Cust. Group Code")
            {
                ApplicationArea = all;
            }
        }
    }
}

