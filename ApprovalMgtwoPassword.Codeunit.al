codeunit 50004 "Approval Mgt. w/o Password"
{

    trigger OnRun()
    begin
    end;

    procedure ApproveApprovalRequest(var CharterNo: Text; var IsApproved: Boolean; var IsReject: Boolean)
    var
        ProjectCharter: Record "Project Charter";
    begin
        IF IsApproved THEN BEGIN
            ProjectCharter.RESET;
            ProjectCharter.SETFILTER("Project Charter No.", '%1', CharterNo);
            IF ProjectCharter.FINDFIRST THEN BEGIN
                ProjectCharter."Project Name 2" := 'Approved';
                ProjectCharter.MODIFY;
            END;
        END;
        IF IsReject THEN BEGIN
            ProjectCharter.RESET;
            ProjectCharter.SETRANGE("Project Charter No.", CharterNo);
            IF ProjectCharter.FINDFIRST THEN BEGIN
                ProjectCharter."Project Name 2" := 'Reject';
                ProjectCharter.MODIFY;
            END;
        END;
    end;
}

