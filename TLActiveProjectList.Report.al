report 50086 "TL-Active Project List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TLActiveProjectList.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Project Manager" = FILTER(true),
                                      Status = FILTER(Active),
                                      "New Data" = FILTER(true));
            column(SrNo_Cap; SrNoCap)
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
            column(ProjectLocation_Cap; ProjectLocationCap)
            {
            }
            column(AgreementFrDate_Cap; AgreementFrDateCap)
            {
            }
            column(AgreementEnDate_Cap; AgreementEnDateCap)
            {
            }
            column(ProjectStartDate_Cap; ProjectStartDateCap)
            {
            }
            column(ProjectEndDate_Cap; ProjectEndDateCap)
            {
            }
            column(ProjectValue_Cap; ProjectValueCap)
            {
            }
            column(BudgetedCost_Cap; BudgetedCostCap)
            {
            }
            column(EstimatedProjCost_Cap; EstimatedProjCostCap)
            {
            }
            column(ActiveProject_Cap; ActiveProjectCap)
            {
            }
            column(Total_Cap; TotalCap)
            {
            }
            column(Expense_Cap; ExpenseCap)
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
            dataitem(Project; Job)
            {
                DataItemLink = "Project Manager" = FIELD("No.");
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "No.";
                column(Sr_No; SrNo)
                {
                }
                column(Manager_Code; Employee."No.")
                {
                }
                column(Manager_Name; Employee."First Name")
                {
                }
                column(Project_Code; "No.")
                {
                }
                column(Project_Name; Description)
                {
                }
                column(Project_Location; ProjectLocationDesc)
                {
                }
                column(Project_Value; "Project Value")
                {
                }
                column(Budgeted_Cost; "Budgeted Cost")
                {
                }
                column(Estimated_Project_Cost; "Estimated Project Cost")
                {
                }
                column(Agreement_From_Date; FORMAT("Agreement From Date"))
                {
                }
                column(Agreement_To_Date; FORMAT("Agreement To Date"))
                {
                }
                column(Project_Start_Date; FORMAT("Starting Date"))
                {
                }
                column(Project_End_Date; FORMAT("Ending Date"))
                {
                }
                column(InvoiceAmountExcTaxes_Cap; InvoiceAmountExcTaxesCap)
                {
                }
                column(LastMilesStoneDescription_Cap; LastMilesStoneDescriptionCap)
                {
                }
                column(Line_Amount; LineAmount)
                {
                }
                column(Milestone_Description; MilestoneDescription)
                {
                }
                column(Expense; Expense)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT ("Project Status" IN [0, 1, 2, 3, 7]) THEN
                        CurrReport.SKIP;

                    IF Project."No." = '' THEN
                        CurrReport.SKIP;

                    IF TempEmployeeCode <> Employee."No." THEN
                        SrNo := 0;

                    TempEmployeeCode := Employee."No.";

                    SrNo += 1;
                    ProjectLocationDesc := '';
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE("Global Dimension No.", 2);
                    DimensionValue.SETRANGE(Code, Project."Global Dimension 2 Code");
                    IF DimensionValue.FINDFIRST THEN
                        ProjectLocationDesc := DimensionValue.Name;


                    MilestoneDescription := '';
                    LineAmount := 0;
                    IF "Type Of Project" = "Type Of Project"::"Main Project" THEN BEGIN
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                            REPEAT
                                SalesInvHeader.RESET;
                                SalesInvHeader.SETRANGE("No.", SalesInvoiceLine."Document No.");
                                SalesInvHeader.SETFILTER("Type Of Note", '<>%1', SalesInvHeader."Type Of Note"::Debit);
                                IF SalesInvHeader.FINDFIRST THEN
                                    IF SalesInvHeader."Currency Code" <> '' THEN
                                        ExchangeRate := 1 / SalesInvHeader."Currency Factor"
                                    ELSE
                                        ExchangeRate := 1;
                                LineAmount += ROUND((SalesInvoiceLine.Amount * ExchangeRate), 0.01);
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;

                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Posting Date");
                        SalesInvoiceLine.SETRANGE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                        SalesInvoiceLine.SETFILTER("Job No.", '<>%1', '');
                        IF SalesInvoiceLine.FINDLAST THEN BEGIN
                            SalesInvHeader.RESET;
                            SalesInvHeader.SETRANGE("No.", SalesInvoiceLine."Document No.");
                            SalesInvHeader.SETFILTER("Type Of Note", '<>%1', SalesInvHeader."Type Of Note"::Debit);
                            IF SalesInvHeader.FINDFIRST THEN BEGIN
                                GetProjectTask.RESET;
                                GetProjectTask.SETRANGE("Job No.", SalesInvoiceLine."Job No.");
                                GetProjectTask.SETFILTER(Milestone, '%1', SalesInvoiceLine.Milestone);
                                IF GetProjectTask.FINDFIRST THEN
                                    MilestoneDescription := GetProjectTask."Milestone Desc";
                            END;
                        END;
                    END;

                    Expense := 0;
                    PurchInvHeader.RESET;
                    PurchInvHeader.SETRANGE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                    IF PurchInvHeader.FINDSET THEN BEGIN
                        REPEAT
                            IF PurchInvHeader."Currency Code" <> '' THEN
                                ExchangeRate := 1 / PurchInvHeader."Currency Factor"
                            ELSE
                                ExchangeRate := 1;

                            PurchInvHeader.CALCFIELDS(Amount);
                            Expense += ROUND((PurchInvHeader.Amount * ExchangeRate), 0.01);
                        UNTIL PurchInvHeader.NEXT = 0;
                    END;

                    PurchCrHeader.RESET;
                    PurchCrHeader.SETRANGE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                    IF PurchCrHeader.FINDSET THEN BEGIN
                        REPEAT
                            IF PurchCrHeader."Currency Code" <> '' THEN
                                ExchangeRate := 1 / PurchCrHeader."Currency Factor"
                            ELSE
                                ExchangeRate := 1;

                            PurchCrHeader.CALCFIELDS(Amount);
                            Expense -= ROUND((PurchCrHeader.Amount * ExchangeRate), 0.01);
                        UNTIL PurchCrHeader.NEXT = 0;
                    END;

                    GLEntry.RESET;
                    GLEntry.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                    GLEntry.SETFILTER("G/L Account No.", '>%1', '400000');
                    IF GLEntry.FINDSET THEN BEGIN
                        REPEAT
                            IF GLEntry."G/L Account No." <> '431030' THEN
                                Expense += GLEntry.Amount;
                        UNTIL GLEntry.NEXT = 0;
                    END;
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
                        GetEmployee.GET(USERID);
                        IF NOT GetEmployee."TL Report" THEN
                            ERROR('You are not authorized for using this filter');
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
        SrNoCap: Label 'Sr. No.';
        ManagerCodeCap: Label 'Employee Code';
        ManagerNameCap: Label 'Employee Name';
        ProjectCodeCap: Label 'Project Code';
        ProjectNameCap: Label 'Project Name';
        ProjectLocationCap: Label 'Project Location';
        AgreementFrDateCap: Label 'Agreement From Date';
        AgreementEnDateCap: Label 'Agreement End Date';
        ProjectStartDateCap: Label 'Start Date';
        ProjectEndDateCap: Label 'End Date';
        ProjectValueCap: Label 'Project Value';
        BudgetedCostCap: Label 'Budgeted Cost';
        EstimatedProjCostCap: Label 'Estimated Project Cost';
        GetCompanyInfo: Record "Company Information";
        ManagerCode: Code[20];
        SrNo: Integer;
        GetEmployee: Record Employee;
        ActiveProjectCap: Label 'Active Project Report';
        TotalCap: Label 'Total';
        DimensionValue: Record "Dimension Value";
        ProjectLocationDesc: Text;
        TempEmployeeCode: Code[20];
        InvoiceAmountExcTaxesCap: Label 'Invoice Amount (Exc Taxes)';
        LastMilesStoneDescriptionCap: Label 'Last MilesStone Description';
        SalesInvoiceLine: Record "Sales Invoice Line";
        LineAmount: Decimal;
        MilestoneDescription: Text;
        GetProjectTask: Record "Job Task";
        SalesInvHeader: Record "Sales Invoice Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        Expense: Decimal;
        GLEntry: Record "G/L Entry";
        ExpenseCap: Label 'Expense';
        PurchCrHeader: Record "Purch. Cr. Memo Hdr.";
        ExchangeRate: Decimal;
        CompanyNameText: Text;
}

