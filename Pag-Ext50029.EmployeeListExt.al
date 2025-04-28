pageextension 50029 EmployeeListExt extends "Employee List"
{
    layout
    {
        addafter("Search Name")
        {
            field("Project Manager"; Rec."Project Manager")
            {
                ApplicationArea = all;
            }
            field("Project Manager for Cash Flow"; Rec."Project Manager for Cash Flow")
            {
                ApplicationArea = all;
            }
        }

    }
}
