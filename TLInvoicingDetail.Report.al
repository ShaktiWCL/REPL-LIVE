report 50079 "TL-Invoicing Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TLInvoicingDetail.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.");
            column(InvoiceDetail_Cap; InvoiceDetailCap)
            {
            }
            column(SNo_Cap; SNoCap)
            {
            }
            column(ManagerCode_Cap; ManagerCodeCap)
            {
            }
            column(ManagerName_Cap; ManagerNameCap)
            {
            }
            column(ProjectCode_Cap; ProjectCodeCap)
            {
            }
            column(ProjectName_Cap; ProjectNameCap)
            {
            }
            column(CustomerCode_Cap; CustomerCodeCap)
            {
            }
            column(CustomerName_Cap; CustomerNameCap)
            {
            }
            column(InvoiceNo_Cap; InvoiceNoCap)
            {
            }
            column(InvoiceDate_Cap; InvoiceDateCap)
            {
            }
            column(InvoiceAmount_Cap; InvoiceAmountCap)
            {
            }
            column(DateFilter_Cap; DateFilterCap)
            {
            }
            column(Total_Cap; TotalCap)
            {
            }
            column(GetCompanyInfo_Name; CompanyNameText)
            {
            }
            column(GetCompanyInfo_Picture; GetCompanyInfo.Picture)
            {
            }
            column(GetCompanyInfo_Address; GetCompanyInfo.Address)
            {
            }
            column(GetCompanyInfo_Address2; GetCompanyInfo."Address 2")
            {
            }
            column(Start_Date; FORMAT(StartDate))
            {
            }
            column(End_Date; FORMAT(EndDate))
            {
            }
            dataitem(Project; Job)
            {
                DataItemLink = "Project Manager" = FIELD("No.");
                DataItemTableView = SORTING("No.");
                dataitem("Sales Invoice Header"; "Sales Invoice Header")
                {
                    CalcFields = Amount;
                    DataItemLink = "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code");
                    DataItemTableView = SORTING("No.");
                    column(Sr_No; SrNo)
                    {
                    }
                    column(Manager_Code; Employee."No.")
                    {
                    }
                    column(Manager_Name; Employee."First Name")
                    {
                    }
                    column(Project_Code; Project."No.")
                    {
                    }
                    column(Project_Name; Project.Description)
                    {
                    }
                    column(Customer_Code; "Sales Invoice Header"."Sell-to Customer No.")
                    {
                    }
                    column(Customer_Name; "Sales Invoice Header"."Sell-to Customer Name")
                    {
                    }
                    column(Invoice_No; "Sales Invoice Header"."No.")
                    {
                    }
                    column(Invoice_Date; FORMAT("Sales Invoice Header"."Posting Date"))
                    {
                    }
                    column(Invoice_Amount; ROUND(("Sales Invoice Header".Amount * ExchangeRate), 0.01))
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Employee."No." = '' THEN
                            CurrReport.SKIP;

                        SrNo += 1;


                        IF "Currency Code" <> '' THEN
                            ExchangeRate := 1 / "Currency Factor"
                        ELSE
                            ExchangeRate := 1;
                        IF LogoOutput THEN
                            CLEAR(GetCompanyInfo.Picture)
                        ELSE
                            LogoOutput := TRUE;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                    end;
                }
            }

            trigger OnPreDataItem()
            begin
                IF GetEmployee.GET(USERID) THEN BEGIN
                    IF GetEmployee."TL Report" THEN BEGIN
                        IF ManagerCode <> '' THEN
                            SETFILTER(Employee."No.", '%1', ManagerCode);
                    END;

                    IF ManagerCode = '' THEN BEGIN
                        IF (GetEmployee."Project Manager") AND (GetEmployee."TL Report" = FALSE) THEN BEGIN
                            ManagerCode := GetEmployee."No.";
                            SETFILTER(Employee."No.", '%1', ManagerCode);
                        END;
                    END;
                END;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Project Manager Code"; ManagerCode)
                {
                    TableRelation = Employee."No." WHERE("Project Manager for Cash Flow" = CONST(true));

                    trigger OnValidate()
                    begin
                        GetEmployee.GET(USERID);
                        IF NOT GetEmployee."TL Report" THEN
                            ERROR('You are not authorized for using this filter');
                    end;
                }
                field("Start Date"; StartDate)
                {

                    trigger OnValidate()
                    begin
                        IF EndDate <> 0D THEN
                            IF StartDate > EndDate THEN
                                ERROR(Text13703);
                    end;
                }
                field("End Date"; EndDate)
                {

                    trigger OnValidate()
                    begin
                        IF StartDate <> 0D THEN
                            IF StartDate > EndDate THEN
                                ERROR(Text13700);
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
        IF (StartDate = 0D) OR (EndDate = 0D) THEN
            ERROR('Date must not be blank');

        GetCompanyInfo.GET;
        GetCompanyInfo.CALCFIELDS(Picture);


        IF GetCompanyInfo."New Name Date" <> 0D THEN BEGIN
            IF EndDate >= GetCompanyInfo."New Name Date" THEN
                CompanyNameText := GetCompanyInfo.Name
            ELSE
                CompanyNameText := GetCompanyInfo."Old Name";
        END ELSE
            CompanyNameText := GetCompanyInfo.Name;
    end;

    var
        SNoCap: Label 'S. No.';
        ManagerCodeCap: Label 'Employee Code';
        ManagerNameCap: Label 'Employeer Name';
        ProjectCodeCap: Label 'Project Code';
        ProjectNameCap: Label 'Project Name';
        CustomerCodeCap: Label 'Customer Code';
        CustomerNameCap: Label 'Customer Name';
        InvoiceNoCap: Label 'Invoice No.';
        InvoiceDateCap: Label 'Invoice Date';
        InvoiceAmountCap: Label 'Invoice Amount';
        GetCompanyInfo: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        ManagerCode: Code[20];
        InvoiceDetailCap: Label 'Invoicing Detail';
        DateFilterCap: Label 'Date Filters';
        TotalCap: Label 'Total';
        SrNo: Integer;
        GetEmployee: Record Employee;
        Text13700: Label 'End Date cannot be before Start Date.';
        Text13703: Label 'Start Date cannot be after End Date.';
        ExchangeRate: Decimal;
        CompanyNameText: Text;
        LogoOutput: Boolean;
}

