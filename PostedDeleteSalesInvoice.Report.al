report 50045 "Posted Delete Sales Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PostedDeleteSalesInvoice.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem("Sales Delete Invoice Header"; "Sales Delete Invoice Header")
        {
            RequestFilterFields = "No.";
            column(No_SalesHeader; "No.")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesHeader; "Bill-to Name")
            {
            }
            column(BilltoName2_SalesHeader; "Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesHeader; "Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesHeader; "Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesHeader; "Bill-to City")
            {
            }
            column(BilltoContact_SalesHeader; "Bill-to Contact")
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
            column(ServiceTaxNo; CompInfo."GST Registration No.")
            {
            }
            column(PanNo; CompInfo."P.A.N. No.")
            {
            }
            column(CinNo; CompInfo."CIN No.")
            {
            }
            column(PostingDate_SalesHeader; "Posting Date")
            {
            }
            column(CurrencyCode_SalesHeader; CurrencyCode)
            {
            }
            column(SalesRemarks; SalesRemarks)
            {
            }
            dataitem("Sales Delete Invoice Line"; "Sales Delete Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(DocumentNo_SalesLine; "Document No.")
                {
                }
                column(No_SalesLine; "No.")
                {
                }
                column(Description_SalesLine; Description)
                {
                }
                column(Description2_SalesLine; "Description 2")
                {
                }
                column(Amount_SalesLine; "Sales Delete Invoice Line"."Deleted Amount")
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(ServiceTaxAmount_SalesLine; ServiceTaxAmount)
                {
                }
                column(AmountToCustomer_SalesLine; TotalAmount)
                {
                }
                column(MilestoneStage; MilestoneStage)
                {
                }
                column(ProjectName; ProjectName)
                {
                }
                column(AmountInWord1; AmountInWord[1])
                {
                }
                column(ChargesToCustomer_SalesLine; "Charges To Customer")
                {
                }
                column(MilestoneDescription; MilestoneDescription)
                {
                }
                column(AgreementNo; AgreementNo)
                {
                }
                column(ProjectValue; ProjectValue)
                {
                }
                column(TaxPer; TaxPer)
                {
                }
                column(ServiceTaxSBCAmount_SalesInvoiceLine; SBCAmount)
                {
                }
                column(KKCessAmount_SalesInvoiceLine; KKCAmount)
                {
                }
                column(TaxAmount_SalesInvoiceLine; "Sales Delete Invoice Line"."Tax Amount")
                {
                }
                column(TaxGroupCode; COPYSTR("Tax Group Code", 1, 3) + ' ' + FORMAT("Tax %") + '%')
                {
                }
                column(TaxPer_SBC; TaxPer_SBC)
                {
                }
                column(TaxPer_KKC; TaxPer_KKC)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SrNo += 1;
                    MilestoneDescription := '';
                    MilestoneStage := 0;
                    ProjectName := '';
                    AgreementNo := '';
                    ProjectValue := '';
                    IF "Job No." <> '' THEN BEGIN
                        ProjectTask.RESET;
                        ProjectTask.SETRANGE("Job No.", "Job No.");
                        ProjectTask.SETRANGE("Job Task No.", "Job Task No.");
                        ProjectTask.SETRANGE(Milestone, Milestone);
                        IF ProjectTask.FINDFIRST THEN BEGIN
                            MilestoneDescription := ProjectTask."Milestone Desc";
                            MilestoneStage := ProjectTask."Milestone Stages";
                            ProjectName := ProjectTask.Description;
                        END;
                        IF Project.GET("Job No.") THEN BEGIN
                            AgreementNo := 'Agreement No. ' + Project."Agreement No.";
                            ProjectValue := 'Project Value ' + FORMAT(Project."Project Value");
                        END;
                    END ELSE
                        MilestoneDescription := Description + "Description 2";

                    TaxPer := 0;
                    TaxPer_SBC := 0;
                    TaxPer_KKC := 0;
                    // ServiceTaxSetup.SETRANGE(Code, "Service Tax Group");
                    // ServiceTaxSetup.SETFILTER("From Date", '<=%1', "Sales Delete Invoice Header"."Posting Date");
                    // IF ServiceTaxSetup.FINDLAST THEN BEGIN
                    //     TaxPer := ServiceTaxSetup."Service Tax %";
                    //     TaxPer_SBC := ServiceTaxSetup."SB Cess%";
                    //     TaxPer_KKC := ServiceTaxSetup."KK Cess%";
                    // END;

                    ServiceTaxAmount := 0;
                    SBCAmount := 0;
                    KKCAmount := 0;

                    ServiceTaxAmount := ROUND("Deleted Amount" * (TaxPer / 100), 1);
                    SBCAmount := ROUND("Deleted Amount" * (TaxPer_SBC / 100), 1);
                    KKCAmount := ROUND("Deleted Amount" * (TaxPer_KKC / 100), 1);

                    TotalAmount += ServiceTaxAmount + SBCAmount + KKCAmount + "Deleted Amount";

                    Check.InitTextVariable;
                    Check.FormatNoText(AmountInWord, TotalAmount, "Sales Delete Invoice Header"."Currency Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SalesRemarks := '';
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
        SalesCommentLine: Record "Sales Comment Line";
        SalesRemarks: Text;
        Project: Record Job;
        CurrencyCode: Code[10];
        //ServiceTaxSetup: Record "16472";
        TaxPer: Decimal;
        AgreementNo: Code[100];
        ProjectValue: Text;
        ServiceTaxAmount: Decimal;
        SBCAmount: Decimal;
        KKCAmount: Decimal;
        TotalAmount: Decimal;
        TaxPer_SBC: Decimal;
        TaxPer_KKC: Decimal;
}

