/// <summary>
/// Page Ficha Contrato Venta (ID 50013).
/// </summary>
page 50209 "Ficha Contrato Venta"
{

    Caption = 'Contratos Venta';
    PageType = Document;
    //PromotedActionCategoriesML = ESP = 'Nuevo,Procesar,Informe,Aprobar,Lanzar,Registrar,Preparar,Pedido,Solicitar aprobación,Historial,Imprimir y enviar,Navegar';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    Permissions = TableData 17 = rimd,
    TableData 36 = rimd,
    TableData 37 = rimd,
    TableData "Sales Comment Line" = rimd;
    layout
    {
        area(content)
        {


            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifique el número del contrato.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }

                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nº Cliente';
                    Importance = Additional;
                    NotBlank = true;
                    ToolTip = 'Especifique el número del cliente al que enviar el contrato.';

                    trigger OnValidate()
                    begin
                        Rec.SelltoCustomerNoOnAfterValidate(Rec, xRec);
                        CurrPage.Update;
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Venta a Nombre cliente';
                    ShowMandatory = true;
                    ToolTip = 'Especifique el nombre del cliente que recibirá el contrato.';

                    trigger OnValidate()
                    begin
                        Rec.SelltoCustomerNoOnAfterValidate(Rec, xRec);

                        if ApplicationAreaMgmtFacade.IsFoundationEnabled then
                            SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);

                        CurrPage.Update;
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if Rec.LookupSellToCustomerName(Rec."Sell-to Customer Name") then
                            CurrPage.Update();
                    end;
                }
                field("Venta-a Dirección"; Rec."Sell-to Address") { ApplicationArea = All; }
                field("Posting Description"; Rec."Posting Description")
                {
                    Caption = 'Texto de Registro';
                    ApplicationArea = Suite;
                    ToolTip = 'Texto del contrato.';
                    //Visible = false;
                }
                field("Nombre Comercial"; Rec."Nombre Comercial")
                {
                    Caption = 'Anunciante';
                    ApplicationArea = All;
                }
                field("Nº pedido"; Rec."Nº pedido")
                {
                    ApplicationArea = All;
                }
                field("Nº pedido cliente"; Rec."Customer Order No.")
                {
                    ApplicationArea = All;
                }
                // group("Datos Adicionales")
                // {

                // }

                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contacto';
                    Editable = Rec."Sell-to Customer No." <> '';
                    ToolTip = 'Especifique el nombre de la persona de contacto en el cliente.';
                }

                field("No. de versiones archivadas"; Rec."No. of Archived Versions")
                {
                    Caption = 'Versiones archivadas';
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Especifique el número de versiones archivadas para este contrato.';
                }
                // group("Tipo facturación ")
                // {
                field("Facturacion Iniciada"; Rec."Facturacion Iniciada")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Tipo Facturacion"; Rec."Tipo Facturacion")
                {
                    ApplicationArea = All;
                }


                //}
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    Caption = 'Fecha emisión documento';
                    ToolTip = 'Especifique la fecha de creación del contrato.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fecha Registro';
                    Importance = Promoted;
                    ToolTip = 'Especifique la fecha de registro del contrato.';


                }
                field("Order Date"; Rec."Order Date")
                {
                    Caption = 'Fecha Contrato';
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Especifique la fecha del contrato.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    Caption = 'Fecha Vto.';
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Especifique la fecha del vto. contrato.';
                }

                field("Proyecto No."; Rec."Nº Proyecto") { Caption = 'Nº proyecto'; Editable = false; ApplicationArea = All; }
                field("Fecha inicial proyecto"; Rec."Fecha inicial proyecto") { ApplicationArea = All; }//Editable = false; }
                field("Fecha Fin proyecto"; Rec."Fecha fin proyecto") { ApplicationArea = All; }
                field("Contrato Origen"; wContOrigen) { ApplicationArea = All; }
                field("Contrato Modificado"; Rec."Contrato modificado") { ApplicationArea = All; }
                // group(GRenovado)
                // {
                //     ShowCaption = false;
                field(Renovado; Rec.Renovado)
                {
                    ApplicationArea = All;
                }
                field(Tipo; Rec."Tipo") { ApplicationArea = All; }
                field("Ofrecida ampliación"; Rec."Ofrecida ampliación") { ApplicationArea = All; }

                // }
                field("Contrato Renovación"; wContRenov) { ApplicationArea = All; }
                field("Contrato Renovable ?"; not Rec."Contrato no Renovable")
                {
                    ApplicationArea = ALL;
                    trigger OnValidate()
                    begin
                        Rec."Contrato No Renovable" := not Rec."Contrato no Renovable";
                    end;
                }
                field("Fecha renovacion"; Rec."Fecha renovacion") { ApplicationArea = All; }
                field("Estado Contrato"; Rec.Estado) { ApplicationArea = All; }
                field("Fecha Estado"; Rec."Fecha Estado") { ApplicationArea = All; }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Especifique la fecha then el cliente has asked for the order to be delivered.';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    Visible = false;
                    ApplicationArea = OrderPromising;
                    Importance = Additional;
                    ToolTip = 'Especifique la fecha that you have promised to deliver the order, as a result of the Order Promising function.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Caption = 'Nº documento Externo';
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ShowMandatory = ExternalDocNoMandatory;
                    ToolTip = 'Especifique una document number that refers al cliente''s or vendor''s numbering system.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    Caption = 'Su/Nuestra ref.';
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Especifique la customer''s reference. The content will be printed on sales documents.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Caption = 'Vendedor';
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Especifique el nombre of the salesperson who is assigned al cliente.';


                }
                field("Nuevo Vendedor asignado"; Rec."Nuevo Vendedor asignado") { ApplicationArea = All; }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Visible = false;
                    Caption = 'Campaña';
                    ApplicationArea = RelationshipMgmt;
                    Importance = Additional;
                    ToolTip = 'Especifique la número del campaign that the document is linked to.';
                }
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    Caption = 'Oportunidad';
                    ApplicationArea = RelationshipMgmt;
                    Importance = Additional;
                    ToolTip = 'Especifique la número del opportunity that the sales quote is assigned to.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Visible = false;
                    Caption = 'Centro Responsabilidad';
                    AccessByPermission = TableData "Responsibility Center" = R;
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Especifique la code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Caption = 'Usuario Asignado';
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Especifique la ID of the user who is responsible for the document.';
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    Caption = 'Estado Cola';
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Especifique la status of a job queue entry or task that handles the posting of sales orders.';
                    Visible = JobQueuesUsed;
                }
                field("Ampliación Covit19"; Rec."Ampliación Covit19")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    StyleExpr = StatusStyleTxt;
                    QuickEntry = false;
                }
                group("Work Description")
                {
                    Caption = 'Descripción Trabajo';
                    field(WorkDescription; WorkDescription)
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Especifique la descripción del trabajo ofrecido.';

                        trigger OnValidate()
                        begin
                            Rec.SetWorkDescription(WorkDescription);
                        end;
                    }
                }
            }
            group(Estadísticas)
            {
                group(Borradores)
                {

                    field("Borradores de Factura"; Rec."Borradores de Factura") { ApplicationArea = All; DrillDownPageId = "Lista documentos venta MLL"; }

                    field("Importe Borr. Facturas"; ImpBorFac) { ApplicationArea = All; }
                    field("Borradores de Abono"; Rec."Borradores de Abono") { ApplicationArea = All; DrillDownPageId = "Lista documentos venta MLL"; }

                    field("Importe Borr. Abonos"; ImpBorAbo)
                    {
                        ApplicationArea = All;
                        //DrillDownPageId = "Lista documentos venta MLL";
                    }
                    field("Borradores de compra"; Rec."Borradores de cOMPRA") { ApplicationArea = All; DrillDownPageId = "Purchase Invoices"; }
                    field("Importe Borradores Compra"; ImporteBorradorCompra())
                    {
                        ApplicationArea = All;
                    }
                }
                group(Históricos)
                {

                    field("Facturas Registradas"; Rec."Facturas Registradas")
                    {
                        ApplicationArea = All;
                        DrillDownPageId = "Posted Sales Invoices";
                    }
                    field("Abonos Registrados"; Rec."Abonos Registrados")
                    {
                        ApplicationArea = All;
                        DrillDownPageId = "Posted Sales Credit Memos";
                    }
                    field("Albaranes Registrados"; Rec."Albaranes Registrados") { ApplicationArea = ALL; }
                    field("Importe facturas y Abonos"; ImpFac - ImpAbo)
                    {
                        ApplicationArea = All;
                        trigger OnDrillDown()
                        var
                            Cab: Record "Sales Invoice Header";
                            CabAbo: Record "Sales Cr.Memo Header";
                        begin
                            Cab.SetRange("Nº Proyecto", Rec."Nº Proyecto");
                            Page.RunModal(0, Cab);
                            CabAbo.SetRange("Nº Proyecto", Rec."Nº Proyecto");
                            If CabAbo.FindSet() then
                                Page.RunModal(0, CabAbo);


                        end;
                    }
                    //field("Importe abonos"; ImpAbo) { ApplicationArea = All; }
                    field("Facturas Compra"; Rec."Borradores Compra")
                    {
                        ApplicationArea = All;
                        DrillDownPageId = "Posted Purchase Invoices";
                    }
                    field("Abonos Compra"; Rec."Abonos Compra")
                    {
                        ApplicationArea = All;
                        DrillDownPageId = "Posted Purchase Credit Memos";
                    }

                    field("Importe compras"; ImporteCompra())
                    {
                        ApplicationArea = All;
                        trigger OnDrillDown()
                        var
                            Cab: Record "Purch. Inv. Header";
                            CabAbo: Record "Purch. Cr. Memo Hdr.";
                        begin
                            Cab.SetRange("Nº Proyecto", Rec."Nº Proyecto");
                            Page.RunModal(0, Cab);
                            CabAbo.SetRange("Nº Proyecto", Rec."Nº Proyecto");
                            If CabAbo.FindSet() then
                                Page.RunModal(0, CabAbo);


                        end;

                    }
                }
                group(Diferencias)
                {

                    field("Total facturas"; TotImp) { ApplicationArea = All; }
                    field(Diferencia; TotCont - TotImp) { ApplicationArea = All; }
                }
                field("Pdte. Facturación"; (ImpBorFac - ImpBorAbo) + (TotCont - TotImp - ImpAbo)) { ApplicationArea = All; }
                field("Cuenta 485"; Importe485)
                {
                    ApplicationArea = All;
                    Caption = 'Cuenta 485';
                    trigger OnDrillDown()
                    var
                        Cab: Record "Sales Header";
                        AlbCab: Record "Sales Shipment Header";
                        HitCab: Record "Sales Invoice Header";
                        Lin: Record "Sales Line";
                        AlbLin: Record "Sales Shipment Line";
                        Hitlin: Record "Sales Invoice Line";
                        Lint: Record "Sales Line" temporary;
                        AlbLint: Record "Sales Shipment Line" temporary;
                        Hitlint: Record "Sales Invoice Line" temporary;
                        rMov: Record "G/L Entry";
                    begin
                        if Importe485 = 'Sin Calcular' then begin
                            Importe485 := Format(Cuenta485(), 0, '<Precision,2:3><Standard Format,0>');
                            Num_Contrato := Rec."No.";
                        end;
                        Cab.SetRange("Document Type", Cab."Document Type"::Invoice);
                        Cab.SetRange("Nº Contrato", Rec."No.");
                        if Cab.FindFirst() Then
                            repeat
                                Lin.SetRange("Document Type", Lin."Document Type"::Invoice);
                                Lin.SetFilter("No.", '485*');
                                Lin.SetRange("Document No.", Cab."No.");
                                if lin.FindFirst() Then
                                    repeat
                                        Lint := Lin;
                                        Lint.Insert();
                                    until lin.Next() = 0;
                            until Cab.Next() = 0;
                        // //Alb
                        // AlbCab.SetRange("Nº Contrato", Rec."No.");
                        // AlbCab.SetRange(Contabilizado, true);
                        // if AlbCab.FindFirst() Then
                        //     repeat
                        //         AlbLin.SetFilter("No.", '485*');
                        //         AlbLin.SetRange("Document No.", AlbCab."No.");
                        //         if AlbLin.FindFirst() Then
                        //             repeat
                        //                 AlbLint := AlbLin;
                        //                 AlbLint.Insert();
                        //             until AlbLin.Next() = 0;
                        //     until AlbCab.Next() = 0;
                        // //Hit
                        // HitCab.SetRange("Nº Contrato", Rec."No.");
                        // if HitCab.FindFirst() Then
                        //     repeat
                        //         Hitlin.SetFilter("No.", '485*');
                        //         Hitlin.SetRange("Document No.", HitCab."No.");
                        //         if Hitlin.FindFirst() Then
                        //             repeat
                        //                 Hitlint := Hitlin;
                        //                 Hitlint.Insert();
                        //             until Hitlin.Next() = 0;
                        //     until HitCab.Next() = 0;
                        // if lint.FindFirst() Then
                        //     Page.RunModal(0, Lint);
                        // if Alblint.FindFirst() Then
                        //     Page.RunModal(0, AlbLint);
                        // if Hitlint.FindFirst() Then
                        //     Page.RunModal(0, Hitlint);
                        rMov.SetRange("Núm. Contrato", Rec."No.");
                        rMov.SetRange("G/L Account No.", '485', '486');

                        Page.Runmodal(0, rMov);
                    end;
                }
            }
            field(AvisosVB; Avisos)
            {
                Visible = AVBVISIBLE;
            }
            field(AvisosVT; Avisos)
            {
                Visible = AVTVISIBLE;
            }
            field(AvisosVB2; Avisos)
            {
                Visible = AVB2VISIBLE;
            }
            part(SalesLines; "Sales Order Subform")
            {
                Caption = 'Líneas';
                ApplicationArea = Basic, Suite;
                Editable = DynamicEditable;
                Enabled = Rec."Sell-to Customer No." <> '';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            part(LineasImpresion; "Lineas de Impresión")
            {
                Caption = 'Líneas de Impresión';
                ApplicationArea = All;
                Enabled = Rec."Sell-to Customer No." <> '';
                SubPageLink = "Document Type" = CONST("Detalle Contrato"), "No." = FIELD("No.");
            }
            group("Sell-to")
            {
                Caption = 'Envio';
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dirección';
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Especifique la dirección del cliente.';
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dirección 2';
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Especifique la información adicional de la dirección';
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Población';
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Especifique la población del cliente en el contrato.';
                }
                group(Control123)
                {
                    ShowCaption = false;
                    Visible = IsSellToCountyVisible;
                    field("Sell-to County"; Rec."Sell-to County")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Provincia';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Especifique la provincia de la dirección.';
                    }
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Código Postal';
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Especifique el código postal.';
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'País';
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Especifique el país de la dirección.';

                    trigger OnValidate()
                    begin
                        IsSellToCountyVisible := FormatAddress.UseCounty(Rec."Sell-to Country/Region Code");
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nº Contacto';
                    Importance = Additional;
                    ToolTip = 'Especifique el número de la persona de contacto a la que enviar el contrato';

                    trigger OnValidate()
                    begin
                        if Rec.GetFilter("Sell-to Contact No.") = xRec."Sell-to Contact No." then
                            if Rec."Sell-to Contact No." <> xRec."Sell-to Contact No." then
                                Rec.SetRange("Sell-to Contact No.");
                    end;
                }
                field("Sell-to Phone No."; Rec."Sell-to Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nº teléfono';
                    Importance = Additional;
                    ToolTip = 'Especifique la número de teléfono de la personaa de contacto a la que enviar el contrato.';
                }
                field(SellToMobilePhoneNo; SellToContact."Mobile Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nº de móvil';
                    Importance = Additional;
                    Editable = false;
                    ExtendedDatatype = PhoneNo;
                    ToolTip = 'Especifique la mobile número de teléfono de la personaa de contacto a la que enviar el contrato.';
                }
                field("Sell-to E-Mail"; Rec."Sell-to E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Email';
                    Importance = Additional;
                    ToolTip = 'Especifique la email address de la personaa de contacto a la que enviar el contrato.';
                }
            }
            group("Invoice Details")
            {
                Caption = 'Facturación';

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;

                    Importance = Additional;
                    ToolTip = 'Especifique la divisa del contrato.';



                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    Caption = 'Precios con IVA incluido';
                    ApplicationArea = VAT;
                    ToolTip = 'Especifique si los precios serán con iva incluido.';

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'Grupo negocio iva';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Especifique el grupo negocio iva de este contrato.';

                    trigger OnValidate()
                    begin
                        if ApplicationAreaMgmtFacade.IsFoundationEnabled then
                            SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);

                        CurrPage.Update;
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Caption = 'Términos de pago';
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Especifique una formula para calcular la fecha de vencimiento.';
                }
                field("Términos facturación"; Rec."Cód. términos facturacion")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Caption = 'Forma de pago';
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        r289: Record 289;
                    begin
                        UpdatePaymentService();
                        if Rec."Forma pago prepago" = '' then
                            Rec."Forma pago prepago" := Rec."Payment Method Code";
                        if r289.GET(Rec."Payment Method Code") THEN
                            if r289."Bill Type" <> r289."Bill Type"::Transfer THEN
                                Rec."Nuestra Cuenta" := '';
                        //NFC := "Nuestra Cuenta";
                    end;
                }
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
                            Rec."B2R Bank Payment Code" := Rec."Nuestra Cuenta";
                            OnAfterLookupNuestraCuentaFicha(Rec, r270);
                        END;
                    end;

                    trigger OnDrillDown()
                    begin
                        Rec."Nuestra Cuenta" := NC();

                    end;
                }
                field("Aeropuerto"; Rec."Contrato Aeropuerto")
                {
                    ApplicationArea = All;

                }
                field("Venta de Soportes"; Rec."Venta de Soportes")
                {
                    ApplicationArea = All;
                }
                group(Control76)
                {
                    ShowCaption = false;
                    Visible = PaymentServiceVisible;
                    field(SelectedPayments; Rec.GetSelectedPaymentServicesText)
                    {
                        ApplicationArea = All;
                        Caption = 'Pago On line';
                        Editable = false;
                        Enabled = PaymentServiceEnabled;
                        MultiLine = true;
                        ToolTip = 'Especifique la el servicio de pago On Line, tal como PayPal, tque el cliente puede usar para pagar el contrato.';

                        trigger OnAssistEdit()
                        begin
                            Rec.ChangePaymentServiceSetting;
                        end;
                    }
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Especifique el código para la dimensión 1, de las dimensiones principales.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Especifique el código para la dimensión 2, de las dimensiones principales.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    Caption = '% descuentom pago';
                    ApplicationArea = Basic, Suite;

                }

                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Especifique la direct-debit mandate que el cliente ha firmado.';
                }
                field("Facturacion Bloqueada"; Rec."Facturacion Bloqueada")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
            group(Payment)
            {
                Caption = 'Pagos';
                // field("Pay-at Code"; Rec."Pay-at Code")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Especifique una code associated with a payment address other than the customer''s standard payment address.';
                // }
                field("Cust. Bank Acc. Code"; Rec."Cust. Bank Acc. Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Especifique el código del banco del cliente a asignar en este contrato.';
                }
            }
            group("Shipping and Billing")
            {
                Caption = 'Envio y facturación';
                group(Control91)
                {
                    ShowCaption = false;
                    field("Esperar Orden Cliente"; Rec."Esperar Orden Cliente")
                    {
                        ApplicationArea = All;
                    }
                    group(Control90)
                    {
                        ShowCaption = false;
                        field(ShippingOptions; ShipToOptions)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Envío-a';
#if CLEAN24
                            OptionCaption = 'Por defecto (dirección de envío),Otra dirección de envio,Personalizada';
#endif
                            ToolTip = 'Especifique la dirección para enviar el contrato. Por defecto: La misma que el cliente . Otra dirección de envio: De la lista de direcciones del cliente''s. Personalizada: Para este contrato.';

                            trigger OnValidate()
                            var
                                ShipToAddress: Record "Ship-to Address";
                                ShipToAddressList: Page "Ship-to Address List";
                                IsHandled: Boolean;
                            begin
                                IsHandled := false;
                                if IsHandled then
                                    exit;

                                case ShipToOptions of
                                    ShipToOptions::"Default (Sell-to Address)":
                                        begin
                                            Rec.Validate("Ship-to Code", '');
                                            Rec.CopySellToAddressToShipToAddress;
                                        end;
                                    ShipToOptions::"Alternate Shipping Address":
                                        begin
                                            ShipToAddress.SetRange("Customer No.", Rec."Sell-to Customer No.");
                                            ShipToAddressList.LookupMode := true;
                                            ShipToAddressList.SetTableView(ShipToAddress);

                                            if ShipToAddressList.RunModal = ACTION::LookupOK then begin
                                                ShipToAddressList.GetRecord(ShipToAddress);
                                                Rec.Validate("Ship-to Code", ShipToAddress.Code);
                                                IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                            end else
                                                ShipToOptions := ShipToOptions::"Custom Address";
                                        end;
                                    ShipToOptions::"Custom Address":
                                        begin
                                            Rec.Validate("Ship-to Code", '');
                                            IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
                                        end;
                                end;


                            end;
                        }
                        group(Control4)
                        {
                            ShowCaption = false;
                            Visible = NOT (ShipToOptions = ShipToOptions::"Default (Sell-to Address)");
                            field("Ship-to Code"; Rec."Ship-to Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Código';
                                Editable = ShipToOptions = ShipToOptions::"Alternate Shipping Address";
                                Importance = Promoted;
                                ToolTip = 'Especifique el código de la dirección del cliente.';

                                trigger OnValidate()
                                var
                                    ShipToAddress: Record "Ship-to Address";
                                begin
                                    if (xRec."Ship-to Code" <> '') and (Rec."Ship-to Code" = '') then
                                        Error(EmptyShipToCodeErr);
                                    if Rec."Ship-to Code" <> '' then begin
                                        ShipToAddress.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code");
                                        IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                    end else
                                        IsShipToCountyVisible := false;
                                end;
                            }
                            field("Ship-to Name"; Rec."Ship-to Name")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Nombre';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                ToolTip = 'Especifique el nombre del cliente para enviar el contrato';
                            }
                            field("Ship-to Address"; Rec."Ship-to Address")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Dirección';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Especifique la dirección del cliente para enviar el contrato';
                            }
                            field("Ship-to Address 2"; Rec."Ship-to Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Dirección 2';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Especifique la información adicional de la dirección';
                            }
                            field("Ship-to City"; Rec."Ship-to City")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Población';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Especifique la población del cliente en el contrato.';
                            }
                            group(Control297)
                            {
                                ShowCaption = false;
                                Visible = IsShipToCountyVisible;
                                field("Ship-to County"; Rec."Ship-to County")
                                {
                                    ApplicationArea = Basic, Suite;
                                    Caption = 'Provincia';
                                    Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                    QuickEntry = false;
                                    ToolTip = 'Especifique la provincia de la dirección.';
                                }
                            }
                            field("Ship-to Post Code"; Rec."Ship-to Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Código postal';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Especifique la código postal.';
                            }
                            field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'País';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Especifique el país del cliente.';

                                trigger OnValidate()
                                begin
                                    IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
                                end;
                            }
                        }
                        field("Ship-to Contact"; Rec."Ship-to Contact")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contacto';
                            ToolTip = 'Especifique el nombre de la personaa de contacto en la dirección del cliente para enviar el contrato';
                        }
                    }
                    group("Shipment Method")
                    {
                        Caption = 'Método de envío';
                        field("Shipment Method Code"; Rec."Shipment Method Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Código';
                            Importance = Additional;
                            ToolTip = 'Especifique como será enviado el contrato al cliente.';
                        }
                        field("Shipping Agent Code"; Rec."Shipping Agent Code")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Agente';
                            Importance = Additional;

                        }
                        field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Agente Servicio';
                            Importance = Additional;

                        }
