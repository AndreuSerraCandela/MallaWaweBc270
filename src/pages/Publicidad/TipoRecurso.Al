
/// <summary>
/// Page Tabla Tipo Recurso (ID 50078).
/// </summary>
page 50078 "Tabla Tipo Recurso"
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
            }
        }
    }


}
