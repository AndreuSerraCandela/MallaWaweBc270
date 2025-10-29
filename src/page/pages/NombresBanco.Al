/// <summary>
/// Page Nombres Banco (ID 7001186).
/// </summary>
page 7001163 "Nombres Banco"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Nombre Banco";
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Nombre Banco"; Rec."Nombre Banco")
                {
                    ApplicationArea = All;
                }
            }
        }

    }
}

