report 50107 "EXPECTED PROJECT PROFITABILITY"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/EXPECTEDPROJECTPROFITABILITY.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Project; Job)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(EPPR_Cap; EPPRCap)
            {
            }
            column(ProjectName_Cap; ProjectNameCap)
            {
            }
            column(Client_Cap; ClientCap)
            {
            }
            column(LocationT_Cap; LocationTCap)
            {
            }
            column(DurationInMonth_Cap; DurationInMonthCap)
            {
            }
            column(EstimatedProjectCost_Cap; EstimatedProjectCostCap)
            {
            }
            column(REPLFees_Cap; REPLFeesCap)
            {
            }
            column(EMDBank_Cap; EMDBankCap)
            {
            }
            column(Expenses_Cap; ExpensesCap)
            {
            }
            column(ManPower1_Cap; ManPower1Cap)
            {
            }
            column(Name_Cap; NameCap)
            {
            }
            column(Role_Cap; RoleCap)
            {
            }
            column(Mandays_Cap; MandaysCap)
            {
            }
            column(DeskCostperday_Cap; DeskCostperdayCap)
            {
            }
            column(TotalRs_Cap; TotalRsCap)
            {
            }
            column(Total1_Cap; Total1Cap)
            {
            }
            column(Other_Expense; OtherExpense)
            {
            }
            column(Location_Cap; LocationCap)
            {
            }
            column(Total2_Cap; Total2Cap)
            {
            }
            column(Noofpersons_Cap; NoofpersonsCap)
            {
            }
            column(Stays_Cap; StaysCap)
            {
            }
            column(PMCAndSubProject_Cap; PMCAndSubProjectCap)
            {
            }
            column(Total3_Cap; Total3Cap)
            {
            }
            column(Description_Cap; DescriptionCap)
            {
            }
            column(Quantity_Cap; QuantityCap)
            {
            }
            column(Unit_Cap; UnitCap)
            {
            }
            column(Rate_Cap; RateCap)
            {
            }
            column(Amount_Cap; AmountCap)
            {
            }
            column(Contingency1_Cap; Contingency1Cap)
            {
            }
            column(CommissionBrokerage_Cap; CommissionBrokerageCap)
            {
            }
            column(Total4_Cap; Total4Cap)
            {
            }
            column(TotalEstimatedExpenses_Cap; TotalEstimatedExpensesCap)
            {
            }
            column(SummaryofExpenses_Cap; SummaryofExpensesCap)
            {
            }
            column(Manpower_Cap; ManpowerCap)
            {
            }
            column(OtherExpense_Cap; OtherExpenseCap)
            {
            }
            column(Outsourced_Cap; OutsourcedCap)
            {
            }
            column(SoilInvestigation_Cap; SoilInvestigationCap)
            {
            }
            column(Contingency_Cap; ContingencyCap)
            {
            }
            column(TotalExpenses_Cap; TotalExpensesCap)
            {
            }
            column(ProfessionalFee_Cap; ProfessionalFeeCap)
            {
            }
            column(ExpectedProfit_Cap; ExpectedProfitCap)
            {
            }
            column(InRsLacs_Cap; InRsLacsCap)
            {
            }
            column(InPercentage_Cap; InPercentageCap)
            {
            }
            column(Project_Project_Name; Project.Description)
            {
            }
            column(Project_BilltoName; Project."Bill-to Name")
            {
            }
            column(Project_BilltoCity; Project."Bill-to City")
            {
            }
            column(Duration_In_Months; DurationInMonths)
            {
            }
            column(Project_Estimated_Project_Cost; Project."Estimated Project Cost")
            {
            }
            column(Total_Expense; TotalExpense)
            {
            }
            column(Professional_Fees; PRPCTotalExpense)
            {
            }
            column(Project_Value; Project."Project Value")
            {
            }
            dataitem("Resource Requirment"; "Resource Requirment")
            {
                DataItemLink = "Project No." = FIELD("No.");
                column(Man_Days; ManDays)
                {
                }
                column(GetEmployee_FirstName; GetEmployee."First Name")
                {
                }
                column(IsTriggers_1; IsTriggers[1])
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SETCURRENTKEY(Resource);
                    IF TempResource <> Resource THEN BEGIN
                        ManDays := 0;
                        ResourceRequirment.RESET;
                        ResourceRequirment.SETRANGE("Project No.", "Project No.");
                        ResourceRequirment.SETRANGE(Resource, "Resource Requirment".Resource);
                        IF ResourceRequirment.FINDSET THEN BEGIN
                            REPEAT
                                ManDays += ResourceRequirment.Usage;
                            UNTIL ResourceRequirment.NEXT = 0;
                        END;
                        GetEmployee.GET(Resource);
                    END ELSE
                        CurrReport.SKIP;
                    TempResource := Resource;
                    IsTriggers[1] := TRUE;
                end;
            }
            dataitem(SubProject; Job)
            {
                DataItemLink = "Parent Project Code" = FIELD("No.");
                DataItemTableView = SORTING("No.");
                column(SubProject_ProjectName; SubProject.Description)
                {
                }
                column(SubProject_ProjectValue; SubProject."Project Value")
                {
                }
                column(IsTriggers_2; IsTriggers[2])
                {
                }
                column(TotalSubProject_Value; TotalSubProjectValue)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IsTriggers[2] := TRUE;
                    TotalSubProjectValue += SubProject."Project Value";
                end;
            }
            dataitem(CalCulations; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(Cal_Percentage; CalPercentage)
                {
                }
                column(SumTotal_Expense; SumTotalExpense)
                {
                }
                column(Expected_Profit; ExpectedProfit)
                {
                }
                column(ExpectedProfit_InLacs; ExpectedProfitInLacs)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SumTotalExpense := TotalSubProjectValue + TotalExpense;
                    ExpectedProfit := PRPCTotalExpense - SumTotalExpense;
                    ExpectedProfitInLacs := (ExpectedProfit / 100000);
                    IF PRPCTotalExpense <> 0 THEN
                        CalPercentage := ExpectedProfit / PRPCTotalExpense;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(IsTriggers);
                TotalSubProjectValue := 0;
                SumTotalExpense := 0;
                ExpectedProfit := 0;
                ExpectedProfitInLacs := 0;
                CalPercentage := 0;
                DurationInMonths := ROUND(("EndIng Date" - "Starting Date") / 30, 1, '>');

                //Other Expense
                TotalExpense := 0;
                GLEntry.RESET;
                GLEntry.SETCURRENTKEY(Amount, "G/L Account No.", "Global Dimension 1 Code");
                GLEntry.SETFILTER(Amount, '>%1', 0);
                GLEntry.SETFILTER("G/L Account No.", '>%1', '400000');
                GLEntry.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                GLEntry.SETFILTER("Document Type", '%1', GLEntry."Document Type"::" ");
                IF GLEntry.FINDSET THEN BEGIN
                    REPEAT
                        IF (GLEntry."Source Code" = 'JOURNALV') OR (GLEntry."Source Code" = '') THEN
                            TotalExpense += GLEntry.Amount;
                    UNTIL GLEntry.NEXT = 0;
                END;
                //Other Expense

                //Total Expense
                PRPCTotalExpense := 0;
                PurchInvHeader.RESET;
                PurchInvHeader.SETCURRENTKEY("Shortcut Dimension 1 Code");
                PurchInvHeader.SETRANGE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                IF PurchInvHeader.FINDSET THEN BEGIN
                    REPEAT
                        PurchInvHeader.CALCFIELDS(Amount);
                        PRPCTotalExpense += PurchInvHeader.Amount;
                    UNTIL PurchInvHeader.NEXT = 0;
                END;

                PurchCrMemoHdr.RESET;
                PurchCrMemoHdr.SETCURRENTKEY("Shortcut Dimension 1 Code");
                PurchCrMemoHdr.SETRANGE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                IF PurchCrMemoHdr.FINDSET THEN BEGIN
                    REPEAT
                        PurchCrMemoHdr.CALCFIELDS(Amount);
                        PRPCTotalExpense -= PurchCrMemoHdr.Amount;
                    UNTIL PurchCrMemoHdr.NEXT = 0;
                END;
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
        EPPRCap: Label 'EXPECTED PROJECT PROFITABILITY REPORT';
        ProjectNameCap: Label 'Project Name:';
        ClientCap: Label 'Client:';
        LocationTCap: Label 'Location:';
        DurationInMonthCap: Label 'Duration (In Months):';
        EstimatedProjectCostCap: Label 'Estimated Project Cost:';
        REPLFeesCap: Label 'REPL Fee:';
        EMDBankCap: Label 'EMD/Bank Guarantee';
        ExpensesCap: Label 'Expenses';
        ManPower1Cap: Label '1. Manpower';
        NameCap: Label 'Name';
        RoleCap: Label 'Role';
        MandaysCap: Label 'Mandays';
        DeskCostperdayCap: Label 'Desk Cost (per day)';
        TotalRsCap: Label 'Total (Rs.)';
        Total1Cap: Label 'Total (1)';
        OtherExpense: Label '2. Other Expense';
        Total2Cap: Label 'Total (2)';
        LocationCap: Label 'Location';
        NoofpersonsCap: Label 'No. of persons';
        StaysCap: Label 'Stays';
        PMCAndSubProjectCap: Label '3. Outsourced (Sub-project or Sub-contract)';
        Total3Cap: Label 'Total (3)';
        DescriptionCap: Label 'Description';
        QuantityCap: Label 'Quantity';
        UnitCap: Label 'Unit';
        RateCap: Label 'Rate';
        AmountCap: Label 'Amount';
        Contingency1Cap: Label '4. Contingency';
        CommissionBrokerageCap: Label 'Commission/Brokerage';
        Total4Cap: Label 'Total (4)';
        TotalEstimatedExpensesCap: Label 'Total Estimated Expenses ';
        SummaryofExpensesCap: Label 'Summary of Expenses';
        ManpowerCap: Label 'Manpower';
        OtherExpenseCap: Label 'Other Expense';
        OutsourcedCap: Label 'Outsourced';
        SoilInvestigationCap: Label 'Soil Investigation';
        ContingencyCap: Label 'Contingency';
        TotalExpensesCap: Label 'Total Expenses';
        ProfessionalFeeCap: Label 'Professional Fee';
        ExpectedProfitCap: Label 'Expected Profit';
        InRsLacsCap: Label 'In Rs. Lacs';
        InPercentageCap: Label 'In Percentage';
        DurationInMonths: Integer;
        GLEntry: Record "G/L Entry";
        TotalExpense: Decimal;
        GetEmployee: Record Employee;
        TempResource: Code[20];
        ResourceRequirment: Record "Resource Requirment";
        ManDays: Decimal;
        IsTriggers: array[5] of Boolean;
        TotalSubProjectValue: Decimal;
        PRPCTotalExpense: Decimal;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchInvHeader: Record "Purch. Inv. Header";
        SumTotalExpense: Decimal;
        ExpectedProfit: Decimal;
        ExpectedProfitInLacs: Decimal;
        CalPercentage: Decimal;
}

