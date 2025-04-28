pageextension 50045 "Sales Invoice Sub PageExt" extends "Sales Invoice Subform"
{
    layout
    {
        modify("Item Reference No.")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        addafter("HSN/SAC Code")
        {
            field("Invoice Type"; Rec."Invoice Type")
            {
                ApplicationArea = all;
            }
            field("Resource No."; Rec."Resource No.")
            {
                ApplicationArea = all;
            }
            field("General/OBC"; Rec."General/OBC")
            {
                ApplicationArea = all;
            }
            field(SC; Rec.SC)
            {
                ApplicationArea = all;
            }
            field(ST; Rec.ST)
            {
                ApplicationArea = all;
            }
            field(Milestone; Rec."Job Task No.")
            {
                ApplicationArea = all;
            }
            field("Billing Days"; Rec."Billing Days")
            {
                ApplicationArea = all;
            }
            field("Billing Month"; Rec."Billing Month")
            {
                ApplicationArea = all;
            }
        }
        addafter("Line Amount")
        {
            field("Revised Amount"; RevisedAmt)
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    if RevisedAmt > Rec."Unit Price" then
                        ERROR('You Cannot Enter Greater Then Amount %1', Rec."Unit Price");
                    if Confirm('Do you want to Revised Amount %1', false, Format(RevisedAmt)) then
                        MaintainProjectBalance(Rec."Job No.", Rec."Job Task No.", 0, RevisedAmt);
                    RevisedAmt := 0;
                end;
            }
        }
    }
    var
        RevisedAmt: Decimal;

    local procedure MaintainProjectBalance(ProjectNo: Code[20]; MileStone1: Code[40]; LineNo: Integer; BalAmount1: Decimal)
    var
        ProjectPlanningLine: Record "Job Planning Line";
        ProjectTask: Record "Job Task";
    begin
        //BalAmount := Window.InputBox('Input Amount', 'INPUT', '', 100, 100);
        // EVALUATE(BalAmount1, BalAmount);
        IF BalAmount1 <> 0 THEN BEGIN
            IF BalAmount1 <= Rec."Unit Price" THEN BEGIN
                ProjectPlanningLine.SETRANGE("Job No.", ProjectNo);
                ProjectPlanningLine.SETRANGE(MileStone, MileStone1);
                // ProjectPlanningLine.SETRANGE("Line No.",LineNo);
                IF ProjectPlanningLine.FINDFIRST THEN BEGIN
                    ProjectTask.SETRANGE("Job No.", ProjectNo);
                    ProjectTask.SETRANGE("Job Task No.", ProjectPlanningLine.MileStone);
                    IF ProjectTask.FINDFIRST THEN BEGIN
                        ProjectTask."Balance Amount" := ProjectTask."Balance Amount" + BalAmount1;
                        ProjectTask.MODIFY;
                    END;
                    ProjectPlanningLine."Balance Amount" := ProjectPlanningLine."Balance Amount" + BalAmount1;
                    ProjectPlanningLine.MODIFY;
                    //AD_REPL
                    IF (Rec."Unit Price" - BalAmount1) = 0 THEN
                        Rec."Deleted Amount" := Rec."Line Amount";
                    //AD_REPL
                    Rec.VALIDATE("Unit Price", (Rec."Unit Price" - BalAmount1));
                    Rec.MODIFY;
                    //MailBodySalesAmountRevised(Rec."Document No.", Rec."Unit Price" + BalAmount1, Rec."Unit Price");
                END;
            END ELSE
                ERROR('You Cannot Enter Greater Then Amount %1', Rec."Unit Price");
        END ELSE
            ERROR('Please Enter Amount!');
    end;
}
