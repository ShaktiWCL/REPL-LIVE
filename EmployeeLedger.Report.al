report 50109 "Employee Ledger"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/EmployeeLedger.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(OpeningAmt; OpeningAmt)
            {
            }
            column(ClosingAmt; ClosingAmt)
            {
            }
            column(EmployeeCode_GLEntry; Employee."No.")
            {
            }
            column(EmpName; Employee."First Name")
            {
            }
            column(OpeningAmtDr; OpeningAmtDr)
            {
            }
            column(OpeningAmtCr; OpeningAmtCr)
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemTableView = SORTING("Posting Date");
                column(CName; CompInfo.Name + '  ' + CompInfo."Name 2")
                {
                }
                column(CAddress; CompInfo.Address + '  ' + CompInfo."Address 2" + ' , ' + CompInfo.City + ' - ' + CompInfo."Post Code")
                {
                }
                column(CPicture; CompInfo.Picture)
                {
                }
                column(Amount_GLEntry; "G/L Entry".Amount)
                {
                }
                column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
                {
                }
                column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
                {
                }
                column(DebitAmount_GLEntry; "G/L Entry"."Debit Amount")
                {
                }
                column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
                {
                }
                column(Sign; Sign)
                {
                }
                column(Sign1; Sign1)
                {
                }
                column(Filters; "G/L Entry".GETFILTERS)
                {
                }
                column(NarrationText; Narration)
                {
                }
                column(NarrationText1; Narration1)
                {
                }
                column(External_Document; "G/L Entry"."External Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF GLAccountNo = '' THEN BEGIN
                        ClosingAmt := ClosingAmt + "G/L Entry".Amount;

                        Sign := '';
                        IF ClosingAmt > 0 THEN
                            Sign := 'Dr'
                        ELSE
                            IF ClosingAmt < 0 THEN
                                Sign := 'Cr';

                        Narration := '';

                        // PostedNarration.RESET;
                        // PostedNarration.SETRANGE(PostedNarration."Transaction No.", "Transaction No.");
                        // PostedNarration.SETRANGE(PostedNarration."Document No.", "Document No.");
                        // IF PostedNarration.FIND('-') THEN
                        //     REPEAT
                        //         Narration += PostedNarration.Narration;
                        //     UNTIL PostedNarration.NEXT = 0;

                        PurchComLine.RESET;
                        PurchComLine.SETRANGE(PurchComLine."Document Type", PurchComLine."Document Type"::"Posted Invoice");
                        PurchComLine.SETRANGE(PurchComLine."No.", "Document No.");
                        IF PurchComLine.FIND('-') THEN
                            REPEAT
                                Narration += PurchComLine.Comment;
                            UNTIL PurchComLine.NEXT = 0;

                        CountValue := STRLEN(Narration);
                        IF CountValue >= 250 THEN
                            Narration := COPYSTR(Narration, 1, 250);


                        IF IsPrintToExcel AND IsDetailRequired THEN BEGIN
                            ExcelBuf.AddColumn("G/L Entry"."Employee Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(Employee."First Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn("G/L Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn("G/L Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn("G/L Entry"."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn("G/L Entry"."Debit Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn("G/L Entry"."Credit Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(ClosingAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(Narration, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.NewRow;
                        END;
                        TotalDebitAmount += "G/L Entry"."Debit Amount";
                        TotalCreditAmount += "G/L Entry"."Credit Amount";
                    END ELSE BEGIN
                        GLEntry1.RESET;
                        GLEntry1.SETCURRENTKEY("Employee Code", "Document No.");
                        GLEntry1.SETRANGE("Employee Code", Employee."No.");
                        GLEntry1.SETRANGE("Document No.", "Document No.");
                        IF GLEntry1.FINDFIRST THEN BEGIN

                            ClosingAmt := ClosingAmt + Amount;

                            Sign := '';
                            IF ClosingAmt > 0 THEN
                                Sign := 'Dr'
                            ELSE
                                IF ClosingAmt < 0 THEN
                                    Sign := 'Cr';

                            Narration := '';

                            // PostedNarration.RESET;
                            // PostedNarration.SETRANGE(PostedNarration."Transaction No.", GLEntry1."Transaction No.");
                            // PostedNarration.SETRANGE(PostedNarration."Document No.", GLEntry1."Document No.");
                            // IF PostedNarration.FIND('-') THEN
                            //     REPEAT
                            //         Narration += PostedNarration.Narration;
                            //     UNTIL PostedNarration.NEXT = 0;

                            PurchComLine.RESET;
                            PurchComLine.SETRANGE(PurchComLine."Document Type", PurchComLine."Document Type"::"Posted Invoice");
                            PurchComLine.SETRANGE(PurchComLine."No.", GLEntry1."Document No.");
                            IF PurchComLine.FIND('-') THEN
                                REPEAT
                                    Narration += PurchComLine.Comment;
                                UNTIL PurchComLine.NEXT = 0;

                            CountValue := STRLEN(Narration);
                            IF CountValue >= 250 THEN
                                Narration := COPYSTR(Narration, 1, 250);

                            IF IsPrintToExcel AND IsDetailRequired THEN BEGIN
                                ExcelBuf.AddColumn(Employee."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                ExcelBuf.AddColumn(Employee."First Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                ExcelBuf.AddColumn(GLEntry1."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                ExcelBuf.AddColumn(GLEntry1."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                ExcelBuf.AddColumn(GLEntry1."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                ExcelBuf.AddColumn("Debit Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                ExcelBuf.AddColumn("Credit Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                ExcelBuf.AddColumn(ClosingAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                ExcelBuf.AddColumn(Narration, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                ExcelBuf.NewRow;
                            END;
                            TotalDebitAmount += "Debit Amount";
                            TotalCreditAmount += "Credit Amount";
                        END ELSE
                            CurrReport.SKIP;
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    IF IsPrintToExcel AND IsDetailRequired THEN BEGIN
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('Closing Balance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(TotalDebitAmount, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(TotalCreditAmount, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(ClosingAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.NewRow;
                    END;

                    IF NOT IsDetailRequired THEN BEGIN
                        IF (TotalDebitAmount = 0) AND (TotalCreditAmount = 0) THEN
                            CurrReport.SKIP;
                    END;

                    IF IsPrintToExcel AND (NOT IsDetailRequired) THEN BEGIN
                        ExcelBuf.AddColumn(Employee."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(Employee."First Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(TotalDebitAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(TotalCreditAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(ClosingAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.NewRow;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", StartDate, EndDate);
                    IF GLAccountNo = '' THEN
                        SETRANGE("Employee Code", Employee."No.")
                    ELSE
                        SETRANGE("G/L Account No.", GLAccountNo);

                    ClosingAmt := OpeningAmt;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                OpeningAmt := 0;
                OpeningAmtDr := 0;
                OpeningAmtCr := 0;
                ClosingAmt := 0;
                TotalDebitAmount := 0;
                TotalCreditAmount := 0;

                IF GLAccountNo = '' THEN BEGIN
                    GLEntry.RESET;
                    GLEntry.SETRANGE("Employee Code", "No.");
                    GLEntry.SETRANGE("Posting Date", 0D, StartDate - 1);
                    IF GLEntry.FINDSET THEN BEGIN
                        REPEAT
                            OpeningAmt += GLEntry.Amount;
                        UNTIL GLEntry.NEXT = 0;
                    END;
                END ELSE BEGIN
                    GLEntry.RESET;
                    GLEntry.SETRANGE("G/L Account No.", GLAccountNo);
                    GLEntry.SETRANGE("Posting Date", 0D, StartDate - 1);
                    IF GLEntry.FINDSET THEN BEGIN
                        REPEAT
                            GLEntry1.RESET;
                            GLEntry1.SETRANGE("Employee Code", "No.");
                            GLEntry1.SETRANGE("Document No.", GLEntry."Document No.");
                            IF GLEntry1.FINDFIRST THEN
                                OpeningAmt += GLEntry1.Amount;
                        UNTIL GLEntry.NEXT = 0;
                    END;
                END;

                Sign1 := '';
                IF OpeningAmt < 0 THEN
                    Sign1 := 'Cr'
                ELSE
                    IF OpeningAmt > 0 THEN
                        Sign1 := 'Dr';

                IF OpeningAmt > 0 THEN
                    OpeningAmtDr := OpeningAmt
                ELSE
                    IF OpeningAmt < 0 THEN
                        OpeningAmtCr := ABS(OpeningAmt);

                IF IsPrintToExcel AND IsDetailRequired THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('Employee', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Employee Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Document No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('External Document No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Debit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Credit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Closing Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Narrartion/Coments', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn(Employee."No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(Employee."First Name", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Opening Balance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(OpeningAmtDr, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(OpeningAmtCr, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(OpeningAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(CompInfo.Picture);

                IF IsPrintToExcel AND (NOT IsDetailRequired) THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('Employee', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Employee Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Debit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Credit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Closing Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                END;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                }
                field("End Date"; EndDate)
                {
                }
                field("G/L Account No."; GLAccountNo)
                {
                    TableRelation = "G/L Account";
                }
                field("Print To Excel"; IsPrintToExcel)
                {
                    Caption = 'Print To Excel';
                }
                field(IsDetailRequired; IsDetailRequired)
                {
                    Caption = ' With Detail';
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
        //AD_REPL
        ReportFilters := 'Date Filter: ' + FORMAT(StartDate) + ' to ' + FORMAT(EndDate);
        IF IsPrintToExcel THEN
            MakeExcelInfo;
        //AD_REPL
    end;

    var
        StartDate: Date;
        EndDate: Date;
        GLEntry: Record "G/L Entry";
        OpeningAmt: Decimal;
        ClosingAmt: Decimal;
        OpeningAmtDr: Decimal;
        OpeningAmtCr: Decimal;
        Sign: Text;
        Sign1: Text;
        CompInfo: Record "Company Information";
        Narration: Text;
        //PostedNarration: Record "16548";
        Narration1: Text;
        PurchComLine: Record "Purch. Comment Line";
        ExcelBuf: Record "Excel Buffer" temporary;
        ReportFilters: Text;
        IsPrintToExcel: Boolean;
        TotalDebitAmount: Decimal;
        TotalCreditAmount: Decimal;
        GLAccountNo: Code[20];
        GLEntry1: Record "G/L Entry";
        CountValue: Integer;
        IsDetailRequired: Boolean;

    procedure NotUseFunction()
    begin
        //Narration:='';
        //PostedNarration.RESET;
        //PostedNarration.SETRANGE(PostedNarration."Transaction No.","Transaction No.");
        //PostedNarration.SETRANGE(PostedNarration."Document No.","Document No.");
        //PostedNarration.SETRANGE(PostedNarration."Entry No.","Entry No.");
        //IF PostedNarration.FIND('-') THEN
        // REPEAT
        //  IF  STRLEN(Narration+' '+PostedNarration.Narration) < 1024 THEN
        //      Narration:= Narration +' '+PostedNarration.Narration;
        // UNTIL PostedNarration.NEXT=0;


        //Narration1:='';
        //PurchComLine.RESET;
        //PurchComLine.SETRANGE(PurchComLine."Document Type",PurchComLine."Document Type"::"Posted Invoice");
        //PurchComLine.SETRANGE(PurchComLine."No.","Document No.");
        //IF PurchComLine.FIND('-') THEN
        // REPEAT
        //  IF  STRLEN(Narration1+' '+PurchComLine.Comment) < 1024 THEN
        //      Narration1:=Narration1+' '+PurchComLine.Comment;
        // UNTIL PurchComLine.NEXT=0;
    end;


    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel('Employee Ledger', 'Employee Ledger', COMPANYNAME, USERID);
        ERROR('');
    end;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.AddColumn(COMPANYNAME, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Report Name: Employee Ledger', FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(ReportFilters, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Print Time: ' + FORMAT(CURRENTDATETIME), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
    end;
}

