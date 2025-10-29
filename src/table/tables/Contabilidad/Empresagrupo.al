/// <summary>
/// Table Empresa grupo (ID 7001187).
/// </summary>
table 7001187 "Empresa grupo"
{
    DataPerCompany = false;
    Caption = 'Empresa grupo';
    LookupPageId = "Lista empresas grupo";
    DrillDownPageId = "Lista empresas grupo";

    fields
    {
        field(1; "Cod. grupo"; Code[10])
        {
            TableRelation = "Grupo de empresas";
            Caption = 'Cód. grupo';
            NotBlank = true;
        }
        field(2; "Empresa"; Text[30])
        {
            TableRelation = Company;
            Caption = 'Empresa';
            NotBlank = true;
        }
    }
    KEYS
    {
        key(P; "Cod. grupo", Empresa) { Clustered = true; }
    }
    VAR
        ConfContab: Record "General Ledger Setup";

}

