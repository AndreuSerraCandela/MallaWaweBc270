/// <summary>
/// Page Detalle Prestamo (ID 7001146).
/// </summary>
page 7001137 "Detalle Prestamo"
{
    PageType = ListPart;
    SourceTable = "Detalle Prestamo";



    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("% Intereses"; Rec."% Intereses") { ApplicationArea = All; }
                field("No. Periodo"; Rec."No. Periodo") { ApplicationArea = All; }
                field(Fecha; Rec.Fecha) { ApplicationArea = All; }
                field("A Pagar"; Rec."A Pagar") { ApplicationArea = All; }
                field("Capital Pendiente"; Rec."Capital Pendiente") { ApplicationArea = All; }
                field("Total Liquidación"; Rec."Total Liquidación") { ApplicationArea = All; }
                field(Amortización; Rec."Amortización") { ApplicationArea = All; }
                field(Intereses; Rec.Intereses) { ApplicationArea = All; }
                field(Gastos; Rec.Gastos) { ApplicationArea = All; }
                field(Liquidado; Rec.Liquidado) { ApplicationArea = All; }
            }
        }
    }



}
