/// <summary>
/// Table Totales por zona (ID 7001163).
/// </summary>
table 7001163 "Totales por zona"
{
    fields
    {
        field(1; "Zona"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            Caption = 'Zona';
            CaptionClass = '1,2,4';
        }
        field(2; "Municipio"; Code[15]) { }
        field(3; "Dias Totales"; Integer) { }
        field(4; "Dias Ocupados"; Integer) { }
        field(5; "Filtro Fecha"; Date) { FieldClass = FlowFilter; }
        field(6; "Dias Ocupados Con Circuitos"; Integer) {; }
        field(7; "Dias Circuitos"; Integer) { }
        field(50003; "Tipo Recurso"; Code[10])
        {
            TableRelation = "Tipo Recurso";
            Description = 'FK Tipo Recurso';
        }
        field(50004; "Nº Recusrsos Municipio"; Integer) { }
        field(50005; "Dias No Pay+Bajas"; Integer) { }
        field(50006; "Dias S/C"; Integer) { }
        field(50007; "Dias Baja"; Integer) { }
        field(50008; "Dias No Pay"; Integer) { }
        field(50009; "Nº Recusrsos Totales municipio"; Integer) {; }
        field(50010; "Importe"; Decimal) { }
        field(50011; "Importe Circuitos"; Decimal) { }
    }
    KEYS
    {
        key(P; Zona, Municipio, "Tipo Recurso") { Clustered = true; }
    }

}

