/// <summary>
/// TableExtension Reversal (ID 80275) extends Record Reversal Entry.
/// </summary>
tableextension 80275 Reversal extends "Reversal Entry"
{

    fields
    {
        field(80001; Albaran; boolean)
        { }
    }

    PROCEDURE ReverseAlbaran(TransactionNo: Integer; Desde: Integer; Hasta: Integer);
    BEGIN
        InsertReversalEntryAlbaran(TransactionNo, 0, Desde, Hasta);
        ReversalEntry.SETCURRENTKEY("Document No.", "Posting Date", "Entry Type", "Entry No.");

        Page.RUNMODAL(Page::"Reverse Transaction Entries", ReversalEntry);
        ReversalEntry.DELETEALL;
    END;

    LOCAL PROCEDURE InsertReversalEntryAlbaran(Number: Integer; RevType: Option Transaction,Register; Desde: Integer; Hasta: Integer);
    VAR
        GLAcc: Record 15;
        Cust: Record Customer;
        Vend: Record Vendor;
        DtldCustLedgEntry: Record 379;
        DtldVendLedgEntry: Record 380;
        BankAcc: Record 270;
        FA: Record 5600;
        NextLineNo: Integer;
        GlEntry: Record "G/L Entry";
    BEGIN
        GLSetup.GET;
        ReversalEntry.DELETEALL;
        PostApplied := FALSE;
        NextLineNo := 1;
        RevertTransactionNo.RESET;
        RevertTransactionNo.DELETEALL;
        RevertTransactionNo.Number := Number;
        RevertTransactionNo.INSERT;
        SetReverseFilter(Number, RevType);
        CustLedgEntry.SetRange("Entry No.", Desde, Hasta);
        if CustLedgEntry.FIND('-') THEN
            REPEAT
                CLEAR(ReversalEntry);
                if RevType = RevType::Register THEN
                    ReversalEntry."G/L Register No." := Number;
                ReversalEntry."Reversal Type" := RevType;
                ReversalEntry."Entry Type" := ReversalEntry."Entry Type"::Customer;
                ReversalEntry."Entry No." := CustLedgEntry."Entry No.";
                Cust.GET(CustLedgEntry."Customer No.");
                ReversalEntry.Albaran := True;
                ReversalEntry."Account No." := Cust."No.";
                ReversalEntry."Account Name" := Cust.Name;
                ReversalEntry."Posting Date" := FechaAlbaran(CustLedgEntry."Posting Date");
                ReversalEntry."Source Code" := CustLedgEntry."Source Code";
                ReversalEntry."Journal Batch Name" := CustLedgEntry."Journal Batch Name";
                ReversalEntry."Transaction No." := CustLedgEntry."Transaction No.";
                ReversalEntry."Currency Code" := CustLedgEntry."Currency Code";
                ReversalEntry.Description := CustLedgEntry.Description;
                CustLedgEntry.CALCFIELDS(Amount, "Debit Amount", "Credit Amount",
                  "Amount (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)");
                ReversalEntry.Amount := CustLedgEntry.Amount;
                ReversalEntry."Debit Amount" := CustLedgEntry."Debit Amount";
                ReversalEntry."Credit Amount" := CustLedgEntry."Credit Amount";
                ReversalEntry."Amount (LCY)" := CustLedgEntry."Amount (LCY)";
                ReversalEntry."Debit Amount (LCY)" := CustLedgEntry."Debit Amount (LCY)";
                ReversalEntry."Credit Amount (LCY)" := CustLedgEntry."Credit Amount (LCY)";
                ReversalEntry."Document Type" := CustLedgEntry."Document Type";
                ReversalEntry."Document No." := CustLedgEntry."Document No.";
                ReversalEntry."Bal. Account Type" := CustLedgEntry."Bal. Account Type";
                ReversalEntry."Bal. Account No." := CustLedgEntry."Bal. Account No.";
                ReversalEntry."Line No." := NextLineNo;
                NextLineNo := NextLineNo + 1;
                ReversalEntry.INSERT;

                DtldCustLedgEntry.INIT;
                DtldCustLedgEntry.SETCURRENTKEY("Transaction No.", "Customer No.", "Entry Type");
                // DtldCustLedgEntry.SETRANGE(DtldCustLedgEntry."Transaction No.", CustLedgEntry."Transaction No.");
                DtldCustLedgEntry.SetRange("Cust. Ledger Entry No.", Desde, Hasta);
                DtldCustLedgEntry.SETRANGE(DtldCustLedgEntry."Customer No.", CustLedgEntry."Customer No.");
                DtldCustLedgEntry.SETFILTER(
                  DtldCustLedgEntry."Entry Type", '<>%1', DtldCustLedgEntry."Entry Type"::"Initial Entry");
                if DtldCustLedgEntry.FIND('-') THEN BEGIN
                    PostApplied := TRUE;
                END;

            UNTIL CustLedgEntry.NEXT = 0;
        VendLedgEntry.SetRange("Entry No.", Desde, Hasta);
        if VendLedgEntry.FIND('-') THEN
            REPEAT
                CLEAR(ReversalEntry);
                if RevType = RevType::Register THEN
                    ReversalEntry."G/L Register No." := Number;
                ReversalEntry.Albaran := True;
                ReversalEntry."Reversal Type" := RevType;
                ReversalEntry."Entry Type" := ReversalEntry."Entry Type"::Vendor;
                ReversalEntry."Entry No." := VendLedgEntry."Entry No.";
                Vend.GET(VendLedgEntry."Vendor No.");
                ReversalEntry."Account No." := Vend."No.";
                ReversalEntry."Account Name" := Vend.Name;
                ReversalEntry."Posting Date" := FechaAlbaran(VendLedgEntry."Posting Date");
                ReversalEntry."Source Code" := VendLedgEntry."Source Code";
                ReversalEntry."Journal Batch Name" := VendLedgEntry."Journal Batch Name";
                ReversalEntry."Transaction No." := VendLedgEntry."Transaction No.";
                ReversalEntry."Currency Code" := VendLedgEntry."Currency Code";
                ReversalEntry.Description := VendLedgEntry.Description;
                VendLedgEntry.CALCFIELDS(Amount, "Debit Amount", "Credit Amount",
                  "Amount (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)");
                ReversalEntry.Amount := VendLedgEntry.Amount;
                ReversalEntry."Debit Amount" := VendLedgEntry."Debit Amount";
                ReversalEntry."Credit Amount" := VendLedgEntry."Credit Amount";
                ReversalEntry."Amount (LCY)" := VendLedgEntry."Amount (LCY)";
                ReversalEntry."Debit Amount (LCY)" := VendLedgEntry."Debit Amount (LCY)";
                ReversalEntry."Credit Amount (LCY)" := VendLedgEntry."Credit Amount (LCY)";
                ReversalEntry."Document Type" := VendLedgEntry."Document Type";
                ReversalEntry."Document No." := VendLedgEntry."Document No.";
                ReversalEntry."Bal. Account Type" := VendLedgEntry."Bal. Account Type";
                ReversalEntry."Bal. Account No." := VendLedgEntry."Bal. Account No.";
                ReversalEntry."Line No." := NextLineNo;
                NextLineNo := NextLineNo + 1;
                ReversalEntry.INSERT;

                DtldVendLedgEntry.INIT;
                DtldVendLedgEntry.SETCURRENTKEY("Transaction No.", "Vendor No.", "Entry Type");
                //DtldVendLedgEntry.SETRANGE(DtldVendLedgEntry."Transaction No.", VendLedgEntry."Transaction No.");
                DtldVendLedgEntry.SetRange("Vendor Ledger Entry No.", Desde, Hasta);
                DtldVendLedgEntry.SETRANGE(DtldVendLedgEntry."Vendor No.", VendLedgEntry."Vendor No.");
                DtldVendLedgEntry.SETFILTER(
                  DtldVendLedgEntry."Entry Type", '<>%1', DtldVendLedgEntry."Entry Type"::"Initial Entry");
                if DtldVendLedgEntry.FIND('-') THEN
                    PostApplied := TRUE;

            UNTIL VendLedgEntry.NEXT = 0;
        BankAccLedgEntry.SetRange("Entry No.", Desde, Hasta);
        if BankAccLedgEntry.FIND('-') THEN
            REPEAT
                CLEAR(ReversalEntry);
                if RevType = RevType::Register THEN
                    ReversalEntry."G/L Register No." := Number;
                ReversalEntry."Reversal Type" := RevType;
                ReversalEntry.Albaran := True;
                ReversalEntry."Entry Type" := ReversalEntry."Entry Type"::"Bank Account";
                ReversalEntry."Entry No." := BankAccLedgEntry."Entry No.";
                BankAcc.GET(BankAccLedgEntry."Bank Account No.");
                ReversalEntry."Account No." := BankAcc."No.";
                ReversalEntry."Account Name" := BankAcc.Name;
                ReversalEntry."Posting Date" := FechaAlbaran(BankAccLedgEntry."Posting Date");
                ReversalEntry."Source Code" := BankAccLedgEntry."Source Code";
                ReversalEntry."Journal Batch Name" := BankAccLedgEntry."Journal Batch Name";
                ReversalEntry."Transaction No." := BankAccLedgEntry."Transaction No.";
                ReversalEntry."Currency Code" := BankAccLedgEntry."Currency Code";
                ReversalEntry.Description := BankAccLedgEntry.Description;
                ReversalEntry.Amount := BankAccLedgEntry.Amount;
                ReversalEntry."Debit Amount" := BankAccLedgEntry."Debit Amount";
                ReversalEntry."Credit Amount" := BankAccLedgEntry."Credit Amount";
                ReversalEntry."Amount (LCY)" := BankAccLedgEntry."Amount (LCY)";
                ReversalEntry."Debit Amount (LCY)" := BankAccLedgEntry."Debit Amount (LCY)";
                ReversalEntry."Credit Amount (LCY)" := BankAccLedgEntry."Credit Amount (LCY)";
                ReversalEntry."Document Type" := BankAccLedgEntry."Document Type";
                ReversalEntry."Document No." := BankAccLedgEntry."Document No.";
                ReversalEntry."Bal. Account Type" := BankAccLedgEntry."Bal. Account Type";
                ReversalEntry."Bal. Account No." := BankAccLedgEntry."Bal. Account No.";
                ReversalEntry."Line No." := NextLineNo;
                NextLineNo := NextLineNo + 1;
                ReversalEntry.INSERT;
            UNTIL BankAccLedgEntry.NEXT = 0;
        FALedgEntry.SetRange("G/L Entry No.", Desde, Hasta);
        if FALedgEntry.READPERMISSION THEN BEGIN
            if FALedgEntry.FIND('-') THEN
                REPEAT
                    CLEAR(ReversalEntry);
                    if RevType = RevType::Register THEN
                        ReversalEntry."G/L Register No." := Number;
                    ReversalEntry."Reversal Type" := RevType;
                    ReversalEntry.Albaran := True;
                    ReversalEntry."Entry Type" := ReversalEntry."Entry Type"::"Fixed Asset";
                    ReversalEntry."Entry No." := FALedgEntry."Entry No.";
                    FA.GET(FALedgEntry."FA No.");
                    ReversalEntry."Account No." := FA."No.";
                    ReversalEntry."Account Name" := FA.Description;
                    ReversalEntry."Posting Date" := FechaAlbaran(FALedgEntry."Posting Date");
                    ReversalEntry."FA Posting Category" := FALedgEntry."FA Posting Category";
                    ReversalEntry."FA Posting Type" := FALedgEntry."FA Posting Type";
                    ReversalEntry."Source Code" := FALedgEntry."Source Code";
                    ReversalEntry."Journal Batch Name" := FALedgEntry."Journal Batch Name";
                    ReversalEntry."Transaction No." := FALedgEntry."Transaction No.";
                    ReversalEntry.Description := FALedgEntry.Description;
                    ReversalEntry."Amount (LCY)" := FALedgEntry.Amount;
                    ReversalEntry."Debit Amount (LCY)" := FALedgEntry."Debit Amount";
                    ReversalEntry."Credit Amount (LCY)" := FALedgEntry."Credit Amount";
                    ReversalEntry."VAT Amount" := FALedgEntry."VAT Amount";
                    ReversalEntry."Document Type" := FALedgEntry."Document Type";
                    ReversalEntry."Document No." := FALedgEntry."Document No.";
                    ReversalEntry."Bal. Account Type" := FALedgEntry."Bal. Account Type";
                    ReversalEntry."Bal. Account No." := FALedgEntry."Bal. Account No.";
                    if FALedgEntry."FA Posting Type" <> FALedgEntry."FA Posting Type"::"Salvage Value" THEN BEGIN
                        ReversalEntry."Line No." := NextLineNo;
                        NextLineNo := NextLineNo + 1;
                        ReversalEntry.INSERT;
                    END;
                UNTIL FALedgEntry.NEXT = 0;
        END;
        MaintenanceLedgEntry.SetRange("G/L Entry No.", Desde, Hasta);
        if MaintenanceLedgEntry.READPERMISSION THEN BEGIN
            if MaintenanceLedgEntry.FIND('-') THEN
                REPEAT
                    CLEAR(ReversalEntry);
                    if RevType = RevType::Register THEN
                        ReversalEntry."G/L Register No." := Number;
                    ReversalEntry."Reversal Type" := RevType;
                    ReversalEntry."Entry Type" := ReversalEntry."Entry Type"::Maintenance;
                    ReversalEntry."Entry No." := MaintenanceLedgEntry."Entry No.";
                    ReversalEntry.Albaran := True;
                    FA.GET(MaintenanceLedgEntry."FA No.");
                    ReversalEntry."Account No." := FA."No.";
                    ReversalEntry."Account Name" := FA.Description;
                    ReversalEntry."Posting Date" := FechaAlbaran(MaintenanceLedgEntry."Posting Date");
                    ReversalEntry."Source Code" := MaintenanceLedgEntry."Source Code";
                    ReversalEntry."Journal Batch Name" := MaintenanceLedgEntry."Journal Batch Name";
                    ReversalEntry."Transaction No." := MaintenanceLedgEntry."Transaction No.";
                    ReversalEntry.Description := MaintenanceLedgEntry.Description;
                    ReversalEntry."Amount (LCY)" := MaintenanceLedgEntry.Amount;
                    ReversalEntry."Debit Amount (LCY)" := MaintenanceLedgEntry."Debit Amount";
                    ReversalEntry."Credit Amount (LCY)" := MaintenanceLedgEntry."Credit Amount";
                    ReversalEntry."VAT Amount" := MaintenanceLedgEntry."VAT Amount";
                    ReversalEntry."Document Type" := MaintenanceLedgEntry."Document Type";
                    ReversalEntry."Document No." := MaintenanceLedgEntry."Document No.";
                    ReversalEntry."Bal. Account Type" := MaintenanceLedgEntry."Bal. Account Type";
                    ReversalEntry."Bal. Account No." := MaintenanceLedgEntry."Bal. Account No.";
                    ReversalEntry."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + 1;
                    ReversalEntry.INSERT;
                UNTIL MaintenanceLedgEntry.NEXT = 0;
        END;
        if RevType = RevType::Transaction THEN BEGIN
            if PostApplied AND (DtldCustLedgEntry."Entry No." <> 0) THEN BEGIN
                CLEAR(DtldCustLedgEntry);
                DtldCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.");
                DtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                DtldCustLedgEntry.SETRANGE(Unapplied, TRUE);
                if DtldCustLedgEntry.FIND('-') THEN BEGIN
                    REPEAT
                        RevertTransactionNo.Number := DtldCustLedgEntry."Transaction No.";
                        if RevertTransactionNo.INSERT THEN;
                    UNTIL DtldCustLedgEntry.NEXT = 0;
                END;
            END ELSE
                if PostApplied AND (DtldVendLedgEntry."Entry No." <> 0) THEN BEGIN
                    CLEAR(DtldVendLedgEntry);
                    DtldVendLedgEntry.SETCURRENTKEY("Vendor Ledger Entry No.");
                    DtldVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", VendLedgEntry."Entry No.");
                    DtldVendLedgEntry.SETRANGE(Unapplied, TRUE);
                    if DtldVendLedgEntry.FIND('-') THEN BEGIN
                        REPEAT
                            RevertTransactionNo.Number := DtldVendLedgEntry."Transaction No.";
                            if RevertTransactionNo.INSERT THEN;
                        UNTIL DtldVendLedgEntry.NEXT = 0;
                    END;
                END;
        END ELSE
            if RevType = RevType::Register THEN BEGIN
                if PostApplied THEN
                    MESSAGE(Text012, Number);
            END;

        RevertTransactionNo.FIND('-');
        REPEAT
            if RevType = RevType::Transaction THEN
                VATEntry.SETRANGE("Transaction No.", RevertTransactionNo.Number);
            if VATEntry.FIND('-') THEN
                REPEAT
                    GlEntry.SetRange("Entry No.", Desde, Hasta);
                    GlEntry.FindFirst();
                    if GlEntry."Transaction No." <> RevertTransactionNo.Number Then Error('El número de asiento no se corresponde con el apunte');
                    GlEntry.FindLast();
                    if GlEntry."Transaction No." <> RevertTransactionNo.Number Then Error('El número de asiento no se corresponde con el apunte');
                    CLEAR(ReversalEntry);
                    if RevType = RevType::Register THEN
                        ReversalEntry."G/L Register No." := Number;
                    ReversalEntry."Reversal Type" := RevType;
                    ReversalEntry."Entry Type" := ReversalEntry."Entry Type"::VAT;
                    ReversalEntry."Entry No." := VATEntry."Entry No.";
                    ReversalEntry."Posting Date" := FechaAlbaran(VATEntry."Posting Date");
                    ReversalEntry."Source Code" := VATEntry."Source Code";
                    ReversalEntry."Transaction No." := VATEntry."Transaction No.";
                    ReversalEntry.Amount := VATEntry.Amount;
                    ReversalEntry."Amount (LCY)" := VATEntry.Amount;
                    ReversalEntry."Document Type" := VATEntry."Document Type";
                    ReversalEntry."Document No." := VATEntry."Document No.";
                    ReversalEntry."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + 1;
                    ReversalEntry.Albaran := True;
                    ReversalEntry.INSERT;
                UNTIL VATEntry.NEXT = 0;
        UNTIL RevertTransactionNo.NEXT = 0;

        RevertTransactionNo.FIND('-');
        REPEAT
            //if RevType = RevType::Transaction THEN
            //  GLEntry.SETRANGE("Transaction No.", RevertTransactionNo.Number);
            GlEntry.SetRange("Entry No.", Desde, Hasta);
            if GLEntry.FIND('-') THEN
                REPEAT
                    //if GLEntry."Document Type"=GLEntry."Document Type"::Albarán THEN ERROR('No se puede retroceder un albarán');
                    CLEAR(ReversalEntry);
                    ReversalEntry.Albaran := True;
                    if RevType = RevType::Register THEN
                        ReversalEntry."G/L Register No." := Number;
                    ReversalEntry."Reversal Type" := RevType;
                    ReversalEntry."Entry Type" := ReversalEntry."Entry Type"::"G/L Account";
                    ReversalEntry."Entry No." := GLEntry."Entry No.";
                    if NOT GLAcc.GET(GLEntry."G/L Account No.") THEN
                        ERROR(Text009, GLEntry.TABLECAPTION, GLAcc.TABLECAPTION);
                    ReversalEntry."Account No." := GLAcc."No.";
                    ReversalEntry."Account Name" := GLAcc.Name;
                    ReversalEntry."Posting Date" := FechaAlbaran(GLEntry."Posting Date");
                    ReversalEntry."Source Code" := GLEntry."Source Code";
                    ReversalEntry."Journal Batch Name" := GLEntry."Journal Batch Name";
                    ReversalEntry."Transaction No." := GLEntry."Transaction No.";
                    ReversalEntry."Source Type" := GLEntry."Source Type";
                    ReversalEntry."Source No." := GLEntry."Source No.";
                    ReversalEntry.Description := GLEntry.Description;
                    ReversalEntry."Amount (LCY)" := GLEntry.Amount;
                    ReversalEntry."Debit Amount (LCY)" := GLEntry."Debit Amount";
                    ReversalEntry."Credit Amount (LCY)" := GLEntry."Credit Amount";
                    ReversalEntry."VAT Amount" := GLEntry."VAT Amount";
                    ReversalEntry."Document Type" := GLEntry."Document Type";
                    ReversalEntry."Document No." := GLEntry."Document No.";
                    ReversalEntry."Bal. Account Type" := GLEntry."Bal. Account Type";
                    ReversalEntry."Bal. Account No." := GLEntry."Bal. Account No.";
                    ReversalEntry."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + 1;
                    ReversalEntry.INSERT;
                UNTIL GLEntry.NEXT = 0;
        UNTIL RevertTransactionNo.NEXT = 0;

        if ReversalEntry.FIND('-') THEN;
    END;

    PROCEDURE FechaAlbaran(POSTINGDATE: Date): Date;
    VAR
        r17: Record "G/L Entry";
        C11: Codeunit 11;
        ProcesoCancelado: Label 'Proceso cancelado por el usuario';
        PeriodoBloqueado: Label 'La fecha del albarán %1, pertenece a un pedriodo bloqueado,¿ Quiere continuar?';
    BEGIN
        if c11.DateNotAllowed(POSTINGDATE) then
            If not Confirm(PeriodoBloqueado, true, POSTINGDATE)
Then
                Error(ProcesoCancelado);
        if DATE2DMY(POSTINGDATE, 3) > DATE2DMY(WORKDATE, 3) THEN EXIT(POSTINGDATE);
        if DATE2DMY(POSTINGDATE, 3) < DATE2DMY(WORKDATE, 3) THEN EXIT(WORKDATE);
        if DATE2DMY(POSTINGDATE, 3) = DATE2DMY(WORKDATE, 3) THEN begin
            If DATE2DMY(POSTINGDATE, 2) > DATE2DMY(WORKDATE, 3) THEN EXIT(POSTINGDATE);
        end;
        if DATE2DMY(POSTINGDATE, 2) < DATE2DMY(WORKDATE, 2) THEN begin
            if DATE2DMY(POSTINGDATE, 2) < DATE2DMY(WORKDATE, 2) - 1 THEN exit(WORKDATE);
            if Date2DMY(POSTINGDATE, 1) > 20 then
                EXIT(WORKDATE);
        end;
        EXIT(POSTINGDATE);
    END;

    VAR
        GLSetup: Record "General Ledger Setup";
        ReversalEntry: Record "Reversal Entry" TEMPORARY;
        GLEntry: Record "G/L Entry";
        CustLedgEntry: Record 21;
        VendLedgEntry: Record 25;
        BankAccLedgEntry: Record 271;
        VATEntry: Record 254;
        FALedgEntry: Record 5601;
        MaintenanceLedgEntry: Record 5625;
        GLReg: Record 45;
        RevertTransactionNo: Record 2000000026 TEMPORARY;
        GenJnlCheckLine: Codeunit 11;
        PostApplied: Boolean;
        Text009: Label 'No es posible revertir la transacción, se comprimió el %1 o se eliminó un %2.';
        Text012: Label 'No puede revertir el nº de registro %1 porque contiene movimientos que se han registrado y aplicado en la misma transacción.\\Debe revertir cada transacción en el nº de registro %1 de forma separada.';

}