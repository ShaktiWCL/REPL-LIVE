report 50005 "Sub Project"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/SubProject.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Project; Job)
        {
            DataItemTableView = WHERE("Type Of Project" = FILTER('Sub Project'));
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
            column(BilltoCustomerNo_Project; Project."Bill-to Customer No.")
            {
            }
            column(BilltoName_Project; Project."Bill-to Name")
            {
            }
            column(ProjectInitiatedOn_Project; Project."Creation Date")
            {
            }
            column(EstimatedStartingDate_Project; Project."Starting Date")
            {
            }
            column(EstimatedEndingDate_Project; Project."Ending Date")
            {
            }
            column(ProjectValue_Project; Project."Project Value")
            {
            }
            column(BudgetedCost_Project; Project."Budgeted Cost")
            {
            }
            column(ProjectStatus_Project; Project."Project Status")
            {
            }
            column(EmployeeName; Employee."First Name")
            {
            }
            column(ParentProjectCode_Project; Project."Parent Project Code")
            {
            }
            column(ParentProjectName_Project; Project."Parent Project Name")
            {
            }
            column(ParentProjectManager; Employee2."First Name")
            {
            }
            column(ParentProjectValue; RecProject."Project Value")
            {
            }
            column(BillAmt; BillAmt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Employee.GET("Project Manager") THEN;
                IF RecProject.GET("Parent Project Code") THEN;

                IF Employee2.GET(RecProject."Project Manager") THEN;

                BillAmt := 0;
                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE("Job No.", "No.");
                SalesInvoiceLine.SETRANGE("Job Task No.", "No.");
                IF SalesInvoiceLine.FINDFIRST THEN
                    REPEAT
                        BillAmt += SalesInvoiceLine.Amount;
                    UNTIL SalesInvoiceLine.NEXT = 0;
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
        RecProject: Record Job;
        SalesInvoiceLine: Record "Sales Invoice Line";
        BillAmt: Decimal;
        Employee2: Record Employee;
}

