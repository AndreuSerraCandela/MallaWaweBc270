/// <summary>
/// Page Tabla Recursos (ID 50005).
/// </summary>
page 50005 "Tabla Recursos"
{
    PageType = List;
    Caption = 'Tabla Recursos';
    SourceTable = Resource;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Nombre"; Rec."Name")
                {
                    ApplicationArea = All;
                }
                field("Nº fam. recurso"; Rec."Resource Group No.")
                {
                    ApplicationArea = All;
                }
                field(Medidas; Rec.Medidas)
                {
                    ApplicationArea = All;
                }
                field(Categoria; Rec.Categoria)
                {
                    ApplicationArea = All;
                }
                field("Tipo Recurso"; Rec."Tipo Recurso")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
