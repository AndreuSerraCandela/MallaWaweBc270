/// <summary>
/// Page Materiales (ID 7001102).
/// </summary>
page 7001102 Materiales
{
    ApplicationArea = All;
    Caption = 'Materiales';
    PageType = List;
    SourceTable = Material;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Código"; Rec."Código")
                {
                    ToolTip = 'Specifies the value of the Código field.';
                }
                field(Material; Rec.Material)
                {
                    ToolTip = 'Specifies the value of the Material field.';
                }
            }
        }
    }
}
