pageextension 50015 "PostedSalesInvExt" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Transmittal Attach. Status"; Rec."Transmittal Attach. Status")
            {
                ApplicationArea = all;
            }
            field("Bank Account No."; Rec."Bank Account No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Project Desc (SUDA)"; Rec."Project Desc (SUDA)")
            {
                ApplicationArea = all;
            }
        }
        addafter("Cancel Reason")
        {
            field("Print Location"; Rec."Print Location")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter(Print)
        {
            action("Print GST Invoice")
            {
                Caption = 'Print GST Invoice';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin

                    SalesInvHeader.Reset();
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    if SalesInvHeader.FindFirst() Then
                        Report.RunModal(50095, true, true, SalesInvHeader);
                end;
            }
            action("Print Debit Note")
            {
                Caption = 'Print Debit Note';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin

                    SalesInvHeader.Reset();
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    if SalesInvHeader.FindFirst() Then
                        Report.RunModal(50095, true, true, SalesInvHeader);
                end;
            }
            action("Resource Invoice")
            {
                Caption = 'Resource Invoice';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin

                    SalesInvHeader.Reset();
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    if SalesInvHeader.FindFirst() Then
                        Report.RunModal(50126, true, true, SalesInvHeader);
                end;
            }
            action("Reimbursement Invoice")
            {
                Caption = 'Reimbursement Invoice';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin

                    SalesInvHeader.Reset();
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    if SalesInvHeader.FindFirst() Then
                        Report.RunModal(50128, true, true, SalesInvHeader);
                end;
            }
            action("Reimbursement Inv New")
            {
                Caption = 'Reimbursement Inv New';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin

                    SalesInvHeader.Reset();
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    if SalesInvHeader.FindFirst() Then
                        Report.RunModal(70110, true, true, SalesInvHeader);
                end;
            }
            action("SUDA Posted Invoice")
            {
                Caption = 'SUDA Posted Invoice';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin

                    SalesInvHeader.Reset();
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    if SalesInvHeader.FindFirst() Then
                        Report.RunModal(60105, true, true, SalesInvHeader);
                end;
            }
            action("SUDA Posted Invoice New")
            {
                Caption = 'SUDA Posted Invoice New';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin

                    SalesInvHeader.Reset();
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    if SalesInvHeader.FindFirst() Then
                        Report.RunModal(90147, true, true, SalesInvHeader);
                end;
            }
            action("Resource Invoice New")
            {
                Caption = 'Resource Invoice New';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin

                    SalesInvHeader.Reset();
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    if SalesInvHeader.FindFirst() Then
                        Report.RunModal(70108, true, true, SalesInvHeader);
                end;
            }
        }

    }
}