report 50084 "TL_Parent Proj Value In Hand"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TLParentProjValueInHand.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.");
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
            column(Employee_No; Employee."No.")
            {
            }
            column(Employee_FirstName; Employee."First Name")
            {
            }
            column(DateFilter_Cap; DateFilterCap)
            {
            }
            column(SNo_Cap; SNoCap)
            {
            }
            column(EmpCode_Cap; EmpCodeCap)
            {
            }
            column(EmpName_Cap; EmpNameCap)
            {
            }
            column(TypeOfProject_Cap; TypeOfProjectCap)
            {
            }
            column(ProjectCode_Cap; ProjectCodeCap)
            {
            }
            column(ProjectName_Cap; ProjectNameCap)
            {
            }
            column(ProjectValue_Cap; ProjectValueCap)
            {
            }
            column(BilledValue_Cap; BilledValueCap)
            {
            }
            column(ActualProjectValue_Cap; ActualProjectValueCap)
            {
            }
            column(SPValue_Cap; SPValueCap)
            {
            }
            column(NetProjectValue_Cap; NetProjectValueCap)
            {
            }
            column(ProjValueInHand_Cap; ProjValueInHandCap)
            {
            }
            column(PMCValue_Cap; PMCValueCap)
            {
            }
            column(Total_Cap; TotalCap)
            {
            }
            dataitem(MainProject; Job)
            {
                DataItemLink = "Project Manager" = FIELD("No.");
                DataItemTableView = SORTING("No.")
                                    WHERE("Type Of Project" = FILTER("Main Project"));
                column(Sr_No; SrNo)
                {
                }
                column(Project_No; MainProject."No.")
                {
                }
                column(Project_Name; MainProject.Description)
                {
                }
                column(Type_Project; MainProject."Type Of Project")
                {
                }
                column(Actual_Value; ActualValue)
                {
                }
                column(Billed_Value; BilledValue)
                {
                }
                column(Project_Value; ProjectValue)
                {
                }
                column(SubProject_Value; SubProjectValue)
                {
                }
                column(Cal_Percentage; CalPercentage)
                {
                }
                column(NetProfit_Value; NetProfitValue)
                {
                }
                column(BilledValue_ExTax; BilledValueExTax)
                {
                }
                column(Cal_Value; CalValue)
                {
                }
                column(PMCProject_Value; PMCProjectValue)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    BilledValue := 0;
                    BilledValueExTax := 0;
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETCURRENTKEY("Shortcut Dimension 1 Code");
                    SalesInvHeader.SETRANGE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                    SalesInvHeader.SETFILTER("Type Of Note", '<>%1', SalesInvHeader."Type Of Note"::Debit);
                    SalesInvHeader.SETFILTER("Posting Date", '%1..%2', 0D, AsonDate);
                    IF SalesInvHeader.FINDSET THEN BEGIN
                        REPEAT
                            IF SalesInvHeader."Currency Code" <> '' THEN
                                ExchangeRate := 1 / SalesInvHeader."Currency Factor"
                            ELSE
                                ExchangeRate := 1;
                            //SalesInvHeader.CALCFIELDS("Amount to Customer");
                            SalesInvHeader.CALCFIELDS(Amount);
                            BilledValue += ROUND((SalesInvHeader.Amount * ExchangeRate), 0.01);
                            BilledValueExTax += ROUND((SalesInvHeader.Amount * ExchangeRate), 0.01);
                        UNTIL SalesInvHeader.NEXT = 0;
                    END;
                    SalesCrMemoHeader.RESET;
                    SalesCrMemoHeader.SETCURRENTKEY("Shortcut Dimension 1 Code");
                    SalesCrMemoHeader.SETRANGE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                    SalesCrMemoHeader.SETFILTER("Posting Date", '%1..%2', 0D, AsonDate);
                    IF SalesCrMemoHeader.FINDSET THEN BEGIN
                        REPEAT

                            IF SalesCrMemoHeader."Currency Code" <> '' THEN
                                ExchangeRate := 1 / SalesCrMemoHeader."Currency Factor"
                            ELSE
                                ExchangeRate := 1;

                            //SalesCrMemoHeader.CALCFIELDS("Amount to Customer");
                            SalesCrMemoHeader.CALCFIELDS(Amount);
                            BilledValue -= ROUND((SalesCrMemoHeader.Amount * ExchangeRate), 0.01);
                            BilledValueExTax -= ROUND((SalesCrMemoHeader.Amount * ExchangeRate), 0.01);
                        UNTIL SalesCrMemoHeader.NEXT = 0;
                    END;


                    ProjectValue := 0;
                    ProjectValue := "Project Value";

                    /*
                    SubProjectValue := 0;
                    GetProject.RESET;
                    GetProject.SETCURRENTKEY("Type Of Project","Parent Project Code");
                    GetProject.SETRANGE("Type Of Project","Type Of Project" ::"Sub Project");
                    GetProject.SETRANGE("Parent Project Code","Project No.");
                    IF GetProject.FINDSET THEN BEGIN
                      REPEAT
                        SubProjectValue += GetProject."Project Value";
                      UNTIL GetProject.NEXT =0;
                    END;
                    
                    PMCProjectValue := 0;
                    GetProject.RESET;
                    GetProject.SETCURRENTKEY("Type Of Project","Parent Project Code");
                    GetProject.SETRANGE("Type Of Project","Type Of Project" ::"PMC Project");
                    GetProject.SETRANGE("Parent Project Code","Project No.");
                    IF GetProject.FINDSET THEN BEGIN
                      REPEAT
                        PMCProjectValue += GetProject."Project Value";
                      UNTIL GetProject.NEXT =0;
                    END;
                    */
                    CalPercentage := 0;
                    IF ProjectValue <> 0 THEN
                        CalPercentage := (SubProjectValue / ProjectValue);


                    ActualValue := 0;
                    ActualValueSub := 0;
                    ActualValuePMC := 0;

                    CalValue := 0;
                    CalValue := CalPercentage * BilledValueExTax;
                    IF CalValue <> 0 THEN
                        ActualValueSub := BilledValueExTax - CalValue;

                    CalPercentage1 := 0;
                    IF ProjectValue <> 0 THEN
                        CalPercentage1 := (PMCProjectValue / ProjectValue);

                    CalValue1 := 0;
                    CalValue1 := CalPercentage1 * BilledValueExTax;
                    IF CalValue1 <> 0 THEN
                        ActualValuePMC := BilledValueExTax - CalValue1;

                    IF (ActualValueSub <> 0) OR (ActualValuePMC <> 0) THEN
                        ActualValue := (ActualValueSub + ActualValuePMC)
                    ELSE
                        ActualValue := BilledValueExTax;

                    NetProfitValue := 0;
                    //MESSAGE('%1--Project Value-%2--SPV-%3--PPV-%4--AV',ProjectValue,SubProjectValue,PMCProjectValue,ActualValue);
                    NetProfitValue := (ProjectValue - ActualValue);

                    IF NetProfitValue <= 2000 THEN
                        CurrReport.SKIP;
                    SrNo += 1;

                end;
            }
            dataitem(SubProject; Job)
            {
                DataItemLink = "Project Manager" = FIELD("No.");
                DataItemTableView = SORTING("No.")
                                    WHERE("Type Of Project" = FILTER("Sub Project"));
                column(Sr_No1; SrNo)
                {
                }
                column(Project_No1; "No.")
                {
                }
                column(Project_Name1; Description)
                {
                }
                column(Type_Project1; "Type Of Project")
                {
                }
                column(Actual_Value1; ActualValue)
                {
                }
                column(Billed_Value1; BilledValue)
                {
                }
                column(Project_Value1; ProjectValue)
                {
                }
                column(SubProject_Value1; SubProjectValue)
                {
                }
                column(Cal_Percentage1; CalPercentage)
                {
                }
                column(NetProfit_Value1; NetProfitValue)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    GetProject.GET("Parent Project Code");
                    ProjectValue := 0;
                    ProjectValue := GetProject."Project Value";

                    BilledValue := 0;
                    BilledValueExTax := 0;
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETCURRENTKEY("Shortcut Dimension 1 Code");
                    SalesInvHeader.SETRANGE("Shortcut Dimension 1 Code", GetProject."Global Dimension 1 Code");
                    SalesInvHeader.SETFILTER("Type Of Note", '<>%1', SalesInvHeader."Type Of Note"::Debit);
                    SalesInvHeader.SETFILTER("Posting Date", '%1..%2', 0D, AsonDate);
                    IF SalesInvHeader.FINDSET THEN BEGIN
                        REPEAT
                            IF SalesInvHeader."Currency Code" <> '' THEN
                                ExchangeRate := 1 / SalesInvHeader."Currency Factor"
                            ELSE
                                ExchangeRate := 1;

                            //SalesInvHeader.CALCFIELDS("Amount to Customer");
                            SalesInvHeader.CALCFIELDS(Amount);
                            BilledValue += ROUND((SalesInvHeader.Amount * ExchangeRate), 0.01);
                            BilledValueExTax += ROUND((SalesInvHeader.Amount * ExchangeRate), 0.01);
                        UNTIL SalesInvHeader.NEXT = 0;
                    END;
                    SalesCrMemoHeader.RESET;
                    SalesCrMemoHeader.SETCURRENTKEY("Shortcut Dimension 1 Code");
                    SalesCrMemoHeader.SETRANGE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                    SalesCrMemoHeader.SETFILTER("Posting Date", '%1..%2', 0D, AsonDate);
                    IF SalesCrMemoHeader.FINDSET THEN BEGIN
                        REPEAT
                            IF SalesCrMemoHeader."Currency Code" <> '' THEN
                                ExchangeRate := 1 / SalesCrMemoHeader."Currency Factor"
                            ELSE
                                ExchangeRate := 1;

                            //SalesCrMemoHeader.CALCFIELDS("Amount to Customer");
                            SalesCrMemoHeader.CALCFIELDS(Amount);
                            BilledValue -= ROUND((SalesCrMemoHeader.Amount * ExchangeRate), 0.01);
                            BilledValueExTax -= ROUND((SalesCrMemoHeader.Amount * ExchangeRate), 0.01);
                        UNTIL SalesCrMemoHeader.NEXT = 0;
                    END;

                    SubProjectValue := 0;
                    SubProjectValue := SubProject."Project Value";

                    CalPercentage := 0;
                    IF ProjectValue <> 0 THEN
                        CalPercentage := SubProjectValue / ProjectValue;

                    ActualValue := 0;
                    CalValue := 0;
                    CalValue := CalPercentage * BilledValueExTax;
                    ActualValue := CalValue;

                    NetProfitValue := 0;
                    NetProfitValue := SubProjectValue - ActualValue;

                    IF NetProfitValue <= 0 THEN
                        CurrReport.SKIP;


                    SrNo += 1;
                end;
            }
            dataitem(PMCProject; Job)
            {
                DataItemLink = "Project Manager" = FIELD("No.");
                DataItemTableView = SORTING("No.")
                                    WHERE("Type Of Project" = FILTER("PMC Project"));
                column(Sr_No2; SrNo)
                {
                }
                column(Project_No2; "No.")
                {
                }
                column(Project_Name2; Description)
                {
                }
                column(Type_Project2; "Type Of Project")
                {
                }
                column(Actual_Value2; ActualValue)
                {
                }
                column(Billed_Value2; BilledValue)
                {
                }
                column(Project_Value2; ProjectValue)
                {
                }
                column(SubProject_Value2; PMCProjectValue)
                {
                }
                column(Cal_Percentage2; CalPercentage)
                {
                }
                column(NetProfit_Value2; NetProfitValue)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    GetProject.GET("Parent Project Code");
                    ProjectValue := 0;
                    ProjectValue := GetProject."Project Value";

                    BilledValue := 0;
                    BilledValueExTax := 0;
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETCURRENTKEY("Shortcut Dimension 1 Code");
                    SalesInvHeader.SETRANGE("Shortcut Dimension 1 Code", GetProject."Global Dimension 1 Code");
                    SalesInvHeader.SETFILTER("Type Of Note", '<>%1', SalesInvHeader."Type Of Note"::Debit);
                    SalesInvHeader.SETFILTER("Posting Date", '%1..%2', 0D, AsonDate);
                    IF SalesInvHeader.FINDSET THEN BEGIN
                        REPEAT
                            //SalesInvHeader.CALCFIELDS("Amount to Customer");
                            SalesInvHeader.CALCFIELDS(Amount);
                            BilledValue += SalesInvHeader.Amount;
                            BilledValueExTax += SalesInvHeader.Amount;
                        UNTIL SalesInvHeader.NEXT = 0;
                    END;

                    PMCProjectValue := 0;
                    PMCProjectValue := PMCProject."Project Value";

                    CalPercentage := 0;
                    IF ProjectValue <> 0 THEN
                        CalPercentage := PMCProjectValue / ProjectValue;

                    ActualValue := 0;
                    CalValue := 0;
                    CalValue := CalPercentage * BilledValueExTax;
                    ActualValue := CalValue;

                    NetProfitValue := 0;
                    NetProfitValue := PMCProjectValue - ActualValue;

                    IF NetProfitValue <= 0 THEN
                        CurrReport.SKIP;


                    SrNo += 1;
                end;
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

        layout
        {
            area(content)
            {
                field("Project Manager Code"; ManagerCode)
                {
                    TableRelation = Employee."No." WHERE("Project Manager for Cash Flow" = CONST(true));

                    trigger OnValidate()
                    begin
                        //GetEmployee.GET(USERID);
                        //IF NOT GetEmployee."TL Report" THEN
                        //  ERROR('You are not authorized for using this filter');
                    end;
                }
                field("As On Date"; AsonDate)
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

    trigger OnPreReport()
    begin
        GetCompanyInfo.GET;
        GetCompanyInfo.CALCFIELDS(Picture);

        IF GetCompanyInfo."New Name Date" <> 0D THEN BEGIN
            IF WORKDATE >= GetCompanyInfo."New Name Date" THEN
                CompanyNameText := GetCompanyInfo.Name
            ELSE
                CompanyNameText := GetCompanyInfo."Old Name";
        END ELSE
            CompanyNameText := GetCompanyInfo.Name;
    end;

    var
        DateFilterCap: Label 'Date Filter';
        SNoCap: Label 'S. No.';
        EmpCodeCap: Label 'Employee Code';
        EmpNameCap: Label 'Employee Name';
        TypeOfProjectCap: Label 'Type of Project';
        ProjectCodeCap: Label 'Project Code';
        ProjectNameCap: Label 'Project Name';
        ProjectValueCap: Label 'Project Value';
        BilledValueCap: Label 'Billed Value (Inc. Of Tax)';
        ActualProjectValueCap: Label 'Actual Billed Value';
        SPValueCap: Label 'SP Value';
        NetProjectValueCap: Label 'Net project Value';
        GetCompanyInfo: Record "Company Information";
        GetEmployee: Record Employee;
        ManagerCode: Code[20];
        SalesInvHeader: Record "Sales Invoice Header";
        BilledValue: Decimal;
        ProjectValue: Decimal;
        GetProject: Record Job;
        SubProjectValue: Decimal;
        CalPercentage: Decimal;
        ActualValue: Decimal;
        ProjValueInHandCap: Label 'Proj Value In Hand';
        PMCValueCap: Label 'PMC Value';
        Text13700: Label 'End Date cannot be before Start Date.';
        Text13703: Label 'Start Date cannot be after End Date.';
        CalValue: Decimal;
        NetProfitValue: Decimal;
        SrNo: Integer;
        TotalCap: Label 'Total';
        SalesInvoiceLine: Record "Sales Invoice Line";
        BilledValueExTax: Decimal;
        PMCProjectValue: Decimal;
        ActualValueSub: Decimal;
        ActualValuePMC: Decimal;
        CalPercentage1: Decimal;
        CalValue1: Decimal;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ExchangeRate: Decimal;
        CompanyNameText: Text;
        AsonDate: Date;
}

