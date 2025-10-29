/// <summary>
/// Table Tarifas publicidad (ID 7001132).
/// </summary>
table 7001132 "Tarifas publicidad"
{
    fields
    {
        field(1; "Cod. Soporte"; Code[20]) { TableRelation = Vendor WHERE(Soporte = CONST(true)); }
        field(2; "Periodo"; Integer) { Caption = 'Periodo'; }
        field(3; "Seccion"; Code[20])
        {
            TableRelation = "Seccion publicidad";
            Caption = 'Sección';
        }
        field(4; "Descripcion"; Text[90]) { Caption = 'Descripción'; }
    }
    KEYS
    {
        key(P; "Cod. Soporte", Periodo, Seccion) { Clustered = true; }
    }
    VAR
        rLinTarifa: Record "Price List Line";

    trigger OnInsert()
    BEGIN
        Periodo := DATE2DMY(WORKDATE, 3);
    END;

    trigger OnDelete()
    BEGIN

        rLinTarifa.RESET;
        rLinTarifa.SetRange("Source Type", rLinTarifa."Source Type"::Vendor);
        rLinTarifa.SETRANGE("source No.", "Cod. Soporte");
        rLinTarifa.SETRANGE("Starting Date", DMY2DATE(1, 1, Periodo));
        rLinTarifa.SETRANGE(Seccion, Seccion);
        if rLinTarifa.FIND('-') THEN
            rLinTarifa.DELETEALL;
    END;

}

