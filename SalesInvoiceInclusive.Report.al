report 50041 "Sales Invoice Inclusive"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/SalesInvoiceInclusive.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Invoice));
            RequestFilterFields = "No.";
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesHeader; "Sales Header"."Bill-to Name")
            {
            }
            column(BilltoName2_SalesHeader; "Sales Header"."Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesHeader; "Sales Header"."Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesHeader; "Sales Header"."Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesHeader; "Sales Header"."Bill-to City")
            {
            }
            column(BilltoContact_SalesHeader; "Sales Header"."Bill-to Contact")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(CompanyName; CompInfo.Name)
            {
            }
            column(CompanyAddress; CompInfo.Address + ',' + CompInfo."Address 2")
            {
            }
            column(CompanyCity; CompInfo.City + '-' + CompInfo."Post Code")
            {
            }
            column(PhoneNo; CompInfo."Phone No.")
            {
            }
            column(CompServiceTaxRegNo; CompInfo."GST Registration No.")
            {
            }
            column(CompPanNo; CompInfo."P.A.N. No.")
            {
            }
            column(CompCinNo; CompInfo."CIN No.")
            {
            }
            column(PostingDate_SalesHeader; "Sales Header"."Posting Date")
            {
            }
            column(CurrencyCode_SalesHeader; CurrencyCode)
            {
            }
            column(SalesRemarks; SalesRemarks)
            {
            }
            column(ProjectName; ProjectName)
            {
            }
            column(UseAs_Invoice; UseAsInvoice)
            {
            }
            column(UseAsInvoiceText_1; UseAsInvoiceText[1])
            {
            }
            column(UseAsInvoiceText_2; UseAsInvoiceText[2])
            {
            }
            column(UseAsInvoiceText_3; UseAsInvoiceText[3])
            {
            }
            column(UseAsInvoiceText_4; UseAsInvoiceText[4])
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(DocumentNo_SalesLine; "Sales Line"."Document No.")
                {
                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                }
                column(Description2_SalesLine; "Sales Line"."Description 2")
                {
                }
                column(Amount_SalesLine; "Sales Line"."Service Tax(PIT)")
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(ServiceTaxAmount_SalesLine; 0)
                {
                }
                column(AmountToCustomer_SalesLine; TotalAmount)
                {
                }
                column(MilestoneStage; MilestoneStage)
                {
                }
                column(AmountInWord1; AmountInWord[1])
                {
                }
                column(ChargesToCustomer_SalesLine; 0)
                {
                }
                column(MilestoneDescription; MilestoneDescription)
                {
                }
                column(ServiceTaxeCessAmount_SalesLine; 0)
                {
                }
                column(ServiceTaxSHECessAmount_SalesLine; 0)
                {
                }
                column(AgreementNo; Project."Agreement No.")
                {
                }
                column(ProjectValue; Project."Project Value")
                {
                }
                column(TaxPer; TaxPer)
                {
                }
                column(ServiceTaxSBCAmount_SalesLine; 0)
                {
                }
                column(KKCessAmount_SalesLine; 0)
                {
                }
                column(AmounttoCustomer; "Sales Line"."Service Tax(PIT)")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    MilestoneDescription := '';
                    MilestoneStage := 0;
                    ProjectTask.RESET;
                    ProjectTask.SETRANGE("JoB No.", "Job No.");
                    ProjectTask.SETRANGE("Job Task No.", "Job Task No.");
                    ProjectTask.SETRANGE(Milestone, Milestone);
                    IF ProjectTask.FINDFIRST THEN BEGIN
                        MilestoneDescription := ProjectTask."Milestone Desc";
                        MilestoneStage := ProjectTask."Milestone Stages";
                    END ELSE
                        MilestoneDescription := Description + ' ' + "Description 2";

                    SrNo += 1;

                    TaxPer := 0;
                    // ServiceTaxSetup.SETRANGE(Code,"Service Tax Group");
                    // ServiceTaxSetup.SETRANGE("From Date",0D,"Sales Header"."Posting Date");
                    // IF ServiceTaxSetup.FINDLAST THEN
                    //  TaxPer := ServiceTaxSetup."Service Tax %";

                    "Sales Header".CALCFIELDS(Amount);
                    TotalAmount := ROUND("Sales Header".Amount);

                    Amt := 0;
                    STaxAmt := 0;
                    eCessAmt := 0;
                    SHECessAmt := 0;
                    SBCAmt := 0;
                    KKCessAmt := 0;
                    AmtToCust := 0;
                    SaleLine.RESET;
                    SaleLine.SETRANGE("Document No.", "Document No.");
                    IF SaleLine.FINDFIRST THEN BEGIN
                        REPEAT
                            Amt += SaleLine."Service Tax(PIT)";
                        //    STaxAmt+= SaleLine."Service Tax Amount";
                        //    eCessAmt +=SaleLine."Service Tax eCess Amount";
                        //    SHECessAmt+=SaleLine."Service Tax SHE Cess Amount";
                        //    SBCAmt+=  SaleLine."Service Tax SBC Amount";
                        //    KKCessAmt+=SaleLine."KK Cess Amount";
                        //    AmtToCust+=SaleLine."Service Tax(PIT)";
                        UNTIL SaleLine.NEXT = 0;
                    END;

                    TotalAmount := ROUND(Amt, 1) + ROUND(STaxAmt, 1) + ROUND(eCessAmt, 1) + ROUND(SHECessAmt, 1) + ROUND(SBCAmt, 1) + ROUND(KKCessAmt, 1);

                    Check.InitTextVariable;
                    Check.FormatNoText(AmountInWord, AmtToCust, "Sales Header"."Currency Code");

                    //Message('%1-%2-%3-%4-%5-%6',ROUND(Amt),ROUND(STaxAmt),ROUND(eCessAmt),ROUND(SHECessAmt),ROUND(SBCAmt),ROUND(KKCessAmt));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SalesRemarks := '';
                SalesCommentLine.SETRANGE("Document Type", "Document Type");
                SalesCommentLine.SETRANGE("No.", "No.");
                IF SalesCommentLine.FINDSET THEN
                    REPEAT
                        IF SalesRemarks <> '' THEN
                            SalesRemarks += ' ' + SalesCommentLine.Comment
                        ELSE
                            SalesRemarks := SalesCommentLine.Comment;
                    UNTIL SalesCommentLine.NEXT = 0;

                IF "Currency Code" <> '' THEN
                    CurrencyCode := "Currency Code"
                ELSE
                    CurrencyCode := 'INR';

                //AD_REPL
                CLEAR(UseAsInvoiceText);
                IF UseAsInvoice THEN BEGIN
                    UseAsInvoiceText[1] := 'Invoice';
                    UseAsInvoiceText[2] := 'Invoice Number';
                    UseAsInvoiceText[3] := 'Invoice Date';
                    UseAsInvoiceText[4] := 'Invoice Currency';
                END ELSE BEGIN
                    UseAsInvoiceText[1] := 'Proforma Invoice';
                    UseAsInvoiceText[2] := 'Proforma Invoice Number';
                    UseAsInvoiceText[3] := 'Proforma Invoice Date';
                    UseAsInvoiceText[4] := 'Proforma Invoice Currency';
                END;
                //AD_REPL


                /*
                MilestoneDescription := '';
                MilestoneStage :=0;
                ProjectName := '';
                ProjectTask.RESET;
                ProjectTask.SETRANGE("Project No.","Job No.");
                ProjectTask.SETRANGE("Project Task No.","Job Task No.");
                ProjectTask.SETRANGE(Milestone,Milestone);
                IF ProjectTask.FINDFIRST THEN BEGIN
                 MilestoneDescription := ProjectTask."Milestone Desc";
                 MilestoneStage := ProjectTask."Milestone Stages";
                 ProjectName := ProjectTask.Name;
                END ELSE
                 MilestoneDescription := Description + ' '+"Description 2";
                IF Project.GET("Job No.") THEN;
                */

                ProjectName := '';
                SaleLine.RESET;
                SaleLine.SETRANGE("Document No.", "No.");
                SaleLine.SETFILTER("Job No.", '<>%1', '');
                IF SaleLine.FINDFIRST THEN BEGIN
                    Project.GET(SaleLine."Job No.");
                    ProjectName := Project.Description + ' ' + Project."Description 2";
                END;
                SaleLine.RESET;
                SaleLine.SETRANGE("Document No.", "No.");
                SaleLine.SETFILTER("Job No.", '=%1', '');
                IF SaleLine.FINDFIRST THEN BEGIN
                    CostCenter := SaleLine."Shortcut Dimension 1 Code";
                    Project.SETRANGE("Global Dimension 1 Code", CostCenter);
                    IF Project.FINDFIRST THEN
                        ProjectName := Project.Description + ' ' + Project."Description 2";
                END;

            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(CompInfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(UseAsInvoice; UseAsInvoice)
                {
                    Caption = 'Use As Invoice';
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

    var
        CompInfo: Record "Company Information";
        SrNo: Integer;
        ProjectTask: Record "Job Task";
        MilestoneStage: Integer;
        ProjectName: Text;
        Check: Report Check;
        AmountInWord: array[2] of Text;
        TotalAmt: Decimal;
        MilestoneDescription: Text;
        Project: Record Job;
        SalesCommentLine: Record "Sales Comment Line";
        SalesRemarks: Text;
        CurrencyCode: Code[10];
        //ServiceTaxSetup: Record "16472";
        TaxPer: Decimal;
        TotalAmount: Decimal;
        SaleLine: Record "Sales Line";
        STaxAmt: Decimal;
        eCessAmt: Decimal;
        SHECessAmt: Decimal;
        SBCAmt: Decimal;
        KKCessAmt: Decimal;
        Amt: Decimal;
        ProjectNo: Code[100];
        CostCenter: Code[50];
        AmtToCust: Decimal;
        UseAsInvoice: Boolean;
        UseAsInvoiceText: array[5] of Text;
}

