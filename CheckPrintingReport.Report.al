report 50077 "Check Printing Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CheckPrintingReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = WHERE("Source Code" = FILTER('BANKPYMTV'));
            column(DearSir_Cap; DearSirCap)
            {
            }
            column(Enclosed_Cap; EnclosedCap)
            {
            }
            column(For_Cap; ForCap)
            {
            }
            column(Dated_Cap; DatedCap)
            {
            }
            column(Of_Cap; OfCap)
            {
            }
            column(AsPerDetail_Cap; AsPerDetailCap)
            {
            }
            column(VoucherNo_Cap; VoucherNoCap)
            {
            }
            column(Date_Cap; DateCap)
            {
            }
            column(VendorInvNo_Cap; VendorInvNoCap)
            {
            }
            column(InvDate_Cap; InvDateCap)
            {
            }
            column(InvAmt_Cap; InvAmtCap)
            {
            }
            column(TDSDeductions_Cap; TDSDeductionsCap)
            {
            }
            column(NetAmt_Cap; NetAmtCap)
            {
            }
            column(PIN_Cap; PINCap)
            {
            }
            column(Tel_Cap; TelCap)
            {
            }
            column(Fax_Cap; FaxCap)
            {
            }
            column(SumTotal_Cap; SumTotalCap)
            {
            }
            column(DeedReason_Cap; DeedReasonCap)
            {
            }
            column(InvoiceAmountIs_Cap; InvoiceAmountIsCap)
            {
            }
            column(PANNo_Cap; PANNoCap)
            {
            }
            column(ServiceTax_Cap; ServiceTaxCap)
            {
            }
            column(PartyName_Cap; PartyNameCap)
            {
            }
            column(Address_Cap; AddressCap)
            {
            }
            column(ApprovedBy_Cap; ApprovedByCap)
            {
            }
            column(PleaseVerify_Cap; PleaseVerifyCap)
            {
            }
            column(PreParedBy_Cap; PreParedByCap)
            {
            }
            column(AuthBy_Cap; AuthByCap)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(CompInfo_Name; CompanyNameText)
            {
            }
            column(CompInfo_Address; CompInfo.Address)
            {
            }
            column(CompInfo_Address2; CompInfo."Address 2")
            {
            }
            column(CompInfo_PhoneNo; CompInfo."Phone No.")
            {
            }
            column(CompInfo_FaxNo; CompInfo."Fax No.")
            {
            }
            column(GetBankAccount_Name; GetBankAccount.Name)
            {
            }
            column(Payment_Amount; BankAccLedgEntry."Amount (LCY)")
            {
            }
            column(Cheque_No; '')
            {
            }
            column(Cheque_Date; FORMAT(BankAccLedgEntry."Posting Date"))
            {
            }
            column(CheckDate_Format; CheckDateFormat)
            {
            }
            column(StoreDate_1; StoreDate[1])
            {
            }
            column(StoreDate_2; StoreDate[2])
            {
            }
            column(StoreDate_3; StoreDate[3])
            {
            }
            column(StoreDate_4; StoreDate[4])
            {
            }
            column(StoreDate_5; StoreDate[5])
            {
            }
            column(StoreDate_6; StoreDate[6])
            {
            }
            column(StoreDate_7; StoreDate[7])
            {
            }
            column(StoreDate_8; StoreDate[8])
            {
            }
            column(TotalNet_Amount; TotalNetAmount)
            {
            }
            column(TotalAmount_Inwords; TotalAmountInwords[1])
            {
            }
            dataitem(DetailedVendorLedgEntry_1; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Entry No.")
                                    WHERE("Entry Type" = FILTER(Application),
                                          "Initial Document Type" = FILTER(Invoice));

                trigger OnAfterGetRecord()
                begin
                    GetVendor.GET("Vendor No.");
                    VendLedgEntry.GET("Vendor Ledger Entry No.");
                    VendLedgEntry.CALCFIELDS("Amount (LCY)");
                    IsApplied := TRUE;

                    TempCashFlowBuffer.INIT;
                    TempCashFlowBuffer."Entry No." += 1;
                    TempCashFlowBuffer."Code 1" := "Document No.";
                    TempCashFlowBuffer."Code 2" := VendLedgEntry."External Document No.";
                    TempCashFlowBuffer."Decimal 1" := -(VendLedgEntry."Purchase (LCY)");
                    TempCashFlowBuffer."Decimal 2" := VendLedgEntry."Total TDS Including SHE CESS";
                    TempCashFlowBuffer."Decimal 3" := VendLedgEntry."Amount (LCY)";
                    TempCashFlowBuffer."Date 1" := "Posting Date";
                    TempCashFlowBuffer."Boolean 1" := IsApplied;
                    IF TempCashFlowBuffer.INSERT THEN
                        Counter += 1;
                end;
            }
            dataitem(VendorDetail_1; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Entry No.")
                                    WHERE("Entry Type" = FILTER(Application),
                                          "Initial Document Type" = FILTER(Invoice));

                trigger OnAfterGetRecord()
                begin
                    GetVendor.GET("Vendor No.");
                    VendLedgEntry.GET("Vendor Ledger Entry No.");
                    VendLedgEntry.CALCFIELDS("Amount (LCY)");

                    VendInfo[1] := UPPERCASE(GetVendor.Name);
                    VendInfo[2] := GetVendor.Address;
                    VendInfo[3] := GetVendor."Address 2";
                    VendInfo[4] := GetVendor.City;
                    VendInfo[5] := GetVendor."State Code";
                    VendInfo[6] := GetVendor."Post Code";
                    VendInfo[7] := GetVendor."Phone No.";
                    VendInfo[8] := GetVendor."GST Registration No.";
                    VendInfo[9] := GetVendor."P.A.N. No.";
                end;
            }
            dataitem(DetailedVendorLedgEntry_2; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Entry No.")
                                    WHERE("Entry Type" = FILTER(Application),
                                          "Document Type" = FILTER(Invoice));

                trigger OnAfterGetRecord()
                begin
                    GetVendor.GET("Vendor No.");
                    VendLedgEntry.GET("Vendor Ledger Entry No.");
                    VendLedgEntry.CALCFIELDS("Amount (LCY)");
                    VendorLedgerEntry1.RESET;
                    VendorLedgerEntry1.SETRANGE("Document No.", "Document No.");
                    IF VendorLedgerEntry1.FINDFIRST THEN;
                    IsApplied := TRUE;

                    TempCashFlowBuffer.INIT;
                    TempCashFlowBuffer."Entry No." += 1;
                    TempCashFlowBuffer."Code 1" := VendLedgEntry."Document No.";
                    TempCashFlowBuffer."Code 2" := VendorLedgerEntry1."External Document No.";
                    TempCashFlowBuffer."Decimal 1" := -(VendorLedgerEntry1."Purchase (LCY)");
                    TempCashFlowBuffer."Decimal 2" := -(VendorLedgerEntry1."Total TDS Including SHE CESS");
                    TempCashFlowBuffer."Decimal 3" := ("Amount (LCY)");
                    TempCashFlowBuffer."Date 1" := "Posting Date";
                    TempCashFlowBuffer."Boolean 1" := IsApplied;
                    IF TempCashFlowBuffer.INSERT THEN
                        Counter += 1;
                end;
            }
            dataitem(VendorDetail_2; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Entry No.")
                                    WHERE("Entry Type" = FILTER(Application),
                                          "Initial Document Type" = FILTER(Invoice));

                trigger OnAfterGetRecord()
                begin
                    GetVendor.GET("Vendor No.");
                    VendLedgEntry.GET("Vendor Ledger Entry No.");
                    VendLedgEntry.CALCFIELDS("Amount (LCY)");

                    VendInfo[1] := UPPERCASE(GetVendor.Name);
                    VendInfo[2] := GetVendor.Address;
                    VendInfo[3] := GetVendor."Address 2";
                    VendInfo[4] := GetVendor.City;
                    VendInfo[5] := GetVendor."State Code";
                    VendInfo[6] := GetVendor."Post Code";
                    VendInfo[7] := GetVendor."Phone No.";
                    VendInfo[8] := GetVendor."GST Registration No.";
                    VendInfo[9] := GetVendor."P.A.N. No.";
                end;
            }
            dataitem(CashFlowBuffer; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(Voucher_No; TempCashFlowBuffer."Code 1")
                {
                }
                column(Voucher_Date; FORMAT(TempCashFlowBuffer."Date 1"))
                {
                }
                column(Vendor_Inv_No; TempCashFlowBuffer."Code 2")
                {
                }
                column(Inv_Date; FORMAT(TempCashFlowBuffer."Date 1"))
                {
                }
                column(Invoice_Amount; TempCashFlowBuffer."Decimal 1")
                {
                }
                column(TDS_Amount; TempCashFlowBuffer."Decimal 2")
                {
                }
                column(Net_Amount; TempCashFlowBuffer."Decimal 3")
                {
                }
                column(Is_Applied; IsApplied)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number <> 1 THEN BEGIN
                        TempCashFlowBuffer.NEXT;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE(Number, 1, Counter);
                    IF TempCashFlowBuffer.FINDFIRST THEN;
                end;
            }
            dataitem(DataItem1000000020; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(GetVendor_Name; VendInfo[1])
                {
                }
                column(GetVendor_Address; VendInfo[2])
                {
                }
                column(GetVendor_Address2; VendInfo[3])
                {
                }
                column(GetVendor_City; VendInfo[4])
                {
                }
                column(GetVendor_StateCode; VendInfo[5])
                {
                }
                column(GetVendor_PostCode; VendInfo[6])
                {
                }
                column(GetVendor_PhoneNo; VendInfo[7])
                {
                }
                column(GetVendor_ServiceTaxRegistration_No; VendInfo[8])
                {
                }
                column(GetVendor_PANNo; VendInfo[9])
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(VendInfo);

                IF CompInfo."New Name Date" <> 0D THEN BEGIN
                    IF "Posting Date" >= CompInfo."New Name Date" THEN
                        CompanyNameText := CompInfo.Name
                    ELSE
                        CompanyNameText := CompInfo."Old Name";
                END ELSE
                    CompanyNameText := CompInfo.Name;


                BankAccLedgEntry.RESET;
                BankAccLedgEntry.SETRANGE("Document No.", "Document No.");
                IF BankAccLedgEntry.FINDFIRST THEN BEGIN

                    IF BankAccLedgEntry.Reversed THEN
                        ERROR('Cheque cannot be printed for reversed voucher');

                    GetBankAccount.GET(BankAccLedgEntry."Bank Account No.");
                    CheckDateFormat := FORMAT(BankAccLedgEntry."Posting Date", 0, '<Day,2><Month,2><Year4>');
                    //evaluate(CheckDateFormat,CheckDate);
                    StoreDate[1] := COPYSTR(CheckDateFormat, 1, 1);
                    StoreDate[2] := COPYSTR(CheckDateFormat, 2, 1);
                    StoreDate[3] := COPYSTR(CheckDateFormat, 3, 1);
                    StoreDate[4] := COPYSTR(CheckDateFormat, 4, 1);
                    StoreDate[5] := COPYSTR(CheckDateFormat, 5, 1);
                    StoreDate[6] := COPYSTR(CheckDateFormat, 6, 1);
                    StoreDate[7] := COPYSTR(CheckDateFormat, 7, 1);
                    StoreDate[8] := COPYSTR(CheckDateFormat, 8, 1);

                    TotalNetAmount += ABS(BankAccLedgEntry."Amount (LCY)");
                    ReportCheck.InitTextVariable;
                    ReportCheck.FormatNoText(TotalAmountInwords, TotalNetAmount, '');

                    DVLE.RESET;
                    DVLE.SETCURRENTKEY("Document No.");
                    DVLE.SETRANGE("Document No.", BankAccLedgEntry."Document No.");
                    IF NOT DVLE.FINDFIRST THEN BEGIN
                        GLE.RESET;
                        GLE.SETRANGE("Document No.", BankAccLedgEntry."Document No.");
                        GLE.SETFILTER(Amount, '>%1', 0);
                        IF GLE.FINDFIRST THEN
                            VendInfo[1] := UPPERCASE(GLE.Description);
                    END;
                END;
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

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
        TempCashFlowBuffer.DELETEALL;
    end;

    var
        DearSirCap: Label 'Dear Sir/ Madam';
        EnclosedCap: Label 'Enclosed herewith please find a Cheque. no#';
        ForCap: Label 'for Rs***********';
        DatedCap: Label '*             dated';
        OfCap: Label 'of';
        AsPerDetailCap: Label 'as per details given below:-';
        VoucherNoCap: Label 'Voucher No.';
        DateCap: Label 'Date';
        VendorInvNoCap: Label 'Vendor Invoice No.';
        InvDateCap: Label 'Inv. Date';
        InvAmtCap: Label 'Invoice Amt.';
        TDSDeductionsCap: Label 'TDS/Deductions';
        NetAmtCap: Label 'Net Amount';
        CompInfo: Record "Company Information";
        GetVendor: Record Vendor;
        PINCap: Label 'PIN';
        TelCap: Label 'Tel';
        FaxCap: Label 'Fax';
        GetBankAccount: Record "Bank Account";
        VendLedgEntry: Record "Vendor Ledger Entry";
        SumTotalCap: Label 'Sum Total';
        DeedReasonCap: Label 'Deed Reason :';
        InvoiceAmountIsCap: Label 'Invoice amount is total of net amount and TDS/deductions shown above.';
        ReportCheck: Report Check;
        TotalNetAmount: Decimal;
        TotalAmountInwords: array[2] of Text[80];
        CheckDateFormat: Text;
        CheckDate: Date;
        StoreDate: array[8] of Text;
        PANNoCap: Label 'PAN No.';
        ServiceTaxCap: Label 'Service Tax Reg.';
        PartyNameCap: Label 'Party Name';
        AddressCap: Label 'Address';
        PleaseVerifyCap: Label '* Please verify PAN No. within 3 days';
        ApprovedByCap: Label 'Approved By';
        PreParedByCap: Label 'Perpared By';
        AuthByCap: Label 'Authorised Signatory';
        IsApplied: Boolean;
        VendInfo: array[20] of Text;
        DVLE: Record "Detailed Vendor Ledg. Entry";
        GLE: Record "G/L Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        TempCashFlowBuffer: Record "Cash Flow Buffer" temporary;
        Counter: Integer;
        VendorLedgerEntry1: Record "Vendor Ledger Entry";
        CompanyNameText: Text;
}

