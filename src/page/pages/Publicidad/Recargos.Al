page 50029 "Recargos Publicidad"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Recargo publicidad";

    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Cod. Soporte"; Rec."Cod. Soporte") { ApplicationArea = All; }
                field(Periodo; Rec.Periodo) { ApplicationArea = All; }
                field("Cod. Recargo"; Rec."Cod. Recargo") { ApplicationArea = All; }
                field(Recargo; Rec.Recargo) { ApplicationArea = All; }
                field(Descripción; Rec.Descripción) { ApplicationArea = All; }
            }
        }
    }

}