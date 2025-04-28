report 50137 "Complete Project Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CompleteProjectDetails.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Project; Job)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(ProjectNo_Project; Project."No.")
            {
            }
            column(ProjectName_Project; Project.Description)
            {
            }
            column(ProjectName2_Project; Project."Description 2")
            {
            }
            column(BilltoCustomerNo_Project; Project."Bill-to Customer No.")
            {
            }
            column(CustName; CustName)
            {
            }
            column(ProjectValue_Project; Project."Project Value")
            {
            }
            column(AgreementToDate_Project; Project."Agreement To Date")
            {
            }
            column(ExpenseBooked; TotalExpense)
            {
            }
            dataitem("Project Task"; "Job Task")
            {
                DataItemLink = "Job No." = FIELD("No.");
                column(Milestone_ProjectTask; "Project Task".Milestone)
                {
                }
                column(MilestoneDesc_ProjectTask; "Project Task"."Milestone Desc")
                {
                }
                column(Amount_ProjectTask; "Project Task".Amount)
                {
                }
                column(BalanceAmount_ProjectTaskb; "Project Task"."Balance Amount")
                {
                }
                column(PlannedBillDate_ProjectTask; "Project Task"."Planned Bill Date")
                {
                }
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code");
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending);
                column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
                {
                }
                column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
                {
                }
                column(AmounttoCustomer_SalesInvoiceHeader; "Sales Invoice Header".Amount)
                {
                }
                column(RemainingAmount_SalesInvoiceHeader; "Sales Invoice Header"."Remaining Amount")
                {
                }
                column(MileStoneCode; GetMileStoneCode("Sales Invoice Header"."No."))
                {
                }
                column(RevisedAmount; RevisedAmount)
                {
                }
                column(ReversalDocNo; ReversalDocNo)
                {
                }
                column(TotalReceiptAmount; TotalReceiptAmount)
                {
                }
                column(OtherPaidAmount; OtherPaidAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ReversalDocNo := '';
                    RevisedAmount := 0;
                    //ReversalDocNo:= GetReversalDocNo("Sales Invoice Header"."No.","Shortcut Dimension 1 Code");
                    RevisedAmount := GetReversalAmt("Sales Invoice Header"."No.", "Shortcut Dimension 1 Code");
                    "Sales Invoice Header".CALCFIELDS(Amount);

                    TotalReceiptAmount := 0;
                    OutStandingAmount := 0;
                    OtherPaidAmount := 0;
                    PaidAmount := 0;

                    CustLedgEntry.RESET;
                    CustLedgEntry.SETCURRENTKEY("Source Code");
                    CustLedgEntry.SETRANGE("Document No.", "No.");
                    //CustLedgEntry.SETFILTER("Source Code",'%1','BANKRCPTV');
                    IF CustLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            //Condition 1
                            DetailedCustLedgEntry.RESET;
                            DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
                            DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                            DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
                            DetailedCustLedgEntry.SETRANGE(Unapplied, FALSE);
                            //DetailedCustLedgEntry.SETFILTER("Initial Document Type",'%1',DetailedCustLedgEntry."Initial Document Type" :: Invoice);
                            IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                                REPEAT
                                    CustLedgEntry2.RESET;
                                    CustLedgEntry2.SETRANGE("Document No.", DetailedCustLedgEntry."Document No.");
                                    CustLedgEntry2.SETFILTER("Source Code", '%1', 'BANKRCPTV');
                                    IF CustLedgEntry2.FINDFIRST THEN
                                        TotalReceiptAmount += -(DetailedCustLedgEntry."Amount (LCY)")
                                    ELSE
                                        OtherPaidAmount += -(DetailedCustLedgEntry."Amount (LCY)");
                                    IF "Sales Invoice Header".Amount = TotalReceiptAmount THEN
                                        ReversalDocNo := ''
                                    ELSE
                                        ReversalDocNo := DetailedCustLedgEntry."Document No.";
                                UNTIL DetailedCustLedgEntry.NEXT = 0;
                            END;
                            //Condition 1

                            //Condition 2
                            DetailedCustLedgEntry.RESET;
                            DetailedCustLedgEntry.SETCURRENTKEY("Document No.");
                            DetailedCustLedgEntry.SETRANGE("Document No.", CustLedgEntry."Document No.");
                            DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
                            DetailedCustLedgEntry.SETRANGE(Unapplied, FALSE);
                            //DetailedCustLedgEntry.SETFILTER("Document Type",'%1',DetailedCustLedgEntry."Document Type" :: Invoice);
                            IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                                REPEAT
                                    CustLedgEntry2.GET(DetailedCustLedgEntry."Cust. Ledger Entry No.");
                                    IF CustLedgEntry2."Source Code" = 'BANKRCPTV' THEN
                                        TotalReceiptAmount += (DetailedCustLedgEntry."Amount (LCY)")
                                    ELSE
                                        OtherPaidAmount += (DetailedCustLedgEntry."Amount (LCY)");
                                    ReversalDocNo := DetailedCustLedgEntry."Document No.";
                                UNTIL DetailedCustLedgEntry.NEXT = 0;
                            END;
                        //Condition 2

                        UNTIL CustLedgEntry.NEXT = 0;
                    END;

                    /*
                    //Condition 1
                    DetailedCustLedgEntry.RESET;
                    DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.","Entry Type");
                    DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.",Cust_Ledger_Entry_Dr."Entry No.");
                    DetailedCustLedgEntry.SETFILTER("Entry Type",'%1',DetailedCustLedgEntry."Entry Type" :: Application);
                    DetailedCustLedgEntry.SETRANGE(Unapplied,FALSE);
                    //DetailedCustLedgEntry.SETFILTER("Initial Document Type",'%1',DetailedCustLedgEntry."Initial Document Type" :: Invoice);
                    IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                      REPEAT
                        CustLedgEntry.RESET;
                        CustLedgEntry.SETRANGE("Document No.",DetailedCustLedgEntry."Document No.");
                        CustLedgEntry.SETFILTER("Source Code",'%1','BANKRCPTV');
                        IF CustLedgEntry.FINDFIRST THEN
                          ReceiptPaidAmount += -(DetailedCustLedgEntry."Amount (LCY)")
                        ELSE
                          OtherPaidAmount += -(DetailedCustLedgEntry."Amount (LCY)");
                      UNTIL DetailedCustLedgEntry.NEXT =0;
                    END;
                    //Condition 1
                    
                    //Condition 2
                    DetailedCustLedgEntry.RESET;
                    DetailedCustLedgEntry.SETCURRENTKEY("Document No.");
                    DetailedCustLedgEntry.SETRANGE("Document No.",Cust_Ledger_Entry_Dr."Document No.");
                    DetailedCustLedgEntry.SETFILTER("Entry Type",'%1',DetailedCustLedgEntry."Entry Type" :: Application);
                    DetailedCustLedgEntry.SETRANGE(Unapplied,FALSE);
                    //DetailedCustLedgEntry.SETFILTER("Document Type",'%1',DetailedCustLedgEntry."Document Type" :: Invoice);
                    IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                      REPEAT
                        CustLedgEntry.GET(DetailedCustLedgEntry."Cust. Ledger Entry No.");
                        IF CustLedgEntry."Source Code" = 'BANKRCPTV' THEN
                          ReceiptPaidAmount += (DetailedCustLedgEntry."Amount (LCY)")
                        ELSE
                          OtherPaidAmount += (DetailedCustLedgEntry."Amount (LCY)");
                      UNTIL DetailedCustLedgEntry.NEXT =0;
                    END;
                    //Condition 2
                    
                    
                    
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                CustName := '';
                IF Cust.GET(Project."Bill-to Customer No.") THEN
                    CustName := Cust.Name;

                TotalExpense := 0;
                GLEntry.RESET;
                GLEntry.SETCURRENTKEY(Amount, "G/L Account No.", "Global Dimension 1 Code");
                GLEntry.SETFILTER(Amount, '>%1', 0);
                GLEntry.SETFILTER("G/L Account No.", '>%1', '400000');
                GLEntry.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                GLEntry.SETFILTER("Document Type", '%1', GLEntry."Document Type"::" ");
                GLEntry.SETRANGE(Reversed, FALSE);
                IF GLEntry.FINDSET THEN BEGIN
                    REPEAT
                        IF (GLEntry."Source Code" = 'JOURNALV') OR (GLEntry."Source Code" = '') THEN
                            TotalExpense += GLEntry.Amount;
                    UNTIL GLEntry.NEXT = 0;
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
        Cust: Record Customer;
        CustName: Text;
        ExpenseBooked: Decimal;
        SalesCreditMemoHrd: Record "Sales Cr.Memo Header";
        RevisedAmount: Decimal;
        ReversalDocNo: Code[40];
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        TotalReceiptAmount: Decimal;
        OutStandingAmount: Decimal;
        PaidAmount: Decimal;
        CustLedgerEntry1: Record "Cust. Ledger Entry";
        GLEntry: Record "G/L Entry";
        TotalExpense: Decimal;
        OtherPaidAmount: Decimal;
        CustLedgEntry2: Record "Cust. Ledger Entry";

    procedure GetMileStoneCode(DocNo: Code[40]) MileStoneCode: Text
    var
        SIL: Record "Sales Invoice Line";
    begin
        SIL.SETRANGE("Document No.", DocNo);
        IF SIL.FINDFIRST THEN
            REPEAT
                IF MileStoneCode <> '' THEN
                    MileStoneCode += ',' + SIL.Milestone
                ELSE
                    MileStoneCode := SIL.Milestone;
            UNTIL SIL.NEXT = 0;
        EXIT(MileStoneCode);
    end;


    procedure GetReversalDocNo(DocNo: Code[40]; CostCentre: Code[20]) RevsalDoc: Text
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        CustLedgerEntry.SETRANGE("Document No.", DocNo);
        CustLedgerEntry.SETRANGE("Global Dimension 1 Code", CostCentre);
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            REPEAT
                DetailedCustLedgerEntry.SETRANGE("Entry Type", DetailedCustLedgerEntry."Entry Type"::Application);
                DetailedCustLedgerEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                DetailedCustLedgerEntry.SETFILTER("Document Type", '%1', DetailedCustLedgerEntry."Document Type"::"Credit Memo");
                IF DetailedCustLedgerEntry.FINDFIRST THEN BEGIN
                    RevsalDoc := DetailedCustLedgerEntry."Document No.";
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
        END;
    end;


    procedure GetReversalAmt(DocNo: Code[40]; CostCentre: Code[20]) RevsalAmt: Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        CustLedgerEntry.SETRANGE("Document No.", DocNo);
        CustLedgerEntry.SETRANGE("Global Dimension 1 Code", CostCentre);
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            REPEAT
                DetailedCustLedgerEntry.SETRANGE("Entry Type", DetailedCustLedgerEntry."Entry Type"::Application);
                DetailedCustLedgerEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                DetailedCustLedgerEntry.SETFILTER("Document Type", '%1', DetailedCustLedgerEntry."Document Type"::"Credit Memo");
                IF DetailedCustLedgerEntry.FINDFIRST THEN BEGIN
                    RevsalAmt += ABS(DetailedCustLedgerEntry."Amount (LCY)");
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
        END;
    end;
}

