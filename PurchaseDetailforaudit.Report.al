report 50102 "Purchase Detail (for audit)"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            CalcFields = "Amount Including VAT";
            DataItemTableView = SORTING("No.");
            //WHERE("Type Of Note" = FILTER(' '));
            RequestFilterFields = "No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code";

            trigger OnAfterGetRecord()
            begin
                PaidAmount := 0;
                RcptNo := '';
                RcptDate := '';
                //Condition 1
                VendorLedgEntry.RESET;
                VendorLedgEntry.SETRANGE("Document No.", "No.");
                IF VendorLedgEntry.FINDFIRST THEN BEGIN
                    DetailedVendorLedgEntry.RESET;
                    DetailedVendorLedgEntry.SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type");
                    DetailedVendorLedgEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedgEntry."Entry No.");
                    DetailedVendorLedgEntry.SETFILTER("Entry Type", '%1', DetailedVendorLedgEntry."Entry Type"::Application);
                    DetailedVendorLedgEntry.SETFILTER("Initial Document Type", '%1', DetailedVendorLedgEntry."Initial Document Type"::Invoice);
                    IF DetailedVendorLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            PaidAmount += -(DetailedVendorLedgEntry."Amount (LCY)");
                        UNTIL DetailedVendorLedgEntry.NEXT = 0;
                    END;
                END;
                //Condition 1

                //Condition 2
                VendorLedgEntry.RESET;
                VendorLedgEntry.SETRANGE("Document No.", "No.");
                IF VendorLedgEntry.FINDFIRST THEN BEGIN
                    DetailedVendorLedgEntry.RESET;
                    DetailedVendorLedgEntry.SETCURRENTKEY("Document No.");
                    DetailedVendorLedgEntry.SETRANGE("Document No.", VendorLedgEntry."Document No.");
                    DetailedVendorLedgEntry.SETFILTER("Entry Type", '%1', DetailedVendorLedgEntry."Entry Type"::Application);
                    DetailedVendorLedgEntry.SETFILTER("Document Type", '%1', DetailedVendorLedgEntry."Document Type"::Invoice);
                    IF DetailedVendorLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            PaidAmount += (DetailedVendorLedgEntry."Amount (LCY)");
                        UNTIL DetailedVendorLedgEntry.NEXT = 0;
                    END;
                END;
                //Condition 2

                VendorLedgEntry.RESET;
                VendorLedgEntry.SETRANGE("Document No.", "No.");
                IF VendorLedgEntry.FINDFIRST THEN BEGIN
                    DetailedVendorLedgEntry.RESET;
                    DetailedVendorLedgEntry.SETCURRENTKEY("Document No.");
                    DetailedVendorLedgEntry.SETRANGE("Document No.", VendorLedgEntry."Document No.");
                    DetailedVendorLedgEntry.SETFILTER("Entry Type", '%1', DetailedVendorLedgEntry."Entry Type"::Application);
                    DetailedVendorLedgEntry.SETFILTER("Document Type", '%1', DetailedVendorLedgEntry."Document Type"::Invoice);
                    DetailedVendorLedgEntry.SETFILTER("Vendor Ledger Entry No.", '<>%1', VendorLedgEntry."Entry No.");
                    IF DetailedVendorLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            VendorLedgEntry1.GET(DetailedVendorLedgEntry."Vendor Ledger Entry No.");
                            IF RcptNo <> '' THEN
                                RcptNo += ', ' + VendorLedgEntry1."Document No."
                            ELSE
                                RcptNo := VendorLedgEntry1."Document No.";

                            IF RcptDate <> '' THEN
                                RcptDate += ', ' + FORMAT(VendorLedgEntry1."Posting Date")
                            ELSE
                                RcptDate := FORMAT(VendorLedgEntry1."Posting Date");
                        UNTIL DetailedVendorLedgEntry.NEXT = 0;
                    END;

                    DetailedVendorLedgEntry.RESET;
                    DetailedVendorLedgEntry.SETCURRENTKEY("Vendor Ledger Entry No.");
                    DetailedVendorLedgEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedgEntry."Entry No.");
                    DetailedVendorLedgEntry.SETFILTER("Entry Type", '%1', DetailedVendorLedgEntry."Entry Type"::Application);
                    DetailedVendorLedgEntry.SETFILTER("Initial Document Type", '%1', DetailedVendorLedgEntry."Initial Document Type"::Invoice);
                    IF DetailedVendorLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            IF DetailedVendorLedgEntry."Document No." <> "No." THEN BEGIN
                                VendorLedgEntry1.RESET;
                                VendorLedgEntry1.SETRANGE("Document No.", DetailedVendorLedgEntry."Document No.");
                                IF VendorLedgEntry1.FINDFIRST THEN BEGIN
                                    IF RcptNo <> '' THEN
                                        RcptNo += ', ' + VendorLedgEntry1."Document No."
                                    ELSE
                                        RcptNo := VendorLedgEntry1."Document No.";

                                    IF RcptDate <> '' THEN
                                        RcptDate += ', ' + FORMAT(VendorLedgEntry1."Posting Date")
                                    ELSE
                                        RcptDate := FORMAT(VendorLedgEntry1."Posting Date");
                                END;
                            END;
                        UNTIL DetailedVendorLedgEntry.NEXT = 0;
                    END;

                END;

                TempRcptNo := RcptNo;
                TempRcptDate := RcptDate;

                RcptNo := COPYSTR(TempRcptNo, 1, 250);
                RcptDate := COPYSTR(TempRcptDate, 1, 250);
                RcptNo1 := COPYSTR(TempRcptNo, 251, 250);
                RcptDate1 := COPYSTR(TempRcptDate, 251, 250);


                OutStandingAmount := 0;
                OutStandingAmount := "Amount Including VAT" - (-PaidAmount);

                LineAmount := 0;
                ServiceTaxAmount := 0;
                TDSAmount := 0;
                GSTAmount := 0;
                PurchInvLine.RESET;
                PurchInvLine.SETRANGE("Document No.", "No.");
                IF PurchInvLine.FINDFIRST THEN BEGIN
                    REPEAT
                        LineAmount += PurchInvLine."Line Amount";
                        //ServiceTaxAmount += PurchInvLine."Service Tax Amount" + PurchInvLine."Service Tax eCess Amount" +
                        //PurchInvLine."Service Tax SHE Cess Amount" + PurchInvLine."Service Tax SBC Amount" + PurchInvLine."KK Cess Amount";
                        //TDSAmount += PurchInvLine."TDS Amount";
                        //GSTAmount += PurchInvLine."Total GST Amount";
                        IF PurchInvLine."GST Credit" = PurchInvLine."GST Credit"::"Non-Availment" THEN
                            GSTCredit := 'Non-Availment'
                        ELSE
                            GSTCredit := 'Availment';
                    UNTIL PurchInvLine.NEXT = 0
                END;

                CLEAR(ProjectInfo);
                CLEAR(EmployeeInfo);
                GetProject.RESET;
                GetProject.SETRANGE("Global Dimension 1 Code", "Shortcut Dimension 1 Code");
                GetProject.SETFILTER("Type Of Project", '%1', GetProject."Type Of Project"::"Main Project");
                IF GetProject.FINDFIRST THEN BEGIN
                    ProjectInfo[1] := GetProject."No.";
                    ProjectInfo[2] := GetProject."Project Name";
                    ProjectInfo[3] := GetProject."Project Name 2";
                    ProjectInfo[4] := FORMAT(GetProject."Creation Date");
                    ProjectInfo[5] := FORMAT(GetProject."Project Value");
                    ProjectInfo[6] := FORMAT(GetProject."Starting Date");
                    ProjectInfo[7] := FORMAT(GetProject."Ending Date");
                    IF GetProject."Project Manager" <> '' THEN BEGIN
                        GetEmployee.GET(GetProject."Project Manager");
                        EmployeeInfo[1] := GetEmployee."No.";
                        EmployeeInfo[2] := GetEmployee."First Name" + ' ' + GetEmployee."Middle Name" + ' ' + GetEmployee."Last Name";
                    END;
                END;

                IF IsPrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(EmployeeInfo[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(EmployeeInfo[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ProjectInfo[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ProjectInfo[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ProjectInfo[3], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ProjectInfo[4], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ProjectInfo[5], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ProjectInfo[6], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ProjectInfo[7], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn("Buy-from Vendor No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Buy-from Vendor Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn("Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);   //Manish
                    ExcelBuf.AddColumn(LineAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ServiceTaxAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(GSTCredit, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(GSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(-TDSAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(LineAmount + ServiceTaxAmount + GSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(OutStandingAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(RcptNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(RcptDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(RcptNo1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(RcptDate1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(PaidAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn("Shortcut Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(GetGLAccountName(GetItemACNo("Purch. Inv. Header"."No.")), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    TotalAmount[1] += LineAmount;
                    TotalAmount[2] += ServiceTaxAmount;
                    TotalAmount[3] += OutStandingAmount;
                    TotalAmount[4] += PaidAmount;
                    TotalAmount[5] += LineAmount + ServiceTaxAmount + GSTAmount;
                    TotalAmount[6] += TDSAmount;
                    TotalAmount[7] += GSTAmount;
                END;

                //MESSAGE('%1',GetGLAccountName(GetItemAcName("Purch. Inv. Header"."No.")));
            end;

            trigger OnPostDataItem()
            begin
                IF IsPrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
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
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TotalAmount[1], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalAmount[2], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalAmount[7], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(-TotalAmount[6], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalAmount[5], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalAmount[3], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TotalAmount[4], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);

                IF IsPrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ManagerCodeCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ManagerNameCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ProjectCodeCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ProjectNameCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ProjectName2Cap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ProjectInitatedDateCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ProjectValueCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ProjectStartDateCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ProjectEndDateCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(CustomerCodeCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(CustomerNameCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(InvoiceNoCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(InvoiceDateCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(InvoiceAmountCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ServiceTaxAmountCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(GSTCreditCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(GSTAmountCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TDSAmountCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(InvoiceAmountIncCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(OutStandingAmountCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ReceiptNoCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ReceiptDateCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ReceiptNoCap1, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ReceiptDateCap1, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ReceiptAmountCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(CostCenterCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(NatureofExpCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.NewRow;
                END;
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
                field("Project Manager Code"; ManagerCode)
                {
                    TableRelation = Employee."No.";
                    Visible = false;
                }
                field("Start Date"; StartDate)
                {

                    trigger OnValidate()
                    begin
                        IF EndDate <> 0D THEN
                            IF StartDate > EndDate THEN
                                ERROR(Text13703);
                    end;
                }
                field("End Date"; EndDate)
                {

                    trigger OnValidate()
                    begin
                        IF StartDate <> 0D THEN
                            IF StartDate > EndDate THEN
                                ERROR(Text13700);
                    end;
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
        IF IsPrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        IF (StartDate = 0D) OR (EndDate = 0D) THEN
            ERROR('Date must not be blank');

        GetCompanyInfo.GET;
        GetCompanyInfo.CALCFIELDS(Picture);

        IsPrintToExcel := TRUE;
        ReportFilters := "Purch. Inv. Header".GETFILTERS;
        ExcelBuf.DELETEALL;
        IF IsPrintToExcel THEN
            MakeExcelInfo;
    end;

    var
        SNoCap: Label 'S. No.';
        ManagerCodeCap: Label 'Employee Code';
        ManagerNameCap: Label 'Employee Name';
        ProjectCodeCap: Label 'Project Code';
        ProjectNameCap: Label 'Project Name';
        ProjectName2Cap: Label 'Project Name 2';
        CustomerCodeCap: Label 'Vendor Code';
        CustomerNameCap: Label 'Vendor Name';
        InvoiceNoCap: Label 'Invoice No.';
        InvoiceDateCap: Label 'Invoice Date';
        InvoiceAmountCap: Label 'Invoice Amount (Exc. Taxes)';
        GetCompanyInfo: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        ManagerCode: Code[20];
        InvoiceDetailCap: Label 'Outstanding Summary';
        DateFilterCap: Label 'Date Filters';
        TotalCap: Label 'Total';
        GetEmployee: Record Employee;
        Text13700: Label 'End Date cannot be before Start Date.';
        Text13703: Label 'Start Date cannot be after End Date.';
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        VendorLedgEntry: Record "Vendor Ledger Entry";
        PaidAmount: Decimal;
        OutStandingAmount: Decimal;
        LineAmount: Decimal;
        PurchInvLine: Record "Purch. Inv. Line";
        OutstdPercentage: Decimal;
        OutStandingAmountCap: Label 'Outstanding Amount';
        OutStandingPerCap: Label 'OutStanding % of Basic Amt';
        ServiceTaxAmountCap: Label 'Service Tax Amount';
        ReceiptAmountCap: Label 'Paid Amount';
        ReceiptDateCap: Label 'Payment Date';
        ReceiptDateCap1: Label 'Payment Date 2';
        ProjectStartDateCap: Label 'Project Start Date';
        ProjectEndDateCap: Label 'Project End Date';
        ProjectInitatedDateCap: Label 'Project Initiated On';
        ProjectValueCap: Label 'Project Value';
        IsPrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        ReportFilters: Text;
        ServiceTaxAmount: Decimal;
        ReceiptNoCap: Label 'Receipt No.';
        RcptNo: Text;
        RcptDate: Text;
        TotalAmount: array[7] of Decimal;
        VendorLedgEntry1: Record "Vendor Ledger Entry";
        GetProject: Record Job;
        ProjectInfo: array[10] of Text;
        EmployeeInfo: array[2] of Text;
        ReceiptNoCap1: Label 'Receipt No. 2';
        InvoiceAmountIncCap: Label 'Invoice Amount (Inc. Taxes)';
        CostCenterCap: Label 'Cost Center';
        TDSAmountCap: Label 'TDS Amount';
        TDSAmount: Decimal;
        TempRcptNo: Text;
        TempRcptDate: Text;
        RcptNo1: Text;
        RcptDate1: Text;
        GSTAmountCap: Label 'GST Amount';
        GSTAmount: Decimal;
        GSTCredit: Text;
        GSTCreditCap: Label 'GST Credit';
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        GLAccount: Record "G/L Account";
        GenPostingSetup: Record "General Posting Setup";
        NatureofExpCap: Label 'Nature of Expenses';
        FADepBook: Record "FA Depreciation Book";
        FAPostingGrp: Record "FA Posting Group";
        FAAccount: Code[50];
        ExcelFileName: Label 'PurchaseDetail_%1_%2';

    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook('Purchase Detail');
        ExcelBuf.WriteSheet('Purchase Detail', COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
        //ExcelBuf.CreateBookAndOpenExcel('Purchase Detail', 'Purchase Detail', COMPANYNAME, USERID);
    end;


    procedure MakeExcelInfo()
    begin
        ExcelBuf.AddColumn(COMPANYNAME, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Purchase Detail', FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Purchase Detail:' + ReportFilters, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Printing DateTime:' + FORMAT(CURRENTDATETIME), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
    end;

    procedure GetItemACNo(DocNo: Code[50]) GLAccount: Text
    var
        PurchInvLine: Record "Purch. Inv. Line";
        FixedAsset: Record "Fixed Asset";
    begin
        PurchInvLine.RESET;
        PurchInvLine.SETRANGE("Document No.", DocNo);
        PurchInvLine.SETFILTER("No.", '<>%1', '431030');
        IF PurchInvLine.FINDFIRST THEN BEGIN
            REPEAT
                IF PurchInvLine.Type = PurchInvLine.Type::Item THEN BEGIN
                    IF GenPostingSetup.GET(PurchInvLine."Gen. Bus. Posting Group", PurchInvLine."Gen. Prod. Posting Group") THEN BEGIN
                        GLAccount := GenPostingSetup."Purch. Account";
                    END;
                END;

                IF PurchInvLine.Type = PurchInvLine.Type::"G/L Account" THEN BEGIN
                    GLAccount := PurchInvLine."No.";
                END;

                IF PurchInvLine.Type = PurchInvLine.Type::"Fixed Asset" THEN BEGIN
                    FADepBook.RESET;
                    FADepBook.SETRANGE("FA No.", PurchInvLine."No.");
                    IF FADepBook.FINDFIRST THEN BEGIN
                        IF FAPostingGrp.GET(FADepBook."FA Posting Group") THEN
                            GLAccount := FAPostingGrp."Acquisition Cost Account";
                    END;
                END;
            UNTIL PurchInvLine.NEXT = 0;
        END;
        EXIT(GLAccount);
    end;

    procedure GetGLAccountName(GLCode: Code[50]) GLAccountName: Text
    var
        GLAccount: Record "G/L Account";
    begin
        IF GLAccount.GET(GLCode) THEN BEGIN
            GLAccountName := GLAccount.Name;
        END;
        EXIT(GLAccountName);
    end;
}

