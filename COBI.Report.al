report 50011 COBI
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/COBI.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Project; Job)
        {
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Job No." = FIELD("No.");
                column(SelltoCustomerNo_SalesInvoiceLine; "Sales Invoice Line"."Sell-to Customer No.")
                {
                }
                column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
                {
                }
                column(CustomerName; RecCustomer.Name)
                {
                }
                column(ProjectCode; Project."No.")
                {
                }
                column(ProjectName; Project.Description)
                {
                }
                column(ProjectManageName; RecEmployee."First Name")
                {
                }
                column(AmountToCustomer_SalesInvoiceLine; 0)
                {
                }
                column(ProjectOU; Project."Global Dimension 2 Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF RecCustomer.GET("Sell-to Customer No.") THEN;
                end;
            }

            trigger OnAfterGetRecord()
            begin
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
        RecCustomer: Record Customer;
        RecEmployee: Record Employee;
}

