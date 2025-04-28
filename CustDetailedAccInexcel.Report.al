report 50103 "Cust. Detailed Acc. (In excel)"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            dataitem(Cust_Ledger_Entry_Dr; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code")
                                where(Amount = filter(> 0),
                                          "Document No." = filter(<> 'OPENINGREPL'));

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("Remaining Amt. (LCY)");
                    CALCFIELDS("Amount (LCY)");
                    ClearVariables;

                    InvoiceStatusFunction;
                    InvoiceTypeFunction;

                    ApplicationEnties;
                    ProjectDetail;
                    CreateBodyDr;

                    TotalAmount[1] += "Amount (LCY)";
                    TotalAmount[2] += ReceiptPaidAmount;
                    TotalAmount[3] += "Remaining Amt. (LCY)";
                    TotalAmount[4] += OtherPaidAmount;
                end;

                trigger OnPreDataItem()
                begin
                    //SETFILTER("Document No.",'%1|%2','CURECT/000506/2012','CDIMISC/00425/2012');
                end;
            }
            dataitem(Cust_Ledger_Entry_OV; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code")
                                where("Document No." = filter('OPENINGREPL'));

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("Remaining Amt. (LCY)");
                    CALCFIELDS("Amount (LCY)");
                    ClearVariables;


                    CreateBodyNOV;

                    TotalAmount[1] += "Amount (LCY)";
                    TotalAmount[2] += ReceiptPaidAmount;
                    TotalAmount[3] += "Remaining Amt. (LCY)";
                    TotalAmount[4] += OtherPaidAmount;
                end;

                trigger OnPreDataItem()
                begin
                    //SETFILTER("Document No.",'%1|%2','CURECT/000506/2012','CDIMISC/00425/2012');
                end;
            }
            dataitem(Cust_Ledger_Entry_Cr; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code")
                                    where(Amount = filter(< 0));

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("Remaining Amt. (LCY)");
                    CALCFIELDS("Amount (LCY)");
                    ClearVariables;

                    UnApplicationEnties;
                    CreateBodyCr;

                    TotalAmount[2] += ReceiptPaidAmount;
                    TotalAmount[3] += "Remaining Amt. (LCY)";
                    TotalAmount[4] += OtherPaidAmount;
                end;

                trigger OnPreDataItem()
                begin
                    //SETFILTER("Document No.",'%1|%2','CURECT/000506/2012','CDIMISC/00425/2012');
                end;
            }
            dataitem(Footer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));

                trigger OnAfterGetRecord()
                begin
                    CreateFooter;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(TotalAmount);
                CreateHeader;
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

    trigger OnPostReport()
    begin
        IF IsPrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        IsPrintToExcel := TRUE;
        ReportFilters := Customer.GETFILTERS;

        ExcelBuf.DELETEALL;
        IF IsPrintToExcel THEN
            MakeExcelInfo;
    end;

    var
        COMPANYCODECap: Label 'COMPANY CODE';
        CUSTOMERCODECap: Label 'CUSTOMER CODE';
        CUSTOMERNAMECap: Label 'CUSTOMER NAME';
        FINANCEBOOKCap: Label 'FINANCE BOOK';
        INVOICETYPECap: Label 'INVOICE TYPE';
        INVOICENOCap: Label 'INVOICE NO';
        INVOICEDATECap: Label 'INVOICE DATE';
        INVOICESTATUSCap: Label 'INVOICE STATUS';
        INVOICEAMOUNTCap: Label 'INVOICE AMOUNT';
        RECEIPTAMOUNTCap: Label 'RECEIPT AMOUNT';
        OUTSTANDINGCap: Label 'OUTSTANDING';
        CREDITAMOUNTCap: Label 'CREDIT AMOUNT';
        RECEIPTNOCap: Label 'RECEIPT NO';
        RECEIPTDATECap: Label 'RECEIPT DATE';
        RECEIPTADJUSTMENTDATECap: Label 'RECEIPT ADJUSTMENT DATE';
        RECEIPTNOCap1: Label 'RECEIPT NO 2';
        RECEIPTDATECap1: Label 'RECEIPT DATE 2';
        RECEIPTADJUSTMENTDATECap1: Label 'RECEIPT ADJUSTMENT DATE 2';
        CREDITNOTECap: Label 'OTHER DOCUMENTS NO.';
        CREDITNOTEDATECap: Label 'OTHER DOCUMENT DATE';
        CREDITNOTEADJUSTDATECap: Label 'OTHER DOCUMENT ADJUSTMENT DATE';
        CREDITNOTECap1: Label 'OTHER DOCUMENTS NO. 2';
        CREDITNOTEDATECap1: Label 'OTHER DOCUMENT DATE 2';
        CREDITNOTEADJUSTDATECap1: Label 'OTHER DOCUMENT ADJUSTMENT DATE 2';
        MANAGERCap: Label 'MANAGER';
        PROJECTSTATUSCap: Label 'PROJECT STATUS';
        PROJECTCODECap: Label 'PROJECT CODE';
        PROJECTNAMECap: Label 'PROJECT NAME';
        PROJECTCREATEDDATECap: Label 'PROJECT CREATED DATE';
        CHEQUENOCap: Label 'CHEQUE NO';
        REMARKSCap: Label 'REMARKS';
        PRJOUDESCCap: Label 'PRJ OU DESC';
        BANKCap: Label 'BANK';
        BANKAccountNoCap: Label 'BANK Account No';
        TAXAMOUNTTDSCap: Label 'TAX AMOUNT TDS';
        ServiceTaxCap: Label 'Service Tax';
        UNADJUSTEDAMOUNTCap: Label 'UN ADJUSTED AMOUNT';
        IsPrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        SalesInvHeader: Record "Sales Invoice Header";
        CustLedgEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        GetProject: Record Job;
        BankAccLdgEntry: Record "Bank Account Ledger Entry";
        BankAccount: Record "Bank Account";
        InvoiceStatus: Option " ","Fully Adjusted","Partialy Adjusted",Authorized;
        InvoiceType: Option " ","Customer Invoice","Debit Note","Customer Payment","Transfer Credit Note";
        ReceiptPaidAmount: Decimal;
        OtherPaidAmount: Decimal;
        TotalAmount: array[4] of Decimal;
        ReportFilters: Text;
        RcptNo: Text;
        RcptDate: Text;
        AdjustmentDate: Text;
        OtherNo: Text;
        OtherDate: Text;
        OtherAdjDate: Text;
        RcptNo1: Text;
        RcptDate1: Text;
        AdjustmentDate1: Text;
        OtherNo1: Text;
        OtherDate1: Text;
        OtherAdjDate1: Text;
        TempRcptNo: Text;
        TempRcptDate: Text;
        TempAdjustmentDate: Text;
        TempOtherNo: Text;
        TempOtherDate: Text;
        TempOtherAdjDate: Text;
        ProjectInfo: array[10] of Text;
        BankInfo: array[2] of Text;
        CountValue1: Integer;
        CountValue2: Integer;
        CountValue3: Integer;
        CountValue4: Integer;
        CountValue5: Integer;
        CountValue6: Integer;
        TOTALCap: Label 'TOTAL';
        ChecqueNo: Code[20];
        ExcelFileName: Label 'CustomerDetailedAccount_%1_%2';

    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook('Cust. Detailed Acc. (In excel)');
        ExcelBuf.WriteSheet('Cust. Detailed Acc. (In excel)', COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
        //ExcelBuf.CreateBookAndOpenExcel('Cust. Detailed Acc. (In excel)', 'Cust. Detailed Acc. (In excel)', COMPANYNAME, USERID);

    end;


    procedure MakeExcelInfo()
    begin
        ExcelBuf.AddColumn(COMPANYNAME, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Cust. Detailed Acc. (In excel)', FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Cust. Detailed Acc. (In excel):' + ReportFilters, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Printing DateTime:' + FORMAT(CURRENTDATETIME), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
    end;


    procedure ApplicationEnties()
    begin
        //Condition 1
        DetailedCustLedgEntry.RESET;
        DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
        DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", Cust_Ledger_Entry_Dr."Entry No.");
        DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
        DetailedCustLedgEntry.SETRANGE(Unapplied, FALSE);
        //DetailedCustLedgEntry.SETFILTER("Initial Document Type",'%1',DetailedCustLedgEntry."Initial Document Type" :: Invoice);
        IF DetailedCustLedgEntry.FINDSET THEN BEGIN
            REPEAT
                CustLedgEntry.RESET;
                CustLedgEntry.SETRANGE("Document No.", DetailedCustLedgEntry."Document No.");
                CustLedgEntry.SETFILTER("Source Code", '%1', 'BANKRCPTV');
                IF CustLedgEntry.FINDFIRST THEN
                    ReceiptPaidAmount += -(DetailedCustLedgEntry."Amount (LCY)")
                ELSE
                    OtherPaidAmount += -(DetailedCustLedgEntry."Amount (LCY)");
            UNTIL DetailedCustLedgEntry.NEXT = 0;
        END;
        //Condition 1

        //Condition 2
        DetailedCustLedgEntry.RESET;
        DetailedCustLedgEntry.SETCURRENTKEY("Document No.");
        DetailedCustLedgEntry.SETRANGE("Document No.", Cust_Ledger_Entry_Dr."Document No.");
        DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
        DetailedCustLedgEntry.SETRANGE(Unapplied, FALSE);
        //DetailedCustLedgEntry.SETFILTER("Document Type",'%1',DetailedCustLedgEntry."Document Type" :: Invoice);
        IF DetailedCustLedgEntry.FINDSET THEN BEGIN
            REPEAT
                CustLedgEntry.GET(DetailedCustLedgEntry."Cust. Ledger Entry No.");
                IF CustLedgEntry."Source Code" = 'BANKRCPTV' THEN
                    ReceiptPaidAmount += (DetailedCustLedgEntry."Amount (LCY)")
                ELSE
                    OtherPaidAmount += (DetailedCustLedgEntry."Amount (LCY)");
            UNTIL DetailedCustLedgEntry.NEXT = 0;
        END;
        //Condition 2

        //Condition 1
        DetailedCustLedgEntry.RESET;
        DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
        DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", Cust_Ledger_Entry_Dr."Entry No.");
        DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
        DetailedCustLedgEntry.SETRANGE(Unapplied, FALSE);
        //DetailedCustLedgEntry.SETFILTER("Initial Document Type",'%1',DetailedCustLedgEntry."Initial Document Type" :: Invoice);
        IF DetailedCustLedgEntry.FINDSET THEN BEGIN
            REPEAT
                IF (DetailedCustLedgEntry."Cust. Ledger Entry No." <> Cust_Ledger_Entry_Dr."Entry No.") OR
                    (DetailedCustLedgEntry."Document No." <> Cust_Ledger_Entry_Dr."Document No.") THEN BEGIN
                    CustLedgEntry.RESET;
                    CustLedgEntry.SETRANGE("Document No.", DetailedCustLedgEntry."Document No.");
                    CustLedgEntry.SETFILTER("Source Code", '%1', 'BANKRCPTV');
                    IF CustLedgEntry.FINDFIRST THEN BEGIN
                        IF RcptNo <> '' THEN
                            RcptNo += ', ' + CustLedgEntry."Document No."
                        ELSE
                            RcptNo := CustLedgEntry."Document No.";

                        IF RcptDate <> '' THEN
                            RcptDate += ', ' + FORMAT(CustLedgEntry."Posting Date")
                        ELSE
                            RcptDate := FORMAT(CustLedgEntry."Posting Date");

                        IF AdjustmentDate <> '' THEN
                            AdjustmentDate += ', ' + FORMAT(DetailedCustLedgEntry."Posting Date")
                        ELSE
                            AdjustmentDate := FORMAT(DetailedCustLedgEntry."Posting Date");
                    END ELSE BEGIN
                        IF OtherNo <> '' THEN
                            OtherNo += ', ' + CustLedgEntry."Document No."
                        ELSE
                            OtherNo := CustLedgEntry."Document No.";

                        IF OtherDate <> '' THEN
                            OtherDate += ', ' + FORMAT(CustLedgEntry."Posting Date")
                        ELSE
                            OtherDate := FORMAT(CustLedgEntry."Posting Date");

                        IF OtherAdjDate <> '' THEN
                            OtherAdjDate += ', ' + FORMAT(DetailedCustLedgEntry."Posting Date")
                        ELSE
                            OtherAdjDate := FORMAT(DetailedCustLedgEntry."Posting Date");
                    END;
                END;
            UNTIL DetailedCustLedgEntry.NEXT = 0;
        END;
        //Condition 1
        //Condition 2
        DetailedCustLedgEntry.RESET;
        DetailedCustLedgEntry.SETCURRENTKEY("Document No.");
        DetailedCustLedgEntry.SETRANGE("Document No.", Cust_Ledger_Entry_Dr."Document No.");
        DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
        //DetailedCustLedgEntry.SETFILTER("Document Type",'%1',DetailedCustLedgEntry."Document Type" :: Invoice);
        DetailedCustLedgEntry.SETRANGE(Unapplied, FALSE);
        DetailedCustLedgEntry.SETFILTER("Cust. Ledger Entry No.", '<>%1', Cust_Ledger_Entry_Dr."Entry No.");
        IF DetailedCustLedgEntry.FINDSET THEN BEGIN
            REPEAT
                CustLedgEntry.GET(DetailedCustLedgEntry."Cust. Ledger Entry No.");
                IF CustLedgEntry."Source Code" = 'BANKRCPTV' THEN BEGIN
                    IF RcptNo <> '' THEN
                        RcptNo += ', ' + CustLedgEntry."Document No."
                    ELSE
                        RcptNo := CustLedgEntry."Document No.";

                    IF RcptDate <> '' THEN
                        RcptDate += ', ' + FORMAT(CustLedgEntry."Posting Date")
                    ELSE
                        RcptDate := FORMAT(CustLedgEntry."Posting Date");

                    IF AdjustmentDate <> '' THEN
                        AdjustmentDate += ', ' + FORMAT(DetailedCustLedgEntry."Posting Date")
                    ELSE
                        AdjustmentDate := FORMAT(DetailedCustLedgEntry."Posting Date");
                END ELSE BEGIN
                    IF OtherNo <> '' THEN
                        OtherNo += ', ' + CustLedgEntry."Document No."
                    ELSE
                        OtherNo := CustLedgEntry."Document No.";

                    IF OtherDate <> '' THEN
                        OtherDate += ', ' + FORMAT(CustLedgEntry."Posting Date")
                    ELSE
                        OtherDate := FORMAT(CustLedgEntry."Posting Date");

                    IF OtherAdjDate <> '' THEN
                        OtherAdjDate += ', ' + FORMAT(DetailedCustLedgEntry."Posting Date")
                    ELSE
                        OtherAdjDate := FORMAT(DetailedCustLedgEntry."Posting Date");
                END;
            UNTIL DetailedCustLedgEntry.NEXT = 0;
        END;
        //Condition 2
        IF OtherPaidAmount = 0 THEN BEGIN
            CLEAR(OtherAdjDate);
            CLEAR(OtherDate);
            CLEAR(OtherNo);
        END;
        IF ReceiptPaidAmount = 0 THEN BEGIN
            CLEAR(RcptDate);
            CLEAR(RcptNo);
            CLEAR(AdjustmentDate);
        END;
        CountValue1 := STRLEN(RcptNo);
        CountValue2 := STRLEN(RcptDate);
        CountValue3 := STRLEN(AdjustmentDate);
        CountValue4 := STRLEN(OtherNo);
        CountValue5 := STRLEN(OtherDate);
        CountValue6 := STRLEN(OtherAdjDate);

        IF (CountValue1 >= 250) OR (CountValue2 >= 250) OR (CountValue3 >= 250)
          OR (CountValue4 >= 250) OR (CountValue5 >= 250) OR (CountValue6 >= 250) THEN BEGIN

            TempRcptNo := RcptNo;
            TempRcptDate := RcptDate;
            TempAdjustmentDate := AdjustmentDate;
            TempOtherNo := OtherNo;
            TempOtherDate := OtherDate;
            TempOtherAdjDate := OtherAdjDate;


            RcptNo := COPYSTR(TempRcptNo, 1, 250);
            RcptDate := COPYSTR(TempRcptDate, 1, 250);
            AdjustmentDate := COPYSTR(TempAdjustmentDate, 1, 250);
            OtherNo := COPYSTR(TempOtherNo, 1, 250);
            OtherDate := COPYSTR(TempOtherDate, 1, 250);
            OtherAdjDate := COPYSTR(TempOtherAdjDate, 1, 250);

            RcptNo1 := COPYSTR(TempRcptNo, 251, 250);
            RcptDate1 := COPYSTR(TempRcptDate, 251, 250);
            AdjustmentDate1 := COPYSTR(TempAdjustmentDate, 251, 250);
            OtherNo1 := COPYSTR(TempOtherNo, 251, 250);
            OtherDate1 := COPYSTR(TempOtherDate, 251, 250);
            OtherAdjDate1 := COPYSTR(TempOtherAdjDate, 251, 250);
        END;
    end;


    procedure UnApplicationEnties()
    begin
        IF Cust_Ledger_Entry_Cr."Source Code" = 'BANKRCPTV' THEN BEGIN
            ReceiptPaidAmount := Cust_Ledger_Entry_Cr."Amount (LCY)";
            RcptNo := Cust_Ledger_Entry_Cr."Document No.";
            RcptDate := FORMAT(Cust_Ledger_Entry_Cr."Posting Date");
            BankAccLdgEntry.RESET;
            BankAccLdgEntry.SETRANGE("Document No.", Cust_Ledger_Entry_Cr."Document No.");
            IF BankAccLdgEntry.FINDFIRST THEN BEGIN
                //ChecqueNo := BankAccLdgEntry."Cheque No.";
                BankAccount.GET(BankAccLdgEntry."Bank Account No.");
                BankInfo[1] := BankAccount.Name;
                BankInfo[2] := BankAccount."Bank Account No.";
            END;
        END ELSE BEGIN
            OtherPaidAmount := Cust_Ledger_Entry_Cr."Amount (LCY)";
            OtherNo := Cust_Ledger_Entry_Cr."Document No.";
            OtherDate := FORMAT(Cust_Ledger_Entry_Cr."Posting Date");
        END;
    end;


    procedure ClearVariables()
    begin
        CLEAR(InvoiceStatus);
        CLEAR(InvoiceType);
        CLEAR(ReceiptPaidAmount);
        CLEAR(RcptNo);
        CLEAR(RcptDate);
        CLEAR(AdjustmentDate);
        CLEAR(OtherPaidAmount);
        CLEAR(OtherNo);
        CLEAR(OtherDate);
        CLEAR(OtherAdjDate);
        CLEAR(RcptNo1);
        CLEAR(RcptDate1);
        CLEAR(AdjustmentDate1);
        CLEAR(OtherNo1);
        CLEAR(OtherDate1);
        CLEAR(OtherAdjDate1);
        CLEAR(TempRcptNo);
        CLEAR(TempRcptDate);
        CLEAR(TempAdjustmentDate);
        CLEAR(TempOtherNo);
        CLEAR(TempOtherDate);
        CLEAR(TempOtherAdjDate);
        CLEAR(ProjectInfo);
        CLEAR(ChecqueNo);
        CLEAR(BankInfo);
    end;


    procedure InvoiceStatusFunction()
    begin
        IF Cust_Ledger_Entry_Dr."Remaining Amt. (LCY)" = 0 THEN
            InvoiceStatus := InvoiceStatus::"Fully Adjusted";

        IF Cust_Ledger_Entry_Dr."Remaining Amt. (LCY)" = Cust_Ledger_Entry_Dr."Amount (LCY)" THEN
            InvoiceStatus := InvoiceStatus::Authorized;

        IF (Cust_Ledger_Entry_Dr."Remaining Amt. (LCY)" < Cust_Ledger_Entry_Dr."Amount (LCY)") AND (Cust_Ledger_Entry_Dr."Remaining Amt. (LCY)" <> 0) THEN
            InvoiceStatus := InvoiceStatus::"Partialy Adjusted";
    end;


    procedure InvoiceTypeFunction()
    begin
        CASE Cust_Ledger_Entry_Dr."Document Type" OF

            Cust_Ledger_Entry_Dr."Document Type"::" ":
                BEGIN
                    InvoiceType := InvoiceType::"Transfer Credit Note";
                    //CurrReport.SKIP; //Temp Apply Logic
                END;


            Cust_Ledger_Entry_Dr."Document Type"::Invoice:
                BEGIN
                    IF SalesInvHeader.GET(Cust_Ledger_Entry_Dr."Document No.") THEN BEGIN
                        IF SalesInvHeader."Type Of Note" <> SalesInvHeader."Type Of Note"::Debit THEN
                            InvoiceType := InvoiceType::"Customer Invoice"
                        ELSE
                            InvoiceType := InvoiceType::"Debit Note"
                    END;
                END;

            Cust_Ledger_Entry_Dr."Document Type"::Refund:
                InvoiceType := InvoiceType::"Customer Payment"

        END;
    end;

    procedure ProjectDetail()
    begin
        GetProject.RESET;
        GetProject.SETRANGE("Global Dimension 1 Code", Cust_Ledger_Entry_Dr."Global Dimension 1 Code");
        IF GetProject.FINDFIRST THEN BEGIN
            ProjectInfo[1] := GetProject."No.";
            ProjectInfo[2] := GetProject."Project Name";
            ProjectInfo[3] := GetProject."Project Name 2";
            ProjectInfo[4] := GetProject."Project Manager";
            ProjectInfo[5] := FORMAT(GetProject."Project Status");
            ProjectInfo[6] := FORMAT(GetProject."Creation Date");
        END;
    end;


    procedure CreateHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(CUSTOMERCODECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CUSTOMERNAMECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FINANCEBOOKCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(INVOICETYPECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(INVOICENOCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(INVOICEDATECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(INVOICESTATUSCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(INVOICEAMOUNTCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(RECEIPTAMOUNTCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(OUTSTANDINGCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CREDITAMOUNTCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(RECEIPTNOCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(RECEIPTDATECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(RECEIPTADJUSTMENTDATECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(RECEIPTNOCap1, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(RECEIPTDATECap1, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(RECEIPTADJUSTMENTDATECap1, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CREDITNOTECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CREDITNOTEDATECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CREDITNOTEADJUSTDATECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CREDITNOTECap1, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CREDITNOTEDATECap1, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CREDITNOTEADJUSTDATECap1, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(MANAGERCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PROJECTSTATUSCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PROJECTCODECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PROJECTNAMECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PROJECTNAMECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PROJECTCREATEDDATECap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CHEQUENOCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(REMARKSCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PRJOUDESCCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(BANKCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(BANKAccountNoCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TAXAMOUNTTDSCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ServiceTaxCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(UNADJUSTEDAMOUNTCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure CreateBodyDr()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Cust_Ledger_Entry_Dr."Global Dimension 2 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(InvoiceType, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Cust_Ledger_Entry_Dr."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(Cust_Ledger_Entry_Dr."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(InvoiceStatus, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Cust_Ledger_Entry_Dr."Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ReceiptPaidAmount, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Cust_Ledger_Entry_Dr."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OtherPaidAmount, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(RcptNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(RcptDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AdjustmentDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(RcptNo1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(RcptDate1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AdjustmentDate1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OtherNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OtherDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OtherAdjDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OtherNo1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OtherDate1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OtherAdjDate1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ProjectInfo[4], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ProjectInfo[5], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ProjectInfo[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ProjectInfo[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ProjectInfo[3], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ProjectInfo[6], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure CreateBodyCr()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Cust_Ledger_Entry_Cr."Global Dimension 2 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(InvoiceType, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ReceiptPaidAmount, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Cust_Ledger_Entry_Cr."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OtherPaidAmount, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(RcptNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(RcptDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OtherNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OtherDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(OtherAdjDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ChecqueNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(BankInfo[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(BankInfo[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;


    procedure CreateFooter()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TOTALCap, FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TotalAmount[1], FALSE, '', TRUE, TRUE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalAmount[2], FALSE, '', TRUE, TRUE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalAmount[3], FALSE, '', TRUE, TRUE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TotalAmount[4], FALSE, '', TRUE, TRUE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;


    procedure CreateBodyNOV()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Cust_Ledger_Entry_OV."Global Dimension 2 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(InvoiceType, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Cust_Ledger_Entry_OV."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(Cust_Ledger_Entry_OV."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(InvoiceStatus, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Cust_Ledger_Entry_OV."Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ReceiptPaidAmount, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Cust_Ledger_Entry_OV."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;
}

