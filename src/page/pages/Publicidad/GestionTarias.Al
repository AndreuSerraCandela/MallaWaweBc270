/// <summary>
/// Page Gestion tarifas de publicidad (ID 50092).
/// </summary>
page 50092 "Gestion tarifas de publicidad"
{
    Caption = 'Gestión Tarifas';
    SaveValues = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    LinksAllowed = false;
    SourceTable = Resource;
    PageType = ListPlus;
    UsageCategory = Tasks;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            Group("Opciones matriz")
            {
                field(Soporte; wFiltroMedio)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    BEGIN
                        SetColumns(SetWanted::Initial);
                        UpdateMatrixSubPage;
                    END;
                }

                field(Periodo; wPeriodo)
                {
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    BEGIN

                        rTarifas.RESET;
                        rTarifas.FILTERGROUP(4);
                        rTarifas.SETRANGE(rTarifas."Cod. Soporte", wFiltroMedio);
                        rTarifas.FILTERGROUP(2);

                        CLEAR(fTarifas);
                        fTarifas.EDITABLE := FALSE;
                        fTarifas.LOOKUPMODE := TRUE;
                        fTarifas.SETTABLEVIEW(rTarifas);
                        if fTarifas.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            fTarifas.GETRECORD(rTarifas);
                            wPeriodo := rTarifas.Periodo;
                        END;
                    END;

                    trigger OnValidate()
                    BEGIN
                        SetColumns(SetWanted::Initial);
                        UpdateMatrixSubPage;
                    END;

                }
                field(Recargo; wRecargo)
                {
                    ApplicationArea = all;
                    TableRelation = "Recargo publicidad"."Cod. Recargo";
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rRecargos.RESET;
                        rRecargos.FILTERGROUP(4);
                        rRecargos.SETRANGE(rRecargos."Cod. Soporte", wFiltroMedio);
                        rRecargos.SETRANGE(rRecargos.Periodo, wPeriodo);
                        //  rRecargos.SETRANGE(rRecargos.Seccion, wSeccion);
                        rRecargos.FILTERGROUP(2);
                        CLEAR(fRecargos);
                        fRecargos.EDITABLE := FALSE;
                        fRecargos.LOOKUPMODE := TRUE;
                        fRecargos.SETTABLEVIEW(rRecargos);
                        if fRecargos.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            fRecargos.GETRECORD(rRecargos);
                            wRecargo := rRecargos."Cod. Recargo";
                            wPorRecargo := rRecargos.Recargo;
                        END;
                        SetColumns(SetWanted::Initial);
                        UpdateMatrixSubPage;
                    END;

                    trigger OnValidate()
                    BEGIN
                        CLEAR(wPorRecargo);
                        if rRecargos.GET(wFiltroMedio, wPeriodo, wRecargo) THEN
                            wPorRecargo := rRecargos.Recargo;
                        SetColumns(SetWanted::Initial);
                        UpdateMatrixSubPage;
                    END;
                }

                field(Sección; wSeccion)
                {
                    Visible = SecCionVisible;
                    ApplicationArea = ALL;
                    TableRelation = "Seccion publicidad";
                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        CLEAR(fSecciones);
                        fSecciones.EDITABLE := FALSE;
                        fSecciones.LOOKUPMODE := TRUE;
                        if fSecciones.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            fSecciones.GETRECORD(rSecciones);
                            wSeccion := rSecciones."Cód. seccion";
                            if NOT rTarifas.GET(wFiltroMedio, wPeriodo, wSeccion) THEN
                                CrearTarifaAuto
                            ELSE
                                wDescripcion := rTarifas.Descripcion;

                            SetColumns(SetWanted::Initial);
                            UpdateMatrixSubPage;

                        END
                    END;

                    trigger OnValidate()
                    BEGIN

                        if wSeccion <> '' THEN BEGIN
                            if NOT rTarifas.GET(wFiltroMedio, wPeriodo, wSeccion) THEN
                                CrearTarifaAuto
                            ELSE
                                wDescripcion := rTarifas.Descripcion;

                        END;

                        SetColumns(SetWanted::Initial);
                        UpdateMatrixSubPage;
                    END;
                }

                field(Descripción; wDescripcion)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    BEGIN

                        if rTarifas.GET(wFiltroMedio, wPeriodo, wSeccion) THEN BEGIN
                            rTarifas.Descripcion := wDescripcion;
                            rTarifas.MODIFY;
                        END;
                    END;

                }
                field("% Recargo"; wPorRecargo)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    BEGIN

                        if rTarifas.GET(wFiltroMedio, wPeriodo, wSeccion) THEN BEGIN
                            rTarifas.Descripcion := wDescripcion;
                            rTarifas.MODIFY;
                        END;
                    END;

                }
                field("Nombre médio"; TraeNombreMedio)
                {
                    ApplicationArea = all;


                }
                field(SoloSiTieneDatos; SoloSiDatos)
                {
                    Caption = 'Solo si tiene tarifas';
                    ApplicationArea = ALL;
                    trigger OnValidate()
                    BEGIN
                        Rec.FILTERGROUP(2);
                        Rec.SETRANGE("Filtro Proveedor", wFiltroMedio);
                        Rec.SETRANGE("Filtro Seccion", wSeccion);
                        Rec.CALCFIELDS("Tiene Tarifas");
                        if SoloSiDatos THEN
                            Rec.SETRANGE("Tiene Tarifas", TRUE)
                        ELSE
                            Rec.SETRANGE("Tiene Tarifas");
                        Rec.FILTERGROUP(0);
                        CurrPage.UPDATE(TRUE);
                    END;
                }

            }
            Part(Matrix; "Gestion tarifas de matrix")
            {
                ApplicationArea = all;
            }

        }
    }

    actions

    {
        area(Navigation)
        {
            action("Previous Set")
            {
                ApplicationArea = ALL;
                Caption = 'Conjunto anterior';
                ToolTip = 'Permite desplazarse al conjunto de datos anterior.';
                Promoted = true;
                PromotedIsBig = true;
                Image = PreviousSet;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    SetColumns(SetWanted::Previous);
                    UpdateMatrixSubPage;
                END;
            }
            action("Previous Column")
            {
                Caption = 'Columna anterior';
                ToolTip = 'Permite desplazarse a la columna anterior.';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                Image = PreviousRecord;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    SetColumns(SetWanted::PreviousColumn);
                    UpdateMatrixSubPage;
                END;
            }
            action("Next Column")
            {
                Caption = 'Columna siguiente';
                ToolTip = 'Permite desplazarse a la columna siguiente.';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                Image = NextRecord;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    SetColumns(SetWanted::NextColumn);
                    UpdateMatrixSubPage;
                END;
            }
            action("Next Set")
            {
                Caption = 'Conjunto siguiente';
                ToolTip = 'Permite desplazarse al conjunto de datos siguiente.';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                Image = NextSet;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    SetColumns(SetWanted::Next);
                    UpdateMatrixSubPage;
                END;
            }
        }
        area(Processing)
        {
            action(Lista)
            {
                ApplicationArea = all;
                Image = List;
                ShortCutKey = F5;
                trigger OnAction()
                BEGIN

                    rTarifas.RESET;
                    rTarifas.FILTERGROUP(4);
                    rTarifas.SETRANGE(rTarifas."Cod. Soporte", wFiltroMedio);
                    rTarifas.FILTERGROUP(2);

                    CLEAR(fTarifas);
                    fTarifas.EDITABLE := FALSE;
                    fTarifas.LOOKUPMODE := TRUE;
                    fTarifas.SETTABLEVIEW(rTarifas);
                    if fTarifas.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        wFiltroMedio := rTarifas."Cod. Soporte";
                        wPeriodo := rTarifas.Periodo;
                        wSeccion := rTarifas.Seccion;
                        wDescripcion := rTarifas.Descripcion;
                    END;
                END;
            }
            action(Dias)
            {
                ApplicationArea = all;
                Image = PaymentDays;
                Caption = 'Dias';
                trigger OnAction()
                BEGIN

                    if rMedios.GET(wFiltroMedio) THEN BEGIN
                        if rMedios.Medio = rMedios.Medio::Prensa THEN
                            if wSeccion = '' THEN
                                ERROR(Err04);

                        rDias.RESET;
                        rDias.FILTERGROUP(4);
                        rDias.SETRANGE(rDias."Cod. Soporte", wFiltroMedio);
                        rDias.SETRANGE(rDias.Seccion, wSeccion);   //grc160505
                        rDias.FILTERGROUP(2);
                        CLEAR(fDias);
                        fDias.SETTABLEVIEW(rDias);
                        fDias.RUNMODAL;

                        CurrPage.UPDATE(FALSE);
                    END;
                END;
            }
            action(Recargos)
            {
                ApplicationArea = all;
                Image = Costs;
                Caption = 'Recargos';
                trigger OnAction()
                BEGIN

                    rRecargos.RESET;
                    rRecargos.FILTERGROUP(4);
                    rRecargos.SETRANGE(rRecargos."Cod. Soporte", wFiltroMedio);
                    rRecargos.SETRANGE(rRecargos.Periodo, wPeriodo);
                    //  rRecargos.SETRANGE(rRecargos.Seccion, wSeccion);
                    rRecargos.FILTERGROUP(2);
                    CLEAR(fRecargos);
                    fRecargos.SETTABLEVIEW(rRecargos);
                    fRecargos.RUNMODAL;
                END;
            }
            action(Secciones)
            {
                ApplicationArea = all;
                Image = ListPage;
                RunObject = Page "Secciones Publicidad";
            }
            action(Conceptos)
            {
                ApplicationArea = all;
                Image = Description;
                RunObject = Page 76;
            }
            action(Eliminar)
            {
                ApplicationArea = all;
                Image = Delete;
                trigger OnAction()
                BEGIN

                    if CONFIRM(txt04, FALSE) THEN
                        BorrarTarifa;
                END;
            }
            // action("Copiar Tarifa")
            // {
            //     ApplicationArea = all;
            //     Image = Copy;
            //     Caption = 'Copiar tarifa';
            //     trigger OnAction()
            //     BEGIN

            //         //$001
            //         CopiarTarifa;
            //         //$001
            //     END;
            // }


        }
    }

    VAR
        SeccionVisible: Boolean;
        MATRIX_CellData: array[32] of Text;
        MatrixRecords: ARRAY[32] OF Record "Dias tarifa publicidad";
        MATRIX_NoOfMatrixColumns: Integer;
        MATRIX_ColumnCaption: ARRAY[32] of Text[1024];
        MATRIX_CurrentColumnOrdinal: Integer;
        ColumnSet: Text[1024];
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        CurrSetLength: Integer;
        rMedios: Record Vendor;
        rTarifas: Record "Tarifas publicidad";
        rLinTarifas: Record "Price List Line";
        rRecargos: Record "Recargo publicidad";
        rDias: Record "Dias tarifa publicidad";
        rSecciones: Record "Seccion publicidad";
        rConfig: Record 315;
        fRecargos: Page "Recargos Publicidad";
        fDias: Page "Dias Tarifa publicidad";
        fTarifas: Page "Tarifas publicidad";
        fSecciones: Page "Secciones Publicidad";
        wFiltroMedio: Code[20];
        wPeriodo: Integer;
        wSeccion: Code[20];
        wDescripcion: Text[90];
        wRecargo: Code[20];
        wPorRecargo: Decimal;
        wPrecio: Text[30];
        txt01: Label 'Tarifas para el';
        txt02: Label 'de la sección';
        txt03: Label 'de';
        txt04: Label 'Desea realmente borrar la tarifa? Se perderán todos los importes relacionados con élla.';
        Err01: Label 'Debe indicar el periodo antes de poder introducir tarifas.';
        wPrecioNum: Decimal;
        Err02: Label 'Debe indicar periodo y  sección antes de poder introducir tarifas.';
        Err03: Label 'Debe configurar los días de la tarifa.';
        Err04: Label 'Debe seleccionar primero una sección.';
        codProveedor: Code[20];
        SoloSiDatos: Boolean;

    trigger OnOpenPage()
    BEGIN

        wPeriodo := DATE2DMY(WORKDATE, 3);

        rTarifas.RESET;
        rTarifas.SETRANGE(rTarifas."Cod. Soporte", wFiltroMedio);
        rTarifas.SETRANGE(rTarifas.Periodo, wPeriodo);

        if rMedios.GET(wFiltroMedio) THEN;
        SeccionVisible := rMedios.Medio = rMedios.Medio::Prensa;
        // CurrPage.TxtSeccionVisible := rMedios.Medio = rMedios.Medio::Prensa;

        if rMedios.Medio <> rMedios.Medio::Prensa THEN BEGIN
            if NOT rTarifas.GET(wFiltroMedio, wPeriodo, '') THEN
                CrearTarifaAuto
            ELSE
                wDescripcion := rTarifas.Descripcion;
        END;

        // $001
        rConfig.GET();
        rConfig.TESTFIELD("Dpto. General");
        Rec.SETRANGE("Global Dimension 1 Code", rConfig."Dpto. General");

        SetColumns(SetWanted::Initial);
        UpdateMatrixSubPage;
    END;

    /// <summary>
    /// PasaParam.
    /// </summary>
    /// <param name="Proveedor">Code[20].</param>
    procedure PasaParam(Proveedor: Code[20])
    begin
        wFiltroMedio := Proveedor;
    end;


    PROCEDURE SetColumns(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn);
    VAR
        Calendar: Record "Dias tarifa publicidad";
        PeriodPageMgt: Codeunit PeriodPageManagement;
        Steps: Integer;
        i: Integer;
    BEGIN
        //SetWanted, 32, FALSE, PeriodType, '',
        //PKFirstRecInCurrSet, MatrixColumnCaptions, 
        //ColumnSet, CurrSetLength, MatrixRecords);

        //SetWanted; UseNameForCaption; PeriodType;DateFilter
        //RecordPosition;CaptionSet; 
        //CaptionRange;CurrSetLength;PeriodRecords)
        Calendar.SETRANGE("Cod. Soporte", wFiltroMedio);
        Clear(MATRIX_ColumnCaption);
        ColumnSet := '';
        CurrSetLength := 0;
        Clear(MatrixRecords);
        Clear(Calendar);

        if not Calendar.Find('-') then begin
            PKFirstRecInCurrSet := '';
            //Error('No hay más registros a la derecha');
        end;

        case SetWanted of
            SetWanted::Initial:
                begin
                    if Calendar.FindFirst() Then;
                end;
            SetWanted::Previous:
                begin
                    Calendar.SetPosition(PKFirstRecInCurrSet);
                    if Calendar.Find('-') then;
                end;
            SetWanted::PreviousColumn:
                begin
                    Calendar.SetPosition(PKFirstRecInCurrSet);
                    if Calendar.Find('-') then;
                end;
            SetWanted::NextColumn:
                begin
                    Calendar.SetPosition(PKFirstRecInCurrSet);
                    if Calendar.Find('+') then;
                end;
            SetWanted::Same:
                begin
                    Calendar.SetPosition(PKFirstRecInCurrSet);
                    if Calendar.Find('=') then;
                end;
            SetWanted::Next:
                begin
                    Calendar.SetPosition(PKFirstRecInCurrSet);
                    if Calendar.Find('+') then;
                end;
        end;

        PKFirstRecInCurrSet := Calendar.GetPosition;
        CurrSetLength := 0;
        repeat
            //GeneratePeriodAndCaption(CaptionSet, PeriodRecords, CurrSetLength, Calendar, UseNameForCaption, PeriodType);
            CurrSetLength += 1;
            MATRIX_ColumnCaption[CurrSetLength] := Calendar.Descripcion;
        until (CurrSetLength = 32) or (Calendar.Next() = 0);

        if CurrSetLength = 1 then
            ColumnSet := MATRIX_ColumnCaption[1]
        else
            ColumnSet := MATRIX_ColumnCaption[1] + '..' + MATRIX_ColumnCaption[CurrSetLength];

        //AdjustPeriodWithDateFilter(DateFilter, PeriodRecords[1]."Period Start",
        //PeriodRecords[CurrSetLength]."Period End");
    end;


    LOCAL PROCEDURE UpdateMatrixSubPage();
    BEGIN
        CurrPage.Matrix.PAGE.Load(MATRIX_ColumnCaption, MatrixRecords, CurrSetLength, wFiltroMedio, wSeccion, wPeriodo);
        CurrPage.UPDATE(FALSE);
    END;

    // PROCEDURE InsertarLinTarifa(pConcepto: Code[20]; pDia: Code[20]; pPrecio: Decimal);
    // BEGIN

    //     rLinTarifas.INIT;
    //     rLinTarifas."Source No." := wFiltroMedio;
    //     rLinTarifas."Starting Date" := DMY2DATE(1, 1, wPeriodo);
    //     rLinTarifas.Seccion := wSeccion;
    //     rLinTarifas.Type := rLinTarifas.Type::Resource;
    //     rLinTarifas.Code := pConcepto;
    //     rLinTarifas."Dia tarifa" := pDia;
    //     if wRecargo <> '' THEN
    //         if rRecargos.GET(wFiltroMedio, wPeriodo, wSeccion, wRecargo) THEN
    //             pPrecio := ROUND(pPrecio * 100 / (rRecargos.Recargo + 100), 0.01);
    //     rLinTarifas."Direct Unit Cost" := pPrecio;
    //     if NOT rLinTarifas.INSERT THEN
    //         rLinTarifas.MODIFY;
    // END;

    PROCEDURE CrearTarifaAuto();
    BEGIN

        if wPeriodo = 0 THEN
            ERROR(Err01);

        rTarifas.RESET;
        rTarifas."Cod. Soporte" := wFiltroMedio;
        rTarifas.Periodo := wPeriodo;
        rTarifas.Seccion := wSeccion;
        if wDescripcion <> '' THEN
            rTarifas.Descripcion := wDescripcion
        ELSE
            rTarifas.Descripcion := MontarDesc;
        rTarifas.INSERT;
    END;

    PROCEDURE MontarDesc(): Text[90];
    VAR
        wDescAuto: Text[90];
    BEGIN

        wDescAuto := txt01 + ' ' + FORMAT(wPeriodo);
        if wSeccion <> '' THEN
            wDescAuto := wDescAuto + ' ' + txt02 + ' ' + wSeccion;
        wDescAuto := wDescAuto + ' ' + txt03 + ' ' + wFiltroMedio;
    END;

    PROCEDURE BorrarTarifa();
    BEGIN

        if rTarifas.GET(wFiltroMedio, wPeriodo, wSeccion) THEN
            rTarifas.DELETE(TRUE);

        rTarifas.RESET;
        rTarifas.SETRANGE(rTarifas."Cod. Soporte", wFiltroMedio);
        rTarifas.SETRANGE(rTarifas.Periodo, DATE2DMY(WORKDATE, 3));
        if rTarifas.FIND('-') THEN BEGIN
            wFiltroMedio := rTarifas."Cod. Soporte";
            wPeriodo := rTarifas.Periodo;
            wSeccion := rTarifas.Seccion;
            wDescripcion := rTarifas.Descripcion;
            CLEAR(wRecargo);
            CLEAR(wPorRecargo);
        END
        ELSE BEGIN
            CLEAR(wSeccion);
            wPeriodo := DATE2DMY(WORKDATE, 3);
            CLEAR(wRecargo);
            CLEAR(wPorRecargo);

        END;
    END;

    PROCEDURE BorrarLinTarifa(pConcepto: Code[20]; pDia: Code[20]);
    BEGIN

        if rLinTarifas.GET(wFiltroMedio, DMY2DATE(1, 1, wPeriodo), wSeccion, pConcepto, pDia) THEN
            rLinTarifas.DELETE;
    END;

    PROCEDURE TraeNombreMedio(): Text[30];
    VAR
        recMedio: Record Vendor;
    BEGIN
        if recMedio.GET(wFiltroMedio) THEN
            EXIT(recMedio.Name);
    END;

    // PROCEDURE CopiarTarifa();
    // VAR
    //     rptCopiarTarifa: Report 80158;
    //     Text001: Label 'Debe cumplimentar Medio y Periodo.';
    //     recMedios: Record Vendor;
    //     Text002: Label 'Debe cumplimentar Sección.';
    // BEGIN
    //     //$001

    //     if (wSeccion = '') THEN BEGIN
    //         if recMedios.GET(wFiltroMedio) THEN
    //             if recMedios.Medio = recMedios.Medio::Prensa THEN
    //                 ERROR(Text002);
    //     END;

    //     if (wFiltroMedio <> '') AND (wPeriodo <> 0) THEN BEGIN
    //         CLEAR(rptCopiarTarifa);
    //         rptCopiarTarifa.PasaParams(wFiltroMedio, wPeriodo, wSeccion);
    //         rptCopiarTarifa.RUNMODAL;
    //     END ELSE
    //         ERROR(Text001);

    //     //$001
    // END;

}