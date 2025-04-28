report 50140 "GST Register"
{
    ApplicationArea = all;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")
                                WHERE(Quantity = FILTER(<> 0),
                                      "No." = FILTER(<> 40000870));

            trigger OnAfterGetRecord()
            begin
                ClearVariables;
                HSNCode := "HSN/SAC Code";
                PostingDate := "Posting Date";
                DocumentNo := "Document No.";
                GetCustomer.GET("Sell-to Customer No.");
                SourceNo := "Sell-to Customer No.";
                Name := GetCustomer.Name;
                GSTTaxReg := GetCustomer."GST Registration No.";
                NatureOfService := NatureOfService::Sale;
                InvTotal := "Line Amount";
                CustVendorType := FORMAT(GetCustomer."GST Customer Type");
                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                            CGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                        IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                            SGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                            IGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                        GSTBaseAmt := DetailedGSTLedgerEntry."GST Base Amount";
                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                END;

                GSTBaseAmount := GSTBaseAmt;//"GST Base Amount";
                TaxRate := "GST Group Code";
                TempDocumentNo := "Document No.";
                TempDocumentLineNo := "Line No.";
                TempExcelBuffer.NewRow;
                TempExcelBuffer.AddColumn(NatureOfService, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(DocumentNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PostingDate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(CustVendorType, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SourceNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GSTTaxReg, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(LocGSTRegNumber, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(HSNCode, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(-GSTBaseAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(TaxRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(-InvTotal, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn("Invoice Type", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                SETRANGE("Sales Invoice Line"."Location Code", GetLocation.Code);
            end;
        }
        dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")
                                WHERE(Quantity = FILTER(<> 0),
                                      "No." = FILTER(<> 40000870));

            trigger OnAfterGetRecord()
            begin
                ClearVariables;
                HSNCode := "HSN/SAC Code";
                PostingDate := "Posting Date";
                DocumentNo := "Document No.";
                GetCustomer.GET("Sell-to Customer No.");
                SourceNo := "Sell-to Customer No.";
                Name := GetCustomer.Name;
                GSTTaxReg := GetCustomer."GST Registration No.";
                NatureOfService := NatureOfService::Sale;
                InvTotal := "Line Amount";
                CustVendorType := FORMAT(GetCustomer."GST Customer Type");

                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                            CGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                        IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                            SGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                            IGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                        GSTBaseAmt := DetailedGSTLedgerEntry."GST Base Amount";
                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                END;

                GSTBaseAmount := GSTBaseAmt;
                TaxRate := "GST Group Code";
                TempDocumentNo := "Document No.";
                TempDocumentLineNo := "Line No.";
                TempExcelBuffer.NewRow;
                TempExcelBuffer.AddColumn(NatureOfService, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(DocumentNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PostingDate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(CustVendorType, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SourceNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GSTTaxReg, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(LocGSTRegNumber, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(HSNCode, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GSTBaseAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(TaxRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(InvTotal, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn("Invoice Type", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                SETRANGE("Sales Cr.Memo Line"."Location Code", GetLocation.Code);
            end;
        }
        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")
                                WHERE(Quantity = FILTER(<> 0),
                                      "No." = FILTER(<> 40000870));

            trigger OnAfterGetRecord()
            begin
                ClearVariables;
                HSNCode := "HSN/SAC Code";
                PostingDate := "Posting Date";
                DocumentNo := "Document No.";
                GetVendor.GET("Buy-from Vendor No.");
                SourceNo := "Buy-from Vendor No.";
                Name := GetVendor.Name;
                GSTTaxReg := GetVendor."GST Registration No.";
                NatureOfService := NatureOfService::Purchase;
                InvTotal := "Line Amount";
                CustVendorType := FORMAT(GetVendor."GST Vendor Type");

                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                            CGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                        IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                            SGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                            IGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                        InvoiceType := FORMAT(DetailedGSTLedgerEntry."Document Type");
                        IsReversedCharge := DetailedGSTLedgerEntry."Reverse Charge";
                        GSTBaseAmt := DetailedGSTLedgerEntry."GST Base Amount";
                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                END;

                IF IsReversedCharge THEN
                    NatureOfService := NatureOfService::"Reversed Charge"
                ELSE
                    NatureOfService := NatureOfService::Purchase;

                GSTBaseAmount := GSTBaseAmt;
                TaxRate := "GST Group Code";
                TempDocumentNo := "Document No.";
                TempDocumentLineNo := "Line No.";
                TempExcelBuffer.NewRow;
                TempExcelBuffer.AddColumn(NatureOfService, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(DocumentNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PostingDate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(CustVendorType, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SourceNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GSTTaxReg, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(LocGSTRegNumber, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(HSNCode, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GSTBaseAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(TaxRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(InvTotal, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(InvoiceType, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                SETRANGE("Purch. Inv. Line"."Location Code", GetLocation.Code);
            end;
        }
        dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")
                                WHERE(Quantity = FILTER(<> 0),
                                      "No." = FILTER(<> 40000870));

            trigger OnAfterGetRecord()

            begin
                ClearVariables;
                HSNCode := "HSN/SAC Code";
                PostingDate := "Posting Date";
                DocumentNo := "Document No.";
                GetVendor.GET("Buy-from Vendor No.");
                SourceNo := "Buy-from Vendor No.";
                Name := GetVendor.Name;
                GSTTaxReg := GetVendor."GST Registration No.";
                InvTotal := "Line Amount";
                CustVendorType := FORMAT(GetVendor."GST Vendor Type");

                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                            CGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                        IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                            SGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                            IGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                        //InvoiceType := FORMAT(DetailedGSTLedgerEntry."Invoice Type");
                        IsReversedCharge := DetailedGSTLedgerEntry."Reverse Charge";
                        GSTBaseAmt := DetailedGSTLedgerEntry."GST Base Amount"
                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                END;

                IF IsReversedCharge THEN
                    NatureOfService := NatureOfService::"Reversed Charge"
                ELSE
                    NatureOfService := NatureOfService::Purchase;

                GSTBaseAmount := GSTBaseAmt;  //"GST Base Amount";
                TaxRate := "GST Group Code";
                TempDocumentNo := "Document No.";
                TempDocumentLineNo := "Line No.";
                TempExcelBuffer.NewRow;
                TempExcelBuffer.AddColumn(NatureOfService, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(DocumentNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PostingDate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(CustVendorType, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SourceNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GSTTaxReg, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(LocGSTRegNumber, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(HSNCode, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(-GSTBaseAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(TaxRate, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(-InvTotal, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(InvoiceType, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                SETRANGE("Purch. Cr. Memo Line"."Location Code", GetLocation.Code);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                }
                field(EnterState; EnterState)
                {
                    Caption = 'State Code';
                    TableRelation = State;
                    Visible = false;
                }
                field(LocGSTRegNumber; LocGSTRegNumber)
                {
                    Caption = 'GST Reg. No.';
                    TableRelation = "GST Registration Nos.";
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

    trigger OnPostReport()
    begin
        CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        TempExcelBuffer.DELETEALL;

        IF LocGSTRegNumber = '' THEN
            ERROR('GST Reg. No. must not be blank');

        //IF EnterState = '' THEN
        //  ERROR('State must not be blank');

        IF StartDate = 0D THEN
            ERROR('Start Date must not be blank');

        IF EndDate = 0D THEN
            ERROR('End Date must not be blank');

        GSTRegistrationNos.GET(LocGSTRegNumber);
        GetLocation.RESET;
        GetLocation.SETRANGE("GST Registration No.", LocGSTRegNumber);
        GetLocation.FINDFIRST;


        MakeHeader;
    end;

    var
        StartDate: Date;
        EndDate: Date;
        GSTBaseAmt: Decimal;
        GetVendor: Record Vendor;
        Name: Text;
        GSTTaxReg: Code[20];
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        NatureOfService: Option Sale,Purchase,"Reversed Charge","Sale Export","Sale Domestic Exempted";
        InvTotal: Decimal;
        CGSTAmount: Decimal;
        SGSTAmount: Decimal;
        IGSTAmount: Decimal;
        GSTBaseAmount: Decimal;
        HSNCode: Code[20];
        GetCustomer: Record Customer;
        DocumentNo: Code[20];
        PostingDate: Date;
        LocGSTRegNumber: Code[20];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        SourceNo: Code[20];
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        TempDocumentNo: Code[20];
        TempDocumentLineNo: Integer;
        InvoiceType: Text;
        IsReversedCharge: Boolean;
        LocationCode: Code[20];
        GetLocation: Record Location;
        CustVendorType: Text;
        GSTRegistrationNos: Record "GST Registration Nos.";
        TaxRate: Text;
        EnterState: Code[20];
        ExcelFileName: Label 'GSTRegister_%1_%2';

    local procedure MakeHeader()
    begin
        TempExcelBuffer.NewRow;
        TempExcelBuffer.AddColumn('Nature of Transaction', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Invoice No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Invoice Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Vendor/Customer Type', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Vendor/Customer No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Vendor/Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Vendor/Customer GST Reg. No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Location GST Reg. No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('HSN/SAC Code', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Taxable Amount', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Tax Rate', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('CGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('SGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('IGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Invoice Amount', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Invoice Type', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
    end;


    procedure CreateExcelbook()
    begin
        TempExcelBuffer.CreateNewBook('GST Register');
        TempExcelBuffer.WriteSheet('GST Register', COMPANYNAME, USERID);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
        //ExcelBuf.CreateBookAndOpenExcel('Cust. Detailed Acc. (In excel)', 'Cust. Detailed Acc. (In excel)', COMPANYNAME, USERID);

    end;

    local procedure ClearVariables()
    begin
        PostingDate := 0D;
        DocumentNo := '';
        SourceNo := '';
        Name := '';
        GSTTaxReg := '';
        CLEAR(NatureOfService);
        InvTotal := 0;
        CGSTAmount := 0;
        IGSTAmount := 0;
        SGSTAmount := 0;
        IsReversedCharge := FALSE;
        CustVendorType := '';
        TaxRate := '';
    end;
}

