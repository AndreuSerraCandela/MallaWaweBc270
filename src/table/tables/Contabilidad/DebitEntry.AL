/// <summary>
/// Table Direct Debit Collection Malla (ID 7001115).
/// </summary>
table 7001115 "Direct Debit Collection Malla"
{
    Caption = 'Direct Debit Collection Malla';
    DataCaptionFields = "Customer No.", "Transaction ID";
    DrillDownPageID = "Direct Debit Collect. Entries";
    LookupPageID = "Direct Debit Collect. Entries";

    fields
    {
        field(1; "Direct Debit Collection No."; Integer)
        {
            Caption = 'Direct Debit Collection No.';
            TableRelation = "Direct Debit Collection";
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if xRec."Customer No." <> '' then
                    TestField(Status, Status::New);
            end;
        }
        field(4; "Applies-to Entry No."; Integer)
        {
            Caption = 'Applies-to Entry No.';

            trigger OnValidate()
            var
                CarTeraDoc: Record "Cartera Doc.";
                CustLedgerEntry: Record "Cust. Ledger Entry";
                DirectDebitCollection: Record "Direct Debit Collection";
                AllowedDocumentType: Boolean;
            begin
                if xRec."Applies-to Entry No." <> "Applies-to Entry No." then begin
                    TestField("Customer No.");
                    if CustLedgerEntry.Get("Applies-to Entry No.") Then Begin
                        CustLedgerEntry.TestField("Customer No.", "Customer No.");
                        CustLedgerEntry.TestField(Open);

                        AllowedDocumentType :=
                          (CustLedgerEntry."Document Type" in
                           [CustLedgerEntry."Document Type"::Invoice,
                            CustLedgerEntry."Document Type"::"Finance Charge Memo",
                            CustLedgerEntry."Document Type"::Reminder,
                            CustLedgerEntry."Document Type"::Bill]);
                        OnBeforeDocTypeErr(CustLedgerEntry, AllowedDocumentType);
                        if not AllowedDocumentType then
                            Error(DocTypeErr);

                        CustLedgerEntry.CalcFields("Remaining Amount");
                        CheckCustLedgerEntryAmountPositive(CustLedgerEntry);

                        "Transfer Date" := CustLedgerEntry."Due Date";
                        "Currency Code" := CustLedgerEntry."Currency Code";
                        "Transfer Amount" := CustLedgerEntry."Remaining Amount" - GetAmountInActiveCollections;
                        Validate("Mandate ID", CustLedgerEntry."Direct Debit Mandate ID");
                        OnValidateAppliesToEntryNoOnAfterTransferCustLedgerEntryFields(Rec, xRec, CustLedgerEntry);
                    End else begin
                        CarTeraDoc.Get(CarTeraDoc.Type::Receivable, "Applies-to Entry No.");
                        "Transfer Date" := CarTeraDoc."Due Date";
                        "Currency Code" := '';
                        "Transfer Amount" := CarTeraDoc."Remaining Amount";
                        Validate("Mandate ID", CarTeraDoc."Direct Debit Mandate ID");

                    end;

                    DirectDebitCollection.Get("Direct Debit Collection No.");
                    "Transaction ID" := StrSubstNo('%1/%2', DirectDebitCollection.Identifier, "Entry No.");
                end;
            end;
        }
        field(5; "Transfer Date"; Date)
        {
            Caption = 'Transfer Date';
        }
        field(6; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(7; "Transfer Amount"; Decimal)
        {
            Caption = 'Transfer Amount';

            trigger OnValidate()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                IsHandled: Boolean;
            begin
                IsHandled := false;
                OnBeforeValidateTransferAmount(Rec, IsHandled);
                if IsHandled then
                    exit;

                if "Transfer Amount" <= 0 then
                    Error(AmountMustBePositiveErr);
                TestField("Applies-to Entry No.");
                if CustLedgEntry.Get("Applies-to Entry No.") Then Begin
                    CustLedgEntry.CalcFields("Remaining Amount");
                    if "Transfer Amount" > CustLedgEntry."Remaining Amount" - GetAmountInActiveCollections then
                        Error(LargerThanRemainingErr, CustLedgEntry."Remaining Amount", CustLedgEntry."Currency Code");
                End;
            end;
        }
        field(8; "Transaction ID"; Text[35])
        {
            Caption = 'Transaction ID';
            Editable = false;
        }
        field(9; "Sequence Type"; Option)
        {
            Caption = 'Sequence Type';
            Editable = false;
            OptionCaption = 'One Off,First,Recurring,Last';
            OptionMembers = "One Off",First,Recurring,Last;
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'New,File Created,Rejected,Posted';
            OptionMembers = New,"File Created",Rejected,Posted;
        }
        field(11; "Mandate ID"; Code[35])
        {
            Caption = 'Mandate ID';
            TableRelation = "SEPA Direct Debit Mandate".ID WHERE("Customer No." = FIELD("Customer No."));

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            begin
                if "Mandate ID" = '' then
                    exit;
                SEPADirectDebitMandate.Get("Mandate ID");
                "Sequence Type" := SEPADirectDebitMandate.GetSequenceType;
            end;
        }
        field(12; "Mandate Type of Payment"; Option)
        {
            CalcFormula = Lookup("SEPA Direct Debit Mandate"."Type of Payment" WHERE(ID = FIELD("Mandate ID")));
            Caption = 'Mandate Type of Payment';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'One Off,Recurrent';
            OptionMembers = "One Off",Recurrent;
        }
        field(13; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Applies-to Entry Document No."; Code[20])
        {
            CalcFormula = Lookup("Cust. Ledger Entry"."Document No." WHERE("Entry No." = FIELD("Applies-to Entry No.")));
            Caption = 'Applies-to Entry Document No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Applies-to Entry Description"; Text[100])
        {
            CalcFormula = Lookup("Cust. Ledger Entry".Description WHERE("Entry No." = FIELD("Applies-to Entry No.")));
            Caption = 'Applies-to Entry Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Applies-to Entry Posting Date"; Date)
        {
            CalcFormula = Lookup("Cust. Ledger Entry"."Posting Date" WHERE("Entry No." = FIELD("Applies-to Entry No.")));
            Caption = 'Applies-to Entry Posting Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Applies-to Entry Currency Code"; Code[10])
        {
            CalcFormula = Lookup("Cust. Ledger Entry"."Currency Code" WHERE("Entry No." = FIELD("Applies-to Entry No.")));
            Caption = 'Applies-to Entry Currency Code';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Currency;
        }
        field(18; "Applies-to Entry Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Cust. Ledger Entry No." = FIELD("Applies-to Entry No."),
                                                                         "Entry Type" = FILTER("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)")));
            Caption = 'Applies-to Entry Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Applies-to Entry Rem. Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Cust. Ledger Entry No." = FIELD("Applies-to Entry No.")));
            Caption = 'Applies-to Entry Rem. Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Applies-to Entry Open"; Boolean)
        {
            CalcFormula = Lookup("Cust. Ledger Entry".Open WHERE("Entry No." = FIELD("Applies-to Entry No.")));
            Caption = 'Applies-to Entry Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Direct Debit Collection Status"; Option)
        {
            CalcFormula = Lookup("Direct Debit Collection".Status WHERE("No." = FIELD("Direct Debit Collection No.")));
            Caption = 'Direct Debit Collection Status';
            FieldClass = FlowField;
            OptionCaption = 'New,Canceled,File Created,Posted,Closed';
            OptionMembers = New,Canceled,"File Created",Posted,Closed;
        }
        field(22; "Payment Reference"; Code[50])
        {
            CalcFormula = Lookup("Cust. Ledger Entry"."Payment Reference" WHERE("Entry No." = FIELD("Applies-to Entry No.")));
            Caption = 'Payment Reference';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Message to Recipient"; Text[140])
        {
            Caption = 'Message to Recipient';
        }
    }

    keys
    {
        key(Key1; "Direct Debit Collection No.", "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Applies-to Entry No.", Status)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DeletePaymentFileErrors;
    end;

    trigger OnInsert()
    var
        DirectDebitCollectionEntry: Record "Direct Debit Collection Malla";
    begin
        if "Entry No." = 0 then begin
            DirectDebitCollectionEntry.SetRange("Direct Debit Collection No.", "Direct Debit Collection No.");
            LockTable();
            if DirectDebitCollectionEntry.FindLast then;
            "Entry No." := DirectDebitCollectionEntry."Entry No." + 1;
        end;
    end;

    trigger OnModify()
    begin
        TestField(Status, Status::New);
        CalcFields("Direct Debit Collection Status");
        TestField("Direct Debit Collection Status", "Direct Debit Collection Status"::New);
    end;

    var
        DocTypeErr: Label 'The customer ledger entry must be of type Invoice, Finance Charge Memo, Reminder or Bill.';
        AmountMustBePositiveErr: Label 'The amount must be positive.';
        LargerThanRemainingErr: Label 'You cannot collect an amount that is larger than the remaining amount for the invoice (%1 %2) that is not on other collection entries.', Comment = '%1 = an amount. %2 = currency code, e.g. 123.45 EUR';
        RejectQst: Label 'Do you want to reject this collection entry?';

    /// <summary>
    /// CreateNew.
    /// </summary>
    /// <param name="DirectDebitCollectionNo">Integer.</param>
    /// <param name="CustLedgerEntry">Record "Cust. Ledger Entry".</param>
    procedure CreateNew(DirectDebitCollectionNo: Integer; CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        IsHandled: Boolean;
    begin
        "Direct Debit Collection No." := DirectDebitCollectionNo;
        SetRange("Direct Debit Collection No.", DirectDebitCollectionNo);
        LockTable();
        if FindLast then;
        "Entry No." += 1;
        Init;
        Validate("Customer No.", CustLedgerEntry."Customer No.");
        Validate("Applies-to Entry No.", CustLedgerEntry."Entry No.");
        OnCreateNewOnBeforeInsert(CustLedgerEntry, Rec);
        Insert;
        OnCreateNewOnAfterInsert(CustLedgerEntry, Rec);

        IsHandled := false;
        OnBeforeCheckSEPA(Rec, IsHandled);
        if not IsHandled then
            CODEUNIT.Run(CODEUNIT::"SEPA DD-Check Line Malla", Rec);
    end;

    /// <summary>
    /// DeletePaymentFileErrors.
    /// </summary>
    procedure DeletePaymentFileErrors()
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        TransferPKToGenJnlLine(GenJnlLine);
        GenJnlLine.DeletePaymentFileErrors;
    end;

    /// <summary>
    /// HasPaymentFileErrors.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure HasPaymentFileErrors(): Boolean
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        TransferPKToGenJnlLine(GenJnlLine);
        exit(GenJnlLine.HasPaymentFileErrors);
    end;

    /// <summary>
    /// ExportSEPA.
    /// </summary>
    procedure ExportSEPA()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeExportSEPA(Rec, IsHandled);
        if not IsHandled then
            CODEUNIT.Run(CODEUNIT::"SEPA DD-Export File", Rec);
    end;

    /// <summary>
    /// InsertPaymentFileError.
    /// </summary>
    /// <param name="Text">Text.</param>
    procedure InsertPaymentFileError(Text: Text)
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        TransferPKToGenJnlLine(GenJnlLine);
        GenJnlLine.InsertPaymentFileError(Text);
    end;

    /// <summary>
    /// InsertPaymentFileErrorWithDetails.
    /// </summary>
    /// <param name="ErrorText">Text.</param>
    /// <param name="AddnlInfo">Text.</param>
    procedure InsertPaymentFileErrorWithDetails(ErrorText: Text; AddnlInfo: Text)
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        TransferPKToGenJnlLine(GenJnlLine);
        GenJnlLine.InsertPaymentFileErrorWithDetails(ErrorText, AddnlInfo, '');
    end;

    /// <summary>
    /// Reject.
    /// </summary>
    procedure Reject()
    var
        SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
    begin
        TestField(Status, Status::"File Created");
        if not Confirm(RejectQst) then
            exit;
        Status := Status::Rejected;
        Modify;
        if "Mandate ID" = '' then
            exit;
        SEPADirectDebitMandate.Get("Mandate ID");
        SEPADirectDebitMandate.RollBackSequenceType;
    end;

    local procedure CheckCustLedgerEntryAmountPositive(var CustLedgEntry: Record "Cust. Ledger Entry")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckCustLedgerEntryAmountPositive(CustLedgEntry, IsHandled);
        if IsHandled then
            exit;

        if CustLedgEntry."Remaining Amount" <= 0 then
            Error(AmountMustBePositiveErr);
    end;

    local procedure TransferPKToGenJnlLine(var GenJnlLine: Record "Gen. Journal Line")
    var
        DirectDebitCollection: Record "Direct Debit Collection";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeTransferPKToGenJnlLine(Rec, GenJnlLine, IsHandled);
        if IsHandled then
            exit;

        if DirectDebitCollection.Get("Direct Debit Collection No.") then begin
            
            if DirectDebitCollection."Source Table ID" <> 0 then begin
                GenJnlLine."Journal Template Name" := '';
                GenJnlLine."Journal Batch Name" := Format(DirectDebitCollection."Source Table ID");
                GenJnlLine."Document No." := DirectDebitCollection.Identifier;
                
            end else
            GenJnlLine."Document No." := CopyStr(Format(DirectDebitCollection."No."), 1, MaxStrLen(GenJnlLine."Document No."));
         end;
        //DirectDebitCollection.SetGenJnlLineMapping(GenJnlLine);
        GenJnlLine."Line No." := "Entry No.";
    end;

    local procedure GetAmountInActiveCollections(): Decimal
    var
        DirectDebitCollectionEntry: Record "Direct Debit Collection Malla";
        AmountAlreadyInCollection: Decimal;
    begin
        if "Applies-to Entry No." = 0 then
            exit(0);

        DirectDebitCollectionEntry.SetRange("Applies-to Entry No.", "Applies-to Entry No.");
        DirectDebitCollectionEntry.SetFilter(Status, '%1|%2', Status::New, Status::"File Created");
        if DirectDebitCollectionEntry.FindSet then
            repeat
                if (DirectDebitCollectionEntry."Direct Debit Collection No." <> "Direct Debit Collection No.") or
                   (DirectDebitCollectionEntry."Entry No." <> "Entry No.")
                then
                    AmountAlreadyInCollection += DirectDebitCollectionEntry."Transfer Amount";
            until DirectDebitCollectionEntry.Next() = 0;
        exit(AmountAlreadyInCollection);
    end;

    /// <summary>
    /// SetTodayAsTransferDateForOverdueEnries.
    /// </summary>
    procedure SetTodayAsTransferDateForOverdueEnries()
    var
        DirectDebitCollectionEntry: Record "Direct Debit Collection Malla";
    begin
        DirectDebitCollectionEntry.SetRange("Direct Debit Collection No.", "Direct Debit Collection No.");
        DirectDebitCollectionEntry.SetRange(Status, DirectDebitCollectionEntry.Status::New);
        DirectDebitCollectionEntry.SetFilter("Transfer Date", '<%1', Today());
        if DirectDebitCollectionEntry.FindSet(true) then
            repeat
                DirectDebitCollectionEntry.Validate("Transfer Date", Today());
                DirectDebitCollectionEntry.Modify(true);
                Codeunit.Run(Codeunit::"SEPA DD-Check Line Malla", DirectDebitCollectionEntry);
            until DirectDebitCollectionEntry.Next() = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckSEPA(var DirectDebitCollectionEntry: Record "Direct Debit Collection Malla"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckCustLedgerEntryAmountPositive(var CustLedgerEntry: Record "Cust. Ledger Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDocTypeErr(CustLedgerEntry: Record "Cust. Ledger Entry"; var AlllowedDocumentType: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeExportSEPA(var DirectDebitCollectionEntry: Record "Direct Debit Collection Malla"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTransferPKToGenJnlLine(var DirectDebitCollectionEntry: Record "Direct Debit Collection Malla"; var GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateTransferAmount(var DirectDebitCollectionEntry: Record "Direct Debit Collection Malla"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateNewOnBeforeInsert(CustLedgerEntry: Record "Cust. Ledger Entry"; var DirectDebitCollectionEntry: Record "Direct Debit Collection Malla")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateNewOnAfterInsert(CustLedgerEntry: Record "Cust. Ledger Entry"; var DirectDebitCollectionEntry: Record "Direct Debit Collection Malla")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnValidateAppliesToEntryNoOnAfterTransferCustLedgerEntryFields(var DirectDebitCollectionEntry: Record "Direct Debit Collection Malla"; xDirectDebitCollectionEntry: Record "Direct Debit Collection Malla"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
    end;
}

