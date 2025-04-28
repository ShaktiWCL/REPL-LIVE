report 50038 "Auto Posting TDS JV Batch"
{
    //DefaultLayout = RDLC;
    //RDLCLayout = './AutoPostingTDSJVBatch.rdlc';
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
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

    trigger OnPreReport()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.GET;
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", GLSetup."TDS Recv Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", GLSetup."TDS Recv Batch Name");
        GenJournalLine.SETRANGE("TDS Receivable Atuo Entry", TRUE);
        IF GenJournalLine.FINDFIRST THEN BEGIN
            REPEAT
                GenJnlPostBatch.RUN(GenJournalLine);
            UNTIL GenJournalLine.NEXT = 0;
        END;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
}

