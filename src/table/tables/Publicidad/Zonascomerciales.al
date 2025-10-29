/// <summary>
/// Table Zonas comerciales (ID 7010450).
/// </summary>
table 7001100 "Zonas comerciales"
{
    Caption = 'Zonas comerciales';
    LookupPageId = "Zonas Comerciales";
    DrillDownPageId = "Zonas Comerciales";
    fields
    {
        field(1; Zona; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Descripcion; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        Key(Primary; Zona)
        {
            Clustered = true;

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Zona, Descripcion)
        {

        }

    }

}
