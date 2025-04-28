report 50100 "Employee Trail Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/EmployeeTrailBalance.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(No_GLAccount; "No.")
            {
            }
            column(Name_GLAccount; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
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
            column(OpeningAmtDr; OpeningAmtDr)
            {
            }
            column(OpeningAmtCr; OpeningAmtCr)
            {
            }
            column(Sign; Sign)
            {
            }
            column(DebitAmt; DebitAmt)
            {
            }
            column(CreditAmt; CreditAmt)
            {
            }
            column(GETFILTERS; GETFILTERS)
            {
            }
            column(DebitBalance; DebitBalance)
            {
            }
            column(CreditBalance; CreditBalance)
            {
            }

            trigger OnAfterGetRecord()
            begin
                OpeningAmt := 0;
                OpeningAmtDr := 0;
                OpeningAmtCr := 0;

                GLEntry1.RESET;
                GLEntry1.SETRANGE("Employee Code", "No.");
                GLEntry1.SETFILTER("Posting Date", '%1..%2', 0D, FromDate - 1);
                IF GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    GLEntry1.SETFILTER("Global Dimension 1 Code", GETFILTER("Global Dimension 1 Filter"));
                IF GETFILTER("Global Dimension 2 Filter") <> '' THEN
                    GLEntry1.SETFILTER("Global Dimension 2 Code", GETFILTER("Global Dimension 2 Filter"));
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
                GLEntry.SETRANGE("Employee Code", "No.");
                GLEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                IF GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    GLEntry.SETFILTER("Global Dimension 1 Code", GETFILTER("Global Dimension 1 Filter"));
                IF GETFILTER("Global Dimension 2 Filter") <> '' THEN
                    GLEntry.SETFILTER("Global Dimension 2 Code", GETFILTER("Global Dimension 2 Filter"));
                IF GLEntry.FIND('-') THEN BEGIN
                    REPEAT
                        DebitAmt += GLEntry."Debit Amount";
                        CreditAmt += GLEntry."Credit Amount";
                        GLEntryAmt += GLEntry.Amount;
                    UNTIL GLEntry.NEXT = 0;
                END;


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

                IF IsPrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("First Name" + ' ' + "Middle Name" + ' ' + "Last Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(OpeningAmtDr, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(OpeningAmtCr, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(DebitAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(CreditAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(DebitBalance, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(CreditBalance, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    TotalValue[1] += OpeningAmtDr;
                    TotalValue[2] += OpeningAmtCr;
                    TotalValue[3] += DebitAmt;
                    TotalValue[4] += CreditAmt;
                    TotalValue[5] += DebitBalance;
                    TotalValue[6] += CreditBalance;
                END;
            end;

            trigger OnPostDataItem()
            begin
                IF IsPrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('Total', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
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
                    ExcelBuf.AddColumn('Employee No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Employee Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Opening Debit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Opening Credit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Transactional Debit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Transactional Credit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Closing Debit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Closing Credit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
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
        IF IsPrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        FromDate := Employee.GETRANGEMIN("Date Filter");
        ToDate := Employee.GETRANGEMAX("Date Filter");

        ReportFilters := Employee.GETFILTERS;
        ExcelBuf.DELETEALL;
        IF IsPrintToExcel THEN
            MakeExcelInfo;
    end;

    var
        OpeningAmt: Decimal;
        OpeningAmtDr: Decimal;
        OpeningAmtCr: Decimal;
        GLEntry1: Record "G/L Entry";
        FromDate: Date;
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        GLEntryAmt: Decimal;
        GLEntry: Record "G/L Entry";
        ToDate: Date;
        Sign: Text;
        DebitBalance: Decimal;
        CreditBalance: Decimal;
        CompInfo: Record "Company Information";
        IsPrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        ReportFilters: Text;
        TotalValue: array[10] of Decimal;


    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel('Employee Trail Balance', 'Employee Trail Balance', COMPANYNAME, USERID);
    end;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.AddColumn(COMPANYNAME, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Employee', FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Employee Trail Balance:' + ReportFilters, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Printing DateTime:' + FORMAT(CURRENTDATETIME), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
    end;
}

