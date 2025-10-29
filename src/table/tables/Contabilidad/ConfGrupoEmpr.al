/// <summary>
/// Table Configuración Grupo Empresas (ID 7010463).
/// </summary>
table 7001124 "Configuración Grupo Empresas"
{
    DataPerCompany = false;
    fields
    {
        field(1; "IC Socio Org./Des."; Code[20]) { TableRelation = "IC Partner".Code; }
        field(2; "IC Socio Des./Org."; Code[20]) { TableRelation = "IC Partner".Code; }
        field(3; "IC Socio Último Intermedio"; Code[20]) { TableRelation = "IC Partner".Code; }
        field(4; "Código Apunte"; Code[20]) { }
    }
    KEYS
    {
        key(Principal; "Código Apunte", "IC Socio Org./Des.", "IC Socio Des./Org.")
        {
            Clustered = true;
        }
    }

}
