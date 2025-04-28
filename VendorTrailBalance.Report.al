report 50020 "Vendor Trail Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/VendorTrailBalance.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.";
            column(No_Vendor; Vendor."No.")
            {
            }
            column(Name_Vendor; Vendor.Name)
            {
            }
            column(OpeningAmtNoi; OpeningAmtNoi)
            {
            }
            column(OpeningAmtDel; OpeningAmtDel)
            {
            }
            column(OpeningAmtLuc; OpeningAmtLuc)
            {
            }
            column(OpeningAmtBho; OpeningAmtBho)
            {
            }
            column(DebitNoi; DebitNoi)
            {
            }
            column(DebitDel; DebitDel)
            {
            }
            column(DebitLuc; DebitLuc)
            {
            }
            column(DebitBho; DebitBho)
            {
            }
            column(CreditNoi; CreditNoi)
            {
            }
            column(CreditDel; CreditDel)
            {
            }
            column(CreditLuc; CreditLuc)
            {
            }
            column(CreditBho; CreditBho)
            {
            }
            column(ClosingNoi; OpeningAmtNoi + DebitNoi - CreditNoi)
            {
            }
            column(ClosingDel; OpeningAmtDel + DebitDel - CreditDel)
            {
            }
            column(ClosingLuc; OpeningAmtLuc + DebitLuc - CreditLuc)
            {
            }
            column(ClosingBho; OpeningAmtBho + DebitBho - CreditBho)
            {
            }

            trigger OnAfterGetRecord()
            begin
                OpeningAmtNoi := 0;
                OpeningAmtDel := 0;
                OpeningAmtLuc := 0;
                OpeningAmtBho := 0;
                VendLedEntry.RESET;
                VendLedEntry.SETRANGE("Vendor No.", "No.");
                VendLedEntry.SETFILTER("Posting Date", '%1..%2', 0D, FromDate - 1);
                IF VendLedEntry.FIND('-') THEN
                    REPEAT
                        CASE VendLedEntry."Global Dimension 2 Code" OF
                            'REPLNOIDA':
                                BEGIN
                                    VendLedEntry.CALCFIELDS("Amount (LCY)");
                                    OpeningAmtNoi += VendLedEntry."Amount (LCY)";
                                END;
                            'REPLDELHI':
                                BEGIN
                                    VendLedEntry.CALCFIELDS("Amount (LCY)");
                                    OpeningAmtDel += VendLedEntry."Amount (LCY)";
                                END;
                            'REPLLUCKNOW':
                                BEGIN
                                    VendLedEntry.CALCFIELDS("Amount (LCY)");
                                    OpeningAmtLuc += VendLedEntry."Amount (LCY)";
                                END;
                            'REPLBHOPAL':
                                BEGIN
                                    VendLedEntry.CALCFIELDS("Amount (LCY)");
                                    OpeningAmtBho += VendLedEntry."Amount (LCY)";
                                END;
                        END;
                    UNTIL VendLedEntry.NEXT = 0;

                DebitNoi := 0;
                DebitDel := 0;
                DebitLuc := 0;
                DebitBho := 0;
                CreditNoi := 0;
                CreditDel := 0;
                CreditLuc := 0;
                CreditBho := 0;
                VendLedEntry1.RESET;
                VendLedEntry1.SETRANGE("Vendor No.", "No.");
                VendLedEntry1.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                IF VendLedEntry1.FIND('-') THEN
                    REPEAT
                        CASE VendLedEntry1."Global Dimension 2 Code" OF
                            'REPLNOIDA':
                                BEGIN
                                    VendLedEntry1.CALCFIELDS("Debit Amount (LCY)");
                                    VendLedEntry1.CALCFIELDS("Credit Amount (LCY)");
                                    DebitNoi += VendLedEntry1."Debit Amount (LCY)";
                                    CreditNoi += VendLedEntry1."Credit Amount (LCY)";
                                END;
                            'REPLDELHI':
                                BEGIN
                                    VendLedEntry1.CALCFIELDS("Debit Amount (LCY)");
                                    VendLedEntry1.CALCFIELDS("Credit Amount (LCY)");
                                    DebitDel += VendLedEntry1."Debit Amount (LCY)";
                                    CreditDel += VendLedEntry1."Credit Amount (LCY)";
                                END;
                            'REPLLUCKNOW':
                                BEGIN
                                    VendLedEntry1.CALCFIELDS("Debit Amount (LCY)");
                                    VendLedEntry1.CALCFIELDS("Credit Amount (LCY)");
                                    DebitLuc += VendLedEntry1."Debit Amount (LCY)";
                                    CreditLuc += VendLedEntry1."Credit Amount (LCY)";
                                END;
                            'REPLBHOPAL':
                                BEGIN
                                    VendLedEntry1.CALCFIELDS("Debit Amount (LCY)");
                                    VendLedEntry1.CALCFIELDS("Credit Amount (LCY)");
                                    DebitBho += VendLedEntry1."Debit Amount (LCY)";
                                    CreditBho += VendLedEntry1."Credit Amount (LCY)";
                                END;
                        END;
                    UNTIL VendLedEntry1.NEXT = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("From Date"; FromDate)
                {
                }
                field("To Date"; ToDate)
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
        VendLedEntry: Record "Vendor Ledger Entry";
        VendLedEntry1: Record "Vendor Ledger Entry";
        FromDate: Date;
        ToDate: Date;
        OpeningAmtNoi: Decimal;
        OpeningAmtDel: Decimal;
        OpeningAmtLuc: Decimal;
        OpeningAmtBho: Decimal;
        DebitNoi: Decimal;
        DebitDel: Decimal;
        DebitLuc: Decimal;
        DebitBho: Decimal;
        CreditNoi: Decimal;
        CreditDel: Decimal;
        CreditLuc: Decimal;
        CreditBho: Decimal;
}

