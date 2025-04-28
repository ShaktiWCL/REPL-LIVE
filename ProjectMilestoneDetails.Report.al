report 50047 "Project Milestone Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/ProjectMilestoneDetails.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Current Date"; CurrentDate)
                {
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
        IF CurrentDate = 0D THEN
            CurrentDate := WORKDATE;
        Next1MonthStartDate := CALCDATE('-CM', CurrentDate);
        Next1MonthEndDate := CALCDATE('CM', Next1MonthStartDate);

        MonthInt := DATE2DMY(CurrentDate, 2);
        YearInt := DATE2DMY(CurrentDate, 3);
        CASE MonthInt OF
            1:
                BEGIN
                    MonthText := 'January ' + FORMAT(YearInt);
                END;
            2:
                BEGIN
                    MonthText := 'February ' + FORMAT(YearInt);
                END;
            3:
                BEGIN
                    MonthText := 'March ' + FORMAT(YearInt);
                END;
            4:
                BEGIN
                    MonthText := 'April ' + FORMAT(YearInt);
                END;
            5:
                BEGIN
                    MonthText := 'May ' + FORMAT(YearInt);
                END;
            6:
                BEGIN
                    MonthText := 'June ' + FORMAT(YearInt);
                END;
            7:
                BEGIN
                    MonthText := 'July ' + FORMAT(YearInt);
                END;
            8:
                BEGIN
                    MonthText := 'August ' + FORMAT(YearInt);
                END;
            9:
                BEGIN
                    MonthText := 'September ' + FORMAT(YearInt);
                END;
            10:
                BEGIN
                    MonthText := 'October ' + FORMAT(YearInt);
                END;
            11:
                BEGIN
                    MonthText := 'November ' + FORMAT(YearInt);
                END;
            12:
                BEGIN
                    MonthText := 'December ' + FORMAT(YearInt);
                END;
        END;

        SendEmailDetails;
    end;

    var
        CurrentDate: Date;
        Next1MonthStartDate: Date;
        Next1MonthEndDate: Date;
        ProjectCode1: Code[40];
        MonthText: Text;
        MonthInt: Integer;
        YearInt: Integer;
        TotalActiveBalance: Decimal;
        TotalInactiveBalance: Decimal;


    procedure GetActiveProject(ProjectTask: Record "Job Task") ActiveDueAmt: Decimal
    var
        ProjectTask1: Record "Job Task";
        Project1: Record "Job";
    begin
        ProjectTask1.SETRANGE("Customer No.", ProjectTask."Customer No.");
        ProjectTask1.SETRANGE("Planned Bill Date", Next1MonthStartDate, Next1MonthEndDate);
        ProjectTask1.SETFILTER("Balance Amount", '>%1', 10);
        IF ProjectTask1.FINDFIRST THEN BEGIN
            REPEAT
                IF Project1.GET(ProjectTask1."Job No.") THEN BEGIN
                    IF (Project1."Temporary Status" = Project1."Temporary Status"::" ") AND (Project1."Type Of Project" = Project1."Type Of Project"::"Main Project") THEN
                        ActiveDueAmt += ProjectTask1."Balance Amount";
                END;
            UNTIL ProjectTask1.NEXT = 0;
        END;
        EXIT(ROUND(ActiveDueAmt, 1, '='));
    end;


    procedure GetInActiveProject(ProjectTask: Record "Job Task") InActiveDueAmt: Decimal
    var
        ProjectTask1: Record "Job Task";
        Project1: Record "Job";
    begin
        ProjectTask1.SETRANGE("Customer No.", ProjectTask."Customer No.");
        ProjectTask1.SETRANGE("Planned Bill Date", Next1MonthStartDate, Next1MonthEndDate);
        ProjectTask1.SETFILTER("Balance Amount", '>%1', 10);
        IF ProjectTask1.FINDFIRST THEN BEGIN
            REPEAT
                IF Project1.GET(ProjectTask1."Job No.") THEN BEGIN
                    IF (Project1."Temporary Status" = Project1."Temporary Status"::"In-Active") AND (Project1."Type Of Project" = Project1."Type Of Project"::"Main Project") THEN
                        InActiveDueAmt += ProjectTask1."Balance Amount";
                END;
            UNTIL ProjectTask1.NEXT = 0;
        END;
        EXIT(ROUND(InActiveDueAmt, 1, '='));
    end;

    local procedure SendEmailDetails()
    var
        Subject: Text;
        Body: Text;
        SMTPMail: Codeunit Mail;
    begin
        Subject := 'Invoicing Alert for the M/o ' + MonthText;
        Body := ('</BR>' + 'Dear Sir,' + '</BR><BR><BR>' + 'Please find below Customer wise Invoicing detail which is due for billing for the M/o ' + MonthText
                + '<table BORDER="1">'
                + '<tr>'
                + '<th style="width:120px"><FONT COLOR=BLACK><FONT SIZE=3>Customer Code</th>'
                + '<th style="width:200px"><FONT COLOR=BLACK><FONT SIZE=3>Customer Name</th>'
                + '<th style="width:50px"><FONT COLOR=BLACK><FONT SIZE=3>Invoice To be done (Active Project)</th>'
                + '<th style="width:50px"><FONT COLOR=BLACK><FONT SIZE=3>Invoice To be done (In-Active Project)</th>'
                + '<th style="width:200px"><FONT COLOR=BLACK><FONT SIZE=3>Project Manager</th>'
               + '</tr>'
               + GeBodyDataEntry
               + '</Table>'
               + '</B><BR><BR>' + 'Warm Regards,'
               + '</B><BR><U><Font COLOR=blue>' + COMPANYNAME + '(Navision ERP Team)')
               + '</B><BR><BR>';
        //SMTPMail.CreateMessage('','manish.raushan@repl.global','manish.raushan@repl.global',Subject,Body,TRUE);
        // SMTPMail.CreateMessage('REPL', 'manish.raushan@repl.global', 'pradeepmisra@repl.global', Subject, Body, TRUE);
        // SMTPMail.AddCC('manish.raushan@repl.global;prakasharya@repl.global');

        // SMTPMail.Send;
    end;

    local procedure GeBodyDataEntry() BodyData: Text
    var
        ProjectTask: Record "Job Task";
        Project: Record "Job";
        ProjectTask1: Record "Job Task";
    begin
        ProjectCode1 := '';
        ProjectTask1.RESET;
        ProjectTask1.SETRANGE("Planned Bill Date", Next1MonthStartDate, Next1MonthEndDate);
        ProjectTask1.SETFILTER("Balance Amount", '>%1', 10);
        ProjectTask1.SETCURRENTKEY("Customer No.");
        IF ProjectTask1.FINDFIRST THEN BEGIN
            REPEAT
                IF Project.GET(ProjectTask1."Job No.") THEN BEGIN
                    IF Project."Type Of Project" = Project."Type Of Project"::"Main Project" THEN BEGIN
                        IF ProjectCode1 <> ProjectTask1."Customer No." THEN BEGIN
                            ProjectTask.RESET;
                            ProjectTask.SETRANGE("Job No.", ProjectTask1."Job No.");
                            ProjectTask.SETRANGE("Customer No.", ProjectTask1."Customer No.");
                            ProjectTask.SETRANGE("Project Manager", ProjectTask1."Project Manager");
                            ProjectTask.SETRANGE("Planned Bill Date", Next1MonthStartDate, Next1MonthEndDate);
                            ProjectTask.SETFILTER("Balance Amount", '>%1', 10);
                            IF ProjectTask.FINDFIRST THEN BEGIN
                                BodyData += '<TR>'
                                + '<td><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ProjectTask."Customer No.") + '</TD>'
                                + '<td><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ProjectTask."Customer Name") + '</TD>'
                                + '<td><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(GetActiveProject(ProjectTask)) + '</TD>'
                                + '<td><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(GetInActiveProject(ProjectTask)) + '</TD>'
                                + '<td><FONT COLOR=BLUE><FONT SIZE=2>' + GetProjectManager(ProjectTask."Customer No.") + '</TD>'
                                + '</TR>';
                                TotalActiveBalance += GetActiveProject(ProjectTask);
                                TotalInactiveBalance += GetInActiveProject(ProjectTask);
                            END;
                            ProjectCode1 := ProjectTask1."Customer No.";
                        END;
                    END;
                END;
            UNTIL ProjectTask1.NEXT = 0;
            BodyData += '<TR>'
            + '<td><FONT COLOR=RED><FONT SIZE=2>' + '' + '</TD>'
            + '<td><FONT COLOR=RED><FONT SIZE=2>' + 'Total' + '</TD>'
            + '<td><FONT COLOR=RED><FONT SIZE=2>' + FORMAT(TotalActiveBalance) + '</TD>'
            + '<td><FONT COLOR=RED><FONT SIZE=2>' + FORMAT(TotalInactiveBalance) + '</TD>'
            + '<td><FONT COLOR=BLUE><FONT SIZE=2>' + '' + '</TD>'
            + '</TR>';

        END;
        EXIT(BodyData);
    end;


    procedure GetProjectManager(ProjectCode: Code[40]): Text
    var
        ProjectTask: Record "Job Task";
        ProjectManager: Text;
        Project: Record "Job";
    begin
        ProjectTask.SETRANGE("Customer No.", ProjectCode);
        ProjectTask.SETRANGE("Planned Bill Date", Next1MonthStartDate, Next1MonthEndDate);
        ProjectTask.SETFILTER("Balance Amount", '>%1', 10);
        IF ProjectTask.FINDFIRST THEN
            REPEAT
                IF Project.GET(ProjectTask."Job No.") THEN BEGIN
                    IF Project."Type Of Project" = Project."Type Of Project"::"Main Project" THEN BEGIN
                        IF ProjectManager <> '' THEN BEGIN
                            IF STRPOS(ProjectManager, GetEmployeeName(ProjectTask."Project Manager")) = 0 THEN
                                ProjectManager += ',' + GetEmployeeName(ProjectTask."Project Manager");
                        END ELSE
                            ProjectManager := GetEmployeeName(ProjectTask."Project Manager");
                    END;
                END;
            UNTIL ProjectTask.NEXT = 0;

        EXIT(ProjectManager);
    end;


    procedure GetEmployeeName(EmployeeCode: Code[20]) EmployeeName: Text
    var
        Employee: Record Employee;
    begin
        IF Employee.GET(EmployeeCode) THEN BEGIN
            EmployeeName := Employee."First Name";
        END;
        EXIT(EmployeeName);
    end;
}

