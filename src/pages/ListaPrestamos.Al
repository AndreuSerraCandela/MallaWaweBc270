/// <summary>
/// Page Lista Prestamos (ID 7001167).
/// </summary>
page 7001167 "Lista Prestamos"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    Editable = false;
    SourceTable = "Cabecera Prestamo";
    SourceTableView = WHERE(Empresa = FILTER(''), Renting = const(false), Aval = const(false));
    CardPageId = "Cabecera Prestamo";
    layout
    {
        area(Content)
        {

            repeater(Detalle)
            {
                field("Código Del Prestamo"; Rec."Código Del Prestamo") { ApplicationArea = All; }
                field("Cabecera Préstamo Dos"; Rec."Cabecera Prestamo2") { ApplicationArea = All; }

                field("Cuenta L/P"; Rec."Cuenta L/P") { ApplicationArea = All; }
                field("Cuenta C/P"; Rec."Cuenta c/P") { ApplicationArea = All; }
                field("Cuenta intrereses"; Rec."Cuenta intrereses") { ApplicationArea = All; }
                field("Cuenta Gastos"; Rec."Cuenta Gastos") { ApplicationArea = All; }
                field("Interes Anual"; Rec."Interes Anual") { ApplicationArea = All; }
                field(Años; Rec."Años") { ApplicationArea = All; }
                field("Cuotas Anuales"; Rec."Cuotas Anuales") { ApplicationArea = All; }
                field("Importe Prestamo"; Rec."Importe Prestamo") { ApplicationArea = All; }
                field(Pendiente; Pend(Rec)) { ApplicationArea = All; }
                field("Fecha Préstamo"; Rec."Fecha Préstamo") { ApplicationArea = All; }
                field("Fecha 1ª Amortización"; Rec."Fecha 1ª Amortización") { ApplicationArea = All; }
                field(Banco; Rec.Banco) { ApplicationArea = All; }
                field(Meses; Rec.Meses) { ApplicationArea = All; }
                field("En vigor"; Rec."En vigor") { }
                // field(Departamento; Rec."Global Dimension 1 Code") { ApplicationArea = All; }
                // field("Descripción Departamento"; DescripCionDim(1, Rec."Global Dimension 1 Code")) { ApplicationArea = All; }
                // field(Programa; Rec."Global Dimension 2 Code") { ApplicationArea = All; }
                // field("Descripción Programa"; DescripCionDim(2, Rec."Global Dimension 2 Code")) { ApplicationArea = All; }
                // field(Principal; Rec."Global Dimension 3 Code") { ApplicationArea = All; }
                // field("Descripción Principal"; DescripCionDim(3, Rec."Global Dimension 3 Code")) { ApplicationArea = All; }
                // field(Zona; Rec."Global Dimension 4 Code") { ApplicationArea = All; }
                // field("Descripción Zona"; DescripCionDim(4, Rec."Global Dimension 4 Code")) { ApplicationArea = All; }
                // field(Soporte; Rec."Global Dimension 5 Code") { ApplicationArea = All; }
                // field("Descripción Soporte"; DescripCionDim(5, Rec."Global Dimension 5 Code")) { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Ficha)
            {
                ApplicationArea = All;
                Image = Card;
                ShortCutKey = 'Mayús+F5';
                Caption = 'Ficha';
                RunObject = page "Cabecera Prestamo";
                RunPageLink = "Código Del Prestamo" = FIELD("Código Del Prestamo");
            }
        }
    }
    trigger OnNewRecord(BelowRec: Boolean)
    begin
        Rec.Renting := false;
        Rec.Aval := false;
    end;


    local procedure Pend(var Cab: Record "Cabecera Prestamo"): Decimal
    BEGIN
        Cab.CALCFIELDS(Liquidado);
        if Cab.GETFILTER("Filtro Fecha Liquidación") <> '' THEN
            if CAb."Fecha Préstamo" > Cab.GETRANGEMAX("Filtro Fecha Liquidación") THEN EXIT(0);
        EXIT(Cab."Importe Prestamo" - Cab.Liquidado);
    END;

    local procedure DescripCionDim(Dim: Integer; DimValCode: Code[20]): Text[100]
    var
        r349: Record "Dimension Value";
    begin
        r349.SetRange("Global Dimension No.", Dim);
        r349.SetRange(Code, DimValCode);
        if r349.FindFirst() then begin
            if r349.Name = '' then
                exit(r349.Code);
            exit(r349.Name);
        end;
    end;
}

