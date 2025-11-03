
page 50031 "Tarifas Publicidad"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Tarifas publicidad";

    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Cod. Soporte"; Rec."Cod. Soporte") { ApplicationArea = All; }
                field("Periodo"; Rec.Periodo) { ApplicationArea = All; }
                field("Sección"; Rec."Seccion") { ApplicationArea = All; }
                field("Descripción"; Rec."Descripcion") { ApplicationArea = All; }
            }
        }
    }

}