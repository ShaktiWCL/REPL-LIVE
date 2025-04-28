pageextension 50017 "PostedSalesInvoice Subform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Line Discount Amount")
        {
            field(Milestone; Rec.Milestone)
            {
                ApplicationArea = all;
            }
        }
    }
}
