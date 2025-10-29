


/// <summary>
/// Page Ultimas reservas recurso (ID 50082).
/// </summary>
page 50082 "Ultimas reservas recurso"
{
    //Version List=MLL;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Ultimas reservas recursos";

    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("Cod Recurso"; Rec."Cod Recurso") { ApplicationArea = All; }
                field("Nombre"; Rec.Nombre) { ApplicationArea = All; }
                field("Medidas"; Rec.Medidas) { ApplicationArea = All; }
                field("Zona"; Rec.Zona) { ApplicationArea = All; }
                field("Nº fam recurso"; Rec."Nº fam recurso") { ApplicationArea = All; }
                field("Ult proyecto"; Rec."Ult proyecto") { ApplicationArea = All; }
                field("Fecha inicial"; Rec."Fecha inicial") { ApplicationArea = All; }
                field("Fecha final"; Rec."Fecha final") { ApplicationArea = All; }
                field("Soporte de"; Rec."Soporte de") { ApplicationArea = All; }
                field("Fija/Papel"; Rec."Fija/Papel") { ApplicationArea = All; }
                field(Iluminado; Rec.Iluminado)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }

                field("Fecha baja"; Rec."Fecha baja") { ApplicationArea = All; }
            }
        }
    }
    trigger OnOpenPage()
    BEGIN
        Rec.SETRANGE(Usuario, USERID);
    END;

}
page 50083 "Tabla presupuesto mismo recurs"
{
    //Version List=MLL1.00;
    Editable = false;
    Caption = 'Este recurso esta en lista de espera para otros proyectos';
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = 1003;

    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("Job No."; Rec."Job No.") { ApplicationArea = All; }
                field("rProyecto.Description"; rProyecto.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción proyecto';
                }
                field("Type"; Rec.Type) { ApplicationArea = All; }
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Planning Date"; Rec."Planning Date") { ApplicationArea = All; }
                field("Fecha Final"; Rec."Fecha Final") { ApplicationArea = All; }
            }
        }
    }
    VAR
        rProyecto: Record 167;

    trigger OnAfterGetRecord()
    BEGIN
        if NOT rProyecto.GET(Rec."Job No.") THEN rProyecto.INIT;
    END;

}
page 50084 "Términos de facturación"
{
    //Version List=MLL1.00;
    //area(Content){ Repeater(Detalle){ID=1;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Términos facturación";
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                field("Código"; Rec.Código) { ApplicationArea = All; }
                field("Descripción"; Rec.Descripción) { ApplicationArea = All; }
                field("Nº de plazos"; Rec."Nº de plazos") { ApplicationArea = All; }
                field("Nº de Facturas"; Rec."Nº de Facturas") { ApplicationArea = All; }
                field("Cálculo de Plazos"; Rec."Cálculo de Plazos") { ApplicationArea = All; }
                field("Código interempreas"; Rec."Código interempreas") { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            group("&Términos")
            {
                Caption = '&Términos';
                action("Equi. Interempresas")
                {
                    ApplicationArea = All;
                    Caption = 'Equi. Interempresas';
                    RunObject = Page "Equiv. Términos Facuración";
                }
            }
        }
    }
}
page 50085 "Plazos de facturación"
{
    //Version List=MLL1.00;
    //area(Content){ Repeater(Detalle){ID=1;
    SourceTable = "Plazos de facturación";
    PageType = List;
    UsageCategory = Lists;
    AutoSplitKey = true;
    //UpdateOnActivate=Yes;
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                field("% del total"; Rec."% del total") { ApplicationArea = All; }
                field("Distancia entre plazos"; Rec."Distancia entre plazos") { ApplicationArea = All; }
            }
        }
    }
}
page 7001114 "Lista documentos venta MLL"
{
    //Version List=MLL1.00;
    PageType = List;
    UsageCategory = Lists;
    Editable = false;
    //area(Content){ Repeater(Detalle){ID=1;
    SourceTable = 36;
    DataCaptionFields = "Document Type";
    CardPageId = 43;

    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("Document Type"; "DocumentType") { Caption = 'Tipo Documento'; ApplicationArea = All; }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    BEGIN
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::Invoice:
                                BEGIN
                                    CLEAR(fFactura);
                                    CLEAR(rRec2);
                                    rRec2.RESET;
                                    rRec2.SETRANGE("Document Type", rRec2."Document Type"::Invoice);
                                    rRec2.SETRANGE("No.", Rec."No.");
                                    Commit();
                                    fFactura.SETTABLEVIEW(rRec2);
                                    fFactura.RUNMODAL;
                                END;
                            Rec."Document Type"::"Credit Memo":
                                BEGIN
                                    CLEAR(fAbono);
                                    CLEAR(rRec2);
                                    rRec2.RESET;
                                    rRec2.SETRANGE("Document Type", rRec2."Document Type"::"Credit Memo");
                                    rRec2.SETRANGE("No.", Rec."No.");
                                    Commit();
                                    fAbono.SETTABLEVIEW(rRec2);
                                    fAbono.RUNMODAL;
                                END;
                        END;
                    END;
                }

                field("Sell-to Customer No."; Rec."Sell-to Customer No.") { ApplicationArea = All; }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    StyleExpr = Color;
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code") { ApplicationArea = All; }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2") { ApplicationArea = All; }
                field("Esperar Orden Cliente"; Rec."Esperar Orden Cliente") { ApplicationArea = All; }
                field("Posting Description"; Rec."Posting Description") { ApplicationArea = All; }
                field("Sell-to Post Code"; Rec."Sell-to Post Code") { ApplicationArea = All; }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code") { ApplicationArea = All; }
                field("Sell-to Contact"; Rec."Sell-to Contact") { ApplicationArea = All; }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.") { ApplicationArea = All; }
                field("Bill-to Name"; Rec."Bill-to Name") { ApplicationArea = All; }
                field("Bill-to Post Code"; Rec."Bill-to Post Code") { ApplicationArea = All; }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code") { ApplicationArea = All; }
                field("Bill-to Contact"; Rec."Bill-to Contact") { ApplicationArea = All; }
                field("Ship-to Code"; Rec."Ship-to Code") { ApplicationArea = All; }
                field("Ship-to Name"; Rec."Ship-to Name") { ApplicationArea = All; }
                field("Ship-to Post Code"; Rec."Ship-to Post Code") { ApplicationArea = All; }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code") { ApplicationArea = All; }
                field("Ship-to Contact"; Rec."Ship-to Contact") { ApplicationArea = All; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                //    { 140 ;Label        ;0    ;0    ;0    ;0    ;
                field("Due Date"; Rec."Due Date") { ApplicationArea = All; }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code") { ApplicationArea = All; }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code") { ApplicationArea = All; }
                field("Cod cadena"; Rec."Cod cadena") { ApplicationArea = All; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
                field("Nº Proyecto"; Rec."Nº Proyecto") { ApplicationArea = All; }
                field("Fecha inicial proyecto"; Rec."Fecha inicial proyecto") { ApplicationArea = All; }
                field("Fecha fin proyecto"; Rec."Fecha fin proyecto") { ApplicationArea = All; }
                field(TAmount; TotalSalesLine.Amount)
                {
                    ApplicationArea = All;

                    Caption = 'Importe';
                }
                field("Amount Including VAT"; TotalSalesLine."Amount Including VAT")
                {
                    ApplicationArea = All;


                    Caption = 'Importe IVA incl.';
                }
                field(Renovado; Rec.Renovado)
                {
                    ApplicationArea = All;

                    ShowCaption = false;
                }
                field("Interc./Compens."; Rec."Interc./Compens.") { ApplicationArea = All; }
                field("Proyecto origen"; Rec."Proyecto origen") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&Documento")
            {

                Caption = '&Documento';
                action("&Ver documento")
                {
                    ApplicationArea = all;
                    ShortCutKey = F2;
                    Caption = '&Ver documento';
                    Scope = Repeater;
                    trigger OnAction()
                    BEGIN
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::Invoice:
                                BEGIN
                                    CLEAR(fFactura);
                                    CLEAR(rRec2);
                                    rRec2.RESET;
                                    rRec2.SETRANGE("Document Type", rRec2."Document Type"::Invoice);
                                    rRec2.SETRANGE("No.", Rec."No.");
                                    Commit();
                                    fFactura.SETTABLEVIEW(rRec2);
                                    fFactura.RUNMODAL;
                                END;
                            Rec."Document Type"::"Credit Memo":
                                BEGIN
                                    CLEAR(fAbono);
                                    CLEAR(rRec2);
                                    rRec2.RESET;
                                    rRec2.SETRANGE("Document Type", rRec2."Document Type"::"Credit Memo");
                                    rRec2.SETRANGE("No.", Rec."No.");
                                    Commit();
                                    fAbono.SETTABLEVIEW(rRec2);
                                    fAbono.RUNMODAL;
                                END;
                        END;
                    END;
                }
                action("Asignar dimensiones Contrato")
                {
                    Caption = 'Asignar dimensiones Contrato';
                    trigger OnAction()
                    VAR
                        cFac: Page 43;
                        rFac: Record 36;
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(rFac);
                        if rFac.FINDFIRST THEN
                            REPEAT
                                CLEAR(cFac);
                            // cFac.RecuperaDimensionesContrato(rFac);
                            // pendiente
                            UNTIL rFac.NEXT = 0;
                    END;
                }
            }
        }
        area(Reporting)
        {
            action("Imprimir &Factura Borrador")
            {
                Image = Document;
                Scope = Repeater;
                ApplicationArea = All;
                trigger OnAction()
                var
                    rCab2: Record "Sales Header";
                Begin
                    rCab2.RESET;
                    rCab2.SETRANGE("Document Type", Rec."Document Type"::Invoice);
                    rCab2.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(REPORT::"Pre-Sales-Invoice Pdf", TRUE, FALSE, rCab2);
                End;
            }
        }
    }

    VAR
        rRec2: Record 36;
        TotalSalesLine: Record 37;
        TotalSalesLineLCY: Record 37;
        fFactura: Page 43;
        fAbono: Page 44;
        RegisVtas: Codeunit 80;
        wDecimal: Decimal;
        wTexto: Text[30];
        Color: Text[30];
        DocumentType: enum "Gen. Journal Document Type";

    trigger OnAfterGetRecord()
    var
        Cust: Record "Customer";
    BEGIN
        CalcularTotales(Rec."No.");
        if ABS(TotalSalesLine.Amount) < 1 Then begin
            if not cust.Get(Rec."Sell-to Customer No.") then
                Cust.Init;
            if Cust."Generar facturas a 0" Then
                documentType := DocumentType::Invoice
            else
                DocumentType := DocumentType::Shipment;
        end else
            DocumentType := DocumentType::Invoice;
        Color := '';
        if DocumentType = DocumentType::Shipment Then begin
            if TotalSalesLine.Amount <> 0 then
                Color := 'Unfavorable'
            else
                Color := 'Attention';
        end;
        //FCL-04/05/04
    END;

    PROCEDURE CalcularTotales(pNumDoc: Code[20]);
    VAR
        TempSalesLine: Record 37 TEMPORARY;
        rCnfVta: Record 311;
        rLinVenta: Record 37;
    BEGIN
        //FCL-04/05/04. Obtengo total y total iva incluído, ya no me sirve el campo calculado
        // porque estos importes están a cero en las líneas.
        //$001(I)
        rCnfVta.GET;
        if rCnfVta."Calc. Inv. Discount" THEN BEGIN
            rLinVenta.RESET;
            rLinVenta.SETRANGE("Document Type", Rec."Document Type");
            rLinVenta.SETRANGE("Document No.", Rec."No.");
            if rLinVenta.FINDFIRST THEN
                CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount", rLinVenta);
        END;
        //$001(F)
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
    // BEGIN
    // {
    //   $001 FCL-200611. Incluyo cálculo dto. factura, no se calculaba
    // }
    // END.

}
page 7001115 "Lista de familias"
{
    //Version List=MLL1.00;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    //area(Content){ Repeater(Detalle){ID=1;
    SourceTable = 152;
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Name"; Rec.Name) { ApplicationArea = All; }
                field("Cód. Departamento"; Rec."Cod. Departamento") { ApplicationArea = All; }
                field("Grupo contable producto"; Rec."Grupo contable producto") { ApplicationArea = All; }
                field("Grupo registro IVA prod."; Rec."Grupo registro IVA prod.") { ApplicationArea = All; }
                field("Nº proveedor"; Rec."Nº proveedor") { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Pla&nific.")
            {
                Caption = 'Pla&nific.';
                action("Capacidad fam. recurso")
                {
                    Image = ResourcePlanning;
                    ApplicationArea = ALL;
                    Caption = 'Capacidad fam. recurso';
                    RunObject = Page 214;
                }
                action("A&signación fams. recursos")
                {
                    Image = ResourceSetup;
                    ApplicationArea = ALL;
                    Caption = 'A&signación fams. recursos';
                    RunObject = Page 228;
                    //RunPageLinkType=OnUpdate;
                    RunPageLink = "Resource Gr. Filter" = FIELD("No.");
                }
                action("D&isponibilidad fam. recurso")
                {
                    Image = ResourceGroup;
                    ApplicationArea = ALL;
                    Caption = 'D&isponibilidad fam. recurso';
                    RunObject = Page 226;
                    //RunPageLinkType=OnUpdate;
                    RunPageLink = "No." = FIELD("No."),
                      "Unit of Measure Filter" = FIELD("Unit of Measure Filter"),
                      "Chargeable Filter" = FIELD("Chargeable Filter");
                }
                action("Presupuesto proyecto")
                {
                    Image = CostBudget;
                    ApplicationArea = ALL;
                    Caption = 'Presupuesto proyecto';
                    //RunObject = Page 212;
                }
            }
            group("&Fam. rec.")
            {
                Caption = '&Fam. rec.';
                action("&Recursos")
                {
                    Image = ResourceGroup;
                    ApplicationArea = ALL;
                    Caption = '&Recursos';
                    RunObject = Page 77;
                    //RunPageView = SORTING(Blocked, "Resource Group No.", Ocupado, Categoria);
                    RunPageLink = "Resource Group No." = FIELD("No.");
                }
                action(Estadísticas)
                {
                    Image = Statistics;
                    ApplicationArea = ALL;
                    ShortCutKey = F9;
                    Caption = 'Estadísticas';
                    RunObject = Page 230;
                    //RunPageLinkType=OnUpdate;
                    RunPageLink = "No." = FIELD("No."),
                                      "Date Filter" = FIELD("Date Filter"),
                      "Unit of Measure Filter" = FIELD("Unit of Measure Filter"),
                      "Chargeable Filter" = FIELD("Chargeable Filter");
                }
                action("C&omentarios")
                {
                    Image = Comment;
                    ApplicationArea = ALL;
                    Caption = 'C&omentarios';
                    RunObject = Page 124;
                    //RunPageLinkType=OnUpdate;
                    RunPageLink = "Table Name" = CONST("Resource Group"),
                      "No." = FIELD("No.");
                }
            }

            // group("&Precios")
            // {

            //     Caption = '&Precios';
            //     action(Costes)
            //     {
            //         Image = Cost;
            //         ApplicationArea = ALL;
            //         Caption = 'Costes';
            //         RunObject = Page 203;
            //         //RunPageLinkType=OnUpdate;
            //         RunPageLink = Type = CONST("Group(Resource)"),
            //           Code = FIELD("No.");
            //     }
            //     action(Precios)
            //     {
            //         Image = Prices;
            //         ApplicationArea = ALL;
            //         Caption = 'Precios';
            //         RunObject = Page 204;
            //         //RunPageLinkType=OnUpdate;
            //         RunPageLink = Type = CONST("Group(Resource)"),
            //           Code = FIELD("No.");
            //     }
            // }
        }
    }

}
page 7001118 "Cambio fechas proyecto"
{
    //Version List=MLL1.00;
    PageType = Card;
    SourceTable = 167;
    layout
    {
        area(Content)
        {
            field("No."; Rec."No.")
            {
                Caption = 'Proyecto';
                ApplicationArea = All;
                Editable = false;
            }
            field("Adelant"; Adelanta)
            {
                ApplicationArea = All;
                Caption = 'Adelantar';
                trigger OnValidate()
                BEGIN
                    Atrasa := NOT Adelanta;
                END;
            }
            field("Atras"; Atrasa)
            {
                ApplicationArea = All;
                Caption = 'Atrasar';
                trigger OnValidate()
                BEGIN
                    Adelanta := NOT Atrasa;
                END;
            }

            field("Intervalo"; Intervalo) { ApplicationArea = All; Caption = 'Num. de dias'; }
        }
    }
    actions
    {
        area(Processing)
        {
            action("&Cambio")
            {
                Image = Change;
                ApplicationArea = All;
                trigger OnAction()
                BEGIN
                    if (Intervalo = 0) THEN
                        ERROR('El intervalo no puede quedar a cero');
                    if Adelanta THEN BEGIN
                        if NOT CONFIRM('Se adelantara TODO el proyecto %1 dias.\' +
                                        'Nos quedara desde %2 - %3. \' +
                                        'Tambien se cambiaran las Reservas y los datos en los\' +
                                        //               'Contratos y Facturas\'+                    //FCL-20/05/05
                                        'Contratos\' +                               //FCL-20/05/05
                                        '¿Correcto?', TRUE, STRSUBSTNO('%1', Intervalo),
                                        STRSUBSTNO('%1', Rec."Starting Date" + Intervalo), STRSUBSTNO('%1', Rec."Ending Date" + Intervalo)) THEN
                            EXIT;
                    END ELSE BEGIN
                        if NOT CONFIRM('Se atrasara TODO el proyecto %1 dias.\' +
                                        'Nos quedara desde %2 - %3. \' +
                                        'Tambien se cambiaran las Reservas y los datos en los\' +
                                        //               'Contratos y Facturas\'+                    //FCL-20/05/05
                                        'Contratos\' +                               //FCL-20/05/05
                                        '¿Correcto?', TRUE, STRSUBSTNO('%1', Intervalo),
                                        STRSUBSTNO('%1', Rec."Starting Date" - Intervalo), STRSUBSTNO('%1', Rec."Ending Date" - Intervalo)) THEN
                            EXIT;
                    END;
                    if Adelanta THEN
                        cProy.Cambio_Fecha(Rec, (Intervalo))
                    ELSE
                        cProy.Cambio_Fecha(Rec, (Intervalo * (-1)));
                    CurrPage.CLOSE;
                END;
            }

        }
    }
    VAR
        Adelanta: Boolean;
        Atrasa: Boolean;
        Intervalo: Decimal;
        cProy: Codeunit "Gestion Proyecto";

    trigger OnOpenPage()
    BEGIN
        Adelanta := TRUE;
        Atrasa := FALSE;
    END;

}
page 7001119 "Pide Nº Serie"
{
    //Version List=MLL1.00;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    //area(Content){ Repeater(Detalle){ID=1;
    SourceTable = 308;
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("Code"; Rec.Code) { ApplicationArea = All; }
                field("Description"; Rec.Description) { ApplicationArea = All; }
                field("Defau lt Nos."; Rec."Default Nos.") { ApplicationArea = All; ShowCaption = false; }

                field("Manual Nos."; Rec."Manual Nos.") { ApplicationArea = All; ShowCaption = false; }

                field("Date Order"; Rec."Date Order") { ApplicationArea = All; ShowCaption = false; }

            }
        }
    }
}
page 7001120 "Quita marca automatico"
{
    //Version List=MLL1.00;
    Permissions = TableData 17 = rimd;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    //area(Content){ Repeater(Detalle){ID=1;
    SourceTable = 17;
    // trigger OnOpenPage()
    // BEGIN
    //              {SETFILTER("Source Code", 'DIAGEN|DIACOBROS|DIAPAGOS');
    //     SETFILTER("G/L Account No.", '572..572:');
    //     SETRANGE("System-Created Entry", TRUE); }
    //            END;
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("Transaction No."; Rec."Transaction No.") { ApplicationArea = All; }
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; }
                field("G/L Account No."; Rec."G/L Account No.") { ApplicationArea = All; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                field("Document Type"; Rec."Document Type") { ApplicationArea = All; }
                field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                field("Description"; Rec.Description) { ApplicationArea = All; }
                field("Amount"; Rec.Amount) { ApplicationArea = All; }
                field("Debit Amount"; Rec."Debit Amount") { ApplicationArea = All; }
                field("Credit Amount"; Rec."Credit Amount") { ApplicationArea = All; }
                field("System-Created Entry"; Rec."System-Created Entry") { ApplicationArea = All; ShowCaption = false; }

                field("Source Code"; Rec."Source Code") { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("&Desmarcar")
            {
                ApplicationArea = All;
                Image = UnApply;
                Caption = '&Desmarcar';
                trigger OnAction()
                BEGIN
                    if NOT CONFIRM('Quitar la marca de automático a los asientos marcados?') THEN EXIT;
                    CurrPage.SETSELECTIONFILTER(rMov);
                    rMov.MODIFYALL("System-Created Entry", FALSE);
                END;
            }
        }
    }
    VAR
        rMov: Record "G/L Entry";

}

