/// <summary>
/// Table Cab. orden publicidad (ID 7001131).
/// </summary>
table 7001131 "Cab. orden publicidad"
{

    Caption = 'Cab. orden publicidad';
    fields
    {
        field(1; "Tipo orden"; Enum "Tipo orden")
        {
            Caption = 'Tipo orden publicidad';

        }
        field(2; "No"; Code[20])
        {
            Caption = 'Nº orden';
            trigger OnValidate()
            BEGIN

                //-003
                if No <> xRec.No THEN BEGIN
                    TestNoSeries;
#pragma warning disable AL0432
                    cNoSeriesMgt.TestManual(GetNoSeriesCode);
#pragma warning restore AL0432
                    "No. serie" := '';
                END;
                //+003
            END;

        }
        field(3; "No cliente"; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Nº cliente';
            trigger OnValidate()
            BEGIN
                CLEAR("Nombre cliente");
                CLEAR(Campaña);
                CLEAR("Cif cliente");
                if rCli.GET("No cliente") THEN BEGIN
                    "Nombre cliente" := rCli.Name;
                    //Campaña := rCli."Cliente campaña";
                    "Cif cliente" := rCli."VAT Registration No.";
                    "Cod vendedor" := rCli."Salesperson Code";
                END;
            END;

        }
        field(4; "Nombre cliente"; Text[50]) { Caption = 'falsembre cliente'; }
        field(5; "Cod. Soporte"; Code[20])
        {
            TableRelation = Vendor WHERE(Soporte = CONST(true),
                                                                               Medio = FIELD("Tipo orden"));
            trigger OnValidate()
            BEGIN
                CLEAR("Nombre Soporte");
                if rMedios.GET("Cod. Soporte") THEN BEGIN
                    "Nombre Soporte" := rMedios.Name;
                    "Cod proveedor" := rMedios."Pay-to Vendor No.";
                END;
            END;
        }
        field(6; "Nombre Soporte"; Text[50]) { Caption = 'falsembre medio'; }
        field(7; "Seccion"; Code[20]) { Caption = 'Sección'; }
        field(8; "No. serie"; Code[10])
        {
            TableRelation = "No. Series";
            Editable = false;
        }
        field(9; "Fecha creacion"; Date) { Caption = 'Fecha'; }
        field(10; "Usuario creacion"; Code[50]) { Caption = 'Usuario creación'; }
        field(11; "Fecha ult. modificacion"; Date) { Caption = 'Fecha Última modificación'; }
        field(12; "Usuario ult. modificacion"; Code[50]) { Caption = 'Usuario Última modificación'; }
        field(13; "Comentado"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Comentario orden publicidad" WHERE("Tipo orden" = FIELD("Tipo orden"),
                                                                                                          "No." = FIELD(No)));
            Editable = false;
        }
        field(15; "Concepto"; Code[20])
        {
            TableRelation = Resource;
            Caption = 'Concepto';
            trigger OnValidate()
            BEGIN

                CLEAR("Texto concepto");
                if rConcepto.GET(Concepto) THEN
                    "Texto concepto" := rConcepto.Name;
            END;

        }
        field(16; "Alto"; Integer) { Caption = 'Alto'; }
        field(17; "Ancho"; Integer) { Caption = 'Ancho'; }
        field(20; "Importe"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Lin. orden publicidad".Importe WHERE("Tipo orden" = FIELD("Tipo orden"),
                                                                                                          "No. orden" = FIELD(No),
                                                                                                          "Fecha inicio" = FIELD(FILTER("Filtro fecha"))));
            Caption = 'Importe';
        }
        field(21; "Recargo"; Decimal) { Caption = 'Recargo`'; }
        field(22; "Periodo"; Integer) { }
        field(23; "Duracion"; Integer) { Caption = 'Duración (seg)'; }
        field(24; "Importe grabacion"; Decimal) { Caption = 'Importe grabación'; }
        field(25; "Importe realizacion"; Decimal) { Caption = 'Importe realización'; }
        field(27; "Estado"; Enum "Estado Orden Publicidad") { }
        field(28; "Campaña"; Boolean) { Caption = 'Campaña'; }
        field(30; "Descripcion"; Text[50]) { Caption = 'Anuncio'; }
        field(31; "Importe manual"; Boolean) { }
        field(32; "Pendiente facturar"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Lin. orden publicidad" WHERE("Tipo orden" = FIELD("Tipo orden"),
                                                                                                    "No. orden" = FIELD(No),
                                                                                                    Facturada = CONST(false)));
        }
        field(33; "Total inserciones"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dias orden publicidad" WHERE("Tipo orden" = FIELD("Tipo orden"),
                                                                                                    "No. orden" = FIELD(No)));
        }
        field(34; "Facturable"; Boolean)
        {
            Caption = 'Facturable';
            trigger OnValidate()
            BEGIN
                "Usuario facturable" := USERID;
                "Fecha facturable" := CURRENTDATETIME;
            END;

        }
        field(35; "Usuario facturable"; Code[50])
        {
            Caption = 'Usuario modificación facturable';
            Editable = false;
        }
        field(36; "Fecha facturable"; DateTime)
        {
            Caption = 'Fecha modificación facturable';
            Editable = false;
        }
        field(37; "Grabacion facturada"; Boolean) { Caption = 'Grabación facturada'; }
        field(38; "Realizacion facturada"; Boolean) { Caption = 'Relización facturada'; }
        field(39; "Texto seccion"; Text[30]) { Caption = 'Texto sección'; }
        field(40; "Texto concepto"; Text[30]) { }
        field(41; "CIF cliente"; Text[20]) { Caption = 'C.I.F. cliente'; }
        field(42; "Cod vendedor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser".Code;
            Caption = 'Cód. vendedor';
        }
        field(43; "Cod proveedor"; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Cód. proveedor';
        }
        // field(45;"Cod delegacion";Code[20];false){        trigger OnValidate()BEGIN
        //                                                             field(  MATAS
        //                                                             //-002

        //                                                             if ("Cod delegacion" <> '') AND ("Cod delegacion" <> xRec."Cod delegacion") THEN BEGIN
        //                                                               WITH rCabOrden DO BEGIN
        //                                                                 rCabOrden := Rec;
        //                                                                 TestNoSeries;
        //                                                                 rCabOrden."No. serie" := GetNoSeriesCode;
        //                                                                 rCabOrden.No := '';
        //                                                                 cNoSeriesMgt.InitSeries(rCabOrden."No. serie", xRec."No. serie", WORKDATE, rCabOrden.No, rCabOrden."No. serie");
        //                                                             //    cNoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. serie", WORKDATE, No,"No. serie");
        //                                                                 TestNoSeries;
        //                                                                 cNoSeriesMgt.SetSeries(rCabOrden.No);
        //                                                                 Rec := rCabOrden;
        //                                                               END;
        //                                                               TestNoSeries;

        //                                                               // eliminamos las posibles lineas
        //                                                               rLinOrden.RESET;
        //                                                               rLinOrden.SETRANGE(rLinOrden."Tipo orden", xRec."Tipo orden");
        //                                                               rLinOrden.SETRANGE(rLinOrden."No. orden", xRec.No);
        //                                                               if rLinOrden.FIND('-') THEN BEGIN
        //                                                                 if CONFIRM(Text0002,FALSE) THEN;
        //                                                                   rLinOrden.DELETEALL;
        //                                                               END;
        //                                                             END;

        //                                                             //+002
        //                                                               }
        //                                                           END;

        //                                                CaptionML=ESP='Cód. delegación';}
        field(46; "Factura grabacion"; Code[20]) {; Description = '004'; }
        field(47; "Factura realizacion"; Code[20]) {; Description = '004'; }
        field(100; "Filtro fecha"; Date)
        {
            FieldClass = FlowFilter;
            Description = '005';
        }
        field(101; "Tiene lineas"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Lin. orden publicidad" WHERE("Tipo orden" = FIELD("Tipo orden"),
                                                                                                    "No. orden" = FIELD(No),
                                                                                                    "Fecha inicio" = FIELD("Filtro fecha")));
            Description = '005';
        }
        field(105; "Nº proyecto"; Code[20])
        {
            TableRelation = Job;
            Description = '006';
        }
        field(110; "Nº tarea proyecto"; Code[20])
        {
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Nº proyecto"));
            Description = '006';
        }
        field(115; "Nº linea"; Integer) {; Description = '006'; }
    }
    KEYS
    {
        key(P; No) { Clustered = true; }
        key(A; "No cliente", Estado) { }
        key(B; "Cod. Soporte") { }
        key(C; "Nº proyecto", "Nº tarea proyecto", "Nº linea") { }
    }
    VAR
        rCabOrden: Record "Cab. orden publicidad";
        rCabOrdenAnt: Record "Cab. orden publicidad";
        rConfig: Record 315;
        rLinOrden: Record "Lin. orden publicidad";
        rComOrden: Record "Comentario orden publicidad";
        rDiasOrden: Record "Dias orden publicidad";
        rTarOrden: Record "Tarifas orden publicidad";
        rTxtOrden: Record "Texto orden publicidad";
        rCli: Record Customer;
        rMedios: Record Vendor;
        rConcepto: Record 156;
        cMedios: Codeunit "Gestion medios";
