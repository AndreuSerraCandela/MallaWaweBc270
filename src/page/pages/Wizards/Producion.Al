/// <summary>
/// Page Laerit File Management Setup Wizard (ID 90103).
/// </summary>
page 7001110 "Wizard Producción"
{
    Caption = 'Wizard Produccion';
    PageType = NavigatePage;
    SourceTable = "Recursos de Producción";
    SourceTableTemporary = true;
    Editable = true;
    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                Caption = '';
                Editable = true;
                Visible = TopBannerVisible and not FinishActionEnabled;
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ShowCaption = false;
                }
            }
            group(FinishedBanner)
            {
                Caption = '';
                Editable = true;
                Visible = TopBannerVisible and FinishActionEnabled;
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ShowCaption = false;
                }

            }

            group(Step0)
            {
                Visible = Step0Visible;
                group("Bienvenido al proceso de asignación de producción")
                {
                    Caption = 'Bienvenido al proceso de asignación de producción';
                    Visible = Step1Visible;
                    group(Group18)
                    {
                        Caption = 'Proceso';
                        InstructionalText = 'Este asistente le guiará por los distintos pasos';

                    }
                }
                group("Let's go!")
                {
                    Caption = 'Empecemos!';
                    group(Group22)
                    {
                        Caption = '';
                        InstructionalText = 'Para empezar pulse siguiente';
                    }

                }
            }
            group(Step1)
            {
                Visible = Step1Visible;
                Caption = 'Tipo de soporte';
                InstructionalText = 'Indique sobre que tipo de soporte se aplicará la producción';
                field("Tipo de Soporte"; Rec."Tipo de Soporte")
                {
                    ApplicationArea = All;
                    // en el ttriger de on validate hacer un testfield en tipo de recurso sobre el cód. principal
                    trigger OnValidate()
                    var
                        Res: Record "Tipo Recurso";
                    begin
                        Res.Get(Rec."Tipo de Soporte");
                        Res.TestField("Cód. Principal");
                    end;

                }
            }
            group(Step2)
            {
                Caption = 'Material';
                InstructionalText = 'Indique el tipo de material';
                Visible = Step2Visible;
                //You might want to add fields here
                field("Material"; Material)
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Prod: Record "Recursos de Producción";
                        rMaterial: Record Material;
                    begin
                        If Page.RunModal(0, rMaterial) = Action::LookupOK Then begin
                            Material := rMaterial."Código";
                            Prod.SetRange("Tipo de Soporte", Rec."Tipo de Soporte");
                            Prod.SetRange(Material, Material);
                            if Prod.FindFirst() Then begin
                                Rec.Material := Material;
                                Rec."Recurso No." := Prod."Recurso No.";
                                Rec.Compra := Prod.Compra;
                                Rec.Venta := Prod.Venta;
                                Rec."Descuento Compra" := Prod."Descuento Compra";
                                Rec."Descuento Venta" := Prod."Descuento Venta";
                            end else // si no encuentra el material, da error
                                ERROR('No se ha encontrado el material para este tipo de soporte');
                        end;
                    end;

                    trigger OnValidate()
                    var
                        Prod: Record "Recursos de Producción";

                    begin
                        Material := Rec.Material;
                        Prod.SetRange("Tipo de Soporte", Rec."Tipo de Soporte");
                        Prod.SetRange(Material, Rec.Material);
                        if Prod.FindFirst() Then begin
                            Rec.Material := Material;
                            Rec."Recurso No." := Prod."Recurso No.";
                            Rec.Compra := Prod.Compra;
                            Rec.Venta := Prod.Venta;
                            Rec."Descuento Compra" := Prod."Descuento Compra";
                            Rec."Descuento Venta" := Prod."Descuento Venta";
                        end else // si no encuentra el material, da error
                            ERROR('No se ha encontrado el material para este tipo de soporte');
                    end;
                }
            }


            group(Step3)
            {
                Visible = Step3Visible;
                group(Group23)
                {
                    Caption = 'Recurso';
                    InstructionalText = 'Seleccione el recurso y escriba la descripción de la line de producción';
                    field("Nº Recurso"; Rec."Recurso No.")
                    {
                        ApplicationArea = All;
                        // trigger OnLookup(var Tect: Text): Boolean
                        // var
                        //     Prod: Record "Recursos de Producción";
                        // begin
                        //     Prod.SetRange("Tipo de Soporte", Rec."Tipo de Soporte");
                        //     Prod.SetRange(Material, Rec.Material);
                        //     if Page.RunModal(0, Prod) = Action::LookupOK Then Begin
                        //         Rec."Recurso No." := Prod."Recurso No.";
                        //         Rec.Compra := Prod.Compra;
                        //         Rec.Venta := Prod.Venta;
                        //         Rec."Descuento Compra" := Prod."Descuento Compra";
                        //         Rec."Descuento Venta" := Prod."Descuento Venta";
                        //     end;
                        // end;
                    }
                    field(Descripcion; Rec.Descripcion)
                    {
                        ApplicationArea = All;

                    }

                    field("Precio Venta"; Rec.Venta)
                    {
                        ApplicationArea = All;

                    }
                    field("Descuento Venta"; Rec."Descuento Venta")
                    {
                        ApplicationArea = All;

                    }
                    field("Precio Compra"; Rec.Compra)
                    {
                        ApplicationArea = All;

                    }
                    field("Descuento Compra"; Rec."Descuento Compra")
                    {
                        ApplicationArea = All;

                    }
                }

            }
            group(Step4)
            {
                Visible = Step4Visible;
                group(Group24)
                {
                    Caption = 'Empresa';
                    InstructionalText = 'Seleccione la empresa para asignar la producción';
                    field(Empresa; Rec.Empresa)
                    {
                        ApplicationArea = All;

                    }
                }

            }
            group(Step5)
            {
                Visible = Step5Visible;
                group(Group25)
                {
                    Caption = 'Proyecto';
                    InstructionalText = 'Seleccione el protyecto o los recursos para asignar la producción.';
                    field("Nº Proyecto"; Rec."Nº Proyecto")
                    {
                        ApplicationArea = All;


                    }
                    field("."; 'Dejelo en blanco si quiere seleccionar recursos de sistintos proyectos')
                    {
                        ShowCaption = false;
                        ApplicationArea = All;

                    }
                    field("Seleccionar Nº Recurso"; AsignaRecursos)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            Linp: Record 1003;
                            Linpt: Record 1003 temporary;
                            Job: Record Job;
                            Res: Record Resource;
                            Reserva: Record Reserva;
                            Zonas: Boolean;
                            ZonaNat: Code[20];
                        begin
                            AsignaRecursos := false;
                            Zonas := false;
                            iF rEC."Nº Proyecto" <> '' Then
                                Job.SetRange("No.", Rec."Nº Proyecto")
                            else
                                Job.SetRange("Sell-to Customer No.", Job."Sell-to Customer No.");
                            if Job.FindFirst() Then
                                repeat
                                    Linp.SetRange("Job No.", Job."No.");
                                    Linp.SetRange(Type, LinPt.Type::Resource);
                                    if Linp.FindFirst() then
                                        repeat
                                            Linpt := Linp;
                                            If Res.Get(Linpt."No.") then
                                                if not Res."Producción" then begin
                                                    Reserva.SetRange("Nº Recurso", Linpt."No.");
                                                    Reserva.SetRange("Nº Proyecto", Linpt."Job No.");
                                                    Reserva.SetFilter("Fecha Fin", '>=%1', Today);
                                                    if Reserva.FindFirst() then begin
                                                        Linpt.Insert();
                                                    end;
                                                end;
                                            If (ZonaNat <> '') and (Res."Global Dimension 4 Code" <> ZonaNat) then begin
                                                Zonas := true;
                                            end;
                                            ZonaNat := Res."Global Dimension 4 Code";
                                        until Linp.Next() = 0;
                                until Job.Next() = 0;
                            Commit();
                            If Not Zonas Then begin
                                Message('Todos los recursos pertenecen a la misma zona, no es necesario asignarlos');
                                lineasproyecto := Linpt;
                                if lineasproyecto.Insert() then;
                            end else begin
                                //Linpt.SetRange("Planning Date", CalcDate('<-3Y>', Today), 29991231D);
                                if Page.RunModal(0, Linpt) = Action::LookupOK Then begin
                                    LineasProyecto := Linpt;
                                    if lineasproyecto.Insert() then;
                                end;
                            end;

                        end;
                    }
                }

            }
            group(Step6)
            {
                Visible = Step6Visible;
                group(Group26)
                {
                    Caption = 'Proucción Incluida?';
                    InstructionalText = 'La Producción está incluida en la venta?';
                    field("Incluida"; Rec.Incluida)
                    {
                        ApplicationArea = All;


                    }
                }
                group("Esto es todo!")
                {
                    Caption = 'Esto es todo!';
                    group(Group27)
                    {
                        Caption = '';
                        InstructionalText = 'Pulse finalizar para volver al proyecto e insertar la línea';


                    }
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ActionBack)
            {
                ApplicationArea = All;
                Caption = 'Anterior';
                Enabled = BackActionEnabled;
                Image = PreviousRecord;
                InFooterBar = true;
                trigger OnAction();
                begin
                    NextStep(true);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = All;
                Caption = 'Siguiente';
                Enabled = NextActionEnabled;
                Image = NextRecord;
                InFooterBar = true;
                trigger OnAction();
                begin
                    NextStep(false);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = All;
                Caption = 'Fializar';
                Enabled = FinishActionEnabled;
                Image = Approve;
                InFooterBar = true;
                trigger OnAction();
                begin
                    FinishAction();
                end;
            }
        }
    }

    trigger OnInit();
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage();
    var
        Glseup: Record "General Ledger Setup";
    begin


        Step := Step::Start;
        EnableControls();
    end;
    /// <summary>
    /// Carga.
    /// </summary>
    /// <param name="PProyecto">code[20].</param>
    /// <param name="RRecurso">Code[20].</param>
    procedure Carga(PProyecto: code[20]; RRecurso: Code[20])
    var
        Res: Record Resource;
    begin
        Rec.Init();
        if Res.Get(RRecurso) then
            Rec."Tipo de Soporte" := Res."Tipo Recurso";
        Rec.Empresa := CompanyName;
        //Rec."Nº Proyecto" := PProyecto;
        REC."Proyecto Origen" := PProyecto;
        Rec.Insert();
    end;

    internal procedure Lineas(var rlin: Record "Job Planning Line" temporary)
    begin
        if lineasproyecto.FindFirst() Then
            repeat
                rlin := lineasproyecto;
                rlin.Insert();
            until lineasproyecto.Next() = 0;
    end;


    var
        lineasproyecto: Record "Job Planning Line" temporary;
        AsignaRecursos: Boolean;
        LLamar: Boolean;
        MediaRepositoryDone: Record "Media Repository";
        MediaRepositoryStandard: Record "Media Repository";
        MediaResourcesDone: Record "Media Resources";
        MediaResourcesStandard: Record "Media Resources";
        Step: Option Start,Step1,Step2,Step3,Step4,Step5,Step6,Finish;
        BackActionEnabled: Boolean;
        FinishActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        Step0Visible: Boolean;
        Step1Visible: Boolean;
        Step2Visible: Boolean;
        Step3Visible: Boolean;
        Step4Visible: Boolean;
        Step5Visible: Boolean;
        Step6Visible: Boolean;
        TopBannerVisible: Boolean;
        Material: Code[20];

    local procedure EnableControls();
    begin
        ResetControls();

        case Step of
            Step::Start:
                ShowStep0();
            Step::Step1:
                ShowStep1();
            Step::Step2:
                ShowStep2();
            Step::Step3:
                ShowStep3();
            Step::Step4:
                ShowStep4();
            Step::Step5:
                ShowStep5();
            Step::Step6:
                ShowStep6();
            Step::Finish:
                ShowStep6();
        end;
    end;

    local procedure StoreRecordVar();
    var
        GlSetup: Record "General Ledger Setup";
    begin
        // if not GlSetup.Get() then begin
        //     GlSetup.Init();
        //     GlSetup.Insert();
        // end;

        // GlSetup.TransferFields(Rec, false);
        // GlSetup.Modify(true);
    end;

    local procedure FinishAction();
    begin
        // StoreRecordVar();
        // if Not LLamar then begin
        //     Commit();
        //     Page.RunModal(Page::"Printer Management");
        // end;
        If lineasproyecto.Count() = 0 then
            ERROR('No se han seleccionado recursos para asignar a la producción');
        CurrPage.Close();
    end;

    local procedure NextStep(Backwards: Boolean);
    begin
        if Backwards then
            Step := Step - 1
        else
            Step := Step + 1;

        EnableControls();
    end;

    local procedure ShowStep0();
    begin
        Step0Visible := true;

        FinishActionEnabled := false;
        BackActionEnabled := false;
    end;

    local procedure ShowStep1();
    begin
        Step1Visible := true;

        FinishActionEnabled := false;
        BackActionEnabled := true;
    end;

    local procedure ShowStep2();
    begin
        Step2Visible := true;
    end;

    local procedure ShowStep3();
    begin
        Step3Visible := true;
    end;

    local procedure ShowStep4();
    begin
        Step4Visible := true;
    end;

    local procedure ShowStep5();
    begin
        Step5Visible := true;
    end;

    local procedure ShowStep6();
    begin
        Step6Visible := true;

        NextActionEnabled := false;
        FinishActionEnabled := true;
    end;

    local procedure ResetControls();
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;
        Step0Visible := false;
        Step1Visible := false;
        Step2Visible := false;
        Step3Visible := false;
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', Format(CurrentClientType())) and
            MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png', Format(CurrentClientType()))
        then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
                MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
        then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue();
    end;
}