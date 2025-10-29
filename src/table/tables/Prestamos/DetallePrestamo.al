/// <summary>
/// Table Detalle Prestamo (ID 7001215).
/// </summary>
table 7001188 "Detalle Prestamo"
{
    fields
    {
        field(1; "Código Del Prestamo"; Text[100]) { TableRelation = "Cabecera Prestamo"; }
        field(2; "No. Periodo"; Integer) { }
        field(3; "Fecha"; Date) { }
        field(4; "Capital Pendiente"; Decimal) { }
        field(5; "Total Liquidación"; Decimal) { }
        field(6; "Amortización"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                "A Pagar" := ("Total Liquidación" + Gastos) * (1 + Iva / 100);
            END;
        }
        field(7; "Intereses"; Decimal) { }
        field(8; "Gastos"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                "A Pagar" := "Total Liquidación" + Gastos * (1 + Iva / 100);
            END;
        }
        field(9; "A Pagar"; Decimal) { }
        field(10; "Liquidado"; Boolean) { }
        field(11; "% Intereses"; Decimal) { DecimalPlaces = 2 : 5; }
        field(12; "Empresa"; Text[30]) { }
        field(13; Renting; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Cabecera Prestamo".Renting where("Código Del Prestamo" = field("Código Del Prestamo")));
        }
        field(14; Facturado; Boolean)
        {

        }
        field(50030; Seguro; Decimal) { }
        field(50031; Mantenimiento; Decimal) { }
    }
    KEYS
    {
        key(P; "Código Del Prestamo", "No. Periodo") { Clustered = true; }
        key(A; "Código Del Prestamo", Fecha) { SumIndexfields = Amortización, Intereses, "A Pagar"; }
        key(B; "Código Del Prestamo", Fecha, Liquidado) { SumIndexfields = Amortización; }
    }

    PROCEDURE Iva(): Decimal;
    VAR
        rCab: Record "Cabecera Prestamo";
    BEGIN
        if rCab.GET("Código Del Prestamo") THEN EXIT(rCab.Iva);
    END;


}

