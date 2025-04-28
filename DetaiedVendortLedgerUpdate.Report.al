report 50051 DetailedVendorLedgerUpdate
{
    ApplicationArea = All;
    Caption = 'Update Detailed Vendor Ledger Update';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = True;
    dataset
    {

        dataitem(DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry")

        {
            RequestFilterFields = "Entry Type";
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                DetailedVendorLedgEntry."Ledger Entry Amount" := true;
                DetailedVendorLedgEntry.Modify()
            end;
        }
    }
    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('Done');
    end;

}
