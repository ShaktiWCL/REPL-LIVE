report 50039 "REPL Cash Flow"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/REPLCashFlow.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Cash Flow Subpage"; "Cash Flow Subpage")
        {
            RequestFilterFields = "Project Manager Code";
            column(Month_CashFlowSubpage; "Cash Flow Subpage".Month)
            {
            }
            column(Year_CashFlowSubpage; "Cash Flow Subpage".Year)
            {
            }
            column(HOD_CashFlowSubpage; "Cash Flow Subpage".HOD)
            {
            }
            column(HODName_CashFlowSubpage; "Cash Flow Subpage"."HOD Name")
            {
            }
            column(ProjectManagerCode_CashFlowSubpage; "Cash Flow Subpage"."Project Manager Code")
            {
            }
            column(ProjectManager_CashFlowSubpage; "Cash Flow Subpage"."Project Manager")
            {
            }
            column(ExpectedBilling_CashFlowSubpage; "Cash Flow Subpage"."Expected Billing")
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
            column(ReceiptofTLInclSubPMCPro_CashFlowSubpage; "Cash Flow Subpage"."Receipt of TL Incl.Sub/PMC Pro")
            {
            }
            column(MonthlyDeskCost_CashFlowSubpage; "Cash Flow Subpage"."Monthly Desk Cost")
            {
            }
            column(ActualConsultancyFeesEMD_CashFlowSubpage; "Cash Flow Subpage"."Actual Consultancy Fees/EMD")
            {
            }
            column(MiscExpenses_CashFlowSubpage; "Cash Flow Subpage"."Misc. Expenses")
            {
            }
            column(ExpectedConsultantFeeEMD_CashFlowSubpage; "Cash Flow Subpage"."Expected Consultant Fee/EMD")
            {
            }
            column(Profitability_CashFlowSubpage; "Cash Flow Subpage"."Receipt of TL Incl.Sub/PMC Pro" - "Cash Flow Subpage"."Monthly Desk Cost" - "Cash Flow Subpage"."Actual Consultancy Fees/EMD")
            {
            }
            column(Authorised_CashFlowSubpage; "Cash Flow Subpage".Authorised)
            {
            }
            column(StartDate_CashFlowSubpage; "Cash Flow Subpage"."Start Date")
            {
            }
            column(EndDate_CashFlowSubpage; "Cash Flow Subpage"."End Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF ("Cash Flow Subpage"."Expected Billing" = 0) AND ("Cash Flow Subpage"."Actual Billed" = 0) AND
                  ("Cash Flow Subpage"."Expected Receipt" = 0) AND ("Cash Flow Subpage"."Actual Receipt (Parent Proj)" = 0) AND
                  ("Cash Flow Subpage"."Sub Project Receipt" = 0) AND ("Cash Flow Subpage"."PMC Sub Project Receipt" = 0) AND
                  ("Cash Flow Subpage"."Parent Project Expenses" = 0) AND ("Cash Flow Subpage"."Receipt of TL Incl.Sub/PMC Pro" = 0) AND
                  ("Cash Flow Subpage"."Monthly Desk Cost" = 0) AND ("Cash Flow Subpage"."Actual Consultancy Fees/EMD" = 0) AND
                  ("Cash Flow Subpage"."Misc. Expenses" = 0) AND ("Cash Flow Subpage"."Expected Consultant Fee/EMD" = 0) THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Start Date", StartDate, EndDate);
                /*
                IF HOD1 <>'' THEN
                SETRANGE(HOD,HOD1);
                IF Month1 <>Month1::" " THEN
                SETRANGE(Month,Month1);
                IF Year1 <>Year1::" " THEN
                SETRANGE(Year,Year1);
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {

                    trigger OnValidate()
                    begin
                        EndDate := CALCDATE('CM', StartDate);
                    end;
                }
                field("End Date"; EndDate)
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

    trigger OnInitReport()
    begin
        StartDate := CALCDATE('-CM', TODAY);
        EndDate := CALCDATE('CM', TODAY);
    end;

    var
        HOD1: Code[40];
        Month1: Option " ",Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec;
        Year1: Option " ","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025";
        StartDate: Date;
        EndDate: Date;
}

