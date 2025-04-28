report 50076 "STLCF-Mis. Expense"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/STLCFMisExpense.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.");
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                column(Document_No; "G/L Entry"."Document No.")
                {
                }
                column(Posting_Date; FORMAT("G/L Entry"."Posting Date"))
                {
                }
                column(OtherExp_Amt; OtherExpAmt)
                {
                }
                column(Start_Date; StartDate)
                {
                }
                column(End_Date; EndDate)
                {
                }
                column(DocumentNo_Cap; DocumentNoCap)
                {
                }
                column(PostingDate_Cap; PostingDateCap)
                {
                }
                column(OtherExpAmt_Cap; OtherExpAmtCap)
                {
                }
                column(MiscExp_Cap; MiscExpCap)
                {
                }
                column(DateFilter_Cap; DateFilterCap)
                {
                }
                column(Total_Cap; TotalCap)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    OtherExpAmt := 0;
                    GetProject.RESET;
                    GetProject.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                    IF GetProject.FINDFIRST THEN BEGIN
                        IF GetProject."Project Manager" = Employee."No." THEN
                            OtherExpAmt := Amount;
                    END;

                    IF OtherExpAmt = 0 THEN
                        CurrReport.SKIP
                end;

                trigger OnPreDataItem()
                begin
                    IF (StartDate = 0D) OR (EndDate = 0D) THEN
                        ERROR('Date must not be blank');

                    SETRANGE("Source Code", 'JOURNALV');
                    SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                    SETFILTER("G/L Account No.", '>%1', '400000');
                end;
            }

            trigger OnPreDataItem()
            begin
                IF ManagerCode <> '' THEN
                    SETFILTER(Employee."No.", '%1', ManagerCode);
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
                    TableRelation = Employee."No.";
                }
                field("Start Date"; StartDate)
                {
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

    var
        GetProject: Record Job;
        OtherExpAmt: Decimal;
        StartDate: Date;
        EndDate: Date;
        ManagerCode: Code[20];
        DocumentNoCap: Label 'Document No.';
        PostingDateCap: Label 'Posting Date';
        OtherExpAmtCap: Label 'Mis. Expense Amount';
        MiscExpCap: Label 'Mis. Expense';
        DateFilterCap: Label 'Date Filter';
        TotalCap: Label 'Total';
}

