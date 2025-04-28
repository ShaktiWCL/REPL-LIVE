pageextension 50016 SalesInvoiceExt extends "Sales Invoice"
{
    layout
    {
        addafter("Location Code")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
        }
        addbefore(Status)
        {
            field("Bank Account No."; Rec."Bank Account No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(ProformaInvoice)
        {
            action("Pre GST Invoice")
            {
                Caption = 'Pre GST Invoice';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin

                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() Then
                        Report.RunModal(50111, true, true, SalesHeader);
                end;
            }
            action("Pre Resource Invoice")
            {
                Caption = 'Pre Resource Invoice';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin

                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() Then
                        Report.RunModal(60107, true, true, SalesHeader);
                end;
            }
            action("Pre Reimbursement Invoice")
            {
                Caption = 'Pre Reimbursement Invoice';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin

                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() Then
                        Report.RunModal(60109, true, true, SalesHeader);
                end;
            }
            action("Print Invoice(SUDA)")
            {
                Caption = 'Print Invoice(SUDA)';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin

                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() Then
                        Report.RunModal(50147, true, true, SalesHeader);
                end;
            }
        }
    }
}
