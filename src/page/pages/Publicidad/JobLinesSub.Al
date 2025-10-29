/// <summary>
/// Page JobLinesSub (ID 50019).
/// </summary>
page 50019 "JobLinesSub"
{
    Caption = 'Job Lines SubPage';
    DataCaptionFields = "Job No.";
    PageType = ListPart;
    SaveValues = true;
    SourceTable = "Job Planning Line";
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                ShowCaption = false;
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies the number of the related job.';
                    Visible = false;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies the number of the related job task.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite, Jobs;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    //Style = Strong;
                    StyleExpr = Color;
                    // trigger OnLookup(var Text: Text): Boolean
                    // var
                    //     ResourceList: Page "Resource List";
                    //     Resource: Record Recurso;
                    // begin
                    //     if Rec.Type = Rec.Type::Resource Then begin

                    //         if ResourceList.RunModal() = Action::LookupOK Then begin
                    //             Rec.Validate("No.", ResourceList.CambiaEmpresa());
                    //         end;
                    //     end;
                    // end;
                    trigger OnAssistEdit()
                    var
                        rJobPl: Record "Job Planning Line";
                        fJobl: Page "MLL-Presupuesto proyecto compr";
                        rRes: Record "Resource";
                        rCost: Record "Price List Line";
                        Linea: Integer;
                    begin

                        if Rec."Origin Line No." <> 0 THEN EXIT;
                        rJobPl.SETRANGE(rJobPl."Job No.", Rec."Job No.");
                        if rJobPl.FINDLAST THEN Linea := rJobPl."Line No." + 10000 ELSE EXIT;
                        rJobPl.SETRANGE(rJobPl."Origin Line No.", Rec."Line No.");
                        rJobPl.SETRANGE(rJobPl."Job Task No.", Rec."Job Task No.");
                        rJobPl.SETRANGE(rJobPl."Crear pedidos", rJobPl."Crear pedidos"::"De Compra");
                        if (NOT rJobPl.FINDFIRST) AND (Rec.Type IN [Rec.Type::Resource, Rec.Type::Familia]) THEN BEGIN
                            CASE Rec.Type OF
                                Rec.Type::Resource:
                                    BEGIN
                                        rCost.SETRANGE(rCost."Asset Type", rCost."Asset Type"::Resource);
                                        rCost.SETRANGE(rCost."Asset No.", Rec."No.");
                                        rRes.GET(Rec."No.");
                                        if (NOT rCost.FINDFIRST) AND (rRes."Resource Group No." <> '') THEN BEGIN
                                            rCost.SETRANGE(rCost."Asset Type", rCost."Asset Type"::"Resource Group");
                                            rCost.SETRANGE(rCost."Asset No.", rRes."Resource Group No.");
                                        END;
                                    END;
                                Rec.Type::Familia:
                                    BEGIN
                                        rCost.SETRANGE(rCost."Asset Type", rCost."Asset Type"::"Resource Group");
                                        rCost.SETRANGE(rCost."Asset No.", Rec."No.");
                                    END;
                            END;
                            if rCost.FINDFIRST THEN
                                REPEAT
                                    rJobPl := Rec;
                                    rJobPl."Line No." := Linea;
                                    Linea := Linea + 10000;
                                    CASE rCost."Dest. Type" OF
                                        rCost."Dest. Type"::Resource:
                                            rJobPl.Type := rJobPl.Type::Resource;
                                        rCost."Dest. Type"::"Group(Resource)":
                                            rJobPl.Type := rJobPl.Type::Familia;
                                    END;
                                    rJobPl."Cdad. a Reservar" := 0;
                                    rJobPl.VALIDATE("No.", rCost."Dest. Code");
                                    if rCost."Amount Type" = rCost."Amount Type"::"% Extra" THEN
                                        rJobPl.VALIDATE(rJobPl."Unit Cost", Rec."Unit Cost" * rCost."Direct Unit Cost" / 100)
                                    ELSE
                                        rJobPl.VALIDATE(rJobPl."Unit Cost", rCost."Direct Unit Cost");
                                    rJobPl."Crear pedidos" := Rec."Crear pedidos"::"De Compra";
                                    rJobPl."Origin Line No." := Rec."Line No.";
                                    rJobPl.VALIDATE(rJobPl."Compra a-Nº proveedor", rCost."Source No.");
                                    rJobPl."Cdad. Reservada" := 0;
                                    rJobPl.INSERT;
                                UNTIL rCost.NEXT = 0;
                        END;
                        COMMIT;
                        CLEAR(fJobl);
                        fJobl.FiltroCompra(Rec."Line No.");
                        fJobl.SETTABLEVIEW(rJobPl);
                        fJobl.RUNMODAL;
                        COMMIT;
                        Rec."Crear pedidos" := Rec."Crear pedidos"::"De Venta";
                        // if ISCLEAR(ws) THEN
                        // CREATE(ws);
                        // ws.SendKeys('% ');
                        // ws.SendKeys('{RIGHT}');
                        // ws.SendKeys('x');
                    end;


                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    StyleExpr = Color;

                    ToolTip = 'Specifies a description of the job task. You can enter anything that is meaningful in describing the task. The description is copied and used in descriptions on the job planning line.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Grupo contable producto';
                    ApplicationArea = all;
                }
                field("Nº Orden Recurso"; Rec."No Orden Recurso")
                {
                    ApplicationArea = all;
                }
                field("Compra a-Nº proveedor"; Rec."Compra a-Nº proveedor")
                {
                    ApplicationArea = All;
                }
                field("Nombre Soporte"; Rec."Nombre Soporte")
                {
                    ApplicationArea = all;
                }
                field("Crear pedidos"; Rec."Crear pedidos")
                {
                    ApplicationArea = all;
                }
                field("Imprmir en Contrato/Factura"; Rec."Imprmir en Contrato/Factura")
                {
                    ApplicationArea = all;

                }
                field("Tipo Duracion"; Rec."Tipo Duracion")
                {
                    ApplicationArea = all;
                }
                field("Planning Date"; Rec."Planning Date")
                {
                    Caption = 'Fecha inical';
                    ApplicationArea = all;
                }
                field("Fecha Final"; Rec."Fecha Final")
                {
                    ApplicationArea = all;
                }
                field(Duracion; Rec.Duracion)
                {
                    ApplicationArea = all;
                }
                field("Cdad. Soportes"; Rec."Cdad. Soportes")
                {
                    ApplicationArea = all;
                }
                field("Sin Producción"; Rec."Sin Producción")
                {
                    ApplicationArea = all;
                    Visible = MaterialVisibele;
                }
                field("Solo Producción"; Rec."Solo Producción")
                {
                    ApplicationArea = all;
                    Visible = MaterialVisibele;
                    trigger OnValidate()
                    begin
                        if Rec."Solo Producción" Then
                            CurrPage.Update(false);
                    end;
                }
                field(Cartel; Rec.Cartel)
                {
                    ApplicationArea = all;
                    Visible = MaterialVisibele;
                    trigger OnValidate()
                    begin
                        if Rec.Cartel Then
                            CurrPage.Update(false);
                    end;
                }
                field(Lona; Rec.Lona)
                {
                    ApplicationArea = all;
                    Visible = MaterialVisibele;
                    trigger OnValidate()
                    begin
                        if Rec.Lona Then
                            CurrPage.Update(false);
                    end;
                }
                field(Vinilo; Rec.Vinilo)
                {
                    ApplicationArea = all;
                    Visible = MaterialVisibele;
                    trigger OnValidate()
                    begin
                        if Rec.Vinilo Then
                            CurrPage.Update(false);
                    end;
                }
                field(Otros; Rec.Otros)
                {
                    ApplicationArea = all;
                    Visible = MaterialVisibele;
                    trigger OnValidate()
                    begin
                        if Rec.Otros Then
                            CurrPage.Update(false);
                    end;
                }

                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = all;
                }
                field("Nombre Zona"; NZona(Rec."Shortcut Dimension 5 Code"))
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cdad. a Reservar"; Rec."Cdad. a Reservar")
                {
                    ApplicationArea = all;
                }
                field("Cdad. Reservada"; Rec."Cdad. Reservada")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Total Cost"; rec."Total Cost")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies, in local currency, the total billable cost for the job task during the time period in the Planning Date Filter field.';

                }
                field("% Dto. Compra"; Rec."% Dto. Compra")
                {
                    ApplicationArea = all;
                }

                field("Precio Tarifa"; Rec."Precio Tarifa")
                {
                    ApplicationArea = all;
                }
                field("Dto. Tarifa"; Rec."Dto. Tarifa")
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                }
                field("% Dto. Volumen"; Rec."% Dto. Venta 1")
                {
                    ApplicationArea = all;
                }
                field("% Dto. Agencia"; Rec."% Dto. Venta 2")
                {
                    ApplicationArea = all;
                }
                field("Total Venta"; Rec."Total Venta")
                {
                    Editable = true;
                    ApplicationArea = Basic, Suite, Jobs;
                    ToolTip = 'Specifies, in the local currency, the total billable price for the job task during the time period in the Planning Date Filter field.';
                }

                field("Nº fam. recurso"; Rec."Nº fam. recurso")
                {
                    ApplicationArea = all;
                }


            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Line)
            {
                Caption = 'Linea';
                group("&Job")
                {
                    Caption = '&Proyecto';
                    Image = Job;

                    action(JobPlanningLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Lineas &planificación proyecto';
                        Image = JobLines;
                        Scope = Repeater;
                        ToolTip = 'View all planning lines for the job. You use this window to plan what items, resources, and general ledger expenses that you expect to use on a job (budget) or you can specify what you actually agreed with your customer that he should pay for the job (billable).';

                        trigger OnAction()
                        var
                            JobPlanningLine: Record "Job Planning Line";
                            JobPlanningLines: Page "Job Planning Lines";
                        begin
                            Rec.TestField("Job No.");
                            JobPlanningLine.FilterGroup(2);
                            JobPlanningLine.SetRange("Job No.", Rec."Job No.");
                            JobPlanningLine.SetRange("Job Task No.", Rec."Job Task No.");
                            JobPlanningLine.FilterGroup(0);
                            JobPlanningLines.SetTableView(JobPlanningLine);
                            JobPlanningLines.Editable := true;
                            JobPlanningLines.Run;
                        end;
                    }
                    action("Asignar produccion a seleccionadas")
                    {
                        ApplicationArea = All;
                        Caption = 'Asignar produccion a seleccionadas';
                        Image = AssessFinanceCharges;
                        Scope = Repeater;
                        
                        trigger OnAction()
                        var
                            JobPlanningLine: Record "Job Planning Line";
                            Tipo: Code[20];
                            Res: Record Resource;
                            rProd: Record "Recursos de Producción";
                        begin
                            CurrPage.SetSelectionFilter(JobPlanningLine);
                            JobPlanningLine.SetRange(Type, JobPlanningLine.Type::Resource);
                            JobPlanningLine.Modifyall(Cartel, false);
                            JobPlanningLine.Modifyall(Lona, false);
                            JobPlanningLine.Modifyall(Vinilo, false);
                            JobPlanningLine.Modifyall(Otros, false);
                            JobPlanningLine.ModifyAll("Sin Producción", false);
                            JobPlanningLine.ModifyAll("Solo Producción", false);
                            If JobPlanningLine.FindSet() Then
                                Repeat
                                    Res.GET(JobPlanningLine."No.");
                                    If Res."Producción" then Error('La linea no puede ser de producción');
                                    If (Tipo <> '') And (Tipo <> Res."Tipo Recurso") Then Error('No se pueden mezclar tipos de recursos');
                                Until JobPlanningLine.Next = 0;
                            rProd.SetRange("Tipo de Soporte", Res."Tipo Recurso");
                            If Page.RunModal(0, rProd) = Action::LookupOK then begin
                                case rProd.Material of
                                    'Cartel':
                                        JobPlanningLine.Modifyall(Cartel, true);
                                    'Lona':
                                        JobPlanningLine.Modifyall(Lona, true);
                                    'Vinilo':
                                        JobPlanningLine.Modifyall(Vinilo, true);
                                    else
                                        JobPlanningLine.Modifyall(Otros, true);

                                end;
                                commit;
                                Rec.CrearLineaProduccion(rProd.Material, True, JobPlanningLine);
                            end;

                        end;
                    }
                    action("Movimientos &proyecto")
                    {
                        ApplicationArea = All;
                        Caption = 'Movimientos &proyecto';
                        Image = JobLedger;
                        RunObject = Page "Job Ledger Entries";
                        RunPageLink = "Job No." = FIELD("Job No."),
                                      "Job Task No." = FIELD("Job Task No.");
                        RunPageView = SORTING("Job No.", "Job Task No.");
                        ShortCutKey = 'Ctrl+F7';
                        ToolTip = 'View the job ledger entries.';
                    }
                     action("&Texto ampliado línea")
                    {
                        ApplicationArea = All;
                        Image = Relatives;
                        ShortcutKey = F10;
                        Caption = '&Texto ampliado línea';
                        trigger OnAction()
                        Begin
                            LlamaTexto(Rec."Line No.");
                        END;
                }
                }
                group("&Dimensions")
                {
                    Caption = '&Dimensiones';
                    Image = Dimensions;
                    action("Dimensions-&Single")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensiones-&Individuales';
                        Image = Dimensions;
                        trigger OnAction()
                        begin
                            ShowDimensions();
                        end;
                    }
                    // action("Dimensions-&Multiple")
                    // {
                    //     AccessByPermission = TableData Dimension = R;
                    //     ApplicationArea = Dimensions;
                    //     Caption = 'Dimensions-&Multiple';
                    //     Image = DimensionSets;
                    //     ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical inPageation.';

                    //     trigger OnAction()
                    //     var
                    //         JobTask: Record "Job Planning Line";
                    //         JobTaskDimensionsMultiple: Page "Job Task Dimensions Multiple";
                    //     begin
                    //         CurrPage.SetSelectionFilter(JobTask);
                    //         JobTaskDimensionsMultiple.SetMultiJobTask(JobTask);
                    //         JobTaskDimensionsMultiple.RunModal;
                    //     end;
                    // }
                }
                group(Documents)
                {
                    Caption = 'Documentos';
                    Image = Invoice;
                    action("Create &Sales Invoice")
                    {
                        ApplicationArea = All;
                        Caption = 'Crear &Factura Venta';
                        Ellipsis = true;
                        Image = JobSalesInvoice;
                        ToolTip = 'Use a batch job to help you create sales invoices for the involved job tasks.';

                        trigger OnAction()
                        var
                            Job: Record Job;
                            JobTask: Record "Job Task";
                        begin
                            Rec.TestField("Job No.");
                            Job.Get(Rec."Job No.");
                            if Job.Blocked = Job.Blocked::All then
                                Job.TestBlocked;

                            JobTask.SetRange("Job No.", Job."No.");
                            if Rec."Job Task No." <> '' then
                                JobTask.SetRange("Job Task No.", Rec."Job Task No.");

                            REPORT.RunModal(REPORT::"Job Create Sales Invoice", true, false, JobTask);
                        end;
                    }

                }
                group(History)
                {
                    Caption = 'Historial';
                    Image = History;
                    action("Job Ledger E&ntries")
                    {
                        ApplicationArea = All;
                        Caption = '&Mov. Proyecto';
                        Image = JobLedger;
                        RunObject = Page "Job Ledger Entries";
                        RunPageLink = "Job No." = FIELD("Job No."),
                                      "Job Task No." = FIELD("Job Task No.");
                        RunPageView = SORTING("Job No.", "Job Task No.");
                        ShortCutKey = 'Ctrl+F7';
                        ToolTip = 'View the job ledger entries.';
                    }
                }
                group("F&unctions")
                {
                    Caption = 'F&unciones';
                    Image = "Action";
                    //crear una acción para marcar como false el campo imprimir de todas las lineas de planificación
                    action("Marcar como No Imprimibles")
                    {
                        Image = Select;
                        ApplicationArea = All;
                        trigger OnAction()
                        var
                            Job: Record Job;
                            JobTask: Record "Job Task";
                            JobPlanningLine: Record "Job Planning Line";
                        begin
                            JobPlanningLine.SetRange("Job No.", Rec."Job No.");
                            JobPlanningLine.ModifyAll("Imprmir en Contrato/Factura", false);
                        end;
                    }

                    action("Split &Planning Lines")
                    {
                        ApplicationArea = All;
                        Caption = 'Insertar &Linea planificación';
                        Ellipsis = true;
                        Image = Splitlines;
                        // Promoted = true;
                        // PromotedCategory = Process;
                        ToolTip = 'Split planning lines of type Budget and Billable into two separate planning lines: Budget and Billable.';

                        trigger OnAction()
                        var
                            Job: Record Job;
                            JobTask: Record "Job Task";
                        begin
                            Rec.TestField("Job No.");
                            Job.Get(Rec."Job No.");
                            if Job.Blocked = Job.Blocked::All then
                                Job.TestBlocked;

                            Rec.TestField("Job Task No.");
                            JobTask.SetRange("Job No.", Job."No.");
                            JobTask.SetRange("Job Task No.", Rec."Job Task No.");

                            REPORT.RunModal(REPORT::"Job Split Planning Line", true, false, JobTask);
                        end;
                    }
                    action("Change &Dates")
                    {
                        ApplicationArea = All;
                        Caption = 'Canbiar &Fechas';
                        Ellipsis = true;
                        Image = ChangeDate;
                        ToolTip = 'Use a batch job to help you move planning lines on a job from one date interval to another.';

                        trigger OnAction()
                        var
                            Job: Record Job;
                            JobTask: Record "Job Task";
                        begin
                            Rec.TestField("Job No.");
                            Job.Get(Rec."Job No.");
                            if Job.Blocked = Job.Blocked::All then
                                Job.TestBlocked;

                            JobTask.SetRange("Job No.", Job."No.");
                            if Rec."Job Task No." <> '' then
                                JobTask.SetRange("Job Task No.", Rec."Job Task No.");

                            REPORT.RunModal(REPORT::"Change Job Dates", true, false, JobTask);
                        end;
                    }
                    action("<Action7>")
                    {
                        ApplicationArea = All;
                        Caption = 'I&ndentar Tareas';
                        Image = Indent;
                        RunObject = Codeunit "Job Task-Indent";
                        ToolTip = 'Move the selected lines in one position to show that the tasks are subcategories of other tasks. Job tasks that are totaled are the ones that lie between one pair of corresponding Begin-Total and End-Total job tasks.';
                    }

                    group("<Action13>")
                    {
                        Caption = 'W&IP';
                        Image = WIP;
                        action("<Action48>")
                        {
                            ApplicationArea = All;
                            Caption = '&Calcular WIP';
                            Ellipsis = true;
                            Image = CalculateWIP;
                            ToolTip = 'Run the Job Calculate WIP batch job.';

                            trigger OnAction()
                            var
                                Job: Record Job;
                            begin
                                Rec.TestField("Job No.");
                                Job.Get(Rec."Job No.");
                                Job.SetRange("No.", Job."No.");
                                REPORT.RunModal(REPORT::"Job Calculate WIP", true, false, Job);
                            end;
                        }
                        action("<Action49>")
                        {
                            ApplicationArea = All;
                            Caption = '&Registrar WIP en Contabilidad';
                            Ellipsis = true;
                            Image = PostOrder;
                            ShortCutKey = 'F9';
                            ToolTip = 'Run the Job Post WIP to G/L batch job.';

                            trigger OnAction()
                            var
                                Job: Record Job;
                            begin
                                Rec.TestField("Job No.");
                                Job.Get(Rec."Job No.");
                                Job.SetRange("No.", Job."No.");
                                REPORT.RunModal(REPORT::"Job Post WIP to G/L", true, false, Job);
                            end;
                        }
                    }
                }
            }
        }
    }
    var
        Proyecto: Record Job;
        rLinP: Record "Job Planning Line";
        NoProyActual: Code[20];
        NoProyActualDeshabil: Boolean;
        GestRes: Codeunit "Gestion Reservas";
        Plazos: Page "Plazos recursos reservados";
        rRec: Record Resource;
        rLin2: Record "Job Planning Line";
        rConf: Record "Jobs Setup";
        fTarifas: Page "Gestion tarifas de publicidad";
        Compra: Boolean;
        Linea: Integer;
        ventana: Dialog;
        Text001: Label 'Debe introducir a menos un filtro de fecha para acceder a la consulta';
        Color: Text;
        Text002: Label 'Filtrando líneas proyecto #1########';
        MaterialVisibele: Boolean;

    trigger OnOpenPage()
    var
        JobsSetup: Record "Jobs Setup";
    begin
        JobsSetup.Get();
        MaterialVisibele := JobsSetup."Nuevo sistema producción";
    end;

    trigger OnAfterGetRecord()
    var
        rJobPl: Record "Job Planning Line";
        Res: Record Resource;
        ListaEspera: Record "Incidencias Rescursos";
    begin

        rJobPl.SETRANGE(rJobPl."Job No.", Rec."Job No.");
        rJobPl.SETRANGE(rJobPl."Origin Line No.", Rec."Line No.");
        rJobPl.SETRANGE(rJobPl."Job Task No.", Rec."Job Task No.");
        rJobPl.SETRANGE(rJobPl."Crear pedidos", rJobPl."Crear pedidos"::"De Compra");
        StyleIsStrong := rJobPl.FINDFIRST();
        if StyleIsStrong then
            Color := 'Strong'
        else
            Color := 'Standard';
        if Rec.Type = Rec.Type::Resource THEN BEGIN
            if not Res.GET(Rec."No.") Then Rec.Init();
            if Res."Recurso Agrupado" THEN
                Color := 'Unfavorable'
            ELSE
                if Res."Producción" then Color := 'Favorable';

        END;
        Proyecto.Get(Rec."Job No.");
        ListaEspera.SetRange("Nº Recurso", Rec."No.");
        ListaEspera.SetRange(Motivo, ListaEspera.Motivo::"Lista de espera");
        if ListaEspera.FindSet then Color := 'StandardAccent';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //añade las fechas de inicio y fin del proyecto
        if Proyecto."No." <> '' Then Begin
            Rec."Planning Date" := Proyecto."Starting Date";
            Rec."Fecha Final" := Proyecto."Ending Date";
        End;

    end;
    /// <summary>
    /// ShowDimensions.
    /// </summary>
    /// <returns>Return variable IsChanged of type Boolean.</returns>

    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
        DimMgt: Codeunit DimensionManagement;
    begin
        IsHandled := false;
        // OnBeforeShowDimensions(Rec, xRec, IsHandled);
        // if IsHandled then
        //     exit;

        OldDimSetID := Rec."Dimension Set ID";
        Rec."Dimension Set ID" :=
          DimMgt.EditDimensionSet(Rec."Dimension Set ID", StrSubstNo('%1 %2 %3', Rec."Job No.", Rec."No.", Rec."Line No."));
        //VerifyItemLineDim();
        DimMgt.UpdateGlobalDimFromDimSetID(Rec."Dimension Set ID", Rec."Shortcut Dimension 1 Code", Rec."Shortcut Dimension 2 Code");
        //ATOLink.UpdateAsmDimFromSalesLine(Rec);
        IsChanged := OldDimSetID <> Rec."Dimension Set ID";

        //OnAfterShowDimensions(Rec, xRec);
    end;

    /// <summary>
    /// Nzona.
    /// </summary>
    /// <param name="Dim">Code[20].</param>
    /// <returns>Return value of type Text.</returns>
    procedure Nzona(Dim: Code[20]): Text
    var
        GlSeetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
    begin
        GlSeetup.Get();
        if DimVal.Get(GlSeetup."Shortcut Dimension 5 Code", Dim) then
            exit(DimVal.Name);
        exit('');
    end;

    var

        DescriptionIndent: Integer;

        StyleIsStrong: Boolean;

    LOCAL PROCEDURE SelecNoProyActual();
    BEGIN
        //   SETRANGE("Nº proyecto",NoProyActual);
        //   CurrPage.UPDATE(FALSE);
        //    
    END;

    PROCEDURE LlamaTexto(Linea: Integer);
    BEGIN
        Rec.FiltroTexto(Linea);
    END;

    PROCEDURE CreaReservas();
    VAR
        rLinpd: Record 1003;
        RecursoAgrupado: Code[20];
        ResourceAgr: Record Resource;
        Resource: Record Resource;
        linea: Integer;
        Job: Record Job;
        Total: Integer;
        ACrear: Integer;
        Reservas: Record Reserva;
        LineasRecursoAgrupado: Record "Job Planning Line";
        LineaAgrupado: Integer;
        i: Integer;
    BEGIN
        if NOT CONFIRM('Crear Reservas?') THEN EXIT;
        Job.Get(Rec."Job No.");
        If Not Resource.Get(Rec."No.") then Resource.Init();
        LineasRecursoAgrupado.SetRange("Job No.", Rec."Job No.");
        If LineasRecursoAgrupado.FindSet() then
            repeat
                If Resource.Get(LineasRecursoAgrupado."No.") then begin
                    If Resource."Recurso Agrupado" then begin
                        If LineasRecursoAgrupado."Recurso Agrupado" = false then begin
                            LineaAgrupado := LineasRecursoAgrupado."Line No.";
                            LineasRecursoAgrupado."Recurso Agrupado" := true;
                            LineasRecursoAgrupado.Modify();
                        end;
                    end;
                end;
            Until LineasRecursoAgrupado.Next() = 0;
        Commit();
        LineasRecursoAgrupado.SetRange("Recurso Agrupado", true);

        if LineasRecursoAgrupado.FindSet() then
            repeat
                If ResourceAgr.Get(LineasRecursoAgrupado."No.") then
                    If ResourceAgr."Tipo Recurso" = Resource."Tipo Recurso" then begin
                        RecursoAgrupado := LineasRecursoAgrupado."No.";
                        LineaAgrupado := LineasRecursoAgrupado."Line No.";
                        i += 1;
                    end;

            until LineasRecursoAgrupado.Next() = 0;
        if i > 1 then RecursoAgrupado := '';
        if i > 1 then LineaAgrupado := 0;
        ComprobarRegursosAgrupados(RecursoAgrupado, linea, Rec."Job No.");
        COMMIT;
        CurrPage.SETSELECTIONFILTER(rLinP);
        rLinP.SetFilter("Cdad. a Reservar", '<>%1', 0);
        if not rLinP.FindSet() then
            ERROR('No hay nada que reservar');
        rLinP.SetRange("Cdad. a Reservar");
        if rLinP.FindSet() THEN
            REPEAT
                if (RecursoAgrupado <> '') AND (rLinP."Unit Price (LCY)" <> 0) THEN
                    if Job."Proyecto Mixto" = False Then
                        ERROR('No se pueden crear circuitos con Recursos con precio a no ser que se trate de un proyecto mixto');
                if (rLinP."Cdad. a Reservar" <> 0) THEN BEGIN
                    GestRes."Crear Reserva"(rLinP, RecursoAgrupado, linea, true, LineaAgrupado);
                END;
                rLinpd.SETRANGE(rLinpd."Job No.", rLinP."Job No.");
                rLinpd.SETRANGE(rLinpd."Origin Line No.", rLinP."Line No.");
                if rLinpd.FIND('-') THEN
                    REPEAT
                        if (rLinpd."Cdad. a Reservar" <> 0) THEN BEGIN
                            GestRes."Crear Reserva"(rLinpd, RecursoAgrupado, linea, true, LineaAgrupado);
                        END;
                    UNTIL rLinpd.NEXT = 0;
            UNTIL rLinP.NEXT = 0;
        // rLin2.INIT;
        // rLin2.SETRANGE("Job No.", Rec."Job No.");

        // rLin2.CALCSUMS("Cdad. a Reservar", "Cdad. Reservada");
        ACrear := 0;
        Total := 0;
        if ACrear = 0 then begin
            rLin2.Reset();
            rLin2.SETRANGE("Job No.", Rec."Job No.");
            if rLin2.findfirst() then
                repeat
                    ACrear += rLin2."Cdad. a Reservar" + rLin2."Cdad. Reservada";
                    Total += rLin2."Cdad. Reservada";
                until rLin2.next() = 0;

        end;
        if rec.Type = Rec.Type::Familia Then begin
            Reservas.SetRange("Nº Proyecto", Rec."Job No.");
            Total := Reservas.Count;
        end;

        MESSAGE('Creadas #1######## reservas de un total de #2########\' +
                'para todo el proyecto.',
                Total, ACrear);
    END;

    PROCEDURE CreaReservasFijacion(LineaAgrupado: Integer);
    VAR
        rLinpd: Record 1003;
        Recurso: Code[20];
        linea: Integer;
        Job: Record Job;
        Total: Integer;
        ACrear: Integer;
    BEGIN
        if NOT CONFIRM('Crear Reservas?') THEN EXIT;

        COMMIT;
        Job.Get(Rec."Job No.");

        rLinP.SETRANGE("Job No.", Rec."Job No.");
        rLinP.SetFilter("Cdad. a Reservar", '<>%1', 0);
        if not rLinP.FindSet() then
            ERROR('No hay nada que reservar');
        rLinP.SetRange("Cdad. a Reservar");
        if rLinP.FIND('-') THEN
            REPEAT

                rLinpd.SETRANGE(rLinpd."Job No.", rLinP."Job No.");
                rLinpd.SETRANGE(rLinpd."Origin Line No.", rLinP."Line No.");
                if rLinpd.FIND('-') THEN
                    REPEAT
                        if (rLinpd."Cdad. a Reservar" <> 0) THEN BEGIN
                            GestRes."Crear Reserva"(rLinpd, '', linea, true, LineaAgrupado);
                        END;
                    UNTIL rLinpd.NEXT = 0;
            UNTIL rLinP.NEXT = 0;

        ACrear := 0;
        Total := 0;
        if ACrear = 0 then begin
            rLin2.Reset();
            rLin2.SETRANGE("Job No.", Rec."Job No.");
            if rLin2.findfirst() then
                repeat
                    ACrear += rLin2."Cdad. Reservada";
                    Total += rLin2."Cdad. Reservada" + rLin2."Cdad. a Reservar";
                until rLin2.next() = 0;
            Total := ACrear;
        end;

        MESSAGE('Creadas #1######## reservas de un total de #2########\' +
                'para todo el proyecto.',
                Total, ACrear);
    END;

    PROCEDURE VerReservas();
    VAR
        rReserva: Record "Reserva";
    BEGIN
        rReserva.SETCURRENTKEY("Nº Proyecto", "Cód. fase", "Cód. subfase", "Cód. tarea",
                               "Tipo (presupuesto)", "Nº (presupuesto)");
        rReserva.SETRANGE("Nº Proyecto", Rec."Job No.");
        //   { $001
        //   rReserva.SETRANGE("Cód. fase","Phase Code");
        //   rReserva.SETRANGE("Cód. subfase","Task Code");
        //   rReserva.SETRANGE("Cód. tarea","Step Code");
        //   }
        rReserva.SETRANGE("Cód. tarea", Rec."Job Task No.");
        // $003
        rReserva.SETRANGE("Nº linea proyecto", Rec."Line No.");
        if (Rec.Type = Rec.Type::Resource) THEN BEGIN
            rReserva.SETRANGE("Tipo (presupuesto)", Rec.Type.AsInteger());
            rReserva.SETRANGE("Nº (presupuesto)", Rec."No.");
        END;
        Page.RUNMODAL(Page::"Tabla Reservas", rReserva);
    END;

    PROCEDURE LlamarPlazos();
    BEGIN
        CLEAR(Plazos);
        if (Rec.Type = Rec.Type::Resource) THEN BEGIN
            rRec.GET(Rec."No.");
            Plazos.Coge_Recurso(rRec);
        END;
        Plazos.RUNMODAL;
    END;

    PROCEDURE OrdenesPubli();
    VAR
        rOrden: Record "Cab. orden publicidad";
        rProyecto: Record 167;
        rProv: Record Vendor;
        rLinCont: Record 37;
    BEGIN
        // $002
        Rec.TESTFIELD("Compra a-Nº proveedor");
        rProv.GET(Rec."Compra a-Nº proveedor");
        rOrden.RESET;
        rOrden.SETCURRENTKEY("Nº proyecto", "Nº tarea proyecto", "Nº linea");
        rOrden.SETRANGE("Tipo orden", rProv.Medio.AsInteger());
        rOrden.SETRANGE("Nº proyecto", Rec."Job No.");
        rOrden.SETRANGE("Nº tarea proyecto", Rec."Job Task No.");
        rOrden.SETRANGE("Nº linea", Rec."Line No.");
        if NOT rOrden.FINDSET THEN BEGIN
            CLEAR(rOrden);
            case rProv.Medio of
                rProv.Medio::Audiovisuales:
                    rOrden."Tipo orden" := rOrden."Tipo orden"::Audiovisuales;
                rProv.Medio::Prensa:
                    rOrden."Tipo orden" := rOrden."Tipo orden"::Prensa;
                rProv.Medio::Radio:
                    rOrden."Tipo orden" := rOrden."Tipo orden"::Radio;
                rProv.Medio::Otros:
                    rOrden."Tipo orden" := rOrden."Tipo orden"::Otros;
            end;
            rOrden."Nº proyecto" := Rec."Job No.";
            rOrden."Nº tarea proyecto" := Rec."Job Task No.";
            rOrden."Nº linea" := Rec."Line No.";
            rOrden.INSERT(TRUE);
            if rProyecto.GET(Rec."Job No.") THEN BEGIN
                rProyecto.TESTFIELD("Bill-to Customer No.");
                rOrden.VALIDATE("No cliente", rProyecto."Bill-to Customer No.");
                rOrden.VALIDATE("Cod vendedor", rProyecto."Cód. vendedor");
                rOrden.VALIDATE(Descripcion, rProyecto.Description);
            END;
            Rec.TESTFIELD("Compra a-Nº proveedor");
            rOrden.VALIDATE("Cod. Soporte", Rec."Compra a-Nº proveedor");
            Rec.TESTFIELD(Type, Rec.Type::Resource);
            Rec.TESTFIELD("No.");
            rOrden.VALIDATE(Concepto, Rec."No.");
            rOrden.MODIFY(TRUE);
            rOrden.ActualizarLineas(TRUE);
            COMMIT;
        END;

        //$006(I)
        if rProyecto.GET(Rec."Job No.") THEN BEGIN
            if rProyecto.Status = rProyecto.Status::Open THEN BEGIN
                rLinCont.RESET;
                rLinCont.SETCURRENTKEY("Document Type", "Document No.", "Job No.", "Job Task No.");
                rLinCont.SETRANGE("Document Type", rLinCont."Document Type"::Order);
                rLinCont.SETRANGE("Job No.", Rec."Job No.");
                rLinCont.SETRANGE("Job Task No.", Rec."Job Task No.");
                rLinCont.SETRANGE("No linea proyecto", Rec."Line No.");
                if rLinCont.FINDFIRST THEN BEGIN
                    if rLinCont."No. Orden Publicidad" = '' THEN BEGIN
                        rLinCont.VALIDATE("No. Orden Publicidad", rOrden.No);
                        rLinCont.MODIFY;
                        COMMIT;
                    END;
                END;
            END;
        END;
        //$006(F)

        Page.RUNMODAL(Page::"Orden de publicidad", rOrden);

        CurrPage.UPDATE;
    END;

    PROCEDURE VerTarifas();
    BEGIN
        CLEAR(fTarifas);
        fTarifas.PasaParam(Rec."Compra a-Nº proveedor");
        fTarifas.RUNMODAL;
    END;

    PROCEDURE FiltrosLinea(FiltroFecIniD: Text[30]; FiltroFecIniH: Text[30]; FiltroTipo: Text[30]; FiltroSop: Text[30]; FiltroFipa: Text[30]; FiltroSubtipo: Text[30]; FiltroFecFinD: Text[30]; FiltroFecFinH: Text[30]);
    VAR
        rLinProy: Record 1003;
        rJob: Record 167;
        rTemporal: Record "Temp Job";
        fLinProy: Page "Proyectos filtrados por linea";
        wAnterior: Code[20];
        FiltroFec: Date;
        FiltroFec2: Date;
        indice: Integer;
    BEGIN
        //$005

        rLinProy.RESET;

        if (FiltroFecIniD = '') AND (FiltroFecFinD = '') AND (FiltroFecIniH = '') AND (FiltroFecFinH = '') THEN
            ERROR(Text001);

        if FiltroFecIniD <> '' THEN BEGIN
            EVALUATE(FiltroFec, FiltroFecIniD);
            EVALUATE(FiltroFec2, FiltroFecIniH);
            rLinProy.SETFILTER("Planning Date", '%1..%2', FiltroFec, FiltroFec2);
        END;

        if FiltroFecFinD <> '' THEN BEGIN
            EVALUATE(FiltroFec, FiltroFecFinD);
            EVALUATE(FiltroFec2, FiltroFecFinH);
            rLinProy.SETFILTER("Fecha Final", '%1..%2', FiltroFec, FiltroFec2);
        END;

        if FiltroTipo = 'Por Campaña' THEN
            rLinProy.SETRANGE(Tipo, 0);
        if FiltroTipo = 'Por Temporada' THEN
            rLinProy.SETRANGE(Tipo, 1);
        if FiltroTipo = 'Anual' THEN
            rLinProy.SETRANGE(Tipo, 2);
        if FiltroTipo = 'Otros' THEN
            rLinProy.SETRANGE(Tipo, 3);

        ///if FiltroSop = '' THEN
        ///  rLinProy.SETRANGE("Soporte de",0);
        if FiltroSop = 'Fijación' THEN
            rLinProy.SETRANGE("Soporte de", 1);
        if FiltroSop = 'Vinilo' THEN
            rLinProy.SETRANGE("Soporte de", 2);
        if FiltroSop = 'Pintura' THEN
            rLinProy.SETRANGE("Soporte de", 3);
        if FiltroSop = 'Lona' THEN
            rLinProy.SETRANGE("Soporte de", 4);

        ///if FiltroFipa = '' THEN
        ///  rLinProy.SETRANGE("Fija/Papel",0);
        if FiltroFipa = 'Fija' THEN
            rLinProy.SETRANGE("Fija/Papel", 1);
        if FiltroFipa = 'Papel' THEN
            rLinProy.SETRANGE("Fija/Papel", 2);

        ///if FiltroSubtipo = '' THEN
        ///  rLinProy.SETRANGE(Subtipo,0);
        if FiltroSubtipo = 'Vallas' THEN
            rLinProy.SETRANGE(Subtipo, 1);
        if FiltroSubtipo = 'Opis' THEN
            rLinProy.SETRANGE(Subtipo, 2);
        if FiltroSubtipo = 'Combinado' THEN
            rLinProy.SETRANGE(Subtipo, 3);

        rTemporal.DELETEALL;

        if rLinProy.FINDSET THEN BEGIN
            ventana.OPEN(Text002);
            indice := 0;
            CLEAR(wAnterior);
            REPEAT
                indice := indice + 1;
                ventana.UPDATE(1, indice);
                if rLinProy."Job No." <> wAnterior THEN BEGIN
                    wAnterior := rLinProy."Job No.";
                    if rJob.GET(rLinProy."Job No.") THEN BEGIN
                        rTemporal.INIT;
                        rTemporal.TRANSFERFIELDS(rJob);
                        rTemporal.INSERT;
                    END;
                END;
            UNTIL rLinProy.NEXT = 0;
            ventana.CLOSE;
        END;

        COMMIT;
        fLinProy.SETTABLEVIEW(rTemporal);
        fLinProy.RUNMODAL;
    END;

    PROCEDURE FiltroCompra(Lin: Integer);
    BEGIN
        Compra := TRUE;
        Linea := Lin;
    END;

    PROCEDURE ComprobarRegursosAgrupados(VAR RecursoAgrupado: Code[20]; VAR Linea: Integer; JobNo: Code[20])
    VAR
        rLinProy: Record 1003;
        rLinProy2: Record 1003;
        Cuenta: Integer;
        Job: Record Job;
        Tipo: Code[20];
        Res: Record Resource;
        Wizard: Page "Wizard Reservas";
    BEGIN
        Wizard.Carga(JobNo, Linea, RecursoAgrupado);
        Wizard.RUNMODAL;
        RecursoAgrupado := Wizard.RRecurso();
        Linea := Wizard.LLinea();
        // Recurso := '';
        // Linea := 0;
        // rLinProy.SETRANGE("Job No.", JobNo);
        // rLinProy.SETRANGE(rLinProy."Recurso Agrupado", TRUE);
        // if job."Proyecto Mixto" = false Then begin
        //     rLinProy2.SETRANGE("Job No.", JobNo);
        //     rLinProy2.SETRANGE("Line No.", Linea);
        //     if rLinProy2.FindFirst() Then begin
        //         if Res.Get(rLinProy2."No.") then Tipo := Res."Tipo Recurso";
        //     end;
        // end;
        // Cuenta := rLinProy.COUNT;
        // if Cuenta = 0 THEN EXIT;
        // if Cuenta = 1 THEN BEGIN
        //     rLinProy.FINDFIRST;
        //     Recurso := rLinProy."No.";
        //     Linea := rLinProy."Line No.";


        //     EXIT;
        // END;
        // MESSAGE('Elija el Circuito');
        // if Page.RUNMODAL(0, rLinProy) = ACTION::LookupOK THEN BEGIN
        //     Recurso := rLinProy."No.";
        //     Linea := rLinProy."Line No.";

        //     EXIT;

        // END else begin
        //     Job.Get(JobNo);
        //     if job."Proyecto Mixto" = false Then
        //         error('No ha elegido circuito');
        // end;

    END;


    Procedure CambiaEmpresa(Emp: Text[30])
    Begin
        Rec.CHANGECOMPANY(Emp);
    End;


}
