/// <summary>
/// Table Detalle Fechas x Usuario (ID 7001138).
/// </summary>
table 7001138 "Detalle Fechas x Usuario"
{
    fields
    {
        field(1; "Fila"; Code[20]) { }
        field(2; "Fecha"; Date) { }
        field(3; "Empresa 1"; Decimal) { }
        field(4; "Empresa 2"; Decimal) { }
        field(5; "Empresa 3"; Decimal) { }
        field(6; "Empresa 4"; Decimal) { }
        field(7; "Empresa 5"; Decimal) { }
        field(8; "Empresa 6"; Decimal) { }
        field(9; "Empresa 7"; Decimal) { }
        field(10; "Empresa 8"; Decimal) { }
        field(11; "Empresa 9"; Decimal) { }
        field(12; "Empresa 10"; Decimal) { }
        field(13; "Empresa 11"; Decimal) { }
        field(14; "Total"; Decimal) { }
        field(15; "Filtro Fecha"; Date) { FieldClass = FlowFilter; }
        field(16; "Nombre Esquema"; Code[20]) { TableRelation = "Acc. Schedule Name"; }
        field(17; "Descripcion"; Text[250]) { }
        field(18; "Linea"; Integer) { }
        field(19; "Totaling Type"; Enum "Acc. Schedule Line Totaling Type")
        {

        }
        field(20; Usuario; Code[50]) { TableRelation = "User Setup"."User ID"; }
    }
    KEYS
    {
        key(P; Usuario, Linea, Fecha) { Clustered = true; }
    }

}
