report 50043 "TL Viability Reort"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TLViabilityReort.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Cash Flow Subpage"; "Cash Flow Subpage")
        {
            RequestFilterFields = "Project Manager Code";
            column(ProjectManagerCode_CashFlowSubpage; "Cash Flow Subpage"."Project Manager Code")
            {
            }
            column(ProjectManager_CashFlowSubpage; "Cash Flow Subpage"."Project Manager")
            {
            }
            column(ActualBilled_CashFlowSubpage; "Cash Flow Subpage"."Actual Billed")
            {
            }
            column(ExpectedReceipt; "Cash Flow Subpage"."Expected Receipt")
            {
            }
            column(ActualReceiptParentProj_CashFlowSubpage; "Cash Flow Subpage"."Actual Receipt (Parent Proj)")
            {
            }
            column(SubProjectReceipt_CashFlowSubpage; "Cash Flow Subpage"."Sub Project Receipt")
            {
            }
            column(PMCSubProjectReceipt_CashFlowSubpage; "Cash Flow Subpage"."PMC Sub Project Receipt")
            {
            }
            column(ParentProjectExpenses_CashFlowSubpage; "Cash Flow Subpage"."Parent Project Expenses")
            {
            }
            column(ActualConsultancyFeesEMD_CashFlowSubpage; "Cash Flow Subpage"."Actual Consultancy Fees/EMD" + GetOtherExpenses("Cash Flow Subpage"."Project Manager Code", StartDate, EndDate))
            {
            }
            column(StartDate_CashFlowSubpage; "Cash Flow Subpage"."Start Date")
            {
            }
            column(EndDate_CashFlowSubpage; "Cash Flow Subpage"."End Date")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(OutstandingAmount; GetOutstandingAmt("Cash Flow Subpage"."Project Manager Code"))
            {
            }
            column(EmployeeLocation; EmployeeLocation)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Employee.GET("Cash Flow Subpage"."Project Manager Code") THEN
                    EmployeeLocation := COPYSTR(Employee."Employee Location", 6, STRLEN(Employee."Employee Location"));

                OtherExp := 0;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Start Date", StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(A)
                {
                    field("Start Date"; StartDate)
                    {
                    }
                    field("End Date"; EndDate)
                    {
                    }
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

    trigger OnInitReport()
    begin
        Month2 := DATE2DMY(TODAY, 2);
        Year2 := DATE2DMY(TODAY, 3);

        IF Month1 IN [1, 2, 3] THEN
            Year3 := Year2 - 1
        ELSE
            Year3 := Year2;

        StartDate := DMY2DATE(1, 4, Year3);
        EndDate := DMY2DATE(31, 3, Year3 + 1);
    end;

    var
        HOD1: Code[40];
        Month1: Option " ",Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec;
        Year1: Option " ","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025";
        StartDate: Date;
        EndDate: Date;
        Month2: Integer;
        Year2: Integer;
        Year3: Integer;
        Employee: Record Employee;
        EmployeeLocation: Text;
        OtherExp: Decimal;

    procedure GetOutstandingAmt(ManagerCode: Code[20]) ProjectReceiptAmt: Decimal
    var
        Project: Record Job;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        CustLedgerEntry.SETFILTER("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETFILTER("Remaining Amt. (LCY)", '<>%1', 0);
        CustLedgerEntry.SETRANGE("Posting Date", 0D, TODAY);
        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                Project.RESET;
                Project.SETRANGE("Global Dimension 1 Code", CustLedgerEntry."Global Dimension 1 Code");
                IF Project.FINDFIRST THEN BEGIN
                    IF Project."Project Manager" = ManagerCode THEN
                        ProjectReceiptAmt += CustLedgerEntry."Remaining Amt. (LCY)";
                END;
            UNTIL CustLedgerEntry.NEXT = 0;

        EXIT(ProjectReceiptAmt);
    end;

    procedure GetOtherExpenses(ManagerCode: Code[20]; StartDate: Date; EndDate: Date) OtherExpAmt: Decimal
    var
        GLEntry: Record "G/L Entry";
        Project: Record Job;
    begin
        GLEntry.SETRANGE("Source Code", 'JOURNALV');
        GLEntry.SETRANGE("Posting Date", StartDate, EndDate);
        GLEntry.SETFILTER("G/L Account No.", '>%1', '400000');
        IF GLEntry.FINDFIRST THEN
            REPEAT
                Project.SETRANGE("Global Dimension 1 Code", GLEntry."Global Dimension 1 Code");
                IF Project.FINDFIRST THEN BEGIN
                    IF Project."Project Manager" = ManagerCode THEN
                        OtherExpAmt += GLEntry.Amount;
                END;
            UNTIL GLEntry.NEXT = 0;
    end;
}

