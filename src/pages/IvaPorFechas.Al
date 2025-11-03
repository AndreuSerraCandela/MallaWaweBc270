/// <summary>
/// Page Iva Por fechas (ID 50076).
/// </summary>
page 50076 "Iva Por fechas"
{

    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Iva por fechas";

    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group") { ApplicationArea = All; }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group") { ApplicationArea = All; }
                field("Fecha Entrada en vigor"; Rec."Fecha Entrada en vigor") { ApplicationArea = All; }
                field("New VAT Bus. Posting Group"; Rec."New VAT Bus. Posting Group") { ApplicationArea = All; }
                field("New VAT Prod. Posting Group"; Rec."New VAT Prod. Posting Group") { ApplicationArea = All; }

            }
        }
    }
}