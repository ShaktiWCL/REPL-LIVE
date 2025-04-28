report 50037 "Sales Invoice Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/SalesInvoiceDetail.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Type Of Note" = FILTER(<> Debit));
            RequestFilterFields = "No.", "Sell-to Customer No.", "Posting Date";
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE("No." = FILTER(<> ''));
                column(CustomerName; CustName)
                {
                }
                column(InvoiceNo; "Sales Invoice Line"."Document No.")
                {
                }
                column(PostingDate; "Sales Invoice Line"."Posting Date")
                {
                }
                column(Amount; "Sales Invoice Line".Amount)
                {
                }
                column(ProjectCOde; Projectcode)
                {
                }
                column(ProjectName; ProjectName)
                {
                }
                column(ProjectManager; ProjectManager)
                {
                }
                column(ProjectStatus; ProjectStatus1)
                {
                }
                column(OldProjectCode; OldProjectNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(ProjectManager);
                    CLEAR(ProjectStatus);
                    CLEAR(Projectcode);
                    CLEAR(ProjectName);
                    CLEAR(OldProjectNo);
                    CLEAR(ProjectStatus1);
                    RecProject.RESET;
                    RecProject.SETRANGE(RecProject."Global Dimension 1 Code", "Sales Invoice Line"."Shortcut Dimension 1 Code");
                    IF RecProject.FINDFIRST THEN BEGIN
                        ProjectManager := RecProject."Project Manager";
                        //ProjectStatus := RecProject.Status;
                        ProjectStatus1 := FORMAT(ProjectStatus);
                        Projectcode := RecProject."No.";
                        ProjectName := RecProject.Description + ' ' + RecProject."Description 2";
                        OldProjectNo := RecProject."Old Project Code(Ramco)";
                    END ELSE
                        ProjectStatus1 := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(CustName);
                Cust.GET("Sell-to Customer No.");
                CustName := Cust.Name;
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
        CustName: Text;
        Cust: Record Customer;
        ProjectCredate: Date;
        ProjectName: Text;
        Projectcode: Code[20];
        ProjectManager: Code[20];
        ProjectStatus: Option Draft,Fresh,Approved,"Under Revision",Completed,"Short close","Deleted/Wrong updated","Pending for Approval";
        RecProject: Record Job;
        OldProjectNo: Code[50];
        ProjectStatus1: Text;
}

