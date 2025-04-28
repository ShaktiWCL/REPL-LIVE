report 50142 "Project Wise Sales Reprot"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/ProjectWiseSalesReprot.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Project; Job)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Type Of Project" = FILTER("Main Project"));
            RequestFilterFields = "No.";
            column(Project_No; Project."No.")
            {
            }
            column(Project_Name; Project.Description)
            {
            }
            column(Project_Name2; Project."Description 2")
            {
            }
            column(Customer_No; Project."Bill-to Customer No.")
            {
            }
            column(Customer_Name; Project."Bill-to Name")
            {
            }
            column(Project_Value; Project."Project Value")
            {
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code");
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending)
                                    WHERE("Type Of Note" = FILTER(<> Debit));
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        ORDER(Ascending);
                    column(Show_DebitNote; ShowDebitNote)
                    {
                    }
                    column(Show_CreditNote; ShowCreditNote)
                    {
                    }
                    column(CName; CompanyNameText)
                    {
                    }
                    column(CAddress; CompInfo.Address + '  ' + CompInfo."Address 2" + ' , ' + CompInfo.City + ' - ' + CompInfo."Post Code")
                    {
                    }
                    column(CPicture; CompInfo.Picture)
                    {
                    }
                    column(DocNo1; "Sales Invoice Header"."No.")
                    {
                    }
                    column(PostingDate1; "Sales Invoice Header"."Posting Date")
                    {
                    }
                    column(VendName1; "Sales Invoice Header"."Sell-to Customer Name")
                    {
                    }
                    column(LineAmount1; ROUND("Sales Invoice Line"."Line Amount" * ExchangeRate, 0.01))
                    {
                    }
                    column(TDSAmt1; 0)
                    {
                    }
                    column(ServiceTax1; 0)
                    {
                    }
                    column(SBCAmt1; 0)
                    {
                    }
                    column(KKCAmt1; 0)
                    {
                    }
                    column(TotalSerTax1; 0)
                    {
                    }
                    column(TotalInvAmt1; ROUND("Sales Invoice Line".Amount * ExchangeRate, 0.01))
                    {
                    }
                    column(Getfilter; "Sales Invoice Header".GETFILTERS)
                    {
                    }
                    column(VatAmount_1; VatAmount[1])
                    {
                    }
                    column(CstAmount_1; CstAmount[1])
                    {
                    }
                    column(CGST_Amount; CGSTAmount)
                    {
                    }
                    column(SGST_Amount; SGSTAmount)
                    {
                    }
                    column(IGST_Amount; IGSTAmount)
                    {
                    }
                    column(CustomerGSTNo_1; CustomerGSTNo)
                    {
                    }
                    column(Comp_GST_1; GetLocation."GST Registration No.")
                    {
                    }
                    column(GetLocation_Name_1; GetLocation.Name)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        // IF "Tax Area Code" = 'CST' THEN
                        //   CstAmount[1] := "Tax Amount"
                        // ELSE
                        //   VatAmount[1] := "Tax Amount";


                        IGSTAmount := 0;
                        IGSTPer := 0;
                        SGSTAmount := 0;
                        SGSTPer := 0;
                        CGSTAmount := 0;
                        CGSTPer := 0;

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
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF CompInfo."New Name Date" <> 0D THEN BEGIN
                        IF "Posting Date" >= CompInfo."New Name Date" THEN
                            CompanyNameText := CompInfo.Name
                        ELSE
                            CompanyNameText := CompInfo."Old Name";
                    END ELSE
                        CompanyNameText := CompInfo.Name;



                    CstAmount[1] := 0;
                    VatAmount[1] := 0;

                    IF "Currency Code" <> '' THEN
                        ExchangeRate := 1 / "Currency Factor"
                    ELSE
                        ExchangeRate := 1;

                    IF GetLocation.GET("Location Code") THEN;


                    CustomerGSTNo := '';
                    IF "Ship-to Code" <> '' THEN BEGIN
                        GetShiptoAddress.GET("Sell-to Customer No.", "Ship-to Code");
                        CustomerGSTNo := GetShiptoAddress."GST Registration No."
                    END ELSE BEGIN
                        GetCustomer.GET("Bill-to Customer No.");
                        CustomerGSTNo := GetCustomer."GST Registration No."
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF (StartDate <> 0D) AND (EndDate <> 0D) THEN
                        SETRANGE("Posting Date", StartDate, EndDate);
                    IF CustNo <> '' THEN
                        SETRANGE("Sell-to Customer No.", CustNo);
                    IF OU <> '' THEN
                        SETRANGE("Responsibility Center", OU);
                end;
            }
            dataitem(SalesInvoiceHrd1; "Sales Invoice Header")
            {
                DataItemLink = "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code");
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending)
                                    WHERE("Type Of Note" = FILTER(Debit));
                dataitem(SalesInvoiceLine1; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        ORDER(Ascending);
                    column(DocNo2; SalesInvoiceHrd1."No.")
                    {
                    }
                    column(PostingDate2; SalesInvoiceHrd1."Posting Date")
                    {
                    }
                    column(VendName2; SalesInvoiceHrd1."Sell-to Customer Name")
                    {
                    }
                    column(LineAmt2; ROUND(SalesInvoiceLine1."Line Amount", 0.01))
                    {
                    }
                    column(TDSAmt2; 0)
                    {
                    }
                    column(SerTax2; 0)
                    {
                    }
                    column(SBCAmt2; 0)
                    {
                    }
                    column(KKCAmt2; 0)
                    {
                    }
                    column(TotalSerTax2; 0)
                    {
                    }
                    column(TotalInvAmt2; ROUND(SalesInvoiceLine1.Amount, 0.01))
                    {
                    }
                    column(VatAmount_2; VatAmount[2])
                    {
                    }
                    column(CstAmount_2; CstAmount[2])
                    {
                    }
                    column(CGST_Amount1; CGSTAmount)
                    {
                    }
                    column(SGST_Amount1; SGSTAmount)
                    {
                    }
                    column(IGST_Amount1; IGSTAmount)
                    {
                    }
                    column(CustomerGSTNo_2; CustomerGSTNo)
                    {
                    }
                    column(Comp_GST_2; GetLocation."GST Registration No.")
                    {
                    }
                    column(GetLocation_Name_2; GetLocation.Name)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        // IF "Tax Area Code" = 'CST' THEN
                        //   CstAmount[2] := "Tax Amount"
                        // ELSE
                        //   VatAmount[2] := "Tax Amount";

                        IGSTAmount := 0;
                        IGSTPer := 0;
                        SGSTAmount := 0;
                        SGSTPer := 0;
                        CGSTAmount := 0;
                        CGSTPer := 0;

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
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CstAmount[2] := 0;
                    VatAmount[2] := 0;

                    IF "Currency Code" <> '' THEN
                        ExchangeRate := 1 / "Currency Factor"
                    ELSE
                        ExchangeRate := 1;
                    IF GetLocation.GET("Location Code") THEN;

                    CustomerGSTNo := '';
                    IF "Ship-to Code" <> '' THEN BEGIN
                        GetShiptoAddress.GET("Sell-to Customer No.", "Ship-to Code");
                        CustomerGSTNo := GetShiptoAddress."GST Registration No."
                    END ELSE BEGIN
                        GetCustomer.GET("Bill-to Customer No.");
                        CustomerGSTNo := GetCustomer."GST Registration No."
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF (StartDate <> 0D) AND (EndDate <> 0D) THEN
                        SETRANGE("Posting Date", StartDate, EndDate);
                    IF CustNo <> '' THEN
                        SETRANGE("Sell-to Customer No.", CustNo);
                    IF OU <> '' THEN
                        SETRANGE("Responsibility Center", OU);
                end;
            }
            dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
            {
                DataItemLink = "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code");
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending);
                dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        ORDER(Ascending);
                    column(DocNo3; "Sales Cr.Memo Line"."Document No.")
                    {
                    }
                    column(PostingDate3; "Posting Date")
                    {
                    }
                    column(VendName3; "Sales Cr.Memo Header"."Sell-to Customer Name")
                    {
                    }
                    column(LineAmt3; ROUND("Sales Cr.Memo Line"."Line Amount", 0.01))
                    {
                    }
                    column(SerTax3; 0)
                    {
                    }
                    column(SBCAmt3; 0)
                    {
                    }
                    column(KKCAmt3; 0)
                    {
                    }
                    column(TotalSerTax3; 0)
                    {
                    }
                    column(TotalInvAmt3; ROUND("Sales Cr.Memo Line".Amount, 0.01))
                    {
                    }
                    column(VatAmount_3; VatAmount[3])
                    {
                    }
                    column(CstAmount_3; CstAmount[3])
                    {
                    }
                    column(CGST_Amount2; CGSTAmount)
                    {
                    }
                    column(SGST_Amount2; SGSTAmount)
                    {
                    }
                    column(IGST_Amount2; IGSTAmount)
                    {
                    }
                    column(CustomerGSTNo_3; CustomerGSTNo)
                    {
                    }
                    column(Comp_GST_3; GetLocation."GST Registration No.")
                    {
                    }
                    column(GetLocation_Name_3; GetLocation.Name)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        // IF "Tax Area Code" = 'CST' THEN
                        //   CstAmount[3] := "Tax Amount"
                        // ELSE
                        //   VatAmount[3] := "Tax Amount";


                        IGSTAmount := 0;
                        IGSTPer := 0;
                        SGSTAmount := 0;
                        SGSTPer := 0;
                        CGSTAmount := 0;
                        CGSTPer := 0;

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
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CstAmount[3] := 0;
                    VatAmount[3] := 0;

                    IF "Currency Code" <> '' THEN
                        ExchangeRate := 1 / "Currency Factor"
                    ELSE
                        ExchangeRate := 1;
                    IF GetLocation.GET("Location Code") THEN;

                    CustomerGSTNo := '';
                    IF "Ship-to Code" <> '' THEN BEGIN
                        GetShiptoAddress.GET("Sell-to Customer No.", "Ship-to Code");
                        CustomerGSTNo := GetShiptoAddress."GST Registration No."
                    END ELSE BEGIN
                        GetCustomer.GET("Bill-to Customer No.");
                        CustomerGSTNo := GetCustomer."GST Registration No."
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF (StartDate <> 0D) AND (EndDate <> 0D) THEN
                        SETRANGE("Posting Date", StartDate, EndDate);
                    IF CustNo <> '' THEN
                        SETRANGE("Sell-to Customer No.", CustNo);
                    IF OU <> '' THEN
                        SETRANGE("Responsibility Center", OU);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                }
                field("End Date"; EndDate)
                {
                }
                field("Customer No"; CustNo)
                {
                    TableRelation = Customer;
                }
                field(OU; OU)
                {
                    TableRelation = "Responsibility Center";
                }
                field("Show Debit Note"; ShowDebitNote)
                {
                }
                field("Show Credit Note"; ShowCreditNote)
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
        CompInfo.GET;
        CompInfo.CALCFIELDS(CompInfo.Picture);
    end;

    var
        StartDate: Date;
        EndDate: Date;
        CustNo: Code[20];
        OU: Code[20];
        ShowDebitNote: Boolean;
        ShowCreditNote: Boolean;
        CompInfo: Record "Company Information";
        VatAmount: array[3] of Decimal;
        CstAmount: array[3] of Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CGSTAmount: Decimal;
        IGSTAmount: Decimal;
        SGSTAmount: Decimal;
        CGSTPer: Decimal;
        IGSTPer: Decimal;
        SGSTPer: Decimal;
        ExchangeRate: Decimal;
        GetLocation: Record Location;
        GetCustomer: Record Customer;
        GetShiptoAddress: Record "Ship-to Address";
        CustomerGSTNo: Code[20];
        CompanyNameText: Text;
}

