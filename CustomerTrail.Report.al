report 50092 "Customer Trail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CustomerTrail.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter", "Global Dimension 1 Code", "Global Dimension 2 Code", "Customer Posting Group";
            column(CName; CompanyNameText)
            {
            }
            column(CAddress; CompInfo.Address + '  ' + CompInfo."Address 2" + ' , ' + CompInfo.City + ' - ' + CompInfo."Post Code")
            {
            }
            column(CPicture; CompInfo.Picture)
            {
            }
            column(No_Vendor; Customer."No.")
            {
            }
            column(Name_Vendor; Customer.Name)
            {
            }
            column(OpeningAmt; ABS(OpeningAmt))
            {
            }
            column(Sign1; Sign1)
            {
            }
            column(DebitAmt; DebitAmt)
            {
            }
            column(CreditAmt; CreditAmt)
            {
            }
            column(Balance; ABS(Balance1))
            {
            }
            column(Sign; Sign)
            {
            }
            column(Filters; Customer.GETFILTERS)
            {
            }

            trigger OnAfterGetRecord()
            begin
                OpeningAmt := 0;
                CustLedEntry.RESET;
                CustLedEntry.SETRANGE("Customer No.", "No.");
                CustLedEntry.SETFILTER("Posting Date", '%1..%2', 0D, FromDate - 1);
                IF Customer.GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    CustLedEntry.SETFILTER("Global Dimension 1 Code", Customer.GETFILTER("Global Dimension 1 Filter"));
                IF Customer.GETFILTER("Global Dimension 2 Filter") <> '' THEN
                    CustLedEntry.SETFILTER("Global Dimension 2 Code", Customer.GETFILTER("Global Dimension 2 Filter"));
                IF Customer.GETFILTER("Customer Posting Group") <> '' THEN
                    CustLedEntry.SETFILTER("Customer Posting Group", Customer.GETFILTER("Customer Posting Group"));
                IF CustLedEntry.FIND('-') THEN BEGIN
                    REPEAT
                        CustLedEntry.CALCFIELDS("Amount (LCY)");
                        OpeningAmt += CustLedEntry."Amount (LCY)";
                    UNTIL CustLedEntry.NEXT = 0;
                END;

                Sign1 := '';
                IF OpeningAmt < 0 THEN
                    Sign1 := 'Cr'
                ELSE
                    IF OpeningAmt > 0 THEN
                        Sign1 := 'Dr';


                DebitAmt := 0;
                CreditAmt := 0;
                CustLedEntry.RESET;
                CustLedEntry.SETRANGE("Customer No.", "No.");
                CustLedEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                IF Customer.GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    CustLedEntry.SETFILTER("Global Dimension 1 Code", Customer.GETFILTER("Global Dimension 1 Filter"));
                IF Customer.GETFILTER("Global Dimension 2 Filter") <> '' THEN
                    CustLedEntry.SETFILTER("Global Dimension 2 Code", Customer.GETFILTER("Global Dimension 2 Filter"));
                IF Customer.GETFILTER("Customer Posting Group") <> '' THEN
                    CustLedEntry.SETFILTER("Customer Posting Group", Customer.GETFILTER("Customer Posting Group"));
                IF CustLedEntry.FIND('-') THEN BEGIN
                    REPEAT
                        CustLedEntry.CALCFIELDS("Debit Amount (LCY)");
                        CustLedEntry.CALCFIELDS("Credit Amount (LCY)");
                        DebitAmt += CustLedEntry."Debit Amount (LCY)";
                        CreditAmt += CustLedEntry."Credit Amount (LCY)";
                    UNTIL CustLedEntry.NEXT = 0;
                END;
                Balance1 := OpeningAmt + DebitAmt - CreditAmt;

                Sign := '';
                IF Balance1 > 0 THEN
                    Sign := 'Dr'
                ELSE
                    IF Balance1 < 0 THEN
                        Sign := 'Cr';

                //AD_REPL
                TDebitAmt += DebitAmt;
                TCreditAmt += CreditAmt;
                TBalance += Balance1;
                TOpeningAmt += OpeningAmt;
                IF IsPrintToExcel THEN BEGIN
                    //ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ABS(OpeningAmt), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(Sign1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(DebitAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(CreditAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ABS(Balance1), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(Sign, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.NewRow;
                END;
                //AD_REPL
            end;

            trigger OnPostDataItem()
            begin
                //AD_REPL
                IF IsPrintToExcel THEN BEGIN
                    //ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.NewRow;
                    //ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Total', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TDebitAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TCreditAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                END;
                //AD_REPL
            end;

            trigger OnPreDataItem()
            begin
                //AD_REPL
                IF IsPrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.NewRow;
                    //ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Customer No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Opening Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Debit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Credit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Balance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                END;
                //AD_REPL
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(IsPrintToExcel; IsPrintToExcel)
                    {
                        Caption = 'Print To Excel';
                    }
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

    trigger OnPostReport()
    begin
        //AD_REPL
        IF IsPrintToExcel THEN
            CreateExcelbook;
        //AD_REPL
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(CompInfo.Picture);

        FromDate := Customer.GETRANGEMIN("Date Filter");
        ToDate := Customer.GETRANGEMAX("Date Filter");

        IF CompInfo."New Name Date" <> 0D THEN BEGIN
            IF ToDate >= CompInfo."New Name Date" THEN
                CompanyNameText := CompInfo.Name
            ELSE
                CompanyNameText := CompInfo."Old Name";
        END ELSE
            CompanyNameText := CompInfo.Name;

        //AD_REPL
        ReportFilters := Customer.GETFILTERS;
        IF IsPrintToExcel THEN
            MakeExcelInfo;
        //AD_REPL
    end;

    var
        CustLedEntry: Record "Cust. Ledger Entry";
        OpeningAmt: Decimal;
        FromDate: Date;
        ToDate: Date;
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        Sign1: Text;
        Sign: Text;
        Balance1: Decimal;
        CompInfo: Record "Company Information";
        ExcelBuf: Record "Excel Buffer" temporary;
        ReportFilters: Text;
        IsPrintToExcel: Boolean;
        TDebitAmt: Decimal;
        TCreditAmt: Decimal;
        TBalance: Decimal;
        TOpeningAmt: Decimal;
        CompanyNameText: Text;


    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel('Customer Trail Report', 'Customer Trail Report', COMPANYNAME, USERID);
        ERROR('');
    end;


    procedure MakeExcelInfo()
    begin
        ExcelBuf.AddColumn(CompanyNameText, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Report Name: Customer Trail Report', FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(ReportFilters, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Print Time: ' + FORMAT(CURRENTDATETIME), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
    end;
}

