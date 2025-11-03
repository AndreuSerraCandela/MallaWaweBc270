
page 50095 "Texto Presupuesto"
{
    PageType = List;
    AutoSplitKey = true;

    SourceTable = "Texto Presupuesto";
    SourceTableView = sorting("Nº proyecto", "Cód. tarea", "Nº linea aux", Tipo, "Nº", "Cód. variante");
    layout
    {
        area(Content)
        {
            repeater(Lineas)
            {
                field("Nº linea"; Rec."Nº linea")
                {
                    ApplicationArea = All;
                }
                field("Tipo linea"; Rec."Tipo linea")
                {
                    ApplicationArea = All;
                }
                field(Texto; Rec.Texto)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}