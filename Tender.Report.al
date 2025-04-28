report 50025 Tender
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/Tender.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Tender; Tender)
        {
            RequestFilterFields = "Tender No.", "Prospect No.";
            column(TenderName_Tender; Tender."Tender Name" + ' /(' + Tender."Prospect Name" + ')')
            {
            }
            column(ProspectName_Tender; Tender."Prospect Name")
            {
            }
            column(State_Tender; Tender.State)
            {
            }
            column(DateOfReceipt_Tender; Tender."Date Of Receipt")
            {
            }
            column(TenderDateDateofSubmission_Tender; Tender."Tender Date/Date of Submission")
            {
            }
            column(TeamLead_Tender; Tender."Team Lead.")
            {
            }
            column(ProjectValue_Tender; Tender."Project Value")
            {
            }
            column(EMD_Tender; Tender.EMD)
            {
            }
            column(Eligibility_Tender; Tender.Eligibility)
            {
            }
            column(ReasonForNotEligible_Tender; Tender."Reason For Not Eligible")
            {
            }
            column(BidNoBid_Tender; Tender."Bid/No Bid")
            {
            }
            column(BidTeam_Tender; Tender."Bid Team")
            {
            }
            column(Rate_Tender; Tender.Rate)
            {
            }
            column(ExpectedMargin_Tender; Tender."Expected Margin(%)")
            {
            }
            column(QuotesApprover_Tender; Tender."Quotes Approver")
            {
            }
            column(Competitors_Tender; Tender.Competitors)
            {
            }
            column(StatusOfTender_Tender; Tender."Status Of Tender")
            {
            }
            column(L1L2L3_Tender; Tender."L1/L2/L3")
            {
            }
            column(ReasonsForFailure_Tender; Tender."Reasons For Failure")
            {
            }
            column(CName; CompInfo.Name + '  ' + CompInfo."Name 2")
            {
            }
            column(CAddress; CompInfo.Address + '  ' + CompInfo."Address 2" + ' , ' + CompInfo.City + ' - ' + CompInfo."Post Code")
            {
            }
            column(CPicture; CompInfo.Picture)
            {
            }
            column(SrNo; SrNo)
            {
            }
            column(Filters; 'Period :- ' + Tender.GETFILTER(Tender."Tender Date/Date of Submission"))
            {
            }
            column(StateCode; StateCode)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(EMDRecoveryStatus_Tender; Tender."EMD Recovery Status")
            {
            }
            column(EMDRecoveredDate_Tender; Tender."EMD Recovered Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                SrNo += 1;
                StateCode := '';
                IF TemporaryCustomer.GET(Tender."Prospect No.") THEN
                    IF TemporaryCustomer."State Code" <> '' THEN
                        StateCode := TemporaryCustomer."State Code"
                    ELSE
                        StateCode := TemporaryCustomer."Country/Region Code";
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(CompInfo.Picture);
                SETRANGE("Tender Date/Date of Submission", StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

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
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            Month := DATE2DMY(TODAY, 2);
            Fyear := DATE2DMY(TODAY, 3);
            IF Month IN [1, 2, 3] THEN
                Fyear1 := Fyear - 1
            ELSE
                Fyear1 := Fyear;

            StartDate := DMY2DATE(1, 4, Fyear1);
            EndDate := TODAY;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Tender Open" = FALSE THEN
            ERROR('You cannot run report');
    end;

    var
        CompInfo: Record "Company Information";
        SrNo: Integer;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Fyear: Integer;
        Fyear1: Integer;
        StateCode: Code[10];
        TemporaryCustomer: Record "Temporary Customer";
        UserSetup: Record "User Setup";
}

