codeunit 50051 "Purchase Posting"
{

    trigger OnRun()
    begin
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Invoice);
        IF PurchHeader.FINDFIRST THEN
            REPEAT
                CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PurchHeader);
            UNTIL PurchHeader.NEXT = 0;

        MESSAGE('Process Done');
    end;

    var
        PurchHeader: Record "Purchase Header";
}

