/// <summary>
/// Page Lineas de Impresión (ID 50014).
/// </summary>
page 50014 "Lineas de Impresión"
{

    Caption = 'Lineas de Impresión';
    PageType = ListPart;
    SourceTable = "Sales Comment Line";
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                    ApplicationArea = All;
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ToolTip = 'Specifies the value of the Cantidad field.';
                    ApplicationArea = All;
                }
                field(Precio; Rec.Precio)
                {
                    ToolTip = 'Specifies the value of the Precio field.';
                    ApplicationArea = All;
                }
                field("% Iva"; Rec."% Iva")
                {
                    ToolTip = 'Specifies the value of the % Iva field.';
                    ApplicationArea = All;
                }
                field("Iva"; Rec."Iva")
                {
                    ToolTip = 'Specifies the value of the Iva   field.';
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ToolTip = 'Specifies the value of the Importe field.';
                    ApplicationArea = All;
                }
                field(Validada; Rec.Validada)
                {
                    ToolTip = 'Specifies the value of the Validada field.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
