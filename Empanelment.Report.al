report 50026 Empanelment
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/Empanelment.rdl';
    PaperSourceFirstPage = LargeFormat;
    PreviewMode = PrintLayout;
    TransactionType = Report;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(Empanelment; Empanelment)
        {
            column(ImpanelmentNo_Empanelment; Empanelment."Empanelment No.")
            {
            }
            column(ImpanelmentName_Empanelment; Empanelment."Empanelment Name")
            {
            }
            column(ClientNo_Empanelment; Empanelment."Client No.")
            {
            }
            column(ClientNameAddress_Empanelment; Empanelment."Client Name & Address")
            {
            }
            column(ClientPhoneNo_Empanelment; Empanelment."Client Phone No.")
            {
            }
            column(ClientEmailId_Empanelment; Empanelment."Client Email Id")
            {
            }
            column(State_Empanelment; Empanelment.State)
            {
            }
            column(Source_Empanelment; Empanelment.Source)
            {
            }
            column(DateOfReceipt_Empanelment; Empanelment."Date Of Receipt")
            {
            }
            column(TenderDateDateofSubmission_Empanelment; Empanelment."Tender Date/Date of Submission")
            {
            }
            column(Department_Empanelment; Empanelment.Department)
            {
            }
            column(TeamLead_Empanelment; Empanelment."Team Lead")
            {
            }
            column(EmpanelmentFee_Empanelment; Empanelment."Empanelment Fee")
            {
            }
            column(EMDDetail_Empanelment; Empanelment."EMD Detail")
            {
            }
            column(EMD_Empanelment; Empanelment.EMD)
            {
            }
            column(EMDDate_Empanelment; Empanelment."EMD Date")
            {
            }
            column(EMDExpiryDate_Empanelment; Empanelment."EMD Expiry Date")
            {
            }
            column(EMDRecoveryStatus_Empanelment; Empanelment."EMD Recovery Status")
            {
            }
            column(OtherExpenses_Empanelment; Empanelment."Other Expenses")
            {
            }
            column(RemarksOtherExpenses_Empanelment; Empanelment."Remarks (Other Expenses)")
            {
            }
            column(Eligibility_Empanelment; Empanelment.Eligibility)
            {
            }
            column(ReasonForNotEligible_Empanelment; Empanelment."Reason For Not Eligible")
            {
            }
            column(AppliedNotApplied_Empanelment; Empanelment."Applied/Not Applied")
            {
            }
            column(ReasonForNotAppliedNot_Empanelment; Empanelment."Reason For Not Applied/Not")
            {
            }
            column(Competitors_Empanelment; Empanelment.Competitors)
            {
            }
            column(StatusOfImpanelment_Empanelment; Empanelment."Status Of Empanelment")
            {
            }
            column(ReasonsForNotEmpanneled_Empanelment; Empanelment."Reasons For Not Empanneled")
            {
            }
            column(EmpanelmentforYear_Empanelment; Empanelment."Empanelment for Year")
            {
            }
            column(EmpanelmentDate_Empanelment; Empanelment."Empanelment Date")
            {
            }
            column(EmpanelmentExpiryDate_Empanelment; Empanelment."Empanelment Expiry Date")
            {
            }
            column(EmpanelmentRenewDate_Empanelment; Empanelment."Empanelment Renew Date")
            {
            }
            column(RenewalStatus_Empanelment; Empanelment."Renewal Status")
            {
            }
            column(NoSeries_Empanelment; Empanelment."No. Series")
            {
            }
            column(Status_Empanelment; Empanelment.Status)
            {
            }
            column(CreatedBy_Empanelment; Empanelment."Created By")
            {
            }
            column(LastModifyBy_Empanelment; Empanelment."Last Modify By")
            {
            }
            column(LastModifyDate_Empanelment; Empanelment."Last Modify Date")
            {
            }
            column(SrNo; Sr)
            {
            }
            column(EmpanelmentPeriod; 'Period :' + Empanelment.GETFILTER("Empanelment Date"))
            {
            }
            column(Start_Date; StartDate)
            {
            }
            column(End_Date; EndDate)
            {
            }
            column(Datefilter; 'Period :' + FORMAT(StartDate) + ' .. ' + FORMAT(EndDate))
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Sr += 1;
            end;

            trigger OnPreDataItem()
            begin
                Sr := 0;
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
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
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
        Sr: Integer;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Fyear: Integer;
        Fyear1: Integer;
        CompInfo: Record "Company Information";
        UserSetup: Record "User Setup";
}

