report 50141 "PO Cycle"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/POCycle.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Buy-from Vendor No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = FILTER(Order));
            RequestFilterFields = "Shortcut Dimension 1 Code", "Buy-from Vendor No.", "No.";
            column(GetFilters; "Purchase Header".GETFILTERS)
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(OrderDate_PurchaseHeader; "Purchase Header"."Order Date")
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Purchase Header"."Buy-from Vendor Name")
            {
            }
            column(ShortcutDimension1Code_PurchaseHeader; "Purchase Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchaseHeader; "Purchase Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Paid_Amount; PaidAmount)
            {
            }
            column(PaidAmount2; PaidAmount2)
            {
            }
            column(PaidAmount3; PaidAmount3)
            {
            }
            column(PaidAmount4; PaidAmount4)
            {
            }
            column(AdjustedAmt; AdjustedAmt)
            {
            }
            column(AdvancePayment1; AdvancePayment1)
            {
            }
            column(InvoicedValue; InvoicedAmount1)
            {
            }
            column(Summary; Summary)
            {
            }
            column(Detail; Detail)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Type = FILTER(Item | "Fixed Asset"));
                column(Type_PurchaseLine; "Purchase Line".Type)
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(OutstandingQuantity_PurchaseLine; "Purchase Line"."Outstanding Quantity")
                {
                }
                column(QtytoInvoice_PurchaseLine; "Purchase Line"."Qty. to Invoice")
                {
                }
                column(QtytoReceive_PurchaseLine; "Purchase Line"."Qty. to Receive")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(QtyRcdNotInvoiced_PurchaseLine; "Purchase Line"."Qty. Rcd. Not Invoiced")
                {
                }
                column(QuantityReceived_PurchaseLine; "Purchase Line"."Quantity Received")
                {
                }
                column(QuantityInvoiced_PurchaseLine; "Purchase Line"."Quantity Invoiced")
                {
                }
                column(LineAmount_PurchaseLine; "Purchase Line"."Quantity Invoiced" * "Purchase Line"."Direct Unit Cost")
                {
                }
                column(InvoiceNo; GetReceiptNo("Purchase Line"."Document No.", "Purchase Line"."Line No."))
                {
                }
                column(ProjectNo; ProjectInfo[1])
                {
                }
                column(ProjectName; ProjectInfo[2])
                {
                }
                column(OrderValue; "Purchase Line".Quantity * "Purchase Line"."Direct Unit Cost")
                {
                }
                column(ReceiptValue; "Purchase Line"."Quantity Received" * "Purchase Line"."Direct Unit Cost")
                {
                }
                column(TotalGSTAmount; 0)
                {
                }
                column(InvoicedAmount; "Purchase Line"."Quantity Invoiced" * "Purchase Line"."Direct Unit Cost")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //MESSAGE('%1',GetVendLedEntryNo(GetReceiptNo("Purchase Line"."Document No.","Purchase Line"."Line No.")));
                    /*
                    PaidAmount4 := 0;
                    DetailedVendLedgEntry.RESET;
                    DetailedVendLedgEntry.SETCURRENTKEY("Vendor Ledger Entry No.","Entry Type");
                    DetailedVendLedgEntry.SETRANGE("Vendor Ledger Entry No.",GetVendLedEntryNo(GetReceiptNo("Purchase Line"."Document No.","Purchase Line"."Line No.")));
                    DetailedVendLedgEntry.SETFILTER("Entry Type",'%1',DetailedVendLedgEntry."Entry Type" :: Application);
                    DetailedVendLedgEntry.SETFILTER("Document Type",'%1|%2',DetailedVendLedgEntry."Document Type" :: Payment,DetailedVendLedgEntry."Document Type" :: Invoice);
                    IF DetailedVendLedgEntry.FINDSET THEN BEGIN
                      REPEAT
                        PaidAmount4 += ABS(DetailedVendLedgEntry."Amount (LCY)");
                      UNTIL DetailedVendLedgEntry.NEXT =0;
                    END;
                    
                    DetailedVendLedgEntry.RESET;
                    DetailedVendLedgEntry.SETCURRENTKEY("Document No.");
                    DetailedVendLedgEntry.SETRANGE("Document No.",GetReceiptNo("Purchase Line"."Document No.","Purchase Line"."Line No."));
                    DetailedVendLedgEntry.SETFILTER("Entry Type",'%1',DetailedVendLedgEntry."Entry Type" :: Application);
                    DetailedVendLedgEntry.SETFILTER("Document Type",'%1',DetailedVendLedgEntry."Document Type" :: Invoice);
                    DetailedVendLedgEntry.SETFILTER("Amount (LCY)",'>%1',0);
                    IF DetailedVendLedgEntry.FINDSET THEN BEGIN
                      REPEAT
                        PaidAmount4 += ABS(DetailedVendLedgEntry."Amount (LCY)");
                      UNTIL DetailedVendLedgEntry.NEXT =0;
                    END;
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                AdvancePayment1 := 0;
                IF GetAdvancePaymentCon1("Purchase Header"."No.") <> 0 THEN
                    AdvancePayment1 := GetAdvancePaymentCon1("Purchase Header"."No.")
                ELSE BEGIN
                    IF GetAdvanceAgstDirectPO("Purchase Header"."No.") <> 0 THEN
                        AdvancePayment1 := GetAdvanceAgstDirectPO("Purchase Header"."No.");
                END;

                AdjustedAmt := 0;
                IF GetPaidAdjustedAmt1("Purchase Header"."No.") <> 0 THEN
                    AdjustedAmt := GetPaidAdjustedAmt1("Purchase Header"."No.");


                InvoicedAmount1 := 0;
                InvoicedAmount1 := GetInvAmt(GetReptDocNo("No."));


                //PaidAmount4 := 0;
                //MESSAGE('%1',GetInvDocNo(GetReptDocNo("Purchase Header"."No.")));
                IF GetInvDocNo(GetReptDocNo("Purchase Header"."No.")) <> '' THEN BEGIN
                    VLE2.RESET;
                    VLE2.SETRANGE("Document Type", VLE2."Document Type"::Invoice);
                    VLE2.SETFILTER("Document No.", GetInvDocNo(GetReptDocNo("Purchase Header"."No.")));
                    IF VLE2.FINDFIRST THEN BEGIN
                        REPEAT
                            DVLE2.SETRANGE("Entry Type", DVLE2."Entry Type"::Application);
                            DVLE2.SETFILTER("Document Type", '%1|%2|%3', DVLE2."Document Type"::Invoice, DVLE2."Document Type"::Payment, DVLE2."Document Type"::" ");
                            DVLE2.SETRANGE("Vendor Ledger Entry No.", VLE2."Entry No.");
                            IF DVLE2.FINDFIRST THEN BEGIN
                                REPEAT
                                    PaidAmount4 += DVLE2."Amount (LCY)";
                                UNTIL DVLE2.NEXT = 0;
                            END;
                        UNTIL VLE2.NEXT = 0;
                    END;
                END;
                //MESSAGE('%1', PaidAmount4);

                //AD_RCPT
                CLEAR(ProjectInfo);
                GetProject.RESET;
                GetProject.SETRANGE("Global Dimension 1 Code", "Shortcut Dimension 1 Code");
                IF GetProject.FINDFIRST THEN BEGIN
                    ProjectInfo[1] := GetProject."No.";
                    ProjectInfo[2] := GetProject.Description;
                    ProjectType := GetProject."Type Of Project";
                END;
            end;

            trigger OnPreDataItem()
            begin
                //IF UserSetupMgt.GetPurchasesFilter3(USERID)<>'' THEN
                // SETRANGE("Shortcut Dimension 2 Code",UserSetupMgt.GetPurchasesFilter3(USERID));
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Summary; Summary)
                {
                }
                field(Detail; Detail)
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

    trigger OnPreReport()
    begin
        IF NOT Detail = TRUE THEN
            Summary := TRUE;
    end;

    var
        InvoiceNo: Code[50];
        PaidAmount: Decimal;
        PaidAmount2: Decimal;
        PaidAmount3: Decimal;
        PaidAmount4: Decimal;
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        PaidAmt: Decimal;
        Summary: Boolean;
        Detail: Boolean;
        UserSetupMgt: Codeunit "User Setup Management";
        GetProject: Record Job;
        ProjectInfo: array[2] of Text;
        ProjectType: Option;
        AdjustedAmt: Decimal;
        AdvancePayment1: Decimal;
        AdvanceAgPO: Decimal;
        InvoicedAmount1: Decimal;
        VLE: Record "Vendor Ledger Entry";
        DVLE: Record "Detailed Vendor Ledg. Entry";
        VLE2: Record "Vendor Ledger Entry";
        DVLE2: Record "Detailed Vendor Ledg. Entry";
        InvoicedAmount2: Decimal;
        VendorLedEntry2: Record "Vendor Ledger Entry";


    procedure GetPaidAmtCon1(CostCentre: Code[50]): Decimal
    var
        VLE: Record "Vendor Ledger Entry";
        DVLE: Record "Detailed Vendor Ledg. Entry";
        PaidCond1: Decimal;
    begin
        VLE.RESET;
        VLE.SETFILTER("Document Type", '%1|%2', VLE."Document Type"::Invoice, VLE."Document Type"::Payment);
        VLE.SETRANGE("Global Dimension 1 Code", CostCentre);
        IF VLE.FINDFIRST THEN BEGIN
            PaidCond1 := 0;
            REPEAT
                DVLE.RESET;
                DVLE.SETCURRENTKEY("Vendor Ledger Entry No.");
                //DVLE.SETRANGE("Source Code",'BANKPYMTV');
                DVLE.SETRANGE("Vendor Ledger Entry No.", VLE."Entry No.");
                DVLE.SETRANGE("Entry Type", DVLE."Entry Type"::Application);
                IF DVLE.FINDFIRST THEN BEGIN
                    REPEAT
                        PaidCond1 += DVLE."Amount (LCY)";
                    UNTIL DVLE.NEXT = 0;
                END;
            UNTIL VLE.NEXT = 0;
        END;
        EXIT(PaidCond1);
    end;


    procedure GetPaidAmtCon2(CostCentre: Code[50]; OrderNo: Code[50]): Decimal
    var
        VLE: Record "Vendor Ledger Entry";
        DVLE: Record "Detailed Vendor Ledg. Entry";
        PaidCond2: Decimal;
    begin
        VLE.RESET;
        VLE.SETFILTER("Document Type", '%1|%2', VLE."Document Type"::Invoice, VLE."Document Type"::Payment);

        VLE.SETRANGE("Global Dimension 1 Code", CostCentre);
        IF VLE.FINDFIRST THEN BEGIN
            PaidCond2 := 0;
            REPEAT
                DVLE.RESET;
                DVLE.SETCURRENTKEY("Vendor Ledger Entry No.");
                DVLE.SETRANGE("Source Code", 'PURCHAPPL');
                DVLE.SETRANGE("Vendor Ledger Entry No.", VLE."Entry No.");
                DVLE.SETFILTER(DVLE."Document Type", '%1|%2', DVLE."Document Type"::Payment, DVLE."Document Type"::Invoice);
                DVLE.SETRANGE("Entry Type", DVLE."Entry Type"::Application);
                IF DVLE.FINDFIRST THEN BEGIN
                    REPEAT
                        PaidCond2 += DVLE."Amount (LCY)";
                    UNTIL DVLE.NEXT = 0;
                END;
            UNTIL VLE.NEXT = 0;
        END;
        EXIT(PaidCond2);
    end;


    procedure GetPaidAmtCon3(CostCentre: Code[50]; OrderNo: Code[50]): Decimal
    var
        VLE: Record "Vendor Ledger Entry";
        DVLE: Record "Detailed Vendor Ledg. Entry";
        PaidCond3: Decimal;
    begin
        VLE.RESET;
        VLE.SETFILTER("Document Type", '%1|%2', VLE."Document Type"::Invoice, VLE."Document Type"::Payment);
        VLE.SETRANGE("Global Dimension 1 Code", CostCentre);
        VLE.SETRANGE("Order No.", OrderNo);
        IF VLE.FINDFIRST THEN BEGIN
            PaidCond3 := 0;
            REPEAT
                DVLE.RESET;
                DVLE.SETCURRENTKEY("Vendor Ledger Entry No.");
                DVLE.SETRANGE("Vendor Ledger Entry No.", VLE."Entry No.");
                DVLE.SETFILTER("Source Code", '<>%1', 'BANKPYMTV');
                DVLE.SETRANGE("Initial Document Type", DVLE."Initial Document Type"::Invoice);
                DVLE.SETFILTER("Document Type", '%1|%2', DVLE."Document Type"::Payment, DVLE."Document Type"::Invoice);
                DVLE.SETRANGE("Entry Type", DVLE."Entry Type"::Application);
                DVLE.SETFILTER("Amount (LCY)", '<>%1', 0);
                IF DVLE.FINDFIRST THEN BEGIN
                    REPEAT
                        PaidCond3 += DVLE."Amount (LCY)";
                    UNTIL DVLE.NEXT = 0;
                END;
            UNTIL VLE.NEXT = 0;
        END;
        EXIT(PaidCond3);
    end;


    procedure GetPaidAdjustedAmt1(OrderNo: Code[50]): Decimal
    var
        VLE: Record "Vendor Ledger Entry";
        DVLE: Record "Detailed Vendor Ledg. Entry";
        AdjustmentAmount2: Decimal;
    begin
        IF GetInvDocNo(GetReptDocNo(OrderNo)) <> '' THEN BEGIN
            VLE.SETRANGE("Document Type", VLE."Document Type"::Invoice);
            VLE.SETFILTER("Document No.", GetInvDocNo(GetReptDocNo(OrderNo)));
            IF VLE.FINDFIRST THEN BEGIN
                REPEAT
                    DVLE.RESET;
                    DVLE.SETCURRENTKEY("Vendor Ledger Entry No.");
                    DVLE.SETFILTER("Source Code", '<>%1', 'BANKPYMTV');
                    DVLE.SETRANGE("Vendor Ledger Entry No.", VLE."Entry No.");
                    DVLE.SETRANGE("Entry Type", DVLE."Entry Type"::Application);
                    DVLE.SETRANGE(DVLE.Unapplied, FALSE);
                    DVLE.SETFILTER("Document Type", '%1|%2', DVLE."Document Type"::"Credit Memo", DVLE."Document Type"::" ");
                    IF DVLE.FINDFIRST THEN BEGIN
                        REPEAT
                            AdjustmentAmount2 += DVLE."Amount (LCY)";
                        UNTIL DVLE.NEXT = 0;
                    END;
                UNTIL VLE.NEXT = 0;
            END;
        END;
        EXIT(AdjustmentAmount2);
    end;


    procedure GetPaidAdjustedAmt2(CostCentre: Code[50]; OrderNo: Code[50]): Decimal
    var
        VLE: Record "Vendor Ledger Entry";
        DVLE: Record "Detailed Vendor Ledg. Entry";
        AdjustmentAmount1: Decimal;
    begin
        VLE.RESET;
        VLE.SETRANGE("Document Type", VLE."Document Type"::Invoice);
        VLE.SETRANGE("Global Dimension 1 Code", CostCentre);
        VLE.SETRANGE("Order No.", OrderNo);
        IF VLE.FINDFIRST THEN BEGIN
            AdjustmentAmount1 := 0;
            REPEAT
                DVLE.RESET;
                DVLE.SETCURRENTKEY("Vendor Ledger Entry No.");
                DVLE.SETFILTER("Source Code", '<>%1', 'BANKPYMTV');
                DVLE.SETRANGE("Vendor Ledger Entry No.", VLE."Entry No.");
                DVLE.SETRANGE("Entry Type", DVLE."Entry Type"::Application);
                IF DVLE.FINDFIRST THEN BEGIN
                    REPEAT
                        AdjustmentAmount1 += DVLE."Amount (LCY)";
                    UNTIL DVLE.NEXT = 0;
                END;
            UNTIL VLE.NEXT = 0;
        END;
        EXIT(AdjustmentAmount1);
    end;


    procedure GetReceiptNo(OrderNo: Code[40]; OrderLineNo: Integer): Code[50]
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine.SETRANGE("Order No.", OrderNo);
        PurchRcptLine.SETRANGE("Order Line No.", OrderLineNo);
        IF PurchRcptLine.FINDFIRST THEN BEGIN
            EXIT(GetInvoiceNo(PurchRcptLine."Document No.", PurchRcptLine."Line No."))
        END;
    end;


    procedure GetInvoiceNo(ReceiptDocNo: Code[40]; ReceiptLineNo: Integer): Code[50]
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        PurchInvLine.SETRANGE("Receipt No.", ReceiptDocNo);
        PurchInvLine.SETRANGE("Receipt Line No.", ReceiptLineNo);
        IF PurchInvLine.FINDFIRST THEN
            EXIT(PurchInvLine."Document No.");
    end;


    procedure GetVendLedEntryNo(DocumentNo: Code[50]): Integer
    var
        VLE: Record "Vendor Ledger Entry";
    begin
        VLE.SETCURRENTKEY("Document No.");
        VLE.SETRANGE("Document No.", DocumentNo);
        IF VLE.FINDFIRST THEN
            EXIT(VLE."Entry No.");
    end;


    procedure GetAdvancePaymentCon1(OrderNo: Code[50]): Decimal
    var
        RecVLE: Record "Vendor Ledger Entry";
        DVLE: Record "Detailed Vendor Ledg. Entry";
        AdvanceAgPO: Decimal;
    begin

        IF GetInvDocNo(GetReptDocNo(OrderNo)) <> '' THEN BEGIN
            RecVLE.SETRANGE("Document Type", RecVLE."Document Type"::Payment);
            RecVLE.SETFILTER("Document No.", GetInvDocNo(GetReptDocNo(OrderNo)));
            RecVLE.SETFILTER("Remaining Amount", '<>%1', 0);
            RecVLE.SETRANGE(Open, TRUE);
            IF RecVLE.FINDFIRST THEN BEGIN
                REPEAT
                    RecVLE.CALCFIELDS("Remaining Amt. (LCY)");
                    AdvanceAgPO += RecVLE."Remaining Amt. (LCY)";
                UNTIL RecVLE.NEXT = 0;
            END;
        END;
        EXIT(AdvanceAgPO);
    end;


    procedure GetSalesInvoiceAmount(InvoiceDocNo: Code[50]; OrderNo: Code[50]): Decimal
    var
        VendorLedEntry: Record "Vendor Ledger Entry";
        InvoiceAmount: Decimal;
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine.RESET;
        PurchRcptLine.SETRANGE("Order No.", OrderNo);
        IF PurchRcptLine.FINDFIRST THEN BEGIN
            REPEAT
                VendorLedEntry.SETRANGE("Document Type", VendorLedEntry."Document Type"::Invoice);
                VendorLedEntry.SETRANGE("Document No.", GetInvoiceDocNo(PurchRcptLine."Document No."));
                IF VendorLedEntry.FINDFIRST THEN BEGIN
                    REPEAT
                        VendorLedEntry.CALCFIELDS("Amount (LCY)");
                        InvoiceAmount += ABS(VendorLedEntry."Amount (LCY)");
                    UNTIL VendorLedEntry.NEXT = 0;
                END;
            UNTIL PurchRcptLine.NEXT = 0;
        END;
        //EXIT(InvoiceAmount);
    end;


    procedure GetCreditMemoDocAmount(OrderNo: Code[50]; OrderLineNo: Integer): Code[50]
    var
        PurchCrMemoHr: Record "Purch. Cr. Memo Hdr.";
        AppliedDocNo: Code[50];
    begin
        PurchCrMemoHr.SETRANGE("Applies-to Doc. Type", PurchCrMemoHr."Applies-to Doc. Type"::Invoice);
        PurchCrMemoHr.SETRANGE("Applies-to Doc. No.", GetReceiptNo(OrderNo, OrderLineNo));
        IF PurchCrMemoHr.FINDFIRST THEN BEGIN
            AppliedDocNo := PurchCrMemoHr."No.";
        END;
        EXIT(AppliedDocNo);
    end;


    procedure VendorLedCreditMemoAmt(OrderNo: Code[40]; OrderLineNo: Integer) CreditAmount: Decimal
    var
        VendorLedEntry: Record "Vendor Ledger Entry";
        DetailedVendLedEntry: Record "Detailed Vendor Ledg. Entry";
    begin
        VendorLedEntry.SETRANGE("Document Type", VendorLedEntry."Document Type"::"Credit Memo");
        VendorLedEntry.SETRANGE("Document No.", GetCreditMemoDocAmount(OrderNo, OrderLineNo));
        IF VendorLedEntry.FINDFIRST THEN BEGIN
            REPEAT
                CreditAmount := 0;
                DetailedVendLedEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedEntry."Entry No.");
                DetailedVendLedEntry.SETRANGE("Entry Type", DetailedVendLedEntry."Entry Type"::Application);
                DetailedVendLedEntry.SETRANGE("Document Type", DetailedVendLedEntry."Document Type"::"Credit Memo");
                IF DetailedVendLedEntry.FINDFIRST THEN BEGIN
                    REPEAT
                        CreditAmount += DetailedVendLedEntry."Amount (LCY)";
                    UNTIL DetailedVendLedEntry.NEXT = 0;
                END;
            UNTIL VendorLedEntry.NEXT = 0;
        END;
        EXIT(CreditAmount);
    end;


    procedure GetReceiptDocNo(OrderNo: Code[40]): Code[50]
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine.SETRANGE("Order No.", OrderNo);
        IF PurchRcptLine.FINDFIRST THEN BEGIN
            EXIT(GetInvoiceDocNo(PurchRcptLine."Document No."))
        END;
    end;


    procedure GetInvoiceDocNo(ReceiptDocNo: Code[40]): Code[50]
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        PurchInvLine.SETRANGE("Receipt No.", ReceiptDocNo);
        IF PurchInvLine.FINDFIRST THEN
            EXIT(PurchInvLine."Document No.");
    end;


    procedure GetReptDocNo(OrderNo: Code[20]) ReceiptNo: Text
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        IF OrderNo <> '' THEN BEGIN
            PurchRcptHeader.SETRANGE("Order No.", OrderNo);
            IF PurchRcptHeader.FINDFIRST THEN
                REPEAT
                    IF ReceiptNo <> '' THEN
                        ReceiptNo += '|' + PurchRcptHeader."No."
                    ELSE
                        ReceiptNo := PurchRcptHeader."No.";
                UNTIL PurchRcptHeader.NEXT = 0;
        END;
        EXIT(ReceiptNo);
    end;


    procedure GetInvDocNo(RecieptNo: Text) InvoiceNo: Text
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        IF RecieptNo <> '' THEN BEGIN
            PurchInvLine.SETFILTER("Receipt No.", RecieptNo);
            IF PurchInvLine.FINDFIRST THEN
                REPEAT
                    IF InvoiceNo <> '' THEN BEGIN
                        IF STRPOS(InvoiceNo, PurchInvLine."Document No.") = 0 THEN
                            InvoiceNo += '|' + PurchInvLine."Document No."
                    END ELSE
                        InvoiceNo := PurchInvLine."Document No.";
                UNTIL PurchInvLine.NEXT = 0;
        END;
        EXIT(InvoiceNo);
    end;


    procedure GetInvAmt(RecieptNo: Text) InvoiceAmt: Decimal
    var
        PurchInvLine: Record "Purch. Inv. Line";
        RecTaxTransaction: Record "Tax Transaction Value";
        GSTAmount: Decimal;
    begin
        IF RecieptNo <> '' THEN BEGIN
            PurchInvLine.SETFILTER("Receipt No.", RecieptNo);
            IF PurchInvLine.FINDFIRST THEN
                REPEAT
                    InvoiceAmt += PurchInvLine.Amount + GetGSTAmount(PurchInvLine."Document No.", PurchInvLine."Line No.");
                UNTIL PurchInvLine.NEXT = 0;

        end;
    end;

    procedure GetGSTAmount(DocNo: Code[20]; DocLineNo: Integer): Decimal
    var
        DTLGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTAmount: Decimal;
    begin
        DTLGSTLedgerEntry.Reset();
        DTLGSTLedgerEntry.SetRange("Document No.", DocNo);
        DTLGSTLedgerEntry.SetRange("Document Line No.", DocLineNo);
        if DTLGSTLedgerEntry.FindFirst() then
            repeat
                GSTAmount += DTLGSTLedgerEntry."GST Amount";
            Until DTLGSTLedgerEntry.Next() = 0;
        exit(GSTAmount);
    end;


    procedure GetAdvanceAgstDirectPO(OrderNo: Code[50]): Decimal
    var
        RecVLE: Record "Vendor Ledger Entry";
        DVLE: Record "Detailed Vendor Ledg. Entry";
        AdvanceAgPO: Decimal;
    begin
        VendorLedEntry2.RESET;
        VendorLedEntry2.SETRANGE(VendorLedEntry2."Order No.", OrderNo);
        IF VendorLedEntry2.FINDFIRST THEN BEGIN
            REPEAT
                // RecVLE.SETRANGE("Document Type",RecVLE."Document Type"::Payment);
                RecVLE.SETFILTER("Document No.", VendorLedEntry2."Document No.");
                RecVLE.SETFILTER("Remaining Amount", '<>%1', 0);
                RecVLE.SETRANGE(Open, TRUE);
                IF RecVLE.FINDFIRST THEN BEGIN
                    REPEAT
                        RecVLE.CALCFIELDS("Remaining Amt. (LCY)");
                        AdvanceAgPO += RecVLE."Remaining Amt. (LCY)";
                    UNTIL RecVLE.NEXT = 0;
                END;
            UNTIL VendorLedEntry2.NEXT = 0;
        END;
        EXIT(AdvanceAgPO);
    end;
}

