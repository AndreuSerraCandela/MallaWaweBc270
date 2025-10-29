/// <summary>
/// Table Ultimas reservas recurso (ID 80102).
/// </summary>

table 7001205 "Ultimas reservas recursos"
{
    fields
    {
        field(1; "Cod Recurso"; Code[20])
        {
            TableRelation = Resource;
            Caption = 'Cód. Recurso';
        }
        field(2; "Nombre"; Text[50]) { }
        field(3; "Medidas"; Code[20]) { TableRelation = Medidas; }
        field(4; "Zona"; Code[20]) { TableRelation = "Zonas Recursos"; }
        field(5; "Nº fam recurso"; Code[20])
        {
            TableRelation = "Resource Group";
            Caption = 'Nº fam. recurso';
        }
        field(6; "Iluminado"; Boolean) { InitValue = false; }
        field(7; "Ult proyecto"; Code[20])
        {
            TableRelation = Job;
            Caption = 'Ult. proyecto';
        }
        field(8; "Fecha inicial"; Date) { }
        field(9; "Soporte de"; Enum "Soporte de") { }
        field(10; "Fecha final"; Date) { }
        field(11; "Fija/Papel"; Enum "Fija/Papel")
        {

        }
        field(12; "Fecha baja"; Date) { }
        field(50; "Usuario"; Code[50]) { TableRelation = User; }
    }
    KEYS
    {
        key(P; Usuario, "Cod Recurso") { Clustered = true; }
    }
}
