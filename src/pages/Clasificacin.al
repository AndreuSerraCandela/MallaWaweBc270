/// <summary>
/// Page Clasificación (ID 50066).
/// </summary>
page 50231 "Clasificación"
{

    ApplicationArea = All;
    Caption = 'Clasificación';
    PageType = List;
    SourceTable = "Clasificación Intercambio";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Clasificación; Rec.Clasificación)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
