pageextension 50000 CurrencyExt extends Currencies
{
    layout
    {
        addafter(Code)
        {
            field("Currency Symbol"; Rec."Currency Symbol")
            {
                ApplicationArea = all;
            }
            field("Currency Numeric Description 1"; Rec."Currency Numeric Description 1")
            {
                ApplicationArea = all;
            }
            field("Currency Decimal Description 1"; Rec."Currency Decimal Description 1")
            {
                ApplicationArea = all;
            }

        }
    }
}

