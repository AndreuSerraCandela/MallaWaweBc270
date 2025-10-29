/// <summary>
/// Table Incidencias Rescursos (ID 7010474).
/// </summary>
table 7001178 "Incidencias Rescursos"
{


    fields
    {
        field(1; "Nº Incidencia"; Integer)
        {
            NotBlank = true;
            //Description =PK 
        }
        field(5; "Fecha inicio"; Date)
        {
            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
                if Resource.GET("Nº Recurso") then begin
                    If Motivo = Motivo::"Baja" then begin
                        Resource."Fecha Baja" := "Fecha inicio";
                        Resource."Resource Group No." := 'BAJA';
                    end else
                        Resource."Fecha Baja" := 0D;
                    Resource.MODIFY;
                end;
            end;
        }
        field(10; "Fecha fin"; Date) { }
        field(6; Motivo; Enum "Motivo Incidencia")
        {
            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
                if Resource.GET("Nº Recurso") then
                    Resource."Fecha Baja" := 0D;
                Case Motivo Of
                    Motivo::"Baja":
                        begin
                            "Incidencia de Bloqueo" := "Incidencia de Bloqueo"::"Bloqueo";
                            if Resource.GET("Nº Recurso") then
                                If "Fecha inicio" <> 0D then begin
                                    Resource."Fecha Baja" := "Fecha inicio";
                                    Resource."Resource Group No." := 'BAJA';
                                    Resource.MODIFY;
                                end;
                        end;
                    Motivo::Bloqueo:
                        begin
                            "Incidencia de Bloqueo" := "Incidencia de Bloqueo"::"Bloqueo";
                        end;
                    Motivo::"Fin Concesion":
                        begin
                            "Incidencia de Bloqueo" := "Incidencia de Bloqueo"::"Bloqueo";
                        end;
                    Motivo::"Lista de espera":
                        begin
                            "Incidencia de Bloqueo" := "Incidencia de Bloqueo"::Informacion;
                        end;
                    Motivo::Obras:
                        begin
                            "Incidencia de Bloqueo" := "Incidencia de Bloqueo"::Bloqueo;
                        end;
                    Motivo::Otros:
                        begin
                            "Incidencia de Bloqueo" := "Incidencia de Bloqueo"::Bloqueo;
                        end;
                    Motivo::Reparacion:
                        begin
                            "Incidencia de Bloqueo" := "Incidencia de Bloqueo"::Bloqueo;
                        end;
                End;
            end;
        }
        field(15; "Nº Recurso"; Code[20])
        {
            TableRelation = Resource;
            Description = 'FK Recurso';
            trigger OnValidate()
            BEGIN
                rRecurs.GET("Nº Recurso");
                Descripción := rRecurs.Name;

                if rRecurs.GET("Nº Recurso") then begin
                    If Motivo = Motivo::"Baja" then begin
                        rRecurs."Fecha Baja" := "Fecha inicio";
                        rRecurs."Resource Group No." := 'BAJA';
                    end else
                        rRecurs."Fecha Baja" := 0D;
                    rRecurs.MODIFY;
                end;
            END;


        }
        field(20; Descripción; Text[100]) { }
        //field(25; Estado; Enum "Estado Reserva") { }//Reservado,Reservado fijo,Ocupado,Ocupado fijo }
        field(30; "Cód. Cliente"; Code[20])
        {
            TableRelation = Customer;
            Description = 'FK Cliente';
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.GET("Cód. Cliente") then
                    "Nombre Cliente" := Customer.Name;
            end;
        }
        field(31; "Nombre Cliente"; Text[100])
        {
            TableRelation = Customer;
            ValidateTableRelation = false;
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
            //WHERE ("Item No."=FIELD("Nº Incidencia")); 
        }
        field(60; "Orden fijación creada"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Orden fijación" WHERE("Nº Reserva" = FIELD("Nº Incidencia")));
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
        field(51023; "No Pay"; Boolean) { }
        field(51024; "Proyecto de fijación"; Boolean) { }
        field(51025; "Tipo de Fijación"; Code[20])
        {
            TableRelation = "Standard Text".Code WHERE("Para Fijación" = CONST(true));
        }
        field(52031; "Sin Cargo"; Boolean) { }
        field(46; "Incidencia de Bloqueo"; Enum Bloqueo)
        {
            Caption = 'Incidencia de Bloqueo';
        }
        field(47; Vendedor; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            Description = 'Vendedor';
        }
        field(48; "Fecha cancelación"; Date)
        {
            Caption = 'Fecha cancelación';
        }
        field(49; "Observaciones"; Text[250])
        {
            Caption = 'Observaciones';
        }
        field(52060; Orden; Integer) { }
    }
    KEYS
    {
        key(Principal; "Nº Incidencia") { Clustered = true; }
        key(Proyecto; "Nº Proyecto", "Cód. fase", "Cód. subfase", "Cód. tarea", "Tipo (presupuesto)", "Nº (presupuesto)") { }
        key(Recurso; "Nº Recurso", "Fecha inicio", "Fecha fin") { }
        key(Fase; "Nº Proyecto", "Cód. subfase", "Fecha inicio") { }
        key(Fecha; "Nº Proyecto", "Fecha inicio") { }
        key(Proy_Res; "Nº Proyecto", "Nº Recurso", "Fecha inicio") { }
        key(Agrupado; "Nº Proyecto", "Recurso Agrupado") { }
        key(Orden; "Nº Recurso", Orden) { }
    }
    VAR
        rRecurs: Record 156;
        rLin2: Record 1003;
        rLin3: Record 1003;
        rOrden: Record "Cab Orden fijación";
    //en el trigger ondelete que se borre el diario de incidencias relacionado
    trigger OnDelete()
    var
        rDiario: Record "Diario Incidencias Rescursos";
        Renum: Record "Incidencias Rescursos";
        a: Integer;
    begin
        rDiario.SETRANGE("Nº Incidencia", "Nº Incidencia");
        rDiario.DELETEALL;
        Renum.SetCurrentKey("Nº Recurso", Orden);
        Renum.SetRange("Nº Recurso", Rec."Nº Recurso");
        Renum.SetRange(Orden, Rec.Orden, 99999);
        a := Rec.Orden;
        If Renum.FindSet() Then
            repeat
                a -= 1;
                Renum.Orden := a;
                Renum.Modify();
            until Renum.Next = 0;
    end;
    //al isnertar que se inserte el diario de incidencias relacionado
    trigger OnInsert()
    var
        rDiario: Record "Diario Incidencias Rescursos";
        Dia: Date;
    begin
        // para cada dia desde fecha inicio hasta fecha fin crear una linea en el diario de incidencias
        Dia := "Fecha inicio";
        while Dia <= "Fecha fin" do begin
            rDiario.INIT;
            rDiario."Nº Incidencia" := "Nº Incidencia";
            rDiario."Cód. Cliente" := "Cód. Cliente";
            rDiario."Nombre Cliente" := "Nombre Cliente";
            rDiario.Vendedor := Vendedor;
            rDiario."Incidencia de Bloqueo" := "Incidencia de Bloqueo";
            rDiario.Fecha := Dia;
            rDiario."Nº Proyecto" := "Nº Proyecto";
            rDiario.Motivo := Motivo;
            rDiario."Cód. fase" := "Cód. fase";
            rDiario."Cód. subfase" := "Cód. subfase";
            rDiario."Cód. tarea" := "Cód. tarea";
            rDiario."Nº linea proyecto" := "Nº linea proyecto";
            rDiario."Nº Recurso" := "Nº Recurso";
            rDiario."Cód. variante" := "Cód. variante (presupuesto)";
            OnAfterInsert(Rec, rDiario);
            rDiario.INSERT;
            Dia := Dia + 1;
        end;
    end;
    //al modificar que se borre el diario de incidencias relacionado y se cree uno nuevo
    trigger OnModify()
    var
        rDiario: Record "Diario Incidencias Rescursos";
        Dia: Date;
    begin
        rDiario.SETRANGE("Nº Incidencia", "Nº Incidencia");
        rDiario.DELETEALL;
        // para cada dia desde fecha inicio hasta fecha fin crear una linea en el diario de incidencias
        Dia := "Fecha inicio";
        while Dia <= "Fecha fin" do begin
            rDiario.INIT;
            rDiario."Nº Incidencia" := "Nº Incidencia";
            rDiario.Fecha := Dia;
            rDiario."Nº Proyecto" := "Nº Proyecto";
            rDiario."Cód. fase" := "Cód. fase";
            rDiario.Motivo := Motivo;
            rDiario."Cód. Cliente" := "Cód. Cliente";
            rDiario."Nombre Cliente" := "Nombre Cliente";
            rDiario.Vendedor := Vendedor;
            rDiario."Incidencia de Bloqueo" := "Incidencia de Bloqueo";
            rDiario."Cód. subfase" := "Cód. subfase";
            rDiario."Cód. tarea" := "Cód. tarea";
            rDiario."Nº linea proyecto" := "Nº linea proyecto";
            rDiario."Nº Recurso" := "Nº Recurso";
            rDiario."Cód. variante" := "Cód. variante (presupuesto)";
            rDiario.INSERT;
            Dia := Dia + 1;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsert(Rec: Record "Incidencias Rescursos"; rDiario: Record "Diario Incidencias Rescursos")
    begin
    end;

}
