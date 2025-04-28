report 50028 "Sales Value"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/SalesValue.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            CalcFields = Amount;
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(SelltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(AmounttoCustomer_SalesInvoiceHeader; ROUND(("Sales Invoice Header".Amount * ExchangeRate), 0.01))
            {
            }
            column(ReportFilter; "Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date"))
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Currency Code" <> '' THEN
                    ExchangeRate := 1 / "Currency Factor"
                ELSE
                    ExchangeRate := 1;
            end;

            trigger OnPreDataItem()
            begin
                IF ViewFor = ViewFor::Month THEN
                    SETRANGE("Posting Date", CALCDATE('-CM', WORKDATE), CALCDATE('CM', WORKDATE));
                IF ViewFor = ViewFor::Quarter THEN
                    SETRANGE("Posting Date", CALCDATE('-CQ', WORKDATE), CALCDATE('CQ', WORKDATE));

                Month1 := DATE2DMY(WORKDATE, 2);
                Year1 := DATE2DMY(WORKDATE, 3);
                IF Month1 IN [1, 2, 3] THEN
                    FYear := Year1 - 1
                ELSE
                    FYear := Year1;
                IF ViewFor = ViewFor::Year THEN
                    SETRANGE("Posting Date", DMY2DATE(1, 4, FYear), DMY2DATE(31, 3, FYear + 1));
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ViewFor; ViewFor)
                {
                    Caption = 'View For';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(CompInfo.Picture);

        IF ViewFor = ViewFor::" " THEN
            ERROR('Please select viewfor');
    end;

    var
        ViewFor: Option " ",Month,Quarter,Year;
        CompInfo: Record "Company Information";
        Month1: Integer;
        Year1: Integer;
        FYear: Integer;
        ExchangeRate: Decimal;
}

