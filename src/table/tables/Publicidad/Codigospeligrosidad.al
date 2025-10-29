/// <summary>
/// Table Codigos peligrosidad (ID 7010452).
/// </summary>
table 7001102 "Codigos peligrosidad"
{
    Caption = 'Codigos peligrosidad';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Codigo; Code[10])
        {
            Caption = 'Codigo';
            DataClassification = ToBeClassified;
        }
        field(2; Descripcion; Text[30])
        {
            Caption = 'Descripcion';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Codigo)
        {
            Clustered = true;
        }
    }

}
