codeunit 50002 "Tender Alert"
{

    trigger OnRun()
    begin
        MESSAGE('Hi');
        /*
        SendMailBefore15DaysBGExprire;
        SendMailBefore30DaysBGExprire;
        SendMailAfter30DaysEMDExprire;
        */

    end;

    var
        EmailIdSetup: Record "Email Id Setup";

    procedure SendMailBefore15DaysBGExprire()
    var
        Tender: Record Tender;
    begin
        Tender.SETFILTER("Bank Guarantee Expiry Date", '%1', TODAY + 15);
        IF Tender.FINDSET THEN
            REPEAT
                MailBodyforBGExpireBefore15Days(Tender);
            UNTIL Tender.NEXT = 0;
    end;

    procedure SendMailBefore30DaysBGExprire()
    var
        Tender: Record Tender;
    begin
        Tender.SETFILTER("Bank Guarantee Expiry Date", '%1', TODAY + 30);
        IF Tender.FINDSET THEN
            REPEAT
                MailBodyforBGExpireBefore30Days(Tender);
            UNTIL Tender.NEXT = 0;
    end;

    procedure SendMailAfter30DaysEMDExprire()
    var
        Tender: Record Tender;
    begin
        Tender.SETFILTER("EMD Expiry Date", '%1', TODAY - 30);
        IF Tender.FINDSET THEN
            REPEAT
                MailBodyforEMDExpireAfter30Days(Tender);
            UNTIL Tender.NEXT = 0;
    end;

    procedure MailBodyforBGExpireBefore15Days(Tender: Record Tender)
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        TeamLeadSetup: Record "Team Lead Setup";
        CCEmail: Text;
        Text50001: Label '';
    begin
        IF TeamLeadSetup.GET(Tender."Team Lead.") THEN
            ReceiverEmail := TeamLeadSetup."Email Id";

        IF EmailIdSetup.GET(50026) THEN
            CCEmail := EmailIdSetup."BD Email" + ';' + EmailIdSetup."Finance Email";
        Subject := 'BG Expire Before 15 Days Notification ';
        Body := ('</B>' + 'Dear Sir/Madam,'
        + '</BR><BR><BR>' + 'Please find  below mention details for BG Expire Before 15 Days:-'
        + '<table border="1">'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
        + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'BANK GUARANTEE EXPIRY DATE:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender."Bank Guarantee Expiry Date") + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'BANK GUARANTEE AMOUNT:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender."Bank Guarantee Amount") + '</div></th>'
        + '</tr>'
        + '</table border="1">'
        + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
        + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        CLEAR(CodeMail);
        CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
    end;

    procedure MailBodyforBGExpireBefore30Days(Tender: Record Tender)
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        TeamLeadSetup: Record "Team Lead Setup";
        CCEmail: Text;
        Text50001: Label '';
    begin
        IF TeamLeadSetup.GET(Tender."Team Lead.") THEN
            ReceiverEmail := TeamLeadSetup."Email Id";

        IF EmailIdSetup.GET(50026) THEN
            CCEmail := EmailIdSetup."BD Email" + ';' + EmailIdSetup."Finance Email";

        Subject := 'BG Expire Before 30 Days Notification ';
        Body := ('</B>' + 'Dear Sir/Madam,'
        + '</BR><BR><BR>' + 'Please find below mention details for BG Expire Before 30 Days:-'
        + '<table border="1">'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
        + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'BANK GUARANTEE EXPIRY DATE:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender."Bank Guarantee Expiry Date") + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'BANK GUARANTEE AMOUNT:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender."Bank Guarantee Amount") + '</div></th>'
        + '</tr>'
        + '</table border="1">'
        + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
        + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        CLEAR(CodeMail);
        CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
    end;

    procedure MailBodyforEMDExpireAfter30Days(Tender: Record Tender)
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        TeamLeadSetup: Record "Team Lead Setup";
        CCEmail: Text;
        Text50001: Label '';
    begin
        IF TeamLeadSetup.GET(Tender."Team Lead.") THEN
            ReceiverEmail := TeamLeadSetup."Email Id";

        IF EmailIdSetup.GET(50026) THEN
            CCEmail := EmailIdSetup."BD Email" + ';' + EmailIdSetup."Finance Email";

        Subject := 'EMD Expire After 30 Days Notification ';
        Body := ('</B>' + 'Dear Sir/Madam,'
        + '</BR><BR><BR>' + 'Please find below mention details for EMD Expire After 30 Days:-'
        + '<table border="1">'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
        + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'EMD:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender.EMD) + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'EMD EXPIRY DATE:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender."EMD Expiry Date") + '</div></th>'
        + '</tr>'
        + '</table border="1">'
        + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
        + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        CLEAR(CodeMail);
        CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
    end;

    procedure StatusUpdateMail(Tender: Record Tender)
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        TeamLeadSetup: Record "Team Lead Setup";
        CCEmail: Text;
        Text50001: Label '';
    begin
        IF TeamLeadSetup.GET(Tender."Team Lead.") THEN
            ReceiverEmail := TeamLeadSetup."Email Id";

        IF EmailIdSetup.GET(50026) THEN
            CCEmail := EmailIdSetup."BD Email" + ';' + EmailIdSetup."CMD Email Id";

        //CCEmail := Employee2."E-Mail"+';';
        IF Tender."Status Of Tender" = Tender."Status Of Tender"::LOST THEN BEGIN
            Subject := 'Tender Status Notification ';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find  below mention details for tender status:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
            + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'STATUS OF TENDER:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Tender."Status Of Tender") + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'REASON FOR FAILURE:' + '</div></th>'
            + '<th><div align="left">' + Tender."Reasons For Failure" + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        END ELSE BEGIN
            Subject := 'Tender Status Notification ';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find  below mention details for tender status:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
            + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'STATUS OF TENDER:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Tender."Status Of Tender") + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        END;
        CLEAR(CodeMail);
        CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
    end;

    procedure QuotesApproverMail(Tender: Record Tender)
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        TeamLeadSetup: Record "Team Lead Setup";
        CCEmail: Text;
        Text50001: Label '';
    begin
        IF TeamLeadSetup.GET(Tender."Team Lead.") THEN
            ReceiverEmail := TeamLeadSetup."Email Id";

        IF EmailIdSetup.GET(50026) THEN
            CCEmail := EmailIdSetup."CMD Email Id";

        Subject := 'Tender Quotes Approver Notification ';
        Body := ('</B>' + 'Dear Sir/Madam,'
        + '</BR><BR><BR>' + 'Please find  below mention details for tender quotes approver:-'
        + '<table border="1">'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
        + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'QUOTES APPROVER:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender."Quotes Approver") + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'STATUS OF TENDER:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender."Status Of Tender") + '</div></th>'
        + '</tr>'
        + '</table border="1">'
        + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
        + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        CLEAR(CodeMail);
        CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
    end;

    procedure EMDRecoveryStatusUpdateMail(Tender: Record Tender)
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        TeamLeadSetup: Record "Team Lead Setup";
        CCEmail: Text;
        Text50001: Label '';
    begin
        IF TeamLeadSetup.GET(Tender."Team Lead.") THEN
            ReceiverEmail := TeamLeadSetup."Email Id";

        IF EmailIdSetup.GET(50026) THEN
            CCEmail := EmailIdSetup."Finance Email";

        IF Tender."EMD Recovery Status" = Tender."EMD Recovery Status"::"Not Received" THEN BEGIN
            Subject := 'EMD Recovery Status Notification ';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find  below mention details for EMD recovery status:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
            + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'EMD:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Tender.EMD) + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'EMD RECOVERY STATUS:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Tender."EMD Recovery Status") + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        END ELSE BEGIN
            Subject := 'EMD Recovery Status Notification ';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find  below mention details for EMD recovery status:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
            + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'EMD:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Tender.EMD) + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'EMD RECOVERY STATUS:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Tender."EMD Recovery Status") + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        END;
        CLEAR(CodeMail);
        CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
    end;

    procedure BidUpdateMail(Tender: Record Tender)
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        TeamLeadSetup: Record "Team Lead Setup";
        CCEmail: Text;
        Text50001: Label '';
    begin
        IF TeamLeadSetup.GET(Tender."Team Lead.") THEN
            ReceiverEmail := TeamLeadSetup."Email Id";

        //CCEmail := Employee2."E-Mail"+';';
        Subject := 'Bid Notification ';
        Body := ('</B>' + 'Dear Sir/Madam,'
        + '</BR><BR><BR>' + 'Please find  below mention details for bid:-'
        + '<table border="1">'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
        + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'PROJECT VALUE:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender."Project Value") + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'BID:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender."Bid/No Bid") + '</div></th>'
        + '</tr>'
        + '</table border="1">'
        + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
        + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        CLEAR(CodeMail);
        CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
    end;

    procedure EligibilityUpdateMail(Tender: Record Tender)
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        TeamLeadSetup: Record "Team Lead Setup";
        CCEmail: Text;
        Text50001: Label '';
    begin
        IF TeamLeadSetup.GET(Tender."Team Lead.") THEN
            ReceiverEmail := TeamLeadSetup."Email Id";

        //CCEmail := Employee2."E-Mail"+';';
        IF Tender.Eligibility = Tender.Eligibility::Yes THEN BEGIN
            Subject := 'Eligiblity Notification ';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find  below mention details for eligibility:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
            + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT VALUE:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Tender."Project Value") + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'ELIGIBILITY:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Tender.Eligibility) + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        END ELSE BEGIN
            Subject := 'Eligiblity Notification ';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find  below mention details for eligibility:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
            + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
            + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT VALUE:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Tender."Project Value") + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'ELIGIBILITY:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Tender.Eligibility) + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'REASON FOR NOT ELIGIBLE:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Tender."Reason For Not Eligible") + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        END;
        CLEAR(CodeMail);
        CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
    end;

    procedure SendApproveMail(Tender: Record Tender)
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        TeamLeadSetup: Record "Team Lead Setup";
        CCEmail: Text;
        Text50001: Label 'GKGaur@replurbanplanners.com;amitnautiyal@replurbanplanners.com,vinit@replurbanplanners.com';
    begin
        IF TeamLeadSetup.GET(Tender."Team Lead.") THEN
            ReceiverEmail := TeamLeadSetup."Email Id";

        //CCEmail := Employee2."E-Mail"+';';
        Subject := 'Bid Notification ';
        Body := ('</B>' + 'Dear Sir/Madam,'
        + '</BR><BR><BR>' + 'Please find  below mention details for bid:-'
        + '<table border="1">'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NO.:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender No." + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TENDER NAME:' + '</div></th>'
        + '<th><div align="left">' + Tender."Tender Name" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'TEAM LEADER:' + '</div></th>'
        + '<th><div align="left">' + Tender."Team Lead" + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'PROJECT VALUE:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender."Project Value") + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'ELIGIBILITY:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender.Eligibility) + '</div></th>'
        + '</tr>'
        + '<tr>'
        + '<th><div align="left">' + 'BID:' + '</div></th>'
        + '<th><div align="left">' + FORMAT(Tender."Bid/No Bid") + '</div></th>'
        + '</tr>'
        + '</table border="1">'
        + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
        + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
        CLEAR(CodeMail);
        CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
    end;
}

