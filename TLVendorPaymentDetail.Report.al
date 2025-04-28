report 50081 "TL-Vendor Payment Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/TLVendorPaymentDetail.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.");
            column(GetCompanyInfo_Name; CompanyNameText)
            {
            }
            column(GetCompanyInfo_Picture; GetCompanyInfo.Picture)
            {
            }
            column(GetCompanyInfo_Address; GetCompanyInfo.Address)
            {
            }
            column(GetCompanyInfo_Address2; GetCompanyInfo."Address 2")
            {
            }
            column(Start_Date; FORMAT(StartDate))
            {
            }
            column(End_Date; FORMAT(EndDate))
            {
            }
            column(SNo_Cap; SNoCap)
            {
            }
            column(ManagerCode_Cap; ManagerCodeCap)
            {
            }
            column(ManagerName_Cap; ManagerNameCap)
            {
            }
            column(ProjCode_Cap; ProjCodeCap)
            {
            }
            column(ProjectName_Cap; ProjectNameCap)
            {
            }
            column(SupName_Cap; SupNameCap)
            {
            }
            column(InvoiceNo_Cap; InvoiceNoCap)
            {
            }
            column(InvoiceDate_Cap; InvoiceDateCap)
            {
            }
            column(InvAmtWoTax_Cap; InvAmtWoTaxCap)
            {
            }
            column(InvAmtWTax_Cap; InvAmtWTaxCap)
            {
            }
            column(PaidAmt_Cap; PaidAmtCap)
            {
            }
            column(VendorPayDetail_Cap; VendorPayDetailCap)
            {
            }
            column(Total_Cap; TotalCap)
            {
            }
            dataitem(Project; Job)
            {
                DataItemLink = "Project Manager" = FIELD("No.");
                DataItemTableView = SORTING("No.");
                dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
                {
                    DataItemLink = "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code");
                    DataItemTableView = SORTING("No.");
                    dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemTableView = SORTING("Entry No.");
                        column(Sr_No; SrNo)
                        {
                        }
                        column(Manager_Code; Employee."No.")
                        {
                        }
                        column(Manager_Name; Employee."First Name")
                        {
                        }
                        column(Project_Code; Project."No.")
                        {
                        }
                        column(Project_Name; Project.Description)
                        {
                        }
                        column(Supp_Name; "Purch. Inv. Header"."Buy-from Vendor No.")
                        {
                        }
                        column(Vend_Name; "Purch. Inv. Header"."Buy-from Vendor Name")
                        {
                        }
                        column(Narrations_Txt; Narrations)
                        {
                        }
                        column(Purch_Comment_Text; PurchCommentText)
                        {
                        }
                        column(Paid_Amount; PaidAmount)
                        {
                        }
                        column(Invoice_No; "Purch. Inv. Header"."No.")
                        {
                        }
                        column(Invoice_Date; FORMAT("Purch. Inv. Header"."Posting Date"))
                        {
                        }
                        column(AmoutWo_Tax; AmoutWoTax)
                        {
                        }
                        column(AmoutW_Tax; ROUND(("Purch. Inv. Header".Amount * ExchangeRate), 0.01))
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PaidAmount := 0;
                            //Condition 1
                            DetailedVendLedgEntry.RESET;
                            DetailedVendLedgEntry.SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type");
                            DetailedVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", "Entry No.");
                            DetailedVendLedgEntry.SETFILTER("Entry Type", '%1', DetailedVendLedgEntry."Entry Type"::Application);
                            DetailedVendLedgEntry.SETFILTER("Initial Document Type", '%1', DetailedVendLedgEntry."Initial Document Type"::Invoice);
                            IF DetailedVendLedgEntry.FINDSET THEN BEGIN
                                REPEAT
                                    PaidAmount += -(DetailedVendLedgEntry."Amount (LCY)");
                                UNTIL DetailedVendLedgEntry.NEXT = 0;
                            END;
                            //Condition 1

                            //Condition 2
                            DetailedVendLedgEntry.RESET;
                            DetailedVendLedgEntry.SETCURRENTKEY("Document No.");
                            DetailedVendLedgEntry.SETRANGE("Document No.", "Document No.");
                            DetailedVendLedgEntry.SETFILTER("Entry Type", '%1', DetailedVendLedgEntry."Entry Type"::Application);
                            DetailedVendLedgEntry.SETFILTER("Document Type", '%1', DetailedVendLedgEntry."Document Type"::Invoice);
                            IF DetailedVendLedgEntry.FINDSET THEN BEGIN
                                REPEAT
                                    PaidAmount += (DetailedVendLedgEntry."Amount (LCY)");
                                UNTIL DetailedVendLedgEntry.NEXT = 0;
                            END;
                            //Condition 2


                            //Narration--
                            Narrations := '';
                            // PostedNarration.RESET;
                            // PostedNarration.SETFILTER("Entry No.", '%1', 0);
                            // PostedNarration.SETRANGE(PostedNarration."Document No.", "Document No.");
                            // IF PostedNarration.FINDSET THEN BEGIN
                            //     REPEAT
                            //         Narrations += PostedNarration.Narration;
                            //     UNTIL PostedNarration.NEXT = 0;
                            // END;


                            IF PaidAmount = 0 THEN
                                CurrReport.SKIP;

                            SrNo += 1;

                            AmoutWoTax := 0;
                            PurchInvLine.RESET;
                            PurchInvLine.SETRANGE("Document No.", "Document No.");
                            IF PurchInvLine.FINDSET THEN BEGIN
                                REPEAT
                                    AmoutWoTax += ROUND((PurchInvLine."Line Amount" * ExchangeRate), 0.01);
                                UNTIL PurchInvLine.NEXT = 0;
                            END;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CALCFIELDS(Amount);

                        IF "Currency Code" <> '' THEN
                            ExchangeRate := 1 / "Currency Factor"
                        ELSE
                            ExchangeRate := 1;
                        PurchCommentText := '';
                        PurchCommentLine.RESET;
                        PurchCommentLine.SETRANGE("Document Type", PurchCommentLine."Document Type"::"Posted Invoice");
                        PurchCommentLine.SETRANGE("No.", "Purch. Inv. Header"."No.");
                        IF PurchCommentLine.FINDFIRST THEN BEGIN
                            REPEAT
                                PurchCommentText += PurchCommentLine.Comment;
                            UNTIL PurchCommentLine.NEXT = 0;
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                    end;
                }
            }

            trigger OnPreDataItem()
            begin
                IF GetEmployee.GET(USERID) THEN BEGIN
                    IF GetEmployee."TL Report" THEN BEGIN
                        IF ManagerCode <> '' THEN
                            SETFILTER(Employee."No.", '%1', ManagerCode);
                    END;

                    IF ManagerCode = '' THEN BEGIN
                        IF (GetEmployee."Project Manager") AND (GetEmployee."TL Report" = FALSE) THEN BEGIN
                            ManagerCode := GetEmployee."No.";
                            SETFILTER(Employee."No.", '%1', ManagerCode);
                        END;
                    END;
                END;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Project Manager Code"; ManagerCode)
                {
                    TableRelation = Employee."No." WHERE("Project Manager for Cash Flow" = CONST(true));

                    trigger OnValidate()
                    begin
                        /*GetEmployee.GET(USERID);
                        IF GetEmployee."TL Report" = GetEmployee."TL Report" :: "0" THEN
                          ERROR('You are not authorized for using this filter');
                         */

                    end;
                }
                field("Start Date"; StartDate)
                {

                    trigger OnValidate()
                    begin
                        IF EndDate <> 0D THEN
                            IF StartDate > EndDate THEN
                                ERROR(Text13703);
                    end;
                }
                field("End Date"; EndDate)
                {

                    trigger OnValidate()
                    begin
                        IF StartDate <> 0D THEN
                            IF StartDate > EndDate THEN
                                ERROR(Text13700);
                    end;
                }
            }
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
        IF (StartDate = 0D) OR (EndDate = 0D) THEN
            ERROR('Date must not be blank');

        GetCompanyInfo.GET;
        //GetCompanyInfo.CALCFIELDS(Picture);//
        IF GetCompanyInfo."New Name Date" <> 0D THEN BEGIN
            IF EndDate >= GetCompanyInfo."New Name Date" THEN
                CompanyNameText := GetCompanyInfo.Name
            ELSE
                CompanyNameText := GetCompanyInfo."Old Name";
        END ELSE
            CompanyNameText := GetCompanyInfo.Name;
    end;

    var
        GetCompanyInfo: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        ManagerCode: Code[20];
        VendorPayDetailCap: Label 'Vendor Payment Detail';
        SNoCap: Label 'S. No.';
        ManagerCodeCap: Label 'Employee Code';
        ManagerNameCap: Label 'Employee Name';
        ProjCodeCap: Label 'Project Code';
        ProjectNameCap: Label 'Project Name';
        SupNameCap: Label 'Sup. Name';
        InvoiceNoCap: Label 'Invoice No.';
        InvoiceDateCap: Label 'Invoice Date';
        InvAmtWoTaxCap: Label 'Inv. Amt. Without Tax';
        InvAmtWTaxCap: Label 'Inv. Amt. With Tax (After TDS Ded.)';
        PaidAmtCap: Label 'Paid Amount';
        GetVendor: Record Vendor;
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        SrNo: Integer;
        PurchInvLine: Record "Purch. Inv. Line";
        AmoutWoTax: Decimal;
        PaidAmount: Decimal;
        TotalCap: Label 'Total';
        GetEmployee: Record Employee;
        Text13700: Label 'End Date cannot be before Start Date.';
        Text13703: Label 'Start Date cannot be after End Date.';
        ExchangeRate: Decimal;
        CompanyNameText: Text;
        //PostedNarration: Record "16548";
        Narrations: Text;
        PurchCommentLine: Record "Purch. Comment Line";
        PurchCommentText: Text;
        Vend: Record Vendor;
        VendorName: Text;
}

