report 60105 "SUDA Posted Invoice Report."
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/SUDAPostedInvoiceReport.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(Invoice_no; "Sales Invoice Header"."No.")
            {
            }
            column(Cust_code; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(Cust_name; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(cust_name2; "Sales Invoice Header"."Bill-to Name 2")
            {
            }
            column(cust_add; "Sales Invoice Header"."Bill-to Address" + ' ' + "Sales Invoice Header"."Bill-to Address 2")
            {
            }
            column(cust_city; "Sales Invoice Header"."Bill-to City")
            {
            }
            column(QR_Code; "Sales Invoice Header"."QR Code")
            {
            }
            column(CustomerPostCode; CustomerPostCode)
            {
            }
            column(cust_order_date; "Sales Invoice Header"."Order Date")
            {
            }
            column(invoice_post_date; "Sales Invoice Header"."Posting Date")
            {
            }
            column(cust_state_code; "Sales Invoice Header"."GST Bill-to State Code")
            {
            }
            column(cust_location_code; "Sales Invoice Header"."Location Code")
            {
            }
            column(cust_gst_no; CustGSTIN)
            {
            }
            column(shipped_date; "Sales Invoice Header"."Shipment Date")
            {
            }
            column(cust_location; "Sales Invoice Header"."Location Code")
            {
            }
            column(cust_state; "Sales Invoice Header".State)
            {
            }
            column(cust_nature_supply; "Sales Invoice Header"."Nature of Supply")
            {
            }
            column(comp_add; LOCATION.Address + ', ' + LOCATION.City + ',' + LOCATION."State Code" + ' - ' + LOCATION."Post Code")
            {
            }
            column(ProjectDescSUDA_SalesHeader; "Sales Invoice Header"."Project Desc (SUDA)")
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
            column(IFSCCODE; Bankname."IFSC Code")
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
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(document_no; "Sales Invoice Line"."Document No.")
                {
                }
                column(line_no; "Sales Invoice Line"."Line No.")
                {
                }
                column(description; "Sales Invoice Line".Description)
                {
                }
                column(srno; Srno)
                {
                }
                column(description2; "Sales Invoice Line"."Description 2")
                {
                }
                column(uom; "Sales Invoice Line"."Unit of Measure")
                {
                }
                column(qty; "Sales Invoice Line".Quantity)
                {
                }
                column(cost; "Sales Invoice Line"."Unit Cost (LCY)")
                {
                }
                column(line_amt; "Sales Invoice Line"."Line Amount")
                {
                }
                column(Project_code; "Sales Invoice Line"."Job No.")
                {
                }
                column(melestone_code; "Sales Invoice Line".Milestone)
                {
                }
                column(Milestonedesc; Milestonedesc)
                {
                }
                column(Projectname; Projectname)
                {
                }
                column(hsncode; "Sales Invoice Line"."HSN/SAC Code")
                {
                }
                column(GeneralOBC_SalesLine; "Sales Invoice Line"."General/OBC")
                {
                }
                column(SC_SalesLine; "Sales Invoice Line".SC)
                {
                }
                column(ST_SalesLine; "Sales Invoice Line".ST)
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
                column(TotalOBCSCST; "Sales Invoice Line"."General/OBC" + "Sales Invoice Line".SC + "Sales Invoice Line".ST)
                {
                }
                column(GenOBCValue; "Sales Invoice Line"."General/OBC" * RateValue)
                {
                }
                column(SCValue; "Sales Invoice Line".SC * RateValue)
                {
                }
                column(STValue; "Sales Invoice Line".ST * RateValue)
                {
                }
                column(Value; Value)
                {
                }
                column(AmountInWord; AmountInWord[1])
                {
                }

                trigger OnAfterGetRecord()
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
                    //ProjectTask.SETRANGE(Milestone, Milestone);
                    IF ProjectTask.FINDFIRST THEN BEGIN
                        Milestonedesc := ProjectTask."Milestone Desc";
                        milestage := ProjectTask."Milestone Stages";
                        IF Project.GET(ProjectTask."Job No.") THEN
                            Projectname := Project."Project Name" + ' ' + Project."Project Name 2";
                        ApprovedRate := ProjectTask."Approved Rate";
                        PerApprovedRate := ProjectTask."% Approved Rate";
                        RatePerMSL := ProjectTask."% Rate per Milestone";
                        IF ProjectTask."Approved Rate" <> 0 THEN BEGIN
                            RateValue := ((ProjectTask."Approved Rate" * ProjectTask."% Approved Rate") / 100)
                        END;
                    END;

                    saleline.RESET;
                    saleline.SETRANGE(saleline."Document No.", "Sales Invoice Header"."No.");
                    IF saleline.FIND('-') THEN BEGIN
                        hsncode := saleline."HSN/SAC Code";
                    END;

                    Value := ("Sales Invoice Line"."General/OBC" * RateValue) + ("Sales Invoice Line".SC * RateValue) + ("Sales Invoice Line".ST * RateValue);

                    Check.InitTextVariable;
                    Check.FormatNoText(AmountInWord, ROUND(Value, 1), "Sales Invoice Header"."Currency Code");


                    IF companyinfo.Name = 'Rudrabhishek Enterprises Limited' THEN
                        Bankname.GET('BANK-013');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF "Sales Invoice Header"."Ship-to Code" <> '' THEN BEGIN
                    IF ShiptoAddress.GET("Sales Invoice Header"."Sell-to Customer No.", "Sales Invoice Header"."Ship-to Code") THEN BEGIN
                        CustomerName := ShiptoAddress.Name;
                        CustomerAddress := ShiptoAddress.Address + ' ' + ShiptoAddress."Address 2";
                        CustomerCity := ShiptoAddress.City;
                        CustomerPostCode := ShiptoAddress."Post Code";
                        CustomerStateCode := ShiptoAddress.State;
                    END;
                END ELSE BEGIN
                    CustomerName := "Sales Invoice Header"."Bill-to Name";
                    CustomerAddress := "Sales Invoice Header"."Bill-to Address" + ' ' + "Sales Invoice Header"."Bill-to Address 2";
                    CustomerCity := "Sales Invoice Header"."Bill-to City";
                    CustomerPostCode := "Sales Invoice Header"."Bill-to Post Code";
                    CustomerStateCode := "Sales Invoice Header"."GST Bill-to State Code";
                END;




                LOCATION.GET("Location Code");
                companyinfo.GET;

                Statename := '';
                STATECODEGST := '';
                getState.RESET;
                IF custinfo.GET("Sales Invoice Header"."Bill-to Customer No.") THEN BEGIN
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
        Saleline: Record "Sales Invoice Line";
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
        Getsalesetup: Record "Sales & Receivables Setup";
}

