/// <summary>
/// TableExtension JobPlaningKuara (ID 80104) extends Record Job Planning Line.
/// </summary>
tableextension 80104 JobPlaningKuara extends "Job Planning Line"
{
    fields
    {
        // Add changes to table fields here

        field(50045; "Fija/Papel"; Enum "Fija/Papel")
        {
            DataClassification = ToBeClassified;


        }

        modify("Planning Date")
        {
            trigger OnAfterValidate()
            Begin
                if "No." = '' Then exit;
                VALIDATE("Document Date", "Planning Date");
                if ("Currency Date" = 0D) OR ("Currency Date" = xRec."Planning Date") THEN
                    VALIDATE("Currency Date", "Planning Date");
                if Type <> Type::Text THEN BEGIN
                    if "No." <> '' THEN
                        VALIDATE(Quantity);
                END;
                // $001 -
                if ("Fecha Final" < "Planning Date") THEN
                    if "Fecha Final" <> 0D Then
                        ERROR(Text50000);
                // $002
                if ("Cdad. Reservada" <> 0) THEN
                    ERROR(Text50002);
                if (Type = Type::Resource) THEN
                    Mirar_Estado;
                // $001 +
                if "Tipo Duracion" = "Tipo Duracion"::" " Then
                    Validate(Duracion, 1);
                if "Fecha Final" <> 0D then begin
                    if "Fecha Final" < "Planning Date" then
                        ERROR(Text50000);
                end;
            end;
        }

        field(50000; Tipo; Enum "Tipo Venta Job")
        {
            Caption = 'Tipo.';
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                RevisaOpciones;
            END;
        }

        field(50001; "Cdad. a Reservar"; Decimal)
        {

        }
        field(50006; Renovando; Boolean)
        { }
        field(50002; "Cdad. Reservada"; Decimal) { }
        field(50003; "Fecha Final"; Date)
        {

            trigger OnValidate()
            var
                rRes: Record Reserva;
                wdias: Decimal;
            begin
                if ("Fecha Final" < "Planning Date") THEN
                    if "Fecha Final" <> 0D Then
                        ERROR(Text50000);
                if ("Cdad. Reservada" <> 0) THEN BEGIN
                    rRes.SETRANGE(rRes."Nº Proyecto", "Job No.");
                    rRes.SETRANGE(rRes."Nº Recurso", "No.");
                    If (Not rRes.FINDLAST) and (Renovando = FALSE) THEN
                        Message('No Hay reservas en estas fechas');
                    if rRes."Fecha fin" <> "Fecha Final" THEN
                        ERROR(Text50002);
                END;
                if ("Fecha Final" <> 0D) AND (xRec."Fecha Final" <> "Fecha Final") THEN BEGIN
                    //Busca_Tarifa;                               //$012
                END;
                if (Type = Type::Resource) THEN
                    Mirar_Estado;
                if ("Fecha Final" <> 0D) And ("Planning Date" <> 0D) Then
                    wdias := "Fecha final" - "Planning Date" + 1;

                case "Tipo Duracion" of
                    "Tipo Duracion"::"Días":
                        wdias := wdias;
                    "Tipo Duracion"::"Semanas":
                        wdias := wdias / 7;
                    "Tipo Duracion"::Catorzenas:
                        begin
                            wdias := wdias / 14;
                            wdias := wdias;
                        end;
                    "tipo duracion"::"Quincenas":
                        begin
                            wdias := wdias / 15;
                            wdias := wdias;
                        end;
                    "Tipo Duracion"::"Meses":
                        wdias := wdias / 30;
                end;
                if wdias - Round(wdias, 1, '=') > 0.7 Then
                    wdias := Round(wdias, 1) + 1
                else
                    if wdias - Round(wdias, 1, '=') > 0.2 Then
                        wdias := Round(wdias, 1) + 0.5
                    else
                        wdias := Round(wdias, 1, '=');
                if Type = Type::Text then
                    wdias := 0;
                Duracion := wdias;
                Validate(Quantity, "Cdad. Soportes" * Duracion);
            END;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                rRes: Record Reserva;
                wdias: Decimal;
                Resource: Record Resource;
            begin

                if ("Fecha Final" < "Planning Date") THEN
                    if "Fecha Final" <> 0D Then
                        ERROR(Text50000);
                if ("Cdad. Reservada" <> 0) THEN BEGIN
                    rRes.SETRANGE(rRes."Nº Proyecto", "Job No.");
                    rRes.SETRANGE(rRes."Nº Recurso", "No.");
                    rRes.FINDLAST;
                    if rRes."Fecha fin" <> "Fecha Final" THEN
                        ERROR(Text50002);
                END;
                if ("Fecha Final" <> 0D) AND (xRec."Fecha Final" <> "Fecha Final") THEN BEGIN
                    //Busca_Tarifa;                               //$012
                END;
                if (Type = Type::Resource) THEN begin
                    Mirar_Estado;
                    If Resource.Get("No.") then begin
                        If Resource."Producción" then Reparto := Reparto::"1ª Fra+proporc.";
                    end;
                end;
                wdias := "Fecha final" - "Planning Date" + 1;
                case "Tipo Duracion" of
                    "Tipo Duracion"::"Días":
                        wdias := wdias;
                    "Tipo Duracion"::"Semanas":
                        wdias := wdias / 7;
                    "Tipo Duracion"::Catorzenas:
                        begin
                            wdias := wdias / 14;
                            wdias := wdias;
                        end;
                    "tipo duracion"::"Quincenas":
                        begin
                            wdias := wdias / 15;
                            wdias := wdias;
                        end;
                    "Tipo Duracion"::"Meses":
                        wdias := wdias / 30;


                end;
                if wdias - Round(wdias, 1, '=') > 0.7 Then
                    wdias := Round(wdias, 1) + 1
                else
                    if wdias - Round(wdias, 1, '=') > 0.2 Then
                        wdias := Round(wdias, 1) + 0.5
                    else
                        wdias := Round(wdias, 1, '=');
                if Type = Type::Text then
                    wdias := 0;
                Validate(Duracion, wdias);
                If Type <> Type::Text Then
                    if "Tipo Duracion" = "Tipo Duracion"::" " Then
                        Validate(Duracion, 1);
            END;
        }


        field(50005; "Compra a-Nº proveedor"; Code[20])
        {
            TableRelation = Vendor;
            trigger OnValidate()
            var
                myInt: Integer;
                rDim: Record "Default Dimension";
            begin

                if "Compra a-Nº proveedor" <> '' THEN BEGIN
                    if "Origin Line No." = 0 THEN
                        "Crear pedidos" := "Crear pedidos"::"De Compra Y De Venta" ELSE
                        "Crear pedidos" := "Crear pedidos"::"De Compra Y De Venta";
                END;

                if "Shortcut Dimension 5 Code" = '' THEN BEGIN
                    rDim.SETRANGE(rDim."Table ID", 23);
                    rDim.SETRANGE(rDim."No.", "No.");
                    rDim.SETRANGE(rDim."Dimension Code", 'SOPORTE');
                    if rDim.FINDFIRST THEN
                        "Shortcut Dimension 5 Code" := rDim."Dimension Value Code";
                END;
                if rOrden.GET("No. Orden Publicidad") THEN BEGIN
                    rOrden."Cod. Soporte" := "Compra a-Nº proveedor";
                    CALCFIELDS("Nombre Soporte");
                    rOrden."Nombre Soporte" := "Nombre Soporte";
                    rOrden.MODIFY;
                END;
            END;
        }
        field(50010; "Crear pedidos"; Enum "Crear Pedidos")
        {
            //OptionMembers = "De Venta","De Compra Y De Venta","De Compra";
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                if ("Crear pedidos" = "Crear pedidos"::"De Compra Y De Venta") THEN
                    TESTFIELD("Compra a-Nº proveedor");
                if Rec."Crear pedidos" in [Rec."Crear pedidos"::"De venta", Rec."Crear pedidos"::"De Compra Y De Venta"] then
                    Rec."Imprmir en Contrato/Factura" := true else
                    Rec."Imprmir en Contrato/Factura" := false;
                if Rec."Crear pedidos" = Rec."Crear pedidos"::"No crear pedido" then
                    Rec."Sin Producción" := true;
            END;

        }
        field(50015; "Enunciado Cto. Venta"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."Enunciado Cto. Venta" WHERE("No." = FIELD("No.")));
            Description = 'Solo se vera si existe en el recurso';
            Editable = false;
        }
        field(50016; Medidas; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Medidas WHERE("No." = FIELD("No.")));
            TableRelation = Medidas;
        }
        field(50020; "Nº fam. recurso"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."Resource Group No." WHERE("No." = FIELD("No.")));
            TableRelation = "Resource Group";
        }
        field(50025; "Texto en linea"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Texto Presupuesto" WHERE("Nº proyecto" = FIELD("Job No."),
            "Cód. tarea" = FIELD("Job Task No."),
            Tipo = FIELD(Type),
            "Nº" = FIELD("No."),
            "Cód. variante" = FIELD("Variant Code"),
            "Nº linea aux" = FIELD("Line No.")));
        }
        field(50026; "Shortcut Dimension 1 Code"; Code[10])
        {
            Caption = 'Cód. dim. acceso dir. 1';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            Begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(50027; "Shortcut Dimension 2 Code"; Code[10])
        {
            Caption = 'Cód. dim. acceso dir. 2';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            Begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50028; Reparto; Enum "Reparto")
        {
            //OptionMembers = Proporcional,"1ª Fra","1ª Fra+proporc.","Fra prepago";
            Description = 'FCL-02/06';
        }


        field(50030; "No. Orden Publicidad"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."No." WHERE("Nº proyecto" = FIELD("Job No.")));
            // CalcFormula=Lookup("Cab. orden publicidad".No WHERE ("Nº proyecto"=FIELD("Job No."),
            // "Nº tarea proyecto"=FIELD("Job Task No."),
            // "Nº linea"=FIELD("Line No.")));

            Description = 'FF';
            Editable = false;
        }
        field(50031; "Estado Orden Publicidad"; Enum "Estado Orden Publicidad")
        {

            FieldClass = FlowField;
            CalcFormula = Lookup("Cab. orden publicidad".Estado WHERE("Nº proyecto" = FIELD("Job No."),
            "Nº tarea proyecto" = FIELD("Job Task No."),
            "Nº linea" = FIELD("Line No.")));

            Description = 'FF';
            Editable = false;
        }
        field(50032; "Nombre Soporte"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Compra a-Nº proveedor")));
            Description = 'FF';
            Editable = false;
        }
        field(50035; "% Dto. Compra"; Decimal)
        {
            trigger OnValidate()
            var
                Currency: Record Currency;
            begin
                Validate("Unit Cost", "Unit Price" * (1 - "% Dto. Compra" / 100));
            end;
        }
        field(50040; "% Dto. Venta"; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
                Currency: Record Currency;
            begin
                If ("% Dto. Venta" <> 100 - ((100 - "% Dto. Venta 1") * (100 - "% Dto. Venta 2") / 100)) THEN begin
                    "% Dto. Venta 2" := 0;
                    "% Dto. Venta 1" := "Line Discount %";
                end;
                VALIDATE(Quantity);
                //VALIDATE("Line Discount %","% Dto. Venta");

                "Total Price (LCY)" := ROUND("Unit Price (LCY)" * Quantity * (1 - "% Dto. Venta" / 100), Currency."Amount Rounding Precision");
                "Total Price" := ROUND(Quantity * "Unit Price" * (1 - "% Dto. Venta" / 100), Currency."Amount Rounding Precision");
                "Total Venta" := "Total Price";
                "Line Amount" := "Line Amount" * (1 - "% Dto. Venta" / 100);
            END;
        }
        field(50054; "% Dto. Venta 1"; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
                Currency: Record Currency;
            begin

                //=100-((100-70)*(100-10)/100)
                Validate("% Dto. Venta", 100 - ((100 - "% Dto. Venta 1") * (100 - "% Dto. Venta 2") / 100));
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
                Validate("% Dto. Venta", 100 - ((100 - "% Dto. Venta 1") * (100 - "% Dto. Venta 2") / 100));
            END;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            var
                Currency: Record Currency;
            begin
                "Total Price (LCY)" := ROUND("Unit Price (LCY)" * Quantity * (1 - "% Dto. Venta" / 100), Currency."Amount Rounding Precision");
                "Total Price" := ROUND(Quantity * "Unit Price" * (1 - "% Dto. Venta" / 100), Currency."Amount Rounding Precision");
                "Line Amount" := "Line Amount" * (1 - "% Dto. Venta" / 100);
                "Total Venta" := "Total Price";
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                Currency: Record Currency;
            begin
                "Total Price (LCY)" := ROUND("Unit Price (LCY)" * Quantity * (1 - "% Dto. Venta" / 100), Currency."Amount Rounding Precision");
                "Total Price" := ROUND(Quantity * "Unit Price" * (1 - "% Dto. Venta" / 100), Currency."Amount Rounding Precision");
                "Line Amount" := "Line Amount" * (1 - "% Dto. Venta" / 100);
                "Total Venta" := "Total Price";
                "Total Cost (LCY)" := ROUND("Unit Cost (LCY)" * Quantity, Currency."Amount Rounding Precision");
                "Total Cost" := ROUND(Quantity * "Unit Cost", Currency."Amount Rounding Precision");

            end;
        }
        field(50041; "Soporte de"; Enum "Soporte de")
        {
            trigger OnValidate()
            begin

                RevisaOpciones;
            END;

        }
        field(50042; "Precio Tarifa"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 2;
            trigger OnValidate()
            begin
                Validate("Unit Price", "Precio Tarifa" * (1 - "Dto. Tarifa" / 100));
            end;
        }
        field(50053; "Dto. Tarifa"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("Unit Price", "Precio Tarifa" * (1 - "Dto. Tarifa" / 100));
            end;
        }
        field(50043; "Medio"; Code[20])
        { }
        field(50044; "Soporte Imp"; Code[20])
        { }
        field(50046; "No Orden Recurso"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."No. Orden" WHERE("No." = FIELD("No.")));
            Description = '$006';
            Editable = false;
        }
        field(50047; "Subtipo cabecera"; Enum "Subtipo")
        {

            FieldClass = FlowField;
            CalcFormula = Lookup(Job.Subtipo WHERE("No." = FIELD("Job No.")));
            Caption = 'Subtipo';

            Description = '$007';
        }
        field(50048; "Subtipo"; Enum "Subtipo")
        {
            Description = '$009';
        }
        field(50049; Remarcar; Boolean)
        {

            Description = '$011';
        }
        field(50050; "Shortcut Dimension 3 Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            Caption = 'Cód. dim. acceso dir. 3';
            CaptionClass = '1,2,3';
            trigger OnValidate()
            Begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50051; "Shortcut Dimension 5 Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            Caption = 'Cód. dim. acceso dir. 5';
            CaptionClass = '1,2,5';
            trigger OnValidate()
            Begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(50052; "Shortcut Dimension 4 Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            Caption = 'Cód. dim. acceso dir. 4';
            CaptionClass = '1,2,4';
            trigger OnValidate()
            Begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(50555; "Tipo Recurso"; Code[10])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."Tipo Recurso" WHERE("No." = FIELD("No.")));
            Description = 'FF';
            Editable = false;
        }
        field(55000; "Origin Line No."; Integer)
        { }
        field(55001; "Recurso Agrupado"; Boolean)
        {
            trigger OnValidate()
            var
                Job: Record Job;
            begin
                if Rec."Recurso Agrupado" then begin
                    if Job.Get(Rec."Job No.") then begin
                        Job.Validate("Según disponibilidad", true);
                        Job.Modify();
                    end;
                end;
            end;
        }

        field(55002; "Recurso en Empresa Origen"; Code[20])
        { }
        field(55003; "Linea en Empresa Origen"; Integer)
        { }

        field(55004; "Calculo Recurso Agrupado"; Boolean)
        {

            FieldClass = FlowField;
            CalcFormula = Exist(Resource WHERE("No." = FIELD("No."),
        "Recurso Agrupado" = CONST(true)));
        }
        field(55006; "Imprmir en Contrato/Factura"; Boolean)
        {
            InitValue = true;
            trigger OnValidate()
            var
                Res: Record Resource;
                Job: Record Job;
                Tipo: Record "Tipo Recurso";
            begin
                if Rec."Imprmir en Contrato/Factura" then
                    if Job.Get(Rec."Job No.") then
                        if job."Según disponibilidad" Then
                            if Not Job."Proyecto Mixto" then
                                if Res.Get(Rec."No.") Then
                                    if not Res."Recurso Agrupado" and not Res."Producción" then
                                        if Tipo.Get(Res."Tipo Recurso") Then if Tipo."Crea Reservas" then Error('No puede imprimirse este recurso en proyecto de disponibilidad, no mixtos');
            end;
        }
        field(55005; "Dimension Set ID"; integer)
        { }
        field(51035; Duracion; Decimal)
        {
            Caption = 'Duración';
            trigger OnValidate()
            var
                DF: DateFormula;
                i: Integer;
            begin
                If "Cdad. Soportes" = 0 Then "Cdad. Soportes" := 1;
                if Duracion = 0 then exit;
                Case "Tipo Duracion" of
                    "Tipo Duracion"::" ":
                        Validate(Quantity, "Cdad. Soportes" * Duracion);
                    "Tipo Duracion"::"Días":
                        begin
                            Validate(Quantity, "Cdad. Soportes" * Duracion);
                            "Fecha Final" := "Planning Date" + Duracion - 1;
                        end;
                    "Tipo Duracion"::"Meses":
                        begin
                            Validate(Quantity, "Cdad. Soportes" * Duracion);
                            If Evaluate(DF, '<' + Format(Duracion) + 'M-1D>') then
                                If "Fecha Final" <> 0D then begin
                                    If ABS(CalcDate(DF, "Planning Date") - "Fecha Final") > 1 then
                                        "Fecha Final" := CalcDate(DF, "Planning Date");
                                end else
                                    "Fecha Final" := CalcDate(DF, "Planning Date");
                        end;
                    "Tipo Duracion"::"Catorzenas":
                        begin
                            Validate(Quantity, "Cdad. Soportes" * Duracion);
                            //Ejemplo 1 Catorcena, empezano dia 2 de junio del 2025 es dia 15 de junio del 2025
                            //Ejemplo 2 Catorcenas, empezando dia 2 de junio del 2025 es dia 29 de junio del 2025
                            //Ejemplo 3 Catorcenas, empezando dia 2 de junio del 2025 es dia 13 de julio del 2025
                            //Ejemplo 4 Catorcenas, empezando dia 2 de junio del 2025 es dia 27 de julio del 2025
                            "Fecha Final" := "Planning Date" + (Duracion * 14) - 1;
                        end;
                    "Tipo Duracion"::Quincenas:
                        begin
                            Validate(Quantity, "Cdad. Soportes" * Duracion);
                            "Fecha Final" := "Planning Date";
                            //Sumar las catorcenas según la duración
                            "Fecha Final" := "Fecha Final" + (Duracion * 15) - 1;
                            //If i > 1 then
                            //    "Fecha Final" := "Fecha Final" + 1;
                        end;
                    "Tipo Duracion"::Semanas:
                        begin
                            Validate(Quantity, "Cdad. Soportes" * Duracion);
                            If Evaluate(DF, '<' + Format(Duracion) + 'W-1D>') then
                                "Fecha Final" := CalcDate(DF, "Planning Date");
                        end;
                end;
            end;
        }
        field(51036; "Tipo Duracion"; Enum "Duracion")
        {
            Caption = 'Tipo Duración';
            InitValue = " ";
            trigger OnValidate()
            var
                Job: Record Job;
            begin
                If "Tipo Duracion" = "Tipo Duracion"::" " Then
                    Validate(Duracion, 1)
                else begin
                    If xRec."Tipo Duracion" <> "Tipo Duracion" then begin
                        Job.Get(Rec."Job No.");
                        "Planning Date" := Job."Starting Date";
                        validate("Fecha Final", Job."Ending Date");

                    end;
                end;

                If Type = Type::Text then
                    Validate(Duracion, 0);
                Validate("Unit Price");
                Validate("% Dto. Compra");
            end;

        }
        field(50037; "Cdad. Soportes"; Decimal)
        {
            trigger OnValidate()
            begin
                If Type <> Type::Text then
                    If Duracion = 0 Then Duracion := 1;
                Validate(Quantity, "Cdad. Soportes" * Duracion);
            end;
        }
        field(50038; Cartel; Boolean)
        {

        }
        field(50039; Lona; Boolean)
        {

        }
        field(50034; Vinilo; Boolean)
        {

        }
        field(50033; Otros; Boolean)
        {

        }
        field(50029; "Sin Producción"; Boolean)
        {
            trigger OnValidate()
            begin
                If "Sin Producción" then
                    Cartel := false;
                Lona := false;
                Vinilo := false;
                Otros := false;
            end;
        }
        field(50056; "Solo Producción"; Boolean)
        {

        }
        field(50057; LineaProduccion; RecordId)
        {
        }
        field(50058; "Es Produccion"; Boolean)
        {

        }
        field(50059; "Total Venta"; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            var
                Currency: Record Currency;
                MaxLineAmount: Decimal;
                LineDiscountPct: Decimal;
            begin
                Currency.Get(Rec."Currency Code");
                "Total Venta" := Round("Total Venta", Currency."Amount Rounding Precision");
                MaxLineAmount := Round(Quantity * "Unit Price", Currency."Amount Rounding Precision");
                if Round(Quantity * "Unit Price", Currency."Amount Rounding Precision") <> 0 then
                    LineDiscountPct := Round(
                        MaxLineAmount - "Total Price" / Round(Quantity * "Unit Price", Currency."Amount Rounding Precision") * 100,
                        0.01);
                Validate("% Dto. Venta 1", LineDiscountPct);
            end;
        }





    }

    /// <summary>
    /// ValidateShortcutDimCode.
    /// </summary>
    /// <param name="FieldNumber">Integer.</param>
    /// <param name="ShortcutDimCode">VAR Code[20].</param>
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        IsHandled: Boolean;
        DimMgt: Codeunit DimensionManagement;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        //VerifyItemLineDim();

    end;

    PROCEDURE FiltroTexto(Linea: Integer);
    VAR
        rText: Record "Texto Presupuesto";
    BEGIN
        CLEAR(rText);
        rText.RESET;                         //FCL-15/04/10
        rText.SETCURRENTKEY("Nº proyecto", "Cód. tarea", "Nº linea aux", Tipo, "Nº", "Cód. variante");
        rText.SETRANGE("Nº proyecto", "Job No.");
        // $001 -
        //   {
        //   rText.SETRANGE("Cód. fase",     "Phase Code");
        //   rText.SETRANGE("Cód. subfase",  "Task Code");
        //   rText.SETRANGE("Cód. tarea",    "Step Code");
        //   }
        rText.SETRANGE("Cód. tarea", "Job Task No.");
        rText.SETRANGE("Nº linea aux", "Line No.");
        // $001 +
        rText.SETRANGE(Tipo, Rec.Type.AsInteger());
        rText.SETRANGE("Nº", Rec."No.");
        rText.SETRANGE("Cód. variante", Rec."Variant Code");

        Page.RUNMODAL(Page::"Texto Presupuesto", rText);
    END;

    // PROCEDURE Busca_Tarifa();
    // BEGIN
    //     //$001
    //     CLEAR(wP);
    //     if (Type = Type::Resource) AND ("Compra a-Nº proveedor" <> '') AND
    //        ("Planning Date" <> 0D) AND ("Fecha Final" <> 0D) THEN BEGIN
    //         wP := Gest_Rvas.Busca_Tarifa("No.", "Compra a-Nº proveedor", "Planning Date", "Fecha Final", "Job No.");
    //         if wp = 0 Then exit;
    //         CASE "Crear pedidos" OF
    //             "Crear pedidos"::"De Venta":
    //                 BEGIN
    //                     //  {
    //                     //  "Unit Price" := wP;
    //                     //  MODIFY;
    //                     //  VALIDATE("Unit Price");
    //                     //  }
    //                     VALIDATE("Unit Price", wP);
    //                 END;
    //             "Crear pedidos"::"De Compra Y De Venta":
    //                 BEGIN
    //                     // {
    //                     // "Unit Price" := wP;
    //                     // MODIFY;
    //                     // VALIDATE("Unit Price");
    //                     // "Unit Cost" := wP;
    //                     // MODIFY;
    //                     // VALIDATE("Unit Cost");
    //                     // }
    //                     VALIDATE("Unit Price", wP);
    //                     VALIDATE("Unit Cost", wP);
    //                 END;
    //         END;
    //     END;
    // END;

    trigger OnInsert()
    Var
        rSelf: Record "Job Planning Line";
        Job: Record Job;
        EsJulia: Boolean;
        Text50001: Label 'OJO. El proyecto ya esta en estado Contrato, y ya se han \creado los pedidos de venta y compra. Si quiere modificarlos\debera hacerlo a mano.';
    Begin
        Job.Get(Rec."Job No.");
        EsJulia := UserId in ['GRUPOMALLA\JULIÀ.SASTRE', 'JULIÀ.SASTRE'];
        // $001 -
        Job.TESTFIELD("Cód. vendedor");
        if Job.Status = Job.Status::Open THEN
            If not EsJulia then
                MESSAGE(Text50001);
        Rec."Planning Date" := Job."Starting Date";
        Rec."Fecha Final" := Job."Ending Date";
        //Mirar_Estado;
        // $001 +

        // $003-
        Rec.Tipo := Job.Tipo;
        Rec."Soporte de" := Job."Soporte de";
        Rec."Fija/Papel" := Job."Fija/Papel";
        // $003+
        Rec."Subtipo cabecera" := Job.Subtipo;                                //$009

        rSelf.SETRANGE(rSelf."Job No.", Rec."Job No.");
        rSelf.SETRANGE(rSelf."Job Task No.", Rec."Job Task No.");
        if rSelf.FINDLAST THEN
            If Rec."Line No." = 0 Then
                Rec."Line No." := rSelf."Line No." + 10000;
        // if BuscarecursosRelacionados("Line No.", "Job No.", "No.") = FALSE THEN
        //   Produccion;

    end;


    trigger OnModify()
    Begin

        if xRec."No." <> "No." THEN BEGIN
            //  VALIDATE("Unit Price", 0);
            BorrarecursosRelacionados("Line No.", "Job No.");
        END;
        //if BuscarecursosRelacionados("Line No.", "Job No.", "No.") = FALSE THEN
        //  Produccion; TODO Revisar
    End;

    trigger OnDelete()
    var
        rSelf: Record "Job Planning Line";
    Begin

        //TESTFIELD(Transferred,FALSE);

        BorrarecursosRelacionados("Line No.", "Job No.");
        // MNC 211098
        if ("Cdad. Reservada" <> 0) THEN
            ERROR('No se puede borrar esta linea, porque ya se han creado reservas');
        CALCFIELDS("No. Orden Publicidad");
        if ("No. Orden Publicidad" <> '') THEN BEGIN
            if ("Estado Orden Publicidad" = "Estado Orden Publicidad"::Validada) THEN
                ERROR(Text50003);
            rOrden.RESET;
            if rOrden.GET("No. Orden Publicidad") Then
                rOrden.DELETE(TRUE);
        END;

        rTexto.SETRANGE("Nº proyecto", "Job No.");
        //  $001 -
        // {
        // rTexto.SETRANGE("Cód. fase","Phase Code");
        // rTexto.SETRANGE("Cód. subfase","Task Code");
        // rTexto.SETRANGE("Cód. tarea","Step Code");
        // }
        rTexto.SETRANGE("Cód. tarea", "Job Task No.");
        rTexto.SETRANGE("Nº linea aux", "Line No.");
        //  $001 +
        rTexto.SETRANGE(Tipo, Type.AsInteger());
        rTexto.SETRANGE("Nº", "No.");
        rTexto.SETRANGE("Cód. variante", "Variant Code");
        rTexto.DELETEALL;
        // Fi MNC
        rSelf.SETRANGE(rSelf."Job No.", "Job No.");
        rSelf.SETRANGE("Origin Line No.", "Line No.");
        rSelf.DELETEALL;
    End;

    PROCEDURE Mirar_Estado();
    var
        Tipo: Record "Tipo Recurso";
    BEGIN
        //$001
        if ((Type = Type::Resource) AND ("No." <> '')) THEN BEGIN
            if Res.GET("No.") THEN
                Res.TESTFIELD(Blocked, FALSE);
            If Not Tipo.GET(Res."Tipo Recurso") THEN
                Tipo.Init();
            If Not ((Res."Recurso Agrupado") Or (Tipo."Crea Reservas")) THEN
                Rec."Sin Producción" := TRUE;
            if Rec."Recurso Agrupado" then exit;
            if Res."Producción" then exit;
            if Not Tipo."Crea Reservas" then exit;
            if Rec."Planning Date" = 0D then exit;
            if Rec."Fecha Final" = 0D then exit;
            rDia.RESET;
            CLEAR(rDia);
            rDia.SETCURRENTKEY("Nº Recurso", Fecha);
            rDia.SETRANGE("Nº Recurso", "No.");
            rDia.SETRANGE(Fecha, "Planning Date", "Fecha Final");
            if rDia.FINDFIRST THEN BEGIN
                Job.GET(rDia."Nº Proyecto");
                MESSAGE('Este recurso ya está %1 en el proyecto %2 \' +
                        'Campaña: %3\' +
                        'No se permitirá la creación de nuevas reservas en del %4 al %5. \' +
                        'Téngalo en cuenta.', rDia.Estado, rDia."Nº Proyecto", Job.Description, Format(Rec."Planning Date", 0, '<Day,2> de <Month,2> de <Year>'), Format(Rec."Fecha Final", 0, '<Day,2> de <Month,2> de <Year>'));
            END;
        END;
    END;

    PROCEDURE TraeCodDivisa(): Code[10];
    VAR
        rProy: Record 167;
    BEGIN
        //FCL-24/02/04. Migración de 2.0. a 3.70.

        if ("Job No." = rProy."No.") THEN
            EXIT(rProy."Cód. divisa")
        ELSE
            if rProy.GET("Job No.") THEN
                EXIT(rProy."Cód. divisa")
            ELSE
                EXIT('');
    END;

    PROCEDURE RevisaOpciones();
    BEGIN
        //   { No se si en las lineas lo tengo que dejar... Pte Lloren‡
        //   // $003
        //   CASE Tipo OF
        //     Tipo::"Por Campa¤a": BEGIN
        //              "Fija/Papel" := "Fija/Papel"::Papel;
        //            END;
        //     Tipo::Otros: BEGIN            // unico caso que se tocan las otras opciones
        //              "Fija/Papel" := 0;
        //              Subtipo      := 0;
        //              "Soporte de" := 0;
        //            END;
        //     ELSE BEGIN
        //            if ("Soporte de" = "Soporte de"::Fijación) THEN
        //              "Fija/Papel" := "Fija/Papel"::Papel
        //            ELSE
        //              "Fija/Papel" := "Fija/Papel"::Fija;
        //          END;
        //   END;
        //   }
    END;

    PROCEDURE BorrarecursosRelacionados(Num: Integer; JobNum: Code[20]);
    VAR
        ProduccionesRelacionadas: Record "Produccines Relacionadas";
        Job: Record Job;
        rRecRerlOtra: Record "Produccines Relacionadas";
        Resource: Record Resource;
        Contrato: Record "Sales Header";
    BEGIN
        ProduccionesRelacionadas.SETRANGE(ProduccionesRelacionadas."Line No.", Num);
        ProduccionesRelacionadas.SETRANGE(ProduccionesRelacionadas."Job No.", JobNum);
        Job.Get(JobNum);
        If Contrato.Get(Contrato."Document Type"::Order, Job."Nº Contrato") then
            If Contrato.Estado = Contrato.Estado::Firmado THEN
                ERROR('No se puede eliminar una producción de un contrato firmado');
        if ProduccionesRelacionadas.FINDFIRST THEN
            REPEAT
                If ProduccionesRelacionadas.Empresa <> CompanyName tHEN begin
                    rRecRerlOtra.ChangeCompany(ProduccionesRelacionadas.Empresa);
                    If Resource.Get(ProduccionesRelacionadas."No.") Then
                        Resource.ChangeCompany(ProduccionesRelacionadas.Empresa);
                    If Resource.Get("Recurso en Empresa Origen") Then begin
                        rRecRerlOtra.SETRANGE(rRecRerlOtra."No.", Resource."No.");
                        rRecRerlOtra.SETRANGE(rRecRerlOtra."Job No.", ProduccionesRelacionadas."Job No.2");
                        rRecRerlOtra.DeleteAll();
                    end;
                end;
            UNTIL ProduccionesRelacionadas.NEXT = 0;
        ProduccionesRelacionadas.DELETEALL;
    END;

    PROCEDURE BorrarecursosRelacionados(Num: Integer; JobNum: Code[20]; Num2: Integer; JobNum2: Code[20]);
    VAR
        ProduccionesRelacionadas: Record "Produccines Relacionadas";
        rRecRerlOtra: Record "Produccines Relacionadas";
        Resource: Record Resource;
        Job: Record Job;
        Contrato: Record "Sales Header";
    BEGIN
        ProduccionesRelacionadas.SETRANGE(ProduccionesRelacionadas."Line No.", Num);
        ProduccionesRelacionadas.SETRANGE(ProduccionesRelacionadas."Job No.", JobNum);
        if ProduccionesRelacionadas.FINDFIRST THEN
            REPEAT
                If ProduccionesRelacionadas.Empresa <> CompanyName tHEN begin
                    rRecRerlOtra.ChangeCompany(ProduccionesRelacionadas.Empresa);
                    Resource.Get(ProduccionesRelacionadas."No.");
                    Resource.ChangeCompany(ProduccionesRelacionadas.Empresa);
                    If Resource.Get("Recurso en Empresa Origen") Then begin
                        rRecRerlOtra.SETRANGE(rRecRerlOtra."No.", Resource."No.");
                        rRecRerlOtra.SETRANGE(rRecRerlOtra."Job No.", JobNum2);
                        if rRecRerlOtra.FindFirst() then Error('No se puede eliminar una producción de un recurso que ha sido asignado en otra empresa. Primero debe borrar en %1 el proyecto %2', ProduccionesRelacionadas.Empresa, JobNum2);
                    end;
                end;
            UNTIL ProduccionesRelacionadas.NEXT = 0;
        Job.Get(JobNum);
        If Contrato.Get(Contrato."Document Type"::Order, Job."Nº Contrato") then
            If Contrato.Estado = Contrato.Estado::Firmado THEN
                ERROR('No se puede eliminar una producción de un contrato firmado');
        ProduccionesRelacionadas.SETRANGE("Line No.", Num);
        ProduccionesRelacionadas.SETRANGE("Job No.", JobNum);
        ProduccionesRelacionadas.SETRANGE("Line No.2", Num2);
        ProduccionesRelacionadas.SETRANGE("Job No.2", JobNum2);
        ProduccionesRelacionadas.DELETEALL;

    END;

    PROCEDURE BuscarecursosRelacionados(Num: Integer; JobNum: Code[20]; ResNum: Code[20]): Boolean;
    VAR
        rRecRerl: Record "Produccines Relacionadas";

    BEGIN
        rRecRerl.SETRANGE(rRecRerl."Line No.", Num);
        rRecRerl.SETRANGE(rRecRerl."Job No.", JobNum);
        rRecRerl.SETRANGE(rRecRerl."No.", ResNum);
        EXIT(rRecRerl.FINDFIRST);
    END;


    var
        myInt: Integer;
        rDim: Record 352;
        wP: Decimal;
        Res: Record "Resource";
        Job: Record "Job";
        rDia: Record "Diario Reserva";
        rTexto: Record "Texto Presupuesto";
        rTipus: Record "Tipo Recurso";
        rFamilia: Record "Resource Group";
        rOrden: Record "Cab. orden publicidad";
        Text50000: Label 'Cuidado! La fecha de final es menor a la fecha de inicio.';
        Text50001: Label 'OJO. El proyecto ya esta en estado Contrato, y ya se han \creado los pedidos de venta y compra. Si quiere modificarlos\debera hacerlo a mano.';
        Text50002: Label 'Esta linea ya tiene reservas asociadas. No se puede modificar este campo.';
        Text50003: Label 'No se puede eliminar esta linea, ya que tiene una orden de publicidad Validada.';
}