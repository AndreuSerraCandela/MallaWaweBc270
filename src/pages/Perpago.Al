page 7001151 "Periodo pago emplazamiento"
{
    SourceTable = "Periodos pago emplazamientos";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Cód. Periodo Pago"; Rec."Cód. Periodo Pago")
                { ApplicationArea = All; }
                field("Descripción"; Rec."Descripción")
                { ApplicationArea = All; }
                field("Año"; Rec."Año")
                { ApplicationArea = All; }
                field("Cuenta Contable FPR"; Rec."Cuenta Contable FPR")
                { ApplicationArea = All; }

            }
        }
    }
}