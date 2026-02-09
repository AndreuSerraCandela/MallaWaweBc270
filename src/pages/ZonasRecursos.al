/// <summary>
/// Page Zonas Recursos (ID 50001).
/// </summary>
page 50200 "Zonas Recursos"
{

    ApplicationArea = All;
    Caption = 'Zonas Recursos';
    PageType = List;
    SourceTable = "Zonas Recursos";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Detalle)
            {
                field("Cod. Zona"; Rec."Cod. Zona")
                {
                    ApplicationArea = All;
                }
                field("Texto Zona"; Rec."Texto Zona")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
