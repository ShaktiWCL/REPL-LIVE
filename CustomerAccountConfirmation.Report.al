report 50131 "Customer Account Confirmation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CustomerAccountConfirmation.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");
            RequestFilterFields = "Customer No.", "Posting Date";
            column(CompInf_Name; CompanyNameText)
            {
            }
            column(CompInf_Address; CompInf.Address)
            {
            }
            column(CompInf_Address2; CompInf."Address 2")
            {
            }
            column(CompInf_City; CompInf.City)
            {
            }
            column(CompInf_PostCode; CompInf."Post Code")
            {
            }
            column(CompInf_PANNo; CompInf."P.A.N. No.")
            {
            }
            column(CompInf_TANNo; CompInf."T.A.N. No.")
            {
            }
            column(GetVendor_Name; GetVendor.Name)
            {
            }
            column(GetVendor_Address; GetVendor.Address)
            {
            }
            column(GetVendor_Address2; GetVendor."Address 2")
            {
            }
            column(GetVendor_City; GetVendor.City)
            {
            }
            column(GetVendor_PANNo; GetVendor."P.A.N. No.")
            {
            }
            column(Vend_Ledger_Entry_Vendor_No_; "Customer No.")
            {
            }
            column(Vend_Ledger_Entry_Posting_Date_; FORMAT("Posting Date"))
            {
            }
            column(Vend_Ledger_Entry_Document_No_; "Document No.")
            {
            }
            column(Vend_Ledger_Entry_Description; Description + ' - ' + "External Document No.")
            {
            }
            column(Vend_Ledger_Entry_Credit_Amount; ROUND("Credit Amount (LCY)", 0.01))
            {
            }
            column(Vend_Ledger_Entry_Debit_Amount; ROUND("Debit Amount (LCY)", 0.01))
            {
            }
            column(Vendor_Ledger_Entry_Amount; "Amount (LCY)")
            {
            }
            column(Vend_Ledger_Entry_Document_Type; "Document Type")
            {
            }
            column(Ledger_Account_Cap; LedgerAccountCap)
            {
            }
            column(Date_Cap; DateCap)
            {
            }
            column(Particulars_Cap; ParticularsCap)
            {
            }
            column(Vch_Type_Cap; VchTypeCap)
            {
            }
            column(VchNo_ExciseInvNo_Cap; VchNoExciseInvNoCap)
            {
            }
            column(Debit_Cap; DebitCap)
            {
            }
            column(Credit_Cap; CreditCap)
            {
            }
            column(Opening_Bal_Cap; OpeningBalCap)
            {
            }
            column(Closing_Bal_Cap; ClosingBalCap)
            {
            }
            column(RunningBalance_Cap; RunningBalanceCap)
            {
            }
            column(Debit_Credit; DebitCredit)
            {
            }
            column(Opening_Balance; ROUND(OpeningBalance, 0.01))
            {
            }
            column(Date_Text; DateText)
            {
            }
            column(Closing_Balance_Dr; ROUND(ABS(ClosingBalanceDr), 0.01))
            {
            }
            column(Closing_Balance_Cr; ROUND(ABS(ClosingBalanceCr), 0.01))
            {
            }
            column(TotalBalance_Dr; ROUND(ABS(TotalBalanceDr), 0.01))
            {
            }
            column(TotalBalance_Cr; ROUND(ABS(TotalBalanceCr), 0.01))
            {
            }
            column(RunningBalance; RunningBalance)
            {
            }
            column(DebitAmountForRun; DebitAmountForRun)
            {
            }
            column(CreditAmountForRun; CreditAmountForRun)
            {
            }
            column(TxtNarration; TxtNarration)
            {
            }
            column(Heading1_Cap; Heading1Cap)
            {
            }
            column(Heading2_Cap; Heading2Cap)
            {
            }
            column(Heading3_Cap; Heading3Cap)
            {
            }
            column(AuthorizedSig_Cap; AuthorizedSigCap)
            {
            }
            column(PAN_Cap; PANCap)
            {
            }
            column(For_Cap; ForCap)
            {
            }
            column(From_Cap; FromCap)
            {
            }
            column(To_Cap; ToCap)
            {
            }
            column(DearSir_Cap; DearSirCap)
            {
            }
            column(AmountInWords_1; AmountInWords[1])
            {
            }
            column(AmountInWords_2; AmountInWords[2])
            {
            }
            column(TAN_Cap; TANCap)
            {
            }
            column(GST_Cap; GSTCap)
            {
            }
            column(Comments_Store; CommentsStore)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF CompInf."New Name Date" <> 0D THEN BEGIN
                    IF EndDate >= CompInf."New Name Date" THEN
                        CompanyNameText := CompInf.Name
                    ELSE
                        CompanyNameText := CompInf."Old Name";
                END ELSE
                    CompanyNameText := CompInf.Name;

                IF (CompInf."New Name Date" >= StartDate) AND (CompInf."New Name Date" <= EndDate) THEN
                    CommentsStore := CommentsCap
                ELSE
                    CommentsStore := '';

                GetVendor.GET("Customer No.");
                CALCFIELDS("Debit Amount (LCY)");
                CALCFIELDS("Credit Amount (LCY)");

                IF "Customer No." <> TempVendNo THEN BEGIN
                    OpeningBalance := 0;
                    VendLedgEntry.RESET;
                    VendLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                    VendLedgEntry.SETRANGE("Customer No.", "Customer No.");
                    VendLedgEntry.SETFILTER("Posting Date", '%1..%2', 0D, StartDate - 1);
                    IF VendLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            VendLedgEntry.CALCFIELDS("Amount (LCY)");
                            OpeningBalance += VendLedgEntry."Amount (LCY)";
                        UNTIL VendLedgEntry.NEXT = 0;
                    END;
                    ClosingBalance := 0;
                    VendLedgEntry.RESET;
                    VendLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                    VendLedgEntry.SETRANGE("Customer No.", "Customer No.");
                    VendLedgEntry.SETFILTER("Posting Date", '%1..%2', 0D, EndDate);
                    IF VendLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            VendLedgEntry.CALCFIELDS("Amount (LCY)");
                            ClosingBalance += VendLedgEntry."Amount (LCY)";
                        UNTIL VendLedgEntry.NEXT = 0;
                    END;
                    TotalDr := 0;
                    TotalCr := 0;
                    DebitAmountForRun := 0;
                    CreditAmountForRun := 0;
                    RunningBalance := 0;
                    VendLedgEntry.RESET;
                    VendLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                    VendLedgEntry.SETRANGE("Customer No.", "Customer No.");
                    VendLedgEntry.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                    IF VendLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            VendLedgEntry.CALCFIELDS("Debit Amount (LCY)");
                            VendLedgEntry.CALCFIELDS("Credit Amount (LCY)");
                            TotalDr += VendLedgEntry."Debit Amount (LCY)";
                            TotalCr += VendLedgEntry."Credit Amount (LCY)";
                        UNTIL VendLedgEntry.NEXT = 0;
                    END;
                END;
                TempVendNo := "Customer No.";

                DebitCredit := '';

                IF "Debit Amount (LCY)" <> 0 THEN
                    DebitCredit := 'Dr';

                IF "Credit Amount (LCY)" <> 0 THEN
                    DebitCredit := 'Cr';

                IF ClosingBalance > 0 THEN
                    ClosingBalanceDr := ClosingBalance
                ELSE
                    ClosingBalanceDr := 0;

                IF ClosingBalance < 0 THEN
                    ClosingBalanceCr := ClosingBalance
                ELSE
                    ClosingBalanceCr := 0;


                IF OpeningBalance > 0 THEN
                    OpeningBalanceDr := OpeningBalance
                ELSE
                    OpeningBalanceDr := 0;

                IF OpeningBalance < 0 THEN
                    OpeningBalanceCr := OpeningBalance
                ELSE
                    OpeningBalanceCr := 0;


                IF ClosingBalanceCr <> 0 THEN
                    TotalBalanceDr := ABS(ClosingBalanceCr) + TotalDr
                ELSE
                    TotalBalanceDr := ABS(OpeningBalanceDr) + TotalDr;

                IF ClosingBalanceDr <> 0 THEN
                    TotalBalanceCr := ABS(ClosingBalanceDr) + TotalCr
                ELSE
                    TotalBalanceCr := ABS(OpeningBalanceCr) + TotalCr;


                DebitAmountForRun += "Debit Amount (LCY)";
                CreditAmountForRun += "Credit Amount (LCY)";

                RunningBalance := OpeningBalance + DebitAmountForRun - CreditAmountForRun;

                ReportCheck.InitTextVariable;
                ReportCheck.FormatNoText(AmountInWords, ROUND(ABS(RunningBalance), 0.01, '='), '');

                //AD Start
                TxtNarration := '';
                TempLine := 0;
                // PostedNarration.RESET;
                // PostedNarration.SETRANGE("Document No.", "Document No.");
                // IF PostedNarration.FINDSET THEN BEGIN
                //     REPEAT
                //         IF TempLine <> PostedNarration."Line No." THEN
                //             TxtNarration += PostedNarration.Narration;
                //         TempLine := PostedNarration."Line No.";
                //     UNTIL PostedNarration.NEXT = 0;
                // END;
                //AD End
            end;

            trigger OnPreDataItem()
            begin
                CompInf.GET;
                StartDate := GETRANGEMIN("Posting Date");
                EndDate := GETRANGEMAX("Posting Date");
                DateText := FORMAT(StartDate, 0, 4) + ' to ' + FORMAT(EndDate, 0, 4);
                TempVendNo := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompInf: Record "Company Information";
        LedgerAccountCap: Label 'Account Confirmation';
        DateCap: Label 'Date';
        ParticularsCap: Label 'Particulars';
        VchTypeCap: Label 'Vch Type';
        VchNoExciseInvNoCap: Label 'Document No.';
        DebitCap: Label 'Debit';
        CreditCap: Label 'Credit';
        OpeningBalCap: Label 'Opening Balance';
        ClosingBalCap: Label 'Closing Balance';
        StartDate: Date;
        EndDate: Date;
        VendLedgEntry: Record "Cust. Ledger Entry";
        GetVendor: Record Customer;
        OpeningBalance: Decimal;
        TempVendNo: Code[20];
        DebitCredit: Text[2];
        DateText: Text;
        ClosingBalanceDr: Decimal;
        ClosingBalanceCr: Decimal;
        ClosingBalance: Decimal;
        TotalBalanceDr: Decimal;
        TotalBalanceCr: Decimal;
        TotalDr: Decimal;
        TotalCr: Decimal;
        OpeningBalanceCr: Decimal;
        OpeningBalanceDr: Decimal;
        RunningBalanceCap: Label 'Running Bal.';
        RunningBalance: Decimal;
        DebitAmountForRun: Decimal;
        CreditAmountForRun: Decimal;
        TxtNarration: Text;
        TempLine: Integer;
        //PostedNarration: Record "16548";
        Heading1Cap: Label 'This is to confirm that we had the following transaction with you from ';
        Heading2Cap: Label '.Kindly confirm by returning the copies of the statement duly sealed and signed by you mentioning your I.T. Permanent A/c No. If we do not receive your confirmation within 15 days from the date of letter. We would consider the balance appearing in our books of account as final. Your prompt response to this request will be highly appreciated. Thanking for your support ';
        Heading3Cap: Label 'We confirm the transaction shown above and the balance of Rs.';
        AuthorizedSigCap: Label 'Authorized Signatory';
        PANCap: Label 'PAN No.:';
        ForCap: Label 'For';
        FromCap: Label 'From';
        ToCap: Label 'To';
        DearSirCap: Label 'Dear Sir/Madam';
        ReportCheck: Report Check;
        AmountInWords: array[2] of Text[80];
        TANCap: Label 'TAN No.';
        GSTCap: Label 'GST No.';
        CompanyNameText: Text;
        CommentsCap: Label '*Company has been listed on 3rd Nov. 2017';
        CommentsStore: Text;
}

