report 50016 "Create Non Project Time Sheet"
{
    Caption = 'Create Time Sheets';
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number);
            dataitem(Employee; Employee)
            {
                RequestFilterFields = "No.";

                trigger OnAfterGetRecord()
                var
                    TimeSheetMgt: Codeunit "Time Sheet Management";
                begin
                    IF CheckExistingPeriods THEN BEGIN
                        TimeSheetHeader.INIT;
                        TimeSheetHeader."Is Employee" := TRUE;
                        TimeSheetHeader."No." := NoSeriesMgt.GetNextNo(ResourcesSetup."Time Sheet Nos.", TODAY, TRUE);
                        TimeSheetHeader."Starting Date" := StartingDate;
                        TimeSheetHeader."Ending Date" := EndingDate;
                        TimeSheetHeader."Project No." := Employee."Non Project Time Sheet";
                        TimeSheetHeader.VALIDATE("Resource No.", "No.");
                        TimeSheetHeader.INSERT;
                        TimeSheetCounter += 1;

                        //IF CreateLinesFromJobPlanning THEN
                        // TimeSheetMgt.CreateLinesFromJobPlanningEmployee(TimeSheetHeader);
                        // FOR i := StartingDate TO EndingDate DO BEGIN
                        //     CreateTimeSheetDetails(TimeSheetHeader."No.", "No.", i, TimeSheetHeader."Project No.");
                        // END;
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    //StartingDate := CALCDATE('<1W>',StartingDate);
                end;

                trigger OnPreDataItem()
                begin
                    IF HidResourceFilter <> '' THEN
                        SETFILTER("No.", HidResourceFilter);

                    SETFILTER("Non Project Time Sheet", '<>%1', '');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //EndingDate := CALCDATE('<1W>',StartingDate) - 1;
                EndingDate := CALCDATE('<CM>', StartingDate);//REPL
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE(Number,1,NoOfPeriods);
                SETRANGE(Number, 1);
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
                    field(StartingDate; StartingDate)
                    {
                        Caption = 'Starting Date';

                        trigger OnValidate()
                        begin
                            //ValidateStartingDate;
                            IF StartingDate <> DMY2DATE(1, DATE2DMY(StartingDate, 2), DATE2DMY(StartingDate, 3)) THEN
                                ERROR('Start date must be %1', DMY2DATE(1, DATE2DMY(StartingDate, 2), DATE2DMY(StartingDate, 3)));
                        end;
                    }
                    field(NoOfPeriods; NoOfPeriods)
                    {
                        Caption = 'No. of Periods';
                        MinValue = 1;
                    }
                    field(CreateLinesFromJobPlanning; CreateLinesFromJobPlanning)
                    {
                        Caption = 'Create Lines From Job Planning';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        var
            TimeSheetMgt: Codeunit "Time Sheet Management";
        begin
            IF NoOfPeriods = 0 THEN
                NoOfPeriods := 1;
            /*
            IF TimeSheetHeader.FINDLAST THEN
              StartingDate := TimeSheetHeader."Ending Date" + 1
            ELSE
              StartingDate := TimeSheetMgt.FindNearestTimeSheetStartDate(WORKDATE);
            */
            StartingDate := DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));

        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        ResourcesSetup.GET;
    end;

    trigger OnPostReport()
    begin
        IF NOT HideDialog THEN
            MESSAGE(Text003, TimeSheetCounter);
    end;

    trigger OnPreReport()
    var
        UserSetup: Record "User Setup";
        i: Integer;
        LastDate: Date;
        FirstAccPeriodStartingDate: Date;
        LastAccPeriodStartingDate: Date;
    begin
        UserSetup.GET(USERID);

        IF NOT UserSetup."Time Sheet Admin." THEN
            ERROR(Text002);

        IF StartingDate = 0D THEN
            ERROR(Text004, Text005);

        IF NoOfPeriods = 0 THEN
            ERROR(Text004, Text006);

        ResourcesSetup.TESTFIELD("Time Sheet Nos.");

        //EndingDate := CALCDATE('<1W>',StartingDate);
        EndingDate := CALCDATE('<CM>', StartingDate);
        LastDate := StartingDate;
        FOR i := 1 TO NoOfPeriods DO
            LastDate := CALCDATE('<1W>', LastDate);

        AccountingPeriod.SETFILTER("Starting Date", '..%1', StartingDate);
        AccountingPeriod.FINDLAST;
        FirstAccPeriodStartingDate := AccountingPeriod."Starting Date";

        AccountingPeriod.SETFILTER("Starting Date", '..%1', LastDate);
        AccountingPeriod.FINDLAST;
        LastAccPeriodStartingDate := AccountingPeriod."Starting Date";

        AccountingPeriod.SETRANGE("Starting Date", FirstAccPeriodStartingDate, LastAccPeriodStartingDate);
        AccountingPeriod.FINDSET;
        REPEAT
            AccountingPeriod.TESTFIELD(Closed, FALSE);
        UNTIL AccountingPeriod.NEXT = 0;
    end;

    var
        AccountingPeriod: Record "Accounting Period";
        ResourcesSetup: Record "Resources Setup";
        TimeSheetHeader: Record "Time Sheet Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HidResourceFilter: Code[250];
        StartingDate: Date;
        EndingDate: Date;
        TimeSheetCounter: Integer;
        NoOfPeriods: Integer;
        CreateLinesFromJobPlanning: Boolean;
        Text002: Label 'Time sheet administrator only is allowed to create time sheets.';
        Text003: Label '%1 time sheets have been created.';
        Text004: Label '%1 must be filled in.';
        Text005: Label 'Starting Date';
        Text006: Label 'No. of Periods';
        Text010: Label 'Starting Date must be %1.';
        HideDialog: Boolean;
        i: Date;

    procedure InitParameters(NewStartingDate: Date; NewNoOfPeriods: Integer; NewResourceFilter: Code[250]; NewCreateLinesFromJobPlanning: Boolean; NewHideDialog: Boolean)
    begin
        CLEARALL;
        ResourcesSetup.GET;
        StartingDate := NewStartingDate;
        NoOfPeriods := NewNoOfPeriods;
        HidResourceFilter := NewResourceFilter;
        CreateLinesFromJobPlanning := NewCreateLinesFromJobPlanning;
        HideDialog := NewHideDialog;
    end;

    procedure CheckExistingPeriods(): Boolean
    begin
        TimeSheetHeader.SETRANGE("Resource No.", Employee."No.");
        TimeSheetHeader.SETRANGE("Starting Date", StartingDate);
        TimeSheetHeader.SETRANGE("Ending Date", EndingDate);
        IF TimeSheetHeader.FINDFIRST THEN
            EXIT(FALSE);

        EXIT(TRUE);
    end;

    procedure ValidateStartingDate()
    begin
        IF DATE2DWY(StartingDate, 1) <> ResourcesSetup."Time Sheet First Weekday" + 1 THEN
            ERROR(Text010, ResourcesSetup."Time Sheet First Weekday");
    end;

    procedure CreateTimeSheetDetails(TimeSheetNo: Code[20]; EmployeeNo: Code[20]; TimeSheetDate: Date; ProjectNo: Code[20])
    var
        TimeSheetDetail: Record "Time Sheet Detail";
    begin
        TimeSheetDetail.INIT;
        TimeSheetDetail."Time Sheet No." := TimeSheetNo;
        TimeSheetDetail."Time Sheet Line No." := 10000;
        TimeSheetDetail.Type := TimeSheetDetail.Type::Job;
        TimeSheetDetail.VALIDATE(Date, TimeSheetDate);
        TimeSheetDetail.VALIDATE("Resource No.", EmployeeNo);
        TimeSheetDetail.VALIDATE("Job No.", ProjectNo);
        TimeSheetDetail."Job Task No." := ProjectNo;
        IF TimeSheetDetail.INSERT THEN //AD_REPL
            CreateTimeSheetExport(TimeSheetDetail); //AD_REPL
    end;

    procedure CreateTimeSheetExport(TimeSheetDetail: Record "Time Sheet Detail")
    var
        TimeSheetExportBuffer: Record "Pull Time Sheet Data";
    begin
        TimeSheetExportBuffer.INIT;
        TimeSheetExportBuffer."Time Sheet No." := TimeSheetDetail."Time Sheet No.";
        TimeSheetExportBuffer."Time Sheet Line No." := TimeSheetDetail."Time Sheet Line No.";
        TimeSheetExportBuffer.Date := TimeSheetDetail.Date;
        TimeSheetExportBuffer."Employee Code" := TimeSheetDetail."Resource No.";
        TimeSheetExportBuffer."Project Code" := TimeSheetDetail."Job No.";
        TimeSheetExportBuffer.Day := TimeSheetDetail.Day;
        TimeSheetExportBuffer.Milestone := TimeSheetDetail."Job Task No.";
        TimeSheetExportBuffer."WBS Id" := TimeSheetDetail."Job No.";
        TimeSheetExportBuffer."Project Name" := TimeSheetDetail."Project Name";
        TimeSheetExportBuffer."Milestone Description" := TimeSheetDetail."Job Task No.";
        TimeSheetExportBuffer."Employee Name" := TimeSheetDetail."Employee Name";
        TimeSheetExportBuffer."Total Days Assigned" := TimeSheetDetail."Total Days Assigned";
        TimeSheetExportBuffer."Task Code" := TimeSheetDetail."Job Task No.";
        TimeSheetExportBuffer."Task Description" := TimeSheetDetail."Job Task No.";
        TimeSheetExportBuffer.INSERT;
    end;
}

