report 50135 "Client Detail with project"
{
    Permissions = TableData 370 = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            dataitem(Job; Job)
            {
                DataItemLink = "Bill-to Customer No." = FIELD("No.");
                DataItemTableView = SORTING("No.")
                                    WHERE("Type Of Project" = FILTER('Main Project'));
                RequestFilterFields = "No.";
                dataitem("Job Task"; "Job Task")
                {
                    DataItemLink = "Job No." = FIELD("No.");
                    DataItemTableView = SORTING("Job No.", "Job Task No.");

                    trigger OnAfterGetRecord()
                    begin

                        SalesInvoiceAmount := 0;
                        SalesInvoiceNo := '';
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE("Shortcut Dimension 1 Code", Job."Global Dimension 1 Code");
                        SalesInvoiceLine.SETRANGE(Milestone, Milestone);
                        //SalesInvoiceLine.SETfilter("Posting Date",'%1..%2',StartDate,EndDate);
                        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                            REPEAT
                                IF SalesInvoiceNo <> '' THEN
                                    //IF STRLEN(SalesInvoiceNo) <= 250 THEN
                                    SalesInvoiceNo += ', ' + SalesInvoiceLine."Document No."
                                ELSE
                                    SalesInvoiceNo := SalesInvoiceLine."Document No.";
                                SalesInvoiceAmount += SalesInvoiceLine.Amount;
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        END;
                        MakeDataFirstCond;
                    end;
                }
                dataitem("Sales Invoice Header"; "Sales Invoice Header")
                {
                    CalcFields = Amount;
                    DataItemLink = "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code");

                    trigger OnAfterGetRecord()
                    begin
                        CALCFIELDS(Amount);
                        CALCFIELDS("Remaining Amount");
                        MakeDataSecondCond;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    IF ManagerCode <> '' THEN
                        SETRANGE("Project Manager", ManagerCode);
                end;
            }

            trigger OnPreDataItem()
            begin
                GetEmployee.GET(USERID);
                IF ManagerCode = '' THEN BEGIN
                    IF (GetEmployee."Project Manager") AND (GetEmployee."TL Report" = FALSE) THEN
                        ManagerCode := GetEmployee."No.";
                END;
            end;
        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                MakeHeader;
                TempProjectNo := '';
                TempCashFlowBuffer.RESET;
                TempCashFlowBuffer.SETCURRENTKEY("Code 2");
                TempCashFlowBuffer.SETFILTER("Code 1", '%1', 'First');
                IF TempCashFlowBuffer.FINDSET THEN BEGIN
                    REPEAT
                        IntCounter := 0;
                        IF TempProjectNo <> TempCashFlowBuffer."Code 3" THEN BEGIN
                            TempCashFlowBuffer1.RESET;
                            TempCashFlowBuffer1.SETRANGE("Code 3", TempCashFlowBuffer."Code 3");
                            TempCashFlowBuffer1.SETFILTER("Code 1", '%1', 'First');
                            IF TempCashFlowBuffer1.FINDSET THEN BEGIN
                                REPEAT
                                    MakeBody;
                                UNTIL TempCashFlowBuffer1.NEXT = 0;
                                TempCashFlowBuffer2.RESET;
                                TempCashFlowBuffer2.SETRANGE("Code 3", TempCashFlowBuffer1."Code 3");
                                TempCashFlowBuffer2.SETFILTER("Code 1", '%1', 'Second');
                                IF TempCashFlowBuffer2.FINDSET THEN BEGIN
                                    RowSecondCounter := 0;
                                    ExcelBuf1.RESET;
                                    ExcelBuf1.SETRANGE("Cell Value as Text", TempCashFlowBuffer2."Code 3");
                                    IF ExcelBuf1.FINDFIRST THEN
                                        RowSecondCounter := ExcelBuf1."Row No." - 1;
                                    REPEAT
                                        MakeSecondBody;
                                    UNTIL TempCashFlowBuffer2.NEXT = 0;
                                END;
                            END;
                        END;
                        TempProjectNo := TempCashFlowBuffer."Code 3";
                    UNTIL TempCashFlowBuffer.NEXT = 0;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Project Manager Code"; ManagerCode)
                    {
                        TableRelation = Employee."No." WHERE("Project Manager for Cash Flow" = CONST(true));

                        trigger OnValidate()
                        begin
                            GetEmployee.GET(USERID);
                            IF NOT GetEmployee."TL Report" THEN
                                ERROR('You are not authorized for using this filter');
                        end;
                    }
                    field("Start Date"; StartDate)
                    {
                        Visible = false;

                        trigger OnValidate()
                        begin
                            IF EndDate <> 0D THEN
                                IF StartDate > EndDate THEN
                                    ERROR(Text13703);
                        end;
                    }
                    field("End Date"; EndDate)
                    {
                        Visible = false;

                        trigger OnValidate()
                        begin
                            IF StartDate <> 0D THEN
                                IF StartDate > EndDate THEN
                                    ERROR(Text13700);
                        end;
                    }
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
        TempCashFlowBuffer.DELETEALL;
    end;

    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceNo: Text;
        SalesInvoiceAmount: Decimal;
        ExcelBuf: Record "Excel Buffer";
        RcptDocumentNo: Text;
        CustLedgEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        PaidAmount: Decimal;
        Counter: Integer;
        CustLedgEntry1: Record "Cust. Ledger Entry";
        AdjAmount: Decimal;
        AdjDocumentNo: Text;
        ManagerCode: Code[20];
        StartDate: Date;
        EndDate: Date;
        GetEmployee: Record Employee;
        Text13700: Label 'End Date cannot be before Start Date.';
        Text13703: Label 'Start Date cannot be after End Date.';
        SalesInvoiceHeader: Record "Sales Invoice Header";
        TempCashFlowBuffer: Record "Report Buffer";
        EntryNo: Integer;
        RowCounter: Integer;
        RowSecondCounter: Integer;
        SetCellType: Option Number,Text;
        TempCashFlowBuffer1: Record "Report Buffer";
        TempCashFlowBuffer2: Record "Report Buffer";
        ExcelBuf1: Record "Excel Buffer";
        TempProjectNo: Code[20];
        IntCounter: Integer;
        RowCounterPlus: Integer;
        ExcelFileName: Label 'ClientDetailwithProject_%1_%2';

    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook('Client Detail with project');
        ExcelBuf.WriteSheet('Client Detail with project', COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();

        //ExcelBuf.CreateBookAndOpenExcel('Client Detail with project', 'Client Detail with project', COMPANYNAME, USERID);
    end;

    procedure MakeHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Client No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Client Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Projects No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Project Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Milestone', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Milestone Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total Invoice No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total Invoice Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('Receipt No.',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Received Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('Adjustment No.',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Adjustment Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Outstanding Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        RowCounter := 1;
    end;

    procedure MakeBody()
    begin
        IntCounter += 1;
        IF IntCounter = 1 THEN BEGIN
            IF RowSecondCounter > RowCounter THEN
                RowCounterPlus := RowSecondCounter - RowCounter
            ELSE
                RowCounterPlus := 0;
        END;
        IF IntCounter = 1 THEN
            RowCounter += 1 + RowCounterPlus
        ELSE
            RowCounter += 1;

        ExcelInsertDataMannual(RowCounter, 1, TempCashFlowBuffer1."Code 2", FALSE, FALSE, SetCellType::Text);
        ExcelInsertDataMannual(RowCounter, 2, TempCashFlowBuffer1."Text 1", FALSE, FALSE, SetCellType::Text);
        ExcelInsertDataMannual(RowCounter, 3, TempCashFlowBuffer1."Code 3", FALSE, FALSE, SetCellType::Text);
        ExcelInsertDataMannual(RowCounter, 4, TempCashFlowBuffer1."Text 2", FALSE, FALSE, SetCellType::Text);
        ExcelInsertDataMannual(RowCounter, 5, TempCashFlowBuffer1."Code 4", FALSE, FALSE, SetCellType::Text);
        ExcelInsertDataMannual(RowCounter, 6, FORMAT(TempCashFlowBuffer1."Decimal 1"), FALSE, FALSE, SetCellType::Number);
        ExcelInsertDataMannual(RowCounter, 7, TempCashFlowBuffer1."Text 3", FALSE, FALSE, SetCellType::Text);
        ExcelInsertDataMannual(RowCounter, 8, FORMAT(TempCashFlowBuffer1."Decimal 2"), FALSE, FALSE, SetCellType::Number);
        ExcelInsertDataMannual(RowCounter, 9, '', FALSE, FALSE, SetCellType::Text);
    end;

    procedure MakeSecondBody()
    begin
        RowSecondCounter += 1;
        ExcelInsertDataMannual(RowSecondCounter, 10, TempCashFlowBuffer2."Code 5", FALSE, FALSE, SetCellType::Text);
        ExcelInsertDataMannual(RowSecondCounter, 11, FORMAT(TempCashFlowBuffer2."Decimal 2"), FALSE, FALSE, SetCellType::Number);
        //ExcelInsertDataMannual(RowSecondCounter,12,TempCashFlowBuffer2."Text 3",FALSE,FALSE,SetCellType::Text);
        ExcelInsertDataMannual(RowSecondCounter, 12, FORMAT(TempCashFlowBuffer2."Decimal 3"), FALSE, FALSE, SetCellType::Number);
        //ExcelInsertDataMannual(RowSecondCounter,14,TempCashFlowBuffer2."Text 4",FALSE,FALSE,SetCellType::Number);
        ExcelInsertDataMannual(RowSecondCounter, 13, FORMAT(TempCashFlowBuffer2."Decimal 4"), FALSE, FALSE, SetCellType::Number);
        ExcelInsertDataMannual(RowSecondCounter, 14, FORMAT(TempCashFlowBuffer2."Decimal 5"), FALSE, FALSE, SetCellType::Number);
    end;

    procedure MakeDataFirstCond()
    begin
        EntryNo += 1;
        TempCashFlowBuffer.INIT;
        TempCashFlowBuffer."Entry No." := EntryNo;
        TempCashFlowBuffer."Code 1" := 'First';
        TempCashFlowBuffer."Code 2" := Customer."No.";
        TempCashFlowBuffer."Text 1" := Customer.Name;
        TempCashFlowBuffer."Code 3" := Job."No.";
        TempCashFlowBuffer."Text 2" := Job."Project Name";
        TempCashFlowBuffer."Code 4" := "Job Task"."Job Task No.";
        TempCashFlowBuffer."Decimal 1" := "Job Task".Amount;
        TempCashFlowBuffer."Text 3" := SalesInvoiceNo;
        TempCashFlowBuffer."Decimal 2" := SalesInvoiceAmount;
        TempCashFlowBuffer.INSERT;
    end;

    procedure MakeDataSecondCond()
    begin
        PaidAmount := 0;
        RcptDocumentNo := '';
        AdjDocumentNo := '';
        AdjAmount := 0;

        CustLedgEntry.RESET;
        CustLedgEntry.SETRANGE("Document No.", "Sales Invoice Header"."No.");
        IF CustLedgEntry.FINDFIRST THEN BEGIN
            DetailedCustLedgEntry.RESET;
            DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
            DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
            DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
            DetailedCustLedgEntry.SETFILTER("Initial Document Type", '%1', DetailedCustLedgEntry."Initial Document Type"::Invoice);
            IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                REPEAT
                    CustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
                    IF DetailedCustLedgEntry."Document No." <> CustLedgEntry."Document No." THEN BEGIN
                        Counter += 1;
                        CustLedgEntry1.RESET;
                        CustLedgEntry1.SETRANGE("Document No.", DetailedCustLedgEntry."Document No.");
                        CustLedgEntry1.SETFILTER("Source Code", '%1', 'BANKRCPTV');
                        IF CustLedgEntry1.FINDFIRST THEN BEGIN
                            PaidAmount += -(DetailedCustLedgEntry."Amount (LCY)");
                            IF RcptDocumentNo <> '' THEN
                                IF STRLEN(RcptDocumentNo) < 250 THEN
                                    RcptDocumentNo += ', ' + CustLedgEntry1."Document No."
                                ELSE
                                    RcptDocumentNo := CustLedgEntry1."Document No.";
                        END;
                        CustLedgEntry1.RESET;
                        CustLedgEntry1.SETRANGE("Document No.", DetailedCustLedgEntry."Document No.");
                        CustLedgEntry1.SETFILTER("Source Code", '<>%1', 'BANKRCPTV');
                        IF CustLedgEntry1.FINDFIRST THEN BEGIN
                            AdjAmount += -(DetailedCustLedgEntry."Amount (LCY)");
                            IF AdjDocumentNo <> '' THEN
                                IF STRLEN(AdjDocumentNo) < 250 THEN
                                    AdjDocumentNo += ', ' + CustLedgEntry1."Document No."
                                ELSE
                                    AdjDocumentNo := CustLedgEntry1."Document No.";
                        END;
                    END;
                UNTIL DetailedCustLedgEntry.NEXT = 0;
            END;
        END;

        CustLedgEntry.RESET;
        CustLedgEntry.SETRANGE("Document No.", "Sales Invoice Header"."No.");
        IF CustLedgEntry.FINDFIRST THEN BEGIN
            DetailedCustLedgEntry.RESET;
            DetailedCustLedgEntry.SETCURRENTKEY("Document No.");
            DetailedCustLedgEntry.SETRANGE("Document No.", CustLedgEntry."Document No.");
            DetailedCustLedgEntry.SETFILTER("Entry Type", '%1', DetailedCustLedgEntry."Entry Type"::Application);
            DetailedCustLedgEntry.SETFILTER("Document Type", '%1', DetailedCustLedgEntry."Document Type"::Invoice);
            DetailedCustLedgEntry.SETFILTER("Cust. Ledger Entry No.", '<>%1', CustLedgEntry."Entry No.");
            IF DetailedCustLedgEntry.FINDSET THEN BEGIN
                REPEAT
                    CustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
                    Counter += 1;
                    CustLedgEntry1.GET(DetailedCustLedgEntry."Cust. Ledger Entry No.");
                    IF CustLedgEntry1."Source Code" = 'BANKRCPTV' THEN BEGIN
                        PaidAmount += (DetailedCustLedgEntry."Amount (LCY)");
                        IF RcptDocumentNo <> '' THEN
                            IF STRLEN(RcptDocumentNo) < 250 THEN
                                RcptDocumentNo += ', ' + CustLedgEntry1."Document No."
                            ELSE
                                RcptDocumentNo := CustLedgEntry1."Document No.";
                    END ELSE BEGIN
                        IF AdjDocumentNo <> '' THEN
                            IF STRLEN(AdjDocumentNo) < 250 THEN
                                AdjDocumentNo += ', ' + CustLedgEntry1."Document No."
                            ELSE
                                AdjDocumentNo := CustLedgEntry1."Document No.";
                        AdjAmount += (DetailedCustLedgEntry."Amount (LCY)");
                    END;
                UNTIL DetailedCustLedgEntry.NEXT = 0;
            END;
        END;

        EntryNo += 1;
        TempCashFlowBuffer.INIT;
        TempCashFlowBuffer."Entry No." := EntryNo;
        TempCashFlowBuffer."Code 1" := 'Second';
        TempCashFlowBuffer."Code 2" := Customer."No.";
        TempCashFlowBuffer."Text 1" := Customer.Name;
        TempCashFlowBuffer."Code 3" := Job."No.";
        TempCashFlowBuffer."Text 2" := Job."Project Name";
        TempCashFlowBuffer."Code 4" := '';
        TempCashFlowBuffer."Decimal 1" := 0;
        TempCashFlowBuffer."Code 5" := "Sales Invoice Header"."No.";
        TempCashFlowBuffer."Decimal 2" := "Sales Invoice Header".Amount;
        TempCashFlowBuffer."Decimal 3" := PaidAmount;
        TempCashFlowBuffer."Decimal 4" := AdjAmount;
        TempCashFlowBuffer."Text 3" := RcptDocumentNo;
        TempCashFlowBuffer."Text 4" := AdjDocumentNo;
        TempCashFlowBuffer."Decimal 5" := "Sales Invoice Header"."Remaining Amount";
        TempCashFlowBuffer.INSERT;
    end;

    procedure ExcelInsertDataMannual(RowNo: Integer; ColNo: Integer; TextVal: Text[250]; IsBold: Boolean; IsUnderLine: Boolean; CellType: Option Number,Text)
    begin
        ExcelBuf.INIT;
        ExcelBuf.VALIDATE("Row No.", RowNo);
        ExcelBuf.VALIDATE("Column No.", ColNo);
        ExcelBuf."Cell Value as Text" := TextVal;
        ExcelBuf.Bold := IsBold;
        ExcelBuf.Underline := IsUnderLine;
        ExcelBuf."Cell Type" := CellType;
        ExcelBuf.INSERT;
    end;
}

