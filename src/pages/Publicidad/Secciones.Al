page 50219 "Secciones Publicidad"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Seccion publicidad";
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Cód. seccion"; Rec."Cód. seccion")
                {
                    ApplicationArea = all;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}