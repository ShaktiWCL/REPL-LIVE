report 50050 "Convert Main Customer"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './ConvertMainCustomer.rdlc';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Temporary Customer"; "Temporary Customer")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Cust.INIT;
                Cust.TRANSFERFIELDS("Temporary Customer");
                Cust."No." := '';
                Cust.INSERT(TRUE);
                Cust.VALIDATE("Bill-to Customer No.", Cust."No.");
                Cust."Invoice Disc. Code" := Cust."No.";
                Cust.MODIFY;

                Status := Status::Approved;
                "Actual Customer No." := Cust."No.";
                "Approved By" := USERID;
                MODIFY;
            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE('Customer No. has been created %1',Cust."No.");
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

    trigger OnPostReport()
    begin
        MESSAGE('Done!!');
    end;

    var
        Cust: Record Customer;
}

