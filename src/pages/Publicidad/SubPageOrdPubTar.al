page 50216 "SubPage tarifas orden pub."
{
    PageType = ListPart;
    SourceTable = "Tarifas orden publicidad";
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Dia tarifa"; Rec."Dia tarifa")
                {
                    ApplicationArea = All;
                }
                field(Precio; Rec.Precio)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    PROCEDURE Actualizar();
    BEGIN

        CurrPage.UPDATE(FALSE);
    END;
}