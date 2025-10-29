/// <summary>
/// Table Calculo Albaranes (ID 50009).
/// </summary>
Table 50009 "Calculo Albaranes"
{
    //LinkedObject = true;
    FIELDS
    {
        field(1; Albaran; Code[20]) { }
        field(2; Contabilizado; Decimal) { }
        field(3; Facturado; Decimal) { }
        field(4; Proveedor; Code[20]) { }
        field(5; Total2; Decimal) { }
        field(6; "Facturado Contabilidad"; Decimal) { }
        field(7; Calculado; Boolean) { }
        field(8; Finalizado; Boolean) { }
        field(9; Facturado2; Decimal) { }
        field(10; "Facturado No Finalizado"; Decimal) { }
    }
    KEYS
    {
        key(Pk; Albaran) { Clustered = true; }
    }

}

