/// <summary>
/// Page Linea Contratos Venta (ID 7001185).
/// </summary>
page 7001162 "Linea Contratos Venta"
{
    //Version List=NAVW15.00,MLL;
    Editable = true;
    Caption = 'Lista lineas Contratos Venta';
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    //area(Content){ Repeater(Detalle){ID=1;
    SourceTable = 37;
    //TimerInterval =10;
    SourceTableTemporary = true;
    SourceTableView = SORTING("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date")
                    WHERE("Document Type" = CONST(Order));
    DataCaptionFields = "Document Type";
    layout
    {
        area(Content)
        {
            group(Filtros)
            {
                field(FiltroTip; FiltroTipo)
                {
                    ApplicationArea = All;
                    Editable = true;
                    Caption = 'Filtro Tipo Recurso';
                    TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('PRINCIPAL'));
                    trigger OnValidate()
                    BEGIN
                        Filtra;
                    END;
                }
                field("Pendiente de Firma"; "Pendiente de Firma")
                {
                    ApplicationArea = All;
                    Caption = 'Pendiente de Firma';
                    //OptionCaption = 'Pendiente de Firma';
                    trigger OnValidate()
                    BEGIN
                        if "Pendiente de Firma" Then Todos := False;
                        Filtra;
                        //SETRANGE("Fecha Estado");
                    END;
                }
                field("Firmado"; Firmado)
                {
                    ApplicationArea = All;
                    Caption = 'Firmado';
                    //OptionCaption = 'Firmado';

                    trigger OnValidate()
                    BEGIN
                        if Firmado Then Todos := False;
                        Filtra;
                        //SETRANGE("Fecha Estado");
                    END;
                }
                field("Anulado"; Anulado)
                {
                    ApplicationArea = All;
                    Caption = 'Anulado';
                    //OptionCaption = 'Anulado';

                    trigger OnValidate()
                    BEGIN
                        if "Anulado" Then Todos := False;
                        Filtra;
                        //SETRANGE("Fecha Estado");
                    END;
                }
                field(Modificado; Modificado)
                {
                    ApplicationArea = All;
                    Caption = 'Modificado';
                    //OptionCaption = 'Modificado';

                    trigger OnValidate()
                    BEGIN
                        if Modificado Then Todos := False;
                        Filtra;
                        //SETRANGE("Fecha Estado");
                    END;
                }
                field(Cancelados; Cancelado)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    BEGIN
                        if "Cancelado" Then Todos := False;
                        Filtra
                    END;
                }
                field("Sin Montar"; "Sin Montar")
                {
                    ApplicationArea = All;


                    trigger OnValidate()
                    BEGIN
                        if "Sin Montar" Then Todos := False;
                        Filtra;
                    END;
                }
                field(Todos; Todos)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    BEGIN
                        if Todos Then begin
                            Anulado := False;
                            Cancelado := false;
                            Firmado := False;
                            "Sin Montar" := False;
                            "Pendiente de Firma" := false
                        End;
                        Filtra;
                    END;
                }
                group(Fechafin)
                {
                    Caption = 'Fecha fin proyecto';
                    field(Desde; Desde)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        BEGIN
                            Filtra;
                        END;
                    }
                    field(Hasta; Hasta)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        BEGIN
                            Filtra;
                        END;
                    }
                }

                field(Sol; Solh)
                {
                    ApplicationArea = All;
                    Caption = 'Solo con facturacion pend.';

                    trigger OnValidate()
                    BEGIN
                        Filtra;
                    END;
                }
                field(FZon; FZona)
                {
                    ApplicationArea = All;
                    Caption = 'Zona';

                    TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('ZONA'));
                    trigger OnValidate()
                    BEGIN
                        Filtra;
                    END;
                }
                field("Recalcule la lista"; 'Recalcule la lista') { ApplicationArea = All; Editable = false; Visible = recalcuVisible; }
            }
            Repeater(Detalle)
            {
                field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.") { ApplicationArea = All; }
                field("Sell-to Customer Name"; r36."Sell-to Customer Name") { ApplicationArea = All; Caption = 'Nombre Cliente'; }
                field("VAT Registration No."; r36."VAT Registration No.") { ApplicationArea = All; Caption = 'C.I.F'; }

                field("Amount"; Rec.Amount) { ApplicationArea = All; }
                field("Amount Including VAT"; Rec."Amount Including VAT") { ApplicationArea = All; }
                field("Description"; Rec.Description) { ApplicationArea = All; }
                field("Posting Description"; r36."Posting Description") { ApplicationArea = All; Caption = 'Descripción Contrato'; }

                field(BF; BF) { ApplicationArea = All; Caption = 'Borradores Factura'; }

                field(BA; BA) { ApplicationArea = All; Caption = 'Borradores Abono'; }

                field(FF; FF) { ApplicationArea = All; Caption = 'Facturas Registradas'; }

                field(FA; FA) { ApplicationArea = All; Caption = 'Abonos Registrados'; }
                field(FC; FC) { ApplicationArea = All; Caption = 'Borrradores Compra'; }

                field(ImpBorFac; ImpBorFac) { ApplicationArea = All; Caption = 'Total Borr Fac'; }

                field(ImpBorAbo; ImpBorAbo) { ApplicationArea = All; Caption = 'Total Borr Abo'; }

                field(ImpFac; ImpFac) { ApplicationArea = All; Caption = 'Total Fac'; }

                field(ImpAbo; ImpAbo) { ApplicationArea = All; ; Caption = 'Total Abo'; }

                field(TotCont; TotCont) { ApplicationArea = All; Caption = 'Total Contrato'; }

                field("Pendiente Factura"; (ImpBorFac - ImpBorAbo) + (TotCont - TotImp)) { ApplicationArea = All; Caption = 'Pendiente Factura'; }
                field("Diferencia"; (TotCont - TotImp)) { ApplicationArea = All; Caption = 'Diferencia'; }
                field("Total Fras-Abo"; TotImp) { ApplicationArea = All; Caption = 'Total Fras-Abo'; }
                field(Revisado; r36.Revisado) { ApplicationArea = All; ShowCaption = false; Caption = 'Revisado'; }


                field("Payment Method Code"; r36."Payment Method Code") { ApplicationArea = All; Caption = 'Forma de pago'; }

                field("External Document No."; r36."External Document No.") { ApplicationArea = All; Caption = 'Nº doc. externo'; }
                field("Sell-to Post Code"; r36."Sell-to Post Code") { ApplicationArea = All; Caption = 'Cód Postal'; }

                field("Sell-to Country/Region Code"; r36."Sell-to Country/Region Code") { ApplicationArea = All; Caption = 'País'; }

                field("Sell-to Contact"; r36."Sell-to Contact") { ApplicationArea = All; Caption = 'Contacto'; }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.") { ApplicationArea = All; }
                field("Bill-to Name"; r36."Bill-to Name") { ApplicationArea = All; Caption = 'Factura a Nombre'; }

                field("Bill-to Post Code"; r36."Bill-to Post Code") { ApplicationArea = All; Caption = 'Cód Postal'; }

                field("Bill-to Country/Region Code"; r36."Bill-to Country/Region Code") { ApplicationArea = All; Caption = 'País'; }

                field("Ship-to Code"; r36."Ship-to Code") { ApplicationArea = All; }
                field("Ship-to Name"; r36."Ship-to Name") { ApplicationArea = All; Caption = 'Envío a Nombre'; }

                field("Ship-to Post Code"; r36."Ship-to Post Code") { ApplicationArea = All; Caption = 'Cód. Postal'; }

                field("Ship-to Country/Region Code"; r36."Ship-to Country/Region Code") { ApplicationArea = All; Caption = 'País'; }

                field("Posting Date"; r36."Posting Date") { ApplicationArea = All; Caption = 'Fecha Registro'; }

                //    { 140 ;Label        ;0    ;0    ;0    ;0    ;
                field("Document Date"; r36."Document Date") { ApplicationArea = All; Caption = 'Fecha Documento'; }

                field("Order Date"; r36."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Contrato';
                }
                field(FechaEstado; r36."Fecha Estado") { ApplicationArea = All; Caption = 'Fecha Estado/Firma'; }

                field("Due Date"; r36."Due Date") { ApplicationArea = All; Caption = 'Fecha Vto.'; }

                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code") { ApplicationArea = All; }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code") { ApplicationArea = All; }
                field("Cod cadena"; r36."Cod cadena") { ApplicationArea = All; Caption = 'Cadena'; }

                field("Salesperson Code"; r36."Salesperson Code") { ApplicationArea = All; Caption = 'Vendedor'; }

                field("Comentario Cabecera"; r36."Comentario Cabecera") { ApplicationArea = All; Caption = 'Comentario Cabecera'; }

                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
                field("Nº Proyecto"; r36."Nº Proyecto") { ApplicationArea = All; Caption = 'Proyecto'; }

                field("Nº Contrato"; r36."Nº Contrato") { ApplicationArea = All; Caption = 'Contrato'; }

                field("Fecha inicial proyecto"; r36."Fecha inicial proyecto") { ApplicationArea = All; Caption = 'Fecha inicial Proyecto'; }

                field("Fecha fin proyecto"; r36."Fecha fin proyecto") { ApplicationArea = All; Caption = 'Fecha final proyecto'; }

                field(Estado; r36.Estado) { ApplicationArea = All; Caption = 'Estado'; }

                field("Fecha Estado"; r36."Fecha Estado") { ApplicationArea = All; Caption = 'Fecha Estado'; }
                field("Pte firma cliente"; r36."Pte firma cliente") { ApplicationArea = All; ShowCaption = false; Caption = 'Pte. Firma'; }

                field("importe calc"; TotalSalesLine.Amount) { ApplicationArea = All; Caption = 'Importe (calc.)'; }

                field(AmountIncludingVAT; TotalSalesLine."Amount Including VAT") { ApplicationArea = All; Caption = 'Importe IVA incl. (calc.)'; }

                field(ImpIVAincl; r36."Imp. IVA. incl.") { ApplicationArea = All; Caption = 'Importe Iva Incl'; }

                field(Renovado; r36.Renovado) { ApplicationArea = All; ShowCaption = false; Caption = 'Renovado'; }
                field("Proyecto origen"; r36."Proyecto origen") { ApplicationArea = All; Caption = 'Proyecto Origen'; }

                field("Interc./Compens."; r36."Interc./Compens.") { ApplicationArea = All; Caption = 'Iter/Compa/Dona'; }

                field("Fecha inicial factura"; r36."Fecha inicial factura") { ApplicationArea = All; Caption = 'Fecha inicial Factura'; }

                field("Fecha final factura"; r36."Fecha final factura") { ApplicationArea = All; Caption = 'Fecha Final Factura'; }
                field("Fecha renovacion"; r36."Fecha renovacion") { ApplicationArea = All; Caption = 'Fecha renovación'; }
                field("Contrato original"; "Contrato original") { ApplicationArea = All; Caption = 'Contrato original'; }

                field("Contrato origen"; "Contrato origen") { ApplicationArea = All; Caption = 'Contrato origen'; }

                field("Contrato renovado"; "Contrato renovado") { ApplicationArea = All; Caption = 'Contrato renovado'; }

                field("Fecha cancelacion"; r36."Fecha cancelacion") { ApplicationArea = All; Caption = 'Fecha Cancelación'; }


            }
            usercontrol(MyTimer; MyTimer)
            {
                ApplicationArea = Basic;

                trigger TimerElapsed()
                begin

                    if Actualiza THEN BEGIN
                        CurrPage.MyTimer.StopTimer();
                        CurrPage.UPDATE(FALSE);
                        Actualiza := FALSE;
                    END;
                    CurrPage.MyTimer.StartTimer();
                end;
            }

        }
    }
    actions
    {
        area(Navigation)
        {
            //   action("&Line")
            //   {

            //     CaptionML=ENU='&Line',
            //     ESP='&Línea';
            action("&Ficha")
            {
                ApplicationArea = All;
                Scope = Repeater;
                Image = Card;
                ShortCutKey = 'Mayús+F5';
                Caption = 'Ficha';
                trigger OnAction()
                BEGIN
                    r36.GET(Rec."Document Type", Rec."Document No.");
                    CASE Rec."Document Type" OF
                        Rec."Document Type"::Quote:
                            PAGE.RUN(PAGE::"Sales Quote", r36);
                        Rec."Document Type"::Order:
                            PAGE.RUN(PAGE::"Ficha Contrato venta", r36);
                        Rec."Document Type"::Invoice:
                            PAGE.RUN(PAGE::"Sales Invoice", r36);
                        Rec."Document Type"::"Return Order":
                            PAGE.RUN(PAGE::"Sales Return Order", r36);
                        Rec."Document Type"::"Credit Memo":
                            PAGE.RUN(PAGE::"Sales Credit Memo", r36);
                        Rec."Document Type"::"Blanket Order":
                            PAGE.RUN(PAGE::"Blanket Sales Order", r36);
                    END;
                END;
            }
            action("Di&ferencia")
            {
                Visible = false;
                Caption = 'Di&ferencia';
            }
            action(Actualiza)
            {
                ApplicationArea = All;
                Image = Refresh;
                Scope = Repeater;
                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
            action("Ver &Todos2")
            {

                Visible = false;
                ApplicationArea = All;
                Caption = 'Ver &Todos';
                trigger OnAction()
                BEGIN
                    wVer := wVer::Todos;
                    MarcaRegistros;
                    Rec.MARKEDONLY(FALSE);
                END;
            }
            action("Ver &Defecto Facturación2")
            {
                Visible = false;
                Caption = 'Ver &Defecto Facturación';
                trigger OnAction()
                BEGIN
                    wVer := wVer::Defecto;
                    MarcaRegistros;
                END;
            }
            action("Ver &Exceso Facturación2")
            {
                Visible = false;
                Caption = 'Ver &Exceso Facturación';
                trigger OnAction()
                BEGIN
                    wVer := wVer::Exceso;
                    MarcaRegistros;
                END;
            }
            action("Pendiente Facturación")
            {
                Caption = 'Pendiente Facturación';
                Visible = false;
            }
            action("Ver &Todos")
            {
                Visible = false;
                Caption = 'Ver &Todos';
                trigger OnAction()
                BEGIN
                    wVerF := wVerF::Todos;
                    MarcaRegistrosF;
                    Rec.MARKEDONLY(FALSE);
                END;
            }
            action("Ver &Defecto Facturación")
            {
                Visible = false;

                Caption = 'Ver &Defecto Facturación';
                trigger OnAction()
                BEGIN
                    wVerF := wVerF::Defecto;
                    MarcaRegistrosF;
                END;
            }
            action("Ver &Exceso Facturación")
            {
                Visible = false;
                Caption = 'Ver &Exceso Facturación';
                trigger OnAction()
                BEGIN
                    wVerF := wVerF::Exceso;
                    MarcaRegistrosF;
                END;
            }
            action("Marcar como Revisado Los seleccionados")
            {
                ShortCutKey = F11;
                Visible = false;
                Caption = 'Marcar como revisado los seleccionados';
                trigger OnAction()
                VAR
                    rContratos: Record 36;
                BEGIN
                    CurrPage.SETSELECTIONFILTER(rContratos);
                    if rContratos.FINDFIRST THEN
                        REPEAT
                            rContratos.Revisado := NOT rContratos.Revisado;
                            rContratos.MODIFY;
                        UNTIL rContratos.NEXT = 0;
                END;
            }
            action("Busca Contratos con errores")
            {
                Caption = 'Busca Contratos con errores';
                Visible = false;
                trigger OnAction()
                VAR
                    r36: Record 36;
                BEGIN
                    wVer := wVer::Defecto;
                    MarcaRegistrosFE;
                END;
            }
            // action("Busca Contratos con errores Fac 16")
            // {
            //     Visible = false;
            //     Caption = 'Busca Contratos con errores Fac 16';
            //     trigger OnAction()
            //     BEGIN
            //         wVer := wVer::Defecto;
            //         //MarcaRegistroFCE;
            //     END;
            // }

            action(Calcular)
            {
                Caption = 'Calcular';
                trigger OnAction()
                VAR
                    rRes: Record 156;
                    a: Integer;
                    r37: Record 37;
                    Ventana: Dialog;
                BEGIN
                    recalcuVisible := FALSE;
                    Rec.DELETEALL;
                    rRes.SETFILTER(rRes."Global Dimension 4 Code", FZona);
                    rRes.SETFILTER(rRes."Global Dimension 3 Code", FiltroTipo);
                    Ventana.OPEN('Calculando recurso #########1## de ########2##');
                    Ventana.UPDATE(2, rRes.COUNT);
                    r36.RESET;
                    //if wTipo=wTipo::Todos THEN
                    /// r36.SETRANGE(Estado)
                    //ELSE
                    //r36.SETRANGE(r36.Estado,wTipo);
                    if Desde = 0D THEN Desde := 19800101D;
                    if Hasta = 0D THEN Hasta := 99991231D;
                    //if Solh THEN
                    //r36.SETRANGE(r36."Fecha fin proyecto")//,0D,Hasta)
                    //ELSE
                    r36.SETRANGE(r36."Fecha fin proyecto", Desde, Hasta);
                    if rRes.FINDFIRST THEN
                        REPEAT
                            a := a + 1;
                            Ventana.UPDATE(1, a);
                            r37.SETRANGE(r37."Document Type", r37."Document Type"::Order);
                            r37.SETRANGE("No.", rRes."No.");
                            if r37.FINDFIRST THEN
                                REPEAT
                                    r36.SETRANGE(r36."Document Type", r37."Document Type");
                                    r36.SETRANGE(r36."No.", r37."Document No.");
                                    if r36.FINDFIRST THEN BEGIN
                                        if CompruebaEstado(r36) THEN BEGIN
                                            ImpBorFac := 0;
                                            ImpBorAbo := 0;
                                            ImpFac := 0;
                                            ImpAbo := 0;
                                            TotImp := 0;
                                            TotCont := 0;
                                            Rec := r37;
                                            if Solh THEN BEGIN
                                                TotalesDocumentos(r36."Nº Proyecto", r36."No.");
                                                if (ImpBorFac <> 0) OR (ImpBorAbo <> 0) OR (ABS(TotCont - (ImpFac - ImpAbo)) > 1) THEN Rec.INSERT;
                                            END ELSE
                                                Rec.INSERT;
                                        END;
                                    END;
                                UNTIL r37.NEXT = 0;
                        UNTIL rRes.NEXT = 0;
                    Ventana.CLOSE;
                    r36.RESET;
                END;
            }
        }
    }

    VAR
        recalcuVisible: Boolean;
        TotalSalesLine: Record 37;
        TotalSalesLineLCY: Record 37;
        rCabFac: Record 112;
        rCabAbo: Record 114;
        RegisVtas: Codeunit 80;
        wDecimal: Decimal;
        wTexto: Text[250];
        ImpBorFac: Decimal;
        ImpBorAbo: Decimal;
        ImpFac: Decimal;
        ImpAbo: Decimal;
        TotImp: Decimal;
        TotCont: Decimal;
        wVer: Option Todos,Defecto,Exceso;
        finestra: Dialog;
        i: Integer;
        Desde: Date;
        Hasta: Date;
        "Contrato original": Code[20];
        "Contrato origen": Code[20];
        "Contrato renovado": Code[20];
        Solh: Boolean;
        Actualiza: Boolean;
        wVerF: oPTION Todos,Defecto,Exceso;
        FiltroTipo: Text[250];
        FZona: Text[250];
        r36: Record 36;
        rLinFac: Record 113;
        rLinAbo: Record 115;
        rLin: Record 37;
        BF: Integer;
        BA: Integer;
        FF: Integer;
        FA: Integer;
        FC: Integer;
        "Pendiente de Firma": Boolean;
        Firmado: Boolean;
        Anulado: Boolean;
        Modificado: Boolean;
        Cancelado: Boolean;
        "Sin Montar": Boolean;
        Todos: Boolean;

    trigger OnOpenPage()
    BEGIN
        recalcuVisible := TRUE;
        Todos := true;
        Anulado := false;
        Cancelado := false;
        Anulado := false;
        "Pendiente de Firma" := false;
        Firmado := false;
        Filtra;
        AplicarFiltros;                                //$004
    END;

    trigger OnAfterGetRecord()
    BEGIN
        CurrPage.MyTimer.SetTimerInterval(100);
        CurrPage.MyTimer.StartTimer();
        r36.GET(Rec."Document Type", Rec."Document No.");
        //CalcularTotales("No.");              //FCL-17/05/04
        // $002 -
        TotalesDocumentos(r36."Nº Proyecto", Rec."Document No.");
        if (wVer <> wVer::Todos) THEN
            Rec.MARKEDONLY(TRUE)
        ELSE
            Rec.MARKEDONLY(FALSE);
        // $002+
        BuscarProyectos;                    //$003
    END;

    PROCEDURE TotalesDocumentos(wNumProyecto: Code[20]; wNum: Code[20]);
    VAR
        TempSalesLine: Record 37 TEMPORARY;
        rCabVenta: Record 36;
    BEGIN
        //$002 Obtengo totales de borradores y facturas correspondientes a este contrato.
        ImpBorFac := 0;
        ImpBorAbo := 0;
        ImpFac := 0;
        ImpAbo := 0;
        TotImp := 0;
        TotCont := 0;
        r36.GET(Rec."Document Type", Rec."Document No.");
        r36.CALCFIELDS(r36."Borradores de Factura", r36."Borradores de Abono",
                   r36."Facturas Registradas", r36."Abonos Registrados", r36."Borradores de Compra");
        BF := r36."Borradores de Factura";
        BA := r36."Borradores de Abono";
        FF := r36."Facturas Registradas";
        FA := r36."Abonos Registrados";
        FC := r36."Borradores de Compra";
        if (r36."Borradores de Factura" <> 0) OR (r36."Borradores de Abono" <> 0) THEN BEGIN
            rCabVenta.RESET;
            rCabVenta.SETCURRENTKEY("Nº Proyecto");
            rCabVenta.SETRANGE("Nº Proyecto", wNumProyecto);
            rCabVenta.SETRANGE("Nº Contrato", wNum);
            rCabVenta.SETFILTER("Document Type", '%1|%2',
               rCabVenta."Document Type"::Invoice, rCabVenta."Document Type"::"Credit Memo");
            if rCabVenta.FIND('-') THEN BEGIN
                REPEAT
                    CLEAR(TotalSalesLine);
                    CLEAR(TotalSalesLineLCY);
                    CLEAR(RegisVtas);
                    CLEAR(TempSalesLine);
                    //RegisVtas.GetSalesLines(rCabVenta,TempSalesLine,0);
                    //CLEAR(RegisVtas);
                    //RegisVtas.SumSalesLinesTemp(
                    //  rCabVenta,Rec,0,TotalSalesLine,TotalSalesLineLCY,
                    //  wDecimal,wTexto,wDecimal,wDecimal,wDecimal);
                    rLin.SETRANGE(rLin."Document No.", rCabVenta."No.");
                    rLin.SETRANGE(rLin."No.", Rec."No.");
                    if rLin.FINDFIRST THEN BEGIN
                        if rCabVenta."Document Type" = rCabVenta."Document Type"::Invoice THEN BEGIN
                            ImpBorFac := ImpBorFac + rLin."Line Amount";
                        END
                        ELSE BEGIN
                            ImpBorAbo := ImpBorAbo + rLin."Line Amount";
                        END;
                    END;
                UNTIL rCabVenta.NEXT = 0;
            END;
        END;
        if r36."Facturas Registradas" <> 0 THEN BEGIN
            rCabFac.RESET;
            rCabFac.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
            rCabFac.SETRANGE("Nº Contrato", wNum);
            if rCabFac.FIND('-') THEN BEGIN
                REPEAT
                    // rCabFac.CALCFIELDS("Amount Including VAT",Amount);
                    rLinFac.SETRANGE(rLinFac."Document No.", rCabFac."No.");
                    rLinFac.SETRANGE(rLinFac."No.", Rec."No.");
                    if rLinFac.FINDFIRST THEN
                        ImpFac := ImpFac + rLinFac.Amount;
                UNTIL rCabFac.NEXT = 0;
            END;
        END;
        if r36."Abonos Registrados" <> 0 THEN BEGIN
            rCabAbo.RESET;
            rCabAbo.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
            rCabAbo.SETRANGE("Nº Contrato", wNum);
            if rCabAbo.FIND('-') THEN BEGIN
                REPEAT
                    //  rCabAbo.CALCFIELDS("Amount Including VAT",Amount);
                    rLinAbo.SETRANGE(rLinAbo."Document No.", rCabAbo."No.");
                    rLinAbo.SETRANGE(rLinAbo."No.", Rec."No.");
                    if rLinAbo.FINDFIRST THEN
                        ImpAbo := ImpAbo + rLinAbo.Amount;
                // ImpAbo:=ImpAbo + rCabAbo.Amount;
                UNTIL rCabAbo.NEXT = 0;
            END;
        END;
        //FCL-13/02/06. Incluyo sumatorio de totales y diferencia con el total del contrato.
        TotImp := ImpBorFac - ImpBorAbo + ImpFac - ImpAbo;
        if rCabVenta.GET(rCabVenta."Document Type"::Order, wNum) THEN BEGIN
            CLEAR(TotalSalesLine);
            CLEAR(TotalSalesLineLCY);
            CLEAR(RegisVtas);
            CLEAR(TempSalesLine);
            //  RegisVtas.GetSalesLines(rCabVenta,TempSalesLine,0);
            //  CLEAR(RegisVtas);
            //  RegisVtas.SumSalesLinesTemp(rCabVenta,TempSalesLine,0,TotalSalesLine,TotalSalesLineLCY,
            //                             wDecimal,wTexto,wDecimal,wDecimal,wDecimal);
            TotCont := Rec."Line Amount";
        END;
    END;

    PROCEDURE MarcaRegistros();
    BEGIN
        // $002-
        Rec.MARKEDONLY(FALSE);
        finestra.OPEN('Procesando #1######## de #2#######');
        finestra.UPDATE(2, Rec.COUNT);
        i := 0;
        r36.GET(Rec."Document Type", Rec."Document No.");
        if Rec.FINDSET THEN
            REPEAT
                i += 1;
                finestra.UPDATE(1, i);
                CASE wVer OF
                    wVer::Todos:
                        Rec.MARK(FALSE);
                    wVer::Defecto:
                        BEGIN
                            TotalesDocumentos(r36."Nº Proyecto", Rec."Document No.");
                            if ((TotCont - TotImp) > 0) THEN
                                Rec.MARK(TRUE)
                            ELSE
                                Rec.MARK(FALSE);
                        END;
                    wVer::Exceso:
                        BEGIN
                            TotalesDocumentos(r36."Nº Proyecto", Rec."Document No.");
                            if ((TotCont - TotImp) < 0) THEN
                                Rec.MARK(TRUE)
                            ELSE
                                Rec.MARK(FALSE);
                        END;
                END;
            UNTIL Rec.NEXT = 0;
        finestra.CLOSE;
        Rec.MARKEDONLY(TRUE);
        // $002+
    END;

    PROCEDURE Filtra();
    BEGIN
        recalcuVisible := TRUE;
        Actualiza := TRUE;
    END;

    PROCEDURE BuscarProyectos();
    VAR
        rContrato: Record 36;
        rProyecto: Record 167;
        wCuantos: Integer;
    BEGIN
        // $003 Obtengo los contratos asociados a los proyectos original, origen y renovado.
        "Contrato origen" := '';
        "Contrato original" := '';
        "Contrato renovado" := '';
        r36.GET(Rec."Document Type", Rec."Document No.");
        if rProyecto.GET(r36."Nº Proyecto") THEN BEGIN
            if rProyecto."Proyecto original" <> '' THEN BEGIN
                rContrato.RESET;
                rContrato.SETCURRENTKEY("Nº Proyecto");
                rContrato.SETRANGE("Nº Proyecto", rProyecto."Proyecto original");
                if rContrato.FINDFIRST THEN
                    "Contrato original" := rContrato."No.";
            END;
            if rProyecto."Proyecto origen" <> '' THEN BEGIN
                rContrato.RESET;
                rContrato.SETCURRENTKEY("Nº Proyecto");
                rContrato.SETRANGE("Nº Proyecto", rProyecto."Proyecto origen");
                if rContrato.FINDFIRST THEN
                    "Contrato origen" := rContrato."No.";
            END;
            //$005(I)
            wCuantos := 0;
            rProyecto.RESET;
            rProyecto.SETCURRENTKEY("Proyecto origen");
            rProyecto.SETRANGE("Proyecto origen", r36."Nº Proyecto");
            wCuantos := rProyecto.COUNT;
            //$005(F)
            rProyecto.RESET;
            rProyecto.SETCURRENTKEY("Proyecto origen");
            rProyecto.SETRANGE("Proyecto origen", r36."Nº Proyecto");
            //$005(I)
            if wCuantos > 0 THEN
                rProyecto.SETFILTER("No.", '<>%1', r36."Nº Proyecto");
            //$005(F)
            if rProyecto.FINDFIRST THEN BEGIN
                rContrato.RESET;
                rContrato.SETCURRENTKEY("Nº Proyecto");
                rContrato.SETRANGE("Nº Proyecto", rProyecto."No.");
                if rContrato.FINDFIRST THEN
                    "Contrato renovado" := rContrato."No.";
            END;
        END;
    END;

    PROCEDURE AplicarFiltros();
    VAR
        rUsuario: Record 91;
    BEGIN
        //$004
        //   {if rUsuario.GET(USERID) THEN BEGIN
        //     if rUsuario."Filtro vendedor" <> '' THEN BEGIN
        //       FILTERGROUP(2);
        //       SETFILTER("Salesperson Code",rUsuario."Filtro vendedor");
        //       FILTERGROUP(0);
        //     END;
        //     if rUsuario."Filtro departamento" <> '' THEN BEGIN
        //       FILTERGROUP(2);
        //       SETFILTER("Shortcut Dimension 1 Code",rUsuario."Filtro departamento");
        //       FILTERGROUP(0);
        //     END;
        //   END; }
    END;

    PROCEDURE MarcaRegistrosF();
    BEGIN
        // $002-
        r36.GET(Rec."Document Type", Rec."Document No.");
        Rec.MARKEDONLY(FALSE);
        finestra.OPEN('Procesando #1######## de #2#######');
        finestra.UPDATE(2, Rec.COUNT);
        i := 0;
        if Rec.FINDSET THEN
            REPEAT
                i += 1;
                finestra.UPDATE(1, i);
                CASE wVer OF
                    wVer::Todos:
                        Rec.MARK(FALSE);
                    wVer::Defecto:
                        BEGIN
                            TotalesDocumentos(r36."Nº Proyecto", Rec."Document No.");
                            if (((ImpBorFac - ImpBorAbo) + (TotCont - TotImp)) > 0) THEN
                                Rec.MARK(TRUE)
                            ELSE
                                Rec.MARK(FALSE);
                        END;
                    wVer::Exceso:
                        BEGIN
                            TotalesDocumentos(r36."Nº Proyecto", Rec."Document No.");
                            if (((ImpBorFac - ImpBorAbo) + (TotCont - TotImp)) < 0) THEN
                                Rec.MARK(TRUE)
                            ELSE
                                Rec.MARK(FALSE);
                        END;
                END;
            UNTIL Rec.NEXT = 0;
        finestra.CLOSE;
        Rec.MARKEDONLY(TRUE);
        // $002+
    END;

    PROCEDURE MarcaRegistrosFE();
    BEGIN
        // $002-

        Rec.MARKEDONLY(FALSE);
        finestra.OPEN('Procesando #1######## de #2#######');
        finestra.UPDATE(2, Rec.COUNT);
        i := 0;
        if Rec.FINDSET THEN
            REPEAT
                i += 1;
                finestra.UPDATE(1, i);
                TotalesDocumentos(r36."Nº Proyecto", Rec."No.");
                if (((ImpBorFac - ImpBorAbo)) <> 0) THEN BEGIN
                    if CompruebaRecursos(r36."Nº Proyecto") THEN
                        Rec.MARK(TRUE)
                END ELSE
                    Rec.MARK(FALSE);
            UNTIL Rec.NEXT = 0;
        finestra.CLOSE;
        Rec.MARKEDONLY(TRUE);
        // $002+
    END;

    PROCEDURE CompruebaRecursos(pJob: Code[20]): Boolean;
    VAR
        LinProy: Record 1003;
        Reserva: Record Reserva;
        Recurso: Record 156;
        Produccion: Record "Produccines Relacionadas";
    BEGIN
        LinProy.SETRANGE(LinProy."Job No.", pJob);
        if LinProy.FINDFIRST THEN
            REPEAT
                if Recurso.GET(LinProy."No.") THEN BEGIN
                    if Recurso."Recurso Agrupado" THEN BEGIN
                        Reserva.SETRANGE(Reserva."Nº Proyecto", pJob);
                        Reserva.SETFILTER(Reserva."Recurso Agrupado", '%1', '');
                        if Reserva.FINDFIRST THEN EXIT(TRUE);
                    END;
                    if Recurso.Producción THEN BEGIN
                        Produccion.SETRANGE(Produccion."Line No.", LinProy."Line No.");
                        Produccion.SETRANGE(Produccion."Job No.", pJob);
                        if NOT Produccion.FINDFIRST THEN EXIT(TRUE);
                    END;
                END;
            UNTIL LinProy.NEXT = 0;
        EXIT(FALSE);
    END;

    /// <summary>
    /// MarcaRegistrosFCE.
    /// </summary>
    procedure MarcaRegistrosFCE()
    var
        r112: Record 112;
    Begin
        r112.SetRange("Posting Date", 20160101D, 20161231D);
        Rec.MarkedOnly(false);
        finestra.Open('Procesando #1######## de #2#######');
        finestra.Update(2, r112.Count);
        i := 0;
        if r112.FindSet() Then
            repeat
                i += 1;
                finestra.Update(1, i);
                if CompruebaRecursos(r112."Nº Proyecto") then begin
                    Rec.Get(Rec."Document Type"::Order, r112."Nº Contrato");
                    Rec.Mark(true);
                end else
                    Rec.Mark(false);
            Until r112.Next() = 0;
        finestra.Close();
        Rec.MarkedOnly(true);
    End;


    PROCEDURE CompruebaEstado(VAR r36: Record 36): Boolean;
    BEGIN
        // if wTipo6 = wTipo6::Todos THEN EXIT(TRUE);
        // if (wTipo1 = wTipo1::"Pendiente de Firma") AND (r36.Estado = r36.Estado::"Pendiente de Firma") THEN EXIT(TRUE);
        // if (wTipo2 = wTipo2::Firmado) AND (r36.Estado = r36.Estado::Firmado) THEN EXIT(TRUE);
        // if (wTipo3 = wTipo3::Anulado) AND (r36.Estado = r36.Estado::Anulado) THEN EXIT(TRUE);
        // if (wTipo4 = wTipo4::Cancelado) AND (r36.Estado = r36.Estado::Cancelado) THEN EXIT(TRUE);
        // if (wTipo5 = wTipo5::"Sin Montar") AND (r36.Estado = r36.Estado::"Sin Montar") THEN EXIT(TRUE);
        // EXIT(FALSE);
        // **********************************REVISAR**********************************************
    END;
    // BEGIN
    // {
    //   $001 MNC 290708 para migracion a 5.0, no tenemos fase, tenemos tarea
    // 02 MNC 170609 Campos total y diferencia
    //   $003 FCL 250510 Incluyo el campo fecha renovacion
    //                   Otros campos referentes a renovación
    //                   OBJETO DISTINTO AL DE MALLA
    //   $004 FCL-050710. Aplico filtros por vendedor definidos en la tabla de usuarios.
    //   $005 FCL 191010 Al buscar el proyecto original tengo en cuenta que puede haber dos, en este caso
    //                   cogeré aquel cuyo nº proyecto origen sea distinto a nº proyecto.
    // }
    // END.

}