page 7001127 "Codigos cadena"
{
    //Version List=MLL;
    PageType = List;
    UsageCategory = Lists;
    Caption = 'Codigos cadena';
    //area(Content){ Repeater(Detalle){ID=1103355000;
    SourceTable = "Codigos cadena";
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                field("Codigo"; Rec.Codigo) { ApplicationArea = All; }
                field("Descripcion"; Rec.Descripcion) { ApplicationArea = All; }

            }
        }
    }
    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Actualizar clientes")
    //         {
    //             ApplicationArea = All;
    //             Image = UpdateDescription;
    //             Caption = 'Actualizar clientes';
    //             trigger OnAction()
    //             var
    //                 CodigosCadena: Record "Codigos cadena";
    //                 Clientes: Record "Customer";
    //                 Description: Text[50];
    //                 Emp: Record "Company";
    //             begin
    //                 if CodigosCadena.FINDFIRST THEN
    //                     REPEAT
    //                         if Emp.FindFirst() then
    //                             repeat
    //                                 Clientes.ChangeCompany(Emp."Name");
    //                                 Clientes.SETRANGE("VAT Registration No.", CodigosCadena.Codigo);
    //                                 if Clientes.FINDFIRST THEN
    //                                     REPEAT
    //                                         Clientes."Name" := CodigosCadena.DescripCion;
    //                                         Clientes.MODIFY;
    //                                     UNTIL Clientes.NEXT = 0;
    //                             UNTIL Emp.NEXT = 0;

    //                     UNTIL CodigosCadena.NEXT = 0;
    //                 MESSAGE('Clientes actualizados.');
    //             end;
    //         }
    //     }
    // }
}
page 7001128 "Codigos peligrosidad"
{
    //Version List=MLL;
    PageType = List;
    UsageCategory = Lists;
    Caption = 'Códigos peligrosidad';
    //area(Content){ Repeater(Detalle){ID=1103355000;
    SourceTable = "Codigos peligrosidad";
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                field("Codigo"; Rec.Codigo) { ApplicationArea = All; }
                field("Descripcion"; Rec.Descripcion) { ApplicationArea = All; }
            }
        }
    }

}
page 7001129 "Tabla Recursos (2)"
{
    //Version List=;
    //area(Content){ Repeater(Detalle){ID=1;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = 156;
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Name"; Rec.Name) { ApplicationArea = All; }
                field("Municipio"; Rec.Municipio) { ApplicationArea = All; }
                field("C.P. Municipio"; Rec."C.P. Municipio") { ApplicationArea = All; }
                field("Resource Group No."; Rec."Resource Group No.") { ApplicationArea = All; }
                field("Tipo Recurso"; Rec."Tipo Recurso") { ApplicationArea = All; }
                field("Medidas"; Rec.Medidas) { ApplicationArea = All; }
                field(Iluminado; Rec.Iluminado) { ApplicationArea = All; ShowCaption = false; }
                field("Categoria"; Rec.Categoria) { ApplicationArea = All; }
                field("Orientación"; Rec.Orientación) { ApplicationArea = All; }
                field("Name 2"; Rec."Name 2") { ApplicationArea = All; }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code") { ApplicationArea = All; }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code") { ApplicationArea = All; }
                field("Zona"; Rec.Zona) { ApplicationArea = All; }
            }
        }
    }
}
page 7001130 "Tabla Bancos"
{
    //Version List=;
    //area(Content){ Repeater(Detalle){ID=1;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = 270;
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Name"; Rec.Name) { ApplicationArea = All; }
                field("Bank Acc. Posting Group"; Rec."Bank Acc. Posting Group") { ApplicationArea = All; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
                field("CCC Bank No."; Rec."CCC Bank No.") { ApplicationArea = All; }
                field("CCC Control Digits"; Rec."CCC Control Digits") { ApplicationArea = All; }
                field("CCC Bank Account No."; Rec."CCC Bank Account No.") { ApplicationArea = All; }
                field("CCC No."; Rec."CCC No.") { ApplicationArea = All; }
                field("Credit Limit for Discount"; Rec."Credit Limit for Discount") { ApplicationArea = All; }
            }
        }
    }
}
page 7001131 "Fijación Proyectos"
{
    //Version List=;
    //area(Content){ Repeater(Detalle){ID=1;
    PageType = Card;
    SourceTable = Job;
    layout
    {
        area(Content)
        {
            //Repeater(Detalle)
            //{

            field("No."; Rec."No.") { ApplicationArea = All; }
            field("Descrption"; Rec.Description) { Caption = 'Descripción'; ApplicationArea = All; }
            field("Fecha Creación"; Rec."Creation Date") { ApplicationArea = All; }
            field(StartingDate; Rec."Starting Date")
            {
                ApplicationArea = ALL;

            }
            field(EndingDate; Rec."Ending Date")
            {
                ApplicationArea = ALL;

            }
            //field("No Pay"; Rec."No Pay") { ApplicationArea = ALL; }
            field("Proyecto de fijación"; Rec."Proyecto de fijación") { ApplicationArea = All; }
            // }
            part(JobTaskLines2; JobLinesSub)
            {
                ApplicationArea = ALL;
                Caption = 'Lineas';
                SubPageLink = "Job No." = FIELD("No.");
                SubPageView = SORTING("Job Task No.")
                              ORDER(Ascending);
            }
        }
    }
    actions
    {

        area(Processing)
        {
            action("Ocupación diaria")
            {
                Image = ResourcePlanning;
                ApplicationArea = All;
                Caption = 'Ocupación diaria';
                trigger OnAction()
                Begin
                    CurrPage.JobTaskLines2.Page.LlamarPlazos;
                END;
            }


            action("Cambiar &Fechas Proyecto")
            {
                Image = ChangeDates;
                ApplicationArea = all;
                Caption = 'Cambiar &Fechas Proyecto';
                trigger OnAction()
                Begin
                    Rec.SETRANGE("No.", Rec."No.");
                    Page.RUNMODAL(Page::"Cambio fechas proyecto", Rec);
                    Rec.SETRANGE("No.");
                    CurrPage.UPDATE;
                END;
            }
            action("Adelanta Fecha Fin")
            {
                Image = ChangeDate;
                ApplicationArea = all;
                Caption = 'Adelanta Fecha Fin';
                trigger OnAction()
                Var
                    NuevoTexto: Text;
                    finestra: Page Dialogo;

                    fech: Date;
                Begin

                    fech := Rec."Ending Date";
                    NuevoTexto := ('Introduzca Nueva fecha fin');
                    finestra.SetValues(fech, NuevoTexto);
                    finestra.RunModal();
                    finestra.GetValues(fech, NuevoTexto);
                    if (fech > Rec."Ending Date") THEN
                        ERROR('La nueva fecha final debe ser inferior a %1', Rec."Ending Date");
                    CLEAR(cProyecto);
                    cProyecto.Adelanta_Fecha_Fin(Rec, fech);

                END;
            }

            action("Todas &Reservas Proyecto")
            {
                ApplicationArea = all;
                Image = ReservationLedger;
                //PushAction=RunObject;
                Caption = 'Todas &Reservas Proyecto';
                RunObject = page "Tabla Reservas";
                RunPageView = SORTING("Nº Proyecto", "Fecha inicio");
                RunPageLink = "Nº Proyecto" = FIELD("No.");
            }



            action("Crear &Reservas")
            {
                ApplicationArea = All;
                Image = Reserve;
                Caption = 'Crear &Reservas';
                trigger OnAction()
                Begin
                    CurrPage.JobTaskLines2.Page.CreaReservas;
                END;
            }
            action("Ver R&eservas")
            {
                ApplicationArea = All;
                Image = Find;
                Caption = 'Ver R&eservas';
                trigger OnAction()
                Begin
                    CurrPage.JobTaskLines2.Page.VerReservas;
                END;
            }
            action("Traspasar Reservas")
            {
                ApplicationArea = All;
                Image = CopyBOM;
                Caption = 'Traspasar Reservas';
                trigger OnAction()
                var
                    NewJob: Record Job;
                    Reservas: Record Reserva;
                    DiarioReservas: Record "Diario Reserva";
                    JobPlanningLine2: Record "Job Planning Line";
                    JobPlanningLine: Record "Job Planning Line";
                    Linea: Integer;
                Begin
                    Message('Elija el proyecto destino');
                    If Page.RunModal(0, NewJob) in [ACTION::OK, Action::LookupOK] THEN BEGIN
                        Reservas.SetRange("Nº Proyecto", Rec."No.");
                        Reservas.SetRange("Fecha inicio");
                        Reservas.SetRange("Fecha Fin");
                        Reservas.ModifyAll("Nº Proyecto", NewJob."No.");
                        Reservas.ModifyAll("Proyecto de fijación", NewJob."Proyecto de fijación");
                        DiarioReservas.SetRange("Nº Proyecto", Rec."No.");
                        DiarioReservas.ModifyAll("Nº Proyecto", NewJob."No.");
                        DiarioReservas.ModifyAll("Proyecto de fijación", NewJob."Proyecto de fijación");
                        DiarioReservas.Reset();
                        JobPlanningLine.SetRange("Job No.", Rec."No.");
                        JobPlanningLine2.SetRange("Job No.", NewJob."No.");
                        If JobPlanningLine2.FindSet() Then Linea := JobPlanningLine2."Line No.";
                        If JobPlanningLine.FindSet() Then
                            Repeat
                                JobPlanningLine2 := JobPlanningLine;
                                JobPlanningLine2."Line No." := Linea;
                                JobPlanningLine2."Job No." := NewJob."No.";
                                JobPlanningLine2.Insert();
                                DiarioReservas.SetRange("Nº Proyecto", NewJob."No.");
                                DiarioReservas.SetRange("Nº linea proyecto", JobPlanningLine."Line No.");
                                If DiarioReservas.FindFirst() Then
                                    DiarioReservas.ModifyAll("Nº linea proyecto", Linea);
                                Linea := Linea + 10000;

                            Until JobPlanningLine.Next() = 0;
                    END;
                END;
            }

        }


    }
    var
        cProyecto: Codeunit "Gestion Proyecto";
}

