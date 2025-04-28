report 50008 "PMC Project -R"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PMCProjectR.rdl';
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
                DataItemLink = "Job No." = FIELD("No.");
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
                column(ProjectManageName; RecEmployee."First Name")
                {
                }
                column(ParentProjectCode; Project."Parent Project Code")
                {
                }
                column(ParentProjectName; Project."Parent Project Name")
                {
                }
                column(ProjectCreatedOn; Project."Creation Date")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF RecEmployee.GET(Project."Project Manager") THEN;
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
        RecEmployee: Record Employee;
}

