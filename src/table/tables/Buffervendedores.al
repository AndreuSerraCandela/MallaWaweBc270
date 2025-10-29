/// <summary>
/// Table Buffer vendedores (ID 7001169).
/// </summary>
table 7001169 "Buffer vendedores"
{
    fields
    {
        field(1; "Vendedor"; Code[10]) { TableRelation = "Salesperson/Purchaser"; }
        field(2; "Nombre Cliente"; Text[80]) { }
        field(3; "Cliente"; Code[10]) { TableRelation = Customer; }
        field(4; "Dimension Principal"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('PRINCIPAL'));
        }
        field(5; "Nombre Dimension"; Text[80]) { }
        field(6; "Importe"; Decimal) { }
        field(7; "Filtro Fecha"; Date) { FieldClass = FlowFilter; }
        field(8; "Telefono"; Text[30]) { }
        field(9; "Nombre Vendedor"; Text[80]) { }
    }
    KEYS
    {
        key(P; Vendedor, Cliente, "Dimension Principal") { Clustered = true; }
    }

}
