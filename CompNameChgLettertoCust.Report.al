report 50133 "Comp. Name Chg. Letter to Cust"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CompNameChgLettertoCust.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(Customer_No; Customer."No.")
            {
            }
            column(Customer_Name; Customer.Name)
            {
            }
            column(Customer_Address; Customer.Address)
            {
            }
            column(Customer_Address2; Customer."Address 2")
            {
            }
            column(Customer_City; Customer.City)
            {
            }
            column(Customer_PostCode; Customer."Post Code")
            {
            }
            column(Customer_StateCode; Customer."State Code")
            {
            }
            column(New_Name; CompanyInformation.Name)
            {
            }
            column(Old_Name; CompanyInformation."Old Name")
            {
            }
            column(Name_Val; NameVal)
            {
            }
            column(Designation_Val; DesignationVal)
            {
            }
            column(Work_Date; FORMAT(WORKDATE))
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(NameVal; NameVal)
                {
                    Caption = 'Name';
                }
                field(DesignationVal; DesignationVal)
                {
                    Caption = 'Designation';
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

    var
        CompanyInformation: Record "Company Information";
        NameVal: Text;
        DesignationVal: Text;
}

