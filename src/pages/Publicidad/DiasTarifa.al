page 50221 "Dias Tarifa Publicidad"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Dias tarifa publicidad";
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field(Codigo; Rec.Codigo) { ApplicationArea = All; }
                field(Descripcion; Rec.Descripcion) { ApplicationArea = All; }
                field(Lunes; Rec.Lunes) { ApplicationArea = All; }
                field(Martes; Rec.Martes) { ApplicationArea = All; }
                field(Miercoles; Rec.Miercoles) { ApplicationArea = All; }
                field(Jueves; Rec.Jueves) { ApplicationArea = All; }
                field(Viernes; Rec.Viernes) { ApplicationArea = All; }
                field(Sabado; Rec.Sabado) { ApplicationArea = All; }
                field(Domingo; Rec.Domingo) { ApplicationArea = All; }
                field(Conjunto; Rec.Conjunto) { ApplicationArea = All; }

            }

        }

    }
}