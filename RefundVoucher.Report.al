report 50116 "Refund Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/RefundVoucher.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Detailed GST Ledger Entry"; "Detailed GST Ledger Entry")
        {
            column(ReceiptVoucher_Cap; ReceiptVoucherCap)
            {
            }
            column(DetailsOfReceiver_Cap; DetailsOfReceiverCap)
            {
            }
            column(Name_Cap; NameCap)
            {
            }
            column(Address_Cap; AddressCap)
            {
            }
            column(GSTNo_Cap; GSTNoCap)
            {
            }
            column(State_Cap; StateCap)
            {
            }
            column(StateCode_Cap; StateCodeCap)
            {
            }
            column(VoucherNo_Cap; VoucherNoCap)
            {
            }
            column(VoucherDate_Cap; VoucherDateCap)
            {
            }
            column(PlaceOfSupply_Cap; PlaceOfSupplyCap)
            {
            }
            column(ReverseCharge_Cap; ReverseChargeCap)
            {
            }
            column(Sn_Cap; SnCap)
            {
            }
            column(DescrpOfProduct_Cap; DescrpOfProductCap)
            {
            }
            column(HSNSACCode_Cap; HSNSACCodeCap)
            {
            }
            column(TaxableAmount_Cap; TaxableAmountCap)
            {
            }
            column(CGST_Cap; CGSTCap)
            {
            }
            column(IGST_Cap; IGSTCap)
            {
            }
            column(SGST_Cap; SGSTCap)
            {
            }
            column(Rate_Cap; RateCap)
            {
            }
            column(Amount_Cap; AmountCap)
            {
            }
            column(AdvanceAmount_Cap; AdvanceAmountCap)
            {
            }
            column(AuthorisedSignatory_Cap; AuthorisedSignatoryCap)
            {
            }
            column(TotalTaxableAmount_Cap; TotalTaxableAmountCap)
            {
            }
            column(TotalGST_Cap; TotalGSTCap)
            {
            }
            column(InvoiceTotal_Cap; InvoiceTotalCap)
            {
            }
            column(GSTPayableOnReverseCh_Cap; GSTPayableOnReverseChCap)
            {
            }
            column(For_Cap; ForCap)
            {
            }
            column(Document_No; "Document No.")
            {
            }
            column(Company_Name; GetCompInfo.Name)
            {
            }
            column(Location_Address; GetLocation.Address)
            {
            }
            column(Location_Address2; GetLocation."Address 2")
            {
            }
            column(Location_City; GetLocation.City)
            {
            }
            column(Location_PostCode; GetLocation."Post Code")
            {
            }
            column(Location_GSTNo; GetLocation."GST Registration No.")
            {
            }
            column(Location_StateName; GetLocationState.Description)
            {
            }
            column(Location_StateCode; GetLocationState."State Code (GST Reg. No.)")
            {
            }
            column(VendInfo_1; VendInfo[1])
            {
            }
            column(VendInfo_2; VendInfo[2])
            {
            }
            column(VendInfo_3; VendInfo[3])
            {
            }
            column(VendInfo_4; VendInfo[4])
            {
            }
            column(VendInfo_5; VendInfo[5])
            {
            }
            column(VendInfo_6; VendInfo[6])
            {
            }
            column(Product_Code; "Detailed GST Ledger Entry"."No.")
            {
            }
            column(HSNSAC_Code; "Detailed GST Ledger Entry"."HSN/SAC Code")
            {
            }
            column(Posting_Date; "Detailed GST Ledger Entry"."Posting Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                GetLocationState.GET("Location Code");
                GetLocationState.GET(GetLocation."State Code");


                CLEAR(VendInfo);
                IF GetVendor.GET("Source No.") THEN BEGIN
                    VendInfo[1] := GetVendor.Name;
                    VendInfo[2] := GetVendor.Address + ' ' + GetVendor."Address 2";
                    VendInfo[6] := GetVendor.City + '-' + GetVendor."Post Code";
                    VendInfo[3] := GetVendor."GST Registration No.";
                    GetVendorState.GET(GetVendor."State Code");
                    VendInfo[4] := GetVendorState.Description;
                    VendInfo[5] := GetVendorState."State Code (GST Reg. No.)";
                END;
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

    trigger OnPreReport()
    begin
        GetCompInfo.GET;
    end;

    var
        ReceiptVoucherCap: Label 'Refund Voucher';
        DetailsOfReceiverCap: Label 'Details Of Receiver';
        NameCap: Label 'Name';
        AddressCap: Label 'Address';
        GSTNoCap: Label 'GST No.';
        StateCap: Label 'State';
        StateCodeCap: Label 'State Code';
        VoucherNoCap: Label 'Voucher No.';
        VoucherDateCap: Label 'Voucher Date';
        PlaceOfSupplyCap: Label 'Place of Supply';
        ReverseChargeCap: Label 'Against Receipt No.';
        SnCap: Label 'SN';
        DescrpOfProductCap: Label 'Decsription of Products';
        HSNSACCodeCap: Label 'HSN/SAC Code';
        TaxableAmountCap: Label 'Taxable Amount';
        CGSTCap: Label 'CGST';
        IGSTCap: Label 'IGST';
        SGSTCap: Label 'SGST';
        RateCap: Label 'Rate';
        AmountCap: Label 'Amount';
        AdvanceAmountCap: Label 'Advance Amount';
        AuthorisedSignatoryCap: Label 'Authorised Signatory';
        TotalTaxableAmountCap: Label 'Total Taxable Amount';
        TotalGSTCap: Label 'Total GST';
        InvoiceTotalCap: Label 'Invoice Total';
        GSTPayableOnReverseChCap: Label 'GST Payable OnReverse Charge';
        ForCap: Label 'For';
        GetVendor: Record Vendor;
        GetVendorState: Record State;
        GetLocation: Record Location;
        GetCompInfo: Record "Company Information";
        GetLocationState: Record State;
        VendInfo: array[10] of Text;
}

