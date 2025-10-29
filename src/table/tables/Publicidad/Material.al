/// <summary>
/// Table Material (ID 7001128).
/// </summary>
table 7001128 Material
{
    LookupPageId = Materiales;
    DrillDownPageId = Materiales;
    Caption = 'Material';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Código"; Code[20])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
        }
        field(2; Material; Text[100])
        {
            Caption = 'Material';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Código")
        {
            Clustered = true;
        }
    }
}
