codeunit 50025 "Batch Create Sales Order"
{
    TableNo = 50057;

    trigger OnRun()
    var
        InboundSalesHeader: Record "Inbound Sales Header";
        lInbSalesHdr: Record "Inbound Sales Header";
    begin
        CreateCustomer;
        lInbSalesHdr := Rec;
        InboundSalesHeader.RESET;
        InboundSalesHeader.SETRANGE(InboundSalesHeader."Web Sales Order No.", lInbSalesHdr."Web Sales Order No.");
        InboundSalesHeader.SETFILTER(Status, '<>%1', InboundSalesHeader.Status::Created);
        IF InboundSalesHeader.FINDFIRST THEN BEGIN
            IF CreateSalesOrder(InboundSalesHeader) THEN BEGIN
                InboundSalesHeader.Status := InboundSalesHeader.Status::Created;
                InboundSalesHeader.MODIFY(TRUE);
            END;
        END;
    end;

    var
        DocNo: Code[20];
        InboundCustomers: Record "Inbound Customer";
        SalesHrd: Record "Sales Header";
        WebSetup: Record "Web Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure CreateCustomer(): Boolean
    var
        Customer: Record Customer;
        CustomerNo: Code[40];
        InboundCustomer: Record "Inbound Customer";
        InboundSalesHeaderM201: Record "Inbound Sales Header";
    begin
        WebSetup.GET;
        WebSetup.TESTFIELD(WebSetup."Web Customer Nos");
        InboundCustomer.RESET;
        InboundCustomer.SETRANGE(Status, InboundCustomer.Status::Pending);
        IF InboundCustomer.FINDFIRST THEN BEGIN
            REPEAT
                Customer.SETRANGE(Customer."Web Cust. No.", InboundCustomer."Web Customer No.");
                IF NOT Customer.FINDFIRST THEN BEGIN
                    Customer.INIT;
                    CustomerNo := NoSeriesMgt.GetNextNo(WebSetup."Web Customer Nos", WORKDATE, TRUE);
                    Customer."No." := CustomerNo;
                    Customer.VALIDATE(Name, InboundCustomer.Name);
                    Customer.VALIDATE("Name 2", InboundCustomer."Name 2");
                    Customer.VALIDATE(Address, InboundCustomer.Address);
                    Customer.VALIDATE("Address 2", InboundCustomer."Address 2");
                    Customer.VALIDATE(City, InboundCustomer.City);
                    Customer.VALIDATE("Post Code", InboundCustomer."Post Code");
                    Customer.VALIDATE("Country/Region Code", InboundCustomer."Country/Region Code");
                    Customer.VALIDATE("E-Mail", InboundCustomer."E-Mail");
                    Customer.Blocked := Customer.Blocked::" ";
                    Customer."Web Cust. No." := InboundCustomer."Web Customer No.";
                    Customer.VALIDATE("Customer Posting Group", WebSetup."Customer Posting Group");
                    Customer.VALIDATE("Gen. Bus. Posting Group", WebSetup."Gen. Bus. Posting Group");
                    Customer."Phone No." := InboundCustomer."Phone No.";
                    //Customer.VALIDATE("State Code", InboundCustomer."State Code");
                    Customer."VAT Bus. Posting Group" := 'NOVAT';
                    Customer."Location Code" := 'DL-TC';
                    //Customer."GST Customer Type" := Customer."GST Customer Type"::Unregistered;
                    Customer."New Data" := TRUE;
                    Customer.INSERT;
                    InboundCustomer.Status := InboundCustomer.Status::Created;
                    InboundCustomer.MODIFY;
                END;
            UNTIL InboundCustomer.NEXT = 0;
        END;

        EXIT(TRUE);
    end;

    procedure CustomerExist(CustomerNo: Code[30]): Boolean
    var
        Customer: Record Customer;
    begin
        IF Customer.GET(CustomerNo) THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    procedure CreateSalesOrder(InboundSalesHeader: Record "Inbound Sales Header"): Boolean
    var
        SalesHeader: Record "Sales Header";
        Text0001: Label 'Sales Order %1 already exists.';
        InboundSalesLine: Record "Inbound Sales Line";
        OrderDate: Text;
        Ok: Boolean;
        intYear: Integer;
        intMonth: Integer;
        intDay: Integer;
        InboundCust: Record "Inbound Customer";
        CountShippingAgent: Integer;
        InboundPaymentLine: Record "Inbound Payment Line";
    begin
        IF NOT SalesOrderExist(InboundSalesHeader."Web Sales Order No.") THEN BEGIN
            WebSetup.GET;
            SalesHeader.INIT;
            SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
            SalesHeader."No." := NoSeriesMgt.GetNextNo(WebSetup."Web Invoice Nos", WORKDATE, TRUE);
            SalesHeader."Document Date" := WORKDATE;
            SalesHeader."Order Date" := InboundSalesHeader."Order Date";
            SalesHeader."External Document No." := InboundSalesHeader."Web Sales Order No.";
            SalesHeader.INSERT(TRUE);
            SalesHeader.SetHideValidationDialog(TRUE);
            SalesHeader.VALIDATE("Sell-to Customer No.", GetCustomer(InboundSalesHeader."Web Customer No."));
            SalesHeader.VALIDATE("Sell-to Customer Name", (InboundSalesHeader."Bill-to Name" + ' ' + InboundSalesHeader."Bill-to Name 2"));
            SalesHeader.VALIDATE("Bill-to Name", (InboundSalesHeader."Bill-to Name"));
            SalesHeader.VALIDATE("Bill-to Name 2", (InboundSalesHeader."Bill-to Name 2"));
            SalesHeader."Bill-to Address" := InboundSalesHeader."Bill-to Address";
            SalesHeader."Bill-to Address 2" := InboundSalesHeader."Bill-to Address 2";
            SalesHeader."Bill-to City" := InboundSalesHeader."Bill-to City";
            SalesHeader.VALIDATE("Shortcut Dimension 1 Code", WebSetup."Shortcut Dimension 1 Code");
            SalesHeader.VALIDATE("Shortcut Dimension 2 Code", WebSetup."Shortcut Dimension 2 Code");
            SalesHeader.VALIDATE("Responsibility Center", WebSetup."Responsibility Center");
            SalesHeader."Bill-to Contact" := InboundSalesHeader."Bill-to Contact";
            SalesHeader."Bill-to Country/Region Code" := InboundSalesHeader."Bill-to Country/Region Code";
            SalesHeader."Bill-to Post Code" := InboundSalesHeader."Bill-to Post Code";
            SalesHeader.VALIDATE("Gen. Bus. Posting Group", WebSetup."Gen. Bus. Posting Group");
            SalesHeader."Posting Date" := InboundSalesHeader."Order Date";
            SalesHeader.VALIDATE("Web.Order ID", InboundSalesHeader."Web Sales Order No.");
            IF SalesHeader.MODIFY(TRUE) THEN BEGIN
                DocNo := SalesHeader."No.";
                InboundSalesLine.RESET;
                InboundSalesLine.SETRANGE("Web Sales Order No.", InboundSalesHeader."Web Sales Order No.");
                InboundSalesLine.SETFILTER("Unit Price", '<>%1', 0);
                IF InboundSalesLine.FINDFIRST THEN BEGIN
                    REPEAT
                        CreateSalesLine(InboundSalesLine, SalesHeader);
                    UNTIL InboundSalesLine.NEXT = 0;
                END;

                InboundPaymentLine.RESET;
                InboundPaymentLine.SETRANGE("Web Sales Order No.", SalesHeader."Web.Order ID");
                InboundPaymentLine.SETFILTER(Status, '<>%1', InboundPaymentLine.Status::Created);
                IF InboundPaymentLine.FINDFIRST THEN BEGIN
                    IF CreatePaymentLine(InboundPaymentLine, SalesHeader) THEN BEGIN
                        InboundPaymentLine.Status := InboundPaymentLine.Status::Created;
                        InboundPaymentLine.MODIFY;
                    END;
                END;


                SalesHeader.MODIFY(TRUE);
                EXIT(TRUE);
            END;
        END;// ELSE
            //ERROR(Text0001,InboundSalesHeader."Web Sales Order No.");
    end;

    procedure CreateSalesLine(InboundSalesLine: Record "Inbound Sales Line"; SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        InboundSalesLine3: Record "Inbound Sales Line";
        ShippingCharges: Decimal;
        RecItem: Record Item;
        lBundleProdTypeText: Label 'bundle';
        InboundSalesHeader: Record "Inbound Sales Header";
        previousItemNo: Code[40];
    begin
        CLEAR(SalesLine);
        WebSetup.GET;
        SalesLine.INIT;
        SalesLine.VALIDATE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
        SalesLine.VALIDATE("No.", WebSetup."Item GL Account No.");
        SalesLine.VALIDATE(Quantity, InboundSalesLine.Quantity);
        SalesLine."Line No." := InboundSalesLine."Line No.";
        SalesLine.INSERT(TRUE);
        SalesLine.VALIDATE("Unit Price", InboundSalesLine."Unit Price");
        SalesLine.Description := InboundSalesLine.Description;
        SalesLine."Description 2" := InboundSalesLine."Description 2";
        SalesLine.MODIFY(TRUE);
        //END;
    end;

    procedure CreatePaymentLine(InboundPaymentLine: Record "Inbound Payment Line"; SalesHeader: Record "Sales Header"): Boolean
    var
        PaymentMethod: Record "Payment Method";
        GenJournalLine: Record "Gen. Journal Line";
        GnlLineNo: Integer;
        BankAccount: Record "Bank Account";
        Text0001: Label 'Bal. Account No. must not be blank.';
    begin
        WebSetup.GET;
        WebSetup.TESTFIELD("Cash Journal Template Name");
        WebSetup.TESTFIELD("Cash Journal Batch Name");
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", WebSetup."Cash Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", WebSetup."Cash Journal Batch Name");
        IF GenJournalLine.FINDLAST THEN
            GnlLineNo := GenJournalLine."Line No." + 10000
        ELSE
            GnlLineNo := 10000;

        CLEAR(GenJournalLine);
        GenJournalLine.INIT;
        GenJournalLine."Document No." := '';
        IF InboundPaymentLine."Payment Type" = InboundPaymentLine."Payment Type"::Cash THEN BEGIN
            GenJournalLine."Journal Template Name" := WebSetup."Cash Journal Template Name";
            GenJournalLine."Journal Batch Name" := WebSetup."Cash Journal Batch Name";
        END ELSE BEGIN
            GenJournalLine."Journal Template Name" := WebSetup."Bank Journal Template Name";
            GenJournalLine."Journal Batch Name" := WebSetup."Bank Journal Batch Name";

        END;
        GenJournalLine."Line No." := GnlLineNo;
        GenJournalLine.INSERT(TRUE);
        SalesHeader.SetHideValidationDialog(TRUE);
        SalesHeader.MODIFY;

        GenJournalLine.VALIDATE("Posting Date", TODAY);
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);

        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        GenJournalLine.VALIDATE("Account No.", SalesHeader."Sell-to Customer No.");
        IF InboundPaymentLine."Payment Type" = InboundPaymentLine."Payment Type"::Cash THEN
            GenJournalLine.VALIDATE("Source Code", 'CASHPYMTV')
        ELSE
            GenJournalLine.VALIDATE("Source Code", 'BANKRCPTV');
        GenJournalLine.VALIDATE(Amount, InboundPaymentLine.Amount * -1);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", WebSetup."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", WebSetup."Shortcut Dimension 2 Code");
        GenJournalLine.VALIDATE("Responsibility Center", WebSetup."Responsibility Center");
        IF InboundPaymentLine."Payment Type" = InboundPaymentLine."Payment Type"::Cash THEN
            GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account")
        ELSE
            GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"Bank Account");
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"Bank Account");
        IF InboundPaymentLine."Payment Type" = InboundPaymentLine."Payment Type"::Cash THEN
            GenJournalLine.VALIDATE("Bal. Account No.", WebSetup."Cash Account")
        ELSE
            GenJournalLine.VALIDATE("Bal. Account No.", WebSetup."Bank Account");
        GenJournalLine.Description := SalesHeader."No.";
        GenJournalLine."External Document No." := SalesHeader."Web.Order ID";
        GenJournalLine.MODIFY(TRUE);
    end;

    procedure SalesOrderExist(SalesOrderNo: Code[30]): Boolean
    var
        SalesOrder: Record "Sales Header";
    begin
        SalesOrder.RESET;
        SalesOrder.SETRANGE("Web.Order ID", SalesOrderNo);
        IF SalesOrder.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    procedure GetCustomer(MagentoCustomerID: Text): Code[20]
    var
        RecCust: Record Customer;
        CustomerNo: Code[20];
        RecInboundCustomers: Record "Inbound Customer";
    begin
        RecCust.SETRANGE("Web Cust. No.", MagentoCustomerID);
        IF RecCust.FINDFIRST THEN
            CustomerNo := RecCust."No.";
        EXIT(CustomerNo);
    end;

    procedure GetCustomerFromMagentoEmail(MagentoCustomerID: Code[40]): Code[40]
    var
        RecCust: Record Customer;
        CustomerNo: Code[40];
        InboundCustomers: Record "Inbound Customer";
    begin
        IF InboundCustomers.GET(MagentoCustomerID) THEN
            RecCust.SETRANGE("Web Cust. No.", MagentoCustomerID);
        IF RecCust.FINDFIRST THEN
            CustomerNo := RecCust."No.";
        EXIT(CustomerNo);
    end;
}

