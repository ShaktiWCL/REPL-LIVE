report 50000 "Create Employee Time Sheets"
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
            dataitem("Resource Requirment"; "Resource Requirment")
            {
                RequestFilterFields = Resource;

                trigger OnAfterGetRecord()
                var
                    TimeSheetMgt: Codeunit "Time Sheet Management";
                    Employee: Record Employee;
                begin
                    IF CheckExistingPeriods THEN BEGIN
                        TimeSheetHeader.INIT;
                        TimeSheetHeader."Is Employee" := TRUE;
                        TimeSheetHeader."No." := NoSeriesMgt.GetNextNo(ResourcesSetup."Time Sheet Nos.", TODAY, TRUE);
                        TimeSheetHeader."Starting Date" := StartingDate;
                        TimeSheetHeader."Ending Date" := EndingDate;
                        TimeSheetHeader."Resource No." := Resource;
                        If Employee.Get(Resource) then begin
                            Employee.TESTFIELD("Time Sheet Owner User ID");
                            Employee.TESTFIELD("Time Sheet Approver User ID");
                            TimeSheetHeader."Owner User ID" := Employee."Time Sheet Owner User ID";
                            TimeSheetHeader."Approver User ID" := Employee."Time Sheet Approver User ID";
                            TimeSheetHeader."Resource Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        end;
                        TimeSheetHeader."Project No." := "Project No.";
                        TimeSheetHeader.Milestone := Milestone;
                        TimeSheetHeader."WBS Id" := "WBS Id";
                        TimeSheetHeader."Task Code" := "Task Code";
                        TimeSheetHeader."Task Group" := "Task Group";
                        TimeSheetHeader.INSERT;
                        TimeSheetCounter += 1;

                        //TimeSheetMgt.SetValues("Resource Requirment"."Task Code", "Resource Requirment"."Task Description");//AD_REPL
                        //TimeSheetMgt.CreateLinesFromJobPlanningEmployee(TimeSheetHeader);
                        FOR i := StartingDate TO EndingDate DO BEGIN
                            CreateTimeSheetDetails(TimeSheetHeader."No.", TimeSheetHeader."Resource No.", i, TimeSheetHeader."Project No.", TimeSheetHeader.Milestone, TimeSheetHeader."WBS Id");
                        END;
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    StartingDate := CALCDATE('<CM>', StartingDate) + 1;
                end;

                trigger OnPreDataItem()
                begin
                    IF "Resource Requirment".GETFILTER("Task Group") = '' THEN
                        ERROR('Task Group must not be blank');

                    IF "Resource Requirment".GETFILTER("Task Code") = '' THEN
                        ERROR('Task Code must not be blank');

                    IF "Resource Requirment".GETFILTER("Project No.") = '' THEN
                        ERROR('Project No. must not be blank');

                    IF "Resource Requirment".GETFILTER(Milestone) = '' THEN
                        ERROR('Milestone must not be blank');

                    IF "Resource Requirment".GETFILTER("WBS Id") = '' THEN
                        ERROR('WBS Id must not be blank');



                    IF HidResourceFilter <> '' THEN
                        SETFILTER(Resource, HidResourceFilter);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                EndingDate := CALCDATE('<CM>', StartingDate);
                IF ActualEndingDate < EndingDate THEN
                    EndingDate := ActualEndingDate;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Number, 1, NoOfPeriods);
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
                            IF NOT ((StartingDate >= TempStartDate) AND (StartingDate <= TempEndDate)) THEN
                                ERROR('Start Date must be between %1 and %2', TempStartDate, TempEndDate);
                            IF EndingDate <> 0D THEN
                                IF StartingDate > EndingDate THEN
                                    ERROR('End Date cannot before Start Date');

                            StartDate := StartingDate;
                            NoOfPeriods := 0;
                            NoOfPeriods := ROUND((EndDate - StartDate) / 30, 1, '>');
                        end;
                    }
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Ending Date';

                        trigger OnValidate()
                        begin
                            IF NOT ((EndingDate >= TempStartDate) AND (EndingDate <= TempEndDate)) THEN
                                ERROR('End Date must be between %1 and %2', TempStartDate, TempEndDate);

                            IF StartingDate <> 0D THEN
                                IF StartingDate > EndingDate THEN
                                    ERROR('Start Date cannot after End Date');

                            EndDate := EndingDate;
                            NoOfPeriods := 0;
                            NoOfPeriods := ROUND((EndDate - StartDate) / 30, 1, '>');
                        end;
                    }
                    field(NoOfPeriods; NoOfPeriods)
                    {
                        Caption = 'No. of Periods';
                        Editable = false;
                        MinValue = 1;
                    }
                    field(CreateLinesFromJobPlanning; CreateLinesFromJobPlanning)
                    {
                        Caption = 'Create Lines From Job Planning';
                        Visible = false;
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

            WBS.SETRANGE("Project No.", "Resource Requirment".GETFILTER("Project No."));
            WBS.SETRANGE(Milestone, "Resource Requirment".GETFILTER(Milestone));
            WBS.SETRANGE("WBS Id", "Resource Requirment".GETFILTER("WBS Id"));
            IF WBS.FINDFIRST THEN BEGIN
                StartingDate := DT2DATE(WBS."Planned Start Date");
                EndingDate := DT2DATE(WBS."Planned End Date");
                TempStartDate := DT2DATE(WBS."Planned Start Date");
                TempEndDate := DT2DATE(WBS."Planned End Date");
            END;


            StartDate := StartingDate;
            EndDate := EndingDate;


            NoOfPeriods := 0;
            NoOfPeriods := ROUND((EndDate - StartDate) / 30, 1, '>');
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


        ActualEndingDate := EndingDate;
        EndingDate := CALCDATE('<CM>', StartingDate);//REPL

        LastDate := StartingDate;
        FOR i := 1 TO NoOfPeriods DO
            LastDate := CALCDATE('<CM>', LastDate);//REPL


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
        NoOfPeriods: Decimal;
        CreateLinesFromJobPlanning: Boolean;
        Text002: Label 'Time sheet administrator only is allowed to create time sheets.';
        Text003: Label '%1 time sheets have been created.';
        Text004: Label '%1 must be filled in.';
        Text005: Label 'Starting Date';
        Text006: Label 'No. of Periods';
        Text010: Label 'Starting Date must be %1.';
        HideDialog: Boolean;
        WBS: Record WBS;
        NoofMonth: Integer;
        ActualEndingDate: Date;
        StartDate: Date;
        EndDate: Date;
        i: Date;
        CalYears: Integer;
        TempStartDate: Date;
        TempEndDate: Date;

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
        TimeSheetHeader.RESET;
        TimeSheetHeader.SETRANGE("Resource No.", "Resource Requirment".Resource);
        TimeSheetHeader.SETRANGE("Project No.", "Resource Requirment"."Project No.");
        TimeSheetHeader.SETRANGE(Milestone, "Resource Requirment".Milestone);
        TimeSheetHeader.SETRANGE("WBS Id", "Resource Requirment"."WBS Id");
        TimeSheetHeader.SETRANGE("Task Code", "Resource Requirment"."Task Code");
        TimeSheetHeader.SETRANGE("Task Group", "Resource Requirment"."Task Group");
        TimeSheetHeader.SETRANGE("Starting Date", StartingDate);
        TimeSheetHeader.SETRANGE("Ending Date", EndingDate);
        IF TimeSheetHeader.FINDFIRST THEN
            EXIT(FALSE);

        EXIT(TRUE);
    end;

    procedure CreateTimeSheetDetails(TimeSheetNo: Code[20]; EmployeeNo: Code[20]; TimeSheetDate: Date; ProjectNo: Code[20]; MilestoneNo: Code[20]; WBSCode: Code[20])
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
        TimeSheetDetail.VALIDATE(Milestone, MilestoneNo);
        TimeSheetDetail."WBS Id" := WBSCode;
        TimeSheetDetail."Task Code" := "Resource Requirment"."Task Code"; //AD_REPL
        TimeSheetDetail."Task Description" := "Resource Requirment"."Task Description";//AD_REPL
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
        TimeSheetExportBuffer.Milestone := TimeSheetDetail.Milestone;
        TimeSheetExportBuffer."WBS Id" := TimeSheetDetail."WBS Id";
        TimeSheetExportBuffer."Project Name" := TimeSheetDetail."Project Name";
        TimeSheetExportBuffer."Milestone Description" := TimeSheetDetail."Milestone Description";
        TimeSheetExportBuffer."Employee Name" := TimeSheetDetail."Employee Name";
        TimeSheetExportBuffer."Total Days Assigned" := TimeSheetDetail."Total Days Assigned";
        TimeSheetExportBuffer."Task Code" := TimeSheetDetail."Task Code";
        TimeSheetExportBuffer."Task Description" := TimeSheetDetail."Task Description";
        TimeSheetExportBuffer.INSERT;
    end;
}

