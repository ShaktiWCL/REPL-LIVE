pageextension 50044 "Project Planning Lines" extends "Job Planning Lines"
{
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
        modify("Line Type")
        {
            Visible = false;
        }

        addafter("Line Amount")
        {
            field("Milestone Amount"; Rec."Milestone Amount")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Balance Amount"; Rec."Balance Amount")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Invoice (To Be Create) Amount"; Rec."Invoice (To Be Create) Amount")
            {
                ApplicationArea = all;
            }
            field("Credit (To Be Create) Amount"; Rec."Credit (To Be Create) Amount")
            {
                ApplicationArea = all;
                Visible = ShowCreditMemo;
            }

            field("Invoiced Amount Incl. Tax"; Rec."Invoiced Amount Incl. Tax")
            {
                ApplicationArea = all;
            }
            field("Balance Amount(Credit)"; Rec."Balance Amount(Credit)")
            {
                ApplicationArea = all;
                Visible = ShowCreditMemo;
            }
            field("Invoice Amount"; Rec."Invoice Amount")
            {
                ApplicationArea = all;
            }
            field("Credit Amount"; Rec."Credit Amount")
            {
                ApplicationArea = all;
                Visible = ShowCreditMemo;
            }
            field("Credited Amount Incl. Tax"; Rec."Credited Amount Incl. Tax")
            {
                ApplicationArea = all;
                Visible = ShowCreditMemo;
            }
        }

    }
    actions
    {
        addafter("F&unctions")
        {
            action(ViewOU)
            {
                Caption = 'ViewOU';
                ApplicationArea = All;
                Image = View;
                RunObject = page "View OU";
            }

        }
    }
    var
        ShowCreditMemo: Boolean;

    trigger OnOpenPage()
    var

    begin
        ShowCreditMemo := true;
    end;

    trigger OnAfterGetRecord()
    var

    begin
        ShowCreditMemo := true;
    end;

}
