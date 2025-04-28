pageextension 50013 "Employee PageExt" extends "Employee Card"
{
    layout
    {
        addafter(Gender)
        {
            field("Nav User Id"; Rec."Nav User Id")
            {
                ApplicationArea = All;
            }
            field("Non Project Time Sheet"; Rec."Non Project Time Sheet")
            {
                ApplicationArea = All;
            }
            field("LND Project Time Sheet"; Rec."LND Project Time Sheet")
            {
                ApplicationArea = All;
            }
            field("Admin User"; Rec."Admin User")
            {
                ApplicationArea = All;
            }
            field("Project Manager"; Rec."Project Manager")
            {
                ApplicationArea = All;
            }
            field("Head Of Department"; Rec."Head Of Department")
            {
                ApplicationArea = All;
            }
            field("Project Manager for Cash Flow"; Rec."Project Manager for Cash Flow")
            {
                ApplicationArea = All;
            }
            field("Unadjusted Cash Flow Member"; Rec."Unadjusted Cash Flow Member")
            {
                ApplicationArea = All;
            }
            field("Time Sheet Owner User ID"; Rec."Time Sheet Owner User ID")
            {
                ApplicationArea = All;
            }
            field("Time Sheet Approver User ID"; Rec."Time Sheet Approver User ID")
            {
                ApplicationArea = All;
            }
            field("Manager No."; Rec."Manager No.")
            {
                ApplicationArea = All;
            }
            field("TL Report"; Rec."TL Report")
            {
                ApplicationArea = All;
            }
            field("Desk Cost"; Rec."Desk Cost")
            {
                ApplicationArea = All;
            }
            field(Desgination; Rec.Desgination)
            {
                ApplicationArea = All;
            }
        }
    }
}
