pageextension 50023 PostedPurchaseInvoiceExt extends "Posted Purchase Invoice"
{
    actions
    {
        addafter(Print)
        {
            action("Print PI GST")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchInvHeader1: Record "Purch. Inv. Header";
                Begin
                    PurchInvHeader1.RESET;
                    PurchInvHeader1.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50119, TRUE, FALSE, PurchInvHeader1);
                End;

            }
            action("Attach Document")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    FileAttachments: Page "File Attachments Page";
                    FilesAttachments: Record "Files Attachments";
                Begin
                    FilesAttachments.RESET;
                    FilesAttachments.SETFILTER("Document No.", '%1|%2', Rec."Pre-Assigned No.", Rec."No.");
                    FileAttachments.SetValues(Rec."No.");
                    FileAttachments.SETTABLEVIEW(FilesAttachments);
                    FileAttachments.RUN;
                End;
            }

        }
    }

}
