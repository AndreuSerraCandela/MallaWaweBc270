/// <summary>
/// Table Recargo publicidad (ID 7001174).
/// </summary>
table 7001174 "Recargo publicidad"
{
    fields
    {
        field(1; "Cod. Soporte"; Code[20]) { TableRelation = Vendor WHERE(Soporte = CONST(true)); }
        field(2; "Periodo"; Integer) { }
        field(3; "Seccion"; Code[20])
        {
            TableRelation = "Seccion publicidad";
            Caption = 'Sección';
        }
        field(4; "Cod. Recargo"; Code[20]) { Caption = 'Recargo'; }
        field(5; "Recargo"; Decimal) { Caption = '% Recargo'; }
        field(6; "Descripción"; Text[60]) { }
    }
    KEYS
    {
        key(P; "Cod. Soporte", Periodo, "Cod. Recargo", Seccion)
        {
            Clustered = true;
        }
    }
}

