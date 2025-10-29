/// <summary>
/// Table Medidas (ID 50003).
/// </summary>
table 50003 Medidas
{
    LookupPageId = Medidas;
    DrillDownPageId = Medidas;
    Caption = 'Medidas';
    fields
    {
        field(1; Medidas; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    Keys
    {
        Key(PrimaryKey; Medidas)
        {
            Clustered = true;
        }

    }
}