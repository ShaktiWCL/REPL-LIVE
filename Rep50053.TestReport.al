report 50053 "Test Report"
{
    ApplicationArea = All;
    Caption = 'Test Report';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(ProjectCharter; "Project Charter")
        {
            RequestFilterFields = "Project Charter No.";
            trigger OnAfterGetRecord()
            var

            begin
                ModifyAll("Project Code", '');
                Message('Done!!');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
