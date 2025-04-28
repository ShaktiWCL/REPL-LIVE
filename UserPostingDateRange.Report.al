report 50094 "User Posting Date Range"
{
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("User Setup"; "User Setup")
        {
            DataItemTableView = SORTING("User ID")
                                WHERE(Department = FILTER(<> ' '));

            trigger OnAfterGetRecord()
            begin
                GetMonth := DATE2DMY(TODAY, 2);
                GetYear := DATE2DMY(TODAY, 3);
                GetDate := DMY2DATE(GeneralLedgerSetup."Date Set for Posting Rights", GetMonth, GetYear);

                IF "Posting Rights" THEN BEGIN
                    IF GetDate = TODAY THEN BEGIN
                        "Allow Posting From" := DMY2DATE(1, GetMonth, GetYear);
                        "Allow Posting To" := TODAY;
                        MODIFY
                    END ELSE BEGIN
                        "Allow Posting To" := TODAY;
                        MODIFY
                    END;
                END ELSE BEGIN
                    "Allow Posting From" := TODAY;
                    "Allow Posting To" := TODAY;
                    MODIFY
                END;
            end;

            trigger OnPreDataItem()
            begin
                GeneralLedgerSetup.GET;
                GeneralLedgerSetup.TESTFIELD("Date Set for Posting Rights");
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
        GeneralLedgerSetup: Record "General Ledger Setup";
        GetMonth: Integer;
        GetYear: Integer;
        GetDate: Date;
}

