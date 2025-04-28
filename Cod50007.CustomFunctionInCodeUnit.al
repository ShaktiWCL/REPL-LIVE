codeunit 50007 "Custom Function In CodeUnit"
{
    procedure BankPaymentMinimumLimitCheck(Rec: Record "Gen. Journal Line")
    var
        BanAcc: Record "Bank Account";
        BankBalanceLCY: Decimal;
        AmountCheck: Decimal;
        GenJnlLine: Record "Gen. Journal Line";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        BankAmount: Decimal;
        TotalBankPayment: Decimal;
        GenJnlLine2: Record "Gen. Journal Line";
        TempBankAccountNo: Code[20];
        BankAccountNo: Code[20];
        BankAccLedgEntry2: Record "Bank Account Ledger Entry";
        Tex0001: Label 'Posting this entry will have adverse effect in Bank Account No. %1';
    begin
        //AD_BP
        BankBalanceLCY := 0;
        //WITH GenJnlLine DO BEGIN
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        GenJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        GenJnlLine.FINDSET;
        REPEAT
            BankAccountNo := '';
            IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Bank Account" THEN
                BankAccountNo := GenJnlLine."Account No.";

            IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"Bank Account" THEN
                BankAccountNo := GenJnlLine."Bal. Account No.";

            TotalBankPayment := 0;
            TempBankAccountNo := '';
            GenJnlLine2.RESET;
            GenJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Account Type", "Account No.");
            GenJnlLine2.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
            GenJnlLine2.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
            GenJnlLine2.SETFILTER("Account Type", '%1', GenJnlLine2."Account Type"::"Bank Account");
            GenJnlLine2.SETRANGE("Account No.", BankAccountNo);
            IF GenJnlLine2.FINDSET THEN BEGIN
                REPEAT
                    TempBankAccountNo := GenJnlLine2."Account No.";
                    BankAmount := 0;
                    BanAcc.GET(GenJnlLine2."Account No.");
                    BankAccLedgEntry.SETCURRENTKEY("Bank Account No.", "Posting Date");
                    BankAccLedgEntry.SETRANGE("Bank Account No.", BanAcc."No.");
                    BankAccLedgEntry.SETFILTER("Posting Date", '..%1', WORKDATE);
                    IF BankAccLedgEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            BankAmount += BankAccLedgEntry."Amount (LCY)"
                        UNTIL BankAccLedgEntry.NEXT = 0;
                    END ELSE BEGIN
                        BankAccLedgEntry2.RESET;
                        BankAccLedgEntry2.SETRANGE("Bank Account No.", BanAcc."No.");
                        IF BankAccLedgEntry2.FINDFIRST THEN
                            ERROR(Tex0001, BanAcc."No.");
                    END;
                    TotalBankPayment += ABS(GenJnlLine2."Amount (LCY)");// - GenJnlLine2."Total TDS/TCS Incl. SHE CESS");
                                                                        //MESSAGE('%1--%2--%3---%4',TotalBankPayment,BankAmount,TempBankAccountNo,GenJnlLine2."Line No.");
                UNTIL (GenJnlLine2.NEXT = 0) OR (TempBankAccountNo <> GenJnlLine2."Account No.");
            END;
            GenJnlLine2.RESET;
            GenJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Bal. Account Type", "Bal. Account No.");
            GenJnlLine2.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
            GenJnlLine2.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
            GenJnlLine2.SETFILTER("Bal. Account Type", '%1', GenJnlLine2."Bal. Account Type"::"Bank Account");
            GenJnlLine2.SETRANGE("Bal. Account No.", BankAccountNo);
            IF GenJnlLine2.FINDSET THEN BEGIN
                REPEAT
                    TempBankAccountNo := GenJnlLine2."Bal. Account No.";
                    BankAmount := 0;
                    BanAcc.GET(GenJnlLine2."Bal. Account No.");
                    BankAccLedgEntry.SETCURRENTKEY("Bank Account No.", "Posting Date");
                    BankAccLedgEntry.SETRANGE("Bank Account No.", BanAcc."No.");
                    BankAccLedgEntry.SETFILTER("Posting Date", '..%1', WORKDATE);
                    IF BankAccLedgEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            BankAmount += BankAccLedgEntry."Amount (LCY)"
                        UNTIL BankAccLedgEntry.NEXT = 0;
                    END ELSE BEGIN
                        BankAccLedgEntry2.RESET;
                        BankAccLedgEntry2.SETRANGE("Bank Account No.", BanAcc."No.");
                        IF BankAccLedgEntry2.FINDFIRST THEN
                            ERROR(Tex0001, BanAcc."No.");
                    END;
                    TotalBankPayment += ABS(GenJnlLine2."Amount (LCY)");// - GenJnlLine2."Total TDS/TCS Incl. SHE CESS");
                                                                        //MESSAGE('%1--%2--%3---%4',TotalBankPayment,BankAmount,TempBankAccountNo,GenJnlLine2."Line No.");
                UNTIL (GenJnlLine2.NEXT = 0) OR (TempBankAccountNo <> GenJnlLine2."Bal. Account No.");
            END;
            BankBalanceLCY := BankAmount - TotalBankPayment;
            IF (BankBalanceLCY < BanAcc."Min. Balance") THEN
                ERROR(Tex0001, BanAcc."No.");

        //MESSAGE('%1--%2',BankBalanceLCY,BanAcc."No.");
        UNTIL GenJnlLine.NEXT = 0;
        //END;
        //AD_BP
    end;

    procedure BankPaymentMinimumLimitCheckContra(Rec: Record "Gen. Journal Line")
    var
        BanAcc: Record "Bank Account";
        BankBalanceLCY: Decimal;
        AmountCheck: Decimal;
        GenJnlLine: Record "Gen. Journal Line";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        BankAmount: Decimal;
        TotalBankPayment: Decimal;
        GenJnlLine2: Record "Gen. Journal Line";
        TempBankAccountNo: Code[20];
        BankAccountNo: Code[20];
        BankAccLedgEntry2: Record "Bank Account Ledger Entry";
        Tex0001: Label 'Posting this entry will have adverse effect in Bank Account No. %1';
    begin
        //AD_BP
        BankBalanceLCY := 0;
        //WITH GenJnlLine DO BEGIN
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        GenJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        GenJnlLine.FINDSET;
        REPEAT
            BankAccountNo := '';
            IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Bank Account" THEN
                BankAccountNo := GenJnlLine."Account No.";

            IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"Bank Account" THEN
                BankAccountNo := GenJnlLine."Bal. Account No.";

            TotalBankPayment := 0;
            TempBankAccountNo := '';
            GenJnlLine2.RESET;
            GenJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Account Type", "Account No.");
            GenJnlLine2.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
            GenJnlLine2.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
            GenJnlLine2.SETFILTER("Account Type", '%1', GenJnlLine2."Account Type"::"Bank Account");
            GenJnlLine2.SETRANGE("Account No.", BankAccountNo);
            GenJnlLine2.SETFILTER("Credit Amount", '<>%1', 0);
            IF GenJnlLine2.FINDSET THEN BEGIN
                REPEAT
                    TempBankAccountNo := GenJnlLine2."Account No.";
                    BankAmount := 0;
                    BanAcc.GET(GenJnlLine2."Account No.");
                    BankAccLedgEntry.SETCURRENTKEY("Bank Account No.", "Posting Date");
                    BankAccLedgEntry.SETRANGE("Bank Account No.", BanAcc."No.");
                    BankAccLedgEntry.SETFILTER("Posting Date", '..%1', WORKDATE);
                    IF BankAccLedgEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            BankAmount += BankAccLedgEntry."Amount (LCY)"
                        UNTIL BankAccLedgEntry.NEXT = 0;
                    END ELSE BEGIN
                        BankAccLedgEntry2.RESET;
                        BankAccLedgEntry2.SETRANGE("Bank Account No.", BanAcc."No.");
                        IF BankAccLedgEntry2.FINDFIRST THEN
                            ERROR(Tex0001, BanAcc."No.");
                    END;
                    TotalBankPayment += ABS(GenJnlLine2."Amount (LCY)");
                //MESSAGE('%1--%2--%3---%4',TotalBankPayment,BankAmount,TempBankAccountNo,GenJnlLine2."Line No.");
                UNTIL (GenJnlLine2.NEXT = 0) OR (TempBankAccountNo <> GenJnlLine2."Account No.");
            END;
            GenJnlLine2.RESET;
            GenJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Bal. Account Type", "Bal. Account No.");
            GenJnlLine2.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
            GenJnlLine2.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
            GenJnlLine2.SETFILTER("Bal. Account Type", '%1', GenJnlLine2."Bal. Account Type"::"Bank Account");
            GenJnlLine2.SETRANGE("Bal. Account No.", BankAccountNo);
            GenJnlLine2.SETFILTER("Debit Amount", '<>%1', 0);
            IF GenJnlLine2.FINDSET THEN BEGIN
                REPEAT
                    TempBankAccountNo := GenJnlLine2."Bal. Account No.";
                    BankAmount := 0;
                    BanAcc.GET(GenJnlLine2."Bal. Account No.");
                    BankAccLedgEntry.SETCURRENTKEY("Bank Account No.", "Posting Date");
                    BankAccLedgEntry.SETRANGE("Bank Account No.", BanAcc."No.");
                    BankAccLedgEntry.SETFILTER("Posting Date", '..%1', WORKDATE);
                    IF BankAccLedgEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            BankAmount += BankAccLedgEntry."Amount (LCY)"
                        UNTIL BankAccLedgEntry.NEXT = 0;
                    END ELSE BEGIN
                        BankAccLedgEntry2.RESET;
                        BankAccLedgEntry2.SETRANGE("Bank Account No.", BanAcc."No.");
                        IF BankAccLedgEntry2.FINDFIRST THEN
                            ERROR(Tex0001, BanAcc."No.");
                    END;
                    TotalBankPayment += ABS(GenJnlLine2."Amount (LCY)");
                //MESSAGE('%1--%2--%3---%4',TotalBankPayment,BankAmount,TempBankAccountNo,GenJnlLine2."Line No.");
                UNTIL (GenJnlLine2.NEXT = 0) OR (TempBankAccountNo <> GenJnlLine2."Bal. Account No.");
            END;

            BankBalanceLCY := BankAmount - TotalBankPayment;
            IF (BankBalanceLCY < BanAcc."Min. Balance") THEN
                ERROR(Tex0001, BanAcc."No.");

        //MESSAGE('%1--%2',BankBalanceLCY,BanAcc."No.");
        UNTIL GenJnlLine.NEXT = 0;
        //END;
        //AD_BP
    end;
}
