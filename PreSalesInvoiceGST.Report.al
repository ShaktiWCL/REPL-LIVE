report 50111 "Pre Sales Invoice GST"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PreSalesInvoiceGST.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            column(Curr_Symbol; GetCurrency."Currency Symbol")
            {
            }
            column(UseAsInvoiceText_1; UseAsInvoiceText[1])
            {
            }
            column(UseAsInvoiceText_2; UseAsInvoiceText[2])
            {
            }
            column(UseAsInvoiceText_3; UseAsInvoiceText[3])
            {
            }
            column(UseAsInvoiceText_4; UseAsInvoiceText[4])
            {
            }
            column(UseAs_Invoice; UseAsInvoice)
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesHeader; "Bill-to Name" + ' ' + "Bill-to Name 2")
            {
            }
            column(BilltoName2_SalesHeader; "Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesHeader; "Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesHeader; "Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesHeader; "Bill-to City")
            {
            }
            column(BilltoContact_SalesHeader; "Bill-to Contact")
            {
            }
            column(GST_BilltoStateCode; StateCodeBill)
            {
            }
            column(GST_ShiptoStateCode; SateCodeShip)
            {
            }
            column(ShipTo_Name; "Ship-to Name")
            {
            }
            column(ShipTo_Address; "Ship-to Address")
            {
            }
            column(ShipTo_Address2; "Ship-to Address 2")
            {
            }
            column(ShipTo_City; "Ship-to City")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(CompanyName; CompanyNameText)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyCity; CompanyCity)
            {
            }
            column(PhoneNo; Location."Phone No.")
            {
            }
            column(ServiceTaxNo; CompInfo."GST Registration No.")
            {
            }
            column(PanNo; CompInfo."P.A.N. No.")
            {
            }
            column(CinNo; CompInfo."CIN No.")
            {
            }
            column(GST_No; Location."GST Registration No.")
            {
            }
            column(PostingDate_SalesHeader; "Posting Date")
            {
            }
            column(CurrencyCode_SalesHeader; CurrencyCode)
            {
            }
            column(SalesRemarks; SalesRemarks)
            {
            }
            column(Bill_State; StateName)
            {
            }
            column(Bill_GSTNo; BillToGSTNo)
            {
            }
            column(Shipl_State; ShipToInfo[2])
            {
            }
            column(Shipl_GSTNo; ShipToInfo[1])
            {
            }
            column(BankAccount_Name; BankAccount.Name)
            {
            }
            column(BankAccount_BankAccountNo; BankAccount."Bank Account No.")
            {
            }
            column(BankAccount_SWIFTCode; BankAccount."SWIFT Code")
            {
            }
            column(Bank_Address; BankAccount.Address)
            {
            }
            column(Bank_Address2; BankAccount."Address 2")
            {
            }
            column(BankAccount_City; BankAccount.City)
            {
            }
            column(BankAccount_IFSCCode; BankAccount."IFSC Code2")
            {
            }
            column(MSME; Getsalesetup.MSME)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(DocumentNo_SalesLine; "Document No.")
                {
                }
                column(No_SalesLine; "No.")
                {
                }
                column(Description_SalesLine; Description)
                {
                }
                column(Description2_SalesLine; "Description 2")
                {
                }
                column(Amount_SalesLine; Amount)
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(ServiceTaxAmount_SalesLine; 0)
                {
                }
                column(AmountToCustomer_SalesLine; CalAmount)
                {
                }
                column(MilestoneStage; MilestoneStage)
                {
                }
                column(ProjectName; ProjectName)
                {
                }
                column(AmountInWord1; AmountInWord[1])
                {
                }
                column(ChargesToCustomer_SalesLine; 0)
                {
                }
                column(MilestoneDescription; MilestoneDescription)
                {
                }
                column(ServiceTaxeCessAmount_SalesInvoiceLine; 0)
                {
                }
                column(ServiceTaxSHECessAmount_SalesInvoiceLine; 0)
                {
                }
                column(AgreementNo; AgreementNo)
                {
                }
                column(ProjectValue; ProjectValue)
                {
                }
                column(TaxPer; TaxPer)
                {
                }
                column(ServiceTaxSBCAmount_SalesInvoiceLine; 0)
                {
                }
                column(KKCessAmount_SalesInvoiceLine; 0)
                {
                }
                column(TaxAmount_SalesInvoiceLine; 0)
                {
                }
                column(TaxGroupCode; COPYSTR("Tax Group Code", 1, 3) + ' ' + 'FORMAT("Tax %")' + '%')
                {
                }
                column(CGST_Amount; CGSTAmount)
                {
                }
                column(IGST_Amount; IGSTAmount)
                {
                }
                column(SGST_Amount; SGSTAmount)
                {
                }
                column(CGST_Per; CGSTPer)
                {
                }
                column(IGST_Per; IGSTPer)
                {
                }
                column(SGST_Per; SGSTPer)
                {
                }
                column(HSNCode; "HSN/SAC Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SrNo += 1;
                    MilestoneDescription := '';
                    MilestoneStage := 0;
                    ProjectName := '';
                    AgreementNo := '';
                    ProjectValue := '';
                    IF "Job No." <> '' THEN BEGIN
                        ProjectTask.RESET;
                        ProjectTask.SETRANGE("Job No.", "Job No.");
                        ProjectTask.SETRANGE("Job Task No.", "Job Task No.");
                        //ProjectTask.SETRANGE(Milestone, Milestone);
                        IF ProjectTask.FINDFIRST THEN BEGIN
                            MilestoneDescription := ProjectTask."Milestone Desc";
                            MilestoneStage := ProjectTask."Milestone Stages";
                            ProjectName := ProjectTask.Description;
                        END;
                        IF Project.GET("Job No.") THEN BEGIN
                            AgreementNo := 'Agreement No. ' + Project."Agreement No.";
                            ProjectValue := 'Project Value ' + FORMAT(Project."Project Value");
                            ProjectName := Project."Project Name" + Project."Project Name 2";
                        END;
                    END ELSE BEGIN
                        MilestoneDescription := Description + "Description 2";
                        Project.RESET;
                        Project.SETRANGE("Global Dimension 1 Code", "Sales Header"."Shortcut Dimension 1 Code");
                        IF Project.FINDFIRST THEN BEGIN
                            AgreementNo := 'Agreement No. ' + Project."Agreement No.";
                            ProjectValue := 'Project Value ' + FORMAT(Project."Project Value");
                            ProjectName := Project."Project Name" + Project."Project Name 2";
                        END;
                    END;
                    TaxPer := 0;
                    // ServiceTaxSetup.SETRANGE(Code, "Service Tax Group");
                    // ServiceTaxSetup.SETRANGE("From Date", 0D, "Sales Header"."Posting Date");
                    // IF ServiceTaxSetup.FINDLAST THEN
                    //     TaxPer := ServiceTaxSetup."Service Tax %";
                    //GST
                    CGSTAmount := 0;
                    CGSTPer := 0;
                    IGSTAmount := 0;
                    IGSTPer := 0;
                    SGSTAmount := 0;
                    SGSTPer := 0;

                    recTaxTransactions.Reset();
                    recTaxTransactions.Setfilter("Tax Record ID", '%1', RecordId);
                    recTaxTransactions.SetFilter("Tax Type", 'GST');
                    recTaxTransactions.SetRange("Value Type", recTaxTransactions."Value Type"::COMPONENT);
                    recTaxTransactions.SetRange("Value ID", 2);
                    if recTaxTransactions.FindFirst() then begin
                        CGSTAmount := recTaxTransactions."Amount (LCY)";
                        CGSTPer := recTaxTransactions.Percent;
                    end;

                    recTaxTransactions.SetRange("Value ID", 3);
                    if recTaxTransactions.FindFirst() then begin
                        IGSTAmount := recTaxTransactions."Amount (LCY)";
                        IGSTPer := recTaxTransactions.Percent;
                    end;
                    recTaxTransactions.SetRange("Value ID", 6);
                    if recTaxTransactions.FindFirst() then begin
                        SGSTAmount := recTaxTransactions."Amount (LCY)";
                        SGSTPer := recTaxTransactions.Percent;
                    end;
                    //decTotalOrderValue := "Line Amount";

                    decTotalOrderValue += "Line Amount" + CGSTAmount + IGSTAmount + SGSTAmount;
                    //GST


                    CalAmount := Amount;
                    "Sales Header".CALCFIELDS(Amount);
                    Check.InitTextVariable;
                    Check.FormatNoText(AmountInWord, ROUND("Sales Header".Amount, 0.01), "Sales Header"."Currency Code");



                    IF "Sales Header"."GST Customer Type" = "Sales Header"."GST Customer Type"::Export THEN BEGIN
                        CalAmount := Amount;
                        CalAmount1 += Amount;
                        CGSTAmount := 0;
                        CGSTPer := 0;
                        IGSTAmount := 0;
                        IGSTPer := 0;
                        SGSTAmount := 0;
                        SGSTPer := 0;
                        Check.InitTextVariable;
                        Check.FormatNoText(AmountInWord, ROUND(CalAmount1, 1), "Sales Header"."Currency Code");
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Location.GET("Location Code");

                IF CompInfo."New Name Date" <> 0D THEN BEGIN
                    IF "Posting Date" >= CompInfo."New Name Date" THEN
                        CompanyNameText := Location.Name
                    ELSE
                        CompanyNameText := Location."Old Name";
                END ELSE
                    CompanyNameText := Location.Name;

                IF "Sales Header"."Print Location" <> '' THEN BEGIN
                    IF Loc2.GET("Sales Header"."Print Location") THEN
                        CompanyAddress := Loc2.Address + ',' + Loc2."Address 2";
                    CompanyCity := Loc2.City + '-' + Loc2."Post Code";
                END ELSE BEGIN
                    CompanyAddress := Location.Address + ',' + Location."Address 2";
                    CompanyCity := Location.City + '-' + Location."Post Code";
                END;

                SalesRemarks := '';
                SalesCommentLine.SETRANGE("No.", "No.");
                IF SalesCommentLine.FINDSET THEN
                    REPEAT
                        IF SalesRemarks <> '' THEN
                            SalesRemarks += ' ' + SalesCommentLine.Comment
                        ELSE
                            SalesRemarks := SalesCommentLine.Comment;
                    UNTIL SalesCommentLine.NEXT = 0;
                IF "Currency Code" <> '' THEN BEGIN
                    CurrencyCode := "Currency Code";
                    GetCurrency.GET(CurrencyCode);
                END ELSE
                    CurrencyCode := 'INR';

                IF NOT "Sales Header"."Billing Address Swap" THEN BEGIN
                    GetCustomer.GET("Bill-to Customer No.");
                    IF GetState.GET(GetCustomer."State Code") THEN;
                    StateName := GetState.Description;
                    StateCodeBill := GetState."State Code (GST Reg. No.)";
                    BillToGSTNo := GetCustomer."GST Registration No.";
                    IF "Ship-to Code" <> '' THEN BEGIN
                        ShiptoAddress.GET("Sell-to Customer No.", "Ship-to Code");
                        ShipToInfo[1] := ShiptoAddress."GST Registration No.";
                        IF GetState.GET(ShiptoAddress.State) THEN;
                        ShipToInfo[2] := GetState.Description;
                        SateCodeShip := GetState."State Code (GST Reg. No.)";
                    END ELSE BEGIN
                        ShipToInfo[1] := GetCustomer."GST Registration No.";
                        IF GetState.GET(GetCustomer."State Code") THEN;
                        ShipToInfo[2] := GetState.Description;
                        SateCodeShip := GetState."State Code (GST Reg. No.)";
                    END;
                END ELSE BEGIN
                    ShiptoAddress.GET("Sell-to Customer No.", "Ship-to Code");
                    ShipToInfo[1] := ShiptoAddress."GST Registration No.";
                    IF GetState.GET(ShiptoAddress.State) THEN;
                    ShipToInfo[2] := GetState.Description;
                    SateCodeShip := GetState."State Code (GST Reg. No.)";
                    BillToGSTNo := ShiptoAddress."GST Registration No.";
                    StateName := GetState.Description;
                    StateCodeBill := GetState."State Code (GST Reg. No.)";
                END;
                /*
               CGSTAmount := 0;
               CGSTPer := 0;
               IGSTAmount := 0;
               IGSTPer := 0;
               SGSTAmount := 0;
               SGSTPer := 0;
               SalesLine.Reset();
               //SalesLine.SetRange("Document Type", "Sales Header"."Invoice Type");
               SalesLine.SetRange("Document No.", "Sales Header"."No.");
               SalesLine.FindFirst();
               repeat
                   recTaxTransactions.Reset();
                   recTaxTransactions.Setfilter("Tax Record ID", '%1', SalesLine.RecordId);
                   recTaxTransactions.SetFilter("Tax Type", 'GST');
                   recTaxTransactions.SetRange("Value Type", recTaxTransactions."Value Type"::COMPONENT);
                   recTaxTransactions.SetRange("Value ID", 2);
                   if recTaxTransactions.FindFirst() then begin
                       CGSTAmount := recTaxTransactions."Amount (LCY)";
                   end;
                   recTaxTransactions.SetRange("Value ID", 3);
                   if recTaxTransactions.FindFirst() then begin
                       IGSTAmount := recTaxTransactions."Amount (LCY)";
                   end;
                   recTaxTransactions.SetRange("Value ID", 6);
                   if recTaxTransactions.FindFirst() then begin
                       SGSTAmount := recTaxTransactions."Amount (LCY)";
                   end;
                   decTotalOrderValue := SalesLine."Line Amount";
               until SalesLine.Next() = 0;
               decTotalOrderValue += CGSTAmount + IGSTAmount + SGSTAmount;
               */

                CLEAR(UseAsInvoiceText);
                IF UseAsInvoice THEN BEGIN
                    UseAsInvoiceText[1] := 'Tax Invoice';
                    UseAsInvoiceText[2] := 'Invoice Number';
                    UseAsInvoiceText[3] := 'Invoice Date';
                    UseAsInvoiceText[4] := 'Invoice Currency';
                END ELSE BEGIN
                    UseAsInvoiceText[1] := 'Proforma Invoice';
                    UseAsInvoiceText[2] := 'Proforma Invoice Number';
                    UseAsInvoiceText[3] := 'Proforma Invoice Date';
                    UseAsInvoiceText[4] := 'Proforma Invoice Curr.';
                END;
                //AD_REPL

                IF CompInfo.Name = 'Rudrabhishek Enterprises Limited' THEN BEGIN
                    IF "Bank Account No." <> '' THEN
                        BankAccount.GET("Bank Account No.")
                    ELSE
                        BankAccount.GET('BANK-013');
                END;


                IF CompInfo.Name = 'Rudrabhishek Infosystem Private Limited' THEN
                    BankAccount.GET('BANK-002');

                IF CompInfo.Name = 'Rudrabhishek Financial Advisors Private Limited' THEN
                    BankAccount.GET('BANK-004');
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(CompInfo.Picture);
                Getsalesetup.GET;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(UseAsInvoice; UseAsInvoice)
                {
                    Caption = 'Use As Invoice';
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
        CompInfo: Record "Company Information";
        SalesLine: Record "Sales Line";
        SrNo: Integer;
        ProjectTask: Record "Job Task";
        MilestoneStage: Integer;
        ProjectName: Text;
        Check: Report "Posted Voucher";
        AmountInWord: array[2] of Text;
        TotalAmt: Decimal;
        MilestoneDescription: Text;
        SalesCommentLine: Record "Sales Comment Line";
        SalesRemarks: Text;
        Project: Record Job;
        CurrencyCode: Code[10];
        //ServiceTaxSetup: Record "16472";
        TaxPer: Decimal;
        AgreementNo: Code[250];
        ProjectValue: Text;
        GetCustomer: Record Customer;
        ShiptoAddress: Record "Ship-to Address";
        GetState: Record State;
        StateName: Text;
        ShipToInfo: array[10] of Text;
        DetailedGSTLedgerEntry: Record "Detailed GST Entry Buffer";
        CGSTAmount: Decimal;
        IGSTAmount: Decimal;
        SGSTAmount: Decimal;
        CGSTPer: Decimal;
        IGSTPer: Decimal;
        SGSTPer: Decimal;
        BankAccount: Record "Bank Account";
        StateCodeBill: Code[10];
        SateCodeShip: Code[10];
        Location: Record Location;
        BillToGSTNo: Code[20];
        UseAsInvoiceText: array[10] of Text;
        UseAsInvoice: Boolean;
        GetCurrency: Record Currency;
        CalAmount: Decimal;
        CalAmount1: Decimal;
        CompanyNameText: Text;
        Getsalesetup: Record "Sales & Receivables Setup";
        recTaxTransactions: Record "Tax Transaction Value";
        decTotalOrderValue: Decimal;
        CompanyAddress: Text;

        CompanyCity: Text;
        Loc2: Record Location;
}

