report 50031 "GST Transaction Details"
{
    ApplicationArea = All;
    Caption = 'GST Transaction Details';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(TaxTransactionValue; "Tax Transaction Value")
        {
            column(TaxRecordID; "Tax Record ID")
            {
            }
            column(TaxType; "Tax Type")
            {
            }
            column(ValueID; "Value ID")
            {
            }
            column(ValueType; "Value Type")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AmountLCY; "Amount (LCY)")
            {
            }
            column(Percent; Percent)
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
