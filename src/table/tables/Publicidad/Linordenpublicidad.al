/// <summary>
/// Table Lin. orden publicidad (ID 7001135).
/// </summary>
table 7001135 "Lin. orden publicidad"
{
    fields
    {
        field(1; "Tipo orden"; Enum "Tipo orden")
        {
            Caption = 'Tipo orden';

        }
        field(2; "No. orden"; Code[20]) { Caption = 'Nº orden'; }
        field(3; "No. linea"; Integer) { Caption = 'Nº linea'; }
        field(4; "Inserciones"; Integer)
        {
            Caption = 'Nº Inserciones';
            trigger OnValidate()
            BEGIN
                CalculoImporte;
            END;

        }
        field(5; "Concepto"; Code[20])
        {
            TableRelation = Resource;
            Caption = 'Espacio';
        }
        field(6; "Dia tarifa"; Code[10])
        {
            TableRelation = "Dias tarifa publicidad".Codigo;
            Caption = 'Día tarifa';
        }
        field(7; "Precio"; Decimal)
        {
            Caption = 'Precio';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            BEGIN
                CalculoImporte;
            END;

        }
        field(8; "Importe"; Decimal) { Caption = 'Importe linea'; }
        field(9; "Ancho"; Decimal) { }
        field(10; "Alto"; Decimal) { }
        field(11; "Fecha inicio"; Date) { }
        field(12; "Fecha fin"; Date) { }
        field(13; "Facturada"; Boolean) { Caption = 'Facturada'; }
        field(14; "Recargo"; Decimal)
        {
            Caption = '% Recargo';
            trigger OnValidate()
            BEGIN
                CalculoImporte;
            END;

        }
        field(15; "Tiempo extra"; Integer) { Caption = 'Tiempo extra'; }
        field(16; "Precio extra"; Decimal)
        {
            Caption = 'Precio tiempo extra';
            trigger OnValidate()
            BEGIN
                CalculoImporte;
            END;

        }
        field(17; "Factura"; Code[20]) { }
        field(18; "Observaciones"; Text[60]) { Caption = 'Observaciones'; }
        field(19; "Importe manual"; Boolean) { }
        field(20; "Dia conjunto"; Date) { Caption = 'Día conjunto'; }
        field(23; "Duracion"; Integer) { Caption = 'Duración (seg)'; }
        field(25; "Fecha factura"; Date) {; Description = '$001'; }
        field(30; "No cliente"; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Nº cliente';
        }
    }
    KEYS
    {
        key(P; "No. orden", "No. linea")
        {
            SumIndexfields = Importe;
            Clustered = true;
        }
        key(A; "Tipo orden", "No. orden", "Fecha inicio") { SumIndexfields = Importe; }
        key(B; Factura) { }
        key(C; "Tipo orden", "No. orden", "Dia tarifa", Concepto, "Fecha inicio") { }
        key(D; "Fecha inicio") { }
    }
    VAR
        rOrdenes: Record "Cab. orden publicidad";
        rDiasOrden: Record "Dias orden publicidad";

        wDia: Date;
        Err01: Label 'No es posible eliminar una linea facturada.';

    trigger OnInsert()
    BEGIN

        ComprobarEstado;
        if rOrdenes.GET("No. orden") THEN
            "No cliente" := rOrdenes."No cliente";
    END;

    trigger OnModify()
    BEGIN

        ComprobarEstado;
    END;

    trigger OnDelete()
    BEGIN

        ComprobarEstado;

        if Facturada THEN
            ERROR(Err01);

        FOR wDia := "Fecha inicio" TO "Fecha fin" DO
            if rDiasOrden.GET("Tipo orden", "No. orden", wDia) THEN
                rDiasOrden.DELETE;

        // Si la linea borrada formaba parte de una tarifa conjunto debemos recalcular el importe de las lineas

    END;

    PROCEDURE UltLinea(): Integer;
    VAR
        rLinOrden: Record "Lin. orden publicidad";
    BEGIN

        rLinOrden.RESET;
        rLinOrden.SETRANGE(rLinOrden."Tipo orden", "Tipo orden");
        rLinOrden.SETRANGE(rLinOrden."No. orden", "No. orden");
        if rLinOrden.FIND('+') THEN
            EXIT(rLinOrden."No. linea");
    END;

    PROCEDURE CalculoImporte();
    BEGIN

        CASE "Tipo orden" OF
            "Tipo orden"::Prensa:
                Importe := Alto * Ancho * Inserciones * Precio;
            "Tipo orden"::Radio:
                Importe := (Precio * Inserciones) + ("Tiempo extra" * "Precio extra");
            "Tipo orden"::Audiovisuales:
                Importe := (Precio * Inserciones);
        END;

        //  Importe := ROUND(Importe + (Importe * Recargo / 100),0.01);
    END;



    PROCEDURE GetDiasInsercion(VAR pTextoDias: Text[60]): Integer;
    VAR
        rDiasOrden: Record "Dias orden publicidad";
        wSep: Text[2];
    BEGIN

        rDiasOrden.RESET;
        rDiasOrden.SETRANGE("Tipo orden", "Tipo orden");
        rDiasOrden.SETRANGE("No. orden", "No. orden");
        rDiasOrden.SETRANGE(Dia, "Fecha inicio", "Fecha fin");
        if rDiasOrden.FIND('-') THEN BEGIN
            REPEAT
                pTextoDias := COPYSTR(pTextoDias + wSep + FORMAT(rDiasOrden.Dia, 0, '<Day>'), 1, 60);
                wSep := ', ';
            UNTIL rDiasOrden.NEXT = 0;
            EXIT(rDiasOrden.COUNT);
        END;
    END;

    PROCEDURE ComprobarEstado();
    VAR
        recCabOrden: Record "Cab. orden publicidad";
    BEGIN
        if recCabOrden.GET("No. orden") THEN
            recCabOrden.TESTFIELD(Estado, recCabOrden.Estado::Abierta);
    END;


}

