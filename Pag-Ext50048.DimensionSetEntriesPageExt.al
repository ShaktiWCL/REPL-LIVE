pageextension 50048 "Dimension Set Entries PageExt" extends "Edit Dimension Set Entries"
{
    layout
    {
        // modify("Dimension Code")
        // {
        //     Editable = EditableField;
        // }
        // modify(DimensionValueCode)
        // {
        //     Editable = EditableField;
        // }
    }
    trigger OnOpenPage()
    begin
        EditableField := Rec."Dimension Code" <> 'FINANCEBOOK';
    end;

    trigger OnAfterGetRecord()
    begin
        EditableField := Rec."Dimension Code" <> 'FINANCEBOOK';
    end;

    var
        EditableField: Boolean;
}
