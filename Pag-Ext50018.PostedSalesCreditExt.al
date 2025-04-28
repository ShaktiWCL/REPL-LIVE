pageextension 50018 PostedSalesCreditExt extends "Posted Sales Credit Memo"
{
    actions
    {
        addafter(Print)
        {
            action("Print Credit Note")
            {
                Caption = 'Print Credit Note';
                IMAGE = Print;
                trigger OnAction()
                var
                    SalesCredMemoHeader: Record "Sales Cr.Memo Header";
                begin

                    SalesCredMemoHeader.Reset();
                    SalesCredMemoHeader.SetRange("No.", Rec."No.");
                    if SalesCredMemoHeader.FindFirst() Then
                        Report.RunModal(50114, true, true, SalesCredMemoHeader);
                end;
            }
        }
    }
}
