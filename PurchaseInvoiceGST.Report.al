report 50119 "Purchase Invoice GST"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PurchaseInvoiceGST.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            column(Is_Register; IsRegister)
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
            column(BilltoCustomerNo_SalesHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
            {
            }
            column(BilltoName_SalesHeader; "Purch. Inv. Header"."Buy-from Vendor Name")
            {
            }
            column(BilltoName2_SalesHeader; "Purch. Inv. Header"."Buy-from Vendor Name 2")
            {
            }
            column(BilltoAddress_SalesHeader; "Purch. Inv. Header"."Buy-from Address")
            {
            }
            column(BilltoAddress2_SalesHeader; "Purch. Inv. Header"."Buy-from Address 2")
            {
            }
            column(BilltoCity_SalesHeader; "Purch. Inv. Header"."Buy-from City")
            {
            }
            column(BilltoContact_SalesHeader; "Purch. Inv. Header"."Buy-from Contact")
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
            column(CompanyName; Location.Name)
            {
            }
            column(CompanyAddress; Location.Address + ',' + Location."Address 2")
            {
            }
            column(CompanyCity; Location.City + '-' + Location."Post Code")
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
            column(TDS_Amount; "Purch. Inv. Header"."TDS Amount")
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
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
                column(AmountToCustomer_SalesLine; Amount)
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
                column(TDS_Category; '')
                {
                }
                column(TDS_Percentage; 0)
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
                    MilestoneDescription := Description + "Description 2";

                    CGSTAmount := 0;
                    CGSTPer := 0;
                    IGSTAmount := 0;
                    IGSTPer := 0;
                    SGSTAmount := 0;
                    SGSTPer := 0;

                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETCURRENTKEY("GST Component Code");
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                    IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                CGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                                CGSTPer := DetailedGSTLedgerEntry."GST %";
                            END;
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                IGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                                IGSTPer := DetailedGSTLedgerEntry."GST %";
                            END;
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                SGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                                SGSTPer := DetailedGSTLedgerEntry."GST %";
                            END;
                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                    END;


                    "Purch. Inv. Header".CALCFIELDS(Amount);
                    Check.InitTextVariable;
                    Check.FormatNoText(AmountInWord, ROUND("Purch. Inv. Header".Amount, 1), "Purch. Inv. Header"."Currency Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF "GST Vendor Type" IN ["GST Vendor Type"::Unregistered, "GST Vendor Type"::Import] THEN
                    IsRegister := FALSE
                ELSE
                    IsRegister := TRUE;

                Location.GET("Location Code");
                SalesRemarks := '';
                SalesCommentLine.SETRANGE("No.", "No.");
                IF SalesCommentLine.FINDSET THEN
                    REPEAT
                        IF SalesRemarks <> '' THEN
                            SalesRemarks += ' ' + SalesCommentLine.Comment
                        ELSE
                            SalesRemarks := SalesCommentLine.Comment;
                    UNTIL SalesCommentLine.NEXT = 0;
                IF "Currency Code" <> '' THEN
                    CurrencyCode := "Currency Code"
                ELSE
                    CurrencyCode := 'INR';

                GetCustomer.GET("Buy-from Vendor No.");
                IF GetState.GET(GetCustomer."State Code") THEN;
                StateName := GetState.Description;
                StateCodeBill := GetState."State Code (GST Reg. No.)";
                BillToGSTNo := GetCustomer."GST Registration No.";
                ShipToInfo[1] := GetCustomer."GST Registration No.";
                IF GetState.GET(GetCustomer."State Code") THEN;
                ShipToInfo[2] := GetState.Description;
                SateCodeShip := GetState."State Code (GST Reg. No.)";

                CLEAR(UseAsInvoiceText);
                IF UseAsInvoice THEN BEGIN
                    UseAsInvoiceText[1] := 'Purchase Invoice';
                    UseAsInvoiceText[2] := 'Purch. Inv. No.';
                    UseAsInvoiceText[3] := 'Purch. Inv. Date';
                    UseAsInvoiceText[4] := 'Purch. Inv. Curr.';
                END ELSE BEGIN
                    UseAsInvoiceText[1] := 'Purchase Invoice';
                    UseAsInvoiceText[2] := 'Purch. Inv. No.';
                    UseAsInvoiceText[3] := 'Purch. Inv. Date';
                    UseAsInvoiceText[4] := 'Purch. Inv. Curr.';
                END;
                //AD_REPL


                IF CompInfo.Name = 'Rudrabhishek Enterprises Pvt. Ltd.' THEN
                    BankAccount.GET('BANK-013');

                IF CompInfo.Name = 'Rudrabhishek Infosystem Private Limited' THEN
                    BankAccount.GET('BANK-002');

                IF CompInfo.Name = 'Rudrabhishek Financial Advisors Private Limited' THEN
                    BankAccount.GET('BANK-001');

                "Purch. Inv. Header".CALCFIELDS("TDS Amount")
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(CompInfo.Picture);
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
        CompInfo: Record "Company Information";
        SrNo: Integer;
        ProjectTask: Record "Job Task";
        MilestoneStage: Integer;
        ProjectName: Text;
        Check: Report Check;
        AmountInWord: array[2] of Text;
        TotalAmt: Decimal;
        MilestoneDescription: Text;
        SalesCommentLine: Record "Sales Comment Line";
        SalesRemarks: Text;
        Project: Record Job;
        CurrencyCode: Code[10];
        //ServiceTaxSetup: Record "16472";
        TaxPer: Decimal;
        AgreementNo: Code[100];
        ProjectValue: Text;
        GetCustomer: Record Customer;
        ShiptoAddress: Record "Ship-to Address";
        GetState: Record State;
        StateName: Text;
        ShipToInfo: array[10] of Text;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
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
        IsRegister: Boolean;
}

