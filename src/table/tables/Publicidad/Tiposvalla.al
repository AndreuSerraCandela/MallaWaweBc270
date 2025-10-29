/// <summary>
/// Table Tipos valla (ID 7001172).
/// </summary>
table 7001172 "Tipos valla"
{
    fields
    {
        field(1; "Codigo"; Code[10]) { }
        field(2; "Tipo"; Text[30]) { }
        field(3; "Code"; Code[10]) { }
    }
    KEYS
    {
        key(P; Codigo) { Clustered = true; }
    }

}

