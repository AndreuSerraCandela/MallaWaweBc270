/// <summary>
/// Table Reserva (ID 7010476).
/// </summary>
table 7001199 Reserva
{


    fields
    {
        field(1; "Nº Reserva"; Integer)
        {
            NotBlank = true;
            //Description =PK 
        }
        field(5; "Fecha inicio"; Date) { }
        field(10; "Fecha fin"; Date) { }
        field(15; "Nº Recurso"; Code[20])
        {
            TableRelation = Resource;
            Description = 'FK Recurso';
            trigger OnValidate()
            BEGIN
                rRecurs.GET("Nº Recurso");
                Descripción := rRecurs.Name;
            END;


        }
        field(20; Descripción; Text[100]) { }
        field(25; Estado; Enum "Estado Reserva") { }//Reservado,Reservado fijo,Ocupado,Ocupado fijo }
        field(30; "Cód. Cliente"; Code[20])
        {
            TableRelation = Customer;
            Description = 'FK Cliente';
        }
        field(35; "Nº Proyecto"; Code[20])
        {
            TableRelation = Job;
            Description = 'FK Proyecto';
        }
        field(40; "Cód. fase"; Code[10]) { }
        field(45; "Cód. subfase"; Code[10]) { }
        field(50; "Cód. tarea"; Code[10]) { }
        field(51; "Nº linea proyecto"; Integer) { }
        field(55; "Tipo (presupuesto)"; Enum "Tipo (presupuesto)") { }
        field(56; "Nº (presupuesto)"; Code[20])
        {
            TableRelation = if ("Tipo (presupuesto)" = CONST(Recurso)) Resource
            ELSE
            if ("Tipo (presupuesto)" = CONST(Producto)) Item
            ELSE
            if ("Tipo (presupuesto)" = CONST(Cuenta)) "G/L Account"
            ELSE
            if ("Tipo (presupuesto)" = CONST(Texto)) "Standard Text"
            ELSE
            if ("Tipo (presupuesto)" = CONST(Familia)) "Resource Group";
        }
        field(57; "Cód. variante (presupuesto)"; Code[10])
        {
            TableRelation = if ("Tipo (presupuesto)" = CONST(Producto)) "Item Variant".Code;
            //WHERE ("Item No."=FIELD("Nº Reserva")); 
        }
        field(60; "Orden fijación creada"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Orden fijación" WHERE("Nº Reserva" = FIELD("Nº Reserva")));
            BlankZero = false;
        }
        field(65; "Nº fam. recurso"; Code[20]) { TableRelation = "Resource Group"; }
        field(70; "Usuario creacion"; Code[50]) { }
        field(75; "Fecha creacion"; DateTime) { }
        field(50000; Zona; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Zona WHERE("No." = FIELD("Nº Recurso")));
        }
        field(50001; Municipo; Code[15])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Municipio WHERE("No." = FIELD("Nº Recurso")));
        }
        field(50002; "Tipo Recurso"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."Tipo Recurso" WHERE("No." = FIELD("Nº Recurso")));
        }
        field(50003; "Total Proyecto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job Planning Line"."Total Price (LCY)" WHERE("Job No." = FIELD("Nº Proyecto")));
        }
        field(50004; Recuperada; Boolean) { }
        field(50005; "Existe Proyecto"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Job Planning Line" WHERE("Line No." = FIELD("Nº linea proyecto"),
                    "Job No." = FIELD("Nº Proyecto")));
        }
        field(50006; "Fecha Inicio Pr"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Planning Line"."Planning Date" WHERE("Line No." = FIELD("Nº linea proyecto"),
                    "Job No." = FIELD("Nº Proyecto")));
        }
        field(50007; "Fecha Fin Pr"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Planning Line"."Fecha Final" WHERE("Line No." = FIELD("Nº linea proyecto"),
                    "Job No." = FIELD("Nº Proyecto")));
        }
        field(50008; "Recurso Agrupado"; Code[20]) { TableRelation = Resource; }
        field(50009; Linea; Integer) { }
        field(50010; "Linea Agrupado"; Integer) { }
        field(51023; "No Pay"; Boolean) { }
        field(51024; "Proyecto de fijación"; Boolean) { }
        field(51025; "Tipo de Fijación"; Code[20])
        {
            TableRelation = "Standard Text".Code WHERE("Para Fijación" = CONST(true));
        }
        field(52031; "Sin Cargo"; Boolean) { }
        field(52032; Seleccionar; Boolean) { }
        field(52033; Refijar; Boolean) { }

    }
    KEYS
    {
        key(Principal; "Nº Reserva") { Clustered = true; }
        key(Proyecto; "Nº Proyecto", "Cód. fase", "Cód. subfase", "Cód. tarea", "Tipo (presupuesto)", "Nº (presupuesto)") { }
        key(Recurso; "Nº Recurso", "Fecha inicio", "Fecha fin") { }
        key(Fase; "Nº Proyecto", "Cód. subfase", "Fecha inicio") { }
        key(Fecha; "Nº Proyecto", "Fecha inicio") { }
        key(Proy_Res; "Nº Proyecto", "Nº Recurso", "Fecha inicio") { }
        key(Agrupado; "Nº Proyecto", "Recurso Agrupado") { }
    }
    VAR
        rRecurs: Record 156;
        rDia: Record "Diario Reserva";
        rLin2: Record 1003;
        rLin3: Record 1003;
        rOrden: Record "Cab Orden fijación";
        Text50000: Label 'Esta reserva no se puede borrar, ya que crearia incongruencias en el proyecto inicial.\\Este caso ocurre, por ejemplo, cuando se ha dividido la reserva original o casos similares.';

    trigger OnModify()
    BEGIN
        rDia.SETRANGE(rDia."Nº Reserva", "Nº Reserva");
        rDia.MODIFYALL(rDia.Cliente, "Cód. Cliente");
        rDia.MODIFYALL(rDia."No Pay", "No Pay");
        rDia.MODIFYALL(rDia."Proyecto de fijación", "Proyecto de fijación");
        rDia.MODIFYALL("Tipo de Fijación", "Tipo de Fijación");
    END;

    trigger OnDelete()
    VAR
        wError: Boolean;
        rRecurs: Record Resource;
        rDia: Record "Diario Reserva";
        rLin2: Record "Job Planning Line";
        rLin3: Record "Job Planning Line";
        rOrden: Record "Orden fijación";
    BEGIN

        if (Estado <> Estado::Reservado) AND (Estado <> Estado::Ocupado) THEN
            ERROR('Solo se pueden borrar reservas con el estado Reservado o Ocupado');
        rLin2.SETCURRENTKEY("Job No.", "Job Task No.", "Line No.");
        rLin2.SETRANGE("Job No.", "Nº Proyecto");
        rLin2.SETRANGE("Job Task No.", "Cód. tarea");
        if ("Nº linea proyecto" <> 0) THEN
            rLin2.SETRANGE("Line No.", "Nº linea proyecto")
        else begin
            rLin2.SETRANGE(Type, "Tipo (presupuesto)");
            rLin2.SETRANGE("No.", "Nº (presupuesto)");
            rLin2.SETRANGE("Planning Date", "Fecha inicio");
            rLin2.SETRANGE("Fecha Final", "Fecha fin");
        end;
        if rLin2.FINDFIRST THEN BEGIN
            rLin2."Cdad. a Reservar" := rLin2."Cdad. a Reservar" + 1;
            rLin2."Cdad. Reservada" := rLin2."Cdad. Reservada" - 1;
            rLin2.MODIFY;
        END ELSE BEGIN
            wError := FALSE;
            rLin2.SETRANGE("Planning Date");
            if rLin2.FINDFIRST THEN
                wError := FALSE
            ELSE
                rLin2.SETRANGE("Planning Date", "Fecha inicio");
            rLin2.SETRANGE("Fecha Final");
            if rLin2.FINDFIRST THEN wError := FALSE;
            //if wError THEN ERROR(Text50000) ELSE MESSAGE('Esto es una partición. Cambie las fechas en la línea del Proyecto');
        END;

        rDia.SETCURRENTKEY("Nº Reserva", Fecha);
        rDia.SETRANGE("Nº Reserva", "Nº Reserva");
        rDia.DELETEALL;

        // MNC 100199
        COMMIT;
        rLin3.RESET;
        rLin3.SETCURRENTKEY("Job No.", Type, "No.", "Planning Date", "Fecha Final");
        rLin3.SETFILTER("Job No.", '<>%1', rLin2."Job No.");
        rLin3.SETRANGE(Type, rLin3.Type::Resource);
        rLin3.SETRANGE("No.", rLin2."No.");
        if rLin2.FINDFIRST THEN BEGIN
            rLin3.SETFILTER("Planning Date", '>=%1', rLin2."Planning Date");
            rLin3.SETFILTER("Cdad. a Reservar", '<>0');
            if rLin3.FIND('-') THEN BEGIN
                //     ventana.SETTABLEVIEW(rLin3);
                //     ventana.LOOKUPMODE(TRUE);
                //     ventana.RUNMODAL;
                //     CLEAR(ventana);
                COMMIT;
            END;
            // Fi MNC
        END;
        rOrden.SETCURRENTKEY("Nº Reserva");
        rOrden.SETRANGE("Nº Reserva", "Nº Reserva");
        if rOrden.FIND('-') THEN begin
            rOrden."Estado Reserva" := rOrden."Estado Reserva"::Anulado;
        end;

    END;

}


// hazme un detalle por dia de la tabla anterior
