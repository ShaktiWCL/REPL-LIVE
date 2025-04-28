report 50089 "TDS Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TDSRegister.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("TDS Entry"; "TDS Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                WHERE(Reversed = FILTER(false));
            RequestFilterFields = "Party Code", "Posting Date";
            column(TDSRegister_Cap; TDSRegisterCap)
            {
            }
            column(ChallanSNo_Cap; ChallanSNoCap)
            {
            }
            column(SectionCode_Cap; SectionCodeCap)
            {
            }
            column(DedcuteeCode_Cap; DedcuteeCodeCap)
            {
            }
            column(PANofthedeductee_Cap; PANofthededucteeCap)
            {
            }
            column(PANReferenceNo_Cap; PANReferenceNoCap)
            {
            }
            column(NameoftheDeductee_Cap; NameoftheDeducteeCap)
            {
            }
            column(Address1_Cap; Address1Cap)
            {
            }
            column(Address2_Cap; Address2Cap)
            {
            }
            column(Address3_Cap; Address3Cap)
            {
            }
            column(Address4_Cap; Address4Cap)
            {
            }
            column(Address5_Cap; Address5Cap)
            {
            }
            column(Pin_Cap; PinCap)
            {
            }
            column(State_Cap; StateCap)
            {
            }
            column(DateofPaymentCredit_Cap; DateofPaymentCreditCap)
            {
            }
            column(AmountPaidcreditedRs_Cap; AmountPaidcreditedRsCap)
            {
            }
            column(PaidbyBookentryorotherwise_Cap; PaidbyBookentryorotherwiseCap)
            {
            }
            column(TDSAmountRs_Cap; TDSAmountRsCap)
            {
            }
            column(SurchargeAmountRs_Cap; SurchargeAmountRsCap)
            {
            }
            column(EducationCessAmountRs_Cap; EducationCessAmountRsCap)
            {
            }
            column(TotalTaxDeductedAmount_Cap; TotalTaxDeductedAmountCap)
            {
            }
            column(TotaltaxDepositedAmount_Cap; TotaltaxDepositedAmountCap)
            {
            }
            column(DateofDeduction_Cap; DateofDeductionCap)
            {
            }
            column(TaxDeductionRateper_Cap; TaxDeductionRateperCap)
            {
            }
            column(SurchargeRateper_Cap; SurchargeRateperCap)
            {
            }
            column(EducationCessRateper_Cap; EducationCessRateperCap)
            {
            }
            column(TotalRateatwhichTaxdeductedper_Cap; TotalRateatwhichTaxdeductedperCap)
            {
            }
            column(Reasonfornondeductionlowerdeduction_Cap; ReasonfornondeductionlowerdeductionCap)
            {
            }
            column(CertificationnumberissuedbyAssessingofficer_Cap; CertificationnumberissuedbyAssessingofficerCap)
            {
            }
            column(ExpenseAccountNo_Cap; ExpenseAccountNoCap)
            {
            }
            column(Filters_Cap; FiltersCap)
            {
            }
            column(DocumentNo_Cap; DocumentNoCap)
            {
            }
            column(VendorNo_Cap; VendorNoCap)
            {
            }
            column(Document_No; "TDS Entry"."Document No.")
            {
            }
            column(TDS_AccountNo; "TDS Entry"."Account No.")
            {
            }
            column(TDS_Sub_Section; TDSSubSection)
            {
            }
            column(Dedcutee_Code; DedcuteeCode)
            {
            }
            column(Dedcutee_PAN_No; DedcuteePANNo)
            {
            }
            column(Vendor_No; "Party Code")
            {
            }
            column(Vendor_Name; VendorName)
            {
            }
            column(VendorAddress_1; VendorAddress[1])
            {
            }
            column(VendorAddress_2; VendorAddress[2])
            {
            }
            column(VendorAddress_3; VendorAddress[3])
            {
            }
            column(VendorAddress_4; VendorAddress[4])
            {
            }
            column(VendorAddress_5; VendorAddress[5])
            {
            }
            column(CompInfo_PIN; CompInfoPIN)
            {
            }
            column(CompInfo_StateGr; CompInfoStateGr)
            {
            }
            column(Date_Of_Payment; FORMAT(DateOfPayment))
            {
            }
            column(Amount_Paid; AmountPaid)
            {
            }
            column(PaidByBook_Or_Otherwise; PaidByBookOrOtherwise)
            {
            }
            column(TDS_Amount; TDSAmount)
            {
            }
            column(Surcharge_Amount; SurchargeAmount)
            {
            }
            column(eCess_Amount; eCessAmount)
            {
            }
            column(TotalTaxDeducated_Amount; TotalTaxDeducatedAmount)
            {
            }
            column(DateOf_Deduction; FORMAT(DateOfDeduction))
            {
            }
            column(TDS_per; TDSper)
            {
            }
            column(Surcharge_per; Surchargeper)
            {
            }
            column(eCess_per; eCessper)
            {
            }
            column(TotalTax_Per; TotalTaxPer)
            {
            }
            column(TotalTaxDeposited_Amount; TotalTaxDepositedAmount)
            {
            }
            column(Filters_Apply; FiltersApply)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ClearData;
                // TDSGroup.RESET;
                // TDSGroup.SETRANGE(TDSGroup."TDS Section", TDSSubSection);
                // IF TDSGroup.FINDFIRST THEN
                //     TDSSubSection := TDSGroup."TDS Sub Section";


                IF AssesseeCode.GET("Assessee Code") THEN
                    DedcuteeCode := AssesseeCode."Dedcutee Code";

                // IF NOT (STRLEN("Deductee P.A.N. No.") > 10) THEN
                //     DedcuteePANNo := "Deductee P.A.N. No."
                // ELSE
                //     ERROR('Deductee P.A.N. No. length should not be greater than 10');

                IF "Party Type" = "Party Type"::Vendor THEN BEGIN
                    GetVendor.GET("Party Code");
                    VendorName := GetVendor.Name;
                    VendorAddress[1] := COPYSTR(GetVendor.Address, 1, 25);
                    VendorAddress[2] := COPYSTR(GetVendor.Address, 26, 50);
                    VendorAddress[3] := COPYSTR(GetVendor."Address 2", 1, 25);
                    VendorAddress[4] := COPYSTR(GetVendor."Address 2", 26, 50);
                    VendorAddress[5] := '';
                END;

                GLEntry.RESET;
                GLEntry.SETCURRENTKEY("Document No.");
                GLEntry.SETRANGE("Document No.", "Document No.");
                IF GLEntry.FINDFIRST THEN BEGIN
                    ResponsibilityCenter.RESET;
                    ResponsibilityCenter.SETRANGE("Global Dimension 2 Code", GLEntry."Global Dimension 2 Code");
                    IF ResponsibilityCenter.FINDFIRST THEN BEGIN

                        IF NOT (STRLEN(ResponsibilityCenter."Post Code") > 6) THEN
                            CompInfoPIN := ResponsibilityCenter."Post Code"
                        ELSE
                            ERROR('P.I.N. No. length should not be greater than 6');

                        IF GetState.GET(ResponsibilityCenter."State Code") THEN
                            CompInfoStateGr := GetState."State Code for eTDS/TCS";
                    END;
                END;


                DateOfPayment := "Posting Date";
                AmountPaid := "TDS Base Amount";
                PaidByBookOrOtherwise := 'N';
                TDSAmount := "TDS Amount";
                SurchargeAmount := "Surcharge Amount";
                eCessAmount := "eCESS Amount";
                TotalTaxDeducatedAmount := TDSAmount + SurchargeAmount + eCessAmount;
                DateOfDeduction := "Posting Date";
                TDSper := "TDS %";
                Surchargeper := "Surcharge %";
                eCessper := "eCESS %";
                TotalTaxPer := TDSper + (TDSper * Surchargeper / 100) + (TDSper * eCessper / 100);
                IF "TDS Entry"."TDS Paid" THEN
                    TotalTaxDepositedAmount := TotalTaxDeducatedAmount - ("Remaining TDS Amount" + "Remaining Surcharge Amount");
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
        FiltersApply := "TDS Entry".GETFILTERS;
    end;

    var
        TDSRegisterCap: Label 'TDS Register';
        ChallanSNoCap: Label 'Challan SNo.';
        SectionCodeCap: Label 'Section Code';
        DedcuteeCodeCap: Label 'Dedcutee Code';
        PANofthededucteeCap: Label 'PAN of the deductee';
        PANReferenceNoCap: Label 'PAN Reference No.';
        NameoftheDeducteeCap: Label 'Name of the Deductee';
        Address1Cap: Label 'Address 1';
        Address2Cap: Label 'Address 2';
        Address3Cap: Label 'Address 3';
        Address4Cap: Label 'Address 4';
        Address5Cap: Label 'Address 5';
        PinCap: Label 'Pin';
        StateCap: Label 'State';
        DateofPaymentCreditCap: Label 'Date of Payment / Credit';
        AmountPaidcreditedRsCap: Label 'Amount Paid/credited      Rs.';
        PaidbyBookentryorotherwiseCap: Label 'Paid by Book entry or otherwise';
        TDSAmountRsCap: Label 'TDS Amount Rs.';
        SurchargeAmountRsCap: Label 'Surcharge Amount Rs.';
        EducationCessAmountRsCap: Label 'Education Cess Amount Rs.';
        TotalTaxDeductedAmountCap: Label 'Total Tax Deducted Amount';
        TotaltaxDepositedAmountCap: Label 'Total tax Deposited Amount';
        DateofDeductionCap: Label 'Date of Deduction';
        TaxDeductionRateperCap: Label 'Tax Deduction Rate %';
        SurchargeRateperCap: Label 'Surcharge Rate %';
        EducationCessRateperCap: Label 'Education Cess Rate %';
        TotalRateatwhichTaxdeductedperCap: Label 'Total Rate at which Tax deducted %';
        ReasonfornondeductionlowerdeductionCap: Label 'Reason for non-deduction/lower deduction';
        CertificationnumberissuedbyAssessingofficerCap: Label 'Certification number issued by Assessing officer';
        FiltersCap: Label 'Filters';
        TDSGroup: Record "TDS Section";
        AssesseeCode: Record "Assessee Code";
        GetVendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        ResponsibilityCenter: Record "Responsibility Center";
        GetState: Record State;
        TDSSubSection: Option " ","94H","94C","94J","94A","94I","195";
        DedcuteeCode: Code[1];
        DedcuteePANNo: Code[10];
        VendorName: Text[75];
        VendorAddress: array[5] of Text[25];
        CompInfoPIN: Code[6];
        CompInfoStateGr: Code[2];
        DateOfPayment: Date;
        AmountPaid: Decimal;
        PaidByBookOrOtherwise: Code[1];
        TDSAmount: Decimal;
        SurchargeAmount: Decimal;
        eCessAmount: Decimal;
        TotalTaxDeducatedAmount: Decimal;
        DateOfDeduction: Date;
        TDSper: Decimal;
        Surchargeper: Decimal;
        eCessper: Decimal;
        TotalTaxPer: Decimal;
        TotalTaxDepositedAmount: Decimal;
        FiltersApply: Text;
        VendorNoCap: Label 'Vendor No.';
        DocumentNoCap: Label 'Document No.';
        ExpenseAccountNoCap: Label 'Expense Account No.';


    procedure ClearData()
    begin
        CLEAR(TDSSubSection);
        CLEAR(DedcuteeCode);
        CLEAR(DedcuteePANNo);
        CLEAR(VendorName);
        CLEAR(VendorAddress);
        CLEAR(CompInfoPIN);
        CLEAR(CompInfoStateGr);
        CLEAR(DateOfPayment);
        CLEAR(AmountPaid);
        CLEAR(PaidByBookOrOtherwise);
        CLEAR(TDSAmount);
        CLEAR(SurchargeAmount);
        CLEAR(eCessAmount);
        CLEAR(TotalTaxDeducatedAmount);
        CLEAR(DateOfDeduction);
        CLEAR(TDSper);
        CLEAR(Surchargeper);
        CLEAR(eCessper);
        CLEAR(TotalTaxPer);
        CLEAR(TotalTaxDepositedAmount);
    end;
}

