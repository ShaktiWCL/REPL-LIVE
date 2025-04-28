report 50080 "TL-Expense Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TLExpenseDetail.rdl';
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
            column(ACDescription_Cap; ACDescriptionCap)
            {
            }
            column(Amount_Cap; AmountCap)
            {
            }
            column(CostCenter_Cap; CostCenterCap)
            {
            }
            column(Remarks_Cap; RemarksCap)
            {
            }
            column(ExpenseDetail_Cap; ExpenseDetailCap)
            {
            }
            column(DateFilter_Cap; DateFilterCap)
            {
            }
            column(TotalCap; TotalCap)
            {
            }
            column(ExpenseDate_Cap; ExpenseDateCap)
            {
            }
            column(VoucherNo_Cap; VoucherNoCap)
            {
            }
            column(ExtDocNo_Cap; ExtDocNoCap)
            {
            }
            dataitem(Project; Job)
            {
                DataItemLink = "Project Manager" = FIELD("No.");
                DataItemTableView = SORTING("No.");
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code");
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
                    column(GLEntry_Description; "G/L Entry".Description)
                    {
                    }
                    column(GLEntry_Amount; "G/L Entry".Amount)
                    {
                    }
                    column(GLEntry_GlobalDimension1Code; "G/L Entry"."Global Dimension 1 Code")
                    {
                    }
                    column(Text_Remarks; TextRemarks)
                    {
                    }
                    column(Expense_Date; FORMAT("G/L Entry"."Posting Date"))
                    {
                    }
                    column(Voucher_No; "G/L Entry"."Document No.")
                    {
                    }
                    column(Ext_DocumentNo; "G/L Entry"."External Document No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        TextRemarks := '';
                        // PostedNarration.RESET;
                        // PostedNarration.SETCURRENTKEY("Transaction No.");
                        // PostedNarration.SETRANGE("Transaction No.", "Transaction No.");
                        // IF PostedNarration.FINDSET THEN BEGIN
                        //     REPEAT
                        //         TextRemarks += PostedNarration.Narration;
                        //     UNTIL PostedNarration.NEXT = 0;
                        //END;

                        SrNo += 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE("Source Code", 'JOURNALV');
                        SETRANGE(Reversed, FALSE);
                        SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                        SETFILTER("G/L Account No.", '>%1', '400000');
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
        GetCompanyInfo: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        ManagerCode: Code[20];
        SrNoCap: Label 'S. No.';
        ManagerCodeCap: Label 'Employee Code';
        ManagerNameCap: Label 'Employee Code';
        ProjectCodeCap: Label 'Project Code';
        ProjectNameCap: Label 'Project Name';
        ACDescriptionCap: Label 'A/C Description';
        AmountCap: Label 'Amount';
        CostCenterCap: Label 'Cost Center';
        RemarksCap: Label 'Remarks';
        ExpenseDetailCap: Label 'Expense Detail';
        DateFilterCap: Label 'Date Filters';
        TotalCap: Label 'Total';
        //PostedNarration: Record "16548";
        TextRemarks: Text;
        SrNo: Integer;
        GetEmployee: Record Employee;
        Text13700: Label 'End Date cannot be before Start Date.';
        Text13703: Label 'Start Date cannot be after End Date.';
        ExpenseDateCap: Label 'Expense Date';
        VoucherNoCap: Label 'Voucher No.';
        ExtDocNoCap: Label 'External Document No.';
        GLEntry: Record "G/L Entry";
        CompanyNameText: Text;
}

