report 50147 "SUDA Invoice Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/SUDAInvoiceReport.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(Invoice_no; "Sales Header"."No.")
            {
            }
            column(Cust_code; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(Cust_name; CustomerName)
            {
            }
            column(cust_name2; "Sales Header"."Bill-to Name 2")
            {
            }
            column(cust_add; CustomerAddress)
            {
            }
            column(cust_city; CustomerCity)
            {
            }
            column(CustomerPostCode; CustomerPostCode)
            {
            }
            column(cust_order_date; "Sales Header"."Order Date")
            {
            }
            column(invoice_post_date; "Sales Header"."Posting Date")
            {
            }
            column(cust_state_code; "Sales Header"."GST Bill-to State Code")
            {
            }
            column(cust_location_code; "Sales Header"."Location State Code")
            {
            }
            column(cust_gst_no; CustGSTIN)
            {
            }
            column(shipped_date; "Sales Header"."Shipment Date")
            {
            }
            column(pay_term; "Sales Header"."Payment Terms Code")
            {
            }
            column(cust_location; "Sales Header"."Location Code")
            {
            }
            column(cust_state; "Sales Header".State)
            {
            }
            column(cust_nature_supply; "Sales Header"."Nature of Supply")
            {
            }
            column(comp_add; LOCATION.Address + ', ' + LOCATION.City + ',' + LOCATION."State Code" + ' - ' + LOCATION."Post Code")
            {
            }
            column(ProjectDescSUDA_SalesHeader; "Sales Header"."Project Desc (SUDA)")
            {
            }
            column(comp_phone; LOCATION."Phone No.")
            {
            }
            column(comp_tel; LOCATION."Telex No.")
            {
            }
            column(comp_city; LOCATION.City)
            {
            }
            column(comp_email; LOCATION."E-Mail")
            {
            }
            column(comp_state; LOCATION."State Code")
            {
            }
            column(comp_pan; companyinfo."P.A.N. No.")
            {
            }
            column(comp_gstn; LOCATION."GST Registration No.")
            {
            }
            column(Bank_address; Bankname.Address + ' ' + Bankname."Address 2")
            {
            }
            column(Bankaccountno; Bankname."Bank Account No.")
            {
            }
            column(SWIFTCODE; Bankname."SWIFT Code")
            {
            }
            column(IFSCCODE; Bankname."IFSC Code2")
            {
            }
            column(Bankname; Bankname.Name)
            {
            }
            column(cinno; companyinfo."CIN No.")
            {
            }
            column(Statename; Statename)
            {
            }
            column(STATECODEGST; STATECODEGST)
            {
            }
            column(locup; locup)
            {
            }
            column(company_name; LOCATION.Name)
            {
            }
            column(MSME; Getsalesetup.MSME)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(document_no; "Sales Line"."Document No.")
                {
                }
                column(line_no; "Sales Line"."Line No.")
                {
                }
                column(description; "Sales Line".Description)
                {
                }
                column(srno; Srno)
                {
                }
                column(description2; "Sales Line"."Description 2")
                {
                }
                column(uom; "Sales Line"."Unit of Measure")
                {
                }
                column(qty; "Sales Line".Quantity)
                {
                }
                column(cost; "Sales Line"."Unit Cost (LCY)")
                {
                }
                column(line_amt; "Sales Line"."Line Amount")
                {
                }
                column(Project_code; "Sales Line"."Job No.")
                {
                }
                column(melestone_code; "Sales Line".Milestone)
                {
                }
                column(Milestonedesc; Milestonedesc)
                {
                }
                column(Projectname; Projectname)
                {
                }
                column(hsncode; saleline."HSN/SAC Code")
                {
                }
                column(GeneralOBC_SalesLine; "Sales Line"."General/OBC")
                {
                }
                column(SC_SalesLine; "Sales Line".SC)
                {
                }
                column(ST_SalesLine; "Sales Line".ST)
                {
                }
                column(ApprovedRate; ApprovedRate)
                {
                }
                column(PerApprovedRate; PerApprovedRate)
                {
                }
                column(RatePerMSL; RatePerMSL)
                {
                }
                column(Rate; RateValue)
                {
                }
                column(TotalOBCSCST; "Sales Line"."General/OBC" + "Sales Line".SC + "Sales Line".ST)
                {
                }
                column(GenOBCValue; "Sales Line"."General/OBC" * RateValue)
                {
                }
                column(SCValue; "Sales Line".SC * RateValue)
                {
                }
                column(STValue; "Sales Line".ST * RateValue)
                {
                }
                column(Value; Value)
                {
                }
                column(AmountInWord; AmountInWord[1])
                {
                }

                trigger OnAfterGetRecord()
                var
                    Text1: Label 'Difference Amount for both calculation is %1';
                begin

                    Srno += 1;
                    Milestonedesc := '';
                    milestage := 0;
                    Projectname := '';
                    hsncode := '';

                    IF "Job No." <> '' THEN
                        ProjectTask.RESET;
                    ProjectTask.SETRANGE("Job No.", "Job No.");
                    ProjectTask.SETRANGE("Job Task No.", "Job Task No.");
                    ProjectTask.SETRANGE(Milestone, Milestone);
                    IF ProjectTask.FINDFIRST THEN BEGIN
                        Milestonedesc := ProjectTask."Milestone Desc";
                        milestage := ProjectTask."Milestone Stages";
                        IF Project.GET(ProjectTask."Job No.") THEN
                            Projectname := Project.Description + ' ' + Project."Description 2";
                        ApprovedRate := ProjectTask."Approved Rate";
                        PerApprovedRate := ProjectTask."% Approved Rate";
                        RatePerMSL := ProjectTask."% Rate per Milestone";
                        IF ProjectTask."Approved Rate" <> 0 THEN BEGIN
                            RateValue := ((ProjectTask."Approved Rate" * ProjectTask."% Approved Rate") / 100)
                        END;
                    END;


                    saleline.RESET;
                    saleline.SETRANGE(saleline."Document No.", "Sales Header"."No.");
                    IF saleline.FIND('-') THEN BEGIN
                        hsncode := saleline."HSN/SAC Code";
                    END;

                    Value := ("Sales Line"."General/OBC" * RateValue) + ("Sales Line".SC * RateValue) + ("Sales Line".ST * RateValue);
                    "Sales Header".CALCFIELDS(Amount);
                    DiffMessage := (Value - "Sales Header".Amount);
                    MESSAGE(Text1, DiffMessage);

                    Check.InitTextVariable;
                    Check.FormatNoText(AmountInWord, ROUND(Value, 1), "Sales Header"."Currency Code");


                    IF companyinfo.Name = 'Rudrabhishek Enterprises Limited' THEN BEGIN
                        IF "Sales Header"."Bank Account No." <> '' THEN
                            Bankname.GET("Sales Header"."Bank Account No.")
                        ELSE
                            Bankname.GET('BANK-013');
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF "Sales Header"."Ship-to Code" <> '' THEN BEGIN
                    IF ShiptoAddress.GET("Sales Header"."Sell-to Customer No.", "Sales Header"."Ship-to Code") THEN BEGIN
                        CustomerName := ShiptoAddress.Name;
                        CustomerAddress := ShiptoAddress.Address + ' ' + ShiptoAddress."Address 2";
                        CustomerCity := ShiptoAddress.City;
                        CustomerPostCode := ShiptoAddress."Post Code";
                        CustomerStateCode := ShiptoAddress.State;
                    END;
                END ELSE BEGIN
                    CustomerName := "Sales Header"."Bill-to Name";
                    CustomerAddress := "Sales Header"."Bill-to Address" + ' ' + "Sales Header"."Bill-to Address 2";
                    CustomerCity := "Sales Header"."Bill-to City";
                    CustomerPostCode := "Sales Header"."Bill-to Post Code";
                    //CustomerStateCode := "Sales Header"."Bill to Customer State";
                END;




                LOCATION.GET("Location Code");
                companyinfo.GET;

                Statename := '';
                STATECODEGST := '';
                getState.RESET;
                IF custinfo.GET("Sales Header"."Bill-to Customer No.") THEN BEGIN
                    getState.GET(custinfo."State Code");
                    Statename := getState.Description;
                    IF custinfo."GST Registration No." <> '' THEN
                        CustGSTIN := custinfo."GST Registration No."
                    ELSE
                        CustGSTIN := 'Unregistered/Exempted';
                    STATECODEGST := getState."State Code (GST Reg. No.)";
                    locup := '';
                    IF RecState.GET(LOCATION."State Code") THEN
                        locup := RecState.Description;
                END;
            end;

            trigger OnPreDataItem()
            begin
                Getsalesetup.GET;
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
        companyinfo: Record "Company Information";
        Srno: Integer;
        Project: Record Job;
        ProjectTask: Record "Job Task";
        custinfo: Record Customer;
        LOCATION: Record Location;
        Milestonedesc: Text;
        Projectname: Text;
        ProjectCity: Text;
        milestage: Integer;
        saleline: Record "Sales Line";
        hsncode: Text;
        Bankname: Record "Bank Account";
        getState: Record State;
        Statename: Text;
        locup: Text;
        STATECODEGST: Text;
        RATE: Decimal;
        "GEN/OBC": Integer;
        RecCust: Record Customer;
        ApprovedRate: Decimal;
        PerApprovedRate: Decimal;
        RatePerMSL: Decimal;
        RateValue: Decimal;
        Check: Report Check;
        AmountInWord: array[2] of Text;
        Value: Decimal;
        CustomerName: Text;
        CustomerAddress: Text;
        CustomerCity: Text;
        CustomerPostCode: Text;
        CustomerStateCode: Text;
        ShiptoAddress: Record "Ship-to Address";
        CustGSTIN: Text;
        RecState: Record State;
        DiffMessage: Decimal;
        Getsalesetup: Record "Sales & Receivables Setup";
}

