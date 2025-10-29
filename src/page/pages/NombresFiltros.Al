/// <summary>
/// Page Filtros (ID 7001103).
/// </summary>
page 7001103 Filtros
{
    PageType = List;
    SourceTable = "Filtros Recursos";
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Nombre del Filtro"; Rec."Nombre del Filtro")
                {
                    ApplicationArea = All;
                }
            }
        }

    }

}

