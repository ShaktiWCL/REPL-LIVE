report 50143 "Vendor Payment Advise"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/VendorPaymentAdvise.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(BuyfromVendorName_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor Name")
            {
            }
            column(BuyfromVendorNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
            {
            }
            column(OrderNo_PurchInvHeader; "Purch. Inv. Header"."Order No.")
            {
            }
            column(ComInfo_Name; ComInfo.Name)
            {
            }
            column(ComInfo_Add; ComInfo.Address)
            {
            }
            column(ComInfo_Add2; ComInfo."Address 2")
            {
            }
            column(ComInfo_City; ComInfo.City)
            {
            }
            column(ComInfo_Postcode; ComInfo."Post Code")
            {
            }
            column(ComInfo_Pic; ComInfo.Picture)
            {
            }
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

    trigger OnPreReport()
    begin
        ComInfo.GET;
        ComInfo.CALCFIELDS(ComInfo.Picture);
    end;

    var
        ComInfo: Record "Company Information";
}

