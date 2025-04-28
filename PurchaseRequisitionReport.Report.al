report 50144 "Purchase Requisition Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PurchaseRequisitionReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Requisition Header"; "Requisition Header")
        {
            RequestFilterFields = "Requisition No";
            column(Date; "Requisition Header"."Requisition Date")
            {
            }
            column(Requisition_No; "Requisition Header"."Requisition No")
            {
            }
            column(Product_Service_Need_By_Date; "Requisition Header"."Product/ Service Need by Date")
            {
            }
            column(Total_project_Free_INR; "Requisition Header"."Total Project Fees(INR)")
            {
            }
            column(Total_Estimated_Cost_Expense; "Requisition Header"."Total Estimated Cost/Expenses")
            {
            }
            column(Total_Vendor_Payment_Done; "Requisition Header"."Total Vendor Payment done")
            {
            }
            column(Estimated_Cost; "Requisition Header"."Estimated cost")
            {
            }
            column(Actual_Amount; "Requisition Header"."Actual Amount")
            {
            }
            column(Already_Incurred; "Requisition Header"."Already Incurred")
            {
            }
            column(Net_Balance; "Requisition Header"."Net Balance")
            {
            }
            column(Department_Name; "Requisition Header"."Department Name")
            {
            }
            column(Department_HOD; "Requisition Header"."Department HOD")
            {
            }
            column(Vendor_No; "Requisition Header"."Vendor No.")
            {
            }
            column(Vendor_Name; "Requisition Header"."Vendor Name")
            {
            }
            column(Vendor_Address; "Requisition Header"."Vendor Address")
            {
            }
            column(Vendor_Type; "Requisition Header"."Vendor Type")
            {
            }
            column(Approved_by_HOD; "Requisition Header"."Approved by HOD")
            {
            }
            column(Centralized_Procurement_Dept; "Requisition Header"."Centralized Procurement Dept")
            {
            }
            column(User_Dept; "Requisition Header"."User Dept")
            {
            }
            column(Remark; "Requisition Header".Remarks)
            {
            }
            column(Project_No; "Requisition Header"."Project No.")
            {
            }
            column(Project_Name; "Requisition Header"."Project Name")
            {
            }
            column(Project_Name2; "Requisition Header"."Project Name 2")
            {
            }
            column(Creator_ID; "Requisition Header"."Creator ID")
            {
            }
            column(Payment_Term; "Requisition Header"."Payment Term")
            {
            }
            column(VendorName2_RequisitionHeader; "Requisition Header"."Vendor Name 2")
            {
            }
            column(VendorAddressCity2_RequisitionHeader; "Requisition Header"."Vendor Address& City 2")
            {
            }
            column(VendorPhoneNo2_RequisitionHeader; "Requisition Header"."Vendor Phone No 2")
            {
            }
            column(AMOUNTCostinclTaxes2_RequisitionHeader; "Requisition Header"."AMOUNT (Cost incl. Taxes 2")
            {
            }
            column(VendorName3_RequisitionHeader; "Requisition Header"."Vendor Name 3")
            {
            }
            column(VendorAddressCity3_RequisitionHeader; "Requisition Header"."Vendor Address& City 3")
            {
            }
            column(VendorPhoneNo3_RequisitionHeader; "Requisition Header"."Vendor Phone No 3")
            {
            }
            column(AMOUNTCostinclTaxes3_RequisitionHeader; "Requisition Header"."AMOUNT (Cost incl. Taxes) 3")
            {
            }
            column(DeptTLName; DeptTLName)
            {
            }
            column(PaymentTermDesc; PaymentDesc)
            {
            }
            dataitem("Requisition Line2"; "Requisition Line2")
            {
                DataItemLink = "Requistion No." = FIELD("Requisition No");
                column(Description; "Requisition Line2".Description)
                {
                }
                column(Nature; "Requisition Line2".Nature)
                {
                }
                column(Unit_Type; "Requisition Line2"."Unit Type")
                {
                }
                column(Unite_Price; "Requisition Line2"."Unit Price")
                {
                }
                column(Quanty; "Requisition Line2".Quantity)
                {
                }
                column(Total_Price; "Requisition Line2"."Total Price")
                {
                }
                column(Sr_N0; SrNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SrNo := SrNo + 1;
                end;

                trigger OnPreDataItem()
                begin
                    IF PaymentTerms.GET("Requisition Header"."Payment Term") THEN
                        PaymentDesc := PaymentTerms.Description;

                    SrNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF RecEmp.GET("Requisition Header"."Department HOD") THEN
                    DeptTLName := RecEmp."First Name" + ' ' + RecEmp."Last Name";
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
        SrNo: Integer;
        RecEmp: Record Employee;
        DeptTLName: Text;
        PaymentTerms: Record "Payment Terms";
        PaymentDesc: Text;
}

