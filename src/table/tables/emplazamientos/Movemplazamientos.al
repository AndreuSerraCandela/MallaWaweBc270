/// <summary>
/// Table Mov. emplazamientos (ID 7010455).
/// </summary>
table 7001105 "Mov. emplazamientos"
{

    Permissions = TableData 7000002 = rimd;

    fields
    {
        field(1; "Nº proveedor"; Code[20]) { TableRelation = Vendor; }
        field(2; "Nº emplazamiento"; Code[20])
        {
            // TableRelation = "Emplazamientos proveedores"."Nº Emplazamiento" WHERE("Nº Proveedor" = FIELD("Nº proveedor"));
            SqlDataType = Varchar;
        }
        field(3; "Nº mov."; Integer)
        { }
        field(6; "No. Contabilidad"; Integer)
        { }
        field(5; "Periodo Pago"; Code[30])
        {
            TableRelation = "Periodos pago emplazamientos";
        }
        field(7; "Texto linea"; Text[250]) { }
        field(15; "Fecha vencimiento"; Date) { }
        field(20; "Fecha prevista pago"; Date)
        {
            trigger OnValidate()
            var
            BEGIN
                if ("Fecha prevista pago" <> 0D) THEN BEGIN
                    CLEAR(rFecha);
                    rFecha.RESET;
                    rFecha.SETRANGE("Period Type", rFecha."Period Type"::Week);
                    rFecha.SETFILTER("Period Start", '<=%1', "Fecha prevista pago");
                    rFecha.SETFILTER("Period End", '>=%1', "Fecha prevista pago");
                    if rFecha.FIND('-') THEN BEGIN
                        Rec.Semana := rFecha."Period No.";
                    END;
                    Rec."Año" := DATE2DMY("Fecha prevista pago", 3);
                END;
            END;
        }
        field(22; "Cód. Divisa"; Code[10])
        {
            TableRelation = Currency;
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(45; "Estado"; Enum "Estado Movimientos") { }
        field(50; "Reclamado"; Enum "Reclamado") { }
        field(55; "Responsable"; Code[3]) { }
        field(60; "Importancia"; Code[10]) { }
        field(65; "Observaciones"; Text[80]) { }
        field(70; "Importe"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
            trigger OnValidate()
            BEGIN
                if Rec."Nº Factura definitivo" <> '' THEN
                    ERROR('No se puede modificar, ya esta facturado');
                if (Rec."No. Contabilidad" <> 0) AND (Rec.Importe = 0) THEN BEGIN
                    if NOT CONFIRM('Se ha generado prevision contable para este movimiento\' +
                                'Debe anular la Previsión antes de continuar\' +
                                'Desea modificar el importe a pesar de ello ?', FALSE) THEN
                        ERROR(ProcesoCancelado);
                END;
                if (Rec."Nº Factura Borrador" <> '') AND (Rec."Nº Factura definitivo" = '') AND (Rec.Importe = 0) THEN BEGIN
                    if NOT CONFIRM('Se ha generado factura borrador para este movimiento\' +
                                    'Debe anular la factura antes de continuar\' +
                                    'Desea modificar el importe a pesar de ello ?', FALSE) THEN
                        ERROR(ProcesoCancelado);
                END;
                if (Rec."Nº Factura definitivo" <> '') AND (Rec.Importe = 0) THEN BEGIN
                    if NOT CONFIRM('Se ha generado factura para este movimiento\' +
                                    'Debe anular la factura antes de continuar\' +
                                    'Desea modificar el importe a pesar de ello ?', FALSE) THEN
                        ERROR(ProcesoCancelado);
                END;
                Rec.VALIDATE("% IVA");
                Rec.VALIDATE("% IRPF");                             //$002
            END;

        }
        field(71; "% IVA"; Decimal)
        {
            trigger OnValidate()
            VAR
                rSelf: Record "Mov. emplazamientos";
            BEGIN
                if (Rec."% IVA" = 0) THEN BEGIN
                    Rec.IVA := 0;
                END ELSE BEGIN
                    Rec.IVA := ROUND((Rec.Importe * Rec."% IVA" / 100), 0.01);
                END;

                //$002
                //VALIDATE(Total, Importe+IVA);
                Rec.VALIDATE(Total, Rec.Importe - Rec."Importe IRPF" + Rec.IVA);
                rSelf.SETRANGE(rSelf."Nº proveedor", "Nº proveedor");
                rSelf.SETRANGE(rSelf."Nº emplazamiento", "Nº emplazamiento");
                rSelf.SETRANGE(rSelf."Periodo Pago", "Periodo Pago");
                rSelf.SETFILTER("Nº mov.", '<>%1', "Nº mov.");
                Rec."Canon Total Periodo" := Rec.Importe + Rec.IVA - Rec."Importe IRPF";
                if rSelf.FINDFIRST THEN
                    REPEAT
                        Rec."Canon Total Periodo" := Rec."Canon Total Periodo" + rSelf.Importe + rSelf.IVA - rSelf."Importe IRPF";
                    UNTIL rSelf.NEXT = 0;
                if rSelf.FINDFIRST THEN
                    REPEAT
                        rSelf."Canon Total Periodo" := Rec."Canon Total Periodo";
                        rSelf.MODIFY;
                    UNTIL rSelf.NEXT = 0;
            END;
        }
        field(72; "IVA"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(75; "Total"; Decimal)
        {

            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
            trigger OnValidate()
            BEGIN
                Rec.VALIDATE("Importe total", Rec.Total + Rec.Gastos);
            END;
        }
        field(76; "Gastos"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
            trigger OnValidate()
            BEGIN
                Rec.VALIDATE("Importe total", Rec.Total + Rec.Gastos);
            END;

        }
        field(80; "Importe total"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                Rec.VALIDATE("Importe pendiente", (Rec."Importe total" - Rec."Importe pagado"));
            END;
        }
        field(85; "Importe pendiente"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                Rec.VALIDATE("Importe pagado", (Rec."Importe total" - Rec."Importe pendiente"));
                Rec."Importe Pendiente S/Iva" := (Rec."Importe pendiente" / (1 + Rec."% IVA" / 100 - Rec."% IRPF" / 100));
            END;
        }
        field(90; "Fecha pago"; Date) { }
        field(95; "Importe pagado"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                if Rec."Importe pagado" = 0 THEN BEGIN
                    Rec."Importe pendiente" := Rec."Importe total";
                    Rec."Importe Pendiente S/Iva" := (Rec."Importe pendiente" / (1 + Rec."% IVA" / 100 - Rec."% IRPF" / 100));
                    EXIT;
                END;
                Rec."Fecha pago" := TODAY;
                Rec."Importe pendiente" := Rec."Importe total" - Rec."Importe pagado";
                Rec."Importe Pendiente S/Iva" := (Rec."Importe pendiente" / (1 + Rec."% IVA" / 100 - Rec."% IRPF" / 100));
                if Rec."Importe pendiente" = 0 THEN
                    Rec.Estado := Rec.Estado::Pagado;
            END;
        }
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
        field(145; "% IRPF"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                if (Rec."% IRPF" = 0) THEN BEGIN
                    Rec."Importe IRPF" := 0;
                END ELSE BEGIN
                    Rec."Importe IRPF" := ROUND((Rec.Importe * Rec."% IRPF" / 100), 0.01);
                END;

                Rec.VALIDATE(Rec.Total, Rec.Importe - Rec."Importe IRPF" + Rec.IVA);
            END;

        }
        field(146; "Importe IRPF"; Decimal) { }
        field(150; "Pagare impreso"; Boolean) { }
        field(151; "Fecha impr pagare"; Date) { }
        field(152; "No prevision"; Code[20]) { }
        field(153; "Año periodo"; Text[4])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Periodos pago emplazamientos".Año WHERE("Cód. Periodo Pago" = FIELD("Periodo Pago")));

        }
        field(154; "Cod. Pago"; Code[3]) { }
        field(155; "No pagare"; Text[30]) { }
        field(156; "Nº Factura Borrador"; Code[20])
        {
            trigger OnValidate()
            VAR
                rPaga: Record 7000002;
                r38: Record 38;
            BEGIN
                if "Nº Factura definitivo" <> '' THEN BEGIN
                    rPaga.SETCURRENTKEY(Type, "Document No.");
                    rPaga.SETRANGE(rPaga.Type, rPaga.Type::Payable);
                    rPaga.SETRANGE(rPaga."Document No.", "Nº Factura definitivo");
                    if rPaga.FINDFIRST THEN BEGIN
                        rPaga."Nº Impreso" := "No pagare";
                        rPaga.MODIFY;
                    END;
                END ELSE BEGIN
                    if "Nº Factura Borrador" <> '' THEN BEGIN
                        if r38.GET(r38."Document Type"::Invoice, "Nº Factura Borrador") THEN BEGIN
                            r38."Nº Impreso" := "No pagare";
                            r38.MODIFY;
                        END;
                    END;
                END;
            END;
        }
        field(157; "Nº Factura definitivo"; Code[20]) { }
        field(158; "Nº Factura proveedor"; Text[30]) { }
        field(50001; Banco; Code[10])
        {
            TableRelation = "Bank Account";
            trigger OnValidate()
            VAR
                r700002: Record 7000002;
            BEGIN
                if "Nº Factura definitivo" = '' THEN EXIT;
                r700002.SETRANGE(r700002.Type, r700002.Type::Payable);
                r700002.SETFILTER(r700002."Document No.", "Nº Factura definitivo" + '*');
                if r700002.FINDFIRST THEN
                    REPEAT
                        r700002.Banco := Banco;
                        r700002.MODIFY;
                    UNTIL r700002.NEXT = 0;
            END;
        }
        field(50002; "Fecha prevista pago2"; Date)
        {
            trigger OnValidate()
            BEGIN
                if ("Fecha prevista pago" <> 0D) THEN BEGIN
                    CLEAR(rFecha);
                    rFecha.RESET;
                    rFecha.SETRANGE("Period Type", rFecha."Period Type"::Week);
                    rFecha.SETFILTER("Period Start", '<=%1', "Fecha prevista pago");
                    rFecha.SETFILTER("Period End", '>=%1', "Fecha prevista pago");
                    if rFecha.FIND('-') THEN BEGIN
                        Semana := rFecha."Period No.";
                    END;
                    Año := DATE2DMY("Fecha prevista pago", 3);
                END;
            END;
        }
        field(50003; "Mes Prevision"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Emplazamientos proveedores"."Mes previsión" WHERE("Nº Proveedor" = FIELD("Nº proveedor"),
                                                                            "Nº Emplazamiento" = FIELD("Nº emplazamiento")));
        }
        field(50004; "Importe Pendiente S/Iva"; Decimal) { }
        field(50005; "Fecha Factura"; Date) { }
        field(50006; "S/Fact.rec.técnico"; Code[20]) { }
        field(50007; "Fecha recep.técnico"; Date) { }
        field(50008; "S/Fact. envio adm."; Boolean) { }
        field(50009; "Fecha envio s/f adm."; Date) { }
        field(50010; Contabilizado; Boolean) { }
        field(50011; "Descuento Covit19"; Boolean) { }
        field(50012; "Regularización"; Decimal)
        {
            trigger OnValidate()
            begin
                if Rec."Regularización" = 0 THEN BEGIN
                    Rec."Importe pendiente" := Rec."Importe total";
                    Rec."Importe Pendiente S/Iva" := (Rec."Importe pendiente" / (1 + Rec."% IVA" / 100 - Rec."% IRPF" / 100));
                    EXIT;
                END;
                Rec."Fecha pago" := TODAY;
                Rec."Importe pendiente" := Rec."Importe total" - Rec."Regularización";
                Rec."Importe Pendiente S/Iva" := (Rec."Importe pendiente" / (1 + Rec."% IVA" / 100 - Rec."% IRPF" / 100));
                if Rec."Importe pendiente" = 0 THEN
                    Rec.Estado := Rec.Estado::Regularizado;
            end;
        }
    }
    KEYS
    {
        Key(Principal; "Nº proveedor", "Nº emplazamiento", "Nº mov.")
        {
            SumIndexFields = "Importe total", "Importe pendiente", "Importe Pendiente S/Iva";
            Clustered = true;
        }
        Key(Emplazamiento; "Nº emplazamiento") { }
        Key(Mov; "Nº mov.") { }
        Key(Fecha; "Fecha prevista pago", "Pagador", "Cod. Pago", Entregado)
        {
            SumIndexFields = "Importe total";
        }
        Key(Semana; Semana, Año, Pagador)
        {
            SumIndexFields = "Importe total";
        }
        Key(Proveedor; "Nº proveedor", "Nº emplazamiento", "Periodo Pago", "% IVA")
        {
            SumIndexFields = "Importe total";
        }
        Key(Vto; "Fecha vencimiento", "Nº proveedor", "Nº emplazamiento") { }
        Key(Total; "Importe total") { }
        Key(Borrador; "Nº Factura Borrador") { }
        Key(Definitivo; "Nº proveedor", "Nº Factura definitivo", "Fecha prevista pago") { }
        Key(Periodo; "Periodo Pago")
        {
            SumIndexFields = Importe, "Importe Pendiente S/Iva";
        }
        Key(Periodo_Emplazamiento; "Periodo Pago", "Nº emplazamiento", "Nº Factura definitivo")
        {
            SumIndexFields = Importe, "Importe Pendiente S/Iva";
        }
        Key(Vto_Pagador; "Fecha vencimiento", Pagador, "Cod. Pago", Entregado)
        {
            SumIndexFields = "Importe total";
        }
        Key(Proveedor_Emplazamiento; "Nº proveedor", "Nº emplazamiento", "Periodo Pago")
        {
            SumIndexFields = "Importe total", Importe, IVA, Total, Gastos, "Importe IRPF", "Importe pagado", "Importe pendiente", "Importe Pendiente S/Iva", "Regularización";
        }
        Key(Periodi_Pago; "Periodo Pago", "Nº emplazamiento", "Fecha prevista pago", "Importe pendiente")
        {
            SumIndexFields = Importe, "Importe Pendiente S/Iva";
        }
    }

    trigger OnInsert()
    BEGIN
        //$001
        rMovEmp.RESET;
        rMovEmp.SETRANGE("Nº proveedor", "Nº proveedor");
        rMovEmp.SETRANGE("Nº emplazamiento", "Nº emplazamiento");
        if rMovEmp.FIND('+') THEN BEGIN
            "Nº mov." := rMovEmp."Nº mov." + 100;
        END
        ELSE BEGIN
            "Nº mov." := 100;
        END;

        //$003. Conservo el nº de pagaré de la tabla de previsiones
        if "No prevision" = '' THEN BEGIN
            rCnfCom.GET;
            rCnfCom.TESTFIELD("Nº serie pagarés");
