/// <summary>
/// Page Fichajes (ID 7001155).
/// </summary>
page 7001155 Fichajes
{
    Caption = 'Fichajes';
    PageType = List;
    SourceTable = Punches;
    UsageCategory = None;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Empleado; Rec.Empleado)
                {
                    ToolTip = 'Specifies the value of the Empleado field.';
                }
                field(Fecha; Rec.Fecha)
                {
                    ToolTip = 'Specifies the value of the Fecha field.';
                }
                field(Entrada; Rec.Entrada)
                {
                    ToolTip = 'Specifies the value of the Entrada field.';
                }
                field(device; Rec.device)
                {
                    ToolTip = 'Specifies the value of the device field.';
                }
                field("event"; Rec.evento)
                {
                    ToolTip = 'Specifies the value of the evento field.';
                }
                field(latitude; Rec.latitude)
                {
                    ToolTip = 'Specifies the value of the latitude field.';
                }
                field(longitude; Rec.longitude)
                {
                    ToolTip = 'Specifies the value of the longitude field.';
                }
                field(closed; Rec.closed)
                {
                    ToolTip = 'Specifies the value of the closed field.';
                }
            }
        }
    }
}
