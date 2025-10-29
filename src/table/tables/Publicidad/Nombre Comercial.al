
/// <summary>
/// Table Nombre Comercial (ID 7001126).
/// </summary>
table 7001126 "Nombre Comercial"
{
    DataPerCompany = false;
    LookupPageId = "Nombre Comercial";
    DrillDownPageId = "Nombre Comercial";
    Caption = 'Anunciantes';
    fields
    {
        field(1; "Nombre"; Text[250]) { }

    }
    KEYS
    {
        key(PK; Nombre) { Clustered = true; }
    }

}
