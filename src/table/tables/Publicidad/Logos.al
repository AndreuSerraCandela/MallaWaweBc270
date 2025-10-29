/// <summary>
/// Table Logos (ID 7010472).
/// </summary>
table 7001171 Logos
{
    fields
    {
        field(1; "Clave"; Code[20]) { }
        field(2; "Logo01"; BLOB) { }
        field(3; "Logo02"; BLOB) { }
        field(4; "Logo03"; BLOB) { }
        field(5; "Logo04"; BLOB) { }
        field(6; "Logo05"; BLOB) { }
        field(7; "Logo06"; BLOB) { }
    }
    KEYS
    {
        key(P; Clave) { Clustered = true; }
    }

}

