/// <summary>
/// Table Relación Grupos (ID 7010468).
/// </summary>
table 7001159 "Relación Grupos"
{
    DataPerCompany = false;
    fields
    {
        field(1; "Empresa Origen"; Text[30]) { TableRelation = Company; }
        field(2; "Grupo Contable Origen"; Code[20]) { TableRelation = "Gen. Product Posting Group".Code; }
        field(3; "Empresa Destino"; Text[30]) { TableRelation = Company; }
        field(4; "Grupo Contable Destino"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group".Code;
            ValidateTableRelation = false;
            trigger OnLookup()
            VAR
                gpp: Record 251;
            BEGIN
                gpp.CHANGECOMPANY("Empresa Destino");
                if PAGE.RUNMODAL(0, gpp) IN [ACTION::LookupOK, ACTION::OK] THEN BEGIN
                    "Grupo Contable Destino" := gpp.Code;
                END;
            END;

        }
    }
    KEYS
    {
        key(Principal; "Empresa Origen", "Grupo Contable Origen", "Empresa Destino") { Clustered = true; }
    }

}







