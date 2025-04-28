codeunit 50001 "Alert Email"
{

    trigger OnRun()
    begin
        MESSAGE('Hi');
        /*
        SendMailBeforeExpireBillDate;
        SendMailAfterExpireBillDate;
        SendMailBeforeExpireAgreementDate;
        SendMailAfterExpireAgreementDate;
        PendingApprovalEmail;
        SendMailAfterOneMonthInitiatedDate;
        SendMailBeforeRecieptService;
        SendMailAfterThreeMonthActualInvoieDate;
        */

    end;

    var
        Text50001: Label 'pradeepmisra@replurbanplanners.com;prakasharya@replurbanplanners.com';

    procedure SendMailBeforeExpireBillDate()
    var
        ProjectTask: Record "Job Task";
    begin
        ProjectTask.SETFILTER("Balance Amount", '<>%1', 0);
        ProjectTask.SETFILTER("Planned Bill Date", '%1', TODAY + 7);
        IF ProjectTask.FINDSET THEN
            REPEAT
                MailBodyBeforeExpireBillDate(ProjectTask."Job No.", ProjectTask.Milestone);
            UNTIL ProjectTask.NEXT = 0;
    end;

    procedure MailBodyBeforeExpireBillDate(ProjectNo: Code[20]; Milestone: Code[20])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        ProjectTask: Record "Job Task";
        Employee: Record Employee;
        Project: Record Job;
        Employee2: Record Employee;
        CCEmail: Text;
    begin
        ProjectTask.SETRANGE("Job No.", ProjectNo);
        ProjectTask.SETRANGE(Milestone, Milestone);
        IF ProjectTask.FINDFIRST THEN BEGIN
            IF Employee.GET(ProjectTask."Project Manager") THEN
                ReceiverEmail := Employee."E-Mail";

            IF Project.GET(ProjectTask."Job No.") THEN
                IF Employee2.GET(Project."Responsible Person") THEN
                    CCEmail := Employee2."E-Mail" + ';';

            Subject := 'Invoice Generation Notification ';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find  below mention details for invoice generation:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT CODE:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask."Job No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT NAME:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask.Description + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'MILESTONE:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask.Milestone + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'MILETONE DESCRIPTION:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask."Milestone Desc" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'MILESOTE AMOUNT:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(ProjectTask."Balance Amount") + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'PLANNED BILL DATE:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(ProjectTask."Planned Bill Date") + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'MILESTONE STAGE:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(ProjectTask."Milestone Stages") + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
            CLEAR(CodeMail);
            CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
        END;
    end;

    procedure SendMailAfterExpireBillDate()
    var
        ProjectTask: Record "Job Task";
    begin
        ProjectTask.SETFILTER("Balance Amount", '<>%1', 0);
        ProjectTask.SETFILTER("Planned Bill Date", '%1', TODAY - 1);
        IF ProjectTask.FINDSET THEN
            REPEAT
                MailBodyAfterExpireBillDate(ProjectTask."Job No.", ProjectTask.Milestone);
            UNTIL ProjectTask.NEXT = 0;
    end;

    procedure MailBodyAfterExpireBillDate(ProjectNo: Code[20]; Milestone: Code[20])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        ProjectTask: Record "Job Task";
        Employee: Record Employee;
        Project: Record Job;
        Employee2: Record Employee;
        CCEmail: Text;
    begin
        ProjectTask.SETRANGE("Job No.", ProjectNo);
        ProjectTask.SETRANGE(Milestone, Milestone);
        IF ProjectTask.FINDFIRST THEN BEGIN
            IF Employee.GET(ProjectTask."Project Manager") THEN
                ReceiverEmail := Employee."E-Mail";

            IF Project.GET(ProjectTask."Job No.") THEN
                IF Employee2.GET(Project."Responsible Person") THEN
                    CCEmail := Employee2."E-Mail" + ';';

            Subject := 'Invoice Generation Notification(After Planned Date) ';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find  below mention details for invoice generation which has crossed planned bill date:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT CODE:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask."Job No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT NAME:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask.Description + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'MILESTONE:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask.Milestone + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'MILETONE DESCRIPTION:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask."Milestone Desc" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'MILESOTE AMOUNT:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(ProjectTask."Balance Amount") + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'PLANNED BILL DATE:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(ProjectTask."Planned Bill Date") + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'MILESTONE STAGE:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(ProjectTask."Milestone Stages") + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
            CLEAR(CodeMail);
            CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
        END;
    end;

    procedure SendMailBeforeExpireAgreementDate()
    var
        Project: Record Job;
    begin
        IF TODAY = DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3)) THEN BEGIN
            Project.SETRANGE("Type Of Project", Project."Type Of Project"::"Main Project");
            Project.SETRANGE("Agreement To Date", TODAY, CALCDATE('CM', TODAY));
            IF Project.FINDSET THEN
                REPEAT
                    MailBodyBeforeExpireAgreementDate(Project."No.");
                UNTIL Project.NEXT = 0;
        END;
    end;

    procedure MailBodyBeforeExpireAgreementDate(ProjectNo: Code[20])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        Employee: Record Employee;
        Project: Record Job;
        Employee2: Record Employee;
        CCEmail: Text;
    begin
        IF Project.GET(ProjectNo) THEN BEGIN
            IF Employee.GET(Project."Project Manager") THEN
                ReceiverEmail := Employee."E-Mail";


            IF Employee2.GET(Project."Responsible Person") THEN
                CCEmail := Employee2."E-Mail" + ';';

            Subject := 'Agreement Extention Notification ';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find below mention details for agreement extention:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT CODE:' + '</div></th>'
            + '<th><div align="left">' + Project."No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT NAME:' + '</div></th>'
            + '<th><div align="left">' + Project.Description + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'AGREEMENT NO.:' + '</div></th>'
            + '<th><div align="left">' + Project."Agreement No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'AGREEMENT END DATE:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Project."Agreement To Date") + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
            CLEAR(CodeMail);
            CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
        END;
    end;

    procedure SendMailAfterExpireAgreementDate()
    var
        Project: Record Job;
    begin
        Project.SETRANGE("Type Of Project", Project."Type Of Project"::"Main Project");
        Project.SETFILTER("Agreement To Date", '%1', TODAY - 1);
        IF Project.FINDSET THEN
            REPEAT
                MailBodyAfterExpireAgreementDate(Project."No.");
            UNTIL Project.NEXT = 0;
    end;

    procedure MailBodyAfterExpireAgreementDate(ProjectNo: Code[20])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        Employee: Record Employee;
        Project: Record Job;
        Employee2: Record Employee;
        CCEmail: Text;
    begin
        IF Project.GET(ProjectNo) THEN BEGIN
            IF Employee.GET(Project."Project Manager") THEN
                ReceiverEmail := Employee."E-Mail";


            IF Employee2.GET(Project."Responsible Person") THEN
                CCEmail := Employee2."E-Mail" + ';';

            Subject := 'Agreement Extention Notification(Reminder)';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find below mention details for agreement extention(Reminder):-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT CODE:' + '</div></th>'
            + '<th><div align="left">' + Project."No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT NAME:' + '</div></th>'
            + '<th><div align="left">' + Project.Description + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'AGREEMENT NO.:' + '</div></th>'
            + '<th><div align="left">' + Project."Agreement No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'AGREEMENT END DATE:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(Project."Agreement To Date") + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
            CLEAR(CodeMail);
            CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
        END;
    end;

    procedure PendingApprovalEmail()
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SETFILTER("Due Date", '%1', TODAY - 7);
        IF ApprovalEntry.FINDSET THEN
            REPEAT
                IF ApprovalEntry."Table ID" = 167 THEN
                    MailBodyProjectApprover(ApprovalEntry."Document No.");
                IF ApprovalEntry."Table ID" = 38 THEN
                    MailBodyPurchaseApprover(ApprovalEntry."Document No.", ApprovalEntry."Approver ID");
                IF ApprovalEntry."Table ID" = 36 THEN
                    MailBodySalesApprover(ApprovalEntry."Document No.", ApprovalEntry."Approver ID");
            UNTIL ApprovalEntry.NEXT = 0;
    end;

    procedure MailBodyProjectApprover(ProjectNo: Code[20])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        Employee: Record Employee;
        Project: Record Job;
        Employee2: Record Employee;
        CCEmail: Text;
    begin
        IF Project.GET(ProjectNo) THEN BEGIN
            IF Employee.GET(Project."Project Manager") THEN
                ReceiverEmail := Employee."E-Mail";


            IF Employee2.GET(Project."Responsible Person") THEN
                CCEmail := Employee2."E-Mail" + ';';

            Subject := 'Project Approval Reminder';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find below mention details for project approval(Reminder):-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT CODE:' + '</div></th>'
            + '<th><div align="left">' + Project."No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT NAME:' + '</div></th>'
            + '<th><div align="left">' + Project.Description + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
            CLEAR(CodeMail);
            CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
        END;
    end;

    procedure MailBodyPurchaseApprover(PurchaseOrderNo: Code[20]; ApproverId: Code[50])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        CCEmail: Text;
        UserSetup: Record "User Setup";
        Project: Record Job;
        PurchLine: Record "Purchase Line";
        Employee: Record Employee;
    begin
        IF UserSetup.GET(ApproverId) THEN BEGIN
            ReceiverEmail := UserSetup."E-Mail";
            PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
            PurchLine.SETRANGE("Document No.", PurchaseOrderNo);
            IF PurchLine.FINDFIRST THEN
                IF Project.GET(PurchLine."Job No.") THEN
                    IF Employee.GET(Project."Project Manager") THEN
                        CCEmail := Employee."E-Mail" + ';';

            Subject := 'Purchase Order Approval Reminder';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find below mention details for purchase order approval(Reminder):-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'PURCHASE ORDER NO.:' + '</div></th>'
            + '<th><div align="left">' + PurchaseOrderNo + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
            CLEAR(CodeMail);
            CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
        END;
    end;

    procedure MailBodySalesApprover(SalesInvoiceNo: Code[20]; ApproverId: Code[50])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        CCEmail: Text;
        UserSetup: Record "User Setup";
        Project: Record Job;
        SalesLine: Record "Sales Line";
        Employee: Record Employee;
    begin
        IF UserSetup.GET(ApproverId) THEN BEGIN
            ReceiverEmail := UserSetup."E-Mail";

            SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Invoice);
            SalesLine.SETRANGE("Document No.", SalesInvoiceNo);
            IF SalesLine.FINDFIRST THEN
                IF Project.GET(SalesLine."Job No.") THEN
                    IF Employee.GET(Project."Project Manager") THEN
                        CCEmail := Employee."E-Mail" + ';';

            Subject := 'Invoice Approval Reminder';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find below mention details for invoice approval(Reminder):-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'SALES INVOICE NO.:' + '</div></th>'
            + '<th><div align="left">' + SalesInvoiceNo + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
            CLEAR(CodeMail);
            CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
        END;
    end;

    procedure SendMailAfterOneMonthInitiatedDate()
    var
        Project: Record Job;
    begin
        Project.SETRANGE("Type Of Project", Project."Type Of Project"::"Main Project");
        Project.SETRANGE("Project Status", Project."Project Status"::Draft);
        Project.SETFILTER("Creation Date", '%1', TODAY - 30);
        Project.SETFILTER("Project Value", '>%1', 1000);
        IF Project.FINDFIRST THEN
            REPEAT
                MailBodyAfterOneMonthInitiatedDate(Project."No.");
            UNTIL Project.NEXT = 0;
    end;

    procedure MailBodyAfterOneMonthInitiatedDate(ProjectNo: Code[20])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        Employee: Record Employee;
        Project: Record Job;
        Employee2: Record Employee;
        CCEmail: Text;
    begin
        IF Project.GET(ProjectNo) THEN BEGIN
            IF Project."Project Manager" <> '' THEN BEGIN
                IF Employee.GET(Project."Project Manager") THEN
                    ReceiverEmail := Employee."E-Mail";


                IF Employee2.GET(Project."Responsible Person") THEN
                    CCEmail := Employee2."E-Mail" + ';';

                Subject := 'Agreement Extention Notification ';
                Body := ('</B>' + 'Dear Sir/Madam,'
                + '</BR><BR><BR>' + 'Please find below mention details for agreement extention:-'
                + '<table border="1">'
                + '<tr>'
                + '<th><div align="left">' + 'PROJECT CODE:' + '</div></th>'
                + '<th><div align="left">' + Project."No." + '</div></th>'
                + '</tr>'
                + '<tr>'
                + '<th><div align="left">' + 'PROJECT NAME:' + '</div></th>'
                + '<th><div align="left">' + Project.Description + '</div></th>'
                + '</tr>'
                + '<tr>'
                + '<th><div align="left">' + 'AGREEMENT NO.:' + '</div></th>'
                + '<th><div align="left">' + Project."Agreement No." + '</div></th>'
                + '</tr>'
                + '<tr>'
                + '<th><div align="left">' + 'AGREEMENT END DATE:' + '</div></th>'
                + '<th><div align="left">' + FORMAT(Project."Agreement To Date") + '</div></th>'
                + '</tr>'
                + '</table border="1">'
                + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
                + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
                CLEAR(CodeMail);
                CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
            END;
        END;
    end;

    procedure SendMailBeforeRecieptService()
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETFILTER("Job No.", '<>%1', '');
        PurchaseLine.SETFILTER("Promised Receipt Date", '%1', TODAY + 7);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                MailBodyBeforeRecieptService(PurchaseLine."Document No.");
            UNTIL PurchaseLine.NEXT = 0;
    end;

    procedure MailBodyBeforeRecieptService(PurchaseOrderNo: Code[20])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        CCEmail: Text;
        UserSetup: Record "User Setup";
        Project: Record Job;
        PurchLine: Record "Purchase Line";
        Employee: Record Employee;
        Employee2: Record Employee;
    begin
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SETRANGE("Document No.", PurchaseOrderNo);
        IF PurchLine.FINDFIRST THEN BEGIN
            IF Project.GET(PurchLine."Job No.") THEN
                IF Employee.GET(Project."Project Manager") THEN
                    ReceiverEmail := Employee."E-Mail";

            IF Employee2.GET(Project."Responsible Person") THEN
                CCEmail := Employee2."E-Mail" + ';';

            Subject := 'Service Receipt Reminder';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find below mention details for service reciept(Reminder):-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'SERVICE NO.:' + '</div></th>'
            + '<th><div align="left">' + PurchaseOrderNo + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
            CLEAR(CodeMail);
            CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
        END;
    end;

    procedure SendMailRecieptServiceAfterDeliveryDate(DocumentNo: Code[20])
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", DocumentNo);
        PurchaseLine.SETFILTER("Job No.", '<>%1', '');
        PurchaseLine.SETFILTER("Promised Receipt Date", '%1', TODAY - 1);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                MailBodyRecieptServiceAfterDeliveryDate(PurchaseLine."Document No.");
            UNTIL PurchaseLine.NEXT = 0;
    end;

    procedure MailBodyRecieptServiceAfterDeliveryDate(PurchaseOrderNo: Code[20])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        CCEmail: Text;
        UserSetup: Record "User Setup";
        Project: Record Job;
        PurchLine: Record "Purchase Line";
        Employee: Record Employee;
        Employee2: Record Employee;
    begin
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SETRANGE("Document No.", PurchaseOrderNo);
        IF PurchLine.FINDFIRST THEN BEGIN
            IF Project.GET(PurchLine."Job No.") THEN
                IF Employee.GET(Project."Project Manager") THEN
                    ReceiverEmail := Employee."E-Mail";

            IF Employee2.GET(Project."Responsible Person") THEN
                CCEmail := Employee2."E-Mail" + ';';

            Subject := 'Service Receipt After Delivery Date';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find below mention details for service reciept After Delivery Date:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'SERVICE NO.:' + '</div></th>'
            + '<th><div align="left">' + PurchaseOrderNo + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
            CLEAR(CodeMail);
            CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
        END;
    end;

    procedure SendMailRecieptService(DocumentNo: Code[20])
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine.SETRANGE("Document No.", DocumentNo);
        PurchRcptLine.SETFILTER("Job No.", '<>%1', '');
        IF PurchRcptLine.FINDFIRST THEN
            //REPEAT
            MailBodyRecieptService(PurchRcptLine."Document No.");
        //UNTIL PurchRcptLine.NEXT = 0;
    end;

    procedure MailBodyRecieptService(RecieptNo: Code[20])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        CCEmail: Text;
        UserSetup: Record "User Setup";
        Project: Record Job;
        PurchRcptLine: Record "Purch. Rcpt. Line";
        Employee: Record Employee;
        Employee2: Record Employee;
        Text50002: Label '';
        EmailIdSetup: Record "Email Id Setup";
    begin
        PurchRcptLine.SETRANGE("Document No.", RecieptNo);
        IF PurchRcptLine.FINDFIRST THEN BEGIN
            /*
             IF Project.GET(PurchRcptLine."Job No.") THEN
              IF Employee.GET(Project."Project Manager") THEN
               ReceiverEmail := Employee."E-Mail";

              IF Employee2.GET(Project."Responsible Person") THEN
               CCEmail := Employee2."E-Mail"+';';
               */
            IF EmailIdSetup."Table Id" = 120 THEN BEGIN
                ReceiverEmail := EmailIdSetup."To Email Id";
                CCEmail := EmailIdSetup."Cc Email Id" + ';' + EmailIdSetup."Operation Head";
            END;
            Subject := 'Service Receipt';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find below mention details for service reciept:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'RECIEPT NO.:' + '</div></th>'
            + '<th><div align="left">' + RecieptNo + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
            CLEAR(CodeMail);
            CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50002, Subject, Body, false, FALSE);
        END;

    end;

    procedure SendMailAfterThreeMonthActualInvoieDate()
    var
        ProjectTask: Record "Job Task";
        Project: Record Job;
    begin
        ProjectTask.SETFILTER("Balance Amount", '<>%1', 0);
        ProjectTask.SETFILTER("Actual Latest Bill Date", '<>%1', 0D);
        IF ProjectTask.FINDSET THEN
            REPEAT
                IF Project.GET(ProjectTask."Job No.") THEN
                    IF (Project."Project Status" <> Project."Project Status"::"Short close") AND (Project."Type Of Project" = Project."Type Of Project"::"Main Project") THEN
                        MailBodyAfterThreeMonthActualInvoieDate(ProjectTask."Job No.", ProjectTask.Milestone);
            UNTIL ProjectTask.NEXT = 0;
    end;

    procedure MailBodyAfterThreeMonthActualInvoieDate(ProjectNo: Code[20]; Milestone: Code[20])
    var
        SenderEmail: Text;
        ReceiverEmail: Text;
        Subject: Text;
        Body: Text;
        CodeMail: Codeunit Mail;
        ProjectTask: Record "Job Task";
        Employee: Record Employee;
        Project: Record Job;
        Employee2: Record Employee;
        CCEmail: Text;
    begin
        ProjectTask.SETRANGE("Job No.", ProjectNo);
        ProjectTask.SETRANGE(Milestone, Milestone);
        ProjectTask.SETFILTER("Actual Latest Bill Date", '<%1', TODAY - 90);
        IF ProjectTask.FINDFIRST THEN BEGIN
            IF Employee.GET(ProjectTask."Project Manager") THEN
                ReceiverEmail := Employee."E-Mail";

            IF Project.GET(ProjectTask."Job No.") THEN
                IF Employee2.GET(Project."Responsible Person") THEN
                    CCEmail := Employee2."E-Mail" + ';';

            Subject := 'Notification For Balance Amount Invoice';
            Body := ('</B>' + 'Dear Sir/Madam,'
            + '</BR><BR><BR>' + 'Please find  below mention details for balance amount invoice:-'
            + '<table border="1">'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT CODE:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask."Job No." + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'PROJECT NAME:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask.Description + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'MILESTONE:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask.Milestone + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'MILETONE DESCRIPTION:' + '</div></th>'
            + '<th><div align="left">' + ProjectTask."Milestone Desc" + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'MILESOTE AMOUNT:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(ProjectTask."Balance Amount") + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'PLANNED BILL DATE:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(ProjectTask."Planned Bill Date") + '</div></th>'
            + '</tr>'
            + '<tr>'
            + '<th><div align="left">' + 'ACTUAL LAST BILL DATE:' + '</div></th>'
            + '<th><div align="left">' + FORMAT(ProjectTask."Actual Latest Bill Date") + '</div></th>'
            + '</tr>'
            + '</table border="1">'
            + '</B><BR><BR>' + 'Warm Regards,' + '</B><BR>' + 'REPL(Navision ERP Team)'
            + '</BR><BR><BR><U><Font COLOR=blue>' + 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Concern Department. ');
            CLEAR(CodeMail);
            CodeMail.CreateMessage(ReceiverEmail, CCEmail, Text50001, Subject, Body, false, FALSE);
        END;
    end;
}

