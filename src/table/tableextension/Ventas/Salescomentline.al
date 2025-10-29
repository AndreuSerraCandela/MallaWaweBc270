/// <summary>
/// TableExtension Sales Comment LineKuara (ID 80152) extends Record Sales Comment Line.
/// </summary>
tableextension 80152 "Sales Comment LineKuara" extends "Sales Comment Line"
{
    fields
    {
        field(50000; "Precio"; Decimal) { }
        field(50001; "% Iva"; Decimal) { }
        field(50002; "Iva"; Decimal) { }
        field(50003; "Importe"; Decimal) { }
        field(50004; "Validada"; Boolean) { }
        field(50005; "Cantidad"; Decimal) { }
    }
}