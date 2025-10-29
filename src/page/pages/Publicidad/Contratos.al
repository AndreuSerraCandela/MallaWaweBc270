/// <summary>
/// Page Lista Contratos Venta (ID 50011).
/// </summary>
page 50011 "Lista Contratos Venta"
{

    Caption = 'Contratos';
    PageType = List;
    SourceTable = "Sales Header";
    CardPageId = "Ficha Contrato Venta";
    UsageCategory = Lists;
    ApplicationArea = Basic, Suite, Assembly;
    SourceTableView = sorting("Document Type", "No.") where("Document Type" = Const(Order));
    layout
    {
        area(content)
        {

            repeater(Detalle)
            {
                field("No."; Rec."No.") { ApplicationArea = ALL; }
                field(Año; Format(Rec."Fecha Estado", 0, '<Year4>')) { ApplicationArea = All; }
                field(Mes; Format(Rec."Fecha Estado", 0, '<Month Text>')) { ApplicationArea = All; }
                field(Semana; Format(Rec."Fecha Estado", 0, '<Week>')) { ApplicationArea = All; }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.") { ApplicationArea = ALL; }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name") { ApplicationArea = ALL; }
                field("VAT Registration No."; Rec."VAT Registration No.") { ApplicationArea = ALL; }
                field(Amount; Amount) { ApplicationArea = ALL; }
                field("Amount Including VAT"; "Amount Including VAT") { ApplicationArea = ALL; }
                field("Posting Description"; Rec."Posting Description") { ApplicationArea = ALL; }
                field("Nombre Comercial"; Rec."Nombre Comercial") { ApplicationArea = All; Caption = 'Anunciante'; }
                field(Estado; Rec.Estado) { ApplicationArea = ALL; StyleExpr = StatusStyleTxt; }
                field(TipoLogia; ProcedureTipologia()) { ApplicationArea = All; }
                field(Empresa; ProcedureEmpresa()) { ApplicationArea = All; }
                field("Borradores de Factura"; "Borradores de Factura") { ApplicationArea = ALL; }
                field("Borradores de Abono"; "Borradores de Abono") { ApplicationArea = ALL; }
                field("Facturas Registradas"; "Facturas Registradas") { ApplicationArea = ALL; }
                field("Abonos Registrados"; "Abonos Registrados") { ApplicationArea = ALL; }
                field("Albaranes Registrados"; "Albaranes Registrados") { ApplicationArea = ALL; }
                field(ImpBorFac; ImpBorFac)

                {
                    ApplicationArea = ALL;
                    Caption = 'Total Borr Fac';
                }
                field(ImpBorAbo; ImpBorAbo)

                {
                    ApplicationArea = ALL;
                    Caption = 'Total Borr Abo';
                }
                field(ImpFac; ImpFac)

                {
                    ApplicationArea = ALL;
                    Caption = 'Total Fac';
                }
                field(ImpAbo; ImpAbo)
                {
                    ApplicationArea = ALL;
                    Caption = 'Total Abo';
                }
                field(TotCont; TotCont)
                {
                    ApplicationArea = ALL;
                    Caption = 'Total Contrato';
                }
                field(Diferencia; TotCont - TotImp)
                {
                    ApplicationArea = ALL;
                    Caption = 'Diferencia';
                }
                field(TotImp; TotImp)
                {
                    ApplicationArea = ALL;
                    Caption = 'Total Fras-Abo';
                }
                field(Revisado; Rec.Revisado) { ApplicationArea = ALL; }
                field("Payment Method Code"; Rec."Payment Method Code") { ApplicationArea = ALL; }
                field("Nuestra Cuenta Transf."; Rec."Nuestra Cuenta")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ShowMandatory = true;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        r270: Record 270;
                    begin
                        r270.SETRANGE("Banco para Transf. Clientes", TRUE);
                        if Page.RUNMODAL(0, r270) = ACTION::LookupOK THEN BEGIN
                            Rec."Nuestra Cuenta" := r270."No.";
                            OnAfterLookupNuestraCuenta(Rec, r270);
                            Rec."B2R Bank Payment Code" := Rec."Nuestra Cuenta";

                        END;

                    end;


                }
                field("External Document No."; Rec."External Document No.") { ApplicationArea = ALL; }
                field("Sell-to Post Code"; Rec."Sell-to Post Code") { ApplicationArea = ALL; }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code") { ApplicationArea = ALL; }
                field("Sell-to Contact"; Rec."Sell-to Contact") { ApplicationArea = ALL; }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.") { ApplicationArea = ALL; }
                field("Bill-to Name"; Rec."Bill-to Name") { ApplicationArea = ALL; }
                field("Bill-to Post Code"; Rec."Bill-to Post Code") { ApplicationArea = ALL; }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code") { ApplicationArea = ALL; }
                field("Bill-to Contact"; Rec."Bill-to Contact") { ApplicationArea = ALL; }
                field("Ship-to Code"; Rec."Ship-to Code") { ApplicationArea = ALL; }
                field("Ship-to Name"; Rec."Ship-to Name") { ApplicationArea = ALL; }
                field("Ship-to Post Code"; Rec."Ship-to Post Code") { ApplicationArea = ALL; }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code") { ApplicationArea = ALL; }
                field("Ship-to Contact"; Rec."Ship-to Contact") { ApplicationArea = ALL; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = ALL; }
                field("Document Date"; Rec."Document Date") { ApplicationArea = ALL; }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = ALL;
                    Caption = 'Fecha Contrato';
                }
                field("Fecha Estado"; Rec."Fecha Estado")
                {
                    ApplicationArea = ALL;
                    Caption = 'Fecha Estado/Firma';
                }
                field("Due Date"; Rec."Due Date") { ApplicationArea = ALL; }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code") { ApplicationArea = ALL; }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code") { ApplicationArea = ALL; }
                field("Cod cadena"; Rec."Cod cadena") { ApplicationArea = ALL; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = ALL; }
                field("Nombre Vendedor"; Vendedor(Rec."Salesperson Code")) { ApplicationArea = All; }
                field("Comentario Cabecera"; Rec."Comentario Cabecera") { ApplicationArea = ALL; }
                field("Assigned User ID"; Rec."Assigned User ID") { ApplicationArea = ALL; }
                field("Currency Code"; Rec."Currency Code") { Visible = false; ApplicationArea = ALL; }
                field("Nº Proyecto"; Rec."Nº Proyecto") { ApplicationArea = ALL; }
                field("Nº Contrato"; Rec."Nº Contrato") { ApplicationArea = ALL; }
                field("Fecha inicial proyecto"; Rec."Fecha inicial proyecto") { ApplicationArea = ALL; }
                field("Fecha fin proyecto"; Rec."Fecha fin proyecto") { ApplicationArea = ALL; }

                //field("Fecha Estado";Rec."Fecha Estado"){}
                field("Pte firma cliente"; Rec."Pte firma cliente") { ApplicationArea = ALL; }
                // field(AmountLines; TotalSalesLine.Amount)
                // {
                //     ApplicationArea = ALL;
                //     Caption = 'Importe (calc.)';
                // }
                // field(AmountInclLines; TotalSalesLine."Amount Including VAT")
                // {
                //     ApplicationArea = ALL;
                //     Caption = 'Importe IVA incl. (calc.)';
                //     Visible = false;
                // }
                // field("Imp. IVA. incl."; Rec."Imp. IVA. incl.") { ApplicationArea = ALL; }
                field(Renovado; Rec.Renovado) { ApplicationArea = ALL; }
                field("Proyecto origen"; Rec."Proyecto origen") { ApplicationArea = ALL; }
                field("Interc./Compens."; Rec."Interc./Compens.") { ApplicationArea = ALL; }
                field("Fecha inicial factura"; Rec."Fecha inicial factura") { ApplicationArea = ALL; }
                field("Fecha final factura"; Rec."Fecha final factura") { ApplicationArea = ALL; }
                field("Contrato Renovable ?"; not Rec."Contrato no Renovable")
                {
                    ApplicationArea = ALL;
                    Caption = 'Contrato Renovable ?';


                }
                field("Fecha renovacion"; Rec."Fecha renovacion") { ApplicationArea = ALL; }
                Field("Contrato original"; Rec."Contrato original") { ApplicationArea = ALL; }
                field("Contrato origen"; Rec."Contrato origen") { ApplicationArea = ALL; }
                field("Contrato renovado"; Rec."Contrato renovado") { ApplicationArea = ALL; }
                field("Fecha cancelacion"; Rec."Fecha cancelacion") { ApplicationArea = ALL; }
            }
            // usercontrol(MyTimer; MyTimer)
            // {
            //     ApplicationArea = Basic;

            //     trigger TimerElapsed()
            //     begin

            //         if Actualiza THEN BEGIN
            //             CurrPage.MyTimer.StopTimer();
            //             CurrPage.UPDATE(FALSE);
            //             Actualiza := FALSE;
            //         END;
            //         CurrPage.MyTimer.StartTimer();
            //     end;
            // }

        }
    }
    actions
    {
        area(Processing)
        {
            action(Ficha)
            {
                ShortCutKey = "Mayús+F5";
                ApplicationArea = ALL;
                Caption = 'Ficha';
                Image = Card;
                trigger OnAction()
                begin
                    CASE Rec."Document Type" OF
                        Rec."Document Type"::Quote:
                            Page.RUN(Page::"Sales Quote", Rec);
                        Rec."Document Type"::Order:
                            Page.RUN(Page::"Ficha Contrato venta", Rec);
                        Rec."Document Type"::Invoice:
                            Page.RUN(Page::"Sales Invoice", Rec);
                        Rec."Document Type"::"Return Order":
                            Page.RUN(Page::"Sales Return Order", Rec);
                        Rec."Document Type"::"Credit Memo":
                            Page.RUN(Page::"Sales Credit Memo", Rec);
                        Rec."Document Type"::"Blanket Order":
                            Page.RUN(Page::"Blanket Sales Order", Rec);
                    END;
                END;
            }

            group(Diferencias)
            {
                Image = CalculateBalanceAccount;
                action("Calcular Totales")
                {
                    ApplicationArea = ALL;
                    Image = CalculateBalanceAccount;
                    trigger OnAction()
                    begin
                        CalcTot := TRUE;
                        CurrPage.Update(false);
                    end;
                }

                action("Ver Todos")
                {
                    ApplicationArea = ALL;
                    Caption = 'Ver &Todos';
                    Image = RemoveFilterLines;
                    trigger OnAction()
                    BEGIN
                        wVer := wVer::Todos;
                        MarcaRegistros;
                        Rec.MARKEDONLY(FALSE);
                    END;
                }
                action("Ver &Defecto Facturación")
                {
                    ApplicationArea = ALL;
                    Image = Filter;
                    Caption = 'Ver &Defecto Facturación';
                    trigger OnAction()
                    Begin
                        wVer := wVer::Defecto;
                        MarcaRegistros;
                    END;
                }
                action("Ver &Exceso Facturación")
                {
                    ApplicationArea = ALL;
                    Image = Filter;
                    Caption = 'Ver &Exceso Facturación';
                    trigger OnAction()
                    Begin
                        wVer := wVer::Exceso;
                        MarcaRegistros;
                    END;
                }
            }
            group("Pendiente Facturación")
            {
                Image = CoupledInvoice;
                action("Ver &Todos")
                {
                    ApplicationArea = ALL;
                    Image = ClearFilter;
                    Caption = 'Ver &Todos';
                    trigger OnAction()
                    Begin
                        wVerF := wVerF::Todos;
                        MarcaRegistrosF;
                        Rec.MARKEDONLY(FALSE);
                    END;
                }
                action("Ver Defecto &Facturación")
                {
                    ApplicationArea = ALL;
                    Image = FilterLines;
                    Caption = 'Ver &Defecto Facturación';
                    trigger OnAction()
                    Begin
                        wVerF := wVerF::Defecto;
                        MarcaRegistrosF;
                    END;
                }
                action("Ver E&xceso Facturación")
                {
                    ApplicationArea = ALL;
                    Image = Filter;
                    Caption = 'Ver &Exceso Facturación';
                    trigger OnAction()
                    Begin
                        wVerF := wVerF::Exceso;
                        MarcaRegistrosF;
                    END;
                }
            }
            group(Informes)
            {
                Image = Report;
                action("Carta Bancaria B2B")
                {
                    ApplicationArea = All;
                    Image = Document;
                    trigger OnAction()
                    var
                        Contrato: Record 36;
                    begin
                        Contrato.SetRange("No.", Rec."No.");
                        Contrato.SetRange("Document Type", Rec."Document Type");
                        if Contrato.FindFirst() Then
                            Report.RunModal(Report::"Carta Bancaria B2b", true, true, Contrato);
                    end;
                }
                action("Carta Bancaria Core")
                {
                    ApplicationArea = All;
                    Image = Document;
                    trigger OnAction()
                    var
                        Contrato: Record 36;
                    begin
                        Contrato.SetRange("No.", Rec."No.");
                        Contrato.SetRange("Document Type", Rec."Document Type");
                        if Contrato.FindFirst() Then
                            Report.RunModal(Report::"Carta Bancaria", true, true, Contrato);
                    end;
                }

            }
            action("Marcar Para Enviar a medios")
            {
                ShortCutKey = F11;
                Image = PostSendTo;
                ApplicationArea = ALL;
                Caption = 'Marcar Para Enviar a medios';
                trigger OnAction()
                VAR
                    rContratos: Record 36;
                BEGIN
                    CurrPage.SETSELECTIONFILTER(rContratos);
                    if rContratos.FINDFIRST THEN
                        REPEAT
                            rContratos."Enviar a medios" := NOT rContratos."Enviar a medios";
                            rContratos.MODIFY;
                        UNTIL rContratos.NEXT = 0;
                END;
            }
            action("Marcar para enviar a admininistración")
            {
                ShortCutKey = F10;
                Image = PostSendTo;
                ApplicationArea = ALL;
                Caption = 'Marcar para enviar a admininistración';
                trigger OnAction()
                VAR
                    rContratos: Record 36;
                BEGIN
                    CurrPage.SETSELECTIONFILTER(rContratos);
                    if rContratos.FINDFIRST THEN
                        REPEAT
                            rContratos."Enviar a administración" := NOT rContratos."Enviar a administración";
                            rContratos.MODIFY;
                        UNTIL rContratos.NEXT = 0;
                END;
            }
            action("Enviar a dirección")
            {
                ShortCutKey = F10;
                Image = PostSendTo;
                ApplicationArea = ALL;
                Caption = 'Enviar a dirección';
                trigger OnAction()
                VAR
                    rContratos: Record 36;
                BEGIN
                    CurrPage.SETSELECTIONFILTER(rContratos);
                    if rContratos.FINDFIRST THEN
                        REPEAT
                            rContratos."Enviado a dirección" := NOT rContratos."Enviado a Dirección";
                            rContratos.MODIFY;
                        UNTIL rContratos.NEXT = 0;
                END;
            }
            action("Enviar a Renovar")
            {

                Image = PostSendTo;
                ApplicationArea = ALL;
                Caption = 'Marcar Para Renovar';
                trigger OnAction()
                VAR
                    rContratos: Record 36;
                BEGIN
                    CurrPage.SETSELECTIONFILTER(rContratos);
                    if rContratos.FINDFIRST THEN
                        REPEAT
                            rContratos."Enviado a dirección" := NOT rContratos."Enviado a Dirección";
                            rContratos."Marcar Para Renovar" := Not rContratos."Marcar Para Renovar";
                            rContratos.MODIFY;
                        UNTIL rContratos.NEXT = 0;
                END;

            }
            action("Enviar a medios")
            {
                ApplicationArea = ALL;
                Image = SendTo;
                Caption = 'Enviar a medios';

            }
            action("Enviar a Admon")
            {
                ApplicationArea = ALL;
                Image = SendTo;

            }
            action("Marcar Ok Admon")
            {
                //ShortCutKey = F11;
                Image = AddWatch;
                ApplicationArea = ALL;
                Caption = 'Marcar Ok Administración los seleccionados';
                trigger OnAction()
                VAR
                    rContratos: Record 36;
                BEGIN
                    CurrPage.SETSELECTIONFILTER(rContratos);
                    if rContratos.FINDFIRST THEN
                        REPEAT
                            rContratos."Ok Admon" := NOT rContratos."Ok Admon";
                            rContratos.MODIFY;
                        UNTIL rContratos.NEXT = 0;
                END;
            }
            action("Marcar como revisado")
            {
                //ShortCutKey = F11;
                Image = AddWatch;
                ApplicationArea = ALL;
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
            action("Busca contratos con errores")
            {
                Caption = 'Busca Contratos con errores';
                Image = ErrorLog;
                ApplicationArea = ALL;
                trigger OnAction()
                VAR
                    r36: Record 36;
                BEGIN

                    wVer := wVer::Defecto;
                    MarcaRegistrosFE;
                END;
            }
            action("Busca Contratos con errores Fac 16")
            {
                Caption = 'Busca Contratos con errores Fac 16';
                Image = Error;
                ApplicationArea = ALL;
                trigger OnAction()
                Begin
                    wVer := wVer::Defecto;
                    MarcaRegistrosFCE;
                END;
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
            action("Marcar Para Listado")
            {
                ApplicationArea = ALL;
                Image = MakeOrder;
                trigger OnAction()
                var
                    Customer: Record Customer;
                    Listado: Record 36;
                    TipoRecursos: Record "Tipo Recurso";
                    Lineas: Record 37;
                    Res: Record Resource;
                    Listadot: Record 36 temporary;
                begin
                    Page.RunModal(0, Customer);
                    Commit;
                    Customer.SetRange(Listado, true);
                    CurrPage.SetSelectionFilter(Listado);
                    if Listado.FindFirst() then
                        repeat
                            if Customer.get(Listado."Sell-to Customer No.") then
                                if Customer.Listado then begin
                                    Listado."Marcar Para Listado" := true;
                                    Listado.Modify;
                                end;
                        until Listado.Next() = 0;
                    if Confirm('Quiere un tipo de recurso?') then begin
                        if Page.RunModal(0, TipoRecursos) = Action::LookupOK Then begin
                            if Listado.FindSet() then
                                repeat
                                    Lineas.SetRange("No.", Listado."No.");
                                    Lineas.SetRange("Document Type", Listado."Document Type");
                                    if Lineas.FindFirst() then
                                        repeat
                                            if Res.Get(Lineas."No.") then begin
                                                if Res."Tipo Recurso" = TipoRecursos.Tipo Then begin
                                                    Listadot := Listado;
                                                    if Listadot.Insert then;
                                                    Lineas.FindLast();
                                                end;

                                            end;
                                        until Lineas.Next() = 0;
                                until Listado.Next() = 0;
                            Listado.ModifyAll("Marcar Para Listado", false);
                            Listado.Reset();
                            if Listadot.FindSet() then
                                repeat
                                    Listadot.Get(Listadot."Document Type", Listadot."No.");
                                    Listado."Marcar Para Listado" := true;
                                    Listado.Modify;
                                until Listadot.Next() = 0;
                        end;
                    end;
                    Commit();
                    Rec.SetRange("Marcar Para Listado", true);
                    CurrPage.Update(false);
                end;
            }
        }
        area(Promoted)
        {
            actionref("Calcula_Totales_ref"; "Calcular Totales") { }
            actionref("Carta Bancaria B2B_ref"; "Carta Bancaria B2B") { }
        }
    }

    VAR
        TotalSalesLine: Record 37;
        TotalSalesLineLCY: Record 37;
        rCabFac: Record 112;
        rCabAbo: Record 114;
        RegisVtas: Codeunit "Sales-Post";
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
        wTipoPendiente: Boolean;
        wTipoFirmado: Boolean;
        wTipoAnulado: Boolean;
        wTipoModificado: Boolean;
        wTipoCancelado: Boolean;
        wTipoSinMontar: Boolean;
        wTipoTodos: Boolean;

        Desde: Date;
        Hasta: Date;
        // "Contrato original": Code[20];
        // "Contrato origen": Code[20];
        // "Contrato renovado": Code[20];
        Solh: Boolean;
        Actualiza: Boolean;
        StatusStyleTxt: Text[30];
        CalcTot: Boolean;
        "Albaranes Registrados": Integer;
        "Abonos Registrados": Integer;
        "Facturas Registradas": Integer;
        "Borradores de Abono": Integer;
        "Borradores de Factura": Integer;
        Amount: Decimal;
        rInf: Record "Company Information";
        "Amount Including VAT": Decimal;
        wVerF: Option Todos,Defecto,Exceso;

    trigger OnOpenPage()
    begin
        CalcTot := FALSE;
        rInf.Get();
        //Filtra;
    end;

    trigger OnAfterGetRecord()
    begin

        TotalesDocumentos(Rec."Nº Proyecto", Rec."No.");
        if (wVer <> wVer::Todos) THEN
            Rec.MARKEDONLY(TRUE)
        ELSE
            Rec.MARKEDONLY(FALSE);
        // $002+

        // BuscarProyectos;
        //StatusStyleTxt Según estado                  //$003
        case Rec.Estado of
            Rec.Estado::"Pendiente de Firma":
                StatusStyleTxt := 'Unfavorable';
            Rec.Estado::Firmado:
                StatusStyleTxt := 'Strong';
            Rec.Estado::Anulado:
                StatusStyleTxt := 'Ambiguous';
            Rec.Estado::Modificado:
                StatusStyleTxt := 'StrongAccent';
            Rec.Estado::Cancelado:
                StatusStyleTxt := 'StandardAccent';
            Rec.Estado::"Sin Montar":
                StatusStyleTxt := 'Favorable';
        end;
    end;

    Procedure CambiarEmpresa(wEmpresa: Text)
    begin
        Rec.ChangeCompany(wEmpresa);
        rInf.ChangeCompany(wEmpresa);
        rInf.Get();
    end;
    /// <summary>
    /// ProcedureEmpresa.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure ProcedureEmpresa(): Text
    var

    begin

        Exit(rInf.Name);
    end;
    /// <summary>
    /// Tipologia.
    /// </summary>
    /// <returns>Return value of type Option Nacional,Local,Intercambio.</returns>
    procedure ProcedureTipologia() T: Option Nacional,Local,Intercambio
    begin
        if Rec."Payment Method Code" = 'INTERCAMBIO' Then exit(T::Intercambio);
        if (Copystr(Rec."Bill-to Post Code", 1, 2) = '07') Or ((Copystr(Rec."Sell-to Post Code", 1, 2) = '07')) Then exit(T::Local);
        exit(T::Nacional);
    end;

    // PROCEDURE CalcularTotales(pNumDoc: Code[20]);
    // VAR
    //     TempSalesLine: Record 37 temporary;
    // BEGIN
    //     //FCL-04/05/04. Obtengo total y total iva incluído, ya no me sirve el campo calculado
    //     // porque estos importes están a cero en las líneas.
    //     // JML 150704 Modificado para poder filtrar por fase.
    //     // $001 por tarea

    //     CLEAR(TotalSalesLine);
    //     CLEAR(TotalSalesLineLCY);

    //     if pNumDoc <> '' THEN BEGIN
    //         CLEAR(RegisVtas);
    //         CLEAR(TempSalesLine);
    //         RegisVtas.GetSalesLines(Rec, TempSalesLine, 0);
    //         CLEAR(RegisVtas);

    //         RegisVtas.SumSalesLinesTemp(
    //           Rec, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
    //           wDecimal, wTexto, wDecimal, wDecimal, wDecimal);

    //         //  JML 150704
    //         //  RegisVtas.SumSalesLinesTempFase(Rec,TempSalesLine,0,TotalSalesLine,
    //         //                              TotalSalesLineLCY, GETFILTER("Filtro fase"));

    //     END;
    // END;

    PROCEDURE TotalesDocumentos(wNumProyecto: Code[20]; wNum: Code[20]);
    VAR
        TempSalesLine: Record 37 temporary;
        rCabVenta: Record 36;
    BEGIN
        //$002 Obtengo totales de borradores y facturas correspondientes a este contrato.
        if CalcTot = False then exit;
        ImpBorFac := 0;
        ImpBorAbo := 0;
        ImpFac := 0;
        ImpAbo := 0;
        TotImp := 0;
        TotCont := 0;

        Rec.CALCFIELDS("Borradores de Factura", "Borradores de Abono",
                   "Facturas Registradas", "Abonos Registrados", "Albaranes Registrados", Amount, "Amount Including VAT");
        Amount := Rec.Amount;
        "Amount Including VAT" := Rec."Amount Including VAT";
        "Borradores de Abono" := Rec."Borradores de Abono";
        "Borradores de Factura" := Rec."Borradores de Factura";
        "Facturas Registradas" := Rec."Facturas Registradas";
        "Abonos Registrados" := Rec."Abonos Registrados";
        "Albaranes Registrados" := Rec."Albaranes Registrados";
        if (Rec."Borradores de Factura" <> 0) OR (Rec."Borradores de Abono" <> 0) THEN BEGIN

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
                    RegisVtas.GetSalesLines(rCabVenta, TempSalesLine, 0);
                    CLEAR(RegisVtas);
                    RegisVtas.SumSalesLinesTemp(
                      rCabVenta, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
                      wDecimal, wTexto, wDecimal, wDecimal, wDecimal);
                    if rCabVenta."Document Type" = rCabVenta."Document Type"::Invoice THEN BEGIN
                        ImpBorFac := ImpBorFac + TotalSalesLineLCY.Amount;
                    END
                    ELSE BEGIN
                        ImpBorAbo := ImpBorAbo + TotalSalesLineLCY.Amount;
                    END;
                UNTIL rCabVenta.NEXT = 0;
            END;

        END;

        if Rec."Facturas Registradas" <> 0 THEN BEGIN

            rCabFac.RESET;
            rCabFac.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
            rCabFac.SETRANGE("Nº Contrato", wNum);
            if rCabFac.FIND('-') THEN BEGIN
                REPEAT
                    rCabFac.CALCFIELDS("Amount Including VAT", Amount);
                    ImpFac := ImpFac + rCabFac.Amount;
                UNTIL rCabFac.NEXT = 0;
            END;

        END;

        if Rec."Abonos Registrados" <> 0 THEN BEGIN

            rCabAbo.RESET;
            rCabAbo.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
            rCabAbo.SETRANGE("Nº Contrato", wNum);
            if rCabAbo.FIND('-') THEN BEGIN
                REPEAT
                    rCabAbo.CALCFIELDS("Amount Including VAT", Amount);
                    ImpAbo := ImpAbo + rCabAbo.Amount;
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
            RegisVtas.GetSalesLines(rCabVenta, TempSalesLine, 0);
            CLEAR(RegisVtas);
            RegisVtas.SumSalesLinesTemp(rCabVenta, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
                                        wDecimal, wTexto, wDecimal, wDecimal, wDecimal);
            TotCont := TotalSalesLineLCY.Amount;
        END;
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
            Rec.SETRANGE("Fecha Estado", 0D, Hasta);
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


    // PROCEDURE BuscarProyectos();
    // VAR
    //     rContrato: Record 36;
    //     rProyecto: Record 167;
    //     wCuantos: Integer;
    // BEGIN
    //     // $003 Obtengo los contratos asociados a los proyectos original, origen y renovado.

    //     "Contrato origen" := '';
    //     "Contrato original" := '';
    //     "Contrato renovado" := '';

    //     if rProyecto.GET(Rec."Nº Proyecto") THEN BEGIN
    //         if rProyecto."Proyecto original" <> '' THEN BEGIN
    //             rContrato.RESET;
    //             rContrato.SETCURRENTKEY("Nº Proyecto");
    //             rContrato.SETRANGE("Nº Proyecto", rProyecto."Proyecto original");
    //             if rContrato.FINDFIRST THEN
    //                 "Contrato original" := rContrato."No.";
    //         END;
    //         if rProyecto."Proyecto origen" <> '' THEN BEGIN
    //             rContrato.RESET;
    //             rContrato.SETCURRENTKEY("Nº Proyecto");
    //             rContrato.SETRANGE("Nº Proyecto", rProyecto."Proyecto origen");
    //             if rContrato.FINDFIRST THEN
    //                 "Contrato origen" := rContrato."No.";
    //         END;
    //         //$005(I)
    //         wCuantos := 0;
    //         rProyecto.RESET;
    //         rProyecto.SETCURRENTKEY("Proyecto origen");
    //         rProyecto.SETRANGE("Proyecto origen", Rec."Nº Proyecto");
    //         wCuantos := rProyecto.COUNT;
    //         //$005(F)
    //         rProyecto.RESET;
    //         rProyecto.SETCURRENTKEY("Proyecto origen");
    //         rProyecto.SETRANGE("Proyecto origen", Rec."Nº Proyecto");
    //         //$005(I)
    //         if wCuantos > 0 THEN
    //             rProyecto.SETFILTER("No.", '<>%1', Rec."Nº Proyecto");
    //         //$005(F)
    //         if rProyecto.FINDFIRST THEN BEGIN
    //             rContrato.RESET;
    //             rContrato.SETCURRENTKEY("Nº Proyecto");
    //             rContrato.SETRANGE("Nº Proyecto", rProyecto."No.");
    //             if rContrato.FINDFIRST THEN
    //                 "Contrato renovado" := rContrato."No.";
    //         END;
    //     END;
    // END;

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
                TotalesDocumentos(Rec."Nº Proyecto", Rec."No.");
                if (((ImpBorFac - ImpBorAbo)) <> 0) THEN BEGIN
                    if CompruebaRecursos(Rec."Nº Proyecto") THEN
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
        ProduccionesRelacionadas: Record "Produccines Relacionadas";
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
                        ProduccionesRelacionadas.SETRANGE("Line No.", LinProy."Line No.");
                        ProduccionesRelacionadas.SETRANGE("Job No.", pJob);
                        if NOT ProduccionesRelacionadas.FINDFIRST THEN EXIT(TRUE);
                    END;
                END;
            UNTIL LinProy.NEXT = 0;
        EXIT(FALSE);
    END;

    PROCEDURE MarcaRegistrosFCE();
    VAR
        r112: Record 112;
    BEGIN
        // $002-
        r112.SETRANGE(r112."Posting Date", 20160101D, 20161231D);
        Rec.MARKEDONLY(FALSE);
        finestra.OPEN('Procesando #1######## de #2#######');
        finestra.UPDATE(2, r112.COUNT);
        i := 0;
        if r112.FINDSET THEN
            REPEAT
                i += 1;
                finestra.UPDATE(1, i);
                if CompruebaRecursos(r112."Nº Proyecto") THEN BEGIN
                    Rec.GET(Rec."Document Type"::Order, r112."Nº Contrato");
                    Rec.MARK(TRUE);
                END ELSE
                    Rec.MARK(FALSE);
            UNTIL r112.NEXT = 0;
        finestra.CLOSE;
        Rec.MARKEDONLY(TRUE);
    end;

    local procedure Vendedor(SalespersonCode: Code[20]): Text
    var
        Vendedores: Record 13;
    begin
        if Vendedores.Get(SalespersonCode) Then Exit(Vendedores.Name);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLookupNuestraCuenta(var Rec: Record "Sales Header"; var r270: Record "Bank Account")
    begin
    end;



}
// group(General)
// {
//     field("Pendiente de Firma"; wtipopendiente)
//     {
//         ApplicationArea = ALL;
//         Editable = true;
//         Caption = 'Pendientes de firma';
//         trigger OnValidate()
//         Begin
//             if not wTipoPendiente then wTipoTodos := false;
//             Filtra;
//             Rec.SETRANGE("Fecha Estado");
//         END;
//     }
//     field("Firmado"; wTipoFirmado)
//     {
//         ApplicationArea = ALL;
//         Editable = true;
//         Caption = 'Firmados';
//         trigger OnValidate()
//         Begin
//             if not wTipoFirmado then wTipoTodos := false;
//             Filtra;

//         END;
//     }
//     field("Anulado"; wTipoAnulado)
//     {
//         ApplicationArea = ALL;
//         Editable = true;
//         Caption = 'Anulados';
//         trigger OnValidate()
//         Begin
//             if not wTipoAnulado then wTipoTodos := false;
//             Filtra;

//         END;
//     }
//     field("Cancelado"; wTipoCancelado)
//     {
//         ApplicationArea = ALL;
//         Editable = true;
//         Caption = 'Cancelados';
//         trigger OnValidate()
//         Begin
//             if not wTipoCancelado then wTipoTodos := false;
//             Filtra;

//         END;
//     }
//     field("Sin Montar"; wTipoSinMontar)
//     {
//         ApplicationArea = ALL;
//         Editable = true;
//         Caption = 'Sin Montar';
//         trigger OnValidate()
//         Begin
//             if not wTipoSinMontar then wTipoTodos := false;
//             Filtra;

//         END;
//     }
//     field("Todos"; wTipoTodos)
//     {
//         ApplicationArea = ALL;
//         Editable = true;
//         Caption = 'Todos';
//         trigger OnValidate()
//         Begin
//             Filtra;

//         END;
//     }
//     group(Fechas)
//     {
//         Caption = 'Filtro Fecha';
//         field("Desde"; Desde)
//         {
//             Caption = 'Desde';
//             trigger OnValidate()
//             Begin
//                 Filtra;

//             END;
//         }
//         field("Hasta"; Hasta)
//         {
//             ApplicationArea = ALL;
//             Caption = 'Hasta';
//             trigger OnValidate()
//             Begin
//                 Filtra;

//             END;
//         }
//         field("Solo Filtro Hasta"; Solh)
//         {
//             ApplicationArea = ALL;
//             Caption = 'Solo Filtro Hasta';
//             trigger OnValidate()
//             Begin
//                 Filtra;

//             END;
//         }
//     }
//     field("Campo diferencias"; wVer)
//     {
//         Editable = false;
//         ApplicationArea = ALL;
//         Caption = 'Diferencias';
//     }
//     field("Campo diferencias factura"; wVerF)
//     { ApplicationArea = ALL; Editable = false; }

// }