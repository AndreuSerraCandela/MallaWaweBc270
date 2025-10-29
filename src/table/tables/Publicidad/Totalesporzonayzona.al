/// <summary>
/// Table Totales por zona y zona (ID 7001121).
/// </summary>
table 7001121 "Totales por zona y zona"
{
    fields
    {
        field(1; "Dimension Zona"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            Caption = 'Dimension Zona';
            CaptionClass = '1,2,4';
        }
        field(2; "Zona"; Code[20])
        {
            TableRelation = "Zonas Recursos";
            Description = 'FK Zonas';
        }
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
        field(50004; "Nº Recusrsos Zona"; Integer) { }
        field(50005; "Dias No Pay + Bajas"; Integer) { }
        field(50006; "Dias S/C"; Integer) { }
        field(50007; "Dias Baja"; Integer) { }
        field(50008; "Dias No Pay"; Integer) { }
        field(50009; "Nº Recusrsos Totales Zona"; Integer) { }
        field(50010; "Importe"; Decimal) { }
        field(50011; "Importe Circuitos"; Decimal) { }
        field(50012; "Categoria"; Code[20]) { TableRelation = "Customer Price Group"; }
    }
    KEYS
    {
        key(P; "Dimension Zona", Zona, "Tipo Recurso", "Categoria")
        {
            Clustered = true;
        }
    }
}

