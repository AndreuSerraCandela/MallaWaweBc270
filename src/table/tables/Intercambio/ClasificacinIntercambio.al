/// <summary>
/// Table Clasificación Intercambio (ID 50008).
/// </summary>
table 50008 "Clasificación Intercambio"
{
    Caption = 'Clasificación';
    DataClassification = ToBeClassified;
    LookupPageId = "Clasificación";
    DrillDownPageId = "Clasificación";

    fields
    {
        field(1; "Clasificación"; Code[20])
        {

            Caption = 'Clasificación';
            DataClassification = ToBeClassified;
        }
        //Tipo Enum, Intercambio Conceptos Comunes, Conceptos Propios
        field(2; "Tipo"; Enum "Tipo Clasificación Intercambio")
        {
            Caption = 'Tipo';
            DataClassification = ToBeClassified;
        }
        //Banco
        field(3; "Banco"; Code[20])
        {
            Caption = 'Banco';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
    }
    keys
    {
        key(PK; "Clasificación", "Tipo", "Banco")
        {
            Clustered = true;
        }
    }

}
