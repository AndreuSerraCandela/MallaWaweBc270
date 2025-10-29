/// <summary>
/// Table Re-Tar (ID 7001122).
/// </summary>
table 7001122 "Re-Tar"
{
    fields
    {
        field(1; "Recurso"; Code[20]) { }
        field(2; "Tarifa"; Code[20]) { }
    }
    KEYS
    {
        key(P; Recurso) { Clustered = true; }
    }

}

