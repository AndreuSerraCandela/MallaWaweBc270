page 50244 "Diario Reserva"
{
    PageType = List;

    UsageCategory = Lists;
    SourceTable = "Diario Reserva";
    Editable = false;
    layout
    {


        area(Content)
        {
            repeater(Detalle)
            {
                field("Nº Reserva"; Rec."Nº Reserva")
                {
                    ApplicationArea = All;
                }

                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                }
                field("Nº Recurso"; Rec."Nº Recurso")
                {
                    ApplicationArea = All;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                }
                field("Nº Proyecto"; Rec."Nº Proyecto")
                {
                    ApplicationArea = All;

                }
                field(Descripcion; rProyecto.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción Proyecto';
                }
                field("Sin Cargo"; Rec."Sin Cargo")
                {
                    ApplicationArea = All;
                    Caption = 'S/C';
                }
                field(Municipo; Rec.Municipo)
                {
                    ApplicationArea = All;
                    Caption = 'Municipo';
                }
                field(Zona; Rec.Zona)
                {
                    ApplicationArea = All;
                    Caption = 'Zona';
                }
                field("Tipo Recurso"; Rec."Tipo Recurso")
                {
                    ApplicationArea = All;
                }
                field(Cliente; Rec.Cliente)
                {
                    ApplicationArea = All;
                    Caption = 'Cliente';
                }
                field(Circuito; EncuentraCircuito(Rec."Nº Proyecto"))
                {
                    ApplicationArea = All;
                    Caption = 'Circuito';
                }
                field(Agencia; EsAgencia(Rec.Cliente))
                {
                    ApplicationArea = All;
                }
                field(Temporada; EsTemporada(Rec."Nº Proyecto"))
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Lista)
            {
                ApplicationArea = ALL;
                Image = List;
                RunObject = Page "Tabla Reservas";
            }

        }
    }
    VAR
        rProyecto: Record 167;
        wCliente: Code[20];
        "wS/C": Boolean;
        wZona: Text[30];
        wMunicipo: Text[30];

    trigger OnAfterGetRecord()
    BEGIN
        "wS/C" := FALSE;
        if NOT rProyecto.GET(Rec."Nº Proyecto") THEN rProyecto.INIT;
        if rProyecto.GET(Rec."Nº Proyecto") THEN BEGIN
            if ((UPPERCASE(COPYSTR(rProyecto.Description, 1, 2)) = 'B ') OR
            (UPPERCASE(COPYSTR(rProyecto.Description, 1, 2)) = 'R-') OR
            (UPPERCASE(COPYSTR(rProyecto.Description, 1, 2)) = 'R ') OR
            (UPPERCASE(COPYSTR(rProyecto.Description, 1, 4)) = 'GRIS') OR
            (STRPOS(UPPERCASE(rProyecto.Description), 'S/C') <> 0)) THEN
                "wS/C" := TRUE;
        END;
    END;

    PROCEDURE EncuentraCircuito(Proy: Code[20]): Boolean;
    VAR
        r1003: Record 1003;
    BEGIN
        r1003.SETCURRENTKEY("Job No.", Type, "No.", "Planning Date", "Fecha Final");
        r1003.SETRANGE(Type, r1003.Type::Resource);
        r1003.SETRANGE("Job No.", Proy);
        r1003.CALCFIELDS("Calculo Recurso Agrupado");
        r1003.SETRANGE("Calculo Recurso Agrupado", TRUE);
        EXIT(r1003.FINDFIRST);
    END;

    local procedure EsAgencia(Cliente: Code[20]): Option " ",Directo,Agencia
    var
        Cust: Record Customer;

    begin

        If Not Cust.GET(Cliente) then
            exit(0);
        if Cust."Tipo Cliente" = Cust."Tipo Cliente"::Directo then
            exit(1)
        else
            exit(2);
    end;

    procedure EsTemporada(Proyecto: Code[20]): Enum "Tipo Venta Job";
    var
        rProyecto: Record Job;
    begin
        if NOT rProyecto.GET(Proyecto) THEN
            EXIT(rProyecto."Tipo");
    end;
}