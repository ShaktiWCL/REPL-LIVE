report 50019 "Import Time Sheet"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = WHERE(Status = FILTER(Active));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                ServerFileName := 'E:\Import Time Sheet\Time Sheet ' + Employee."No." + '(' + FORMAT(StartDate) + '..' + FORMAT(EndDate) + ').xlsx';

                IF FileMgt.ServerFileExists(ServerFileName) THEN BEGIN
                    //SheetName := ExcelBuf.SelectSheetsName(ServerFileName);

                    ExcelBuf.LOCKTABLE;
                    //ExcelBuf.OpenBook(ServerFileName, SheetName);
                    ExcelBuf.ReadSheet;
                    GetLastRowandColumn;

                    FOR x := 2 TO TotalRows DO
                        InsertData(x);

                    ExcelBuf.DELETEALL;

                    MESSAGE('Import Completed');
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
                field("Start Date"; StartDate)
                {

                    trigger OnValidate()
                    begin
                        NoOfDay := DATE2DWY(StartDate, 1);
                        IF NoOfDay <> 1 THEN
                            ERROR('Start date must be Monday');

                        EndDate := StartDate + 6;
                    end;
                }
                field("End Date"; EndDate)
                {
                    Editable = false;
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
        //ServerFileName := FileMgt.UploadFile(Text006,ExcelExtensionTok);

        //SheetName := ExcelBuf.SelectSheetsName(ServerFileName);
    end;

    var
        ExcelBuf: Record "Excel Buffer";
        x: Integer;
        TotalRows: Integer;
        TotalColumns: Integer;
        ServerFileName: Text;
        SheetName: Text;
        FileMgt: Codeunit "File Management";
        Text006: Label 'Import Excel File';
        ExcelExtensionTok: Label '.xlsx';
        ImportOption: Option "Add entries","Replace entries";
        StartDate: Date;
        EndDate: Date;
        NoOfDay: Integer;

    procedure GetLastRowandColumn()
    begin
        ExcelBuf.SETRANGE("Row No.", 1);
        TotalColumns := ExcelBuf.COUNT;

        ExcelBuf.RESET;
        IF ExcelBuf.FINDLAST THEN
            TotalRows := ExcelBuf."Row No.";
    end;

    procedure InsertData(RowNo: Integer)
    var
        TimeSheetDetail: Record "Time Sheet Detail";
        TimeSheetLineNo: Integer;
        TimeSheetDate: Date;
        TimeSheetStatus: Option Open,Approved,Rejected;
    begin
        TimeSheetDetail.SETRANGE("Time Sheet No.", GetValueAtCell(RowNo, 13));
        EVALUATE(TimeSheetLineNo, GetValueAtCell(RowNo, 14));
        TimeSheetDetail.SETRANGE("Time Sheet Line No.", TimeSheetLineNo);
        EVALUATE(TimeSheetDate, GetValueAtCell(RowNo, 1));
        TimeSheetDetail.SETRANGE(Date, TimeSheetDate);
        TimeSheetDetail.SETRANGE(Day, GetValueAtCell(RowNo, 2));
        TimeSheetDetail.SETFILTER(Status, '<>%1', TimeSheetDetail.Status::Approved);
        IF TimeSheetDetail.FINDFIRST THEN BEGIN
            EVALUATE(TimeSheetDetail.Quantity, GetValueAtCell(RowNo, 7));
            EVALUATE(TimeSheetDetail."Extra Hours", GetValueAtCell(RowNo, 8));
            EVALUATE(TimeSheetDetail.BD, GetValueAtCell(RowNo, 9));
            EVALUATE(TimeSheetDetail."L&D", GetValueAtCell(RowNo, 10));
            EVALUATE(TimeSheetDetail.ODT, GetValueAtCell(RowNo, 11));
            EVALUATE(TimeSheetStatus, GetValueAtCell(RowNo, 12));
            TimeSheetDetail.VALIDATE("Time Sheet Status", TimeSheetStatus);
            TimeSheetDetail.MODIFY;
        END;
    end;

    procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    var
        ExcelBuf1: Record "Excel Buffer";
    begin
        ExcelBuf1.GET(RowNo, ColNo);
        EXIT(ExcelBuf1."Cell Value as Text");
    end;
}

