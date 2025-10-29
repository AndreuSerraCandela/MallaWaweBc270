/// <summary>
/// Table Facturas (ID 7001161).
/// </summary>
table 7001161 Facturas
{
    fields
    {
        field(1; "Factura"; Code[20]) { }
        field(2; "Procesada"; Boolean) { }
        field(3; "Vorver a procesar"; Boolean) { }
        field(4; "Base"; Decimal) { }
        field(5; "Iva"; Decimal) { }
        field(6; "Mov Cliente"; Integer) { }
        field(7; "Mov Cliente2"; Integer) { }
        field(8; "Fatura Contabilidad"; Code[20]) { }
        field(9; "Mas de una"; Boolean) { }
    }
    KEYS
    {
        key(P; Factura) { Clustered = true; }
    }

}

