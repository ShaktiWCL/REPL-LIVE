report 50049 DetailedCustomerUpdate
{
    ApplicationArea = All;
    Caption = 'Update Detailed Customer Ledger Update';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = True;
    dataset
    {

        dataitem(DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry")

        {
            RequestFilterFields = "Entry Type";
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                DetailedCustLedgEntry."Ledger Entry Amount" := True;
                DetailedCustLedgEntry.Modify()
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
