report 60101 "EPP Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/EPPReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Project; Job)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "Project Charter No.", "No.";
            column(ProjectNo; Project."No.")
            {
            }
            column(ProjectName; Project."Project Name" + ' ' + Project."Project Name 2")
            {
            }
            column(ClientName; Project."Bill-to Name")
            {
            }
            column(LocationCode; EPPLoc)
            {
            }
            column(ProjectCost; ProjectVAl)
            {
            }
            column(TenderNo; TenderNo)
            {
            }
            column(Duration; Noofday)
            {
            }
            column(feeVal; fee)
            {
            }
            column(EMDAMT; EMD)
            {
            }
            column(OneToFiveActualAmt; "1to5ActualAmt")
            {
            }
            column(TotalNoPO; TotalNoPO)
            {
            }
            column(TotalNoInv; TotalNoInv)
            {
            }
            column(PurchInvAmt; InviceAmt)
            {
            }
            column(POAmt; POAmt)
            {
            }
            column(ActualFee; ActualFee)
            {
            }
            dataitem(Manpower; "Expected Project Prof")
            {
                DataItemLink = "Project Charter No." = FIELD("Project Charter No.");
                DataItemTableView = SORTING(Expense, "Expense Code", "Project Charter No.")
                                    ORDER(Ascending)
                                    WHERE(Expense = FILTER(Manpower));
                column(EmpName; Manpower."Employee Name")
                {
                }
                column(Role; Manpower.Role)
                {
                }
                column(ManDays; Manpower.Mandayds)
                {
                }
                column(DeshCost; Manpower."Desk Cost ( Per Day)")
                {
                }
                column(Total; Manpower."Total (Rs.)")
                {
                }
                column(ActManDays; ActManday)
                {
                }
                column(ActDeshCost; ActDeskCost)
                {
                }
                column(ActTotal; ActTotal)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*
                    ActManday:=0;
                    ActDeskCost:=0;
                    ActDay:=0;
                    TotHrs:=0;
                    EmpWorkHourMan.RESET;
                    EmpWorkHourMan.SETRANGE("Project Code", Project."Project No.");
                    EmpWorkHourMan.SETRANGE("Employee Code",Manpower."Expense Code");
                    IF EmpWorkHourMan.FIND('-')THEN BEGIN
                      REPEAT
                        TotHrs:=TotHrs+EmpWorkHourMan."Total Time (Hrs)";
                      UNTIL EmpWorkHourMan.NEXT=0;
                    
                      IF TotHrs<>0 THEN
                        ActManday:=ROUND(TotHrs/8.5,0.01);
                    END;
                    
                    EMP.RESET;
                    EMP.SETRANGE("No.",Manpower."Expense Code");
                    IF EMP.FIND('-')THEN BEGIN
                      ActDeskCost:=EMP."Desk Cost";
                    END;
                    
                    
                    ActTotal :=ROUND((ActManday*ActDeskCost),0.01);
                    */// old logic

                    ActTotalCal := 0;
                    ActManday := 0;
                    ActDeskCost := 0;
                    ActDay := 0;
                    TotHrs := 0;
                    OSActManday := 0;
                    EmpWorkHourMan.RESET;
                    EmpWorkHourMan.SETRANGE("Project Code", Project."No.");
                    EmpWorkHourMan.SETRANGE("Employee Code", Manpower."Expense Code");
                    IF EmpWorkHourMan.FIND('-') THEN BEGIN
                        REPEAT
                            TotHrs := 0;
                            TotHrs := EmpWorkHourMan."Total Time (Hrs)";

                            IF TotHrs <> 0 THEN BEGIN
                                OSActManday := TotHrs / 8.5;
                                ActManday := ActManday + OSActManday;
                            END;

                            ActDeskCost := 0;
                            EmployeeDeskCost.RESET;
                            EmployeeDeskCost.SETRANGE("Employee Code", Manpower."Expense Code");
                            EmployeeDeskCost.SETFILTER("Start Date", '..%1', EmpWorkHourMan."Timesheet Date");
                            IF EmployeeDeskCost.FIND('+') THEN BEGIN
                                ActDeskCost := EmployeeDeskCost."Desk Cost";
                            END;
                            ActTotalCal := ActTotalCal + (OSActManday * ActDeskCost);
                        UNTIL EmpWorkHourMan.NEXT = 0;
                    END;
                    ActTotal := ROUND(ActTotalCal, 0.01);

                end;
            }
            dataitem(Manpower2; "Employee Working Hour Manager")
            {
                DataItemLink = "Project Code" = FIELD("No.");
                column(EmpName2; manName)
                {
                }
                column(Role2; Role2)
                {
                }
                column(ManDays2; ManDays2)
                {
                }
                column(DeshCost2; ActDeskCost2)
                {
                }
                column(Total2; Manpower2Totoal)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PrintSkip := FALSE;
                    ExpProjProf.RESET;
                    ExpProjProf.SETRANGE("Project Charter No.", Project."Project Charter No.");
                    ExpProjProf.SETRANGE("Expense Code", Manpower2."Employee Code");
                    IF ExpProjProf.FIND('-') THEN BEGIN
                        PrintSkip := TRUE

                    END;

                    IF PrintSkip THEN
                        CurrReport.SKIP
                    ELSE BEGIN

                    END;

                    ActDeskCost2 := 0;

                    EMP.RESET;
                    EMP.SETRANGE("No.", Manpower2."Employee Code");
                    IF EMP.FIND('-') THEN BEGIN
                        //ActDeskCost2:=EMP."Desk Cost";
                        manName := EMP."First Name" + ' ' + EMP."Middle Name";
                        Role2 := EMP.Desgination
                    END;

                    EmployeeDeskCost.RESET;
                    EmployeeDeskCost.SETRANGE("Employee Code", Manpower2."Employee Code");
                    EmployeeDeskCost.SETFILTER("Start Date", '..%1', Manpower2."Timesheet Date");
                    IF EmployeeDeskCost.FIND('+') THEN
                        ActDeskCost2 := EmployeeDeskCost."Desk Cost";



                    ManDays2 := 0;
                    IF Manpower2."Total Time (Hrs)" <> 0 THEN
                        ManDays2 := Manpower2."Total Time (Hrs)" / 8.5;

                    Manpower2Totoal := 0;

                    IF Manpower2."Total Time (Hrs)" <> 0 THEN
                        Manpower2Totoal := ManDays2 * ActDeskCost2;

                end;
            }
            dataitem(BoadingAndLoadging; "Expected Project Prof")
            {
                DataItemLink = "Project Charter No." = FIELD("Project Charter No.");
                DataItemTableView = SORTING(Expense, "Expense Code", "Project Charter No.")
                                    ORDER(Ascending)
                                    WHERE(Expense = FILTER("Boarding & Loading"));
                column(BoadLocation; BoadingAndLoadging.Location)
                {
                }
                column(BoadNoPer; BoadingAndLoadging."No. of Persons")
                {
                }
                column(BoadStays; BoadingAndLoadging.Stays)
                {
                }
                column(BoadRate; BoadingAndLoadging.Rate)
                {
                }
                column(BoadAmount; BoadingAndLoadging.Amount)
                {
                }
            }
            dataitem(Travelling; "Expected Project Prof")
            {
                DataItemLink = "Project Charter No." = FIELD("Project Charter No.");
                DataItemTableView = SORTING(Expense, "Expense Code", "Project Charter No.")
                                    ORDER(Ascending)
                                    WHERE(Expense = FILTER(Travelling));
                column(TravLocation; Travelling.Location)
                {
                }
                column(TravNoPerson; Travelling."No. of Persons")
                {
                }
                column(TravDays; Travelling.Days)
                {
                }
                column(TravRate; Travelling.Rate)
                {
                }
                column(TravAmount; Travelling.Amount)
                {
                }
            }
            dataitem(LocalConveyance; "Expected Project Prof")
            {
                DataItemLink = "Project Charter No." = FIELD("Project Charter No.");
                DataItemTableView = SORTING(Expense, "Expense Code", "Project Charter No.")
                                    ORDER(Ascending)
                                    WHERE(Expense = FILTER("Local Convenyance"));
                column(LocalLocation; LocalConveyance.Location)
                {
                }
                column(LocalNoPerson; LocalConveyance."No. of Persons")
                {
                }
                column(LocalDays; LocalConveyance.Days)
                {
                }
                column(LocalRate; LocalConveyance.Rate)
                {
                }
                column(LocalAmount; LocalConveyance.Amount)
                {
                }
            }
            dataitem(Printing; "Expected Project Prof")
            {
                DataItemLink = "Project Charter No." = FIELD("Project Charter No.");
                DataItemTableView = SORTING(Expense, "Expense Code", "Project Charter No.")
                                    ORDER(Ascending)
                                    WHERE(Expense = FILTER(Printing));
                column(PrintingName; Printing."Name of Report")
                {
                }
                column(PrintingPaper; Printing."Paper Size")
                {
                }
                column(PrintingNoPage; Printing."No. of Page")
                {
                }
                column(PrintingRate; Printing.Rate)
                {
                }
                column(PrintingAmount; Printing.Amount)
                {
                }
            }
            dataitem(Outsourced1; "Vendor Details for Charter")
            {
                DataItemLink = "Project Charter No." = FIELD("Project Charter No.");
                column(OutDescrition; Outsourced1."Service Details")
                {
                }
                column(OutQty; '')
                {
                }
                column(OutUnit; '')
                {
                }
                column(OutRate; '')
                {
                }
                column(OutAmount; Outsourced1.Value)
                {
                }
            }
            dataitem(OutSubProject; "Sub Project Charter")
            {
                DataItemLink = "Project Charter No." = FIELD("Project Charter No.");
                column(OutSubProDescrition; OutSubProject."Manager Name")
                {
                }
                column(OutSubProAmount; OutSubProject.Value)
                {
                }
            }
            dataitem(Contingency; "Expected Project Prof")
            {
                DataItemLink = "Project Charter No." = FIELD("Project Charter No.");
                DataItemTableView = SORTING(Expense, "Expense Code", "Project Charter No.")
                                    ORDER(Ascending)
                                    WHERE(Expense = FILTER(Contingency));
                column(Amount; Contingency.Amount)
                {
                }
                column(ContComm; Contingency."Commission/ Brokerage")
                {
                }
            }
            dataitem(ActulOutSource; Job)
            {
                DataItemLink = "Parent Project Code" = FIELD("No.");
                column(ActualOutSouDes; ActulOutSource."Project Name" + ' ' + ActulOutSource."Project Name 2")
                {
                }
                column(ActualOutSouVal; OSActTotal)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    OSTotHrs := 0;
                    OSActManday := 0;
                    OSActDeskCost := 0;
                    OSActTotalCal := 0;
                    OSActTotal := 0;

                    EmpWorkHourMan.RESET;
                    EmpWorkHourMan.SETRANGE("Project Code", ActulOutSource."No.");
                    IF EmpWorkHourMan.FIND('-') THEN BEGIN
                        REPEAT
                            OSTotHrs := 0;
                            OSTotHrs := EmpWorkHourMan."Total Time (Hrs)";

                            IF OSTotHrs <> 0 THEN
                                OSActManday := OSTotHrs / 8.5;

                            OSActDeskCost := 0;
                            /*
                            EmployeeDeskCost.RESET;
                            EmployeeDeskCost.SETRANGE("Employee Code",EmpWorkHourMan."Employee Code");
                            EmployeeDeskCost.SETFILTER("Start Date",'%1..%2',0D,EmpWorkHourMan."Timesheet Date");
                            IF EmployeeDeskCost.FIND('+')THEN  BEGIN
                              OSActDeskCost:=EmployeeDeskCost."Desk Cost";

                            END;
                             */
                            EmpDeskCostRec.RESET;
                            EmpDeskCostRec.SETRANGE("Start Date", 0D, EmpWorkHourMan."Timesheet Date");
                            EmpDeskCostRec.SETRANGE("Employee Code", EmpWorkHourMan."Employee Code");
                            IF EmpDeskCostRec.FIND('+') THEN
                                OSActDeskCost := EmpDeskCostRec."Desk Cost";

                            OSActTotalCal := OSActTotalCal + (OSActManday * OSActDeskCost);
                        //MESSAGE( 'cost :-%1 date :-  %2  man-%3 pR-%4 emp:-%5', OSActDeskCost ,EmpWorkHourMan."Timesheet Date",OSActManday,ActulOutSource."Project No.",EmpWorkHourMan."Employee Code");
                        UNTIL EmpWorkHourMan.NEXT = 0;
                    END;

                    OSActTotal := ROUND(OSActTotalCal, 0.01);

                end;
            }

            trigger OnAfterGetRecord()
            begin

                EPPLoc := '';
                ProjectVAl := 0;
                fee := 0;
                ActualFee := 0;
                TenderNo := '';
                ProjChart.RESET;
                ProjChart.SETRANGE("Project Code", Project."No.");
                IF ProjChart.FIND('-') THEN BEGIN
                    EPPLoc := ProjChart."EPP Location";
                    ProjectVAl := ProjChart."Project Cost for EPP";
                    TenderNo := ProjChart."Tender No.";

                    fee := ProjChart."Project Value";
                    //ActualFee:=  ProjChart."Project Value";
                END;

                Noofday := 0;
                Noofday := Project."Ending Date" - Project."Starting Date";

                EMD := 0;
                Tender.RESET;
                Tender.SETRANGE("Tender No.", Project."Tender No.");
                IF Tender.FIND('-') THEN BEGIN
                    EMD := Tender.EMD;

                END;

                "1to5ActualAmt" := 0;
                GLEntry.RESET;
                //GLEntry.SETFILTER("G/L Account No.",'%1|%2|%3','431003','431014','431028');
                GLEntry.SETFILTER("G/L Account No.", '%1..%2', '400000', '499999');
                GLEntry.SETRANGE("Global Dimension 1 Code", Project."Global Dimension 1 Code");
                //GLEntry.SETRANGE("Source Code",'JOURNALV');
                GLEntry.SETFILTER(GLEntry."Source Code", '%1|%2', 'JOURNALV', 'REVERSAL');
                IF GLEntry.FIND('-') THEN BEGIN
                    REPEAT
                        "1to5ActualAmt" := "1to5ActualAmt" + GLEntry.Amount;
                    UNTIL GLEntry.NEXT = 0;
                END;


                POAmt := 0;
                TotalNoPO := 0;
                PurchHead.RESET;
                PurchHead.SETRANGE("Document Type", PurchHead."Document Type"::Order);
                PurchHead.SETRANGE("Shortcut Dimension 1 Code", Project."Global Dimension 1 Code");
                IF PurchHead.FIND('-') THEN BEGIN
                    TotalNoPO := PurchHead.COUNT;
                    REPEAT
                        PurchHead.CALCFIELDS(Amount);

                        POAmt += PurchHead.Amount;
                    UNTIL PurchHead.NEXT = 0;
                END;

                InviceAmt := 0;
                TotalNoInv := 0;
                PurchInvHeader.RESET;
                PurchInvHeader.SETRANGE("Shortcut Dimension 1 Code", Project."Global Dimension 1 Code");
                IF PurchInvHeader.FIND('-') THEN BEGIN
                    TotalNoInv := PurchInvHeader.COUNT;
                    REPEAT
                        PurchInvHeader.CALCFIELDS(Amount);
                        InviceAmt += PurchInvHeader.Amount;
                    UNTIL PurchInvHeader.NEXT = 0;

                END;

                CrAmt := 0;

                PurchCrHead.RESET;
                PurchCrHead.SETRANGE("Shortcut Dimension 1 Code", Project."Global Dimension 1 Code");
                IF PurchCrHead.FIND('-') THEN BEGIN
                    //TotalNoInv:=PurchCrHead.COUNT;
                    REPEAT
                        PurchCrHead.CALCFIELDS(Amount);
                        CrAmt += PurchCrHead.Amount;
                    UNTIL PurchCrHead.NEXT = 0;

                END;
                InviceAmt := InviceAmt - CrAmt;
                //  MESSAGE('ord %1 .. inv %2',POAmt,InviceAmt);

                SalesInviceAmt := 0;
                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Shortcut Dimension 1 Code", Project."Global Dimension 1 Code");
                IF SalesInvLine.FIND('-') THEN BEGIN
                    TotalNoInv := SalesInvLine.COUNT;
                    REPEAT
                        SalesInviceAmt += SalesInvLine."Line Amount";
                    UNTIL SalesInvLine.NEXT = 0;

                END;

                SalesCrAmt := 0;

                SalesCrLine.RESET;
                SalesCrLine.SETRANGE("Shortcut Dimension 1 Code", Project."Global Dimension 1 Code");
                IF SalesCrLine.FIND('-') THEN BEGIN
                    //TotalNoInv:=SalesCrLine.COUNT;
                    REPEAT
                        SalesCrAmt += SalesCrLine."Line Amount";
                    UNTIL SalesCrLine.NEXT = 0;

                END;
                ActualFee := SalesInviceAmt - SalesCrAmt;
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
        ExpProjProf: Record "Expected Project Prof";
        PrintSkip: Boolean;
        ProjChart: Record "Project Charter";
        EPPLoc: Code[20];
        ProjectVAl: Decimal;
        Tender: Record Tender;
        TenderNo: Code[20];
        Noofday: Integer;
        EMD: Decimal;
        fee: Decimal;
        ActManday: Decimal;
        ActDeskCost: Decimal;
        ActTotal: Decimal;
        Manpower2Totoal: Decimal;
        EmpWorkHourMan: Record "Employee Working Hour Manager";
        ActDay: Decimal;
        TotHrs: Decimal;
        EMP: Record Employee;
        ActDeskCost2: Decimal;
        manName: Text[250];
        Role2: Code[50];
        ManDays2: Decimal;
        GLEntry: Record "G/L Entry";
        "1to5ActualAmt": Decimal;
        PurchHead: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        TotalNoPO: Integer;
        TotalNoInv: Integer;
        POAmt: Decimal;
        InviceAmt: Decimal;
        CrAmt: Decimal;
        PurchCrHead: Record "Purch. Cr. Memo Hdr.";
        PurchCrLine: Record "Purch. Cr. Memo Line";
        EmployeeDeskCost: Record "Employee Desk cost";
        ActTotalCal: Decimal;
        OSTotHrs: Decimal;
        OSActManday: Decimal;
        OSActDeskCost: Decimal;
        OSActTotalCal: Decimal;
        OSActTotal: Decimal;
        CALActManday: Decimal;
        EmpDeskCostRec: Record "Employee Desk cost";
        ActualFee: Decimal;
        SalesInviceAmt: Decimal;
        SalesCrAmt: Decimal;
        SalesCrLine: Record "Sales Cr.Memo Line";
        SalesInvLine: Record "Sales Invoice Line";
}

