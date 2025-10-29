/// <summary>
/// Table Texto orden publicidad (ID 7001136).
/// </summary>
table 7001136 "Texto orden publicidad"
{
    Caption = 'Texto orden publicidad';
    fields
    {
        field(1; "Tipo orden"; Enum "Tipo orden")
        {
            Caption = 'Tipo de orden';

        }
        field(2; "No."; Code[20]) { Caption = 'Nº'; }
        field(3; "No. linea"; Integer) { Caption = 'Nº línea'; }
        field(6; "Texto"; Text[60]) { Caption = 'Texto anuncio'; }
    }
    KEYS
    {
        key(P; "Tipo orden", "No.", "No. linea") { Clustered = true; }
    }
}

