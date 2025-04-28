pageextension 50030 FixedAssetExt extends "Fixed Asset Card"
{
    layout
    {
        addafter("Vendor No.")
        {
            field("FA Tag No."; Rec."FA Tag No.")
            {
                ApplicationArea = all;
            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = all;
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = all;
            }
        }
        addafter(Insured)
        {
            field("Purchase Value"; Rec."Purchase Value")
            {
                ApplicationArea = all;
            }
            field("Purchase Date"; Rec."Purchase Date")
            {
                ApplicationArea = all;
            }
            field("Company Name"; Rec."Company Name")
            {
                ApplicationArea = all;
            }
            field("Employee No. 1"; Rec."Employee No. 1")
            {
                ApplicationArea = all;
            }
            field("FA Issue Date 1"; Rec."FA Issue Date 1")
            {
                ApplicationArea = all;
            }
            field("FA Return Date 1"; Rec."FA Return Date 1")
            {
                ApplicationArea = all;
            }
            field("Employee No. 2"; Rec."Employee No. 2")
            {
                ApplicationArea = all;
            }
            field("FA Issue Date 2"; Rec."FA Issue Date 2")
            {
                ApplicationArea = all;
            }
            field("FA Return Date 2"; Rec."FA Return Date 2")
            {
                ApplicationArea = all;
            }
            field("Employee No. 3"; Rec."Employee No. 3")
            {
                ApplicationArea = all;
            }
            field("FA Issue Date 3"; Rec."FA Issue Date 3")
            {
                ApplicationArea = all;
            }
            field("FA Return Date 3"; Rec."FA Return Date 3")
            {
                ApplicationArea = all;
            }
            field("Minor Category"; Rec."Minor Category")
            {
                ApplicationArea = all;
            }
            field(Stock; Rec.Stock)
            {
                ApplicationArea = all;
            }
        }
        modify(Maintenance)
        {
            Editable = IsTab;
        }
    }
    var
        IsTab: Boolean;
        IsVisible: Boolean;

    procedure IsTabEditable()
    var
        UserSetup: Record "User Setup";
        CompanyInformation: Record "Company Information";
    begin
        UserSetup.GET(USERID);
        IF (UserSetup.Department IN [UserSetup.Department::IT]) OR (UserSetup."Admin User") THEN
            IsTab := TRUE
        ELSE
            IsTab := FALSE;

        CompanyInformation.GET;
        IF CompanyInformation.Name = 'Group Companies (Others)' THEN
            IsVisible := TRUE
        ELSE
            IsVisible := FALSE;
    end;
}