#if CLEAN24
#pragma warning disable AL0432
                        field("Package Tracking No."; Rec."Package Tracking No.")
#pragma warning restore AL0432
                        {
                            Caption = 'Nº de seguimiento';
                            ApplicationArea = Suite;
                            Importance = Additional;
                            ToolTip = 'Especifique el nº de seguimiento del paquete.';
                        }
#else
#pragma warning disable AL0432
                        field("Package Tracking No."; Rec."Package Tracking No.")
                        {
                            Caption = 'Nº de seguimiento';
                            ApplicationArea = Suite;
                            Importance = Additional;
                            ToolTip = 'Especifique el nº de seguimiento del paquete.';
                        }
#pragma warning restore AL0432
#endif
                    }
                }
                group(Control85)
                {
                    ShowCaption = false;
                    field(BillToOptions; BillToOptions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Facturar-a';
#if CLEAN24
                        OptionCaption = 'Por defecto (Ccliente),Otro Cliente,Personalizar';
#endif
                        ToolTip = 'Especifique el cliente de facturación, si es distinto al de venta.';

                        trigger OnValidate()
                        begin
                            if BillToOptions = BillToOptions::"Default (Customer)" then begin
                                Rec.Validate("Bill-to Customer No.", Rec."Sell-to Customer No.");
                                Rec.RecallModifyAddressNotification(Rec.GetModifyBillToCustomerAddressNotificationId);
                            end;

                            Rec.CopySellToAddressToBillToAddress;
                        end;
                    }
                    group(Control82)
                    {
                        ShowCaption = false;
                        Visible = NOT (BillToOptions = BillToOptions::"Default (Customer)");
                        field("Bill-to Name"; Rec."Bill-to Name")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Nnombre';
                            Editable = BillToOptions = BillToOptions::"Another Customer";
                            Enabled = BillToOptions = BillToOptions::"Another Customer";
                            Importance = Promoted;
                            ToolTip = 'Especifique el nombre del cliente de facturación, si es distinto al de venta.';

                            trigger OnValidate()
                            begin
                                if Rec.GetFilter("Bill-to Customer No.") = xRec."Bill-to Customer No." then
                                    if Rec."Bill-to Customer No." <> xRec."Bill-to Customer No." then
                                        Rec.SetRange("Bill-to Customer No.");

                                CurrPage.SaveRecord;
                                if ApplicationAreaMgmtFacade.IsFoundationEnabled then
                                    SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);

                                CurrPage.Update(false);
                            end;
                        }
                        field("Bill-to Address"; Rec."Bill-to Address")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Dirección';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Especifique la dirección del cliente donde enviar el contrato.';
                        }
                        field("Bill-to Address 2"; Rec."Bill-to Address 2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address 2';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Especifique la información adicional de la dirección';
                        }
                        field("Bill-to City"; Rec."Bill-to City")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'City';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Especifique la población del cliente en el contrato.';
                        }
                        group(Control130)
                        {
                            ShowCaption = false;
                            Visible = IsBillToCountyVisible;
                            field("Bill-to County"; Rec."Bill-to County")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Provincia';
                                Editable = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                                Enabled = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Especifique la provincia de la dirección.';
                            }
                        }
                        field("Bill-to Post Code"; Rec."Bill-to Post Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Código Postal';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Especifique el código postal.';
                        }
                        field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'País';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Especifique el país de la dirección.';

                            trigger OnValidate()
                            begin
                                IsBillToCountyVisible := FormatAddress.UseCounty(Rec."Bill-to Country/Region Code");
                            end;
                        }
                        field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Nº Contacto';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Importance = Additional;
                            ToolTip = 'Especifique el número del contacto para enviar el contrato.';
                        }
                        field("Bill-to Contact"; Rec."Bill-to Contact")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contacto';
                            Editable = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            Enabled = (BillToOptions = BillToOptions::"Custom Address") OR (Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.");
                            ToolTip = 'Especifique el nombre de la persona a contactar en el cliente donde enviar el contrato.';
                        }
                        field(BillToContactPhoneNo; BillToContact."Phone No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Nº Teléfono';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = PhoneNo;
                            ToolTip = 'Especifique la número de teléfono de la persona a contactar en el cliente donde enviar el contrato.';
                        }
                        field(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Nº Movil';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = PhoneNo;
                            ToolTip = 'Especifique número de teléfono nóvil de la persona a contactar en el cliente donde enviar el contrato.';
                        }
                        field(BillToContactEmail; BillToContact."E-Mail")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Email';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = EMail;
                            ToolTip = 'Especifique la correo de la persona a contactar en el cliente donde enviar el contrato.';
                        }
                    }
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Almacén';
                    ApplicationArea = Location;
                    ToolTip = 'Especifique el almacén.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Caption = 'Fecha de envío';
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    //ToolTip = 'Specifies when items on the document será enviado or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    Caption = 'Aviso envio';
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    //ToolTip = 'Specifies if the customer accepts partial shipment of orders.';

                    trigger OnValidate()
                    var
                        ConfirmManagement: Codeunit "Confirm Management";
                    begin
                        if Rec."Shipping Advice" <> xRec."Shipping Advice" then
                            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text001, Rec.FieldCaption("Shipping Advice")), true) then
                                Error(Text002);
                    end;
                }
                // field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                // {
                //     ApplicationArea = Warehouse;
                //     Importance = Additional;
                //    // ToolTip = 'Especifique una date formula for the time it takes to get items ready to ship from this location. The time element is used in the calculation of the delivery date as follows: Shipment Date + Outbound Warehouse Handling Time = Planned Shipment Date + Shipping Time = Planned Delivery Date.';
                // }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    Caption = 'Hora envío';
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    //ToolTip = 'Especifique como long it takes from when the items será enviado from the warehouse to when they are delivered.';
                }
                // field("Late Order Shipping"; Rec."Late Order Shipping")
                // {

                //     ApplicationArea = Basic, Suite;
                //     Importance = Additional;
                //     ToolTip = 'Specifies that the shipment of one or more lines has been delayed, or that the shipment date is before the work date.';
                // }
                // field("Combine Shipments"; Rec."Combine Shipments")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Importance = Additional;
                //     ToolTip = 'Specifies whether the order will be included when you use the Combine Shipments function.';
                // }
            }
            // group("Foreign Trade")
            // {
            //     Caption = 'Internacional';
            //     field("Transaction Specification"; Rec."Transaction Specification")
            //     {
            //         ApplicationArea = BasicEU;
            //         ToolTip = 'Especifique una specification of the document''s transaction, for the purpose of reporting to INTRASTAT.';
            //     }
            //     field("Transaction Type"; Rec."Transaction Type")
            //     {
            //         ApplicationArea = BasicEU;
            //         ToolTip = 'Especifique la type of transaction that the document represents, for the purpose of reporting to INTRASTAT.';
            //     }
            //     field("Transport Method"; Rec."Transport Method")
            //     {
            //         ApplicationArea = BasicEU;
            //         ToolTip = 'Especifique la transport method, for the purpose of reporting to INTRASTAT.';
            //     }
            //     field("Exit Point"; Rec."Exit Point")
            //     {
            //         ApplicationArea = BasicEU;
            //         ToolTip = 'Especifique la point of exit through which you ship the items out of your country/region, for reporting to Intrastat.';
            //     }
            //     field("Area"; Rec.Area)
            //     {
            //         ApplicationArea = BasicEU;
            //         ToolTip = 'Especifique la area del cliente or vendor, for the purpose of reporting to INTRASTAT.';
            //     }
            // }
            group(Control1900201301)
            {
                Caption = 'Prepago';
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Caption = '% Prepago';
                    ApplicationArea = Prepayments;
                    Importance = Promoted;
                    ToolTip = 'Especifique el porcentaje para calcular la factura de prepago.';

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;

                    end;
                }
                field("Terminos facturación Prepago"; Rec."Cód. términos prepago")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Description"; Rec."Prepmt. Posting Description")
                {
                    Caption = 'Descripción prepago';
                    ApplicationArea = Prepayments;
                    Importance = Promoted;
                    ToolTip = 'Especifique la descripción para la factura de prepago.';
                }
                field("% prep incl produccion"; Rec."% prep incl produccion")
                {
                    ApplicationArea = all;
                    trigger onValidate()
                    BEGIN
                        CurrPage.UPDATE;
                    END;
                }
                field("% prep antes recalculo"; Rec."% prep antes recalculo") { }
                field("Fecha registro prepago"; Rec."Fecha registro prepago") { ApplicationArea = All; }
                field("Forma pago prepago"; Rec."Forma pago prepago")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        r289: Record 289;
                    begin


                        if r289.GET(Rec."Forma pago prepago") THEN
                            if r289."Bill Type" <> r289."Bill Type"::Transfer THEN
                                Rec."Nuestra Cuenta Prepago" := '';
                        //NFC := "Nuestra Cuenta";
                    end;
                }

                field("Nuestra Cuenta Prepago"; Rec."Nuestra Cuenta Prepago")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    VAR
                        r270: Record 270;
                    BEGIN
                        if Page.RUNMODAL(0, r270) = ACTION::LookupOK THEN BEGIN
                            Rec."Nuestra Cuenta Prepago" := r270."No.";

                            //TODO: - B2R Bank Payment Code
                            OnAfterLookupNuestraCuentaFichaPrepago(Rec, r270);
                            //if Rec."Factura prepago" Then
                            //    Rec."B2R Bank Payment Code" := Rec."Nuestra Cuenta Prepago";
                        END;
                    END;

                    trigger OnDrillDown()
                    begin
                        Rec."Nuestra Cuenta Prepago" := NCP();

                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    Caption = 'Combinar prepago';
                    ApplicationArea = Dimensions;
                    ToolTip = 'Con las mismas dimensiones del resto de facturas.';
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    Caption = 'Términos de pago prepago';
                    ApplicationArea = Prepayments;
                    ToolTip = 'Especifique los términos de pago para calcular el vencimiento de la factura de prepago.';
                    trigger OnValidate()
                    var
                        PaymentTerms: Record "Payment Terms";
                        DT: DateFormula;
                    begin
                        Evaluate(DT, '<0D>');
                        If PaymentTerms.GET(Rec."Prepmt. Payment Terms Code") then
                            if PaymentTerms."Due Date Calculation" <> DT then error('Solo se admite contado como cálculo de vencimiento de prepago'); //jo
                        Rec."Prepayment Due Date" := Rec."Order Date";
                    end;
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    Caption = 'Fecha vto. prepago';
                    ApplicationArea = Prepayments;
                    Importance = Promoted;
                    ToolTip = 'Fecha de vencimiento de la factura de prepago.';
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    Caption = '% descuento prepago';
                    ApplicationArea = Prepayments;
                    ToolTip = 'Especifique el descuento por prepago.';
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    Caption = 'Fecha dto. prepago';
                    ApplicationArea = Prepayments;
                    ToolTip = 'Especifique la fecha máxima de pago para aplivar el descuento anterior.';
                }


            }
            group(Comentario)
            {
                field("Comentario Cabera"; Rec."Comentario Cabecera")
                {
                    ApplicationArea = All;
                }
            }
            Group(Proyecto)
            {
                field("Proyecto origen"; Rec."Proyecto origen") { Editable = false; ApplicationArea = All; }
                field("Interc./Compens."; Rec."Interc./Compens.") { Editable = false; ApplicationArea = All; }
                field("Soporte de"; Rec."Soporte de") { Editable = false; ApplicationArea = All; }
                field(Subtipo; Rec.Subtipo) { Editable = false; ApplicationArea = All; }
                field("Fecha Firma"; Rec."Fecha Firma") { Editable = false; ApplicationArea = All; }
                field(Firmado; Rec.Firmado) { Editable = false; ApplicationArea = All; }
                field("Tipo Venta"; Rec.Tipo) { Editable = true; ApplicationArea = All; }
                field("Nº Proyecto"; Rec."Nº Proyecto") { Editable = False; ApplicationArea = All; }
                field("Fecha cancelacion"; Rec."Fecha cancelacion") { ApplicationArea = All; Editable = false; }
                field("Pte firma cliente"; Rec."Pte firma cliente") { ApplicationArea = All; }

            }
        }
        area(factboxes)
        {
            part(Control1903433807; "Cartera Receiv. Statistics FB")
            {
                Caption = 'Cartera';
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            part(Control1903433607; "Cartera Fact. Statistics FB")
            {
                Caption = 'Facturas en cartera';
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documentos adjuntos';
                SubPageLink = "Table ID" = CONST(Database::"Sales Header"),
                                "No." = FIELD("No."),
                                "Document Type" = FIELD("Document Type");

            }
            part(Control35; "Pending Approval FactBox")
            {
                Caption = 'Documentos pendientes de aprobar';
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control1903720907; "Sales Hist. Sell-to FactBox")
            {
                Caption = 'Histórico de facturas venta';
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
            }
            part(Control1902018507; "Customer Statistics FactBox")
            {
                Caption = 'Estadísticas';
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                Caption = 'Detalle Cliente';
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
            }
            part(Control1906127307; "Sales Line FactBox")
            {
                Caption = 'Detalle Líneas';
                ApplicationArea = Suite;
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
            part(Control1901314507; "Item Invoicing FactBox")
            {
                Caption = 'Detalle Producto';
                ApplicationArea = Basic, Suite;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                Caption = 'Aprobaciones';
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                Caption = 'Documentoa entrantes';
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = false;
            }
            part(Control1907012907; "Resource Details FactBox")
            {
                Caption = 'Recursos';
                ApplicationArea = Basic, Suite;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(Control1901796907; "Item Warehouse FactBox")
            {
                Caption = 'Almacén';
                ApplicationArea = Basic, Suite;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(Control1907234507; "Sales Hist. Bill-to FactBox")
            {
                Caption = 'Hist facturas cliente';
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                Caption = 'Flujo trabajo';
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control1900383207; Links)
            {
                Caption = 'Links';
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Caption = 'Notas';
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {

            group("O&rder")
            {
                Caption = 'C&ontrato';
                Image = "Order";
                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Estádisticas';
                    Image = Statistics;
                    // //Promoted = true;
                    // //PromotedCategory = Category8;
                    // //PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    //ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    RunObject = Page "Sales Order Statistics";
                    RunPageOnRec = true;
                }
                action(Customer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cliente';
                    Enabled = IsCustomerOrContactNotEmpty;
                    Image = Customer;
                    //Promoted = true;
                    ////PromotedCategory = Category12;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No."),
                                  "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'Shift+F7';
                    //ToolTip = 'View or edit detailed information about the customer en el contrato.';
                }
                action("&Navegar")
                {
                    ApplicationArea = All;
                    Image = Navigate;
                    trigger OnAction()
                    BEGIN
                        Rec.Navigate;
                    END;
                }
                action("Recupera Nº Cuenta")
                {
                    Image = BankAccount;
                    ApplicationArea = All;
                    trigger ONaction()
                    var
                        // Crea una varaible para customer
                        rCustomer: Record Customer;
                    begin
                        //Recupera el cliente de la factura y actualiza el campo nuestra cuenta
                        rCustomer.GET(Rec."Sell-to Customer No.");
                        Rec."Nuestra Cuenta" := rCustomer."Banco transferencia";
                        Rec.MODIFY;

                    end;


                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensiones';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    //Promoted = true;
                    //PromotedCategory = Category8;
                    //PromotedIsBig = true;
                    ShortCutKey = 'Alt+D';
                    //ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }

                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Aprobaciones';
                    Image = Approvals;
                    //Promoted = true;
                    //PromotedCategory = Category8;
                    //ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Codeunit "Approvals Mgmt.";
                    begin
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Sales Header", Rec."Document Type", Rec."No.");
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mentarios';
                    Image = ViewComments;
                    //Promoted = true;
                    //PromotedCategory = Category8;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    //ToolTip = 'View or add comments for the record.';
                }
                action(Recorda)
                {
                    Caption = 'Recordatorio';
                    ApplicationArea = All;
                    Image = Reminder;
                    trigger OnAction()
                    var
                        Recordatorios: Record Recordatorios;
                    begin
                        Recordatorios.SetRange("Tipo documento", Rec."Document Type");
                        Recordatorios.SetRange("Nº", Rec."No.");
                        Page.RunModal(Page::"Recordatorios contrato", Recordatorios);
                    end;



                    // TableRelation="Tipo documento"=FIELD("Document Type"),
                    // "Nº"=FIELD("No."); 
                }
                action(DocAttach)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Adjuntos';
                    Image = Attach;
                    //Promoted = true;
                    //PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
                action("Borradores Fac/Abo")
                {
                    ApplicationArea = All;
                    Image = "Invoicing-View";
                    trigger OnAction()
                    var

                    begin

                        //rCabF.SETCURRENTKEY("Nº Proyecto");
                        rCabF.SETRANGE("Nº Proyecto", Rec."Nº Proyecto");
                        //rCabF.SETRANGE("Tipo documento", rCabF."Tipo documento"::Factura);
                        rCabF.SETRANGE("Nº Contrato", Rec."No.");
                        fListaFras.CAPTION('Lista borradores facturas creadas desde el contrato');
                        fListaFras.SETTABLEVIEW(rCabF);
                        fListaFras.RUNMODAL;
                        CLEAR(fListaFras);
                        rCabF.RESET;
                    end;
                }
                action("Histórico Facturas del contrato")
                {
                    ApplicationArea = All;
                    Image = "Invoicing-Document";
                    RunObject = page "Posted Sales Invoices";
                    RunPageLink = "Nº Proyecto" = field("Nº Proyecto"), "Nº Contrato" = field("Nº Contrato");
                }
                action("Histórico Abonos del contrato")
                {
                    ApplicationArea = All;
                    Image = CreditMemo;
                    RunObject = page "Posted Sales Credit Memos";
                    RunPageLink = "Nº Proyecto" = field("Nº Proyecto"), "Nº Contrato" = field("Nº Contrato");
                }

                action("Contratos asociados")
                {
                    ApplicationArea = All;
                    Image = FileContract;
                    trigger OnAction()
                    var
                        rContrato: Record "Sales Header";
                    begin

                        Rec.CALCFIELDS("Proyecto original");
                        if Rec."Proyecto original" <> '' THEN BEGIN
                            rContrato.RESET;
                            rContrato.SETRANGE("Proyecto original", Rec."Proyecto original");
                            Page.RUN(45, rContrato);
                        END;
                    end;
                }
                action("Recalcular Contrato")
                {
                    ApplicationArea = All;
                    Image = Calculate;
                    trigger OnAction()
                    var
                        r37: Record "Sales Line";
                        r325: Record "VAT Posting Setup";
                    begin
                        r37.SETRANGE(r37."Document Type", Rec."Document Type");
                        r37.SETRANGE(r37."Document No.", Rec."No.");
                        if r37.FINDFIRST THEN
                            REPEAT
                                if r37.Type <> r37.Type::" " THEN BEGIN
                                    r37.VALIDATE(Quantity);
                                    r325.SETRANGE(r325."VAT Bus. Posting Group", r37."VAT Bus. Posting Group");
                                    r325.SETRANGE(r325."VAT Prod. Posting Group", r37."VAT Prod. Posting Group");
                                    if r325.FINDFIRST THEN
                                        r37."VAT %" := r325."VAT %";
                                    r37.MODIFY;
                                END;
                            UNTIL r37.NEXT = 0;
                    end;
                }
                action("Asignar Contrato Origen (renovación)")
                {
                    ApplicationArea = All;
                    Image = ApplyEntries;
                    trigger OnAction()
                    var
                        rContr: Record "Sales Header";
                        rProyOr: Record Job;
                        rProyDes: Record Job;
                        Lista: Page "Sales List";
                    begin
                        rContr.SETCURRENTKEY("Document Type", "Sell-to Customer No.", "No.");
                        rContr.SETRANGE(rContr."Document Type", rContr."Document Type"::Order);
                        rContr.SETRANGE(rContr."Sell-to Customer No.", Rec."Sell-to Customer No.");
                        if PAGE.RUNMODAL(Page::"Lista Contratos Venta", rContr) = ACTION::LookupOK THEN BEGIN
                            rContr.Renovado := TRUE;
                            rContr."Fecha renovacion" := 0D;
                            rContr.MODIFY;
                            if Not Rec."Contrato No Renovable" then
                                Rec."Fecha renovacion" := Rec."Fecha fin proyecto";
                            Rec."Proyecto origen" := rContr."Nº Proyecto";
                            Rec.MODIFY;
                            rProyOr.GET(rContr."Nº Proyecto");
                            rProyDes.GET(Rec."Nº Proyecto");
                            rProyOr.Renovado := TRUE;
                            rProyDes."Proyecto origen" := rProyOr."No.";
                            rProyDes.MODIFY;
                        END;
                    end;
                }




            }
            group(Documents)
            {
                Caption = 'Documentos';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Albaranes';
                    Image = Shipment;
                    //Promoted = true;
                    ////PromotedCategory = Category12;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    //ToolTip = 'View related posted sales shipments.';
                }
                action(Invoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Facturas';
                    Image = Invoice;
                    //Promoted = true;
                    ////PromotedCategory = Category12;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    //ToolTip = 'View a list of ongoing sales invoices for the order.';
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepago';
                Image = Prepayment;
                action("Calcular 485")
                {
                    Image = CalculateBalanceAccount;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Importe485 := Format(Cuenta485(), 0, '<Precision,2:3><Standard Format,0>');
                        Num_Contrato := Rec."No.";
                        Currpage.Update(False);

                    end;
                }
                action(PagePostedSalesPrepaymentInvoices)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Facturas Prepa&go';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    //ToolTip = 'View related posted sales invoices that involve a prepayment. ';
                }
                action(PagePostedSalesPrepaymentCrMemos)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Abonos Prepago';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    //ToolTip = 'View related posted sales credit memos that involve a prepayment. ';
                }
            }
            group(History)
            {
                Image = History;
                Caption = 'Histórico';
                action(PageInteractionLogEntries)
                {
                    ApplicationArea = Suite;
                    Caption = 'Movimientos de Interacción';
                    Image = InteractionLog;
                    //The property '//PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    ////PromotedCategory = Category10;
                    ShortCutKey = 'Ctrl+F7';
                    //ToolTip = 'View a list of interaction log entries related to this document.';

                    trigger OnAction()
                    begin
                        Rec.ShowInteractionLogEntries;
                    end;
                }
            }
        }
        area(processing)
        {
            group(Acciones)
            {
                Caption = 'Acciones';
                Image = Action;
                action(Recordatorio)
                {
                    ApplicationArea = ALL;
                    Image = Reminder;

                }


                action("Lineas no facturadas")
                {
                    ApplicationArea = All;
                    Image = OpenJournal;
                    trigger OnAction()
                    var
                        r37: Record "Sales Line";
                    begin

                        r37.SETRANGE(r37."Document Type", Rec."Document Type");
                        r37.SETRANGE(r37."Document No.", Rec."No.");
                        if r37.FINDFIRST THEN
                            REPEAT
                                r37."Linea Marcada a Borrador" := FALSE;
                                r37."Cantidad a Borrador" := 0;
                                r37."Cantidad pasada Borrador" := 0;
                                r37.MODIFY;
                            UNTIL r37.NEXT = 0;
                    end;
                }
                action("Desmarcar un Periodo")
                {
                    ApplicationArea = All;
                    Image = UnApply;
                    trigger OnAction()
                    var
                        fechaI: Date;
                        fechaF: Date;
                        fDatos: Page "Petición datos Facturación";
                        rLinOrden: Record "Lin. orden publicidad";
                        r37: Record "Sales Line";
                        fechaReg: Date;
                    begin

                        CLEAR(fechaI);
                        CLEAR(fechaF);
                        CLEAR(fDatos);
                        fDatos.RUNMODAL;
                        //$006 (I)
                        //fDatos.Recoge_Fechas(fechaI,fechaF);
                        //if NOT CONFIRM(Text005, TRUE, fechaI, fechaF, WORKDATE) THEN
                        fDatos.Recoge_Fechas(fechaI, fechaF, fechaReg);
                        if NOT CONFIRM(Text005, TRUE, fechaI, fechaF) THEN
                            EXIT;
                        r37.SETRANGE(r37."Document Type", Rec."Document Type");
                        r37.SETRANGE(r37."Document No.", Rec."No.");
                        if r37.FINDFIRST THEN
                            REPEAT
                                if r37."No. Orden Publicidad" <> '' THEN BEGIN
                                    rLinOrden.RESET;
                                    rLinOrden.SETCURRENTKEY("Tipo orden", "No. orden", "Fecha inicio");
                                    rLinOrden.SETRANGE("No. orden", r37."No. Orden Publicidad");
                                    rLinOrden.SETRANGE("Fecha inicio", fechaI, fechaF);
                                    rLinOrden.SETFILTER(Precio, '<>%1', 0);
                                    rLinOrden.SETRANGE(rLinOrden.Facturada, TRUE);
                                    r37."Linea Marcada a Borrador" := FALSE;
                                    r37."Cantidad a Borrador" := 0;
                                    r37."Cantidad pasada Borrador" := r37."Cantidad pasada Borrador" - rLinOrden.COUNT;
                                    rLinOrden.MODIFYALL(rLinOrden.Factura, '');
                                    rLinOrden.MODIFYALL(rLinOrden.Facturada, FALSE);
                                    r37.MODIFY;
                                END;
                            UNTIL r37.NEXT = 0;
                    end;
                }
                action("Marcar Como Firmado")
                {
                    ApplicationArea = All;
                    Image = Signature;
                    trigger OnAction()
                    var
                        SalesLine: Record "Sales Line";
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        Rec.Estado := Rec.Estado::Firmado;
                        Rec.TESTFIELD("Comentario Cabecera");
                        if Rec."Shortcut Dimension 1 Code" <> 'GENERAL' THEN
                            if (Rec.Estado = Rec.Estado::Firmado) THEN Rec.VALIDATE("Fecha renovacion", Rec."Fecha fin proyecto");
                        if (xRec.Estado <> Rec.Estado::"Sin Montar") AND (xRec.Estado <> Rec.Estado::Firmado) THEN           //$016
                            Rec."Fecha Estado" := WORKDATE;
                        Rec.Modify();
                        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                        SalesLine.SETRANGE("Document No.", Rec."No.");
                        if NOT SalesLine.ISEMPTY THEN
                            ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Marcar como no Renovable")
                {
                    ApplicationArea = All;
                    Image = RedoFluent;
                    trigger OnAction()
                    var
                        SalesLine: Record "Sales Line";
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        Rec."Contrato No Renovable" := not Rec."Contrato No Renovable";
                        Rec.Modify();

                    end;
                }


                action("Generar PDF")
                {
                    ApplicationArea = All;
                    Image = SendAsPDF;
                    trigger OnAction()
                    var
                        Recref: RecordRef;
                        Tempblob: Codeunit "Temp Blob";
                        Out: OutStream;
                        AttachmentStream: InStream;
                        Fichero: Text;
                    begin
                        Rec.SetRange("Document Type", Rec."Document Type");
                        Rec.SetRange("No.", Rec."No.");
                        Recref.GetTable(Rec);
                        TempBlob.CreateOutStream(Out);
                        REPORT.SaveAs(50016, '', ReportFormat::Pdf, out, Recref);//Report::"Contrato"
                        TempBlob.CreateInStream(AttachmentStream);
                        Fichero := Rec."No." + '.pdf';
                        DownloadFromStream(AttachmentStream, 'Guardar Contrato', '', 'Pdf files (*.pdf)|*.pdf', Fichero);

                        Rec.SetRange("No.");
                    end;
                }
                action("Generar PDF por lotes")
                {
                    ApplicationArea = All;
                    Image = SendEmailPDF;
                    trigger OnAction()
                    var
                    begin
                        Report.RunModal(50016);//Report::Contrato
                    end;
                }
                action("Actualiza Dimensiones")
                {
                    ApplicationArea = All;
                    Image = ChangeDimensions;
                    trigger OnAction()
                    var
                        r37: Record "Sales Line";
                        rDef: Record "Default Dimension";
                        rCof: Record "General Ledger Setup";
                    begin

                        r37.SETRANGE(r37."Document Type", Rec."Document Type");
                        r37.SETRANGE(r37."Document No.", Rec."No.");
                        rCof.GET;
                        if r37.FINDFIRST THEN
                            REPEAT
                                rDef.SETRANGE(rDef."Table ID", 156);
                                rDef.SETRANGE(rDef."No.", r37."No.");
                                rDef.SETRANGE(rDef."Dimension Code", rCof."Global Dimension 1 Code");
                                if rDef.FINDFIRST THEN
                                    r37."Shortcut Dimension 1 Code" := rDef."Dimension Value Code";
                                rDef.SETRANGE(rDef."Table ID", 156);
                                rDef.SETRANGE(rDef."No.", r37."No.");
                                rDef.SETRANGE(rDef."Dimension Code", rCof."Global Dimension 2 Code");
                                if rDef.FINDFIRST THEN
                                    r37."Shortcut Dimension 2 Code" := rDef."Dimension Value Code";
                                r37.MODIFY;
                            UNTIL r37.NEXT = 0;
                    end;
                }
                action("Cargar Texto U.E.")
                {
                    ApplicationArea = All;
                    Image = EndingText;
                    trigger OnAction()
                    var
                        rLin: Record "Sales Comment Line";
                        r37: Record "Sales Line";
                    begin

                        rLin.SETRANGE(rLin."Document Type", rLin."Document Type"::"Detalle Contrato");
                        rLin.SETRANGE(rLin."No.", Rec."No.");
                        rLin.DELETEALL;
                        rLin."Document Type" := rLin."Document Type"::"Detalle Contrato";
                        rLin."No." := Rec."No.";
                        rLin."Document Line No." := 10000;
                        rLin."Line No." := 10000;
                        rLin.Comment := 'Campaña publicitaria';
                        rLin.Validada := TRUE;
                        rLin.INSERT;
                        rLin."Line No." := 20000;
                        rLin.Comment := Rec."Bill-to Name";
                        rLin.Validada := TRUE;
                        rLin.INSERT;
                        rLin."Line No." := 30000;
                        rLin.Comment := 'incluyendo:';
                        rLin.Validada := TRUE;
                        rLin.INSERT;
                        rLin."Line No." := 40000;
                        rLin.Comment := 'Diseño, producción, fijación';
                        rLin.Validada := TRUE;
                        rLin.INSERT;
                        rLin."Line No." := 50000;
                        rLin.Comment := ' y espacio publicitario.';
                        rLin.Validada := TRUE;
                        rLin.Cantidad := 1;
                        TotalesDocumentos;
                        rLin.Precio := TotCont;
                        r37.SETRANGE(r37."Document Type", Rec."Document Type");
                        r37.SETRANGE(r37."Document No.", Rec."No.");
                        r37.SETFILTER(r37."VAT Prod. Posting Group", '<>%1', '');
                        if r37.FINDFIRST THEN
                            rLin."% Iva" := r37."VAT %";
                        rLin."Iva" := ROUND(rLin.Precio * rLin.Cantidad * (rLin."% Iva" / 100), 0.01, '=');
                        rLin.Importe := ROUND(rLin.Precio * rLin.Cantidad * (1 + (rLin."% Iva" / 100)), 0.01, '=');
                        rLin.INSERT;
                    end;
                }
                action("Cargar Datos Cliente")
                {
                    ApplicationArea = All;
                    Image = Customer;
                    trigger OnAction()
                    Var
                        Fact_Abo: Record "Sales Header";
                        Cust: Record "Customer";
                        ShiptoAddress: Record "Ship-to Address";
                        Contrato: Record "Sales Header";
                    begin

                        Fact_Abo.SETFILTER(Fact_Abo."Document Type", '%1|%2', Fact_Abo."Document Type"::Invoice, Fact_Abo."Document Type"::"Credit Memo");
                        Fact_Abo.SETRANGE(Fact_Abo."Nº Contrato", Rec."No.");
                        Fact_Abo.SETRANGE(Fact_Abo."Nº Proyecto", Rec."Nº Proyecto");
                        if Fact_Abo.FINDFIRST THEN
                            REPEAT
                                Cust.GET(Rec."Sell-to Customer No.");
                                Fact_Abo."Sell-to Customer Name" := Cust.Name;
                                Fact_Abo."Sell-to Customer Name 2" := Cust."Name 2";
                                Fact_Abo."Sell-to Address" := Cust.Address;
                                Fact_Abo."Sell-to Address 2" := Cust."Address 2";
                                Fact_Abo."Sell-to City" := Cust.City;
                                Fact_Abo."Sell-to Post Code" := Cust."Post Code";
                                Fact_Abo."Sell-to County" := Cust.County;
                                Fact_Abo."Sell-to Country/Region Code" := Cust."Country/Region Code";
                                Fact_Abo."Sell-to Contact" := Cust.Contact;
                                Fact_Abo."VAT Registration No." := Cust."VAT Registration No.";
                                if Rec."Bill-to Customer No." <> '' THEN Cust.GET(Rec."Bill-to Customer No.");
                                Fact_Abo."Bill-to Name" := Cust.Name;
                                Fact_Abo."Bill-to Name 2" := Cust."Name 2";
                                Fact_Abo."Bill-to Address" := Cust.Address;
                                Fact_Abo."Bill-to Address 2" := Cust."Address 2";
                                Fact_Abo."Bill-to City" := Cust.City;
                                Fact_Abo."Bill-to Post Code" := Cust."Post Code";
                                Fact_Abo."Bill-to County" := Cust.County;
                                Fact_Abo."Bill-to Country/Region Code" := Cust."Country/Region Code";
                                Fact_Abo."Bill-to Contact" := Cust.Contact;
                                Fact_Abo."VAT Registration No." := Cust."VAT Registration No.";
                                Fact_Abo."VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                                Fact_Abo."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                                Fact_Abo."Customer Posting Group" := Cust."Customer Posting Group";
                                Fact_Abo."Nuestra Cuenta" := Cust."Banco transferencia";
                                if Fact_Abo."Ship-to Code" = '' THEN BEGIN
                                    Rec.CopyShipToCustomerAddressFieldsFromCust(Cust);
                                    Fact_Abo."Ship-to Name" := Cust.Name;
                                    Fact_Abo."Ship-to Name 2" := Cust."Name 2";
                                    Fact_Abo."Ship-to Address" := Cust.Address;
                                    Fact_Abo."Ship-to Address 2" := Cust."Address 2";
                                    Fact_Abo."Ship-to City" := Cust.City;
                                    Fact_Abo."Ship-to Post Code" := Cust."Post Code";
                                    Fact_Abo."Ship-to County" := Cust.County;
                                    Fact_Abo."Ship-to Country/Region Code" := Cust."Country/Region Code";
                                    Fact_Abo."Ship-to Contact" := Cust.Contact;

                                END ELSE BEGIN
                                    ShiptoAddress.GET(Rec."Sell-to Customer No.", Rec."Ship-to Code");
                                    Fact_Abo.SetShipToCustomerAddressFieldsFromShipToAddr(ShiptoAddress);

                                END;
                                Fact_Abo."Payment Method Code" := cust."Payment Method Code";
                                Fact_Abo."Payment Terms Code" := cust."Payment Terms Code";
                                Fact_Abo."Salesperson Code" := Cust."Salesperson Code";
                                Fact_Abo.MODIFY;

                            UNTIL Fact_Abo.NEXT = 0;
                        Contrato.Reset;
                        if Contrato.Get(Rec."Document Type", Rec."No.") THEN Begin
                            Cust.Get(Rec."Sell-to Customer No.");
                            Contrato."Sell-to Customer No." := Cust."No.";
                            Contrato."Sell-to Customer Name" := Cust.Name;
                            Contrato."Sell-to Customer Name 2" := Cust."Name 2";
                            Contrato."Payment Method Code" := Cust."Payment Method Code";
                            Contrato."Payment Terms Code" := Cust."Payment Terms Code";
                            Contrato."Salesperson Code" := Cust."Salesperson Code";
                            Contrato."Sell-to Address" := Cust.Address;
                            Contrato."Sell-to Address 2" := Cust."Address 2";
                            Contrato."Sell-to City" := Cust.City;
                            Contrato."Sell-to Post Code" := Cust."Post Code";
                            Contrato."Sell-to County" := Cust.County;
                            Contrato."Sell-to Country/Region Code" := Cust."Country/Region Code";
                            Contrato."Sell-to Contact" := Cust.Contact;
                            Contrato."VAT Registration No." := Cust."VAT Registration No.";
                            if Cust."Bill-to Customer No." <> '' THEN Cust.GET(Cust."Bill-to Customer No.");
                            Contrato."Bill-to Customer No." := Cust."No.";
                            Contrato."Bill-to Name" := Cust.Name;
                            Contrato."Bill-to Name 2" := Cust."Name 2";
                            Contrato."Bill-to Address" := Cust.Address;
                            Contrato."Bill-to Address 2" := Cust."Address 2";
                            Contrato."Bill-to City" := Cust.City;
                            Contrato."Bill-to Post Code" := Cust."Post Code";
                            Contrato."Bill-to County" := Cust.County;
                            Contrato."Bill-to Country/Region Code" := Cust."Country/Region Code";
                            Contrato."Bill-to Contact" := Cust.Contact;
                            Contrato."VAT Registration No." := Cust."VAT Registration No.";
                            Contrato."VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                            Contrato."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                            Contrato."Customer Posting Group" := Cust."Customer Posting Group";
                            Contrato."Ship-to Code" := '';
                            Contrato."Nuestra Cuenta" := Cust."Banco transferencia";
                            Contrato.CopyShipToCustomerAddressFieldsFromCust(Cust);
                            Contrato."Salesperson Code" := Rec."Salesperson Code";
                            Contrato.MODIFY;

                        end;
                    end;
                }
                action("Cambiar Cliente")
                {
                    ApplicationArea = All;
                    Image = CustomerCode;
                    trigger OnAction()
                    Var
                        Fact_Abo: Record "Sales Header";
                        Contrato: Record "Sales Header";
                        Cust: Record "Customer";
                        Cust2: Record "Customer";
                        ShiptoAddress: Record "Ship-to Address";
                        Job: Record Job;
                    begin
                        if Page.RunModal(0, Cust) <> Action::LookupOK Then exit;
                        Cust2.Get(Cust."No.");
                        Fact_Abo.SETFILTER(Fact_Abo."Document Type", '%1|%2', Fact_Abo."Document Type"::Invoice, Fact_Abo."Document Type"::"Credit Memo");
                        Fact_Abo.SETRANGE(Fact_Abo."Nº Contrato", Rec."No.");
                        Fact_Abo.SETRANGE(Fact_Abo."Nº Proyecto", Rec."Nº Proyecto");
                        if Fact_Abo.FINDFIRST THEN
                            REPEAT
                                Cust.Get(Cust2."No.");
                                Fact_Abo."Sell-to Customer No." := Cust."No.";
                                Fact_Abo."Sell-to Customer Name" := Cust.Name;
                                Fact_Abo."Sell-to Customer Name 2" := Cust."Name 2";
                                Fact_Abo."Sell-to Address" := Cust.Address;
                                Fact_Abo."Payment Method Code" := Cust."Payment Method Code";
                                Fact_Abo."Payment Terms Code" := Cust."Payment Terms Code";
                                Fact_Abo."Salesperson Code" := Cust."Salesperson Code";
                                Fact_Abo."Sell-to Address 2" := Cust."Address 2";
                                Fact_Abo."Sell-to City" := Cust.City;
                                Fact_Abo."Sell-to Post Code" := Cust."Post Code";
                                Fact_Abo."Sell-to County" := Cust.County;
                                Fact_Abo."Sell-to Country/Region Code" := Cust."Country/Region Code";
                                Fact_Abo."Sell-to Contact" := Cust.Contact;
                                Fact_Abo."VAT Registration No." := Cust."VAT Registration No.";
                                if Cust."Bill-to Customer No." <> '' THEN Cust.GET(Cust."Bill-to Customer No.");
                                Fact_Abo."Bill-to Customer No." := Cust."No.";
                                Fact_Abo."Bill-to Name" := Cust.Name;
                                Fact_Abo."Bill-to Name 2" := Cust."Name 2";
                                Fact_Abo."Bill-to Address" := Cust.Address;
                                Fact_Abo."Bill-to Address 2" := Cust."Address 2";
                                Fact_Abo."Bill-to City" := Cust.City;
                                Fact_Abo."Bill-to Post Code" := Cust."Post Code";
                                Fact_Abo."Bill-to County" := Cust.County;
                                Fact_Abo."Bill-to Country/Region Code" := Cust."Country/Region Code";
                                Fact_Abo."Bill-to Contact" := Cust.Contact;
                                Fact_Abo."VAT Registration No." := Cust."VAT Registration No.";
                                Fact_Abo."VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                                Fact_Abo."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                                Fact_Abo."Customer Posting Group" := Cust."Customer Posting Group";
                                Rec."Ship-to Code" := '';
                                Cust.Get(Rec."Sell-to Customer No.");
                                Rec.CopyShipToCustomerAddressFieldsFromCust(Cust);

                                Fact_Abo."SalesPerson Code" := Cust."Salesperson Code";
                                Fact_Abo.MODIFY;

                            UNTIL Fact_Abo.NEXT = 0;
                        Contrato.Reset;
                        if Contrato.Get(Rec."Document Type", Rec."No.") THEN Begin
                            Cust.Get(Cust2."No.");
                            Contrato."Sell-to Customer No." := Cust."No.";
                            Contrato."Sell-to Customer Name" := Cust.Name;
                            Contrato."Sell-to Customer Name 2" := Cust."Name 2";
                            Contrato."Payment Method Code" := Cust."Payment Method Code";
                            Contrato."Payment Terms Code" := Cust."Payment Terms Code";
                            Contrato."Salesperson Code" := Cust."Salesperson Code";
                            Contrato."Sell-to Address" := Cust.Address;
                            Contrato."Sell-to Address 2" := Cust."Address 2";
                            Contrato."Sell-to City" := Cust.City;
                            Contrato."Sell-to Post Code" := Cust."Post Code";
                            Contrato."Sell-to County" := Cust.County;
                            Contrato."Sell-to Country/Region Code" := Cust."Country/Region Code";
                            Contrato."Sell-to Contact" := Cust.Contact;
                            Contrato."VAT Registration No." := Cust."VAT Registration No.";
                            if Cust."Bill-to Customer No." <> '' THEN Cust.GET(Cust."Bill-to Customer No.");
                            Contrato."Bill-to Customer No." := Cust."No.";
                            Contrato."Bill-to Name" := Cust.Name;
                            Contrato."Bill-to Name 2" := Cust."Name 2";
                            Contrato."Bill-to Address" := Cust.Address;
                            Contrato."Bill-to Address 2" := Cust."Address 2";
                            Contrato."Bill-to City" := Cust.City;
                            Contrato."Bill-to Post Code" := Cust."Post Code";
                            Contrato."Bill-to County" := Cust.County;
                            Contrato."Bill-to Country/Region Code" := Cust."Country/Region Code";
                            Contrato."Bill-to Contact" := Cust.Contact;
                            Contrato."VAT Registration No." := Cust."VAT Registration No.";
                            Contrato."VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                            Contrato."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                            Contrato."Customer Posting Group" := Cust."Customer Posting Group";
                            Contrato."Ship-to Code" := '';
                            Contrato."Nuestra Cuenta" := Cust."Banco transferencia";
                            Contrato.CopyShipToCustomerAddressFieldsFromCust(Cust);
                            Contrato."Salesperson Code" := Rec."Salesperson Code";
                            Contrato.MODIFY;

                        end;
                        if Job.Get(Rec."Nº Proyecto") Then begin
                            Cust.Get(Cust2."No.");
                            Job."Sell-to Customer No." := Cust."No.";
                            Job."Sell-To Customer Name" := Cust.Name;
                            Job."Sell-to Customer Name 2" := Cust."Name 2";
                            Job."Sell-to Address" := Cust.Address;
                            Job."Sell-to Address 2" := Cust."Address 2";
                            Job."Sell-to City" := Cust.City;
                            Job."Payment Method Code" := Cust."Payment Method Code";
                            Job."Payment Terms Code" := Cust."Payment Terms Code";
                            Job."Cód. vendedor" := Cust."Salesperson Code";

                            Job."Sell-to Post Code" := Cust."Post Code";
                            Job."Sell-to Country/Region Code" := Cust."Country/Region Code";
                            Job."Currency Code" := Cust."Currency Code";
                            Job."Customer Disc. Group" := Cust."Customer Disc. Group";
                            Job."Customer Price Group" := Cust."Customer Price Group";
                            Job."Language Code" := Cust."Language Code";

                            if Cust."Bill-to Customer No." <> '' THEN
                                Cust.GET(Cust."Bill-to Customer No.");
                            Job."Bill-to Customer No." := Cust."No.";
                            Job."Bill-to Name" := Cust.Name;
                            Job."Bill-to Name 2" := Cust."Name 2";
                            Job."Bill-to Address" := Cust.Address;
                            Job."Bill-to Address 2" := Cust."Address 2";
                            Job."Bill-to City" := Cust.City;
                            Job."Bill-to Post Code" := Cust."Post Code";
                            Job."Bill-to Country/Region Code" := Cust."Country/Region Code";
                            Job."Currency Code" := Cust."Currency Code";
                            Job."Bill-to County" := Cust.County;
                            Job."Cód. vendedor" := Cust."Salesperson Code";
                            Job.Modify();
                        end;
                    end;
                }

            }
            group(Approval)
            {
                Caption = 'Aprobaciones';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Aprobar';
                    Image = Approve;
                    //Promoted = true;
                    //PromotedCategory = Category4;
                    //PromotedIsBig = true;
                    //PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;

                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Rechazar';
                    Image = Reject;
                    //Promoted = true;
                    //PromotedCategory = Category4;
                    //PromotedIsBig = true;
                    //PromotedOnly = true;
                    // ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegar';
                    Image = Delegate;
                    //Promoted = true;
                    //PromotedCategory = Category4;
                    //PromotedOnly = true;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comentarios';
                    Image = ViewComments;
                    //Promoted = true;
                    //PromotedCategory = Category4;
                    //PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(Action21)
            {
                Caption = 'Lanzar';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Lan&zar';
                    Image = ReleaseDoc;
                    //Promoted = true;
                    //PromotedCategory = Category5;
                    //PromotedIsBig = true;
                    //PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';
                    //ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Volver A&brir';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    //Promoted = true;
                    //PromotedCategory = Category5;
                    //PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unciones';
                Image = Flow;
                action(CalculateInvoiceDiscount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calcular &Descuento factura y prepago';
                    Image = CalculateDiscount;
                    //ToolTip = 'Update the lines with any payment discount that is specified in the related payment terms.';

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                group("Create Purchase Document")
                {
                    Caption = 'Crear Docuemnto de compra';
                    Image = NewPurchaseInvoice;
                    ToolTip = 'Create a new purchase document so you can buy items from a vendor.';
                    action(CreatePurchaseOrder)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Crear Pedido Compra';
                        Image = Document;
                        //Promoted = false;
                        //The property '//PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        ////PromotedCategory = Category8;
                        //The property '//PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        ////PromotedIsBig = true;
                        // ToolTip = 'Create one or more new purchase orders to buy the items that are required by this sales document, minus any quantity that is already available.';

                        trigger OnAction()
                        var
                            PurchDocFromSalesDoc: Codeunit "Purch. Doc. From Sales Doc.";
                        begin
                            PurchDocFromSalesDoc.CreatePurchaseOrder(Rec);
                        end;
                    }
                    action(CreatePurchaseInvoice)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Crear Factura Compra';
                        Image = NewPurchaseInvoice;
                        //Promoted = false;
                        //The property '//PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        ////PromotedCategory = Category8;
                        //The property '//PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        ////PromotedIsBig = true;
                        ToolTip = 'Create a new purchase invoice to buy all the items that are required by the sales document, even if some of the items are already available.';

                        trigger OnAction()
                        var
                            SelectedSalesLine: Record "Sales Line";
                            PurchDocFromSalesDoc: Codeunit "Purch. Doc. From Sales Doc.";
                        begin
                            CurrPage.SalesLines.PAGE.SetSelectionFilter(SelectedSalesLine);
                            PurchDocFromSalesDoc.CreatePurchaseInvoice(Rec, SelectedSalesLine);
                        end;
                    }
                }
                action(GetRecurringSalesLines)
                {
                    ApplicationArea = Suite;
                    Caption = 'Traer líneas recurrentes';
                    Ellipsis = true;
                    Image = CustomerCode;
                    //Promoted = true;
                    //PromotedCategory = Category7;
                    //  ToolTip = 'Insert sales document lines that you have set up for the customer as recurring. Recurring sales lines could be for a monthly replenishment order or a fixed freight expense.';

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = Suite;
                    Caption = 'Copiar Documento';
                    Ellipsis = true;
                    Enabled = Rec."No." <> '';
                    Image = CopyDocument;
                    //Promoted = true;
                    //PromotedCategory = Category7;
                    //PromotedIsBig = true;
                    // ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

                    trigger OnAction()
                    begin
                        Rec.CopyDocument();
                        if Rec.Get(Rec."Document Type", Rec."No.") then;
                    end;
                }
                action(MoveNegativeLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mover Líneas Negativas';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    //ToolTip = 'Prepare to create a replacement sales order in a sales return process.';

                    trigger OnAction()
                    begin
                        Clear(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RunModal;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archi&var Documento';
                    Image = Archive;
                    ToolTip = 'Enviar el contrato al archivo, por ejemplo por si se borra o se modifica.';

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.Update(false);
                    end;
                }
                action("Send IC Sales Order")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    ApplicationArea = Intercompany;
                    Caption = 'Enviar Pedido Venta InterEmpresas';
                    Image = IntercompanyOrder;
                    ToolTip = 'Enviar el contrato to the intercompany a la otra empresa';

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                            ICInOutboxMgt.SendSalesDoc(Rec, false);
                    end;
                }
                group(IncomingDocument)
                {
                    Caption = 'Documento Entrante';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Ver Documento Entrante';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        // ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        AccessByPermission = TableData "Incoming Document" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Selecionar Documento entrante';
                        Image = SelectLineToApply;
                        // ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId));
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Crear Documento entrante desde fichero';
                        Ellipsis = true;
                        Enabled = NOT HasIncomingDocument;
                        Image = Attach;
                        // ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';

                        trigger OnAction()
                        var
                            IncomingDocumentAttachment: Record "Incoming Document Attachment";
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromSalesDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Eliminar Documento Entrante';
                        Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        // ToolTip = 'Remove any incoming document records and file attachments.';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            if IncomingDocument.Get(Rec."Incoming Document Entry No.") then
                                IncomingDocument.RemoveLinkToRelatedRecord;
                            Rec."Incoming Document Entry No." := 0;
                            Rec.Modify(true);
                        end;
                    }
                }
            }
            group(Plan)
            {
                Caption = 'Plan';
                Image = Planning;
                action(OrderPromising)
                {
                    AccessByPermission = TableData "Order Promising Line" = R;
                    ApplicationArea = OrderPromising;
                    Caption = 'Pedido &Comprometido';
                    Image = OrderPromising;
                    //  ToolTip = 'Calculate the shipment and delivery dates based on the item''s known and expected availability dates, and then promise the dates al cliente.';

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SetRange("Source Type", Rec."Document Type");
                        OrderPromisingLine.SetRange("Source ID", Rec."No.");
                        PAGE.RunModal(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Demand Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Demanda';
                    Image = Forecast;
                    ToolTip = 'Get an overview of demand for your items when planning sales, production, jobs, or service management and when they will be available.';

                    trigger OnAction()
                    var
                        DemandOverview: Page "Demand Overview";
                        "Demand Order Source Type": Enum "Demand Order Source Type";
                    begin
                        DemandOverview.SetCalculationParameter(true);
                        DemandOverview.SetParameters(0D, "Demand Order Source Type"::"All Demands", Rec."No.", '', '');
                        DemandOverview.RunModal;
                    end;
                }
                action("Pla&nning")
                {
                    ApplicationArea = Planning;
                    Caption = 'Pla&nning';
                    Image = Planning;
                    // ToolTip = 'Open a tool for manual supply planning that displays all new demand along with availability information and suggestions for supply. It provides the visibility and tools needed to plan for demand from sales lines and component lines and then create different types of supply orders directly.';

                    trigger OnAction()
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder(Rec."No.");
                        SalesPlanForm.RunModal;
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Aprobaciones';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Enviar solicitud a&pprobación';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    //Promoted = true;
                    //PromotedCategory = Category9;
                    //PromotedIsBig = true;
                    //    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancelar solicitud aprobación';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    //Promoted = true;
                    //PromotedCategory = Category9;
                    //   ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }

            }
            group("P&osting")
            {
                Caption = 'Proponer &facturación contratos';
                Image = Post;

                action("Anular Facturación")
                {
                    Image = Undo;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        Facturas: record "Sales Header";
                    begin
                        if Rec."Tipo Facturacion" <> Rec."Tipo Facturacion"::"Por Términos" Then Error('Solo se puede anular la facturación por términos');
                        Rec.CalcFields("Facturas Registradas");
                        if Rec."Facturas Registradas" = 0 then begin
                            Facturas.SetRange("Document Type", Facturas."Document Type"::Invoice);
                            Facturas.SetRange("Nº Contrato", Rec."No.");
                            Facturas.DeleteAll(True);
                            Rec."Facturacion Iniciada" := false;
                            Rec."Creada su facturación" := false;
                            Rec."Creada facturación Prepago" := false;
                            Rec.Modify();
                        end;
                    end;
                }
                action("Recalcular Compra")
                {
                    Image = Calculate;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        LinProy: Record "Job Planning Line";
                        LinContr: Record "Sales Line";
                    begin
                        LinContr.SetRange("Document Type", Rec."Document Type");
                        LinContr.SetRange("Document No.", Rec."No.");
                        if LinContr.FindFirst() then
                            repeat
                                LinProy.SetRange("Job No.", LinContr."Job No.");
                                LinProy.SetRange("Line No.", Lincontr."No linea proyecto");
                                if LinProy.FindFirst() Then begin
                                    LinContr.Validate("Precio Compra", linproy."Unit Cost");
                                    Lincontr.Validate("Dto. Compra", LinProy."% Dto. Compra");
                                    LinContr.Modify();
                                end;
                            until LinContr.Next() = 0;

                    end;
                }
                // action(PostAndNew)
                // {
                //     Enabled = false;
                //     Visible = False;
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Registrar y nuevo';
                //     Ellipsis = true;
                //     Image = PostOrder;
                //     //Promoted = true;
                //     //PromotedCategory = Category6;
                //     ShortCutKey = 'Alt+F9';
                //     ToolTip = 'Post the sales document and create a new, empty one.';

                //     trigger OnAction()
                //     begin
                //         PostDocument(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"New Document");
                //     end;
                // }

                action("Test Report")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Informe de Test';
                    Ellipsis = true;
                    Image = TestReport;
                    //  ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("&Ver Facturas Propuestas")
                {
                    ApplicationArea = All;
                    Image = "Invoicing-MDL-PreviewDoc";
                    RunObject = Page "Lista Facturas Propuestas";
                    RunPageLink = "No. Contrato" = field("No.");
                }

                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Eliminar de la cola';
                    Image = RemoveLine;
                    //  ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
                }
                action(PreviewPosting)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vista previa registro';
                    Image = ViewPostedOrder;
                    //Promoted = true;
                    //PromotedCategory = Category6;
                    //   ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        ShowPreview;
                    end;
                }
                action(ProformaInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Factura Pro Forma';
                    Ellipsis = true;
                    Image = ViewPostedOrder;
                    //The property '//PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    ////PromotedCategory = Category5;
                    //    ToolTip = 'View or print the pro forma sales invoice.';

                    trigger OnAction()
                    begin
                        DocPrint.PrintProformaSalesInvoice(Rec);
                    end;
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&go';
                    Image = Prepayment;
                    action("Prepayment &Test Report")
                    {
                        ApplicationArea = Prepayments;
                        Caption = 'Informe test prepago';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;
                        //       ToolTip = 'Preview the prepayment transactions that will results from posting the sales document as invoiced. ';

                        trigger OnAction()
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
                        end;
                    }
                    // action(PostPrepaymentInvoice)
                    // {
                    //     ApplicationArea = Prepayments;
                    //     Caption = 'Registrar factura Prepago';
                    //     Ellipsis = true;
                    //     Image = PrepaymentPost;
                    //     //    ToolTip = 'Post the specified prepayment information. ';
                    //     Enabled = false;
                    //     trigger OnAction()
                    //     var
                    //         SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                    //     begin
                    //         if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                    //             SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                    //     end;
                    // }
                    // action("Post and Print Prepmt. Invoic&e")
                    // {
                    //     ApplicationArea = Prepayments;
                    //     Caption = 'Registrar e imprimir factura Prepago';
                    //     Ellipsis = true;
                    //     Image = PrepaymentPostPrint;
                    //     //    ToolTip = 'Post the specified prepayment information and print the related report. ';
                    //     Enabled = false;
                    //     trigger OnAction()
                    //     var
                    //         SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                    //     begin
                    //         if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                    //             SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, true);
                    //     end;
                    // }


                    // action("Post and Print Prepmt. Cr. Mem&o")
                    // {
                    //     ApplicationArea = Prepayments;
                    //     Caption = 'Registrar abono Prepago';
                    //     Ellipsis = true;
                    //     Image = PrepaymentPostPrint;
                    //     //        ToolTip = 'Create and post a credit memo for the specified prepayment information and print the related report.';
                    //     Enabled = false;
                    //     trigger OnAction()
                    //     var
                    //         SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                    //     begin
                    //         if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                    //             SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, true);
                    //     end;
                    // }

                    action(PostPrepaymentCreditMemo)
                    {
                        ApplicationArea = all;
                        Caption = 'Registrar abono Prepago';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ToolTip = 'Crear y registrar un abono para el prepago especificado.';

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";

                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then begin

                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, false);




                            end;
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        ApplicationArea = all;
                        Caption = 'Registrar e imprimir abono Prepago';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ToolTip = 'Crear y registrar un abono para el prepago especificado y imprimir el informe relacionado.';

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, true);
                        end;
                    }
                }
            }
            group("&Print")
            {
                Caption = '&Imprimir';
                Image = Print;
                // action("Imprimir &especial")
                // {
                //     ApplicationArea = All;
                //     Image = PrintDocument;
                //     trigger OnAction()
                //     begin

                //         Control_Previo;

                //         rCab2.SETRANGE("No.", Rec."No.");
                //         REPORT.RUNMODAL(REPORT::"Informe Presupuesto esp.", TRUE, FALSE, rCab2)
                //     end;
                // }


                action("Work Order")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orden de trabajo';
                    Ellipsis = true;
                    Image = Print;
                    //      ToolTip = 'Prepare to registers actual item quantities or time used in connection with the sales order. For example, the document can be used by staff who perform any kind of processing work in connection with the sales order. It can also be exported to Excel if you need to process the sales line data further.';

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }

            }
            group("&Order Confirmation")
            {
                Caption = '&Orden Confirmación';
                Image = Email;
                action(SendEmailConfirmation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Email Confirmación';
                    Ellipsis = true;
                    Image = Email;
                    //Promoted = true;
                    //PromotedCategory = Category11;
                    //PromotedIsBig = true;
                    //  ToolTip = 'Send a sales order confirmation by email. The attachment is sent as a .pdf.';

                    trigger OnAction()
                    begin
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
                group(Action96)
                {
                    Visible = false;
                    action("Print Confirmation")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Imprimir Confirmación';
                        Ellipsis = true;
                        Image = Print;
                        //Promoted = true;
                        //PromotedCategory = Category11;
                        //   ToolTip = 'Print a sales order confirmation.';
                        Visible = NOT IsOfficeHost;

                        trigger OnAction()
                        begin
                            DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                        end;
                    }
                    action(AttachAsPDF)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Adjuntar como PDF';
                        Ellipsis = true;
                        Image = PrintAttachment;
                        //Promoted = true;
                        //PromotedCategory = Category11;
                        //  ToolTip = 'Create a PDF file and attach it to the document.';

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                        begin
                            SalesHeader := Rec;
                            SalesHeader.SetRecFilter();
                            DocPrint.PrintSalesOrderToDocumentAttachment(SalesHeader, DocPrint.GetSalesOrderPrintToAttachmentOption(Rec));
                        end;
                    }
                }
            }
        }
        area(Reporting)
        {
            action("Imprimir Letras")
            {
                ApplicationArea = All;
                Image = Payment;
                trigger OnAction()
                var
                    Contrato: Record 36;
                begin
                    Contrato.SetRange("Document Type", Rec."Document Type"::Order);
                    Contrato.SetRange("No.", Rec."No.");
                    Report.RunModal(50005, true, true, Contrato);//Report::Letras
                end;
            }
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
                        Report.RunModal(50021, true, true, Contrato);//Report::"Carta Bancaria B2b"
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
                        Report.RunModal(50009, true, true, Contrato);//Report::"Carta Bancaria"
                end;
            }

        }
        area(Promoted)
        {



            actionref("Desmarcar un Periodo_promoted"; "Desmarcar un Periodo")
            {

            }


            actionRef(Recordatorio_Promoted; Recorda)
            {

            }

            actionref("Cargar Datos Cliente_Promoted"; "Cargar Datos Cliente")
            {
            }
            actionref("Cambiar Cliente_Promoted"; "Cambiar Cliente")
            {
            }
            actionref("Ver Facturas Propuestas_Promoted"; "&Ver Facturas Propuestas")
            {

            }


            actionref("Imprimir Letras_Promoted"; "Imprimir Letras")
            {

            }
            // actionref("Carta Bancaria_Promoted"; "Carta Bancaria Core")
            // {

            // }
            actionref("Carta Bancaria B2B_Promoted"; "Carta Bancaria B2B")
            {

            }
            actionref("Navegar_Promoted"; "&Navegar")

            {

            }


        }

    }

    trigger OnAfterGetCurrRecord()
    var
        SalesHeader: Record "Sales Header";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        CustCheckCrLimit: Codeunit "Cust-Check Cr. Limit";
        SIIManagement: Codeunit "SII Management";
    begin
        DynamicEditable := CurrPage.Editable;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        CRMIsCoupledToRecord := CRMIntegrationEnabled;
        if CRMIsCoupledToRecord then
            CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
        UpdatePaymentService();
        if CallNotificationCheck then begin
            SalesHeader := Rec;
            SalesHeader.CalcFields("Amount Including VAT");
            CustCheckCrLimit.SalesHeaderCheck(SalesHeader);
            Rec.CheckItemAvailabilityInLines;
            CallNotificationCheck := false;
        end;

        //SIIManagement.CombineOperationDescription("Operation Description", "Operation Description 2", OperationDescription);
        StatusStyleTxt := Rec.GetStatusStyleText();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
        UpdateShipToBillToGroupVisibility;
        WorkDescription := Rec.GetWorkDescription;
        if BillToContact.Get(Rec."Bill-to Contact No.") then;
        if SellToContact.Get(Rec."Sell-to Contact No.") then;
        TotalesDocumentos;                                          //FCL-31/05/04
        if Rec."Nuestra Cuenta" = '' then Rec."Nuestra Cuenta" := NC();
        if Rec."Nuestra Cuenta Prepago" = '' Then Rec."Nuestra Cuenta Prepago" := NCP();
        BuscarProyectos;
        if Num_Contrato <> Rec."No." Then Importe485 := 'Sin Calcular';
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        JobQueuesUsed := SalesReceivablesSetup.JobQueueActive;
        SetExtDocNoMandatoryCondition;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if DocNoVisible then
            Rec.CheckCreditMaxBeforeInsert;

        if (Rec."Sell-to Customer No." = '') and (Rec.GetFilter("Sell-to Customer No.") <> '') then
            CurrPage.Update(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        xRec.Init();
        Rec."Responsibility Center" := UserMgt.GetSalesFilter;
        if (not DocNoVisible) and (Rec."No." = '') then
            Rec.SetSellToCustomerFromFilter;

        Rec.SetDefaultPaymentServices;
        UpdateShipToBillToGroupVisibility;
        // $010
        wContOrigen := '';
        wContOriginal := '';
        wContRenov := '';
    end;

    trigger OnOpenPage()
    var
        PaymentServiceSetup: Record "Payment Service Setup";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
        EnvironmentInfo: Codeunit "Environment Information";
        SIIManagement: Codeunit "SII Management";
    begin
        if UserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;

        Rec.SetRange("Date Filter", 0D, WorkDate());

        ActivateFields();

        SetDocNoVisible();

        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsOfficeHost := OfficeMgt.IsAvailable;
        IsSaas := EnvironmentInfo.IsSaaS;

        if (Rec."No." <> '') and (Rec."Sell-to Customer No." = '') then
            DocumentIsPosted := (not Rec.Get(Rec."Document Type", Rec."No."));

        //SIIManagement.CombineOperationDescription("Operation Description", "Operation Description 2", OperationDescription);
        PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;
        // $005  SETRANGE("Date Filter",0D,WORKDATE - 1);

        AplicarFiltros;                              //$011
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not DocumentIsScheduledForPosting and ShowReleaseNotification then
            if not InstructionMgt.ShowConfirmUnreleased then
                exit(false);
        if not DocumentIsPosted then
            exit(Rec.ConfirmCloseUnposted);
    end;

    var
        Importe485: Text;
        Num_Contrato: Text;
        NFC: Text;
        BillToContact: Record Contact;
        SellToContact: Record Contact;
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        UserMgt: Codeunit "User Setup Management";
        CustomerMgt: Codeunit "Customer Mgt.";
        FormatAddress: Codeunit "Format Address";
        ChangeExchangeRate: Page "Change Exchange Rate";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        NavigateAfterPost: Option "Posted Document","New Document","Do Nothing";
        AVBVISIBLE: Boolean;
        AVTVISIBLE: Boolean;
        AVB2VISIBLE: Boolean;
        Avisos: Text;
        fListaFras: Page "Lista documentos venta MLL";
        ImpBorFac: Decimal;
        ImpBorAbo: Decimal;
        ImpFac: Decimal;
        ImpAbo: Decimal;
        wdecimal: Decimal;
        TotImp: Decimal;
        TotCont: Decimal;
        wtexto: Text[30];
        Text0010: Label 'No ha especificado Tipo Facturación. ¿Desea utilizar "%1"?';

        Text0020: Label 'Proceso abortado por el usuario.';

        wContOrigen: Code[20];
        wContOriginal: Code[20];
        wContRenov: Code[20];
        Text005: Label 'No puede generar borradores de factura para este contrato porque debe generar primero el borrador de prepago y registrarlo.';

        JobQueueVisible: Boolean;
        Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
        Text002: Label 'The update has been interrupted to respect the warning.';
        DynamicEditable: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        ExternalDocNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        ShowWorkflowStatus: Boolean;
        IsOfficeHost: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        JobQueuesUsed: Boolean;
        ShowQuoteNo: Boolean;
        DocumentIsPosted: Boolean;
        DocumentIsScheduledForPosting: Boolean;
        OpenPostedSalesOrderQst: Label 'The order is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        PaymentServiceVisible: Boolean;
        PaymentServiceEnabled: Boolean;
        CallNotificationCheck: Boolean;
        EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';
        CanRequestApprovalForFlow: Boolean;
        //cGestFactecord 315;
        IsCustomerOrContactNotEmpty: Boolean;
        WorkDescription: Text;
        rCabF: Record 36;
        TotalSalesLine: Record 37;
        rProyectoLineLCY: Record 37;
        rCabFac: Record 112;
        rCabAbo: Record 114;
        rCab2: Record 36;
        //cGestFactecord 315;
        TotalSalesLineLCY: Record "Sales Line";
        rProyecto: Record 167;

        ApprovalMgt: Codeunit 439;
        RegisVtas: Codeunit 80;

        SalesSetup: Record 311;

        OperationDescription: Text[500];

        StatusStyleTxt: Text;
        IsSaas: Boolean;
        IsBillToCountyVisible: Boolean;
        IsSellToCountyVisible: Boolean;
        IsShipToCountyVisible: Boolean;

    protected var
#if CLEAN24
        ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address";
        BillToOptions: Option "Default (Customer)","Another Customer","Custom Address";
#else
        ShipToOptions: Enum "Sales Ship-to Options";
        BillToOptions: Enum "Sales Bill-to Options";
#endif
    local procedure ActivateFields()
    begin
        IsBillToCountyVisible := FormatAddress.UseCounty(Rec."Bill-to Country/Region Code");
        IsSellToCountyVisible := FormatAddress.UseCounty(Rec."Sell-to Country/Region Code");
        IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
    end;

    /// <summary>
    /// PostDocument.
    /// </summary>
    /// <param name="PostingCodeunitID">Integer.</param>
    /// <param name="Navigate">Option.</param>


    PROCEDURE TotalesDocumentos();
    VAR
        TempSalesLine: Record 37 TEMPORARY;
        rCabVenta: Record 36;
    BEGIN
        //FCL-31/05/04. Obtengo totales de borradores y facturas correspondientes a este contrato.
        If Rec."No." = '' Then exit;
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
                      wdecimal, wtexto, wdecimal, wdecimal, wdecimal);
                    if rCabVenta."Document Type" = rCabVenta."Document Type"::Invoice THEN BEGIN
                        //$009(I)
                        //ImpBorFac:=ImpBorFac + TotalSalesLineLCY."Amount Including VAT";
                        ImpBorFac := ImpBorFac + TotalSalesLineLCY.Amount;
                        //$009(F)
                    END
                    ELSE BEGIN
                        //$009(I)
                        //ImpBorAbo:=ImpBorAbo + TotalSalesLineLCY."Amount Including VAT";
                        ImpBorAbo := ImpBorAbo + TotalSalesLineLCY.Amount;
                        //$009(F)
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
                    //$009(I)
                    //ImpFac:=ImpFac + rCabFac."Amount Including VAT";
                    rCabFac.CALCFIELDS(Amount);
                    ImpFac := ImpFac + rCabFac.Amount;
                //$009(F)
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
                    //$009(I)
                    //ImpAbo:=ImpAbo + rCabAbo."Amount Including VAT";
                    rCabAbo.CALCFIELDS(Amount);
                    ImpAbo := ImpAbo + rCabAbo.Amount;
                //$009(F)
                UNTIL rCabAbo.NEXT = 0;
            END;

        END;

        //FCL-13/02/06. Incluyo sumatorio de totales y diferencia con el total del contrato.
        TotImp := ImpBorFac - ImpBorAbo + ImpFac - ImpAbo;

        if rCabVenta.GET(rCabVenta."Document Type"::Order, Rec."No.") THEN BEGIN
            CLEAR(TotalSalesLine);
            CLEAR(TotalSalesLineLCY);
            CLEAR(RegisVtas);
            CLEAR(TempSalesLine);
            RegisVtas.GetSalesLines(rCabVenta, TempSalesLine, 0);
            CLEAR(RegisVtas);
            RegisVtas.SumSalesLinesTemp(rCabVenta, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
                                        wdecimal, wtexto, wdecimal, wdecimal, wdecimal);
            //$009(I)
            //TotCont:=TotalSalesLineLCY."Amount Including VAT";
            TotCont := TotalSalesLineLCY.Amount;
            //$009(F)
        END;
    END;



    PROCEDURE BuscarProyectos();
    VAR
        rContrato: Record 36;
        wCuantos: Integer;
    BEGIN
        // $010 Obtengo los contratos asociados a los proyectos original y origen. También obtengo el renovado.
        // De momento no busco el contrato original, no interesa visualizarlo.

        wContOrigen := '';
        wContOriginal := '';
        wContRenov := '';

        if rProyecto.GET(Rec."Nº Proyecto") THEN BEGIN
            // {if rProyecto."Proyecto original" <> '' THEN BEGIN
            //   rContrato.RESET;
            //   rContrato.SETCURRENTKEY("Nº Proyecto");
            //   rContrato.SETRANGE("Nº Proyecto",rProyecto."Proyecto original");
            //   if rContrato.FINDFIRST THEN
            //     wContOriginal:=rContrato."No.";
            // END; }
            if rProyecto."Proyecto origen" <> '' THEN BEGIN
                rContrato.RESET;
                rContrato.SETCURRENTKEY("Nº Proyecto");
                rContrato.SETRANGE("Nº Proyecto", rProyecto."Proyecto origen");
                if rContrato.FINDFIRST THEN
                    wContOrigen := rContrato."No.";
            END;
            //$015(I)
            wCuantos := 0;
            rProyecto.RESET;
            rProyecto.SETCURRENTKEY("Proyecto origen");
            rProyecto.SETRANGE("Proyecto origen", Rec."Nº Proyecto");
            wCuantos := rProyecto.COUNT;
            //$015(F)
            rProyecto.RESET;
            rProyecto.SETCURRENTKEY("Proyecto origen");
            rProyecto.SETRANGE("Proyecto origen", Rec."Nº Proyecto");
            //$015(I)
            if wCuantos > 0 THEN
                rProyecto.SETFILTER("No.", '<>%1', Rec."Nº Proyecto");
            //$015(F)
            rProyecto.SETFILTER(rProyecto."Estado Contrato", '<>%1|<>%2', rProyecto."Estado Contrato"::Anulado, rProyecto."Estado Contrato"::Modificado);
            if NOT rProyecto.FINDFIRST THEN
                rProyecto.SETRANGE(rProyecto."Estado Contrato");
            if rProyecto.FINDFIRST THEN BEGIN
                rContrato.RESET;
                rContrato.SETCURRENTKEY("Nº Proyecto");
                rContrato.SETRANGE("Nº Proyecto", rProyecto."No.");
                if rContrato.FINDFIRST THEN
                    wContRenov := rContrato."No.";
            END;
        END;
    END;

    PROCEDURE AplicarFiltros();
    VAR
        rUsuario: Record 91;
    BEGIN
        //$011
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



    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.Update;
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        if Rec."Prepayment %" = 100 Then Rec."Prepmt. Posting Description" := Rec."Posting Description";
        CurrPage.Update;
        Rec."Prepayment Due Date" := Rec."Order Date";
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.Get();
        ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;


    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        ShowQuoteNo := Rec."Quote No." <> '';
        SetExtDocNoMandatoryCondition;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        IsCustomerOrContactNotEmpty := (Rec."Sell-to Customer No." <> '') or (Rec."Sell-to Contact No." <> '');
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        OrderSalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not OrderSalesHeader.Get(Rec."Document Type", Rec."No.") then begin
            SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.");
            if SalesInvoiceHeader.FindFirst then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesOrderQst, SalesInvoiceHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode)
                then
                    PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end;
    end;

    protected procedure UpdatePaymentService()
    var
        PaymentServiceSetup: Record "Payment Service Setup";
    begin
        PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;
        PaymentServiceEnabled := PaymentServiceSetup.CanChangePaymentService(Rec);
    end;

    /// <summary>
    /// UpdateShipToBillToGroupVisibility.
    /// </summary>
    procedure UpdateShipToBillToGroupVisibility()
    begin
