report 50088 "Customize G/L Ledger"
{
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

            trigger OnAfterGetRecord()
            begin
                IF IsGroupRequired THEN
                    PrintGroupingValue
                ELSE
                    PrintWithoutGroupingValue;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(IsGroupRequired; IsGroupRequired)
                {
                    Caption = 'Grouping Required';
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
        ExcelBuf.DELETEALL;
        StartDate := "G/L Account".GETRANGEMIN("Date Filter");
        EndDate := "G/L Account".GETRANGEMAX("Date Filter");
        CompInfo.GET;

        IF CompInfo."New Name Date" <> 0D THEN BEGIN
            IF EndDate >= CompInfo."New Name Date" THEN
                CompanyNameText := CompInfo.Name
            ELSE
                CompanyNameText := CompInfo."Old Name";
        END ELSE
            CompanyNameText := CompInfo.Name;

        ReportFilters := "G/L Account".GETFILTERS;
        MakeExcelInfo;

        IF NOT IsGroupRequired THEN
            PrintHeader;
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        ReportFilters: Text;
        TempGlAccountNo: Code[20];
        GLEntry: Record "G/L Entry";
        StartDate: Date;
        EndDate: Date;
        OpeningBalance: Decimal;
        ClosingBalance: Decimal;
        //PostedNarration: Record "16548";
        SalesCommentLine: Record "Sales Comment Line";
        PurchCommentLine: Record "Purch. Comment Line";
        Narrations: Text;
        PurchInvLine: Record "Purch. Inv. Line";
        SaleInvLine: Record "Sales Invoice Line";
        TDSAmount: Decimal;
        ServiceTaxAmount: Decimal;
        GetVendor: Record Vendor;
        VendorInfo: array[2] of Text;
        CountValue: Integer;
        IsGroupRequired: Boolean;
        SBAmount: Decimal;
        KKCessAmount: Decimal;
        ServiceTaxGLAccountNo: Code[20];
        ServiceTaxGLAccountName: Text;
        SBGLAccountNo: Code[20];
        SBGLAccountName: Text;
        KKCessGLAccountNo: Code[20];
        KKCessGLAccountName: Text;
        //ServiceTaxEntry: Record "16473";
        GLAccount: Record "G/L Account";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        TDSEntry: Record "TDS Entry";
        TDSAccountNo: Code[20];
        TDSAccountName: Text;
        GetCustomer: Record Customer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        HSNSACCode: Code[20];
        GSTGroupCode: Code[20];
        CGSTAmount: Decimal;
        SGSTAmount: Decimal;
        IGSTAmount: Decimal;
        CGSTAccountNo: Code[20];
        SGSTAccountNo: Code[20];
        IGSTAccountNo: Code[20];
        HSNSAC: Record "HSN/SAC";
        HSNSACDescription: Text;
        CompanyLocationGSTNo: Code[20];
        VendorCustomerGSTNo: Code[20];
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchInvHeader: Record "Purch. Inv. Header";
        GetLocation: Record Location;
        ShiptoAddress: Record "Ship-to Address";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CompInfo: Record "Company Information";
        CompanyNameText: Text;

    procedure CreateExcelbook()
    var
        ExcelFileName: Label 'CustomGLEntries_%1_%2';
    begin
        ExcelBuf.CreateNewBook('G/L Ledger');
        ExcelBuf.WriteSheet('G/L Ledger', COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
        //ExcelBuf.CreateBookAndOpenExcel('G/L Ledger', 'G/L Ledger', COMPANYNAME, USERID);
        //ERROR('');
    end;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.AddColumn(CompanyNameText, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Report Name: G/L Ledger', FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(ReportFilters, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
    end;

    procedure PrintGroupingValue()
    begin
        OpeningBalance := 0;
        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
        GLEntry.SETRANGE("G/L Account No.", "G/L Account"."No.");
        GLEntry.SETFILTER("Posting Date", '%1..%2', 0D, CLOSINGDATE("G/L Account".GETRANGEMIN("Date Filter") - 1));
        IF GLEntry.FINDFIRST THEN BEGIN
            REPEAT
                OpeningBalance += GLEntry.Amount;
            UNTIL GLEntry.NEXT = 0;
        END;


        ClosingBalance := 0;
        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
        GLEntry.SETRANGE("G/L Account No.", "G/L Account"."No.");
        GLEntry.SETFILTER("Posting Date", '%1..%2', 0D, EndDate);
        IF GLEntry.FINDSET THEN BEGIN
            REPEAT
                ClosingBalance += GLEntry.Amount;
            UNTIL GLEntry.NEXT = 0;
        END;


        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
        GLEntry.SETRANGE("G/L Account No.", "G/L Account"."No.");
        GLEntry.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
        IF GLEntry.FINDSET THEN BEGIN
            REPEAT
                IF TempGlAccountNo <> GLEntry."G/L Account No." THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Document No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Vendor Invoice No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Debit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Credit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Cost Center', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Finance Book', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Vendor/Customer Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Vendor/Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Employee Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('TDS Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Service Tax Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('HSN/SAC Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('GST Group', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Narration', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn("G/L Account"."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("G/L Account".Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Opening Balance', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    IF OpeningBalance > 0 THEN
                        ExcelBuf.AddColumn(OpeningBalance, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
                    ELSE
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                    IF OpeningBalance < 0 THEN
                        ExcelBuf.AddColumn(OpeningBalance, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
                    ELSE
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                    ExcelBuf.NewRow;
                END;
                TDSAmount := 0;
                ServiceTaxAmount := 0;
                CLEAR(VendorInfo);
                IF GLEntry."G/L Account No." IN ['300000' .. '499999'] THEN BEGIN
                    PurchInvLine.RESET;
                    PurchInvLine.SETRANGE("Document No.", GLEntry."Document No.");
                    //PurchInvLine.SETRANGE("No.",GLEntry."G/L Account No.");
                    IF PurchInvLine.FINDSET THEN BEGIN
                        REPEAT
                            IF PurchInvLine.Type = PurchInvLine.Type::"G/L Account" THEN BEGIN
                                IF PurchInvLine."No." = GLEntry."G/L Account No." THEN BEGIN
                                    // TDSAmount += PurchInvLine."TDS Amount";
                                    // ServiceTaxAmount += PurchInvLine."Service Tax Amount" + PurchInvLine."Service Tax eCess Amount" + PurchInvLine."Service Tax SHE Cess Amount"
                                    //                                 + PurchInvLine."Service Tax SBC Amount" + PurchInvLine."KK Cess Amount";
                                END;
                            END;
                            IF PurchInvLine.Type = PurchInvLine.Type::Item THEN BEGIN
                                IF PurchInvLine."Item G/L Account No." = GLEntry."G/L Account No." THEN BEGIN
                                    // TDSAmount += PurchInvLine."TDS Amount";
                                    // ServiceTaxAmount += PurchInvLine."Service Tax Amount" + PurchInvLine."Service Tax eCess Amount" + PurchInvLine."Service Tax SHE Cess Amount"
                                    //                                 + PurchInvLine."Service Tax SBC Amount" + PurchInvLine."KK Cess Amount";
                                END;
                            END;
                        UNTIL PurchInvLine.NEXT = 0;
                        IF GetVendor.GET(PurchInvLine."Buy-from Vendor No.") THEN BEGIN
                            VendorInfo[1] := GetVendor."No.";
                            VendorInfo[2] := GetVendor.Name;
                        END;
                    END;
                    PurchCrMemoLine.RESET;
                    PurchCrMemoLine.SETRANGE("Document No.", GLEntry."Document No.");
                    //PurchCrMemoLine.SETRANGE("No.",GLEntry."G/L Account No.");
                    IF PurchCrMemoLine.FINDSET THEN BEGIN
                        REPEAT
                            IF PurchCrMemoLine.Type = PurchCrMemoLine.Type::"G/L Account" THEN BEGIN
                                IF PurchCrMemoLine."No." = GLEntry."G/L Account No." THEN BEGIN
                                    // ServiceTaxAmount += PurchCrMemoLine."Service Tax Amount" + PurchCrMemoLine."Service Tax eCess Amount" + PurchCrMemoLine."Service Tax SHE Cess Amount"
                                    //                      + PurchCrMemoLine."Service Tax SBC Amount" + PurchCrMemoLine."KK Cess Amount";
                                    // ;
                                END;
                            END;
                            IF PurchCrMemoLine.Type = PurchCrMemoLine.Type::Item THEN BEGIN
                                IF PurchCrMemoLine."Item G/L Account No." = GLEntry."G/L Account No." THEN BEGIN
                                    // ServiceTaxAmount += PurchCrMemoLine."Service Tax Amount" + PurchCrMemoLine."Service Tax eCess Amount" + PurchCrMemoLine."Service Tax SHE Cess Amount"
                                    //                      + PurchCrMemoLine."Service Tax SBC Amount" + PurchCrMemoLine."KK Cess Amount";
                                    // ;
                                END;
                            END;
                        UNTIL PurchCrMemoLine.NEXT = 0;
                        TDSEntry.RESET;
                        TDSEntry.SETRANGE("Document No.", PurchCrMemoLine."Document No.");
                        IF TDSEntry.FINDSET THEN BEGIN
                            REPEAT
                                TDSAmount += TDSEntry."TDS Amount";
                            UNTIL TDSEntry.NEXT = 0;
                        END;
                        IF GetVendor.GET(PurchCrMemoLine."Buy-from Vendor No.") THEN BEGIN
                            VendorInfo[1] := GetVendor."No.";
                            VendorInfo[2] := GetVendor.Name;
                        END;
                    END;
                    SaleInvLine.RESET;
                    SaleInvLine.SETRANGE("Document No.", GLEntry."Document No.");
                    SaleInvLine.SETRANGE("No.", GLEntry."G/L Account No.");
                    IF SaleInvLine.FINDSET THEN BEGIN
                        REPEAT
                        // ServiceTaxAmount += SaleInvLine."Service Tax Amount" + SaleInvLine."Service Tax eCess Amount" + SaleInvLine."Service Tax SHE Cess Amount"
                        //                           + SaleInvLine."Service Tax SBC Amount" + SaleInvLine."KK Cess Amount";
                        UNTIL SaleInvLine.NEXT = 0;
                        IF GetCustomer.GET(SaleInvLine."Sell-to Customer No.") THEN BEGIN
                            VendorInfo[1] := GetCustomer."No.";
                            VendorInfo[2] := GetCustomer.Name;
                        END;
                    END;
                    SalesCrMemoLine.RESET;
                    SalesCrMemoLine.SETRANGE("Document No.", GLEntry."Document No.");
                    SalesCrMemoLine.SETRANGE("No.", GLEntry."G/L Account No.");
                    IF SalesCrMemoLine.FINDSET THEN BEGIN
                        REPEAT
                        // ServiceTaxAmount += SalesCrMemoLine."Service Tax Amount" + SalesCrMemoLine."Service Tax eCess Amount" + SalesCrMemoLine."Service Tax SHE Cess Amount"
                        //                     + SalesCrMemoLine."Service Tax SBC Amount" + SalesCrMemoLine."KK Cess Amount";
                        UNTIL SalesCrMemoLine.NEXT = 0;
                        IF GetCustomer.GET(SalesCrMemoLine."Sell-to Customer No.") THEN BEGIN
                            VendorInfo[1] := GetCustomer."No.";
                            VendorInfo[2] := GetCustomer.Name;
                        END;
                    END;
                    IF VendorInfo[1] = '' THEN BEGIN
                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETRANGE("Document No.", GLEntry."Document No.");
                        IF CustLedgerEntry.FINDFIRST THEN BEGIN
                            IF GetCustomer.GET(CustLedgerEntry."Customer No.") THEN BEGIN
                                VendorInfo[1] := GetCustomer."No.";
                                VendorInfo[2] := GetCustomer.Name;
                            END;
                        END;
                    END;
                END;

                ExcelBuf.AddColumn(GLEntry."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                ExcelBuf.AddColumn(GLEntry."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(GLEntry."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(GLEntry."Debit Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(GLEntry."Credit Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(FORMAT(GLEntry."Global Dimension 1 Code"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(GLEntry."Global Dimension 2 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(VendorInfo[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(VendorInfo[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(GLEntry."Employee Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TDSAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(ServiceTaxAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);

                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE("Document No.", GLEntry."Document No.");
                IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
                    HSNSAC.GET(DetailedGSTLedgerEntry."GST Group Code", DetailedGSTLedgerEntry."HSN/SAC Code");
                    ExcelBuf.AddColumn(HSNSAC.Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(DetailedGSTLedgerEntry."GST Group Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                END ELSE BEGIN
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                END;

                Narrations := '';
                // PostedNarration.RESET;
                // PostedNarration.SETFILTER("Entry No.", '%1', 0);
                // PostedNarration.SETRANGE("Transaction No.", GLEntry."Transaction No.");
                // IF PostedNarration.FINDSET THEN BEGIN
                //     REPEAT
                //         Narrations += PostedNarration.Narration;
                //     UNTIL PostedNarration.NEXT = 0;
                // END;
                SalesCommentLine.RESET;
                SalesCommentLine.SETFILTER("Document Type", '%1|%2', SalesCommentLine."Document Type"::"Posted Invoice", SalesCommentLine."Document Type"::"Posted Credit Memo");
                SalesCommentLine.SETRANGE("No.", GLEntry."Document No.");
                IF SalesCommentLine.FINDSET THEN BEGIN
                    REPEAT
                        Narrations += SalesCommentLine.Comment;
                    UNTIL SalesCommentLine.NEXT = 0;
                END;
                PurchCommentLine.RESET;
                PurchCommentLine.SETFILTER("Document Type", '%1|%2', PurchCommentLine."Document Type"::"Posted Invoice", PurchCommentLine."Document Type"::"Posted Credit Memo");
                PurchCommentLine.SETRANGE("No.", GLEntry."Document No.");
                IF PurchCommentLine.FINDSET THEN BEGIN
                    REPEAT
                        Narrations += PurchCommentLine.Comment;
                    UNTIL PurchCommentLine.NEXT = 0;
                END;
                CountValue := STRLEN(Narrations);
                IF CountValue >= 250 THEN
                    Narrations := COPYSTR(Narrations, 1, 250);

                ExcelBuf.AddColumn(Narrations, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.NewRow;
                TempGlAccountNo := GLEntry."G/L Account No.";
            UNTIL GLEntry.NEXT = 0;
            ExcelBuf.NewRow;
            ExcelBuf.AddColumn("G/L Account"."No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("G/L Account".Name, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('Closing Balance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            IF ClosingBalance > 0 THEN
                ExcelBuf.AddColumn(ClosingBalance, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            IF ClosingBalance < 0 THEN
                ExcelBuf.AddColumn(ClosingBalance, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number)
            ELSE
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.NewRow;
            ExcelBuf.NewRow;
        END ELSE BEGIN
            IF NOT ((OpeningBalance = 0) AND (ClosingBalance = 0)) THEN BEGIN
                ExcelBuf.NewRow;
                ExcelBuf.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Document No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Vendor Invoice No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Debit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Credit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Cost Center', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Finance Book', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Vendor/Customer Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Vendor/Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Employee Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('TDS Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Service Tax Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('HSN/SAC Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('GST Group', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Narration', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.NewRow;
                ExcelBuf.NewRow;
                ExcelBuf.AddColumn("G/L Account"."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("G/L Account".Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Opening Balance', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                IF OpeningBalance > 0 THEN
                    ExcelBuf.AddColumn(OpeningBalance, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
                ELSE
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                IF OpeningBalance < 0 THEN
                    ExcelBuf.AddColumn(OpeningBalance, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
                ELSE
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.NewRow;
                ExcelBuf.NewRow;
                ExcelBuf.NewRow;
                ExcelBuf.AddColumn("G/L Account"."No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("G/L Account".Name, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Closing Balance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                IF ClosingBalance > 0 THEN
                    ExcelBuf.AddColumn(ClosingBalance, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number)
                ELSE
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                IF ClosingBalance < 0 THEN
                    ExcelBuf.AddColumn(ClosingBalance, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number)
                ELSE
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.NewRow;
                ExcelBuf.NewRow;
            END;
        END;
    end;

    procedure PrintWithoutGroupingValue()
    begin
        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
        GLEntry.SETRANGE("G/L Account No.", "G/L Account"."No.");
        GLEntry.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
        IF GLEntry.FINDSET THEN BEGIN
            REPEAT

                TDSAmount := 0;
                TDSAccountNo := '';
                TDSAccountName := '';
                ServiceTaxAmount := 0;
                SBAmount := 0;
                KKCessAmount := 0;
                ServiceTaxGLAccountNo := '';
                ServiceTaxGLAccountName := '';
                SBGLAccountNo := '';
                SBGLAccountName := '';
                KKCessGLAccountNo := '';
                KKCessGLAccountName := '';
                CLEAR(VendorInfo);
                IF GLEntry."G/L Account No." IN ['300000' .. '499999'] THEN BEGIN
                    PurchInvLine.RESET;
                    PurchInvLine.SETRANGE("Document No.", GLEntry."Document No.");
                    //PurchInvLine.SETRANGE("No.",GLEntry."G/L Account No.");
                    IF PurchInvLine.FINDSET THEN BEGIN
                        REPEAT
                            IF PurchInvLine.Type = PurchInvLine.Type::"G/L Account" THEN BEGIN
                                IF PurchInvLine."No." = GLEntry."G/L Account No." THEN BEGIN
                                    // TDSAmount += PurchInvLine."TDS Amount";
                                    // ServiceTaxAmount += PurchInvLine."Service Tax Amount" + PurchInvLine."Service Tax eCess Amount" + PurchInvLine."Service Tax SHE Cess Amount";
                                    // SBAmount += PurchInvLine."Service Tax SBC Amount";
                                    // KKCessAmount += PurchInvLine."KK Cess Amount";
                                END;
                            END;
                            IF PurchInvLine.Type = PurchInvLine.Type::Item THEN BEGIN
                                IF PurchInvLine."Item G/L Account No." = GLEntry."G/L Account No." THEN BEGIN
                                    // TDSAmount += PurchInvLine."TDS Amount";
                                    // ServiceTaxAmount += PurchInvLine."Service Tax Amount" + PurchInvLine."Service Tax eCess Amount" + PurchInvLine."Service Tax SHE Cess Amount";
                                    // SBAmount += PurchInvLine."Service Tax SBC Amount";
                                    // KKCessAmount += PurchInvLine."KK Cess Amount";
                                END;
                            END;
                        UNTIL PurchInvLine.NEXT = 0;
                        IF GetVendor.GET(PurchInvLine."Buy-from Vendor No.") THEN BEGIN
                            VendorInfo[1] := GetVendor."No.";
                            VendorInfo[2] := GetVendor.Name;
                        END;
                        TDSEntry.RESET;
                        TDSEntry.SETRANGE("Document No.", PurchInvLine."Document No.");
                        IF TDSEntry.FINDSET THEN BEGIN
                            IF GLAccount.GET(TDSEntry."Account No.") THEN BEGIN
                                TDSAccountNo := GLAccount."No.";
                                TDSAccountName := GLAccount.Name;
                            END;
                        END;

                        // ServiceTaxEntry.RESET;
                        // ServiceTaxEntry.SETRANGE("Document No.", PurchInvLine."Document No.");
                        // IF ServiceTaxEntry.FINDFIRST THEN BEGIN
                        //     IF GLAccount.GET(ServiceTaxEntry."G/L Account No.") THEN BEGIN
                        //         ServiceTaxGLAccountNo := GLAccount."No.";
                        //         ServiceTaxGLAccountName := GLAccount.Name;
                        //     END;
                        //     IF GLAccount.GET(ServiceTaxEntry."SBC G/L Account") THEN BEGIN
                        //         SBGLAccountNo := GLAccount."No.";
                        //         SBGLAccountName := GLAccount.Name;
                        //     END;
                        //     IF GLAccount.GET(ServiceTaxEntry."KK Cess G/L Account") THEN BEGIN
                        //         KKCessGLAccountNo := GLAccount."No.";
                        //         KKCessGLAccountName := GLAccount.Name;
                        //     END;
                        // END;
                    END;
                    PurchCrMemoLine.RESET;
                    PurchCrMemoLine.SETRANGE("Document No.", GLEntry."Document No.");
                    //PurchCrMemoLine.SETRANGE("No.",GLEntry."G/L Account No.");
                    IF PurchCrMemoLine.FINDSET THEN BEGIN
                        REPEAT
                            TDSEntry.RESET;
                            TDSEntry.SETRANGE("Document No.", PurchCrMemoLine."Document No.");
                            IF TDSEntry.FINDSET THEN BEGIN
                                REPEAT
                                    TDSAmount += TDSEntry."TDS Line Amount";
                                UNTIL TDSEntry.NEXT = 0;
                                IF GLAccount.GET(TDSEntry."Account No.") THEN BEGIN
                                    TDSAccountNo := GLAccount."No.";
                                    TDSAccountName := GLAccount.Name;
                                END;
                            END;
                            IF PurchCrMemoLine.Type = PurchCrMemoLine.Type::"G/L Account" THEN BEGIN
                                IF PurchCrMemoLine."No." = GLEntry."G/L Account No." THEN BEGIN
                                    // ServiceTaxAmount += PurchCrMemoLine."Service Tax Amount" + PurchCrMemoLine."Service Tax eCess Amount" + PurchCrMemoLine."Service Tax SHE Cess Amount";
                                    // SBAmount += PurchCrMemoLine."Service Tax SBC Amount";
                                    // KKCessAmount += PurchCrMemoLine."KK Cess Amount";
                                END;
                            END;
                            IF PurchCrMemoLine.Type = PurchCrMemoLine.Type::Item THEN BEGIN
                                IF PurchCrMemoLine."Item G/L Account No." = GLEntry."G/L Account No." THEN BEGIN
                                    // ServiceTaxAmount += PurchCrMemoLine."Service Tax Amount" + PurchCrMemoLine."Service Tax eCess Amount" + PurchCrMemoLine."Service Tax SHE Cess Amount";
                                    // SBAmount += PurchCrMemoLine."Service Tax SBC Amount";
                                    // KKCessAmount += PurchCrMemoLine."KK Cess Amount";
                                END;
                            END;
                        UNTIL PurchCrMemoLine.NEXT = 0;
                        IF GetVendor.GET(PurchCrMemoLine."Buy-from Vendor No.") THEN BEGIN
                            VendorInfo[1] := GetVendor."No.";
                            VendorInfo[2] := GetVendor.Name;
                        END;
                        // ServiceTaxEntry.RESET;
                        // ServiceTaxEntry.SETRANGE("Document No.", PurchCrMemoLine."Document No.");
                        // IF ServiceTaxEntry.FINDFIRST THEN BEGIN
                        //     IF GLAccount.GET(ServiceTaxEntry."G/L Account No.") THEN BEGIN
                        //         ServiceTaxGLAccountNo := GLAccount."No.";
                        //         ServiceTaxGLAccountName := GLAccount.Name;
                        //     END;
                        //     IF GLAccount.GET(ServiceTaxEntry."SBC G/L Account") THEN BEGIN
                        //         SBGLAccountNo := GLAccount."No.";
                        //         SBGLAccountName := GLAccount.Name;
                        //     END;
                        //     IF GLAccount.GET(ServiceTaxEntry."KK Cess G/L Account") THEN BEGIN
                        //         KKCessGLAccountNo := GLAccount."No.";
                        //         KKCessGLAccountName := GLAccount.Name;
                        //     END;
                        // END;
                    END;
                    SaleInvLine.RESET;
                    SaleInvLine.SETRANGE("Document No.", GLEntry."Document No.");
                    SaleInvLine.SETRANGE("No.", GLEntry."G/L Account No.");
                    IF SaleInvLine.FINDSET THEN BEGIN
                        REPEAT
                        // ServiceTaxAmount += SaleInvLine."Service Tax Amount" + SaleInvLine."Service Tax eCess Amount" + SaleInvLine."Service Tax SHE Cess Amount";
                        // SBAmount += SaleInvLine."Service Tax SBC Amount";
                        // KKCessAmount += SaleInvLine."KK Cess Amount";
                        UNTIL SaleInvLine.NEXT = 0;
                        IF GetCustomer.GET(SaleInvLine."Sell-to Customer No.") THEN BEGIN
                            VendorInfo[1] := GetCustomer."No.";
                            VendorInfo[2] := GetCustomer.Name;
                        END;
                        // ServiceTaxEntry.RESET;
                        // ServiceTaxEntry.SETRANGE("Document No.", SaleInvLine."Document No.");
                        // IF ServiceTaxEntry.FINDFIRST THEN BEGIN
                        //     IF GLAccount.GET(ServiceTaxEntry."G/L Account No.") THEN BEGIN
                        //         ServiceTaxGLAccountNo := GLAccount."No.";
                        //         ServiceTaxGLAccountName := GLAccount.Name;
                        //     END;
                        //     IF GLAccount.GET(ServiceTaxEntry."SBC G/L Account") THEN BEGIN
                        //         SBGLAccountNo := GLAccount."No.";
                        //         SBGLAccountName := GLAccount.Name;
                        //     END;
                        //     IF GLAccount.GET(ServiceTaxEntry."KK Cess G/L Account") THEN BEGIN
                        //         KKCessGLAccountNo := GLAccount."No.";
                        //         KKCessGLAccountName := GLAccount.Name;
                        //     END;
                        // END;
                    END;
                    SalesCrMemoLine.RESET;
                    SalesCrMemoLine.SETRANGE("Document No.", GLEntry."Document No.");
                    SalesCrMemoLine.SETRANGE("No.", GLEntry."G/L Account No.");
                    IF SalesCrMemoLine.FINDSET THEN BEGIN
                        REPEAT
                        // ServiceTaxAmount += SalesCrMemoLine."Service Tax Amount" + SalesCrMemoLine."Service Tax eCess Amount" + SalesCrMemoLine."Service Tax SHE Cess Amount";
                        // SBAmount += SalesCrMemoLine."Service Tax SBC Amount";
                        // KKCessAmount += SalesCrMemoLine."KK Cess Amount";
                        UNTIL SalesCrMemoLine.NEXT = 0;
                        IF GetCustomer.GET(SalesCrMemoLine."Sell-to Customer No.") THEN BEGIN
                            VendorInfo[1] := GetCustomer."No.";
                            VendorInfo[2] := GetCustomer.Name;
                        END;
                        // ServiceTaxEntry.RESET;
                        // ServiceTaxEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
                        // IF ServiceTaxEntry.FINDFIRST THEN BEGIN
                        //     IF GLAccount.GET(ServiceTaxEntry."G/L Account No.") THEN BEGIN
                        //         ServiceTaxGLAccountNo := GLAccount."No.";
                        //         ServiceTaxGLAccountName := GLAccount.Name;
                        //     END;
                        //     IF GLAccount.GET(ServiceTaxEntry."SBC G/L Account") THEN BEGIN
                        //         SBGLAccountNo := GLAccount."No.";
                        //         SBGLAccountName := GLAccount.Name;
                        //     END;
                        //     IF GLAccount.GET(ServiceTaxEntry."KK Cess G/L Account") THEN BEGIN
                        //         KKCessGLAccountNo := GLAccount."No.";
                        //         KKCessGLAccountName := GLAccount.Name;
                        //     END;
                        // END;
                    END;
                    IF VendorInfo[1] = '' THEN BEGIN
                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETRANGE("Document No.", GLEntry."Document No.");
                        IF CustLedgerEntry.FINDFIRST THEN BEGIN
                            IF GetCustomer.GET(CustLedgerEntry."Customer No.") THEN BEGIN
                                VendorInfo[1] := GetCustomer."No.";
                                VendorInfo[2] := GetCustomer.Name;
                            END;
                        END;
                    END;
                END;
                Narrations := '';
                // PostedNarration.RESET;
                // PostedNarration.SETFILTER("Entry No.", '%1', 0);
                // PostedNarration.SETRANGE("Transaction No.", GLEntry."Transaction No.");
                // IF PostedNarration.FINDSET THEN BEGIN
                //     REPEAT
                //         Narrations += PostedNarration.Narration;
                //     UNTIL PostedNarration.NEXT = 0;
                // END;
                SalesCommentLine.RESET;
                SalesCommentLine.SETFILTER("Document Type", '%1|%2', SalesCommentLine."Document Type"::"Posted Invoice", SalesCommentLine."Document Type"::"Posted Credit Memo");
                SalesCommentLine.SETRANGE("No.", GLEntry."Document No.");
                IF SalesCommentLine.FINDSET THEN BEGIN
                    REPEAT
                        Narrations += SalesCommentLine.Comment;
                    UNTIL SalesCommentLine.NEXT = 0;
                END;
                PurchCommentLine.RESET;
                PurchCommentLine.SETFILTER("Document Type", '%1|%2', PurchCommentLine."Document Type"::"Posted Invoice", PurchCommentLine."Document Type"::"Posted Credit Memo");
                PurchCommentLine.SETRANGE("No.", GLEntry."Document No.");
                IF PurchCommentLine.FINDSET THEN BEGIN
                    REPEAT
                        Narrations += PurchCommentLine.Comment;
                    UNTIL PurchCommentLine.NEXT = 0;
                END;
                CountValue := STRLEN(Narrations);
                IF CountValue >= 250 THEN
                    Narrations := COPYSTR(Narrations, 1, 250);

                CLEAR(HSNSACCode);
                CLEAR(GSTGroupCode);
                CLEAR(CGSTAmount);
                CLEAR(CGSTAccountNo);
                CLEAR(SGSTAmount);
                CLEAR(SGSTAccountNo);
                CLEAR(IGSTAmount);
                CLEAR(IGSTAccountNo);
                CLEAR(HSNSACDescription);
                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                DetailedGSTLedgerEntry.SETRANGE("Document No.", GLEntry."Document No.");
                IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                            HSNSAC.GET(DetailedGSTLedgerEntry."GST Group Code", DetailedGSTLedgerEntry."HSN/SAC Code");
                            HSNSACCode := DetailedGSTLedgerEntry."HSN/SAC Code";
                            HSNSACDescription := HSNSAC.Description;
                            GSTGroupCode := DetailedGSTLedgerEntry."GST Group Code";
                            CGSTAmount += DetailedGSTLedgerEntry."GST Amount";
                            CGSTAccountNo := DetailedGSTLedgerEntry."G/L Account No.";
                        END;
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                            HSNSAC.GET(DetailedGSTLedgerEntry."GST Group Code", DetailedGSTLedgerEntry."HSN/SAC Code");
                            HSNSACCode := DetailedGSTLedgerEntry."HSN/SAC Code";
                            HSNSACDescription := HSNSAC.Description;
                            GSTGroupCode := DetailedGSTLedgerEntry."GST Group Code";
                            SGSTAmount += DetailedGSTLedgerEntry."GST Amount";
                            SGSTAccountNo := DetailedGSTLedgerEntry."G/L Account No.";
                        END;
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                            HSNSAC.GET(DetailedGSTLedgerEntry."GST Group Code", DetailedGSTLedgerEntry."HSN/SAC Code");
                            HSNSACCode := DetailedGSTLedgerEntry."HSN/SAC Code";
                            HSNSACDescription := HSNSAC.Description;
                            GSTGroupCode := DetailedGSTLedgerEntry."GST Group Code";
                            IGSTAmount += DetailedGSTLedgerEntry."GST Amount";
                            IGSTAccountNo := DetailedGSTLedgerEntry."G/L Account No.";
                        END
                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                END;

                CompanyLocationGSTNo := '';
                VendorCustomerGSTNo := '';

                SalesInvHeader.RESET;
                SalesInvHeader.SETRANGE("No.", GLEntry."Document No.");
                IF SalesInvHeader.FINDFIRST THEN BEGIN
                    IF SalesInvHeader."Ship-to Code" <> '' THEN BEGIN
                        IF ShiptoAddress.GET(SalesInvHeader."Sell-to Customer No.", SalesInvHeader."Ship-to Code") THEN BEGIN
                            VendorCustomerGSTNo := ShiptoAddress."GST Registration No.";
                        END
                    END ELSE BEGIN
                        GetCustomer.GET(SalesInvHeader."Sell-to Customer No.");
                        VendorCustomerGSTNo := GetCustomer."GST Registration No.";
                    END;
                    IF GetLocation.GET(SalesInvHeader."Location Code") THEN
                        CompanyLocationGSTNo := GetLocation."GST Registration No.";
                END;
                SalesCrMemoHeader.RESET;
                SalesCrMemoHeader.SETRANGE("No.", GLEntry."Document No.");
                IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                    IF SalesCrMemoHeader."Ship-to Code" <> '' THEN BEGIN
                        IF ShiptoAddress.GET(SalesCrMemoHeader."Sell-to Customer No.", SalesCrMemoHeader."Ship-to Code") THEN BEGIN
                            VendorCustomerGSTNo := ShiptoAddress."GST Registration No.";
                        END
                    END ELSE BEGIN
                        GetCustomer.GET(SalesCrMemoHeader."Sell-to Customer No.");
                        VendorCustomerGSTNo := GetCustomer."GST Registration No.";
                    END;
                    IF GetLocation.GET(SalesCrMemoHeader."Location Code") THEN
                        CompanyLocationGSTNo := GetLocation."GST Registration No.";
                END;

                PurchInvHeader.RESET;
                PurchInvHeader.SETRANGE("No.", GLEntry."Document No.");
                IF PurchInvHeader.FINDFIRST THEN BEGIN
                    GetVendor.GET(PurchInvHeader."Buy-from Vendor No.");
                    VendorCustomerGSTNo := GetVendor."GST Registration No.";
                    IF GetLocation.GET(PurchInvHeader."Location Code") THEN
                        CompanyLocationGSTNo := GetLocation."GST Registration No.";
                END;

                PurchCrMemoHdr.RESET;
                PurchCrMemoHdr.SETRANGE("No.", GLEntry."Document No.");
                IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
                    GetVendor.GET(PurchCrMemoHdr."Buy-from Vendor No.");
                    VendorCustomerGSTNo := GetVendor."GST Registration No.";
                    IF GetLocation.GET(PurchInvHeader."Location Code") THEN
                        CompanyLocationGSTNo := GetLocation."GST Registration No.";
                END;



                ExcelBuf.AddColumn("G/L Account"."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("G/L Account".Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(GLEntry."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                ExcelBuf.AddColumn(GLEntry."Entry No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(GLEntry."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(GLEntry."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(GLEntry."Debit Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(GLEntry."Credit Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(FORMAT(GLEntry."Global Dimension 1 Code"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(GLEntry."Global Dimension 2 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(VendorInfo[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(VendorInfo[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(GLEntry."Employee Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TDSAccountNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TDSAccountName, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TDSAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(ServiceTaxGLAccountNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(ServiceTaxGLAccountName, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(ServiceTaxAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(SBGLAccountNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(SBGLAccountName, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(SBAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(KKCessGLAccountNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(KKCessGLAccountName, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(KKCessAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(HSNSACCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(HSNSACDescription, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(GSTGroupCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(CGSTAccountNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(SGSTAccountNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(IGSTAccountNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(Narrations, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(VendorCustomerGSTNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(CompanyLocationGSTNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.NewRow;
            UNTIL GLEntry.NEXT = 0;
        END;
    end;

    procedure PrintHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Account No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Account Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Entry No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Invoice No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Debit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Credit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Cost Center', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Finance Book', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor/Customer Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor/Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Employee Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TDS G/L Account No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TDS G/L Account Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TDS Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Service Tax G/L Account No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Service Tax G/L Account Name.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Service Tax Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('SB Cess G/L Account No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('SB Cess G/L Account Name.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('SB Cess Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('KK Cess G/L Account No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('KK Cess G/L Account Name.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('KK Cess Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('HSN/SAC Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('HSN/SAC Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('GST Group', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('CGST Account No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('CGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('SGST Account No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('SGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('IGST Account No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('IGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Narration', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer/Vendor GST No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Company GST No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
    end;
}

