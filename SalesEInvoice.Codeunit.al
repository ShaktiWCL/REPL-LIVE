codeunit 50032 "Sales E-Invoice"
{

    trigger OnRun()
    begin
        //CreateEInvoiceToken;
    end;

    //     var
    //         TestDate: Date;
    //         E_InvoiceSetup: Record "50061";
    //         JSonMgt: Codeunit "50029";
    //         String: DotNet String;
    //         HttpWebRequest: DotNet HttpWebRequest;
    //         HttpWebResponse: DotNet WebResponse;
    //         StreamReader: DotNet StreamReader;
    //         RecCust: Record "18";
    //         GSTPay: Text;
    //         SalesInvHeader: Record "112";
    //         SalesInvLine: Record "113";
    //         SalesCrMemoLine: Record "115";
    //         ComInfo: Record "79";
    //         RecLocation: Record "14";
    //         RecState: Record "13762";
    //         SupplierGSTINNo: Code[40];
    //         SupplierName: Text;
    //         SupplierAdd1: Text;
    //         SupplierAdd2: Text;
    //         SupplierCity: Text;
    //         SupplierPinCode: Text;
    //         SupplierStateDesc: Text;
    //         SupplierPhNo: Text;
    //         SupplierEmail: Text;
    //         ExpType: Text;
    //         Port: Text;
    //         ShipBillNo: Text;
    //         ShipBillDate: Text;
    //         GSTManagement: Codeunit "16401";
    //         InvForCur: Decimal;
    //         CurrencyCode: Text;
    //         CountryCode: Text;
    //         CustGstin: Text;
    //         TrdName: Text;
    //         BillAdd1: Text;
    //         BillAdd2: Text;
    //         BillCity: Text;
    //         BillPostCode: Text;
    //         State1: Record "13762";
    //         StateCode: Text;
    //         Contact: Record "5050";
    //         Ph: Text;
    //         Em: Text;
    //         ShipState: Record "13762";
    //         ShipStateCode: Code[10];
    //         ShipToAddr: Record "222";
    //         Gstin: Text;
    //         ShipTrdNm: Text;
    //         ShipBno: Text;
    //         ShipBnm: Text;
    //         ShipDst: Text;
    //         ShipPin: Text;
    //         StateBuff: Record "13762";
    //         ShipStcd: Text;
    //         ShipPh: Text;
    //         ShipEmail: Text;
    //         GSTLedgerEntry: Record "16418";
    //         Total_assVal: Decimal;
    //         CGSTvalue: Decimal;
    //         SGSTvalue: Decimal;
    //         IGSTvalue: Decimal;
    //         StateCessValue: Decimal;
    //         DetailedGSTLedgerEntry: Record "16419";
    //         cessValue: Decimal;
    //         GSTComponent: Record "16405";
    //         StCesVal: Decimal;
    //         SalesInvoiceLine: Record "113";
    //         AssVal: Decimal;
    //         TotGSTAmt: Decimal;
    //         Disc: Decimal;
    //         OtherCrg: Decimal;
    //         CurrExchRate: Record "330";
    //         CGSTRate: Decimal;
    //         SGSTRate: Decimal;
    //         IGSTRate: Decimal;
    //         CesRt: Decimal;
    //         CesNonAdval: Decimal;
    //         StateCes: Decimal;
    //         CGSTAmt: Decimal;
    //         SGSTAmt: Decimal;
    //         IGSTAmt: Decimal;
    //         CesAmt: Decimal;
    //         CesNonAdAmt: Decimal;
    //         StCesAmt: Decimal;
    //         AssValAmt: Decimal;
    //         TotalGSTAmt: Decimal;
    //         Cust: Record "18";
    //         CGSTLineAmt: Decimal;
    //         SGSTLineAmt: Decimal;
    //         IGSTLineAmt: Decimal;
    //         BatchText: Text;
    //         Sr: Integer;
    //         AssVal2: Decimal;
    //         FileManagement: Codeunit "419";
    //         SalesCrMemoLine2: Record "115";

    //     [Scope('Internal')]
    //     procedure GetEInvoice(SalesInvoiceHeader: Record "112")
    //     var
    //         SGSTvalue1: Decimal;
    //         CGSTvalue1: Decimal;
    //         IGSTvalue1: Decimal;
    //         State2: Record "13762";
    //         DescText: Text;
    //         SIL2: Record "113";
    //         TempBlob: Record "99008535";
    //         FieldRef: FieldRef;
    //         QRCodeInput: Text;
    //         QRCodeFileName: Text;
    //         intYear: Integer;
    //         intMonth: Integer;
    //         intDay: Integer;
    //         DateValue: Date;
    //         DateText: Text;
    //         ProjectTask: Record "1001";
    //         MilestoneDescription: Text;
    //         QRCodeTxt: Text;
    //         TaxableValue: Decimal;
    //     begin
    //         SalesInvoiceMandatoryFields(SalesInvoiceHeader);

    //         IF CreateEInvoiceToken THEN BEGIN
    //             ComInfo.GET;
    //             IF RecLocation.GET(SalesInvoiceHeader."Location Code") THEN BEGIN
    //                 SupplierGSTINNo := RecLocation."GST Registration No.";
    //                 SupplierName := RecLocation.Name;
    //                 SupplierAdd1 := RecLocation.Address;
    //                 SupplierAdd2 := RecLocation."Address 2";
    //                 SupplierCity := RecLocation.City;
    //                 SupplierPinCode := COPYSTR(RecLocation."Post Code", 1, 6);
    //                 RecState.GET(RecLocation."State Code");
    //                 SupplierStateDesc := RecState."State Code (GST Reg. No.)";
    //                 SupplierPhNo := COPYSTR(RecLocation."Phone No. 2", 1, 18);
    //                 SupplierEmail := COPYSTR(RecLocation."E-Mail", 1, 50);
    //             END;

    //             WITH SalesInvoiceHeader DO BEGIN
    //                 IF RecCust.GET("Sell-to Customer No.") THEN;
    //                 CustGstin := RecCust."GST Registration No.";
    //                 TrdName := "Bill-to Name";
    //                 BillAdd1 := "Bill-to Address";
    //                 BillAdd2 := "Bill-to Address 2";
    //                 BillCity := "Bill-to City";
    //                 BillPostCode := COPYSTR("Bill-to Post Code", 1, 6);
    //                 SalesInvLine.SETRANGE("Document No.", "No.");
    //                 SalesInvLine.SETRANGE(Type, SalesInvLine.Type::Item);
    //                 IF SalesInvLine.FINDFIRST THEN
    //                     IF SalesInvLine."GST Place of Supply" = SalesInvLine."GST Place of Supply"::"Bill-to Address" THEN BEGIN
    //                         IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
    //                             TESTFIELD("GST Bill-to State Code");
    //                             State1.GET("GST Bill-to State Code");
    //                             StateCode := State1."State Code (GST Reg. No.)";
    //                         END ELSE
    //                             StateCode := '';
    //                         IF Contact.GET("Bill-to Contact No.") THEN BEGIN
    //                             Ph := COPYSTR(Contact."Phone No.", 1, 10);
    //                             Em := COPYSTR(Contact."E-Mail", 1, 50);
    //                         END ELSE BEGIN
    //                             Ph := '';
    //                             Em := '';
    //                         END;
    //                     END ELSE
    //                         IF SalesInvLine."GST Place of Supply" = SalesInvLine."GST Place of Supply"::"Ship-to Address" THEN BEGIN
    //                             IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
    //                                 ShipState.GET("GST Ship-to State Code");
    //                                 StateCode := ShipState."State Code (GST Reg. No.)";
    //                             END ELSE
    //                                 StateCode := '';
    //                             IF ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code") THEN BEGIN
    //                                 Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                                 Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //                             END ELSE BEGIN
    //                                 Ph := '';
    //                                 Em := '';
    //                             END;
    //                         END ELSE BEGIN
    //                             StateCode := '';
    //                             Ph := '';
    //                             Em := '';
    //                         END;
    //             END;

    //             IF (SalesInvoiceHeader."Ship-to Code" <> '') THEN BEGIN
    //                 WITH SalesInvoiceHeader DO BEGIN
    //                     ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
    //                     IF ShipToAddr."GST Registration No." <> '' THEN
    //                         Gstin := ShipToAddr."GST Registration No."
    //                     ELSE BEGIN
    //                         IF Cust.GET("Sell-to Customer No.") THEN;
    //                         Gstin := Cust."GST Registration No.";
    //                     END;
    //                     ShipTrdNm := ShipToAddr.Name;
    //                     ShipBno := ShipToAddr.Address;
    //                     ShipBnm := ShipToAddr."Address 2";
    //                     ShipDst := ShipToAddr.City;
    //                     ShipPin := COPYSTR(ShipToAddr."Post Code", 1, 6);
    //                     StateBuff.GET(ShipToAddr.State);
    //                     ShipStcd := StateBuff."State Code (GST Reg. No.)";
    //                     ShipPh := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                     ShipEmail := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //                 END;
    //             END ELSE BEGIN
    //                 WITH SalesInvoiceHeader DO BEGIN
    //                     IF Cust.GET("Sell-to Customer No.") THEN;
    //                     Gstin := Cust."GST Registration No.";
    //                     ShipTrdNm := "Ship-to Name";
    //                     ShipBno := "Ship-to Address";
    //                     ShipBnm := "Ship-to Address 2";
    //                     ShipDst := "Ship-to City";
    //                     ShipPin := COPYSTR("Ship-to Post Code", 1, 6);
    //                     IF StateBuff.GET(Cust."State Code") THEN
    //                         ShipStcd := StateBuff."State Code (GST Reg. No.)";
    //                     ShipPh := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                     ShipEmail := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //                 END;
    //             END;


    //             GSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //             GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //             IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     CGSTvalue1 += ABS(GSTLedgerEntry."GST Amount");
    //                 UNTIL GSTLedgerEntry.NEXT = 0;
    //             END ELSE
    //                 CGSTvalue1 := 0;

    //             GSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //             GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //             IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     SGSTvalue1 += ABS(GSTLedgerEntry."GST Amount")
    //                 UNTIL GSTLedgerEntry.NEXT = 0;
    //             END ELSE
    //                 SGSTvalue1 := 0;

    //             GSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //             GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //             IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     IGSTvalue1 += ABS(GSTLedgerEntry."GST Amount")
    //                 UNTIL GSTLedgerEntry.NEXT = 0;
    //             END ELSE
    //                 IGSTvalue1 := 0;

    //             StateCessValue := 0;
    //             GSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //             GSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //             IF GSTLedgerEntry.FINDSET THEN
    //                 REPEAT
    //                     StateCessValue += ABS(GSTLedgerEntry."GST Amount")
    //                 UNTIL GSTLedgerEntry.NEXT = 0;

    //             DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //             DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //             IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //                 REPEAT
    //                     IF DetailedGSTLedgerEntry."GST %" > 0 THEN
    //                         cessValue += ABS(DetailedGSTLedgerEntry."GST Amount")
    //                 UNTIL GSTLedgerEntry.NEXT = 0;

    //             GSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //             GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
    //             IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
    //                         StCesVal += ABS(GSTLedgerEntry."GST Amount");
    //                 UNTIL GSTLedgerEntry.NEXT = 0;
    //             END;
    //             AssVal := 0;
    //             TotGSTAmt := 0;
    //             Disc := 0;
    //             OtherCrg := 0;
    //             TaxableValue := 0;
    //             SalesInvoiceHeader.CALCFIELDS("Amount to Customer");
    //             SalesInvoiceLine.RESET;
    //             SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //             IF SalesInvoiceLine.FINDSET THEN BEGIN
    //                 REPEAT
    //                     AssVal += SalesInvoiceLine."GST Base Amount";
    //                     TaxableValue += SalesInvoiceLine."Line Amount";
    //                     TotGSTAmt += SalesInvoiceLine."Total GST Amount";
    //                     Disc += SalesInvoiceLine."Inv. Discount Amount";
    //                     OtherCrg += SalesInvoiceLine."Charges To Customer";
    //                 UNTIL SalesInvoiceLine.NEXT = 0;
    //             END;

    //             AssVal := ROUND(
    //                 CurrExchRate.ExchangeAmtFCYToLCY(
    //                   WORKDATE, SalesInvoiceHeader."Currency Code", AssVal, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
    //             TotGSTAmt := ROUND(
    //                 CurrExchRate.ExchangeAmtFCYToLCY(
    //                   WORKDATE, SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
    //             Disc := ROUND(
    //                 CurrExchRate.ExchangeAmtFCYToLCY(
    //                   WORKDATE, SalesInvoiceHeader."Currency Code", Disc, SalesInvoiceHeader."Currency Factor"), 0.01, '=');



    //             JSonMgt.StartJSon;
    //             JSonMgt.AddToJSon('userGstin', SupplierGSTINNo);
    //             JSonMgt.AddToJSonRaw('pobCode', 'null');
    //             JSonMgt.AddToJSon('supplyType', 'O');
    //             IF SalesInvoiceHeader."GST Bill-to State Code" = SalesInvoiceHeader."Location State Code" THEN
    //                 JSonMgt.AddToJSon('ntr', 'Intra')
    //             ELSE
    //                 JSonMgt.AddToJSon('ntr', 'Inter');
    //             IF SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::"Debit Note" THEN
    //                 JSonMgt.AddToJSon('docType', 'D')
    //             ELSE
    //                 JSonMgt.AddToJSon('docType', 'RI');
    //             IF (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Unregistered) OR (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Exempted) THEN BEGIN
    //                 SalesInvoiceHeader.CALCFIELDS("Amount to Customer");
    //                 IF SalesInvoiceHeader."GST Bill-to State Code" = SalesInvoiceHeader."Location State Code" THEN
    //                     JSonMgt.AddToJSon('catg', 'B2CS')
    //                 ELSE BEGIN
    //                     IF SalesInvoiceHeader."Amount to Customer" > 250000 THEN
    //                         JSonMgt.AddToJSon('catg', 'B2CL')
    //                     ELSE
    //                         JSonMgt.AddToJSon('catg', 'B2CS');
    //                 END;
    //             END
    //             ELSE
    //                 JSonMgt.AddToJSon('catg', 'B2B');
    //             JSonMgt.AddToJSon('dst', 'O');
    //             //IF SalesInvoiceHeader."Location State Code" =SalesInvoiceHeader."GST Ship-to State Code" THEN
    //             //JSonMgt.AddToJSon('trnTyp','Bill To - Ship To')
    //             //ELSE
    //             JSonMgt.AddToJSon('trnTyp', 'REG');
    //             JSonMgt.AddToJSon('no', SalesInvoiceHeader."No.");
    //             JSonMgt.AddToJSon('dt', FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
    //             JSonMgt.AddToJSonRaw('refinum', 'null');
    //             JSonMgt.AddToJSonRaw('refidt', 'null');
    //             IF SalesInvoiceHeader."Ship-to Code" = '' THEN BEGIN
    //                 IF Cust.GET(SalesInvoiceHeader."Sell-to Customer No.") THEN;
    //                 IF State2.GET(Cust."State Code") THEN;
    //                 JSonMgt.AddToJSon('pos', State2."State Code (GST Reg. No.)");
    //             END
    //             ELSE BEGIN
    //                 IF ShipToAddr.GET(SalesInvoiceHeader."Sell-to Customer No.", SalesInvoiceHeader."Ship-to Code") THEN;
    //                 IF State2.GET(ShipToAddr.State) THEN;
    //                 JSonMgt.AddToJSon('pos', State2."State Code (GST Reg. No.)");

    //             END;
    //             JSonMgt.AddToJSonRaw('diffprcnt', 'null');
    //             JSonMgt.AddToJSonRaw('etin', 'null');
    //             JSonMgt.AddToJSon('rchrg', 'N');
    //             JSonMgt.AddToJSon('sgstin', SupplierGSTINNo);
    //             JSonMgt.AddToJSon('strdNm', SupplierName);
    //             JSonMgt.AddToJSon('slglNm', SupplierName);
    //             JSonMgt.AddToJSon('sbnm', SupplierAdd1);
    //             IF SupplierAdd2 <> '' THEN
    //                 JSonMgt.AddToJSon('sflno', SupplierAdd2)
    //             ELSE
    //                 JSonMgt.AddToJSon('sflno', 'null');
    //             JSonMgt.AddToJSon('sloc', SupplierCity);
    //             JSonMgt.AddToJSon('sdst', '');
    //             JSonMgt.AddToJSon('sstcd', SupplierStateDesc);//);
    //             JSonMgt.AddToJSon('spin', SupplierPinCode);
    //             JSonMgt.AddToJSon('sph', SupplierPhNo);
    //             JSonMgt.AddToJSon('sem', SupplierEmail);
    //             IF (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Unregistered) OR (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Exempted) THEN
    //                 JSonMgt.AddToJSon('bgstin', 'URP')
    //             ELSE
    //                 JSonMgt.AddToJSon('bgstin', CustGstin);
    //             JSonMgt.AddToJSon('btrdNm', TrdName);
    //             JSonMgt.AddToJSon('blglNm', TrdName);
    //             JSonMgt.AddToJSon('bbnm', BillAdd1);
    //             IF BillAdd2 <> '' THEN
    //                 JSonMgt.AddToJSon('bflno', BillAdd2)
    //             ELSE
    //                 JSonMgt.AddToJSon('bflno', 'null');
    //             JSonMgt.AddToJSon('bloc', BillCity);
    //             JSonMgt.AddToJSon('bdst', '');
    //             IF State2.GET(Cust."State Code") THEN;
    //             IF StateCode <> '' THEN
    //                 JSonMgt.AddToJSon('bstcd', StateCode)
    //             ELSE
    //                 JSonMgt.AddToJSon('bstcd', State2."State Code (GST Reg. No.)");
    //             JSonMgt.AddToJSon('bpin', BillPostCode);
    //             IF Ph <> '' THEN
    //                 JSonMgt.AddToJSon('bph', Ph)
    //             ELSE
    //                 JSonMgt.AddToJSonRaw('bph', 'null');
    //             IF Em <> '' THEN
    //                 JSonMgt.AddToJSon('bem', Em)
    //             ELSE
    //                 JSonMgt.AddToJSonRaw('bem', 'null');
    //             JSonMgt.AddToJSonRaw('dgstin', 'null');
    //             JSonMgt.AddToJSonRaw('dtrdNm', 'null');
    //             JSonMgt.AddToJSonRaw('dlglNm', 'null');
    //             JSonMgt.AddToJSonRaw('dbnm', 'null');
    //             JSonMgt.AddToJSonRaw('dflno', 'null');
    //             JSonMgt.AddToJSonRaw('dloc', 'null');
    //             JSonMgt.AddToJSonRaw('ddst', 'null');
    //             JSonMgt.AddToJSonRaw('dstcd', 'null');
    //             JSonMgt.AddToJSonRaw('dpin', 'null');
    //             JSonMgt.AddToJSonRaw('dph', 'null');
    //             JSonMgt.AddToJSonRaw('dem', 'null');
    //             IF SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Registered THEN BEGIN
    //                 IF SalesInvoiceHeader."Ship-to Code" = '' THEN BEGIN
    //                     JSonMgt.AddToJSonRaw('togstin', 'null');
    //                     JSonMgt.AddToJSonRaw('totrdNm', 'null');
    //                     JSonMgt.AddToJSonRaw('tolglNm', 'null');
    //                     JSonMgt.AddToJSonRaw('tobnm', 'null');
    //                     JSonMgt.AddToJSonRaw('toflno', 'null');
    //                     JSonMgt.AddToJSonRaw('toloc', 'null');
    //                     JSonMgt.AddToJSonRaw('todst', 'null');
    //                     JSonMgt.AddToJSonRaw('tostcd', 'null');
    //                     JSonMgt.AddToJSonRaw('topin', 'null');
    //                     IF ShipPh <> '' THEN
    //                         JSonMgt.AddToJSonRaw('toph', 'null')
    //                     ELSE
    //                         JSonMgt.AddToJSonRaw('toph', 'null');
    //                     IF ShipEmail <> '' THEN
    //                         JSonMgt.AddToJSonRaw('toem', 'null')
    //                     ELSE
    //                         JSonMgt.AddToJSonRaw('toem', 'null');
    //                 END ELSE BEGIN
    //                     IF Cust.GET(SalesInvoiceHeader."Sell-to Customer No.") THEN;
    //                     IF SalesInvoiceHeader."Ship-to Code" = '' THEN
    //                         JSonMgt.AddToJSon('togstin', 'null')
    //                     ELSE
    //                         JSonMgt.AddToJSon('togstin', Gstin);//Cust."GST Registration No.");
    //                     JSonMgt.AddToJSon('totrdNm', ShipTrdNm);
    //                     JSonMgt.AddToJSon('tolglNm', ShipTrdNm);
    //                     JSonMgt.AddToJSon('tobnm', ShipBno);
    //                     IF ShipBnm <> '' THEN
    //                         JSonMgt.AddToJSon('toflno', ShipBnm)
    //                     ELSE
    //                         JSonMgt.AddToJSon('toflno', 'null');
    //                     JSonMgt.AddToJSon('toloc', ShipDst);
    //                     JSonMgt.AddToJSon('todst', ShipDst);
    //                     JSonMgt.AddToJSon('tostcd', ShipStcd);
    //                     JSonMgt.AddToJSon('topin', ShipPin);
    //                     IF ShipPh <> '' THEN
    //                         JSonMgt.AddToJSon('toph', ShipPh)
    //                     ELSE
    //                         JSonMgt.AddToJSonRaw('toph', 'null');
    //                     IF ShipEmail <> '' THEN
    //                         JSonMgt.AddToJSon('toem', ShipEmail)
    //                     ELSE
    //                         JSonMgt.AddToJSonRaw('toem', 'null');
    //                 END;
    //                 JSonMgt.AddToJSonRaw('sbnum', 'null');
    //                 JSonMgt.AddToJSonRaw('sbdt', 'null');
    //                 JSonMgt.AddToJSonRaw('port', 'null');
    //                 JSonMgt.AddToJSonRaw('expduty', 0);
    //                 JSonMgt.AddToJSonRaw('cntcd', 'null');
    //                 JSonMgt.AddToJSonRaw('forCur', 'null');
    //                 JSonMgt.AddToJSonRaw('invForCur', 'null');
    //                 JSonMgt.AddToJSon('taxSch', 'GST');
    //             END ELSE BEGIN
    //                 JSonMgt.AddToJSonRaw('togstin', 'null');
    //                 JSonMgt.AddToJSonRaw('totrdNm', 'null');
    //                 JSonMgt.AddToJSonRaw('tolglNm', 'null');
    //                 JSonMgt.AddToJSonRaw('tobnm', 'null');
    //                 JSonMgt.AddToJSonRaw('toflno', 'null');
    //                 JSonMgt.AddToJSonRaw('toloc', 'null');
    //                 JSonMgt.AddToJSonRaw('todst', 'null');
    //                 JSonMgt.AddToJSonRaw('tostcd', 'null');
    //                 JSonMgt.AddToJSonRaw('topin', 'null');
    //                 JSonMgt.AddToJSonRaw('toph', 'null');
    //                 JSonMgt.AddToJSonRaw('toem', 'null');
    //                 JSonMgt.AddToJSonRaw('sbnum', 'null');
    //                 JSonMgt.AddToJSonRaw('sbdt', 'null');
    //                 JSonMgt.AddToJSonRaw('port', 'null');
    //                 JSonMgt.AddToJSonRaw('expduty', 0);
    //                 JSonMgt.AddToJSonRaw('cntcd', 'null');
    //                 JSonMgt.AddToJSonRaw('forCur', 'null');
    //                 JSonMgt.AddToJSonRaw('invForCur', 'null');
    //                 JSonMgt.AddToJSon('taxSch', 'GST');
    //             END;
    //             JSonMgt.AddToJSonRaw('totinvval', ROUND(SalesInvoiceHeader."Amount to Customer", 0.01));
    //             JSonMgt.AddToJSonRaw('totdisc', Disc);
    //             JSonMgt.AddToJSonRaw('totfrt', 'null');
    //             JSonMgt.AddToJSonRaw('totins', 'null');
    //             JSonMgt.AddToJSonRaw('totpkg', 'null');
    //             JSonMgt.AddToJSonRaw('totothchrg', ROUND(CalcTCSAmt(SalesInvoiceHeader."No."), 0.01));
    //             IF AssVal <> 0 THEN
    //                 JSonMgt.AddToJSonRaw('tottxval', ROUND(AssVal, 0.01))
    //             ELSE
    //                 JSonMgt.AddToJSonRaw('tottxval', ROUND(TaxableValue, 0.01));
    //             JSonMgt.AddToJSonRaw('totiamt', IGSTvalue1);
    //             JSonMgt.AddToJSonRaw('totcamt', CGSTvalue1);
    //             JSonMgt.AddToJSonRaw('totsamt', SGSTvalue1);
    //             JSonMgt.AddToJSonRaw('totcsamt', cessValue);
    //             JSonMgt.AddToJSonRaw('totstcsamt', StateCessValue);
    //             JSonMgt.AddToJSonRaw('rndOffAmt', '0');
    //             JSonMgt.AddToJSon('sec7act', 'N');
    //             JSonMgt.AddToJSonRaw('invStDt', 'null');
    //             JSonMgt.AddToJSonRaw('invEndDt', 'null');
    //             JSonMgt.AddToJSonRaw('invRmk', 'null');
    //             JSonMgt.AddToJSonRaw('omon', 'null');
    //             JSonMgt.AddToJSonRaw('odty', 'null');
    //             JSonMgt.AddToJSonRaw('oinvtyp', 'null');
    //             JSonMgt.AddToJSonRaw('octin', 'null');
    //             JSonMgt.AddToJSonRaw('userIRN', 'null');
    //             JSonMgt.AddToJSonRaw('payNm', 'null');
    //             JSonMgt.AddToJSonRaw('acctdet', 'null');
    //             JSonMgt.AddToJSonRaw('mode', 'null');
    //             JSonMgt.AddToJSonRaw('ifsc', 'null');
    //             JSonMgt.AddToJSonRaw('payTerm', 'null');
    //             JSonMgt.AddToJSonRaw('payInstr', 'null');
    //             JSonMgt.AddToJSonRaw('crTrn', 'null');
    //             JSonMgt.AddToJSonRaw('dirDr', 'null');
    //             JSonMgt.AddToJSonRaw('crDay', 'null');
    //             JSonMgt.AddToJSonRaw('balAmt', 'null');
    //             JSonMgt.AddToJSonRaw('paidAmt', 'null');
    //             JSonMgt.AddToJSonRaw('payDueDt', 'null');
    //             JSonMgt.AddToJSonRaw('transId', 'null');
    //             JSonMgt.AddToJSon('subSplyTyp', 'Supply');
    //             JSonMgt.AddToJSonRaw('subSplyDes', 'null');
    //             JSonMgt.AddToJSonRaw('kdrefinum', 'null');
    //             JSonMgt.AddToJSonRaw('kdrefidt', 'null');
    //             JSonMgt.AddToJSonRaw('transMode', 'null');
    //             JSonMgt.AddToJSonRaw('vehTyp', 'null');
    //             JSonMgt.AddToJSonRaw('transDist', 'null');
    //             JSonMgt.AddToJSonRaw('transName', 'null');
    //             JSonMgt.AddToJSonRaw('transDocNo', 'null');
    //             JSonMgt.AddToJSonRaw('transdocdate', 'null');
    //             JSonMgt.AddToJSonRaw('vehNo', 'null');
    //             JSonMgt.AddToJSonRaw('clmrfnd', 'null');
    //             JSonMgt.AddToJSonRaw('rfndelg', 'null');
    //             JSonMgt.AddToJSonRaw('boef', 'null');
    //             JSonMgt.AddToJSonRaw('fy', 'null');
    //             JSonMgt.AddToJSonRaw('refnum', 'null');
    //             JSonMgt.AddToJSonRaw('pdt', 'null');
    //             JSonMgt.AddToJSonRaw('ivst', 'null');
    //             JSonMgt.AddToJSonRaw('cptycde', 'null');
    //             JSonMgt.AddToJSon('gen1', 'abcd');
    //             JSonMgt.AddToJSon('gen2', 'abcd');
    //             JSonMgt.AddToJSon('gen3', 'abcd');
    //             JSonMgt.AddToJSon('gen4', 'abcd');
    //             JSonMgt.AddToJSon('gen5', 'abcd');
    //             JSonMgt.AddToJSon('gen6', 'abcd');
    //             JSonMgt.AddToJSon('gen7', 'abcd');
    //             JSonMgt.AddToJSon('gen8', 'abcd');
    //             JSonMgt.AddToJSon('gen9', 'abcd');
    //             JSonMgt.AddToJSon('gen10', 'abcd');
    //             JSonMgt.AddToJSon('gen11', 'abcd');
    //             JSonMgt.AddToJSon('gen12', 'abcd');
    //             JSonMgt.AddToJSon('gen13', 'abcd');
    //             JSonMgt.AddToJSon('gen14', 'abcd');
    //             JSonMgt.AddToJSon('gen15', 'abcd');
    //             JSonMgt.AddToJSon('gen16', 'abcd');
    //             JSonMgt.AddToJSon('gen17', 'abcd');
    //             JSonMgt.AddToJSon('gen18', 'abcd');
    //             JSonMgt.AddToJSon('gen19', 'abcd');
    //             JSonMgt.AddToJSon('gen20', 'abcd');
    //             JSonMgt.AddToJSon('gen21', 'abcd');
    //             JSonMgt.AddToJSon('gen22', 'abcd');
    //             JSonMgt.AddToJSon('gen23', 'abcd');
    //             JSonMgt.AddToJSon('gen24', 'abcd');
    //             JSonMgt.AddToJSon('gen25', 'abcd');
    //             JSonMgt.AddToJSon('gen26', 'abcd');
    //             JSonMgt.AddToJSon('gen27', 'abcd');
    //             JSonMgt.AddToJSon('gen28', 'abcd');
    //             JSonMgt.AddToJSon('gen29', 'abcd');
    //             JSonMgt.AddToJSon('gen30', 'abcd');
    //             JSonMgt.AddToJSon('pobewb', 'null');
    //             JSonMgt.AddToJSon('Pobret', 'null');
    //             JSonMgt.AddToJSon('tcsrt', 'null');
    //             JSonMgt.AddToJSon('tcsamt', '0');
    //             JSonMgt.AddToJSon('pretcs', '0');
    //             JSonMgt.AddToJSon('genIrn', 'true');
    //             JSonMgt.AddToJSon('genewb', 'N');
    //             JSonMgt.AddToJSon('signedDataReq', 'true');

    //             SalesInvLine.RESET;
    //             SalesInvLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //             SalesInvLine.SETFILTER(Quantity, '<>%1', 0);
    //             SalesInvLine.SETFILTER("No.", '<>%1', '431030');
    //             IF SalesInvLine.FINDFIRST THEN BEGIN
    //                 JSonMgt.StartJsonArray2('itemList');
    //                 REPEAT
    //                     Sr += 1;
    //                     MilestoneDescription := '';
    //                     IF SalesInvLine."Job No." <> '' THEN BEGIN
    //                         ProjectTask.RESET;
    //                         ProjectTask.SETRANGE("Project No.", SalesInvLine."Job No.");
    //                         ProjectTask.SETRANGE("Project Task No.", SalesInvLine."Job Task No.");
    //                         ProjectTask.SETRANGE(Milestone, SalesInvLine.Milestone);
    //                         IF ProjectTask.FINDFIRST THEN
    //                             MilestoneDescription := ProjectTask."Milestone Desc"
    //                     END
    //                     ELSE
    //                         MilestoneDescription := SalesInvLine.Description + SalesInvLine."Description 2";



    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //                     IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                         CGSTRate := DetailedGSTLedgerEntry."GST %";
    //                         CGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                     END ELSE BEGIN
    //                         CGSTRate := 0;
    //                         CGSTLineAmt := 0;
    //                     END;

    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //                     IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                         SGSTRate := DetailedGSTLedgerEntry."GST %";
    //                         SGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                     END ELSE BEGIN
    //                         SGSTRate := 0;
    //                         SGSTLineAmt := 0;
    //                     END;
    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //                     IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                         IGSTRate := DetailedGSTLedgerEntry."GST %";
    //                         IGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                     END
    //                     ELSE BEGIN
    //                         IGSTRate := 0;
    //                         IGSTLineAmt := 0;
    //                     END;

    //                     CesRt := 0;
    //                     CesNonAdval := 0;
    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //                     IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //                         IF DetailedGSTLedgerEntry."GST %" > 0 THEN
    //                             CesRt := DetailedGSTLedgerEntry."GST %"
    //                         ELSE
    //                             CesNonAdval := ABS(DetailedGSTLedgerEntry."GST Amount");

    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //                     IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //                         CesRt := DetailedGSTLedgerEntry."GST %";

    //                     StateCes := 0;
    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code");
    //                     IF DetailedGSTLedgerEntry.FINDSET THEN
    //                         REPEAT
    //                             IF NOT (DetailedGSTLedgerEntry."GST Component Code" IN ['CGST', 'SGST', 'IGST', 'CESS', 'INTERCESS'])
    //                             THEN
    //                                 IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN
    //                                     StateCes := DetailedGSTLedgerEntry."GST %";
    //                         UNTIL DetailedGSTLedgerEntry.NEXT = 0;

    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //                     IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                         REPEAT
    //                             CGSTAmt += ABS(GSTLedgerEntry."GST Amount");
    //                         UNTIL GSTLedgerEntry.NEXT = 0;
    //                     END ELSE
    //                         CGSTAmt := 0;

    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //                     IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                         REPEAT
    //                             SGSTAmt += ABS(GSTLedgerEntry."GST Amount")
    //                         UNTIL GSTLedgerEntry.NEXT = 0;
    //                     END ELSE
    //                         SGSTAmt := 0;
    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //                     IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                         REPEAT
    //                             IGSTAmt += ABS(GSTLedgerEntry."GST Amount")
    //                         UNTIL GSTLedgerEntry.NEXT = 0;
    //                     END ELSE
    //                         IGSTAmt := 0;

    //                     CesAmt := 0;
    //                     CesNonAdAmt := 0;
    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     GSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //                     IF GSTLedgerEntry.FINDSET THEN
    //                         REPEAT
    //                             CesAmt += ABS(GSTLedgerEntry."GST Amount")
    //                         UNTIL GSTLedgerEntry.NEXT = 0;

    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     GSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //                     IF GSTLedgerEntry.FINDFIRST THEN
    //                         REPEAT
    //                             CesAmt += ABS(GSTLedgerEntry."GST Amount");
    //                         UNTIL GSTLedgerEntry.NEXT = 0;

    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                     GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
    //                     IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                         REPEAT
    //                             IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
    //                                 StCesAmt += ABS(GSTLedgerEntry."GST Amount");
    //                         UNTIL GSTLedgerEntry.NEXT = 0;
    //                     END;
    //                     AssValAmt := 0;
    //                     TotalGSTAmt := 0;
    //                     Disc := 0;
    //                     SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //                     IF SalesInvoiceLine.FINDSET THEN BEGIN
    //                         REPEAT
    //                             AssValAmt += SalesInvoiceLine."GST Base Amount";
    //                             TotalGSTAmt += SalesInvoiceLine."Total GST Amount";
    //                             Disc += SalesInvoiceLine."Inv. Discount Amount";
    //                         UNTIL SalesInvoiceLine.NEXT = 0;
    //                     END;

    //                     AssValAmt := ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           WORKDATE, SalesInvoiceHeader."Currency Code", AssVal, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
    //                     TotalGSTAmt := ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           WORKDATE, SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');

    //                     Disc := ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           WORKDATE, SalesInvoiceHeader."Currency Code", Disc, SalesInvoiceHeader."Currency Factor"), 0.01, '=');

    //                     JSonMgt.StartJSon;
    //                     JSonMgt.AddToJSonRaw('barcode', 'null');
    //                     JSonMgt.AddToJSonRaw('bchExpDt', 'null');
    //                     JSonMgt.AddToJSonRaw('bchWrDt', 'null');
    //                     JSonMgt.AddToJSonRaw('bchnm', 'null');
    //                     JSonMgt.AddToJSonRaw('camt', CGSTLineAmt);
    //                     JSonMgt.AddToJSonRaw('cesNonAdval', '0');
    //                     JSonMgt.AddToJSonRaw('stCesNonAdvl', '0');
    //                     JSonMgt.AddToJSonRaw('crt', CGSTRate);
    //                     JSonMgt.AddToJSonRaw('csamt', '0');
    //                     JSonMgt.AddToJSonRaw('csrt', '0');
    //                     JSonMgt.AddToJSonRaw('disc', '0');
    //                     JSonMgt.AddToJSonRaw('freeQty', '0');
    //                     JSonMgt.AddToJSon('hsnCd', SalesInvLine."HSN/SAC Code");
    //                     JSonMgt.AddToJSonRaw('iamt', IGSTLineAmt);
    //                     JSonMgt.AddToJSonRaw('irt', IGSTRate);
    //                     JSonMgt.AddToJSonRaw('isServc', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen1', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen2', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen3', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen4', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen5', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen6', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen7', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen8', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen9', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen10', 'null');
    //                     JSonMgt.AddToJSonRaw('itmVal', ROUND((SalesInvLine."Line Amount" + SalesInvLine."Total GST Amount"), 0.01));
    //                     //Sr+=1;
    //                     JSonMgt.AddToJSon('num', Sr);
    //                     JSonMgt.AddToJSonRaw('ordLineRef', 'null');
    //                     JSonMgt.AddToJSonRaw('orgCntry', 'null');
    //                     JSonMgt.AddToJSonRaw('othchrg', 'null');
    //                     JSonMgt.AddToJSon('prdDesc', MilestoneDescription);
    //                     JSonMgt.AddToJSon('prdSlNo', 'null');
    //                     JSonMgt.AddToJSonRaw('preTaxVal', '0');
    //                     JSonMgt.AddToJSonRaw('qty', SalesInvLine.Quantity);
    //                     JSonMgt.AddToJSonRaw('rt', '0');
    //                     JSonMgt.AddToJSonRaw('samt', SGSTLineAmt);
    //                     JSonMgt.AddToJSonRaw('srt', SGSTRate);

    //                     JSonMgt.AddToJSonRaw('stcsamt', '0');
    //                     JSonMgt.AddToJSonRaw('stcsrt', '0');
    //                     JSonMgt.AddToJSonRaw('sval', ROUND(SalesInvLine."Line Amount", 0.01));
    //                     JSonMgt.AddToJSonRaw('txp', 'null');
    //                     JSonMgt.AddToJSonRaw('txval', ROUND(SalesInvLine."Line Amount", 0.01));//SalesInvLine."GST Base Amount");
    //                     IF SalesInvLine.Type = SalesInvLine.Type::Item THEN BEGIN
    //                         IF SalesInvLine."Unit of Measure Code" = 'MT' THEN
    //                             JSonMgt.AddToJSon('unit', 'MTS')
    //                         ELSE
    //                             JSonMgt.AddToJSon('unit', SalesInvLine."Unit of Measure Code");
    //                     END ELSE BEGIN
    //                         JSonMgt.AddToJSon('unit', 'OTH');
    //                     END;
    //                     JSonMgt.AddToJSonRaw('unitPrice', ROUND(SalesInvLine."Unit Price", 0.01));
    //                     JSonMgt.EndJSon;
    //                 UNTIL SalesInvLine.NEXT = 0;
    //             END;
    //             JSonMgt.EndJSonArray;


    //             JSonMgt.StartJsonArray2('invItmOtherDtls');
    //             JSonMgt.StartJSon;
    //             JSonMgt.AddToJSon('attNm', 'null');
    //             JSonMgt.AddToJSon('attVal', 'null');
    //             JSonMgt.EndJSon;
    //             JSonMgt.EndJSonArray;

    //             JSonMgt.StartJsonArray2('invOthDocDtls');
    //             JSonMgt.StartJSon;
    //             JSonMgt.AddToJSon('url', 'null');
    //             JSonMgt.AddToJSon('docs', 'null');
    //             JSonMgt.AddToJSon('infoDtls', 'null');
    //             JSonMgt.EndJSon;
    //             JSonMgt.EndJSonArray;

    //             JSonMgt.StartJsonArray2('invRefPreDtls');
    //             JSonMgt.StartJSon;
    //             JSonMgt.AddToJSonRaw('oinum', 'null');
    //             JSonMgt.AddToJSonRaw('oidt', 'null');
    //             JSonMgt.AddToJSonRaw('othRefNo', 'null');
    //             JSonMgt.EndJSon;
    //             JSonMgt.EndJSonArray;

    //             JSonMgt.StartJsonArray2('invRefContDtls');
    //             JSonMgt.StartJSon;
    //             JSonMgt.AddToJSonRaw('raref', 'null');
    //             JSonMgt.AddToJSonRaw('radt', 'null');
    //             JSonMgt.AddToJSonRaw('tendref', 'null');
    //             JSonMgt.AddToJSonRaw('contref', 'null');
    //             JSonMgt.AddToJSonRaw('extref', 'null');
    //             JSonMgt.AddToJSonRaw('projref', 'null');
    //             JSonMgt.AddToJSonRaw('poref', 'null');
    //             JSonMgt.AddToJSonRaw('porefdt', 'null');
    //             JSonMgt.EndJSon;
    //             JSonMgt.EndJSonArray;
    //             JSonMgt.EndJSon;
    //             String := String.Copy(JSonMgt.GetJSon);
    //             MESSAGE('%1', String);
    //             E_InvoiceSetup.GET;
    //             JSonMgt.UploadJSon(E_InvoiceSetup."e-Invoice URL", String, 'POST');
    //             MESSAGE('%1', String);
    //             SalesInvoiceHeader."IRN Hash2" := JSonMgt.ReadFirstJSonValue(String, 'irn');
    //             SalesInvoiceHeader."Acknowledgement No.2" := JSonMgt.ReadFirstJSonValue(String, 'ackNo');
    //             IF JSonMgt.ReadFirstJSonValue(String, 'ackDt') <> '' THEN BEGIN
    //                 EVALUATE(intYear, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'ackDt'), 1, 4));
    //                 EVALUATE(intMonth, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'ackDt'), 6, 2));
    //                 EVALUATE(intDay, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'ackDt'), 9, 2));
    //                 DateValue := DMY2DATE(intDay, intMonth, intYear);
    //                 DateText := FORMAT(DateValue) + ' ' + FORMAT(TIME);
    //                 EVALUATE(SalesInvoiceHeader."Acknowledgement Date2", DateText);
    //             END;
    //             IF JSonMgt.ReadFirstJSonValue(String, 'signedQrCode') <> '' THEN BEGIN
    //                 QRCodeTxt := JSonMgt.ReadFirstJSonValue(String, 'signedQrCode');
    //                 QRCodeFileName := GetQRCodeInvoice(QRCodeTxt);
    //                 QRCodeFileName := MoveToMagicPathInvoice(QRCodeFileName);

    //                 CLEAR(TempBlob);
    //                 TempBlob.CALCFIELDS(Blob);
    //                 FileManagement.BLOBImport(TempBlob, QRCodeFileName);
    //                 SalesInvoiceHeader."QR Code2" := TempBlob.Blob;
    //             END ELSE BEGIN
    //                 IF JSonMgt.ReadFirstJSonValue(String, 'qrCode') <> '' THEN BEGIN
    //                     QRCodeTxt := JSonMgt.ReadFirstJSonValue(String, 'qrCode');
    //                     QRCodeFileName := GetQRCodeInvoice(QRCodeTxt);
    //                     QRCodeFileName := MoveToMagicPathInvoice(QRCodeFileName);

    //                     CLEAR(TempBlob);
    //                     TempBlob.CALCFIELDS(Blob);
    //                     FileManagement.BLOBImport(TempBlob, QRCodeFileName);
    //                     SalesInvoiceHeader."QR Code2" := TempBlob.Blob;
    //                 END;
    //             END;
    //             SalesInvoiceHeader.MODIFY;

    //             IF NOT ISSERVICETIER THEN
    //                 IF EXISTS(QRCodeFileName) THEN
    //                     ERASE(QRCodeFileName);
    //         END;
    //     end;

    //     [Scope('Internal')]
    //     procedure CreateEInvoiceToken(): Boolean
    //     var
    //         lCustCreated: Boolean;
    //         lStrPos: Integer;
    //         lFirstName: Text[50];
    //         lLastName: Text[50];
    //     begin
    //         E_InvoiceSetup.GET;
    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSon('email', E_InvoiceSetup."User Name");
    //         JSonMgt.AddToJSon('password', E_InvoiceSetup.Password);
    //         JSonMgt.EndJSon;
    //         String := String.Copy(JSonMgt.GetJSon);
    //         //MESSAGE('%1',String);
    //         JSonMgt.UploadJSon2(E_InvoiceSetup."Token URL", String, 'POST');
    //         //MESSAGE('%1',String);
    //         E_InvoiceSetup.Password1 := COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'token'), 1, 200);
    //         E_InvoiceSetup.Password2 := COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'token'), 201, 250);
    //         E_InvoiceSetup.MODIFY;
    //         EXIT(TRUE);
    //     end;

    //     [Scope('Internal')]
    //     procedure CalcTCSAmt(DocNo: Code[40]) TCSAmt: Decimal
    //     var
    //         StructureLineDetails: Record "13798";
    //     begin
    //         StructureLineDetails.RESET;
    //         StructureLineDetails.SETRANGE(Type, StructureLineDetails.Type::Sale);
    //         StructureLineDetails.SETFILTER("Document Type", '%1|%2|%3', StructureLineDetails."Document Type"::Invoice, StructureLineDetails."Document Type"::"Credit Memo",
    //         StructureLineDetails."Document Type"::"Return Order");
    //         StructureLineDetails.SETFILTER("Invoice No.", '%1', DocNo);
    //         StructureLineDetails.SETFILTER("Tax/Charge Group", '<>%1', '');
    //         IF StructureLineDetails.FINDFIRST THEN
    //             REPEAT
    //                 IF (StructureLineDetails."Tax/Charge Group" = 'TCSN') OR ((StructureLineDetails."Tax/Charge Group" = 'TCS')) THEN
    //                     TCSAmt += ABS(ROUND(StructureLineDetails.Amount, 0.01));
    //             UNTIL StructureLineDetails.NEXT = 0;
    //         EXIT(TCSAmt);
    //     end;

    //     [Scope('Internal')]
    //     procedure CheckState(DocNo: Code[50]): Boolean
    //     var
    //         GSTLedgerEntry: Record "16418";
    //     begin
    //         GSTLedgerEntry.RESET;
    //         GSTLedgerEntry.SETRANGE("Document No.", DocNo);
    //         GSTLedgerEntry.SETFILTER("GST Component Code", '%1', 'SGST');
    //         IF GSTLedgerEntry.FINDFIRST THEN
    //             EXIT(TRUE)
    //         ELSE
    //             EXIT(FALSE);
    //     end;

    //     [Scope('Internal')]
    //     procedure GetEDebitNote(SalesCrMemoHeader: Record "114")
    //     var
    //         SGSTvalue1: Decimal;
    //         CGSTvalue1: Decimal;
    //         IGSTvalue1: Decimal;
    //         State2: Record "13762";
    //         SalesCrMemoLine: Record "115";
    //         SalesCrLine: Record "115";
    //         TempBlob: Record "99008535";
    //         FieldRef: FieldRef;
    //         QRCodeInput: Text;
    //         QRCodeFileName: Text;
    //         intYear: Integer;
    //         intMonth: Integer;
    //         intDay: Integer;
    //         DateValue: Date;
    //         DateText: Text;
    //         ProjectTask: Record "1001";
    //         MilestoneDescription: Text;
    //         QRCodeTxt: Text;
    //     begin
    //         ComInfo.GET;
    //         IF RecLocation.GET(SalesCrMemoHeader."Location Code") THEN BEGIN
    //             SupplierGSTINNo := RecLocation."GST Registration No.";
    //             SupplierName := RecLocation.Name;
    //             SupplierAdd1 := RecLocation.Address;
    //             SupplierAdd2 := RecLocation."Address 2";
    //             SupplierCity := RecLocation.City;
    //             SupplierPinCode := COPYSTR(RecLocation."Post Code", 1, 6);
    //             RecState.GET(RecLocation."State Code");
    //             SupplierStateDesc := RecState."State Code (GST Reg. No.)";
    //             SupplierPhNo := COPYSTR(RecLocation."Phone No. 2", 1, 18);
    //             SupplierEmail := COPYSTR(RecLocation."E-Mail", 1, 50);
    //         END;

    //         WITH SalesCrMemoHeader DO BEGIN
    //             IF RecCust.GET("Sell-to Customer No.") THEN;
    //             CustGstin := RecCust."GST Registration No.";
    //             TrdName := "Bill-to Name";
    //             BillAdd1 := "Bill-to Address";
    //             BillAdd2 := "Bill-to Address 2";
    //             BillCity := "Bill-to City";
    //             BillPostCode := COPYSTR("Bill-to Post Code", 1, 6);
    //             SalesInvLine.SETRANGE("Document No.", "No.");
    //             SalesInvLine.SETRANGE(Type, SalesInvLine.Type::Item);
    //             IF SalesInvLine.FINDFIRST THEN
    //                 IF SalesInvLine."GST Place of Supply" = SalesInvLine."GST Place of Supply"::"Bill-to Address" THEN BEGIN
    //                     IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
    //                         TESTFIELD("GST Bill-to State Code");
    //                         State1.GET("GST Bill-to State Code");
    //                         StateCode := State1."State Code (GST Reg. No.)";
    //                     END ELSE
    //                         StateCode := '';
    //                     IF Contact.GET("Bill-to Contact No.") THEN BEGIN
    //                         Ph := COPYSTR(Contact."Phone No.", 1, 10);
    //                         Em := COPYSTR(Contact."E-Mail", 1, 50);
    //                     END ELSE BEGIN
    //                         Ph := '';
    //                         Em := '';
    //                     END;
    //                 END ELSE
    //                     IF SalesInvLine."GST Place of Supply" = SalesInvLine."GST Place of Supply"::"Ship-to Address" THEN BEGIN
    //                         IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
    //                             ShipState.GET("GST Ship-to State Code");
    //                             StateCode := ShipState."State Code (GST Reg. No.)";
    //                         END ELSE
    //                             StateCode := '';
    //                         IF ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code") THEN BEGIN
    //                             Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                             Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //                         END ELSE BEGIN
    //                             Ph := '';
    //                             Em := '';
    //                         END;
    //                     END ELSE BEGIN
    //                         StateCode := '';
    //                         Ph := '';
    //                         Em := '';
    //                     END;
    //         END;

    //         IF (SalesCrMemoHeader."Ship-to Code" <> '') THEN BEGIN
    //             WITH SalesCrMemoHeader DO BEGIN
    //                 ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
    //                 IF ShipToAddr."GST Registration No." <> '' THEN
    //                     Gstin := ShipToAddr."GST Registration No."
    //                 ELSE BEGIN
    //                     IF Cust.GET("Sell-to Customer No.") THEN;
    //                     Gstin := Cust."GST Registration No.";
    //                 END;
    //                 ShipTrdNm := "Ship-to Name";
    //                 ShipBno := "Ship-to Address";
    //                 ShipBnm := "Ship-to Address 2";
    //                 ShipDst := "Ship-to City";
    //                 ShipPin := COPYSTR("Ship-to Post Code", 1, 6);
    //                 StateBuff.GET("GST Ship-to State Code");
    //                 ShipStcd := StateBuff."State Code (GST Reg. No.)";
    //                 ShipPh := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                 ShipEmail := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //             END;
    //         END ELSE BEGIN
    //             WITH SalesCrMemoHeader DO BEGIN
    //                 IF Cust.GET("Sell-to Customer No.") THEN;
    //                 Gstin := Cust."GST Registration No.";
    //                 ShipTrdNm := "Ship-to Name";
    //                 ShipBno := "Ship-to Address";
    //                 ShipBnm := "Ship-to Address 2";
    //                 ShipDst := "Ship-to City";
    //                 ShipPin := COPYSTR("Ship-to Post Code", 1, 6);
    //                 IF StateBuff.GET(Cust."State Code") THEN
    //                     ShipStcd := StateBuff."State Code (GST Reg. No.)";
    //                 ShipPh := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                 ShipEmail := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //             END;
    //         END;
    //         GSTLedgerEntry.RESET;
    //         GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //         GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //         GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //         IF GSTLedgerEntry.FINDSET THEN BEGIN
    //             REPEAT
    //                 CGSTvalue1 += ABS(GSTLedgerEntry."GST Amount");
    //             UNTIL GSTLedgerEntry.NEXT = 0;
    //         END ELSE
    //             CGSTvalue1 := 0;
    //         GSTLedgerEntry.RESET;
    //         GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //         GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //         GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //         IF GSTLedgerEntry.FINDSET THEN BEGIN
    //             REPEAT
    //                 SGSTvalue1 += ABS(GSTLedgerEntry."GST Amount")
    //             UNTIL GSTLedgerEntry.NEXT = 0;
    //         END ELSE
    //             SGSTvalue1 := 0;

    //         GSTLedgerEntry.RESET;
    //         GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //         GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //         GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //         IF GSTLedgerEntry.FINDSET THEN BEGIN
    //             REPEAT
    //                 IGSTvalue1 += ABS(GSTLedgerEntry."GST Amount")
    //             UNTIL GSTLedgerEntry.NEXT = 0;
    //         END ELSE
    //             IGSTvalue1 := 0;

    //         StateCessValue := 0;
    //         GSTLedgerEntry.RESET;
    //         GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //         GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //         GSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //         IF GSTLedgerEntry.FINDSET THEN
    //             REPEAT
    //                 StateCessValue += ABS(GSTLedgerEntry."GST Amount")
    //             UNTIL GSTLedgerEntry.NEXT = 0;

    //         GSTLedgerEntry.RESET;
    //         GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //         DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //         DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //         IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //             REPEAT
    //                 IF DetailedGSTLedgerEntry."GST %" > 0 THEN
    //                     cessValue += ABS(DetailedGSTLedgerEntry."GST Amount")
    //             UNTIL GSTLedgerEntry.NEXT = 0;

    //         GSTLedgerEntry.RESET;
    //         GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //         GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //         GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
    //         IF GSTLedgerEntry.FINDSET THEN BEGIN
    //             REPEAT
    //                 IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
    //                     StCesVal += ABS(GSTLedgerEntry."GST Amount");
    //             UNTIL GSTLedgerEntry.NEXT = 0;
    //         END;

    //         AssVal2 := 0;
    //         GSTLedgerEntry.RESET;
    //         GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //         GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //         IF GSTLedgerEntry."GST Component Code" = 'CGST' THEN
    //             GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //         IF GSTLedgerEntry.FINDSET THEN BEGIN
    //             REPEAT
    //                 AssVal2 += ABS(GSTLedgerEntry."GST Base Amount");
    //             UNTIL GSTLedgerEntry.NEXT = 0;
    //         END;



    //         TotGSTAmt := 0;
    //         Disc := 0;
    //         OtherCrg := 0;
    //         SalesCrMemoHeader.CALCFIELDS("Amount to Customer");
    //         SalesCrMemoLine.RESET;
    //         SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //         IF SalesCrMemoLine.FINDSET THEN BEGIN
    //             REPEAT
    //                 AssVal += SalesCrMemoLine."GST Base Amount";
    //                 TotGSTAmt += SalesCrMemoLine."Total GST Amount";
    //                 Disc += SalesCrMemoLine."Inv. Discount Amount";
    //                 OtherCrg += SalesCrMemoLine."Charges To Customer";
    //             UNTIL SalesInvoiceLine.NEXT = 0;
    //         END;

    //         AssVal := ROUND(
    //             CurrExchRate.ExchangeAmtFCYToLCY(
    //               WORKDATE, SalesCrMemoHeader."Currency Code", AssVal, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
    //         TotGSTAmt := ROUND(
    //             CurrExchRate.ExchangeAmtFCYToLCY(
    //               WORKDATE, SalesCrMemoHeader."Currency Code", TotGSTAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
    //         Disc := ROUND(
    //             CurrExchRate.ExchangeAmtFCYToLCY(
    //               WORKDATE, SalesCrMemoHeader."Currency Code", Disc, SalesCrMemoHeader."Currency Factor"), 0.01, '=');



    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSon('userGstin', SupplierGSTINNo);
    //         JSonMgt.AddToJSonRaw('pobCode', 'null');
    //         JSonMgt.AddToJSon('supplyType', 'O');
    //         IF CheckState(SalesCrMemoHeader."No.") THEN
    //             JSonMgt.AddToJSon('ntr', 'Intra')
    //         ELSE
    //             JSonMgt.AddToJSon('ntr', 'Inter');
    //         JSonMgt.AddToJSon('docType', 'C');
    //         JSonMgt.AddToJSon('catg', 'B2B');
    //         JSonMgt.AddToJSon('dst', 'O');
    //         IF SalesCrMemoHeader."Ship-to Code" <> '' THEN
    //             JSonMgt.AddToJSon('trnTyp', 'Bill To - Ship To')
    //         ELSE
    //             JSonMgt.AddToJSon('trnTyp', 'REG');
    //         JSonMgt.AddToJSon('no', SalesCrMemoHeader."No.");
    //         JSonMgt.AddToJSon('dt', FORMAT(SalesCrMemoHeader."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
    //         JSonMgt.AddToJSonRaw('refinum', 'null');
    //         JSonMgt.AddToJSonRaw('refidt', 'null');
    //         IF State2.GET(Cust."State Code") THEN;
    //         JSonMgt.AddToJSon('pos', State2."State Code (GST Reg. No.)");
    //         JSonMgt.AddToJSonRaw('diffprcnt', 'null');
    //         JSonMgt.AddToJSonRaw('etin', 'null');
    //         JSonMgt.AddToJSon('rchrg', 'N');
    //         JSonMgt.AddToJSon('sgstin', SupplierGSTINNo);
    //         JSonMgt.AddToJSon('strdNm', SupplierName);
    //         JSonMgt.AddToJSon('slglNm', SupplierName);
    //         JSonMgt.AddToJSon('sbnm', SupplierAdd1);
    //         JSonMgt.AddToJSon('sflno', SupplierAdd2);
    //         JSonMgt.AddToJSon('sloc', SupplierCity);
    //         JSonMgt.AddToJSon('sdst', '');
    //         JSonMgt.AddToJSon('sstcd', SupplierStateDesc);//);
    //         JSonMgt.AddToJSon('spin', SupplierPinCode);
    //         JSonMgt.AddToJSon('sph', SupplierPhNo);
    //         JSonMgt.AddToJSon('sem', SupplierEmail);
    //         JSonMgt.AddToJSon('bgstin', CustGstin);
    //         JSonMgt.AddToJSon('btrdNm', TrdName);
    //         JSonMgt.AddToJSon('blglNm', TrdName);
    //         JSonMgt.AddToJSon('bbnm', BillAdd1);
    //         IF BillAdd2 <> '' THEN
    //             JSonMgt.AddToJSon('bflno', BillAdd2)
    //         ELSE
    //             JSonMgt.AddToJSon('bflno', 'null');
    //         JSonMgt.AddToJSon('bloc', BillCity);
    //         JSonMgt.AddToJSon('bdst', '');
    //         IF State2.GET(Cust."State Code") THEN;
    //         IF StateCode <> '' THEN
    //             JSonMgt.AddToJSon('bstcd', StateCode)
    //         ELSE
    //             JSonMgt.AddToJSon('bstcd', State2."State Code (GST Reg. No.)");
    //         JSonMgt.AddToJSon('bpin', BillPostCode);
    //         IF Ph <> '' THEN
    //             JSonMgt.AddToJSon('bph', Ph)
    //         ELSE
    //             JSonMgt.AddToJSonRaw('bph', 'null');
    //         IF Em <> '' THEN
    //             JSonMgt.AddToJSon('bem', Em)
    //         ELSE
    //             JSonMgt.AddToJSonRaw('bem', 'null');
    //         JSonMgt.AddToJSonRaw('dgstin', 'null');
    //         JSonMgt.AddToJSonRaw('dtrdNm', 'null');
    //         JSonMgt.AddToJSonRaw('dlglNm', 'null');
    //         JSonMgt.AddToJSonRaw('dbnm', 'null');
    //         JSonMgt.AddToJSonRaw('dflno', 'null');
    //         JSonMgt.AddToJSonRaw('dloc', 'null');
    //         JSonMgt.AddToJSonRaw('ddst', 'null');
    //         JSonMgt.AddToJSonRaw('dstcd', 'null');
    //         JSonMgt.AddToJSonRaw('dpin', 'null');
    //         JSonMgt.AddToJSonRaw('dph', 'null');
    //         JSonMgt.AddToJSonRaw('dem', 'null');
    //         IF SalesCrMemoHeader."Ship-to Code" = '' THEN BEGIN
    //             JSonMgt.AddToJSonRaw('togstin', 'null');
    //             JSonMgt.AddToJSonRaw('totrdNm', 'null');
    //             JSonMgt.AddToJSonRaw('tolglNm', 'null');
    //             JSonMgt.AddToJSonRaw('tobnm', 'null');
    //             JSonMgt.AddToJSonRaw('toflno', 'null');
    //             JSonMgt.AddToJSonRaw('toloc', 'null');
    //             JSonMgt.AddToJSonRaw('todst', 'null');
    //             JSonMgt.AddToJSonRaw('tostcd', 'null');
    //             JSonMgt.AddToJSonRaw('topin', 'null');
    //             IF ShipPh <> '' THEN
    //                 JSonMgt.AddToJSonRaw('toph', 'null')
    //             ELSE
    //                 JSonMgt.AddToJSonRaw('toph', 'null');
    //             IF ShipEmail <> '' THEN
    //                 JSonMgt.AddToJSonRaw('toem', 'null')
    //             ELSE
    //                 JSonMgt.AddToJSonRaw('toem', 'null');
    //         END ELSE BEGIN
    //             IF Cust.GET(SalesCrMemoHeader."Sell-to Customer No.") THEN;
    //             IF SalesCrMemoHeader."Ship-to Code" = '' THEN
    //                 JSonMgt.AddToJSon('togstin', 'null')
    //             ELSE
    //                 JSonMgt.AddToJSon('togstin', Cust."GST Registration No.");
    //             JSonMgt.AddToJSon('totrdNm', ShipTrdNm);
    //             JSonMgt.AddToJSon('tolglNm', ShipTrdNm);
    //             JSonMgt.AddToJSon('tobnm', ShipBno);
    //             IF ShipBnm <> '' THEN
    //                 JSonMgt.AddToJSon('toflno', ShipBnm)
    //             ELSE
    //                 JSonMgt.AddToJSon('toflno', 'null');
    //             JSonMgt.AddToJSon('toloc', ShipDst);
    //             JSonMgt.AddToJSon('todst', ShipDst);
    //             JSonMgt.AddToJSon('tostcd', ShipStcd);
    //             JSonMgt.AddToJSon('topin', ShipPin);
    //             IF ShipPh <> '' THEN
    //                 JSonMgt.AddToJSon('toph', ShipPh)
    //             ELSE
    //                 JSonMgt.AddToJSonRaw('toph', 'null');
    //             IF ShipEmail <> '' THEN
    //                 JSonMgt.AddToJSon('toem', ShipEmail)
    //             ELSE
    //                 JSonMgt.AddToJSonRaw('toem', 'null');
    //         END;
    //         JSonMgt.AddToJSonRaw('sbnum', 'null');
    //         JSonMgt.AddToJSonRaw('sbdt', 'null');
    //         JSonMgt.AddToJSonRaw('port', 'null');
    //         JSonMgt.AddToJSonRaw('expduty', 0);
    //         JSonMgt.AddToJSonRaw('cntcd', 'null');
    //         JSonMgt.AddToJSonRaw('forCur', 'null');
    //         JSonMgt.AddToJSonRaw('invForCur', 'null');
    //         JSonMgt.AddToJSon('taxSch', 'GST');
    //         JSonMgt.AddToJSonRaw('totinvval', SalesCrMemoHeader."Amount to Customer");
    //         JSonMgt.AddToJSonRaw('totdisc', Disc);
    //         JSonMgt.AddToJSonRaw('totfrt', 'null');
    //         JSonMgt.AddToJSonRaw('totins', 'null');
    //         JSonMgt.AddToJSonRaw('totpkg', 'null');
    //         JSonMgt.AddToJSonRaw('totothchrg', CalcTCSAmt(SalesCrMemoHeader."No."));
    //         JSonMgt.AddToJSonRaw('tottxval', AssVal2);
    //         JSonMgt.AddToJSonRaw('totiamt', IGSTvalue1);
    //         JSonMgt.AddToJSonRaw('totcamt', CGSTvalue1);
    //         JSonMgt.AddToJSonRaw('totsamt', SGSTvalue1);
    //         JSonMgt.AddToJSonRaw('totcsamt', cessValue);
    //         JSonMgt.AddToJSonRaw('totstcsamt', StateCessValue);
    //         JSonMgt.AddToJSonRaw('rndOffAmt', '0');
    //         JSonMgt.AddToJSon('sec7act', 'N');
    //         JSonMgt.AddToJSonRaw('invStDt', 'null');
    //         JSonMgt.AddToJSonRaw('invEndDt', 'null');
    //         JSonMgt.AddToJSonRaw('invRmk', 'null');
    //         JSonMgt.AddToJSonRaw('omon', 'null');
    //         JSonMgt.AddToJSonRaw('odty', 'null');
    //         JSonMgt.AddToJSonRaw('oinvtyp', 'null');
    //         JSonMgt.AddToJSonRaw('octin', 'null');
    //         JSonMgt.AddToJSonRaw('userIRN', 'null');
    //         JSonMgt.AddToJSonRaw('payNm', 'null');
    //         JSonMgt.AddToJSonRaw('acctdet', 'null');
    //         JSonMgt.AddToJSonRaw('mode', 'null');
    //         JSonMgt.AddToJSonRaw('ifsc', 'null');
    //         JSonMgt.AddToJSonRaw('payTerm', 'null');
    //         JSonMgt.AddToJSonRaw('payInstr', 'null');
    //         JSonMgt.AddToJSonRaw('crTrn', 'null');
    //         JSonMgt.AddToJSonRaw('dirDr', 'null');
    //         JSonMgt.AddToJSonRaw('crDay', 'null');
    //         JSonMgt.AddToJSonRaw('balAmt', 'null');
    //         JSonMgt.AddToJSonRaw('paidAmt', 'null');
    //         JSonMgt.AddToJSonRaw('payDueDt', 'null');
    //         JSonMgt.AddToJSonRaw('transId', 'null');
    //         JSonMgt.AddToJSon('subSplyTyp', 'Supply');
    //         JSonMgt.AddToJSonRaw('subSplyDes', 'null');
    //         JSonMgt.AddToJSonRaw('kdrefinum', 'null');
    //         JSonMgt.AddToJSonRaw('kdrefidt', 'null');
    //         JSonMgt.AddToJSonRaw('transMode', 'null');
    //         JSonMgt.AddToJSonRaw('vehTyp', 'null');
    //         JSonMgt.AddToJSonRaw('transDist', 'null');
    //         JSonMgt.AddToJSonRaw('transName', 'null');
    //         JSonMgt.AddToJSonRaw('transDocNo', 'null');
    //         JSonMgt.AddToJSonRaw('transdocdate', 'null');
    //         JSonMgt.AddToJSonRaw('vehNo', 'null');
    //         JSonMgt.AddToJSonRaw('clmrfnd', 'null');
    //         JSonMgt.AddToJSonRaw('rfndelg', 'null');
    //         JSonMgt.AddToJSonRaw('boef', 'null');
    //         JSonMgt.AddToJSonRaw('fy', 'null');
    //         JSonMgt.AddToJSonRaw('refnum', 'null');
    //         JSonMgt.AddToJSonRaw('pdt', 'null');
    //         JSonMgt.AddToJSonRaw('ivst', 'null');
    //         JSonMgt.AddToJSonRaw('cptycde', 'null');
    //         JSonMgt.AddToJSon('gen1', 'abcd');
    //         JSonMgt.AddToJSon('gen2', 'abcd');
    //         JSonMgt.AddToJSon('gen3', 'abcd');
    //         JSonMgt.AddToJSon('gen4', 'abcd');
    //         JSonMgt.AddToJSon('gen5', 'abcd');
    //         JSonMgt.AddToJSon('gen6', 'abcd');
    //         JSonMgt.AddToJSon('gen7', 'abcd');
    //         JSonMgt.AddToJSon('gen8', 'abcd');
    //         JSonMgt.AddToJSon('gen9', 'abcd');
    //         JSonMgt.AddToJSon('gen10', 'abcd');
    //         JSonMgt.AddToJSon('gen11', 'abcd');
    //         JSonMgt.AddToJSon('gen12', 'abcd');
    //         JSonMgt.AddToJSon('gen13', 'abcd');
    //         JSonMgt.AddToJSon('gen14', 'abcd');
    //         JSonMgt.AddToJSon('gen15', 'abcd');
    //         JSonMgt.AddToJSon('gen16', 'abcd');
    //         JSonMgt.AddToJSon('gen17', 'abcd');
    //         JSonMgt.AddToJSon('gen18', 'abcd');
    //         JSonMgt.AddToJSon('gen19', 'abcd');
    //         JSonMgt.AddToJSon('gen20', 'abcd');
    //         JSonMgt.AddToJSon('gen21', 'abcd');
    //         JSonMgt.AddToJSon('gen22', 'abcd');
    //         JSonMgt.AddToJSon('gen23', 'abcd');
    //         JSonMgt.AddToJSon('gen24', 'abcd');
    //         JSonMgt.AddToJSon('gen25', 'abcd');
    //         JSonMgt.AddToJSon('gen26', 'abcd');
    //         JSonMgt.AddToJSon('gen27', 'abcd');
    //         JSonMgt.AddToJSon('gen28', 'abcd');
    //         JSonMgt.AddToJSon('gen29', 'abcd');
    //         JSonMgt.AddToJSon('gen30', 'abcd');
    //         JSonMgt.AddToJSon('pobewb', 'null');
    //         JSonMgt.AddToJSon('Pobret', 'null');
    //         JSonMgt.AddToJSon('tcsrt', 'null');
    //         JSonMgt.AddToJSon('tcsamt', '0');
    //         JSonMgt.AddToJSon('pretcs', '0');
    //         JSonMgt.AddToJSon('genIrn', 'true');
    //         JSonMgt.AddToJSon('genewb', 'N');
    //         JSonMgt.AddToJSon('signedDataReq', 'true');

    //         SalesCrLine.RESET;
    //         SalesCrLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //         SalesCrLine.SETFILTER(Quantity, '<>%1', 0);
    //         SalesCrLine.SETFILTER("No.", '<>%1', '708030');
    //         IF SalesCrLine.FINDFIRST THEN BEGIN
    //             JSonMgt.StartJsonArray2('itemList');
    //             REPEAT
    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //                 IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                     CGSTRate := DetailedGSTLedgerEntry."GST %";
    //                     CGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                 END ELSE BEGIN
    //                     CGSTRate := 0;
    //                     CGSTLineAmt := 0;
    //                 END;

    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //                 IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                     SGSTRate := DetailedGSTLedgerEntry."GST %";
    //                     SGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                 END ELSE BEGIN
    //                     SGSTRate := 0;
    //                     SGSTLineAmt := 0;
    //                 END;
    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //                 IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                     IGSTRate := DetailedGSTLedgerEntry."GST %";
    //                     IGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                 END
    //                 ELSE BEGIN
    //                     IGSTRate := 0;
    //                     IGSTLineAmt := 0;
    //                 END;

    //                 CesRt := 0;
    //                 CesNonAdval := 0;
    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //                 IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //                     IF DetailedGSTLedgerEntry."GST %" > 0 THEN
    //                         CesRt := DetailedGSTLedgerEntry."GST %"
    //                     ELSE
    //                         CesNonAdval := ABS(DetailedGSTLedgerEntry."GST Amount");

    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //                 IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //                     CesRt := DetailedGSTLedgerEntry."GST %";

    //                 StateCes := 0;
    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code");
    //                 IF DetailedGSTLedgerEntry.FINDSET THEN
    //                     REPEAT
    //                         IF NOT (DetailedGSTLedgerEntry."GST Component Code" IN ['CGST', 'SGST', 'IGST', 'CESS', 'INTERCESS'])
    //                         THEN
    //                             IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN
    //                                 StateCes := DetailedGSTLedgerEntry."GST %";
    //                     UNTIL DetailedGSTLedgerEntry.NEXT = 0;

    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesCrLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //                 IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                     REPEAT
    //                         CGSTAmt += ABS(GSTLedgerEntry."GST Amount");
    //                     UNTIL GSTLedgerEntry.NEXT = 0;
    //                 END ELSE
    //                     CGSTAmt := 0;

    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesCrLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //                 IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                     REPEAT
    //                         SGSTAmt += ABS(GSTLedgerEntry."GST Amount")
    //                     UNTIL GSTLedgerEntry.NEXT = 0;
    //                 END ELSE
    //                     SGSTAmt := 0;
    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesCrLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //                 IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                     REPEAT
    //                         IGSTAmt += ABS(GSTLedgerEntry."GST Amount")
    //                     UNTIL GSTLedgerEntry.NEXT = 0;
    //                 END ELSE
    //                     IGSTAmt := 0;

    //                 CesAmt := 0;
    //                 CesNonAdAmt := 0;
    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesCrLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //                 IF GSTLedgerEntry.FINDSET THEN
    //                     REPEAT
    //                         CesAmt += ABS(GSTLedgerEntry."GST Amount")
    //                     UNTIL GSTLedgerEntry.NEXT = 0;

    //                 //DetailedGSTLedgerEntry.SETRANGE("Document No.",SalesInvLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //                 IF GSTLedgerEntry.FINDFIRST THEN
    //                     REPEAT
    //                         CesAmt += ABS(GSTLedgerEntry."GST Amount");
    //                     UNTIL GSTLedgerEntry.NEXT = 0;

    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesCrLine."Document No.");
    //                 GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
    //                 IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                     REPEAT
    //                         IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
    //                             StCesAmt += ABS(GSTLedgerEntry."GST Amount");
    //                     UNTIL GSTLedgerEntry.NEXT = 0;
    //                 END;
    //                 AssValAmt := 0;
    //                 TotalGSTAmt := 0;
    //                 Disc := 0;
    //                 SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //                 IF SalesCrMemoLine.FINDSET THEN BEGIN
    //                     REPEAT
    //                         AssValAmt += SalesCrMemoLine."GST Base Amount";
    //                         TotalGSTAmt += SalesCrMemoLine."Total GST Amount";
    //                         Disc += SalesCrMemoLine."Inv. Discount Amount";
    //                     UNTIL SalesCrMemoLine.NEXT = 0;
    //                 END;

    //                 AssValAmt := ROUND(
    //                     CurrExchRate.ExchangeAmtFCYToLCY(
    //                       WORKDATE, SalesCrMemoHeader."Currency Code", AssValAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
    //                 TotalGSTAmt := ROUND(
    //                     CurrExchRate.ExchangeAmtFCYToLCY(
    //                       WORKDATE, SalesCrMemoHeader."Currency Code", TotGSTAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');

    //                 Disc := ROUND(
    //                     CurrExchRate.ExchangeAmtFCYToLCY(
    //                       WORKDATE, SalesCrMemoHeader."Currency Code", Disc, SalesCrMemoHeader."Currency Factor"), 0.01, '=');

    //                 JSonMgt.StartJSon;
    //                 JSonMgt.AddToJSonRaw('barcode', 'null');
    //                 JSonMgt.AddToJSonRaw('bchExpDt', 'null');
    //                 JSonMgt.AddToJSonRaw('bchWrDt', 'null');
    //                 JSonMgt.AddToJSonRaw('bchnm', 'null');
    //                 JSonMgt.AddToJSonRaw('camt', CGSTLineAmt);
    //                 JSonMgt.AddToJSonRaw('cesNonAdval', '0');
    //                 JSonMgt.AddToJSonRaw('stCesNonAdvl', '0');
    //                 JSonMgt.AddToJSonRaw('crt', CGSTRate);
    //                 JSonMgt.AddToJSonRaw('csamt', '0');
    //                 JSonMgt.AddToJSonRaw('csrt', '0');
    //                 JSonMgt.AddToJSonRaw('disc', '0');
    //                 JSonMgt.AddToJSonRaw('freeQty', '0');
    //                 JSonMgt.AddToJSon('hsnCd', SalesCrLine."HSN/SAC Code");
    //                 JSonMgt.AddToJSonRaw('iamt', IGSTLineAmt);
    //                 JSonMgt.AddToJSonRaw('irt', IGSTRate);
    //                 JSonMgt.AddToJSonRaw('isServc', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen1', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen2', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen3', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen4', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen5', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen6', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen7', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen8', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen9', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen10', 'null');
    //                 JSonMgt.AddToJSonRaw('itmVal', SalesCrLine."Line Amount" + CGSTLineAmt + IGSTLineAmt + SGSTLineAmt);// SalesCrLine."Total GST Amount");
    //                 JSonMgt.AddToJSon('num', SalesCrLine."Line No." / 10000);
    //                 JSonMgt.AddToJSonRaw('ordLineRef', 'null');
    //                 JSonMgt.AddToJSonRaw('orgCntry', 'null');
    //                 JSonMgt.AddToJSonRaw('othchrg', 'null');
    //                 JSonMgt.AddToJSon('prdDesc', SalesCrLine.Description);
    //                 JSonMgt.AddToJSon('prdSlNo', 'null');
    //                 JSonMgt.AddToJSonRaw('preTaxVal', '0');
    //                 JSonMgt.AddToJSonRaw('qty', SalesCrLine.Quantity);
    //                 JSonMgt.AddToJSonRaw('rt', '0');
    //                 JSonMgt.AddToJSonRaw('samt', SGSTLineAmt);
    //                 JSonMgt.AddToJSonRaw('srt', SGSTRate);

    //                 JSonMgt.AddToJSonRaw('stcsamt', '0');
    //                 JSonMgt.AddToJSonRaw('stcsrt', '0');
    //                 JSonMgt.AddToJSonRaw('sval', SalesCrLine."Line Amount");
    //                 JSonMgt.AddToJSonRaw('txp', 'null');
    //                 JSonMgt.AddToJSonRaw('txval', SalesCrLine."GST Base Amount");
    //                 IF SalesCrLine.Type = SalesCrLine.Type::Item THEN BEGIN
    //                     IF SalesCrLine."Unit of Measure Code" = 'MT' THEN
    //                         JSonMgt.AddToJSon('unit', 'MTS')
    //                     ELSE
    //                         IF SalesCrLine."Unit of Measure Code" <> '' THEN
    //                             JSonMgt.AddToJSon('unit', SalesCrLine."Unit of Measure Code")
    //                         ELSE
    //                             JSonMgt.AddToJSon('unit', 'OTH');
    //                 END ELSE BEGIN
    //                     JSonMgt.AddToJSon('unit', 'OTH');
    //                 END;
    //                 JSonMgt.AddToJSonRaw('unitPrice', SalesCrLine."Unit Price");
    //                 JSonMgt.EndJSon;
    //             UNTIL SalesCrLine.NEXT = 0;
    //         END;
    //         JSonMgt.EndJSonArray;


    //         JSonMgt.StartJsonArray2('invItmOtherDtls');
    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSon('attNm', 'null');
    //         JSonMgt.AddToJSon('attVal', 'null');
    //         JSonMgt.EndJSon;
    //         JSonMgt.EndJSonArray;

    //         JSonMgt.StartJsonArray2('invOthDocDtls');
    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSon('url', 'null');
    //         JSonMgt.AddToJSon('docs', 'null');
    //         JSonMgt.AddToJSon('infoDtls', 'null');
    //         JSonMgt.EndJSon;
    //         JSonMgt.EndJSonArray;

    //         JSonMgt.StartJsonArray2('invRefPreDtls');
    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSonRaw('oinum', 'null');
    //         JSonMgt.AddToJSonRaw('oidt', 'null');
    //         JSonMgt.AddToJSonRaw('othRefNo', 'null');
    //         JSonMgt.EndJSon;
    //         JSonMgt.EndJSonArray;

    //         JSonMgt.StartJsonArray2('invRefContDtls');
    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSonRaw('raref', 'null');
    //         JSonMgt.AddToJSonRaw('radt', 'null');
    //         JSonMgt.AddToJSonRaw('tendref', 'null');
    //         JSonMgt.AddToJSonRaw('contref', 'null');
    //         JSonMgt.AddToJSonRaw('extref', 'null');
    //         JSonMgt.AddToJSonRaw('projref', 'null');
    //         JSonMgt.AddToJSonRaw('poref', 'null');
    //         JSonMgt.AddToJSonRaw('porefdt', 'null');
    //         JSonMgt.EndJSon;
    //         JSonMgt.EndJSonArray;
    //         JSonMgt.EndJSon;
    //         String := String.Copy(JSonMgt.GetJSon);
    //         MESSAGE('%1', String);
    //         E_InvoiceSetup.GET;
    //         JSonMgt.UploadJSon(E_InvoiceSetup."e-Invoice URL", String, 'POST');
    //         MESSAGE('%1', String);
    //         SalesCrMemoHeader."IRN Hash2" := JSonMgt.ReadFirstJSonValue(String, 'irn');
    //         SalesCrMemoHeader."Acknowledgement No.2" := JSonMgt.ReadFirstJSonValue(String, 'ackNo');
    //         IF JSonMgt.ReadFirstJSonValue(String, 'ackDt') <> '' THEN BEGIN
    //             EVALUATE(intYear, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'ackDt'), 1, 4));
    //             EVALUATE(intMonth, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'ackDt'), 6, 2));
    //             EVALUATE(intDay, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'ackDt'), 9, 2));
    //             DateValue := DMY2DATE(intDay, intMonth, intYear);
    //             DateText := FORMAT(DateValue) + ' ' + FORMAT(TIME);
    //             EVALUATE(SalesCrMemoHeader."Acknowledgement Date2", DateText);
    //         END;
    //         IF JSonMgt.ReadFirstJSonValue(String, 'signedQrCode') <> '' THEN BEGIN
    //             QRCodeTxt := JSonMgt.ReadFirstJSonValue(String, 'signedQrCode');
    //             QRCodeFileName := GetQRCodeDebit(QRCodeTxt);
    //             QRCodeFileName := MoveToMagicPathDebit(QRCodeFileName);
    //             CLEAR(TempBlob);
    //             TempBlob.CALCFIELDS(Blob);
    //             FileManagement.BLOBImport(TempBlob, QRCodeFileName);
    //             SalesCrMemoHeader."QR Code2" := TempBlob.Blob;
    //         END;
    //         SalesCrMemoHeader.MODIFY;
    //     end;

    //     [Scope('Internal')]
    //     procedure GetECreditMemo(SalesCrMemoHeader: Record "114")
    //     var
    //         SGSTvalue1: Decimal;
    //         CGSTvalue1: Decimal;
    //         IGSTvalue1: Decimal;
    //         State2: Record "13762";
    //         DescText: Text;
    //         SIL2: Record "113";
    //         TempBlob: Record "99008535";
    //         FieldRef: FieldRef;
    //         QRCodeInput: Text;
    //         QRCodeFileName: Text;
    //         intYear: Integer;
    //         intMonth: Integer;
    //         intDay: Integer;
    //         DateValue: Date;
    //         DateText: Text;
    //         ProjectTask: Record "1001";
    //         MilestoneDescription: Text;
    //         QRCodeTxt: Text;
    //         TaxableValue: Decimal;
    //     begin
    //         SalesCreditMemoMandatoryFields(SalesCrMemoHeader);

    //         IF CreateEInvoiceToken THEN BEGIN
    //             ComInfo.GET;
    //             IF RecLocation.GET(SalesCrMemoHeader."Location Code") THEN BEGIN
    //                 SupplierGSTINNo := RecLocation."GST Registration No.";
    //                 SupplierName := RecLocation.Name;
    //                 SupplierAdd1 := RecLocation.Address;
    //                 SupplierAdd2 := RecLocation."Address 2";
    //                 SupplierCity := RecLocation.City;
    //                 SupplierPinCode := COPYSTR(RecLocation."Post Code", 1, 6);
    //                 RecState.GET(RecLocation."State Code");
    //                 SupplierStateDesc := RecState."State Code (GST Reg. No.)";
    //                 SupplierPhNo := COPYSTR(RecLocation."Phone No. 2", 1, 18);
    //                 SupplierEmail := COPYSTR(RecLocation."E-Mail", 1, 50);
    //             END;

    //             WITH SalesCrMemoHeader DO BEGIN
    //                 IF RecCust.GET("Sell-to Customer No.") THEN;
    //                 CustGstin := RecCust."GST Registration No.";
    //                 TrdName := "Bill-to Name";
    //                 BillAdd1 := "Bill-to Address";
    //                 BillAdd2 := "Bill-to Address 2";
    //                 BillCity := "Bill-to City";
    //                 BillPostCode := COPYSTR("Bill-to Post Code", 1, 6);
    //                 SalesCrMemoLine.SETRANGE("Document No.", "No.");
    //                 SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::Item);
    //                 IF SalesCrMemoLine.FINDFIRST THEN
    //                     IF SalesCrMemoLine."GST Place of Supply" = SalesCrMemoLine."GST Place of Supply"::"Bill-to Address" THEN BEGIN
    //                         IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
    //                             TESTFIELD("GST Bill-to State Code");
    //                             State1.GET("GST Bill-to State Code");
    //                             StateCode := State1."State Code (GST Reg. No.)";
    //                         END ELSE
    //                             StateCode := '';
    //                         IF Contact.GET("Bill-to Contact No.") THEN BEGIN
    //                             Ph := COPYSTR(Contact."Phone No.", 1, 10);
    //                             Em := COPYSTR(Contact."E-Mail", 1, 50);
    //                         END ELSE BEGIN
    //                             Ph := '';
    //                             Em := '';
    //                         END;
    //                     END ELSE
    //                         IF SalesCrMemoLine."GST Place of Supply" = SalesCrMemoLine."GST Place of Supply"::"Ship-to Address" THEN BEGIN
    //                             IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
    //                                 ShipState.GET("GST Ship-to State Code");
    //                                 StateCode := ShipState."State Code (GST Reg. No.)";
    //                             END ELSE
    //                                 StateCode := '';
    //                             IF ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code") THEN BEGIN
    //                                 Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                                 Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //                             END ELSE BEGIN
    //                                 Ph := '';
    //                                 Em := '';
    //                             END;
    //                         END ELSE BEGIN
    //                             StateCode := '';
    //                             Ph := '';
    //                             Em := '';
    //                         END;
    //             END;

    //             IF (SalesCrMemoHeader."Ship-to Code" <> '') THEN BEGIN
    //                 WITH SalesCrMemoHeader DO BEGIN
    //                     ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
    //                     IF ShipToAddr."GST Registration No." <> '' THEN
    //                         Gstin := ShipToAddr."GST Registration No."
    //                     ELSE BEGIN
    //                         IF Cust.GET("Sell-to Customer No.") THEN;
    //                         Gstin := Cust."GST Registration No.";
    //                     END;
    //                     ShipTrdNm := "Ship-to Name";
    //                     ShipBno := "Ship-to Address";
    //                     ShipBnm := "Ship-to Address 2";
    //                     ShipDst := "Ship-to City";
    //                     ShipPin := COPYSTR("Ship-to Post Code", 1, 6);
    //                     StateBuff.GET("GST Ship-to State Code");
    //                     ShipStcd := StateBuff."State Code (GST Reg. No.)";
    //                     ShipPh := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                     ShipEmail := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //                 END;
    //             END ELSE BEGIN
    //                 WITH SalesCrMemoHeader DO BEGIN
    //                     IF Cust.GET("Sell-to Customer No.") THEN;
    //                     Gstin := Cust."GST Registration No.";
    //                     ShipTrdNm := "Ship-to Name";
    //                     ShipBno := "Ship-to Address";
    //                     ShipBnm := "Ship-to Address 2";
    //                     ShipDst := "Ship-to City";
    //                     ShipPin := COPYSTR("Ship-to Post Code", 1, 6);
    //                     IF StateBuff.GET(Cust."State Code") THEN
    //                         ShipStcd := StateBuff."State Code (GST Reg. No.)";
    //                     ShipPh := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                     ShipEmail := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //                 END;
    //             END;

    //             GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //             GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //             GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //             IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     CGSTvalue1 += ABS(GSTLedgerEntry."GST Amount");
    //                 UNTIL GSTLedgerEntry.NEXT = 0;
    //             END ELSE
    //                 CGSTvalue1 := 0;

    //             GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //             GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //             GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //             IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     SGSTvalue1 += ABS(GSTLedgerEntry."GST Amount")
    //                 UNTIL GSTLedgerEntry.NEXT = 0;
    //             END ELSE
    //                 SGSTvalue1 := 0;
    //             GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //             GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //             GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //             IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     IGSTvalue1 += ABS(GSTLedgerEntry."GST Amount")
    //                 UNTIL GSTLedgerEntry.NEXT = 0;
    //             END ELSE
    //                 IGSTvalue1 := 0;

    //             StateCessValue := 0;
    //             GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //             GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //             GSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //             IF GSTLedgerEntry.FINDSET THEN
    //                 REPEAT
    //                     StateCessValue += ABS(GSTLedgerEntry."GST Amount")
    //                 UNTIL GSTLedgerEntry.NEXT = 0;

    //             GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //             DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //             DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //             IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //                 REPEAT
    //                     IF DetailedGSTLedgerEntry."GST %" > 0 THEN
    //                         cessValue += ABS(DetailedGSTLedgerEntry."GST Amount")
    //                 UNTIL GSTLedgerEntry.NEXT = 0;
    //             GSTLedgerEntry.SETRANGE(GSTLedgerEntry."Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
    //             GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //             GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
    //             IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
    //                         StCesVal += ABS(GSTLedgerEntry."GST Amount");
    //                 UNTIL GSTLedgerEntry.NEXT = 0;
    //             END;
    //             AssVal := 0;
    //             TotGSTAmt := 0;
    //             Disc := 0;
    //             OtherCrg := 0;
    //             TaxableValue := 0;
    //             SalesCrMemoHeader.CALCFIELDS("Amount to Customer");
    //             SalesCrMemoLine.RESET;
    //             SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //             IF SalesCrMemoLine.FINDSET THEN BEGIN
    //                 REPEAT
    //                     AssVal += SalesCrMemoLine."GST Base Amount";
    //                     TaxableValue += SalesCrMemoLine."Line Amount";
    //                     TotGSTAmt += SalesCrMemoLine."Total GST Amount";
    //                     Disc += SalesCrMemoLine."Inv. Discount Amount";
    //                     OtherCrg += SalesCrMemoLine."Charges To Customer";
    //                 UNTIL SalesCrMemoLine.NEXT = 0;
    //             END;

    //             AssVal := ROUND(
    //                 CurrExchRate.ExchangeAmtFCYToLCY(
    //                   WORKDATE, SalesCrMemoHeader."Currency Code", AssVal, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
    //             TotGSTAmt := ROUND(
    //                 CurrExchRate.ExchangeAmtFCYToLCY(
    //                   WORKDATE, SalesCrMemoHeader."Currency Code", TotGSTAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
    //             Disc := ROUND(
    //                 CurrExchRate.ExchangeAmtFCYToLCY(
    //                   WORKDATE, SalesCrMemoHeader."Currency Code", Disc, SalesCrMemoHeader."Currency Factor"), 0.01, '=');



    //             JSonMgt.StartJSon;
    //             JSonMgt.AddToJSon('userGstin', SupplierGSTINNo);
    //             JSonMgt.AddToJSonRaw('pobCode', 'null');
    //             JSonMgt.AddToJSon('supplyType', 'O');
    //             IF SalesCrMemoHeader."GST Bill-to State Code" = SalesCrMemoHeader."Location State Code" THEN
    //                 JSonMgt.AddToJSon('ntr', 'Intra')
    //             ELSE
    //                 JSonMgt.AddToJSon('ntr', 'Inter');
    //             IF SalesCrMemoHeader."Invoice Type" = SalesCrMemoHeader."Invoice Type"::"Debit Note" THEN
    //                 JSonMgt.AddToJSon('docType', 'C')
    //             ELSE
    //                 JSonMgt.AddToJSon('docType', 'C');
    //             IF (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Unregistered) OR (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Exempted) THEN BEGIN
    //                 SalesCrMemoHeader.CALCFIELDS("Amount to Customer");
    //                 IF SalesCrMemoHeader."GST Bill-to State Code" = SalesCrMemoHeader."Location State Code" THEN
    //                     JSonMgt.AddToJSon('catg', 'B2CS')
    //                 ELSE BEGIN
    //                     IF SalesCrMemoHeader."Amount to Customer" > 250000 THEN
    //                         JSonMgt.AddToJSon('catg', 'B2CL')
    //                     ELSE
    //                         JSonMgt.AddToJSon('catg', 'B2CS');
    //                 END;
    //             END
    //             ELSE
    //                 JSonMgt.AddToJSon('catg', 'B2B');
    //             JSonMgt.AddToJSon('dst', 'O');
    //             //IF SalesInvoiceHeader."Location State Code" =SalesInvoiceHeader."GST Ship-to State Code" THEN
    //             //JSonMgt.AddToJSon('trnTyp','Bill To - Ship To')
    //             //ELSE
    //             JSonMgt.AddToJSon('trnTyp', 'REG');
    //             JSonMgt.AddToJSon('no', SalesCrMemoHeader."No.");
    //             JSonMgt.AddToJSon('dt', FORMAT(SalesCrMemoHeader."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
    //             JSonMgt.AddToJSonRaw('refinum', 'null');
    //             JSonMgt.AddToJSonRaw('refidt', 'null');
    //             IF SalesCrMemoHeader."Ship-to Code" = '' THEN BEGIN
    //                 IF Cust.GET(SalesCrMemoHeader."Sell-to Customer No.") THEN;
    //                 IF State2.GET(Cust."State Code") THEN;
    //                 JSonMgt.AddToJSon('pos', State2."State Code (GST Reg. No.)");
    //             END
    //             ELSE BEGIN
    //                 IF ShipToAddr.GET(SalesCrMemoHeader."Sell-to Customer No.", SalesCrMemoHeader."Ship-to Code") THEN;
    //                 IF State2.GET(ShipToAddr.State) THEN;
    //                 JSonMgt.AddToJSon('pos', State2."State Code (GST Reg. No.)");

    //             END;
    //             JSonMgt.AddToJSonRaw('diffprcnt', 'null');
    //             JSonMgt.AddToJSonRaw('etin', 'null');
    //             JSonMgt.AddToJSon('rchrg', 'N');
    //             JSonMgt.AddToJSon('sgstin', SupplierGSTINNo);
    //             JSonMgt.AddToJSon('strdNm', SupplierName);
    //             JSonMgt.AddToJSon('slglNm', SupplierName);
    //             JSonMgt.AddToJSon('sbnm', SupplierAdd1);
    //             IF SupplierAdd2 <> '' THEN
    //                 JSonMgt.AddToJSon('sflno', SupplierAdd2)
    //             ELSE
    //                 JSonMgt.AddToJSon('sflno', 'null');
    //             JSonMgt.AddToJSon('sloc', SupplierCity);
    //             JSonMgt.AddToJSon('sdst', '');
    //             JSonMgt.AddToJSon('sstcd', SupplierStateDesc);//);
    //             JSonMgt.AddToJSon('spin', SupplierPinCode);
    //             JSonMgt.AddToJSon('sph', SupplierPhNo);
    //             JSonMgt.AddToJSon('sem', SupplierEmail);
    //             IF (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Unregistered) OR (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Exempted) THEN
    //                 JSonMgt.AddToJSon('bgstin', 'URP')
    //             ELSE
    //                 JSonMgt.AddToJSon('bgstin', CustGstin);
    //             JSonMgt.AddToJSon('btrdNm', TrdName);
    //             JSonMgt.AddToJSon('blglNm', TrdName);
    //             JSonMgt.AddToJSon('bbnm', BillAdd1);
    //             IF BillAdd2 <> '' THEN
    //                 JSonMgt.AddToJSon('bflno', BillAdd2)
    //             ELSE
    //                 JSonMgt.AddToJSon('bflno', 'null');
    //             JSonMgt.AddToJSon('bloc', BillCity);
    //             JSonMgt.AddToJSon('bdst', '');
    //             IF State2.GET(Cust."State Code") THEN;
    //             IF StateCode <> '' THEN
    //                 JSonMgt.AddToJSon('bstcd', StateCode)
    //             ELSE
    //                 JSonMgt.AddToJSon('bstcd', State2."State Code (GST Reg. No.)");
    //             JSonMgt.AddToJSon('bpin', BillPostCode);
    //             IF Ph <> '' THEN
    //                 JSonMgt.AddToJSon('bph', Ph)
    //             ELSE
    //                 JSonMgt.AddToJSonRaw('bph', 'null');
    //             IF Em <> '' THEN
    //                 JSonMgt.AddToJSon('bem', Em)
    //             ELSE
    //                 JSonMgt.AddToJSonRaw('bem', 'null');
    //             JSonMgt.AddToJSonRaw('dgstin', 'null');
    //             JSonMgt.AddToJSonRaw('dtrdNm', 'null');
    //             JSonMgt.AddToJSonRaw('dlglNm', 'null');
    //             JSonMgt.AddToJSonRaw('dbnm', 'null');
    //             JSonMgt.AddToJSonRaw('dflno', 'null');
    //             JSonMgt.AddToJSonRaw('dloc', 'null');
    //             JSonMgt.AddToJSonRaw('ddst', 'null');
    //             JSonMgt.AddToJSonRaw('dstcd', 'null');
    //             JSonMgt.AddToJSonRaw('dpin', 'null');
    //             JSonMgt.AddToJSonRaw('dph', 'null');
    //             JSonMgt.AddToJSonRaw('dem', 'null');
    //             IF SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Registered THEN BEGIN
    //                 IF SalesCrMemoHeader."Ship-to Code" = '' THEN BEGIN
    //                     JSonMgt.AddToJSonRaw('togstin', 'null');
    //                     JSonMgt.AddToJSonRaw('totrdNm', 'null');
    //                     JSonMgt.AddToJSonRaw('tolglNm', 'null');
    //                     JSonMgt.AddToJSonRaw('tobnm', 'null');
    //                     JSonMgt.AddToJSonRaw('toflno', 'null');
    //                     JSonMgt.AddToJSonRaw('toloc', 'null');
    //                     JSonMgt.AddToJSonRaw('todst', 'null');
    //                     JSonMgt.AddToJSonRaw('tostcd', 'null');
    //                     JSonMgt.AddToJSonRaw('topin', 'null');
    //                     IF ShipPh <> '' THEN
    //                         JSonMgt.AddToJSonRaw('toph', 'null')
    //                     ELSE
    //                         JSonMgt.AddToJSonRaw('toph', 'null');
    //                     IF ShipEmail <> '' THEN
    //                         JSonMgt.AddToJSonRaw('toem', 'null')
    //                     ELSE
    //                         JSonMgt.AddToJSonRaw('toem', 'null');
    //                 END ELSE BEGIN
    //                     IF Cust.GET(SalesCrMemoHeader."Sell-to Customer No.") THEN;
    //                     IF SalesCrMemoHeader."Ship-to Code" = '' THEN
    //                         JSonMgt.AddToJSon('togstin', 'null')
    //                     ELSE
    //                         JSonMgt.AddToJSon('togstin', Cust."GST Registration No.");
    //                     JSonMgt.AddToJSon('totrdNm', ShipTrdNm);
    //                     JSonMgt.AddToJSon('tolglNm', ShipTrdNm);
    //                     JSonMgt.AddToJSon('tobnm', ShipBno);
    //                     IF ShipBnm <> '' THEN
    //                         JSonMgt.AddToJSon('toflno', ShipBnm)
    //                     ELSE
    //                         JSonMgt.AddToJSon('toflno', 'null');
    //                     JSonMgt.AddToJSon('toloc', ShipDst);
    //                     JSonMgt.AddToJSon('todst', ShipDst);
    //                     JSonMgt.AddToJSon('tostcd', ShipStcd);
    //                     JSonMgt.AddToJSon('topin', ShipPin);
    //                     IF ShipPh <> '' THEN
    //                         JSonMgt.AddToJSon('toph', ShipPh)
    //                     ELSE
    //                         JSonMgt.AddToJSonRaw('toph', 'null');
    //                     IF ShipEmail <> '' THEN
    //                         JSonMgt.AddToJSon('toem', ShipEmail)
    //                     ELSE
    //                         JSonMgt.AddToJSonRaw('toem', 'null');
    //                 END;
    //                 JSonMgt.AddToJSonRaw('sbnum', 'null');
    //                 JSonMgt.AddToJSonRaw('sbdt', 'null');
    //                 JSonMgt.AddToJSonRaw('port', 'null');
    //                 JSonMgt.AddToJSonRaw('expduty', 0);
    //                 JSonMgt.AddToJSonRaw('cntcd', 'null');
    //                 JSonMgt.AddToJSonRaw('forCur', 'null');
    //                 JSonMgt.AddToJSonRaw('invForCur', 'null');
    //                 JSonMgt.AddToJSon('taxSch', 'GST');
    //             END ELSE BEGIN
    //                 JSonMgt.AddToJSonRaw('togstin', 'null');
    //                 JSonMgt.AddToJSonRaw('totrdNm', 'null');
    //                 JSonMgt.AddToJSonRaw('tolglNm', 'null');
    //                 JSonMgt.AddToJSonRaw('tobnm', 'null');
    //                 JSonMgt.AddToJSonRaw('toflno', 'null');
    //                 JSonMgt.AddToJSonRaw('toloc', 'null');
    //                 JSonMgt.AddToJSonRaw('todst', 'null');
    //                 JSonMgt.AddToJSonRaw('tostcd', 'null');
    //                 JSonMgt.AddToJSonRaw('topin', 'null');
    //                 JSonMgt.AddToJSonRaw('toph', 'null');
    //                 JSonMgt.AddToJSonRaw('toem', 'null');
    //                 JSonMgt.AddToJSonRaw('sbnum', 'null');
    //                 JSonMgt.AddToJSonRaw('sbdt', 'null');
    //                 JSonMgt.AddToJSonRaw('port', 'null');
    //                 JSonMgt.AddToJSonRaw('expduty', 0);
    //                 JSonMgt.AddToJSonRaw('cntcd', 'null');
    //                 JSonMgt.AddToJSonRaw('forCur', 'null');
    //                 JSonMgt.AddToJSonRaw('invForCur', 'null');
    //                 JSonMgt.AddToJSon('taxSch', 'GST');
    //             END;
    //             JSonMgt.AddToJSonRaw('totinvval', SalesCrMemoHeader."Amount to Customer");
    //             JSonMgt.AddToJSonRaw('totdisc', Disc);
    //             JSonMgt.AddToJSonRaw('totfrt', 'null');
    //             JSonMgt.AddToJSonRaw('totins', 'null');
    //             JSonMgt.AddToJSonRaw('totpkg', 'null');
    //             JSonMgt.AddToJSonRaw('totothchrg', CalcTCSAmt(SalesCrMemoHeader."No."));

    //             IF AssVal <> 0 THEN
    //                 JSonMgt.AddToJSonRaw('tottxval', AssVal)
    //             ELSE
    //                 JSonMgt.AddToJSonRaw('tottxval', TaxableValue);
    //             JSonMgt.AddToJSonRaw('totiamt', IGSTvalue1);
    //             JSonMgt.AddToJSonRaw('totcamt', CGSTvalue1);
    //             JSonMgt.AddToJSonRaw('totsamt', SGSTvalue1);
    //             JSonMgt.AddToJSonRaw('totcsamt', cessValue);
    //             JSonMgt.AddToJSonRaw('totstcsamt', StateCessValue);
    //             JSonMgt.AddToJSonRaw('rndOffAmt', '0');
    //             JSonMgt.AddToJSon('sec7act', 'N');
    //             JSonMgt.AddToJSonRaw('invStDt', 'null');
    //             JSonMgt.AddToJSonRaw('invEndDt', 'null');
    //             JSonMgt.AddToJSonRaw('invRmk', 'null');
    //             JSonMgt.AddToJSonRaw('omon', 'null');
    //             JSonMgt.AddToJSonRaw('odty', 'null');
    //             JSonMgt.AddToJSonRaw('oinvtyp', 'null');
    //             JSonMgt.AddToJSonRaw('octin', 'null');
    //             JSonMgt.AddToJSonRaw('userIRN', 'null');
    //             JSonMgt.AddToJSonRaw('payNm', 'null');
    //             JSonMgt.AddToJSonRaw('acctdet', 'null');
    //             JSonMgt.AddToJSonRaw('mode', 'null');
    //             JSonMgt.AddToJSonRaw('ifsc', 'null');
    //             JSonMgt.AddToJSonRaw('payTerm', 'null');
    //             JSonMgt.AddToJSonRaw('payInstr', 'null');
    //             JSonMgt.AddToJSonRaw('crTrn', 'null');
    //             JSonMgt.AddToJSonRaw('dirDr', 'null');
    //             JSonMgt.AddToJSonRaw('crDay', 'null');
    //             JSonMgt.AddToJSonRaw('balAmt', 'null');
    //             JSonMgt.AddToJSonRaw('paidAmt', 'null');
    //             JSonMgt.AddToJSonRaw('payDueDt', 'null');
    //             JSonMgt.AddToJSonRaw('transId', 'null');
    //             JSonMgt.AddToJSon('subSplyTyp', 'Supply');
    //             JSonMgt.AddToJSonRaw('subSplyDes', 'null');
    //             JSonMgt.AddToJSonRaw('kdrefinum', 'null');
    //             JSonMgt.AddToJSonRaw('kdrefidt', 'null');
    //             JSonMgt.AddToJSonRaw('transMode', 'null');
    //             JSonMgt.AddToJSonRaw('vehTyp', 'null');
    //             JSonMgt.AddToJSonRaw('transDist', 'null');
    //             JSonMgt.AddToJSonRaw('transName', 'null');
    //             JSonMgt.AddToJSonRaw('transDocNo', 'null');
    //             JSonMgt.AddToJSonRaw('transdocdate', 'null');
    //             JSonMgt.AddToJSonRaw('vehNo', 'null');
    //             JSonMgt.AddToJSonRaw('clmrfnd', 'null');
    //             JSonMgt.AddToJSonRaw('rfndelg', 'null');
    //             JSonMgt.AddToJSonRaw('boef', 'null');
    //             JSonMgt.AddToJSonRaw('fy', 'null');
    //             JSonMgt.AddToJSonRaw('refnum', 'null');
    //             JSonMgt.AddToJSonRaw('pdt', 'null');
    //             JSonMgt.AddToJSonRaw('ivst', 'null');
    //             JSonMgt.AddToJSonRaw('cptycde', 'null');
    //             JSonMgt.AddToJSon('gen1', 'abcd');
    //             JSonMgt.AddToJSon('gen2', 'abcd');
    //             JSonMgt.AddToJSon('gen3', 'abcd');
    //             JSonMgt.AddToJSon('gen4', 'abcd');
    //             JSonMgt.AddToJSon('gen5', 'abcd');
    //             JSonMgt.AddToJSon('gen6', 'abcd');
    //             JSonMgt.AddToJSon('gen7', 'abcd');
    //             JSonMgt.AddToJSon('gen8', 'abcd');
    //             JSonMgt.AddToJSon('gen9', 'abcd');
    //             JSonMgt.AddToJSon('gen10', 'abcd');
    //             JSonMgt.AddToJSon('gen11', 'abcd');
    //             JSonMgt.AddToJSon('gen12', 'abcd');
    //             JSonMgt.AddToJSon('gen13', 'abcd');
    //             JSonMgt.AddToJSon('gen14', 'abcd');
    //             JSonMgt.AddToJSon('gen15', 'abcd');
    //             JSonMgt.AddToJSon('gen16', 'abcd');
    //             JSonMgt.AddToJSon('gen17', 'abcd');
    //             JSonMgt.AddToJSon('gen18', 'abcd');
    //             JSonMgt.AddToJSon('gen19', 'abcd');
    //             JSonMgt.AddToJSon('gen20', 'abcd');
    //             JSonMgt.AddToJSon('gen21', 'abcd');
    //             JSonMgt.AddToJSon('gen22', 'abcd');
    //             JSonMgt.AddToJSon('gen23', 'abcd');
    //             JSonMgt.AddToJSon('gen24', 'abcd');
    //             JSonMgt.AddToJSon('gen25', 'abcd');
    //             JSonMgt.AddToJSon('gen26', 'abcd');
    //             JSonMgt.AddToJSon('gen27', 'abcd');
    //             JSonMgt.AddToJSon('gen28', 'abcd');
    //             JSonMgt.AddToJSon('gen29', 'abcd');
    //             JSonMgt.AddToJSon('gen30', 'abcd');
    //             JSonMgt.AddToJSon('pobewb', 'null');
    //             JSonMgt.AddToJSon('Pobret', 'null');
    //             JSonMgt.AddToJSon('tcsrt', 'null');
    //             JSonMgt.AddToJSon('tcsamt', '0');
    //             JSonMgt.AddToJSon('pretcs', '0');
    //             JSonMgt.AddToJSon('genIrn', 'true');
    //             JSonMgt.AddToJSon('genewb', 'N');
    //             JSonMgt.AddToJSon('signedDataReq', 'true');

    //             SalesCrMemoLine.RESET;
    //             SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //             SalesCrMemoLine.SETFILTER(Quantity, '<>%1', 0);
    //             SalesCrMemoLine.SETFILTER("No.", '<>%1', '431030');
    //             IF SalesCrMemoLine.FINDFIRST THEN BEGIN
    //                 JSonMgt.StartJsonArray2('itemList');
    //                 REPEAT
    //                     //MESSAGE('%1--%2--%3',SalesCrMemoLine."Document No.",SalesCrMemoLine."Line No.",SalesCrMemoLine."No.");
    //                     Sr += 1;
    //                     MilestoneDescription := '';
    //                     IF SalesCrMemoLine."Job No." <> '' THEN BEGIN
    //                         ProjectTask.RESET;
    //                         ProjectTask.SETRANGE("Project No.", SalesCrMemoLine."Job No.");
    //                         ProjectTask.SETRANGE("Project Task No.", SalesCrMemoLine."Job Task No.");
    //                         ProjectTask.SETRANGE(Milestone, SalesCrMemoLine.Milestone);
    //                         IF ProjectTask.FINDFIRST THEN
    //                             MilestoneDescription := ProjectTask."Milestone Desc"
    //                     END
    //                     ELSE
    //                         MilestoneDescription := SalesCrMemoLine.Description + SalesCrMemoLine."Description 2";



    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrMemoLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //                     IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                         CGSTRate := DetailedGSTLedgerEntry."GST %";
    //                         CGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                     END ELSE BEGIN
    //                         CGSTRate := 0;
    //                         CGSTLineAmt := 0;
    //                     END;

    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrMemoLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //                     IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                         SGSTRate := DetailedGSTLedgerEntry."GST %";
    //                         SGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                     END ELSE BEGIN
    //                         SGSTRate := 0;
    //                         SGSTLineAmt := 0;
    //                     END;
    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrMemoLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //                     IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                         IGSTRate := DetailedGSTLedgerEntry."GST %";
    //                         IGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                     END
    //                     ELSE BEGIN
    //                         IGSTRate := 0;
    //                         IGSTLineAmt := 0;
    //                     END;

    //                     CesRt := 0;
    //                     CesNonAdval := 0;
    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrMemoLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //                     IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //                         IF DetailedGSTLedgerEntry."GST %" > 0 THEN
    //                             CesRt := DetailedGSTLedgerEntry."GST %"
    //                         ELSE
    //                             CesNonAdval := ABS(DetailedGSTLedgerEntry."GST Amount");

    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrMemoLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //                     IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //                         CesRt := DetailedGSTLedgerEntry."GST %";

    //                     StateCes := 0;
    //                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesCrMemoLine."Line No.");
    //                     DetailedGSTLedgerEntry.SETRANGE("GST Component Code");
    //                     IF DetailedGSTLedgerEntry.FINDSET THEN
    //                         REPEAT
    //                             IF NOT (DetailedGSTLedgerEntry."GST Component Code" IN ['CGST', 'SGST', 'IGST', 'CESS', 'INTERCESS'])
    //                             THEN
    //                                 IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN
    //                                     StateCes := DetailedGSTLedgerEntry."GST %";
    //                         UNTIL DetailedGSTLedgerEntry.NEXT = 0;

    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //                     IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                         REPEAT
    //                             CGSTAmt += ABS(GSTLedgerEntry."GST Amount");
    //                         UNTIL GSTLedgerEntry.NEXT = 0;
    //                     END ELSE
    //                         CGSTAmt := 0;

    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //                     IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                         REPEAT
    //                             SGSTAmt += ABS(GSTLedgerEntry."GST Amount")
    //                         UNTIL GSTLedgerEntry.NEXT = 0;
    //                     END ELSE
    //                         SGSTAmt := 0;
    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //                     IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                         REPEAT
    //                             IGSTAmt += ABS(GSTLedgerEntry."GST Amount")
    //                         UNTIL GSTLedgerEntry.NEXT = 0;
    //                     END ELSE
    //                         IGSTAmt := 0;

    //                     CesAmt := 0;
    //                     CesNonAdAmt := 0;
    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     GSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //                     IF GSTLedgerEntry.FINDSET THEN
    //                         REPEAT
    //                             CesAmt += ABS(GSTLedgerEntry."GST Amount")
    //                         UNTIL GSTLedgerEntry.NEXT = 0;

    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     GSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //                     IF GSTLedgerEntry.FINDFIRST THEN
    //                         REPEAT
    //                             CesAmt += ABS(GSTLedgerEntry."GST Amount");
    //                         UNTIL GSTLedgerEntry.NEXT = 0;

    //                     GSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
    //                     GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
    //                     IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                         REPEAT
    //                             IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
    //                                 StCesAmt += ABS(GSTLedgerEntry."GST Amount");
    //                         UNTIL GSTLedgerEntry.NEXT = 0;
    //                     END;
    //                     AssValAmt := 0;
    //                     TotalGSTAmt := 0;
    //                     Disc := 0;
    //                     SalesCrMemoLine2.RESET;
    //                     SalesCrMemoLine2.SETRANGE("Document No.", SalesCrMemoHeader."No.");
    //                     SalesCrMemoLine2.SETFILTER(Quantity, '<>%1', 0);
    //                     SalesCrMemoLine2.SETFILTER("No.", '<>%1', '431030');
    //                     IF SalesCrMemoLine2.FINDSET THEN BEGIN
    //                         REPEAT
    //                             AssValAmt += SalesCrMemoLine2."GST Base Amount";
    //                             TotalGSTAmt += SalesCrMemoLine2."Total GST Amount";
    //                             Disc += SalesCrMemoLine2."Inv. Discount Amount";
    //                         UNTIL SalesCrMemoLine2.NEXT = 0;
    //                     END;

    //                     AssValAmt := ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           WORKDATE, SalesCrMemoHeader."Currency Code", AssVal, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
    //                     TotalGSTAmt := ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           WORKDATE, SalesCrMemoHeader."Currency Code", TotGSTAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');

    //                     Disc := ROUND(
    //                         CurrExchRate.ExchangeAmtFCYToLCY(
    //                           WORKDATE, SalesCrMemoHeader."Currency Code", Disc, SalesCrMemoHeader."Currency Factor"), 0.01, '=');

    //                     JSonMgt.StartJSon;
    //                     JSonMgt.AddToJSonRaw('barcode', 'null');
    //                     JSonMgt.AddToJSonRaw('bchExpDt', 'null');
    //                     JSonMgt.AddToJSonRaw('bchWrDt', 'null');
    //                     JSonMgt.AddToJSonRaw('bchnm', 'null');
    //                     JSonMgt.AddToJSonRaw('camt', CGSTLineAmt);
    //                     JSonMgt.AddToJSonRaw('cesNonAdval', '0');
    //                     JSonMgt.AddToJSonRaw('stCesNonAdvl', '0');
    //                     JSonMgt.AddToJSonRaw('crt', CGSTRate);
    //                     JSonMgt.AddToJSonRaw('csamt', '0');
    //                     JSonMgt.AddToJSonRaw('csrt', '0');
    //                     JSonMgt.AddToJSonRaw('disc', '0');
    //                     JSonMgt.AddToJSonRaw('freeQty', '0');
    //                     JSonMgt.AddToJSon('hsnCd', SalesCrMemoLine."HSN/SAC Code");
    //                     JSonMgt.AddToJSonRaw('iamt', IGSTLineAmt);
    //                     JSonMgt.AddToJSonRaw('irt', IGSTRate);
    //                     JSonMgt.AddToJSonRaw('isServc', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen1', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen2', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen3', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen4', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen5', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen6', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen7', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen8', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen9', 'null');
    //                     JSonMgt.AddToJSonRaw('itmgen10', 'null');
    //                     JSonMgt.AddToJSonRaw('itmVal', SalesCrMemoLine."Line Amount" + CGSTLineAmt + IGSTLineAmt + SGSTLineAmt);
    //                     //Sr+=1;
    //                     JSonMgt.AddToJSon('num', Sr);
    //                     JSonMgt.AddToJSonRaw('ordLineRef', 'null');
    //                     JSonMgt.AddToJSonRaw('orgCntry', 'null');
    //                     JSonMgt.AddToJSonRaw('othchrg', 'null');
    //                     JSonMgt.AddToJSon('prdDesc', MilestoneDescription);
    //                     JSonMgt.AddToJSon('prdSlNo', 'null');
    //                     JSonMgt.AddToJSonRaw('preTaxVal', '0');
    //                     JSonMgt.AddToJSonRaw('qty', SalesCrMemoLine.Quantity);
    //                     JSonMgt.AddToJSonRaw('rt', '0');
    //                     JSonMgt.AddToJSonRaw('samt', SGSTLineAmt);
    //                     JSonMgt.AddToJSonRaw('srt', SGSTRate);

    //                     JSonMgt.AddToJSonRaw('stcsamt', '0');
    //                     JSonMgt.AddToJSonRaw('stcsrt', '0');
    //                     JSonMgt.AddToJSonRaw('sval', SalesCrMemoLine."Line Amount");
    //                     JSonMgt.AddToJSonRaw('txp', 'null');
    //                     JSonMgt.AddToJSonRaw('txval', SalesCrMemoLine."GST Base Amount");
    //                     IF SalesCrMemoLine.Type = SalesCrMemoLine.Type::Item THEN BEGIN
    //                         IF SalesCrMemoLine."Unit of Measure Code" = 'MT' THEN
    //                             JSonMgt.AddToJSon('unit', 'MTS')
    //                         ELSE
    //                             JSonMgt.AddToJSon('unit', SalesCrMemoLine."Unit of Measure Code");
    //                     END ELSE BEGIN
    //                         JSonMgt.AddToJSon('unit', 'OTH');
    //                     END;
    //                     JSonMgt.AddToJSonRaw('unitPrice', SalesCrMemoLine."Unit Price");
    //                     JSonMgt.EndJSon;
    //                 UNTIL SalesCrMemoLine.NEXT = 0;
    //             END;
    //             JSonMgt.EndJSonArray;


    //             JSonMgt.StartJsonArray2('invItmOtherDtls');
    //             JSonMgt.StartJSon;
    //             JSonMgt.AddToJSon('attNm', 'null');
    //             JSonMgt.AddToJSon('attVal', 'null');
    //             JSonMgt.EndJSon;
    //             JSonMgt.EndJSonArray;

    //             JSonMgt.StartJsonArray2('invOthDocDtls');
    //             JSonMgt.StartJSon;
    //             JSonMgt.AddToJSon('url', 'null');
    //             JSonMgt.AddToJSon('docs', 'null');
    //             JSonMgt.AddToJSon('infoDtls', 'null');
    //             JSonMgt.EndJSon;
    //             JSonMgt.EndJSonArray;

    //             JSonMgt.StartJsonArray2('invRefPreDtls');
    //             JSonMgt.StartJSon;
    //             JSonMgt.AddToJSonRaw('oinum', 'null');
    //             JSonMgt.AddToJSonRaw('oidt', 'null');
    //             JSonMgt.AddToJSonRaw('othRefNo', 'null');
    //             JSonMgt.EndJSon;
    //             JSonMgt.EndJSonArray;

    //             JSonMgt.StartJsonArray2('invRefContDtls');
    //             JSonMgt.StartJSon;
    //             JSonMgt.AddToJSonRaw('raref', 'null');
    //             JSonMgt.AddToJSonRaw('radt', 'null');
    //             JSonMgt.AddToJSonRaw('tendref', 'null');
    //             JSonMgt.AddToJSonRaw('contref', 'null');
    //             JSonMgt.AddToJSonRaw('extref', 'null');
    //             JSonMgt.AddToJSonRaw('projref', 'null');
    //             JSonMgt.AddToJSonRaw('poref', 'null');
    //             JSonMgt.AddToJSonRaw('porefdt', 'null');
    //             JSonMgt.EndJSon;
    //             JSonMgt.EndJSonArray;
    //             JSonMgt.EndJSon;
    //             String := String.Copy(JSonMgt.GetJSon);
    //             MESSAGE('%1', String);
    //             E_InvoiceSetup.GET;
    //             JSonMgt.UploadJSon(E_InvoiceSetup."e-Invoice URL", String, 'POST');
    //             MESSAGE('%1', String);
    //             SalesCrMemoHeader."IRN Hash2" := JSonMgt.ReadFirstJSonValue(String, 'irn');
    //             SalesCrMemoHeader."Acknowledgement No.2" := JSonMgt.ReadFirstJSonValue(String, 'ackNo');
    //             IF JSonMgt.ReadFirstJSonValue(String, 'ackDt') <> '' THEN BEGIN
    //                 EVALUATE(intYear, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'ackDt'), 1, 4));
    //                 EVALUATE(intMonth, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'ackDt'), 6, 2));
    //                 EVALUATE(intDay, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'ackDt'), 9, 2));
    //                 DateValue := DMY2DATE(intDay, intMonth, intYear);
    //                 DateText := FORMAT(DateValue) + ' ' + FORMAT(TIME);
    //                 EVALUATE(SalesCrMemoHeader."Acknowledgement Date2", DateText);
    //             END;
    //             IF JSonMgt.ReadFirstJSonValue(String, 'signedQrCode') <> '' THEN BEGIN
    //                 QRCodeTxt := JSonMgt.ReadFirstJSonValue(String, 'signedQrCode');
    //                 QRCodeFileName := GetQRCodeDebit(QRCodeTxt);
    //                 QRCodeFileName := MoveToMagicPathInvoice(QRCodeFileName);

    //                 CLEAR(TempBlob);
    //                 TempBlob.CALCFIELDS(Blob);
    //                 FileManagement.BLOBImport(TempBlob, QRCodeFileName);
    //                 SalesCrMemoHeader."QR Code2" := TempBlob.Blob;
    //             END ELSE BEGIN
    //                 IF JSonMgt.ReadFirstJSonValue(String, 'qrCode') <> '' THEN BEGIN
    //                     QRCodeTxt := JSonMgt.ReadFirstJSonValue(String, 'qrCode');
    //                     QRCodeFileName := GetQRCodeDebit(QRCodeTxt);
    //                     QRCodeFileName := MoveToMagicPathInvoice(QRCodeFileName);

    //                     CLEAR(TempBlob);
    //                     TempBlob.CALCFIELDS(Blob);
    //                     FileManagement.BLOBImport(TempBlob, QRCodeFileName);
    //                     SalesCrMemoHeader."QR Code2" := TempBlob.Blob;
    //                 END;
    //             END;
    //             SalesCrMemoHeader.MODIFY;

    //             IF NOT ISSERVICETIER THEN
    //                 IF EXISTS(QRCodeFileName) THEN
    //                     ERASE(QRCodeFileName);
    //         END;
    //     end;

    //     [Scope('Internal')]
    //     procedure GetExportInvoice(SalesInvoiceHeader: Record "112")
    //     var
    //         SGSTvalue1: Decimal;
    //         CGSTvalue1: Decimal;
    //         IGSTvalue1: Decimal;
    //         State2: Record "13762";
    //         DescText: Text;
    //         SIL2: Record "113";
    //     begin
    //         ComInfo.GET;
    //         IF RecLocation.GET(SalesInvoiceHeader."Location Code") THEN BEGIN
    //             SupplierGSTINNo := RecLocation."GST Registration No.";
    //             SupplierName := RecLocation.Name;
    //             SupplierAdd1 := RecLocation.Address;
    //             SupplierAdd2 := RecLocation."Address 2";
    //             SupplierCity := RecLocation.City;
    //             SupplierPinCode := COPYSTR(RecLocation."Post Code", 1, 6);
    //             RecState.GET(RecLocation."State Code");
    //             SupplierStateDesc := RecState."State Code (GST Reg. No.)";
    //             SupplierPhNo := COPYSTR(RecLocation."Phone No. 2", 1, 18);
    //             SupplierEmail := COPYSTR(RecLocation."E-Mail", 1, 50);
    //         END;

    //         WITH SalesInvoiceHeader DO BEGIN
    //             IF RecCust.GET("Sell-to Customer No.") THEN;
    //             CustGstin := RecCust."GST Registration No.";
    //             TrdName := "Bill-to Name";
    //             BillAdd1 := "Bill-to Address";
    //             BillAdd2 := "Bill-to Address 2";
    //             BillCity := "Bill-to City";
    //             BillPostCode := COPYSTR("Bill-to Post Code", 1, 6);
    //             SalesInvLine.SETRANGE("Document No.", "No.");
    //             SalesInvLine.SETRANGE(Type, SalesInvLine.Type::Item);
    //             IF SalesInvLine.FINDFIRST THEN
    //                 IF SalesInvLine."GST Place of Supply" = SalesInvLine."GST Place of Supply"::"Bill-to Address" THEN BEGIN
    //                     IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
    //                         TESTFIELD("GST Bill-to State Code");
    //                         State1.GET("GST Bill-to State Code");
    //                         StateCode := State1."State Code (GST Reg. No.)";
    //                     END ELSE
    //                         StateCode := '';
    //                     IF Contact.GET("Bill-to Contact No.") THEN BEGIN
    //                         Ph := COPYSTR(Contact."Phone No.", 1, 10);
    //                         Em := COPYSTR(Contact."E-Mail", 1, 50);
    //                     END ELSE BEGIN
    //                         Ph := '';
    //                         Em := '';
    //                     END;
    //                 END ELSE
    //                     IF SalesInvLine."GST Place of Supply" = SalesInvLine."GST Place of Supply"::"Ship-to Address" THEN BEGIN
    //                         IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
    //                             ShipState.GET("GST Ship-to State Code");
    //                             StateCode := ShipState."State Code (GST Reg. No.)";
    //                         END ELSE
    //                             StateCode := '';
    //                         IF ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code") THEN BEGIN
    //                             Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                             Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //                         END ELSE BEGIN
    //                             Ph := '';
    //                             Em := '';
    //                         END;
    //                     END ELSE BEGIN
    //                         StateCode := '';
    //                         Ph := '';
    //                         Em := '';
    //                     END;
    //         END;

    //         IF (SalesInvoiceHeader."Ship-to Code" <> '') THEN BEGIN
    //             WITH SalesInvoiceHeader DO BEGIN
    //                 ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
    //                 IF ShipToAddr."GST Registration No." <> '' THEN
    //                     Gstin := ShipToAddr."GST Registration No."
    //                 ELSE BEGIN
    //                     IF Cust.GET("Sell-to Customer No.") THEN;
    //                     Gstin := Cust."GST Registration No.";
    //                 END;
    //                 ShipTrdNm := "Ship-to Name";
    //                 ShipBno := "Ship-to Address";
    //                 ShipBnm := "Ship-to Address 2";
    //                 ShipDst := "Ship-to City";
    //                 ShipPin := COPYSTR("Ship-to Post Code", 1, 6);
    //                 StateBuff.GET("GST Ship-to State Code");
    //                 ShipStcd := StateBuff."State Code (GST Reg. No.)";
    //                 ShipPh := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                 ShipEmail := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //             END;
    //         END ELSE BEGIN
    //             WITH SalesInvoiceHeader DO BEGIN
    //                 IF Cust.GET("Sell-to Customer No.") THEN;
    //                 Gstin := Cust."GST Registration No.";
    //                 ShipTrdNm := "Ship-to Name";
    //                 ShipBno := "Ship-to Address";
    //                 ShipBnm := "Ship-to Address 2";
    //                 ShipDst := "Ship-to City";
    //                 ShipPin := COPYSTR("Ship-to Post Code", 1, 6);
    //                 IF StateBuff.GET(Cust."State Code") THEN
    //                     ShipStcd := StateBuff."State Code (GST Reg. No.)";
    //                 ShipPh := COPYSTR(ShipToAddr."Phone No.", 1, 10);
    //                 ShipEmail := COPYSTR(ShipToAddr."E-Mail", 1, 50);
    //             END;
    //         END;


    //         GSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //         GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //         IF GSTLedgerEntry.FINDSET THEN BEGIN
    //             REPEAT
    //                 CGSTvalue1 += ABS(GSTLedgerEntry."GST Amount");
    //             UNTIL GSTLedgerEntry.NEXT = 0;
    //         END ELSE
    //             CGSTvalue1 := 0;

    //         GSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //         GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //         IF GSTLedgerEntry.FINDSET THEN BEGIN
    //             REPEAT
    //                 SGSTvalue1 += ABS(GSTLedgerEntry."GST Amount")
    //             UNTIL GSTLedgerEntry.NEXT = 0;
    //         END ELSE
    //             SGSTvalue1 := 0;

    //         GSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //         GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //         IF GSTLedgerEntry.FINDSET THEN BEGIN
    //             REPEAT
    //                 IGSTvalue1 += ABS(GSTLedgerEntry."GST Amount")
    //             UNTIL GSTLedgerEntry.NEXT = 0;
    //         END ELSE
    //             IGSTvalue1 := 0;

    //         StateCessValue := 0;
    //         GSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //         GSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //         IF GSTLedgerEntry.FINDSET THEN
    //             REPEAT
    //                 StateCessValue += ABS(GSTLedgerEntry."GST Amount")
    //             UNTIL GSTLedgerEntry.NEXT = 0;

    //         DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //         DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //         IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //             REPEAT
    //                 IF DetailedGSTLedgerEntry."GST %" > 0 THEN
    //                     cessValue += ABS(DetailedGSTLedgerEntry."GST Amount")
    //             UNTIL GSTLedgerEntry.NEXT = 0;

    //         GSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //         GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
    //         IF GSTLedgerEntry.FINDSET THEN BEGIN
    //             REPEAT
    //                 IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
    //                     StCesVal += ABS(GSTLedgerEntry."GST Amount");
    //             UNTIL GSTLedgerEntry.NEXT = 0;
    //         END;
    //         AssVal := 0;
    //         TotGSTAmt := 0;
    //         Disc := 0;
    //         OtherCrg := 0;
    //         SalesInvoiceHeader.CALCFIELDS(SalesInvoiceHeader."Amount to Customer");
    //         SalesInvoiceLine.RESET;
    //         SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //         IF SalesInvoiceLine.FINDSET THEN BEGIN
    //             REPEAT
    //                 IF SalesInvoiceHeader."Currency Factor" <> 0 THEN BEGIN
    //                     AssVal += SalesInvoiceLine."Line Amount" / SalesInvoiceHeader."Currency Factor";
    //                     TotGSTAmt += SalesInvoiceLine."Total GST Amount" / SalesInvoiceHeader."Currency Factor";
    //                     Disc += SalesInvoiceLine."Inv. Discount Amount" / SalesInvoiceHeader."Currency Factor";
    //                     OtherCrg += SalesInvoiceLine."Charges To Customer" / SalesInvoiceHeader."Currency Factor";
    //                 END ELSE BEGIN
    //                     AssVal += SalesInvoiceLine."Line Amount";
    //                     TotGSTAmt += SalesInvoiceLine."Total GST Amount";
    //                     Disc += SalesInvoiceLine."Inv. Discount Amount";
    //                     OtherCrg += SalesInvoiceLine."Charges To Customer";

    //                 END;
    //             UNTIL SalesInvoiceLine.NEXT = 0;
    //         END;

    //         AssVal := ROUND(
    //             CurrExchRate.ExchangeAmtFCYToLCY(
    //               WORKDATE, SalesInvoiceHeader."Currency Code", AssVal, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
    //         TotGSTAmt := ROUND(
    //             CurrExchRate.ExchangeAmtFCYToLCY(
    //               WORKDATE, SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
    //         Disc := ROUND(
    //             CurrExchRate.ExchangeAmtFCYToLCY(
    //               WORKDATE, SalesInvoiceHeader."Currency Code", Disc, SalesInvoiceHeader."Currency Factor"), 0.01, '=');



    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSon('userGstin', SupplierGSTINNo);
    //         JSonMgt.AddToJSonRaw('pobCode', 'null');
    //         JSonMgt.AddToJSon('supplyType', 'O');
    //         IF CheckState(SalesInvoiceHeader."No.") THEN
    //             JSonMgt.AddToJSon('ntr', 'Intra')
    //         ELSE
    //             JSonMgt.AddToJSon('ntr', 'Inter');
    //         IF SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::"Debit Note" THEN
    //             JSonMgt.AddToJSon('docType', 'D')
    //         ELSE
    //             JSonMgt.AddToJSon('docType', 'RI');
    //         JSonMgt.AddToJSon('catg', 'EXWOP');
    //         JSonMgt.AddToJSon('dst', 'O');
    //         IF SalesInvoiceHeader."Ship-to Code" <> '' THEN
    //             JSonMgt.AddToJSon('trnTyp', 'Bill To - Ship To')
    //         ELSE
    //             JSonMgt.AddToJSon('trnTyp', 'REG');
    //         JSonMgt.AddToJSon('no', SalesInvoiceHeader."No.");
    //         JSonMgt.AddToJSon('dt', FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
    //         JSonMgt.AddToJSonRaw('refinum', 'null');
    //         JSonMgt.AddToJSonRaw('refidt', 'null');
    //         IF State2.GET(Cust."State Code") THEN;
    //         JSonMgt.AddToJSon('pos', '96');
    //         JSonMgt.AddToJSonRaw('diffprcnt', 'null');
    //         JSonMgt.AddToJSonRaw('etin', 'null');
    //         JSonMgt.AddToJSon('rchrg', 'N');
    //         JSonMgt.AddToJSon('sgstin', SupplierGSTINNo);
    //         JSonMgt.AddToJSon('strdNm', SupplierName);
    //         JSonMgt.AddToJSon('slglNm', SupplierName);
    //         JSonMgt.AddToJSon('sbnm', SupplierAdd1);
    //         JSonMgt.AddToJSon('sflno', SupplierAdd2);
    //         JSonMgt.AddToJSon('sloc', SupplierCity);
    //         JSonMgt.AddToJSon('sdst', '');
    //         JSonMgt.AddToJSon('sstcd', SupplierStateDesc);//);
    //         JSonMgt.AddToJSon('spin', SupplierPinCode);
    //         JSonMgt.AddToJSon('sph', SupplierPhNo);
    //         JSonMgt.AddToJSon('sem', SupplierEmail);
    //         JSonMgt.AddToJSon('bgstin', 'URP');
    //         JSonMgt.AddToJSon('btrdNm', TrdName);
    //         JSonMgt.AddToJSon('blglNm', TrdName);
    //         JSonMgt.AddToJSon('bbnm', BillAdd1);
    //         IF BillAdd2 <> '' THEN
    //             JSonMgt.AddToJSon('bflno', BillAdd2)
    //         ELSE
    //             JSonMgt.AddToJSon('bflno', 'null');
    //         IF BillCity <> '' THEN
    //             JSonMgt.AddToJSon('bloc', BillCity)
    //         ELSE
    //             JSonMgt.AddToJSon('bloc', RecCust."Country/Region Code");
    //         JSonMgt.AddToJSon('bdst', '');
    //         JSonMgt.AddToJSon('bstcd', '96');
    //         JSonMgt.AddToJSon('bpin', '999999');
    //         IF Ph <> '' THEN
    //             JSonMgt.AddToJSon('bph', Ph)
    //         ELSE
    //             JSonMgt.AddToJSonRaw('bph', 'null');
    //         IF Em <> '' THEN
    //             JSonMgt.AddToJSon('bem', Em)
    //         ELSE
    //             JSonMgt.AddToJSonRaw('bem', 'null');
    //         JSonMgt.AddToJSonRaw('dgstin', 'null');
    //         JSonMgt.AddToJSonRaw('dtrdNm', 'null');
    //         JSonMgt.AddToJSonRaw('dlglNm', 'null');
    //         JSonMgt.AddToJSonRaw('dbnm', 'null');
    //         JSonMgt.AddToJSonRaw('dflno', 'null');
    //         JSonMgt.AddToJSonRaw('dloc', 'null');
    //         JSonMgt.AddToJSonRaw('ddst', 'null');
    //         JSonMgt.AddToJSonRaw('dstcd', 'null');
    //         JSonMgt.AddToJSonRaw('dpin', 'null');
    //         JSonMgt.AddToJSonRaw('dph', 'null');
    //         JSonMgt.AddToJSonRaw('dem', 'null');
    //         /*
    //         IF SalesInvoiceHeader."GST Customer Type"= SalesInvoiceHeader."GST Customer Type"::Registered THEN BEGIN
    //         IF SalesInvoiceHeader."Ship-to Code" ='' THEN BEGIN
    //         JSonMgt.AddToJSonRaw('togstin','null');
    //         JSonMgt.AddToJSonRaw('totrdNm','null');
    //         JSonMgt.AddToJSonRaw('tolglNm','null');
    //         JSonMgt.AddToJSonRaw('tobnm','null');
    //         JSonMgt.AddToJSonRaw('toflno','null');
    //         JSonMgt.AddToJSonRaw('toloc','null');
    //         JSonMgt.AddToJSonRaw('todst','null');
    //         JSonMgt.AddToJSonRaw('tostcd','null');
    //         JSonMgt.AddToJSonRaw('topin','null');
    //         IF ShipPh <>'' THEN
    //         JSonMgt.AddToJSonRaw('toph','null')
    //         ELSE
    //         JSonMgt.AddToJSonRaw('toph','null');
    //         IF ShipEmail <>'' THEN
    //         JSonMgt.AddToJSonRaw('toem','null')
    //         ELSE
    //         JSonMgt.AddToJSonRaw('toem','null');
    //         END ELSE BEGIN
    //         IF Cust.GET(SalesInvoiceHeader."Sell-to Customer No.")THEN;
    //         IF SalesInvoiceHeader."Ship-to Code" ='' THEN
    //         JSonMgt.AddToJSon('togstin','null')
    //         ELSE
    //         JSonMgt.AddToJSon('togstin',Cust."GST Registration No.");
    //         JSonMgt.AddToJSon('totrdNm',ShipTrdNm);
    //         JSonMgt.AddToJSon('tolglNm',ShipTrdNm);
    //         JSonMgt.AddToJSon('tobnm',ShipBno);
    //         IF ShipBnm <>'' THEN
    //         JSonMgt.AddToJSon('toflno',ShipBnm)
    //         ELSE
    //         JSonMgt.AddToJSon('toflno','null');
    //         JSonMgt.AddToJSon('toloc',ShipDst);
    //         JSonMgt.AddToJSon('todst',ShipDst);
    //         JSonMgt.AddToJSon('tostcd',ShipStcd);
    //         JSonMgt.AddToJSon('topin',ShipPin);
    //         IF ShipPh <>'' THEN
    //         JSonMgt.AddToJSon('toph',ShipPh)
    //         ELSE
    //         JSonMgt.AddToJSonRaw('toph','null');
    //         IF ShipEmail <>'' THEN
    //         JSonMgt.AddToJSon('toem',ShipEmail)
    //         ELSE
    //         JSonMgt.AddToJSonRaw('toem','null');
    //         END;
    //         JSonMgt.AddToJSonRaw('sbnum','null');
    //         JSonMgt.AddToJSonRaw('sbdt','null');
    //         JSonMgt.AddToJSonRaw('port','null');
    //         JSonMgt.AddToJSonRaw('expduty',0);
    //         JSonMgt.AddToJSonRaw('cntcd','null');
    //         JSonMgt.AddToJSonRaw('forCur','null');
    //         JSonMgt.AddToJSonRaw('invForCur','null');
    //         JSonMgt.AddToJSon('taxSch','GST');
    //         */
    //         //END ELSE BEGIN
    //         JSonMgt.AddToJSonRaw('togstin', 'null');
    //         JSonMgt.AddToJSonRaw('totrdNm', 'null');
    //         JSonMgt.AddToJSonRaw('tolglNm', 'null');
    //         JSonMgt.AddToJSonRaw('tobnm', 'null');
    //         JSonMgt.AddToJSonRaw('toflno', 'null');
    //         JSonMgt.AddToJSonRaw('toloc', 'null');
    //         JSonMgt.AddToJSonRaw('todst', 'null');
    //         JSonMgt.AddToJSonRaw('tostcd', 'null');
    //         JSonMgt.AddToJSonRaw('topin', 'null');
    //         JSonMgt.AddToJSonRaw('toph', 'null');
    //         JSonMgt.AddToJSonRaw('toem', 'null');
    //         JSonMgt.AddToJSonRaw('sbnum', 'null');
    //         JSonMgt.AddToJSonRaw('sbdt', 'null');
    //         JSonMgt.AddToJSonRaw('port', 'null');
    //         JSonMgt.AddToJSonRaw('expduty', 0);
    //         JSonMgt.AddToJSonRaw('cntcd', 'null');
    //         JSonMgt.AddToJSonRaw('forCur', 'null');
    //         JSonMgt.AddToJSonRaw('invForCur', '0');
    //         JSonMgt.AddToJSon('taxSch', 'GST');
    //         //END;
    //         IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
    //             JSonMgt.AddToJSonRaw('totinvval', ROUND(SalesInvoiceHeader."Amount to Customer" / SalesInvoiceHeader."Currency Factor", 0.01))
    //         ELSE
    //             JSonMgt.AddToJSonRaw('totinvval', SalesInvoiceHeader."Amount to Customer");
    //         JSonMgt.AddToJSonRaw('totdisc', Disc);
    //         JSonMgt.AddToJSonRaw('totfrt', 'null');
    //         JSonMgt.AddToJSonRaw('totins', 'null');
    //         JSonMgt.AddToJSonRaw('totpkg', 'null');
    //         JSonMgt.AddToJSonRaw('totothchrg', CalcTCSAmt(SalesInvoiceHeader."No."));
    //         IF SalesInvHeader."Currency Factor" <> 0 THEN
    //             JSonMgt.AddToJSonRaw('tottxval', AssVal / SalesInvHeader."Currency Factor")
    //         ELSE
    //             JSonMgt.AddToJSonRaw('tottxval', AssVal);
    //         JSonMgt.AddToJSonRaw('totiamt', IGSTvalue1);
    //         JSonMgt.AddToJSonRaw('totcamt', CGSTvalue1);
    //         JSonMgt.AddToJSonRaw('totsamt', SGSTvalue1);
    //         JSonMgt.AddToJSonRaw('totcsamt', cessValue);
    //         JSonMgt.AddToJSonRaw('totstcsamt', StateCessValue);
    //         JSonMgt.AddToJSonRaw('rndOffAmt', '0');
    //         JSonMgt.AddToJSon('sec7act', 'N');
    //         JSonMgt.AddToJSonRaw('invStDt', 'null');
    //         JSonMgt.AddToJSonRaw('invEndDt', 'null');
    //         JSonMgt.AddToJSonRaw('invRmk', 'null');
    //         JSonMgt.AddToJSonRaw('omon', 'null');
    //         JSonMgt.AddToJSonRaw('odty', 'null');
    //         JSonMgt.AddToJSonRaw('oinvtyp', 'null');
    //         JSonMgt.AddToJSonRaw('octin', 'null');
    //         JSonMgt.AddToJSonRaw('userIRN', 'null');
    //         JSonMgt.AddToJSonRaw('payNm', 'null');
    //         JSonMgt.AddToJSonRaw('acctdet', 'null');
    //         JSonMgt.AddToJSonRaw('mode', 'null');
    //         JSonMgt.AddToJSonRaw('ifsc', 'null');
    //         JSonMgt.AddToJSonRaw('payTerm', 'null');
    //         JSonMgt.AddToJSonRaw('payInstr', 'null');
    //         JSonMgt.AddToJSonRaw('crTrn', 'null');
    //         JSonMgt.AddToJSonRaw('dirDr', 'null');
    //         JSonMgt.AddToJSonRaw('crDay', 'null');
    //         JSonMgt.AddToJSonRaw('balAmt', 'null');
    //         JSonMgt.AddToJSonRaw('paidAmt', 'null');
    //         JSonMgt.AddToJSonRaw('payDueDt', 'null');
    //         JSonMgt.AddToJSonRaw('transId', 'null');
    //         JSonMgt.AddToJSon('subSplyTyp', 'Supply');
    //         JSonMgt.AddToJSonRaw('subSplyDes', 'null');
    //         JSonMgt.AddToJSonRaw('kdrefinum', 'null');
    //         JSonMgt.AddToJSonRaw('kdrefidt', 'null');
    //         JSonMgt.AddToJSonRaw('transMode', 'null');
    //         JSonMgt.AddToJSonRaw('vehTyp', 'null');
    //         JSonMgt.AddToJSonRaw('transDist', 'null');
    //         JSonMgt.AddToJSonRaw('transName', 'null');
    //         JSonMgt.AddToJSonRaw('transDocNo', 'null');
    //         JSonMgt.AddToJSonRaw('transdocdate', 'null');
    //         JSonMgt.AddToJSonRaw('vehNo', 'null');
    //         JSonMgt.AddToJSonRaw('clmrfnd', 'null');
    //         JSonMgt.AddToJSonRaw('rfndelg', 'null');
    //         JSonMgt.AddToJSonRaw('boef', 'null');
    //         JSonMgt.AddToJSonRaw('fy', 'null');
    //         JSonMgt.AddToJSonRaw('refnum', 'null');
    //         JSonMgt.AddToJSonRaw('pdt', 'null');
    //         JSonMgt.AddToJSonRaw('ivst', 'null');
    //         JSonMgt.AddToJSonRaw('cptycde', 'null');
    //         JSonMgt.AddToJSon('gen1', 'abcd');
    //         JSonMgt.AddToJSon('gen2', 'abcd');
    //         JSonMgt.AddToJSon('gen3', 'abcd');
    //         JSonMgt.AddToJSon('gen4', 'abcd');
    //         JSonMgt.AddToJSon('gen5', 'abcd');
    //         JSonMgt.AddToJSon('gen6', 'abcd');
    //         JSonMgt.AddToJSon('gen7', 'abcd');
    //         JSonMgt.AddToJSon('gen8', 'abcd');
    //         JSonMgt.AddToJSon('gen9', 'abcd');
    //         JSonMgt.AddToJSon('gen10', 'abcd');
    //         JSonMgt.AddToJSon('gen11', 'abcd');
    //         JSonMgt.AddToJSon('gen12', 'abcd');
    //         JSonMgt.AddToJSon('gen13', 'abcd');
    //         JSonMgt.AddToJSon('gen14', 'abcd');
    //         JSonMgt.AddToJSon('gen15', 'abcd');
    //         JSonMgt.AddToJSon('gen16', 'abcd');
    //         JSonMgt.AddToJSon('gen17', 'abcd');
    //         JSonMgt.AddToJSon('gen18', 'abcd');
    //         JSonMgt.AddToJSon('gen19', 'abcd');
    //         JSonMgt.AddToJSon('gen20', 'abcd');
    //         JSonMgt.AddToJSon('gen21', 'abcd');
    //         JSonMgt.AddToJSon('gen22', 'abcd');
    //         JSonMgt.AddToJSon('gen23', 'abcd');
    //         JSonMgt.AddToJSon('gen24', 'abcd');
    //         JSonMgt.AddToJSon('gen25', 'abcd');
    //         JSonMgt.AddToJSon('gen26', 'abcd');
    //         JSonMgt.AddToJSon('gen27', 'abcd');
    //         JSonMgt.AddToJSon('gen28', 'abcd');
    //         JSonMgt.AddToJSon('gen29', 'abcd');
    //         JSonMgt.AddToJSon('gen30', 'abcd');
    //         JSonMgt.AddToJSon('pobewb', 'null');
    //         JSonMgt.AddToJSon('Pobret', 'null');
    //         JSonMgt.AddToJSon('tcsrt', 'null');
    //         JSonMgt.AddToJSon('tcsamt', '0');
    //         JSonMgt.AddToJSon('pretcs', '0');
    //         JSonMgt.AddToJSon('genIrn', 'true');
    //         JSonMgt.AddToJSon('genewb', 'N');
    //         JSonMgt.AddToJSon('signedDataReq', 'true');

    //         SalesInvLine.RESET;
    //         SalesInvLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //         SalesInvLine.SETFILTER(Quantity, '<>%1', 0);
    //         SalesInvLine.SETFILTER("No.", '<>%1', '708030');
    //         IF SalesInvLine.FINDFIRST THEN BEGIN
    //             JSonMgt.StartJsonArray2('itemList');
    //             REPEAT
    //                 Sr += 1;
    //                 SIL2.RESET;
    //                 SIL2.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 SIL2.SETRANGE(SIL2.Type, SIL2.Type::Item);
    //                 IF SIL2.FINDFIRST THEN
    //                     DescText := SIL2.Description;

    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //                 IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                     CGSTRate := DetailedGSTLedgerEntry."GST %";
    //                     CGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                 END ELSE BEGIN
    //                     CGSTRate := 0;
    //                     CGSTLineAmt := 0;
    //                 END;

    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //                 IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                     SGSTRate := DetailedGSTLedgerEntry."GST %";
    //                     SGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                 END ELSE BEGIN
    //                     SGSTRate := 0;
    //                     SGSTLineAmt := 0;
    //                 END;
    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //                 IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
    //                     IGSTRate := DetailedGSTLedgerEntry."GST %";
    //                     IGSTLineAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
    //                 END
    //                 ELSE BEGIN
    //                     IGSTRate := 0;
    //                     IGSTLineAmt := 0;
    //                 END;

    //                 CesRt := 0;
    //                 CesNonAdval := 0;
    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //                 IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //                     IF DetailedGSTLedgerEntry."GST %" > 0 THEN
    //                         CesRt := DetailedGSTLedgerEntry."GST %"
    //                     ELSE
    //                         CesNonAdval := ABS(DetailedGSTLedgerEntry."GST Amount");

    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //                 IF DetailedGSTLedgerEntry.FINDFIRST THEN
    //                     CesRt := DetailedGSTLedgerEntry."GST %";

    //                 StateCes := 0;
    //                 DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvLine."Line No.");
    //                 DetailedGSTLedgerEntry.SETRANGE("GST Component Code");
    //                 IF DetailedGSTLedgerEntry.FINDSET THEN
    //                     REPEAT
    //                         IF NOT (DetailedGSTLedgerEntry."GST Component Code" IN ['CGST', 'SGST', 'IGST', 'CESS', 'INTERCESS'])
    //                         THEN
    //                             IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN
    //                                 StateCes := DetailedGSTLedgerEntry."GST %";
    //                     UNTIL DetailedGSTLedgerEntry.NEXT = 0;

    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
    //                 IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                     REPEAT
    //                         CGSTAmt += ABS(GSTLedgerEntry."GST Amount");
    //                     UNTIL GSTLedgerEntry.NEXT = 0;
    //                 END ELSE
    //                     CGSTAmt := 0;

    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
    //                 IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                     REPEAT
    //                         SGSTAmt += ABS(GSTLedgerEntry."GST Amount")
    //                     UNTIL GSTLedgerEntry.NEXT = 0;
    //                 END ELSE
    //                     SGSTAmt := 0;
    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
    //                 IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                     REPEAT
    //                         IGSTAmt += ABS(GSTLedgerEntry."GST Amount")
    //                     UNTIL GSTLedgerEntry.NEXT = 0;
    //                 END ELSE
    //                     IGSTAmt := 0;

    //                 CesAmt := 0;
    //                 CesNonAdAmt := 0;
    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
    //                 IF GSTLedgerEntry.FINDSET THEN
    //                     REPEAT
    //                         CesAmt += ABS(GSTLedgerEntry."GST Amount")
    //                     UNTIL GSTLedgerEntry.NEXT = 0;

    //                 //DetailedGSTLedgerEntry.SETRANGE("Document No.",SalesInvLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 GSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
    //                 IF GSTLedgerEntry.FINDFIRST THEN
    //                     REPEAT
    //                         CesAmt += ABS(GSTLedgerEntry."GST Amount");
    //                     UNTIL GSTLedgerEntry.NEXT = 0;

    //                 GSTLedgerEntry.SETRANGE("Document No.", SalesInvLine."Document No.");
    //                 GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
    //                 IF GSTLedgerEntry.FINDSET THEN BEGIN
    //                     REPEAT
    //                         IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
    //                             StCesAmt += ABS(GSTLedgerEntry."GST Amount");
    //                     UNTIL GSTLedgerEntry.NEXT = 0;
    //                 END;
    //                 AssValAmt := 0;
    //                 TotalGSTAmt := 0;
    //                 Disc := 0;
    //                 SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //                 IF SalesInvoiceLine.FINDSET THEN BEGIN
    //                     REPEAT
    //                         AssValAmt += SalesInvoiceLine."GST Base Amount";
    //                         TotalGSTAmt += SalesInvoiceLine."Total GST Amount";
    //                         Disc += SalesInvoiceLine."Inv. Discount Amount";
    //                     UNTIL SalesInvoiceLine.NEXT = 0;
    //                 END;

    //                 AssValAmt := ROUND(
    //                     CurrExchRate.ExchangeAmtFCYToLCY(
    //                       WORKDATE, SalesInvoiceHeader."Currency Code", AssVal, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
    //                 TotalGSTAmt := ROUND(
    //                     CurrExchRate.ExchangeAmtFCYToLCY(
    //                       WORKDATE, SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');

    //                 Disc := ROUND(
    //                     CurrExchRate.ExchangeAmtFCYToLCY(
    //                       WORKDATE, SalesInvoiceHeader."Currency Code", Disc, SalesInvoiceHeader."Currency Factor"), 0.01, '=');

    //                 JSonMgt.StartJSon;
    //                 JSonMgt.AddToJSonRaw('barcode', 'null');
    //                 JSonMgt.AddToJSonRaw('bchExpDt', 'null');
    //                 JSonMgt.AddToJSonRaw('bchWrDt', 'null');
    //                 JSonMgt.AddToJSonRaw('bchnm', 'null');
    //                 IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
    //                     JSonMgt.AddToJSonRaw('camt', ROUND(CGSTLineAmt / SalesInvoiceHeader."Currency Factor", 0.01))
    //                 ELSE
    //                     JSonMgt.AddToJSonRaw('camt', CGSTLineAmt);
    //                 JSonMgt.AddToJSonRaw('cesNonAdval', '0');
    //                 JSonMgt.AddToJSonRaw('stCesNonAdvl', '0');
    //                 JSonMgt.AddToJSonRaw('crt', CGSTRate);
    //                 JSonMgt.AddToJSonRaw('csamt', '0');
    //                 JSonMgt.AddToJSonRaw('csrt', '0');
    //                 JSonMgt.AddToJSonRaw('disc', '0');
    //                 JSonMgt.AddToJSonRaw('freeQty', '0');
    //                 JSonMgt.AddToJSon('hsnCd', SalesInvLine."HSN/SAC Code");
    //                 IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
    //                     JSonMgt.AddToJSonRaw('iamt', ROUND(IGSTLineAmt / SalesInvoiceHeader."Currency Factor", 0.01))
    //                 ELSE
    //                     JSonMgt.AddToJSonRaw('iamt', IGSTLineAmt);
    //                 JSonMgt.AddToJSonRaw('irt', IGSTRate);
    //                 JSonMgt.AddToJSonRaw('isServc', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen1', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen2', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen3', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen4', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen5', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen6', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen7', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen8', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen9', 'null');
    //                 JSonMgt.AddToJSonRaw('itmgen10', 'null');
    //                 IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
    //                     JSonMgt.AddToJSonRaw('itmVal', ROUND((SalesInvLine."Line Amount" + SalesInvLine."Total GST Amount") / SalesInvoiceHeader."Currency Factor", 0.01))
    //                 ELSE
    //                     JSonMgt.AddToJSonRaw('itmVal', SalesInvLine."Line Amount" + SalesInvLine."Total GST Amount");
    //                 //Sr+=1;
    //                 JSonMgt.AddToJSon('num', Sr);
    //                 JSonMgt.AddToJSonRaw('ordLineRef', 'null');
    //                 JSonMgt.AddToJSonRaw('orgCntry', 'null');
    //                 JSonMgt.AddToJSonRaw('othchrg', 'null');
    //                 JSonMgt.AddToJSon('prdDesc', SalesInvLine.Description);
    //                 JSonMgt.AddToJSon('prdSlNo', 'null');
    //                 JSonMgt.AddToJSonRaw('preTaxVal', '0');
    //                 JSonMgt.AddToJSonRaw('qty', SalesInvLine.Quantity);
    //                 JSonMgt.AddToJSonRaw('rt', '0');
    //                 IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
    //                     JSonMgt.AddToJSonRaw('samt', ROUND(SGSTLineAmt / SalesInvoiceHeader."Currency Factor", 0.01))
    //                 ELSE
    //                     JSonMgt.AddToJSonRaw('samt', SGSTLineAmt);
    //                 JSonMgt.AddToJSonRaw('srt', SGSTRate);

    //                 JSonMgt.AddToJSonRaw('stcsamt', '0');
    //                 JSonMgt.AddToJSonRaw('stcsrt', '0');
    //                 IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
    //                     JSonMgt.AddToJSonRaw('sval', ROUND(SalesInvLine."Line Amount" / SalesInvoiceHeader."Currency Factor", 0.01))
    //                 ELSE
    //                     JSonMgt.AddToJSonRaw('sval', SalesInvLine."Line Amount");
    //                 JSonMgt.AddToJSonRaw('txp', 'null');
    //                 IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
    //                     JSonMgt.AddToJSonRaw('txval', ROUND(SalesInvLine."Line Amount" / SalesInvoiceHeader."Currency Factor", 0.01))
    //                 ELSE
    //                     JSonMgt.AddToJSonRaw('txval', SalesInvLine."Line Amount");
    //                 IF SalesInvLine.Type = SalesInvLine.Type::Item THEN BEGIN
    //                     IF SalesInvLine."Unit of Measure Code" = 'MT' THEN
    //                         JSonMgt.AddToJSon('unit', 'MTS')
    //                     ELSE
    //                         JSonMgt.AddToJSon('unit', SalesInvLine."Unit of Measure Code");
    //                 END ELSE BEGIN
    //                     JSonMgt.AddToJSon('unit', 'OTH');
    //                 END;
    //                 JSonMgt.AddToJSonRaw('unitPrice', SalesInvLine."Unit Price");
    //                 JSonMgt.EndJSon;
    //             UNTIL SalesInvLine.NEXT = 0;
    //         END;
    //         JSonMgt.EndJSonArray;


    //         JSonMgt.StartJsonArray2('invItmOtherDtls');
    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSon('attNm', 'null');
    //         JSonMgt.AddToJSon('attVal', 'null');
    //         JSonMgt.EndJSon;
    //         JSonMgt.EndJSonArray;

    //         JSonMgt.StartJsonArray2('invOthDocDtls');
    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSon('url', 'null');
    //         JSonMgt.AddToJSon('docs', 'null');
    //         JSonMgt.AddToJSon('infoDtls', 'null');
    //         JSonMgt.EndJSon;
    //         JSonMgt.EndJSonArray;

    //         JSonMgt.StartJsonArray2('invRefPreDtls');
    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSonRaw('oinum', 'null');
    //         JSonMgt.AddToJSonRaw('oidt', 'null');
    //         JSonMgt.AddToJSonRaw('othRefNo', 'null');
    //         JSonMgt.EndJSon;
    //         JSonMgt.EndJSonArray;

    //         JSonMgt.StartJsonArray2('invRefContDtls');
    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSonRaw('raref', 'null');
    //         JSonMgt.AddToJSonRaw('radt', 'null');
    //         JSonMgt.AddToJSonRaw('tendref', 'null');
    //         JSonMgt.AddToJSonRaw('contref', 'null');
    //         JSonMgt.AddToJSonRaw('extref', 'null');
    //         JSonMgt.AddToJSonRaw('projref', 'null');
    //         JSonMgt.AddToJSonRaw('poref', 'null');
    //         JSonMgt.AddToJSonRaw('porefdt', 'null');
    //         JSonMgt.EndJSon;
    //         JSonMgt.EndJSonArray;
    //         JSonMgt.EndJSon;
    //         String := String.Copy(JSonMgt.GetJSon);
    //         MESSAGE('%1', String);
    //         E_InvoiceSetup.GET;
    //         JSonMgt.UploadJSon(E_InvoiceSetup."e-Invoice URL", String, 'POST');  // BLOCK BY SHAKTI
    //         MESSAGE('%1', String);

    //     end;

    //     [Scope('Internal')]
    //     procedure CancelE_Invoice(SalesInvoiceHeader: Record "112")
    //     var
    //         lCustCreated: Boolean;
    //         lStrPos: Integer;
    //         lFirstName: Text[50];
    //         lLastName: Text[50];
    //         intYear: Integer;
    //         intMonth: Integer;
    //         intDay: Integer;
    //         DateValue: Date;
    //         DateText: Text;
    //         RecLocation: Record "14";
    //     begin
    //         E_InvoiceSetup.GET;
    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSon('irn', SalesInvoiceHeader."IRN Hash2");
    //         JSonMgt.AddToJSon('cnlRsn', '1');
    //         JSonMgt.AddToJSon('cnlRem', 'Wrong entry');
    //         IF RecLocation.GET(SalesInvoiceHeader."Location Code") THEN
    //             JSonMgt.AddToJSon('userGstin', RecLocation."GST Registration No.");
    //         JSonMgt.EndJSon;
    //         String := String.Copy(JSonMgt.GetJSon);
    //         JSonMgt.UploadJSon(E_InvoiceSetup."e_Invoice Cancelled URL", String, 'PUT');
    //         MESSAGE('%1', String);
    //         SalesInvoiceHeader."Canceled By" := USERID;
    //         SalesInvoiceHeader.Canceled := TRUE;
    //         IF JSonMgt.ReadFirstJSonValue(String, 'cancelDate') <> '' THEN BEGIN
    //             EVALUATE(intYear, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'cancelDate'), 1, 4));
    //             EVALUATE(intMonth, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'cancelDate'), 6, 2));
    //             EVALUATE(intDay, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'cancelDate'), 9, 2));
    //             DateValue := DMY2DATE(intDay, intMonth, intYear);
    //             DateText := FORMAT(DateValue) + ' ' + FORMAT(TIME);
    //             EVALUATE(SalesInvoiceHeader."E-Inv. Cancelled Date2", DateText);
    //             SalesInvoiceHeader.MODIFY;
    //         END;
    //     end;

    //     [Scope('Internal')]
    //     procedure CancelCreditMemoE_Invoice(SaleCrMemoHeader: Record "114")
    //     var
    //         lCustCreated: Boolean;
    //         lStrPos: Integer;
    //         lFirstName: Text[50];
    //         lLastName: Text[50];
    //         intYear: Integer;
    //         intMonth: Integer;
    //         intDay: Integer;
    //         DateValue: Date;
    //         DateText: Text;
    //         RecLocation: Record "14";
    //     begin
    //         E_InvoiceSetup.GET;
    //         JSonMgt.StartJSon;
    //         JSonMgt.AddToJSon('irn', SaleCrMemoHeader."IRN Hash2");
    //         JSonMgt.AddToJSon('cnlRsn', '1');
    //         JSonMgt.AddToJSon('cnlRem', 'Wrong entry');
    //         IF RecLocation.GET(SaleCrMemoHeader."Location Code") THEN
    //             JSonMgt.AddToJSon('userGstin', RecLocation."GST Registration No.");
    //         JSonMgt.EndJSon;
    //         String := String.Copy(JSonMgt.GetJSon);
    //         JSonMgt.UploadJSon(E_InvoiceSetup."e_Invoice Cancelled URL", String, 'PUT');
    //         MESSAGE('%1', String);
    //         //SaleCrMemoHeader."Canceled By" := USERID;
    //         SaleCrMemoHeader.Canceled := TRUE;
    //         IF JSonMgt.ReadFirstJSonValue(String, 'cancelDate') <> '' THEN BEGIN
    //             EVALUATE(intYear, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'cancelDate'), 1, 4));
    //             EVALUATE(intMonth, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'cancelDate'), 6, 2));
    //             EVALUATE(intDay, COPYSTR(JSonMgt.ReadFirstJSonValue(String, 'cancelDate'), 9, 2));
    //             DateValue := DMY2DATE(intDay, intMonth, intYear);
    //             DateText := FORMAT(DateValue) + ' ' + FORMAT(TIME);
    //             EVALUATE(SaleCrMemoHeader."E-Inv. Cancelled Date2", DateText);
    //             SaleCrMemoHeader.MODIFY;
    //         END;
    //     end;

    //     local procedure "---GetQRCodeInvoice---"()
    //     begin
    //     end;

    //     [Scope('Internal')]
    //     procedure GenrateQRCodeInvoice(SalesInvoiceHeader: Record "112")
    //     var
    //         TempBlob: Record "99008535";
    //         FieldRef: FieldRef;
    //         QRCodeInput: Text;
    //         QRCodeFileName: Text;
    //     begin
    //         QRCodeFileName := MoveToMagicPathInvoice(QRCodeFileName);
    //         CLEAR(TempBlob);
    //         TempBlob.CALCFIELDS(Blob);
    //         FileManagement.BLOBImport(TempBlob, QRCodeFileName);
    //         IF TempBlob.Blob.HASVALUE THEN
    //             SalesInvoiceHeader."QR Code2" := TempBlob.Blob;
    //         SalesInvoiceHeader.MODIFY;

    //         IF NOT ISSERVICETIER THEN
    //             IF EXISTS(QRCodeFileName) THEN
    //                 ERASE(QRCodeFileName);
    //     end;

    //     [Scope('Internal')]
    //     procedure MoveToMagicPathInvoice(SourceFileName: Text) DestinationFileName: Text[1024]
    //     var
    //         FileSystemObject: Automation;
    //     begin
    //         DestinationFileName := COPYSTR(FileManagement.ClientTempFileName(''), 1, 1024);
    //         IF ISCLEAR(FileSystemObject) THEN
    //             CREATE(FileSystemObject, TRUE, TRUE);
    //         FileSystemObject.MoveFile(SourceFileName, DestinationFileName);
    //     end;

    //     local procedure GetQRCodeInvoice(QRCodeInput: Text) QRCodeFileName: Text
    //     var
    //         [RunOnClient]
    //         IBarCodeProvider: DotNet IBarcodeProvider;
    //     begin
    //         GetBarCodeProviderInvoice(IBarCodeProvider);
    //         QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
    //     end;

    //     [Scope('Internal')]
    //     procedure GetBarCodeProviderInvoice(var IBarCodeProvider: DotNet IBarcodeProvider)
    //     var
    //         [RunOnClient]
    //         QRCodeProvider: DotNet QRCodeProvider;
    //     begin
    //         QRCodeProvider := QRCodeProvider.QRCodeProvider;
    //         IBarCodeProvider := QRCodeProvider;
    //     end;

    //     local procedure "---GetQRCodeDebit---"()
    //     begin
    //     end;

    //     [Scope('Internal')]
    //     procedure GenrateQRCodeDebit(SalesCrMemoHeader: Record "114")
    //     var
    //         TempBlob: Record "99008535";
    //         FieldRef: FieldRef;
    //         QRCodeInput: Text;
    //         QRCodeFileName: Text;
    //     begin
    //         QRCodeFileName := MoveToMagicPathDebit(QRCodeFileName);
    //         CLEAR(TempBlob);
    //         TempBlob.CALCFIELDS(Blob);
    //         FileManagement.BLOBImport(TempBlob, QRCodeFileName);
    //         IF TempBlob.Blob.HASVALUE THEN
    //             SalesCrMemoHeader."QR Code2" := TempBlob.Blob;
    //         SalesCrMemoHeader.MODIFY;

    //         IF NOT ISSERVICETIER THEN
    //             IF EXISTS(QRCodeFileName) THEN
    //                 ERASE(QRCodeFileName);
    //     end;

    //     [Scope('Internal')]
    //     procedure MoveToMagicPathDebit(SourceFileName: Text) DestinationFileName: Text[1024]
    //     var
    //         FileSystemObject: Automation;
    //     begin
    //         DestinationFileName := COPYSTR(FileManagement.ClientTempFileName(''), 1, 1024);
    //         IF ISCLEAR(FileSystemObject) THEN
    //             CREATE(FileSystemObject, TRUE, TRUE);
    //         FileSystemObject.MoveFile(SourceFileName, DestinationFileName);
    //     end;

    //     local procedure GetQRCodeDebit(QRCodeInput: Text) QRCodeFileName: Text
    //     var
    //         [RunOnClient]
    //         IBarCodeProvider: DotNet IBarcodeProvider;
    //     begin
    //         GetBarCodeProviderDebit(IBarCodeProvider);
    //         QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
    //     end;

    //     [Scope('Internal')]
    //     procedure GetBarCodeProviderDebit(var IBarCodeProvider: DotNet IBarcodeProvider)
    //     var
    //         [RunOnClient]
    //         QRCodeProvider: DotNet QRCodeProvider;
    //     begin
    //         QRCodeProvider := QRCodeProvider.QRCodeProvider;
    //         IBarCodeProvider := QRCodeProvider;
    //     end;

    //     [Scope('Internal')]
    //     procedure "-----MandatoryFields------"()
    //     begin
    //     end;

    //     [Scope('Internal')]
    //     procedure SalesInvoiceMandatoryFields(SalesInvoiceHeader: Record "112")
    //     var
    //         Cust: Record "18";
    //         ShiptoAddress: Record "222";
    //         SalesInvoiceLine: Record "113";
    //         Loc: Record "14";
    //     begin
    //         IF Loc.GET(SalesInvoiceHeader."Location Code") THEN BEGIN
    //             Loc.TESTFIELD(Address);
    //             Loc.TESTFIELD(City);
    //             Loc.TESTFIELD("Post Code");
    //             Loc.TESTFIELD("Country/Region Code");
    //             Loc.TESTFIELD("E-Mail");
    //             Loc.TESTFIELD("Phone No. 2");
    //         END;

    //         IF SalesInvoiceHeader."Ship-to Code" = '' THEN BEGIN
    //             SalesInvoiceHeader.TESTFIELD("Sell-to Customer No.");
    //             SalesInvoiceHeader.TESTFIELD("Sell-to Customer Name");
    //             SalesInvoiceHeader.TESTFIELD("Sell-to Address");
    //             SalesInvoiceHeader.TESTFIELD("Sell-to City");
    //             SalesInvoiceHeader.TESTFIELD("Sell-to Post Code");
    //             SalesInvoiceHeader.TESTFIELD("Ship-to Post Code");
    //             SalesInvoiceHeader.TESTFIELD("Posting Date");
    //             SalesInvoiceHeader.TESTFIELD("GST Bill-to State Code");
    //             //SalesInvoiceHeader.TESTFIELD("GST Ship-to State Code");
    //             SalesInvoiceHeader.TESTFIELD("Location State Code");
    //             SalesInvoiceHeader.TESTFIELD(State);
    //         END ELSE
    //             IF SalesInvoiceHeader."Ship-to Code" <> '' THEN BEGIN
    //                 IF ShiptoAddress.GET(SalesInvoiceHeader."Sell-to Customer No.", SalesInvoiceHeader."Ship-to Code") THEN BEGIN
    //                     ShiptoAddress.TESTFIELD(City);
    //                     ShiptoAddress.TESTFIELD("Post Code");
    //                     ShiptoAddress.TESTFIELD("E-Mail");
    //                     ShiptoAddress.TESTFIELD(State);
    //                     ShiptoAddress.TESTFIELD("Phone No.");
    //                     IF SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Registered THEN
    //                         ShiptoAddress.TESTFIELD("GST Registration No.");
    //                 END;
    //             END;

    //         IF SalesInvoiceLine.GET(SalesInvoiceHeader."No.") THEN BEGIN
    //             SalesInvoiceLine.TESTFIELD("HSN/SAC Code");
    //             SalesInvoiceLine.TESTFIELD("Total GST Amount");
    //             SalesInvoiceLine.TESTFIELD("GST Group Code");
    //         END;
    //     end;

    //     [Scope('Internal')]
    //     procedure SalesCreditMemoMandatoryFields(SalesCrMemoHeader: Record "114")
    //     var
    //         Cust: Record "18";
    //         ShiptoAddress: Record "222";
    //         SalesInvoiceLine: Record "113";
    //         Loc: Record "14";
    //     begin
    //         IF Loc.GET(SalesCrMemoHeader."Location Code") THEN BEGIN
    //             Loc.TESTFIELD(Address);
    //             Loc.TESTFIELD(City);
    //             Loc.TESTFIELD("Post Code");
    //             Loc.TESTFIELD("Country/Region Code");
    //             Loc.TESTFIELD("E-Mail");
    //             Loc.TESTFIELD("Phone No. 2");
    //         END;

    //         IF SalesCrMemoHeader."Ship-to Code" = '' THEN BEGIN
    //             SalesCrMemoHeader.TESTFIELD("Sell-to Customer No.");
    //             SalesCrMemoHeader.TESTFIELD("Sell-to Customer Name");
    //             SalesCrMemoHeader.TESTFIELD("Sell-to Address");
    //             SalesCrMemoHeader.TESTFIELD("Sell-to City");
    //             SalesCrMemoHeader.TESTFIELD("Sell-to Post Code");
    //             SalesCrMemoHeader.TESTFIELD("Ship-to Post Code");
    //             SalesCrMemoHeader.TESTFIELD("Posting Date");
    //             SalesCrMemoHeader.TESTFIELD("GST Bill-to State Code");
    //             //SalesInvoiceHeader.TESTFIELD("GST Ship-to State Code");
    //             SalesCrMemoHeader.TESTFIELD("Location State Code");
    //             SalesCrMemoHeader.TESTFIELD(State);
    //         END ELSE
    //             IF SalesCrMemoHeader."Ship-to Code" <> '' THEN BEGIN
    //                 IF ShiptoAddress.GET(SalesCrMemoHeader."Sell-to Customer No.", SalesCrMemoHeader."Ship-to Code") THEN BEGIN
    //                     ShiptoAddress.TESTFIELD(City);
    //                     ShiptoAddress.TESTFIELD("Post Code");
    //                     ShiptoAddress.TESTFIELD("E-Mail");
    //                     ShiptoAddress.TESTFIELD(State);
    //                     ShiptoAddress.TESTFIELD("Phone No.");
    //                     IF SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Registered THEN
    //                         ShiptoAddress.TESTFIELD("GST Registration No.");
    //                 END;
    //             END;

    //         IF SalesInvoiceLine.GET(SalesCrMemoHeader."No.") THEN BEGIN
    //             SalesInvoiceLine.TESTFIELD("HSN/SAC Code");
    //             SalesInvoiceLine.TESTFIELD("Total GST Amount");
    //             SalesInvoiceLine.TESTFIELD("GST Group Code");
    //         END;
    //     end;
}

