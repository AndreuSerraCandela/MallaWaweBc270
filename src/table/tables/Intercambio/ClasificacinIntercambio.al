/// <summary>
/// Table Clasificación Intercambio (ID 50008).
/// </summary>
table 50008 "Clasificación Intercambio"
{
    Caption = 'Clasificación Intercambio';
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
    }
    keys
    {
        key(PK; "Clasificación")
        {
            Clustered = true;
        }
    }

}
