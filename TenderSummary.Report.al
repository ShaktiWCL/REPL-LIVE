report 50027 "Tender Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TenderSummary.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = WHERE(Number = CONST(1));
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(SalesSetupNoOfTeamMember; SalesSetup."No Of Team Member")
            {
            }
            column(NoOfTender1; ROUND(NoOfTender[1] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfTender2; ROUND(NoOfTender[2] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfTender3; ROUND(NoOfTender[3] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfTender4; ROUND(NoOfTender[4] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfTender5; ROUND(NoOfTender[5] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfTender6; ROUND(NoOfTender[6] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfTender7; ROUND(NoOfTender[7] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfTender8; ROUND(NoOfTender[8] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfTender9; ROUND(NoOfTender[9] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfTender10; ROUND(NoOfTender[10] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfTender11; ROUND(NoOfTender[11] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfTender12; ROUND(NoOfTender[12] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(Fyear1; Fyear1)
            {
            }
            column(TenderValue1; TenderValue[1] / SalesSetup."No Of Team Member")
            {
            }
            column(TenderValue2; TenderValue[2] / SalesSetup."No Of Team Member")
            {
            }
            column(TenderValue3; TenderValue[3] / SalesSetup."No Of Team Member")
            {
            }
            column(TenderValue4; TenderValue[4] / SalesSetup."No Of Team Member")
            {
            }
            column(TenderValue5; TenderValue[5] / SalesSetup."No Of Team Member")
            {
            }
            column(TenderValue6; TenderValue[6] / SalesSetup."No Of Team Member")
            {
            }
            column(TenderValue7; TenderValue[7] / SalesSetup."No Of Team Member")
            {
            }
            column(TenderValue8; TenderValue[8] / SalesSetup."No Of Team Member")
            {
            }
            column(TenderValue9; TenderValue[9] / SalesSetup."No Of Team Member")
            {
            }
            column(TenderValue10; TenderValue[10] / SalesSetup."No Of Team Member")
            {
            }
            column(TenderValue11; TenderValue[11] / SalesSetup."No Of Team Member")
            {
            }
            column(TenderValue12; TenderValue[12] / SalesSetup."No Of Team Member")
            {
            }
            column(BidNoOfTender1; ROUND(BidNoOfTender[1] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidNoOfTender2; ROUND(BidNoOfTender[2] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidNoOfTender3; ROUND(BidNoOfTender[3] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidNoOfTender4; ROUND(BidNoOfTender[4] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidNoOfTender5; ROUND(BidNoOfTender[5] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidNoOfTender6; ROUND(BidNoOfTender[6] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidNoOfTender7; ROUND(BidNoOfTender[7] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidNoOfTender8; ROUND(BidNoOfTender[8] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidNoOfTender9; ROUND(BidNoOfTender[9] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidNoOfTender10; ROUND(BidNoOfTender[10] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidNoOfTender11; ROUND(BidNoOfTender[11] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidNoOfTender12; ROUND(BidNoOfTender[12] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(BidTenderValue1; BidTenderValue[1] / SalesSetup."No Of Team Member")
            {
            }
            column(BidTenderValue2; BidTenderValue[2] / SalesSetup."No Of Team Member")
            {
            }
            column(BidTenderValue3; BidTenderValue[3] / SalesSetup."No Of Team Member")
            {
            }
            column(BidTenderValue4; BidTenderValue[4] / SalesSetup."No Of Team Member")
            {
            }
            column(BidTenderValue5; BidTenderValue[5] / SalesSetup."No Of Team Member")
            {
            }
            column(BidTenderValue6; BidTenderValue[6] / SalesSetup."No Of Team Member")
            {
            }
            column(BidTenderValue7; BidTenderValue[7] / SalesSetup."No Of Team Member")
            {
            }
            column(BidTenderValue8; BidTenderValue[8] / SalesSetup."No Of Team Member")
            {
            }
            column(BidTenderValue9; BidTenderValue[9] / SalesSetup."No Of Team Member")
            {
            }
            column(BidTenderValue10; BidTenderValue[10] / SalesSetup."No Of Team Member")
            {
            }
            column(BidTenderValue11; BidTenderValue[11] / SalesSetup."No Of Team Member")
            {
            }
            column(BidTenderValue12; BidTenderValue[12] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue1; WinTenderValue[1] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue2; WinTenderValue[2] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue3; WinTenderValue[3] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue4; WinTenderValue[4] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue5; WinTenderValue[5] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue6; WinTenderValue[6] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue7; WinTenderValue[7] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue8; WinTenderValue[8] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue9; WinTenderValue[9] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue10; WinTenderValue[10] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue11; WinTenderValue[11] / SalesSetup."No Of Team Member")
            {
            }
            column(WinTenderValue12; WinTenderValue[12] / SalesSetup."No Of Team Member")
            {
            }
            column(MarginPercent1; MarginPercent[1])
            {
            }
            column(MarginPercent2; MarginPercent[2])
            {
            }
            column(MarginPercent3; MarginPercent[3])
            {
            }
            column(MarginPercent4; MarginPercent[4])
            {
            }
            column(MarginPercent5; MarginPercent[5])
            {
            }
            column(MarginPercent6; MarginPercent[6])
            {
            }
            column(MarginPercent7; MarginPercent[7])
            {
            }
            column(MarginPercent8; MarginPercent[8])
            {
            }
            column(MarginPercent9; MarginPercent[9])
            {
            }
            column(MarginPercent10; MarginPercent[10])
            {
            }
            column(MarginPercent11; MarginPercent[11])
            {
            }
            column(MarginPercent12; MarginPercent[12])
            {
            }
            column(CostOfTendering1; CostOfTendering[1])
            {
            }
            column(CostOfTendering2; CostOfTendering[2])
            {
            }
            column(CostOfTendering3; CostOfTendering[3])
            {
            }
            column(CostOfTendering4; CostOfTendering[4])
            {
            }
            column(CostOfTendering5; CostOfTendering[5])
            {
            }
            column(CostOfTendering6; CostOfTendering[6])
            {
            }
            column(CostOfTendering7; CostOfTendering[7])
            {
            }
            column(CostOfTendering8; CostOfTendering[8])
            {
            }
            column(CostOfTendering9; CostOfTendering[9])
            {
            }
            column(CostOfTendering10; CostOfTendering[10])
            {
            }
            column(CostOfTendering11; CostOfTendering[11])
            {
            }
            column(CostOfTendering12; CostOfTendering[12])
            {
            }
            column(NoOfEmpanelment1; ROUND(NoOfEmpanelment[1] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfEmpanelment2; ROUND(NoOfEmpanelment[2] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfEmpanelment3; ROUND(NoOfEmpanelment[3] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(NoOfEmpanelment4; ROUND(NoOfEmpanelment[4] / SalesSetup."No Of Team Member", 1))
            {
            }
            column(TenderDocumentCost1; TenderDocumentCost[1])
            {
            }
            column(TenderDocumentCost2; TenderDocumentCost[2])
            {
            }
            column(TenderDocumentCost3; TenderDocumentCost[3])
            {
            }
            column(TenderDocumentCost4; TenderDocumentCost[4])
            {
            }
            column(TenderDocumentCost5; TenderDocumentCost[5])
            {
            }
            column(TenderDocumentCost6; TenderDocumentCost[6])
            {
            }
            column(TenderDocumentCost7; TenderDocumentCost[7])
            {
            }
            column(TenderDocumentCost8; TenderDocumentCost[8])
            {
            }
            column(TenderDocumentCost9; TenderDocumentCost[9])
            {
            }
            column(TenderDocumentCost10; TenderDocumentCost[10])
            {
            }
            column(TenderDocumentCost11; TenderDocumentCost[11])
            {
            }
            column(TenderDocumentCost12; TenderDocumentCost[12])
            {
            }
            column(EMDOutstanding; EMDOutstanding)
            {
            }
            column(EMDProcess; EMDProcess)
            {
            }
            column(EMDRecovered; EMDRecovered)
            {
            }
            column(EMDOutstanding1; EMDOutstanding1[1])
            {
            }
            column(EMDOutstanding2; EMDOutstanding1[2])
            {
            }
            column(EMDOutstanding3; EMDOutstanding1[3])
            {
            }
            column(EMDOutstanding4; EMDOutstanding1[4])
            {
            }
            column(EMDOutstanding5; EMDOutstanding1[5])
            {
            }
            column(EMDOutstanding6; EMDOutstanding1[6])
            {
            }
            column(EMDOutstanding7; EMDOutstanding1[7])
            {
            }
            column(EMDOutstanding8; EMDOutstanding1[8])
            {
            }
            column(EMDOutstanding9; EMDOutstanding1[9])
            {
            }
            column(EMDOutstanding10; EMDOutstanding1[10])
            {
            }
            column(EMDOutstanding11; EMDOutstanding1[11])
            {
            }
            column(EMDOutstanding12; EMDOutstanding1[12])
            {
            }
            column(EMDProcess1; EMDProcess1[1])
            {
            }
            column(EMDProcess2; EMDProcess1[2])
            {
            }
            column(EMDProcess3; EMDProcess1[3])
            {
            }
            column(EMDProcess4; EMDProcess1[4])
            {
            }
            column(EMDProcess5; EMDProcess1[5])
            {
            }
            column(EMDProcess6; EMDProcess1[6])
            {
            }
            column(EMDProcess7; EMDProcess1[7])
            {
            }
            column(EMDProcess8; EMDProcess1[8])
            {
            }
            column(EMDProcess9; EMDProcess1[9])
            {
            }
            column(EMDProcess10; EMDProcess1[10])
            {
            }
            column(EMDProcess11; EMDProcess1[11])
            {
            }
            column(EMDProcess12; EMDProcess1[12])
            {
            }
            column(EMDRecovered1; EMDRecovered1[1])
            {
            }
            column(EMDRecovered2; EMDRecovered1[2])
            {
            }
            column(EMDRecovered3; EMDRecovered1[3])
            {
            }
            column(EMDRecovered4; EMDRecovered1[4])
            {
            }
            column(EMDRecovered5; EMDRecovered1[5])
            {
            }
            column(EMDRecovered6; EMDRecovered1[6])
            {
            }
            column(EMDRecovered7; EMDRecovered1[7])
            {
            }
            column(EMDRecovered8; EMDRecovered1[8])
            {
            }
            column(EMDRecovered9; EMDRecovered1[9])
            {
            }
            column(EMDRecovered10; EMDRecovered1[10])
            {
            }
            column(EMDRecovered11; EMDRecovered1[11])
            {
            }
            column(EMDRecovered12; EMDRecovered1[12])
            {
            }

            trigger OnAfterGetRecord()
            begin
                SalesSetup.GET;

                CLEAR(NoOfTender);
                CLEAR(TenderValue);
                CLEAR(CostOfTendering);
                CLEAR(TenderDocumentCost);
                Tender.RESET;
                Tender.SETRANGE("Tender Date/Date of Submission", StartDate, EndDate);
                IF Tender.FINDSET THEN
                    REPEAT
                        Month1 := DATE2DMY(Tender."Tender Date/Date of Submission", 2);
                        CASE Month1 OF
                            1:
                                BEGIN
                                    NoOfTender[1] += 1;
                                    TenderValue[1] += Tender."Project Value";
                                    CostOfTendering[1] += Tender."Other Expenses";
                                    TenderDocumentCost[1] += Tender."Tender Cost";
                                END;
                            2:
                                BEGIN
                                    NoOfTender[2] += 1;
                                    TenderValue[2] += Tender."Project Value";
                                    CostOfTendering[2] += Tender."Other Expenses";
                                    TenderDocumentCost[2] += Tender."Tender Cost";
                                END;
                            3:
                                BEGIN
                                    NoOfTender[3] += 1;
                                    TenderValue[3] += Tender."Project Value";
                                    CostOfTendering[3] += Tender."Other Expenses";
                                    TenderDocumentCost[3] += Tender."Tender Cost";
                                END;
                            4:
                                BEGIN
                                    NoOfTender[4] += 1;
                                    TenderValue[4] += Tender."Project Value";
                                    CostOfTendering[4] += Tender."Other Expenses";
                                    TenderDocumentCost[4] += Tender."Tender Cost";
                                END;
                            5:
                                BEGIN
                                    NoOfTender[5] += 1;
                                    TenderValue[5] += Tender."Project Value";
                                    CostOfTendering[5] += Tender."Other Expenses";
                                    TenderDocumentCost[5] += Tender."Tender Cost";
                                END;
                            6:
                                BEGIN
                                    NoOfTender[6] += 1;
                                    TenderValue[6] += Tender."Project Value";
                                    CostOfTendering[6] += Tender."Other Expenses";
                                    TenderDocumentCost[6] += Tender."Tender Cost";
                                END;
                            7:
                                BEGIN
                                    NoOfTender[7] += 1;
                                    TenderValue[7] += Tender."Project Value";
                                    CostOfTendering[7] += Tender."Other Expenses";
                                    TenderDocumentCost[7] += Tender."Tender Cost";
                                END;
                            8:
                                BEGIN
                                    NoOfTender[8] += 1;
                                    TenderValue[8] += Tender."Project Value";
                                    CostOfTendering[8] += Tender."Other Expenses";
                                    TenderDocumentCost[8] += Tender."Tender Cost";
                                END;
                            9:
                                BEGIN
                                    NoOfTender[9] += 1;
                                    TenderValue[9] += Tender."Project Value";
                                    CostOfTendering[9] += Tender."Other Expenses";
                                    TenderDocumentCost[9] += Tender."Tender Cost";
                                END;
                            10:
                                BEGIN
                                    NoOfTender[10] += 1;
                                    TenderValue[10] += Tender."Project Value";
                                    CostOfTendering[10] += Tender."Other Expenses";
                                    TenderDocumentCost[10] += Tender."Tender Cost";
                                END;
                            11:
                                BEGIN
                                    NoOfTender[11] += 1;
                                    TenderValue[11] += Tender."Project Value";
                                    CostOfTendering[11] += Tender."Other Expenses";
                                    TenderDocumentCost[11] += Tender."Tender Cost";
                                END;
                            12:
                                BEGIN
                                    NoOfTender[12] += 1;
                                    TenderValue[12] += Tender."Project Value";
                                    CostOfTendering[12] += Tender."Other Expenses";
                                    TenderDocumentCost[12] += Tender."Tender Cost";
                                END;
                        END;
                    UNTIL Tender.NEXT = 0;

                CLEAR(BidNoOfTender);
                CLEAR(BidTenderValue);
                Tender1.RESET;
                Tender1.SETFILTER("Bid/No Bid", '%1', Tender1."Bid/No Bid"::Bid);
                Tender1.SETRANGE("Tender Date/Date of Submission", StartDate, EndDate);
                IF Tender1.FINDSET THEN
                    REPEAT
                        Month2 := DATE2DMY(Tender1."Tender Date/Date of Submission", 2);
                        CASE Month2 OF
                            1:
                                BEGIN
                                    BidNoOfTender[1] += 1;
                                    BidTenderValue[1] += Tender1."Project Value";
                                END;
                            2:
                                BEGIN
                                    BidNoOfTender[2] += 1;
                                    BidTenderValue[2] += Tender1."Project Value";
                                END;
                            3:
                                BEGIN
                                    BidNoOfTender[3] += 1;
                                    BidTenderValue[3] += Tender1."Project Value";
                                END;
                            4:
                                BEGIN
                                    BidNoOfTender[4] += 1;
                                    BidTenderValue[4] += Tender1."Project Value";
                                END;
                            5:
                                BEGIN
                                    BidNoOfTender[5] += 1;
                                    BidTenderValue[5] += Tender1."Project Value";
                                END;
                            6:
                                BEGIN
                                    BidNoOfTender[6] += 1;
                                    BidTenderValue[6] += Tender1."Project Value";
                                END;
                            7:
                                BEGIN
                                    BidNoOfTender[7] += 1;
                                    BidTenderValue[7] += Tender1."Project Value";
                                END;
                            8:
                                BEGIN
                                    BidNoOfTender[8] += 1;
                                    BidTenderValue[8] += Tender1."Project Value";
                                END;
                            9:
                                BEGIN
                                    BidNoOfTender[9] += 1;
                                    BidTenderValue[9] += Tender1."Project Value";
                                END;
                            10:
                                BEGIN
                                    BidNoOfTender[10] += 1;
                                    BidTenderValue[10] += Tender1."Project Value";
                                END;
                            11:
                                BEGIN
                                    BidNoOfTender[11] += 1;
                                    BidTenderValue[11] += Tender1."Project Value";
                                END;
                            12:
                                BEGIN
                                    BidNoOfTender[12] += 1;
                                    BidTenderValue[12] += Tender1."Project Value";
                                END;
                        END;
                    UNTIL Tender1.NEXT = 0;

                CLEAR(WinTenderValue);
                CLEAR(MarginValue);
                Tender2.RESET;
                Tender2.SETFILTER("Status Of Tender", '%1', Tender2."Status Of Tender"::WON);
                Tender2.SETRANGE("Tender Date/Date of Submission", StartDate, EndDate);
                IF Tender2.FINDSET THEN
                    REPEAT
                        Month3 := DATE2DMY(Tender2."Tender Date/Date of Submission", 2);
                        CASE Month3 OF
                            1:
                                BEGIN
                                    WinTenderValue[1] += Tender2."Project Value";
                                    MarginValue[1] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                            2:
                                BEGIN
                                    WinTenderValue[2] += Tender2."Project Value";
                                    MarginValue[2] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                            3:
                                BEGIN
                                    WinTenderValue[3] += Tender2."Project Value";
                                    MarginValue[3] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                            4:
                                BEGIN
                                    WinTenderValue[4] += Tender2."Project Value";
                                    MarginValue[4] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                            5:
                                BEGIN
                                    WinTenderValue[5] += Tender2."Project Value";
                                    MarginValue[5] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                            6:
                                BEGIN
                                    WinTenderValue[6] += Tender2."Project Value";
                                    MarginValue[6] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                            7:
                                BEGIN
                                    WinTenderValue[7] += Tender2."Project Value";
                                    MarginValue[7] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                            8:
                                BEGIN
                                    WinTenderValue[8] += Tender2."Project Value";
                                    MarginValue[8] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                            9:
                                BEGIN
                                    WinTenderValue[9] += Tender2."Project Value";
                                    MarginValue[9] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                            10:
                                BEGIN
                                    WinTenderValue[10] += Tender2."Project Value";
                                    MarginValue[10] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                            11:
                                BEGIN
                                    WinTenderValue[11] += Tender2."Project Value";
                                    MarginValue[11] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                            12:
                                BEGIN
                                    WinTenderValue[12] += Tender2."Project Value";
                                    MarginValue[12] += (Tender2."Project Value" * Tender2."Expected Margin(%)") / 100;
                                END;
                        END;
                    UNTIL Tender2.NEXT = 0;

                CLEAR(MarginPercent);
                IF WinTenderValue[1] <> 0 THEN
                    MarginPercent[1] := (MarginValue[1] * 100) / WinTenderValue[1];
                IF WinTenderValue[2] <> 0 THEN
                    MarginPercent[2] := (MarginValue[2] * 100) / WinTenderValue[2];
                IF WinTenderValue[3] <> 0 THEN
                    MarginPercent[3] := (MarginValue[3] * 100) / WinTenderValue[3];
                IF WinTenderValue[4] <> 0 THEN
                    MarginPercent[4] := (MarginValue[4] * 100) / WinTenderValue[4];
                IF WinTenderValue[5] <> 0 THEN
                    MarginPercent[5] := (MarginValue[5] * 100) / WinTenderValue[5];
                IF WinTenderValue[6] <> 0 THEN
                    MarginPercent[6] := (MarginValue[6] * 100) / WinTenderValue[6];
                IF WinTenderValue[7] <> 0 THEN
                    MarginPercent[7] := (MarginValue[7] * 100) / WinTenderValue[7];
                IF WinTenderValue[8] <> 0 THEN
                    MarginPercent[8] := (MarginValue[8] * 100) / WinTenderValue[8];
                IF WinTenderValue[9] <> 0 THEN
                    MarginPercent[9] := (MarginValue[9] * 100) / WinTenderValue[9];
                IF WinTenderValue[10] <> 0 THEN
                    MarginPercent[10] := (MarginValue[10] * 100) / WinTenderValue[10];
                IF WinTenderValue[11] <> 0 THEN
                    MarginPercent[11] := (MarginValue[11] * 100) / WinTenderValue[11];
                IF WinTenderValue[12] <> 0 THEN
                    MarginPercent[12] := (MarginValue[12] * 100) / WinTenderValue[12];

                CLEAR(NoOfEmpanelment);
                Empanelment.RESET;
                Empanelment.SETRANGE("Tender Date/Date of Submission", StartDate, EndDate);
                IF Empanelment.FINDSET THEN
                    REPEAT
                        Month4 := DATE2DMY(Empanelment."Tender Date/Date of Submission", 2);
                        CASE Month4 OF
                            1, 2, 3:
                                BEGIN
                                    NoOfEmpanelment[1] += 1;
                                END;
                            4, 5, 6:
                                BEGIN
                                    NoOfEmpanelment[2] += 1;
                                END;
                            7, 8, 9:
                                BEGIN
                                    NoOfEmpanelment[3] += 1;
                                END;
                            10, 11, 12:
                                BEGIN
                                    NoOfEmpanelment[4] += 1;
                                END;
                        END;
                    UNTIL Empanelment.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(CompInfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                }
                group("EMD Entery")
                {
                    Caption = 'EMD Entery';
                    grid(A)
                    {
                        GridLayout = Rows;
                        group(Outstanding)
                        {
                            Caption = 'Outstanding';
                            field(EMDOutstanding14; EMDOutstanding1[4])
                            {
                                Caption = 'APR';
                            }
                            field(EMDOutstanding15; EMDOutstanding1[5])
                            {
                                Caption = 'MAY';
                            }
                            field(EMDOutstanding16; EMDOutstanding1[6])
                            {
                                Caption = 'JUN';
                            }
                            field(EMDOutstanding17; EMDOutstanding1[7])
                            {
                                Caption = 'JUL';
                            }
                            field(EMDOutstanding18; EMDOutstanding1[8])
                            {
                                Caption = 'AUG';
                            }
                            field(EMDOutstanding19; EMDOutstanding1[9])
                            {
                                Caption = 'SEP';
                            }
                            field(EMDOutstanding110; EMDOutstanding1[10])
                            {
                                Caption = 'OCT';
                            }
                            field(EMDOutstanding111; EMDOutstanding1[11])
                            {
                                Caption = 'NOV';
                            }
                            field(EMDOutstanding112; EMDOutstanding1[12])
                            {
                                Caption = 'DEC';
                            }
                            field(EMDOutstanding11; EMDOutstanding1[1])
                            {
                                Caption = 'JAN';
                            }
                            field(EMDOutstanding12; EMDOutstanding1[2])
                            {
                                Caption = 'FEB';
                            }
                            field(EMDOutstanding13; EMDOutstanding1[3])
                            {
                                Caption = 'MAR';
                            }
                        }
                        group(" In Process")
                        {
                            Caption = ' In Process';
                            field(EMDProcess14; EMDProcess1[4])
                            {
                            }
                            field(EMDProcess15; EMDProcess1[5])
                            {
                            }
                            field(EMDProcess16; EMDProcess1[6])
                            {
                            }
                            field(EMDProcess17; EMDProcess1[7])
                            {
                            }
                            field(EMDProcess18; EMDProcess1[8])
                            {
                            }
                            field(EMDProcess19; EMDProcess1[9])
                            {
                            }
                            field(EMDProcess110; EMDProcess1[10])
                            {
                            }
                            field(EMDProcess111; EMDProcess1[11])
                            {
                            }
                            field(EMDProcess112; EMDProcess1[12])
                            {
                            }
                            field(EMDProcess11; EMDProcess1[1])
                            {
                            }
                            field(EMDProcess12; EMDProcess1[2])
                            {
                            }
                            field(EMDProcess13; EMDProcess1[3])
                            {
                            }
                        }
                        group(Recovered)
                        {
                            Caption = 'Recovered';
                            field(EMDRecovered14; EMDRecovered1[4])
                            {
                            }
                            field(EMDRecovered15; EMDRecovered1[5])
                            {
                            }
                            field(EMDRecovered16; EMDRecovered1[6])
                            {
                            }
                            field(EMDRecovered17; EMDRecovered1[7])
                            {
                            }
                            field(EMDRecovered18; EMDRecovered1[8])
                            {
                            }
                            field(EMDRecovered19; EMDRecovered1[9])
                            {
                            }
                            field(EMDRecovered110; EMDRecovered1[10])
                            {
                            }
                            field(EMDRecovered111; EMDRecovered1[11])
                            {
                            }
                            field(EMDRecovered112; EMDRecovered1[12])
                            {
                            }
                            field(EMDRecovered11; EMDRecovered1[1])
                            {
                            }
                            field(EMDRecovered12; EMDRecovered1[2])
                            {
                            }
                            field(EMDRecovered13; EMDRecovered1[3])
                            {
                            }
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            Month := DATE2DMY(TODAY, 2);
            Fyear := DATE2DMY(TODAY, 3);
            IF Month IN [1, 2, 3] THEN
                Fyear1 := Fyear - 1
            ELSE
                Fyear1 := Fyear;

            StartDate := DMY2DATE(1, 4, Fyear1);
            EndDate := TODAY;//DMY2DATE(31,3,Fyear1+1);
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Tender Open" = FALSE THEN
            ERROR('You cannot run report');
    end;

    var
        Tender: Record Tender;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Fyear: Integer;
        Fyear1: Integer;
        Month1: Integer;
        NoOfTender: array[13] of Integer;
        CompInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TenderValue: array[13] of Decimal;
        Tender1: Record Tender;
        BidNoOfTender: array[13] of Integer;
        BidTenderValue: array[13] of Decimal;
        Month2: Integer;
        Tender2: Record Tender;
        WinTenderValue: array[13] of Decimal;
        Month3: Integer;
        MarginValue: array[13] of Decimal;
        MarginPercent: array[13] of Decimal;
        CostOfTendering: array[13] of Decimal;
        Empanelment: Record Empanelment;
        Month4: Integer;
        NoOfEmpanelment: array[5] of Integer;
        TenderDocumentCost: array[13] of Decimal;
        EMDOutstanding: Decimal;
        EMDProcess: Decimal;
        EMDRecovered: Decimal;
        EMDOutstanding1: array[13] of Decimal;
        EMDProcess1: array[13] of Decimal;
        EMDRecovered1: array[13] of Decimal;
        UserSetup: Record "User Setup";
}