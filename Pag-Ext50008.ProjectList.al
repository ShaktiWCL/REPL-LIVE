pageextension 50008 ProjectList extends "Job List"
{
    Caption = 'Project List';
    layout
    {
        addafter("No.")
        {
            Field("Project Name"; Rec."Project Name")
            {
                ApplicationArea = all;
            }
            field("Project Name 2"; Rec."Project Name 2")
            {
                ApplicationArea = all;
            }
            field("Old Project Code(Ramco)"; Rec."Old Project Code(Ramco)")
            {
                ApplicationArea = all;
            }
            field("Agreement No."; Rec."Agreement No.")
            {
                ApplicationArea = all;
            }
            field("Bill-to Name"; Rec."Bill-to Name")
            {
                ApplicationArea = all;
            }
            field("Project Value"; Rec."Project Value")
            {
                ApplicationArea = all;
            }
            field("Estimated Project Cost"; Rec."Estimated Project Cost")
            {
                ApplicationArea = all;
            }
            field("Budgeted Cost"; Rec."Budgeted Cost")
            {
                ApplicationArea = all;
            }
            field("Balance For Invoice"; Rec."Balance For Invoice")
            {
                ApplicationArea = all;
            }
            field("Starting Date"; Rec."Starting Date")
            {
                ApplicationArea = all;
            }
            field("Ending Date"; Rec."Ending Date")
            {
                ApplicationArea = all;
            }
            field(Sector; Rec.Sector)
            {
                ApplicationArea = all;
            }

            field("Project Status"; Rec."Project Status")
            {
                ApplicationArea = all;
            }
            field("Is Project Live"; Rec."Is Project Live")
            {
                ApplicationArea = all;
            }
            field("Type Of Project"; Rec."Type Of Project")
            {
                ApplicationArea = all;
            }
            field("Old Customer Code"; Rec."Old Customer Code")
            {
                ApplicationArea = all;
            }
            field("Old Customer Name"; Rec."Old Customer Name")
            {
                ApplicationArea = all;
            }
            field("Client Project Name"; Rec."Client Project Name")
            {
                ApplicationArea = all;
            }
            field("Parent Project's OU"; Rec."Parent Project's OU")
            {
                ApplicationArea = all;
            }
            field("Parent Project Code"; Rec."Parent Project Code")
            {
                ApplicationArea = all;
            }
            field("Parent Project Name"; Rec."Parent Project Name")
            {
                ApplicationArea = all;
            }
            field("Project Manager Name"; Rec."Project Manager Name")
            {
                ApplicationArea = all;
            }
            field("Head Of Department"; Rec."Head Of Department")
            {
                ApplicationArea = all;
                Caption = 'Sector Head';
            }
            field("HOD Name"; Rec."HOD Name")
            {
                ApplicationArea = all;
                Caption = 'Sector Head Name';
            }
            field("Manager Department"; Rec."Manager Department")
            {
                ApplicationArea = all;
            }
            field("Reference Proposal ID"; Rec."Reference Proposal ID")
            {
                ApplicationArea = all;
            }
            field("Revised On"; Rec."Revised On")
            {
                ApplicationArea = all;
            }
            field("No. of Archived Versions"; Rec."No. of Archived Versions")
            {
                ApplicationArea = all;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = all;
            }
            field("Temporary Status"; Rec."Temporary Status")
            {
                ApplicationArea = all;
            }
            field("Project Charter No."; Rec."Project Charter No.")
            {
                ApplicationArea = all;
            }
            field("Actual Lattest Bill Date"; Rec."Actual Lattest Bill Date")
            {
                ApplicationArea = all;
            }
            field("BD Charter No."; Rec."BD Charter No.")
            {
                ApplicationArea = all;
            }
            field("Agreement From Date"; Rec."Agreement From Date")
            {
                ApplicationArea = all;
            }
            field("Agreement To Date"; Rec."Agreement To Date")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        addbefore("Job Task &Lines")
        {
            action("View OU")
            {
                ApplicationArea = All;
                Caption = 'View OU', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ViewPage;
                trigger OnAction()
                begin
                    PAge.Run(Page::"View OU");
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        //AD_REPL
        IF GetHOD <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Head of Department", GetProjectManager);
            Rec.SETFILTER("Project Status", '<>%1', Rec."Project Status"::Draft);
            Rec.FILTERGROUP(0);
        END;
        //AD_REPL
        IF GetHOD = '' THEN BEGIN //AD_REPL
            IF GetProjectManager <> '' THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETFILTER("Project Manager", GetProjectManager);
                Rec.SETFILTER("Project Status", '<>%1', Rec."Project Status"::Draft);
                Rec.FILTERGROUP(0);
            END;
        END; //AD_REPL

        UserSetup.GET(USERID);
        IF UserSetup."Responsibility Center" <> '' THEN BEGIN
            IF UserSetup."Responsibility Center" <> 'DELHPFB' THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETFILTER("Responsibility Center", '%1', UserSetup."Responsibility Center");
                Rec.FILTERGROUP(0);
            END;
        END;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec."Actual Lattest Bill Date" := Rec.GetLatestBillDate(Rec."No.");
    end;

    procedure GetProjectManager() ProjectManagerCode: Text
    var
        Employee: Record Employee;
    begin
        Employee.SETRANGE("Nav User Id", USERID);
        Employee.SETFILTER("Project Manager", '%1', TRUE);
        Employee.SETFILTER("Admin User", '%1', FALSE);
        IF Employee.FINDSET THEN
            REPEAT
                IF ProjectManagerCode <> '' THEN
                    ProjectManagerCode := ProjectManagerCode + '|' + Employee."No."
                ELSE
                    ProjectManagerCode := Employee."No.";
            UNTIL Employee.NEXT = 0;

        EXIT(ProjectManagerCode);
    end;

    procedure GetHOD() ProjectManagerCode: Text
    var
        Employee: Record Employee;
    begin
        Employee.SETRANGE("Nav User Id", USERID);
        Employee.SETFILTER("Head of Department", '%1', TRUE);
        Employee.SETFILTER("Project Manager", '%1', TRUE);
        Employee.SETFILTER("Admin User", '%1', FALSE);
        IF Employee.FINDSET THEN
            REPEAT
                IF ProjectManagerCode <> '' THEN
                    ProjectManagerCode := ProjectManagerCode + '|' + Employee."No."
                ELSE
                    ProjectManagerCode := Employee."No.";
            UNTIL Employee.NEXT = 0;

        EXIT(ProjectManagerCode);
    end;
}
