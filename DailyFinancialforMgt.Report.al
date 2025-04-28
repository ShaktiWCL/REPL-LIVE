report 50046 "Daily Financial for Mgt"
{
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = FILTER(1));
            column(Current_Date; CurrentDate)
            {
            }
            column(Total_SaleValue; TotalSalesValue)
            {
            }
            column(TotalSalesValue_Debit; TotalSalesValueDebit)
            {
            }
            column(Total_SalesCreditValue; TotalSalesCreditValue)
            {
            }
            column(Net_Sales; NetSales)
            {
            }
            column(TotalSalesValue_Monthly; TotalSalesValueMonthly)
            {
            }
            column(TotalSalesValueDebit_Monthly; TotalSalesValueDebitMonthly)
            {
            }
            column(TotalSalesCreditValue_Monthly; TotalSalesCreditValueMonthly)
            {
            }
            column(NetSales_Monthly; NetSalesMonthly)
            {
            }
            column(TotalSalesValue_Quaterly; TotalSalesValueQuaterly)
            {
            }
            column(TotalSalesValueDebit_Quaterly; TotalSalesValueDebitQuaterly)
            {
            }
            column(TotalSalesCreditValue_Quaterly; TotalSalesCreditValueQuaterly)
            {
            }
            column(NetSales_Quaterly; NetSalesQuaterly)
            {
            }
            column(TotalSalesValue_Yearly; TotalSalesValueYearly)
            {
            }
            column(TotalSalesValueDebit_Yearly; TotalSalesValueDebitYearly)
            {
            }
            column(TotalSalesCreditValue_Yearly; TotalSalesCreditValueYearly)
            {
            }
            column(NetSales_Yearly; NetSalesYearly)
            {
            }
            column(Total_SaleValueBT; TotalSalesValueBT)
            {
            }
            column(TotalSalesValue_DebitBT; TotalSalesValueDebitBT)
            {
            }
            column(Total_SalesCreditValueBT; TotalSalesCreditValueBT)
            {
            }
            column(Net_SalesBT; NetSalesBT)
            {
            }
            column(TotalSalesValue_MonthlyBT; TotalSalesValueMonthlyBT)
            {
            }
            column(TotalSalesValueDebit_MonthlyBT; TotalSalesValueDebitMonthlyBT)
            {
            }
            column(TotalSalesCreditValue_MonthlyBT; TotalSalesCreditValueMonthlyBT)
            {
            }
            column(NetSales_MonthlyBT; NetSalesMonthlyBT)
            {
            }
            column(TotalSalesValue_QuaterlyBT; TotalSalesValueQuaterlyBT)
            {
            }
            column(TotalSalesValueDebit_QuaterlyBT; TotalSalesValueDebitQuaterlyBT)
            {
            }
            column(TotalSalesCreditValue_QuaterlyBT; TotalSalesCreditValueQuaterlyBT)
            {
            }
            column(NetSales_QuaterlyBT; NetSalesQuaterlyBT)
            {
            }
            column(TotalSalesValue_YearlyBT; TotalSalesValueYearlyBT)
            {
            }
            column(TotalSalesValueDebit_YearlyBT; TotalSalesValueDebitYearlyBT)
            {
            }
            column(TotalSalesCreditValue_YearlyBT; TotalSalesCreditValueYearlyBT)
            {
            }
            column(NetSales_YearlyBT; NetSalesYearlyBT)
            {
            }
            column(Total_PurchaseValue; TotalPurchaseValue)
            {
            }
            column(TotalPurchaseValue_Debit; TotalPurchaseValueDebit)
            {
            }
            column(Total_PurchaseCreditValue; TotalPurchaseCreditValue)
            {
            }
            column(Net_Purchase; NetPurchase)
            {
            }
            column(NetPurchase_Monthly; NetPurchaseMonthly)
            {
            }
            column(NetPurchase_Quaterly; NetPurchaseQuaterly)
            {
            }
            column(NetPurchase_Yearly; NetPurchaseYearly)
            {
            }
            column(TotalOther_Expense; TotalOtherExpense)
            {
            }
            column(TotalOtherExpense_Monthly; TotalOtherExpenseMonthly)
            {
            }
            column(TotalOtherExpense_Quaterly; TotalOtherExpenseQuaterly)
            {
            }
            column(TotalOtherExpense_Yearly; TotalOtherExpenseYearly)
            {
            }
            column(Total_Expenses; TotalExpenses)
            {
            }
            column(TotalExpenses_Monthly; TotalExpensesMonthly)
            {
            }
            column(TotalExpenses_Quaterly; TotalExpensesQuaterly)
            {
            }
            column(TotalExpenses_Yearly; TotalExpensesYearly)
            {
            }
            column(TotalPayment_Received; TotalPaymentReceived)
            {
            }
            column(TotalPaymentReceived_Monthly; TotalPaymentReceivedMonthly)
            {
            }
            column(TotalPaymentReceived_Quaterly; TotalPaymentReceivedQuaterly)
            {
            }
            column(TotalPaymentReceived_Yearly; TotalPaymentReceivedYearly)
            {
            }
            column(Total_Receipt; TotalReceipt)
            {
            }
            column(TotalReceipt_Monthly; TotalReceiptMonthly)
            {
            }
            column(TotalReceipt_Quaterly; TotalReceiptQuaterly)
            {
            }
            column(TotalReceipt_Yearly; TotalReceiptYearly)
            {
            }
            column(TotalOtherthenCust_Received; TotalOtherthenCustReceived)
            {
            }
            column(TotalOtherthenCustReceived_Monthly; TotalOtherthenCustReceivedMonthly)
            {
            }
            column(TotalOtherthenCustReceived_Quaterly; TotalOtherthenCustReceivedQuaterly)
            {
            }
            column(TotalOtherthenCustReceived_Yearly; TotalOtherthenCustReceivedYearly)
            {
            }
            column(TotalBankPayment_Value; TotalBankPaymentValue)
            {
            }
            column(TotalBankPaymentValue_Monthly; TotalBankPaymentValueMonthly)
            {
            }
            column(TotalBankPaymentValue_Quaterly; TotalBankPaymentValueQuaterly)
            {
            }
            column(TotalBankPaymentValue_Yearly; TotalBankPaymentValueYearly)
            {
            }
            column(TotalOtherThenVendor_Value; TotalOtherThenVendorValue)
            {
            }
            column(TotalOtherThenVendorValue_Monthly; TotalOtherThenVendorValueMonthly)
            {
            }
            column(TotalOtherThenVendorValue_Quaterly; TotalOtherThenVendorValueQuaterly)
            {
            }
            column(TotalOtherThenVendorValue_Yearly; TotalOtherThenVendorValueYearly)
            {
            }
            column(Total_Payment; TotalPayment)
            {
            }
            column(TotalPayment_Monthly; TotalPaymentMonthly)
            {
            }
            column(TotalPayment_Quaterly; TotalPaymentQuaterly)
            {
            }
            column(TotalPayment_Yearly; TotalPaymentYearly)
            {
            }
            column(GetBankBalance; TotalBankBalanceAmt)
            {
            }
            column(GetODBalance; TotalBankODAmt)
            {
            }
            column(Net_Balance; NetBalance)
            {
            }

            trigger OnAfterGetRecord()
            begin


                //CurrentDate:= CALCDATE('CM', TODAY);
                IF CurrentDate <> 0D THEN BEGIN
                    Next1MonthStartDate := CALCDATE('-CM', CurrentDate);
                    Next1MonthEndDate := CALCDATE('CM', Next1MonthStartDate);
                END ELSE BEGIN
                    CurrentDate := TODAY;
                    Next1MonthStartDate := CALCDATE('-CM', CurrentDate);
                    Next1MonthEndDate := CALCDATE('CM', Next1MonthStartDate);
                END;
                GetQtrDate(CurrentDate);

                GetFYDate(CurrentDate);

                //Sales Before Tax Today
                TotalSalesValueBT := GetTotalSalesInvoiceBT(CurrentDate, CurrentDate);
                TotalSalesValueDebitBT := GetTotalSalesInvoiceDebitBT(CurrentDate, CurrentDate);
                TotalSalesCreditValueBT := GetTotalCreditMemoBT(CurrentDate, CurrentDate);
                NetSalesBT := (GetTotalSalesInvoiceBT(CurrentDate, CurrentDate) + GetTotalSalesInvoiceDebitBT(CurrentDate, CurrentDate)) - GetTotalCreditMemoBT(CurrentDate, CurrentDate);
                //Sales Before Tax Monthly
                TotalSalesValueMonthlyBT := GetTotalSalesInvoiceBT(Next1MonthStartDate, Next1MonthEndDate);
                TotalSalesValueDebitMonthlyBT := GetTotalSalesInvoiceDebitBT(Next1MonthStartDate, Next1MonthEndDate);
                TotalSalesCreditValueMonthlyBT := GetTotalCreditMemoBT(Next1MonthStartDate, Next1MonthEndDate);
                NetSalesMonthlyBT := (GetTotalSalesInvoiceMonthlyBT(Next1MonthStartDate, Next1MonthEndDate) + GetTotalSalesInvoiceDebitMonthlyBT(Next1MonthStartDate, Next1MonthEndDate)) - GetTotalCreditMemoMonthlyBT(Next1MonthStartDate, Next1MonthEndDate);

                //Sales Before Tax Quaterly
                TotalSalesValueQuaterlyBT := GetTotalSalesInvoiceBT(Next1QuaterStartDate, Next1QuaterEndDate);
                TotalSalesValueDebitQuaterlyBT := GetTotalSalesInvoiceDebitBT(Next1QuaterStartDate, Next1QuaterEndDate);
                TotalSalesCreditValueQuaterlyBT := GetTotalCreditMemoBT(Next1QuaterStartDate, Next1QuaterEndDate);
                NetSalesQuaterlyBT := (GetTotalSalesInvoiceQuaterlyBT(Next1QuaterStartDate, Next1QuaterEndDate) + GetTotalSalesInvoiceDebitQuaterlyBT(Next1QuaterStartDate, Next1QuaterEndDate)) - GetTotalCreditMemoQuaterlyBT(Next1QuaterStartDate, Next1QuaterEndDate);

                //Sales Before Tax Yearly
                TotalSalesValueYearlyBT := GetTotalSalesInvoiceBT(Next1YearStartDate, Next1YearEndDate);
                TotalSalesValueDebitYearlyBT := GetTotalSalesInvoiceDebitBT(Next1YearStartDate, Next1YearEndDate);
                TotalSalesCreditValueYearlyBT := GetTotalCreditMemoBT(Next1YearStartDate, Next1YearEndDate);
                NetSalesYearlyBT := (GetTotalSalesInvoiceYearlyBT(Next1YearStartDate, Next1YearEndDate) + GetTotalSalesInvoiceDebitYearlyBT(Next1YearStartDate, Next1YearEndDate)) - GetTotalCreditMemoYearlyBT(Next1YearStartDate, Next1YearEndDate);



                //Sales Today
                TotalSalesValue := GetTotalSalesInvoice(CurrentDate, CurrentDate);
                TotalSalesValueDebit := GetTotalSalesInvoiceDebit(CurrentDate, CurrentDate);
                TotalSalesCreditValue := GetTotalCreditMemo(CurrentDate, CurrentDate);
                NetSales := (GetTotalSalesInvoice(CurrentDate, CurrentDate) + GetTotalSalesInvoiceDebit(CurrentDate, CurrentDate)) - GetTotalCreditMemo(CurrentDate, CurrentDate);
                //Sales Monthly
                TotalSalesValueMonthly := GetTotalSalesInvoice(Next1MonthStartDate, Next1MonthEndDate);
                TotalSalesValueDebitMonthly := GetTotalSalesInvoiceDebit(Next1MonthStartDate, Next1MonthEndDate);
                TotalSalesCreditValueMonthly := GetTotalCreditMemo(Next1MonthStartDate, Next1MonthEndDate);
                NetSalesMonthly := (GetTotalSalesInvoiceMonthly(Next1MonthStartDate, Next1MonthEndDate) + GetTotalSalesInvoiceDebitMonthly(Next1MonthStartDate, Next1MonthEndDate)) - GetTotalCreditMemoMonthly(Next1MonthStartDate, Next1MonthEndDate);

                //Sales Quaterly
                TotalSalesValueQuaterly := GetTotalSalesInvoice(Next1QuaterStartDate, Next1QuaterEndDate);
                TotalSalesValueDebitQuaterly := GetTotalSalesInvoiceDebit(Next1QuaterStartDate, Next1QuaterEndDate);
                TotalSalesCreditValueQuaterly := GetTotalCreditMemo(Next1QuaterStartDate, Next1QuaterEndDate);
                NetSalesQuaterly := (GetTotalSalesInvoiceQuaterly(Next1QuaterStartDate, Next1QuaterEndDate) + GetTotalSalesInvoiceDebitQuaterly(Next1QuaterStartDate, Next1QuaterEndDate)) - GetTotalCreditMemoQuaterly(Next1QuaterStartDate, Next1QuaterEndDate);

                //Sales Yearly
                TotalSalesValueYearly := GetTotalSalesInvoice(Next1YearStartDate, Next1YearEndDate);
                TotalSalesValueDebitYearly := GetTotalSalesInvoiceDebit(Next1YearStartDate, Next1YearEndDate);
                TotalSalesCreditValueYearly := GetTotalCreditMemo(Next1YearStartDate, Next1YearEndDate);
                NetSalesYearly := (GetTotalSalesInvoiceYearly(Next1YearStartDate, Next1YearEndDate) + GetTotalSalesInvoiceDebitYearly(Next1YearStartDate, Next1YearEndDate)) - GetTotalCreditMemoYearly(Next1YearStartDate, Next1YearEndDate);



                //Purchase Today
                TotalPurchaseValue := ABS(GetTotalPurchaseInvoice(CurrentDate, CurrentDate));
                TotalPurchaseValueDebit := ABS(GetTotalPurchaseInvoiceDebit(CurrentDate, CurrentDate));
                TotalPurchaseCreditValue := ABS(GetTotalPurchCreditMemo(CurrentDate, CurrentDate));

                //Total Purchase Monthly Quaterly and Yearly
                NetPurchase := (ABS(GetTotalPurchaseInvoice(CurrentDate, CurrentDate)) + ABS(GetTotalPurchaseInvoiceDebit(CurrentDate, CurrentDate))) - (ABS(GetTotalPurchCreditMemo(CurrentDate, CurrentDate)));
                NetPurchaseMonthly := (ABS(GetTotalPurchaseInvoiceMonthly(Next1MonthStartDate, Next1MonthEndDate)) + ABS(GetTotalPurchaseInvoiceDebitMonthly(Next1MonthStartDate, Next1MonthEndDate))) - (ABS
                (GetTotalPurchCreditMemoMonthly(Next1MonthStartDate, Next1MonthEndDate)));
                NetPurchaseQuaterly := (ABS(GetTotalPurchaseInvoiceQuaterly(Next1QuaterStartDate, Next1QuaterEndDate))
                + ABS(GetTotalPurchaseInvoiceDebitQuaterly(Next1QuaterStartDate, Next1QuaterEndDate))) - (ABS(GetTotalPurchCreditMemoQuaterly(Next1QuaterStartDate, Next1QuaterEndDate)));

                NetPurchaseYearly := (ABS(GetTotalPurchaseInvoiceYearly(Next1YearStartDate, Next1YearEndDate))
                + ABS(GetTotalPurchaseInvoiceDebitYearly(Next1YearStartDate, Next1YearEndDate))) - (ABS(GetTotalPurchCreditMemoYearly(Next1YearStartDate, Next1YearEndDate)));

                // Total Other Expense Daily, Monthly Quaterly and Yearly
                TotalOtherExpense := ABS(GetOtherExpenses(CurrentDate, CurrentDate));
                TotalOtherExpenseMonthly := ABS(GetOtherExpenses(Next1MonthStartDate, Next1MonthEndDate));
                TotalOtherExpenseQuaterly := ABS(GetOtherExpenses(Next1QuaterStartDate, Next1QuaterEndDate));
                TotalOtherExpenseYearly := ABS(GetOtherExpenses(Next1YearStartDate, Next1YearEndDate));
                //Total Expenses
                TotalExpenses := NetPurchase + TotalOtherExpense;
                TotalExpensesMonthly := NetPurchaseMonthly + TotalOtherExpenseMonthly;
                TotalExpensesQuaterly := NetPurchaseQuaterly + TotalOtherExpenseQuaterly;
                TotalExpensesYearly := NetPurchaseYearly + TotalOtherExpenseYearly;

                // Total Payment received Daily, Monthly Quaterly and Yearly
                TotalPaymentReceived := GetPaymentCustomerReceived(CurrentDate, CurrentDate);
                TotalPaymentReceivedMonthly := GetPaymentCustomerReceived(Next1MonthStartDate, Next1MonthEndDate);
                TotalPaymentReceivedQuaterly := GetPaymentCustomerReceived(Next1QuaterStartDate, Next1QuaterEndDate);
                TotalPaymentReceivedYearly := GetPaymentCustomerReceived(Next1YearStartDate, Next1YearEndDate);

                // Total Other then Customer received Daily, Monthly Quaterly and Yearly
                TotalOtherthenCustReceived := ABS(GetOtherThenCustomerReceived(CurrentDate, CurrentDate)) - ABS(GetPaymentCustomerReceived(CurrentDate, CurrentDate));
                TotalOtherthenCustReceivedMonthly := ABS(GetOtherThenCustomerReceived(Next1MonthStartDate, Next1MonthEndDate)) - ABS(GetPaymentCustomerReceived(Next1MonthStartDate, Next1MonthEndDate));
                TotalOtherthenCustReceivedQuaterly := ABS(GetOtherThenCustomerReceived(Next1QuaterStartDate, Next1QuaterEndDate)) - ABS(GetPaymentCustomerReceived(Next1QuaterStartDate, Next1QuaterEndDate));
                TotalOtherthenCustReceivedYearly := ABS(GetOtherThenCustomerReceived(Next1YearStartDate, Next1YearEndDate)) - ABS(GetPaymentCustomerReceived(Next1YearStartDate, Next1YearEndDate));

                //Total Receipt Daily, Monthly Quaterly and Yearly
                TotalReceipt := ABS(GetOtherThenCustomerReceived(CurrentDate, CurrentDate));//+GetPaymentCustomerReceived(CurrentDate,CurrentDate);
                TotalReceiptMonthly := ABS(GetOtherThenCustomerReceived(Next1MonthStartDate, Next1MonthEndDate));
                TotalReceiptQuaterly := ABS(GetOtherThenCustomerReceived(Next1QuaterStartDate, Next1QuaterEndDate));
                TotalReceiptYearly := ABS(GetOtherThenCustomerReceived(Next1YearStartDate, Next1YearEndDate));

                //Total Vendor Payment Daily, Monthly Quaterly and Yearly
                TotalBankPaymentValue := ABS(GetVendorPaymentPaid(CurrentDate, CurrentDate));
                TotalBankPaymentValueMonthly := ABS(GetVendorPaymentPaid(Next1MonthStartDate, Next1MonthEndDate));
                TotalBankPaymentValueQuaterly := ABS(GetVendorPaymentPaid(Next1QuaterStartDate, Next1QuaterEndDate));
                TotalBankPaymentValueYearly := ABS(GetVendorPaymentPaid(Next1YearStartDate, Next1YearEndDate));



                //Total Other then Vendor Payment Daily, Monthly Quaterly and Yearly
                TotalOtherThenVendorValue := ABS(GetOtherThenVendorPaymentPaid(CurrentDate, CurrentDate)) - ABS(GetVendorPaymentPaid(CurrentDate, CurrentDate));
                TotalOtherThenVendorValueMonthly := ABS(GetOtherThenVendorPaymentPaid(Next1MonthStartDate, Next1MonthEndDate)) - ABS(GetVendorPaymentPaid(Next1MonthStartDate, Next1MonthEndDate));
                TotalOtherThenVendorValueQuaterly := ABS(GetOtherThenVendorPaymentPaid(Next1QuaterStartDate, Next1QuaterEndDate)) - ABS(GetVendorPaymentPaid(Next1QuaterStartDate, Next1QuaterEndDate));
                TotalOtherThenVendorValueYearly := ABS(GetOtherThenVendorPaymentPaid(Next1YearStartDate, Next1YearEndDate)) - ABS(GetVendorPaymentPaid(Next1YearStartDate, Next1YearEndDate));

                //Total Payment Daily, Monthly Quaterly and Yearly
                TotalPayment := GetOtherThenVendorPaymentPaid(CurrentDate, CurrentDate);
                TotalPaymentMonthly := GetOtherThenVendorPaymentPaid(Next1MonthStartDate, Next1MonthEndDate);
                TotalPaymentQuaterly := GetOtherThenVendorPaymentPaid(Next1QuaterStartDate, Next1QuaterEndDate);
                TotalPaymentYearly := GetOtherThenVendorPaymentPaid(Next1YearStartDate, Next1YearEndDate);

                //Bank Balnace as on Daily
                TotalBankBalanceAmt := GetBankBalace;
                TotalBankODAmt := GetODBalace;
                NetBalance := GetBankBalace - GetODBalace;


                SendEmailDetails;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Current Date"; CurrentDate)
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
        Month: Integer;
        Year: Integer;
        StartDate: Date;
        EndDate: Date;
        TotalSalesValue: Decimal;
        TotalSalesValueDebit: Decimal;
        TotalSalesCreditValue: Decimal;
        NetSales: Decimal;
        TotalPurchaseValue: Decimal;
        TotalPurchaseValueDebit: Decimal;
        TotalPurchaseCreditValue: Decimal;
        NetPurchase: Decimal;
        NetPurchaseMonthly: Decimal;
        NetPurchaseQuaterly: Decimal;
        NetPurchaseYearly: Decimal;
        TotalOtherExpense: Decimal;
        TotalOtherExpenseMonthly: Decimal;
        TotalOtherExpenseQuaterly: Decimal;
        TotalOtherExpenseYearly: Decimal;
        TotalExpenses: Decimal;
        TotalExpensesMonthly: Decimal;
        TotalExpensesQuaterly: Decimal;
        TotalExpensesYearly: Decimal;
        TotalPaymentReceived: Decimal;
        TotalPaymentReceivedMonthly: Decimal;
        TotalPaymentReceivedQuaterly: Decimal;
        TotalPaymentReceivedYearly: Decimal;
        TotalReceipt: Decimal;
        TotalReceiptMonthly: Decimal;
        TotalReceiptQuaterly: Decimal;
        TotalReceiptYearly: Decimal;
        TotalOtherthenCustReceived: Decimal;
        TotalOtherthenCustReceivedMonthly: Decimal;
        TotalOtherthenCustReceivedQuaterly: Decimal;
        TotalOtherthenCustReceivedYearly: Decimal;
        TotalBankPaymentValue: Decimal;
        TotalBankPaymentValueMonthly: Decimal;
        TotalBankPaymentValueQuaterly: Decimal;
        TotalBankPaymentValueYearly: Decimal;
        TotalOtherThenVendorValue: Decimal;
        TotalOtherThenVendorValueMonthly: Decimal;
        TotalOtherThenVendorValueQuaterly: Decimal;
        TotalOtherThenVendorValueYearly: Decimal;
        TotalPayment: Decimal;
        TotalPaymentMonthly: Decimal;
        TotalPaymentQuaterly: Decimal;
        TotalPaymentYearly: Decimal;
        TotalBankBalanceAmt: Decimal;
        TotalBankODAmt: Decimal;
        NetBalance: Decimal;
        "----Month---------------": Integer;
        CurrentDate: Date;
        Next1MonthStartDate: Date;
        Next1MonthEndDate: Date;
        Next1QuaterStartDate: Date;
        Next1QuaterEndDate: Date;
        Next1YearStartDate: Date;
        Next1YearEndDate: Date;
        TotalSalesValueMonthly: Decimal;
        TotalSalesValueDebitMonthly: Decimal;
        TotalSalesCreditValueMonthly: Decimal;
        NetSalesMonthly: Decimal;
        "---Quaterly----": Integer;
        TotalSalesValueQuaterly: Decimal;
        TotalSalesValueDebitQuaterly: Decimal;
        TotalSalesCreditValueQuaterly: Decimal;
        NetSalesQuaterly: Decimal;
        "---Yearly----": Integer;
        TotalSalesValueYearly: Decimal;
        TotalSalesValueDebitYearly: Decimal;
        TotalSalesCreditValueYearly: Decimal;
        NetSalesYearly: Decimal;
        CodeMail: Codeunit Mail;
        "----Before Tax---": Integer;
        TotalSalesValueBT: Decimal;
        TotalSalesValueDebitBT: Decimal;
        TotalSalesCreditValueBT: Decimal;
        NetSalesBT: Decimal;
        "---Monthly---": Integer;
        TotalSalesValueMonthlyBT: Decimal;
        TotalSalesValueDebitMonthlyBT: Decimal;
        TotalSalesCreditValueMonthlyBT: Decimal;
        NetSalesMonthlyBT: Decimal;
        "----Quaterly----": Integer;
        TotalSalesValueQuaterlyBT: Decimal;
        TotalSalesValueDebitQuaterlyBT: Decimal;
        TotalSalesCreditValueQuaterlyBT: Decimal;
        NetSalesQuaterlyBT: Decimal;
        "----YEarly----": Integer;
        TotalSalesValueYearlyBT: Decimal;
        TotalSalesValueDebitYearlyBT: Decimal;
        TotalSalesCreditValueYearlyBT: Decimal;
        NetSalesYearlyBT: Decimal;

    procedure GetTotalSalesInvoice(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SetFilter(SaleInvHeader."Type Of Note", '<>%1', SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalSalesInvoiceDebit(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SETRANGE(SaleInvHeader."Type Of Note", SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalCreditMemo(StartDate: Date; EndDate: Date) TotalCreditMemoAmt: Decimal
    var
        SaleCrMemoHrd: Record "Sales Cr.Memo Header";
    begin
        TotalCreditMemoAmt := 0;
        SaleCrMemoHrd.RESET;
        SaleCrMemoHrd.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleCrMemoHrd.FINDFIRST THEN BEGIN
            REPEAT
                SaleCrMemoHrd.CALCFIELDS(Amount);
                TotalCreditMemoAmt += SaleCrMemoHrd.Amount;
            UNTIL SaleCrMemoHrd.NEXT = 0;
        END;
        EXIT(TotalCreditMemoAmt);
    end;

    procedure GetTotalPurchaseInvoice(StartDate: Date; EndDate: Date) TotalPurchaseAmt: Decimal
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        TotalPurchaseAmt := 0;
        PurchInvHeader.RESET;
        PurchInvHeader.SetFilter("Type Of Note", '<>%1', PurchInvHeader."Type Of Note"::Credit);
        PurchInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                PurchInvHeader.CALCFIELDS(Amount);
                TotalPurchaseAmt += PurchInvHeader.Amount;
            UNTIL PurchInvHeader.NEXT = 0;
        END;
        EXIT(TotalPurchaseAmt);
    end;

    procedure GetTotalPurchaseInvoiceDebit(StartDate: Date; EndDate: Date) TotalPurchaseAmt: Decimal
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        TotalPurchaseAmt := 0;
        PurchInvHeader.RESET;
        PurchInvHeader.SETRANGE(PurchInvHeader."Type Of Note", PurchInvHeader."Type Of Note"::Credit);
        PurchInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                PurchInvHeader.CALCFIELDS(Amount);
                TotalPurchaseAmt += PurchInvHeader.Amount;
            UNTIL PurchInvHeader.NEXT = 0;
        END;
        EXIT(TotalPurchaseAmt);
    end;

    procedure GetTotalPurchCreditMemo(StartDate: Date; EndDate: Date) TotalPurchCreditAmt: Decimal
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    begin
        TotalPurchCreditAmt := 0;
        PurchCrMemoHdr.RESET;
        PurchCrMemoHdr.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
            REPEAT
                PurchCrMemoHdr.CALCFIELDS(Amount);
                TotalPurchCreditAmt += PurchCrMemoHdr.Amount;
            UNTIL PurchCrMemoHdr.NEXT = 0;
        END;
        EXIT(TotalPurchCreditAmt);
    end;

    procedure GetOtherExpenses(StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        TotalExpense: Decimal;
    begin
        TotalExpense := 0;
        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
        GLEntry.SETFILTER("G/L Account No.", '>%1', '400000');
        GLEntry.SETRANGE("Posting Date", StartDate, EndDate);
        GLEntry.SETFILTER("Document Type", '%1', GLEntry."Document Type"::" ");
        IF GLEntry.FINDSET THEN BEGIN
            REPEAT
                IF (GLEntry."Source Code" = 'JOURNALV') THEN// OR (GLEntry."Source Code" = '') THEN
                    TotalExpense += GLEntry.Amount;
            UNTIL GLEntry.NEXT = 0;
        END;
        EXIT(TotalExpense);
    end;

    procedure GetPaymentCustomerReceived(StartDate: Date; EndDate: Date) TotalReceiptAmount: Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry2: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.RESET;
        CustLedgEntry.SETCURRENTKEY("Source Code", "Posting Date");
        CustLedgEntry.SETFILTER("Source Code", '%1', 'BANKRCPTV');
        CustLedgEntry.SETRANGE("Posting Date", StartDate, EndDate);
        IF CustLedgEntry.FINDSET THEN BEGIN
            REPEAT
                CustLedgEntry2.RESET;
                CustLedgEntry2.SETRANGE("Document No.", CustLedgEntry."Document No.");
                IF CustLedgEntry2.FINDFIRST THEN BEGIN
                    REPEAT
                        CustLedgEntry2.CALCFIELDS("Amount (LCY)");
                        TotalReceiptAmount += (CustLedgEntry2."Amount (LCY)");
                    UNTIL CustLedgEntry2.NEXT = 0;
                END;
            UNTIL CustLedgEntry.NEXT = 0;
        END;
        EXIT(TotalReceiptAmount);
    end;

    procedure GetOtherThenCustomerReceived(StartDate: Date; EndDate: Date) TotatOtherthenCustomerRevd: Decimal
    var
        VendLedEntry: Record "Vendor Ledger Entry";
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        BankAccLedEntry: Record "Bank Account Ledger Entry";
        BankAccLedEntry2: Record "Bank Account Ledger Entry";
    begin
        TotatOtherthenCustomerRevd := 0;
        BankAccLedEntry.RESET;
        BankAccLedEntry.SETCURRENTKEY("Bank Account No.", "Posting Date");
        BankAccLedEntry.SETFILTER("Source Code", '%1', 'BANKRCPTV');
        BankAccLedEntry.SETRANGE("Posting Date", StartDate, EndDate);
        IF BankAccLedEntry.FINDSET THEN BEGIN
            REPEAT
                BankAccLedEntry2.RESET;
                BankAccLedEntry2.SETRANGE("Document No.", BankAccLedEntry."Document No.");
                IF BankAccLedEntry2.FINDFIRST THEN BEGIN
                    REPEAT
                        TotatOtherthenCustomerRevd += BankAccLedEntry2."Amount (LCY)";
                    UNTIL BankAccLedEntry2.NEXT = 0;
                END;
            UNTIL BankAccLedEntry.NEXT = 0;
        END;
        EXIT(TotatOtherthenCustomerRevd);
    end;

    procedure GetVendorPaymentPaid(StartDate: Date; EndDate: Date) TotalBankPayment: Decimal
    var
        VendLedEntry: Record "Vendor Ledger Entry";
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        VendLedEntry2: Record "Vendor Ledger Entry";
    begin
        TotalBankPayment := 0;
        VendLedEntry.RESET;
        VendLedEntry.SETCURRENTKEY("Source Code", "Posting Date");
        VendLedEntry.SETFILTER("Source Code", '%1', 'BANKPYMTV');
        VendLedEntry.SETRANGE("Posting Date", StartDate, EndDate);
        IF VendLedEntry.FINDSET THEN BEGIN
            REPEAT
                VendLedEntry2.RESET;
                VendLedEntry2.SETRANGE("Document No.", VendLedEntry."Document No.");
                IF VendLedEntry2.FINDFIRST THEN BEGIN
                    REPEAT
                        VendLedEntry2.CALCFIELDS("Amount (LCY)");
                        TotalBankPayment += (VendLedEntry2."Amount (LCY)") - (VendLedEntry2."Total TDS Including SHE CESS" * VendLedEntry2."Adjusted Currency Factor");

                    UNTIL VendLedEntry2.NEXT = 0;
                END;
            UNTIL VendLedEntry.NEXT = 0;
        END;
        EXIT(TotalBankPayment);
    end;

    procedure GetOtherThenVendorPaymentPaid(StartDate: Date; EndDate: Date) TotatOtherPayment: Decimal
    var
        VendLedEntry: Record "Vendor Ledger Entry";
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        BankAccLedEntry: Record "Bank Account Ledger Entry";
        BankAccLedEntry2: Record "Bank Account Ledger Entry";
    begin
        TotatOtherPayment := 0;
        BankAccLedEntry.RESET;
        BankAccLedEntry.SETCURRENTKEY("Bank Account No.", "Posting Date");
        BankAccLedEntry.SETFILTER("Source Code", '%1', 'BANKPYMTV');
        BankAccLedEntry.SETRANGE("Posting Date", StartDate, EndDate);
        IF BankAccLedEntry.FINDSET THEN BEGIN
            REPEAT
                BankAccLedEntry2.RESET;
                BankAccLedEntry2.SETRANGE("Document No.", BankAccLedEntry."Document No.");
                IF BankAccLedEntry2.FINDFIRST THEN BEGIN
                    REPEAT
                        TotatOtherPayment += BankAccLedEntry2."Amount (LCY)";
                    UNTIL BankAccLedEntry2.NEXT = 0;
                END;
            UNTIL BankAccLedEntry.NEXT = 0;
        END;
        EXIT(TotatOtherPayment);
    end;

    procedure GetBankBalace() BankBalance: Decimal
    var
        BankAccLedger: Record "Bank Account Ledger Entry";
    begin
        //BankBalance:=0;
        BankAccLedger.SETCURRENTKEY("Bank Account No.", "Posting Date");
        BankAccLedger.SETFILTER("Bank Account No.", '<>%1', 'BANK-042');
        BankAccLedger.SETRANGE("Posting Date", 0D, TODAY);
        IF BankAccLedger.FINDFIRST THEN BEGIN
            BankAccLedger.CALCSUMS(BankAccLedger."Amount (LCY)");
            BankBalance := ABS(BankAccLedger."Amount (LCY)");
        END;
        EXIT(BankBalance);
    end;


    procedure GetODBalace() ODLimit: Decimal
    var
        BankAccLedger2: Record "Bank Account Ledger Entry";
    begin
        //ODLimit:=0;
        BankAccLedger2.SETCURRENTKEY("Bank Account No.", "Posting Date");
        BankAccLedger2.SETRANGE("Bank Account No.", 'BANK-042');
        BankAccLedger2.SETRANGE("Posting Date", 0D, TODAY);
        IF BankAccLedger2.FINDFIRST THEN BEGIN
            BankAccLedger2.CALCSUMS("Amount (LCY)");
            ODLimit := ABS(BankAccLedger2."Amount (LCY)");
        END;

        EXIT(ODLimit);
    end;

    procedure "------Mothly Sales----"()
    begin
    end;

    procedure GetTotalSalesInvoiceMonthly(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SetFilter(SaleInvHeader."Type Of Note", '<>%1', SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalSalesInvoiceDebitMonthly(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SETRANGE(SaleInvHeader."Type Of Note", SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalCreditMemoMonthly(StartDate: Date; EndDate: Date) TotalCreditMemoAmt: Decimal
    var
        SaleCrMemoHrd: Record "Sales Cr.Memo Header";
    begin
        TotalCreditMemoAmt := 0;
        SaleCrMemoHrd.RESET;
        SaleCrMemoHrd.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleCrMemoHrd.FINDFIRST THEN BEGIN
            REPEAT
                SaleCrMemoHrd.CALCFIELDS(Amount);
                TotalCreditMemoAmt += SaleCrMemoHrd.Amount;
            UNTIL SaleCrMemoHrd.NEXT = 0;
        END;
        EXIT(TotalCreditMemoAmt);
    end;

    procedure "---Quaterly Sales---"()
    begin
    end;

    procedure GetTotalSalesInvoiceQuaterly(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SetFilter(SaleInvHeader."Type Of Note", '<>%1', SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalSalesInvoiceDebitQuaterly(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SETRANGE(SaleInvHeader."Type Of Note", SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalCreditMemoQuaterly(StartDate: Date; EndDate: Date) TotalCreditMemoAmt: Decimal
    var
        SaleCrMemoHrd: Record "Sales Cr.Memo Header";
    begin
        TotalCreditMemoAmt := 0;
        SaleCrMemoHrd.RESET;
        SaleCrMemoHrd.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleCrMemoHrd.FINDFIRST THEN BEGIN
            REPEAT
                SaleCrMemoHrd.CALCFIELDS(Amount);
                TotalCreditMemoAmt += SaleCrMemoHrd.Amount;
            UNTIL SaleCrMemoHrd.NEXT = 0;
        END;
        EXIT(TotalCreditMemoAmt);
    end;

    procedure "---Yearly Sales---"()
    begin
    end;


    procedure GetTotalSalesInvoiceYearly(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SetFilter(SaleInvHeader."Type Of Note", '<>%1', SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalSalesInvoiceDebitYearly(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SETRANGE(SaleInvHeader."Type Of Note", SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalCreditMemoYearly(StartDate: Date; EndDate: Date) TotalCreditMemoAmt: Decimal
    var
        SaleCrMemoHrd: Record "Sales Cr.Memo Header";
    begin
        TotalCreditMemoAmt := 0;
        SaleCrMemoHrd.RESET;
        SaleCrMemoHrd.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleCrMemoHrd.FINDFIRST THEN BEGIN
            REPEAT
                SaleCrMemoHrd.CALCFIELDS(Amount);
                TotalCreditMemoAmt += SaleCrMemoHrd.Amount;
            UNTIL SaleCrMemoHrd.NEXT = 0;
        END;
        EXIT(TotalCreditMemoAmt);
    end;

    procedure GetQtrDate(Date1: Date)
    var
        Month1: Integer;
    begin
        Month1 := DATE2DMY(Date1, 2);

        IF Month1 IN [1, 2, 3] THEN BEGIN
            Next1QuaterStartDate := DMY2DATE(1, 1, DATE2DMY(Date1, 3));
            Next1QuaterEndDate := DMY2DATE(31, 3, DATE2DMY(Date1, 3));
        END;
        IF Month1 IN [4, 5, 6] THEN BEGIN
            Next1QuaterStartDate := DMY2DATE(1, 4, DATE2DMY(Date1, 3));
            Next1QuaterEndDate := DMY2DATE(30, 6, DATE2DMY(Date1, 3));
        END;
        IF Month1 IN [7, 8, 9] THEN BEGIN
            Next1QuaterStartDate := DMY2DATE(1, 7, DATE2DMY(Date1, 3));
            Next1QuaterEndDate := DMY2DATE(30, 9, DATE2DMY(Date1, 3));
        END;
        IF Month1 IN [10, 11, 12] THEN BEGIN
            Next1QuaterStartDate := DMY2DATE(1, 10, DATE2DMY(Date1, 3));
            Next1QuaterEndDate := DMY2DATE(31, 12, DATE2DMY(Date1, 3));
        END;
    end;

    procedure GetFYDate(Date1: Date)
    var
        Month1: Integer;
        Year1: Integer;
        Year2: Integer;
    begin
        Month1 := DATE2DMY(Date1, 2);
        Year1 := DATE2DMY(Date1, 3);

        IF Month1 IN [1, 2, 3] THEN
            Year2 := Year1 - 1
        ELSE
            Year2 := Year1;

        Next1YearStartDate := DMY2DATE(1, 4, Year2);
        Next1YearEndDate := DMY2DATE(31, 3, Year2 + 1);
    end;

    procedure "----Total Monthly Purchase----"()
    begin
    end;


    procedure GetTotalPurchaseInvoiceMonthly(StartDate: Date; EndDate: Date) TotalPurchaseAmt: Decimal
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        TotalPurchaseAmt := 0;
        PurchInvHeader.RESET;
        PurchInvHeader.SetFilter("Type Of Note", '<>%1', PurchInvHeader."Type Of Note"::Credit);
        PurchInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                PurchInvHeader.CALCFIELDS(Amount);
                TotalPurchaseAmt += PurchInvHeader.Amount;
            UNTIL PurchInvHeader.NEXT = 0;
        END;
        EXIT(TotalPurchaseAmt);
    end;

    procedure GetTotalPurchaseInvoiceDebitMonthly(StartDate: Date; EndDate: Date) TotalPurchaseAmt: Decimal
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        TotalPurchaseAmt := 0;
        PurchInvHeader.RESET;
        PurchInvHeader.SETRANGE(PurchInvHeader."Type Of Note", PurchInvHeader."Type Of Note"::Credit);
        PurchInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                PurchInvHeader.CALCFIELDS(Amount);
                TotalPurchaseAmt += PurchInvHeader.Amount;
            UNTIL PurchInvHeader.NEXT = 0;
        END;
        EXIT(TotalPurchaseAmt);
    end;

    procedure GetTotalPurchCreditMemoMonthly(StartDate: Date; EndDate: Date) TotalPurchCreditAmt: Decimal
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    begin
        TotalPurchCreditAmt := 0;
        PurchCrMemoHdr.RESET;
        PurchCrMemoHdr.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
            REPEAT
                PurchCrMemoHdr.CALCFIELDS(Amount);
                TotalPurchCreditAmt += PurchCrMemoHdr.Amount;
            UNTIL PurchCrMemoHdr.NEXT = 0;
        END;
        EXIT(TotalPurchCreditAmt);
    end;

    procedure GetTotalPurchaseInvoiceQuaterly(StartDate: Date; EndDate: Date) TotalPurchaseAmt: Decimal
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        TotalPurchaseAmt := 0;
        PurchInvHeader.RESET;
        PurchInvHeader.SetFilter("Type Of Note", '<>%1', PurchInvHeader."Type Of Note"::Credit);
        PurchInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                PurchInvHeader.CALCFIELDS(Amount);
                TotalPurchaseAmt += PurchInvHeader.Amount;
            UNTIL PurchInvHeader.NEXT = 0;
        END;
        EXIT(TotalPurchaseAmt);
    end;

    procedure GetTotalPurchaseInvoiceDebitQuaterly(StartDate: Date; EndDate: Date) TotalPurchaseAmt: Decimal
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        TotalPurchaseAmt := 0;
        PurchInvHeader.RESET;
        PurchInvHeader.SETRANGE(PurchInvHeader."Type Of Note", PurchInvHeader."Type Of Note"::Credit);
        PurchInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                PurchInvHeader.CALCFIELDS(Amount);
                TotalPurchaseAmt += PurchInvHeader.Amount;
            UNTIL PurchInvHeader.NEXT = 0;
        END;
        EXIT(TotalPurchaseAmt);
    end;

    procedure GetTotalPurchCreditMemoQuaterly(StartDate: Date; EndDate: Date) TotalPurchCreditAmt: Decimal
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    begin
        TotalPurchCreditAmt := 0;
        PurchCrMemoHdr.RESET;
        PurchCrMemoHdr.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
            REPEAT
                PurchCrMemoHdr.CALCFIELDS(Amount);
                TotalPurchCreditAmt += PurchCrMemoHdr.Amount;
            UNTIL PurchCrMemoHdr.NEXT = 0;
        END;
        EXIT(TotalPurchCreditAmt);
    end;

    procedure GetTotalPurchaseInvoiceYearly(StartDate: Date; EndDate: Date) TotalPurchaseAmt: Decimal
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        TotalPurchaseAmt := 0;
        PurchInvHeader.RESET;
        PurchInvHeader.SetFilter("Type Of Note", '<>%1', PurchInvHeader."Type Of Note"::Credit);
        PurchInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                PurchInvHeader.CALCFIELDS(Amount);
                TotalPurchaseAmt += PurchInvHeader.Amount;
            UNTIL PurchInvHeader.NEXT = 0;
        END;
        EXIT(TotalPurchaseAmt);
    end;

    procedure GetTotalPurchaseInvoiceDebitYearly(StartDate: Date; EndDate: Date) TotalPurchaseAmt: Decimal
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        TotalPurchaseAmt := 0;
        PurchInvHeader.RESET;
        PurchInvHeader.SETRANGE(PurchInvHeader."Type Of Note", PurchInvHeader."Type Of Note"::Credit);
        PurchInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                PurchInvHeader.CALCFIELDS(Amount);
                TotalPurchaseAmt += PurchInvHeader.Amount;
            UNTIL PurchInvHeader.NEXT = 0;
        END;
        EXIT(TotalPurchaseAmt);
    end;

    procedure GetTotalPurchCreditMemoYearly(StartDate: Date; EndDate: Date) TotalPurchCreditAmt: Decimal
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    begin
        TotalPurchCreditAmt := 0;
        PurchCrMemoHdr.RESET;
        PurchCrMemoHdr.SETRANGE("Posting Date", StartDate, EndDate);
        IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
            REPEAT
                PurchCrMemoHdr.CALCFIELDS(Amount);
                TotalPurchCreditAmt += PurchCrMemoHdr.Amount;
            UNTIL PurchCrMemoHdr.NEXT = 0;
        END;
        EXIT(TotalPurchCreditAmt);
    end;

    procedure "-------------------Mail-------------------------------------------"()
    begin
    end;

    local procedure SendEmailDetails()
    var
        Subject: Text;
        Body: Text;
        SMTPMail: Codeunit Mail;
    begin
        Subject := 'Financial Detail (' + COMPANYNAME + ')';
        Body := ('</BR>' + 'Dear Sir,' + '</BR><BR><BR>' + 'Please find below daily basis Financial detail:-  '
                + '<div id="div1" width="100%">'
                + '<table align="left" border="1">'
                + '<tr>'
                + '<th colspan="3"><FONT COLOR=BLACK><FONT SIZE=3>Bank Balance as on Date</th>'
                + '</tr>'
                + '<tr>'
                + '<th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Team</th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Balance</Th>'
                + '</tr>'
                + GetBankBodyDataEntry
                + '</table>'
                + '</div>'
                //Income
                + '</BR><BR><BR><BR><BR><BR><BR><BR><BR>'
                + '<div id="div2" width="100%">'
                + '<table align="left"  border="1">'
                + '<tr>'
                + '<Th colspan="4"><FONT COLOR=BLACK><FONT SIZE=3>Income Details Before Tax</Th>'
                + '</tr>'
                + '<tr>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Sales Today</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Sales Monthly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Sales Quaterly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Sales Yearly</Th>'
                + '</tr>'
                + GetIncomeBodyDataEntryBT
                + '</Table>'
                + '</div>'

                //Income
                + '</BR><BR><BR><BR><BR><BR><BR><BR><BR>'
                + '<div id="div2" width="100%">'
                + '<table align="left"  border="1">'
                + '<tr>'
                + '<Th colspan="4"><FONT COLOR=BLACK><FONT SIZE=3>Income Details After Tax</Th>'
                + '</tr>'
                + '<tr>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Sales Today</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Sales Monthly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Sales Quaterly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Sales Yearly</Th>'
                + '</tr>'
                + GetIncomeBodyDataEntry
                + '</Table>'
                + '</div>'

                //Expense
                + '</BR><BR><BR><BR><BR><BR><BR><BR><BR>'
                + '<div id="div2" width="100%">'
                + '<table align="left" border="1">'
                + '<tr>'
                + '<th colspan="8"><FONT COLOR=BLACK><FONT SIZE=3>Expense Details</th>'
                + '</tr>'
                + '<tr>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Purchase Today</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Purchase Monthly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Purchase Quaterly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Net Purchase Yearly</Th>'
                /*
                +'</tr>'
                +GetExpBodyDataEntry
                +'</table>'
                +'<table align="left"  border="1">'
                +'<tr>'
                +'<Th colspan="4"><FONT COLOR=BLACK><FONT SIZE=3>Other Expense Details</Th>'
                +'</tr>'
                +'<tr>'
                */
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Exp. Today</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Exp. Monthly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Exp. Quaterly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Exp. Yearly</Th>'
                + '</tr>'
                + GetOtherExpBodyDataEntry
                + '</Table>'
                + '<table align="left"  border="1">'
                + '<tr>'
                + '<Th colspan="4"><FONT COLOR=BLACK><FONT SIZE=3>Total Expense Details</Th>'
                + '</tr>'
                + '<tr>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Exp. Today</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Exp. Monthly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Exp. Quaterly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Exp. Yearly</Th>'
                + '</tr>'
                + GetTotalExpBodyDataEntry
                + '</Table>'
                + '</div>'


                //Customer Reciepts
                + '</BR><BR><BR><BR><BR><BR><BR><BR><BR>'
                + '<div id="div2" width="100%">'
                + '<table align="left" border="1">'
                + '<tr>'
                + '<th colspan="8"><FONT COLOR=BLACK><FONT SIZE=3>Receipts</th>'
                + '</tr>'
                + '<tr>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Customer Receipt Today</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Customer Receipt Monthly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Customer Receipt Quaterly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Customer Receipt Yearly</Th>'
                /*
                +'</tr>'
                +GetRecieptBodyDataEntry
                +'</table>'
                +'<table align="left"  border="1">'
                +'<tr>'
                +'<Th colspan="4"><FONT COLOR=BLACK><FONT SIZE=3>Other Receipts</Th>'
                +'</tr>'
                +'<tr>'
                */
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Receipt Today</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Receipt Monthly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Receipt Quaterly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Receipt Yearly</Th>'
                + '</tr>'
                + GetOtherRecieptBodyDataEntry
                + '</Table>'
                + '<table align="left"  border="1">'
                + '<tr>'
                + '<Th colspan="4"><FONT COLOR=BLACK><FONT SIZE=3>Total Receipts</Th>'
                + '</tr>'
                + '<tr>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Receipt Today</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Receipt Monthly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Receipt Quaterly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Receipt Yearly</Th>'
                + '</tr>'
                + GetTotalRecieptBodyDataEntry
                + '</Table>'
                + '</div>'


                //Vendor Payment
                + '</BR><BR><BR><BR><BR><BR><BR><BR><BR>'
                + '<div id="div2" width="100%">'
                + '<table align="left" border="1">'
                + '<tr>'
                + '<th colspan="8"><FONT COLOR=BLACK><FONT SIZE=3>Payments</th>'
                + '</tr>'
                + '<tr>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Vendor Payment Today</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Vendor Payment Monthly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Vendor Payment Quaterly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Vendor Payment Yearly</Th>'
                /*
                +'</tr>'
                +GetPaymentBodyDataEntry
                +'</table>'
                +'<table align="left"  border="1">'
                +'<tr>'
                +'<Th colspan="4"><FONT COLOR=BLACK><FONT SIZE=3>Other Then Vendor Payment</Th>'
                +'</tr>'
                +'<tr>'
                */
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Payment Today</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Payment Monthly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Payment Quaterly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Other Payment Yearly</Th>'
                + '</tr>'
                + GetOtherPaymentBodyDataEntry
                + '</Table>'
                + '<table align="left"  border="1">'
                + '<tr>'
                + '<Th colspan="4"><FONT COLOR=BLACK><FONT SIZE=3>Total Payments</Th>'
                + '</tr>'
                + '<tr>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Payment Today</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Payment Monthly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Payment Quaterly</Th>'
                + '<Th width="70%"><FONT COLOR=BLACK><FONT SIZE=3>Total Payment Yearly</Th>'
                + '</tr>'
                + GetTotalPaymentBodyDataEntry
                + '</Table>'
                + '</div>'


               + '</BR><BR><BR><BR><BR><BR><BR><BR><BR>' + 'Regards,'
               + '</BR><BR><U><Font COLOR=blue>' + COMPANYNAME + ' (ERP Navision Team)')
               + '</BR><BR><BR>';

        // IF COMPANYNAME = 'REPL' THEN BEGIN
        //     SMTPMail.CreateMessage('REPL', 'erp@replurbanplanners.com', 'pradeepmisra@repl.global', Subject, Body, TRUE);
        //     SMTPMail.AddCC('manish.raushan@repl.global;prakasharya@repl.global');
        // END;
        // IF COMPANYNAME = 'RIPL' THEN BEGIN
        //     SMTPMail.CreateMessage('RIPL', 'erpripl@replinfosys.com', 'pradeepmisra@repl.global', Subject, Body, TRUE);
        //     SMTPMail.AddCC('manish.raushan@repl.global;prakasharya@repl.global');
        // END;
        // SMTPMail.Send;

    end;

    local procedure GetBankBodyDataEntry() BodyData: Text
    var
        BankAccount: Record "Bank Account";
    begin
        /*
         IF NetBalance > 0 THEN BEGIN
         BodyData +='<TR>'
             +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+FORMAT(ABS(ROUND(TotalBankBalanceAmt,1,'=')))+'</TD>'
             +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+'('+FORMAT(ABS(ROUND(TotalBankODAmt,1,'=')))+')'+'</TD>'
             +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+FORMAT(ABS(ROUND(NetBalance,1,'=')))+'</TD>'
             +'</TR>';
        
        END ELSE BEGIN
         BodyData +='<TR>'
             +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+FORMAT(ABS(ROUND(TotalBankBalanceAmt,1,'=')))+'</TD>'
             +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+'('+FORMAT(ABS(ROUND(TotalBankODAmt,1,'=')))+')'+'</TD>'
             +'<TD width="70%"><FONT COLOR=RED><FONT SIZE=2>'+'('+FORMAT(ABS(ROUND(NetBalance,1,'=')))+')'+'</TD>'
             +'</TR>';
        
        END;
        */
        IF COMPANYNAME = 'REPL' THEN BEGIN
            BankAccount.SETFILTER("No.", 'BANK-055|BANK-056|BANK-050|BANK-051|BANK-052');
            IF BankAccount.FINDFIRST THEN
                REPEAT
                    BankAccount.CALCFIELDS("Balance (LCY)");
                    IF BankAccount."No." = 'BANK-055' THEN BEGIN
                        BodyData += '<TR>'
                          + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + 'CORPORATE' + '</TD>'
                          + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(BankAccount."Balance (LCY)", 1, '='))) + '</TD>'
                          + '</TR>';
                    END;
                    /*
                     IF BankAccount."No." = 'BANK-041' THEN BEGIN
                     BodyData +='<TR>'
                       +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+'PLANNING'+'</TD>'
                       +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+FORMAT(ABS(ROUND(BankAccount."Balance (LCY)",1,'=')))+'</TD>'
                       +'</TR>';
                     END;
                     IF BankAccount."No." = 'BANK-043' THEN BEGIN
                     BodyData +='<TR>'
                       +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+'INFRA'+'</TD>'
                       +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+FORMAT(ABS(ROUND(BankAccount."Balance (LCY)",1,'=')))+'</TD>'
                       +'</TR>';
                     END;
                     IF BankAccount."No." = 'BANK-044' THEN BEGIN
                     BodyData +='<TR>'
                       +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+'ARCH'+'</TD>'
                       +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+FORMAT(ABS(ROUND(BankAccount."Balance (LCY)",1,'=')))+'</TD>'
                       +'</TR>';
                     END;
                    */
                    /* IF BankAccount."No." = 'BANK-056' THEN BEGIN
                     BodyData +='<TR>'
                       +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+'OD HDFC'+'</TD>'
                       +'<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>'+FORMAT(ABS(ROUND(BankAccount."Balance (LCY)",1,'=')))+'</TD>'
                       +'</TR>';
                     END;
                     */

                    IF BankAccount."No." = 'BANK-050' THEN BEGIN
                        BodyData += '<TR>'
                          + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + 'KOTAK MAIN AC' + '</TD>'
                          + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(BankAccount."Balance (LCY)", 1, '='))) + '</TD>'
                          + '</TR>';
                    END;


                    IF BankAccount."No." = 'BANK-051' THEN BEGIN
                        BodyData += '<TR>'
                          + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + 'OD KOTAK' + '</TD>'
                          + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(BankAccount."Balance (LCY)", 1, '='))) + '</TD>'
                          + '</TR>';
                    END;

                    IF BankAccount."No." = 'BANK-052' THEN BEGIN
                        BodyData += '<TR>'
                          + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + 'SKILL INDIA KOTAK' + '</TD>'
                          + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(BankAccount."Balance (LCY)", 1, '='))) + '</TD>'
                          + '</TR>';
                    END;

                    IF BankAccount."No." = 'BANK-056' THEN BEGIN
                        BodyData += '<TR>'
                          + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + 'OD HDFC' + '</TD>'
                          + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(BankAccount."Balance (LCY)", 1, '='))) + '</TD>'
                          + '</TR>';
                    END;





                UNTIL BankAccount.NEXT = 0;
            EXIT(BodyData);
        END ELSE BEGIN
            IF COMPANYNAME = 'RIPL' THEN BEGIN
                BankAccount.SETFILTER("No.", 'BANK-002|BANK-001|BANK-007');
                IF BankAccount.FINDFIRST THEN
                    REPEAT
                        BankAccount.CALCFIELDS("Balance (LCY)");
                        IF BankAccount."No." = 'BANK-002' THEN BEGIN
                            BodyData += '<TR>'
                              + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + 'MAIN ACCOUNT' + '</TD>'
                              + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(BankAccount."Balance (LCY)", 1, '='))) + '</TD>'
                              + '</TR>';
                        END;
                        IF BankAccount."No." = 'BANK-001' THEN BEGIN
                            BodyData += '<TR>'
                              + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + 'TAX ACCOUNT' + '</TD>'
                              + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(BankAccount."Balance (LCY)", 1, '='))) + '</TD>'
                              + '</TR>';
                        END;
                        IF BankAccount."No." = 'BANK-007' THEN BEGIN
                            BodyData += '<TR>'
                              + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + 'TRAINNING CENTER' + '</TD>'
                              + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(BankAccount."Balance (LCY)", 1, '='))) + '</TD>'
                              + '</TR>';
                        END;
                    UNTIL BankAccount.NEXT = 0;
                EXIT(BodyData);
            END;

        END

    end;

    local procedure GetIncomeBodyDataEntry() BodyData: Text
    begin
        BodyData += '<TR>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetSales, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetSalesMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetSalesQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetSalesYearly, 1, '='))) + '</TD>'
            + '</TR>';
        EXIT(BodyData);
    end;

    local procedure GetExpBodyDataEntry() BodyData: Text
    begin
        BodyData += '<TR>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetPurchase, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetPurchaseMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetPurchaseQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetPurchaseYearly, 1, '='))) + '</TD>'
            + '</TR>';
        EXIT(BodyData);
    end;

    local procedure GetOtherExpBodyDataEntry() BodyData: Text
    begin
        BodyData += '<TR>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetPurchase, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetPurchaseMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetPurchaseQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetPurchaseYearly, 1, '='))) + '</TD>'

            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherExpense, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherExpenseMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherExpenseQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherExpenseYearly, 1, '='))) + '</TD>'
            + '</TR>';
        EXIT(BodyData);
    end;

    local procedure GetTotalExpBodyDataEntry() BodyData: Text
    begin
        BodyData += '<TR>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalExpenses, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalExpensesMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalExpensesQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalExpensesYearly, 1, '='))) + '</TD>'
            + '</TR>';
        EXIT(BodyData);
    end;

    local procedure GetRecieptBodyDataEntry() BodyData: Text
    begin
        BodyData += '<TR>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPaymentReceived, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPaymentReceivedMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPaymentReceivedQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPaymentReceivedYearly, 1, '='))) + '</TD>'
            + '</TR>';
        EXIT(BodyData);
    end;

    local procedure GetOtherRecieptBodyDataEntry() BodyData: Text
    begin
        BodyData += '<TR>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPaymentReceived, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPaymentReceivedMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPaymentReceivedQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPaymentReceivedYearly, 1, '='))) + '</TD>'

            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherthenCustReceived, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherthenCustReceivedMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherthenCustReceivedQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherthenCustReceivedYearly, 1, '='))) + '</TD>'
            + '</TR>';
        EXIT(BodyData);
    end;

    local procedure GetTotalRecieptBodyDataEntry() BodyData: Text
    begin
        BodyData += '<TR>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalReceipt, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalReceiptMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalReceiptQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalReceiptYearly, 1, '='))) + '</TD>'
            + '</TR>';
        EXIT(BodyData);
    end;

    local procedure GetPaymentBodyDataEntry() BodyData: Text
    begin
        BodyData += '<TR>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalBankPaymentValue, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalBankPaymentValueMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalBankPaymentValueQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalBankPaymentValueYearly, 1, '='))) + '</TD>'
            + '</TR>';
        EXIT(BodyData);
    end;

    local procedure GetOtherPaymentBodyDataEntry() BodyData: Text
    begin
        BodyData += '<TR>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalBankPaymentValue, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalBankPaymentValueMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalBankPaymentValueQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalBankPaymentValueYearly, 1, '='))) + '</TD>'

            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherThenVendorValue, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherThenVendorValueMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherThenVendorValueQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalOtherThenVendorValueYearly, 1, '='))) + '</TD>'
            + '</TR>';
        EXIT(BodyData);
    end;

    local procedure GetTotalPaymentBodyDataEntry() BodyData: Text
    begin
        BodyData += '<TR>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPayment, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPaymentMonthly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPaymentQuaterly, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(TotalPaymentYearly, 1, '='))) + '</TD>'
            + '</TR>';
        EXIT(BodyData);
    end;

    procedure "-----Get Sales Details Before Tax----"()
    begin
    end;

    procedure GetTotalSalesInvoiceBT(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SetFilter(SaleInvHeader."Type Of Note", '<>%1', SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalSalesInvoiceDebitBT(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SETRANGE(SaleInvHeader."Type Of Note", SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalCreditMemoBT(StartDate: Date; EndDate: Date) TotalCreditMemoAmt: Decimal
    var
        SaleCrMemoHrd: Record "Sales Cr.Memo Header";
    begin
        TotalCreditMemoAmt := 0;
        SaleCrMemoHrd.RESET;
        SaleCrMemoHrd.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleCrMemoHrd.FINDFIRST THEN BEGIN
            REPEAT
                SaleCrMemoHrd.CALCFIELDS(Amount);
                TotalCreditMemoAmt += SaleCrMemoHrd.Amount;
            UNTIL SaleCrMemoHrd.NEXT = 0;
        END;
        EXIT(TotalCreditMemoAmt);
    end;

    procedure "------Mothly Sales BT----"()
    begin
    end;

    procedure GetTotalSalesInvoiceMonthlyBT(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SetFilter(SaleInvHeader."Type Of Note", '<>%1', SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalSalesInvoiceDebitMonthlyBT(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SETRANGE(SaleInvHeader."Type Of Note", SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalCreditMemoMonthlyBT(StartDate: Date; EndDate: Date) TotalCreditMemoAmt: Decimal
    var
        SaleCrMemoHrd: Record "Sales Cr.Memo Header";
    begin
        TotalCreditMemoAmt := 0;
        SaleCrMemoHrd.RESET;
        SaleCrMemoHrd.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleCrMemoHrd.FINDFIRST THEN BEGIN
            REPEAT
                SaleCrMemoHrd.CALCFIELDS(Amount);
                TotalCreditMemoAmt += SaleCrMemoHrd.Amount;
            UNTIL SaleCrMemoHrd.NEXT = 0;
        END;
        EXIT(TotalCreditMemoAmt);
    end;

    procedure "---Quaterly Sales BT---"()
    begin
    end;

    procedure GetTotalSalesInvoiceQuaterlyBT(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SetFilter(SaleInvHeader."Type Of Note", '<>%1', SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalSalesInvoiceDebitQuaterlyBT(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SETRANGE(SaleInvHeader."Type Of Note", SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalCreditMemoQuaterlyBT(StartDate: Date; EndDate: Date) TotalCreditMemoAmt: Decimal
    var
        SaleCrMemoHrd: Record "Sales Cr.Memo Header";
    begin
        TotalCreditMemoAmt := 0;
        SaleCrMemoHrd.RESET;
        SaleCrMemoHrd.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleCrMemoHrd.FINDFIRST THEN BEGIN
            REPEAT
                SaleCrMemoHrd.CALCFIELDS(Amount);
                TotalCreditMemoAmt += SaleCrMemoHrd.Amount;
            UNTIL SaleCrMemoHrd.NEXT = 0;
        END;
        EXIT(TotalCreditMemoAmt);
    end;

    procedure "---Yearly Sales BT---"()
    begin
    end;

    procedure GetTotalSalesInvoiceYearlyBT(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SetFilter(SaleInvHeader."Type Of Note", '<>%1', SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalSalesInvoiceDebitYearlyBT(StartDate: Date; EndDate: Date) TotalSalesAmt: Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
    begin
        TotalSalesAmt := 0;
        SaleInvHeader.RESET;
        SaleInvHeader.SETRANGE(SaleInvHeader."Type Of Note", SaleInvHeader."Type Of Note"::Debit);
        SaleInvHeader.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SaleInvHeader.CALCFIELDS(SaleInvHeader.Amount);
                TotalSalesAmt += SaleInvHeader.Amount;
            UNTIL SaleInvHeader.NEXT = 0;
        END;
        EXIT(TotalSalesAmt);
    end;

    procedure GetTotalCreditMemoYearlyBT(StartDate: Date; EndDate: Date) TotalCreditMemoAmt: Decimal
    var
        SaleCrMemoHrd: Record "Sales Cr.Memo Header";
    begin
        TotalCreditMemoAmt := 0;
        SaleCrMemoHrd.RESET;
        SaleCrMemoHrd.SETRANGE("Posting Date", StartDate, EndDate);
        IF SaleCrMemoHrd.FINDFIRST THEN BEGIN
            REPEAT
                SaleCrMemoHrd.CALCFIELDS(Amount);
                TotalCreditMemoAmt += SaleCrMemoHrd.Amount;
            UNTIL SaleCrMemoHrd.NEXT = 0;
        END;
        EXIT(TotalCreditMemoAmt);
    end;

    procedure "----Before Tax-----"()
    begin
    end;

    local procedure GetIncomeBodyDataEntryBT() BodyData: Text
    begin
        BodyData += '<TR>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetSalesBT, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetSalesMonthlyBT, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetSalesQuaterlyBT, 1, '='))) + '</TD>'
            + '<TD width="70%"><FONT COLOR=BLUE><FONT SIZE=2>' + FORMAT(ABS(ROUND(NetSalesYearlyBT, 1, '='))) + '</TD>'
            + '</TR>';
        EXIT(BodyData);
    end;
}

