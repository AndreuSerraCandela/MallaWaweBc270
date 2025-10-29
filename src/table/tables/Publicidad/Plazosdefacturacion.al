/// <summary>
/// Table Plazos de facturación (ID 7010460).
/// </summary>
table 7001109 "Plazos de facturación"
{
    LookupPageId = "Plazos de facturación";
    DrillDownPageId = "Plazos de facturación";
    fields
    {
        field(1; "Cód. términos facturación"; Code[10]) { TableRelation = "Términos facturación"; }
        field(2; "Nº línea"; Integer) { }
        field(3; "% del total"; Decimal) { DecimalPlaces = 2 : 5; }
        field(4; "Distancia entre plazos"; Code[20]) { DateFormula = true; }
    }
    KEYS
    {
        key(Principal; "Cód. términos facturación", "Nº línea")
        {
            SumIndexFields = "% del total";
            Clustered = true;
        }
    }

}
