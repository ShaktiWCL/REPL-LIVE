report 50090 "Purchase Regsiter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PurchaseRegsiter.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Type Of Note" = FILTER(<> Credit));
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
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
                column(DocNo1; "Purch. Inv. Header"."No.")
                {
                }
                column(PostingDate1; "Purch. Inv. Header"."Posting Date")
                {
                }
                column(VendName1; "Purch. Inv. Header"."Buy-from Vendor Name")
                {
                }
                column(LineAmount1; "Purch. Inv. Line"."Line Amount")
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
                column(TotalInvAmt1; "Purch. Inv. Line".Amount)
                {
                }
                column(Getfilter; "Purch. Inv. Header".GETFILTERS)
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
                column(GST_BaseAmount; GSTBaseAmount)
                {
                }
                column(CustomerGSTNo_1; GetVendor."GST Registration No.")
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

                    GSTBaseAmount := 0;
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
                        GSTBaseAmount := DetailedGSTLedgerEntry."GST Base Amount";
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                CGSTAmount += DetailedGSTLedgerEntry."GST Amount";
                                CGSTPer := DetailedGSTLedgerEntry."GST %";
                            END;
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                IGSTAmount += DetailedGSTLedgerEntry."GST Amount";
                                IGSTPer := DetailedGSTLedgerEntry."GST %";
                            END;
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                SGSTAmount += DetailedGSTLedgerEntry."GST Amount";
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
                GetVendor.GET("Buy-from Vendor No.");
            end;

            trigger OnPreDataItem()
            begin
                IF (StartDate <> 0D) AND (EndDate <> 0D) THEN
                    SETRANGE("Posting Date", StartDate, EndDate);
                IF VendNo <> '' THEN
                    SETRANGE("Buy-from Vendor No.", VendNo);
                IF OU <> '' THEN
                    SETRANGE("Responsibility Center", OU);
            end;
        }
        dataitem(PurchInvHeader1; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Type Of Note" = FILTER(Credit));
            dataitem(PurchInvLine1; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
                column(DocNo2; PurchInvHeader1."No.")
                {
                }
                column(PostingDate2; PurchInvHeader1."Posting Date")
                {
                }
                column(VendName2; PurchInvHeader1."Buy-from Vendor Name")
                {
                }
                column(LineAmt2; PurchInvLine1."Line Amount")
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
                column(TotalInvAmt2; PurchInvLine1.Amount)
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
                column(GST_BaseAmount1; GSTBaseAmount)
                {
                }
                column(CustomerGSTNo_2; GetVendor."GST Registration No.")
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


                    GSTBaseAmount := 0;
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
                        GSTBaseAmount := DetailedGSTLedgerEntry."GST Base Amount";
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
                GetVendor.GET("Buy-from Vendor No.");
            end;

            trigger OnPreDataItem()
            begin
                IF (StartDate <> 0D) AND (EndDate <> 0D) THEN
                    SETRANGE("Posting Date", StartDate, EndDate);
                IF VendNo <> '' THEN
                    SETRANGE("Buy-from Vendor No.", VendNo);
                IF OU <> '' THEN
                    SETRANGE("Responsibility Center", OU);
            end;
        }
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
                column(DocNo3; "Purch. Cr. Memo Hdr."."No.")
                {
                }
                column(PostingDate3; "Purch. Cr. Memo Hdr."."Posting Date")
                {
                }
                column(VendName3; "Purch. Cr. Memo Hdr."."Buy-from Vendor Name")
                {
                }
                column(LineAmt3; "Purch. Cr. Memo Line"."Line Amount")
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
                column(TotalInvAmt3; "Purch. Cr. Memo Line".Amount)
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
                column(GST_BaseAmount2; GSTBaseAmount)
                {
                }
                column(CustomerGSTNo_3; GetVendor."GST Registration No.")
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

                    GSTBaseAmount := 0;
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
                        GSTBaseAmount := DetailedGSTLedgerEntry."GST Base Amount";
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
                GetVendor.GET("Buy-from Vendor No.");
            end;

            trigger OnPreDataItem()
            begin
                IF (StartDate <> 0D) AND (EndDate <> 0D) THEN
                    SETRANGE("Posting Date", StartDate, EndDate);
                IF VendNo <> '' THEN
                    SETRANGE("Buy-from Vendor No.", VendNo);
                IF OU <> '' THEN
                    SETRANGE("Responsibility Center", OU);
            end;
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
                field("Vendor No"; VendNo)
                {
                    TableRelation = Vendor;
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
        VendNo: Code[20];
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
        GetVendor: Record Vendor;
        ExchangeRate: Decimal;
        GetLocation: Record Location;
        GSTBaseAmount: Decimal;
        CompanyNameText: Text;
}

