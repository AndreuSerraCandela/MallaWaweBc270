/// <summary>
/// Page Gestion tarifas de matrix (ID 50093).
/// </summary>
page 50093 "Gestion tarifas de matrix"
{
    PageType = ListPart;
    SourceTable = Resource;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Nombre; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the resource.';
                }
                field("Tipo Recurso"; Rec."Tipo Recurso")
                {
                    ApplicationArea = All;
                }

                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(1)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(2)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(3)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(4)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(5)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(6)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(7)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(8)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(12)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[13];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(13)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[14];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(14)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[15];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(15)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[16];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(16)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[17];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(17)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[18];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(18)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[19];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(19)
                    end;

                    trigger OnValidate()
                    begin
                        ValidateCapacity(19);
                    end;
                }

            }
            field(Field21; MATRIX_CellData[21])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[22];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(22)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(22);
                end;
            }
            field(Field22; MATRIX_CellData[22])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[22];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(22)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(22);
                end;
            }
            field(Field23; MATRIX_CellData[23])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[23];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(23)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(23);
                end;
            }
            field(Field24; MATRIX_CellData[24])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[24];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(24)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(24);
                end;
            }
            field(Field25; MATRIX_CellData[25])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[25];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(25)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(25);
                end;
            }
            field(Field26; MATRIX_CellData[26])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[26];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(26)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(26);
                end;
            }
            field(Field27; MATRIX_CellData[27])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[27];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(27)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(27);
                end;
            }
            field(Field28; MATRIX_CellData[28])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[28];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(28)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(28);
                end;
            }
            field(Field29; MATRIX_CellData[29])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[29];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(29)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(29);
                end;
            }
            field(Field30; MATRIX_CellData[30])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[30];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(30)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(30);
                end;
            }
            field(Field31; MATRIX_CellData[31])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[31];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(31)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(31);
                end;
            }
            field(Field32; MATRIX_CellData[32])
            {
                ApplicationArea = All;
                CaptionClass = '3,' + MATRIX_ColumnCaption[32];

                trigger OnDrillDown()
                begin
                    MatrixOnDrillDown(33)
                end;

                trigger OnValidate()
                begin
                    ValidateCapacity(32);
                end;
            }
        }

    }
    actions
    {
        area(Processing)
        {
            group(Planificación)
            {
                action("Ver Ficha Reserva")
                {
                    Caption = '&Ver Reserva';
                    RunObject = Page "Tabla Reservas";
                    RunPageView = SORTING("Nº Reserva");
                    RunPageLink = "Nº Recurso" = FIELD("No.");
                    ApplicationArea = ALL;
                }
                action("Asignación recursos")
                {
                    Caption = '&Asignación recursos';
                    ApplicationArea = ALL;
                    RunObject = Page 221;
                    //RunPageLinkType =OnUpdate;
                    RunPageLink = "Resource Filter" = FIELD("No.");
                }
                action("Disponibilidad recurso")
                {
                    Caption = 'Disponibilidad recurso';
                    RunObject = Page 225;
                    ApplicationArea = ALL;
                    //RunPageLinkType =OnUpdate;
                    RunPageLink = "No." = FIELD("No."),
                                "Unit of Measure Filter" = FIELD("Base Unit of Measure"),
                                "Chargeable Filter" = FIELD("Chargeable Filter");
                }
                action("Presupuesto Proyecto")
                {
                    Caption = 'Presupuesto proyecto';
                    RunObject = Page "Job Planning Lines";
                    ApplicationArea = ALL;
                }
            }
            group(Precios)
            {
                action(Costes)
                {
                    Caption = 'Costes';
                    ApplicationArea = ALL;

                    trigger OnAction()
                    var
                        AmountType: Enum "Price Amount Type";
                        PriceType: Enum "Price Type";
                    begin
                        Rec.ShowPriceListLines(PriceType::Purchase, AmountType::Any);
                    end;
                }
                action("Precios Recurso")
                {
                    Caption = 'Precios';
                    ApplicationArea = ALL;
                    //RunPageLinkType =OnUpdate;
                    trigger OnAction()
                    var
                        AmountType: Enum "Price Amount Type";
                        PriceType: Enum "Price Type";
                    begin
                        Rec.ShowPriceListLines(PriceType::Sale, AmountType::Any);
                    end;
                }
            }
            group(Recurso)
            {
                action(Lista)
                {
                    //LookupTable;
                    ShortCutKey = F5;
                    ApplicationArea = ALL;
                    Caption = 'Lista';
                    trigger OnAction()
                    var
                        Resource: Record Resource;
                    begin
                        Resource.SetRange(Hoy, Today);
                        resource.SetRange(Bloqueado, FALSE);
                        Page.Runmodal(0, Resource);
                    end;
                }
                action(Ficha)
                {
                    //PushAction=RunObject;
                    ShortCutKey = 'Mayús+F5';
                    Caption = 'Ficha';
                    ApplicationArea = ALL;
                    RunObject = Page 76;
                    //RunPageLinkType =OnUpdate;
                    RunPageLink = "No." = FIELD("No."),
                                "Date Filter" = FIELD("Date Filter"),
                                "Base Unit of Measure" = FIELD("Base Unit of Measure"),
                                "Chargeable Filter" = FIELD("Chargeable Filter");
                }
                action(Estadísticas)
                {
                    //PushAction=RunObject;
                    ShortCutKey = F9;
                    ApplicationArea = ALL;
                    Caption = 'Estadísticas';
                    RunObject = Page 223;
                    RunPageLink = "No." = Field("No."),
                                "Date Filter" = FIELD("Date Filter"),
                                "Unit of Measure Filter" = FIELD("Base Unit of Measure"),
                                "Chargeable Filter" = FIELD("Chargeable Filter");
                }
                action(Comentarios)
                {
                    //PushAction=RunObject;
                    Caption = 'C&omentarios';
                    RunObject = Page 124;
                    ApplicationArea = ALL;
                    //RunPageLinkType =OnUpdate;
                    RunPageLink = "Table Name" = CONST(Resource),
                                "No." = Field("No.");
                }
                action(Movimientos)
                {
                    //PushAction=RunObject;
                    ShortCutKey = 'Ctrl+F5';
                    Caption = 'Movimientos';
                    RunObject = Page 202;
                    ApplicationArea = ALL;
                    //RunPageLinkType =OnUpdate;
                    RunPageView = SORTING("Resource No.", "Posting Date");
                    RunPageLink = "Resource No." = Field("No.");
                }

            }
        }
    }

    VAR
        rMedios: Record Vendor;
        rTarifas: Record "Tarifas publicidad";
        rLinTarifas: Record "Price List Line";
        rRecargos: Record "Recargo publicidad";
        rDias: Record "Dias tarifa publicidad";
        rSecciones: Record "Seccion publicidad";
        rConfig: Record "Jobs Setup";
        fRecargos: Page "Recargos publicidad";
        fDias: Page "Dias tarifa publicidad";
        fTarifas: Page "Tarifas publicidad";
        fSecciones: Page "Secciones publicidad";
        wFiltroMedio: Code[20];
        wPeriodo: Integer;
        wSeccion: Code[20];
        wDescripcion: Text[90];
        wRecargo: Code[20];
        wPorRecargo: Decimal;
        wPrecioNum: Decimal;
        codProveedor: Code[20];
        SoloSiDatos: Boolean;
        MATRIX_CellData: array[32] of Text;
        MatrixRecords: ARRAY[32] OF Record "Dias tarifa publicidad";
        MATRIX_NoOfMatrixColumns: Integer;
        MATRIX_ColumnCaption: ARRAY[32] of Text[1024];
        MATRIX_CurrentColumnOrdinal: Integer;

    trigger OnAfterGetRecord()
    var

    begin
        MATRIX_CurrentColumnOrdinal := 0;
        WHILE MATRIX_CurrentColumnOrdinal < MATRIX_NoOfMatrixColumns DO BEGIN
            MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
        END;
    end;

    /// <summary>
    /// ValidateCapacity.
    /// </summary>
    /// <param name="i">integer.</param>
    procedure ValidateCapacity(i: integer)
    begin

    end;

    /// <summary>
    /// MATRIX_OnAfterGetRecord.
    /// </summary>
    /// <param name="ColumnID">Integer.</param>
    procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin
        MATRIX_CellData[ColumnID] := Trae_Precio(Rec."No.", MatrixRecords[ColumnID].Codigo);
    end;

    LOCAL PROCEDURE AsigFiltFecha();
    BEGIN
    END;

    PROCEDURE Trae_Precio(PConcepto: Text; pDia: Text): Text[50];
    var
        wPrecioLin: Decimal;
    BEGIN
        if rTarifas.GET(wFiltroMedio, wPeriodo, wSeccion) THEN BEGIN

            rLinTarifas.RESET;
            rLinTarifas.SETRANGE("Source No.", wFiltroMedio);
            rLinTarifas.SETRANGE(Seccion, wSeccion);
            rLinTarifas.SETRANGE("Dia tarifa", pDia);
            rLinTarifas.SETRANGE("Starting Date", DMY2DATE(1, 1, wPeriodo));
            rLinTarifas.SETRANGE("Asset Type", rLinTarifas."Asset Type"::Resource);
            rLinTarifas.SETRANGE("Asset No.", pConcepto);
            if rLinTarifas.FIND('-') THEN BEGIN
                wPrecioLin := rLinTarifas."Direct Unit Cost";
                if wRecargo <> '' THEN
                    //        if rRecargos.GET(wFiltroMedio,wFiltroPeriodo,wFiltroSeccion,wRecargo) THEN
                    wPrecioLin := ROUND(wPrecioLin + (wPrecioLin * wPorRecargo / 100), 0.01);
                EXIT(FORMAT(wPrecioLin));
            END;

        END;
        EXIT('');
    END;

    Procedure Load(MatrixColumns1: ARRAY[32] OF Text[1024];
    MatrixRecords1: ARRAY[32] OF Record "Dias tarifa publicidad"; NoOfMatrixColumns1: Integer;
    pFiltroMedio: Text; pSecion: Text; pPeriodo: Integer)
    var
        i: Integer;
    Begin
        wPeriodo := pPeriodo;
        wSeccion := pSecion;
        wFiltroMedio := pFiltroMedio;
        COPYARRAY(MATRIX_ColumnCaption, MatrixColumns1, 1);
        FOR i := 1 TO ARRAYLEN(MatrixRecords) DO
            MatrixRecords[i].COPY(MatrixRecords1[i]);
        MATRIX_NoOfMatrixColumns := NoOfMatrixColumns1;
    End;

    /// <summary>
    /// MatrixOnDrillDown.
    /// </summary>
    /// <param name="i">Integer.</param>
    procedure MatrixOnDrillDown(i: Integer)
    begin

    end;

}