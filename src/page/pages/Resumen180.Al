/// <summary>
/// Page Modelo 180 Resumen (ID 7001104).
/// </summary>
page 7001104 "Modelo 180 Resumen"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Ref Catastral Address";



    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field(Base; Rec.Base) { ApplicationArea = All; }
                field(Retención; Rec.Retención) { ApplicationArea = All; }
                field(Cif; Rec.Cif) { ApplicationArea = All; }
                field(Catastro; Rec."Ref. catastral") { ApplicationArea = All; }
                field(Población; Rec.City) { ApplicationArea = All; }
                field("Código Postal"; Rec."Post Code") { ApplicationArea = All; }
                field(Dirección; Rec.Address) { ApplicationArea = All; }
                field(Nombre; Rec.Name) { ApplicationArea = All; }
                field(Proveedor; Rec."Vendor No.") { ApplicationArea = All; }
            }
        }
    }
}