report 50132 "Purchase Order Comparision"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PurchaseOrderComparision.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Order),
                                      Type = CONST(Item));
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            column(ReportName_Cap; ReportNameCap)
            {
            }
            column(SrNo_Cap; SrNoCap)
            {
            }
            column(PODate_Cap; PODateCap)
            {
            }
            column(PODeliveryCity_Cap; PODeliveryCityCap)
            {
            }
            column(VendorName_Cap; VendorNameCap)
            {
            }
            column(VendorCity_Cap; VendorCityCap)
            {
            }
            column(Item_Cap; ItemCap)
            {
            }
            column(DescriptionScopeofwork_Cap; DescriptionScopeofworkCap)
            {
            }
            column(Quantity_Cap; QuantityCap)
            {
            }
            column(ItemPriceUnit_Cap; ItemPriceUnitCap)
            {
            }
            column(UoM_Cap; UoMCap)
            {
            }
            column(VendorContactNo_Cap; VendorContactNoCap)
            {
            }
            column(SrNo; SrNo)
            {
            }
            column(PODate_Val; FORMAT(PODateVal))
            {
            }
            column(PODeliveryCity_Val; PODeliveryCityVal)
            {
            }
            column(VendorName_Val; VendorNameVal)
            {
            }
            column(VendorCity_Val; VendorCityVal)
            {
            }
            column(Item_Val; ItemVal)
            {
            }
            column(DescriptionScopeoFwork_Val; DescriptionScopeoFworkVal)
            {
            }
            column(Quantity_Val; QuantityVal)
            {
            }
            column(ItempriceUnit_Val; ItempriceUnitVal)
            {
            }
            column(UoM_Val; UoMVal)
            {
            }
            column(VendorContactNo_Val; VendorContactNoVal)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ClearOnAfterGetVariable;
                BodyInformation;
            end;

            trigger OnPreDataItem()
            begin
                ClearOnPreVariable;
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
        ReportNameCap: Label 'Purchase Order Comparision';
        SrNoCap: Label 'Sr. No.';
        PODateCap: Label 'PO Date';
        PODeliveryCityCap: Label 'PO Delivery City';
        VendorNameCap: Label 'Vendor Name';
        VendorCityCap: Label 'Vendor City';
        ItemCap: Label 'Item';
        DescriptionScopeofworkCap: Label 'Description/Scope of work';
        QuantityCap: Label 'Quantity';
        ItemPriceUnitCap: Label 'Item Price/Unit';
        UoMCap: Label 'UoM';
        VendorContactNoCap: Label 'Vendor Contact No.';
        PurchaseHeader: Record "Purchase Header";
        GetLocation: Record Location;
        SrNo: Integer;
        PODateVal: Date;
        PODeliveryCityVal: Text;
        VendorNameVal: Text;
        VendorCityVal: Text;
        ItemVal: Text;
        DescriptionScopeoFworkVal: Text;
        QuantityVal: Decimal;
        GetVendor: Record Vendor;
        ItempriceUnitVal: Decimal;
        UoMVal: Code[20];
        VendorContactNoVal: Code[20];


    procedure ClearOnPreVariable()
    begin
        SrNo := 0;
    end;

    procedure ClearOnAfterGetVariable()
    begin
        PODateVal := 0D;
        PODeliveryCityVal := '';
        VendorNameVal := '';
        VendorCityVal := '';
        ItemVal := '';
        DescriptionScopeoFworkVal := '';
        QuantityVal := 0;
        ItempriceUnitVal := 0;
        UoMVal := '';
        VendorContactNoVal := '';
    end;

    procedure BodyInformation()
    begin
        PurchaseHeader.RESET;
        PurchaseHeader.SETRANGE("Document Type", "Purchase Line"."Document Type");
        PurchaseHeader.SETRANGE("No.", "Purchase Line"."Document No.");
        PurchaseHeader.SETFILTER("Type Of Note", '<>%1', PurchaseHeader."Type Of Note"::Credit);
        IF PurchaseHeader.FINDFIRST THEN BEGIN
            GetVendor.GET("Purchase Line"."Buy-from Vendor No.");
            SrNo += 1;
            PODateVal := PurchaseHeader."Posting Date";
            IF GetLocation.GET(PurchaseHeader."Location Code") THEN;

            PODeliveryCityVal := GetLocation.City;
            VendorNameVal := PurchaseHeader."Buy-from Vendor Name";
            VendorCityVal := PurchaseHeader."Buy-from City";
            ItemVal := "Purchase Line"."No.";
            DescriptionScopeoFworkVal := "Purchase Line".Description;
            QuantityVal := "Purchase Line".Quantity;
            ItempriceUnitVal := "Purchase Line"."Direct Unit Cost";
            UoMVal := "Purchase Line"."Unit of Measure Code";
            VendorContactNoVal := GetVendor."Phone No.";

        END ELSE
            CurrReport.SKIP;
    end;
}

