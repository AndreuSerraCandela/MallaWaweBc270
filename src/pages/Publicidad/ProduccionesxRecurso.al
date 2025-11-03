
/// <summary>
/// Page Producciones x Recurso (ID 7001109).
/// </summary>
page 7001109 "Producciones x Recurso"
{
    ApplicationArea = All;
    Caption = 'Producciones x Recurso';
    PageType = List;
    SourceTable = "Recursos de Producción";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Tipo de Soporte"; Rec."Tipo de Soporte")
                {
                    ToolTip = 'Especifique el valor del campo Tipo de Soporte.';
                }
                field(Material; Rec.Material)
                {
                    ToolTip = 'Especifique el valor del campo Material.';
                }
                field("Recurso No."; Rec."Recurso No.")
                {
                    ToolTip = 'Especifique el valor del campo Recurso No..';
                }
                field("Precio Unitario"; Rec."Precio Unitario")
                {
                    ToolTip = 'Especifique el valor del campo Precio Unitario.';
                }
                field("Cantidad"; Rec."Cantidad")
                {
                    ToolTip = 'Especifique el valor del campo Cantidad.';
                }
                field(Venta; Rec.Venta)
                {
                    ToolTip = 'Especifique el valor del campo Venta.';
                }
                field("Descuento Venta"; Rec."Descuento Venta")
                {
                    ToolTip = 'Especifique el valor del campo Descuento Venta .';
                }
                field("Descuento Compra"; Rec."Descuento Compra")
                {
                    ToolTip = 'Especifique el valor de Descuento Compra.';
                }
                field(Compra; Rec.Compra)
                {
                    ToolTip = 'Especifique el valor de Compra.';
                }
            }
        }
    }
}

