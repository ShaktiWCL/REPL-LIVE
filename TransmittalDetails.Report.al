report 50032 "Transmittal Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TransmittalDetails.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Transmital Header"; "Transmital Header")
        {
            RequestFilterFields = "Transmital No.";
            column(TransmitalNo_TransmitalHeader; "Transmital Header"."Project No." + '/' + "Transmital Header"."Transmital No.")
            {
            }
            column(DocumentDate_TransmitalHeader; "Transmital Header"."Document Date")
            {
            }
            column(Place_TransmitalHeader; ResCenterName)
            {
            }
            column(CustomerNo_TransmitalHeader; "Transmital Header"."Customer No.")
            {
            }
            column(CustomerName_TransmitalHeader; "Transmital Header"."Customer Name")
            {
            }
            column(CustomerAddress1_TransmitalHeader; "Transmital Header"."Customer Address 1")
            {
            }
            column(CustomerAddress2_TransmitalHeader; "Transmital Header"."Customer Address 2")
            {
            }
            column(City_TransmitalHeader; "Transmital Header".City)
            {
            }
            column(State_TransmitalHeader; "Transmital Header".State)
            {
            }
            column(PostCode_TransmitalHeader; "Transmital Header"."Post Code")
            {
            }
            column(ProjectNo_TransmitalHeader; "Transmital Header"."Project No.")
            {
            }
            column(ProjectName_TransmitalHeader; "Transmital Header"."Project Name")
            {
            }
            column(Stageperargreement_TransmitalHeader; "Transmital Header"."Stage per argreement")
            {
            }
            column(NoSeries_TransmitalHeader; "Transmital Header"."No. Series")
            {
            }
            column(MileStoneNo_TransmitalHeader; "Transmital Header"."MileStone No.")
            {
            }
            column(MileStoneDesc_TransmitalHeader; "Transmital Header"."MileStone Desc")
            {
            }
            column(ComInfoName; ComInfo.Name)
            {
            }
            column(AdditionalWork_TransmitalHeader; "Transmital Header"."Additional Work")
            {
            }
            column(ContactPerson_TransmitalHeader; "Transmital Header"."Contact Person")
            {
            }
            column(ComInfoPicture; ComInfo.Picture)
            {
            }
            column(ComWaterMark; ComInfo."Water Mark")
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; Address2)
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(FaxNo; FaxNo)
            {
            }
            column(MilestoneDescription1; MilestoneDescription[1])
            {
            }
            column(MilestoneDescription2; MilestoneDescription[2])
            {
            }
            column(MilestoneDescription3; MilestoneDescription[3])
            {
            }
            column(MilestoneDescription4; MilestoneDescription[4])
            {
            }
            column(ResCenter; ResCenter)
            {
            }
            dataitem("Transmital Line"; "Transmital Line")
            {
                DataItemLink = "Transmital Doc No." = FIELD("Transmital No.");
                column(TransmitalDocNo_TransmitalLine; "Transmital Line"."Transmital Doc No.")
                {
                }
                column(LineNo_TransmitalLine; "Transmital Line"."Line No.")
                {
                }
                column(DrawingNoTitle_TransmitalLine; "Transmital Line"."Drawing Title/Doc. No.")
                {
                }
                column(DescriptionofDwawAddWork_TransmitalLine; "Transmital Line"."Drawing/Doc. No.")
                {
                }
                column(Additionalwork_TransmitalLine; "Transmital Line".Revision)
                {
                }
                column(Size_TransmitalLine; "Transmital Line"."Dwg. Size")
                {
                }
                column(ColorBW_TransmitalLine; "Transmital Line"."Color/B.W")
                {
                }
                column(TotalSets_TransmitalLine; "Transmital Line"."Total Drawings Sets")
                {
                }
                column(SrNo; SrNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SrNo += 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF ResCenter <> '' THEN BEGIN
                    IF ResponsibilityCenter.GET(ResCenter) THEN BEGIN
                        Address := ResponsibilityCenter.Address + ResponsibilityCenter."Address 2" + ',' + ResponsibilityCenter.City;
                        IF CountryRegion.GET(ResponsibilityCenter."Country/Region Code") THEN;
                        Address2 := ResponsibilityCenter."Address 3" + ',' + ResponsibilityCenter."Post Code" + ',' + CountryRegion.Name;
                        PhoneNo := ResponsibilityCenter."Phone No.";
                        FaxNo := ResponsibilityCenter."Fax No.";
                        ResCenterName := COPYSTR(ResponsibilityCenter.Name, 6, STRLEN(ResponsibilityCenter.Name));
                    END ELSE BEGIN
                        Address := '';
                        Address2 := '';
                        PhoneNo := '';
                        FaxNo := '';
                        ResCenterName := '';
                    END;
                END ELSE BEGIN
                    IF ResponsibilityCenter.GET("Responsibility Center") THEN BEGIN
                        Address := ResponsibilityCenter.Address + ResponsibilityCenter."Address 2" + ',' + ResponsibilityCenter.City;
                        IF CountryRegion.GET(ResponsibilityCenter."Country/Region Code") THEN;
                        Address2 := ResponsibilityCenter."Address 3" + ',' + ResponsibilityCenter."Post Code" + ',' + CountryRegion.Name;
                        PhoneNo := ResponsibilityCenter."Phone No.";
                        FaxNo := ResponsibilityCenter."Fax No.";
                        ResCenterName := COPYSTR(ResponsibilityCenter.Name, 6, STRLEN(ResponsibilityCenter.Name));
                    END ELSE BEGIN
                        Address := '';
                        Address2 := '';
                        PhoneNo := '';
                        FaxNo := '';
                        ResCenterName := '';
                    END;

                END;

                CLEAR(MilestoneDescription);
                i := 1;
                ProjectTask.RESET;
                ProjectTask.SETRANGE("Transmittal No.", "Transmital No.");
                IF ProjectTask.FINDFIRST THEN
                    REPEAT
                        MilestoneDescription[i] := '(' + FORMAT(i) + ')' + ProjectTask."Milestone Desc";
                        i += 1;
                    UNTIL ProjectTask.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                ComInfo.GET;
                ComInfo.CALCFIELDS(Picture);
                ComInfo.CALCFIELDS(ComInfo."Water Mark");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Print Location"; ResCenter)
                {
                    TableRelation = "Responsibility Center";

                    trigger OnValidate()
                    begin
                        IF ResponsibilityCenter.GET(ResCenter) THEN BEGIN
                            ResCenterName1 := COPYSTR(ResponsibilityCenter.Name, 6, STRLEN(ResponsibilityCenter.Name));
                        END;
                        MESSAGE('You are selecting %1 So this document will be print on %2 letter head', ResCenterName1, ResCenterName1);
                    end;
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

    trigger OnPreReport()
    begin
        IF ResCenter = '' THEN
            ERROR('Please select print location');
    end;

    var
        ComInfo: Record "Company Information";
        SrNo: Integer;
        ResponsibilityCenter: Record "Responsibility Center";
        Address: Text;
        Address2: Text;
        PhoneNo: Text;
        MilestoneDescription: array[25] of Text;
        ProjectTask: Record "Job Task";
        i: Integer;
        ResCenter: Code[20];
        CountryRegion: Record "Country/Region";
        FaxNo: Text;
        ResCenterName: Text;
        ResCenterName1: Text;
}

