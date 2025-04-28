report 50004 Project
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/Project.rdl';
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
            column(BillAmt; BillAmt)
            {
            }
            column(GlobalDimension2Code_Project; Project."Global Dimension 2 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Employee.GET(Project."Project Manager") THEN;
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
        SalesInvoiceLine: Record "Sales Invoice Line";
        BillAmt: Decimal;
}

