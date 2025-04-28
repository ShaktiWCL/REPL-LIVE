report 50036 "Purchase Invoice Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/PurchaseInvoiceDetail.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = WHERE("Type Of Note" = FILTER(<> Credit));
            RequestFilterFields = "Posting Date";
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ProjectNo; ProjectNo)
                {
                }
                column(Invoice_No; "Purch. Inv. Line"."Document No.")
                {
                }
                column(PostingDate_PurchInvLine; "Purch. Inv. Line"."Posting Date")
                {
                }
                column(FinanicalBook; "Purch. Inv. Line"."Shortcut Dimension 2 Code")
                {
                }
                column(CostCenter; "Purch. Inv. Line"."Shortcut Dimension 1 Code")
                {
                }
                column(BasicAmount; "Purch. Inv. Line".Amount)
                {
                }
                column(NetAmt; "Purch. Inv. Line".Amount)
                {
                }
                column(Qty; "Purch. Inv. Line".Quantity)
                {
                }
                column(VendorNo; "Purch. Inv. Line"."Buy-from Vendor No.")
                {
                }
                column(OldVendorNo; OldVendorNo)
                {
                }
                column(ProjectName; ProjectName1)
                {
                }
                column(ProjectMnager; ProjectManager)
                {
                }
                column(RamcoOldCode; RamcoOldCode)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF RecPurchaseH.GET("Purch. Inv. Line"."Document No.") THEN
                        OldVendorNo := RecPurchaseH."Old Vendor No.";


                    RecProject.RESET;
                    RecProject.SETRANGE("Global Dimension 1 Code", "Purch. Inv. Line"."Shortcut Dimension 1 Code");
                    IF RecProject.FINDFIRST THEN BEGIN
                        ProjectNo := RecProject."No.";
                        ProjectName1 := RecProject.Description;
                        ProjectManager := RecProject."Project Manager";
                        RamcoOldCode := RecProject."Old Project Code(Ramco)";
                    END;
                end;
            }

            trigger OnPreDataItem()
            begin
                SETRANGE("Posting Date", StartDate, EndDate);
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = WHERE("Source Type" = FILTER("Bank Account"),
                                      Amount = FILTER(< 0));
            dataitem("<G/L Entry1>"; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = WHERE("Source Type" = FILTER(' '));
                column(GLAccountNo_GLEntry1; "<G/L Entry1>"."G/L Account No.")
                {
                }
                column(PostingDate_GLEntry1; "<G/L Entry1>"."Posting Date")
                {
                }
                column(DocumentType_GLEntry1; "<G/L Entry1>"."Document Type")
                {
                }
                column(DocumentNo_GLEntry1; "<G/L Entry1>"."Document No.")
                {
                }
                column(Description_GLEntry1; "<G/L Entry1>".Description)
                {
                }
                column(BalAccountNo_GLEntry1; "<G/L Entry1>"."Bal. Account No.")
                {
                }
                column(Amount_GLEntry1; "<G/L Entry1>".Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    GlEntry.SETRANGE("Document No.", "Document No.");
                    IF GlEntry.FINDFIRST THEN
                        REPEAT
                            IF (GlEntry."Source Type" = GlEntry."Source Type"::Customer) OR (GlEntry."Source Type" = GlEntry."Source Type"::Vendor) THEN
                                CurrReport.SKIP;
                        UNTIL GlEntry.NEXT = 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                SETRANGE("Posting Date", StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                }
                field("End Date"; EndDate)
                {
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

    var
        ProjectName: Text;
        FinanicalBook: Code[20];
        RecPurchaseH: Record "Purch. Inv. Header";
        OldVendorNo: Code[20];
        RecProject: Record Job;
        ProjectName1: Text;
        ProjectManager: Text;
        ProjectNo: Code[20];
        RamcoOldCode: Code[40];
        GlEntry: Record "G/L Entry";
        StartDate: Date;
        EndDate: Date;
}