#if CLEAN24
#pragma warning disable AL0432
            NoSeriesMgt.InitSeries(rCnfCom."Nº serie pagarés", rCnfCom."Nº serie pagarés", WORKDATE, "No prevision", rCnfCom."Nº serie pagarés");
#pragma warning restore AL0432
#else
            If NoSeriesMgt.AreRelated(rCnfCom."Nº serie pagarés", rCnfCom."Nº serie pagarés") THEN
                rCnfCom."Nº serie pagarés" := rCnfCom."Nº serie pagarés";
#endif
        END;
    END;

    trigger OnModify()
    BEGIN
        if Entregado THEN BEGIN
            if NOT CONFIRM(Text001, FALSE) THEN
                EXIT;
        END;
    END;

    trigger OnDelete()
    BEGIN

        if "Nº Factura definitivo" <> '' THEN ERROR('No se puede eliminar, ya esta facturado');
        if "No. Contabilidad" <> 0 THEN BEGIN
            Error('Se ha generado prevision contable para este movimiento\' +
                            'Debe anular la Previsión antes de continuar\' +
                            'Debe revertir la transaccion desde Contailidad');
            //     ERROR(ProcesoCancelado)
            // else
            //     ERROR(ProcesoCancelado);

        END;
    END;

    VAR
        rFecha: Record Date;
        Text001: Label '=Ojo, hay pagares entregados para esta linea, ¿esta seguro de que desea modificarla?';
        rMovEmp: Record "Mov. emplazamientos";
        rCnfCom: Record "Purchases & Payables Setup";
#if CLEAN24
#pragma warning disable AL0432
        NoSeriesMgt: Codeunit NoSeriesManagement;
#pragma warning restore AL0432
#else
        NoSeriesMgt: Codeunit "No. Series";
#endif
        ProcesoCancelado: Label 'Proceso cancelado por el usuario';


}