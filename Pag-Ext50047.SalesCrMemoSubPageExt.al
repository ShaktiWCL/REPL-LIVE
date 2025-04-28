pageextension 50047 "Sales Cr. Memo Sub PageExt" extends "Sales Cr. Memo Subform"
{
    layout
    {
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
        //BalAmount := Window.InputBox('Input Amount','INPUT','',100,100);
        //EVALUATE(BalAmount1,BalAmount);
        IF BalAmount1 <> 0 THEN BEGIN
            IF BalAmount1 <= Rec."Unit Price" THEN BEGIN
                ProjectPlanningLine.SETRANGE("Job No.", ProjectNo);
                ProjectPlanningLine.SETRANGE("Job Task No.", MileStone1);
                // ProjectPlanningLine.SETRANGE("Line No.",LineNo);
                IF ProjectPlanningLine.FINDFIRST THEN BEGIN
                    ProjectTask.SETRANGE("Job No.", ProjectNo);
                    ProjectTask.SETRANGE("Job Task No.", ProjectPlanningLine."Job Task No.");
                    IF ProjectTask.FINDFIRST THEN BEGIN
                        ProjectTask."Balance Amount(Credit)" := ProjectTask."Balance Amount(Credit)" + BalAmount1;
                        ProjectTask.MODIFY;
                    END;
                    ProjectPlanningLine."Balance Amount(Credit)" := ProjectPlanningLine."Balance Amount(Credit)" + BalAmount1;
                    ProjectPlanningLine.MODIFY;
                    //AD_REPL
                    IF (Rec."Unit Price" - BalAmount1) = 0 THEN
                        Rec."Deleted Amount" := Rec."Line Amount";
                    //AD_REPL
                    Rec.VALIDATE("Unit Price", (Rec."Unit Price" - BalAmount1));
                    Rec.MODIFY;
                    //MailBodySalesAmountRevised("Document No.","Unit Price"+BalAmount1,"Unit Price");
                END;
            END ELSE
                ERROR('You Cannot Enter Greater Then Amount %1', Rec."Unit Price");
        END ELSE
            ERROR('Please Enter Amount!');
    end;
}
