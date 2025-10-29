/// <summary>
/// Page Comparativa Contratos (ID 50017).
/// </summary>
page 50017 "Comparativa Contratos"
{
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Sales Header";
    //TimerInterval=10;
    SourceTableView = SORTING("Document Type", "No.")
                    WHERE("Document Type" = CONST(Order));


    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Pendiente de Firma"; wtipopendiente)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                    Caption = 'Pendientes de firma';
                    trigger OnValidate()
                    Begin
                        if not wTipoPendiente then wTipoTodos := false;
                        Filtra;
                        Rec.SETRANGE("Fecha Estado");
                    END;
                }
                field("Firmado"; wTipoFirmado)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                    Caption = 'Firmados';
                    trigger OnValidate()
                    Begin
                        if not wTipoFirmado then wTipoTodos := false;
                        Filtra;

                    END;
                }
                field("Anulado"; wTipoAnulado)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                    Caption = 'Anulados';
                    trigger OnValidate()
                    Begin
                        if not wTipoAnulado then wTipoTodos := false;
                        Filtra;

                    END;
                }
                field("Cancelado"; wTipoCancelado)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                    Caption = 'Cancelados';
                    trigger OnValidate()
                    Begin
                        if not wTipoCancelado then wTipoTodos := false;
                        Filtra;

                    END;
                }
                field("Modificado"; wTipoModificado)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                    Caption = 'Modificados';
                    trigger OnValidate()
                    Begin
                        if not wTipoModificado then wTipoTodos := false;
                        Filtra;

                    END;
                }
                field("Sin Montar"; wTipoSinMontar)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                    Caption = 'Sin Montar';
                    trigger OnValidate()
                    Begin
                        if not wTipoSinMontar then wTipoTodos := false;
                        Filtra;

                    END;
                }
                field("Todos"; wTipoTodos)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                    Caption = 'Todos';
                    trigger OnValidate()
                    Begin
                        Filtra;

                    END;
                }
                field(Desde; Desde)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    BEGIN
                        Filtra;
                    END;
                }

                field("Solo Filtro Hasta"; Solh)
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
                field("Campo Diferencias"; wVerF)
                {
                    ApplicationArea = All;
                }
                field("Campo Diferencias2"; wVer)
                {
                    Caption = 'Campo Diferencias';
                    ApplicationArea = All;
                }

            }
            repeater(Detalle)
            {

                field("No."; Rec."No.") { ApplicationArea = All; }

                field("Sell-to Customer No."; Rec."Sell-to Customer No.") { ApplicationArea = All; }

                field("Sell-to Customer Name"; Rec."Sell-to Customer Name") { ApplicationArea = All; }

                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Amount; Rec.Amount) { ApplicationArea = All; Visible = false; }


                field("Amount Including VAT"; Rec."Amount Including VAT") { ApplicationArea = All; }


                field("Posting Description"; Rec."Posting Description") { ApplicationArea = All; }

                //                            CaptionML=ESP=Total Borr Fac;
                field("Total Borr Fac"; ImpBorFac)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    VAR
                        rCabVenta: Record 36;
                    BEGIN
                        rCabVenta.RESET;
                        rCabVenta.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
                        if Rec."Nº Proyecto" <> '' THEN
                            rCabVenta.SETRANGE("Nº Proyecto", Rec."Nº Proyecto");
                        rCabVenta.SETRANGE("Nº Contrato", Rec."No.");
                        rCabVenta.SETRANGE("Document Type", rCabVenta."Document Type"::Invoice);//,rCabVenta."Document Type"::"Credit Memo");
                        if rCabVenta.FIND('-') THEN Page.RUNMODAL(0, rCabVenta);
                    END;
                }

                //CaptionML=ESP=Total Borr Abo;
                field("Total Borr Abo"; ImpBorAbo)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    VAR
                        rCabVenta: Record 36;
                    BEGIN
                        rCabVenta.RESET;
                        rCabVenta.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
                        if Rec."Nº Proyecto" <> '' THEN
                            rCabVenta.SETRANGE("Nº Proyecto", Rec."Nº Proyecto");
                        rCabVenta.SETRANGE("Nº Contrato", Rec."No.");
                        rCabVenta.SETRANGE("Document Type", rCabVenta."Document Type"::"Credit Memo");
                        if rCabVenta.FIND('-') THEN Page.RUNMODAL(0, rCabVenta);
                    END;
                }

                //CaptionML=ESP=;
                field("Total Fac"; ImpFac)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    Begin
                        rCabFac.RESET;
                        rCabFac.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
                        rCabFac.SETRANGE("Nº Contrato", Rec."No.");
                        if rCabFac.FIND('-') THEN Page.RUNMODAL(0, rCabFac);
                    END;
                }

                //CaptionML=ESP=Total Abo;
                field("Total Abo"; ImpAbo)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    Begin
                        rCabAbo.RESET;
                        rCabAbo.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
                        rCabAbo.SETRANGE("Nº Contrato", Rec."No.");
                        if rCabAbo.FIND('-') THEN Page.RUNMODAL(0, rCabAbo);
                    END;
                }

                //CaptionML=ESP=Total Contrato;
                field("Total Contrato"; TotCont) { ApplicationArea = All; }

                //CaptionML=ESP=Diferencia;
                field("Diferencia"; (TotCont - TotImp)) { ApplicationArea = All; }

                //CaptionML=ESP=Total Fras-Abo;
                field("Total Fras-Abo"; TotImp) { ApplicationArea = All; }

                //CaptionML=ESP=Total Gasto;
                field("Total Gasto<"; ImpGasto)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    Var
                        r17: Record "G/L Entry";
                    BEGIN
                        r17.SETCURRENTKEY("G/L Account No.", "Job No.", "Posting Date");
                        r17.SETRANGE(r17."G/L Account No.", '6', '7');
                        r17.SETRANGE(r17."Job No.", Rec."Nº Proyecto");
                        if r17.FINDFIRST THEN Page.RUNMODAL(0, r17);
                    END;
                }

                //CaptionML=ESP=Total pedidos;
                field("Total pedidos"; ImpGastoA)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    Var
                        rCabventa: Record 38;
                    BEGIN
                        rCabventa.RESET;
                        rCabventa.SETCURRENTKEY("Nº Proyecto");
                        rCabventa.SETRANGE("Nº Proyecto", Rec."Nº Proyecto");
                        rCabventa.SETRANGE("Document Type", rCabventa."Document Type"::Order);
                        if rCabventa.FIND('-') THEN Page.RUNMODAL(0, rCabventa);
                    END;
                }
                //CaptionML=ESP=Total devoluciones;
                field("Total devoluciones"; ImpGastoD)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    Var
                        rCabventa: Record 38;
                    BEGIN
                        rCabventa.RESET;
                        rCabventa.SETCURRENTKEY("Nº Proyecto");
                        rCabventa.SETRANGE("Nº Proyecto", Rec."Nº Proyecto");
                        //rCabVenta.SETRANGE("Nº Contrato","No.");
                        rCabventa.SETRANGE("Document Type", rCabventa."Document Type"::"Return Order");
                        if rCabventa.FIND('-') THEN Page.RUNMODAL(0, rCabventa);
                    END;
                }
                field(Revisado; Rec.Revisado) { ApplicationArea = All; }
                field("Payment Method Code"; Rec."Payment Method Code") { ApplicationArea = All; }
                field("External Document No."; Rec."External Document No.") { ApplicationArea = All; }


                field("Sell-to Post Code"; Rec."Sell-to Post Code") { ApplicationArea = All; Visible = false; }

                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code") { ApplicationArea = All; Visible = false; }

                field("Sell-to Contact"; Rec."Sell-to Contact") { ApplicationArea = All; Visible = false; }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.") { ApplicationArea = All; }

                field("Bill-to Name"; Rec."Bill-to Name") { ApplicationArea = All; Visible = false; }

                field("Bill-to Post Code"; Rec."Bill-to Post Code") { ApplicationArea = All; Visible = false; }

                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code") { ApplicationArea = All; Visible = false; }

                field("Bill-to Contact"; Rec."Bill-to Contact") { ApplicationArea = All; Visible = false; }

                field("Ship-to Code"; Rec."Ship-to Code") { ApplicationArea = All; Visible = false; }

                field("Ship-to Name"; Rec."Ship-to Name") { ApplicationArea = All; Visible = false; }

                field("Ship-to Post Code"; Rec."Ship-to Post Code") { ApplicationArea = All; Visible = false; }

                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code") { ApplicationArea = All; Visible = false; }

                field("Ship-to Contact"; Rec."Ship-to Contact") { ApplicationArea = All; Visible = false; }

                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }

                field("Document Date"; Rec."Document Date") { ApplicationArea = All; }

                //CaptionML=ENU='Order Date;
                //           ESP=Fecha Contrato];
                field("Fecha Contrato"; Rec."Order Date") { ApplicationArea = All; }

                //CaptionML=ESP=Fecha Estado/Firma;
                field("Fecha Estado/Firma"; Rec."Fecha Estado") { ApplicationArea = All; }
                field("Fecha Vto."; Rec."Due Date") { ApplicationArea = All; }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code") { ApplicationArea = All; }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code") { ApplicationArea = All; }
                field("Cod cadena"; Rec."Cod cadena") { ApplicationArea = All; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
                field("Comentario Cabecera"; Rec."Comentario Cabecera") { ApplicationArea = All; }
                field("Assigned User ID"; Rec."Assigned User ID") { ApplicationArea = All; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; Visible = false; }
            }
            field("Nº Proyecto"; Rec."Nº Proyecto") { ApplicationArea = All; }
            field("Nº Contrato"; Rec."Nº Contrato") { ApplicationArea = All; }
            field("Fecha inicial proyecto"; Rec."Fecha inicial proyecto") { ApplicationArea = All; }
            field("Fecha fin proyecto"; Rec."Fecha fin proyecto") { ApplicationArea = All; }
            field(Estado; Rec.Estado) { ApplicationArea = All; }
            field("Fecha Estado"; Rec."Fecha Estado") { ApplicationArea = All; }
            field("Pte firma cliente"; Rec."Pte firma cliente") { ApplicationArea = All; }
            field(Renovado; Rec.Renovado) { ApplicationArea = All; }
            field("Interc./Compens."; Rec."Interc./Compens.") { ApplicationArea = All; Visible = false; }
            field("Proyecto origen"; Rec."Proyecto origen") { ApplicationArea = All; Visible = false; }
            field("Fecha inicial factura"; Rec."Fecha inicial factura") { ApplicationArea = All; }
            field("Fecha final factura"; Rec."Fecha final factura") { ApplicationArea = All; }
            field("Fecha renovacion"; Rec."Fecha renovacion") { ApplicationArea = All; }
            field("Fecha cancelacion"; Rec."Fecha cancelacion") { ApplicationArea = All; }

        }
    }
    actions
    {
        area(Processing)
        {
            group("&Línea")

            {
                action(Card)
                {
                    ShortCutKey = 'Mayús+F5';
                    Caption = 'Ficha';
                    ApplicationArea = All;
                    Image = Card;
                    trigger OnAction()
                    BEGIN
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::Quote:
                                Page.RUN(PAGE::"Sales Quote", Rec);
                            Rec."Document Type"::Order:
                                Page.RUN(PAGE::"Ficha Contrato Venta", Rec);
                            Rec."Document Type"::Invoice:
                                Page.RUN(PAGE::"Sales Invoice", Rec);
                            Rec."Document Type"::"Return Order":
                                Page.RUN(PAGE::"Sales Return Order", Rec);
                            Rec."Document Type"::"Credit Memo":
                                Page.RUN(PAGE::"Sales Credit Memo", Rec);
                            Rec."Document Type"::"Blanket Order":
                                Page.RUN(PAGE::"Blanket Sales Order", Rec);
                        END;
                    END;
                }
                Group("Di&ferencia")
                {
                    Caption = 'Di&ferencia';
                    action("Ver &Todos")
                    {
                        ApplicationArea = All;
                        Image = AllLines;
                        Caption = 'Ver &Todos';
                        trigger OnAction()
                        BEGIN
                            wVer := wVer::Todos;
                            MarcaRegistros;
                            Rec.MARKEDONLY(FALSE);
                        END;
                    }
                    action("Ver &Defecto Facturación")
                    {
                        ApplicationArea = All;
                        Image = Filter;
                        Caption = 'Ver &Defecto Facturación';
                        trigger OnAction()
                        BEGIN
                            wVer := wVer::Defecto;
                            MarcaRegistros;
                        END;
                    }
                    action("Ver &Exceso Facturación")
                    {
                        ApplicationArea = All;
                        Image = FilterLines;
                        Caption = 'Ver &Exceso Facturación';
                        trigger OnAction()
                        BEGIN
                            wVer := wVer::Exceso;
                            MarcaRegistros;
                        END;
                    }
                }
                group("Pendiente Facturación")
                {
                    Caption = 'Pendiente Facturación';
                    action("Ver &Todos.")
                    {
                        ApplicationArea = All;
                        Image = AllLines;
                        Caption = 'Ver &Todos';
                        trigger OnAction()
                        BEGIN
                            wVerF := wVerF::Todos;
                            MarcaRegistrosF;
                            Rec.MARKEDONLY(FALSE);
                        END;
                    }
                    action("Ver &Defecto Facturación.")
                    {
                        ApplicationArea = All;
                        Image = FilterLines;
                        Caption = 'Ver &Defecto Facturación';
                        trigger OnAction()
                        BEGIN
                            wVerF := wVerF::Defecto;
                            MarcaRegistrosF;
                        END;
                    }
                    action("Ver &Exceso Facturación.")
                    {
                        ApplicationArea = All;
                        Caption = 'Ver &Exceso Facturación';
                        trigger OnAction()
                        BEGIN
                            wVerF := wVerF::Exceso;
                            MarcaRegistrosF;
                        END;
                    }
                }
                action("Marcar como Revisado Los seleccionados")
                {
                    ShortCutKey = F11;
                    Caption = 'Marcar como Revisado Los seleccionados';
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
            }
        }
    }
    VAR
        Text016: Label 'No existe el usuario %1';
        Text017: Label 'No existe Parámetros Back Office para el Hotel %1';
        Text018: Label 'No existe el Libro Diario Producto en parámetros Back Office para el Hotel %1';
        Text019: Label 'No existe la Sección Consumos Diario en parámetros Back Office para el Hotel %1';
        Text020: Label 'MERMAS';
        Text021: Label 'ROTURAS';
        TotalSalesLine: Record 37;
        TotalSalesLineLCY: Record 37;
        rCabFac: Record 112;
        rCabAbo: Record 114;
        RegisVtas: Codeunit 80;
        wDecimal: Decimal;
        wTexto: Text[30];
        ImpBorFac: Decimal;
        ImpBorAbo: Decimal;
        ImpFac: Decimal;
        ImpAbo: Decimal;
        TotImp: Decimal;
        TotCont: Decimal;
        wVer: Option Todos,Defecto,Exceso;
        finestra: Dialog;
        i: Integer;
        wTipo: Option "Pendiente de Firma",Firmado,Anulado,Modificado,Cancelado,"Sin Montar",Todos;
        Desde: Date;
        Hasta: Date;
        "Contrato original": Code[20];
        "Contrato origen": Code[20];
        "Contrato renovado": Code[20];
        Solh: Boolean;
        Actualiza: Boolean;
        wVerF: Option Todos,Defecto,Exceso;
        ImpGasto: Decimal;
        Alb: Boolean;
        ImpGastoA: Decimal;
        TotalSalesLineC: Record 39;
        TotalSalesLineLCYC: Record 39;
        RegisVtasC: Codeunit 90;
        ImpGastoD: Decimal;
        r367: Record 367 TEMPORARY;
        wTipoPendiente: Boolean;
        wTipoModificado: Boolean;
        wTipoFirmado: Boolean;
        wTipoAnulado: Boolean;
        wTipoCancelado: Boolean;
        wTipoSinMontar: Boolean;
        wTipoTodos: Boolean;

    trigger OnOpenPage()
    BEGIN
        wTipo := wTipo::Todos;
        Filtra;

        AplicarFiltros;                                //$004
    END;

    trigger OnAfterGetRecord()
    BEGIN

        TotalesDocumentos(Rec."Nº Proyecto", Rec."No.");
        if (wVer <> wVer::Todos) THEN
            Rec.MARKEDONLY(TRUE)
        ELSE
            Rec.MARKEDONLY(FALSE);
    END;

    // OnTimer=BEGIN
    //           if Actualiza THEN BEGIN
    //            CurrPage.UPDATE(FALSE);
    //            Actualiza:=FALSE;
    //           END;
    //         END;

    PROCEDURE CalcularTotales(pNumDoc: Code[20])
    VAR
        TempSalesLine: Record 37 TEMPORARY;
    BEGIN

        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);

        if pNumDoc <> '' THEN BEGIN
            CLEAR(RegisVtas);
            CLEAR(TempSalesLine);
            RegisVtas.GetSalesLines(Rec, TempSalesLine, 0);
            CLEAR(RegisVtas);
            RegisVtas.SumSalesLinesTemp(
                Rec, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
                wDecimal, wTexto, wDecimal, wDecimal, wDecimal);
        END;
    END;

    PROCEDURE TotalesDocumentos(pNumProyecto: Code[20]; wNum: Code[20]);
    VAR
        TempSalesLine: Record 37 TEMPORARY;
        rCabVenta: Record 36;
        r17: Record "G/L Entry";
        rCabcompra: Record 38;
        TempSalesLineC: Record 39 TEMPORARY;
        rLinVenta: Record 37;
    BEGIN
        //$002 Obtengo totales de borradores y facturas correspondientes a este contrato.

        ImpBorFac := 0;
        ImpBorAbo := 0;
        ImpFac := 0;
        ImpAbo := 0;
        TotImp := 0;
        TotCont := 0;
        //Miro si ya están grabados
        if r367.GET(wNum) THEN BEGIN
            ImpBorFac := r367.IBF;
            ImpBorAbo := r367.IBA;
            ImpFac := r367."IF";
            ImpAbo := r367.IA;
            TotCont := r367.TC;
            TotImp := r367.TI;
            ImpGasto := r367.IG;
            ImpGastoA := r367.IP;
            ImpGastoD := r367.ID;
            EXIT;
        END;
        r367.Code := wNum;
        r367.INSERT;
        rCabVenta.RESET;
        rCabVenta.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
        if pNumProyecto <> '' THEN
            rCabVenta.SETRANGE("Nº Proyecto", pNumProyecto)
        ELSE
            rCabVenta.SETRANGE("Nº Contrato", wNum);
        rCabVenta.SETFILTER("Document Type", '%1|%2',
           rCabVenta."Document Type"::Invoice, rCabVenta."Document Type"::"Credit Memo");
        if rCabVenta.FIND('-') THEN BEGIN
            REPEAT
                CLEAR(TotalSalesLine);
                CLEAR(TotalSalesLineLCY);
                CLEAR(RegisVtas);
                CLEAR(TempSalesLine);
                RegisVtas.GetSalesLines(rCabVenta, TempSalesLine, 0);
                CLEAR(RegisVtas);
                RegisVtas.SumSalesLinesTemp(
                  rCabVenta, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
                  wDecimal, wTexto, wDecimal, wDecimal, wDecimal);
                if rCabVenta."Document Type" = rCabVenta."Document Type"::Invoice THEN
                    ImpBorFac := ImpBorFac + TotalSalesLineLCY.Amount
                ELSE
                    ImpBorAbo := ImpBorAbo + TotalSalesLineLCY.Amount;
            UNTIL rCabVenta.NEXT = 0;
        END;
        rCabFac.RESET;
        rCabFac.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
        rCabFac.SETRANGE("Nº Contrato", wNum);
        if rCabFac.FIND('-') THEN BEGIN
            REPEAT
                rCabFac.CALCFIELDS("Amount Including VAT", Amount);
                ImpFac := ImpFac + rCabFac.Amount;
            UNTIL rCabFac.NEXT = 0;
        END;
        rCabAbo.RESET;
        rCabAbo.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
        rCabAbo.SETRANGE("Nº Contrato", wNum);
        if rCabAbo.FIND('-') THEN BEGIN
            REPEAT
                rCabAbo.CALCFIELDS("Amount Including VAT", Amount);
                ImpAbo := ImpAbo + rCabAbo.Amount;
            UNTIL rCabAbo.NEXT = 0;
        END;

        //FCL-13/02/06. Incluyo sumatorio de totales y diferencia con el total del contrato.
        TotImp := ImpBorFac - ImpBorAbo + ImpFac - ImpAbo;

        if rCabVenta.GET(rCabVenta."Document Type"::Order, wNum) THEN BEGIN
            CLEAR(TotalSalesLine);
            CLEAR(TotalSalesLineLCY);
            CLEAR(RegisVtas);
            CLEAR(TempSalesLine);
            RegisVtas.GetSalesLines(rCabVenta, TempSalesLine, 0);
            CLEAR(RegisVtas);
            RegisVtas.SumSalesLinesTemp(rCabVenta, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
                                        wDecimal, wTexto, wDecimal, wDecimal, wDecimal);
            TotCont := TotalSalesLineLCY.Amount;
        END;
        ImpGasto := 0;
        ImpGastoD := 0;
        ImpGastoA := 0;

        if pNumProyecto <> '' THEN BEGIN
            r17.SETCURRENTKEY("G/L Account No.", "Job No.", "Posting Date");
            r17.SETRANGE(r17."G/L Account No.", '6', '7');
            r17.SETRANGE(r17."Job No.", Rec."Nº Proyecto");
            if r17.FINDFIRST THEN BEGIN
                r17.CALCSUMS(r17.Amount);
                ImpGasto := r17.Amount;
            END;
            rCabcompra.RESET;
            rCabcompra.SETCURRENTKEY("Nº Proyecto");
            rCabcompra.SETRANGE("Nº Proyecto", Rec."Nº Proyecto");
            if pNumProyecto = '' THEN
                rCabcompra.SETRANGE("Nº Contrato Venta", Rec."No.");
            rCabcompra.SETFILTER("Document Type", '%1|%2', rCabcompra."Document Type"::Order,
            rCabcompra."Document Type"::"Return Order");
            if rCabcompra.FIND('-') THEN
                REPEAT
                    CLEAR(TotalSalesLineC);
                    CLEAR(TotalSalesLineLCYC);
                    CLEAR(RegisVtasC);
                    CLEAR(TempSalesLineC);
                    RegisVtasC.GetPurchLines(rCabcompra, TempSalesLineC, 0);
                    CLEAR(RegisVtasC);
                    RegisVtasC.SumPurchLinesTemp(rCabcompra, TempSalesLineC, 0, TotalSalesLineC, TotalSalesLineLCYC,
                                                wDecimal, wTexto);//,wDecimal,wDecimal,wDecimal);
                    if rCabcompra."Document Type" = rCabcompra."Document Type"::Order THEN
                        ImpGastoA := TotalSalesLineLCYC.Amount
                    ELSE
                        ImpGastoD := TotalSalesLineLCYC.Amount;
                UNTIL rCabcompra.NEXT = 0;
        END;
        //Grabo los totales
        r367.IBF := ImpBorFac;
        r367.IBA := ImpBorAbo;
        r367."IF" := ImpFac;
        r367.IA := ImpAbo;
        r367.TC := TotCont;
        r367.TI := TotImp;
        r367.IG := ImpGasto;
        r367.IP := ImpGastoA;
        r367.ID := ImpGastoD;
        r367.MODIFY;
    END;

    PROCEDURE MarcaRegistros();
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
                CASE wVer OF
                    wVer::Todos:
                        Rec.MARK(FALSE);
                    wVer::Defecto:
                        BEGIN
                            TotalesDocumentos(Rec."Nº Proyecto", Rec."No.");
                            if ((TotCont - TotImp) > 0) THEN
                                Rec.MARK(TRUE)
                            ELSE
                                Rec.MARK(FALSE);
                        END;
                    wVer::Exceso:
                        BEGIN
                            TotalesDocumentos(Rec."Nº Proyecto", Rec."No.");
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
    var
        filtro: Text;
        filtro2: Text;
    BEGIN
        if Desde = 0D THEN Desde := 19000101D;
        if Hasta = 0D THEN Hasta := 29991231D;
        if Solh THEN
            Rec.SETRANGE("Fecha Estado", 0D, Hasta)
        ELSE
            Rec.SETRANGE("Fecha Estado", Desde, Hasta);
        Actualiza := TRUE;
        if wTipoTodos THEN begin
            Rec.SETRANGE(Estado);
            wTipoAnulado := true;
            wTipoModificado := true;
            wTipoCancelado := true;
            wTipoFirmado := true;
            wTipoPendiente := true;
            wTipoSinMontar := true;
            exit;
        end;
        // Combinaciones de todos los estados

        //Estados := '';
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado And wTipoFirmado And wTipoSinMontar Then begin
            wTipoTodos := true;
            Rec.SetRange(Estado);
            exit
        end;
        //Todas las combinaciones de estados
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado And wTipoFirmado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoFirmado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoModificado And wTipoFirmado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.EsTado::Modificado, Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoFirmado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoModificado And wTipoFirmado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoFirmado And wTipoCancelado And wTipoModificado And wTipoAnulado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::Firmado, Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoFirmado And wTipoModificado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Firmado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoSinMontar And wTipoModificado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::"Sin Montar", Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::"Sin Montar", Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoFirmado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoFirmado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoFirmado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoModificado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoFirmado And wTipoModificado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoFirmado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoFirmado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoFirmado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoModificado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoFirmado And wTipoModificado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoFirmado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoFirmado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoFirmado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoModificado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoFirmado And wTipoModificado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoFirmado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoFirmado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado And wTipoFirmado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5|%6', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado And wTipoFirmado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoFirmado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoModificado And wTipoFirmado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.EsTado::Modificado, Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoFirmado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoModificado And wTipoFirmado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoFirmado And wTipoCancelado And wTipoModificado And wTipoAnulado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::Firmado, Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoFirmado And wTipoModificado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Firmado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoSinMontar And wTipoModificado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::"Sin Montar", Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::"Sin Montar", Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoFirmado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoFirmado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoFirmado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoModificado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoFirmado And wTipoModificado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoFirmado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoFirmado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado And wTipoFirmado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5|%6', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;



        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado And wTipoFirmado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoFirmado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoModificado And wTipoFirmado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.EsTado::Modificado, Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoFirmado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoModificado And wTipoFirmado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoFirmado And wTipoCancelado And wTipoModificado And wTipoAnulado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4|%5', Rec.Estado::Firmado, Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoCancelado And wTipoModificado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoFirmado And wTipoModificado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::Firmado, Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoSinMontar And wTipoModificado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::"Sin Montar", Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoAnulado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3|%4', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado, Rec.Estado::"Sin Montar", Rec.Estado::Modificado);
            exit
        end;
        if wTipoPendiente And wTipoFirmado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoSinMontar Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado, Rec.Estado::"Sin Montar");
            exit
        end;
        if wTipoPendiente And wTipoCancelado And wTipoFirmado Then begin

            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado, Rec.Estado::Cancelado);
            exit
        end;
        if wTipoAnulado And wTipoCancelado And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::Anulado, Rec.Estado::Cancelado, Rec.Estado::"Sin Montar");
            exit
        end;
        if (wTipoAnulado) And (wTipoFirmado) And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::Anulado, Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if (wTipoAnulado) And (wTipoFirmado) And wTipoCancelado Then begin
            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::Anulado, Rec.Estado::Firmado, Rec.Estado::Cancelado);
            exit
        end;
        if (wTipoCancelado) And (wTipoFirmado) And wTipoSinMontar Then begin
            Rec.SetFilter(Estado, '%1|%2|%3', Rec.Estado::Cancelado, Rec.Estado::Firmado, Rec.Estado::"Sin Montar");
            exit
        end;
        if (wTipoPendiente) And (wTipoAnulado) Then begin
            Rec.SetFilter(Estado, '%1|%2', Rec.Estado::"Pendiente de Firma", Rec.Estado::Anulado);
            exit
        end;
        if (wTipoPendiente) And (wTipoCancelado) Then begin
            Rec.SetFilter(Estado, '%1|%2', Rec.Estado::"Pendiente de Firma", Rec.Estado::Cancelado);
            exit
        end;
        if (wTipoPendiente) And (wTipoFirmado) Then begin
            Rec.SetFilter(Estado, '%1|%2', Rec.Estado::"Pendiente de Firma", Rec.Estado::Firmado);
            exit
        end;
        if (wTipoPendiente) And (wTipoSinMontar) Then begin
            Rec.SetFilter(Estado, '%1|%2', Rec.Estado::"Pendiente de Firma", Rec.Estado::"Sin Montar");
            exit
        end;
        if (wTipoAnulado) And (wTipoCancelado) Then begin
            Rec.SetFilter(Estado, '%1|%2', Rec.Estado::Anulado, Rec.Estado::Cancelado);
            exit
        end;
        if (wTipoAnulado) And (wTipoFirmado) Then begin
            Rec.SetFilter(Estado, '%1|%2', Rec.Estado::Anulado, Rec.Estado::Firmado);
            exit
        end;
        if (wTipoAnulado) And (wTipoSinMontar) Then begin
            Rec.SetFilter(Estado, '%1|%2', Rec.Estado::Anulado, Rec.Estado::"Sin Montar");
            exit
        end;
        if (wTipoCancelado) And (wTipoFirmado) Then begin
            Rec.SetFilter(Estado, '%1|%2', Rec.Estado::Cancelado, Rec.Estado::Firmado);
            exit
        end;
        if (wTipoCancelado) And (wTipoSinMontar) Then begin
            Rec.SetFilter(Estado, '%1|%2', Rec.Estado::Cancelado, Rec.Estado::"Sin Montar");
            exit
        end;
        if (wTipoSinMontar) And (wTipoFirmado) Then begin
            Rec.SetFilter(Estado, '%1|%2', Rec.Estado::"Sin Montar", Rec.Estado::Firmado);
            exit
        end;
        if wTipoPendiente then Rec.SetRange(Estado, Rec.Estado::"Pendiente de Firma");
        if wTipoPendiente then Rec.SetRange(Estado, Rec.Estado::"Pendiente de Firma");
        if wTipoFirmado then Rec.SetRange(Estado, Rec.Estado::Firmado);
        if wTipoAnulado then Rec.SetRange(Estado, Rec.Estado::Anulado);
        If wtipoModificado then Rec.SetRange(Estado, Rec.Estado::Modificado);
        if wTipoCancelado then Rec.SetRange(Estado, Rec.Estado::Cancelado);
        if wTipoSinMontar then Rec.SetRange(Estado, Rec.Estado::"Sin Montar");
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

        if rProyecto.GET(Rec."Nº Proyecto") THEN BEGIN
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
            rProyecto.SETRANGE("Proyecto origen", Rec."Nº Proyecto");
            wCuantos := rProyecto.COUNT;
            //$005(F)
            rProyecto.RESET;
            rProyecto.SETCURRENTKEY("Proyecto origen");
            rProyecto.SETRANGE("Proyecto origen", Rec."Nº Proyecto");
            //$005(I)
            if wCuantos > 0 THEN
                rProyecto.SETFILTER("No.", '<>%1', Rec."Nº Proyecto");
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
        if rUsuario.GET(USERID) THEN BEGIN
            if rUsuario."Filtro vendedor" <> '' THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETFILTER("Salesperson Code", rUsuario."Filtro vendedor");
                Rec.FILTERGROUP(0);
            END;
            if rUsuario."Filtro departamento" <> '' THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETFILTER("Shortcut Dimension 1 Code", rUsuario."Filtro departamento");
                Rec.FILTERGROUP(0);
            END;

        END;
    END;

    PROCEDURE MarcaRegistrosF();
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
                CASE wVer OF
                    wVer::Todos:
                        Rec.MARK(FALSE);
                    wVer::Defecto:
                        BEGIN
                            TotalesDocumentos(Rec."Nº Proyecto", Rec."No.");
                            if (((ImpBorFac - ImpBorAbo) + (TotCont - TotImp)) > 0) THEN
                                Rec.MARK(TRUE)
                            ELSE
                                Rec.MARK(FALSE);
                        END;
                    wVer::Exceso:
                        BEGIN
                            TotalesDocumentos(Rec."Nº Proyecto", Rec."No.");
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

}
