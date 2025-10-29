/// <summary>
/// Page Incidencias (ID 7001164).
/// </summary>
page 7001164 "Ficha Incidencias"
{
    ApplicationArea = All;
    Caption = 'Incidencias';
    PageType = Card;
    SourceTable = "Incidencias Rescursos";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Nº Recurso"; Rec."Nº Recurso")
                {
                    ToolTip = 'Specifies the value of the Nº Recurso field.';
                }
                field("Fecha inicio"; Rec."Fecha inicio")
                {
                    ToolTip = 'Specifies the value of the Fecha inicio field.';
                }
                field("Fecha fin"; Rec."Fecha fin")
                {
                    ToolTip = 'Specifies the value of the Fecha fin field.';
                }
                field(Vendedor; Rec.Vendedor)
                {
                    ToolTip = 'Especifica el vendedor de la incidencia.';
                    Visible = EsListaEspera;
                }
                field(Cliente; Rec."Cód. Cliente")
                {
                    ToolTip = 'Especifica el código del cliente de la incidencia.';
                    Visible = EsListaEspera;
                }
                field(Motivo; Rec.Motivo)
                {
                    ToolTip = 'Specifies the value of the Motivo field.';
                }
                field("Fecha cancelación"; Rec."Fecha cancelación")
                {
                    ToolTip = 'Especifica la fecha de cancelación de la solicitud.';
                    Visible = EsListaEspera;
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ToolTip = 'Especifica observaciones adicionales para la incidencia.';
                    MultiLine = true;

                }
            }
        }
    }
    var
        EsListaEspera: Boolean;

    trigger OnAfterGetRecord()
    begin
        EsListaEspera := Rec.Motivo = Rec.Motivo::"Lista de Espera";
    end;
}
page 7001113 Incidencias
{
    ApplicationArea = All;
    Caption = 'Incidencias';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Incidencias Rescursos";
    CardPageId = 7001164;

    layout
    {
        area(content)
        {
            repeater(Detalle)
            {


                field("Nº Recurso"; Rec."Nº Recurso")
                {
                    ToolTip = 'Specifies the value of the Nº Recurso field.';
                }
                field("Fecha inicio"; Rec."Fecha inicio")
                {
                    ToolTip = 'Specifies the value of the Fecha inicio field.';
                }
                field("Fecha fin"; Rec."Fecha fin")
                {
                    ToolTip = 'Specifies the value of the Fecha fin field.';
                }
                field(Motivo; Rec.Motivo)
                {
                    ToolTip = 'Specifies the value of the Motivo field.';
                }
                field("Fecha cancelación"; Rec."Fecha cancelación")
                {
                    ToolTip = 'Especifica la fecha de cancelación de la solicitud.';
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ToolTip = 'Especifica observaciones adicionales para la incidencia.';
                }
            }
        }
    }
}