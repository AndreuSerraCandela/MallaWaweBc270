
/// <summary>
/// Page Tabla Tipo Recurso (ID 50078).
/// </summary>
page 50235 "Tabla Tipo Recurso"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Tipo Recurso";// Table80177;

    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                field(Tipo; Rec.Tipo) { ApplicationArea = All; }
                field(Descripción; Rec.Descripción) { ApplicationArea = All; }
                field("Cód. Departamento"; Rec."Cód. Departamento") { ApplicationArea = All; }
                field("Tipo Comun"; Rec."Tipo Comun") { ApplicationArea = All; }
                field("Cód. Principal"; Rec."Cód. Principal") { ApplicationArea = All; }
                field("Asociar a emplazamiento"; Rec."Asociar a emplazamiento")
                {
                    ApplicationArea = All;
                    // ShowCaption = false;
                }
                field("Crea Reservas"; Rec."Crea Reservas")
                {
                    ApplicationArea = All;
                    // ShowCaption = false;
                }
                field(Exterior; Rec.Exterior)
                {
                    ApplicationArea = All;
                    // ShowCaption = false;
                }
                field("Ruta Imagenes"; Rec."Ruta Imagenes")
                {
                    ApplicationArea = All;
                }
                //añade los campos nuevos de la tabla tipo recurso
                field("Vat Prod. Posting Group"; Rec."Vat Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("% Dto. Compra"; Rec."% Dto. Compra")
                {
                    ApplicationArea = All;
                }
                field("Tiene Medidas"; Rec."Tiene Medidas")
                {
                    ApplicationArea = All;
                }
                field("Reparto todas las reservas"; Rec."Reparto todas las reservas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indica que los recursos de producción de este tipo se reparten entre todas las reservas del proyecto, sin filtrar por tipo de recurso.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Acciones)
            {
                action("Combinación Dimensiones")
                {
                    Caption = 'Combinación Dimensiones';
                    trigger OnAction()
                    VAR
                        rComb: Record 351;
                        rRes: Record 156;
                        rTip: Record "Tipo Recurso";
                        Dep: Code[20];
                        Pro: Code[20];
                        a: Integer;
                        Ventana: Dialog;
                    BEGIN
                        Ventana.OPEN('#############1# de ###############2#');
                        Ventana.UPDATE(2, rRes.COUNT);
                        if rRes.FINDFIRST THEN
                            REPEAT
                                a := a + 1;
                                Ventana.UPDATE(1, a);
                                if rTip.GET(rRes."Tipo Recurso") THEN BEGIN
                                    rComb.SETRANGE(rComb."Dimension 1 Value Code", rRes."Global Dimension 1 Code");
                                    rComb.SETRANGE(rComb."Dimension 2 Value Code", rRes."Global Dimension 2 Code");
                                    if rComb.FINDFIRST THEN
                                        REPEAT
                                            rComb."Dimension Pincipal" := rTip."Cód. Principal";
                                            rComb.MODIFY;
                                        UNTIL rComb.NEXT = 0;
                                END;
                            UNTIL rRes.NEXT = 0;
                        Ventana.CLOSE;
                        COMMIT;
                        PAGE.RUNMODAL(50500);
                    END;
                }
                action("Copiar desde otra empresa")
                {
                    Caption = 'Copiar desde otra empresa';
                    Image = Copy;
                    ApplicationArea = All;
                    trigger OnAction()
                    VAR
                        Company: Record Company;
                        TipoRecursoOrigen: Record "Tipo Recurso";
                        TipoRecursoDestino: Record "Tipo Recurso";
                        Ventana: Dialog;
                        Contador: Integer;
                        Total: Integer;
                        Copiados: Integer;
                    BEGIN
                        // Seleccionar empresa
                        Company.SetRange("Evaluation Company", false);
                        if Page.RunModal(Page::Companies, Company) in [Action::LookupOK, Action::OK] THEN BEGIN
                            if Company.Name = COMPANYNAME THEN
                                ERROR('Debe seleccionar una empresa diferente a la actual.');

                            // Cambiar a la empresa origen y leer registros
                            TipoRecursoOrigen.ChangeCompany(Company.Name);
                            If Page.RunModal(Page::"Tabla Tipo Recurso", TipoRecursoOrigen) in [Action::LookupOK, Action::OK] THEN BEGIN
                                if TipoRecursoDestino.GET(TipoRecursoOrigen.Tipo) THEN TipoRecursoDestino.Delete(FALSE);

                                // Copiar el registro
                                TipoRecursoDestino := TipoRecursoOrigen;
                                TipoRecursoDestino.INSERT;


                                MESSAGE('Se ha copiado el Tipo Recurso %1 desde la empresa %2.', TipoRecursoOrigen.Tipo, Company.Name);
                                COMMIT;

                            END ELSE
                                MESSAGE('Proceso de copia cancelado.');
                        END;
                    END;
                }
                action("Trasladar reparto a empresas")
                {
                    Caption = 'Trasladar reparto a todas las empresas';
                    Image = Copy;
                    ApplicationArea = All;
                    ToolTip = 'Copia el valor de Reparto a todas las reservas del tipo seleccionado a todas las empresas donde exista el mismo tipo.';

                    trigger OnAction()
                    begin
                        TrasladarRepartoTodasEmpresas();
                    end;
                }
            }
        }
    }

    local procedure TrasladarRepartoTodasEmpresas()
    var
        Empresa: Record Company;
        TipoRecursoDestino: Record "Tipo Recurso";
        Actualizados: Integer;
        NoEncontrados: Integer;
    begin
        Rec.TestField(Tipo);
        if not Confirm(
            '¿Desea trasladar el valor %1 de "Reparto a todas las reservas" para el tipo %2 a todas las empresas?',
            false, Rec."Reparto todas las reservas", Rec.Tipo)
        then
            exit;

        if Empresa.FindSet() then
            repeat
                TipoRecursoDestino.ChangeCompany(Empresa.Name);
                if TipoRecursoDestino.Get(Rec.Tipo) then begin
                    TipoRecursoDestino."Reparto todas las reservas" := Rec."Reparto todas las reservas";
                    TipoRecursoDestino.Modify();
                    Actualizados += 1;
                end else
                    NoEncontrados += 1;
            until Empresa.Next() = 0;

        Message(
            'Valor trasladado a %1 empresas. El tipo %2 no existe en %3 empresas.',
            Actualizados, Rec.Tipo, NoEncontrados);
    end;
}
