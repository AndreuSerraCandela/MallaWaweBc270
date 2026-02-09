/// <summary>
/// Page Ficha Reserva (ID 50087).
/// </summary>
page 50242 "Ficha Reserva"
{
    PageType = Card;
    SourceTable = Reserva;
    Editable = False;
    layout
    {
        area(Content)

        {

            field("Nº Reserva"; Rec."Nº Reserva")
            {
                ApplicationArea = All;
            }
            field("Fecha inicio"; Rec."Fecha inicio")
            {
                ApplicationArea = All;
            }
            field("Fecha fin"; Rec."Fecha fin")
            {
                ApplicationArea = All;
            }
            field("Nº Recurso"; Rec."Nº Recurso")
            {
                ApplicationArea = All;
            }
            field(Desc; Rec.Descripción)
            {
                Caption = 'Descripción';
                ApplicationArea = All;
            }
            field(Estado; Rec.Estado)
            {
                ApplicationArea = All;
            }
            field("Cód. Cliente"; Rec."Cód. Cliente")
            {
                ApplicationArea = All;
            }
            field("Nº Proyecto"; Rec."Nº Proyecto")
            {
                ApplicationArea = All;
            }

            field("Cód. fase"; Rec."Cód. fase")
            {
                ApplicationArea = All;
            }
            field("Cód. subfase"; Rec."Cód. subfase")
            {
                ApplicationArea = All;
            }
            field("Cód. tarea"; Rec."Cód. tarea")
            {
                ApplicationArea = All;
            }
            field("Tipo (presupuesto)"; Rec."Tipo (presupuesto)")
            {
                ApplicationArea = All;
            }
            field("Nº (presupuesto)"; Rec."Nº (presupuesto)")
            {
                ApplicationArea = All;
            }
            field("Orden fijación creada"; Rec."Orden fijación creada")
            {
                ApplicationArea = All;
            }
            field(Descripción; rProyecto.Description)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Reserva)
            {
                Caption = '&Reserva';
                action("Diario Reserva")
                {
                    Caption = '&Diario Reserva';
                    RunObject = page "Diario Reserva";
                    RunPageView = SORTING("Nº Reserva", Fecha);
                    RunPageLink = "Nº Reserva" = FIELD("Nº Reserva");
                    ApplicationArea = ALL;
                }
                action("Texto Linea")
                {

                    Caption = '&Texto linea presup.';
                    ApplicationArea = ALL;
                    RunObject = page "Texto Presupuesto";
                    RunPageView = SORTING("Nº proyecto", "Cód. fase", "Cód. subfase", "Cód. tarea", Tipo, "Nº", "Cód. variante", "Nº linea");
                    RunPageLink = "Nº proyecto" = FIELD("Nº Proyecto"),
                                "Cód. fase" = FIELD("Cód. fase"),
                                "Cód. subfase" = FIELD("Cód. subfase"),
                                "Cód. tarea" = FIELD("Cód. tarea"),
                                Tipo = FIELD("Tipo (presupuesto)"),
                                "Nº" = FIELD("Nº (presupuesto)");
                }

                action("Orden fijacion")
                {
                    Caption = 'O&rden fijación';
                    RunObject = Page "Ficha Orden Fijacion";
                    ApplicationArea = ALL;
                    trigger OnAction()
                    var
                        rOrden: Record "Cab Orden fijación";
                        rLinFijacion: Record "Orden fijación";
                    begin
                        rLinFijacion.SETRANGE("Nº Reserva", Rec."Nº Reserva");
                        if rLinFijacion.FindSet() then begin
                            rOrden.SETRANGE("Nº Orden", rLinFijacion."Nº Orden");
                            if rOrden.FindSet() then
                                Page.RUNMODAL(Page::"Ficha Orden Fijacion", rOrden);
                        end;
                    end;
                }
            }

        }
    }
    VAR
        //Gestio: Codeunit "Gestion Reservas";
        rProyecto: Record 167;
        //Plazos: Page "Plazos recursos reservados";
        rRec: Record 156;

    trigger OnAfterGetRecord()
    BEGIN
        rProyecto.GET(Rec."Nº Proyecto");
    END;

}