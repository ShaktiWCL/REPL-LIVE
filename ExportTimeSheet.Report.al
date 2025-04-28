report 50018 "Export Time Sheet"
{
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = WHERE(Status = FILTER(Active));
            RequestFilterFields = "No.";
            dataitem("Time Sheet Detail"; "Time Sheet Detail")
            {
                DataItemLink = "Resource No." = FIELD("No.");
                column(TimeSheetNo_TimeSheetDetail; "Time Sheet Detail"."Time Sheet No.")
                {
                }
                column(TimeSheetLineNo_TimeSheetDetail; "Time Sheet Detail"."Time Sheet Line No.")
                {
                }
                column(Date_TimeSheetDetail; "Time Sheet Detail".Date)
                {
                }
                column(Day_TimeSheetDetail; "Time Sheet Detail".Day)
                {
                }
                column(EmployeeCode_TimeSheetDetail; "Time Sheet Detail"."Resource No.")
                {
                }
                column(EmployeeName_TimeSheetDetail; "Time Sheet Detail"."Employee Name")
                {
                }
                column(ProjectName_TimeSheetDetail; "Time Sheet Detail"."Project Name")
                {
                }
                column(MilestoneDescription_TimeSheetDetail; "Time Sheet Detail"."Milestone Description")
                {
                }
                column(Hours_TimeSheetDetail; "Time Sheet Detail".Quantity)
                {
                }
                column(ExtraHours_TimeSheetDetail; "Time Sheet Detail"."Extra Hours")
                {
                }
                column(BD_TimeSheetDetail; "Time Sheet Detail".BD)
                {
                }
                column(LD_TimeSheetDetail; "Time Sheet Detail"."L&D")
                {
                }
                column(ODT_TimeSheetDetail; "Time Sheet Detail".ODT)
                {
                }
                column(TimeSheetStatus_TimeSheetDetail; "Time Sheet Detail"."Time Sheet Status")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF ExportToExcel THEN BEGIN
                        EnterCell(k, 1, FORMAT(Date), FALSE, FALSE);
                        EnterCell(k, 2, Day, FALSE, FALSE);
                        EnterCell(k, 3, "Resource No.", FALSE, FALSE);
                        EnterCell(k, 4, "Employee Name", FALSE, FALSE);
                        EnterCell(k, 5, "Project Name", FALSE, FALSE);
                        IF "Milestone Description" = '' THEN
                            EnterCell(k, 6, "Project Name", FALSE, FALSE)
                        ELSE
                            EnterCell(k, 6, "Milestone Description", FALSE, FALSE);
                        EnterCell(k, 7, FORMAT(Quantity), FALSE, FALSE);
                        EnterCell(k, 8, FORMAT("Extra Hours"), FALSE, FALSE);
                        EnterCell(k, 9, FORMAT(BD), FALSE, FALSE);
                        EnterCell(k, 10, FORMAT("L&D"), FALSE, FALSE);
                        EnterCell(k, 11, FORMAT(ODT), FALSE, FALSE);
                        EnterCell(k, 12, FORMAT("Time Sheet Status"), FALSE, FALSE);
                        EnterCell(k, 13, "Time Sheet No.", FALSE, FALSE);
                        EnterCell(k, 14, FORMAT("Time Sheet Line No."), FALSE, FALSE);
                        k += 1;
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    IF ExportToExcel THEN BEGIN
                        //ExcelBuff.CreateBookAndSaveExcel('Employe Time Sheet', 'Time Sheet ' + "Employee Code" + '(' + FORMAT(StartDate) + '..' + FORMAT(EndDate) + ')', COMPANYNAME, USERID);
                        SendEmail;
                        //ExcelBuff.GiveUserControl;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE(Date, StartDate, EndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TimeSheetDetail.SETRANGE("Resource No.", "No.");
                TimeSheetDetail.SETRANGE(Date, StartDate, EndDate);
                IF TimeSheetDetail.FINDFIRST THEN BEGIN
                    REPEAT
                        CheckTimeSheetDetail := TRUE;
                    UNTIL (TimeSheetDetail.NEXT = 0) OR (CheckTimeSheetDetail = TRUE);
                END ELSE
                    CheckTimeSheetDetail := FALSE;
                IF CheckTimeSheetDetail = FALSE THEN
                    CurrReport.SKIP;

                IF ExportToExcel THEN BEGIN
                    ExcelBuff.DELETEALL;
                    CLEAR(ExcelBuff);
                    EnterCell(1, 1, 'Date', TRUE, FALSE);
                    EnterCell(1, 2, 'Day', TRUE, FALSE);
                    EnterCell(1, 3, 'Employee Code', TRUE, FALSE);
                    EnterCell(1, 4, 'Employee Name', TRUE, FALSE);
                    EnterCell(1, 5, 'Project Name', TRUE, FALSE);
                    EnterCell(1, 6, 'Milestone Description', TRUE, FALSE);
                    EnterCell(1, 7, 'Hours', TRUE, FALSE);
                    EnterCell(1, 8, 'Extra Hours', TRUE, FALSE);
                    EnterCell(1, 9, 'BD', TRUE, FALSE);
                    EnterCell(1, 10, 'L&D', TRUE, FALSE);
                    EnterCell(1, 11, 'ODT', TRUE, FALSE);
                    EnterCell(1, 12, 'Time Sheet Status', TRUE, FALSE);
                    EnterCell(1, 13, 'Time Sheet No.', TRUE, FALSE);
                    EnterCell(1, 14, 'Time Sheet Line No.', TRUE, FALSE);
                    k := 2;
                END;
            end;

            trigger OnPreDataItem()
            begin
                /*
                IF TimeSheetForProject THEN
                 SETFILTER("Non Project Time Sheet",'%1','')
                ELSE
                 SETFILTER("Non Project Time Sheet",'<>%1','');
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Export To Excel"; ExportToExcel)
                {
                    Editable = false;
                }
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
                field("Time Sheet For Project"; TimeSheetForProject)
                {
                    Visible = false;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            ExportToExcel := TRUE;
        end;
    }

    labels
    {
    }

    var
        ExcelBuff: Record "Excel Buffer";
        k: Integer;
        ExportToExcel: Boolean;
        StartDate: Date;
        EndDate: Date;
        TimeSheetForProject: Boolean;
        Subject: Text;
        Smail: Codeunit Mail;
        Body: Text;
        CodeMail: Codeunit Mail;
        NoOfDay: Integer;
        TimeSheetDetail: Record "Time Sheet Detail";
        CheckTimeSheetDetail: Boolean;

    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CallValue: Text; Bold: Boolean; UnderLine: Boolean)
    begin
        IF ExportToExcel THEN BEGIN
            ExcelBuff.INIT;
            ExcelBuff.VALIDATE("Row No.", RowNo);
            ExcelBuff.VALIDATE("Column No.", ColumnNo);
            ExcelBuff."Cell Value as Text" := CallValue;
            ExcelBuff.Bold := Bold;
            ExcelBuff.Underline := UnderLine;
            ExcelBuff.INSERT;
        END;
    end;

    procedure SendEmail()
    var
        Text50001: Text;
    begin
        Subject := 'Time sheet for the period of ' + '(' + FORMAT(StartDate) + '..' + FORMAT(EndDate) + ')';
        Body := ('</B>' + 'Dear Sir/Madam,'
        + '</BR><BR><BR>' + 'Please find attached time sheet for the period of ' + '(' + FORMAT(StartDate) + '..' + FORMAT(EndDate) + ')'
        + '</B><BR><BR>' + 'Regards,' + '</B><BR>' + 'REPL'
        + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');

        CLEAR(CodeMail);
        CodeMail.CreateMessage(Employee."E-Mail", Text50001, Subject, Body, 'E:\Export Time Sheet\Time Sheet ' + Employee."No." + '(' + FORMAT(StartDate) + '..' + FORMAT(EndDate) + ').xlsx', True, FALSE);
    end;
}

