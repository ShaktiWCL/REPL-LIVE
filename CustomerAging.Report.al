report 50098 "Customer Aging"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CustomerAging.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Global Dimension 1 Filter", "Global Dimension 2 Filter", "Currency Filter";

            trigger OnAfterGetRecord()
            begin
                CalAging;
                IF (BalanceAmount = 0) AND (AgedValue[1] = 0) AND (AgedValue[2] = 0) AND (AgedValue[3] = 0)
                  AND (AgedValue[4] = 0) AND (AgedValue[5] = 0) AND (AgedValue[6] = 0) AND (AgedValue[7] = 0)
                  AND (UnAdjustedAmount = 0) AND (NetBalance = 0) THEN
                    CurrReport.SKIP;

                TempCashFlowBuffer.INIT;
                TempCashFlowBuffer."Entry No." += 1;
                TempCashFlowBuffer."Code 1" := "No.";
                TempCashFlowBuffer."Text 1" := Name;
                TempCashFlowBuffer."Code 2" := CurrencyCode;
                TempCashFlowBuffer."Decimal 1" := BalanceAmount;
                TempCashFlowBuffer."Decimal 2" := AgedValue[1];
                TempCashFlowBuffer."Decimal 3" := AgedValue[2];
                TempCashFlowBuffer."Decimal 4" := AgedValue[3];
                TempCashFlowBuffer."Decimal 5" := AgedValue[4];
                TempCashFlowBuffer."Decimal 6" := AgedValue[5];
                TempCashFlowBuffer."Decimal 7" := AgedValue[6];
                TempCashFlowBuffer."Decimal 8" := AgedValue[7];
                TempCashFlowBuffer."Decimal 9" := UnAdjustedAmount;
                TempCashFlowBuffer."Decimal 10" := NetBalance;
                TempCashFlowBuffer."Boolean 1" := IsColShow[1];
                TempCashFlowBuffer."Boolean 2" := IsColShow[2];
                TempCashFlowBuffer."Boolean 3" := IsColShow[3];
                TempCashFlowBuffer."Boolean 4" := IsColShow[4];
                TempCashFlowBuffer."Boolean 5" := IsColShow[5];
                TempCashFlowBuffer."Boolean 6" := IsColShow[6];
                TempCashFlowBuffer."Boolean 7" := IsColShow[7];
                IF TempCashFlowBuffer.INSERT THEN
                    Counter1 += 1;
            end;
        }
        dataitem(Integer; Integer)
        {
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Address; CompInfo.Address)
            {
            }
            column(CompInfo_Address_2; CompInfo."Address 2")
            {
            }
            column(CompInfo_City; CompInfo.City)
            {
            }
            column(CompInfo_State; '')
            {
            }
            column(AgedAccRece_Cap; AgedAccReceCap)
            {
            }
            column(AgedAsOf_Cap; AgedAsOfCap)
            {
            }
            column(CustomerNo_Cap; CustomerNoCap)
            {
            }
            column(CustomerName_Cap; CustomerNameCap)
            {
            }
            column(PostingDate_Cap; PostingDateCap)
            {
            }
            column(DocumentType_Cap; DocumentTypeCap)
            {
            }
            column(DocumentNo_Cap; DocumentNoCap)
            {
            }
            column(DueDate_Cap; DueDateCap)
            {
            }
            column(UnAdjustedAmount_Cap; UnAdjustedAmountCap)
            {
            }
            column(NetBalance_Cap; NetBalanceCap)
            {
            }
            column(Total_Cap; TotalCap)
            {
            }
            column(OriginalAmount_Cap; OriginalAmountCap)
            {
            }
            column(Balance_Cap; BalanceCap)
            {
            }
            column(CurrencyCode_Cap; CurrencyCodeCap)
            {
            }
            column(As_OnDate; FORMAT(EndingDate))
            {
            }
            column(Customer_No; TempCashFlowBuffer."Code 1")
            {
            }
            column(Customer_Name; TempCashFlowBuffer."Text 1")
            {
            }
            column(AgedDuration_1; AgedDuration[1])
            {
            }
            column(AgedDuration_2; AgedDuration[2])
            {
            }
            column(AgedDuration_3; AgedDuration[3])
            {
            }
            column(AgedDuration_4; AgedDuration[4])
            {
            }
            column(AgedDuration_5; AgedDuration[5])
            {
            }
            column(AgedDuration_6; AgedDuration[6])
            {
            }
            column(AgedDuration_7; AgedDuration[7])
            {
            }
            column(AgedDuration_8; AgedDuration[8])
            {
            }
            column(AgedDuration_9; AgedDuration[9])
            {
            }
            column(AgedDuration_10; AgedDuration[10])
            {
            }
            column(AgedDuration_11; AgedDuration[11])
            {
            }
            column(AgedDuration_12; AgedDuration[12])
            {
            }
            column(AgedDuration_14; AgedDuration[14])
            {
            }
            column(AgedCapPrint_1; AgedCapPrint[1])
            {
            }
            column(AgedCapPrint_2; AgedCapPrint[2])
            {
            }
            column(AgedCapPrint_3; AgedCapPrint[3])
            {
            }
            column(AgedCapPrint_4; AgedCapPrint[4])
            {
            }
            column(AgedCapPrint_5; AgedCapPrint[5])
            {
            }
            column(AgedCapPrint_6; AgedCapPrint[6])
            {
            }
            column(AgedCapPrint_7; AgedCapPrint[7])
            {
            }
            column(AgedValue_1; TempCashFlowBuffer."Decimal 2")
            {
            }
            column(AgedValue_2; TempCashFlowBuffer."Decimal 3")
            {
            }
            column(AgedValue_3; TempCashFlowBuffer."Decimal 4")
            {
            }
            column(AgedValue_4; TempCashFlowBuffer."Decimal 5")
            {
            }
            column(AgedValue_5; TempCashFlowBuffer."Decimal 6")
            {
            }
            column(AgedValue_6; TempCashFlowBuffer."Decimal 7")
            {
            }
            column(AgedValue_7; TempCashFlowBuffer."Decimal 8")
            {
            }
            column(UnAdjusted_Amount; TempCashFlowBuffer."Decimal 9")
            {
            }
            column(Net_Balance; TempCashFlowBuffer."Decimal 10")
            {
            }
            column(Balance_Amount; TempCashFlowBuffer."Decimal 1")
            {
            }
            column(Currency_Code; TempCashFlowBuffer."Code 2")
            {
            }
            column(IsColShow_1; IsColShow[1])
            {
            }
            column(IsColShow_2; IsColShow[2])
            {
            }
            column(IsColShow_3; IsColShow[3])
            {
            }
            column(IsColShow_4; IsColShow[4])
            {
            }
            column(IsColShow_5; IsColShow[5])
            {
            }
            column(IsColShow_6; IsColShow[6])
            {
            }
            column(IsColShow_7; IsColShow[7])
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number <> 1 THEN BEGIN
                    TempCashFlowBuffer.NEXT;
                END;

                IF PrintToExcel THEN BEGIN
                    Counter += 1;

                    IF Counter = 1 THEN BEGIN
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        IF IsColShow[1] THEN
                            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[2] THEN
                            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[3] THEN
                            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[4] THEN
                            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[5] THEN
                            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[6] THEN
                            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[7] THEN
                            ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('Customer No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('Currency Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('Balance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[1] THEN
                            ExcelBuf.AddColumn(DELCHR(AgedCapPrint[1], '=', '\'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[2] THEN
                            ExcelBuf.AddColumn(DELCHR(AgedCapPrint[2], '=', '\'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[3] THEN
                            ExcelBuf.AddColumn(DELCHR(AgedCapPrint[3], '=', '\'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[4] THEN
                            ExcelBuf.AddColumn(DELCHR(AgedCapPrint[4], '=', '\'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[5] THEN
                            ExcelBuf.AddColumn(DELCHR(AgedCapPrint[5], '=', '\'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[6] THEN
                            ExcelBuf.AddColumn(DELCHR(AgedCapPrint[6], '=', '\'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        IF IsColShow[7] THEN
                            ExcelBuf.AddColumn(AgedCapPrint[7], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('Unadjusted Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('Net Balance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    END;
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn(TempCashFlowBuffer."Code 1", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TempCashFlowBuffer."Text 1", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TempCashFlowBuffer."Code 2", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TempCashFlowBuffer."Decimal 1", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[1] THEN
                        ExcelBuf.AddColumn(TempCashFlowBuffer."Decimal 2", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[2] THEN
                        ExcelBuf.AddColumn(TempCashFlowBuffer."Decimal 3", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[3] THEN
                        ExcelBuf.AddColumn(TempCashFlowBuffer."Decimal 4", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[4] THEN
                        ExcelBuf.AddColumn(TempCashFlowBuffer."Decimal 5", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[5] THEN
                        ExcelBuf.AddColumn(TempCashFlowBuffer."Decimal 6", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[6] THEN
                        ExcelBuf.AddColumn(TempCashFlowBuffer."Decimal 7", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[7] THEN
                        ExcelBuf.AddColumn(TempCashFlowBuffer."Decimal 8", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    ExcelBuf.AddColumn(TempCashFlowBuffer."Decimal 9", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TempCashFlowBuffer."Decimal 10", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                END;
            end;

            trigger OnPostDataItem()
            begin
                IF PrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    IF IsColShow[1] THEN
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    IF IsColShow[2] THEN
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    IF IsColShow[3] THEN
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    IF IsColShow[4] THEN
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    IF IsColShow[5] THEN
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    IF IsColShow[6] THEN
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    IF IsColShow[7] THEN
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('Total', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TotalBalanceAmount, FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[1] THEN
                        ExcelBuf.AddColumn(TotalAgedValue[1], FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[2] THEN
                        ExcelBuf.AddColumn(TotalAgedValue[2], FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[3] THEN
                        ExcelBuf.AddColumn(TotalAgedValue[3], FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[4] THEN
                        ExcelBuf.AddColumn(TotalAgedValue[4], FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[5] THEN
                        ExcelBuf.AddColumn(TotalAgedValue[5], FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[6] THEN
                        ExcelBuf.AddColumn(TotalAgedValue[6], FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    IF IsColShow[7] THEN
                        ExcelBuf.AddColumn(TotalAgedValue[7], FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);

                    ExcelBuf.AddColumn(TotalUnAdjustedAmount, FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalNetBalance, FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                END;
            end;

            trigger OnPreDataItem()
            begin
                TempCashFlowBuffer.RESET;
                TempCashFlowBuffer.SETRANGE("Boolean 1", TRUE);
                IF TempCashFlowBuffer.FINDFIRST THEN
                    IsColShow[1] := TRUE;

                TempCashFlowBuffer.RESET;
                TempCashFlowBuffer.SETRANGE("Boolean 2", TRUE);
                IF TempCashFlowBuffer.FINDFIRST THEN
                    IsColShow[2] := TRUE;

                TempCashFlowBuffer.RESET;
                TempCashFlowBuffer.SETRANGE("Boolean 3", TRUE);
                IF TempCashFlowBuffer.FINDFIRST THEN
                    IsColShow[3] := TRUE;

                TempCashFlowBuffer.RESET;
                TempCashFlowBuffer.SETRANGE("Boolean 4", TRUE);
                IF TempCashFlowBuffer.FINDFIRST THEN
                    IsColShow[4] := TRUE;

                TempCashFlowBuffer.RESET;
                TempCashFlowBuffer.SETRANGE("Boolean 5", TRUE);
                IF TempCashFlowBuffer.FINDFIRST THEN
                    IsColShow[5] := TRUE;

                TempCashFlowBuffer.RESET;
                TempCashFlowBuffer.SETRANGE("Boolean 6", TRUE);
                IF TempCashFlowBuffer.FINDFIRST THEN
                    IsColShow[6] := TRUE;

                TempCashFlowBuffer.RESET;
                TempCashFlowBuffer.SETRANGE("Boolean 7", TRUE);
                IF TempCashFlowBuffer.FINDFIRST THEN
                    IsColShow[7] := TRUE;


                SETRANGE(Number, 1, Counter1);
                TempCashFlowBuffer.RESET;
                IF TempCashFlowBuffer.FINDFIRST THEN;
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
                group(Options)
                {
                    Caption = 'Options';
                    field(AgedAsOf; EndingDate)
                    {
                        Caption = 'Aged As Of';
                    }
                    field(HeadingType; HeadingType)
                    {
                        Caption = 'Heading Type';
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print To Excel';
                    }
                }
                group(A)
                {
                    grid("Aging Range")
                    {
                        Caption = 'Aging Range';
                        GridLayout = Rows;
                        group(AB)
                        {
                            field(AgedDuration1; AgedDuration[1])
                            {
                                //BlankZero = true;
                                Caption = 'First Range From';

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[2] <> 0 THEN
                                        IF AgedDuration[1] > AgedDuration[2] THEN
                                            ERROR(Text13700);
                                end;
                            }
                            field(AgedDuration2; AgedDuration[2])
                            {
                                //BlankZero = true;
                                Caption = 'First Range To';

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[1] <> 0 THEN
                                        IF AgedDuration[1] > AgedDuration[2] THEN
                                            ERROR(Text13700);

                                    IF AgedDuration[2] <> 0 THEN
                                        AgedDuration[3] := AgedDuration[2] + 1
                                    ELSE
                                        AgedDuration[3] := 0;
                                end;
                            }
                        }
                        group(AC)
                        {
                            field(AgedDuration3; AgedDuration[3])
                            {
                                //BlankZero = true;
                                Caption = 'Second Range From';
                                Editable = false;

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[4] <> 0 THEN
                                        IF AgedDuration[3] > AgedDuration[4] THEN
                                            ERROR(Text13700);
                                end;
                            }
                            field(AgedDuration4; AgedDuration[4])
                            {
                                //BlankZero = true;
                                Caption = 'Secong Range To';

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[3] <> 0 THEN
                                        IF AgedDuration[3] > AgedDuration[4] THEN
                                            ERROR(Text13700);

                                    IF AgedDuration[4] <> 0 THEN
                                        AgedDuration[5] := AgedDuration[4] + 1
                                    ELSE
                                        AgedDuration[5] := 0;
                                end;
                            }
                        }
                        group(AD)
                        {
                            field(AgedDuration5; AgedDuration[5])
                            {
                                //BlankZero = true;
                                Caption = 'Third Range From';
                                Editable = false;

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[6] <> 0 THEN
                                        IF AgedDuration[5] > AgedDuration[6] THEN
                                            ERROR(Text13700);
                                end;
                            }
                            field(AgedDuration6; AgedDuration[6])
                            {
                                //BlankZero = true;
                                Caption = 'Third Range To';

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[5] <> 0 THEN
                                        IF AgedDuration[5] > AgedDuration[6] THEN
                                            ERROR(Text13700);

                                    IF AgedDuration[6] <> 0 THEN
                                        AgedDuration[7] := AgedDuration[6] + 1
                                    ELSE
                                        AgedDuration[7] := 0;
                                end;
                            }
                        }
                        group(AE)
                        {
                            field(AgedDuration7; AgedDuration[7])
                            {
                                //BlankZero = true;
                                Caption = 'Fourth Range From';
                                Editable = false;

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[8] <> 0 THEN
                                        IF AgedDuration[7] > AgedDuration[8] THEN
                                            ERROR(Text13700);
                                end;
                            }
                            field(AgedDuration8; AgedDuration[8])
                            {
                                //BlankZero = true;
                                Caption = 'Fourth Range To';

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[7] <> 0 THEN
                                        IF AgedDuration[7] > AgedDuration[8] THEN
                                            ERROR(Text13700);

                                    IF AgedDuration[8] <> 0 THEN
                                        AgedDuration[9] := AgedDuration[8] + 1
                                    ELSE
                                        AgedDuration[9] := 0;
                                end;
                            }
                        }
                        group(AF)
                        {
                            field(AgedDuration9; AgedDuration[9])
                            {
                                //BlankZero = true;
                                Caption = 'Fifth Range From';
                                Editable = false;

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[10] <> 0 THEN
                                        IF AgedDuration[9] > AgedDuration[10] THEN
                                            ERROR(Text13700);
                                end;
                            }
                            field(AgedDuration10; AgedDuration[10])
                            {
                                //BlankZero = true;
                                Caption = 'Fifth Range To';

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[9] <> 0 THEN
                                        IF AgedDuration[9] > AgedDuration[10] THEN
                                            ERROR(Text13700);

                                    IF AgedDuration[10] <> 0 THEN
                                        AgedDuration[11] := AgedDuration[10] + 1
                                    ELSE
                                        AgedDuration[11] := 0;
                                end;
                            }
                        }
                        group(AG)
                        {
                            field(AgedDuration11; AgedDuration[11])
                            {
                                //BlankZero = true;
                                Caption = 'Sixth Range From';
                                Editable = false;

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[12] <> 0 THEN
                                        IF AgedDuration[11] > AgedDuration[12] THEN
                                            ERROR(Text13700);
                                end;
                            }
                            field(AgedDuration12; AgedDuration[12])
                            {
                                //BlankZero = true;
                                Caption = 'Sixth Range To';

                                trigger OnValidate()
                                begin
                                    IF AgedDuration[11] <> 0 THEN
                                        IF AgedDuration[11] > AgedDuration[12] THEN
                                            ERROR(Text13700);

                                    IF AgedDuration[12] <> 0 THEN
                                        AgedDuration[14] := AgedDuration[12] + 1
                                    ELSE
                                        AgedDuration[14] := 0;
                                end;
                            }
                        }
                        group(AH)
                        {
                            field(AgedDuration14; AgedDuration[14])
                            {
                                //BlankZero = true;
                                Caption = 'Seventh Range';
                                Editable = false;
                            }
                        }
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
        IF PrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
        CLEAR(IsColShow);
        CLEAR(AgedCapPrint);
        TempCashFlowBuffer.DELETEALL;
        ReportFilters := AgedAsOfCap + ': ' + FORMAT(EndingDate);
        Counter := 0;
        Counter1 := 0;
        IF CompInfo."New Name Date" <> 0D THEN BEGIN
            IF EndingDate >= CompInfo."New Name Date" THEN
                CompanyNameText := CompInfo.Name
            ELSE
                CompanyNameText := CompInfo."Old Name";
        END ELSE
            CompanyNameText := CompInfo.Name;

        IF PrintToExcel THEN
            MakeExcelInfo
    end;

    var
        CompInfo: Record "Company Information";
        ColCount: Integer;
        AgedAccReceCap: Label 'Aged Accounts Receivable';
        AgedAsOfCap: Label 'Aged As of';
        CustomerNoCap: Label 'Customer No.';
        PostingDateCap: Label 'Posting Date';
        DocumentTypeCap: Label 'Document Type';
        DocumentNoCap: Label 'Document No.';
        DueDateCap: Label 'Due Date';
        UnAdjustedAmountCap: Label 'Unadjusted Amount';
        NetBalanceCap: Label 'Net Balance';
        TotalCap: Label 'Total';
        StartingDate: Date;
        EndingDate: Date;
        AgedDuration: array[14] of Integer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CalDays: Integer;
        AgedValue: array[7] of Decimal;
        UnAdjustedAmount: Decimal;
        IsColShow: array[7] of Boolean;
        OriginalAmountCap: Label 'Original Amount';
        BalanceCap: Label 'Balance';
        AgedCapPrint: array[7] of Text;
        OriginalAmount: Decimal;
        BalanceAmount: Decimal;
        CustomerNameCap: Label 'Name';
        CurrencyCodeCap: Label 'Currency Code';
        NetBalance: Decimal;
        CurrencyCode: Code[10];
        Text13700: Label 'First Range To value cannot be less than First Range From value.';
        HeadingType: Option "Date Interval","Number of Days";
        ExcelBuf: Record "Excel Buffer" temporary;
        ReportFilters: Text;
        PrintToExcel: Boolean;
        Counter: Integer;
        TotalAgedValue: array[7] of Decimal;
        TotalBalanceAmount: Decimal;
        TotalNetBalance: Decimal;
        TotalUnAdjustedAmount: Decimal;
        TempCashFlowBuffer: Record "Cash Flow Buffer" temporary;
        Counter1: Integer;
        DetCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        RemaingValueCal: Decimal;
        CompanyNameText: Text;


    procedure CalAging()
    begin
        CLEAR(UnAdjustedAmount);
        CLEAR(OriginalAmount);
        CLEAR(BalanceAmount);
        CLEAR(NetBalance);
        CLEAR(CurrencyCode);
        CLEAR(AgedValue);

        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code");
        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
        IF Customer.GETFILTER("Global Dimension 1 Filter") <> '' THEN
            CustLedgerEntry.SETFILTER("Global Dimension 1 Code", Customer."Global Dimension 1 Filter");
        IF Customer.GETFILTER("Global Dimension 2 Filter") <> '' THEN
            CustLedgerEntry.SETFILTER("Global Dimension 2 Code", Customer."Global Dimension 2 Filter");
        CustLedgerEntry.SETFILTER("Posting Date", '..%1', EndingDate);
        IF Customer.GETFILTER("Currency Filter") <> '' THEN
            CustLedgerEntry.SETFILTER("Currency Code", Customer."Currency Filter");
        IF CustLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                CustLedgerEntry.CALCFIELDS("Amount (LCY)");
                CLEAR(RemaingValueCal);
                DetCustLedgEntry.RESET;
                DetCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                DetCustLedgEntry.SETFILTER("Posting Date", '..%1', EndingDate);
                IF DetCustLedgEntry.FINDSET THEN BEGIN
                    REPEAT
                        RemaingValueCal += DetCustLedgEntry."Amount (LCY)";
                    UNTIL DetCustLedgEntry.NEXT = 0;
                END;
                CalDays := EndingDate - CustLedgerEntry."Posting Date";
                IF RemaingValueCal > 0 THEN BEGIN
                    // Case---1
                    IF (AgedDuration[1] = 0) AND (AgedDuration[2] <> 0) THEN BEGIN
                        IF (CalDays <= AgedDuration[2]) THEN
                            AgedValue[1] += RemaingValueCal;

                        IsColShow[1] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[1] := FORMAT(AgedDuration[1]) + '-' + FORMAT(AgedDuration[2]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[1] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[2] + 1), FORMAT(EndingDate - AgedDuration[1] + 1));
                        END;
                    END;

                    IF (AgedDuration[1] <> 0) AND (AgedDuration[2] <> 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[1]) AND (CalDays <= AgedDuration[2]) THEN
                            AgedValue[1] += RemaingValueCal;

                        IsColShow[1] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[1] := FORMAT(AgedDuration[1]) + '-' + FORMAT(AgedDuration[2]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[1] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[2] + 1), FORMAT(EndingDate - AgedDuration[1] + 1));
                        END;
                    END;

                    IF (AgedDuration[1] <> 0) AND (AgedDuration[2] = 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[1]) THEN
                            AgedValue[1] += RemaingValueCal;

                        IsColShow[1] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[1] := '>' + FORMAT(AgedDuration[1] - 1);
                            HeadingType::"Date Interval":
                                AgedCapPrint[1] := '>' + FORMAT(EndingDate - (AgedDuration[1] - 1));
                        END;
                    END;
                    // Case---1

                    // Case---2
                    IF (AgedDuration[3] = 0) AND (AgedDuration[4] <> 0) THEN BEGIN
                        IF (CalDays <= AgedDuration[4]) THEN
                            AgedValue[2] += RemaingValueCal;

                        IsColShow[2] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[2] := FORMAT(AgedDuration[3]) + '-' + FORMAT(AgedDuration[4]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[2] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[4] + 1), FORMAT(EndingDate - AgedDuration[3] + 1));
                        END;
                    END;

                    IF (AgedDuration[3] <> 0) AND (AgedDuration[4] <> 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[3]) AND (CalDays <= AgedDuration[4]) THEN
                            AgedValue[2] += RemaingValueCal;

                        IsColShow[2] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[2] := FORMAT(AgedDuration[3]) + '-' + FORMAT(AgedDuration[4]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[2] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[4] + 1), FORMAT(EndingDate - AgedDuration[3] + 1));
                        END;
                    END;

                    IF (AgedDuration[3] <> 0) AND (AgedDuration[4] = 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[3]) THEN
                            AgedValue[2] += RemaingValueCal;

                        IsColShow[2] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[2] := '>' + FORMAT(AgedDuration[3] - 1);
                            HeadingType::"Date Interval":
                                AgedCapPrint[2] := '>' + FORMAT(EndingDate - (AgedDuration[3] - 1));
                        END;

                    END;
                    // Case---2

                    // Case---3
                    IF (AgedDuration[5] = 0) AND (AgedDuration[6] <> 0) THEN BEGIN
                        IF (CalDays <= AgedDuration[6]) THEN
                            AgedValue[3] += RemaingValueCal;

                        IsColShow[3] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[3] := FORMAT(AgedDuration[5]) + '-' + FORMAT(AgedDuration[6]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[3] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[6] + 1), FORMAT(EndingDate - AgedDuration[5] + 1));
                        END;
                    END;

                    IF (AgedDuration[5] <> 0) AND (AgedDuration[6] <> 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[5]) AND (CalDays <= AgedDuration[6]) THEN
                            AgedValue[3] += RemaingValueCal;

                        IsColShow[3] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[3] := FORMAT(AgedDuration[5]) + '-' + FORMAT(AgedDuration[6]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[3] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[6] + 1), FORMAT(EndingDate - AgedDuration[5] + 1));
                        END;
                    END;

                    IF (AgedDuration[5] <> 0) AND (AgedDuration[6] = 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[5]) THEN
                            AgedValue[3] += RemaingValueCal;

                        IsColShow[3] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[3] := '>' + FORMAT(AgedDuration[5] - 1);
                            HeadingType::"Date Interval":
                                AgedCapPrint[3] := '>' + FORMAT(EndingDate - (AgedDuration[5] - 1));
                        END;
                    END;
                    // Case---3

                    // Case---4
                    IF (AgedDuration[7] = 0) AND (AgedDuration[8] <> 0) THEN BEGIN
                        IF (CalDays <= AgedDuration[8]) THEN
                            AgedValue[4] += RemaingValueCal;

                        IsColShow[4] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[4] := FORMAT(AgedDuration[7]) + '-' + FORMAT(AgedDuration[8]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[4] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[8] + 1), FORMAT(EndingDate - AgedDuration[7] + 1));
                        END;
                    END;

                    IF (AgedDuration[7] <> 0) AND (AgedDuration[8] <> 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[7]) AND (CalDays <= AgedDuration[8]) THEN
                            AgedValue[4] += RemaingValueCal;

                        IsColShow[4] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[4] := FORMAT(AgedDuration[7]) + '-' + FORMAT(AgedDuration[8]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[4] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[8] + 1), FORMAT(EndingDate - AgedDuration[7] + 1));
                        END;
                    END;

                    IF (AgedDuration[7] <> 0) AND (AgedDuration[8] = 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[7]) THEN
                            AgedValue[4] += RemaingValueCal;

                        IsColShow[4] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[4] := '>' + FORMAT(AgedDuration[7] - 1);
                            HeadingType::"Date Interval":
                                AgedCapPrint[4] := '>' + FORMAT(EndingDate - (AgedDuration[7] - 1));
                        END;
                    END;
                    // Case---4

                    // Case---5
                    IF (AgedDuration[9] = 0) AND (AgedDuration[10] <> 0) THEN BEGIN
                        IF (CalDays <= AgedDuration[10]) THEN
                            AgedValue[5] += RemaingValueCal;

                        IsColShow[5] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[5] := FORMAT(AgedDuration[9]) + '-' + FORMAT(AgedDuration[10]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[5] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[10] + 1), FORMAT(EndingDate - AgedDuration[9] + 1));
                        END;
                    END;

                    IF (AgedDuration[9] <> 0) AND (AgedDuration[10] <> 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[9]) AND (CalDays <= AgedDuration[10]) THEN
                            AgedValue[5] += RemaingValueCal;

                        IsColShow[5] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[5] := FORMAT(AgedDuration[9]) + '-' + FORMAT(AgedDuration[10]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[5] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[10] + 1), FORMAT(EndingDate - AgedDuration[9] + 1));
                        END;
                    END;

                    IF (AgedDuration[9] <> 0) AND (AgedDuration[10] = 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[9]) THEN
                            AgedValue[5] += RemaingValueCal;
                        IsColShow[5] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[5] := '>' + FORMAT(AgedDuration[9] - 1);
                            HeadingType::"Date Interval":
                                AgedCapPrint[5] := '>' + FORMAT(EndingDate - (AgedDuration[9] - 1));
                        END;
                    END;
                    // Case---5

                    // Case---6
                    IF (AgedDuration[11] = 0) AND (AgedDuration[12] <> 0) THEN BEGIN
                        IF (CalDays <= AgedDuration[12]) THEN
                            AgedValue[6] += RemaingValueCal;

                        IsColShow[6] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[6] := FORMAT(AgedDuration[11]) + '-' + FORMAT(AgedDuration[12]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[6] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[12] + 1), FORMAT(EndingDate - AgedDuration[11] + 1));
                        END;
                    END;
                    IF (AgedDuration[11] <> 0) AND (AgedDuration[12] <> 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[11]) AND (CalDays <= AgedDuration[12]) THEN
                            AgedValue[6] += RemaingValueCal;

                        IsColShow[6] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[6] := FORMAT(AgedDuration[11]) + '-' + FORMAT(AgedDuration[12]);
                            HeadingType::"Date Interval":
                                AgedCapPrint[6] := STRSUBSTNO('%1\..%2', FORMAT(EndingDate - AgedDuration[12] + 1), FORMAT(EndingDate - AgedDuration[11] + 1));
                        END;
                    END;

                    IF (AgedDuration[11] <> 0) AND (AgedDuration[12] = 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[11]) THEN
                            AgedValue[6] += RemaingValueCal;

                        IsColShow[6] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[6] := '>' + FORMAT(AgedDuration[11] - 1);
                            HeadingType::"Date Interval":
                                AgedCapPrint[6] := '>' + FORMAT(EndingDate - (AgedDuration[11] - 1));
                        END;
                    END;
                    // Case---6

                    // Case---7
                    IF (AgedDuration[14] <> 0) THEN BEGIN
                        IF (CalDays >= AgedDuration[14]) THEN
                            AgedValue[7] += RemaingValueCal;

                        IsColShow[7] := TRUE;

                        CASE HeadingType OF
                            HeadingType::"Number of Days":
                                AgedCapPrint[7] := '>' + FORMAT(AgedDuration[14] - 1);
                            HeadingType::"Date Interval":
                                AgedCapPrint[7] := '>' + FORMAT(EndingDate - (AgedDuration[14] - 1));
                        END;

                    END;
                    // Case---7

                END;

                IF RemaingValueCal < 0 THEN
                    UnAdjustedAmount += RemaingValueCal;

                OriginalAmount += RemaingValueCal;
                BalanceAmount += CustLedgerEntry."Amount (LCY)";

            UNTIL CustLedgerEntry.NEXT = 0;

            CurrencyCode := CustLedgerEntry."Currency Code";

        END;

        NetBalance := ABS(AgedValue[1] + AgedValue[2] + AgedValue[3] + AgedValue[4] + AgedValue[5] + AgedValue[6] + AgedValue[7]) - ABS(UnAdjustedAmount);

        TotalAgedValue[1] += AgedValue[1];
        TotalAgedValue[2] += AgedValue[2];
        TotalAgedValue[3] += AgedValue[3];
        TotalAgedValue[4] += AgedValue[4];
        TotalAgedValue[5] += AgedValue[5];
        TotalAgedValue[6] += AgedValue[6];
        TotalAgedValue[7] += AgedValue[7];
        TotalBalanceAmount += BalanceAmount;
        TotalNetBalance += NetBalance;
        TotalUnAdjustedAmount += UnAdjustedAmount;
    end;


    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel('Customer Aging','Customer Aging',COMPANYNAME,USERID);
        ERROR('');
    end;


    procedure MakeExcelInfo()
    begin
        ExcelBuf.AddColumn(CompanyNameText, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Report Name: Customer Aging', FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(ReportFilters, FALSE, '', TRUE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
    end;
}

