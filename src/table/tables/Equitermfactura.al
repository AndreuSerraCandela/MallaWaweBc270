/// <summary>
/// Table Equi. Términos Facuración (ID 7001145).
/// </summary>
table 7001145 "Equi. Términos Facuración"
{
    fields
    {
        field(1; "Duración Contrato"; DateFormula) { Caption = 'Duración Contrato'; }
        field(2; "Código Terminos"; Code[10])
        {
            TableRelation = "Términos facturación".Código;
            Caption = 'Código Terminos';
            NotBlank = true;
        }
        field(3; "No usar"; Code[30]) { Caption = 'No usar'; }
    }
    KEYS
    {
        key(P; "Duración Contrato", "Código Terminos", "No usar")
        {
            Clustered = true;
        }
    }
}

