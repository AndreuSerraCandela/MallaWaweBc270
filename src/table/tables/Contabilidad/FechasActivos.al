/// <summary>
/// Table Fechas Activos (ID 7001125).
/// </summary>
table 7001125 "Fechas Activos"
{
    fields
    {
        field(1; "Activo Fijo"; Code[20]) { }
        field(2; "Fecha"; Date) { }
        field(3; "Años"; Integer) { }
    }
    KEYS
    {
        key(P; "Activo Fijo") { Clustered = true; }
    }
}
