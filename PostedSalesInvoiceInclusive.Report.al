report 50042 "Posted Sales Invoice Inclusive"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PostedSalesInvoiceInclusive.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
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
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
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
                column(Amount_SalesLine; "Sales Invoice Line"."Service Tax(PIT)")
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(ServiceTaxAmount_SalesLine; 0)
                {
                }
                column(AmountToCustomer_SalesLine; Amount)
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
                column(ChargesToCustomer_SalesLine; 0)
                {
                }
                column(MilestoneDescription; MilestoneDescription)
                {
                }
                column(ServiceTaxeCessAmount_SalesInvoiceLine; 0)
                {
                }
                column(ServiceTaxSHECessAmount_SalesInvoiceLine; 0)
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
                column(ServiceTaxSBCAmount_SalesInvoiceLine; 0)
                {
                }
                column(KKCessAmount_SalesInvoiceLine; 0)
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
                        ProjectTask.SETRANGE("job No.", "Job No.");
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
                    // ServiceTaxSetup.SETRANGE(Code, "Service Tax Group");
                    // ServiceTaxSetup.SETRANGE("From Date", 0D, "Sales Invoice Header"."Posting Date");
                    // IF ServiceTaxSetup.FINDLAST THEN
                    //     TaxPer := ServiceTaxSetup."Service Tax %";

                    "Sales Invoice Header".CALCFIELDS(Amount);
                    Check.InitTextVariable;
                    Check.FormatNoText(AmountInWord, "Sales Invoice Header".Amount, "Sales Invoice Header"."Currency Code");
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
}

