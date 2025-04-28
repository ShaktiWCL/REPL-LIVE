report 90001 "Update From UPG_Table"
{
    Caption = 'Update From UPG_Table';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Project; UPG_Project)
        {
            trigger OnAfterGetRecord()
            var
                UPG_Project: Record Job;
            begin
                IF UPG_Project.GET(Project."Project No.") THEN BEGIN
                    // UPG_Project.INIT;
                    // UPG_Project."Project No." := Project."Project No.";
                    // UPG_Project."Search Name" := Project."Search Name";
                    // UPG_Project."Project Name" := Project."Project Name";
                    // UPG_Project."Project Name 2" := Project."Project Name 2";
                    UPG_Project."Old Customer Code" := Project."Old Customer Code";
                    UPG_Project."Old Customer Name" := Project."Old Customer Name";
                    UPG_Project."Project Value" := Project."Project Value";
                    UPG_Project."Client Project Name" := Project."Client Project Name";
                    UPG_Project."Parent Project's OU" := Project."Parent Project's OU";
                    UPG_Project."Parent Project Code" := Project."Parent Project Code";
                    UPG_Project."Parent Project Name" := Project."Parent Project Name";
                    UPG_Project."Agreement No." := Project."Agreement No.";
                    UPG_Project."Project Manager1" := Project."Project Manager";
                    UPG_Project."Reference Proposal ID" := Project."Reference Proposal ID";
                    UPG_Project."Revision No." := Project."Revision No.";
                    UPG_Project."Revised On" := Project."Revised On";
                    UPG_Project."Budget Breakup Mandatory" := Project."Budget Breakup Mandatory";
                    UPG_Project."Achived By" := Project."Achived By";
                    UPG_Project."Estimated Project Cost" := Project."Estimated Project Cost";
                    UPG_Project."Budget Control Required" := Project."Budget Control Required";
                    UPG_Project."Budgeted Cost" := Project."Budgeted Cost";
                    UPG_Project."Milestone Revision Date" := Project."Milestone Revision Date";
                    UPG_Project."Project Status" := Project."Project Status";
                    UPG_Project."Doc. No. Occurrence" := Project."Doc. No. Occurrence";
                    UPG_Project."Version No." := Project."Version No.";
                    UPG_Project."Document Type" := Project."Document Type";
                    UPG_Project."Responsible Person" := Project."Responsible Person";
                    UPG_Project.Type := Project.Type;
                    UPG_Project."Sub Type" := Project."Sub Type";
                    UPG_Project."Source Project No." := Project."Source Project No.";
                    UPG_Project."Source Project Name" := Project."Source Project Name";
                    UPG_Project."Type Of Project" := Project."Type Of Project";
                    UPG_Project."Responsibility Center" := Project."Responsibility Center";
                    UPG_Project."Agreement From Date" := Project."Agreement From Date";
                    UPG_Project."Agreement To Date" := Project."Agreement To Date";
                    UPG_Project."Work Order No." := Project."Work Order No.";
                    UPG_Project.Structure := Project.Structure;
                    UPG_Project."Project Charter No." := Project."Project Charter No.";
                    UPG_Project."BD Charter No." := Project."BD Charter No.";
                    UPG_Project."Old Project Code(Ramco)" := Project."Old Project Code(Ramco)";
                    UPG_Project."Price Inclusive Service Tax" := Project."Price Inclusive Service Tax";
                    UPG_Project."Approval Satge Skip" := Project."Approval Satge Skip";
                    UPG_Project."Milestone Invoice Satge Skip" := Project."Milestone Invoice Satge Skip";
                    UPG_Project."Temporary Status" := Project."Temporary Status";
                    UPG_Project.Validate("Head of Department", Project."Head of Department");
                    UPG_Project."Actual Lattest Bill Date" := Project."Actual Lattest Bill Date";
                    UPG_Project."Tender No." := Project."Tender No.";
                    UPG_Project."Email Aleart(Despectro)" := Project."Email Aleart(Despectro)";
                    UPG_Project."Balance For Invoice" := Project."Balance For Invoice";
                    UPG_Project."Is Project Live" := Project."Is Project Live";
                    UPG_Project."No. of Archived Versions" := Project."No. of Archived Versions";
                    UPG_Project."Project Manager Name" := Project."Project Manager Name";
                    UPG_Project."HOD Name" := Project."HOD Name";
                    //UPG_Project."Manager Department" := Project."Manager Department";
                    UPG_Project.Modify();
                END;
            end;
        }
    }
}
