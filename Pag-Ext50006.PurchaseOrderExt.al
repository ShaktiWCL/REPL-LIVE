pageextension 50006 PurchaseOrderExt extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {

            field("Terms Conditions"; Rec."Terms Conditions")
            {
                ApplicationArea = all;
            }
            field("Terms Conditions 2"; Rec."Terms Conditions 2")
            {
                ApplicationArea = all;
            }
            field("Department Code"; Rec."Department Code")
            {
                ApplicationArea = all;
            }
            field("Department Head"; Rec."Department Head")
            {
                ApplicationArea = all;
            }
            field("PO Status"; Rec."PO Status")
            {
                ApplicationArea = all;
            }
            field("Pending for Authorization"; Rec."Pending for Authorization")
            {
                ApplicationArea = all;
            }
            field(Authorised; Rec.Authorised)
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter(Print)
        {
            action("PO Print Report")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    PurchaseLine: Record "Purchase Line";
                    Project: Record Job;
                begin

                    IF COMPANYNAME IN ['REPL', 'RIPL', 'RFA'] THEN BEGIN
                        //AD_REPL

                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE("Document No.", Rec."No.");
                        IF PurchaseLine.FINDFIRST THEN BEGIN
                            Project.RESET;
                            Project.SETRANGE("Global Dimension 1 Code", PurchaseLine."Shortcut Dimension 1 Code");
                            IF NOT Project.FINDFIRST THEN
                                ERROR('Project Costcenter doesnot exit in purchase lines');
                        END;
                        //AD_REPL
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUN(50003, TRUE, TRUE, Rec);
                    END ELSE BEGIN
                        //AD_REPL
                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE("Document No.", Rec."No.");
                        IF PurchaseLine.FINDFIRST THEN BEGIN
                            Project.RESET;
                            Project.SETRANGE("Global Dimension 1 Code", PurchaseLine."Shortcut Dimension 1 Code");
                            IF NOT Project.FINDFIRST THEN
                                ERROR('Project Costcenter doesnot exit in purchase lines');
                        END;
                        //AD_REPL
                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUN(50004, TRUE, TRUE, Rec);
                    END;
                end;
            }
            action("PO REPORT DT 24 NOV 20")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUN(60126, TRUE, TRUE, Rec);
                end;
            }

            action("Purchase Order- Long Comment")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUN(50146, TRUE, TRUE, Rec);
                end;
            }
        }
    }
}
