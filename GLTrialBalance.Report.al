report 50015 "G/L Trial Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/GLTrialBalance.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            RequestFilterFields = "No.", "Date Filter";
            column(No_GLAccount; "G/L Account"."No.")
            {
            }
            column(Name_GLAccount; "G/L Account".Name)
            {
            }
            column(CName; CompInfo.Name + '  ' + CompInfo."Name 2")
            {
            }
            column(CAddress; CompInfo.Address + '  ' + CompInfo."Address 2" + ' , ' + CompInfo.City + ' - ' + CompInfo."Post Code")
            {
            }
            column(CPicture; CompInfo.Picture)
            {
            }
            column(OpeningAmtDr; OpeningAmtDr * AmountforMultiple)
            {
            }
            column(OpeningAmtCr; OpeningAmtCr * AmountforMultiple)
            {
            }
            column(AccountType_GLAccount; "G/L Account"."Account Type")
            {
            }
            column(NetChange_GLAccount; "G/L Account"."Net Change")
            {
            }
            column(Balance; Balance1 * AmountforMultiple)
            {
            }
            column(OldCodeRamco_GLAccount; "G/L Account"."Old Code(Ramco)")
            {
            }
            column(TotalBalance; Balance * AmountforMultiple)
            {
            }
            column(Sign; Sign)
            {
            }
            column(DebitAmt; DebitAmt * AmountforMultiple)
            {
            }
            column(CreditAmt; CreditAmt * AmountforMultiple)
            {
            }
            column(GETFILTERS; "G/L Account".GETFILTERS)
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(DebitBalance; DebitBalance * AmountforMultiple)
            {
            }
            column(CreditBalance; CreditBalance * AmountforMultiple)
            {
            }

            trigger OnAfterGetRecord()
            begin
                OpeningAmt := 0;
                OpeningAmtDr := 0;
                OpeningAmtCr := 0;
                Balance1 := 0;
                Balance := 0;
                GLEntry1.RESET;
                GLEntry1.SETRANGE("G/L Account No.", "No.");
                GLEntry1.SETFILTER("Posting Date", '%1..%2', 0D, CLOSINGDATE(FromDate - 1));
                IF "G/L Account".GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    GLEntry1.SETFILTER("Global Dimension 1 Code", "G/L Account".GETFILTER("Global Dimension 1 Filter"));
                IF "G/L Account".GETFILTER("Global Dimension 2 Filter") <> '' THEN
                    GLEntry1.SETFILTER("Global Dimension 2 Code", "G/L Account".GETFILTER("Global Dimension 2 Filter"));
                IF GLEntry1.FIND('-') THEN BEGIN
                    REPEAT
                        OpeningAmt += GLEntry1.Amount;
                    UNTIL GLEntry1.NEXT = 0;
                END;

                IF OpeningAmt > 0 THEN
                    OpeningAmtDr := OpeningAmt
                ELSE
                    IF OpeningAmt < 0 THEN
                        OpeningAmtCr := ABS(OpeningAmt);

                DebitAmt := 0;
                CreditAmt := 0;
                GLEntryAmt := 0;
                GLEntry.RESET;
                GLEntry.SETRANGE(GLEntry."G/L Account No.", "No.");
                GLEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                IF "G/L Account".GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    GLEntry.SETFILTER("Global Dimension 1 Code", "G/L Account".GETFILTER("Global Dimension 1 Filter"));
                IF "G/L Account".GETFILTER("Global Dimension 2 Filter") <> '' THEN
                    GLEntry.SETFILTER("Global Dimension 2 Code", "G/L Account".GETFILTER("Global Dimension 2 Filter"));
                IF GLEntry.FIND('-') THEN BEGIN
                    REPEAT
                        DebitAmt += GLEntry."Debit Amount";
                        CreditAmt += GLEntry."Credit Amount";
                        GLEntryAmt += GLEntry.Amount;
                    UNTIL GLEntry.NEXT = 0;
                END;

                Balance1 := ABS(OpeningAmt + GLEntryAmt);
                Balance := (OpeningAmt + GLEntryAmt);

                Sign := '';
                DebitBalance := 0;
                CreditBalance := 0;
                IF (OpeningAmt + GLEntryAmt) > 0 THEN BEGIN
                    Sign := 'Dr';
                    DebitBalance := (OpeningAmt + GLEntryAmt);
                END ELSE
                    IF (OpeningAmt + GLEntryAmt) < 0 THEN BEGIN
                        Sign := 'Cr';
                        CreditBalance := ABS(OpeningAmt + GLEntryAmt);
                    END;

                IF NotShowZeroAmount THEN
                    IF (OpeningAmt = 0) AND (DebitAmt = 0) AND (CreditAmt = 0) THEN
                        CurrReport.SKIP;

                IF NotShowZeroBalane THEN
                    IF Balance1 = 0 THEN
                        CurrReport.SKIP;

                IF IsPrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("G/L Account"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("G/L Account"."Old Code(Ramco)", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("G/L Account".Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(CurrencyCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ROUND(OpeningAmtDr * AmountforMultiple, 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(OpeningAmtCr * AmountforMultiple, 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(DebitAmt * AmountforMultiple, 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(CreditAmt * AmountforMultiple, 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(DebitBalance * AmountforMultiple, 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(CreditBalance * AmountforMultiple, 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(Balance * AmountforMultiple, 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    TotalValue[1] += OpeningAmtDr * AmountforMultiple;
                    TotalValue[2] += OpeningAmtCr * AmountforMultiple;
                    TotalValue[3] += DebitAmt * AmountforMultiple;
                    TotalValue[4] += CreditAmt * AmountforMultiple;
                    TotalValue[5] += DebitBalance * AmountforMultiple;
                    TotalValue[6] += CreditBalance * AmountforMultiple;

                END;
            end;

            trigger OnPostDataItem()
            begin
                IF IsPrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('Total', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TotalValue[1], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalValue[2], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalValue[3], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalValue[4], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalValue[5], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalValue[6], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.NewRow;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(Picture);

                IF IsPrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Account No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Old Code Ramco', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Account Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Currency Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Opening Debit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Opening Credit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Transactional Debit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Transactional Credit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Closing Debit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Closing Credit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Balance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(A)
                {
                    field("Amount for Multiple"; AmountforMultiple)
                    {
                    }
                    field("Not Show Zero Amount"; NotShowZeroAmount)
                    {
                    }
                    field("Not Show Zero Balane"; NotShowZeroBalane)
                    {
                    }
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

        trigger OnInit()
        begin
            NotShowZeroAmount := TRUE;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF IsPrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        FromDate := "G/L Account".GETRANGEMIN("Date Filter");
        ToDate := "G/L Account".GETRANGEMAX("Date Filter");
        GLSetup.GET;
        IF AmountforMultiple = 0 THEN BEGIN
            AmountforMultiple := 1;
            CurrencyCode := GLSetup."LCY Code";
        END ELSE
            CurrencyCode := 'INR';

        ReportFilters := "G/L Account".GETFILTERS;
        ExcelBuf.DELETEALL;
        IF IsPrintToExcel THEN
            MakeExcelInfo;
    end;

    var
        CompInfo: Record "Company Information";
        OpeningAmt: Decimal;
        OpeningAmtDr: Decimal;
        OpeningAmtCr: Decimal;
        GLAccount: Record "G/L Account";
        FromDate: Date;
        ToDate: Date;
        Sign: Text;
        Balance1: Decimal;
        GLEntry: Record "G/L Entry";
        Check1: Boolean;
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        GLEntry1: Record "G/L Entry";
        GLEntryAmt: Decimal;
        Balance: Decimal;
        AmountforMultiple: Decimal;
        NotShowZeroAmount: Boolean;
        NotShowZeroBalane: Boolean;
        CurrencyCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        DebitBalance: Decimal;
        CreditBalance: Decimal;
        ExcelBuf: Record "Excel Buffer" temporary;
        IsPrintToExcel: Boolean;
        TotalValue: array[10] of Decimal;
        ReportFilters: Text;
        PrintTime: DateTime;

    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel('G/L Trail Balance', 'G/L Trail Balance', COMPANYNAME, USERID);
    end;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.AddColumn(COMPANYNAME, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('G/L Trail Balance', FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('G/L Trail Balance:' + ReportFilters, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Printing DateTime:' + FORMAT(CURRENTDATETIME), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
    end;
}

