/// <summary>
/// Table Latitudes (ID 7001124).
/// </summary>
table 50098 Latitudes
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Recurso"; Code[20]) { }
        field(2; "Longitud"; Decimal) { DecimalPlaces = 10 : 10; }
        field(3; "Latitud"; Decimal) { DecimalPlaces = 10 : 10; }
    }
    KEYS
    {
        key(P; Recurso) { Clustered = true; }
    }
}

