report 50022 "Vendor Trail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/VendorTrail.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.", "Date Filter", "Global Dimension 1 Code", "Global Dimension 2 Code", "Vendor Posting Group";
            column(CName; CompInfo.Name + '  ' + CompInfo."Name 2")
            {
            }
            column(CAddress; CompInfo.Address + '  ' + CompInfo."Address 2" + ' , ' + CompInfo.City + ' - ' + CompInfo."Post Code")
            {
            }
            column(CPicture; CompInfo.Picture)
            {
            }
            column(No_Vendor; Vendor."No.")
            {
            }
            column(Name_Vendor; Vendor.Name)
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
            column(Filters; Vendor.GETFILTERS)
            {
            }

            trigger OnAfterGetRecord()
            begin
                OpeningAmt := 0;
                VendLedEntry.RESET;
                VendLedEntry.SETRANGE("Vendor No.", "No.");
                VendLedEntry.SETFILTER("Posting Date", '%1..%2', 0D, FromDate - 1);
                IF Vendor.GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    VendLedEntry.SETFILTER("Global Dimension 1 Code", Vendor.GETFILTER("Global Dimension 1 Filter"));
                IF Vendor.GETFILTER("Global Dimension 2 Filter") <> '' THEN
                    VendLedEntry.SETFILTER("Global Dimension 2 Code", Vendor.GETFILTER("Global Dimension 2 Filter"));
                IF Vendor.GETFILTER("Vendor Posting Group") <> '' THEN
                    VendLedEntry.SETFILTER("Vendor Posting Group", Vendor.GETFILTER("Vendor Posting Group"));
                IF VendLedEntry.FIND('-') THEN BEGIN
                    REPEAT
                        VendLedEntry.CALCFIELDS("Amount (LCY)");
                        OpeningAmt += VendLedEntry."Amount (LCY)";
                    UNTIL VendLedEntry.NEXT = 0;
                END;

                Sign1 := '';
                IF OpeningAmt < 0 THEN
                    Sign1 := 'Cr'
                ELSE
                    IF OpeningAmt > 0 THEN
                        Sign1 := 'Dr';


                DebitAmt := 0;
                CreditAmt := 0;
                VendLedEntry.RESET;
                VendLedEntry.SETRANGE("Vendor No.", "No.");
                VendLedEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                IF Vendor.GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    VendLedEntry.SETFILTER("Global Dimension 1 Code", Vendor.GETFILTER("Global Dimension 1 Filter"));
                IF Vendor.GETFILTER("Global Dimension 2 Filter") <> '' THEN
                    VendLedEntry.SETFILTER("Global Dimension 2 Code", Vendor.GETFILTER("Global Dimension 2 Filter"));
                IF Vendor.GETFILTER("Vendor Posting Group") <> '' THEN
                    VendLedEntry.SETFILTER("Vendor Posting Group", Vendor.GETFILTER("Vendor Posting Group"));
                IF VendLedEntry.FIND('-') THEN BEGIN
                    REPEAT
                        VendLedEntry.CALCFIELDS("Debit Amount (LCY)");
                        VendLedEntry.CALCFIELDS("Credit Amount (LCY)");
                        DebitAmt += VendLedEntry."Debit Amount (LCY)";
                        CreditAmt += VendLedEntry."Credit Amount (LCY)";
                    UNTIL VendLedEntry.NEXT = 0;
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
                    ExcelBuf.AddColumn(Vendor."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(Vendor.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ABS(OpeningAmt), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(Sign1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(DebitAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(CreditAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ABS(Balance1), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(Sign, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                END;
                //AD_REPL
            end;

            trigger OnPostDataItem()
            begin
                //AD_REPL
                IF IsPrintToExcel THEN BEGIN
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.NewRow;
                    //ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Total', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
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
                    ExcelBuf.AddColumn('Vendor No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Vendor Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
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

        FromDate := Vendor.GETRANGEMIN("Date Filter");
        ToDate := Vendor.GETRANGEMAX("Date Filter");

        //AD_REPL
        ReportFilters := Vendor.GETFILTERS;
        IF IsPrintToExcel THEN
            MakeExcelInfo;
        //AD_REPL
    end;

    var
        VendLedEntry: Record "Vendor Ledger Entry";
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

    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel('Vendor Trail Report', 'Vendor Trail Report', COMPANYNAME, USERID);
        //ERROR('');
    end;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.AddColumn(COMPANYNAME, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Report Name: Vendor Trail Report', FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(ReportFilters, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Print Time: ' + FORMAT(CURRENTDATETIME), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
    end;
}

