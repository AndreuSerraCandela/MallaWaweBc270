/// <summary>
/// Table Zonas Recursos (ID 50001).
/// </summary>
table 50001 "Zonas Recursos"
{
    Caption = 'Zonas Recursos';
    DataClassification = ToBeClassified;
    LookupPageId = "Zonas Recursos";
    DrillDownPageId = "Zonas Recursos";
    fields
    {
        field(1; "Cod. Zona"; Code[20])
        {
            Caption = 'Cod. Zona';
            DataClassification = ToBeClassified;
        }
        field(2; "Texto Zona"; Text[30])
        {
            Caption = 'Texto Zona';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Cod. Zona")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(Dropdown; "Cod. Zona", "Texto Zona")
        { }
    }
}
