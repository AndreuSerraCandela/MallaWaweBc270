/// <summary>
/// Page Laerit File Management Setup Wizard (ID 90103).
/// </summary>
page 7001111 "Wizard Recursos"
{
    Caption = 'Wizard Recursos';
    PageType = NavigatePage;
    SourceTable = "Resource";
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
                    Caption = 'Bienvenido al proceso de creación de recursos';
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
                Caption = 'Código y Descripción';
                InstructionalText = 'Código y Descripción del Soporte';
                Visible = Step1Visible;
                //You might want to add fields here
                field("Código"; Numero)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        //Variable Resource
                        Recurso: Record Resource;
                    begin
                        //Si se encuentra, error de ya existe   
                        if Recurso.Get(Numero) then
                            ERROR('El recurso ya existe');
                        Rec."No." := Numero;
                        Rec.Insert();
                    end;

                }
                field("Descripción"; Rec.Name)
                {
                    ApplicationArea = All;

                }
            }
            group(Step2)
            {
                Visible = Step7Visible;
                group(Group27)
                {
                    Caption = 'Ahora viene lo complicado!';
                    InstructionalText = 'Seleccione que tipo de recurso es';
                    field("¿Es un recurso agrupado?"; Rec."Recurso Agrupado")
                    {
                        Caption = '¿Es un recurso agrupado?';
                        ApplicationArea = All;

                    }
                    field("¿Qué es un recurso agrupado?"; 'Un recurso agrupado es un recurso de venta que se compone de varios recursos\, siempre y cunado estos recursos sean propios y deban crear reservas\. Ej Alquiler Opis')
                    {
                        ShowCaption = false;
                        ApplicationArea = All;

                    }


                    field("¿Es un recurso de producción?"; Rec."Producción")
                    {
                        Caption = '¿Es un recurso de producción?';
                        ApplicationArea = All;



                    }
                    field("¿Qué es un recurso de producción?"; 'Un recurso de producción es un recurso que se utiliza \para la producción de otros recursos propios que tenemos en exclusiva\. Ej. Vinilo Opis')
                    {
                        ShowCaption = false;
                        ApplicationArea = All;

                    }

                }
            }
            group(Step3)
            {
                Visible = Step2Visible;
                Caption = 'Tipo de soporte';
                InstructionalText = 'Indique sobre que tipo de soporte a crear';
                field("Tipo de Soporte"; Rec."Tipo Recurso")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        //Variable Record Tipo Recurso
                        TipoRecurso: Record "Tipo Recurso";

                    begin
                        //Get a tipo re recurso y testfiled de dimension principal, vat Prod posting group y gen. pros posting group
                        if TipoRecurso.Get(Rec."Tipo Recurso") then begin
                            TipoRecurso.TestField("Cód. Principal");
                            TipoRecurso.TestField("VAT Prod. Posting Group");
                            TipoRecurso.Testfield("Gen. Prod. Posting Group");
                        end;
                        Rec."Global Dimension 1 Code" := TipoRecurso."Cód. Departamento";
                        Rec."Global Dimension 3 Code" := TipoRecurso."Cód. Principal";
                        Rec."VAT Prod. Posting Group" := TipoRecurso."VAT Prod. Posting Group";
                        Rec."Gen. Prod. Posting Group" := TipoRecurso."Gen. Prod. Posting Group";

                        //Pon sisible el campo Recurso agrupado y producción

                    end;
                }

            }


            group(Step4)
            {
                Visible = Step3Visible;
                group(Group23)
                {
                    Caption = 'Familia y Tarifa';
                    InstructionalText = 'Escriba las descripcion del recurso';
                    field("Familia Recurso"; Rec."Resource Group No.")
                    {
                        Caption = 'Familia Recurso';
                        ApplicationArea = All;

                    }
                    field("Categoria Tarifa"; Rec."Customer Price Group")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            FromSalesPrice: Record "Price List Line";// "Sales Price";
                            TempTargetCampaignGr: Record "Campaign Target Group";
                            StartingDate: date;
                        BEGIN

                            if StartingDate = 0D THEN StartingDate := WORKDATE;
                            FromSalesPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
                            FromSalesPrice.SETRANGE("Starting Date", 0D, StartingDate);
                            FromSalesPrice.SETRANGE("Source Type", FromSalesPrice."Source Type"::"Customer Price Group");
                            FromSalesPrice.SETRANGE("Source No.", Rec."Customer Price Group");
                            if FromSalesPrice.FINDLAST THEN Rec."Alquiler Anual" := FromSalesPrice."Unit Price";
                        end;
                    }
                }

            }
            group(Step5)
            {
                Visible = Step4Visible;
                group(Group24)
                {
                    Caption = 'Donde Está el Recurso?';
                    InstructionalText = 'Seleccion los datos de ubicación del recurso';
                    field("Escribe el Código Postal"; Rec."C.P. Municipio")
                    {
                        Caption = 'Esribe el Código Postal';
                        ApplicationArea = All;

                    }
                    field("En Que Municipio está instalado?"; Rec."Municipio")
                    {
                        Caption = '¿En Que Municipio está instalado?';
                        ApplicationArea = All;

                    }
                    field("En que Zona esá situado?"; Rec.Zona)
                    {
                        Caption = '¿En que Zona esá situado?';
                        ApplicationArea = All;
                    }
                    field("Como está Orienta?"; Rec."Orientación")
                    {
                        Caption = '¿Como está Orienta?';
                        ApplicationArea = All;
                    }
                    field("Dame la ubicación, Puntox y Punto y, separado por ;"; Ubicacion)
                    {
                        Caption = 'Dame la ubicación, Puntox y Punto y, separado por ;';
                        ToolTip = 'PuntoX y PuntoY, separado por ;';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            //Pon la ubicacion en Punto x y punto y, viene separada por ;
                            Evaluate(Rec.PuntoX, COPYSTR(Ubicacion, 1, StrPos(Ubicacion, ';') - 1));
                            Evaluate(Rec.PuntoY, COPYSTR(Ubicacion, StrPos(Ubicacion, ';') + 1, STRLEN(Ubicacion)));

                        end;
                    }

                }

            }
            group(Step6)
            {
                Visible = Step5Visible;
                group(Group25)
                {
                    Caption = '¿Como es el recurso?';
                    InstructionalText = 'Seleccione el tipo de recursos';
                    field("¿Qué prohibiciones tiene?"; Rec.Prohibiciones)
                    {
                        Caption = '¿Qué prohibiciones tiene?';
                        ApplicationArea = All;


                    }
                    //linea vida
                    field("¿Que ocurre con la línea vida?"; Rec."Linea Vida")
                    {
                        Caption = '¿Que ocurre con la línea vida?';
                        ApplicationArea = All;

                    }
                    field("Qué peligosidad tiene?"; Rec.Peligrosidad)
                    {
                        Caption = '¿Qué peligosidad tiene?';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            //Si es peligroso, se pone visible las observaciones peligrosidad
                            if Rec.Peligrosidad <> '' then
                                ObservacionesPeligrosidadVisible := true
                            else
                                ObservacionesPeligrosidadVisible := false;
                        end;
                    }
                    group(Peligrosidad)
                    {
                        Visible = ObservacionesPeligrosidadVisible;
                        field("¿Quieres comentar algo más sobre la peligrosidad?"; Rec."Observaciones Peligrosidad")
                        {
                            Caption = '¿Quieres comentar algo más sobre la peligrosidad?';
                            ApplicationArea = All;

                        }
                    }
                    field("¿Qué medidas tine?"; Rec.Medidas)
                    {
                        Caption = '¿Qué medidas tiene?';
                        ApplicationArea = All;

                    }
                    field("¿Está iluminado?"; Rec.Iluminado)
                    {
                        Caption = '¿Está iluminado?';
                        ApplicationArea = All;

                    }
                    field("¿Cómo se monta?"; Rec."tipo Montaje")
                    {
                        Caption = '¿Cómo se monta?';
                        ApplicationArea = All;

                    }


                }

            }
            group(Step7)
            {
                Visible = Step6Visible;
                group(Group26)
                {
                    Caption = 'Precios del Recurso';
                    InstructionalText = 'Seleccione los precios recursos';
                    group("Precios Locales")
                    {

                        field("¿Tiene alquiler anual?"; Rec."Alquiler Anual")
                        {
                            Caption = '¿Tiene alquiler anual?';
                            ApplicationArea = All;

                        }
                        field("¿Y para los 7 meses?"; Rec."Local - Alquiler 7 Meses")
                        {
                            Caption = '¿Y para los 7 meses?';
                            ApplicationArea = All;

                        }

                    }
                    group("Precios Nacionales")
                    {
                        field("¿Tiene alquiler anual Nacional?"; Rec."Nacional - Alquiler Anual")
                        {
                            Caption = '¿Tiene alquiler anual?';
                            ApplicationArea = All;

                        }
                        field("¿Y para los 7 meses Nacional?"; Rec."Nacional - Alquiler 7 Meses")
                        {
                            Caption = '¿Y para los 7 meses?';
                            ApplicationArea = All;

                        }
                    }

                }

            }

            group(Step8)
            {
                Visible = Step8Visible;
                group(Group28)
                {
                    Caption = 'Ya casi Está!';
                    InstructionalText = 'Vamos con las dimensiones?';
                    field("¿Qué departamento?"; Rec."Global Dimension 1 Code")
                    {
                        Caption = '¿Qué departamento?';
                        ApplicationArea = All;


                    }
                    field("¿Qué programa?"; Rec."Global Dimension 2 Code")
                    {
                        Caption = '¿Qué programa?';
                        ApplicationArea = All;

                    }
                    field("¿Qué dimension principal?"; Rec."Global Dimension 3 Code")
                    {
                        Caption = '¿Qué dimension principal?';
                        ApplicationArea = All;

                    }
                    field("¿En qué zona?"; Rec."Global Dimension 4 Code")
                    {
                        Caption = '¿En qué zona?';
                        ApplicationArea = All;

                    }
                    field("¿Qué tipo de soporte?"; Rec."Global Dimension 5 Code")
                    {
                        Caption = '¿Qué tipo de soporte?';
                        ApplicationArea = All;

                    }
                }

            }
            group(Step9)
            {
                Visible = Step9Visible;
                group(Group29)
                {
                    Caption = 'Ánimo, última pantalla!';
                    InstructionalText = 'Datos contables y precios';
                    // field("¿Tiene Irpf?"; Rec.Irpf)
                    // {
                    //     Caption = '¿Tiene Irpf?';
                    //     ApplicationArea = All;


                    // }
                    field("¿Qué grupo contable?"; Rec."Gen. Prod. Posting Group")
                    {
                        Caption = '¿Qué grupo contable?';
                        ApplicationArea = All;

                    }
                    field("¿Y el Iva?"; Rec."VAT Prod. Posting Group")
                    {
                        Caption = '¿Y el Iva?';
                        ApplicationArea = All;

                    }



                }

                group("Esto es todo!")
                {
                    Caption = 'Esto es todo!';
                    group(Group30)
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
    procedure Carga()
    var
        Res: Record Resource;
    begin
        Rec.Init();

    end;



    var
        Numero: Code[20];
        ObservacionesPeligrosidadVisible: Boolean;
        RecursoAgrupadoVisible: Boolean;
        ProduccionVisible: Boolean;
        Ubicacion: Text;
        LLamar: Boolean;
        MediaRepositoryDone: Record "Media Repository";
        MediaRepositoryStandard: Record "Media Repository";
        MediaResourcesDone: Record "Media Resources";
        MediaResourcesStandard: Record "Media Resources";
        Step: Option Start,Step1,Step2,Step3,Step4,Step5,Step6,Step7,Step8,Step9,Finish;
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
        Step7Visible: Boolean;
        Step8Visible: Boolean;
        Step9Visible: Boolean;
        TopBannerVisible: Boolean;

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
            // añade hata el 9
            Step::Step7:
                ShowStep7();
            Step::Step8:
                ShowStep8();
            Step::Step9:
                ShowStep9();
            Step::Finish:
                ShowStep9();
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
    var
        Res: Record Resource;
        Uni: Record "Resource Unit of Measure";
    begin
        //Crear Recurso a partir de este Recurso temporal
        Res := Rec;
        Res.Insert();
        Res.Validate("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        // Lo mismo parra las 5 dimensiones
        Res.Validate("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
        Res.Validate("Global Dimension 3 Code", Rec."Global Dimension 3 Code");
        Res.Validate("Global Dimension 4 Code", Rec."Global Dimension 4 Code");
        Res.Validate("Global Dimension 5 Code", Rec."Global Dimension 5 Code");
        if Rec."Base Unit of Measure" = '' then
            Rec."Base Unit of Measure" := 'UNIDAD';
        Res."Base Unit of Measure" := Rec."Base Unit of Measure";
        Res."Employment Date" := TODAY;
        Res.Modify(true);
        //Crear Unidad de Medida
        Uni."Resource No." := Res."No.";
        Uni."Code" := Res."Base Unit of Measure";
        Uni."Related to Base Unit of Meas." := true;
        Uni.Insert();



        CurrPage.Close();
    end;

    local procedure NextStep(Backwards: Boolean);
    begin
        CompruebaPaso(Step);
        if (Rec."Producción") Or Rec."Recurso Agrupado" Then begin
            if Step = Step::Step2 then begin
                if Backwards then
                    Step := Step - 1
                else
                    Step := 8;
            end else begin
                if Step = Step::Step8 then begin
                    if Backwards then
                        Step := 2
                    else
                        Step := Step + 1;
                end else
                    if Backwards then
                        Step := Step - 1
                    else
                        Step := Step + 1;
            end;
        end else
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
    //crea hasta el 8
    local procedure ShowStep6();
    begin
        Step6Visible := true;
    end;

    local procedure ShowStep7();
    begin
        Step7Visible := true;
    end;

    local procedure ShowStep8();
    begin
        Step8Visible := true;
    end;

    local procedure ShowStep9();
    begin
        Step9Visible := true;

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
        //añade hasta el 9
        Step4Visible := false;
        Step5Visible := false;
        Step6Visible := false;
        Step7Visible := false;
        Step8Visible := false;
        Step9Visible := false;

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

    local procedure CompruebaPaso(Step: Option Start,Step1,Step2,Step3,Step4,Step5,Step6,Step7,Step8,Step9,Finish)
    begin
        // Hacer un tesfield a los campos incluidos en cada step
        case Step of
            Step::Step2:
                Rec.TestField("Tipo Recurso");
            Step::Step1:
                begin
                    Rec.TestField("No.");
                    Rec.TestField("Name");
                end;
            Step::Step4:
                begin
                    Rec.TestField("Resource Group No.");
                    // Rec.TestField("Categoria");
                end;
            Step::Step8:
                begin
                    Rec.TestField("global Dimension 1 Code");
                    Rec.TestField("global Dimension 2 Code");
                    Rec.TestField("global Dimension 3 Code");
                    Rec.TestField("global Dimension 4 Code");
                    Rec.TestField("global Dimension 5 Code");
                end;

        end;
    end;
}