report 50085 "TL-Outstanding"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TLOutstanding.rdl';
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
            column(OutStandingPer_Cap; OutStandingPerCap)
            {
            }
            column(OutStandingAmount_Cap; OutStandingAmountCap)
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
            column(Remaining_Amt; GetTotalOpenReceipt)
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
                    column(Invoice_Amount; AmountToCustomer)
                    {
                    }
                    column(OutStanding_Amount; OutStandingAmount)
                    {
                    }
                    column(Outstd_Percentage; OutstdPercentage)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Employee."No." = '' THEN
                            CurrReport.SKIP;
                        AmountToCustomer := 0;
                        PaidAmount := 0;
                        //Condition 1
                        CustLedgEntry.RESET;
                        CustLedgEntry.SETRANGE("Document No.", "No.");
                        IF CustLedgEntry.FINDFIRST THEN BEGIN
                            DetailedCustLedgEntry.RESET;
                            DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
                            DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                            DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
                            DetailedCustLedgEntry.SETFILTER("Initial Document Type", '%1', DetailedCustLedgEntry."Initial Document Type"::Invoice);
                            IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                                REPEAT
                                    PaidAmount += -(DetailedCustLedgEntry."Amount (LCY)");
                                UNTIL DetailedCustLedgEntry.NEXT = 0;
                            END;
                        END;
                        //Condition 1

                        //Condition 2
                        CustLedgEntry.RESET;
                        CustLedgEntry.SETRANGE("Document No.", "No.");
                        IF CustLedgEntry.FINDFIRST THEN BEGIN
                            DetailedCustLedgEntry.RESET;
                            DetailedCustLedgEntry.SETCURRENTKEY("Document No.");
                            DetailedCustLedgEntry.SETRANGE("Document No.", CustLedgEntry."Document No.");
                            DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
                            DetailedCustLedgEntry.SETFILTER("Document Type", '%1', DetailedCustLedgEntry."Document Type"::Invoice);
                            IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                                REPEAT
                                    PaidAmount += (DetailedCustLedgEntry."Amount (LCY)");
                                UNTIL DetailedCustLedgEntry.NEXT = 0;
                            END;
                        END;
                        //Condition 2

                        IF "Currency Code" <> '' THEN
                            ExchangeRate := 1 / "Currency Factor"
                        ELSE
                            ExchangeRate := 1;


                        OutStandingAmount := 0;

                        IF "Currency Code" <> '' THEN BEGIN
                            AmountToCustomer := ROUND((Amount * ExchangeRate), 0.01);

                            IF PaidAmount < 0 THEN
                                OutStandingAmount := ROUND((Amount * ExchangeRate), 0.01) - (-PaidAmount)
                            ELSE
                                OutStandingAmount := ROUND((Amount * ExchangeRate), 0.01);

                            IF PaidAmount > 0 THEN
                                OutStandingAmount := ROUND((Amount * ExchangeRate), 0.01) - (PaidAmount)
                            ELSE
                                OutStandingAmount := ROUND((Amount * ExchangeRate), 0.01);
                        END ELSE BEGIN
                            AmountToCustomer := ROUND((Amount * ExchangeRate), 0.01);

                            IF PaidAmount < 0 THEN
                                OutStandingAmount := ROUND((Amount * ExchangeRate), 0.01) - (-PaidAmount)
                            ELSE
                                OutStandingAmount := ROUND((Amount * ExchangeRate), 0.01);

                            IF PaidAmount > 0 THEN
                                OutStandingAmount := ROUND((Amount * ExchangeRate), 0.01) - (PaidAmount)
                            ELSE
                                OutStandingAmount := ROUND((Amount * ExchangeRate), 0.01);
                        END;

                        IF OutStandingAmount = 0 THEN
                            CurrReport.SKIP;

                        LineAmount := 0;
                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.", "No.");
                        IF SalesInvLine.FINDFIRST THEN BEGIN
                            REPEAT
                                LineAmount += ROUND((SalesInvLine."Line Amount" * ExchangeRate), 0.01);
                            UNTIL SalesInvLine.NEXT = 0
                        END;

                        OutstdPercentage := 0;
                        OutstdPercentage := (OutStandingAmount / LineAmount) * 100;
                        IF OutstdPercentage > 100 THEN
                            OutstdPercentage := 100;

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
        SNoCap: Label 'S. No.';
        ManagerCodeCap: Label 'Employee Code';
        ManagerNameCap: Label 'Employee Name';
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
        InvoiceDetailCap: Label 'Outstanding Summary';
        DateFilterCap: Label 'Date Filters';
        TotalCap: Label 'Total';
        SrNo: Integer;
        GetEmployee: Record Employee;
        Text13700: Label 'End Date cannot be before Start Date.';
        Text13703: Label 'Start Date cannot be after End Date.';
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        PaidAmount: Decimal;
        OutStandingAmount: Decimal;
        LineAmount: Decimal;
        SalesInvLine: Record "Sales Invoice Line";
        OutstdPercentage: Decimal;
        OutStandingAmountCap: Label 'Outstanding Amount';
        OutStandingPerCap: Label 'OutStanding % of Basic Amt';
        ExchangeRate: Decimal;
        CompanyNameText: Text;
        AmountToCustomer: Decimal;
        RemainingAmt: Decimal;

    procedure GetTotalOpenReceipt() OTAmount: Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Source Code", "Posting Date", Open);
        CustLedgerEntry.SETRANGE("Source Code", 'BANKRCPTV');
        CustLedgerEntry.SETRANGE("Posting Date", 0D, TODAY);
        CustLedgerEntry.SETRANGE(Open, TRUE);
        IF CustLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                OTAmount += CustLedgerEntry."Remaining Amt. (LCY)";
            UNTIL CustLedgerEntry.NEXT = 0;
        END;
        EXIT(OTAmount);
    end;
}

