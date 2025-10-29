/// <summary>
/// Page Nombre Comercial (ID 7001158).
/// </summary>
page 7001159 "SeleccionRecursos"
{
    PageType = ListPart;
    SourceTable = SeleccionRecursos;
    DeleteAllowed = false;
    InsertAllowed = false;
    DataCaptionFields = "Tipo Recurso";

    layout
    {
        area(content)
        {

            repeater(General)
            {
                field(Seleccionar; Rec.Seleccionar)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Res: Record Resource;
                    begin
                        Res.ChangeCompany(Rec.Empresa);
                        Res.SetRange("No.", Rec."No.");
                        Page.RunModal(76, Res);
                    end;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }

    }
    trigger OnOpenPage()
    begin
        if CompanyName <> 'Malla Publicidad' then
            Rec.SetRange(Empresa, CompanyName);
        Rec.SetRange(UserId, UserId);
    end;

    var
        Busca: Text;
    /// <summary>
    /// filtra.
    /// </summary>
    /// <param name="Texto">Text.</param>
    procedure filtra(Texto: Text)
    begin
        if Texto = '' Then Rec.Setrange("No.");
        Rec.SetFilter("No.", '%1', '*' + Texto + '*');

        CurrPage.Update(false);
    end;

    /// <summary>
    /// filtraEmresa.
    /// </summary>
    /// <param name="Usr">Record "User Setup".</param>

    procedure filtraEmresa(var Usr: Record "User Setup")
    var
        Emp: Text;
    begin
        if Usr."Mostrar Malla Publicidad" Then begin
            if Emp = '' then
                Emp := 'Malla Publicidad'
            else
                Emp := Emp + '|Malla Publicidad';
        end;
        if Usr."Mostrar Grepsa" then begin
            if Emp = '' then
                Emp := 'Grepsa'
            else
                Emp := Emp + '|Grepsa';
        end;
        if Usr."Mostrar Ibiza Publicidad" then begin
            if Emp = '' then
                Emp := 'Ibiza Publicidad, S.A.'
            else
                Emp := Emp + '|Ibiza Publicidad, S.A.';
        end;
        if Usr."Mostrar Menorca Publicidad" then begin
            if Emp = '' then
                Emp := 'Menorca de Publicidad, S.A.'
            else
                Emp := Emp + '|Menorca de Publicidad, S.A.';
        end;
        Rec.SetFilter(Empresa, '%1', Emp);
        CurrPage.Update(false);
    end;


}