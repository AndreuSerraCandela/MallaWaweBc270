
/// <summary>
/// Table Temp. Movs. emplazamientos (ID 7001143).
/// </summary>
table 7001143 "Temp. Movs. emplazamientos"
{

    fields
    {
        field(1; "Nº proveedor"; Code[20]) { TableRelation = Vendor; }
        field(2; "Nº emplazamiento"; Code[20]) { }//TableRelation = "Emplazamientos proveedores"."Nº Emplazamiento" WHERE("Nº Proveedor" = FIELD("Nº proveedor")); }
        field(3; "Nº mov."; Integer) { }
        field(5; "Periodo Pago"; Code[30]) { TableRelation = "Periodos pago emplazamientos"; }
        field(7; "Texto linea"; Text[50]) { }
        field(15; "Fecha vencimiento"; Date) { }
        field(20; "Fecha prevista pago"; Date) { }
        field(22; "Cód. Divisa"; Code[10])
        {
            TableRelation = Currency;
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(45; "Estado"; Enum "Estado Movimientos")
        {

        }
        field(50; "Reclamado"; Enum "Reclamado")
        {

        }
        field(55; "Responsable"; Code[3]) { }
        field(60; "Importancia"; Code[10]) { }
        field(65; "Observaciones"; Text[80]) { }
        field(70; "Importe"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(71; "% IVA"; Decimal) { }
        field(72; "IVA"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(75; "Total"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(76; "Gastos"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(80; "Importe total"; Decimal) { }
        field(85; "Importe pendiente"; Decimal) { }
        field(90; "Fecha pago"; Date) { }
        field(95; "Importe pagado"; Decimal) { }
        field(100; "Canon Total Periodo"; Decimal) { }
        field(105; "Nombre Proveedor"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Nº proveedor")));
        }
        field(110; "Pago mediante"; Text[30]) { }
        field(115; "Semana"; Integer) { }
        field(120; "Año"; Integer) { }
        field(125; "Pagador"; Enum "Pagador") { }
        field(130; "Entregado"; Boolean) { }
        field(135; "Impreso"; Boolean) { }
        field(140; "Fecha impresion"; Date) { }
        field(145; "% IRPF"; Decimal) { }
        field(146; "Importe IRPF"; Decimal) { }
        field(150; "Pagare impreso"; Boolean) { Caption = 'Pagaré impreso'; }
        field(151; "Fecha impr pagare"; Date) { Caption = 'Fecha impresión pagaré'; }
        field(152; "No prevision"; Code[20]) { Caption = 'false. previsión'; }
        field(153; "Año periodo"; Text[4])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Periodos pago emplazamientos"."Año" WHERE("Cód. Periodo Pago" = FIELD("Periodo Pago")));
        }
        field(500; "User"; Code[50]) { Caption = 'Usuario'; TableRelation = "User Setup"; }
    }
    KEYS
    {
        key(P; User, "Nº proveedor", "Nº emplazamiento", "Periodo Pago")
        {
            Clustered = true;
        }
    }
    PROCEDURE CargarTabla(pCodProv: Code[20]; pEmplaz: Code[20]);
    VAR
        rMovEmp: Record "Mov. emplazamientos";
        rTemp: Record "Temp. Movs. emplazamientos";
        wPeriodoAnt: Code[30];
        wImporte: Decimal;
    BEGIN
        rTemp.RESET;
        rTemp.SETRANGE(User, USERID);
        rTemp.DELETEALL;

        CLEAR(wPeriodoAnt);
        rMovEmp.RESET;
        rMovEmp.SETCURRENTKEY("Nº proveedor", "Nº emplazamiento", "Periodo Pago");
        rMovEmp.SETRANGE("Nº proveedor", pCodProv);
        rMovEmp.SETRANGE("Nº emplazamiento", pEmplaz);
        if rMovEmp.FIND('-') THEN BEGIN
            REPEAT
                wImporte := rMovEmp."Importe total" - rMovEmp.Gastos - rMovEmp.IVA + rMovEmp."Importe IRPF";
                if rMovEmp."Periodo Pago" <> wPeriodoAnt THEN BEGIN
                    wPeriodoAnt := rMovEmp."Periodo Pago";
                    rTemp.INIT;
                    rTemp.TRANSFERfields(rMovEmp);
                    rTemp.User := USERID;
                    rTemp."Canon Total Periodo" := wImporte;
                    rTemp.INSERT;
                END
                ELSE BEGIN
                    rTemp.RESET;
                    rTemp.SETRANGE(User, USERID);
                    rTemp.SETRANGE("Nº proveedor", pCodProv);
                    rTemp.SETRANGE("Nº emplazamiento", pEmplaz);
                    rTemp.SETRANGE("Periodo Pago", rMovEmp."Periodo Pago");
                    if rTemp.FIND('-') THEN BEGIN
                        rTemp."Canon Total Periodo" += wImporte;
                        rTemp.MODIFY;
                    END;
                END;
            UNTIL rMovEmp.NEXT = 0;
        END;

        COMMIT;

        Page.RUNMODAL(7001255);
    END;
}
