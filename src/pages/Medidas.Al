/// <summary>
/// Page Medidas (ID 7001121).
/// </summary>
page 7001121 "Medidas"
{
    //Version List=MLL1.00;
    //area(Content){ Repeater(Detalle){ID=1;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Medidas";
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("Medidas"; Rec.Medidas) { ApplicationArea = All; }
            }
        }
    }

}