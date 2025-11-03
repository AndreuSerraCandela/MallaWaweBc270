/// <summary>
/// TableExtension SalesHeaderKuara (ID 80102) extends Record Sales Header.
/// </summary>
tableextension 80102 SalesHeaderKuara extends "Sales Header"
{
    DataCaptionFields = "No.", "Posting Description";
    fields
    {

        // Add changes to table fields here

        field(50000; Tipo; Enum "Tipo Venta Job") { }
        field(50001; "Ofrecida ampliación"; Boolean) { }
        field(50005; Firmado; Enum "Firmado") { }
        field(50006; "Fecha Firma"; Date) { }
        field(50010; "Fecha inicial proyecto"; Date)
        {
            trigger OnValidate()
            begin
                Rec."B2R Fecha inicio Periodo Fact." := Rec."Fecha inicial proyecto";
                If Rec."Posting Date" = 0D then
                    Rec."B2R Fecha operación" := Rec."Fecha inicial proyecto";
                Rec."B2R Fecha operación" := Rec."Posting Date";
            end;
        }
        field(50011; "Fecha fin proyecto"; Date)
        {
            trigger OnValidate()
            begin
                Rec."B2R Fecha fin Periodo Fact." := Rec."Fecha fin proyecto";
            end;
        }
        field(50015; "Cód. términos facturacion"; Code[10]) { TableRelation = "Términos facturación"; }
        field(50018; "Subtipo"; Enum "Subtipo") { }
        field(50020; "Creada su facturación"; Boolean)
        {
            InitValue = false;
            Description = 'Nos dice si ya estan creadas las facturas MLL';
        }
        field(50025; "Factura propuesta sistema"; Boolean) { InitValue = false; }
        field(50030; "Nº Contrato"; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order), "No." = FIELD("Nº Contrato"));

        }
        field(50035; "Nº lineas"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Line" WHERE("Document Type" = FIELD("Document Type"),
                                                                                         "Document No." = FIELD("No.")));
        }
        field(50039; "Esperar Orden Cliente"; Enum "Esperar Orden Cliente") { InitValue = No; }
        field(50041; "Soporte de"; Enum "Soporte de") { }
        field(50045; "Comentario Cabecera"; Text[50]) { }
        field(50050; "Impresion Presup. especial"; Boolean) { InitValue = false; }
        field(50055; "Borradores de Factura"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Invoice),
                                                                                           "Nº Contrato" = FIELD("No."),
                                                                                           "Nº Proyecto" = FIELD("Nº Proyecto")));
            Editable = false;
        }

        field(50057; "Borradores de Compra"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("pURCHASE Header" WHERE("Document Type" = CONST(Invoice),

                                                                                           "Nº Proyecto" = FIELD("Nº Proyecto")));
            Editable = false;
        }
        field(50054; "Borradores Compra"; Integer)
        {
            Caption = 'Facturas Compra';
            FieldClass = FlowField;
            CalcFormula = Count("pURCh. Inv. Header" WHERE("Nº Proyecto" = FIELD("Nº Proyecto")));
            Editable = false;
        }
        field(50058; "Abonos Compra"; Integer)
        {
            Caption = 'Abonos Compra';
            FieldClass = FlowField;
            CalcFormula = Count("pURCh. Cr. Memo Hdr." WHERE("Nº Proyecto" = FIELD("Nº Proyecto")));
            Editable = false;
        }
        field(50056; "Borradores de Abono"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Credit Memo"),
                                                                                           "Nº Contrato" = FIELD("No."),
                                                                                           "Nº Proyecto" = FIELD("Nº Proyecto")));
            Editable = false;
        }
        field(50060; "Facturas Registradas"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Invoice Header" WHERE("Nº Contrato" = FIELD("No.")));
            Editable = false;
        }
        field(50061; "Abonos Registrados"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Cr.Memo Header" WHERE("Nº Contrato" = FIELD("No.")));
            Editable = false;
        }
        field(51060; "Albaranes Registrados"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Shipment Header" WHERE("Nº Contrato" = FIELD("No."), Contabilizado = const(true)));
            Editable = false;
        }
        field(50062; "Interc./Compens."; Enum "Interc./Compens.")
        {
            Caption = 'Interc./Compens./Dona.';
            Description = 'FCL-18/05/04';
        }
        field(50063; "Proyecto origen"; Code[20])
        {
            TableRelation = Job;
            ValidateTableRelation = false;
            Description = 'FCL-18/05/04';
        }
        field(50064; "Renovado"; Boolean) { Description = 'FCL-18/05/04'; }
        field(50065; "Fecha inicial factura"; Date) { Description = 'FCL-06/04. Se graba en proceso proponer facturación contratos'; }
        field(50066; "Fecha final factura"; Date) { Description = 'FCL-06/04. Se graba en proceso proponer facturación contratos'; }
        field(50067; "Filtro fase"; Code[20]) { FieldClass = FlowFilter; }
        field(50068; "Imp. IVA. incl."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                                                            "Document No." = FIELD("No."),
                                                                                                            "Job Task No." = FIELD("Filtro Tarea Proyecto")));
            Description = 'FCL-25/10/04';
        }
        field(50069; "Importe líneas"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                                                     "Document No." = FIELD("No."),
                                                                                                     "Job Task No." = FIELD("Filtro Tarea Proyecto")));
            Description = 'FCL-25/10/04';
        }
        field(50075; "Nº Proyecto"; Code[20])
        {
            TableRelation = Job;
            trigger OnValidate()
            var
                rProy: Record Job;
                ReservasDiario: Record "Diario Reserva";
            BEGIN
                // $001 -
                MessageIfSalesLinesExist(FIELDCAPTION("Nº Proyecto"));

                // MNC 220802
                if ("Nº Proyecto" <> '') THEN BEGIN
                    rProy.GET("Nº Proyecto");
                    Tipo := rProy.Tipo;
                    Firmado := rProy.Firmado;
                    Subtipo := rProy.Subtipo;
                    "Soporte de" := rProy."Soporte de";
                    ReservasDiario.SetCurrentKey("Nº Proyecto");
                    ReservasDiario.SETRANGE("Nº Proyecto", "Nº Proyecto");
                    ReservasDiario.ModifyAll(Contrato, "No.");
                END;

                // $001 +
            END;

        }
        field(50077; "Estado Contrato"; Enum "Estado Contrato")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header".Estado WHERE("Document Type" = CONST(Order),
                                                                                                   "No." = FIELD("Nº Contrato")));
            /*  trigger OnValidate()
             VAR
                 Gest_dll: Codeunit "Gestion Reservas";
                 r36: Record 36;
                 r120: Record "Purch. Rcpt. Header";
                 c90: Codeunit 90;
                 rCar: Record 7000002;
                 rRes: Record Reserva;
                 FecFin: Date;
                 Ventana: Dialog;
                 r70002: Record 7000002;
                 FecAnul: Date;
                 rDiari: Record "Diario Reserva";
                 Gest_Fac: Codeunit "Gestion Facturación";
                 rProy: Record Job;
                 SalesLine: Record "Sales Line";
                 ReleaseSalesDoc: Codeunit "Release Sales Document";
             BEGIN
                 if USERID <> 'LLLL' THEN BEGIN
                     if (xRec.Estado = Estado::"Sin Montar") OR (xRec.Estado = Estado::Firmado) THEN
                         if Estado = Estado::"Pendiente de Firma" THEN ERROR('No se puede regrersar a un estado anterior');
                 END;
                 if ((Estado = Estado::Firmado) OR (Estado = Estado::"Sin Montar"))
                 AND ("Albarán Empresa Origen" = '') THEN BEGIN
                     TESTFIELD("Comentario Cabecera");
                     if "Shortcut Dimension 1 Code" <> 'GENERAL' THEN
                         if (Estado = Estado::Firmado) THEN VALIDATE("Fecha renovacion", "Fecha fin proyecto");
                     if (xRec.Estado <> Estado::"Sin Montar") AND (xRec.Estado <> Estado::Firmado) THEN           //$016
                         "Fecha Estado" := WORKDATE;
                     if "Pedido compra creado" = FALSE THEN
                         GenerarContratoCompra;
                 END;
                 //$012(I)
                 if Estado = Estado::Cancelado THEN
                     "Fecha cancelacion" := WORKDATE;         //de momento no inicializo fecha si cambia a otro estado
                                                              //$012(F)
                 if (Estado = Estado::Anulado) OR (Estado = Estado::Cancelado) THEN BEGIN
                     if CONFIRM('Se van a eliminar todas las facturas que esten en borrador \'
                     + 'con fecha porterior a la solicitada, las demás deberán borrarse manialmente \'
                     + 'se solicitará la fecha para anular las reservas asociadas al proyecto,\'
                     + 'en el caso de anulación borrará las reservas asociadas al proyecto,\'
                     + 'así mismo, se marcarán como facturados todos los albaranes posteriores \'
                     + 'a fecha de anulación y, se procederá a descontabilizarlos. Los albaranes con \'
                     + 'fecha anterior a la de anulación, deben anularse manualmete.¿ Desea continuar ?', TRUE)
                     THEN BEGIN

                         FecAnul := WORKDATE;
                         Ventana.OPEN('Fecha Anulación #######1#');
                         Ventana.INPUT(1, FecAnul);
                         Ventana.CLOSE;
                         if Estado = Estado::Cancelado THEN
                             "Fecha cancelacion" := FecAnul;
                         if Estado = Estado::Anulado THEN
                             "Fecha cancelacion" := FecAnul;

                         Ventana.OPEN('Fecha Fin Reservas -si es anulación no la tentrá en cuenta - #######1#');
                         Ventana.INPUT(1, FecFin);
                         Ventana.CLOSE;
                         if FecAnul = 0D THEN ERROR('La fecha anulación no puede quedar en blanco');
                         if FecFin = 0D THEN ERROR('La fecha fin no puede quedar en blanco');
                         if rProy.GET("Nº Proyecto") THEN BEGIN
                             rRes.SETCURRENTKEY(rRes."Nº Proyecto");
                             rRes.SETRANGE(rRes."Nº Proyecto", "Nº Proyecto");
                             if rRes.FINDFIRST THEN BEGIN
                                 CLEAR(Gest_dll);
                                 REPEAT
                                     if Estado = Estado::Cancelado THEN BEGIN
                                         if rRes."Fecha fin" > FecFin THEN
                                             Gest_dll.Cambia_Fecha_Fin_Reserva(rRes, FecFin);
                                     END;
                                     if Estado = Estado::Anulado THEN BEGIN
                                         rDiari.RESET;
                                         rDiari.SETCURRENTKEY("Nº Reserva", Fecha);
                                         rDiari.SETRANGE("Nº Reserva", rRes."Nº Reserva");
                                         rDiari.DELETEALL;
                                     END;
                                 UNTIL rRes.NEXT = 0;
                             END;
                             if Estado = Estado::Anulado THEN rRes.DELETEALL;
                         END;
                         r36.SETRANGE(r36."Document Type", r36."Document Type"::Invoice);
                         r36.SETRANGE("Nº Contrato", "No.");
                         r36.SETRANGE("Nº Proyecto", "Nº Proyecto");
                         r36.SETRANGE(r36."Posting Date", FecAnul, 29991231D);
                         if r36.FINDFIRST THEN
                             REPEAT
                                 rCar.SETRANGE(rCar."No. Borrador factura", r36."No.");
                                 rCar.SETFILTER(rCar."Bill Gr./Pmt. Order No.", '<>%1', '');
                                 rCar.DELETEALL;
                             UNTIL r36.NEXT = 0;
                         r36.DELETEALL(TRUE);

                         r36.SETRANGE(r36."Document Type", r36."Document Type"::"Credit Memo");
                         r36.DELETEALL(TRUE);
                         if "Nº Proyecto" <> '' THEN BEGIN
                             r120.SETRANGE(r120."Nº Proyecto", "Nº Proyecto");
                             r120.SETRANGE(r120."Posting Date", FecAnul, 99991231D);
                             if r120.FINDFIRST THEN
                                 REPEAT
                                     CLEAR(c90);
                                     if r120.Facturado = FALSE THEN
                                         c90.DesContabilizarAlbaranesContra(r120);
                                     MarcarComofacturado(r120."No.");
                                     r120.Facturado := TRUE;
                                     r120.Contabilizado := TRUE;
                                     r120.MODIFY;
                                 UNTIL r120.NEXT = 0;
                         END;
                         //r120.DELETEALL;
                         r70002.SETFILTER(r70002."Document No.", '%1', "No." + '*');
                         r70002.SETRANGE(r70002."Posting Date", FecAnul, 99991231D);
                         r70002.DELETEALL;
                         CLEAR(Gest_Fac);
                         Gest_Fac.GeneraContrasientoprepago(Rec, FecAnul);
                         COMMIT;
                         Gest_Fac.EnviarMailJm("No.", FORMAT(Estado));
                     END;
                 END;

                 //$011(I)
                 if (Estado = Estado::Firmado) OR (Estado = Estado::Anulado) OR (Estado = Estado::Cancelado) THEN BEGIN
                     MODIFY;
                     SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                     SalesLine.SETRANGE("Document No.", "No.");
                     if NOT SalesLine.ISEMPTY THEN
                         ReleaseSalesDoc.PerformManualRelease(Rec);

                 END;
                 //$011(F)
             END; */

        }
        field(50078; "Contrato origen"; Code[20])
        { }
        field(50079; "Contrato original"; Code[20])
        { }
        field(50081; "Contrato renovado"; Code[20])
        { }
        field(50080; "Filtro Tarea Proyecto"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Job Task"."Job Task No.";
        }
        field(50085; "Facturacion Iniciada"; Boolean) { }
        field(50086; "Tipo Facturacion"; Enum "Facturación resaltada") { }
        field(50084; "Facturacion Bloqueada"; Boolean) { }
        field(50087; "Estado"; Enum "Estado Contrato")
        {
            /*  trigger OnValidate()
             VAR
                 Gest_dll: Codeunit "Gestion Reservas";
                 r36: Record 36;
                 r120: Record "Purch. Rcpt. Header";
                 c90: Codeunit 90;
                 rCar: Record 7000002;
                 rRes: Record Reserva;
                 FecFin: Date;
                 Ventana: Dialog;
                 r70002: Record 7000002;
                 FecAnul: Date;
                 rDiari: Record "Diario Reserva";
                 Gest_Fac: Codeunit "Gestion Facturación";
                 SalesLine: Record "Sales Line";
                 ReleaseSalesDoc: Codeunit "Release Sales Document";
             BEGIN

                 if USERID <> 'LLLL' THEN BEGIN
                     if (xRec.Estado = Estado::"Sin Montar") OR (xRec.Estado = Estado::Firmado) THEN
                         if Estado = Estado::"Pendiente de Firma" THEN ERROR('No se puede regrersar a un estado anterior');
                 END;
                 if ((Estado = Estado::Firmado) OR (Estado = Estado::"Sin Montar"))
                 AND ("Albarán Empresa Origen" = '') THEN BEGIN
                     TESTFIELD("Comentario Cabecera");
                     if "Shortcut Dimension 1 Code" <> 'GENERAL' THEN
                         if (Estado = Estado::Firmado) THEN VALIDATE("Fecha renovacion", "Fecha fin proyecto");
                     if (xRec.Estado <> Estado::"Sin Montar") AND (xRec.Estado <> Estado::Firmado) THEN           //$016
                         "Fecha Estado" := WORKDATE;
                     if "Pedido compra creado" = FALSE THEN
                         GenerarContratoCompra;
                 END;
                 //$012(I)
                 if Estado = Estado::Cancelado THEN
                     "Fecha cancelacion" := WORKDATE;         //de momento no inicializo fecha si cambia a otro estado
                                                              //$012(F)
                 if (Estado = Estado::Anulado) OR (Estado = Estado::Cancelado) THEN BEGIN
                     if CONFIRM('Se van a eliminar todas las facturas que esten en borrador \'
                     + 'con fecha porterior a la solicitada, las demás deberán borrarse manialmente \'
                     + 'se solicitará la fecha para anular las reservas asociadas al proyecto,\'
                     + 'en el caso de anulación borrará las reservas asociadas al proyecto,\'
                     + 'así mismo, se marcarán como facturados todos los albaranes posteriores \'
                     + 'a fecha de anulación y, se procederá a descontabilizarlos. Los albaranes con \'
                     + 'fecha anterior a la de anulación, deben anularse manualmete.¿ Desea continuar ?', TRUE)
                     THEN BEGIN
                         FecAnul := WORKDATE;
                         Ventana.OPEN('Fecha Anulación #######1#');
                         Ventana.INPUT(1, FecAnul);
                         Ventana.CLOSE;
                         if Estado = Estado::Cancelado THEN
                             "Fecha cancelacion" := FecAnul;
                         if Estado = Estado::Anulado THEN
                             "Fecha cancelacion" := FecAnul;

                         Ventana.OPEN('Fecha Fin Reservas -si es anulación no la tentrá en cuenta - #######1#');
                         Ventana.INPUT(1, FecFin);
                         Ventana.CLOSE;
                         if FecAnul = 0D THEN ERROR('La fecha anulación no puede quedar en blanco');
                         if FecFin = 0D THEN ERROR('La fecha fin no puede quedar en blanco');
                         if rProy.GET("Nº Proyecto") THEN BEGIN
                             rRes.SETCURRENTKEY(rRes."Nº Proyecto");
                             rRes.SETRANGE(rRes."Nº Proyecto", "Nº Proyecto");
                             if rRes.FINDFIRST THEN BEGIN
                                 CLEAR(Gest_dll);
                                 REPEAT
                                     if Estado = Estado::Cancelado THEN BEGIN
                                         if rRes."Fecha fin" > FecFin THEN
                                             Gest_dll.Cambia_Fecha_Fin_Reserva(rRes, FecFin);
                                     END;
                                     if Estado = Estado::Anulado THEN BEGIN
                                         rDiari.RESET;
                                         rDiari.SETCURRENTKEY("Nº Reserva", Fecha);
                                         rDiari.SETRANGE("Nº Reserva", rRes."Nº Reserva");
                                         rDiari.DELETEALL;
                                     END;
                                 UNTIL rRes.NEXT = 0;
                             END;
                             if Estado = Estado::Anulado THEN rRes.DELETEALL;
                         END;
                         r36.SETRANGE(r36."Document Type", r36."Document Type"::Invoice);
                         r36.SETRANGE("Nº Contrato", "No.");
                         r36.SETRANGE("Nº Proyecto", "Nº Proyecto");
                         r36.SETRANGE(r36."Posting Date", FecAnul, 29991231D);
                         if r36.FINDFIRST THEN
                             REPEAT
                                 rCar.SETRANGE(rCar."No. Borrador factura", r36."No.");
                                 rCar.SETFILTER(rCar."Bill Gr./Pmt. Order No.", '<>%1', '');
                                 rCar.DELETEALL;
                             UNTIL r36.NEXT = 0;
                         r36.DELETEALL(TRUE);
                         r36.SETRANGE(r36."Document Type", r36."Document Type"::"Credit Memo");
                         r36.DELETEALL(TRUE);
                         if "Nº Proyecto" <> '' THEN BEGIN
                             r120.SETRANGE(r120."Nº Proyecto", "Nº Proyecto");
                             r120.SETRANGE(r120."Posting Date", FecAnul, 99991231D);
                             if r120.FINDFIRST THEN
                                 REPEAT
                                     CLEAR(c90);
                                     if r120.Facturado = FALSE THEN
                                         c90.DesContabilizarAlbaranesContra(r120);
                                     MarcarComofacturado(r120."No.");
                                     r120.Facturado := TRUE;
                                     r120.Contabilizado := TRUE;
                                     r120.MODIFY;
                                 UNTIL r120.NEXT = 0;
                         END;
                         //r120.DELETEALL;
                         r70002.SETFILTER(r70002."Document No.", '%1', "No." + '*');
                         r70002.SETRANGE(r70002."Posting Date", FecAnul, 99991231D);
                         r70002.DELETEALL;
                         MODIFY;
                         COMMIT;
                         r36.RESET;
                         r36.GET("Document Type", "No.");
                         CLEAR(Gest_Fac);
                         Gest_Fac.GeneraContrasientoprepago(r36, FecAnul);
                         COMMIT;
                         Gest_Fac.EnviarMailJm("No.", FORMAT(Estado));
                     END;
                 END;

                 //$011(I)
                 if (Estado = Estado::Firmado) OR (Estado = Estado::Anulado) OR (Estado = Estado::Cancelado) THEN BEGIN
                     MODIFY;
                     SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                     SalesLine.SETRANGE("Document No.", "No.");
                     if NOT SalesLine.ISEMPTY THEN
                         ReleaseSalesDoc.PerformManualRelease(Rec);

                 END;
                 //$011(F)
             END; */

        }
        field(50088; "Fecha Estado"; Date)
        {


        }
        field(50089; "Remesa sin factura"; Boolean) { Description = '$003'; }
        field(50090; "Forma pago prepago"; Code[10])
        {
            TableRelation = "Payment Method".Code WHERE("Cobro/Pagos/Ambos" = FILTER('Cobro|Ambos'),
                                                                                              Visible = CONST(true));
            Description = '$004';
        }
        field(50091; "Fecha registro prepago"; Date) { Description = '$004'; }
        field(50092; "Fecha renovacion"; Date)
        {
            Caption = 'Fecha renovación';
            Description = 'Indica cuándo deberá renovarse el contrato ';
        }
        field(50123; "Nuevo Vendedor asignado"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50122; "Contrato modificado"; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order), "No." = FIELD("Contrato modificado"));
        }
        field(50121; "Fecha Comparación"; Date)
        {
            Caption = 'Fecha comparación';
            Description = 'Indica la fecha de comparación del contrato renovado con el original';
        }
        field(50093; "Proyecto original"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Job."Proyecto original" WHERE("No." = FIELD("Nº Proyecto")));
        }
        field(50094; "Vendedor Origen"; Code[20]) { }
        field(50095; "Albarán Empresa Origen"; Code[20]) { }
        field(50096; "Empresa Origen Alb"; Text[30]) { }
        field(50097; "Factura Compra"; Code[20]) { }
        field(50098; "Empresa del Cliente"; Text[30]) { }
        field(50099; "Contrato No Renovable"; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec."Contrato No Renovable" then
                    Rec."Fecha renovacion" := 0D;
            end;
        }
        field(50100; "% prep incl produccion"; Boolean)
        {
            Caption = '% prep. incl. producción';
            Description = '$009';
            // trigger OnValidate()
            // VAR
            //     SalesPostPrepmt: Codeunit 442;
            //     wTotContrato: Decimal;
            //     wTotExcluido: Decimal;
            //     SalesLine: Record "Sales Line";
            // BEGIN
            //     //$009
            //     if NOT "% prep incl produccion" THEN BEGIN
            //         VALIDATE("Prepayment %", "% prep antes recalculo");
            //         VALIDATE("% prep antes recalculo", 0);
            //     END
            //     ELSE BEGIN
            //         MESSAGE(Text063);
            //         wTotContrato := 0;
            //         wTotExcluido := 0;
            //         rLinContrato.RESET;
            //         rLinContrato.SETRANGE("Document Type", "Document Type");
            //         rLinContrato.SETRANGE("Document No.", "No.");
            //         rLinContrato.SETFILTER(Type, '<>%1', rLinContrato.Type::" ");
            //         rLinContrato.SETFILTER("Line Amount", '<>0');
            //         if rLinContrato.FIND('-') THEN BEGIN
            //             REPEAT
            //                 wTotContrato := wTotContrato + rLinContrato."Line Amount";
            //                 if rLinContrato.Reparto = SalesLine.Reparto::"Fra prepago" THEN
            //                     wTotExcluido := wTotExcluido + rLinContrato."Line Amount";
            //             UNTIL rLinContrato.NEXT = 0;
            //         END;
            //         VALIDATE("% prep antes recalculo", "Prepayment %");

            //         UpdatePrepmtAmountOnSaleslines(Rec, ROUND(wTotContrato * "Prepayment %" / 100));


            //     END;
            //END;

        }
        field(50101; "% prep antes recalculo"; Decimal)
        {
            Caption = '% prep. antes recálculo';
            Description = '$009. Porc. introducido por usuario antes de recalcular';
        }
        field(50102; "Fecha cancelacion"; Date)
        {
            Caption = 'Fecha cancelación';
            Description = '$012';
        }

        field(50103; "Cod cadena"; Code[10])
        {
            TableRelation = "Codigos cadena";
            Caption = 'Cód. cadena';
            Description = '$013';
        }
        field(50104; "Pte firma cliente"; Boolean)
        {
            Caption = 'Pte. firma cliente';
            Description = '$014';
        }
        field(50105; "Imprimir Solo Total"; Boolean) { }
        field(50106; "Revisado"; Boolean) { }
        field(50108; "Enviar a Administración"; Boolean) { }
        field(50109; "Enviar a Medios"; Boolean) { }
        field(50110; "Enviado a Dirección"; Boolean) { }
        field(50107; "Ampliación Covit19"; Enum "Ampliación Covid") { }
        field(50111; "Pedido standard"; Boolean) { }
        field(51040; "Shortcut Dimension 3 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            Caption = 'Cód. dim. acceso dir. 3';
            CaptionClass = '1,2,3';
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            END;

        }
        field(51041; "Shortcut Dimension 4 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            Caption = 'Cód. dim. acceso dir. 4';
            CaptionClass = '1,2,4';
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            END;

        }
        field(51042; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Cód. dim. acceso dir. 5';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            END;

        }
        field(51102; "Nº Remesa Fact. Electrónica"; Integer) { }
        field(52003; "Fact. Electrónica Activada"; Boolean) { }
        field(54094; "Pedido compra creado"; Boolean) { }
        field(54095; "Nº pedido"; Code[20]) { }
        field(54096; "Customer Order No."; Code[20]) { Caption = 'Nº de pedido cliente'; }
        field(60000; "Enviada E-Mail"; Boolean) { }
        field(60030; "Situación Efactura"; Enum "Situación Efactura") { }
        field(70000; "Nuestra Cuenta"; Code[20])
        {
            TableRelation = "Bank Account";
            trigger OnValidate()
            begin
                "B2R Bank Payment Code" := Rec."Nuestra Cuenta";
            end;
        }
        field(70001; "Nuestra Cuenta Prepago"; Code[20])
        {
            TableRelation = "Bank Account";
            trigger OnValidate()
            begin
                if Rec."Factura prepago" Then
                    "B2R Bank Payment Code" := Rec."Nuestra Cuenta Prepago";
            end;
        }
        field(80001; "Tipo factura SII"; Code[2])
        {
            Description = 'SII';
            Editable = true;
        }
        field(80006; "Descripción operación"; Text[250])
        {
            Description = 'SII';
            Editable = true;
        }
        field(80007; "Tipo factura rectificativa"; Code[1])
        {
            Description = 'SII';
            Editable = true;
        }
        field(80015; "Obviar SII"; Boolean) { }
        field(90000; "Anulación"; Boolean) { Description = 'AF3.70 (FCL-17/03/04)'; }
        field(90001; "Creado por anulación"; Boolean) { Description = 'AF3.70 (FCL-30/03/04)'; }
        field(90002; "Factura prepago"; Boolean) { Description = '$007 Anulaciones'; }
        field(90003; "Nº pedido prepago"; Code[20]) { Description = '$007 Anulaciones'; }
        field(90004; "Fecha Vencimiento"; Date)
        { }
        // field(95000; "Retention Group Code (GE)"; Code[20])
        // {
        //     ObsoleteState = Removed;
        //     TableRelation = "Payments Retention Group".Code WHERE("Retention Type" = CONST("Good Execution"));
        //     DataClassification = ToBeClassified;

        //     Caption = 'Código grupo retención (BE)';
        // }
        // field(95001; "Retention Group Code (IRPF)"; Code[20])
        // {
        //     ObsoleteState = Removed;
        //     TableRelation = "Payments Retention Group".Code WHERE("Retention Type" = CONST(IRPF));
        //     DataClassification = ToBeClassified;

        //     Caption = 'Código grupo retención (IRPF)';
        // }
        // field(95002; "Retention Amount (GE)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Sales Line"."Retention Amount (GE)" WHERE("Document Type" = FIELD("Document Type"),
        //                                                                                                        "Document No." = FIELD("No.")));

        //     Caption = 'Importe retención (BE)';
        //     Editable = false;
        // }
        // field(95003; "Retention Amount (IRPF)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Sales Line"."Retention Amount (IRPF)" WHERE("Document Type" = FIELD("Document Type"),
        //                                                                                                          "Document No." = FIELD("No.")));

        //     Caption = 'Importe retención (IRPF)';
        //     Editable = false;
        // }
        field(60019; "Nombre Comercial"; Text[250])
        {
            Caption = 'Anunciante';
            TableRelation = "Nombre Comercial".Nombre;
        }
        field(90100; nodeRef; Text[100])
        { }
        field(90102; nodeRefSepa; Text[100])
        { }


        field(90101; "Estado Firma Electrónica"; Enum "Estado Firma Electrónica")
        {

        }

        field(50120; "Creada facturación Prepago"; Boolean)
        {
            InitValue = false;
            Description = 'Nos dice si ya estan creadas las facturas MLL';
        }
        field(50115; "Cód. términos prepago"; Code[10]) { TableRelation = "Términos facturación"; }
        field(50116; "Marcar Para Listado"; Boolean) { }
        field(50118; "Marcar para Renovar"; Boolean)
        { }
        field(50119; "Ok Admon"; Boolean)
        { }
        field(50200; "Comentarios Direccion"; BLOB)
        {
            Caption = 'Comentarios Dirección';
        }
        field(50201; "Prepago Nuevo"; Boolean)
        { }
        field(50202; "Contrato Aeropuerto"; Boolean)
        { }
        //FechaenvioFirma
        field(50203; "Fecha envío firma"; Date)
        { }
        field(50204; "Fecha notificación"; Date)
        { }
        // field(92123; "Order Type"; Code[20])
        // {
        //     Caption = 'Tipo de pedido';
        //     TableRelation = "Transaction Type";
        // }
        field(50205; "Línea Borrador"; Integer) { }
        field(50206; "Venta de Soportes"; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec."Venta de Soportes" then
                    Rec."Imprimir Parte" := false;
            end;
        }
        field(50207; "Imprimir Parte"; Boolean)
        { }

    }

    var
        myInt: Integer;
        rProy: Record Job;
        rConfigProy: Record "Jobs Setup";

        rLinContrato: Record "Sales Line";
        UserMgt: Codeunit "User Setup Management";
