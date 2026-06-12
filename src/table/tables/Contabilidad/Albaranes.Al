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
        field(11; Status; Option)
        {
            OptionMembers = Calculado,Calculating,Error;
        }
        field(12; "Error Message"; Text[250]) { }
        field(13; "Pct. Facturado"; Decimal) { }
        field(14; "Pct. Pendiente"; Decimal) { }
        field(15; "Pct. Facturado Año Ant."; Decimal) { }
        field(16; "Pct. Pendiente Año Ant."; Decimal) { }
        field(17; "Contratos Count"; Integer) { }
        field(18; "Billing Cutoff Text"; Text[250]) { }
        field(19; "Last Updated"; DateTime) { }
        //Salesperson Code
        field(20; "Salesperson Code"; Code[20]) { }

    }
    KEYS
    {
        key(Pk; Albaran) { Clustered = true; }
    }

}

