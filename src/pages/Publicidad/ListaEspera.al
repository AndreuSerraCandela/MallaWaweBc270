/// <summary>
/// Page Lista Espera Recursos (ID 7001165).
/// </summary>
page 50252 "Lista Espera Recursos"
{
    ApplicationArea = All;
    Caption = 'Lista de Espera de Recursos';
    PageType = List;
    SourceTable = "Incidencias Rescursos";
    UsageCategory = Lists;
    CardPageId = 7001164;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Detalle)
            {
                field("Nº Incidencia"; Rec."Nº Incidencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el número de incidencia';
                    Editable = false;
                    Visible = false;
                }
                field(Orden; Rec.Orden)
                {
                    ApplicationArea = All;
                }
                field("Nº Recurso"; Rec."Nº Recurso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el recurso en lista de espera';
                }
                field(Descripción; Rec.Descripción)
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica la descripción del recurso';
                }
                field("Fecha inicio"; Rec."Fecha inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica la fecha de inicio de la solicitud';
                }
                field("Cód. Cliente"; Rec."Cód. Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el cliente que solicita el recurso';
                    Visible = false;
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el nombre del cliente que solicita el recurso';
                }
                field(Vendedor; Rec.Vendedor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el vendedor asociado';
                }
                field("Fecha cancelación"; Rec."Fecha cancelación")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica la fecha de cancelación de la solicitud';
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica observaciones adicionales';
                }

            }
        }
        area(factboxes)
        {
            systempart(Enlaces; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notas; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Ficha Recurso")
            {
                ApplicationArea = All;
                Image = Resource;
                RunObject = page "Resource Card";
                RunPageLink = "No." = field("Nº Recurso");
                ToolTip = 'Ver la ficha del recurso';
            }
            action("Ficha Cliente")
            {
                ApplicationArea = All;
                Image = Customer;
                RunObject = page "Customer Card";
                RunPageLink = "No." = field("Cód. Cliente");
                ToolTip = 'Ver la ficha del cliente';
            }
            action("Ficha Vendedor")
            {
                ApplicationArea = All;
                Image = SalesPerson;
                RunObject = page "Salesperson/Purchaser Card";
                RunPageLink = "Code" = field(Vendedor);
                ToolTip = 'Ver la ficha del vendedor';
            }

        }
        area(Processing)
        {
            action(Cancelar)
            {
                ApplicationArea = All;
                Image = Cancel;
                Caption = 'Cancelar Solicitud';
                ToolTip = 'Marca la solicitud como cancelada';

                trigger OnAction()
                begin
                    if Confirm('¿Está seguro de que desea cancelar esta solicitud de lista de espera?') then begin
                        Rec."Fecha cancelación" := Today;
                        Rec.Modify(true);
                        Message('Solicitud cancelada correctamente');
                    end;
                end;
            }

            action(Asignar)
            {
                ApplicationArea = All;
                Image = Approve;
                Caption = 'Asignar Recurso';
                ToolTip = 'Convierte la lista de espera en una reserva';

                trigger OnAction()
                var
                    JobPlanningLine: Record "Job Planning Line";
                    Resource: Record Resource;
                begin
                    // Implementación básica - en una implementación completa habría que crear una reserva real
                    if Rec."Nº Proyecto" = '' then
                        Error('Debe especificar un proyecto para poder asignar el recurso');

                    if Confirm('¿Desea crear una línea de planificación de proyecto para este recurso?') then begin
                        if Resource.Get(Rec."Nº Recurso") then;

                        JobPlanningLine.Init();
                        JobPlanningLine."Job No." := Rec."Nº Proyecto";
                        JobPlanningLine."Line No." := 10000;
                        JobPlanningLine."Job Task No." := ''; // Requiere implementación específica
                        JobPlanningLine.Type := JobPlanningLine.Type::Resource;
                        JobPlanningLine."No." := Rec."Nº Recurso";
                        JobPlanningLine.Description := Resource.Name;
                        JobPlanningLine."Planning Date" := Rec."Fecha inicio";
                        JobPlanningLine."Fecha Final" := Rec."Fecha fin";
                        JobPlanningLine.Quantity := 1;
                        JobPlanningLine."Crear pedidos" := JobPlanningLine."Crear pedidos"::"No crear pedido";
                        JobPlanningLine."Cdad. a Reservar" := 1;
                        if JobPlanningLine.Insert() then begin
                            Message('Línea de planificación creada correctamente');
                            Rec."Fecha cancelación" := Today;
                            Rec.Observaciones := Rec.Observaciones + ' ASIGNADO: ' + Format(Today);
                            Rec.Modify(true);
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange(Motivo, Rec.Motivo::"Lista de espera");
        Rec.FilterGroup(0);
        Rec.SetFilter("Fecha cancelación", '%1', 0D); // Solo mostrar las no canceladas por defecto

    end;
}