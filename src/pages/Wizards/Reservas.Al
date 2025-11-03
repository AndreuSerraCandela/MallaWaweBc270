/// <summary>
/// Page Laerit File Management Setup Wizard (ID 50080).
/// </summary>
page 50080 "Wizard Reservas"
{
    Caption = 'Wizard Reservas';
    PageType = NavigatePage;
    SourceTable = "Job Planning Line";
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
                group("Bienvenido al proceso de creación de reservas")
                {
                    Caption = 'Bienvenido al proceso de creación de las reservas de recursos';
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
                Caption = 'Comprobemos si tiene un recurso agrupado';
                InstructionalText = 'Indique que recurso es';
                field("¿Depende de la disponibilidad?"; Disponibilidad)
                {
                    ApplicationArea = All;
                    Caption = 'Depende de la disponibilidad?';
                    trigger OnValidate()
                    begin
                        Job.Get(Rec."Job No.");
                        Job."Según disponibilidad" := Disponibilidad;
                        Job.Modify();
                    end;
                }
                field("¿Es un proyecto Mixto?"; Mixto)
                {
                    ApplicationArea = All;
                    Caption = '¿Es un proyecto mixto?';
                    trigger OnValidate()
                    begin
                        Job.Get(Rec."Job No.");
                        Job."Proyecto Mixto" := Mixto;
                        Job.Modify();
                    end;
                }
                field("¿Qué recurso agrupado ?"; Recurso)
                {
                    ApplicationArea = All;
                    Caption = '¿Es un recurso agrupado?';
                    trigger OnValidate()
                    begin
                        Rec."No." := Recurso;
                        Rec.Modify();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var

                        rLinProy: Record "Job Planning Line";
                        Res: Record Resource;
                    begin
                        if Recurso = '' Then begin
                            rLinProy.SETRANGE("Job No.", rec."Job No.");
                            rLinProy.SETRANGE(rLinProy."Recurso Agrupado", TRUE);
                            if Page.RUNMODAL(0, rLinProy) = ACTION::LookupOK THEN BEGIN
                                Recurso := rLinProy."No.";
                                Linea := rLinProy."Line No.";


                            END else begin
                                Job.Get(Rec."Job No.");
                                if job."Proyecto Mixto" = false Then
                                    error('No ha elegido circuito');
                            end;
                        end;
                        Rec."No." := Recurso;
                        Rec.Modify();
                    end;

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


    var
        Mixto: Boolean;
        Disponibilidad: Boolean;
        Recurso: Code[20];
        Linea: Integer;
        Num: Code[20];
        LLamar: Boolean;
        MediaRepositoryDone: Record "Media Repository";
        MediaRepositoryStandard: Record "Media Repository";
        MediaResourcesDone: Record "Media Resources";
        MediaResourcesStandard: Record "Media Resources";
        Step: Option Start,Step1,Finish;
        BackActionEnabled: Boolean;
        FinishActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        Step0Visible: Boolean;
        Step1Visible: Boolean;
        Step2Visible: Boolean;
        Step3Visible: Boolean;
        Step4Visible: Boolean;
        Step5Visible: Boolean;
        //Step6Visible: Boolean;
        TopBannerVisible: Boolean;
        ProyectoAnteriorVisible: Boolean;
        EsClienteNuevoVisible: Boolean;

        ClienteNuevo: Boolean;
        SalesPerson: Record "Salesperson/Purchaser";
        Proyectomixpovisible: Boolean;
        Traspasamos: Boolean;
        JobLineT: Record "Job Planning Line";
        //Variable Record Job
        Job: Record Job;
        Agrupado: Boolean;
        TipoRecurso: Code[20];
        Produccion: Boolean;
        Compra: Boolean;
        Venta: Boolean;

    /// <summary>
    /// Carga.
    /// </summary>
    /// <param name="PProyecto">code[20].</param>
    /// <param name="llinea">Integer.</param>

    procedure Carga(PProyecto: code[20]; llinea: Integer; RecursoAgrupado: Code[20])
    var
        //Varaable Job Setup
        JobSetup: Record "Jobs Setup";
    //Variable Codeunit NoserieManagement


    begin
        //Crear proyecto con numero correspondiente
        Rec.Init();
        Rec."Job No." := PProyecto;
        Rec."Job Task No." := '10';
        Rec."Line No." := llinea + 10000;
        Rec."No." := RecursoAgrupado;
        Rec.Insert();


    end;
    /// <summary>
    /// LLinea.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure LLinea(): Integer
    begin
        exit(Linea);
    end;
    /// <summary>
    /// RRecurso.
    /// </summary>
    /// <returns>Return value of type Code[20].</returns>
    procedure RRecurso(): Code[20]
    begin
        if Rec."No." = '' Then exit(Recurso);
        exit(Rec."No.");
    end;

    local procedure EnableControls();
    begin
        ResetControls();

        case Step of
            Step::Start:
                ShowStep0();
            Step::Step1:
                ShowStep1();

            Step::Finish:
                ShowStep1();
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
        ComprobarRegursosAgrupados(Recurso, linea, Rec."Job No.");
        Rec."No." := Recurso;
        BackActionEnabled := true;

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
        Step4Visible := false;
        Step5Visible := false;
        //Step6Visible := false;

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

    PROCEDURE ComprobarRegursosAgrupados(VAR Recurso: Code[20]; VAR Linea: Integer; JobNo: Code[20])
    VAR
        rLinProy: Record 1003;
        rLinProy2: Record 1003;
        Cuenta: Integer;
        Job: Record Job;
        Tipo: Code[20];
        Res: Record Resource;
    BEGIN
        Recurso := '';
        Linea := 0;
        rLinProy.SETRANGE("Job No.", JobNo);
        rLinProy.SETRANGE(rLinProy."Recurso Agrupado", TRUE);
        if job."Proyecto Mixto" = false Then begin
            rLinProy2.SETRANGE("Job No.", JobNo);
            rLinProy2.SETRANGE("Line No.", Linea);
            if rLinProy2.FindFirst() Then begin
                if Res.Get(rLinProy2."No.") then Tipo := Res."Tipo Recurso";
            end;
        end;
        Cuenta := rLinProy.COUNT;
        if Cuenta = 0 THEN begin
            Rec."Recurso Agrupado" := false;
            CurrPage.Close();
        end;
        if Cuenta = 1 THEN BEGIN
            rLinProy.FINDFIRST;
            Recurso := rLinProy."No.";
            Linea := rLinProy."Line No.";
            if tipo <> '' Then begin
                if Res.Get(Recurso) Then if Res."Tipo Recurso" <> Tipo Then Error('El recurso reservado y, el recurso agrupado, no son del mismo tipo')
            end;
            EXIT;
        END;

    END;


    // local procedure CrearClienteDesdePlantilla(): Code[20]
    // var
    //     CustTemplate: Record "Customer Templ.";
    //     Customer: Record Customer;
    //     No: Code[20];
    // begin
    //     //Elije la plantilla de una lista
    //     if Page.RunModal(0, CustTemplate) <> Action::LookupOK then
    //         Error('No se ha seleccionado ninguna plantilla de cliente.');
    //     // Buscar la plantilla de cliente
    //     if Customer.FindLast() Then No := IncStr(Customer."No.") Else No := '10000';
    //     // Crear un nuevo registro de cliente
    //     Customer.Init();
    //     Customer."No." := No;  // Puedes reemplazar esto por una lógica para generar números de cliente
    //     Customer."Customer Posting Group" := CustTemplate."Customer Posting Group";
    //     Customer."Gen. Bus. Posting Group" := CustTemplate."Gen. Bus. Posting Group";
    //     Customer."VAT Bus. Posting Group" := CustTemplate."VAT Bus. Posting Group";
    //     Customer."Customer Price Group" := CustTemplate."Customer Price Group";
    //     Customer."Customer Disc. Group" := CustTemplate."Customer Disc. Group";
    //     Customer."Payment Terms Code" := CustTemplate."Payment Terms Code";
    //     Customer."Payment Method Code" := CustTemplate."Payment Method Code";
    //     // Agrega aquí más campos de la plantilla según sea necesario

    //     // Insertar el nuevo cliente
    //     if not Customer.Insert() then
    //         Error('No se pudo crear el cliente.');
    //     Commit();
    //     exit(Customer."No.");

    // end;

}