#if CLEAN24
#pragma warning disable AL0432
        cNoSeriesMgt: Codeunit NoSeriesManagement;
#pragma warning restore AL0432
#else
        cNoSeriesMgt: Codeunit "No. Series";
#endif
        Text0001: Label 'No es posible eliminar ordenes validadas.';
        Text0002: Label 'Ya existen líneas en la orden que serán eliminadas. ¿Desea continuar?';

    trigger OnInsert()
    BEGIN

        rConfig.GET;

        if No = '' THEN BEGIN
            TestNoSeries;
            //  cNoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. serie",WORKDATE,No,"No. serie");  // 004
#if CLEAN24
#pragma warning disable AL0432
            cNoSeriesMgt.InitSeries(GetNoSeriesCode, '', WORKDATE, No, "No. serie");
#pragma warning restore AL0432
#else
            If cNoSeriesMgt.AreRelated(GetNoSeriesCode, "No. Serie") THEN
                Rec."No. Serie" := GetNoSeriesCode;
#endif
        END;

        InitRecord;
    END;

    trigger OnModify()
    BEGIN

        "Usuario ult. modificacion" := USERID;
        "Fecha ult. modificacion" := WORKDATE;
    END;

    trigger OnDelete()
    BEGIN

        if Estado = Estado::Validada THEN
            ERROR(Text0001);

        rLinOrden.RESET;
        rLinOrden.SETRANGE("Tipo orden", "Tipo orden");
        rLinOrden.SETRANGE("No. orden", No);
        if rLinOrden.FIND('-') THEN
            rLinOrden.DELETEALL(TRUE);

        rComOrden.RESET;
        rComOrden.SETRANGE("Tipo orden", "Tipo orden");
        rComOrden.SETRANGE("No.", No);
        if rComOrden.FIND('-') THEN
            rComOrden.DELETEALL;

        rTxtOrden.RESET;
        rTxtOrden.SETRANGE("Tipo orden", "Tipo orden");
        rTxtOrden.SETRANGE("No.", No);
        if rTxtOrden.FIND('-') THEN
            rTxtOrden.DELETEALL;

        rTarOrden.RESET;
        rTarOrden.SETRANGE("Tipo orden", "Tipo orden");
        rTarOrden.SETRANGE(No, No);
        if rTarOrden.FIND('-') THEN
            rTarOrden.DELETEALL;
    END;

    PROCEDURE InitRecord();
    VAR
        recMedio: Record Vendor;
        recSeccion: Record "Seccion publicidad";
    BEGIN

        "Fecha creacion" := WORKDATE;
        "Usuario creacion" := USERID;
        //grc221204
        CASE "Tipo orden" OF
            "Tipo orden"::Prensa:
                BEGIN
                    Alto := 1;
                    Ancho := 1;
                    //por defecto mostramos la seccion y medio de la Última orden creada
                    rCabOrdenAnt.RESET;
                    rCabOrdenAnt.SETRANGE("Tipo orden", rCabOrdenAnt."Tipo orden"::Prensa);
                    rCabOrdenAnt.ASCENDING(FALSE);
                    if rCabOrdenAnt.FIND('-') THEN BEGIN
                        if recMedio.GET(rCabOrdenAnt."Cod. Soporte") THEN
                            VALIDATE("Cod. Soporte", rCabOrdenAnt."Cod. Soporte");
                        if recSeccion.GET(rCabOrdenAnt.Seccion) THEN
                            Seccion := rCabOrdenAnt.Seccion;
                    END;
                END;
            "Tipo orden"::Radio:
                BEGIN
                    //por defecto mostramos el medio de la Última orden creada
                    rCabOrdenAnt.RESET;
                    rCabOrdenAnt.SETRANGE("Tipo orden", rCabOrdenAnt."Tipo orden"::Radio);
                    rCabOrdenAnt.ASCENDING(FALSE);
                    if rCabOrdenAnt.FIND('-') THEN BEGIN
                        if recMedio.GET(rCabOrdenAnt."Cod. Soporte") THEN
                            VALIDATE("Cod. Soporte", rCabOrdenAnt."Cod. Soporte");
                    END;
                    //

                END;
            "Tipo orden"::Audiovisuales:
                BEGIN
                    //por defecto mostramos el medio de la Última orden creada
                    rCabOrdenAnt.RESET;
                    rCabOrdenAnt.SETRANGE("Tipo orden", rCabOrdenAnt."Tipo orden"::Audiovisuales);
                    rCabOrdenAnt.ASCENDING(FALSE);
                    if rCabOrdenAnt.FIND('-') THEN BEGIN
                        if recMedio.GET(rCabOrdenAnt."Cod. Soporte") THEN
                            VALIDATE("Cod. Soporte", rCabOrdenAnt."Cod. Soporte");
                    END;
                    //

                END;
        END;
        //

        Facturable := TRUE;
    END;

    PROCEDURE AssistEdit(prCabOrden: Record "Cab. orden publicidad"): Boolean;
    BEGIN

        //WITH rCabOrden DO BEGIN
        rCabOrden := Rec;
        //  rConfMed.GET;

        TestNoSeries;