#if CLEAN24
#pragma warning disable AL0432
        NoSeriesMgt: Codeunit NoSeriesManagement;
#pragma warning restore AL0432
#else
        NoSeriesMgt: Codeunit "No. Series";
#endif
        Text061: Label 'Se ha configurado %1 para procesar sólo desde %2 %3.';
        Text062: Label 'La fecha de estado no se puede cambiar una vez puesta.';
        Text1100002: Label '%1 no existe. \Campos de identificación y valores:\%1 = %2';
        Text1100003: Label '%1 no se puede liquidar, ya que está incluido en una remesa.';
        Text1100004: Label ' Bórrelo de la remesa e inténtelo de nuevo.';
        Text1100100: Label 'Debe generar los borradores de factura  antes de firmar el contrato';
        Text063: Label 'Se ha modifcado porcentaje prepago en cabecera y líneas.';

    /* PROCEDURE GenerarContratoCompra();
    VAR
        Gest_dll: Codeunit "Gestion Reservas";
        JobSetup: Record 315;
    BEGIN
        JobSetup.GET;
        if JobSetup."Correlación de ingresos-gastos" = FALSE THEN EXIT;
        if "Pedido compra creado" THEN ERROR('Ya se ha creado el pedido de compra');
        "Pedido compra creado" := TRUE;
        MODIFY;
        rProy.GET("Nº Proyecto");
        //ASC 01/08/2010 Genero contrato de compra
        CALCFIELDS("Borradores de Factura", "Borradores de Abono");
        //if ("Borradores de Factura"+"Borradores de Abono")=0 THEN
        //ERROR(Text1100100);
        CLEAR(Gest_dll);
        Gest_dll.Pasa_ContratoCompra(rProy, Rec);
    END; */
    /// <summary>
    /// SetComentariosDireccion.
    /// </summary>
    /// <param name="NewCom">Text.</param>
    procedure SetComentariosDireccion(NewCom: Text)
    var
        OutStream: OutStream;
    begin
        Clear("comentarios direccion");
        "Comentarios Direccion".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewCom);
        Modify();
    end;

    /// <summary>
    /// UpdatePrepmtAmountOnSaleslines.
    /// </summary>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    /// <param name="NewTotalPrepmtAmount">Decimal.</param>
    /// <returns>Return value of type Decimal.</returns>
    procedure UpdatePrepmtAmountOnSaleslines(SalesHeader: Record "Sales Header"; NewTotalPrepmtAmount: Decimal): Decimal;
    var
        Currency: Record Currency;
        SalesLine: Record "Sales Line";
        TotalLineAmount: Decimal;
        TotalPrepmtAmount: Decimal;
        TotalPrepmtAmtInv: Decimal;
        LastLineNo: Integer;
        IsHandled: Boolean;
        Text013: Label 'It is not possible to assign a prepayment amount of %1 to the sales lines.';
        Text014: Label 'VAT Amount';
        Text015: Label '%1% VAT';
        Text016: Label 'The new prepayment amount must be between %1 and %2.';
        Text017: Label 'At least one line must have %1 > 0 to distribute prepayment amount.';
        Por: Decimal;
    begin
        IsHandled := false;
        Currency.Initialize(SalesHeader."Currency Code");

        with SalesLine do begin
            SetRange("Document Type", SalesHeader."Document Type");
            SetRange("Document No.", SalesHeader."No.");
            SetFilter(Type, '<>%1', Type::" ");
            SetFilter("Line Amount", '<>0');
            SetFilter("Prepayment %", '<>0');
            SetFilter(Reparto, '<>%1', Reparto::"Fra prepago");
            LockTable();
            if Find('-') then
                repeat
                    TotalLineAmount := TotalLineAmount + "Line Amount";
                    TotalPrepmtAmtInv := TotalPrepmtAmtInv + "Prepmt. Amt. Inv.";
                    LastLineNo := "Line No.";
                until Next() = 0
            else
                Error(Text017, FieldCaption("Prepayment %"));
            if TotalLineAmount = 0 then
                Error(Text013, NewTotalPrepmtAmount);
            if not (NewTotalPrepmtAmount in [TotalPrepmtAmtInv .. TotalLineAmount]) then
                Error(Text016, TotalPrepmtAmtInv, TotalLineAmount);

            if Find('-') then
                repeat
                    if "Line No." <> LastLineNo then begin
                        Validate(
                          "Prepmt. Line Amount",
                          Round(
                            NewTotalPrepmtAmount * "Line Amount" / TotalLineAmount,
                            Currency."Amount Rounding Precision"));

                    end else
                        Validate("Prepmt. Line Amount", NewTotalPrepmtAmount - TotalPrepmtAmount);
                    TotalPrepmtAmount := TotalPrepmtAmount + "Prepmt. Line Amount";
                    Modify();
                    Por := "Prepayment %";
                until Next() = 0;
        end;
        exit(Por);
    end;

    /// <summary>
    /// GetComentariosDireccion.
    /// </summary>
    /// <returns>Return variable NewCom of type Text.</returns>
    procedure GetComentariosDireccion() NewCom: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("comentarios direccion");
        "Comentarios Direccion".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Comentarios Direccion")));
    end;

    PROCEDURE ComprobarPostingNo(pNumero: Code[20]);
    VAR
        NuevoNum: Code[20];
        TxtFor001: Label 'Nº siguiente factura debe tener %1 caracteres';
        ind: Integer;
        wind2: Integer;
        caracter1: Text[1];
        caracter2: Text[1];
        TxtFor002: Label 'El formato de Nº siguiente factura no es correcto.\Revise el carácter nº %1.';
        any1: Text[2];
        any2: Text[2];
        any2int: Integer;
        TxtFor003: Label 'El año de Nº siguiente factura debe ser %1';
    BEGIN
        //$010. Comparo el formato del nº introducido con el formato de nº serie
        NuevoNum := NoSeriesMgt.GetNextNo("Posting No. Series", "Posting Date", FALSE);

        //Compruebo que la longitud sea la misma
        if STRLEN(pNumero) <> STRLEN(NuevoNum) THEN
            ERROR(TxtFor001, STRLEN(NuevoNum));

        //Compruebo que los caracteres sean del mismo tipo
        FOR ind := 1 TO STRLEN(NuevoNum) DO BEGIN
            caracter1 := COPYSTR(NuevoNum, ind, 1);
            caracter2 := COPYSTR(pNumero, ind, 1);
            if (caracter1 >= 'A') AND (caracter1 <= 'Z') THEN BEGIN            //letra
                if (caracter2 < 'A') OR (caracter2 > 'Z') THEN
                    ERROR(TxtFor002, ind);
            END
            ELSE BEGIN
                if (caracter1 >= '0') AND (caracter1 <= '9') THEN BEGIN              //número
                    if (caracter2 < '0') OR (caracter2 > '9') THEN
                        ERROR(TxtFor002, ind);
                END
                ELSE BEGIN                                                  //otro carácter (debe coincidir)
                    wind2 := ind;
                    if caracter1 <> caracter2 THEN
                        ERROR(TxtFor002, ind);
                END;
            END;
        END;

        //Compruebo que los 2 caracteres anteriores al guión coincidan con el a¤o de fecha registro
        if wind2 > 2 THEN BEGIN
            any1 := COPYSTR(pNumero, wind2 - 2, 2);
            any2int := DATE2DMY("Posting Date", 3);
            any2 := COPYSTR(FORMAT(any2int), 3, 2);
            if any1 <> any2 THEN
                ERROR(TxtFor003, any2);
        END;
    END;

    /*  PROCEDURE UpdateCustEmp(VAR Cust: Record Customer; Emp: Text[30]);
     BEGIN
         if "Bill-to Customer No." <> '' THEN BEGIN
             Cust.GET("Bill-to Customer No.");
             Cust.TESTFIELD("Customer Posting Group");
             Cust.TESTFIELD("Bill-to Customer No.", '');
             "Sell-to Customer Template Code" := '';
             "Sell-to Customer Name" := Cust.Name;
             "Sell-to Customer Name 2" := Cust."Name 2";
             "Sell-to Address" := Cust.Address;
             "Sell-to Address 2" := Cust."Address 2";
             "Sell-to City" := Cust.City;
             "Sell-to Post Code" := Cust."Post Code";
             "Sell-to County" := Cust.County;
             "Sell-to Country/Region Code" := Cust."Country/Region Code";
             "Sell-to Contact" := Cust.Contact;
             "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
             "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
             "Tax Area Code" := Cust."Tax Area Code";
             "Tax Liable" := Cust."Tax Liable";
             "VAT Registration No." := Cust."VAT Registration No.";
             "Shipping Advice" := Cust."Shipping Advice";
             "Sell-to IC Partner Code" := Cust."IC Partner Code";
             "Send IC Document" := ("Sell-to IC Partner Code" <> '') AND ("IC Direction" = "IC Direction"::Outgoing);
             "Cod cadena" := Cust."Cod cadena";            //$013

             "Bill-to Name" := Cust.Name;
             "Bill-to Name 2" := Cust."Name 2";
             "Bill-to Address" := Cust.Address;
             "Bill-to Address 2" := Cust."Address 2";
             "Bill-to City" := Cust.City;
             "Bill-to Post Code" := Cust."Post Code";
             "Bill-to Country/Region Code" := Cust."Country/Region Code";
             "Currency Code" := Cust."Currency Code";
             "Customer Disc. Group" := Cust."Customer Disc. Group";
             "Customer Price Group" := Cust."Customer Price Group";
             "Language Code" := Cust."Language Code";
             "Bill-to County" := Cust.County;
             "Bill-to Country/Region Code" := Cust."Country/Region Code";

             UpdateBillToContEmp("Bill-to Customer No.", Cust, Emp);
         END ELSE BEGIN
             "Bill-to Name" := '';
             "Bill-to Name 2" := '';
             "Bill-to Address" := '';
             "Bill-to Address 2" := '';
             "Bill-to City" := '';
             "Bill-to Post Code" := '';
             "Bill-to Country/Region Code" := '';
             "Currency Code" := '';
             "Customer Disc. Group" := '';
             "Customer Price Group" := '';
             "Language Code" := '';
             "Bill-to County" := '';
             "Bill-to Country/Region Code" := '';
             "Sell-to Customer Template Code" := '';
             "Sell-to Customer Name" := '';
             "Sell-to Customer Name 2" := '';
             "Sell-to Address" := '';
             "Sell-to Address 2" := '';
             "Sell-to City" := '';
             "Sell-to Post Code" := '';
             "Sell-to County" := '';
             "Sell-to Country/Region Code" := '';
             "Sell-to Contact" := '';
         END;
     END;

     PROCEDURE UpdateBillToContEmp(CustomerNo: Code[20]; VAR Cust: Record Customer; Emp: Text[30]);
     VAR
         ContBusRel: Record 5054;
     BEGIN
         if Cust.GET(CustomerNo) THEN BEGIN
             if Cust."Primary Contact No." <> '' THEN
                 "Bill-to Contact No." := Cust."Primary Contact No."
             ELSE BEGIN
                 ContBusRel.CHANGECOMPANY(Emp);
                 ContBusRel.RESET;
                 ContBusRel.SETCURRENTKEY("Link to Table", "No.");
                 ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Customer);
                 ContBusRel.SETRANGE("No.", "Bill-to Customer No.");
                 if ContBusRel.FIND('-') THEN
                     "Bill-to Contact No." := ContBusRel."Contact No.";
             END;
             "Bill-to Contact" := Cust.Contact;
         END;
     END; */

    PROCEDURE UpdateFieldsSII(): Boolean;
    Var
        GlSetup: Record "General Ledger Setup";
    BEGIN

        //-SII1
        GLSetup.GET;
        if NOT GLSetup."Activar SII" THEN
            EXIT;
        // Si ya están informados no volver a informarlos..
        if ("Tipo factura SII" <> '') AND ("Descripción operación" <> '') THEN
            EXIT;
        "Tipo factura SII" := 'F1';
        if "Document Type" IN ["Document Type"::"Credit Memo", "Document Type"::"Return Order"] THEN BEGIN
            "Tipo factura rectificativa" := 'I';
        END;
        "Descripción operación" := "Posting Description";
        EXIT(TRUE);
        //+SII1
    END;

    PROCEDURE MarcarComofacturado(No: Code[20]);
    VAR
        rCab: Record "Purch. Rcpt. Header";
        rLin: Record "Purch. Rcpt. Line";
        r39: Record 39;
    BEGIN
        rCab.GET(No);
        //if rCab.FINDFIRST THEN REPEAT
        rLin.SETRANGE(rLin."Document No.", rCab."No.");
        if rLin.FINDFIRST THEN
            REPEAT
                rLin."Qty. Rcd. Not Invoiced" := 0;
                rLin."Quantity Invoiced" := rLin.Quantity;
                rLin."Qty. Invoiced (Base)" := rLin."Quantity (Base)";
                if r39.GET(r39."Document Type"::Order, rLin."Order No.", rLin."Order Line No.") THEN BEGIN
                    r39."Qty. to Invoice" := r39."Qty. to Receive";
                    r39."Qty. Rcd. Not Invoiced" := 0;
                    r39."Amt. Rcd. Not Invoiced" := 0;
                    r39."Quantity Invoiced" := rLin."Quantity Invoiced";
                    r39."Qty. to Invoice (Base)" := 0;
                    r39."Qty. Rcd. Not Invoiced (Base)" := 0;
                    r39."Qty. Invoiced (Base)" := rLin."Qty. Invoiced (Base)";
                    r39.MODIFY;
                END;
                rLin.MODIFY;
            UNTIL rLin.NEXT = 0;
    END;

    procedure Navigate()
    var
        NavigatePage: Page Navigate;
    begin
        NavigatePage.SetDoc("Posting Date", "No.");
        NavigatePage.SetRec(Rec);
        NavigatePage.Run();
    end;

}