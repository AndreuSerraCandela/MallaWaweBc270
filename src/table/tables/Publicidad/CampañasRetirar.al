/// <summary>
/// Table Campañas a retirar (ID 50014).
/// </summary>
table 50014 "Campañas a retirar"
{
    Caption = 'Campañas a retirar';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Fecha"; Date)
        {
            Caption = 'Fecha';
        }
        field(3; "Campaña"; Text[100])
        {
            Caption = 'Campaña';
        }
        field(4; "Tirar"; Boolean)
        {
            Caption = 'Tirar';
        }
        field(5; "Observaciones"; Text[250])
        {
            Caption = 'Observaciones';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Fecha; "Fecha")
        {
        }
        key(Campaña; "Campaña")
        {
        }
    }
}
