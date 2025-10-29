/// <summary>
/// Table Periodos pago emplazamientos (ID 7010456).
/// </summary>
table 7001106 "Periodos pago emplazamientos"
{
    LookupPageId = "Periodo pago emplazamiento";
    DrillDownPageId = "Periodo pago emplazamiento";
    fields
    {
        field(1; "Cód. Periodo Pago"; Code[30]) { }
        field(5; "Descripción"; Text[30]) { }
        field(10; "Año"; Text[4]) { }
        field(50011; "Cuenta Contable FPR"; Code[20]) { TableRelation = "G/L Account"; }
        field(50012; "Provisionado"; Boolean) { }
        field(50013; "Saldo Movimientos"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos".Importe WHERE("Periodo Pago" = FIELD("Cód. Periodo Pago")));
        }
        field(50014; "Saldo Contabilidad"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FILTER(621000000 .. 622999999 | 400901315 .. 400901326),
                                                                                             "Periodo de Pago" = FIELD("Cód. Periodo Pago")));
        }
        field(50015; "Saldo Pendiente Factura"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos".Importe WHERE("Periodo Pago" = FIELD("Cód. Periodo Pago"),
                                                                                                        "Nº Factura definitivo" = FILTER('')));
        }
        field(50016; "Saldo Facturado"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos".Importe WHERE("Periodo Pago" = FIELD("Cód. Periodo Pago"),
                                                                    "Nº Factura definitivo" = FILTER(<> '')));
        }
        field(50017; "Saldo Contabilidad 4009"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("G/L Entry".Amount WHERE("G/L Account No." = FILTER('4009..4009999999'),
                                                    "Periodo de Pago" = FIELD("Cód. Periodo Pago")));
        }
        field(50018; "Saldo Correcto 4009"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("Cuenta Contable FPR"),
                                                    "Periodo de Pago" = FIELD("Cód. Periodo Pago")));
        }
        field(50019; "Seleccionado"; Boolean) { }
        field(50020; "Saldo Pendiente pago"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos".Importe WHERE("Periodo Pago" = FIELD("Cód. Periodo Pago"),
                                                            "Importe pendiente" = FILTER(<> 0)));
        }
        field(50021; "Saldo Pendiente"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos"."Importe Pendiente S/Iva" WHERE("Periodo Pago" = FIELD("Cód. Periodo Pago")));
        }
        field(60013; "Saldo Movimientos Calculado"; Decimal)
        {

        }
        field(60019; "Diferencia Calculado"; Decimal)
        {

        }
        field(60014; "Saldo Contabilidad Calculado"; Decimal)
        {

        }
        field(60015; "Saldo Pendiente Factura Calc"; Decimal)
        {

        }
        field(60016; "Saldo Facturado Calculado"; Decimal)
        {

        }
        field(60017; "Saldo Contabilidad 4009 Calc"; Decimal)
        {

        }
        field(60018; "Saldo Correcto 4009 Calculado"; Decimal)
        {

        }
        field(60020; "Saldo Pendiente pago Calculado"; Decimal)
        {

        }
        field(60021; "Saldo Pendiente Calculado"; Decimal)
        {

        }
        field(60022; "Facturas Calculado"; Decimal)
        {

        }
        field(60023; "Factuas Proveedor Calculado"; Decimal)
        { }
    }
    keys
    {
        Key(Periodo; "Cód. Periodo Pago") { Clustered = true; }
    }

}









