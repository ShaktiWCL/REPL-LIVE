codeunit 50050 "Sales Posting"
{

    trigger OnRun()
    begin
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Credit Memo");
        IF SalesHeader.FINDFIRST THEN
            REPEAT
                CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
            UNTIL SalesHeader.NEXT = 0;

        MESSAGE('Process Done');
    end;

    var
        SalesHeader: Record "Sales Header";
}

