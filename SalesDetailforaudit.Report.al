report 50101 "Sales Detail (for audit)"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            CalcFields = "Amount Including VAT";
            DataItemTableView = SORTING("No.");
            //WHERE("Type Of Note" = FILTER(' '));
            RequestFilterFields = "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code";

            trigger OnAfterGetRecord()
            begin
                PaidAmount := 0;
                RcptNo := '';
                RcptDate := '';
                //Condition 1
                CustLedgEntry.RESET;
                CustLedgEntry.SETRANGE("Document No.", "No.");
                IF CustLedgEntry.FINDFIRST THEN BEGIN
                    DetailedCustLedgEntry.RESET;
                    DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
                    DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                    DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
                    DetailedCustLedgEntry.SETFILTER("Initial Document Type", '%1', DetailedCustLedgEntry."Initial Document Type"::Invoice);
                    IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            PaidAmount += -(DetailedCustLedgEntry."Amount (LCY)");
                        UNTIL DetailedCustLedgEntry.NEXT = 0;
                    END;
                END;
                //Condition 1

                //Condition 2
                CustLedgEntry.RESET;
                CustLedgEntry.SETRANGE("Document No.", "No.");
                IF CustLedgEntry.FINDFIRST THEN BEGIN
                    DetailedCustLedgEntry.RESET;
                    DetailedCustLedgEntry.SETCURRENTKEY("Document No.");
                    DetailedCustLedgEntry.SETRANGE("Document No.", CustLedgEntry."Document No.");
                    DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
                    DetailedCustLedgEntry.SETFILTER("Document Type", '%1', DetailedCustLedgEntry."Document Type"::Invoice);
                    IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            PaidAmount += (DetailedCustLedgEntry."Amount (LCY)");
                        UNTIL DetailedCustLedgEntry.NEXT = 0;
                    END;
                END;
                //Condition 2
                //Condition 1
                CustLedgEntry.RESET;
                CustLedgEntry.SETRANGE("Document No.", "No.");
                IF CustLedgEntry.FINDFIRST THEN BEGIN
                    DetailedCustLedgEntry.RESET;
                    DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
                    DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                    DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
                    DetailedCustLedgEntry.SETFILTER("Initial Document Type", '%1', DetailedCustLedgEntry."Initial Document Type"::Invoice);
                    IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            IF DetailedCustLedgEntry."Document No." <> "No." THEN BEGIN
                                CustLedgEntry1.RESET;
                                CustLedgEntry1.SETRANGE("Document No.", DetailedCustLedgEntry."Document No.");
                                IF CustLedgEntry1.FINDFIRST THEN BEGIN
                                    IF RcptNo <> '' THEN
                                        RcptNo += ', ' + CustLedgEntry1."Document No."
                                    ELSE
                                        RcptNo := CustLedgEntry1."Document No.";

                                    IF RcptDate <> '' THEN
                                        RcptDate += ', ' + FORMAT(CustLedgEntry1."Posting Date")
                                    ELSE
                                        RcptDate := FORMAT(CustLedgEntry1."Posting Date");
                                END;
                            END;
                        UNTIL DetailedCustLedgEntry.NEXT = 0;
                    END;
                END;
                //Condition 1
                //Condition 2
                CustLedgEntry.RESET;
                CustLedgEntry.SETRANGE("Document No.", "No.");
                IF CustLedgEntry.FINDFIRST THEN BEGIN
                    DetailedCustLedgEntry.RESET;
                    DetailedCustLedgEntry.SETCURRENTKEY("Document No.");
                    DetailedCustLedgEntry.SETRANGE("Document No.", CustLedgEntry."Document No.");
                    DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
                    DetailedCustLedgEntry.SETFILTER("Document Type", '%1', DetailedCustLedgEntry."Document Type"::Invoice);
                    DetailedCustLedgEntry.SETFILTER("Cust. Ledger Entry No.", '<>%1', CustLedgEntry."Entry No.");
                    IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                        REPEAT
                            CustLedgEntry1.GET(DetailedCustLedgEntry."Cust. Ledger Entry No.");
                            IF RcptNo <> '' THEN
                                RcptNo += ', ' + CustLedgEntry1."Document No."
                            ELSE
                                RcptNo := CustLedgEntry1."Document No.";

                            IF RcptDate <> '' THEN
                                RcptDate += ', ' + FORMAT(CustLedgEntry1."Posting Date")
                            ELSE
                                RcptDate := FORMAT(CustLedgEntry1."Posting Date");
                        UNTIL DetailedCustLedgEntry.NEXT = 0;
                    END;
                END;
                //Condition 2

                TempRcptNo := RcptNo;
                TempRcptDate := RcptDate;

                RcptNo := COPYSTR(TempRcptNo, 1, 250);
                RcptDate := COPYSTR(TempRcptDate, 1, 250);
                RcptNo1 := COPYSTR(TempRcptNo, 251, 250);
                RcptDate1 := COPYSTR(TempRcptDate, 251, 250);


                OutStandingAmount := 0;
                IF PaidAmount < 0 THEN
                    OutStandingAmount := "Amount Including VAT" - (-PaidAmount)
                ELSE
                    OutStandingAmount := "Amount Including VAT";

                IF PaidAmount > 0 THEN
                    OutStandingAmount := "Amount Including VAT" - (PaidAmount)
                ELSE
                    OutStandingAmount := "Amount Including VAT";

                LineAmount := 0;
                ServiceTaxAmount := 0;
                Counter := 0;
                GSTAmount := 0;
                MilesTone := '';
                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.", "No.");
                IF SalesInvLine.FINDFIRST THEN BEGIN
                    REPEAT
                        LineAmount += SalesInvLine."Line Amount";
                        // ServiceTaxAmount += SalesInvLine."Service Tax Amount" + SalesInvLine."Service Tax eCess Amount" +
                        // SalesInvLine."Service Tax SHE Cess Amount" + SalesInvLine."Service Tax SBC Amount" + SalesInvLine."KK Cess Amount";
                        //GSTAmount += SalesInvLine."Total GST Amount";
                        Counter += 1;
                        IF Counter = 1 THEN
                            MilesTone := SalesInvLine.Milestone
                        ELSE
                            MilesTone += '|' + SalesInvLine.Milestone
                    UNTIL SalesInvLine.NEXT = 0
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
                    ProjectInfo[8] := FORMAT(GetProject."Project Status");
                    ProjectInfo[9] := FORMAT(GetProject."Temporary Status");
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
                    ExcelBuf.AddColumn(ProjectInfo[8], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ProjectInfo[9], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sell-to Customer No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("Sell-to Customer Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn("No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn("Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                    ExcelBuf.AddColumn(LineAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ServiceTaxAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(GSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(LineAmount + ServiceTaxAmount + GSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(OutStandingAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(RcptNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(RcptDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(RcptNo1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(RcptDate1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(PaidAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn("Shortcut Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(COPYSTR(MilesTone, 1, 249), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    TotalAmount[1] += LineAmount;
                    TotalAmount[2] += ServiceTaxAmount;
                    TotalAmount[3] += OutStandingAmount;
                    TotalAmount[4] += PaidAmount;
                    TotalAmount[5] += LineAmount + ServiceTaxAmount + GSTAmount;
                    TotalAmount[6] += GSTAmount;
                END;
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
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TotalAmount[1], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalAmount[2], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalAmount[6], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalAmount[5], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalAmount[3], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TotalAmount[4], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
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
                    ExcelBuf.AddColumn(ProjectSatusCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TempProjectSatusCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(CustomerCodeCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(CustomerNameCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(InvoiceNoCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(InvoiceDateCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(InvoiceAmountCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ServiceTaxAmountCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(GSTAmountCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(InvoiceAmountIncCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(OutStandingAmountCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ReceiptNoCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ReceiptDateCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ReceiptNoCap1, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ReceiptDateCap1, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ReceiptAmountCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(CostCenterCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(MilesStoneCap, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
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
        ReportFilters := "Sales Invoice Header".GETFILTERS;
        ExcelBuf.DELETEALL;
        IF IsPrintToExcel THEN
            MakeExcelInfo;
    end;

    var
        ExcelFileName: Label 'SalesDetail_%1_%2';
        SNoCap: Label 'S. No.';
        ManagerCodeCap: Label 'Employee Code';
        ManagerNameCap: Label 'Employee Name';
        ProjectCodeCap: Label 'Project Code';
        ProjectNameCap: Label 'Project Name';
        ProjectName2Cap: Label 'Project Name 2';
        CustomerCodeCap: Label 'Customer Code';
        CustomerNameCap: Label 'Customer Name';
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
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        PaidAmount: Decimal;
        OutStandingAmount: Decimal;
        LineAmount: Decimal;
        SalesInvLine: Record "Sales Invoice Line";
        OutstdPercentage: Decimal;
        OutStandingAmountCap: Label 'Outstanding Amount';
        OutStandingPerCap: Label 'OutStanding % of Basic Amt';
        ServiceTaxAmountCap: Label 'Service Tax Amount';
        GSTAmountCap: Label 'GST Amount';
        ReceiptAmountCap: Label 'Receipt Amount';
        ReceiptDateCap: Label 'Receipt Date';
        ReceiptNoCap1: Label 'Receipt No 2';
        ReceiptDateCap1: Label 'Receipt Date 2';
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
        TotalAmount: array[10] of Decimal;
        CustLedgEntry1: Record "Cust. Ledger Entry";
        GetProject: Record Job;
        ProjectInfo: array[10] of Text;
        EmployeeInfo: array[2] of Text;
        InvoiceAmountIncCap: Label 'Invoice Amount (Inc. Taxes)';
        CostCenterCap: Label 'Cost Center';
        TempRcptNo: Text;
        TempRcptDate: Text;
        RcptNo1: Text;
        RcptDate1: Text;
        GSTAmount: Decimal;
        MilesTone: Text[1024];
        Counter: Integer;
        MilesStoneCap: Label 'Milestone';
        ProjectSatusCap: Label 'Project Status';
        TempProjectSatusCap: Label 'Temporary Project Status';


    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel('Sales Detail', 'Sales Detail', COMPANYNAME, USERID);
        ExcelBuf.CreateNewBook('Sales Detail');
        ExcelBuf.WriteSheet('Sales Detail', COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
    end;


    procedure MakeExcelInfo()
    begin
        ExcelBuf.AddColumn(COMPANYNAME, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Sales Detail', FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Sales Detail:' + ReportFilters, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Printing DateTime:' + FORMAT(CURRENTDATETIME), FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
    end;
}

