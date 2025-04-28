report 50013 "Customer Ledger"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CustomerLedger.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Net Change (LCY)";
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(CName; CompInfo.Name + '  ' + CompInfo."Name 2")
            {
            }
            column(CAddress; CompInfo.Address + '  ' + CompInfo."Address 2" + ' , ' + CompInfo.City + ' - ' + CompInfo."Post Code")
            {
            }
            column(CPicture; CompInfo.Picture)
            {
            }
            column(FromDate; FORMAT(FromDate))
            {
            }
            column(ToDate; FORMAT(ToDate))
            {
            }
            column(CNo; Customer."No.")
            {
            }
            column(CustomerAddress1; CustomerAddress[1])
            {
            }
            column(CustomerAddress2; CustomerAddress[2])
            {
            }
            column(CustomerAddress3; CustomerAddress[3])
            {
            }
            column(CustomerAddress4; CustomerAddress[4])
            {
            }
            column(CustomerAddress5; CustomerAddress[5])
            {
            }
            column(CustomerAddress6; CustomerAddress[6])
            {
            }
            column(CustomerAddress7; CustomerAddress[7])
            {
            }
            column(CustomerAddress8; CustomerAddress[8])
            {
            }
            column(ConsolidateAddress; ConsolidateAddress)
            {
            }
            column(OpenAmt; ABS(OpeningAmt))
            {
            }
            column(OpenAmtDr; OpeningDr)
            {
            }
            column(OpenAmtCr; OpeningCr)
            {
            }
            column(Filters; Customer.GETFILTERS)
            {
            }
            column(ShowNarration; ShowNarration)
            {
            }
            column(Sign1; Sign1)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Debit Amount (LCY)", "Credit Amount (LCY)", "Amount (LCY)";
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Posting Date")
                                    ORDER(Ascending);
                column(PDate; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(DType; FORMAT("Cust. Ledger Entry"."Document Type"))
                {
                }
                column(DocNo; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(DrAmt; "Cust. Ledger Entry"."Debit Amount (LCY)")
                {
                }
                column(CrAmt; "Cust. Ledger Entry"."Credit Amount (LCY)")
                {
                }
                column(ExtDocNo; "External Document No.")
                {
                }
                column(Balance; ABS(Balance))
                {
                }
                column(Narration; Narration)
                {
                }
                column(Sign; Sign)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Balance := Balance + "Cust. Ledger Entry"."Amount (LCY)";

                    Sign := '';
                    IF Balance > 0 THEN
                        Sign := 'Dr'
                    ELSE
                        IF Balance < 0 THEN
                            Sign := 'Cr';

                    Narration := '';
                    Narration2 := '';
                    // PostedNarration.RESET;
                    // PostedNarration.SETRANGE(PostedNarration."Transaction No.","Transaction No.");
                    // PostedNarration.SETRANGE(PostedNarration."Document No.","Document No.");
                    // IF PostedNarration.FIND('-') THEN
                    //  REPEAT
                    //   IF  STRLEN(Narration +' '+ PostedNarration.Narration) <= 250 THEN
                    //       Narration := Narration+' '+PostedNarration.Narration;
                    //   IF  STRLEN(Narration)  >= 250 THEN
                    //     Narration2 := Narration2 +' '+PostedNarration.Narration;
                    //  UNTIL PostedNarration.NEXT=0;

                    TotalDebitAmount += "Debit Amount (LCY)";
                    TotalCreditAmount += "Credit Amount (LCY)";

                    //AD_REPL
                    IF IsPrintToExcel THEN BEGIN
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(FORMAT("Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(FORMAT("Cust. Ledger Entry"."Document Type"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn("Cust. Ledger Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn("External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn("Cust. Ledger Entry"."Debit Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn("Cust. Ledger Entry"."Credit Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(ABS(Balance), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(Narration, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(Narration2, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    END;
                    //AD_REPL
                end;

                trigger OnPostDataItem()
                begin
                    //AD_REPL
                    IF IsPrintToExcel THEN BEGIN
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('Closing Balance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(TotalDebitAmount + OpeningDr, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(TotalCreditAmount + OpeningCr, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(ABS(ABS(TotalDebitAmount + OpeningDr) - ABS(TotalCreditAmount + OpeningCr)), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.NewRow;
                    END;
                    //AD_REPL
                end;

                trigger OnPreDataItem()
                begin
                    Balance := OpeningAmt;
                    SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StateL.RESET;
                IF StateL.GET("State Code") THEN;

                CLEAR(CustomerAddress);
                CustomerAddress[1] := UPPERCASE("No.");
                CustomerAddress[2] := UPPERCASE(Name);
                CustomerAddress[3] := UPPERCASE(Address);
                CustomerAddress[4] := UPPERCASE("Address 2");
                CustomerAddress[5] := UPPERCASE(City);

                IF ("Post Code" <> '') AND (CustomerAddress[5] = '') THEN
                    CustomerAddress[5] := 'PIN: ' + "Post Code"
                ELSE
                    IF ("Post Code" <> '') THEN
                        CustomerAddress[5] := CustomerAddress[5] + ' - ' + "Post Code";

                IF "State Code" <> '' THEN
                    CustomerAddress[6] := StateL.Description;

                IF Customer."Phone No." <> '' THEN
                    CustomerAddress[7] := 'Ph. ' + Customer."Phone No.";

                IF Contact <> '' THEN BEGIN
                    CustomerAddress[8] := 'Kind Attn. ';
                    CustomerAddress[8] := CustomerAddress[8] + Contact;
                END;
                COMPRESSARRAY(CustomerAddress);

                ConsolidateAddress := '';
                IF CustomerAddress[1] <> '' THEN
                    ConsolidateAddress := CustomerAddress[1];
                IF CustomerAddress[2] <> '' THEN
                    ConsolidateAddress := ConsolidateAddress + NewLine + CustomerAddress[2];
                IF CustomerAddress[3] <> '' THEN
                    ConsolidateAddress := ConsolidateAddress + NewLine + CustomerAddress[3];
                IF CustomerAddress[4] <> '' THEN
                    ConsolidateAddress := ConsolidateAddress + NewLine + CustomerAddress[4];
                IF CustomerAddress[5] <> '' THEN
                    ConsolidateAddress := ConsolidateAddress + NewLine + CustomerAddress[5];
                IF CustomerAddress[6] <> '' THEN
                    ConsolidateAddress := ConsolidateAddress + NewLine + CustomerAddress[6];
                IF CustomerAddress[7] <> '' THEN
                    ConsolidateAddress := ConsolidateAddress + NewLine + CustomerAddress[7];
                IF CustomerAddress[8] <> '' THEN
                    ConsolidateAddress := ConsolidateAddress + NewLine + CustomerAddress[8];
                IF CustomerAddress[9] = '' THEN
                    ConsolidateAddress := ConsolidateAddress + NewLine + CustomerAddress[9];


                OpeningAmt := 0;
                OpeningDr := 0;
                OpeningCr := 0;
                Balance := 0;
                CustLedEntry.RESET;
                CustLedEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedEntry.SETFILTER("Posting Date", '%1..%2', 0D, FromDate - 1);
                IF Customer.GETFILTER(Customer."Global Dimension 1 Filter") <> '' THEN
                    CustLedEntry.SETFILTER("Global Dimension 1 Code", Customer.GETFILTER(Customer."Global Dimension 1 Filter"));
                IF Customer.GETFILTER(Customer."Global Dimension 2 Filter") <> '' THEN
                    CustLedEntry.SETFILTER("Global Dimension 2 Code", Customer.GETFILTER(Customer."Global Dimension 2 Filter"));
                IF CustLedEntry.FIND('-') THEN
                    REPEAT
                        CustLedEntry.CALCFIELDS("Amount (LCY)");
                        OpeningAmt += CustLedEntry."Amount (LCY)";
                    UNTIL CustLedEntry.NEXT = 0;

                Sign1 := '';
                IF OpeningAmt < 0 THEN
                    Sign1 := 'Cr'
                ELSE
                    IF OpeningAmt > 0 THEN
                        Sign1 := 'Dr';

                IF OpeningAmt > 0 THEN
                    OpeningDr := OpeningAmt
                ELSE
                    IF OpeningAmt < 0 THEN
                        OpeningCr := ABS(OpeningAmt);


                Check1 := FALSE;
                CustLedEntry.RESET;
                CustLedEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                CustLedEntry.SETFILTER("Global Dimension 1 Code", Customer.GETFILTER(Customer."Global Dimension 1 Filter"));
                CustLedEntry.SETFILTER("Global Dimension 2 Code", Customer.GETFILTER(Customer."Global Dimension 2 Filter"));
                IF NOT CustLedEntry.FIND('-') THEN
                    Check1 := TRUE;
                //AD_REPL
                IF IsPrintToExcel THEN BEGIN
                    TotalDebitAmount := 0;
                    TotalCreditAmount := 0;

                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn(Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Document Type', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Invoice No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Party Order No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Debit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Credit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Balance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Narrartion/Coments', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Narrartion/Coments 2', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Opening Balance', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(OpeningDr, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(OpeningCr, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ABS(OpeningDr - OpeningCr), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.NewRow;
                END;
                //AD_REPL

                IF (Check1 = TRUE) AND (OpeningAmt = 0) THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                //SETFILTER("Date Filter",'%1..%2',0D,FromDate-1);
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
                    field("Show Narration"; ShowNarration)
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

        trigger OnOpenPage()
        begin
            ShowNarration := TRUE;
        end;
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

        Char13 := 13;
        Char10 := 10;
        NewLine := FORMAT(Char13) + FORMAT(Char10);

        FromDate := Customer.GETRANGEMIN("Date Filter");
        ToDate := Customer.GETRANGEMAX("Date Filter");

        //AD_REPL
        ReportFilters := FORMAT(FromDate) + 'to' + FORMAT(ToDate);
        IF IsPrintToExcel THEN
            MakeExcelInfo;
        //AD_REPL
    end;

    var
        FromDate: Date;
        ToDate: Date;
        OpeningAmt: Decimal;
        OpeningDr: Decimal;
        OpeningCr: Decimal;
        CustomerAddress: array[10] of Text[100];
        ConsolidateAddress: Text[1024];
        StateL: Record State;
        Char13: Char;
        Char10: Char;
        NewLine: Text;
        Balance: Decimal;
        Check1: Boolean;
        CustLedEntry: Record "Cust. Ledger Entry";
        CompInfo: Record "Company Information";
        Narration: Text[1024];
        //PostedNarration: Record "Posted Narration";
        ShowNarration: Boolean;
        Sign1: Text[10];
        Sign: Text[10];
        Cust: Record Customer;
        OpeningAmt1: Decimal;
        ExcelBuf: Record "Excel Buffer" temporary;
        ReportFilters: Text;
        IsPrintToExcel: Boolean;
        TotalDebitAmount: Decimal;
        TotalCreditAmount: Decimal;
        Narration2: Text;

    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBook('Cust. Ledger Report','Cust. Ledger Report',COMPANYNAME,USERID);
        //ERROR('');
    end;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.AddColumn(COMPANYNAME, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Report Name: Cust. Ledger Report', FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(ReportFilters, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Print Time: ' + FORMAT(CURRENTDATETIME), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
    end;
}

