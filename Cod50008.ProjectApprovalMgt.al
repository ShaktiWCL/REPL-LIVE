codeunit 50008 "Project Approval Mgt"
{
    trigger OnRun()
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendRequestForApproval(var Project: Record Job)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelRequestForApproval(var Project: Record Job)
    begin
    end;

    procedure IsProjectEnabled(var Project: Record Job): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "Project WorkFlow Mgt";
    begin
        exit(WFMngt.CanExecuteWorkflow(Project, WFCode.RunWorkflowOnSendProjectApprovalCode()))
    end;

    local procedure CheckWorkflowEnabled(): Boolean
    var
        Project: Record Job;
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsProjectEnabled(Project) then
            Error(NoWorkflowEnb);
    end;
}
