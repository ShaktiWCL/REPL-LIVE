codeunit 50006 REPLSubscribers
{
    EventSubscriberInstance = StaticAutomatic;
    //Table 36 Sales Header
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInitInsert', '', true, true)]
    procedure OnBeforeInitInsert(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
        LocCode: code[20];
        GetLocation1: Record Location;
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            //"Responsibility Center" := UserSetup."Responsibility Center";
            IF ResponsibilityCenter.GET(UserSetup."Responsibility Center") THEN BEGIN
                //"Shortcut Dimension 2 Code" := ResponsibilityCenter."Global Dimension 2 Code";
                //"Location Code" := ResponsibilityCenter."Location Code";
                LocCode := ResponsibilityCenter."Location Code";
            END;
        END;
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN BEGIN
            IF SalesHeader."No." = '' THEN BEGIN
                IF LocCode <> '' THEN BEGIN
                    GetLocation1.GET(LocCode);
                    SalesHeader."No." := NoSeriesMgt.GetNextNo(GetLocation1."Location Sales Invoice No.", WORKDATE, TRUE);
                    SalesHeader."Posting No." := SalesHeader."No.";
                END;
            END;
        END ELSE
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN BEGIN
                IF SalesHeader."No." = '' THEN BEGIN
                    IF LocCode <> '' THEN BEGIN
                        GetLocation1.GET(LocCode);
                        SalesHeader."No." := NoSeriesMgt.GetNextNo(GetLocation1."Sales Debit Nos", WORKDATE, TRUE);

                    END;
                END;
            END;

        SalesHeader."Creator ID" := USERID;
        if LocCode <> '' then
            IsHandled := true;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', true, true)]
    procedure OnAfterInitRecord(var SalesHeader: Record "Sales Header")
    var
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            SalesHeader."Responsibility Center" := UserSetup."Responsibility Center";
            IF ResponsibilityCenter.GET(UserSetup."Responsibility Center") THEN BEGIN
                SalesHeader."Shortcut Dimension 2 Code" := ResponsibilityCenter."Global Dimension 2 Code";
                SalesHeader."Location Code" := ResponsibilityCenter."Location Code";
                //SalesHeader."Posting No." := SalesHeader."No.";
            END;
        END;

        SalesHeader."Creator ID" := USERID;
    end;
    //Table 37 Sales Line
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeTestJobPlanningLine', '', true, true)]
    procedure OnBeforeTestJobPlanningLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; CallingFieldNo: Integer)
    begin
        IsHandled := true;
    end;
    //Table 38 Purchase Header
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeOnInsert', '', true, true)]
    procedure OnBeforeOnInsertPurch(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order THEN BEGIN
            UserSetup.GET(USERID);
            IF NOT UserSetup."Create PO" THEN
                ERROR('You do not have premission to create Purchase order. Contact your system administrator');
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeInitInsert', '', true, true)]
    procedure OnBeforeInitInsertPurch(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
        LocCode: code[20];
        GetLocation1: Record Location;
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            //"Responsibility Center" := UserSetup."Responsibility Center";
            IF ResponsibilityCenter.GET(UserSetup."Responsibility Center") THEN BEGIN
                //"Shortcut Dimension 2 Code" := ResponsibilityCenter."Global Dimension 2 Code";
                //"Location Code" := ResponsibilityCenter."Location Code";
                LocCode := ResponsibilityCenter."Location Code";
            END;
        END;
        IF PurchaseHeader."No." = '' THEN BEGIN
            IF LocCode <> '' THEN BEGIN
                GetLocation1.GET(LocCode);
                PurchaseHeader."No." := NoSeriesMgt.GetNextNo(GetLocation1."Location Purchase Invoice No.", WORKDATE, TRUE);
                IsHandled := true;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitRecord', '', true, true)]
    procedure OnAfterInitRecordPurch(var PurchHeader: Record "Purchase Header")
    var
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            PurchHeader."Responsibility Center" := UserSetup."Responsibility Center";
            IF ResponsibilityCenter.GET(UserSetup."Responsibility Center") THEN BEGIN
                PurchHeader."Shortcut Dimension 2 Code" := ResponsibilityCenter."Global Dimension 2 Code";
                PurchHeader."Location Code" := ResponsibilityCenter."Location Code";
            END;
        END;

        PurchHeader."Creator ID" := USERID;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterValidatePayToVendor', '', true, true)]
    procedure OnValidateBuyFromVendorNoOnAfterValidatePayToVendor(var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader.Validate("Shortcut Dimension 1 Code", '');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont', '', true, true)]
    procedure OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var SkipBuyFromContact: Boolean)
    var
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            PurchaseHeader."Responsibility Center" := UserSetup."Responsibility Center";
            IF ResponsibilityCenter.GET(UserSetup."Responsibility Center") THEN BEGIN
                PurchaseHeader.Validate("Shortcut Dimension 2 Code", ResponsibilityCenter."Global Dimension 2 Code");
                //PurchHeader."Location Code" := ResponsibilityCenter."Location Code";
            END;
        END;
    end;
    //Table 167 Project
    [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterOnInsert', '', true, true)]
    procedure OnAfterOnInsert(var Job: Record Job; var xJob: Record Job)
    var
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        IF UserSetup.GET(USERID) THEN
            JOb."Responsibility Center" := UserSetup."Responsibility Center";
        IF ResponsibilityCenter.GET(UserSetup."Responsibility Center") THEN
            Job."Global Dimension 2 Code" := ResponsibilityCenter."Global Dimension 2 Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnBeforeCheckRemoveFromMyJobsFromModify', '', true, true)]
    procedure OnBeforeCheckRemoveFromMyJobsFromModify(var Job: Record Job; var xJob: Record Job; var IsHandled: Boolean)
    var
        Employee: Record Employee;
    begin
        IF Employee.GET(Job."Project Manager") THEN
            IF Employee.Status <> Employee.Status::Active THEN
                ERROR('Project Manager is %1.', Employee.Status);

    end;

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterBillToCustomerNoUpdated', '', true, true)]
    procedure OnAfterBillToCustomerNoUpdated(var Job: Record Job; xJob: Record Job; BillToCustomer: Record Customer; CallingFieldNo: Integer)
    var
        ProjectTask: Record "Job Task";
        ProjectPlanningLine: Record "Job Planning Line";
    begin
        ProjectTask.RESET;
        ProjectTask.SETRANGE("Job No.", Job."No.");
        ProjectTask.SETFILTER("Balance Amount", '<>%1', 0);
        IF ProjectTask.FINDFIRST THEN
            REPEAT
                ProjectTask."Customer No." := Job."Bill-to Customer No.";
                ProjectTask."Customer Name" := Job."Bill-to Name";
                ProjectTask.MODIFY;
            UNTIL ProjectTask.NEXT = 0;

        ProjectPlanningLine.RESET;
        ProjectPlanningLine.SETRANGE("Job No.", Job."No.");
        ProjectPlanningLine.SETFILTER("Balance Amount", '<>%1', 0);
        IF ProjectPlanningLine.FINDFIRST THEN
            REPEAT
                ProjectPlanningLine."Customer No." := Job."Bill-to Customer No.";
                ProjectPlanningLine."Customer Name" := JOb."Bill-to Name";
                ProjectPlanningLine.MODIFY;
            UNTIL ProjectPlanningLine.NEXT = 0;
    end;
    //Codeunit 80 Sales-Post
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
    begin
        SalesHeader."Posting No." := SalesHeader."No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', true, true)]
    procedure OnAfterSalesInvHeaderInsert(VAR SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header");
    var
    begin
        UpdateMilestone(SalesHeader);
        //S.01
        IF TDSExist(SalesInvHeader."Sell-to Customer No.") THEN
            CreateTDSJV(SalesInvHeader);
        //S.01
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoHeaderInsert', '', true, true)]
    procedure OnAfterSalesCrMemoHeaderInsert(VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header");
    var
    begin
        UpdateMilestoneCredit(SalesHeader);
    end;


    procedure UpdateMilestone(VAR SaleHeader2: Record "Sales Header");
    var
        SaleLine: Record "Sales Line";
        ProjectTask: Record "Job Task";
        ProjectPlanningLine: Record "Job Planning Line";
    Begin
        SaleLine.SETRANGE("Document Type", SaleLine."Document Type"::Invoice);
        SaleLine.SETRANGE("Document No.", SaleHeader2."No.");
        IF SaleLine.FINDSET THEN
            REPEAT
                ProjectTask.RESET;
                ProjectTask.SETRANGE("Job No.", SaleLine."Job No.");
                ProjectTask.SETRANGE("Job Task No.", SaleLine."Job Task No.");
                //ProjectTask.SETRANGE(Milestone, SaleLine.Milestone);
                IF ProjectTask.FINDFIRST THEN BEGIN
                    SaleHeader2.CALCFIELDS(Amount);
                    ProjectTask."Actual Latest Bill Date" := SaleHeader2."Posting Date";
                    ProjectTask."Balance Amount(Credit)" += SaleLine.Amount;
                    ProjectTask.MODIFY;
                END;
                ProjectPlanningLine.RESET;
                ProjectPlanningLine.SETRANGE("Job No.", SaleLine."Job No.");
                ProjectPlanningLine.SETRANGE("Job Task No.", SaleLine."Job Task No.");
                //ProjectPlanningLine.SETRANGE(MileStone, SaleLine.Milestone);
                IF ProjectPlanningLine.FINDFIRST THEN BEGIN
                    SaleHeader2.CALCFIELDS(Amount);
                    ProjectPlanningLine."Balance Amount(Credit)" += SaleLine.Amount;
                    ProjectPlanningLine.MODIFY;
                END;
            UNTIL SaleLine.NEXT = 0;
    End;

    procedure CreateTDSJV(SalesInvHeader: Record "Sales Invoice Header");
    var
        GLSetup: Record "General Ledger Setup";
        GenJournalLine: Record "Gen. Journal Line";
        Cust: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
    Begin
        GLSetup.GET;

        GenJournalLine.INIT;
        GenJournalLine.VALIDATE("Journal Template Name", GLSetup."TDS Recv Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", GLSetup."TDS Recv Batch Name");
        GenJournalLine."Line No." := GetJVLastNo();
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine.VALIDATE("Account No.", GLSetup.JVAccountNo);
        GenJournalLine."Posting Date" := WORKDATE;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::" ";
        GenJournalLine."Document No." := NoSeriesMgt.GetNextNo(GLSetup."JV Posting Nos", WORKDATE, TRUE);
        IF Cust.GET(SalesInvHeader."Sell-to Customer No.") THEN BEGIN
            GenJournalLine.VALIDATE(Amount, (GetDocAmount(SalesInvHeader."No.") * (Cust."TDS %") / 100));
        END;
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::Customer;
        GenJournalLine.VALIDATE("Bal. Account No.", SalesInvHeader."Sell-to Customer No.");
        GenJournalLine."External Document No." := SalesInvHeader."No.";
        GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::Invoice;
        GenJournalLine."Applies-to Doc. No." := SalesInvHeader."No.";
        GenJournalLine."Source Code" := 'JOURNALV';
        GenJournalLine."TDS Receivable Atuo Entry" := TRUE;
        IF GenJournalLine.INSERT(TRUE) THEN BEGIN
            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", SalesInvHeader."Shortcut Dimension 1 Code");
            GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", SalesInvHeader."Shortcut Dimension 2 Code");
            GenJournalLine.MODIFY;
        END;
        //SLEEP(1000);
        //GenJnlPost.RUN(GenJournalLine);
    end;

    procedure GetJVLastNo() DocLineNo: Integer
    var

        GenLedSetup: Record "General Ledger Setup";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenLedSetup.GET;
        GenJournalLine.SETRANGE("Journal Template Name", GenLedSetup."TDS Recv Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", GenLedSetup."TDS Recv Batch Name");
        IF GenJournalLine.FINDLAST THEN
            DocLineNo := GenJournalLine."Line No." + 10000
        ELSE
            DocLineNo := 10000;
        EXIT(DocLineNo);
    end;


    procedure GetDocAmount(DocNo: Code[50]) BasicAmount: Decimal
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    Begin
        SalesInvoiceLine.SETRANGE("Document No.", DocNo);
        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
            REPEAT
                BasicAmount += SalesInvoiceLine."Line Amount";
            UNTIL SalesInvoiceLine.NEXT = 0;
        END;
        EXIT(BasicAmount);
    End;


    procedure TDSExist(CustNo: Code[50]): Boolean
    var
        Cust: Record Customer;
    begin
        IF Cust.GET(CustNo) THEN BEGIN
            IF Cust."TDS %" <> 0 THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END;
        EXIT(FALSE);
    end;


    procedure UpdateMilestoneCredit(VAR SaleHeader2: Record "Sales Header")
    var
        SaleLine: Record "Sales Line";
        ProjectTask: Record "Job Task";
        ProjectPlanningLine: Record "Job Planning Line";
    begin
        SaleLine.SETRANGE("Document Type", SaleLine."Document Type"::"Credit Memo");
        SaleLine.SETRANGE("Document No.", SaleHeader2."No.");
        IF SaleLine.FINDSET THEN
            REPEAT
                ProjectTask.RESET;
                ProjectTask.SETRANGE("Job No.", SaleLine."Job No.");
                ProjectTask.SETRANGE(Milestone, SaleLine."Job Task No.");
                //ProjectTask.SETRANGE(Milestone, SaleLine.Milestone);
                IF ProjectTask.FINDFIRST THEN BEGIN
                    SaleHeader2.CALCFIELDS(Amount);
                    ProjectTask."Balance Amount" := ProjectTask."Balance Amount" + SaleLine.Amount;
                    ProjectTask.MODIFY;
                END;
                ProjectPlanningLine.RESET;
                ProjectPlanningLine.SETRANGE("Job No.", SaleLine."Job No.");
                ProjectPlanningLine.SETRANGE(Milestone, SaleLine."Job Task No.");
                //ProjectPlanningLine.SETRANGE(MileStone, SaleLine.Milestone);
                IF ProjectPlanningLine.FINDFIRST THEN BEGIN
                    SaleHeader2.CALCFIELDS(Amount);
                    ProjectPlanningLine."Balance Amount" := ProjectPlanningLine."Balance Amount" + SaleLine.Amount;
                    ProjectPlanningLine.MODIFY;
                END;
            UNTIL SaleLine.NEXT = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeInsertICGenJnlLine', '', true, true)]
    procedure OnBeforeInsertICGenJnlLine(VAR ICGenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line");
    var
    begin
        ICGenJournalLine."Creator Id" := SalesHeader."Creator ID";
    end;
    //CodeUnit 81 Sales-Post (Yes/No)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', true, true)]
    procedure OnBeforeConfirmSalesPost(VAR SalesHeader: Record "Sales Header"; VAR HideDialog: Boolean);
    var
    begin
        SalesHeader.TESTFIELD("Location Code");
        CheckFinBookAndLocation(SalesHeader);
    end;

    procedure CheckFinBookAndLocation(SalesHeader: Record "Sales Header")
    var
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GeneralLedgerSetup.GET;
        IF GeneralLedgerSetup."Activate OU Filter" THEN BEGIN
            UserSetup.GET(USERID);
            ResponsibilityCenter.GET(UserSetup."Responsibility Center");
            IF (ResponsibilityCenter."Global Dimension 2 Code" <> SalesHeader."Shortcut Dimension 2 Code") OR (ResponsibilityCenter."Location Code" <>
                SalesHeader."Location Code") THEN
                ERROR('Document cannot be authorised because you are login from %1', UserSetup."Responsibility Center");
        END;
    end;
    //Table 1003
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnBeforeValidateModification', '', true, true)]
    procedure OnBeforeValidateModification(var JobPlanningLine: Record "Job Planning Line"; var IsHandled: Boolean; xJobPlanningLine: Record "Job Planning Line"; FieldNo: Integer)
    var
    begin
        IsHandled := true;
    end;
    //CodeUnit 82 Sales-Post + Print
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeConfirmPost', '', true, true)]
    procedure OnBeforeConfirmPost(VAR SalesHeader: Record "Sales Header"; VAR HideDialog: Boolean);
    var
    begin
        SalesHeader.TestField("Location Code");
        CheckFinBookAndLocation(SalesHeader);
    end;
    //CodeUnit 90 Purch.-Post
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvHeaderInsert', '', true, true)]
    procedure OnBeforePurchInvHeaderInsert(VAR PurchInvHeader: Record "Purch. Inv. Header"; VAR PurchHeader: Record "Purchase Header");
    var
    begin
        PurchInvHeader."Order No." := PurchHeader."Order No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnInsertICGenJnlLineOnBeforeICGenJnlLineInsert', '', true, true)]
    procedure OnInsertICGenJnlLineOnBeforeICGenJnlLineInsert(var TempICGenJournalLine: Record "Gen. Journal Line"; PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; CommitIsSuppressed: Boolean);
    var
    begin
        TempICGenJournalLine."Order No." := PurchaseHeader."Order No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', true, true)]
    procedure OnBeforePurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean);
    var
    begin
        if PurchaseHeader."Order No." <> '' then
            PurchRcptHeader."Order No." := PurchaseHeader."Order No.";
    end;
    //CodeUnit 91 Purch.-Post (Yes/No)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', true, true)]
    procedure OnBeforeConfirmPostPur(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer);
    var
        PurchaseLine: Record "Purchase Line";
        SalvageValue: Decimal;
    begin
        PurchaseHeader.TESTFIELD(Authorised);
        PurchaseHeader.TESTFIELD("Location Code");
        CheckFinBookAndLocation(PurchaseHeader);

        SalvageValue := 0;
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::"Fixed Asset");
        IF PurchaseLine.FINDSET THEN BEGIN
            REPEAT
                SalvageValue += -(PurchaseLine."Salvage Value");
            UNTIL PurchaseLine.NEXT = 0;
            IF NOT CONFIRM('Salvage Value %1, Do you want to proceed the invoice', FALSE, SalvageValue) THEN
                EXIT;
        END;
    end;

    procedure CheckFinBookAndLocation(PurchHeader: Record "Purchase Header")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        GeneralLedgerSetup.GET;
        IF GeneralLedgerSetup."Activate OU Filter" THEN BEGIN
            UserSetup.GET(USERID);
            ResponsibilityCenter.GET(UserSetup."Responsibility Center");
            IF (ResponsibilityCenter."Global Dimension 2 Code" <> PurchHeader."Shortcut Dimension 2 Code") OR (ResponsibilityCenter."Location Code" <>
                PurchHeader."Location Code") THEN
                ERROR('Document cannot be authorised because you are login from %1', UserSetup."Responsibility Center");
        END;
    end;
    //CodeUnit 92 Purch.-Post + Print
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforeConfirmPost', '', true, true)]
    procedure OnBeforeConfirmPostPurPrint(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer);
    var
    begin
        CheckFinBookAndLocation(PurchaseHeader);
    end;
    //CodeUnit 12 Gen. Jnl.-Post Line
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCode', '', true, true)]
    procedure OnBeforeCode(VAR GenJnlLine: Record "Gen. Journal Line"; CheckLine: Boolean);
    var
    begin
        CheckFinBookAndLocation(GenJnlLine);
    end;

    local procedure CheckFinBookAndLocation(VAR GenJournalLine: Record "Gen. Journal Line")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        GeneralLedgerSetup.GET;
        IF (GenJournalLine."Location Code" <> '') AND (GenJournalLine."Shortcut Dimension 2 Code" <> '') THEN BEGIN
            IF GeneralLedgerSetup."Activate OU Filter" THEN BEGIN
                UserSetup.GET(USERID);
                ResponsibilityCenter.GET(UserSetup."Responsibility Center");
                IF (ResponsibilityCenter."Global Dimension 2 Code" <> GenJournalLine."Shortcut Dimension 2 Code") OR (ResponsibilityCenter."Location Code" <>
                    GenJournalLine."Location Code") THEN
                    ERROR('Document cannot be authorised because you are login from %1', UserSetup."Responsibility Center");
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntryBuffer', '', true, true)]
    procedure OnBeforeInsertGLEntryBuffer(VAR TempGLEntryBuf: Record "G/L Entry"; VAR GenJournalLine: Record "Gen. Journal Line");
    var
    begin
        //TempGLEntryBuf."Location Code" := GenJournalLine."Location Code";
        TempGLEntryBuf."Creator Id" := GenJournalLine."Creator Id";
        TempGLEntryBuf."Approver Id" := GenJournalLine."Approver Id";
        TempGLEntryBuf."Employee Code" := GenJournalLine."Emp.Code";
        TempGLEntryBuf."Tender No." := GenJournalLine."Tender No.";
        TempGLEntryBuf."Pre Document No." := GenJournalLine."Pre Document No.";
    end;

    //CodeUnit 225 Gen. Jnl.-Apply
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnApplyVendorLedgerEntryOnBeforeModify', '', true, true)]
    procedure OnApplyVendorLedgerEntryOnBeforeModify(var GenJournalLine: Record "Gen. Journal Line"; VendorLedgerEntry: Record "Vendor Ledger Entry"; VendorLedgerEntryLocal: Record "Vendor Ledger Entry");
    var
    begin
        GenJournalLine."Order No." := VendorLedgerEntryLocal."Order No.";
    end;
    //CodeUnit 396 NoSeriesManagement
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"NoSeriesManagement", 'OnSelectSeriesOnBeforePageRunModal', '', true, true)]
    procedure OnSelectSeriesOnBeforePageRunModal(DefaultNoSeriesCode: Code[20]; var NoSeries: Record "No. Series")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        IF NOT IsNotRequired THEN BEGIN
            GeneralLedgerSetup.GET;
            IF GeneralLedgerSetup."Activate OU Filter" THEN BEGIN
                UserSetup.GET(USERID);
                ResponsibilityCenter.GET(UserSetup."Responsibility Center");
                IF NOT CONFIRM('No. seies will create from Location Code %1', FALSE, ResponsibilityCenter."Location Code") THEN
                    EXIT;
            END;
        END;
    end;

    procedure ExcludeNoSeriesFilterFunctionality(SetIsNotRequired: Boolean)
    begin
        IsNotRequired := SetIsNotRequired;
    end;

    //CodeUnit 950 Time Sheet Management
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Time Sheet Management", 'OnBeforeFillJobPlanningBuffer', '', true, true)]
    procedure OnBeforeFillJobPlanningBuffer(var JobPlanningLine: Record "Job Planning Line"; var JobPlanningLineBuffer: Record "Job Planning Line"; TimeSheetHeader: Record "Time Sheet Header"; var IsHandled: Boolean)
    var
        SkipLine: Boolean;
    begin
        //JobPlanningLine.SetRange(Type, JobPlanningLine.Type::Resource);
        JobPlanningLine.SetRange("Project Manager", TimeSheetHeader."Resource No.");
        JobPlanningLine.SetRange("Planning Date", TimeSheetHeader."Starting Date", TimeSheetHeader."Ending Date");
        if JobPlanningLine.FindSet() then
            repeat
                SkipLine := TimesheetLineWithJobPlanningLineExists(TimeSheetHeader, JobPlanningLine);
                if not SkipLine then
                    SkipLine := JobPlanningLineIsNotValidForTimesheetLine(JobPlanningLine);
                if not SkipLine then begin
                    JobPlanningLineBuffer.SetRange("Job No.", JobPlanningLine."Job No.");
                    JobPlanningLineBuffer.SetRange("Job Task No.", JobPlanningLine."Job Task No.");
                    if JobPlanningLineBuffer.IsEmpty() then begin
                        JobPlanningLineBuffer."Job No." := JobPlanningLine."Job No.";
                        JobPlanningLineBuffer."Job Task No." := JobPlanningLine."Job Task No.";
                        JobPlanningLineBuffer.Insert();
                    end;
                end;
            until JobPlanningLine.Next() = 0;
        JobPlanningLineBuffer.Reset();
        IsHandled := true;
    end;

    local procedure TimesheetLineWithJobPlanningLineExists(TimeSheetHeader: Record "Time Sheet Header"; JobPlanningLine: Record "Job Planning Line"): Boolean
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        TimeSheetLine.SetRange("Time Sheet No.", TimeSheetHeader."No.");
        TimeSheetLine.SetRange(Type, TimeSheetLine.Type::Job);
        TimeSheetLine.SetRange("Job No.", JobPlanningLine."Job No.");
        // TimeSheetLine.SetRange("Job Task No.", JobPlanningLine."Job Task No.");
        exit(not TimeSheetLine.IsEmpty());
    end;

    local procedure JobPlanningLineIsNotValidForTimesheetLine(JobPlanningLine: Record "Job Planning Line"): Boolean
    var
        Job: Record Job;
    begin
        if JobPlanningLine."Job No." = '' then
            exit(true);

        if not Job.Get(JobPlanningLine."Job No.") then
            exit(true);

        if (Job.Blocked = Job.Blocked::All) or (Job.Status = Job.Status::Completed) then
            exit(true);

        exit(false);
    end;
    //CodeUnit 1001 Job Post-Line
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", 'OnPostInvoiceContractLineOnBeforeCheckBillToCustomer', '', true, true)]
    procedure OnPostInvoiceContractLineOnBeforeCheckBillToCustomer(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var JobPlanningLine: Record "Job Planning Line"; var IsHandled: Boolean)
    var
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", 'OnBeforeValidateRelationship', '', true, true)]
    procedure OnBeforeValidateRelationship(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var JobPlanningLine: Record "Job Planning Line"; var IsHandled: Boolean)
    var
    begin
        IsHandled := true;
    end;
    //CodeUnit 1002 Job Create-Invoice
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesInvoiceOnBeforeRunReport', '', true, true)]
    procedure OnCreateSalesInvoiceOnBeforeRunReport(var JobPlanningLine: Record "Job Planning Line"; var Done: Boolean; var NewInvoice: Boolean; var PostingDate: Date; var InvoiceNo: Code[20]; var IsHandled: Boolean; CrMemo: Boolean)
    var
        SalesHeader: Record "Sales Header";
        GetSalesInvoiceNo: Report "Job Transfer to Sales Invoice";
        GetSalesCrMemoNo: Report "Job Transfer to Credit Memo";
        DocumentDate: Date;
        Text004: Label 'You must specify Invoice No. or New Invoice.';
        Text005: Label 'You must specify Credit Memo No. or New Invoice.';
        Text007: Label 'You must specify %1.';
        JObCreateInvoice: Codeunit "Job Create-Invoice";
        UserSetup: Record "User Setup";
        Project: Record Job;
        JobPlanningLine2: Record "Job Planning Line";
    begin
        IsHandled := false;
        if not IsHandled then
            if not CrMemo then begin
                GetSalesInvoiceNo.SetCustomer(JobPlanningLine."Job No.");
                GetSalesInvoiceNo.RunModal();
                IsHandled := false;
                if not IsHandled then
                    GetSalesInvoiceNo.GetInvoiceNo(Done, NewInvoice, PostingDate, DocumentDate, InvoiceNo);
            end else begin
                GetSalesCrMemoNo.SetCustomer(JobPlanningLine."Job No.");
                GetSalesCrMemoNo.RunModal();
                IsHandled := false;
                if not IsHandled then
                    GetSalesCrMemoNo.GetCreditMemoNo(Done, NewInvoice, PostingDate, DocumentDate, InvoiceNo);
            end;

        if Done then begin
            if (PostingDate = 0D) and NewInvoice then
                Error(Text007, SalesHeader.FieldCaption("Posting Date"));
            if (InvoiceNo = '') and not NewInvoice then begin
                if CrMemo then
                    Error(Text005);
                Error(Text004);
            end;
            //JObCreateInvoice.CreateSalesInvoiceLines(
            //JobPlanningLine."Job No.", JobPlanningLine, InvoiceNo, NewInvoice, PostingDate, DocumentDate, CrMemo);
            //REPL-
            UserSetup.GET(USERID);
            IF NOT UserSetup.GetAdminUser THEN BEGIN
                IF Project.GET(JobPlanningLine."Job No.") THEN
                    IF PostingDate > (Project."Ending Date" + 30) THEN
                        ERROR('You cannot create invoice because invoice date is greater then project end date');
            END;

            /*
             SendMailforPartialInvoice(JobPlanningLine."Project No.");

             IF RecProject.GET(JobPlanningLine."Project No.")THEN BEGIN
                IF RecProject."Email Aleart(Despectro)" THEN
                   SendMailforBGInvoice(JobPlanningLine."Project No.");
             END;
             */
            IF NOT CrMemo THEN BEGIN
                JobPlanningLine2.SETRANGE("Job No.", JobPlanningLine."Job No.");
                //JobPlanningLine2.SETRANGE("Job Task No.", JobPlanningLine."Job Task No.");
                JobPlanningLine2.SETFILTER("Invoice (To Be Create) Amount", '<>%1', 0);
                IF JobPlanningLine2.FINDSET THEN
                    REPEAT
                        JObCreateInvoice.CreateSalesInvoiceLines(
                                   JobPlanningLine."Job No.", JobPlanningLine, InvoiceNo, NewInvoice, PostingDate, DocumentDate, CrMemo);
                    //JObCreateInvoice.CreateSalesInvoiceLines(
                    //JobPlanningLine."Job No.",JobPlanningLine,InvoiceNo,NewInvoice,PostingDate,CrMemo);
                    UNTIL JobPlanningLine2.NEXT = 0;
            END;
            IF CrMemo THEN BEGIN
                JobPlanningLine2.RESET;
                JobPlanningLine2.SETRANGE("Job No.", JobPlanningLine."Job No.");
                //JobPlanningLine2.SETRANGE("Job Task No.", JobPlanningLine."Job Task No.");
                JobPlanningLine2.SETFILTER("Credit (To Be Create) Amount", '<>%1', 0);
                IF JobPlanningLine2.FINDSET THEN
                    REPEAT
                        JObCreateInvoice.CreateSalesInvoiceLines(
                                   JobPlanningLine."Job No.", JobPlanningLine, InvoiceNo, NewInvoice, PostingDate, DocumentDate, CrMemo);
                    //JObCreateInvoice.CreateSalesInvoiceLines(
                    //JobPlanningLine."Job No.",JobPlanningLine,InvoiceNo,NewInvoice,PostingDate,CrMemo);
                    UNTIL JobPlanningLine2.NEXT = 0;
            END;
            IsHandled := true;
            Done := false;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesInvoiceLinesOnBeforeJobPlanningLineModify', '', true, true)]
    procedure OnCreateSalesInvoiceLinesOnBeforeJobPlanningLineModify(var JobPlanningLine: Record "Job Planning Line")
    var
        JobTask: Record "Job Task";
    begin

        JobTask.GET(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.");
        IF JobPlanningLine."Invoice (To Be Create) Amount" <> 0 THEN BEGIN
            JobPlanningLine."Balance Amount" := JobPlanningLine."Balance Amount" - JobPlanningLine."Invoice (To Be Create) Amount";
            JobPlanningLine.VALIDATE("Invoice (To Be Create) Amount", 0);
            JobTask."Balance Amount" := JobPlanningLine."Balance Amount"
        END ELSE BEGIN
            IF JobPlanningLine."Credit (To Be Create) Amount" <> 0 THEN BEGIN
                JobPlanningLine."Balance Amount(Credit)" := JobPlanningLine."Balance Amount(Credit)" - JobPlanningLine."Credit (To Be Create) Amount";
                JobPlanningLine.VALIDATE("Credit (To Be Create) Amount", 0);
                JobTask."Balance Amount(Credit)" := JobPlanningLine."Balance Amount(Credit)";
            END;
        END;
        //JobTask."Balance Amount" := JobTask."Balance Amount" - JobTask."Invoice Amount";//
        //JobTask."Invoice Amount" := 0;
        JobTask.MODIFY;
        //REPL+
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeInsertSalesHeader', '', true, true)]
    procedure OnBeforeInsertSalesHeader(var SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line")
    var
        GLSetUp: Record "General Ledger Setup";
        UserSetUp: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
        LocationCode: code[20];
    begin
        //AD_OU
        GLSetUp.GET;
        IF GLSetUp."Activate OU Filter" THEN BEGIN
            UserSetUp.GET(USERID);
            ResponsibilityCenter.GET(UserSetUp."Responsibility Center");
            //SalesHeader.SetValues(ResponsibilityCenter."Location Code");
            LocationCode := ResponsibilityCenter."Location Code";
        END;
        SalesHeader.VALIDATE("Location Code", LocationCode);
        SalesHeader.Validate("Shortcut Dimension 1 Code", Job."Global Dimension 1 Code");
        SalesHeader.Validate("Shortcut Dimension 2 Code", Job."Global Dimension 2 Code");
        //AD_OU
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnAfterUpdateSalesHeader', '', true, true)]
    procedure OnAfterUpdateSalesHeader(var SalesHeader: Record "Sales Header"; Job: Record Job)
    var
    begin
        SalesHeader.VALIDATE("Sell-to Customer No.", Job."Bill-to Customer No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeModifySalesHeader', '', true, true)]
    procedure OnBeforeModifySalesHeader(var SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line")
    var
    begin
        SalesHeader.VALIDATE(SalesHeader."Shortcut Dimension 1 Code", Job."Global Dimension 1 Code");
        SalesHeader.VALIDATE(SalesHeader."Shortcut Dimension 2 Code", Job."Global Dimension 2 Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeInsertSalesLine', '', true, true)]
    procedure OnBeforeInsertSalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line"; JobInvCurrency: Boolean)
    var
        GLSetUp: Record "General Ledger Setup";
        UserSetUp: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
        LocationCode: code[20];
    begin
        GLSetUp.GET;
        IF GLSetUp."Activate OU Filter" THEN BEGIN
            UserSetUp.GET(USERID);
            ResponsibilityCenter.GET(UserSetUp."Responsibility Center");
            LocationCode := ResponsibilityCenter."Location Code";
        END;

        SalesLine.Validate(Quantity, JobPlanningLine."Qty. to Transfer to Invoice");
        SalesLine.VALIDATE("Location Code", LocationCode);
        SalesLine.Milestone := JobPlanningLine.MileStone;
        SalesLine."Deleted Amount" := JobPlanningLine."Invoice (To Be Create) Amount";
    end;

    //Page 1007 Job Planning Lines
    [EventSubscriber(ObjectType::Page, Page::"Job Planning Lines", 'OnCreateSalesInvoiceOnBeforeAction', '', true, true)]
    procedure OnCreateSalesInvoiceOnBeforeAction(var JobPlanningLine: Record "Job Planning Line"; var IsHandled: Boolean);
    var
        GetProjectTask: Record "Job Task";
        GetProject: Record Job;
        ShiptoAddress: Record "Ship-to Address";
        GetCustomer: Record Customer;
        Project: Record Job;
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        ProjectPlanLine1: Record "Job Planning Line";
        Text1: Label 'Currently you are at %1 Project OU %2  , please changes OU\\ if you want to create invoice for that projects';
    begin
        UserSetup.Get(UserId);
        GetProjectTask.RESET;
        GetProjectTask.SETRANGE("Job No.", JobPlanningLine."Job No.");
        //GetProjectTask.SETRANGE(Milestone, MileStone);
        GetProjectTask.SETRANGE("Job Task No.", JobPlanningLine."Job Task No.");
        GetProjectTask.SETRANGE("Project Manager", JobPlanningLine."Project Manager");
        IF GetProjectTask.FINDFIRST THEN BEGIN
            IF GetProjectTask."Planned Bill Date" < TODAY THEN
                ERROR('Sales Invoice cannot be created after Planned Bill Date');
        END;


        GetProject.GET(JobPlanningLine."Job No.");
        IF GetProject."Temporary Status" <> GetProject."Temporary Status"::" " THEN
            ERROR('You cannot perform this activity because the Temporary Status of Project No. %1 is In-Active', GetProject."No.");


        ShiptoAddress.RESET;
        ShiptoAddress.SETRANGE("Customer No.", JobPlanningLine."Customer No.");
        ShiptoAddress.SETFILTER("GST Registration No.", '<>%1', '');
        IF NOT ShiptoAddress.FINDFIRST THEN BEGIN
            GetCustomer.GET(JobPlanningLine."Customer No.");
            IF GetCustomer."GST Customer Type" = GetCustomer."GST Customer Type"::" " THEN BEGIN
                IF GetCustomer."GST Registration No." = '' THEN
                    ERROR('GST No. must not be blank, Please specify GST No. in customer master/ Ship-to address');
            END;
        END;
        Project.GET(JobPlanningLine."Job No.");
        Project.TESTFIELD("Project Status", Project."Project Status"::Approved);
        IF NOT UserSetup.GetAdminUser THEN BEGIN
            UserSetup2.GET(USERID);
            IF Project."Responsibility Center" <> UserSetup2."Responsibility Center" THEN
                ERROR(Text1, UserSetup2."Responsibility Center", Project."Responsibility Center");

            // ProjectPlanLine.RESET;
            // ProjectPlanLine.SETRANGE("Project No.", "Project No.");
            // ProjectPlanLine.SETRANGE("Project Task No.", "Project Task No.");
            // IF ProjectPlanLine.FINDFIRST THEN BEGIN
            //     REPEAT
            //         IF ProjectPlanLine."Milestone Amount" = ProjectPlanLine."Balance Amount" THEN
            //             CheckTransmitalandAttachement("Project No.", MileStone);
            //     UNTIL ProjectPlanLine.NEXT = 0;
            // END;
        END;

        //AD_REPL
        //REPL_PN
        Project.GET(JobPlanningLine."Job No.");
        Project.TESTFIELD("Project Status", Project."Project Status"::Approved);
        JobPlanningLine.TESTFIELD("Unit Cost", JobPlanningLine."Invoice (To Be Create) Amount");
        IF NOT Project."Milestone Invoice Satge Skip" THEN BEGIN//AD_REPL
            IF NOT UserSetup.GetAdminUser THEN BEGIN
                ProjectPlanLine1.RESET;
                ProjectPlanLine1.SETRANGE("Job No.", JobPlanningLine."Job No.");
                ProjectPlanLine1.SETFILTER("Milestone Amount", '<>%1', 0);
                ProjectPlanLine1.SetFilter("Job Task No.", '<%1', JobPlanningLine."Job Task No.");
                //ProjectPlanLine1.SETFILTER(MileStone, '<%1', JobPlanningLine.MileStone);
                IF ProjectPlanLine1.FINDSET THEN BEGIN
                    REPEAT
                        IF ProjectPlanLine1."Balance Amount" = ProjectPlanLine1."Milestone Amount" THEN
                            ERROR('You can not invoice selected milestone because earlier milestone are pending for invoicing Project No.%1,Milistone No.%2', ProjectPlanLine1."Job No.", ProjectPlanLine1."Job Task No.");
                    UNTIL (ProjectPlanLine1.NEXT = 0);
                END;
            END;
        END;
    end;
    //CodeUnit 5611 Calculate Normal Depreciation
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Normal Depreciation", 'OnAfterCalcDB1Amount', '', true, true)]
    procedure OnAfterCalcDB1Amount(DBPercent: Decimal; NumberOfDays: Integer; DaysInFiscalYear: Integer; BookValue: Decimal; SalvageValue: Decimal; MinusBookValue: Decimal; Sign: Integer; DeprInFiscalYear: Decimal; var Result: Decimal; FADepreciationBook: Record "FA Depreciation Book"; FirstDeprDate: Date)
    var
    begin
        result := -(DBPercent / 100) * (NumberOfDays / DaysInFiscalYear) *
          (BookValue - MinusBookValue - Sign * DeprInFiscalYear);
    end;
    //CodeUnit 5700 User Setup Management
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"User Setup Management", 'OnBeforeGetSalesFilter', '', true, true)]
    procedure OnBeforeGetSalesFilter(UserCode: Code[50]; var UserLocation: Code[10]; var UserRespCenter: Code[10]; var IsHandled: Boolean)
    var
        CompanyInfo: Record "Company Information";
        UserSetup: Record "User Setup";
    begin
        CompanyInfo.Get();
        UserRespCenter := CompanyInfo."Responsibility Center";
        UserLocation := CompanyInfo."Location Code";
        if UserSetup.Get(UserCode) and (UserCode <> '') then
            IF UserSetup."Responsibility Center" <> 'DELHPFB' THEN
                UserRespCenter := UserSetup."Responsibility Center";
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"User Setup Management", 'OnAfterGetPurchFilter', '', true, true)]
    procedure OnAfterGetPurchFilter(var UserSetup: Record "User Setup"; var UserRespCenter: Code[10]; var UserLocation: Code[10])
    var
    begin
        IF UserSetup."Responsibility Center" <> 'DELHPFB' THEN
            UserRespCenter := UserSetup."Responsibility Center";
    end;

    var
        IsNotRequired: Boolean;
}