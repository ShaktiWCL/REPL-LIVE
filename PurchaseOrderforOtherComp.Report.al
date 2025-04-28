report 50033 "Purchase Order for Other Comp"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PurchaseOrderforOtherComp.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Purchase Header"."Buy-from Vendor Name")
            {
            }
            column(PaytoVendorNo_PurchaseHeader; "Purchase Header"."Pay-to Vendor No.")
            {
            }
            column(PaytoName_PurchaseHeader; "Purchase Header"."Pay-to Name")
            {
            }
            column(PaytoName2_PurchaseHeader; "Purchase Header"."Pay-to Name 2")
            {
            }
            column(PaytoAddress_PurchaseHeader; "Purchase Header"."Pay-to Address" + ',' + "Purchase Header"."Pay-to Address 2")
            {
            }
            column(PaytoAddress2_PurchaseHeader; "Purchase Header"."Pay-to Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; "Purchase Header"."Pay-to City" + '-' + "Purchase Header"."Pay-to Post Code")
            {
            }
            column(PaytoContact_PurchaseHeader; "Purchase Header"."Pay-to Contact")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(PostingDate_PurchaseHeader; "Purchase Header"."Order Date")
            {
            }
            column(CompInfoName; CompanyNameText)
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Purchase Header"."Payment Terms Code")
            {
            }
            column(CompInfoAddress; GetLocation.Address + ', ' + GetLocation."Address 2")
            {
            }
            column(PaytoCounty_PurchaseHeader; "Purchase Header"."Pay-to County")
            {
            }
            column(CompInfoCity; GetLocation.City + '-' + GetLocation."Post Code")
            {
            }
            column(PaymentMethodCode_PurchaseHeader; "Purchase Header"."Payment Method Code")
            {
            }
            column(PhoneNo; GetLocation."Phone No.")
            {
            }
            column(LocationGSTNo; GetLocation."GST Registration No.")
            {
            }
            column(VendPhoneNo; Vend."Phone No.")
            {
            }
            column(VendFaxNo; Vend."Fax No.")
            {
            }
            column(VendEmail; Vend."E-Mail")
            {
            }
            column(VendContact; Vend.Contact)
            {
            }
            column(VendTINNo; '')
            {
            }
            column(VendPANNo; Vend."P.A.N. No.")
            {
            }
            column(VendServiceTaxNo; Vend."GST Registration No.")
            {
            }
            column(PurchRemarks; PurchRemarks)
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(ProjectName; Project.Description + ' ' + Project."Description 2")
            {
            }
            column(TermsConditions; "Terms Conditions")
            {
            }
            column(TermsConditions2; "Terms Conditions 2")
            {
            }
            column(TaxName_Cap; TaxNameCap)
            {
            }
            column(TaxValue_Cap; TaxValueCap)
            {
            }
            column(AmountInWord1; AmountInWord[1])
            {
            }
            dataitem("Purch. Comment Line"; "Purch. Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                    ORDER(Ascending);
                column(Comment_PurchCommentLine; "Purch. Comment Line".Comment)
                {
                }
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description + '  ' + "Purchase Line"."Description 2")
                {
                }
                column(Description2_PurchaseLine; "Purchase Line"."Description 2")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(LineAmount_PurchaseLine; "Purchase Line"."Line Amount")
                {
                }
                column(AmountToVendor_PurchaseLine; "Purchase Line".Amount)
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(SrNo; SrNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SrNo += 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF CompInfo."New Name Date" <> 0D THEN BEGIN
                    IF "Posting Date" >= CompInfo."New Name Date" THEN
                        CompanyNameText := CompInfo.Name
                    ELSE
                        CompanyNameText := CompInfo."Old Name";
                END ELSE
                    CompanyNameText := CompInfo.Name;

                Vend.GET("Purchase Header"."Buy-from Vendor No.");
                PurchRemarks := '';
                PurchCommentLine.SETRANGE("No.", "No.");
                IF PurchCommentLine.FINDSET THEN
                    REPEAT
                        IF PurchRemarks <> '' THEN
                            PurchRemarks += ' ' + PurchCommentLine.Comment
                        ELSE
                            PurchRemarks := PurchCommentLine.Comment;
                    UNTIL PurchCommentLine.NEXT = 0;

                IF "Purchase Header"."Currency Code" <> '' THEN
                    CurrencyCode := "Purchase Header"."Currency Code"
                ELSE
                    CurrencyCode := 'INR';

                PurchaseLine.RESET;
                PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SETRANGE("Document No.", "Purchase Header"."No.");
                IF PurchaseLine.FINDFIRST THEN
                    IF Project.GET(PurchaseLine."Job No.") THEN;


                IF ResponsibilityCenter.GET("Purchase Header"."Responsibility Center") THEN;

                IF GetLocation.GET("Location Code") THEN;

                TaxNameCap := '';
                TaxValueCap := '';

                IF "Order Date" <= 20170630D THEN BEGIN
                    TaxNameCap := 'Service Tax No. ';
                    TaxValueCap := Vend."GST Registration No.";
                END ELSE BEGIN
                    TaxNameCap := 'GST No. ';
                    TaxValueCap := Vend."GST Registration No.";
                END;

                "Purchase Header".CALCFIELDS(Amount);
                Check.InitTextVariable;
                Check.FormatNoText(AmountInWord, "Purchase Header".Amount, '');
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                //CompInfo.CALCFIELDS(CompInfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompInfo: Record "Company Information";
        Vend: Record Vendor;
        SrNo: Integer;
        Check: Report Check;
        AmountInWord: array[2] of Text;
        PurchRemarks: Text;
        PurchCommentLine: Record "Purch. Comment Line";
        CurrencyCode: Code[10];
        PurchaseLine: Record "Purchase Line";
        Project: Record Job;
        TermsConditions: Text;
        ResponsibilityCenter: Record "Responsibility Center";
        GetLocation: Record Location;
        TaxNameCap: Text;
        TaxValueCap: Text;
        CompanyNameText: Text;
}

