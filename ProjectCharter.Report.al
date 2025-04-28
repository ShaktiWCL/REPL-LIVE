report 50012 "Project Charter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/ProjectCharter.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Project Charter"; "Project Charter")
        {
            RequestFilterFields = "Project Charter No.";
            column(ModifiedDate; ModifiedDate)
            {
            }
            column(ProjectCharterNo_ProjectCharter; "Project Charter"."Project Charter No.")
            {
            }
            column(ProjectName_ProjectCharter; "Project Charter"."Project Name")
            {
            }
            column(ProjectName_ProjectCharter2; "Project Charter"."Project Name 2")
            {
            }
            column(ProjectArea_ProjectCharter; FORMAT("Project Charter"."Project Area") + ' ' + "Project Charter"."Base Unit of Measure")
            {
            }
            column(ClientName_ProjectCharter; "Project Charter"."Prospect Customer Name")
            {
            }
            column(AgreementWoQuotationNo_ProjectCharter; "Project Charter"."No.")
            {
            }
            column(AgreementStartDate_ProjectCharter; "Project Charter"."Agreement Start Date")
            {
            }
            column(AgreementEndDate_ProjectCharter; "Project Charter"."Agreement End Date")
            {
            }
            column(ProjectPeriodAsPerAgreement_ProjectCharter; "Project Charter"."Project Period AsPer Agreement")
            {
            }
            column(ProjectStartDate_ProjectCharter; "Project Charter"."Project Start Date")
            {
            }
            column(ProjectEndDate_ProjectCharter; "Project Charter"."Project End Date")
            {
            }
            column(BudgetedCost_ProjectCharter; "Project Charter"."Budgeted Cost")
            {
            }
            column(EstimatedCost_ProjectCharter; "Project Charter"."Estimated Cost")
            {
            }
            column(ProjectValue_ProjectCharter; "Project Charter"."Project Value")
            {
            }
            column(ContactName_ProjectCharter; "Project Charter"."Contact Name")
            {
            }
            column(ContactPhone_ProjectCharter; "Project Charter"."Contact Phone")
            {
            }
            column(ContactEmail_ProjectCharter; "Project Charter"."Contact Email")
            {
            }
            column(ContactName_ProjectCharter_1; Contactinfo[1])
            {
            }
            column(ContactPhone_ProjectCharter_1; Contactinfo[2])
            {
            }
            column(ContactEmail_ProjectCharter_1; Contactinfo[3])
            {
            }
            column(ProjectCode_ProjectCharter; "Project Charter"."Project Code")
            {
            }
            column(ProjectManager_ProjectCharter; "Project Charter"."Project Manager")
            {
            }
            column(TechnicalRole_ProjectCharter; "Project Charter"."Technical Role")
            {
            }
            column(ProjectCharterDate_ProjectCharter; "Project Charter"."Project Charter Date")
            {
            }
            column(Version_ProjectCharter; "Project Charter".Version)
            {
            }
            column(CreatedBy_ProjectCharter; "Project Charter"."Created By")
            {
            }
            column(BaseUnitofMeasure_ProjectCharter; "Project Charter"."Base Unit of Measure")
            {
            }
            column(CurrencyCode_ProjectCharter; "Project Charter"."Currency Code")
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(AgreementDate_ProjectCharter; "Project Charter"."Agreement Date")
            {
            }
            column(ProjectManagerName; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
            {
            }
            column(TechnicalRole; TechnicalRole)
            {
            }
            column(Currencycode; Currencycode)
            {
            }
            column(Type_ProjectCharter; "Project Charter".Type)
            {
            }
            column(Status_ProjectCharter; "Project Charter".Status)
            {
            }
            column(Project_Charter_Remarks; "Project Charter".Remarks + "Project Charter"."Remarks 2")
            {
            }
            dataitem("Project Maitain Milestones"; "Project Maitain Milestones")
            {
                DataItemLink = "Project Charter Code" = FIELD("Project Charter No.");
                RequestFilterFields = "Project Charter Code";
                column(Milestone_ProjectMaitainMilestones; "Project Maitain Milestones".Milestone)
                {
                }
                column(MilestoneDesc_ProjectMaitainMilestones; "Project Maitain Milestones"."Milestone Desc")
                {
                }
                column(Amount_ProjectMaitainMilestones; "Project Maitain Milestones".Amount)
                {
                }
                column(PerAmount_ProjectMaitainMilestones; "Project Maitain Milestones"."Amount %")
                {
                }
                column(MilestoneStages_ProjectMaitainMilestones; "Project Maitain Milestones"."Milestone Stages")
                {
                }
                column(PlannedInvoiceDate_ProjectMaitainMilestones; "Project Maitain Milestones"."Planned Invoice Date")
                {
                }
                column(Remarks_ProjectMaitainMilestones; "Project Maitain Milestones".Remarks)
                {
                }
            }
            dataitem("Sub Project Charter"; "Sub Project Charter")
            {
                DataItemLink = "Project Charter No." = FIELD("Project Charter No.");
                RequestFilterFields = "Project Charter No.";
                column(Code_SubProjectCharter; "Sub Project Charter".Code)
                {
                }
                column(Manager_SubProjectCharter; "Sub Project Charter".Manager)
                {
                }
                column(Department_SubProjectCharter; "Sub Project Charter".Department)
                {
                }
                column(Value_SubProjectCharter; "Sub Project Charter".Value)
                {
                }
                column(StartDate_SubProjectCharter; "Sub Project Charter"."Start Date")
                {
                }
                column(EndDate_SubProjectCharter; "Sub Project Charter"."End Date")
                {
                }
                column(SubProjectManagerName; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
                {
                }
                column(SubTechnicalRole; TechnicalRole1 + '/' + FORMAT("Sub Project Charter"."Sub Depatment"))
                {
                }
                column(SubDepatment_SubProjectCharter; "Sub Project Charter"."Sub Depatment")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Employee.GET(Manager) THEN;
                    TechnicalRole1 := '';
                    DimValue.RESET;
                    DimValue.SETRANGE("Dimension Code", 'DEPARTMENT');
                    DimValue.SETRANGE(Code, Department);
                    IF DimValue.FINDFIRST THEN
                        TechnicalRole1 := DimValue.Name;
                end;
            }
            dataitem("Vendor Details for Charter"; "Vendor Details for Charter")
            {
                DataItemLink = "Project Charter No." = FIELD("Project Charter No.");
                RequestFilterFields = "Project Charter No.";
                column(VendorNo_VendorDetailsforCharter; "Vendor Details for Charter"."Vendor No.")
                {
                }
                column(VendorName_VendorDetailsforCharter; "Vendor Details for Charter"."Vendor Name")
                {
                }
                column(ServiceCode_VendorDetailsforCharter; "Vendor Details for Charter"."Service Code")
                {
                }
                column(ServiceDetails_VendorDetailsforCharter; "Vendor Details for Charter"."Service Details")
                {
                }
                column(Value_VendorDetailsforCharter; "Vendor Details for Charter".Value)
                {
                }
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = WHERE(Number = FILTER(1 .. 3));
                column(Number_Integer; Integer.Number)
                {
                }
                column(ProjectValue; ProjectValue)
                {
                }
                column(NewProjectValue; NewProjectValue)
                {
                }
                column(Fee; Fee)
                {
                }
                column(ProjectStatus; ProjectStatus)
                {
                }
                column(Remark; Remark)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ProjectValue := 0;
                    NewProjectValue := 0;
                    Fee := '';
                    Remark := '';
                    IF Integer.Number = 1 THEN BEGIN
                        ProjectCharterArchive.RESET;
                        ProjectCharterArchive.SETRANGE("Project Charter No.", "Project Charter"."Project Charter No.");
                        IF ProjectCharterArchive.FINDFIRST THEN
                            ProjectValue := ProjectCharterArchive."Project Value";
                        NewProjectValue := "Project Charter"."Project Value";
                        Fee := 'FEES';
                        ProjectStatus := "Project Charter".Status;
                        Remark := "Project Charter".Comments;
                    END ELSE
                        IF Integer.Number = 2 THEN BEGIN
                            ProjectCharterArchive.RESET;
                            ProjectCharterArchive.SETRANGE("Project Charter No.", "Project Charter"."Project Charter No.");
                            IF ProjectCharterArchive.FINDFIRST THEN
                                ProjectValue := ProjectCharterArchive."Project Period AsPer Agreement";
                            NewProjectValue := "Project Charter"."Project Period AsPer Agreement";
                            Fee := 'PRIOD';
                            ProjectStatus := "Project Charter".Status;
                        END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Employee.GET("Project Manager") THEN;
                TechnicalRole := '';
                DimValue.SETRANGE("Dimension Code", 'DEPARTMENT');
                DimValue.SETRANGE(Code, "Technical Role");
                IF DimValue.FINDFIRST THEN
                    TechnicalRole := DimValue.Name;
                IF "Project Charter"."Currency Code" <> '' THEN
                    Currencycode := "Project Charter"."Currency Code"
                ELSE
                    Currencycode := 'INR';

                //AD_REPL
                ProjectCharterArchive1.RESET;
                ProjectCharterArchive1.SETCURRENTKEY(Version);
                ProjectCharterArchive1.SETRANGE("Project Charter No.", "Project Charter"."Project Charter No.");
                IF ProjectCharterArchive1.FINDLAST THEN
                    ModifiedDate := ProjectCharterArchive1."Date Archived"
                ELSE
                    ModifiedDate := "Project Charter"."Project Charter Date";
                CLEAR(Contactinfo);
                IF GetContact.GET("Project Charter"."Contact Person 2") THEN BEGIN
                    Contactinfo[1] := GetContact.Name;
                    Contactinfo[2] := GetContact."Phone No.";
                    Contactinfo[3] := GetContact."E-Mail";
                END;
                //AD_REPL
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
        Employee: Record Employee;
        DimValue: Record "Dimension Value";
        TechnicalRole: Text;
        TechnicalRole1: Text;
        Currencycode: Code[10];
        ProjectCharterArchive: Record "Project Charter Archive";
        ProjectValue: Decimal;
        NewProjectValue: Decimal;
        Fee: Text;
        ProjectStatus: Option Draft,"Pending for Approval",Approved,Rejected,"Under Revision";
        Remark: Text;
        ProjectCharterArchive1: Record "Project Charter Archive";
        ModifiedDate: Date;
        GetContact: Record Contact;
        Contactinfo: array[10] of Text;
}

