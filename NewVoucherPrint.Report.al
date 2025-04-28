report 50048 "New Voucher Print"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/NewVoucherPrint.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Document No.";
            column(rsJnlBatch_Description; rsJnlBatch.Description)
            {
            }
            column(CompanyInformation_Name; CompanyNameText)
            {
            }
            column(CompanyInformation_Address; CompanyInformation.Address + ' ' + CompanyInformation."Address 2")
            {
            }
            column(CompanyInformation_City; CompanyInformation.City)
            {
            }
            column(STRSUBSTNO_Text066_CompanyInformation__E_Mail__; STRSUBSTNO(Text066, CompanyInformation."E-Mail"))
            {
            }
            column(Date_______FORMAT__Gen__Journal_Line___Posting_Date__; FORMAT("Gen. Journal Line"."Posting Date"))
            {
            }
            column(Voucher_No_________Gen__Journal_Line___Document_No__; 'Voucher No. : ' + "Gen. Journal Line"."Document No.")
            {
            }
            column(RECSalesperson_Purchaser__Name; "RECSalesperson/Purchaser".Name)
            {
            }
            column(Page_No_______FORMAT_CurrReport_PAGENO________Continued_______; 'Page No.  ' + '' + '   Continued . . .')
            {
            }
            column(dblBalCredit; dblBalCredit)
            {
            }
            column(dblBalDebit; dblBalDebit)
            {
            }
            column(strBalAccountName; strBalAccountName)
            {
            }
            column(strBalContactName; strBalContactName)
            {
            }
            column(TotalLineDr; TotalLineDr)
            {
            }
            column(TotalLineCr; TotalLineCr + DblSwachhBhartCess)
            {
            }
            column(strContact; strContact)
            {
            }
            column(strDescription; strDescription)
            {
            }
            column(To_____strBalAccountName; 'To ' + strBalAccountName)
            {
            }
            column(dblTotalServiceTaxCr; dblTotalServiceTaxCr)
            {
            }
            column(To_____strServiceTaxAccount; 'To ' + strServiceTaxAccount)
            {
            }
            column(VouchNarr; VouchNarr)
            {
            }
            column(Credit__INR_Caption; Credit__INR_CaptionLbl)
            {
            }
            column(Debit__INR_Caption; Debit__INR_CaptionLbl)
            {
            }
            column(Account_NameCaption; Account_NameCaptionLbl)
            {
            }
            column(NARRATION_Caption; NARRATION_CaptionLbl)
            {
            }
            column(Prepared_ByCaption; Prepared_ByCaptionLbl)
            {
            }
            column(Checked_by_Caption; Checked_by_CaptionLbl)
            {
            }
            column(Authorised_SignatoryCaption; Authorised_SignatoryCaptionLbl)
            {
            }
            column(Gen__Journal_Line_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Gen__Journal_Line_Journal_Batch_Name; "Journal Batch Name")
            {
            }
            column(Gen__Journal_Line_Line_No_; "Line No.")
            {
            }
            column(Gen__Journal_Line_Account_No_; "Account No.")
            {
            }
            column(Gen__Journal_Line_Document_No_; "Document No.")
            {
            }
            column(Gen__Journal_Line_Amount_Type; "Gen. Journal Line"."Account Type")
            {
            }
            column(Gen__Journal_Line_Contact_No_; "Gen. Journal Line"."Account No.")
            {
            }
            column(strExternal; strExternal)
            {
            }
            column(dblTotalWorkTaxCr; dblTotalWorkTaxCr)
            {
            }
            column(lineno; "Gen. Journal Line"."Line No.")
            {
            }
            column(LineAmount; LineAmount)
            {
            }
            column(Gen__Journal_Line2__Line_Narration_; "Gen. Journal Line".Description)
            {
            }
            column(LineDrCr; LineDrCr)
            {
            }
            column(ChequeString; ChequeString)
            {
            }
            column(strExterna1; strExternal + ' ' + "Gen. Journal Line"."External Document No.")
            {
            }
            column(strMatter; strMatter)
            {
            }
            column(Gen__Journal_Line2__Gen__Journal_Line2___Line_Narration_; "Gen. Journal Line".Description)
            {
            }
            column(FORMAT__Gen__Journal_Line2___Document_Date___________Gen__Journal_Line2___Line_Narration_; FORMAT("Document Date") + ' :- ' + 'SHAKTI')
            {
            }
            column(strTDSAccount; strTDSAccount)
            {
            }
            column(dblTotalTDS; dblTotalTDS)
            {
            }
            column(dblTDS; dblTDS)
            {
            }
            column(dblSurcharge; dblSurcharge)
            {
            }
            column(dblECess; dblECess)
            {
            }
            column(SHE_Cess_on_TDS_TCS_Amount_; 0)
            {
            }
            column(dblTotalWorkTaxDr; dblTotalWorkTaxDr)
            {
            }
            column(strWorkTaxAccount; strWorkTaxAccount)
            {
            }
            column(strServiceTaxAccount; strServiceTaxAccount)
            {
            }
            column(dblTotalServiceTaxDr; dblTotalServiceTaxDr)
            {
            }
            column(TDS_AmountCaption; TDS_AmountCaptionLbl)
            {
            }
            column(SurchargeCaption; SurchargeCaptionLbl)
            {
            }
            column(ECESSCaption; ECESSCaptionLbl)
            {
            }
            column(SHE_Cess_AmountCaption; SHE_Cess_AmountCaptionLbl)
            {
            }
            column(Gen__Journal_Line2_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Gen__Journal_Line2_Journal_Batch_Name; "Journal Batch Name")
            {
            }
            column(Gen__Journal_Line2_Line_No_; "Line No.")
            {
            }
            column(Gen__Journal_Line2_Account_No_; "Account No.")
            {
            }
            column(Gen__Journal_Line2_Document_No_; "Document No.")
            {
            }
            column(Gen__Journal_Line2_Amount_Type; "Gen. Journal Line"."Account Type")
            {
            }
            column(Gen__Journal_Line2_Contact_No_; "Gen. Journal Line"."Account No.")
            {
            }
            column(TotDebitAmt; TotDebitAmt)
            {
            }
            column(TotCreditAmt; TotCreditAmt)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(dim1; DimString[1])
            {
            }
            column(dim2; DimString[2])
            {
            }
            column(dim3; DimString[3])
            {
            }
            column(dim4; DimString[4])
            {
            }
            column(dim5; DimString[5])
            {
            }
            column(DblSwachhBhartCess; DblSwachhBhartCess)
            {
            }
            column(ExpanceAccount; '')
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF CompanyInformation."New Name Date" <> 0D THEN BEGIN
                    IF "Posting Date" >= CompanyInformation."New Name Date" THEN
                        CompanyNameText := CompanyInformation.Name
                    ELSE
                        CompanyNameText := CompanyInformation."Old Name";
                END ELSE
                    CompanyNameText := CompanyInformation.Name;


                strDescription := '';
                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    GLAcc.RESET;
                    IF GLAcc.GET("Gen. Journal Line"."Account No.") THEN BEGIN
                        IF blnPrintCodes THEN
                            strDescription := "Gen. Journal Line"."Account No." + ' - ' + GLAcc.Name
                        ELSE
                            strDescription := GLAcc.Name;
                    END;
                END
                ELSE BEGIN
                    IF "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Customer THEN BEGIN
                        rsCustomer.RESET;
                        IF rsCustomer.GET("Gen. Journal Line"."Account No.") THEN BEGIN
                            IF blnPrintCodes THEN
                                strDescription := "Gen. Journal Line"."Account No." + ' - ' + rsCustomer.Name
                            ELSE
                                strDescription := rsCustomer.Name;
                        END;
                    END
                    ELSE BEGIN
                        IF "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Vendor THEN BEGIN
                            rsVendor.RESET;
                            IF rsVendor.GET("Gen. Journal Line"."Account No.") THEN BEGIN
                                IF blnPrintCodes THEN
                                    strDescription := "Gen. Journal Line"."Account No." + ' - ' + rsVendor.Name
                                ELSE
                                    strDescription := rsVendor.Name;
                            END;
                        END
                        ELSE BEGIN
                            IF "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::"Bank Account" THEN BEGIN
                                rsBank.RESET;
                                IF rsBank.GET("Gen. Journal Line"."Account No.") THEN BEGIN
                                    IF blnPrintCodes THEN
                                        strDescription := "Gen. Journal Line"."Account No." + ' - ' + rsBank.Name
                                    ELSE
                                        strDescription := rsBank.Name;
                                END;
                            END
                            ELSE BEGIN
                                IF "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::"Fixed Asset" THEN BEGIN
                                    rsFA.RESET;
                                    IF rsFA.GET("Gen. Journal Line"."Account No.") THEN BEGIN
                                        IF blnPrintCodes THEN
                                            strDescription := "Gen. Journal Line"."Account No." + ' - ' + rsFA.Description
                                        ELSE
                                            strDescription := rsFA.Description;
                                    END;
                                END;
                            END;
                        END;
                    END;
                END;

                strContact := '';
                /*
                IF "Gen. Journal Line"."Contact No."<>'' THEN BEGIN
                   rsContact.RESET;
                   rsContact.GET("Gen. Journal Line"."Contact No.");
                   IF (strContact<>strDescription) OR (rsContact.Type=rsContact.Type::Person) THEN
                      strContact := rsContact."No." + ' - ' + rsContact.Name;
                   END;
                
                
                IF "Gen. Journal Line"."Amount Type" = "Gen. Journal Line"."Amount Type"::Credit THEN
                   strDescription := 'To ' + strDescription;
                */

                IF NOT CheckAndFillBuffer THEN
                    strDescription := '';

                strBalAccountName := '';
                IF "Gen. Journal Line"."Bal. Account Type" = "Gen. Journal Line"."Bal. Account Type"::"G/L Account" THEN BEGIN
                    GLAcc.RESET;
                    IF GLAcc.GET("Gen. Journal Line"."Bal. Account No.") THEN BEGIN
                        IF blnPrintCodes THEN
                            strBalAccountName := "Gen. Journal Line"."Bal. Account No." + ' - ' + GLAcc.Name
                        ELSE
                            strBalAccountName := GLAcc.Name;
                    END;
                END
                ELSE BEGIN
                    IF "Gen. Journal Line"."Bal. Account Type" = "Gen. Journal Line"."Bal. Account Type"::Customer THEN BEGIN
                        rsCustomer.RESET;
                        IF rsCustomer.GET("Gen. Journal Line"."Bal. Account No.") THEN BEGIN
                            IF blnPrintCodes THEN
                                strBalAccountName := "Gen. Journal Line"."Bal. Account No." + ' - ' + rsCustomer.Name
                            ELSE
                                strBalAccountName := rsCustomer.Name;
                        END;
                    END
                    ELSE BEGIN
                        IF "Gen. Journal Line"."Bal. Account Type" = "Gen. Journal Line"."Bal. Account Type"::Vendor THEN BEGIN
                            rsVendor.RESET;
                            IF rsVendor.GET("Gen. Journal Line"."Bal. Account No.") THEN BEGIN
                                IF blnPrintCodes THEN
                                    strBalAccountName := "Gen. Journal Line"."Bal. Account No." + ' - ' + rsVendor.Name
                                ELSE
                                    strBalAccountName := rsVendor.Name;
                            END;
                        END
                        ELSE BEGIN
                            IF "Gen. Journal Line"."Bal. Account Type" = "Gen. Journal Line"."Bal. Account Type"::"Bank Account" THEN BEGIN
                                rsBank.RESET;
                                IF rsBank.GET("Gen. Journal Line"."Bal. Account No.") THEN BEGIN
                                    IF blnPrintCodes THEN
                                        strBalAccountName := "Gen. Journal Line"."Bal. Account No." + ' - ' + rsBank.Name
                                    ELSE
                                        strBalAccountName := rsBank.Name;
                                END;
                            END
                            ELSE BEGIN
                                IF "Gen. Journal Line"."Bal. Account Type" = "Gen. Journal Line"."Bal. Account Type"::"Fixed Asset" THEN BEGIN
                                    rsFA.RESET;
                                    IF rsFA.GET("Gen. Journal Line"."Bal. Account No.") THEN BEGIN
                                        IF blnPrintCodes THEN
                                            strBalAccountName := "Gen. Journal Line"."Bal. Account No." + ' - ' + rsFA.Description
                                        ELSE
                                            strBalAccountName := rsFA.Description;
                                    END;
                                END;
                            END;
                        END;
                    END;
                END;

                strBalContactName := '';

                //For Balance Account Type
                dblBalDebit := 0;
                dblBalCredit := 0;
                dblBalAmount := 0;
                rsGenJnlLine2.RESET;
                rsGenJnlLine2.SETRANGE("Journal Template Name", "Gen. Journal Line"."Journal Template Name");
                rsGenJnlLine2.SETRANGE("Journal Batch Name", "Gen. Journal Line"."Journal Batch Name");
                rsGenJnlLine2.SETRANGE("Document No.", "Gen. Journal Line"."Document No.");
                IF rsGenJnlLine2.FINDSET THEN
                    REPEAT
                        dblBalAmount += rsGenJnlLine2.Amount;
                    UNTIL rsGenJnlLine2.NEXT = 0;

                IF dblBalAmount > 0 THEN
                    dblBalCredit += dblBalAmount
                ELSE
                    dblBalDebit := ABS(dblBalAmount);

                //Group Total
                TotalLineDr := 0;
                TotalLineCr := 0;

                rsGenJnlLine2.RESET;
                rsGenJnlLine2.SETRANGE("Journal Template Name", "Gen. Journal Line"."Journal Template Name");
                rsGenJnlLine2.SETRANGE("Journal Batch Name", "Gen. Journal Line"."Journal Batch Name");
                rsGenJnlLine2.SETRANGE("Account No.", "Gen. Journal Line"."Account No.");
                rsGenJnlLine2.SETRANGE("Document No.", "Gen. Journal Line"."Document No.");
                IF rsGenJnlLine2.COUNT > 1 THEN
                    blnMultiple := TRUE
                ELSE
                    blnMultiple := FALSE;
                IF rsGenJnlLine2.FINDSET THEN
                    REPEAT
                        TotalLineDr += (rsGenJnlLine2."Debit Amount");
                        TotalLineCr += (rsGenJnlLine2."Credit Amount");
                    // IF (rsGenJnlLine2."Total TDS/TCS Incl. SHE CESS" <> 0) AND (rsGenJnlLine2."Credit Amount" <> 0) THEN
                    //     TotalLineCr += (rsGenJnlLine2."Total TDS/TCS Incl. SHE CESS");

                    // IF rsGenJnlLine2."Service Tax Amount" <> 0 THEN
                    //     TotalLineCr += rsGenJnlLine2."Service Tax Amount" + rsGenJnlLine2."Service Tax eCess Amount" +
                    //       rsGenJnlLine2."Service Tax SHE Cess Amount";
                    UNTIL rsGenJnlLine2.NEXT = 0;


                IF OldDocNo <> "Document No." THEN BEGIN
                    OldDocNo := "Document No.";
                    TotCreditAmt := 0;
                    TotDebitAmt := 0;
                    GenJnlLine.RESET;
                    GenJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                    GenJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    GenJnlLine.SETRANGE("Document No.", "Document No.");
                    IF GenJnlLine.FINDSET THEN BEGIN
                        REPEAT
                            IF GenJnlLine.Amount > 0 THEN
                                TotDebitAmt += GenJnlLine."Debit Amount"
                            ELSE
                                TotCreditAmt += GenJnlLine."Credit Amount";
                        UNTIL GenJnlLine.NEXT = 0;
                        IF TotDebitAmt = 0 THEN
                            TotDebitAmt := TotCreditAmt;
                        IF TotCreditAmt = 0 THEN
                            TotCreditAmt := TotDebitAmt;
                    END;
                END;


                blnLinePrint := FALSE;

                ChequeString := '';
                // IF ("Cheque No." <> '') AND ("Cheque Date" <> 0D) THEN
                //     ChequeString := STRSUBSTNO(Text068, "Cheque No.", "Cheque Date", '');

                strExternal := '';
                IF "External Document No." <> '' THEN
                    strExternal := 'Bill  No. ' + "External Document No.";//+' Dated ' +FORMAT("Document Date");

                strMatter := '';


                dblTotalTDS := 0;
                dblTDS := 0;
                dblSurcharge := 0;
                dblECess := 0;


                // IF "Total TDS/TCS Incl. SHE CESS" <> 0 THEN BEGIN
                //     rsTDSGroup.RESET;
                //     rsTDSGroup.SETRANGE("TDS Group", "TDS Group");
                //     rsTDSGroup.SETFILTER("Effective Date", '<=%1', "Posting Date");
                //     IF rsTDSGroup.FIND('+') THEN BEGIN
                //         GLAcc.RESET;
                //         GLAcc.SETRANGE("No.", rsTDSGroup."TDS Account");
                //         IF GLAcc.FIND('-') THEN BEGIN
                //             IF blnPrintCodes THEN
                //                 strTDSAccount := 'To ' + GLAcc."No." + ' - ' + GLAcc.Name
                //             ELSE
                //                 strTDSAccount := 'To ' + GLAcc.Name;
                //         END;
                //     END;
                //     dblTotalTDS := ROUND(ABS("Total TDS/TCS Incl. SHE CESS"), 1);
                //     dblTDS := ROUND(ABS("TDS/TCS Amount"), 1);
                //     dblSurcharge := ABS("Surcharge Amount");
                //     dblECess := ABS("eCESS on TDS/TCS Amount");
                //     //   TotCreditAmt += abs("Gen. Journal Line2"."Total TDS Including eCESS");
                //     dblGrandTotalTDS += ABS("Total TDS/TCS Incl. SHE CESS");
                //     IF (strBalAccountName <> '') AND (dblBalCredit <> 0) THEN
                //         dblBalCredit -= ABS("Total TDS/TCS Incl. SHE CESS");
                // END;


                dblWorkTax := 0;
                dblTotalWorkTaxDr := 0;
                dblTotalWorkTaxCr := 0;
                strWorkTaxAccount := '';
                // IF "Work Tax Amount" <> 0 THEN BEGIN
                //     rsTDSGroup.RESET;
                //     rsTDSGroup.SETRANGE("TDS Group", "Work Tax Group");
                //     rsTDSGroup.SETFILTER("Effective Date", '<=%1', "Posting Date");
                //     IF rsTDSGroup.FIND('+') THEN BEGIN
                //         GLAcc.RESET;
                //         GLAcc.SETRANGE("No.", rsTDSGroup."TDS Account");
                //         IF GLAcc.FIND('-') THEN BEGIN
                //             IF blnPrintCodes THEN
                //                 strWorkTaxAccount := 'To ' + GLAcc."No." + ' - ' + GLAcc.Name
                //             ELSE
                //                 strWorkTaxAccount := 'To ' + GLAcc.Name;
                //         END;
                //     END;

                // dblWorkTax := "Service Tax Amount";
                // dblTotalWorkTaxCr := ABS("Work Tax Amount");
                // END;


                dblServiceTax := 0;
                dblServiceTaxCESS := 0;
                dblServiceTaxShe := 0;
                DblSwachhBhartCess := 0;
                dblTotalServiceTaxDr := 0;
                dblTotalServiceTaxCr := 0;
                // IF "Service Tax Amount" <> 0 THEN BEGIN
                //     rsServiceTaxSetup.RESET;
                //     rsServiceTaxSetup.SETRANGE(Code, "Service Tax Group Code");
                //     rsServiceTaxSetup.SETFILTER("From Date", '<=%1', "Posting Date");
                //     IF rsServiceTaxSetup.FIND('+') THEN BEGIN
                //         GLAcc.RESET;
                //         IF "Service Tax Amount" + "Service Tax eCess Amount" > 0 THEN
                //             GLAcc.SETRANGE("No.", rsServiceTaxSetup."Service Tax Receivable Account")
                //         ELSE
                //             GLAcc.SETRANGE("No.", rsServiceTaxSetup."Service Tax Payable Account");

                //         IF GLAcc.FIND('-') THEN BEGIN
                //             IF blnPrintCodes THEN
                //                 strServiceTaxAccount := GLAcc."No." + ' - ' + GLAcc.Name
                //             ELSE
                //                 strServiceTaxAccount := GLAcc.Name;
                //         END;
                //     END;

                //     dblServiceTax := "Service Tax Amount";
                //     dblServiceTaxCESS := "Service Tax eCess Amount";
                //     dblServiceTaxShe := "Service Tax SHE Cess Amount";
                //     DblSwachhBhartCess := "Service Tax SBC Amount";

                //     IF "Service Tax Amount" + "Service Tax eCess Amount" > 0 THEN
                //         dblTotalServiceTaxDr := "Service Tax Amount" + "Service Tax eCess Amount" +
                //          "Service Tax SHE Cess Amount"
                //     ELSE
                //         dblTotalServiceTaxCr := ABS("Service Tax Amount" + "Service Tax eCess Amount" +
                //         "Service Tax SHE Cess Amount");

                //     TotCreditAmt += ABS("Service Tax Amount" + "Service Tax eCess Amount" +
                //     "Service Tax SHE Cess Amount" + "Service Tax SBC Amount");
                //     TotDebitAmt += ABS("Service Tax Amount" + "Service Tax eCess Amount" +
                //     "Service Tax SHE Cess Amount" + "Service Tax SBC Amount");

                // END;

                CLEAR(DimString);
                i := 0;
                IF blnPrintAllDimensions = TRUE THEN BEGIN
                    DimSetEntry.RESET;
                    DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                    IF DimSetEntry.FINDSET THEN BEGIN
                        REPEAT
                            DimValue.RESET;
                            DimValue.SETRANGE("Dimension Code", DimSetEntry."Dimension Code");
                            DimValue.SETFILTER(Code, DimSetEntry."Dimension Value Code");
                            IF DimValue.FIND('-') THEN BEGIN
                                i += 1;
                                Dimenson.GET(DimSetEntry."Dimension Code");
                                DimString[i] := COPYSTR(Dimenson.Name, 1, 3) + '-';
                                DimString[i] := DimString[i] + DimValue.Name;
                            END;
                        UNTIL DimSetEntry.NEXT = 0;
                    END;
                END;



                LineDr := "Debit Amount";
                LineCr := "Credit Amount";

                LineAmount := 0;
                LineDrCr := '';

                IF (LineDr <> 0) AND (blnMultiple) THEN BEGIN
                    LineAmount := LineDr;
                    LineDrCr := 'Dr';
                END;

                IF (LineCr <> 0) AND (blnMultiple) THEN BEGIN
                    LineAmount := LineCr;
                    LineDrCr := 'Cr';
                END;

                VouchNarr := '';
                // GenJouNarration.RESET;
                // GenJouNarration.SETRANGE("Journal Template Name", "Gen. Journal Line"."Journal Template Name");
                // GenJouNarration.SETRANGE("Journal Batch Name", "Gen. Journal Line"."Journal Batch Name");
                // GenJouNarration.SETRANGE(GenJouNarration."Document No.", "Gen. Journal Line"."Document No.");
                // GenJouNarration.SETFILTER("Line No.", '<>%1', "Line No.");
                // IF GenJouNarration.FINDFIRST THEN BEGIN
                //     REPEAT
                //         IF DocNo <> GenJouNarration."Document No." THEN
                //             IF VouchNarr <> '' THEN
                //                 VouchNarr += '|' + GenJouNarration.Narration
                //             ELSE
                //                 VouchNarr := GenJouNarration.Narration;
                //         DocNo := GenJouNarration."Document No.";
                //     UNTIL GenJouNarration.NEXT = 0;
                // END;

                Check.InitTextVariable;
                Check.FormatNoText(NumberText, ABS(TotDebitAmt), '');

            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET();

                TotDebitAmt := 0;
                TotCreditAmt := 0;

                strLastAccountNo := '';
                dblGrandTotalTDS := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Print all dimensions"; blnPrintAllDimensions)
                {
                    Visible = false;
                }
                field("Print Account codes"; blnPrintCodes)
                {
                    Visible = false;
                }
                field("For dim. line narration"; bolDim)
                {
                    Visible = false;
                }
                field(TEXT; TEXT)
                {
                    Visible = false;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        SwachhBhartCessLbl = 'Swachh Bhart Cess';
        KKCessLbl = 'KK Cess';
    }

    trigger OnInitReport()
    begin
        blnPrintCodes := TRUE;
        blnPrintAllDimensions := TRUE;
    end;

    trigger OnPreReport()
    begin
        GenJnlLineTemp.DELETEALL;
    end;

    var
        CompanyInformation: Record "Company Information";
        Text066: Label 'E-Mail : %1';
        rsJob: Record Job;
        DimSetEntry: Record "Dimension Set Entry";
        //rsTDSGroup: Record "TDS Group";
        GLAcc: Record "G/L Account";
        rsCustomer: Record Customer;
        rsVendor: Record Vendor;
        rsFA: Record "Fixed Asset";
        rsBank: Record "Bank Account";
        rsJnlBatch: Record "Gen. Journal Batch";
        rsGenJnlLine2: Record "Gen. Journal Line";
        GenJnlLineTemp: Record "Gen. Journal Line" temporary;
        rsContact: Record Contact;
        //rsServiceTaxSetup: Record "Service Tax Setup";
        "RECSalesperson/Purchaser": Record "Salesperson/Purchaser";
        GenJnlLine: Record "Gen. Journal Line";
        Dimenson: Record Dimension;
        DimValue: Record "Dimension Value";
        Check: Report Check;
        ChequeString: Text[80];
        NumberText: array[2] of Text[150];
        strLastAccountNo: Text[30];
        Text067: Label 'Being Cheque No : %1 dated %2 payable at %3';
        Text068: Label 'Being Cheque No : %1 dated %2%3';
        Text069: Label '%1   %2';
        VouchNarr: Text;
        strMatter: Text[100];
        strDimension: Text[100];
        strTDSAccount: Text[100];
        strDescription: Text[100];
        strContact: Text[100];
        strBalAccountName: Text[100];
        strBalContactName: Text[100];
        CRDR1: Text[30];
        CRDR2: Text[30];
        LineDrCr: Text[30];
        strExternal: Text[100];
        strServiceTaxAccount: Text[100];
        strWorkTaxAccount: Text[100];
        TEXT: Text[30];
        txtDimensionLine: Text[250];
        Credit__INR_CaptionLbl: Label 'Credit (INR)';
        Debit__INR_CaptionLbl: Label 'Debit (INR)';
        Account_NameCaptionLbl: Label 'Account Name';
        NARRATION_CaptionLbl: Label 'NARRATION:';
        Prepared_ByCaptionLbl: Label 'Prepared By';
        Checked_by_CaptionLbl: Label 'Checked by:';
        Authorised_SignatoryCaptionLbl: Label 'Authorised Signatory';
        TDS_AmountCaptionLbl: Label 'TDS Amount';
        SurchargeCaptionLbl: Label 'Surcharge';
        ECESSCaptionLbl: Label 'ECESS';
        SHE_Cess_AmountCaptionLbl: Label 'SHE Cess Amount';
        DimString: array[12] of Text[1024];
        dblWorkTax: Decimal;
        dblTotalWorkTaxDr: Decimal;
        dblTotalWorkTaxCr: Decimal;
        dblServiceTaxShe: Decimal;
        DblSwachhBhartCess: Decimal;
        TotDebitAmt: Decimal;
        TotCreditAmt: Decimal;
        dblTDS: Decimal;
        dblSurcharge: Decimal;
        dblECess: Decimal;
        dblTotalTDS: Decimal;
        dblBalDebit: Decimal;
        dblBalCredit: Decimal;
        AMT_CUST: Decimal;
        AMT_VEN: Decimal;
        LineDr: Decimal;
        LineCr: Decimal;
        LineAmount: Decimal;
        TotalLineDr: Decimal;
        TotalLineCr: Decimal;
        dblBalAmount: Decimal;
        dblGrandTotalTDS: Decimal;
        dblServiceTax: Decimal;
        dblServiceTaxCESS: Decimal;
        dblTotalServiceTaxDr: Decimal;
        dblTotalServiceTaxCr: Decimal;
        blnPrint: Boolean;
        blnPrintCodes: Boolean;
        blnLinePrint: Boolean;
        blnMultiple: Boolean;
        blnPrintAllDimensions: Boolean;
        bolDim: Boolean;
        ChequeDate: Date;
        ChequeNo: Code[20];
        OldDocNo: Code[20];
        i: Integer;
        //GenJouNarration: Record "16549";
        DocNo: Code[40];
        CompanyNameText: Text;

    procedure CheckAndFillBuffer(): Boolean
    var
        LineNo: Integer;
    begin
        GenJnlLineTemp.RESET;
        GenJnlLineTemp.SETRANGE("Document No.", "Gen. Journal Line"."Document No.");
        GenJnlLineTemp.SETRANGE("Account Type", "Gen. Journal Line"."Account Type"::"G/L Account");
        GenJnlLineTemp.SETRANGE("Account No.", "Gen. Journal Line"."Account No.");
        IF NOT GenJnlLineTemp.FINDFIRST THEN BEGIN
            GenJnlLineTemp.INIT;
            GenJnlLineTemp."Journal Template Name" := "Gen. Journal Line"."Journal Template Name";
            GenJnlLineTemp."Journal Batch Name" := "Gen. Journal Line"."Journal Batch Name";
            GenJnlLineTemp."Line No." := "Gen. Journal Line"."Line No.";
            GenJnlLineTemp.INSERT;
            GenJnlLineTemp."Account Type" := "Gen. Journal Line"."Account Type";
            GenJnlLineTemp."Account No." := "Gen. Journal Line"."Account No.";
            GenJnlLineTemp."Document No." := "Gen. Journal Line"."Document No.";
            GenJnlLineTemp.MODIFY;
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;
}

