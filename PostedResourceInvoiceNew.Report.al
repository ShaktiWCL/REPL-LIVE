report 60108 "Posted Resource Invoice New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PostedResourceInvoiceNew.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(No_SalesHeader; "No.")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesHeader; "Bill-to Name")
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
            column(GST_ShiptoStateCode; StateCodeShip)
            {
            }
            column(ShipTo_Name; "Sales Invoice Header"."Ship-to Name")
            {
            }
            column(ShipTo_Address; "Sales Invoice Header"."Ship-to Address")
            {
            }
            column(ShipTo_Address2; "Sales Invoice Header"."Ship-to Address 2")
            {
            }
            column(ShipTo_City; "Sales Invoice Header"."Ship-to City")
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
            column(Bill_GSTNo; GetCustomer."GST Registration No.")
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
            column(MSME; Getsalesetup.MSME)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(DocumentNo_SalesLine;
                "Document No.")
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
                column(AmountToCustomer_SalesLine; 0)
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
                column(MilestoneDescription; ResourceName)
                {
                }
                column(MilestoneDescription_Des; "Sales Invoice Line"."Resource Desgination")
                {
                }
                column(Billing_Month; "Sales Invoice Line"."Billing Month")
                {
                }
                column(Unit_Price; "Sales Invoice Line"."Unit Price")
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
                column(TaxGroupCode; COPYSTR("Tax Group Code", 1, 3) + ' ' + FORMAT(0) + '%')
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
                column(HSNCode; "Sales Invoice Line"."HSN/SAC Code")
                {
                }
                column(Total_No_OfDays; "Billing Days")
                {
                }
                column(PerManday_Cost; ROUND(PerMandayCost, 0.01))
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
                        ProjectTask.SETRANGE(Milestone, Milestone);
                        IF ProjectTask.FINDFIRST THEN BEGIN
                            MilestoneDescription := ProjectTask."Milestone Desc";
                            MilestoneStage := ProjectTask."Milestone Stages";
                            ProjectName := ProjectTask.Description;
                        END;
                        IF Project.GET("Job No.") THEN BEGIN
                            AgreementNo := 'Agreement No. ' + Project."Agreement No.";
                            ProjectValue := 'Project Value ' + FORMAT(Project."Project Value");
                        END;
                    END ELSE
                        MilestoneDescription := Description + "Description 2";

                    TaxPer := 0;
                    //ServiceTaxSetup.SETRANGE(Code, "Service Tax Group");
                    //ServiceTaxSetup.SETRANGE("From Date", 0D, "Sales Invoice Header"."Posting Date");
                    //IF ServiceTaxSetup.FINDLAST THEN
                    //  TaxPer := ServiceTaxSetup."Service Tax %";


                    ResourceName := '';
                    IF GetEmployee.GET("Resource No.") THEN
                        ResourceName := GetEmployee."First Name";


                    CGSTAmount := 0;
                    CGSTPer := 0;
                    IGSTAmount := 0;
                    IGSTPer := 0;
                    SGSTAmount := 0;
                    SGSTPer := 0;
                    /*
                                        DetailedGSTLedgerEntry.RESET;
                                        DetailedGSTLedgerEntry.SETCURRENTKEY("GST Component Code");
                                        DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                                        DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                                        DetailedGSTLedgerEntry.SETFILTER("Entry Type", '%1', DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                                        IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                                            REPEAT
                                                IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                                    CGSTAmount := -DetailedGSTLedgerEntry."GST Amount";
                                                    CGSTPer := DetailedGSTLedgerEntry."GST %";
                                                END;
                                                IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                                    IGSTAmount := -DetailedGSTLedgerEntry."GST Amount";
                                                    IGSTPer := DetailedGSTLedgerEntry."GST %";
                                                END;
                                                IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                                    SGSTAmount := -DetailedGSTLedgerEntry."GST Amount";
                                                    SGSTPer := DetailedGSTLedgerEntry."GST %";
                                                END;
                                            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                                        END;
                    */
                    PerMandayCost := 0;
                    IF "Billing Days" <> 0 THEN
                        PerMandayCost := Amount / "Billing Days";


                    "Sales Invoice Header".CALCFIELDS(Amount);
                    Check.InitTextVariable;
                    Check.FormatNoText(AmountInWord, "Sales Invoice Header".Amount, "Sales Invoice Header"."Currency Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
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


                IF NOT "Billing Address Swap" THEN BEGIN
                    GetCustomer.GET("Bill-to Customer No.");
                    GetState.GET(GetCustomer."State Code");
                    StateName := GetState.Description;
                    StateCodeBill := GetState."State Code (GST Reg. No.)";
                    BillToGSTNo := GetCustomer."GST Registration No.";

                    IF "Ship-to Code" <> '' THEN BEGIN
                        ShiptoAddress.GET("Sell-to Customer No.", "Ship-to Code");
                        ShipToInfo[1] := ShiptoAddress."GST Registration No.";
                        GetState.GET(ShiptoAddress.State);
                        ShipToInfo[2] := GetState.Description;
                        StateCodeShip := GetState."State Code (GST Reg. No.)";
                    END ELSE BEGIN
                        ShipToInfo[1] := GetCustomer."GST Registration No.";
                        GetState.GET(GetCustomer."State Code");
                        ShipToInfo[2] := GetState.Description;
                        StateCodeShip := GetState."State Code (GST Reg. No.)";
                    END;
                END ELSE BEGIN
                    ShiptoAddress.GET("Sell-to Customer No.", "Ship-to Code");
                    ShipToInfo[1] := ShiptoAddress."GST Registration No.";
                    GetState.GET(ShiptoAddress.State);
                    ShipToInfo[2] := GetState.Description;
                    StateCodeShip := GetState."State Code (GST Reg. No.)";
                    BillToGSTNo := ShiptoAddress."GST Registration No.";
                    StateName := GetState.Description;
                    StateCodeBill := GetState."State Code (GST Reg. No.)";
                END;

                IF CompInfo.Name = 'Rudrabhishek Enterprises Limited' THEN
                    BankAccount.GET('BANK-013');

                IF CompInfo.Name = 'Rudrabhishek Infosystem Private Limited' THEN
                    BankAccount.GET('BANK-002');

                IF CompInfo.Name = 'Rudrabhishek Financial Advisors Private Limited' THEN
                    BankAccount.GET('BANK-001');
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
        // ServiceTaxSetup: Record "16472";
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
        StateCodeShip: Code[10];
        Location: Record Location;
        BillToGSTNo: Code[20];
        GetEmployee: Record Employee;
        ResourceName: Text;
        PerMandayCost: Decimal;
        Getsalesetup: Record "Sales & Receivables Setup";
}

