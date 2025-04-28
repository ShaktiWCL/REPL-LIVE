codeunit 50009 "Project WorkFlow Mgt"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendProjectReq: TextConst ENU = 'Approval Request for Project is requested', ENG = 'Approval Request for Project is requested';
        AppReqProject: TextConst ENU = 'Approval Request for Project is approved', ENG = 'Approval Request for Project is approved';
        RejReqProject: TextConst ENU = 'Approval Request for Project is rejected', ENG = 'Approval Request for Project is rejected';
        DelReqProject: TextConst ENU = 'Approval Request for Project is delegated', ENG = 'Approval Request for Project is delegated';
        SendForPendAppTxt: TextConst ENU = 'Status of Project changed to Pending approval', ENG = 'Status of Project changed to Pending approval';
        ReleaseProjectTxt: TextConst ENU = 'Release Project', ENG = 'Release Project';
        ReOpenProjectTxt: TextConst ENU = 'ReOpen Project', ENG = 'ReOpen Project';
        RelesedProjectDocument: Codeunit "Release Project Document";

    procedure RunWorkflowOnSendProjectApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendProjectApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Project Approval Mgt", 'OnSendRequestForApproval', '', false, false)]
    procedure RunWorkflowOnSendProjectApproval(var Project: Record Job)
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendProjectApprovalCode(), Project);
    end;

    procedure RunWorkflowOnApproveProjectApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveProjectApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveProjectApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveProjectApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectProjectApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectProjectApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectProjectApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectProjectApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateProjectApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateProjectApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateProjectApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateProjectApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeProject(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalProject'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendApprovalRequestFromRecordOnBeforeFindApprovedApprovalEntryForWorkflowUserGroup', '', false, false)]
    procedure OnSendApprovalRequestFromRecordOn(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        ReRef: RecordRef;
        Project: Record Job;
    begin
        ReRef.Get(ApprovalEntry."Record ID to Approve");
        case ReRef.Number() of
            Database::Job:
                begin
                    ReRef.SetTable(Project);
                    ApprovalEntry."Approver ID" := Project."Project Manager1";
                    ApprovalEntry.Status := ApprovalEntry.Status::Open;
                    ApprovalEntry.Modify();
                end;
        end;
    end;

    procedure SetStatusToPendingApprovalProject(var Variant: Variant)
    var
        RecRef: RecordRef;
        Project: Record Job;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::Job:
                begin
                    RecRef.SetTable(Project);
                    Project.Validate("Project Status", Project."Project Status"::"Pending for Approval");
                    Project.Modify();
                    Variant := Project;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApproveApprovalRequests', '', false, false)]
    local procedure OnBeforeApproveApprovalRequests2(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        _ApprovalEntry: Record "Approval Entry";
        _ApprovalEntry2: Record "Approval Entry";
        ApprovalLbl1: Label '1- Status..%1\DocNo..%2\EntryNo...%3\SeqNo...%4\ApprovID...%5\SendID....%6';
        ApprovalLbl2: Label '2- Status..%1\DocNo..%2\EntryNo...%3\SeqNo...%4\ApprovID...%5\SendID....%6';
    begin
        if (ApprovalEntry."Table ID" = 167) then begin

            //if ApprovalEntry.FindSet() then
            //repeat
            _ApprovalEntry.SetRange("Sequence No.", ApprovalEntry."Sequence No.");
            _ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
            if ApprovalEntry."Approval Type" <> ApprovalEntry."Approval Type"::"Workflow User Group" then
                _ApprovalEntry.SetFilter("Approver ID", '%1', UserId);
            if _ApprovalEntry.FindFirst() then begin
                repeat
                    _ApprovalEntry.Validate(Status, _ApprovalEntry.Status::Approved);
                    //_ApprovalEntry.Validate("Auto Approved Entry", true);
                    _ApprovalEntry.Modify(true);
                until _ApprovalEntry.Next() = 0;
            end;
            //until ApprovalEntry.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnApproveApprovalRequest', '', false, false)]

    procedure UpdateApprovalStatus(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        ProjectHeader: Record Job;
        LastAprovalEntry: Record "Approval Entry";
        LastAprovalEntry2: Record "Approval Entry";
        LastEntryApprovalFound: Boolean;
        Email: Codeunit Email;
    begin
        IF NOT RecRef.GET(ApprovalEntry."Record ID to Approve") THEN
            EXIT;
        LastEntryApprovalFound := False;
        LastAprovalEntry.RESET;
        LastAprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.");
        LastAprovalEntry.SetAscending("Sequence No.", TRUE);
        LastAprovalEntry.Setrange("Table ID", RecRef.Number);
        LastAprovalEntry.SETRANGE("Record ID to Approve", ApprovalEntry."Record ID to Approve");
        LastAprovalEntry.SetFilter("Approval Type", '%1', LastAprovalEntry."Approval Type"::"Workflow User Group");
        LastAprovalEntry.SetfILTER("Sequence No.", '%1', 3);
        IF LastAprovalEntry.FINDLAST THEN begin
            LastAprovalEntry2.Reset();
            LastAprovalEntry2.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.");
            LastAprovalEntry2.Setrange("Table ID", LastAprovalEntry."Table ID");
            LastAprovalEntry2.setrange("Document Type", LastAprovalEntry."Document Type");
            LastAprovalEntry2.SETRANGE("Document No.", LastAprovalEntry."Document No.");
            LastAprovalEntry2.setrange("Sequence No.", LastAprovalEntry."Sequence No.");
            LastAprovalEntry2.setrange(Status, LastAprovalEntry2.Status::Open);
            IF LastAprovalEntry2.FindLast() THEN BEGIN
                LastEntryApprovalFound := True;
            END;
        end;

        If (ApprovalEntry."Sequence No." = 2) or (ApprovalEntry."Approver ID" = UserId) then begin
            IF ProjectHeader.GET(RecRef.RECORDID) THEN BEGIN
                RelesedProjectDocument.Run(ProjectHeader);
                IF (ProjectHeader."Project Status" = ProjectHeader."Project Status"::"Pending for Approval") THEN begin
                    ProjectHeader.Validate("Project Status", ProjectHeader."Project Status"::Approved);
                    ProjectHeader.Modify();
                end;
                Message('Project Approved..%1', ProjectHeader."No.");

            end;

        end;
        UpdateApprovedEntryStatus(ApprovalEntry);
    end;

    procedure UpdateApprovedEntryStatus(ApprvalEntry2: Record "Approval Entry"): Code[100]
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetFilter("Approval Type", '%1', ApprovalEntry."Approval Type"::"Workflow User Group");
        ApprovalEntry.SetFilter("Sequence No.", '%1', ApprvalEntry2."Sequence No.");
        ApprovalEntry.SetRange("Record ID to Approve", ApprvalEntry2."Record ID to Approve");
        ApprovalEntry.ModifyAll(Status, ApprovalEntry.Status::Approved);
    end;
    //InReject
    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnAfterRejectSelectedApprovalRequest', '', false, false)]

    procedure UpdateApprovalStatusReject(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        ProjectHeader: Record Job;
        LastAprovalEntry: Record "Approval Entry";
        LastAprovalEntry2: Record "Approval Entry";
        LastEntryApprovalFound: Boolean;
        Email: Codeunit Email;
    begin
        IF NOT RecRef.GET(ApprovalEntry."Record ID to Approve") THEN
            EXIT;
        // LastEntryApprovalFound := False;
        // LastAprovalEntry.RESET;
        // LastAprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.");
        // LastAprovalEntry.SetAscending("Sequence No.", TRUE);
        // LastAprovalEntry.Setrange("Table ID", RecRef.Number);
        // LastAprovalEntry.SETRANGE("Record ID to Approve", ApprovalEntry."Record ID to Approve");
        // LastAprovalEntry.SetFilter("Approval Type", '%1', LastAprovalEntry."Approval Type"::"Workflow User Group");
        // LastAprovalEntry.SetfILTER("Sequence No.", '%1', 3);
        // IF LastAprovalEntry.FINDLAST THEN begin
        //     LastAprovalEntry2.Reset();
        //     LastAprovalEntry2.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.");
        //     LastAprovalEntry2.Setrange("Table ID", LastAprovalEntry."Table ID");
        //     LastAprovalEntry2.setrange("Document Type", LastAprovalEntry."Document Type");
        //     LastAprovalEntry2.SETRANGE("Document No.", LastAprovalEntry."Document No.");
        //     LastAprovalEntry2.setrange("Sequence No.", LastAprovalEntry."Sequence No.");
        //     LastAprovalEntry2.setrange(Status, LastAprovalEntry2.Status::Open);
        //     IF LastAprovalEntry2.FindLast() THEN BEGIN
        //         LastEntryApprovalFound := True;
        //     END;
        // end;

        If (ApprovalEntry."Sequence No." = 2) or (ApprovalEntry."Approver ID" = UserId) then begin
            IF ProjectHeader.GET(RecRef.RECORDID) THEN BEGIN
                IF (ProjectHeader."Project Status" = ProjectHeader."Project Status"::"Pending for Approval") THEN begin
                    ProjectHeader.Validate("Project Status", ProjectHeader."Project Status"::"Under Revision");
                    //ProjectHeader.Validate("Approver ID", ApprovalEntry."Approver ID");
                    //ProjectHeader."Approval Date" := Today;
                    ProjectHeader.Modify();
                end;
                Message('Project Reject..%1', ProjectHeader."No.");

            end;

        end;
        UpdateRejectedEntryStatus(ApprovalEntry);
    end;

    procedure UpdateRejectedEntryStatus(ApprvalEntry2: Record "Approval Entry"): Code[100]
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetFilter("Approval Type", '%1', ApprovalEntry."Approval Type"::"Workflow User Group");
        ApprovalEntry.SetFilter("Sequence No.", '%1', ApprvalEntry2."Sequence No.");
        ApprovalEntry.SetRange("Record ID to Approve", ApprvalEntry2."Record ID to Approve");
        ApprovalEntry.ModifyAll(Status, ApprovalEntry.Status::Rejected);
    end;
    //IReject

    procedure ReleaseProjectCode(): Code[128]
    begin
        exit(UpperCase('ReleaseProject'));
    end;

    procedure ReleaseProject(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Project: Record Job;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseProject(Variant);
                end;
            DATABASE::JOb:
                begin
                    RecRef.SetTable(Project);
                    RelesedProjectDocument.Run(Project);
                    Project.Validate("Project Status", Project."Project Status"::Approved);
                    // Project.Validate("Approval Date", Today);
                    // Project.Validate("Approver ID", UserId);
                    Project.Modify();
                    Variant := Project;
                end;
        end;
    end;

    procedure ReOpenProjectCode(): Code[128]
    begin
        exit(UpperCase('ReOpenProject'));
    end;

    procedure ReOpenProject(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Project: Record JOb;
        ApprovalComment: Record "Approval Comment Line";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");

                    Variant := TargetRecRef;
                    ReOpenProject(Variant);
                end;
            DATABASE::Job:
                begin
                    RecRef.SetTable(Project);
                    Project.Validate("Project Status", Project."Project Status"::"Under Revision");
                    // ApprovalComment.SetRange("Table ID", 50003);
                    // ApprovalComment.SetRange("Workflow Step Instance ID", ApprovalEntry."Workflow Step Instance ID");
                    // ApprovalComment.SetRange("Record ID to Approve", ApprovalEntry."Record ID to Approve");
                    // if ApprovalComment.FindFirst() then
                    //     repeat
                    //         Project."Rejection Comments" += ApprovalComment.Comment;
                    //     until ApprovalComment.next = 0;

                    Project.Modify();
                    Variant := Project;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddProjectEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendProjectApprovalCode(), Database::Job, SendProjectReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveProjectApprovalCode(), Database::"Approval Entry", AppReqProject, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectProjectApprovalCode(), Database::"Approval Entry", RejReqProject, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateProjectApprovalCode(), Database::"Approval Entry", DelReqProject, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddProjectRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeProject(), 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseProjectCode(), 0, ReleaseProjectTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenProjectCode(), 0, ReOpenProjectTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForProject(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeProject():
                    begin
                        SetStatusToPendingApprovalProject(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseProjectCode():
                    begin
                        ReleaseProject(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenProjectCode():
                    begin
                        ReOpenProject(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


}
