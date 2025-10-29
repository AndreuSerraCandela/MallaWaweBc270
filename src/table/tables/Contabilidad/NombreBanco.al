/// <summary>
/// Table Nombre Banco (ID 7010469).
/// </summary>
table 7001160 "Nombre Banco"
{

    LookupPageId = "Nombres Banco";
    DrillDownPageId = "Nombres Banco";
    DataPerCompany = false;
    fields
    {
        field(1; "Nombre Banco"; Text[30]) { }
    }
    KEYS
    {
        key(P; "Nombre Banco") { Clustered = true; }
    }
}

