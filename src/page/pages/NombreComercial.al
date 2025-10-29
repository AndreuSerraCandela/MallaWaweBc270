/// <summary>
/// Page Nombre Comercial (ID 7001158).
/// </summary>
page 7001158 "Nombre Comercial"
{
    ApplicationArea = All;
    Caption = 'Anunciantes';
    PageType = List;
    SourceTable = "Nombre Comercial";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