#if CLEAN24
#pragma warning disable AL0432
        CustomerMgt.CalculateShipToBillToOptions(ShipToOptions, BillToOptions, Rec);
#pragma warning restore AL0432
#else
        CustomerMgt.CalculateShipBillToOptions(ShipToOptions, BillToOptions, Rec);
#endif

    end;



    /// <summary>
    /// CheckNotificationsOnce.
    /// </summary>
    procedure CheckNotificationsOnce()
    begin
        CallNotificationCheck := true;
    end;

    local procedure ShowReleaseNotification(): Boolean
    var
        LocationsQuery: Query "Locations from items Sales";
    begin
        if Rec.TestStatusIsNotReleased then begin
            LocationsQuery.SetRange(Document_No, Rec."No.");
            LocationsQuery.SetRange(Require_Pick, true);
            LocationsQuery.Open;
            if LocationsQuery.Read then
                exit(true);
            LocationsQuery.SetRange(Require_Pick);
            LocationsQuery.SetRange(Require_Shipment, true);
            LocationsQuery.Open;
            exit(LocationsQuery.Read);
        end;
        exit(false);
    end;


    PROCEDURE NCP(): Text[250];
    VAR
        r270: Record 270;
        r289: Record 289;
    BEGIN
        if r289.GET(Rec."Forma pago prepago") THEN BEGIN
            if r270.GET(Rec."Nuestra Cuenta Prepago") THEN BEGIN
                EXIT(r270."CCC Bank No." + '-' + r270."CCC Bank Branch No." + '-' + r270."CCC Control Digits" +
                '-' + r270."CCC Bank Account No.");
            END ELSE BEGIN
                if r289."Bill Type" = r289."Bill Type"::Transfer THEN BEGIN
                    AVBVISIBLE := TRUE;
                    AVTVISIBLE := TRUE;
                    AVB2VISIBLE := TRUE;
                    Avisos := Avisos + ' Especifique Nº de banco para la transferencia en la pestaña de prepago' +
                    ' en el campo Nuestra cuenta prepago';
                END;
                if r289."Bill Type" <> r289."Bill Type"::Transfer THEN BEGIN
                    Rec."Nuestra Cuenta prepago" := '';
                END;

            END;
        END;
    END;

    PROCEDURE NC(): Text[250];
    VAR
        r270: Record 270;
        r289: Record 289;
    BEGIN

        AVBVISIBLE := FALSE;
        AVB2VISIBLE := FALSE;
        AVTVISIBLE := FALSE;
        Avisos := '';
        if NOT r289.GET(Rec."Payment Method Code") THEN BEGIN
            AVBVISIBLE := TRUE;
            AVB2VISIBLE := TRUE;
            AVTVISIBLE := TRUE;
            Avisos := Avisos + ' Especifique forma de pago';
        END ELSE BEGIN
            if r270.GET(Rec."Nuestra Cuenta") THEN BEGIN
                EXIT(r270."CCC Bank No." + '-' + r270."CCC Bank Branch No." + '-' + r270."CCC Control Digits" +
                '-' + r270."CCC Bank Account No.");
            END ELSE BEGIN
                if r289."Bill Type" = r289."Bill Type"::Transfer THEN BEGIN
                    AVBVISIBLE := TRUE;
                    AVTVISIBLE := TRUE;
                    AVB2VISIBLE := TRUE;
                    Avisos := Avisos + ' Especifique Nº de banco para la transferencia en la pestaña de facturación' +
                    ' en el campo Nuestra cuenta transferencia';
                END;
                if r289."Bill Type" <> r289."Bill Type"::Transfer THEN BEGIN
                    Rec."Nuestra Cuenta" := '';
                END;
            END;
        END;
    END;

    local procedure ImporteBorradorCompra(): Decimal
    var
        Cab: Record "Purchase Header";
        Lin: Record "Purchase Line";
        rMov: Record "g/l Entry";
        Total: Decimal;
    begin
        If Rec."Nº Proyecto" = '' Then exit(0);
        Cab.SetRange("Document Type", Cab."Document Type"::Invoice);
        Cab.SetRange("Nº Proyecto", Rec."Nº Proyecto");
        if Cab.FindFirst() Then
            repeat
                Lin.SetRange("Document Type", Lin."Document Type"::Invoice);
                Lin.SetRange("Document No.", Cab."No.");
                if lin.FindFirst() Then
                    repeat
                        Total += Lin."Line Amount";
                    until lin.Next() = 0;
            until Cab.Next() = 0;
        exit(Total);
    end;

    local procedure ImporteCompra(): Decimal
    var
        Cab: Record "Purch. Inv. Header";
        Lin: Record "Purch. Inv. Line";
        linAno: Record "Purch. Cr. Memo Line";
        CabAbono: Record "Purch. Cr. Memo Hdr.";
        rMov: Record "g/l Entry";
        Total: Decimal;
    begin
        If Rec."Nº Proyecto" = '' Then exit(0);
        Cab.SetRange("Nº Proyecto", Rec."Nº Proyecto");
        if Cab.FindFirst() Then
            repeat
                Lin.SetRange("Document No.", Cab."No.");
                if lin.FindFirst() Then
                    repeat
                        Total += Lin."Line Amount";
                    until lin.Next() = 0;
            until Cab.Next() = 0;
        CabAbono.SetRange("Nº Proyecto", Rec."Nº Proyecto");
        if CabAbono.FindFirst() Then
            repeat
                linAno.SetRange("Document No.", CabAbono."No.");
                if linAno.FindFirst() Then
                    repeat
                        Total -= linAno."Line Amount";
                    until linAno.Next() = 0;
            until CabAbono.Next() = 0;
        exit(Total);
    end;

    local procedure Cuenta485(): Decimal;
    var
        Cab: Record "Sales Header";
        Lin: Record "Sales Line";
        rMov: Record "g/l Entry";
        Total: Decimal;
    begin
        Cab.SetRange("Document Type", Cab."Document Type"::Invoice);
        Cab.SetRange("Nº Contrato", Rec."No.");
        if Cab.FindFirst() Then
            repeat
                Lin.SetRange("Document Type", Lin."Document Type"::Invoice);
                Lin.SetFilter("No.", '485*');
                Lin.SetRange("Document No.", Cab."No.");
                if lin.FindFirst() Then
                    repeat
                        Total -= Lin."Line Amount";
                    until lin.Next() = 0;
            until Cab.Next() = 0;
        rMov.SetRange("Nº Contrato", Rec."No.");
        rMov.SetRange("G/L Account No.", '485', '486');
        //rMov.CalcFields("Núm. Contrato");
        if rMov.FindSet() then
            repeat
                Total += rMov.Amount;
            until rMov.Next() = 0;

        exit(Total);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLookupNuestraCuentaFicha(var Rec: Record "Sales Header"; var r270: Record "Bank Account")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLookupNuestraCuentaFichaPrepago(var Rec: Record "Sales Header"; var r270: Record "Bank Account")
    begin
    end;

    // {
    //   $001 MNC 291009   Controles previos a la impresion del contrato


    //   $002 MNC 131109   Si el contrato tiene prepago, saco el recibo
    //   $003 MNC 181109 Si el contrato tiene prepago, pero aun no se ha registrado, no dejo crear borradores
    //   $004 MNC 161209 Si el contrato no esta firmado, no dejo que se generen facturas. Depende de configuracion
    //   $005 MNC 250210 Lo quito, no se porque esta aqui este filtro
    //   $006 MNC 250210 Para que la fra prepago tenga los conceptos tal cual el contrato
    //   $007 FCL 130410 Calculo el total del contrato antes de crear las facturas, para crear cargo o abono
    //   $008 FCL 190410 Bloqueo la modificación nº 6, se tiene que comprimir el prepago
    //   $009 FCL 290410 Modifico los totales para que se calculen sobre la base
    //   $010 FCL 240510 Incluyo contrato original y origen, y renovado. Opción para ver contratos asociados.
    //   $011 FCL 050710 Aplico filtros por vendedor definidos en la tabla de usuarios.
    //   $012 FCL 100810 Modifico controles prepago, ahora se genera borrador y el usuario registra.
    //   $013 FCL 100810 Incluyo llamada a Imprimir letra timbrada y letra Malla.
    //   $014 FCL 111010 Incluyo nuevos campos en la pesta¤a de Prepago.

    //   ESTE OBJETO ES DISTINTO AL DE MALLA

    //   $015 FCL 191010 Al buscar el proyecto original tengo en cuenta que puede haber dos, en este caso
    //                   cogeré aquel cuyo nº proyecto origen sea distinto a nº proyecto.
    //   $016 FCL 291210 Nueva opción para imprimir carta bancaria
    //   $017 FCL 110111 Nuevas opciones para generar Pdf
    //   $018 FCL 280211 Opción para imprimir recibo prepago Malla.
    // }

}

