/// <summary>
/// TableExtension Bill GroupKuara (ID 80338) extends Record Bill Group.
/// </summary>
tableextension 80338 "Bill GroupKuara" extends "Bill Group"
{
    fields
    {
        field(50000; "Al descuento (2)"; Boolean) { }
        field(50001; "Remesa al descuento"; Boolean) { }
        field(51200; "Partner Type ant"; Enum "Partner Type") { }
    }
    /// <summary>
    /// RunFileExportCodeunitMa.
    /// </summary>
    /// <param name="CodeunitID">Integer.</param>
    /// <param name="DirectDebitCollectionNo">Integer.</param>
    /// <param name="DirectDebitCollectionEntry">VAR Record "Direct Debit Collection Malla".</param>
    procedure RunFileExportCodeunitMa(CodeunitID: Integer; DirectDebitCollectionNo: Integer; var DirectDebitCollectionEntry: Record "Direct Debit Collection Malla")
    var
        LastError: Text;
    begin
        if not CODEUNIT.Run(CodeunitID, DirectDebitCollectionEntry) then begin
            LastError := GetLastErrorText;
            DeleteDirectDebitCollection2(DirectDebitCollectionNo);
            Commit();
            Error(LastError);
        end;
    end;
     procedure DeleteDirectDebitCollection2(DirectDebitCollectionNo: Integer)
    var
        DirectDebitCollection: Record "Direct Debit Collection";
    begin
        if DirectDebitCollection.Get(DirectDebitCollectionNo) then
            DirectDebitCollection.Delete(true);
    end;

    /// <summary>
    /// ExportToFileMalla.
    /// </summary>
    procedure ExportToFileMalla()
    var
        DirectDebitCollection: Record "Direct Debit Collection";
        DirectDebitCollectionEntry: Record "Direct Debit Collection Malla";
        BankAccount: Record "Bank Account";
        Errores: Record "Payment Jnl. Export Error Text";
        PT: Enum "Partner Type";
    begin
        Case Rec."Partner Type" Of
            Rec."Partner Type"::" ":
                DirectDebitCollection.CreateRecord("No.", "Bank Account No.", PT::" ");
            Rec."Partner Type"::Company:
                DirectDebitCollection.CreateRecord("No.", "Bank Account No.", PT::Company);
            rec."Partner Type"::Person:
                DirectDebitCollection.CreateRecord("No.", "Bank Account No.", pt::Person);
        End;
        Errores.SetRange("Document No.", Rec."No.");
        Errores.DeleteAll();
        DirectDebitCollection."Source Table ID" := DATABASE::"Bill Group";
        DirectDebitCollection.Modify();
        CheckSEPADirectDebitFormat(DirectDebitCollection);
        if DirectDebitCollection."Direct Debit Format" = DirectDebitCollection."Direct Debit Format"::N58 then
            TestField("Remesa al descuento");
        BankAccount.Get("Bank Account No.");
        Commit();
        DirectDebitCollectionEntry.SetRange("Direct Debit Collection No.", DirectDebitCollection."No.");
        RunFileExportCodeunitMa(BankAccount.GetDDExportCodeunitID, DirectDebitCollection."No.", DirectDebitCollectionEntry);
        DeleteDirectDebitCollection2(DirectDebitCollection."No.");
    end;

    local procedure CheckSEPADirectDebitFormat(var DirectDebitCollection: Record "Direct Debit Collection")
    var
        BankAccount: Record "Bank Account";
        DirectDebitFormat: Option;
        Selection: Integer;
    begin
        BankAccount.Get("Bank Account No.");
        if BankAccount.GetDDExportCodeunitID = CODEUNIT::"SEPA DD-Export File" then begin
            //if not DirectDebitFormatSilentlySelected then begin
            Selection := StrMenu(StrSubstNo('%1,%2', DirectDebitOptionTxt, InvoiceDiscountingOptionTxt), 1, InstructionTxt);

            if Selection = 0 then
                exit;

            case Selection of
                1:
                    DirectDebitFormat := DirectDebitCollection."Direct Debit Format"::Standard;
                2:
                    DirectDebitFormat := DirectDebitCollection."Direct Debit Format"::N58;
            end;
            // end else
            //   DirectDebitFormat := SilentDirectDebitFormat;

            DirectDebitCollection."Direct Debit Format" := DirectDebitFormat;
            DirectDebitCollection.Modify();
        end;
    end;

    var
        DirectDebitOptionTxt: Label 'Adeudo directo';
        InvoiceDiscountingOptionTxt: Label 'Al Descuento';
        InstructionTxt: Label 'Seleccione el formato a usar.';
}