#if CLEAN24
#pragma warning disable AL0432
        if cNoSeriesMgt.SelectSeries(GetNoSeriesCode, prCabOrden."No. serie", rCabOrden."No. serie") THEN BEGIN
#pragma warning restore AL0432
            rConfig.GET;
            TestNoSeries;
#pragma warning disable AL0432
            cNoSeriesMgt.SetSeries(rCabOrden.No);
#pragma warning restore AL0432
            Rec := rCabOrden;
            EXIT(TRUE);

            //END;
        END;

#else
        if cNoSeriesMgt.LookupRelatedNoSeries(GetNoSeriesCode, prCabOrden."No. serie", rCabOrden."No. serie") then begin
            rCabOrden.No := cNoSeriesMgt.GetNextNo(rCabOrden."No. serie");
            Rec := rCabOrden;
            exit(true);
        end;
#endif
    END;

    LOCAL PROCEDURE TestNoSeries(): Boolean;
    VAR
        wlDeleg: Code[20];
    BEGIN
        rConfig.Get();
        rConfig.TESTFIELD("Nº serie orden publicidad");
    END;

    LOCAL PROCEDURE GetNoSeriesCode(): Code[10];
    VAR
        wlDeleg: Code[20];
    BEGIN
        EXIT(rConfig."Nº serie orden publicidad");
    END;

    PROCEDURE CopiaTarifasTamaño();
    VAR
        rDiasTar: Record "Dias tarifa publicidad";
        rTarifas: Record "Price List Line";
        rTarOrden: Record "Tarifas orden publicidad";
    BEGIN

        rTarOrden.RESET;
        rTarOrden.SETRANGE("Tipo orden", "Tipo orden");
        rTarOrden.SETRANGE(No, No);
        if rTarOrden.FIND('-') THEN
            rTarOrden.DELETEALL;

        if Concepto <> '' THEN BEGIN

            rDiasTar.RESET;
            rDiasTar.SETRANGE("Cod. Soporte", "Cod. Soporte");
            rDiasTar.SETRANGE(Seccion, Seccion);  //grc240505
            if rDiasTar.FIND('-') THEN
                REPEAT
                    rTarOrden.INIT;
                    rTarOrden."Tipo orden" := "Tipo orden";
                    rTarOrden.No := No;
                    rTarOrden."Dia tarifa" := rDiasTar.Codigo;
                    if rTarifas.GET("Cod. Soporte", CALCDATE('-PA', "Fecha creacion"), Seccion, Concepto, rDiasTar.Codigo) THEN BEGIN
                        rTarOrden.Precio := rTarifas."Direct Unit Cost";
                        if Recargo <> 0 THEN
                            rTarOrden.Precio := ROUND(rTarOrden.Precio + (rTarOrden.Precio * Recargo / 100), 0.01);
                        rTarOrden.INSERT;
                    END;
                UNTIL rDiasTar.NEXT = 0;
        END;
    END;

    PROCEDURE ActualizarLineas(pActualizarTarifas: Boolean): Boolean;
    VAR
        wOpciones: Option Cancelar,Recalcular,Eliminar;
        txt01: Label 'Recalcular lineas,Eliminar lineas';
    BEGIN

        rLinOrden.RESET;
        rLinOrden.SETRANGE("Tipo orden", "Tipo orden");
        rLinOrden.SETRANGE("No. orden", No);
        rLinOrden.SETRANGE(rLinOrden."Importe manual", FALSE);
        if rLinOrden.FIND('-') THEN BEGIN

            wOpciones := STRMENU(txt01);

            CASE wOpciones OF
                wOpciones::Cancelar:
                    EXIT(FALSE);
                wOpciones::Recalcular:
                    BEGIN
                        rLinOrden.DELETEALL;
                        if pActualizarTarifas THEN
                            CopiaTarifasTamaño;
                        cMedios.GenerarLineasOrden(Rec, 0D, 0D, 0);  // Genera todas las lineas otra vez
                        EXIT(TRUE);
                    END;
                wOpciones::Eliminar:
                    BEGIN
                        rLinOrden.DELETEALL(TRUE);
                        if pActualizarTarifas THEN
                            CopiaTarifasTamaño;
                        EXIT(TRUE);
                    END;
            END;
        END
        ELSE BEGIN
            if pActualizarTarifas THEN
                CopiaTarifasTamaño;
            EXIT(TRUE);
        END;
    END;

    PROCEDURE ActualizarClienteLineas();
    BEGIN
        rLinOrden.RESET;
        rLinOrden.SETRANGE("Tipo orden", "Tipo orden");
        rLinOrden.SETRANGE("No. orden", No);
        if rLinOrden.FIND('-') THEN
            REPEAT
                rLinOrden."No cliente" := "No cliente";
                rLinOrden.MODIFY;
            UNTIL rLinOrden.NEXT = 0;
    END;

}
