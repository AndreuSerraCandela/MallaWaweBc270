/// <summary>
/// Table Codigos cadena (ID 7010464).
/// </summary>
table 7001144 "Codigos cadena"
{
    fields
    {
        field(1; "Codigo"; Code[10]) { Caption = 'Código'; }
        field(2; "Descripcion"; Text[100]) { Caption = 'Descripción'; }
    }
    KEYS
    {
        key(Principal; Codigo) { Clustered = true; }
    }

}
