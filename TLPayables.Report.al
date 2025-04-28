report 50083 TL_Payables
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TLPayables.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.");
            column(Payables_Cap; PayablesCap)
            {
            }
            column(SrNo_Cap; SrNoCap)
            {
            }
            column(ManageCode_Cap; ManageCodeCap)
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
            column(InvoiceNo_Cap; InvoiceNoCap)
            {
            }
            column(InvoiceDate_Cap; InvoiceDateCap)
            {
            }
            column(InvoiceAmount_Cap; InvoiceAmountCap)
            {
            }
            column(OutStandingAmount_Cap; OutStandingAmountCap)
            {
            }
            column(SupplierName_Cap; SupplierNameCap)
            {
            }
            column(DateFilter_Cap; DateFilterCap)
            {
            }
            column(Total_Cap; TotalCap)
            {
            }
            column(Client_Cap; ClientCap)
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
                dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
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
                    column(Suppiler_Name; "Buy-from Vendor Name")
                    {
                    }
                    column(Invoice_No; "No.")
                    {
                    }
                    column(Invoice_Date; FORMAT("Posting Date"))
                    {
                    }
                    column(Inv_Amount; ROUND((Amount * ExchangeRate), 0.01))
                    {
                    }
                    column(OutStanding_Amount; OutStandingAmount)
                    {
                    }
                    column(Narration; PurchCommentText)
                    {
                    }
                    column(Client_Name; Project."Bill-to Name")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF "Currency Code" <> '' THEN
                            ExchangeRate := 1 / "Currency Factor"
                        ELSE
                            ExchangeRate := 1;

                        OutStandingAmount := 0;
                        PaidAmount := 0;

                        VendorLedgerEntry.RESET;
                        VendorLedgerEntry.SETRANGE("Document No.", "No.");
                        IF VendorLedgerEntry.FINDFIRST THEN BEGIN
                            VendorLedgerEntry.CALCFIELDS("Remaining Amount");
                            OutStandingAmount := 0;
                            OutStandingAmount := -ROUND((VendorLedgerEntry."Remaining Amount" * ExchangeRate), 0.01);
                        END;

                        PurchCommentText := '';
                        PurchCommentLine.RESET;
                        PurchCommentLine.SETRANGE("Document Type", PurchCommentLine."Document Type"::"Posted Invoice");
                        PurchCommentLine.SETRANGE("No.", "Purch. Inv. Header"."No.");
                        IF PurchCommentLine.FINDFIRST THEN BEGIN
                            REPEAT
                                PurchCommentText += PurchCommentLine.Comment;
                            UNTIL PurchCommentLine.NEXT = 0;
                        END;


                        IF OutStandingAmount = 0 THEN
                            CurrReport.SKIP;

                        SrNo += 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                    end;
                }
            }

            trigger OnPreDataItem()
            begin
                GetEmployee.GET(USERID);
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
        //GetCompanyInfo.CALCFIELDS(Picture);

        IF GetCompanyInfo."New Name Date" <> 0D THEN BEGIN
            IF EndDate >= GetCompanyInfo."New Name Date" THEN
                CompanyNameText := GetCompanyInfo.Name
            ELSE
                CompanyNameText := GetCompanyInfo."Old Name";
        END ELSE
            CompanyNameText := GetCompanyInfo.Name;
    end;

    var
        PayablesCap: Label 'Payables Summary';
        SrNoCap: Label 'Sr. No.';
        ManageCodeCap: Label 'Employee Code';
        ManagerNameCap: Label 'Employee Name';
        ProjectCodeCap: Label 'Project Code';
        ProjectNameCap: Label 'Project Name';
        InvoiceNoCap: Label 'Invoice No.';
        InvoiceDateCap: Label 'Invoice Date';
        InvoiceAmountCap: Label 'Invoice Amount';
        OutStandingAmountCap: Label 'Outstanding Amount';
        SupplierNameCap: Label 'Suppiler Name';
        GetCompanyInfo: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        ManagerCode: Code[20];
        SrNo: Integer;
        GetEmployee: Record Employee;
        Text13700: Label 'End Date cannot be before Start Date.';
        Text13703: Label 'Start Date cannot be after End Date.';
        DateFilterCap: Label 'Date Filter';
        TotalCap: Label 'Total';
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PaidAmount: Decimal;
        OutStandingAmount: Decimal;
        ExchangeRate: Decimal;
        CompanyNameText: Text;
        PurchCommentText: Text;
        PurchCommentLine: Record "Purch. Comment Line";
        ClientCap: Label 'Client Name';
}

