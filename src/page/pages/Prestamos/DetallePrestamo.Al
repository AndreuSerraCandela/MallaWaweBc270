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
    VAR
        DefEmpresa: Text[30];

    trigger onOpenPage()
    var
        Control: Codeunit ControlProcesos;
    begin
        If Control.AccesoProibido_Empresas(CompanyName, 'RESTRINGIDO') then
            Error('No tiene permisos para acceder a este punto del menú en esta empresa');
        if DefEmpresa <> '' THEN
            Rec.CHANGECOMPANY(DefEmpresa);
    END;

    PROCEDURE Empresa(Cia: Text[30]);

    BEGIN
        DefEmpresa := Cia;
        Rec.CHANGECOMPANY(Cia);
    END;


}
