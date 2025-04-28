codeunit 50005 "File Attachment Mgt."
{

    trigger OnRun()
    var
        FileName: Text;
    begin
    end;

    var
        ImportTxt: Label 'Insert File';
        FileDialogTxt: Label 'Attachments (%1)|%1';
        FilterTxt: Label '*.jpg;*.jpeg;*.bitmap;*.pdf;*xlsx;*.xls';
        GetDocumentNo: Code[20];
        PurchPayablesSetup: Record "Purchases & Payables Setup";

    procedure UploadFileNotInUse(var IncomingDocumentAttachment: Record "Files Attachments"; var FileName: Text) ServerFileName: Text
    var
        //TempBlob: Record TempBlob;
        FileManagement: Codeunit "File Management";
    begin
        //FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, STRSUBSTNO(FileDialogTxt, FilterTxt), FilterTxt);
        //IncomingDocumentAttachment.Content := TempBlob.Blob;
        ImportAttachment(IncomingDocumentAttachment, FileName);
        ServerFileName := FileName;
    end;

    procedure ImportAttachment(var IncomingDocumentAttachment: Record "Files Attachments"; FileName: Text): Boolean
    var
        //TempBlob: Record TempBlob;
        FileManagement: Codeunit "File Management";
        CheckFilesAttachments: Record "Files Attachments";
        EntryNo: Integer;
    begin
        IF FileName = '' THEN
            ERROR('');

        //WITH IncomingDocumentAttachment DO BEGIN
        IF NOT IncomingDocumentAttachment.Content.HASVALUE THEN BEGIN
            // IF FileManagement.ServerFileExists(FileName) THEN
            //   FileManagement.BLOBImportFromServerFile(TempBlob, FileName)
            // ELSE
            //     FileManagement.BLOBImportFromServerFile(TempBlob, FileManagement.UploadFileSilent(FileName));
            //IncomingDocumentAttachment.Content := TempBlob.Blob;
        END;
        IncomingDocumentAttachment.VALIDATE("File Extension", LOWERCASE(COPYSTR(FileManagement.GetExtension(FileName), 1, MAXSTRLEN(IncomingDocumentAttachment."File Extension"))));
        IF IncomingDocumentAttachment.Name = '' THEN
            IncomingDocumentAttachment.Name := COPYSTR(FileManagement.GetFileNameWithoutExtension(FileName), 1, MAXSTRLEN(IncomingDocumentAttachment.Name));
        IncomingDocumentAttachment.MODIFY;
        //END;
        EXIT(TRUE);
    end;

    procedure UploadFile(var IncomingDocumentAttachment: Record "Files Attachments"; var FileName: Text) ServerFileName: Text
    var
        //TempBlob: Record TempBlob;
        FileManagement: Codeunit "File Management";
        RecRef: RecordRef;
        RecordLink: Record "Record Link";
        GetProject: Record Job;
        GetProjectCharter: Record "Project Charter";
        GetTransmitalHeader: Record "Transmital Header";
        GetPurchaseHeader: Record "Purchase Header";
        FilePath: Text;
        PurchaseInvoice: Record "Purchase Header";
        RequisitionHeader: Record "Requisition Header";
        GetTenderHeader: Record Tender;
        PurchInvHeader: Record "Purch. Inv. Header";
        UploadedFile: Boolean;
        InStr: InStream;
        TempFileName: Text;
        OutStr: OutStream;
    begin
        IF GetProjectCharter.GET(GetDocumentNo) THEN BEGIN
            RecRef.GETTABLE(GetProjectCharter);
            FilePath := 'D:\Project Charter Attachment\';
        END;

        IF GetProject.GET(GetDocumentNo) THEN BEGIN
            RecRef.GETTABLE(GetProject);
            FilePath := 'D:\Project Attachment\';
        END;

        IF GetTransmitalHeader.GET(GetDocumentNo) THEN BEGIN
            RecRef.GETTABLE(GetTransmitalHeader);
            FilePath := 'D:\Transmital Attachment\';
        END;

        GetPurchaseHeader.RESET;
        GetPurchaseHeader.SETRANGE("No.", GetDocumentNo);
        IF GetPurchaseHeader.FINDFIRST THEN BEGIN
            RecRef.GETTABLE(GetPurchaseHeader);
            IF GetPurchaseHeader."Document Type" = GetPurchaseHeader."Document Type"::Invoice THEN
                FilePath := 'D:\Fixed Asset Attachment\';
            IF GetPurchaseHeader."Document Type" = GetPurchaseHeader."Document Type"::Order THEN
                FilePath := 'D:\PO Attachment\';
        END;

        PurchInvHeader.RESET;
        PurchInvHeader.SETRANGE("No.", GetDocumentNo);
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            RecRef.GETTABLE(PurchInvHeader);
            FilePath := 'D:\PI Attachment\';
        END;


        IF RequisitionHeader.GET(GetDocumentNo) THEN BEGIN
            RecRef.GETTABLE(RequisitionHeader);
            FilePath := 'D:\Requisition\';
        END;

        IF GetTenderHeader.GET(GetDocumentNo) THEN BEGIN
            RecRef.GETTABLE(GetTenderHeader);
            FilePath := 'D:\Tender Attachment\';
        END;

        PurchPayablesSetup.GET;
        IF (PurchPayablesSetup."PI Attachment Option" = PurchPayablesSetup."PI Attachment Option"::"Fixed Asset") OR (PurchPayablesSetup."PI Attachment Option" = PurchPayablesSetup."PI Attachment Option"::All) THEN BEGIN
            PurchaseInvoice.RESET;
            PurchaseInvoice.SETRANGE("Document Type", PurchaseInvoice."Document Type"::Invoice);
            PurchaseInvoice.SETRANGE("No.", GetDocumentNo);
            IF PurchaseInvoice.FINDFIRST THEN BEGIN
                RecRef.GETTABLE(PurchaseInvoice);
                FilePath := 'D:\PI Attachment\'
            END
            // ELSE ERROR('You Cannot Attached document in posted invoice');
        END;
        IF FilePath = '' THEN
            ERROR('Document cannot be find');


        UploadedFile := UploadIntoStream('Select file', '', '', TempFileName, InStr);
        FileName := TempFileName;
        //FileManagement.CopyServerFile(FileName, FilePath + GetDocumentNo + ' ' + FileManagement.GetFileName(FileName), TRUE);
        RecordLink.INIT;
        RecordLink."Record ID" := RecRef.RECORDID;
        RecordLink.URL1 := '\\103.69.219.50\' + FilePath + GetDocumentNo + ' ' + FileManagement.GetFileName(FileName);
        RecordLink.Description := FileManagement.GetFileName(FileName);
        RecordLink.Created := CREATEDATETIME(WORKDATE, TIME);
        RecordLink."User ID" := USERID;
        RecordLink.Company := COMPANYNAME;
        RecordLink.INSERT;

        IncomingDocumentAttachment.Content.CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        ImportAttachment(IncomingDocumentAttachment, FileName);
        ServerFileName := FileName;
    end;

    procedure SetValues(SetDocument: Code[20])
    begin
        GetDocumentNo := SetDocument;
    end;
}

