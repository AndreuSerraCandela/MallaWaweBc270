/// <summary>
/// Table Diario Reserva (ID 7010480).
/// </summary>
table 7001201 "Diario Reserva"
{
    fields
    {
        field(1; "Nº Reserva"; Integer) { }
        field(5; "Fecha"; Date) { }
        field(10; "Nº Recurso"; Code[20]) { TableRelation = Resource; }
        field(15; "Nº Proyecto"; Code[20]) { TableRelation = Job; }
        field(20; "Estado"; Enum "Estado Reserva") { }//Reservado,Reservado fijo,Ocupado,Ocupado fijo }
        field(25; "Nº fam. recurso"; Code[20]) { TableRelation = "Resource Group"; }
        field(40; "Cód. fase"; Code[10])
        {        //TableRelation=Table161;
            Description = 'FK Fase';
        }
        field(45; "Cód. subfase"; Code[10])
        {        //TableRelation=Table162;
            Description = 'FK Subfase';
        }
        field(50; "Cód. tarea"; Code[10])
        {        //TableRelation=Table163;
            Description = 'FK Tarea';
        }
        field(51; "Nº linea proyecto"; Integer) { }
        field(55; "Tipo (presupuesto)"; Enum "Tipo (presupuesto)") { }//Recurso,Producto,Cuenta,Texto,,,,,Familia;}
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
        field(50000; Cliente; Code[20]) { TableRelation = Customer; }
        field(51023; "No Pay"; Boolean) { }
        field(51024; "Proyecto de fijación"; Boolean) { }
        field(51025; "Tipo de Fijación"; Code[20])
        {
            TableRelation = "Standard Text".Code WHERE("Para Fijación" = CONST(true));
        }
        field(51026; "Zona."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Table ID" = CONST(156),
                    "No." = FIELD("Nº Recurso"),
                    "Dimension Code" = CONST('ZONA')));
        }
        field(51027; "Tipo Recurso."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."Tipo Recurso" WHERE("No." = FIELD("Nº Recurso")));
        }
        field(51028; "Municipo."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Municipio WHERE("No." = FIELD("Nº Recurso")));
        }
        field(51029; "Cód cliente"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Job."Bill-to Customer No." WHERE("No." = FIELD("Nº Proyecto")));
        }
        field(51030; "Cód Zona."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Zona WHERE("No." = FIELD("Nº Recurso")));
        }
        field(52026; Zona; Code[20]) { }
        field(52027; "Tipo Recurso"; Code[20]) { }
        field(52028; Municipo; Code[20]) { }
        field(52030; "Cód Zona"; Code[20]) { }
        field(52031; "Sin Cargo"; Boolean) { }
        field(52032; "Customer Price Group"; Code[10])
        {
            TableRelation = "Customer Price Group";
            Caption = 'Grupo precio cliente';
        }
        field(50008; "Recurso Agrupado"; Code[20])
        {
            TableRelation = Resource;
        }
        field(50009; Venta; Decimal)
        { }
        field(50010; "Cantidad Agrupada"; Integer)
        {
            //FieldClass = FlowField;
            //CalcFormula = Count("Diario Reserva" where("Recurso Agrupado" = field("Recurso Agrupado"), "Nº Proyecto" = field("Nº Proyecto")));

        }
        field(50011; "Cantidad No Agrupada"; Integer)
        {
            // FieldClass = FlowField;
            // CalcFormula = Count("Diario Reserva" where("Nº Recurso" = field("Recurso Agrupado"), "Nº Proyecto" = field("Nº Proyecto")));

        }
        field(50012; Ventas; Decimal)
        { }
        field(50013; Empresa; Text[30])
        { }
        field(50014; Comercial; Code[20])
        {

        }
        field(50015; Contrato; Code[20])
        {
            TableRelation = "Sales Header";
        }
        field(50017; "Estado Contrato"; Enum "Estado Contrato")
        {
            //Activo,Inactivo
        }
    }
    KEYS
    {
        key(Principal; "Nº Reserva", Fecha) { Clustered = true; }
        key(Recurso; "Nº Recurso", Fecha) { }
        key(Proyecto; "Nº Proyecto", "Cód. fase", "Cód. subfase", "Cód. tarea", "Tipo (presupuesto)", "Nº (presupuesto)", Fecha) { }
        key(Famili; "Nº fam. recurso", Fecha) { }
        key(Fecha; "Fecha", "Nº Recurso", "Nº Reserva") { }
        key(Recurso_Proyecto; "Nº Recurso", "Nº Proyecto", Fecha) { }
        key(TipoRecurso; "Tipo Recurso", "Cód Zona", Zona) { }
        key(Recurso_Estado; "Nº Recurso", "Estado Contrato", Fecha) { }

    }
    trigger OnDelete()
    var
        rLinP: Record 1003;
    begin
        if rLinP.Get(Rec."Nº Proyecto", Rec."Cód. tarea", Rec."Nº linea proyecto") Then begin
            rLinP."Cdad. a Reservar" := rLinP."Cdad. a Reservar" + 1;
            rLinP."Cdad. Reservada" := rLinP."Cdad. Reservada" - 1;
            rLinP.MODIFY;
        end;
    end;
}
