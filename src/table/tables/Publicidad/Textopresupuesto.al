/// <summary>
/// Table Texto Presupuesto (ID 7001181).
/// </summary>
table 7001181 "Texto Presupuesto"
{
    fields
    {
        field(1; "Nº proyecto"; Code[20]) { TableRelation = Job; }
        field(2; "Cód. fase"; Code[10]) { }
        field(3; "Cód. subfase"; Code[10]) { }
        field(4; "Cód. tarea"; Code[10]) { TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Nº proyecto")); }
        field(5; "Tipo"; Enum "Tipo (presupuesto)") { }
        field(6; "Nº"; Code[20])
        {
            TableRelation = if (Tipo = CONST(Recurso)) Resource
            ELSE
            if (Tipo = CONST(Producto)) Item
            ELSE
            if (Tipo = CONST(Cuenta)) "G/L Account"
            ELSE
            if (Tipo = CONST(Texto)) "Standard Text"
            ELSE
            if (Tipo = CONST(Familia)) "Resource Group";
        }
        field(7; "Cód. variante"; Code[10]) { TableRelation = if (Tipo = CONST(Producto)) "Item Variant".Code WHERE("Item No." = FIELD("Nº")); }
        field(10; "Nº linea"; Integer) { }
        field(15; "Texto"; Text[50]) { }
        field(20; "Tipo linea"; Enum "TipoLinea")
        {

        }
        field(25; "Nº linea aux"; Integer) { }
        field(26; "Remarcar"; Boolean) { }
    }
    KEYS
    {
        key(P; "Nº proyecto", "Cód. fase", "Cód. subfase", "Cód. tarea", Tipo, "Nº", "Cód. variante", "Nº linea aux", "Nº linea")
        {
            Clustered = true;
        }
        key(A; "Nº linea") { }
        key(B; "Nº proyecto", "Cód. tarea", "Nº linea aux", Tipo, Nº, "Cód. variante") { }
        key(C; "Nº proyecto", "Nº linea") { }
    }
    trigger OnInsert()
    var
        rSelf: Record "Texto Presupuesto";
    BEGIN
        TESTFIELD("Nº proyecto");
        rSelf.SetCurrentKey("Nº proyecto", "Nº linea");
        rself.SetRange("Nº proyecto", Rec."Nº proyecto");
        if rSelf.FindLast() Then
            "Nº Linea" := rself."Nº linea" + 10000
        else
            "Nº Linea" := 10000;

    END;

}

