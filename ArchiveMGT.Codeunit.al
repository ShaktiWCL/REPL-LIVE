codeunit 50003 ArchiveMGT
{
    procedure ArchiveProjectDocument(var Project: Record Job)

    var
        myInt: Integer;
    begin
        IF CONFIRM(
             Text007, TRUE,
             Project."No.")
        THEN BEGIN
            StoreProjectDocument(Project, FALSE);
            MESSAGE(Text001, Project."No.");
            Project."Project Status" := Project."Project Status"::"Under Revision";
            Project."Revised On" := TODAY;
            Project.MODIFY;
        END;

    end;

    procedure StoreProjectDocument(Var Project: Record Job; InteractionExisT: Boolean)
    var
        SalesLine: Record "Sales Line";
        ProjectArchive: Record "Project Archive";
        SalesLineArchive: Record "Sales Line Archive";
        SalesHeaderArchive: Record "Sales Header Archive";
        SalesHeader: Record "Sales Header";
    Begin

        ProjectArchive.INIT;
        ProjectArchive.TRANSFERFIELDS(Project);
        ProjectArchive."Achived By" := USERID;
        ProjectArchive."Date Archived" := WORKDATE;
        ProjectArchive."Time Archived" := TIME;
        ProjectArchive."Version No." := GetProjectNextVersionNo(
            DATABASE::Job, Project."No.", Project."Doc. No. Occurrence");
        ProjectArchive."Interaction Exist" := InteractionExist;
        ProjectArchive.COPYLINKS(Project);
        ProjectArchive.INSERT;

    end;

    procedure GetProjectNextOccurrenceNo(TableId: Integer; DocNo: Code[40]; DocNoOccurrence: Integer): Integer
    var
        ProjectArchive: Record "Project Archive";
    Begin
        CASE TableId OF
            DATABASE::Job:
                BEGIN
                    ProjectArchive.LOCKTABLE;
                    ProjectArchive.SETRANGE("Project No.", DocNo);
                    IF ProjectArchive.FINDLAST THEN
                        EXIT(ProjectArchive."Doc. No. Occurrence" + 1);
                    EXIT(1);
                END;
        END;

    End;

    procedure GetProjectNextVersionNo(TableId: Integer; DocNo: Code[40]; DocNoOccurrence: Integer): Integer
    var
        ProjectArchive: Record "Project Archive";
    Begin

        CASE TableId OF
            DATABASE::Job:
                BEGIN
                    ProjectArchive.LOCKTABLE;
                    ProjectArchive.SETRANGE("Project No.", DocNo);
                    ProjectArchive.SETRANGE("Doc. No. Occurrence", DocNoOccurrence);
                    IF ProjectArchive.FINDLAST THEN
                        EXIT(ProjectArchive."Version No." + 1);
                    EXIT(1);
                END;
        END;
    end;
    //
    procedure ArchiveProjectCharterDocument(var ProjectCharter: Record "Project Charter")

    begin
        IF CONFIRM(
             Text007, TRUE,
             ProjectCharter."Project Charter No.")
        THEN BEGIN
            StoreProjectCharterDocument(ProjectCharter, FALSE);
            MESSAGE(Text001, ProjectCharter."Project Charter No.");
            ProjectCharter."Status" := ProjectCharter."Status"::"Under Revision";
            //ProjectCharter."Budgeted Cost" := 0;
            ProjectCharter.MODIFY;
        END;

    end;

    procedure StoreProjectCharterDocument(Var ProjectCharter: Record "Project Charter"; InteractionExisT: Boolean)
    var
        SalesLine: Record "Sales Line";
        ProjectCharterArchive: Record "Project Charter Archive";
        SalesLineArchive: Record "Sales Line Archive";
        SalesHeaderArchive: Record "Sales Header Archive";
        SalesHeader: Record "Sales Header";
    Begin
        ProjectCharterArchive.INIT;
        ProjectCharterArchive.TRANSFERFIELDS(ProjectCharter);
        ProjectCharterArchive."Archived By" := USERID;
        ProjectCharterArchive."Date Archived" := WORKDATE;
        ProjectCharterArchive."Time Archived" := TIME;
        ProjectCharterArchive.Version := GetProjectCharterNextVersionNo(
            DATABASE::"Project Charter", ProjectCharter."Project Charter No.");
        ProjectCharterArchive.COPYLINKS(ProjectCharter);
        IF ProjectCharterArchive.INSERT THEN
            StoreProjectCharterMilestoneDocument(ProjectCharterArchive."Project Charter No.", ProjectCharterArchive.Version);
        InsertSubProjectCharter(ProjectCharterArchive."Project Charter No.", ProjectCharterArchive.Version);
        InsertProjectCharterVendorDetails(ProjectCharterArchive."Project Charter No.", ProjectCharterArchive.Version);

    end;

    procedure InsertSubProjectCharter(VAR ProjectCharterNo: Code[20]; Version: Integer)
    Var
        SubProjectCharter: Record "Sub Project Charter";
        SubProjectCharterArchive: Record "Sub Project Charter Archive";
    begin
        SubProjectCharter.SETRANGE("Project Charter No.", ProjectCharterNo);
        IF SubProjectCharter.FINDSET THEN
            REPEAT
                SubProjectCharterArchive.INIT;
                SubProjectCharterArchive.TRANSFERFIELDS(SubProjectCharter);
                SubProjectCharterArchive.Version := Version;
                SubProjectCharterArchive.INSERT;
                SubProjectCharter.Approved := TRUE;
                SubProjectCharter."Approved Date" := TODAY;
                SubProjectCharter.MODIFY;
            UNTIL SubProjectCharter.NEXT = 0;
    end;

    procedure InsertProjectCharterVendorDetails(VAR ProjectCharterNo: Code[20]; Version: Integer)
    var
        VendorDetailsforCharter: Record "Vendor Details for Charter";
        VendorDetailsforCharterArc: Record "Vendor Details for Charter Arc";
    begin
        VendorDetailsforCharter.SETRANGE("Project Charter No.", ProjectCharterNo);
        IF VendorDetailsforCharter.FINDSET THEN
            REPEAT
                VendorDetailsforCharterArc.INIT;
                VendorDetailsforCharterArc.TRANSFERFIELDS(VendorDetailsforCharter);
                VendorDetailsforCharterArc.Version := Version;
                VendorDetailsforCharterArc.INSERT;
                VendorDetailsforCharter.Approved := TRUE;
                VendorDetailsforCharter."Approved Date" := TODAY;
                VendorDetailsforCharter.MODIFY;
            UNTIL VendorDetailsforCharter.NEXT = 0;
    end;


    procedure GetProjectCharterNextVersionNo(TableId: Integer; DocNo: Code[40]): Integer
    var
        ProjectCharterArchive: Record "Project Charter Archive";
    Begin

        CASE TableId OF
            DATABASE::Job:
                BEGIN
                    ProjectCharterArchive.LOCKTABLE;
                    ProjectCharterArchive.SETRANGE("Project Charter No.", DocNo);
                    IF ProjectCharterArchive.FINDLAST THEN
                        EXIT(ProjectCharterArchive.Version + 1);
                    EXIT(1);
                END;
        end;
    end;

    Procedure StoreProjectCharterMilestoneDocument(VAR ProjectCharterNo: Code[20]; Version: Integer)
    var
        ProjectMaitainMilestones: Record "Project Maitain Milestones";
        ProjectCharterMilestoneArch: Record "Project Charter Milestone Arch";
    begin
        ProjectMaitainMilestones.SETRANGE("Project Charter Code", ProjectCharterNo);
        IF ProjectMaitainMilestones.FINDSET THEN
            REPEAT
                ProjectCharterMilestoneArch.INIT;
                ProjectCharterMilestoneArch.TRANSFERFIELDS(ProjectMaitainMilestones);
                ProjectCharterMilestoneArch.Version := Version;
                ProjectCharterMilestoneArch.INSERT;
                ProjectMaitainMilestones.Approved := TRUE;
                ProjectMaitainMilestones."Approved Date" := TODAY;
                ProjectMaitainMilestones.MODIFY;
            UNTIL ProjectMaitainMilestones.NEXT = 0;
    end;



    var
        Text001: TextConst ENU = 'Document %1 has been archived.', ENG = 'Document %1 has been archived.';
        Text002: TextConst ENU = 'Do you want to Restore %1 %2 Version %3?', ENG = 'Do you want to Restore %1 %2 Version %3?';
        Text003: TextConst ENU = '%1 %2 has been restored.', ENG = '%1 %2 has been restored.';
        Text004: TextConst ENU = 'Document restored from Version %1.', ENG = 'Document restored from Version %1.';
        Text005: TextConst ENU = '%1 %2 has been partly posted.\Restore not possible.', ENG = '%1 %2 has been partly posted.\Restore not possible.';
        Text006: TextConst ENU = 'Entries exist for on or more of the following:\  - %1\  - %2\  - %3.\Restoration of document will delete these entries.\Continue with restore?', ENG =
             'Entries exist for on or more of the following:\  - %1\  - %2\  - %3.\Restoration of document will delete these entries.\Continue with restore?';
        Text007: TextConst ENU = 'Archive %1?', ENG = 'Archive %1?';
        Text009: TextConst ENU = 'Unposted %1 %2 does not exist anymore.\It is not possible to restore the %1.', ENG = 'Unposted %1 %2 does not exist anymore.\It is not possible to restore the %1.';
}