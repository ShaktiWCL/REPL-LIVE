pageextension 50012 "Prject Task Lines" extends "Job Task Lines"
{
    Caption = 'Project Task Lines';
    layout
    {
        modify("Job Task No.")
        {
            Visible = false;
        }
        modify(Description)
        {
            Visible = false;
        }
        modify("Job Task Type")
        {
            Visible = false;
        }
        modify("Start Date")
        {
            Visible = false;
        }
        modify("End Date")
        {
            Visible = false;
        }

        addafter("Job Task Type")
        {
            field(MileStone; Rec.MileStone)
            {
                ApplicationArea = all;
            }
            field("Transmittal No."; Rec."Transmittal No.")
            {
                ApplicationArea = all;
            }
            field("Milestone Desc"; Rec."Milestone Desc")
            {
                ApplicationArea = all;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = all;
            }
            field("Invoice Amount"; Rec."Invoice Amount")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Balance Amount"; Rec."Balance Amount")
            {
                ApplicationArea = all;
            }
            field("Milestone Stages"; Rec."Milestone Stages")
            {
                ApplicationArea = all;
            }
            field("Planned Bill Date"; Rec."Planned Bill Date")
            {
                ApplicationArea = all;
            }
            field("Revised Billing Date"; Rec."Revised Billing Date")
            {
                ApplicationArea = all;
            }
            field("Actual Latest Bill Date"; Rec."Actual Latest Bill Date")
            {
                ApplicationArea = all;
            }
            field("WBS Id"; Rec."WBS Id")
            {
                ApplicationArea = all;
            }
            field("Task Code"; Rec."Task Code")
            {
                ApplicationArea = all;
            }
            field("Balance Amount(Credit)"; Rec."Balance Amount(Credit)")
            {
                ApplicationArea = all;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = all;
            }
            field(Type; Rec.Type)
            {
                ApplicationArea = all;
            }
            field("Account No."; Rec."Account No.")
            {
                ApplicationArea = all;
            }
        }
        modify(Totaling)
        {
            Visible = false;
        }
        modify("WIP Method")
        {
            Visible = false;
        }
        modify("WIP-Total")
        {
            Visible = false;
        }
        modify("Job Posting Group")
        {
            Visible = false;
        }
        modify("Schedule (Total Cost)")
        {
            Visible = false;
        }
        modify("Schedule (Total Price)")
        {
            Visible = false;
        }
        modify("Usage (Total Cost)")
        {
            Visible = false;
        }
        modify("Usage (Total Price)")
        {
            Visible = false;
        }
        modify("Contract (Invoiced Cost)")
        {
            Visible = false;
        }
        modify("Contract (Total Cost)")
        {
            Visible = false;
        }
        modify("Contract (Total Price)")
        {
            Visible = false;
        }
        modify("EAC (Total Cost)")
        {
            Visible = false;

        }
        modify("EAC (Total Price)")
        {
            Visible = false;
        }
        modify("Remaining (Total Cost)")
        {
            Visible = false;
        }
        modify("Remaining (Total Price)")
        {
            Visible = false;
        }

    }

    actions
    {
        modify(JobPlanningLines)
        {
            Visible = false;
        }
        addafter(JobPlanningLines)
        {

            group("Project Planning Line")
            {
                action(ProjectPlanningLines)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Project &Planning Lines';
                    Image = JobLines;
                    ToolTip = 'View all planning lines for the job. You use this window to plan what items, resources, and general ledger expenses that you expect to use on a job (budget) or you can specify what you actually agreed with your customer that they should pay for the job (billable).';
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        JobPlanningLine: Record "Job Planning Line";
                        JobPlanningLines: Page "Job Planning Lines";
                    begin
                        Rec.TestField("Job Task Type", Rec."Job Task Type"::Posting);
                        Rec.TestField("Job No.");
                        Rec.TestField("Job Task No.");
                        JobPlanningLine.FilterGroup(2);
                        JobPlanningLine.SetRange("Job No.", Rec."Job No.");
                        //JobPlanningLine.SetRange("Job Task No.", Rec."Job Task No.");
                        JobPlanningLine.FilterGroup(0);
                        JobPlanningLines.SetJobTaskNoVisible(false);
                        JobPlanningLines.SetTableView(JobPlanningLine);
                        JobPlanningLines.Run();
                    end;
                }
            }
        }
        addafter("F&unctions")
        {
            action(WBS)
            {
                Caption = 'WBS';
                ApplicationArea = All;
                RunObject = page WBS;
                RunPageLink = "Project No." = FIELD("Job No."), Milestone = FIELD(Milestone);
            }
            action("Create Transmittal Document")
            {
                Caption = 'Create Transmittal Document';
                ApplicationArea = All;
                trigger OnAction()
                var
                    GetProject: Record Job;
                    ProjectTask: Record "Job Task";
                    RecProject: Record Job;
                    RespCenter: Record "Responsibility Center";
                    TransmitalHeader: Record "Transmital Header";
                    TransmitalDetails: Record "Transmital Details";
                    EntryNo: Integer;
                begin
                    IF Rec."Planned Bill Date" < TODAY THEN
                        ERROR('Transmittal cannot be created after Planned Bill Date');

                    GetProject.GET(Rec."Job No.");
                    IF GetProject."Temporary Status" <> GetProject."Temporary Status"::" " THEN
                        ERROR('You cannot perform this activity because the Temporary Status of Project No. %1 is In-Active', GetProject."No.");
                    //AD_REPL
                    IF CONFIRM('Do you want to create transmittal Doc ?', TRUE) THEN BEGIN
                        CurrPage.SETSELECTIONFILTER(ProjectTask);
                        IF ProjectTask.FINDFIRST THEN BEGIN
                            TransmitalHeader.INIT;
                            TransmitalHeader."Transmital No." := '';
                            TransmitalHeader."Document Date" := WORKDATE;
                            TransmitalHeader."Project No." := ProjectTask."Job No.";
                            IF ProjectTask."Job No." <> '' THEN BEGIN
                                IF RecProject.GET(ProjectTask."Job No.") THEN
                                    IF RespCenter.GET(RecProject."Responsibility Center") THEN
                                        TransmitalHeader.Place := RespCenter.Name;
                                TransmitalHeader."Responsibility Center" := RecProject."Responsibility Center";
                            END;
                            TransmitalHeader."Project Name" := ProjectTask."Project Name";
                            TransmitalHeader.VALIDATE("Customer No.", ProjectTask."Customer No.");
                            TransmitalHeader."MileStone No." := ProjectTask.Milestone;
                            TransmitalHeader."MileStone Desc" := ProjectTask."Milestone Desc";
                            TransmitalHeader.INSERT(TRUE);
                            REPEAT
                                IF TransmitalDetails.FINDLAST THEN
                                    EntryNo := TransmitalDetails."Entry No." + 1
                                ELSE
                                    EntryNo := 1;
                                TransmitalDetails.INIT;
                                TransmitalDetails."Entry No." := EntryNo;
                                TransmitalDetails."Project Code" := ProjectTask."Job No.";
                                TransmitalDetails.Milestone := ProjectTask.Milestone;
                                TransmitalDetails."Transmital No." := TransmitalHeader."Transmital No.";
                                TransmitalDetails.INSERT;
                                ProjectTask."Transmittal No." := TransmitalHeader."Transmital No.";
                                ProjectTask.MODIFY;
                            UNTIL ProjectTask.NEXT = 0;
                        END;
                    end;
                end;
            }
            action("View Transmittal Document")
            {
                Caption = 'View Transmittal Document';
                ApplicationArea = All;
                RunObject = page "Transmital Details";
                RunPageLink = "Project Code" = field("Job No."), Milestone = FIELD(Milestone);
            }

            action("Update In Charter")
            {
                Caption = 'Update In Charter';
                ApplicationArea = All;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    IF Rec.FINDFIRST THEN
                        REPEAT
                            ConvertIntoCharter(Rec);
                        UNTIL rec.NEXT = 0;
                end;
            }
            action("Revise Amount")
            {
                Caption = 'Revise Amount';
                ApplicationArea = All;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    MaintainProjectBalance(Rec."Job No.", Rec.Milestone);
                end;
            }
        }
    }

    local procedure ConvertIntoCharter(ProjectTask: Record "Job Task")
    var
        Project: Record Job;
        ProjectCharter: Record "Project Charter";
        ProjectMaitainMilestones: Record "Project Maitain Milestones";
    begin
        Project.GET(ProjectTask."Job No.");
        Project.TESTFIELD("Project Status", Project."Project Status"::"Under Revision");
        ProjectCharter.GET(Project."Project Charter No.");
        ProjectCharter.TESTFIELD(Status, ProjectCharter.Status::"Under Revision");
        ProjectMaitainMilestones.SETRANGE("Project Charter Code", Project."Project Charter No.");
        ProjectMaitainMilestones.SETRANGE(Milestone, ProjectTask.Milestone);
        IF NOT ProjectMaitainMilestones.FINDFIRST THEN BEGIN
            ProjectMaitainMilestones.INIT;
            ProjectMaitainMilestones."Project Charter Code" := Project."Project Charter No.";
            ProjectMaitainMilestones."Project Name" := ProjectCharter."Project Name";
            ProjectMaitainMilestones."Project Manager" := ProjectCharter."Project Manager";
            ProjectMaitainMilestones."Customer No." := ProjectCharter."Customer Code";
            ProjectMaitainMilestones.Milestone := ProjectTask.Milestone;
            ProjectMaitainMilestones."Project Type" := ProjectCharter."Type Of Project";
            ProjectMaitainMilestones."Milestone Desc" := ProjectTask."Milestone Desc";
            ProjectMaitainMilestones.VALIDATE(Amount, ProjectTask.Amount);
            ProjectMaitainMilestones."Customer Name" := ProjectCharter."Client Name";
            ProjectMaitainMilestones."Milestone Stages" := ProjectTask."Milestone Stages";
            ProjectMaitainMilestones."Planned Invoice Date" := ProjectTask."Planned Bill Date";
            ProjectMaitainMilestones.Remarks := ProjectTask.Remarks;
            ProjectMaitainMilestones.INSERT;
        END ELSE BEGIN
            ProjectMaitainMilestones.VALIDATE(Amount, ProjectTask.Amount);
            ProjectMaitainMilestones."Planned Invoice Date" := ProjectTask."Planned Bill Date";
            ProjectMaitainMilestones.Remarks := ProjectTask.Remarks;
            ProjectMaitainMilestones.MODIFY;
        END;
    end;

    procedure MaintainProjectBalance(ProjectNo: Code[20]; MileStone1: Code[40])
    var
        SalesLine: Record "Sales Line";
        Project: Record Job;
        BalAmount: Text;
        BalAmount1: Decimal;
        ProjectPlanningLine: Record "Job Planning Line";
        ProjectTask: Record "Job Task";
    begin
        SalesLine.SETRANGE("Job No.", ProjectNo);
        SalesLine.SETRANGE(Milestone, MileStone1);
        IF SalesLine.FINDFIRST THEN
            ERROR('Invoice No. %1 for this milestone already created,Please post it first', SalesLine."Document No.");

        Project.GET(ProjectNo);
        Project.TESTFIELD("Project Status", Project."Project Status"::"Under Revision");
        // BalAmount := Window.InputBox('Input Amount', 'INPUT', '', 100, 100); /S.01
        EVALUATE(BalAmount1, BalAmount);
        IF BalAmount1 > Rec."Balance Amount" THEN
            ERROR('You cannot enter greater then balance amount');
        IF BalAmount1 <> 0 THEN BEGIN
            ProjectPlanningLine.SETRANGE("Job No.", ProjectNo);
            ProjectPlanningLine.SETRANGE(MileStone, MileStone1);
            IF ProjectPlanningLine.FINDFIRST THEN BEGIN
                ProjectTask.SETRANGE("Job No.", ProjectNo);
                ProjectTask.SETRANGE(Milestone, ProjectPlanningLine.MileStone);
                IF ProjectTask.FINDFIRST THEN BEGIN
                    ProjectTask.Amount := ProjectTask.Amount - BalAmount1;
                    ProjectTask."Balance Amount" := ProjectTask."Balance Amount" - BalAmount1;
                    ProjectTask.MODIFY;
                END;
                ProjectPlanningLine."Milestone Amount" := ProjectPlanningLine."Milestone Amount" - BalAmount1;
                ProjectPlanningLine."Balance Amount" := ProjectPlanningLine."Balance Amount" - BalAmount1;
                ProjectPlanningLine.MODIFY;
            END;
        END ELSE
            ERROR('Please Enter Amount!');
    End;

    procedure IsPageEditable()
    var
        UserSetup: Record "User Setup";
        MilestoneEditable: Boolean;
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Project for Approval Sender" THEN
            MilestoneEditable := TRUE
        ELSE
            MilestoneEditable := FALSE
    end;

}

