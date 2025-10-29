/// <summary>
/// Table Configuración G. Emp. detalle (ID 7001127).
/// </summary>
table 7001127 "Configuración G. Emp. detalle"
{
    DataPerCompany = false;

    fields
    {
        field(1; "IC Socio Org./Des."; Code[20]) { TableRelation = "IC Partner".Code; }
        field(2; "IC Socio Des./Org."; Code[20]) { TableRelation = "IC Partner".Code; }
        field(3; "IC Socio Último Intermedio"; Code[20]) { TableRelation = "IC Partner".Code; }
        field(4; "Línea"; Integer) { }
        field(5; "Tipo Debe"; Enum "Tipo Debe/Haber") { }
        field(6; "Cuenta Debe"; Code[20])
        {
            TableRelation = if ("Tipo Debe" = CONST(Cuenta)) "G/L Account"."No."
            ELSE
            if ("Tipo Debe" = CONST(Socio)) "IC Partner".Code;
        }
        field(7; "Tipo Haber"; Enum "Tipo Debe/Haber") { }

        field(8; "Cuenta Haber"; Code[20])
        {
            TableRelation = if ("Tipo Haber" = CONST(Cuenta)) "G/L Account"."No."
            ELSE
            if ("Tipo Haber" = CONST(Socio)) "IC Partner".Code;
        }
        field(9; "Empresa Asiento"; Text[30]) { TableRelation = "IC Partner".Code; }
        field(10; "Usar Cuenta Intermedia en Debe"; Boolean) { }
        field(11; "Usar Cuenta Intermedia en Habe"; Boolean) { }
        field(12; "Código Apunte"; Code[20]) { }
        field(13; "Tipo Cuenta debe"; Enum "Tipo Cuenta Debe") { }
        field(14; "Tipo Cuenta haber"; Enum "Tipo Cuenta Haber") { }
    }
    KEYS
    {
        key(P; "Código Apunte", "IC Socio Org./Des.", "IC Socio Des./Org.", Línea)
        {
            Clustered = true;
        }
    }
    VAR
        rConf: Record "Configuración G. Emp. detalle";

    trigger OnInsert()
    BEGIN
        rConf.GET("Código Apunte", "IC Socio Org./Des.", "IC Socio Des./Org.");
        "IC Socio Último Intermedio" := rConf."IC Socio Último Intermedio";
    END;


}

