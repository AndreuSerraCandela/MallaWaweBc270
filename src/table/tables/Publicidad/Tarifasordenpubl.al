/// <summary>
/// Table Tarifas orden publicidad (ID 7001137).
/// </summary>
table 7001137 "Tarifas orden publicidad"
{
    fields
    {
        field(1; "Tipo orden"; Enum "Tipo orden")
        {
            Caption = 'Tipo orden publicidad';

        }
        field(2; "No"; Code[20]) { Caption = 'Nº orden'; }
        field(30; "Dia tarifa"; Code[10]) { }
        field(40; "Precio"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                RecalcularLineas;
            END;
        }
    }
    KEYS
    {
        key(P; "Tipo orden", No, "Dia tarifa") { Clustered = true; }
    }
    PROCEDURE RecalcularLineas();
    VAR
        rOrden: Record "Cab. orden publicidad";
        rLinOrden: Record "Lin. orden publicidad";
    BEGIN

        // Si hay lineas afectadas se tienen que recalcular

        rLinOrden.RESET;
        rLinOrden.SETRANGE("Tipo orden", "Tipo orden");
        rLinOrden.SETRANGE("No. orden", No);
        rLinOrden.SETRANGE("Dia tarifa", "Dia tarifa");
        if rLinOrden.FIND('-') THEN
            REPEAT
                // Descartamos las lineas con tarifa conjunta excepto el primer dia.
                if NOT ((rLinOrden."Dia conjunto" <> 0D) AND (rLinOrden."Dia conjunto" <> rLinOrden."Fecha inicio")) THEN BEGIN
                    if Precio = 0 THEN BEGIN
                        CLEAR(rLinOrden."Dia conjunto");       // 001
                        CLEAR(rLinOrden."Dia tarifa");         // 001
                    END;
                    rLinOrden.VALIDATE(Precio, Precio);
                    rLinOrden.MODIFY;
                END;
            UNTIL rLinOrden.NEXT = 0;
    END;
}

