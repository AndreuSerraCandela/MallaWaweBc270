/// <summary>
/// Table Cambios dimensiones (ID 7001180).
/// </summary>
table 7001180 "Cambios dimensiones"
{

    fields
    {
        field(1; "Cod. antiguo"; Code[20]) { TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(2)); }
        field(2; "Cod. nuevo"; Code[20]) { TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(2)); }
    }
    KEYS
    {
        key(P; "Cod. antiguo") { Clustered = true; }
    }
}


