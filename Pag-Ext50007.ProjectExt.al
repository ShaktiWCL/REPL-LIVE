pageextension 50007 ProjectExt extends "Job Card"
{
    Caption = 'Project Card';
    layout
    {
        modify("WIP and Recognition")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = false;
        }
        modify("Project Manager")
        {
            Visible = false;
        }
        modify("No.")
        {
            Editable = ProjectEditable;
        }
        modify("Currency Code")
        {
            Editable = ProjectEditable2;
        }
        modify("Bill-to Customer No.")
        {
            Editable = ProjectEditable;
        }
        addafter("No.")
        {
            field("Project Name"; Rec."Project Name")
            {
                Editable = ProjectEditable2;
                ApplicationArea = All;
            }
            field("Project Name 2"; Rec."Project Name 2")
            {
                Editable = ProjectEditable2;
                ApplicationArea = All;

            }
            field("Project Charter No."; Rec."Project Charter No.")
            {
                ApplicationArea = all;
            }
            field("BD Charter No."; Rec."BD Charter No.")
            {
                ApplicationArea = all;
            }
            field("Old Project Code(Ramco)"; Rec."Old Project Code(Ramco)")
            {
                ApplicationArea = all;

            }
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = all;
            }
            field("Head Of Department"; Rec."Head Of Department")
            {
                //Caption = 'Sector Head';
                Editable = ProjectEditable1;
                ApplicationArea = all;
            }
            field("HOD Name"; Rec."HOD Name")
            {
                //Caption = 'Sector Head Name';
                Editable = ProjectEditable1;
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
            field("Revised On"; Rec."Revised On")
            {
                ApplicationArea = all;
            }
            Field("Reason Code"; Rec."Reason Code")
            {
                Editable = ProjectEditable;
                ApplicationArea = all;
            }
            field(Sector; Rec.Sector)
            {
                ApplicationArea = all;
            }
            field("No. of Archived Versions"; Rec."No. of Archived Versions")
            {
                ApplicationArea = all;
            }
            field(Type; Rec.Type)
            {
                ApplicationArea = all;
            }
            field("Sub Type"; Rec."Sub Type")
            {
                ApplicationArea = all;
            }
            field("Responsible Person"; Rec."Responsible Person")
            {
                Editable = ProjectEditable;
                ApplicationArea = all;
            }
            field("Project Manager1"; Rec."Project Manager1")
            {
                //Editable = ProjectEditable2;
                ApplicationArea = all;
            }
            field("Manager Department"; Rec."Manager Department")
            {
                ApplicationArea = all;
            }
            field("Project Status"; Rec."Project Status")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Achived By"; Rec."Achived By")
            {
                ApplicationArea = all;

            }
            field("Client Project Name"; Rec."Client Project Name")
            {
                ApplicationArea = all;
                Editable = ProjectEditable;
            }
            field("Type Of Project"; Rec."Type Of Project")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Parent Project Code"; Rec."Parent Project Code")
            {
                ApplicationArea = all;
                Editable = false;

            }
            field("Parent Project Name"; Rec."Parent Project Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Structure; Rec.Structure)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Agreement No."; Rec."Agreement No.")
            {
                ApplicationArea = all;
                Editable = ProjectEditable2;
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = all;
                Editable = False;
            }
            field("Agreement From Date"; Rec."Agreement From Date")
            {
                ApplicationArea = all;
                Editable = ProjectEditable2;
            }
            field("Agreement To Date"; Rec."Agreement To Date")
            {
                ApplicationArea = all;
                Editable = ProjectEditable2;
            }
            field("Project Value"; Rec."Project Value")
            {
                ApplicationArea = all;
                Editable = ProjectEditable2;
            }
            field("Budgeted Cost"; Rec."Budgeted Cost")
            {
                ApplicationArea = all;
                Editable = ProjectEditable2;
            }
            field("Estimated Project Cost"; Rec."Estimated Project Cost")
            {
                ApplicationArea = all;
                Editable = ProjectEditable2;
            }
            field("Temporary Status"; Rec."Temporary Status")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Price Inclusive Service Tax"; Rec."Price Inclusive Service Tax")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Tender No."; Rec."Tender No.")
            {
                ApplicationArea = all;
            }
            field("Source Project No."; Rec."Source Project No.")
            {
                ApplicationArea = all;
            }
            field("Source Project Name"; Rec."Source Project Name")
            {
                ApplicationArea = all;
            }

        }


    }
    actions
    {
        addafter("&WIP Entries")
        {
            action(WBS)
            {
                ApplicationArea = All;
                Caption = 'WBS', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Task;
                PromotedOnly = true;
                trigger OnAction()
                var
                    WBS: Record WBS;
                    PageWBS: Page WBS;
                begin
                    DefaultDim.SETRANGE("Table ID", DATABASE::Job);
                    DefaultDim.SETRANGE("No.", rec."No.");
                    IF NOT DefaultDim.FINDFIRST THEN
                        ERROR('Please Enter Cost Center First!');
                    Rec.TESTFIELD("Parent Project Code");
                    Rec.TESTFIELD("Project Value");
                    Rec.TESTFIELD("Starting Date");
                    Rec.TESTFIELD("Ending Date");
                    Rec.TESTFIELD("Budgeted Cost");
                    Rec.TESTFIELD("Project Value");
                    Rec.TESTFIELD("Project Manager1");
                    Rec.TESTFIELD("Responsible Person");
                    WBS.SETRANGE("Project No.", Rec."No.");
                    PageWBS.SETTABLEVIEW(WBS);
                    PageWBS.RUN;
                end;
            }
            action("Save File On Server")
            {
                ApplicationArea = All;
                Caption = 'Save File On Server', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Save;
                PromotedOnly = true;
                Visible = false;
                trigger OnAction()
                var
                    DestinationFile: Text;
                    FileMgt: Codeunit "File Management";
                    RecordLink: Record "Record Link";
                    RecRef: RecordRef;
                begin
                    //    DestinationFile := FileMgt.UploadFile('Window Title', 'file.txt');
                    //  FileMgt.CopyServerFile(DestinationFile, 'D:\Project Attachment\' + "Project No." + ' ' + FileMgt.GetFileName(DestinationFile), TRUE);

                    RecRef.GETTABLE(Rec);
                    RecordLink.INIT;
                    RecordLink."Record ID" := RecRef.RECORDID;
                    RecordLink.URL1 := '\\103.69.219.50\D\Project Attachment\' + Rec."No." + ' ' + FileMgt.GetFileName(DestinationFile);
                    RecordLink.Description := FileMgt.GetFileName(DestinationFile);
                    RecordLink.Created := CREATEDATETIME(WORKDATE, TIME);
                    RecordLink."User ID" := USERID;
                    RecordLink.Company := COMPANYNAME;
                    RecordLink.INSERT;

                end;
            }
            action("Maintain Project Milestone")
            {
                ApplicationArea = All;
                Caption = 'Maintain Project Milestone', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = TaskList;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ProjectTask: Record "Job Task";
                    ProjectTaskLines: Page "Job Task Lines";
                begin
                    DefaultDim.SETRANGE("Table ID", DATABASE::Job);
                    DefaultDim.SETRANGE("No.", Rec."No.");
                    IF NOT DefaultDim.FINDFIRST THEN
                        ERROR('Please Enter Cost Center First!');

                    IF NOT UserSetup.GetAdminUser THEN BEGIN
                        Rec.TESTFIELD("Global Dimension 1 Code");
                        Rec.TESTFIELD("Global Dimension 2 Code");
                        Rec.TESTFIELD("Project Manager1");
                        Rec.TESTFIELD("Sub Type", Rec."Sub Type"::Receivable);
                        Rec.TESTFIELD("Estimated Project Cost");
                        Rec.TESTFIELD("Project Value");
                        Rec.TESTFIELD("Starting Date");
                        Rec.TESTFIELD("Ending Date");
                    END;
                    IF (Rec."Type Of Project" = Rec."Type Of Project"::"Sub Project") OR (Rec."Type Of Project" = Rec."Type Of Project"::" ") THEN
                        ERROR('Type of Project only Main Project or PMC Project for Milestone creation');
                    ProjectTask.SETRANGE("Job No.", Rec."No.");
                    //ProjectTask.SETRANGE("Job Task No.", Rec."No.");
                    //ProjectTask.SETRANGE(Description, Rec.Description);
                    //ProjectTask.SETRANGE("Project Manager", Rec."Project Manager1");
                    ProjectTaskLines.SETTABLEVIEW(ProjectTask);
                    ProjectTaskLines.RUN;
                end;
            }
            action("Copy Project")
            {

                ApplicationArea = All;
                Caption = 'Copy Project', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Copy;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ProjectTask: Record "Job Task";

                begin
                    Rec.TESTFIELD("Source Project No.");
                    IF CONFIRM('Do you want to copy project?', FALSE) THEN BEGIN
                        CopyProject(Rec."Source Project No.");
                    END;

                end;
            }
            action(Contacts)
            {
                Caption = 'Contacts';
                Image = ContactPerson;
                RunObject = Page "Project Contacts";
                RunPageLink = "Project Code" = field("No.");
            }

            action("Change Customer")
            {
                ApplicationArea = All;
                Caption = 'Change Customer', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ChangeCustomer;
                PromotedOnly = true;
                trigger OnAction()
                var
                    SaleLine: Record "Sales Line";

                begin
                    SaleLine.SETRANGE("Job No.", Rec."No.");
                    SaleLine.SETRANGE("Job Task No.", Rec."No.");
                    IF SaleLine.FINDFIRST THEN
                        ERROR('One or more then one Invoices are in open status,Please post first');
                    IF CONFIRM('Are you sure ?', FALSE) THEN BEGIN
                        Rec."Old Customer Code" := Rec."Bill-to Customer No.";
                        Rec."Old Customer Name" := Rec."Bill-to Name";
                        Rec.MODIFY;
                    END;

                end;
            }
            action("Archi&ve Document")
            {
                ApplicationArea = All;
                Caption = 'Archive Document', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Archive;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ArchiveManagement: Codeunit ArchiveMGT;
                begin
                    Rec.TESTFIELD("Project Status", Rec."Project Status"::Approved);
                    //AD_REPL
                    UserSetup.GET(USERID);
                    IF Rec."Temporary Status" <> Rec."Temporary Status"::" " THEN
                        ERROR('You cannot perform this activity because the Temporary Status of Project No. %1 is In-Active', Rec."No.");
                    IF NOT UserSetup."Project for Approval Sender" THEN
                        ERROR('You do not have premission to archive this document');
                    //AD_REPL
                    ArchiveManagement.ArchiveProjectDocument(Rec); //BC S.01
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action("Project Payable")
            {
                ApplicationArea = All;
                Caption = 'Project Payable', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Payables;
                PromotedOnly = true;
                trigger OnAction()
                var

                begin
                    DefaultDim.SETRANGE("Table ID", DATABASE::Job);
                    DefaultDim.SETRANGE("No.", Rec."No.");
                    IF NOT DefaultDim.FINDFIRST THEN
                        ERROR('Please Enter Cost Center First!');
                    IF NOT UserSetup.GetAdminUser THEN BEGIN
                        Rec.TESTFIELD("Sub Type", Rec."Sub Type"::Payable);
                        Rec.TESTFIELD("Project Value");
                        Rec.TESTFIELD("Starting Date");
                        Rec.TESTFIELD("Ending Date");
                    END;
                    ProjectPurchaseLine.SETRANGE("Project No.", Rec."No.");
                    ProjectPurchaseLine.SETRANGE("Project Task No.", Rec."No.");
                    // ProjectPurchaseLine.SETRANGE("Project Name", "Project Name");
                    ProjectPurchaseLine.SETRANGE("Project Manager", Rec."Project Manager1");
                    ProjectPurchasePayable.SETTABLEVIEW(ProjectPurchaseLine);
                    ProjectPurchasePayable.RUN;
                end;
            }
            action("Send A&pproval Request")
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendApprovalRequest;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RecordLink: Record "Record Link";
                    RecRef: RecordRef;
                    ApprovalMgt: Codeunit "Project Approval Mgt";
                begin
                    ProjectCharter.RESET;
                    ProjectCharter.SETRANGE("Project Charter No.", Rec."Project Charter No.");
                    IF ProjectCharter.FINDFIRST THEN BEGIN
                        ProjectCharter.TESTFIELD(Status, ProjectCharter.Status::Approved);
                    END;

                    DefaultDim.SETRANGE("Table ID", DATABASE::Job);
                    DefaultDim.SETRANGE("No.", Rec."No.");
                    IF NOT DefaultDim.FINDFIRST THEN
                        ERROR('Please Enter Cost Center First!');
                    IF NOT UserSetup.GetAdminUser THEN BEGIN
                        Rec.TESTFIELD("Global Dimension 1 Code");
                        Rec.TESTFIELD("Global Dimension 2 Code");
                        Rec.TESTFIELD("Project Manager1");
                        Rec.TESTFIELD("Responsible Person");
                        Rec.TESTFIELD("Starting Date");
                        Rec.TESTFIELD("Ending Date");
                        IF Rec."Type Of Project" <> Rec."Type Of Project"::"BD Project" THEN BEGIN
                            Rec.TESTFIELD("Estimated Project Cost");
                            Rec.TESTFIELD("Budgeted Cost");
                            Rec.TESTFIELD("Project Value");
                            //Rec.TESTFIELD(Structure);
                            Rec.TESTFIELD("Agreement No.");
                            Rec.TESTFIELD("Agreement From Date");
                            Rec.TESTFIELD("Agreement To Date");

                            // IF Rec."Type Of Project" = Rec."Type Of Project"::"Main Project" THEN BEGIN
                            //     RecRef.GETTABLE(Rec);
                            //     RecordLink.RESET;
                            //     RecordLink.SETRANGE("Record ID", RecRef.RECORDID);
                            //     IF NOT RecordLink.FINDFIRST THEN
                            //         ERROR('Please attach customer aggrement!');
                            // END;
                        END;

                        //IF Rec.Structure = 'Exempted' THEN
                        //CheckExemptedAttachment;

                        Rec.CALCFIELDS("No. of Archived Versions");
                        IF Rec."No. of Archived Versions" <> 0 THEN
                            Rec.TESTFIELD("Reason Code");
                        CheckPreApproval;
                    END;

                    UserSetup.GET(USERID);
                    IF NOT UserSetup."Project for Approval Sender" THEN
                        ERROR('You donot have permission for this activity');

                    ApprovalMgt.OnSendRequestForApproval(Rec);
                end;
            }
            action("Create SubProject")
            {
                ApplicationArea = All;
                Caption = 'Create SubProject', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Create;
                PromotedOnly = true;
                trigger OnAction()
                var
                    Project: Record Job;

                begin
                    IF Rec."Temporary Status" <> Rec."Temporary Status"::" " THEN
                        ERROR('You cannot perform this activity because the Temporary Status of Project No. %1 is In-Active', Rec."No.");

                    IF NOT (Rec."Type Of Project" IN [Rec."Type Of Project"::"Main Project", Rec."Type Of Project"::"BD Project"]) THEN
                        ERROR('You can create only main project or bd project');
                    IF CONFIRM('Do you want to create Sub Project', FALSE) THEN BEGIN
                        CurrPage.SETSELECTIONFILTER(Rec);
                        Project.INIT;
                        Project."No." := GetSubProject(Rec."No.");
                        Project."Type Of Project" := Project."Type Of Project"::"Sub Project";
                        Project.VALIDATE("Parent Project Code", Rec."No.");
                        Project."Starting Date" := Rec."Starting Date";
                        Project."Ending Date" := Rec."Ending Date";
                        Project."Agreement From Date" := Rec."Agreement From Date";
                        Project."Agreement To Date" := Rec."Agreement To Date";
                        Project.INSERT(TRUE);
                        Project.VALIDATE("Global Dimension 2 Code");
                        MESSAGE('Sub Project No. %1 has been created', Project."No.");
                    END;
                end;
            }
            action("Create PMCProject")
            {
                ApplicationArea = All;
                Caption = 'Create PMC Project', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Create;
                PromotedOnly = true;
                trigger OnAction()
                var
                    Project: Record Job;
                begin
                    IF Rec."Temporary Status" <> Rec."Temporary Status"::" " then
                        ERROR('You cannot perform this activity because the Temporary Status of Project No. %1 is In-Active', Rec."No.");

                    IF NOT (Rec."Type Of Project" IN [Rec."Type Of Project"::"Main Project", Rec."Type Of Project"::"PMC Project"]) THEN
                        ERROR('You can create only main Project or BD project');
                    IF CONFIRM('Do you want to create PMC Project', FALSE) THEN BEGIN
                        CurrPage.SETSELECTIONFILTER(Rec);
                        Project.INIT;
                        Project."No." := GetSubProject(Rec."No.");
                        Project."Type Of Project" := Project."Type Of Project"::"Sub Project";
                        Project.VALIDATE("Parent Project Code", Rec."No.");
                        Project."Starting Date" := Rec."Starting Date";
                        Project."Ending Date" := Rec."Ending Date";
                        Project."Agreement From Date" := Rec."Agreement From Date";
                        Project."Agreement To Date" := Rec."Agreement To Date";
                        Project.INSERT(TRUE);
                        Project.VALIDATE("Global Dimension 2 Code");
                        MESSAGE('PMC Project No. %1 has been created', Project."No.");
                    END;
                end;
            }
            action("Short Close")
            {
                Caption = 'Short Close';
                ApplicationArea = All;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    IF Rec."Temporary Status" <> Rec."Temporary Status"::" " THEN
                        ERROR('You cannot perform this activity because the Temporary Status of Project No. %1 is In-Active', Rec."No.");

                    IF CONFIRM('Do you want to Short Close', FALSE) THEN
                        ReleaseProjectDocument.ShortClose(Rec);
                end;
            }
            action("Completed")
            {
                Caption = 'Completed';
                ApplicationArea = All;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TESTFIELD(Rec."Project Status", Rec."Project Status"::Approved);
                    IF Rec."Temporary Status" <> Rec."Temporary Status"::" " THEN
                        ERROR('You cannot perform this activity because the Temporary Status of Project No. %1 is In-Active', Rec."No.");

                    IF CONFIRM('Do you want to Complete', FALSE) THEN
                        ReleaseProjectDocument.CompletedStatus(Rec);
                end;
            }

            action("Create Project Lines")
            {
                Caption = 'Create Project Line';
                ApplicationArea = All;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    //Message(Rec."No.");
                    ReleaseProjectDocument.Run(Rec);
                    Message('Done!!');
                end;
            }
        }
    }



    local procedure CheckPreApproval()
    var
        ProjectTask: Record "Job Task";
        ProjectContacts: Record "Project Contacts";
        Text001: TextConst ENU = 'Please Enter Milestone for this Project No. %1.';
        Text002: TextConst ENU = 'Please Enter Contact for this Project No. %1.';
    begin
        IF Rec."Type Of Project" = Rec."Type Of Project"::"Main Project" THEN BEGIN
            ProjectTask.SETRANGE("Job No.", Rec."No.");
            ProjectTask.SETFILTER(Amount, '<>0');
            IF NOT ProjectTask.FIND('-') THEN
                ERROR(Text001, Rec."No.");
        END;
        ProjectContacts.SETRANGE("Project Code", Rec."No.");
        IF NOT ProjectContacts.FINDFIRST THEN
            ERROR(Text002, Rec."No.");
    end;

    local procedure GetSubProject(ProjectNo: Code[20]) NoOfSubProj: Code[20]
    var
        Project: Record Job;
    begin
        Project.SETRANGE("Parent Project Code", ProjectNo);
        Project.SETRANGE("Type Of Project", Project."Type Of Project"::"Sub Project");
        IF Project.FINDLAST THEN
            NoOfSubProj := INCSTR(Project."No.")
        ELSE
            NoOfSubProj := ProjectNo + '\SP-001';

        EXIT(NoOfSubProj);
    end;

    local procedure GetPMCProject(ProjectNo: Code[20]) NoOfSubProj: Code[20]
    var
        Project: Record Job;
    begin
        Project.SETRANGE("Parent Project Code", ProjectNo);
        Project.SETRANGE("Type Of Project", Project."Type Of Project"::"PMC Project");
        IF Project.FINDLAST THEN
            NoOfSubProj := INCSTR(Project."No.")
        ELSE
            NoOfSubProj := ProjectNo + '\SP-001';

        EXIT(NoOfSubProj);
    end;

    local procedure CopyProject(SourceNo: Code[20])
    var
        Project: Record Job;
    begin
        IF Project.GET(SourceNo) THEN BEGIN
            Rec.Description := Project.Description;
            Rec."Project Manager1" := Project."Project Manager1";
            Rec.VALIDATE("Bill-to Customer No.", Project."Bill-to Customer No.");
            Rec."Project Status" := Rec."Project Status"::Draft;
            Rec."Responsible Person" := Project."Responsible Person";
            Rec."Project Manager" := Project."Project Manager1";
        END;
    end;

    local procedure CheckEstimatedDate()
    var
        Project: Record Job;
        Project2: Record Job;
        Text50000: TextConst ENU = 'Please Enter Greater then equal to Main Project Starting Date %1.';
        Text50001: TextConst ENU = 'Please Enter Less then equal to Main Project Ending Date %1.';
        Text50002: TextConst ENU = 'Please Enter Less then equal to Main Project Budgeted Cost %1.';
        Text50003: TextConst ENU = 'Please Enter Less then equal to Main Project Value %1.';
        Text50004: TextConst ENU = 'Please Enter Greater then equal to Main Project Agreement From Date %1.';
        Text50005: TextConst ENU = 'Please Enter Less then equal to Main Project Agreement To Date %1.';
        ProjectValue: Decimal;
        PurchaseAmount: Decimal;
    begin
        IF (Rec."Type Of Project" = Rec."Type Of Project"::"Sub Project") OR (Rec."Type Of Project" = Rec."Type Of Project"::"PMC Project") THEN BEGIN
            Rec.TESTFIELD("Parent Project Code");
            Project.GET(Rec."Parent Project Code");
            IF Project."Starting Date" <> 0D THEN BEGIN
                IF (Project."Starting Date" > Rec."Ending Date") THEN
                    ERROR(Text50000, Project."Starting Date");
            END;
            IF Rec."Ending Date" <> 0D THEN BEGIN
                IF (Project."Starting Date" < Rec."Ending Date") THEN
                    ERROR(Text50001, Project."Ending Date");
            END;
            IF Rec."Agreement From Date" <> 0D THEN BEGIN
                IF (Project."Agreement From Date" > Rec."Agreement From Date") THEN
                    ERROR(Text50004, Project."Agreement From Date");
            END;
            IF Rec."Agreement To Date" <> 0D THEN BEGIN
                IF (Project."Agreement To Date" < Rec."Agreement To Date") THEN
                    ERROR(Text50005, Project."Agreement To Date");
            END;

            IF Rec."Budgeted Cost" <> 0 THEN BEGIN
                IF Project."Budgeted Cost" < Rec."Budgeted Cost" THEN
                    ERROR(Text50002, Rec."Budgeted Cost");
            END;
            IF Rec."Project Value" <> 0 THEN BEGIN
                Project2.SETRANGE("Parent Project Code", Rec."Parent Project Code");
                IF Project2.FINDSET THEN
                    REPEAT
                        ProjectValue += Project2."Project Value";
                    UNTIL Project2.NEXT = 0;
                ProjectPurchaseLine.SETRANGE("Project No.", Rec."Parent Project Code");
                ProjectPurchaseLine.SETRANGE(Status, ProjectPurchaseLine.Status::Completed);
                IF ProjectPurchaseLine.FINDSET THEN
                    REPEAT
                        PurchaseAmount += ProjectPurchaseLine."PO Value";
                    UNTIL ProjectPurchaseLine.NEXT = 0;
                IF Project."Project Value" < (Rec."Project Value" + ProjectValue + PurchaseAmount) THEN
                    ERROR(Text50003, Project."Project Value");
            END;
        END;
    end;


    local procedure CheckMilestoneValue(ProjectNo: Code[20]) MilestoneAmt: Decimal
    var
        ProjectTask: Record "Job Task";
    begin
        ProjectTask.SETRANGE(ProjectTask."Job No.", ProjectNo);
        IF ProjectTask.FINDSET THEN
            REPEAT
                MilestoneAmt += ProjectTask.Amount;
            UNTIL ProjectTask.NEXT = 0;
        EXIT(MilestoneAmt);
    end;

    local procedure CheckCostCenterWiseAmt(CostCenter: Code[40]; Amount: Decimal)
    var
        RecProject: Record Job;
        GLEntry: Record "G/L Entry";
        ProjectValue: Decimal;
        GLAmount: Decimal;
        RecGenJournalLine: Record "Gen. Journal Line";
        GenJourAmount: Decimal;
        RecPurchaseHeader: Record "Purchase Header";
        RecPurchaseLine: Record "Purchase Line";
        PurchaseAmount: Decimal;
        RecProject2: Record Job;
        SubprojectValue: Decimal;
        DocumentNo: Code[50];
        Text50001: TextConst ENU = 'Total Assign value more then Budgeted Cost, Reduse any value first then proceed for approval (Budgeted Cost %1 Posted %2 On JV %3 PO %4 SP %5 for voucher No. %6.)';
    begin
        RecProject.SETRANGE("Global Dimension 1 Code", CostCenter);
        RecProject.SETFILTER("Type Of Project", '<>%1', RecProject."Type Of Project"::"BD Project");
        IF RecProject.FINDFIRST THEN BEGIN
            ProjectValue := RecProject."Budgeted Cost";
            GLEntry.SETRANGE("Global Dimension 1 Code", CostCenter);
            GLEntry.SETFILTER("Source Code", '%1|%2|%3', 'JOURNALV', 'GENJNL', 'PURCHASES');
            GLEntry.SETFILTER(Amount, '<%1', 0);
            IF GLEntry.FINDFIRST THEN
                REPEAT
                    GLAmount += ABS(GLEntry.Amount);
                UNTIL GLEntry.NEXT = 0;
            RecGenJournalLine.SETRANGE("Shortcut Dimension 1 Code", CostCenter);
            IF RecGenJournalLine.FINDFIRST THEN
                REPEAT
                    IF DocumentNo <> RecGenJournalLine."Document No." THEN
                        GenJourAmount += GetCurrentAmount(RecGenJournalLine."Document No.", CostCenter);
                    DocumentNo := RecGenJournalLine."Document No.";
                UNTIL RecGenJournalLine.NEXT = 0;
            RecPurchaseHeader.SETRANGE("Shortcut Dimension 1 Code", CostCenter);
            RecPurchaseHeader.SETRANGE(Status, RecPurchaseHeader.Status::Released);
            IF RecPurchaseHeader.FINDFIRST THEN BEGIN
                REPEAT
                    RecPurchaseLine.SETRANGE("Document No.", RecPurchaseHeader."No.");
                    IF RecPurchaseLine.FINDFIRST THEN
                        REPEAT
                            PurchaseAmount += RecPurchaseLine."Outstanding Amount" + RecPurchaseLine."Amt. Rcd. Not Invoiced";
                        UNTIL RecPurchaseLine.NEXT = 0;
                UNTIL RecPurchaseHeader.NEXT = 0;
            END;
            RecProject2.SETRANGE("Parent Project Code", RecProject."No.");
            IF RecProject2.FINDFIRST THEN
                REPEAT
                    SubprojectValue += RecProject2."Budgeted Cost";
                UNTIL RecProject2.NEXT = 0;
        END;

        IF ProjectValue < (GLAmount + GenJourAmount + PurchaseAmount + SubprojectValue) THEN
            ERROR(Text50001, ProjectValue, GLAmount, GenJourAmount, PurchaseAmount, SubprojectValue, RecGenJournalLine."Document No.");

    end;

    local procedure GetCurrentAmount(DocumentNo: Code[20]; CostCenter: Code[20]) CostAmount: Decimal;
    var
        RecGenJournalLine: Record "Gen. Journal Line";
        BalanceAmt: Decimal;
    begin
        RecGenJournalLine.SETRANGE("Document No.", DocumentNo);
        RecGenJournalLine.SETRANGE("Shortcut Dimension 1 Code", CostCenter);
        RecGenJournalLine.SETFILTER("Source Code", '%1|%2', 'JOURNALV', 'GENJNL');
        RecGenJournalLine.SETFILTER(Status, '%1|%2|%3', RecGenJournalLine.Status::Draft, RecGenJournalLine.Status::Approved, RecGenJournalLine.Status::"Pending for Approval");
        IF RecGenJournalLine.FINDFIRST THEN
            REPEAT
                IF RecGenJournalLine."Bal. Account No." = '' THEN BEGIN
                    CostAmount += RecGenJournalLine."Debit Amount";
                    BalanceAmt += RecGenJournalLine.Amount;
                END ELSE BEGIN
                    IF RecGenJournalLine."Debit Amount" <> 0 THEN
                        CostAmount += RecGenJournalLine."Debit Amount";
                    IF RecGenJournalLine."Credit Amount" <> 0 THEN
                        CostAmount += RecGenJournalLine."Credit Amount";
                END;
            UNTIL RecGenJournalLine.NEXT = 0;
        IF BalanceAmt <> 0 THEN
            ERROR('Incomplete Voucher can not be send for Approval');
        EXIT(CostAmount);
    end;

    local procedure ChangeMainProjectIntoInactive()
    var
        GetProjectCharter: Record "Project Charter";
        GetProject: Record Job;
    begin
        Rec.TESTFIELD(Rec."Project Status", Rec."Project Status"::Approved);
        IF Rec."Type Of Project" = Rec."Type Of Project"::"Main Project" THEN BEGIN
            IF Rec."Temporary Status" = Rec."Temporary Status"::"In-Active" THEN BEGIN
                IF GetProjectCharter.GET(Rec."Project Charter No.") THEN BEGIN
                    GetProjectCharter."Temporary Status" := Rec."Temporary Status"::"In-Active";
                    GetProjectCharter.MODIFY;
                END;
                GetProject.RESET;
                GetProject.SETRANGE("Parent Project Code", Rec."No.");
                IF GetProject.FINDSET THEN BEGIN
                    REPEAT
                        GetProject."Temporary Status" := Rec."Temporary Status"::"In-Active";
                        GetProject.MODIFY;
                    UNTIL GetProject.NEXT = 0;
                END;
            END ELSE BEGIN
                IF GetProjectCharter.GET(Rec."Project Charter No.") THEN BEGIN
                    GetProjectCharter."Temporary Status" := Rec."Temporary Status"::" ";
                    GetProjectCharter.MODIFY;
                END;
                GetProject.RESET;
                GetProject.SETRANGE("Parent Project Code", Rec."No.");
                IF GetProject.FINDSET THEN BEGIN
                    REPEAT
                        GetProject."Temporary Status" := Rec."Temporary Status"::" ";
                        GetProject.MODIFY;
                    UNTIL GetProject.NEXT = 0;
                END;
            END;
        END;
    end;

    local procedure GetLatestBillDate(): Date
    var
        ProjectCode: Code[20];
        ProjectTask: Record "Job Task";
    begin
        ProjectTask.SETRANGE("Job No.", ProjectCode);
        ProjectTask.SETFILTER("Actual Latest Bill Date", '<>%1', 0D);
        ProjectTask.SETCURRENTKEY("Actual Latest Bill Date");
        IF ProjectTask.FINDLAST THEN
            EXIT(ProjectTask."Actual Latest Bill Date");
    end;


    trigger OnOpenPage()
    var

    begin
        ProjectEditable2 := ((Rec."Type Of Project" = Rec."Type Of Project"::"Sub Project") OR (Rec."Type Of Project" = Rec."Type Of Project"::"PMC Project")) AND (Rec."Project Status" <> Rec."Project Status"::Approved);
        ProjectEditable := Rec."Project Status" IN [Rec."Project Status"::Draft, Rec."Project Status"::Fresh, Rec."Project Status"::"Under Revision", Rec."Project Status"::Draft, Rec."Project Status"::"Pending for Approval"];
        ProjectEditable1 := Rec."Project Status" = Rec."Project Status"::Draft;
        ProjectEditable3 := (Rec."Project Status" <> Rec."Project Status"::Approved);
        WBSVisiblity := ((Rec."Type Of Project" = Rec."Type Of Project"::"Sub Project") OR (Rec."Type Of Project" = Rec."Type Of Project"::"BD Project"));
    end;

    trigger OnAfterGetRecord()
    var

    begin
        ProjectEditable2 := ((Rec."Type Of Project" = Rec."Type Of Project"::"Sub Project") OR (Rec."Type Of Project" = Rec."Type Of Project"::"PMC Project")) AND (Rec."Project Status" <> Rec."Project Status"::Approved);
        ProjectEditable := Rec."Project Status" IN [Rec."Project Status"::Draft, Rec."Project Status"::Fresh, Rec."Project Status"::"Under Revision", Rec."Project Status"::Draft, Rec."Project Status"::"Pending for Approval"];
        ProjectEditable1 := Rec."Project Status" = Rec."Project Status"::Draft;
        ProjectEditable3 := (Rec."Project Status" <> Rec."Project Status"::Approved);
        WBSVisiblity := ((Rec."Type Of Project" = Rec."Type Of Project"::"Sub Project") OR (Rec."Type Of Project" = Rec."Type Of Project"::"BD Project"));
    end;

    var
        RecProject: Record Job;
        ArchiveManagement: Codeunit ArchiveManagement;
        ProjectTask2: Record "Job Task";
        DefaultDim: Record "Default Dimension";
        ProjectEditable: Boolean;
        ProjectPurchaseLine: Record "Project Purchase Line";
        ProjectPurchasePayable: Page "Project Purchase Payable";
        WBSVisiblity: Boolean;
        ExemptedVisiblity: Boolean;
        ProjectEditable1: Boolean;
        ReleaseProjectDocument: Codeunit "Release Project Document";
        ProjectEditable2: Boolean;
        ProjectEditable3: Boolean;
        UserSetup: Record "User Setup";
        ProjectCharter: Record "Project Charter";
        EPPTest: Page EPP;
        EPP: Record "Expected Project Prof";
}
