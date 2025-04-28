report 50006 "PMC Sub Project"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PMCSubProject.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Project; Job)
        {
            DataItemTableView = WHERE("Type Of Project" = FILTER('PMC Project'));
            RequestFilterFields = "No.";
            dataitem("Project Task"; "Job Task")
            {
                DataItemLink = "JOb No." = FIELD("No.");
                column(ProjectNo_ProjectTask; "Project Task"."Job No.")
                {
                }
                column(Name_ProjectTask; "Project Task".Description)
                {
                }
                column(Milestone_ProjectTask; "Project Task".Milestone)
                {
                }
                column(PlannedBillDate_ProjectTask; "Project Task"."Planned Bill Date")
                {
                }
                column(ParentProjectCode; Project."Parent Project Code")
                {
                }
                column(ParentProjectName; Project."Parent Project Name")
                {
                }
                column(ProjectManagerName; RecEmployee."First Name")
                {
                }
                column(ProjectStartDate; Project."Starting Date")
                {
                }
                column(ProjectEndDate; Project."Ending Date")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF RecProject.GET("Parent Project Code") THEN;
                IF RecEmployee.GET("Project Manager") THEN;
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
        RecProject: Record Job;
        RecEmployee: Record Employee;
}

