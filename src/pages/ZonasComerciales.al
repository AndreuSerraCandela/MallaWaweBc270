/// <summary>
/// Page Zonas Comerciales (ID 50002).
/// </summary>
page 50201 "Zonas Comerciales"
{

    ApplicationArea = All;
    Caption = 'Zonas Comerciales';
    PageType = List;
    SourceTable = "Zonas comerciales";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Zona; Rec.Zona)
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
