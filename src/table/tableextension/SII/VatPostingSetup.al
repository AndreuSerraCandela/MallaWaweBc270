/// <summary>
/// TableExtension VAT Posting SetupKuara (ID 80219) extends Record VAT Posting Setup.
/// </summary>
tableextension 80219 "VAT Posting SetupKuara" extends "VAT Posting Setup"
{
    fields
    {
        field(50000; "Emplazaminentos"; Boolean) { }
        field(50705; "VAT Cash Regime ant"; Boolean) { }
        field(80003; "Tipo desglose emitidas"; CODE[3]) { }
        field(80004; "Sujeta exenta"; CODE[3]) { }
        field(80005; "Tipo de operación"; CODE[2]) { }
        field(80006; "Obviar SII"; Boolean) { }
        field(80009; "Tipo desglose recibidas"; CODE[3]) { }
    }
}
