page 50233 "Lista empresas grupo"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Empresa grupo";

    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                field(Empresa; Rec.Empresa) { ApplicationArea = All; }
            }
        }
    }
}