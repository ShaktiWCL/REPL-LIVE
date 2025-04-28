codeunit 50026 "Create Sales Order"
{
    TableNo = 472;

    trigger OnRun()
    begin
        OrderGenerated := 0;
        InboundSalesHeader.RESET;
        InboundSalesHeader.SETFILTER(Status, '%1|%2', InboundSalesHeader.Status::Pending, InboundSalesHeader.Status::Error);
        IF InboundSalesHeader.FINDSET THEN
            REPEAT
                IF NOT CODEUNIT.RUN(CODEUNIT::"Batch Create Sales Order", InboundSalesHeader) THEN BEGIN
                    InboundSalesHeader.FIND;
                    InboundSalesHeader.Status := InboundSalesHeader.Status::Error;
                    InboundSalesHeader."Processed Date" := CURRENTDATETIME;
                    InboundSalesHeader."Error Message" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                    InboundSalesHeader.MODIFY;
                    CLEARLASTERROR;
                    COMMIT;
                END;
                OrderGenerated := OrderGenerated + 1;
                IF OrderGenerated = 500 THEN
                    EXIT;
            UNTIL InboundSalesHeader.NEXT = 0;
        MESSAGE('Success');
    end;

    var
        InboundSalesHeader: Record "Inbound Sales Header";
        OrderGenerated: Integer;
}