page 7001116 "Proyectos de Fijacion"
{
    //Version List=;
    //area(Content){ Repeater(Detalle){ID=1;
    PageType = List;
    UsageCategory = Lists;
    CardPageId = "Fijación Proyectos";
    SourceTable = Job;
    SourceTableView = where("Proyecto de fijación" = const(true));
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Descrption"; Rec.Description) { Caption = 'Descripción'; ApplicationArea = All; }
                field("Fecha Creación"; Rec."Creation Date") { ApplicationArea = All; }
                field("Proyecto de fijación"; Rec."Proyecto de fijación") { ApplicationArea = All; }
                //field("No Pay"; Rec."No Pay") { ApplicationArea = All; }
            }
        }
    }
}

page 7001117 "Lista recordatorios"
{
    //Version List=;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    //area(Content){ Repeater(Detalle){ID=1100244000;
    SourceTable = Recordatorios;

    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                Editable = false;
                field("Fecha"; Rec.Fecha) { ApplicationArea = All; }
                field("Nº"; Rec."Nº") { ApplicationArea = All; Caption = 'Nº contrato'; }


                field("Recordatorio"; Rec.Recordatorio) { ApplicationArea = All; }
                field("wFiltroFech"; wFiltroFecha)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    BEGIN
                        Rec.SETFILTER(Fecha, wFiltroFecha);
                        wFiltroFecha := Rec.GETFILTER(Fecha);
                        Actualizar;
                    END;
                }
                field("wFiltroContrat"; wFiltroContrato)
                {
                    ApplicationArea = All;
                    TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
                    trigger OnValidate()
                    BEGIN
                        Actualizar;
                    END;
                }
            }
        }
    }
    VAR
        // cAppMan: Codeunit 1;
        wFiltroContrato: Code[20];
        wFiltroFecha: Text[250];

    trigger OnOpenPage()
    BEGIN
        if NOT CurrPage.LOOKUPMODE THEN BEGIN
            wFiltroFecha := FORMAT(WORKDATE);
            Actualizar;
        END;
    END;

    PROCEDURE Actualizar();
    BEGIN
        if wFiltroFecha <> '' THEN
            Rec.SETFILTER(Fecha, wFiltroFecha)
        ELSE
            Rec.SETRANGE(Fecha);
        if wFiltroContrato <> '' THEN
            Rec.SETRANGE("Nº", wFiltroContrato)
        ELSE
            Rec.SETRANGE("Nº");
        CurrPage.UPDATE(FALSE);
    END;

}
page 7001124 "Recordatorios contrato"
{
    //Version List=;
    Caption = 'Recordatorios contrato';
    MultipleNewLines = true;
    PageType = List;
    UsageCategory = Lists;
    //area(Content){ Repeater(Detalle){ID=1;
    SourceTable = Recordatorios;
    AutoSplitKey = true;
    DataCaptionFields = "Tipo documento", "Nº";

    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("Fecha"; Rec.Fecha) { ApplicationArea = All; }
                field("Recordatorio"; Rec.Recordatorio) { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            group("R&ecordatorios")
            {
                Caption = 'R&ecordatorios';
                action(Lista)
                {
                    ShortCutKey = F5;
                    Image = List;
                    ApplicationArea = All;
                    Caption = 'Lista';
                    RunObject = Page "Lista recordatorios";
                }
            }
        }
    }

    trigger OnNewRecord(BelowRec: Boolean)
    BEGIN
        Rec.SetUpNewLine;
    END;
}
page 7001125 "Cambios dimensiones"
{
    //Version List=MLL1.00;
    //area(Content){ Repeater(Detalle){ID=1103355000;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cambios Dimensiones";


    layout
    {

        area(Content)
        {
            Repeater(Detalle)
            {
                field("Cod. antiguo"; Rec."Cod. antiguo")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    BEGIN
                        ObtenerDescripcion;
                    END;
                }
                field("Descripcion1"; Descripcion1) { ApplicationArea = All; }
                field("Cod. nuevo"; Rec."Cod. nuevo")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    BEGIN
                        ObtenerDescripcion;
                    END;
                }
                field("Descripcion2"; Descripcion2) { ApplicationArea = All; }
            }
        }
    }
    VAR
        rDimValue: Record 349;
        Descripcion1: Text[30];
        Descripcion2: Text[30];

    trigger OnAfterGetRecord()
    BEGIN
        ObtenerDescripcion;
    END;

    PROCEDURE ObtenerDescripcion();
    BEGIN
        Descripcion1 := '';
        Descripcion2 := '';
        rDimValue.RESET;
        rDimValue.SETCURRENTKEY(Code, "Global Dimension No.");
        rDimValue.SETRANGE(Code, Rec."Cod. antiguo");
        rDimValue.SETRANGE("Global Dimension No.", 2);
        if rDimValue.FIND('-') THEN
            Descripcion1 := rDimValue.Name;
        rDimValue.RESET;
        rDimValue.SETCURRENTKEY(Code, "Global Dimension No.");
        rDimValue.SETRANGE(Code, Rec."Cod. nuevo");
        rDimValue.SETRANGE("Global Dimension No.", 2);
        if rDimValue.FIND('-') THEN
            Descripcion2 := rDimValue.Name;
    END;

}
page 7001126 "Lista contratos con totales"
{
    //Version List=NAVW13.70,MLL1.00;
    PageType = List;
    UsageCategory = Lists;
    Editable = false;
    Caption = 'Lista contratos con totales';
    //area(Content){ Repeater(Detalle){ID=1;
    SourceTable = 36;
    DataCaptionFields = "Document Type";

    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.") { ApplicationArea = All; }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name") { ApplicationArea = All; }
                field("Amount"; Rec.Amount) { ApplicationArea = All; }
                field("Amount Including VAT"; Rec."Amount Including VAT") { ApplicationArea = All; }
                field("Posting Description"; Rec."Posting Description") { ApplicationArea = All; }
                field("Payment Method Code"; Rec."Payment Method Code") { ApplicationArea = All; }
                field("External Document No."; Rec."External Document No.") { ApplicationArea = All; }
                field("Sell-to Post Code"; Rec."Sell-to Post Code") { ApplicationArea = All; }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code") { ApplicationArea = All; }
                field("Sell-to Contact"; Rec."Sell-to Contact") { ApplicationArea = All; }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.") { ApplicationArea = All; }
                field("Bill-to Name"; Rec."Bill-to Name") { ApplicationArea = All; }
                field("Bill-to Post Code"; Rec."Bill-to Post Code") { ApplicationArea = All; }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code") { ApplicationArea = All; }
                field("Bill-to Contact"; Rec."Bill-to Contact") { ApplicationArea = All; }
                field("Ship-to Code"; Rec."Ship-to Code") { ApplicationArea = All; }
                field("Ship-to Name"; Rec."Ship-to Name") { ApplicationArea = All; }
                field("Ship-to Post Code"; Rec."Ship-to Post Code") { ApplicationArea = All; }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code") { ApplicationArea = All; }
                field("Ship-to Contact"; Rec."Ship-to Contact") { ApplicationArea = All; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                //    { 140 ;Label        ;0    ;0    ;0    ;0    ;
                field("Document Date"; Rec."Document Date") { ApplicationArea = All; }
                field("Order Date"; Rec."Order Date") { ApplicationArea = All; }
                field("Due Date"; Rec."Due Date") { ApplicationArea = All; }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code") { ApplicationArea = All; }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code") { ApplicationArea = All; }
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
                field("Comentario Cabecera"; Rec."Comentario Cabecera") { ApplicationArea = All; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
                field("Nº Proyecto"; Rec."Nº Proyecto") { ApplicationArea = All; }
                field("Nº Contrato"; Rec."Nº Contrato") { ApplicationArea = All; }
                field("Fecha inicial proyecto"; Rec."Fecha inicial proyecto") { ApplicationArea = All; }
                field("Fecha fin proyecto"; Rec."Fecha fin proyecto") { ApplicationArea = All; }
                field(TotalSalesLineAmount; TotalSalesLine.Amount) { ApplicationArea = All; Caption = 'Importe (calc.)'; }

                field(AmountIncludingVAT; TotalSalesLine."Amount Including VAT") { ApplicationArea = All; Caption = 'Importe IVA incl. (calc.)'; }

                field("Importe líneas"; Rec."Importe líneas") { ApplicationArea = All; }
                field("Imp. IVA. incl."; Rec."Imp. IVA. incl.") { ApplicationArea = All; }
                field(Renovado; Rec.Renovado) { ApplicationArea = All; ShowCaption = false; }

                field("Interc./Compens."; Rec."Interc./Compens.") { ApplicationArea = All; }
                field("Proyecto origen"; Rec."Proyecto origen") { ApplicationArea = All; }
                field("Fecha inicial factura"; Rec."Fecha inicial factura") { ApplicationArea = All; }
                field("Fecha final factura"; Rec."Fecha final factura") { ApplicationArea = All; }
                field("Borradores de Factura"; Rec."Borradores de Factura") { ApplicationArea = All; }
                field("Borradores de Abono"; Rec."Borradores de Abono") { ApplicationArea = All; }
                field("Facturas Registradas"; Rec."Facturas Registradas") { ApplicationArea = All; }
                field("Abonos Registrados"; Rec."Abonos Registrados") { ApplicationArea = All; }
                field(ImpBorFac; ImpBorFac) { ApplicationArea = All; Caption = 'Imp. Borr.Fac.'; }

                field(ImpBorAbo; ImpBorAbo) { ApplicationArea = All; Caption = 'Imp. Borr.Abo.'; }

                field(ImpFac; ImpFac) { ApplicationArea = All; Caption = 'Imp. Fac.Reg.'; }

                field(ImpAbo; ImpAbo) { ApplicationArea = All; Caption = 'Imp. Abo.Reg.'; }

                field(TotImp; TotImp) { ApplicationArea = All; Caption = 'Importe total'; }

                field(Diferencia; TotalSalesLine."Amount Including VAT" - TotImp) { ApplicationArea = All; Caption = 'Diferencia'; }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            group("&Line")
            {
                Caption = '&Línea';
                action(Card)
                {
                    ShortCutKey = 'Mayús+F5';
                    Caption = 'Ficha';
                    trigger OnAction()
                    BEGIN
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::Quote:
                                PAGE.RUN(PAGE::"Sales Quote", Rec);
                            Rec."Document Type"::Order:
                                PAGE.RUN(PAGE::"Ficha Contrato venta", Rec);
                            Rec."Document Type"::Invoice:
                                PAGE.RUN(PAGE::"Sales Invoice", Rec);
                            Rec."Document Type"::"Return Order":
                                PAGE.RUN(PAGE::"Sales Return Order", Rec);
                            Rec."Document Type"::"Credit Memo":
                                PAGE.RUN(PAGE::"Sales Credit Memo", Rec);
                            Rec."Document Type"::"Blanket Order":
                                PAGE.RUN(PAGE::"Blanket Sales Order", Rec);
                        END;
                    END;
                }
            }
        }
    }

    VAR
        TotalSalesLine: Record 37;
        TotalSalesLineLCY: Record 37;
        rCabFac: Record 112;
        rCabAbo: Record 114;
        RegisVtas: Codeunit 80;
        SumVtas: Codeunit ControlProcesos;
        wDecimal: Decimal;
        ImpBorFac: Decimal;
        ImpBorAbo: Decimal;
        ImpFac: Decimal;
        ImpAbo: Decimal;
        TotImp: Decimal;
        wTexto: Text[30];

    PROCEDURE CalcularTotales(pNumDoc: Code[20]);
    VAR
        TempSalesLine: Record 37 TEMPORARY;
    BEGIN
        //FCL-04/05/04. Obtengo total y total iva incluído, ya no me sirve el campo calculado
        // porque estos importes están a cero en las líneas.
        // JML 150704 Modificado para poder filtrar por fase.
        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);
        if pNumDoc <> '' THEN BEGIN
            CLEAR(RegisVtas);
            CLEAR(TempSalesLine);
            Clear(SumVtas);
            RegisVtas.GetSalesLines(Rec, TempSalesLine, 0);
            CLEAR(RegisVtas);
            //  JML 150704
            //  RegisVtas.SumSalesLinesTemp(
            //    Rec,TempSalesLine,0,TotalSalesLine,TotalSalesLineLCY,
            //    wDecimal,wTexto,wDecimal,wDecimal);
            SumVtas.SumSalesLinesTempTarea(Rec, TempSalesLine, 0, TotalSalesLine,
                                        TotalSalesLineLCY, Rec.GETFILTER("Filtro fase"), TotalSalesLine, TotalSalesLineLCY);
        END;
    END;

    PROCEDURE TotalesDocumentos();
    VAR
        TempSalesLine: Record 37 TEMPORARY;
        rCabVenta: Record 36;
    BEGIN
        //FCL-13/02/06. Obtengo totales de borradores y facturas correspondientes a este contrato.
        ImpBorFac := 0;
        ImpBorAbo := 0;
        ImpFac := 0;
        ImpAbo := 0;
        if (Rec."Borradores de Factura" <> 0) OR (Rec."Borradores de Abono" <> 0) THEN BEGIN
            rCabVenta.RESET;
            rCabVenta.SETCURRENTKEY("Nº Proyecto");
            rCabVenta.SETRANGE("Nº Proyecto", Rec."Nº Proyecto");
            rCabVenta.SETRANGE("Nº Contrato", Rec."No.");
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
                        ImpBorFac := ImpBorFac + TotalSalesLineLCY."Amount Including VAT";
                    END
                    ELSE BEGIN
                        ImpBorAbo := ImpBorAbo + TotalSalesLineLCY."Amount Including VAT";
                    END;
                UNTIL rCabVenta.NEXT = 0;
            END;
        END;
        if Rec."Facturas Registradas" <> 0 THEN BEGIN
            rCabFac.RESET;
            rCabFac.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
            rCabFac.SETRANGE("Nº Contrato", Rec."No.");
            if rCabFac.FIND('-') THEN BEGIN
                REPEAT
                    rCabFac.CALCFIELDS("Amount Including VAT");
                    ImpFac := ImpFac + rCabFac."Amount Including VAT";
                UNTIL rCabFac.NEXT = 0;

            END;
        END;
        if Rec."Abonos Registrados" <> 0 THEN BEGIN
            rCabAbo.RESET;
            rCabAbo.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
            rCabAbo.SETRANGE("Nº Contrato", Rec."No.");
            if rCabAbo.FIND('-') THEN BEGIN
                REPEAT
                    rCabAbo.CALCFIELDS("Amount Including VAT");
                    ImpAbo := ImpAbo + rCabAbo."Amount Including VAT";
                UNTIL rCabAbo.NEXT = 0;
            END;
        END;
        TotImp := ImpBorFac - ImpBorAbo + ImpFac - ImpAbo;
    END;

}
page 7001132 "Referencias Catastrales"
{
    PageType = ListPart;
    SourceTable = "Ref Catastral Address";
    layout
    {
        area(Content)
        {

            Repeater(Detalle)
            {
                field("Ref. catastral"; Rec."Ref. catastral") { ApplicationArea = All; }
                field("Vendor No."; Rec."Vendor No.") { ApplicationArea = All; }
                field(Code; Rec.Code) { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Name 2"; Rec."Name 2") { ApplicationArea = All; }
                field(Address; Rec.Address) { ApplicationArea = All; }
                field("Address 2"; Rec."Address 2") { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field(Contact; Rec.Contact) { ApplicationArea = All; }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field("Telex No."; Rec."Telex No.") { ApplicationArea = All; }
                field("Country/Region Code"; Rec."Country/Region Code") { ApplicationArea = All; }
                field("Last Date Modified"; Rec."Last Date Modified") { ApplicationArea = All; }
                field("Fax No."; Rec."Fax No.") { ApplicationArea = All; }
                field("Telex Answer Back"; Rec."Telex Answer Back") { ApplicationArea = All; }
                field("Post Code"; Rec."Post Code") { ApplicationArea = All; }
                field(County; Rec.County) { ApplicationArea = All; }
                field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
                field("Home Page"; Rec."Home Page") { ApplicationArea = All; }
                field("Situación inmueble"; Rec."Situación inmueble") { ApplicationArea = All; }
            }
        }
    }
}
page 7001133 "Ficha Soporte"
{
    //Version List=MLL;
    SourceTable = 23;
    //UpdateOnActivate=Yes;
    PageType = Card;
    SourceTableView = WHERE(Soporte = CONST(true));

    layout
    {
        area(Content)
        {
            //PageNamesML=ESP=General,Facturacion }
            field("No."; Rec."No.") { ApplicationArea = All; }
            field("Pay-to Vendor No."; Rec."Pay-to Vendor No.") { ApplicationArea = All; }
            field("Name"; Rec.Name) { ApplicationArea = All; }
            field("Name 2"; Rec."Name 2") { ApplicationArea = All; }
            field("Address"; Rec.Address) { ApplicationArea = All; }
            field("Address 2"; Rec."Address 2") { ApplicationArea = All; }
            field("City"; Rec.City) { ApplicationArea = All; Caption = 'C.P.+Población'; }
            field("Country/Region Code"; Rec."Country/Region Code") { ApplicationArea = All; }
            field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
            field("Contact"; Rec.Contact) { ApplicationArea = All; }
            field("Search Name"; Rec."Search Name") { ApplicationArea = All; }
            field("VAT Registration No."; Rec."VAT Registration No.") { ApplicationArea = All; }
            field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
            field("Fax No."; Rec."Fax No.") { ApplicationArea = All; }
            field("Blocked"; Rec.Blocked) { ApplicationArea = All; }
            field("Last Date Modified"; Rec."Last Date Modified") { ApplicationArea = All; }
            field("Post Code"; Rec."Post Code") { ApplicationArea = All; }
            field("Medio"; Rec.Medio) { ApplicationArea = All; }
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group") { ApplicationArea = All; }
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group") { ApplicationArea = All; }
            field("Vendor Posting Group"; Rec."Vendor Posting Group") { ApplicationArea = All; }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("&Comentarios")
            {
                ApplicationArea = ALL;
                Image = Comment;
                ToolTip = 'Comentario';
                RunObject = Page 124;
                //RunPageLinkType=OnUpdate;
                RunPageLink = "Table Name" = CONST(Vendor),
            "No." = FIELD("No.");
            }



            action("&Lista")
            {
                Image = List;
                ShortCutKey = F5;
                ApplicationArea = All;
                Caption = '&Lista';
                trigger OnAction()
                var
                    Vendor: Record Vendor;
                begin
                    Vendor.SetRange(Soporte, true);
                    Page.RunModal(0, Vendor);
                end;


            }
            action("&Tarifas")
            {
                Caption = '&Tarifas';
                trigger OnAction()
                BEGIN
                    CLEAR(fTarifas);
                    fTarifas.PasaParam(Rec."No.");
                    fTarifas.RUNMODAL;
                END;
            }
        }
    }

    VAR
        fTarifas: Page "Gestion tarifas de publicidad";

    trigger OnAfterGetRecord()
    BEGIN
        Rec.SETRANGE("No.");
    END;

    trigger OnNewRecord(BelowxRex: Boolean)
    BEGIN
        Rec.Soporte := TRUE;
    END;
}
page 7001135 "Lista comentarios publicidad"
{
    //Version List=MLL;
    //area(Content){ Repeater(Detalle){ID=1103355000;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Comentario orden publicidad";
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Fecha"; Rec.Fecha) { ApplicationArea = All; }
                field("Comentario"; Rec.Comentario) { ApplicationArea = All; }
            }
        }
    }
}
page 7001136 "Subform texto orden publicidad"
{
    PageType = ListPart;
    //Version List=MLL;
    Caption = 'Texto orden publicidad';
    MultipleNewLines = true;
    //area(Content){ Repeater(Detalle){ID=1;
    SourceTable = "Texto orden publicidad";
    AutoSplitKey = true;
    DelayedInsert = true;
    DataCaptionFields = "No.";
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("Texto"; Rec.Texto) { ApplicationArea = All; }

            }
        }
    }
}
page 7001138 "Lista Facturas Propuestas"
{
    //Version List=MLL;
    PageType = List;
    UsageCategory = Lists;
    InsertAllowed = true;
    DeleteAllowed = true;
    ModifyAllowed = true;
    //area(Content){ Repeater(Detalle){ID=1103355000;
    SourceTable = "Facturas Propuestas";
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                field("No. Contrato"; Rec."No. Contrato") { ApplicationArea = All; Editable = false; }

                field("Fecha Contrato"; Rec."Fecha Contrato") { ApplicationArea = All; Editable = false; }

                field("No. Proyecto"; Rec."No. Proyecto") { ApplicationArea = All; Editable = false; }

                field("Fecha Factura"; Rec."Fecha Factura") { ApplicationArea = All; }
                field("Texto de registro"; Rec."Texto de registro") { ApplicationArea = All; }
                field("Importe sin IVA"; Rec."Importe sin IVA") { ApplicationArea = All; }
                field("Importe con IVA"; Rec."Importe con IVA") { ApplicationArea = All; }
                field("Cód. Forma Pago"; Rec."Cód. Forma Pago") { ApplicationArea = All; }
                field("Cód. Términos Pago"; Rec."Cód. Términos Pago") { ApplicationArea = All; }
                field("Fecha Vencimiento"; Rec."Fecha Vencimiento") { ApplicationArea = All; }
                field("Cód. términos facturacion"; Rec."Cód. términos facturacion") { ApplicationArea = All; }
                field("Tipo Facturación"; Rec."Tipo Facturación") { ApplicationArea = All; Editable = false; }
                field("Customer Order No."; Rec."Customer Order No.") { ApplicationArea = All; }
            }
        }
    }
}
page 7001139 "Lista ordenes publicidad"
{
    //Version List=MLL;
    PageType = List;
    UsageCategory = Lists;
    Editable = false;
    //area(Content){ Repeater(Detalle){ID=1103355000;
    SourceTable = "Cab. orden publicidad";
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("Tipo orden"; Rec."Tipo orden") { ApplicationArea = All; }
                field("No"; Rec.No) { ApplicationArea = All; }
                field("No cliente"; Rec."No cliente") { ApplicationArea = All; }
                field("Nombre cliente"; Rec."Nombre cliente") { ApplicationArea = All; }
                field("Cod. Soporte"; Rec."Cod. Soporte") { ApplicationArea = All; }
                field("Nombre Soporte"; Rec."Nombre Soporte") { ApplicationArea = All; }
                field("Concepto"; Rec.Concepto) { ApplicationArea = All; }
                field("Seccion"; Rec.Seccion) { ApplicationArea = All; }
                field("Fecha creacion"; Rec."Fecha creacion") { ApplicationArea = All; }
                field("Estado"; Rec.Estado) { ApplicationArea = All; }
                field("Usuario creacion"; Rec."Usuario creacion") { ApplicationArea = All; }
                field("Alto"; Rec.Alto) { ApplicationArea = All; }
                field("Ancho"; Rec.Ancho) { ApplicationArea = All; }
                field("Importe"; Rec.Importe) { ApplicationArea = All; }
                field("Duracion"; Rec.Duracion) { ApplicationArea = All; }
            }
        }
    }
}
page 7001140 "Job List Temp"
{
    //Version List=TEMPORAL;
    PageType = List;
    UsageCategory = Lists;
    Editable = true;
    Caption = 'Lista de proyectos Temporal';
    //area(Content){ Repeater(Detalle){ID=1;
    SourceTable = 167;
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Proyecto original"; Rec."Proyecto original") { ApplicationArea = All; }
                field("Proyecto origen"; Rec."Proyecto origen")
                {
                    ApplicationArea = All;
                    Caption = 'Proyecto anterior';
                }
                field(Description; Rec.Description) { ApplicationArea = All; Editable = false; }

                field("Bill-to Name"; Rec."Bill-to Name") { ApplicationArea = All; }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.") { ApplicationArea = All; }
                field("Cód. vendedor"; Rec."Cód. vendedor") { ApplicationArea = All; }
                field("Creation Date"; Rec."Creation Date") { ApplicationArea = All; }
                field("Starting Date"; Rec."Starting Date") { ApplicationArea = All; }
                field("Ending Date"; Rec."Ending Date") { ApplicationArea = All; }
                field("Antiguo proyecto original"; Rec."Antiguo proyecto original") { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Ver &proyecto")
            {
                Image = Card;
                ApplicationArea = ALL;
                Caption = 'Ver &proyecto';
                RunObject = Page 88;
                RunPageView = SORTING("No.");
                RunPageLink = "No." = FIELD("No.");
            }
        }
    }

    //     BEGIN
    //     END.
    //   }
}
page 7001141 "Equiv. Términos Facuración"
{
    //Version List=FH3.70;
    //area(Content){ Repeater(Detalle){ID=1;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Equi. Términos Facuración";
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("Duración Contrato"; Rec."Duración Contrato") { ApplicationArea = All; }
                field("Código Terminos"; Rec."Código Terminos") { ApplicationArea = All; Caption = 'Código Terminos Facturación'; }
            }
        }
    }
}
page 7001142 "Comer - Control contab. ptes"
{
    //Version List=FH3.70,ES;
    SaveValues = true;
    PageType = List;
    UsageCategory = Lists;
    //area(Content){ Repeater(Detalle){ID=16;
    SourceTable = 265;
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; }
                field("Table ID"; Rec."Table ID") { ApplicationArea = All; }
                field("Table Name"; Rec."Table Name") { ApplicationArea = All; }

                field("No. of Records"; Rec."No. of Records") { ApplicationArea = All; DrillDown = true; }
            }
        }
    }
    VAR
        Text000: Label 'No se ha indicado tipo negocio.';
        Text001: Label 'No existe información registrada con el nº documento externo indicado.';
        Text002: Label 'Contando registros...';
        Text003: Label 'Historical sale invoices;ESP=Histórico facturas venta';
        Text004: Label 'Hotel Invoices;ESP=Facturas Hotel';
        Text005: Label 'Historical sale credits;ESP=Histórico abonos venta';
        Text006: Label 'Histórico albaranes venta';
        Text007: Label 'Recordatorio emitido';
        Text008: Label 'Doc. interés emitido';
        Text009: Label 'Historical purchase invoices;ESP=Histórico facturas compra';
        Text010: Label 'Histórico abono compra';
        Text011: Label 'Histórico albaranes compra';
        Text012: Label 'El mismo nº documento se ha utilizado en varios documentos';
        Text013: Label 'La combinación del nº documento y fecha registro se ha utilizado más de una vez.';
        Text014: Label 'No existe información registrada con el nº documento indicado.';
        Text015: Label 'No existe información registrada con esta combinación de nº documento y fecha de registro.';
        Text016: Label 'El resultado de la búsqueda incluye demasiados documentos externos. Indique un valor en tipo negocio.';
        Text017: Label 'El resultado de la búsqueda incluye demasiados documentos. Utilice Navegar desde otros movimientos más aproximados.';
        Text018: Label 'Sólo se puede imprimir desde la misma empresa.';
        Text019: Label 'Esta información no se puede imprimir.';
        Text020: Label 'FAC00001';
        rSec: Record "Gen. Journal Batch";
        rDir: Record "Gen. Journal Line";
        DocMov: Record 265 TEMPORARY;
        Ventana: Dialog;
        FiltNoAgr: Code[250];
        FiltNoFacVta: Code[250];
        FiltNoFacCom: Code[250];
        NoDocExt: Code[250];
        NueFechaRegi: Date;
        TipoDoc: Text[30];
        TipoOrigen: Text[30];
        NoOrigen: Code[20];
        NombOrigen: Text[50];
        TipoContact: Option ,Proveedor;
        ExisteDoc: Boolean;
        EmpresaBuscar: Text[30];
        ComplejoBuscar: Code[10];
        AgrupaciónBuscar: Code[12];
        Con: Record "General Ledger Setup";
        rEmp: Record 2000000006;
        wFiltro: Text[250];
        Leido: Integer;
        SumaImporte: Decimal;

    trigger OnOpenPage()
    BEGIN
        DocMov.DELETEALL;
        BuscarRegs;
    END;

    trigger OnFindRecord(which: Text): Boolean
    BEGIN
        DocMov := Rec;
        if NOT DocMov.FIND(Which) THEN
            EXIT(FALSE);
        Rec := DocMov;
        EXIT(TRUE);
    END;

    trigger OnNextRecord(Steps: Integer): Integer
    VAR
        PasosEnCurso: Integer;
    BEGIN
        DocMov := Rec;
        PasosEnCurso := DocMov.NEXT(Steps);
        if PasosEnCurso <> 0 THEN
            Rec := DocMov;
        EXIT(PasosEnCurso);
    END;

    LOCAL PROCEDURE BuscarRegs();
    var
        Coltrol: Codeunit ControlProcesos;
    BEGIN
        // MostrarRegs;
        DocMov.DELETEALL;
        DocMov."Entry No." := 0;
        rEmp.RESET;

        rEmp.SetRange("Evaluation Company", false);
        if rEmp.FIND('-') THEN
            REPEAT
                if Coltrol.Permiso_Empresas(rEmp.Name) then begin
                    EmpresaBuscar := rEmp.Name;
                    if (EmpresaBuscar <> '') THEN BEGIN
                        rSec.CHANGECOMPANY(EmpresaBuscar);
                        rDir.CHANGECOMPANY(EmpresaBuscar);
                        WITH DocMov DO BEGIN
                            Ventana.OPEN(Text002);
                            if rSec.READPERMISSION THEN BEGIN
                                rSec.RESET;
                                if rSec.FIND('-') THEN
                                    REPEAT
                                        Leido := 0;
                                        SumaImporte := 0;
                                        rDir.RESET;
                                        rDir.SETRANGE("Journal Template Name", rSec."Journal Template Name");
                                        rDir.SETRANGE("Journal Batch Name", rSec.Name);
                                        if rDir.FIND('-') THEN
                                            REPEAT
                                                Leido := Leido + 1;
                                                SumaImporte := SumaImporte + rDir."Debit Amount" - rDir."Credit Amount";
                                            UNTIL rDir.NEXT = 0;
                                        if (Leido > 0) OR (SumaImporte <> 0) THEN BEGIN
                                            DocMov.INIT;
                                            DocMov."Entry No." := DocMov."Entry No." + 1;
                                            DocMov."Table ID" := DATABASE::"Gen. Journal Batch";
                                            DocMov."Table Name" := rSec."Journal Template Name" + '/' + rSec.Name;
                                            DocMov."No. of Records" := Leido;
                                            // DocMov.Empresa := EmpresaBuscar;
                                            DocMov.INSERT;
                                        END;
                                    UNTIL rSec.NEXT = 0;
                            END;
                        END;
                    END;
                end;
            UNTIL rEmp.NEXT = 0;
        CurrPage.UPDATE(FALSE);
        ExisteDoc := Rec.FIND('-');
        //CurrPageE;
    END;

    LOCAL PROCEDURE MostrarRegs();
    BEGIN
        DocMov := Rec;
        if DocMov.FIND THEN
            Rec := DocMov;
        WITH DocMov DO
            CASE "Table ID" OF
                DATABASE::"Gen. Journal Batch":
                    BEGIN
                        //        rDir.CHANGECOMPANY(Empresa);
                        rDir.SETRANGE("Journal Template Name", rSec."Journal Template Name");
                        rDir.SETRANGE("Journal Batch Name", rSec.Name);
                        PAGE.RUNMODAL(0, rDir);
                    END;
            END;
    END;
    // BEGIN
    // {
    //   // PLB 07/08/2000
    //   Imprimir la información correspondiente
    // }
    // END.

}
page 7001143 "Documentos excel"
{
    //Version List=FH4.00;
    PageType = Card;
    SourceTable = "Documentos Excel";
    layout
    {
        area(Content)
        {
            field("Código Excel"; Rec."Código Excel") { ApplicationArea = All; }
            field("Nombre documento Excel"; Rec."Nombre documento Excel") { ApplicationArea = All; }
            field("Documento"; Rec.Documento) { ApplicationArea = All; }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Import)
            {
                Caption = 'Im&portar';
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                var
                    InsStream: InStream;
                    OutStream: OutStream;
                BEGIN
                    Rec.CALCFIELDS(Documento);
                    ExisteImagen := Rec.Documento.HASVALUE;
                    UploadIntoStream('Importar documento', '', 'Excel files (*.xls)|*.xls', wNomDoc, InsStream);
                    Rec.Documento.CreateOutStream(OutStream);
                    CopyStream(OutStream, InsStream);
                    //Rec.Modify();
                    //wNomDoc := Rec.Documento.IMPORT(Text000);//, TRUE);
                    if wNomDoc = '' THEN
                        EXIT;
                    if ExisteImagen THEN
                        if NOT CONFIRM(Text001, FALSE) THEN
                            EXIT;
                    Rec."Nombre documento Excel" := fNomDoc(wNomDoc);
                    CurrPage.SAVERECORD;
                END;
            }
            action("E&xport")
            {
                ApplicationArea = All;
                Caption = 'E&xportar';
                Image = Export;
                trigger OnAction()
                var
                    Fichero: Text;
                    AttachmentStream: InStream;
                BEGIN
                    REC.CALCFIELDS(Documento);
                    if Rec.Documento.HASVALUE THEN begin
                        Rec.Documento.CreateInStream(AttachmentStream);
                        Fichero := Text000;
                        DownloadFromStream(AttachmentStream, 'Guardar Contrato', '', 'Pdf files (*.pdf)|*.pdf', Fichero);
                        //Rec.Documento.EXPORT(Text000);//, TRUE);
                    end;
                END;
            }
            action("E&liminar")
            {
                ApplicationArea = All;
                Image = Delete;
                Caption = 'E&liminar';
                trigger OnAction()
                BEGIN
                    Rec.CALCFIELDS(Documento);
                    if Rec.Documento.HASVALUE THEN
                        if CONFIRM(Text002, FALSE) THEN BEGIN
                            CLEAR(Rec.Documento);
                            CurrPage.SAVERECORD;
                        END;
                END;
            }
        }
    }
    VAR
        ExisteImagen: Boolean;
        Text000: Label '*.bmp;ESP=*.xls';
        Text001: Label 'Confirm if one wants  to replace the previous image?;ESP=¿Confirma que desea reemplazar el documento anterior?';
        Text002: Label 'Confirm if one wants to delete the image?;ESP=¿Confirma que desea eliminar el documento?';
        wNomDoc: Text[250];

    PROCEDURE fNomDoc(pNomDoc: Text[250]): Text[30];
    BEGIN
        if STRPOS(pNomDoc, '\') <> 0 THEN
            REPEAT
                pNomDoc := COPYSTR(pNomDoc, STRPOS(pNomDoc, '\') + 1, STRLEN(pNomDoc) - STRPOS(pNomDoc, '\'));
            UNTIL STRPOS(pNomDoc, '\') = 0;
        EXIT(COPYSTR(pNomDoc, 1, 30));
    END;

}
// page 7001190 "Logo NaviHotel"
// {

//     //Version List=FH5.00,LAB;
//     PageType = Card;
//     SourceTable = "Documentos Excel";

//     layout
//     {
//         area(Content)
//         {
//             field(Documento; Rec.Documento)
//             {
//                 ApplicationArea = All;
//             }
//             field("Retorna Hotel"; RetornaHotel) { ApplicationArea = All; Editable = false; }

//         }
//     }
//     VAR
//         strNombre: Text[250];

//     trigger OnOpenPage()
//     BEGIN
//         //if COMPANYNAME='Grepsa' THEN
//         //GET('LOGOG')
//         //ELSE
//         Rec.GET('LOGO');
//         Rec.CALCFIELDS(Documento);
//     END;

//     trigger OnNextRecord(Steps: Integer): Integer
//     BEGIN
//         // +001
//         EXIT(0);
//         // -001
//     END;

//     PROCEDURE RetornaHotel(): Text[250];
//     VAR
//         rSes: Record 2000000009;
//     BEGIN
//         //   {rUser.GET(USERID    );
//         //   rUsu.GET(USERID);
//         //   strNombre := rUsu."User ID";
//         //   if rUsu.Name <> '' THEN
//         //     strNombre := rUsu.Name;
//         //   if rHot.GET(rUser."Hotel de trabajo") THEN
//         //     strHotel := rHot.Nombre + '  (' + strNombre + ')'
//         //   ELSE
//         //     strHotel := rUser."Hotel de trabajo" + '  (' + strNombre + ')';
//         //    }
//         rSes.SETRANGE(rSes."Database Name", 'msdb');
//         if rSes.FINDFIRST THEN strNombre := rSes."Host Name";
//         //CurrPage.Ret64.VISIBLE := TRUE;
//         //CurrPage.Ret32.VISIBLE:=TRUE;
//         EXIT('Servidor: ' + '-' + strNombre + '-' + COMPANYNAME + '  (' + USERID + ')');
//     END;
//     //     BEGIN
//     //     {
//     //       001 18-10-06 LIS: Evitamos que puedan cambiar  de registro
//     //     }
//     //     END.
//     //   }
// }
page 7001145 "Customer/Vendor Warnings 349 M"
{
    //Version List=;
    //area(Content){ Repeater(Detalle){ID=1000000000;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Customer/Vendor Warning 349";
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                field("Include Correction"; Rec."Include Correction") { ApplicationArea = All; ShowCaption = false; }

                field("Type"; Rec.Type) { ApplicationArea = All; }
                field("Customer/Vendor No."; Rec."Customer/Vendor No.") { ApplicationArea = All; }
                field("Customer/Vendor Name"; Rec."Customer/Vendor Name") { ApplicationArea = All; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                field("Previous Declared Amount"; Rec."Previous Declared Amount") { ApplicationArea = All; }
                field("Original Declaration FY"; Rec."Original Declaration FY") { ApplicationArea = All; }
                field("Original Declaration Period"; Rec."Original Declaration Period") { ApplicationArea = All; }
                field("Original Declared Amount"; Rec."Original Declared Amount") { ApplicationArea = All; }
                field("Sign"; Rec.Sign) { ApplicationArea = All; }
                field(Exported; Rec.Exported) { ApplicationArea = All; ShowCaption = false; }

                field("VAT Entry No."; Rec."VAT Entry No.") { ApplicationArea = All; }
                field("Delivery Operation Code"; Rec."Delivery Operation Code") { ApplicationArea = All; }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade") { ApplicationArea = All; ShowCaption = false; }

                field("EU Service"; Rec."EU Service") { ApplicationArea = All; ShowCaption = false; }

                field("Texto Error"; Rec."Texto Error") { ApplicationArea = All; }
                field("Clave registro"; Rec."Clave registro") { ApplicationArea = All; }
                field("Situación inmueble"; Rec."Situación inmueble") { ApplicationArea = All; }
                field("Ref. catastral"; Rec."Ref. catastral") { ApplicationArea = All; }
                field("Document Type"; Rec."Document Type") { ApplicationArea = All; }
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; }
            }
        }
    }

}
page 7001156 "Clientes - Cuentas anticipo"
{
    //Version List=FH3.70,FINTIS;
    InsertAllowed = false;
    DeleteAllowed = false;
    //area(Content){ Repeater(Detalle){ID=1;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = 18;
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Name"; Rec.Name) { ApplicationArea = All; }
                field("Cuenta anticipo"; Rec."Cuenta anticipo") { ApplicationArea = All; }
                field(NomCuenta; NombreCuenta(Rec."Cuenta anticipo"))
                {
                    ApplicationArea = All;
                    Caption = 'Nombre cuenta';
                }
            }
        }
    }
    PROCEDURE NombreCuenta(par_Cuenta: Text[20]): Text[30];
    VAR
        rCuenta: Record 15;
    BEGIN
        if rCuenta.GET(par_Cuenta) THEN
            EXIT(rCuenta.Name);
        EXIT('');
    END;

}
page 7001144 "Lista Referencias Catastrales"
{
    PageType = List;
    SourceTable = "Ref Catastral Address";
    layout
    {
        area(Content)
        {

            Repeater(Detalle)
            {
                field("Ref. catastral"; Rec."Ref. catastral") { ApplicationArea = All; }
                field("Vendor No."; Rec."Vendor No.") { ApplicationArea = All; }
                field(Code; Rec.Code) { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Name 2"; Rec."Name 2") { ApplicationArea = All; }
                field(Address; Rec.Address) { ApplicationArea = All; }
                field("Address 2"; Rec."Address 2") { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field(Contact; Rec.Contact) { ApplicationArea = All; }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field("Telex No."; Rec."Telex No.") { ApplicationArea = All; }
                field("Country/Region Code"; Rec."Country/Region Code") { ApplicationArea = All; }
                field("Last Date Modified"; Rec."Last Date Modified") { ApplicationArea = All; }
                field("Fax No."; Rec."Fax No.") { ApplicationArea = All; }
                field("Telex Answer Back"; Rec."Telex Answer Back") { ApplicationArea = All; }
                field("Post Code"; Rec."Post Code") { ApplicationArea = All; }
                field(County; Rec.County) { ApplicationArea = All; }
                field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
                field("Home Page"; Rec."Home Page") { ApplicationArea = All; }
                field("Situación inmueble"; Rec."Situación inmueble") { ApplicationArea = All; }
            }
        }
    }
}
