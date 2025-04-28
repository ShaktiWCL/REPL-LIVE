report 50052 "Update Project Details"
{
    ApplicationArea = All;
    Caption = 'Update Project Details';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Job; Job)
        {
            trigger OnAfterGetRecord()
            var
                UPGProject: Record UPG_Project;
            begin
                IF UPGProject.GET("No.") then begin
                    Job."Project Name" := UPGProject."Project Name";
                    Job."Project Name 2" := UPGProject."Project Name 2";
                    Job.Modify()
                end;
            end;
        }
    }

}
