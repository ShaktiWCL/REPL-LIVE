report 50040 "New Project Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/NewProjectReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Project; Job)
        {
            DataItemTableView = WHERE("Type Of Project" = FILTER("Main Project"));
            column(ProjectNo_Project; Project."No.")
            {
            }
            column(OldProjectCodeRamco_Project; Project."Old Project Code(Ramco)")
            {
            }
            column(ProjectName; Project.Description)
            {
            }
            column(ProjectManager; Project."Project Manager")
            {
            }
            column(ProjectManagerName; ProjectManagerName)
            {
            }
            column(ProjectCreatedDate; Project."Creation Date")
            {
            }
            column(ProjectValue; Project."Project Value")
            {
            }
            column(ProjectEndDate; Project."Ending Date")
            {
            }
            column(Status; Project."Project Status")
            {
            }
            column(OUName; Project."Global Dimension 1 Code")
            {
            }
            column(CostCenter; Project."Global Dimension 2 Code")
            {
            }
            column(SrNo; SrNo)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SrNo += 1;
                ProjectManagerName := '';
                IF Project."Project Manager" <> '' THEN BEGIN
                    Emp.GET(Project."Project Manager");
                    ProjectManagerName := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Creation Date", StartDate, EndDate);
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
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Month1 := DATE2DMY(TODAY, 2);
        Year1 := DATE2DMY(TODAY, 3);

        IF Month1 IN [1, 2, 3] THEN
            Year2 := Year1 - 1
        ELSE
            Year2 := Year1;

        StartDate := DMY2DATE(1, 4, Year2);
        EndDate := TODAY;
    end;

    var
        ProjectManagerName: Text;
        Emp: Record Employee;
        StartDate: Date;
        EndDate: Date;
        Month1: Integer;
        Year1: Integer;
        Year2: Integer;
        SrNo: Integer;
}

