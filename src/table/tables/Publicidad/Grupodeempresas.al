/// <summary>
/// Table Grupo de empresas (ID 7001192).
/// </summary>
table 7001192 "Grupo de empresas"
{
    DataPerCompany = false;
    Caption = 'Grupo de empresas';

    fields
    {
        field(1; "Codigo"; Code[10])
        {
            Caption = 'Código';
            NotBlank = true;
        }
        field(2; "Descripcion"; Text[30]) { Caption = 'Descripción'; }
    }
    KEYS
    {
        key(P; Codigo, Descripcion) { Clustered = true; }
    }
    VAR
        ConfContab: Record "General Ledger Setup";

}

