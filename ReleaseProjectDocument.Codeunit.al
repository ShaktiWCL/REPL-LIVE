codeunit 50000 "Release Project Document"
{
    TableNo = Job;

    trigger OnRun()
    var
        ProjectTask: Record "Job Task";
        TempVATAmountLine0: Record "VAT Amount Line" temporary;
        TempVATAmountLine1: Record "VAT Amount Line" temporary;
        NotOnlyDropShipment: Boolean;
        PostingDate: Date;
    begin
        IF Rec."Project Status" = Rec."Project Status"::Approved THEN
            EXIT;

        //AD_REPL
        IF (Rec."Type Of Project" = Rec."Type Of Project"::"Main Project") THEN BEGIN
            GetProjectCharter.RESET;
            GetProjectCharter.SETRANGE("Project Charter No.", Rec."Project Charter No.");
            GetProjectCharter.SETFILTER(Status, '%1', GetProjectCharter.Status::Approved);
            IF NOT GetProjectCharter.FINDFIRST THEN
                ERROR('Project Charter No. %1 status must be approved', Rec."Project Charter No.");
        END;

        IF NOT UserSetup.GetAdminUser THEN BEGIN
            IF (Rec."Type Of Project" = rec."Type Of Project"::"Main Project") OR (Rec."Type Of Project" = Rec."Type Of Project"::"PMC Project") THEN
                CheckResourceEntry(Rec."No.", TRUE)
            ELSE
                CheckResourceEntry(Rec."No.", FALSE);
            CheckTimeSheetDetails(Rec."No.");
        END;

        CreateLineForSalesInvoice(Rec."No.");

        Rec."Project Status" := Rec."Project Status"::Approved;
        IF Rec.MODIFY(TRUE) THEN
            MaintainApprovedStatus(Rec."No.");
    end;

    var
        Text001: Label 'There is nothing to release for the document of type %1 with the number %2.';
        SalesSetup: Record "Sales & Receivables Setup";
        InvtSetup: Record "Inventory Setup";
        WhseSalesRelease: Codeunit "Whse.-Sales Release";
        Text002: Label 'This document can only be released when the approval process is complete.';
        Text003: Label 'The approval process must be cancelled or completed to reopen this document.';
        Text004: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.';
        Text005: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';
        ProjectTeam: Record "Project Team";
        ProjectPlanLine2: Record "Job Planning Line";
        UserSetup: Record "User Setup";
        GetProjectCharter: Record "Project Charter";
        WBS: Record WBS;
        ProjectCharter: Record "Project Charter";

    procedure Reopen(var ProjectsHeader: Record Job)
    begin
        //WITH ProjectsHeader DO BEGIN
        IF ProjectsHeader."Project Status" = ProjectsHeader."Project Status"::Draft THEN
            EXIT;
        ProjectsHeader."Project Status" := ProjectsHeader."Project Status"::Draft;
        ProjectsHeader.MODIFY(TRUE);
        //END;
    end;

    procedure PerformManualRelease(var SalesHeader: Record "Sales Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovedOnly: Boolean;
    begin

        //IF ApprovalManagement.TestSalesPrepayment(SalesHeader) THEN
        //ERROR(STRSUBSTNO(Text004,"Document Type","No."));
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN BEGIN//AND ApprovalManagement.TestSalesPayment(SalesHeader) THEN BEGIN
            IF SalesHeader.Status <> SalesHeader.Status::"Pending Prepayment" THEN BEGIN
                SalesHeader.Status := SalesHeader.Status::"Pending Prepayment";
                SalesHeader.MODIFY;
                COMMIT;
            END;
            ERROR(STRSUBSTNO(Text005, SalesHeader."Document Type", SalesHeader."No."));


            //IF ApprovalManagement.CheckApprSalesDocument(SalesHeader) THEN BEGIN
            CASE SalesHeader.Status OF
                SalesHeader.Status::"Pending Approval":
                    ERROR(Text002);
                SalesHeader.Status::Released, SalesHeader.Status::"Pending Prepayment":
                    CODEUNIT.RUN(CODEUNIT::"Release Sales Document", SalesHeader);
                SalesHeader.Status::Open:
                    BEGIN
                        ApprovedOnly := TRUE;
                        ApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.");
                        ApprovalEntry.SETRANGE("Table ID", DATABASE::"Sales Header");
                        ApprovalEntry.SETRANGE("Document Type", SalesHeader."Document Type");
                        ApprovalEntry.SETRANGE("Document No.", SalesHeader."No.");
                        ApprovalEntry.SETFILTER(Status, '<>%1&<>%2', ApprovalEntry.Status::Rejected, ApprovalEntry.Status::Canceled);
                        IF ApprovalEntry.FINDSET THEN BEGIN
                            REPEAT
                                IF ApprovalEntry.Status <> ApprovalEntry.Status::Approved THEN
                                    ApprovedOnly := FALSE;
                            UNTIL NOT ApprovedOnly OR (ApprovalEntry.NEXT = 0);

                            IF ApprovedOnly THEN      //AND TestApprovalLimit(ProjectsHeader)
                                CODEUNIT.RUN(CODEUNIT::"Release Project Document", SalesHeader)
                            ELSE
                                ERROR(Text002);
                        END ELSE
                            ERROR(Text002);
                    END;
            END;
            //END ELSE
            //CODEUNIT.RUN(CODEUNIT::"Release Project Document",SalesHeader);
        END;
    end;

    //[Scope('Internal')]
    procedure PerformManualReopen(var ProjectsHeader: Record Job)
    begin
        //WITH ProjectsHeader DO BEGIN
        CASE ProjectsHeader."Project Status" OF
            ProjectsHeader."Project Status"::Approved:
                ERROR(Text003);
            ProjectsHeader."Project Status"::Draft, ProjectsHeader."Project Status"::Fresh:
                Reopen(ProjectsHeader)
            ELSE
                Reopen(ProjectsHeader);
        END;
        // END;
    end;


    procedure TestPrepayment(SalesHeader: Record "Sales Header"): Boolean
    var
        SalesLines: Record "Sales Line";
    begin
        SalesLines.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLines.SETRANGE("Document No.", SalesHeader."No.");
        SalesLines.SETFILTER("Prepmt. Line Amount", '<>%1', 0);
        IF SalesLines.FIND('-') then
            REPEAT
                IF SalesLines."Prepmt. Amt. Inv." <> SalesLines."Prepmt. Line Amount" THEN
                    EXIT(TRUE);
            UNTIL SalesLines.NEXT = 0;
    end;


    procedure TestApprovalLimit(ProjectsHeader: Record Job): Boolean
    var
        UserSetup: Record "User Setup";
        AppAmount: Decimal;
        AppAmountLCY: Decimal;
    begin
        //AppManagement.CalcProjectsDocAmount(ProjectsHeader,AppAmount,AppAmountLCY);
        UserSetup.GET(USERID);
        IF UserSetup."Unlimited Sales Approval" THEN
            EXIT(TRUE);

        IF AppAmountLCY > UserSetup."Sales Amount Approval Limit" THEN
            ERROR(Text002);

        EXIT(TRUE);
    end;

    local procedure ReleaseATOs(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        AsmHeader: Record "Assembly Header";
    begin
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF SalesLine.FINDSET THEN
            REPEAT
                IF SalesLine.AsmToOrderExists(AsmHeader) THEN
                    CODEUNIT.RUN(CODEUNIT::"Release Assembly Document", AsmHeader);
            UNTIL SalesLine.NEXT = 0;
    end;

    local procedure ReopenATOs(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        AsmHeader: Record "Assembly Header";
        ReleaseAssemblyDocument: Codeunit "Release Assembly Document";
    begin
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF SalesLine.FINDSET THEN
            REPEAT
                IF SalesLine.AsmToOrderExists(AsmHeader) THEN
                    ReleaseAssemblyDocument.Reopen(AsmHeader);
            UNTIL SalesLine.NEXT = 0;
    end;

    //[Scope('Internal')]
    procedure CreateLineForSalesInvoice(ProjectNo: Code[20])
    var
        ProjectPlanLine: Record "Job Planning Line";
        ProjectTask: Record "Job Task";
        LineNo: Integer;
        Project: Record Job;
        InsertStatus: Boolean;
    begin
        ProjectTask.RESET;
        ProjectTask.SETRANGE("Job No.", ProjectNo);
        //ProjectTask.SETRANGE("Job Task No.", ProjectNo);
        IF ProjectTask.FINDFIRST THEN BEGIN
            REPEAT
                ProjectPlanLine.RESET;
                ProjectPlanLine.SETRANGE("Job No.", ProjectTask."Job No.");
                //ProjectPlanLine.SETRANGE("Job Task No.", ProjectTask."Job Task No.");
                ProjectPlanLine.SETRANGE(MileStone, ProjectTask.Milestone);
                IF NOT ProjectPlanLine.FINDFIRST THEN BEGIN
                    ProjectPlanLine.INIT;
                    ProjectPlanLine."Job No." := ProjectTask."Job No.";
                    ProjectPlanLine."Job Task No." := ProjectTask."Job Task No.";
                    ProjectPlanLine."Project Name" := ProjectTask.Description;
                    ProjectPlanLine."Project Manager" := ProjectTask."Project Manager";
                    ProjectPlanLine."Customer No." := ProjectTask."Customer No.";
                    ProjectPlanLine."Customer Name" := ProjectTask."Customer Name";
                    ProjectPlanLine.MileStone := ProjectTask.Milestone;
                    ProjectPlanLine."Line No." := GetPlanningLineNo(ProjectNo);
                    Project.GET(ProjectTask."Job No.");
                    IF (Project."Type Of Project" = Project."Type Of Project"::"PMC Project") OR (Project."Type Of Project" = Project."Type Of Project"::"Sub Project") THEN
                        ProjectPlanLine.VALIDATE("Line Type", ProjectPlanLine."Line Type"::Billable)
                    ELSE
                        ProjectPlanLine.VALIDATE("Line Type", ProjectPlanLine."Line Type"::"Both Budget and Billable");
                    IF ProjectTask.Type = 2 then
                        ProjectPlanLine.Type := ProjectPlanLine.Type::"G/L Account";
                    IF ProjectTask.Type = 1 then
                        ProjectPlanLine.Type := ProjectPlanLine.Type::Item;
                    IF ProjectTask.Type = 0 then
                        ProjectPlanLine.Type := ProjectPlanLine.Type::Resource;
                    IF ProjectTask.Type = 4 then
                        ProjectPlanLine.Type := ProjectPlanLine.Type::Text;
                    ProjectPlanLine.VALIDATE("No.", ProjectTask."Account No.");
                    ProjectPlanLine.VALIDATE(Quantity, 1);
                    ProjectPlanLine."Milestone Amount" := ProjectTask.Amount;
                    ProjectPlanLine."Balance Amount" := ProjectTask.Amount;
                    ProjectPlanLine.VALIDATE("Planning Date", WORKDATE);
                    ProjectPlanLine.INSERT(TRUE);
                END;
            //IF NOT ValidateProjectPlanningLine(ProjectTask2) THEN
            //ProjectPlanLine.INSERT(TRUE);
            UNTIL ProjectTask.NEXT = 0;
        END;
    end;

    //[Scope('Internal')]
    procedure CheckResourceEntry(ProjectNo: Code[20]; MainProject: Boolean)
    var
        ProjectTask: Record "Job Task";
        WBS: Record WBS;
        ResourceRequirment: Record "Resource Requirment";
        Txt00001: Label 'Please Enter Resource Requirment for this Project No. %1, Milestone %2 and WBS ID %3.';
        Txt00002: Label 'Please Enter Resource Requirment for this Project No. %1,and WBS ID %2.';
        Txt00003: Label 'Please Enter WBS for this Project No. %1,and Milestone %2.';
    begin
        IF MainProject = TRUE THEN BEGIN
            ProjectTask.SETRANGE("Job No.", ProjectNo);
            ProjectTask.SETFILTER(Amount, '<>%1', 0);
            ProjectTask.SETFILTER("Balance Amount", '<>%1', 0);
            IF ProjectTask.FINDSET THEN
                REPEAT
                    IF NOT ProjectTask."Approval Stage Skip" THEN BEGIN //AD_REPL
                        IF ProjectTask."Planned Bill Date" > 20180430D THEN BEGIN
                            IF ProjectTask.Amount = ProjectTask."Balance Amount" THEN BEGIN
                                WBS.SETRANGE("Project No.", ProjectNo);
                                WBS.SETRANGE(Milestone, ProjectTask.Milestone);
                                IF WBS.FINDSET THEN BEGIN
                                    REPEAT
                                        ResourceRequirment.SETRANGE("Project No.", ProjectNo);
                                        ResourceRequirment.SETRANGE(Milestone, ProjectTask.Milestone);
                                        ResourceRequirment.SETRANGE("WBS Id", WBS."WBS Id");
                                        IF NOT ResourceRequirment.FINDFIRST THEN
                                            ERROR(Txt00001, ProjectNo, ProjectTask.Milestone, WBS."WBS Id");
                                    UNTIL WBS.NEXT = 0;
                                END ELSE BEGIN
                                    ERROR(Txt00003, ProjectNo, ProjectTask.Milestone);
                                END;
                            END;
                        END;
                    END;//AD_REPL
                UNTIL ProjectTask.NEXT = 0;

        END ELSE BEGIN
            WBS.SETRANGE("Project No.", ProjectNo);
            WBS.SETRANGE(Milestone, '');
            IF WBS.FINDSET THEN
                REPEAT
                    ResourceRequirment.SETRANGE("Project No.", ProjectNo);
                    ResourceRequirment.SETRANGE(Milestone, '');
                    ResourceRequirment.SETRANGE("WBS Id", WBS."WBS Id");
                    IF NOT ResourceRequirment.FINDFIRST THEN
                        ERROR(Txt00002, ProjectNo, WBS."WBS Id");
                UNTIL WBS.NEXT = 0;
        END;
    end;

    // [Scope('Internal')]
    procedure ValidateProjectPlanningLine(ProjectTask2: Record "Job Task") PlanningLine: Boolean
    var
        ProjectPlanLine: Record "Job Planning Line";
    begin
        ProjectPlanLine.SETRANGE("Job No.", ProjectTask2."Job No.");
        // ProjectPlanLine.SETRANGE("Job Task No.", ProjectTask2."Job Task No.");
        ProjectPlanLine.SETRANGE(MileStone, ProjectTask2.Milestone);
        IF ProjectPlanLine.FINDFIRST THEN
            PlanningLine := TRUE
        ELSE
            PlanningLine := FALSE;

        EXIT(PlanningLine);
    end;

    //[Scope('Internal')]
    procedure MaintainApprovedStatus(ProjectNo: Code[20])
    var
        ProjectTask: Record "Job Task";
        ProjectContacts: Record "Project Contacts";
        WBS: Record WBS;
        ResourceRequirment: Record "Resource Requirment";
    begin
        ProjectTask.SETRANGE("Job No.", ProjectNo);
        ProjectTask.SETRANGE(Approved, FALSE);
        IF ProjectTask.FINDSET THEN
            REPEAT
                ProjectTask.Approved := TRUE;
                ProjectTask."Approved Date" := WORKDATE;
                ProjectTask.MODIFY;
            UNTIL ProjectTask.NEXT = 0;
        ProjectContacts.SETRANGE("Project Code", ProjectNo);
        ProjectContacts.SETRANGE(Approved, FALSE);
        IF ProjectContacts.FINDSET THEN
            REPEAT
                ProjectContacts.Approved := TRUE;
                ProjectContacts."Approved Date" := WORKDATE;
                ProjectContacts.MODIFY;
            UNTIL ProjectContacts.NEXT = 0;
        WBS.SETRANGE("Project No.", ProjectNo);
        WBS.SETRANGE(Approved, FALSE);
        IF WBS.FINDSET THEN
            REPEAT
                WBS.Approved := TRUE;
                WBS."Approved Date" := WORKDATE;
                WBS.MODIFY;
            UNTIL WBS.NEXT = 0;
        ResourceRequirment.SETRANGE("Project No.", ProjectNo);
        ResourceRequirment.SETRANGE(Approved, FALSE);
        IF ResourceRequirment.FINDSET THEN
            REPEAT
                ResourceRequirment.Approved := TRUE;
                ResourceRequirment."Approved Date" := WORKDATE;
                ResourceRequirment.MODIFY;
            UNTIL ResourceRequirment.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure ShortClose(var ProjectsHeader: Record Job)
    begin
        CheckSubProjectStatus(ProjectsHeader."No.");

        IF ProjectsHeader."Project Status" = ProjectsHeader."Project Status"::"Short close" THEN
            EXIT;
        SendShortCloseEmail(ProjectsHeader);
        ProjectsHeader."Project Status" := ProjectsHeader."Project Status"::"Short close";
        //AD_REPL
        IF ProjectCharter.GET(ProjectsHeader."Project Charter No.") THEN BEGIN
            ProjectCharter.Status := ProjectCharter.Status::"Short close";
            ProjectCharter.MODIFY;
        END;
        //AD_REPL
        ProjectCharter.MODIFY(TRUE);

    end;

    //[Scope('Internal')]
    procedure CheckSubProjectStatus(ProjectCode: Code[20])
    var
        Project: Record Job;
    begin
        Project.SETRANGE("Parent Project Code", ProjectCode);
        IF Project.FINDSET THEN
            REPEAT
                IF Project."Project Status" <> Project."Project Status"::"Short close" THEN
                    Project.TESTFIELD("Project Status", Project."Project Status"::"Short close");
            UNTIL Project.NEXT = 0;
    end;

    //[Scope('Internal')]
    procedure CompletedStatus(var ProjectsHeader: Record Job)
    begin
        CheckBalanceAmountBeforeCompleted(ProjectsHeader."No.");//S.01
        CheckInvoiceAmountBeforeCompleted(ProjectsHeader."No.");
        CheckCompletedSubProjectStatus(ProjectsHeader."No.");

        IF ProjectsHeader."Project Status" = ProjectsHeader."Project Status"::Completed THEN
            EXIT;
        SendCompleteEmail(ProjectsHeader);
        ProjectsHeader."Project Status" := ProjectsHeader."Project Status"::Completed;
        //AD_REPL
        IF ProjectCharter.GET(ProjectsHeader."Project Charter No.") THEN BEGIN
            ProjectCharter.Status := ProjectCharter.Status::Completed;
            ProjectCharter.MODIFY;
        END;
        //AD_REPL
        ProjectsHeader.MODIFY(TRUE);
    end;

    //[Scope('Internal')]
    procedure CheckCompletedSubProjectStatus(ProjectCode: Code[20])
    var
        Project: Record Job;
    begin
        Project.SETRANGE("Parent Project Code", ProjectCode);
        IF Project.FINDSET THEN
            REPEAT
                IF Project."Project Status" <> Project."Project Status"::Completed THEN
                    Project.TESTFIELD("Project Status", Project."Project Status"::Completed);
            UNTIL Project.NEXT = 0;
    end;


    procedure CheckInvoiceAmountBeforeCompleted(ProjectCode: Code[20])
    var
        ProjectPlanningLine: Record "Job Planning Line";
    begin
        ProjectPlanningLine.SETRANGE("Job No.", ProjectCode);
        IF ProjectPlanningLine.FINDSET THEN
            REPEAT
                ProjectPlanningLine.CALCFIELDS(ProjectPlanningLine."Invoice Amount");
                IF ProjectPlanningLine."Invoice Amount" <> 0 THEN
                    ERROR('You cannot complete because invoice is pending');
            UNTIL ProjectPlanningLine.NEXT = 0;
    end;

    procedure CheckTimeSheetDetails(ProjectNo: Code[20])
    var
        ResourceRequirment: Record "Resource Requirment";
        TimeSheetDetail: Record "Time Sheet Detail";
        Counter: Integer;
        TimeSheetHeader: Record "Time Sheet Header";
        ProjectTask: Record "Job Task";
    begin
        Counter := 0;
        //ProjectTask.SETRANGE("Project No.",ProjectNo);
        //ProjectTask.SETFILTER(Amount,'<>%1',0);
        //ProjectTask.SETFILTER("Balance Amount",'<>%1',0);
        //IF ProjectTask.FINDSET THEN begin
        // REPEAT
        // IF ProjectTask."Planned Bill Date" > 300417D THEN BEGIN
        //  IF ProjectTask.Amount = ProjectTask."Balance Amount" THEN BEGIN
        //    WBS.SETRANGE("Project No.",ProjectNo);
        //    WBS.SETRANGE(Milestone,ProjectTask.Milestone);
        //    IF WBS.FINDSET THEN BEGIN
        //     REPEAT
        //        Until (WBS.Next =0) or (Counter = 1);
        //      end;
        //    end;
        //    end;
        //  Until (ProjectTask.Next =0) or (Counter = 1);
        //end;

        ResourceRequirment.SETRANGE("Project No.", ProjectNo);
        ResourceRequirment.SETFILTER(Resource, '<>%1', '');
        ResourceRequirment.SETFILTER(Usage, '<>%1', 0);
        IF ResourceRequirment.FINDSET THEN
            REPEAT
                ResourceRequirment.CALCFIELDS("Milestone Bal. Amount"); //AD_REPL
                IF ResourceRequirment."Milestone Bal. Amount" <> 0 THEN BEGIN //AD_REPL
                    TimeSheetHeader.RESET;
                    TimeSheetHeader.SETRANGE("Project No.", ProjectNo);
                    TimeSheetHeader.SETRANGE("Resource No.", ResourceRequirment.Resource);
                    TimeSheetHeader.SETRANGE(Milestone, ResourceRequirment.Milestone);
                    TimeSheetHeader.SETRANGE("WBS Id", ResourceRequirment."WBS Id");
                    TimeSheetHeader.SETRANGE("Task Code", ResourceRequirment."Task Code"); //AD_REPL
                    TimeSheetHeader.SETRANGE("Task Group", ResourceRequirment."Task Group"); //AD_REPL
                    IF NOT TimeSheetHeader.FINDFIRST THEN BEGIN
                        //AD_REPL
                        ProjectTask.RESET;
                        ProjectTask.SETRANGE("Job No.", ProjectNo);
                        ProjectTask.SETRANGE(Milestone, ResourceRequirment.Milestone);
                        ProjectTask.SETRANGE("Approval Stage Skip", FALSE);
                        IF ProjectTask.FINDFIRST THEN BEGIN
                            //AD_REPL
                            Counter += 1;
                            ERROR('Please create time sheet for resource no. %1, Project No.: %2, Milestone No.: %3, WBS ID: %4,Task Code: %5 Task Group: %6',
                             ResourceRequirment.Resource, ResourceRequirment."Project No.", ResourceRequirment.Milestone, ResourceRequirment."WBS Id",
                             ResourceRequirment."Task Code", ResourceRequirment."Task Group");
                        END;//AD_REPL
                    END;
                END;
            UNTIL (ResourceRequirment.NEXT = 0) OR (Counter = 1);
    end;


    procedure GetFinanaceBook() FinanceBook: Code[20]
    var
        UserSetup: Record "User Setup";
        RespCenter: Record "Responsibility Center";
    begin
        FinanceBook := '';
        IF COMPANYNAME = 'REPL' THEN BEGIN
            UserSetup.GET(USERID);
            IF NOT UserSetup."Admin User" THEN BEGIN
                IF UserSetup."Responsibility Center" <> '' THEN BEGIN
                    IF UserSetup."Responsibility Center" <> 'DELHPFB' THEN BEGIN
                        IF RespCenter.GET(UserSetup."Responsibility Center") THEN
                            FinanceBook := RespCenter."Global Dimension 2 Code";
                    END;
                END;
            END;
            EXIT(FinanceBook);
        END ELSE
            EXIT(FinanceBook);
    end;

    //[Scope('Internal')]
    procedure GetPlanningLineNo(ProjectNo: Code[20]) LineNo: Integer
    var
        ProjectPlanLine: Record "Job Planning Line";
    begin
        ProjectPlanLine.RESET;
        ProjectPlanLine.SETRANGE("Job No.", ProjectNo);
        //ProjectPlanLine.SETRANGE("Job Task No.", ProjectNo);
        IF ProjectPlanLine.FINDLAST THEN
            LineNo := ProjectPlanLine."Line No." + 10000
        ELSE
            LineNo := 10000;
    end;

    //[Scope('Internal')]
    procedure SendShortCloseEmail(Project: Record Job)
    var
        Subject: Text;
        Body: Text;
        UserSetup: Record "User Setup";
        ReceiverEmail: Text;
        SMTPMail: Codeunit Mail;
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
    begin
        Subject := 'For Project Short Close' + ' ' + Project."No.";
        Body := ('</B>' + 'Dear Sir/Madam,'
        + '</BR><BR><BR>' + 'Project Code ' + Project."No." + ' has been initiated as Short Close, Please check all relevent transactions must be completed: '
        + '</B><BR><BR>' + 'Regards,' + '</B><BR>' + 'REPL'
        + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        UserSetup.GET(USERID);
        IF UserSetup1.GET(Project."Project Manager") THEN
            ReceiverEmail := UserSetup1."E-Mail";
        IF UserSetup2.GET(Project."Responsible Person") THEN
            IF UserSetup2."E-Mail" <> '' THEN
                ReceiverEmail += ';' + UserSetup2."E-Mail";

        // SMTPMail.CreateMessage('REPL', UserSetup."E-Mail", ReceiverEmail, Subject, Body, TRUE);

        // SMTPMail.AddCC('manish.raushan@repl.global;prakasharya@repl.global;kailash@repl.global;manoj.kumar@repl.global;anubhav@repl.global');
        //SMTPMail.Send;     //S.01
    end;

    // [Scope('Internal')]
    procedure SendCompleteEmail(Project: Record Job)
    var
        Subject: Text;
        Body: Text;
        UserSetup: Record "User Setup";
        ReceiverEmail: Text;
        SMTPMail: Codeunit Mail;
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
    begin
        Subject := 'For Project Complete' + ' ' + Project."No.";
        Body := ('</B>' + 'Dear Sir/Madam,'
        + '</BR><BR><BR>' + 'Project Code ' + Project."No." + ' has been initiated as Completed, Please check all relevent transactions must be completed: '
        + '</B><BR><BR>' + 'Regards,' + '</B><BR>' + 'REPL'
        + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        UserSetup.GET(USERID);
        IF UserSetup1.GET(Project."Project Manager") THEN
            ReceiverEmail := UserSetup1."E-Mail";
        IF UserSetup2.GET(Project."Responsible Person") THEN
            IF UserSetup2."E-Mail" <> '' THEN
                ReceiverEmail += ';' + UserSetup2."E-Mail";



        //        SMTPMail.CreateMessage(UserSetup."E-Mail"; 'manish.raushan@repl.global'
        //      prakasharya@repl.global;
        //    kailash@repl.global;
        //  manoj.kumar@repl.global;
        //  anubhav@repl.global'; ReceiverEmail, Subject, Body, TRUE, true);


        //SMTPMail.Send;    //S.01

    end;


    procedure "---S.01------"()
    begin
    end;


    procedure CheckBalanceAmountBeforeCompleted(ProjectCode: Code[20])
    var
        ProjectTask: Record "Job Task";
    begin
        ProjectTask.SETRANGE("Job No.", ProjectCode);
        ProjectTask.SETRANGE("Type Of Project", ProjectTask."Type Of Project"::"Main Project");
        IF ProjectTask.FINDSET THEN
            REPEAT
                // ProjectTask.CALCFIELDS(ProjectTask."Balance Amount");
                IF ProjectTask."Balance Amount" <> 0 THEN
                    ERROR('You cannot complete because invoice is pending');
            UNTIL ProjectTask.NEXT = 0;
    end;
}

