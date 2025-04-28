report 50009 "Project Creation -R"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/ProjectCreationR.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(Project; Job)
        {
            RequestFilterFields = "No.";
            column(ProjectNo_Project; Project."No.")
            {
            }
            column(ProjectName_Project; Project.Description)
            {
            }
            column(ProjectName2_Project; Project."Description 2")
            {
            }
            column(ProjectInitiatedOn_Project; Project."Creation Date")
            {
            }
            column(EstimatedEndingDate_Project; Project."Ending Date")
            {
            }
            column(ProjectValue_Project; Project."Project Value")
            {
            }
            column(ProjectStatus_Project; Project."Project Status")
            {
            }
            column(EmployeeName; Employee."First Name")
            {
            }
            column(GlobalDimension1Code_Project; Project."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Project; Project."Global Dimension 2 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Employee.GET(Project."Project Manager") THEN;
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
        Employee: Record Employee;
}

