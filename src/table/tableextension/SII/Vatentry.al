/// <summary>
/// TableExtension VAT EntryKuara (ID 80195) extends Record VAT Entry.
/// </summary>
tableextension 80195 "VAT EntryKuara" extends "VAT Entry"
{
    fields
    {
        field(50001; "Orden anterior"; Integer) { }
        field(50002; "Nuevo Número"; CODE[20]) { }
        field(50705; "VAT Cash Regime ant"; Boolean) { }
        field(80000; "Tipo factura SII"; CODE[2]) { }
        field(80001; "Clave registro SII expedidas"; CODE[2]) { }
        field(80002; "Clave registro SII recibidas"; CODE[2]) { }
        field(80003; "Tipo desglose emitidas"; CODE[3]) { }
        field(80004; "Sujeta exenta"; CODE[3]) { }
        field(80005; "Tipo de operación"; CODE[2]) { }
        field(80006; "Descripción operación"; TEXT[250]) { }
        field(80007; "Tipo factura rectificativa"; CODE[1]) { }
        field(80009; "Tipo desglose recibidas"; CODE[3]) { }
    }
}