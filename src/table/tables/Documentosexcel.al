/// <summary>
/// Table Documentos Excel (ID 7001148).
/// </summary>
table 7001148 "Documentos Excel"
{

    DataPerCompany = false;
    fields
    {
        field(1; "Código Excel"; Code[10]) { }
        field(5; "Nombre documento Excel"; Text[30]) {; Editable = false; }
        field(10; "Documento"; BLOB) { }
    }
    KEYS
    {
        key(P; "Código Excel") { Clustered = true; }
    }
}

