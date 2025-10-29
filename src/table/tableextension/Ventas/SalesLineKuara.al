/// <summary>
/// TableExtension SalesLineKuara (ID 80134) extends Record Sales Line.
/// </summary>
tableextension 80134 SalesLineKuara extends "Sales Line"
{
    fields
    {
        // Add changes to table fields here
        field(80100; DescuentoFicha; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "Cdad. Facturada MLL"; Decimal) { Description = 'Control porcentaje facturado en MLL'; }
        field(50001; "Medidas"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Medidas WHERE("No." = FIELD("No.")));
        }
        field(50002; "Cód. proveedor"; Code[20])
        {
            TableRelation = Vendor;
            Description = 'FCL-23/11/04. Para grabar en diario recurso.';
        }
        field(50003; "Reparto"; Enum "Reparto")
        {
            trigger OnValidate()
            BEGIN
                //'$011';
                if (Reparto = Reparto::"Fra prepago") AND ("Prepayment %" <> 0) THEN
                    ERROR(Text051);
            END;

        }
        field(50004; "Duración Facturada MLL"; Decimal) { Description = 'Control porcentaje facturado en MLL'; }
        field(50030; "No. Orden Publicidad"; Code[20])
        {
            ; trigger OnValidate()
            var
                rOrden: Record "Cab. orden publicidad";
            BEGIN
                //'$014';(I)

                //PermiteModificar;

                if "No. Orden Publicidad" <> '' THEN
                    rOrden.GET("No. Orden Publicidad");

                //'$014';(F)
            END;

        }
        field(50076; "Cod. Fase"; Code[10]) { Description = 'MNC - Mig 5.0'; }
        field(50077; "Cod. Subfase"; Code[10]) { Description = 'MNC - Mig 5.0'; }
        field(50080; "Linea Marcada a Borrador"; Boolean)
        {
            ; trigger OnValidate()
            VAR
                rCab: Record 36;
            BEGIN
                // '$005';
                if ("Linea Marcada a Borrador" AND (NOT xRec."Linea Marcada a Borrador")) THEN BEGIN
                    CLEAR(rCab);
                    rCab.INIT;
                    rCab.GET("Document Type", "Document No.");
                    if ((rCab."Tipo Facturacion".AsInteger() <> 0) AND
                       (rCab."Tipo Facturacion" <> rCab."Tipo Facturacion"::"Por Lineas")) THEN
                        ERROR(Text049);
                    if ("Cantidad pasada Borrador" >= Quantity) THEN
                        ERROR(Text050, Quantity);
                    "Cantidad a Borrador" := (Quantity - "Cantidad pasada Borrador");
                END;

                if ((NOT "Linea Marcada a Borrador") AND (xRec."Linea Marcada a Borrador")) THEN BEGIN
                    "Cantidad a Borrador" := 0;
                END;
            END;
        }
        field(50085; "Cantidad a Borrador"; Integer) { Description = '$004'; }
        field(50090; "Cantidad pasada Borrador"; Integer) { Description = '$004'; }
        field(50091; "Fecha inicial recurso"; Date)
        {
            trigger OnValidate()
            var
                wdias: Decimal;
                DF: DateFormula;
                i: Integer;
            begin
                if ("Fecha final recurso" <> 0D) And ("Fecha inicial recurso" <> 0D) Then begin
                    if ("Fecha final recurso" < "Fecha inicial recurso") then
                        Error('La fecha final no puede ser menor que la fecha inicial');


                end;
            end;
        }
        field(50092; "Fecha final recurso"; Date)
        {
            trigger OnValidate()
            var
                wdias: Decimal;
                DF: DateFormula;
                i: Integer;
            begin
                if ("Fecha final recurso" <> 0D) And ("Fecha inicial recurso" <> 0D) Then begin
                    if ("Fecha final recurso" < "Fecha inicial recurso") then
                        Error('La fecha final no puede ser menor que la fecha inicial');

                end;
            end;
        }
        field(50093; "Precio a Borrador"; Decimal) { Description = '$008'; }
        field(50094; "No linea proyecto"; Integer)
        {
            TableRelation = "Job Planning Line"."Line No." WHERE("Job No." = FIELD("Job No."));
            ValidateTableRelation = false;
            Caption = 'No. línea proyecto';
            Description = '$009';
        }
        field(50095; "Imprimir fecha recurso"; Boolean)
        {
            Description = '$010';
            trigger OnValidate()
            var
                rLinCont: Record "Sales Line";
                wLinea: Integer;
                wDescripcion: Text[50];
            begin
                If "Imprimir fecha recurso" = false then
                    exit;
                //Añade una línea en el documento
                CLEAR(rLinCont);
                rLinCont."Document Type" := Rec."Document Type";
                rLinCont."Document No." := Rec."Document No.";
                wLinea := Rec."Line No." + 10;
                repeat
                    rLinCont."Line No." := wLinea;
                    wLinea += 11;
                until rLinCont.INSERT;
                rLinCont.Type := rLinCont.Type::" ";
                wDescripcion := Format(Rec."Fecha inicial recurso", 0, '<Day,2>/<Month,2>/<Year>') + ' a ' + Format(Rec."Fecha final recurso", 0, '<Day,2>/<Month,2>/<Year>');
                rLinCont.Description := COPYSTR(wDescripcion, 1, 50);
                rLinCont.MODIFY;

            end;
        }
        field(50096; "No Orden Recurso"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."No. Orden" WHERE("No." = FIELD("No.")));
            Caption = 'No. Orden Recurso';
            Description = '$012';
            Editable = false;
        }
        field(50097; "Imprimir Nº recurso"; Boolean)
        {
            Description = '$010';
            trigger OnValidate()
            var
                rLinCont: Record "Sales Line";
                wLinea: Integer;
                wDescripcion: Text[50];
            begin
                If "Imprimir Nº recurso" = false then
                    exit;
                //Añade una línea en el documento
                CLEAR(rLinCont);
                rLinCont."Document Type" := Rec."Document Type";
                rLinCont."Document No." := Rec."Document No.";
                wLinea := Rec."Line No." + 10;
                repeat
                    rLinCont."Line No." := wLinea;
                    wLinea += 10;
                until rLinCont.INSERT;
                rLinCont.Type := rLinCont.Type::" ";
                wDescripcion := Rec."No.";
                rLinCont.Description := COPYSTR(wDescripcion, 1, 50);
                rLinCont.MODIFY;

            end;
        }
        field(50098; "Remarcar"; Boolean) { Description = '$015'; }
        field(51040; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Cód. dim. acceso dir. 3';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            trigger OnValidate()
            Var
                SalesHeader: Record "Sales Header";
            BEGIN
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");

            END;

        }
        field(51041; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Cód. dim. acceso dir. 4';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
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
        field(54000; "Imprimir"; Boolean) { InitValue = true; }
        field(70000; "Tipo sit. inmueble SII"; Code[10]) { Description = 'SII'; }
        field(70001; "Ref. catastral inmueble SII"; Text[30]) { Description = 'SII'; }

        // field(95000; "Retention % (GE)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     ObsoleteState = Removed;
        //     Caption = '% retención (BE)';
        // }
        // field(95001; "Retention % (IRPF)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     ObsoleteState = Removed;
        //     Caption = '% retención (IRPF)';
        // }
        // field(95002; "Retention Amount (GE)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     ObsoleteState = Removed;
        //     Caption = 'Importe retención (BE)';
        // }
        // field(95003; "Retention Amount (IRPF)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     ObsoleteState = Removed;
        //     Caption = 'Importe retención (IRPF)';
        // }
        field(50099; "Empresa Compra"; Text[30])
        {
            TableRelation = Company;
        }
        field(50100; "Empresa Venta"; Text[30])
        {
            TableRelation = Company;
        }
        field(50101; "Doc. Itercompany Venta"; Code[20])
        {

        }
        field(50102; "Doc Intercompany Compra"; Code[20])
        {
            //TableRelation = "Purchase Header"."No." where ("Document Type"=Field("Document Type"));
        }
        field(50103; "Precio Compra"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 2;
        }
        field(50104; "Dto. Compra"; Decimal)
        { }
        field(50105; "Linea Origen"; Integer)
        { }
        field(50106; "Contrato Origen"; Code[20])
        { }
        field(50107; "Precio Tarifa"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 2;
            trigger OnValidate()
            var
                Contrato: Record "Sales Header";
            begin
                If not Contrato.Get("Document Type", "Document No.") then
                    Contrato.Init;
                if Not Contrato."Marcar para Renovar" then
                    Validate("Unit Price", "Precio Tarifa" * (1 - "Dto. Tarifa" / 100));

            end;
        }

        field(50053; "Dto. Tarifa"; Decimal)
        {
            trigger OnValidate()
            var
                Contrato: Record "Sales Header";
            begin
                If not Contrato.Get("Document Type", "Document No.") then
                    Contrato.Init;
                if Not Contrato."Marcar para Renovar" then
                    Validate("Unit Price", "Precio Tarifa" * (1 - "Dto. Tarifa" / 100));
            end;
        }
        // field(92100; "Descuento Ficha Ocr"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(92101; "Seleccionar Línea"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(50054; "% Dto. Venta 1"; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
                Currency: Record Currency;
            begin

                //=100-((100-70)*(100-10)/100)
                "Line Discount %" := "% Dto. Venta 1";
                Validate("Line Discount %", 100 - ((100 - "% Dto. Venta 1") * (100 - "% Dto. Venta 2") / 100));
            END;
        }
        field(50055; "% Dto. Venta 2"; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
                Currency: Record Currency;
            begin

                //=100-((100-70)*(100-10)/100)
                Validate("Line Discount %", 100 - ((100 - "% Dto. Venta 1") * (100 - "% Dto. Venta 2") / 100));
            END;
        }
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            begin
                IF CurrFieldNo = FIELDNO("Line Discount %") THEN begin
                    "% Dto. Venta 2" := 0;

                    "% Dto. Venta 1" := "Line Discount %";
                end;
            end;
        }
        field(51035; Duracion; Decimal)
        {
            Caption = 'Duración';
            trigger OnValidate()
            var
                DF: DateFormula;
                i: Integer;
            begin
                if Duracion = 0 then exit;
                if "Fecha inicial recurso" = 0D then exit;
                If "Cdad. Soportes" = 0 Then "Cdad. Soportes" := 1;
                Case "Tipo Duracion" of
                    "Tipo Duracion"::" ":
                        Validate(Quantity, "Cdad. Soportes" * Duracion);
                    "Tipo Duracion"::"Días":
                        begin
                            Validate(Quantity, "Cdad. Soportes" * Duracion);
                            "Fecha final recurso" := "Fecha inicial recurso" + Duracion;
                        end;
                    "Tipo Duracion"::"Meses":
                        begin
                            Validate(Quantity, "Cdad. Soportes" * Duracion);
                            If Evaluate(DF, '<' + Format(Duracion) + 'M-1D>') then
                                If "Fecha final recurso" <> 0D then begin
                                    If ABS(CalcDate(DF, "Fecha inicial recurso") - "Fecha final recurso") > 1 then
                                        "Fecha final recurso" := CalcDate(DF, "Fecha inicial recurso");
                                end else
                                    "Fecha final recurso" := CalcDate(DF, "Fecha inicial recurso");
                        end;
                    "Tipo Duracion"::"Catorzenas":
                        begin
                            Validate(Quantity, "Cdad. Soportes" * Duracion);
                            "Fecha final recurso" := "Fecha final recurso" + 13;
                        end;
                    "Tipo Duracion"::Quincenas:
                        begin
                            Validate(Quantity, "Cdad. Soportes" * Duracion);
                            "Fecha final recurso" := "Fecha final recurso" + 14;
                        end;
                    "Tipo Duracion"::Semanas:
                        begin
                            Validate(Quantity, "Cdad. Soportes" * Duracion);
                            If Evaluate(DF, '<' + Format(Duracion) + 'W-1D>') then
                                "Fecha final recurso" := CalcDate(DF, "Fecha inicial recurso");
                        end;
                end;
            end;
        }
        field(51036; "Tipo Duracion"; Enum "Duracion")
        {
            Caption = 'Tipo Duración';
            trigger OnValidate()
            begin
                If "Tipo Duracion" = "Tipo Duracion"::" " Then
                    Validate(Duracion, 1);
                If Type = Type::" " then Validate(Duracion, 0);
            end;
        }
        field(50037; "Cdad. Soportes"; Decimal)
        {
            trigger OnValidate()
            begin
                If Type <> Type::" " then
                    If Duracion = 0 Then Duracion := 1;
                Validate(Quantity, "Cdad. Soportes" * Duracion);
            end;
        }
        field(54096; "Customer Order No."; Code[20]) { Caption = 'Nº de pedido cliente'; }



    }

    var
        myInt: Integer;
        Text034: Label 'El valor del campo %1 debe ser un número entero correspondiente al producto incluido en el grupo de productos de servicio si está activada la casilla de verificación del campo %2 en la ventana Grupos producto servicio.';
        Text035: Label 'Almacén';
        Text036: Label 'Inventario';
        Text037: Label 'No puede cambiar el %1 cuando la %2 es %3 y la %4 es positiva.';
        Text038: Label 'No puede cambiar el %1 cuando la %2 es %3 y la %4 es negativa.';
        Text039: Label '%1 unidades para el %2 %3 ya se han devuelto. Por lo tanto, sólo se pueden devolver %4 unidades.';
        Text040: Label 'Utilice el formulario %1 para insertar %2, si se utiliza el seguimiento de productos.';
        Text041: Label 'Debe cancelar la aprobación existente para este documento para poder cambiar el campo %1.';
        Text042: Label 'Al registrar Liq. por mov. contable, %1 se abrirá primero';
        Text043: Label 'no puede ser %1';
        Text044: Label 'no puede ser inferior a %1';
        Text045: Label 'no puede ser superior a %1';
        Text046: Label 'No puede devolver más de las %1 unidades enviadas para el %2 %3.';
        Text047: Label 'debe ser positivo cuando %1 no es 0.';
        Text048: Label 'No puede utilizar el seguimiento de productos en una %1 creada desde un %2.';
        Text049: Label 'Ya se ha iniciado la facturación de este contrato con otro tipo diferente al de Lineas. No puede marcar lineas.';
        Text050: Label 'Esta linea ya se ha facturado, no puede facturarse superior a %1.';
        Text051: Label 'No se permite porc. prepago para tipo reparto Fra prepago';
        Text052: Label 'No se permite modificar líneas de contrato porque el proceso de facturación se ha iniciado';
        rCta2: Record "G/L Account";
        rTexto: Record "Texto Presupuesto";
        rOrden: Record "Cab. orden publicidad";

    /// <summary>
    /// FiltroTexto.
    /// </summary>
    procedure FiltroTexto()
    begin

        if (Type = Type::Resource) THEN
            rTexto.SETRANGE("Nº", "No.");

        rTexto.SETRANGE("Nº proyecto", "Job No.");
        // $001 -
        // {
        // rTexto.SETRANGE("Cód. fase",     "Phase Code");
        // rTexto.SETRANGE("Cód. subfase",  "Task Code");
        // rTexto.SETRANGE("Cód. tarea",    "Step Code");
        // }
        // rTexto.SETRANGE("Cód. tarea",    "Job Task No.");
        rTexto.SETRANGE("Nº linea aux", "Line No.");
        // $001 +
        rTexto.SETRANGE("Cód. variante", "Variant Code");
        rTexto.SETFILTER(rTexto."Tipo linea", '%1|%2',
                        rTexto."Tipo linea"::Venta, rTexto."Tipo linea"::Ambos); //FCL-24/05/04
        Page.RUNMODAL(Page::"Texto Presupuesto", rTexto);
    end;

    /// <summary>
    /// PermiteModificar.
    /// </summary>
    procedure PermiteModificar()
    var
        rCabVenta: Record "Sales Header";
    begin

        if "Document Type" = "Document Type"::Order THEN BEGIN
            if rCabVenta.GET("Document Type", "Document No.") THEN BEGIN
                // {
                // rCabVenta.CALCFIELDS("Borradores de Factura");
                // rCabVenta.CALCFIELDS("Borradores de Abono");
                // rCabVenta.CALCFIELDS("Facturas Registradas");
                // rCabVenta.CALCFIELDS("Abonos Registrados");
                // if (rCabVenta."Borradores de Factura" <> 0) OR (rCabVenta."Borradores de Abono" <> 0) OR
                //    (rCabVenta."Facturas Registradas" <> 0) OR (rCabVenta."Abonos Registrados" <> 0) THEN
                //     ERROR(Text052);
                // }
                if rCabVenta.Status = rCabVenta.Status::Released THEN
                    ERROR(Text052);
            END;
        END;
    end;

    /// <summary>
    /// CalcVATAmountLinesEmpresa.
    /// </summary>
    /// <param name="QtyType">Option General,Invoicing,Shipping.</param>
    /// <param name="Var SalesHeader">Record "Sales Header".</param>
    /// <param name="Var SalesLine">Record "Sales Line".</param>
    /// <param name="VATAmountLine">VAR Record "VAT Amount Line".</param>
    /// <param name="Var Empresa">Text[30].</param>
    procedure CalcVATAmountLinesEmpresa(QtyType: Option General,Invoicing,Shipping; Var SalesHeader: Record "Sales Header"; Var SalesLine: Record "Sales Line"; var VATAmountLine: Record "VAT Amount Line"; Var Empresa: Text[30])
    var
        PrevVatAmountLine: Record "VAT Amount Line";
        Currency: Record Currency;
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        QtyFactor: Decimal;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine3: Record "Sales Line";
        rIva: Record "Iva por fechas";
        RoundingLineInserted: Boolean;
        TotalVATAmount: Decimal;
        Fecha: Date;
        r112: Record "Sales Invoice Header";
        VatPostingSetup: Record "VAT Posting Setup";
    begin

        if SalesHeader."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
        ELSE
            Currency.GET(SalesHeader."Currency Code");

        VATAmountLine.DELETEALL;
        WITH SalesLine DO BEGIN
            SETRANGE("Document Type", SalesHeader."Document Type");
            SETRANGE("Document No.", SalesHeader."No.");
            SETFILTER(Type, '>0');
            SETFILTER(Quantity, '<>0');
            SalesSetup.CHANGECOMPANY(Empresa);
            SalesSetup.GET;
            if SalesSetup."Invoice Rounding" THEN BEGIN
                SalesLine3.CHANGECOMPANY(Empresa);
                SalesLine3.COPYFILTERS(SalesLine);
                RoundingLineInserted := (SalesLine3.COUNT <> SalesLine.COUNT) AND NOT SalesLine."Prepayment Line";
            END;
            if FINDSET THEN
                REPEAT
                    if "VAT Calculation Type" IN
                        ["VAT Calculation Type"::"Reverse Charge VAT", "VAT Calculation Type"::"Sales Tax"]
                    THEN BEGIN
                        "VAT %" := 0;
                        "EC %" := 0;
                    END;
                    if NOT VATAmountLine.GET(
                        "VAT Identifier", "VAT Calculation Type", "Tax Group Code", FALSE, "Line Amount" >= 0)
                    THEN BEGIN
                        VATAmountLine.INIT;
                        VATAmountLine."VAT Identifier" := "VAT Identifier";
                        VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                        VATAmountLine."Tax Group Code" := "Tax Group Code";
                        VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                        // $006-  BLOQUEADO, YA NO SE UTILIZA
                        rIva.CHANGECOMPANY(Empresa);
                        rIva.SETRANGE(rIva."VAT Bus. Posting Group", "VAT Bus. Posting Group");
                        rIva.SETRANGE(rIva."VAT Prod. Posting Group", "VAT Prod. Posting Group");
                        //Parte del código no es de SGB
                        Fecha := SalesHeader."Posting Date";
                        if SalesHeader."Corrected Invoice No." <> '' THEN BEGIN
                            r112.SETRANGE("No.", SalesHeader."Corrected Invoice No.");
                            if r112.FINDFIRST THEN Fecha := r112."Posting Date";
                        END;
                        rIva.SETFILTER(rIva."Fecha Entrada en vigor", '<=%1', Fecha);
                        if rIva.FINDFIRST THEN BEGIN
                            VATPostingSetup.CHANGECOMPANY(Empresa);
                            VATPostingSetup.GET(rIva."New VAT Bus. Posting Group", rIva."New VAT Prod. Posting Group");

                            if QtyType = 4 THEN BEGIN
                                "VAT Bus. Posting Group" := rIva."New VAT Bus. Posting Group";
                                "VAT Prod. Posting Group" := rIva."New VAT Prod. Posting Group";
                                "VAT %" := VATPostingSetup."VAT %";
                                MODIFY;
                            END;
                        END;
                        // $006+

                        VATAmountLine."EC %" := VATPostingSetup."EC %";
                        VATAmountLine."VAT %" := VATPostingSetup."VAT %";
                        VATAmountLine.Modified := TRUE;
                        VATAmountLine.Positive := "Line Amount" >= 0;
                        VATAmountLine.INSERT;
                    END;
                    CASE QtyType OF
                        QtyType::General:
                            BEGIN
                                VATAmountLine.Quantity := VATAmountLine.Quantity + "Quantity (Base)";
                                VATAmountLine."Line Amount" := VATAmountLine."Line Amount" + "Line Amount";
                                if "Allow Invoice Disc." THEN
                                    VATAmountLine."Inv. Disc. Base Amount" :=
                                        VATAmountLine."Inv. Disc. Base Amount" + "Line Amount";
                                VATAmountLine."Invoice Discount Amount" :=
                                VATAmountLine."Invoice Discount Amount" + "Inv. Discount Amount";
                                VATAmountLine."Pmt. Discount Amount" :=
                                VATAmountLine."Pmt. Discount Amount" + "Pmt. Discount Amount";
                                VATAmountLine."Line Discount Amount" := VATAmountLine."Line Discount Amount" + "Line Discount Amount";
                                VATAmountLine."VAT Difference" := VATAmountLine."VAT Difference" + "VAT Difference";
                                VATAmountLine."EC Difference" := VATAmountLine."EC Difference" + "EC Difference";
                                if "Prepayment Line" THEN
                                    VATAmountLine."Includes Prepayment" := TRUE;
                                VATAmountLine.MODIFY;
                            END;
                        QtyType::Invoicing:
                            BEGIN
                                CASE TRUE OF
                                    ("Document Type" IN ["Document Type"::Order, "Document Type"::Invoice]) AND
                                    (NOT SalesHeader.Ship) AND SalesHeader.Invoice AND (NOT "Prepayment Line"):
                                        BEGIN
                                            if "Shipment No." = '' THEN BEGIN
                                                QtyFactor := GetAbsMin("Qty. to Invoice", "Qty. Shipped Not Invoiced") / Quantity;
                                                VATAmountLine.Quantity :=
                                                VATAmountLine.Quantity + GetAbsMin("Qty. to Invoice (Base)", "Qty. Shipped Not Invd. (Base)");
                                            END ELSE BEGIN
                                                QtyFactor := "Qty. to Invoice" / Quantity;
                                                VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Invoice (Base)";
                                            END;
                                        END;
                                    ("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) AND
                                    (NOT SalesHeader.Receive) AND SalesHeader.Invoice:
                                        BEGIN
                                            QtyFactor := GetAbsMin("Qty. to Invoice", "Return Qty. Rcd. Not Invd.") / Quantity;
                                            VATAmountLine.Quantity :=
                                                VATAmountLine.Quantity + GetAbsMin("Qty. to Invoice (Base)", "Ret. Qty. Rcd. Not Invd.(Base)");
                                        END;
                                    ELSE BEGIN
                                        QtyFactor := "Qty. to Invoice" / Quantity;
                                        VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Invoice (Base)";
                                    END;
                                END;
                                VATAmountLine."Line Amount" :=
                                VATAmountLine."Line Amount" +
                                ROUND("Line Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                if "Allow Invoice Disc." THEN
                                    VATAmountLine."Inv. Disc. Base Amount" :=
                                        VATAmountLine."Inv. Disc. Base Amount" +
                                        ROUND("Line Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                VATAmountLine."Invoice Discount Amount" :=
                                VATAmountLine."Invoice Discount Amount" + "Inv. Disc. Amount to Invoice";
                                VATAmountLine."Pmt. Discount Amount" :=
                                VATAmountLine."Pmt. Discount Amount" +
                                ROUND("Pmt. Discount Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                VATAmountLine."Line Discount Amount" := VATAmountLine."Line Discount Amount" + "Line Discount Amount";
                                VATAmountLine."VAT Difference" := VATAmountLine."VAT Difference" + "VAT Difference";
                                VATAmountLine."EC Difference" := VATAmountLine."EC Difference" + "EC Difference";
                                if "Prepayment Line" THEN
                                    VATAmountLine."Includes Prepayment" := TRUE;
                                VATAmountLine.MODIFY;
                            END;
                        QtyType::Shipping:
                            BEGIN
                                if "Document Type" IN
                                ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]
                                THEN BEGIN
                                    QtyFactor := "Return Qty. to Receive" / Quantity;
                                    VATAmountLine.Quantity := VATAmountLine.Quantity + "Return Qty. to Receive (Base)";
                                END ELSE BEGIN
                                    QtyFactor := "Qty. to Ship" / Quantity;
                                    VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Ship (Base)";
                                END;
                                VATAmountLine."Line Amount" :=
                                VATAmountLine."Line Amount" +
                                ROUND("Line Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                if "Allow Invoice Disc." THEN
                                    VATAmountLine."Inv. Disc. Base Amount" :=
                                        VATAmountLine."Inv. Disc. Base Amount" +
                                        ROUND("Line Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                VATAmountLine."Invoice Discount Amount" :=
                                VATAmountLine."Invoice Discount Amount" +
                                ROUND("Inv. Discount Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                VATAmountLine."Pmt. Discount Amount" :=
                                VATAmountLine."Pmt. Discount Amount" + "Pmt. Discount Amount";
                                VATAmountLine."Line Discount Amount" := VATAmountLine."Line Discount Amount" + "Line Discount Amount";
                                VATAmountLine."VAT Difference" := VATAmountLine."VAT Difference" + "VAT Difference";
                                VATAmountLine."EC Difference" := VATAmountLine."EC Difference" + "EC Difference";
                                if "Prepayment Line" THEN
                                    VATAmountLine."Includes Prepayment" := TRUE;
                                VATAmountLine.MODIFY;
                            END;
                    END;
                    if RoundingLineInserted THEN
                        TotalVATAmount := TotalVATAmount + "Amount Including VAT" - Amount + "VAT Difference";
                UNTIL NEXT = 0;
            SETRANGE(Type);
            SETRANGE(Quantity);
        END;

        WITH VATAmountLine DO
            if FINDSET THEN
                REPEAT
                    if (PrevVatAmountLine."VAT Identifier" <> "VAT Identifier") OR
                        (PrevVatAmountLine."VAT Calculation Type" <> "VAT Calculation Type") OR
                        (PrevVatAmountLine."Tax Group Code" <> "Tax Group Code") OR
                        (PrevVatAmountLine."Use Tax" <> "Use Tax")
                    THEN
                        PrevVatAmountLine.INIT;
                    if SalesHeader."Prices Including VAT" AND NOT ("VAT %" = 0) THEN BEGIN
                        CASE "VAT Calculation Type" OF
                            "VAT Calculation Type"::"Normal VAT",
                            "VAT Calculation Type"::"No taxable VAT":
                                BEGIN
                                    "VAT Base" :=
                                        ROUND(
                                        ("Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount") /
                                        (1 + ("VAT %" + "EC %") / 100),
                                        Currency."Amount Rounding Precision") - "VAT Difference";
                                    "VAT Amount" :=
                                        "VAT Difference" +
                                        ROUND(
                                        PrevVatAmountLine."VAT Amount" +
                                        ("Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount" -
                                        "VAT Base" - "VAT Difference") / ("VAT %" + "EC %") * "VAT %" * (1 - SalesHeader."VAT Base Discount %" / 100)
                        ,
                                        Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    "EC Amount" :=
                                        "EC Difference" +
                                        ROUND(
                                        ("Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount" -
                                        "VAT Base") / ("VAT %" + "EC %") * "EC %" * (1 - SalesHeader."VAT Base Discount %" / 100),
                                        Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    "Amount Including VAT" := "VAT Base" + "VAT Amount" + "EC Amount";
                                    if Positive THEN
                                        PrevVatAmountLine.INIT
                                    ELSE BEGIN
                                        PrevVatAmountLine := VATAmountLine;
                                        PrevVatAmountLine."VAT Amount" :=
                                        ("Line Amount" - "Invoice Discount Amount" - "VAT Base" - "VAT Difference") *
                                        (1 - SalesHeader."VAT Base Discount %" / 100);
                                        PrevVatAmountLine."VAT Amount" :=
                                        PrevVatAmountLine."VAT Amount" -
                                        ROUND(PrevVatAmountLine."VAT Amount", Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    END;
                                END;
                            "VAT Calculation Type"::"Reverse Charge VAT":
                                BEGIN
                                    "VAT Base" :=
                                        ROUND(
                                        ("Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount"),
                                        Currency."Amount Rounding Precision");
                                    "VAT Amount" := 0;
                                    "EC Amount" := 0;
                                    "Amount Including VAT" := "VAT Base";
                                END;
                            "VAT Calculation Type"::"Full VAT":
                                BEGIN
                                    "VAT Base" := 0;
                                    "VAT Amount" := "VAT Difference" + "Line Amount" - "Invoice Discount Amount";
                                    "Amount Including VAT" := "VAT Amount";
                                END;
                            "VAT Calculation Type"::"Sales Tax":
                                BEGIN
                                    "Amount Including VAT" := "Line Amount" - "Invoice Discount Amount";
                                    "VAT Base" :=
                                        ROUND(
                                        SalesTaxCalculate.ReverseCalculateTax(
                                            SalesHeader."Tax Area Code", "Tax Group Code", SalesHeader."Tax Liable",
                                            SalesHeader."Posting Date", "Amount Including VAT", Quantity, SalesHeader."Currency Factor"),
                                        Currency."Amount Rounding Precision");
                                    "VAT Amount" := "VAT Difference" + "Amount Including VAT" - "VAT Base";
                                    if "VAT Base" = 0 THEN BEGIN
                                        "VAT %" := 0;
                                        "EC %" := 0;
                                    END
                                    ELSE BEGIN
                                        "VAT %" := ROUND(100 * "VAT Amount" / "VAT Base", 0.000001);
                                        "EC %" := ROUND(100 * "EC Amount" / "VAT Base", 0.000001);
                                    END;
                                END;
                        END;
                    END ELSE BEGIN
                        CASE "VAT Calculation Type" OF
                            "VAT Calculation Type"::"No taxable VAT",
                            "VAT Calculation Type"::"Normal VAT":
                                BEGIN
                                    "VAT Base" := "Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount";
                                    "VAT Amount" :=
                                        "VAT Difference" +
                                        ROUND(
                                        PrevVatAmountLine."VAT Amount" +
                                        "VAT Base" * "VAT %" / 100 * (1 - SalesHeader."VAT Base Discount %" / 100),
                                        Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    "EC Amount" :=
                                        "EC Difference" +
                                        ROUND(
                                        "VAT Base" * "EC %" / 100 * (1 - SalesHeader."VAT Base Discount %" / 100),
                                        Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    "Amount Including VAT" := "Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount"
                                    + "VAT Amount" + "EC Amount";
                                    if Positive THEN
                                        PrevVatAmountLine.INIT
                                    ELSE BEGIN
                                        PrevVatAmountLine := VATAmountLine;
                                        PrevVatAmountLine."VAT Amount" :=
                                        "VAT Base" * "VAT %" / 100 * (1 - SalesHeader."VAT Base Discount %" / 100);
                                        PrevVatAmountLine."VAT Amount" :=
                                        PrevVatAmountLine."VAT Amount" -
                                        ROUND(PrevVatAmountLine."VAT Amount", Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    END;
                                END;
                            "VAT Calculation Type"::"Reverse Charge VAT":
                                BEGIN
                                    "VAT Base" := "Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount";
                                    "VAT Amount" := 0;
                                    "EC Amount" := 0;
                                    "Amount Including VAT" := "VAT Base";
                                END;
                            "VAT Calculation Type"::"Full VAT":
                                BEGIN
                                    "VAT Base" := 0;
                                    "VAT Amount" := "VAT Difference" + "Line Amount" - "Invoice Discount Amount";
                                    "Amount Including VAT" := "VAT Amount";
                                END;
                            "VAT Calculation Type"::"Sales Tax":
                                BEGIN
                                    "VAT Base" := "Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount";
                                    "VAT Amount" :=
                                        SalesTaxCalculate.CalculateTax(
                                        SalesHeader."Tax Area Code", "Tax Group Code", SalesHeader."Tax Liable",
                                        SalesHeader."Posting Date", "VAT Base", Quantity, SalesHeader."Currency Factor");
                                    "Amount Including VAT" := "VAT Base" + "VAT Amount" + "EC Amount";
                                END;
                        END;
                    END;
                    if RoundingLineInserted THEN
                        TotalVATAmount := TotalVATAmount - "VAT Amount";
                    "Calculated VAT Amount" := "VAT Amount" - "VAT Difference";
                    "Calculated EC Amount" := "EC Amount" - "EC Difference";
                    MODIFY;
                UNTIL NEXT = 0;

        if RoundingLineInserted AND (TotalVATAmount <> 0) THEN
            if VATAmountLine.GET(SalesLine."VAT Identifier", SalesLine."VAT Calculation Type",
                SalesLine."Tax Group Code", FALSE, SalesLine."Line Amount" >= 0)
            THEN BEGIN
                VATAmountLine."VAT Amount" := VATAmountLine."VAT Amount" + TotalVATAmount;
                VATAmountLine."Amount Including VAT" := VATAmountLine."Amount Including VAT" + TotalVATAmount;
                VATAmountLine."Calculated VAT Amount" := VATAmountLine."Calculated VAT Amount" + TotalVATAmount;
                VATAmountLine.MODIFY;
            END;
    end;

    // procedure GetAbsMin(QtyToHandle: Decimal; QtyHandled: Decimal): Decimal
    // begin
    //     if ABS(QtyHandled) < ABS(QtyToHandle) THEN
    //         EXIT(QtyHandled)
    //     ELSE
    //         EXIT(QtyToHandle);
    // end;
}