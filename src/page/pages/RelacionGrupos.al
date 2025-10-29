/// <summary>
/// Page Relación Grupos (ID 50039).
/// </summary>
page 50039 "Relación Grupos"
{
    ApplicationArea = All;
    Caption = 'Relación Grupos';
    PageType = List;
    SourceTable = "Relación Grupos";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Empresa Destino"; Rec."Empresa Destino")
                {
                    ToolTip = 'Specifies the value of the Empresa Destino field.';
                    ApplicationArea = All;
                }
                field("Empresa Origen"; Rec."Empresa Origen")
                {
                    ToolTip = 'Specifies the value of the Empresa Origen field.';
                    ApplicationArea = All;
                }
                field("Grupo Contable Destino"; Rec."Grupo Contable Destino")
                {
                    ToolTip = 'Specifies the value of the Grupo Contable Destino field.';
                    ApplicationArea = All;
                }
                field("Grupo Contable Origen"; Rec."Grupo Contable Origen")
                {
                    ToolTip = 'Specifies the value of the Grupo Contable Origen field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
