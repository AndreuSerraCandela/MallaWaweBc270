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
        ListEmpresas: List of [Text];
        Empresas: array[20] of Record Company;

    begin
        if Usr."Mostrar Malla Publicidad" Then begin
            ListEmpresas.Add('Malla Publicidad');
        end;
        if Usr."Mostrar Grepsa" then begin
            ListEmpresas.Add('Grepsa');
        end;
        if Usr."Mostrar Ibiza Publicidad" then begin
            ListEmpresas.Add('Ibiza Publicidad, S.A.');
        end;
        if Usr."Mostrar Menorca Publicidad" then begin
            ListEmpresas.Add('Menorca de Publicidad, S.A.');
        end;
        Case ListEmpresas.Count() of
            0:
                Rec.SetRange(Empresa, '');
            1:
                begin
                    Empresas[1].Get(ListEmpresas.Get(1));
                    Rec.SetFilter(Empresa, '%1', Empresas[1].Name);
                end;
            2:
                begin
                    Empresas[1].Get(ListEmpresas.Get(1));
                    Empresas[2].Get(ListEmpresas.Get(2));
                    Rec.SetFilter(Empresa, '%1|%2', Empresas[1].Name, Empresas[2].Name);
                end;
            3:
                begin
                    Empresas[1].Get(ListEmpresas.Get(1));
                    Empresas[2].Get(ListEmpresas.Get(2));
                    Empresas[3].Get(ListEmpresas.Get(3));
                    Rec.SetFilter(Empresa, '%1|%2|%3', Empresas[1].Name, Empresas[2].Name, Empresas[3].Name);
                end;
            4:
                begin
                    Empresas[1].Get(ListEmpresas.Get(1));
                    Empresas[2].Get(ListEmpresas.Get(2));
                    Empresas[3].Get(ListEmpresas.Get(3));
                    Empresas[4].Get(ListEmpresas.Get(4));
                    Rec.SetFilter(Empresa, '%1|%2|%3|%4', Empresas[1].Name, Empresas[2].Name, Empresas[3].Name, Empresas[4].Name);
                end;
            5:
                begin
                    Empresas[1].Get(ListEmpresas.Get(1));
                    Empresas[2].Get(ListEmpresas.Get(2));
                    Empresas[3].Get(ListEmpresas.Get(3));
                    Empresas[4].Get(ListEmpresas.Get(4));
                    Empresas[5].Get(ListEmpresas.Get(5));
                    Rec.SetFilter(Empresa, '%1|%2|%3|%4|%5', Empresas[1].Name, Empresas[2].Name, Empresas[3].Name, Empresas[4].Name, Empresas[5].Name);
                end;

        end;
        CurrPage.Update(false);
    end;


}