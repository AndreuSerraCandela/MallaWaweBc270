/// <summary>
/// TableExtension VAT Business Post. GroupKuara (ID 80217) extends Record VAT Business Posting Group.
/// </summary>
tableextension 80217 "VAT Business Post. GroupKuara" extends "VAT Business Posting Group"
{
    fields
    {
        field(50000; "Codigo Ruta"; CODE[10]) { }
        field(80000; "Clave registro SII expedidas"; CODE[2]) { }
        field(80001; "Clave registro SII recibidas"; CODE[2]) { }
        field(80002; "Devengo SII"; Enum "Devengo SII") { }
    }
}
