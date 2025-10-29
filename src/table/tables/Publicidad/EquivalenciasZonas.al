/// <summary>
/// Table Equivalencias Zonas (ID 7010465).
/// </summary>
table 7001152 "Equivalencias Zonas"
{
    fields
    {
        field(50002; "Dimensión Zona"; Code[20]) { TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('ZONA')); }
        field(50003; "Tipo Recurso"; Code[10])
        {
            TableRelation = "Tipo Recurso";
            Description = 'FK Tipo Recurso';
        }
        field(50009; "Zona"; Code[20])
        {
            TableRelation = "Zonas Recursos";
            Description = 'FK Zonas';
        }
    }
    KEYS
    {
        key(P; "Tipo Recurso", Zona) { Clustered = true; }
    }

}

