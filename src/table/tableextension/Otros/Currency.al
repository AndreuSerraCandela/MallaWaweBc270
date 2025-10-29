/// <summary>
/// TableExtension CurrencyKuara (ID 80114) extends Record Currency.
/// </summary>
tableextension 80114 "CurrencyKuara" extends "Currency"
{
    fields
    {
        field(50000; "Clave de divisa"; CODE[3]) { }
        field(50001; "Divisa local"; Boolean) { }
    }
}