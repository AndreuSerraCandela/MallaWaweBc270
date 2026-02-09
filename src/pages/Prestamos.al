/// <summary>
/// Page Prestamos (ID 50018).
/// </summary>
page 50213 Prestamos
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cabecera Prestamo";
    SourceTableView = SORTING(Empresa)
                    WHERE(Empresa = FILTER(<> ''),
                          "Importe Prestamo" = FILTER(<> 0), Renting = const(false));
    CardPageId = "Cabecera Prestamo";


    layout
    {
        area(Content)
        {
            group(Filtros)
            {

                field("Tipo Periodo"; PeriodType)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(TipoImporte; tipoImporte)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }

            }

            repeater(Detalle)
            {
                field(Empresa; Rec.Empresa)
                {
                    ApplicationArea = All;
                }
                field("Código Del Prestamo"; Cab)
                {
                    ApplicationArea = All;
                }
                field(Banco; Banc)
                {
                    ApplicationArea = All;
                }
                field(Liquidado; Rec.Liquidado)
                {
                    ApplicationArea = All;
                }
                field(Pendiente; Rec."Importe Pendiente") { ApplicationArea = All; }
                field("Fecha Vto"; Vto(Rec)) { ApplicationArea = All; }
                field(Leasing; Rec.Leasing) { ApplicationArea = All; }
                field(Meses; Rec.Meses) { ApplicationArea = All; }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[1];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = true;// Field1Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(1);
                    end;


                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[2];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field2Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[3];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field3Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(3);
                    end;


                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[4];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field4Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(4);
                    end;


                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[5];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field5Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[6];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field6Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[7];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field7Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(7);
                    end;
                }

                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[8];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field8Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[9];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field9Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[10];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field10Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[11];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field11Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[12];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field12Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[13];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field13Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[14];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field14Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[15];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field15Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[16];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field16Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[17];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field17Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[18];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field18Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[19];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field19Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[20];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field20Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(20);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[21];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field21Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(21);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[22];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field22Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[23];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field23Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[24];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field24Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[25];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field25Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[26];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field26Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[27];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field27Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[28];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field28Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[29];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field29Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[30];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field30Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(30);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[31];
                    //Style = Strong;
                    //StyleExpr = Emphasize;
                    Visible = Field31Visible;
                    trigger OnDrillDown()
                    begin
                        DrilDown(31);
                    end;
                }

            }
        }

    }
    actions
    {
        area(Processing)
        {

        }
    }
    VAR
        tipoImporte: Option Amotización,Intereses,Cuota;
        PeriodFormMgt: Codeunit PeriodPageManagement;
        PeriodType: Enum "Analysis Period Type";
        QtyType: Option "Net Change","Balance at Date";
        MatrixMgt: Codeunit "Matrix Management";
        Desde: Date;
        Hasta: Date;
        LineDimCode: Text[30];
        ColumnDimCode: Text[30];
        ExcludeClosingDateFilter: Text;
        InternalDateFilter: Text;
        MatrixAmount: Decimal;
        PeriodInitialized: Boolean;
        CurrExchDate: Date;

        MATRIX_ColumnOrdinal: Integer;
        MATRIX_NoOfMatrixColumns: Integer;
        MATRIX_CellData: array[33] of Decimal;
        MATRIX_ColumnCaptions: array[33] of Text[1024];
        MATRIX_PrimKeyFirstCol: Text[1024];
        RoundingFactorFormatString: Text;
        MATRIX_CurrSetLength: Integer;

        Field1Visible: Boolean;

        Field2Visible: Boolean;

        Field3Visible: Boolean;

        Field4Visible: Boolean;

        Field5Visible: Boolean;

        Field6Visible: Boolean;

        Field7Visible: Boolean;

        Field8Visible: Boolean;

        Field9Visible: Boolean;

        Field10Visible: Boolean;

        Field11Visible: Boolean;

        Field12Visible: Boolean;

        Field13Visible: Boolean;

        Field14Visible: Boolean;

        Field15Visible: Boolean;

        Field16Visible: Boolean;

        Field17Visible: Boolean;

        Field18Visible: Boolean;

        Field19Visible: Boolean;

        Field20Visible: Boolean;

        Field21Visible: Boolean;

        Field22Visible: Boolean;

        Field23Visible: Boolean;

        Field24Visible: Boolean;

        Field25Visible: Boolean;

        Field26Visible: Boolean;

        Field27Visible: Boolean;

        Field28Visible: Boolean;

        Field29Visible: Boolean;

        Field30Visible: Boolean;

        Field31Visible: Boolean;

        Field32Visible: Boolean;
        Emphasize: Boolean;
        Fechas: Record Date;
        SoloImprePend: Boolean;
        Fecha: Date;

    trigger onOpenPage()
    var

    begin
        tipoImporte := tipoImporte::Cuota;
        PeriodType := PeriodType::Month;
    END;

    local procedure FormatStr(): Text
    begin
        exit(RoundingFactorFormatString);
    end;

    PROCEDURE Importe(): Decimal;
    Var
        Cab: record "Cabecera Prestamo";
    BEGIN
        Fechas.FindFirst();
        if QtyType = QtyType::"Net Change" THEN
            if Fechas."Period Start" = Fechas."Period End" THEN
                Rec.SETRANGE("Filtro Fecha", Fechas."Period Start")
            ELSE
                Rec.SETRANGE("Filtro Fecha", Fechas."Period Start", Fechas."Period End")
        ELSE
            Rec.SETRANGE("Filtro Fecha", 0D, Fechas."Period End");
        Rec.CALCFIELDS(Amortización, Intereses, Cuota);
        CASE tipoImporte OF
            tipoImporte::Amotización:
                EXIT(Rec.Amortización);
            tipoImporte::Intereses:
                EXIT(Rec.Intereses);
            tipoImporte::Cuota:
                EXIT(Rec.Cuota);
        END;
    END;

    trigger OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        MATRIX_Steps: Integer;
        FHasta: Date;
    begin
        // if CurrForm.TotalAmount.VISIBLE THEN
        if Desde = 0D then
            Desde := CalcDate('PA+1D-1A', WorkDate());
        if Hasta = 0D Then Hasta := CalcDate('PA', WorkDate());
        case PeriodType of
            PeriodType::Day:
                Fechas.SetRange("Period Type", Fechas."Period Type"::Date);
            PeriodType::Month, PeriodType::"Accounting Period":
                Fechas.SetRange("Period Type", Fechas."Period Type"::Month);
            PeriodType::Quarter:
                Fechas.SetRange("Period Type", Fechas."Period Type"::Quarter);
            PeriodType::Week:
                Fechas.SetRange("Period Type", Fechas."Period Type"::Week);
            PeriodType::Year:
                Fechas.SetRange("Period Type", Fechas."Period Type"::Year);
        end;
        Fechas.SetRange("Period Start", Desde, Hasta);
        Fechas.FindFirst();
        case PeriodType Of
            //PeriodType::Day: Fecha := Calcdate('-1D',Desde);
            PeriodType::Week:
                Fecha := Calcdate('PW-1W+1d', Desde);
            PeriodType::Month:
                Fecha := Calcdate('PM-1M+1D', Desde);
            PeriodType::Quarter:
                Fecha := Calcdate('PQ-1Q+1D', Desde);
            PeriodType::Year:
                Fecha := Calcdate('PA-1A+1D', Desde);

        end;
        MATRIX_CurrentColumnOrdinal := 1;

        for MATRIX_CurrentColumnOrdinal := 1 to 31 do begin
            MATRIX_ColumnOrdinal := MATRIX_CurrentColumnOrdinal;
            //PeriodFormMgt.NextDate(MATRIX_CurrentColumnOrdinal, Fechas, PeriodType);
            if MATRIX_CurrentColumnOrdinal > 1 Then
                case PeriodType Of
                    PeriodType::Day:
                        Fecha := Calcdate('1D', Fecha);
                    PeriodType::Week:
                        Fecha := Calcdate('1W', Fecha);
                    PeriodType::Month:
                        Fecha := Calcdate('1M', Fecha);
                    PeriodType::Quarter:
                        Fecha := Calcdate('1Q', Fecha);
                    PeriodType::Year:
                        Fecha := Calcdate('1A', Fecha);

                end;
            Fechas.SetRange("Period Start", Fecha);
            MATRIX_ColumnCaptions[MATRIX_CurrentColumnOrdinal] := PeriodFormMgt.CreatePeriodFormat(PeriodType, Fecha);

            MATRIX_CellData[MATRIX_CurrentColumnOrdinal] := Importe();
            //   MATRIX_CurrentColumnOrdinal += 1

        end;
        Field1Visible := true;
        Field2Visible := true;
        Field3Visible := true;
        Field4Visible := true;
        Field5Visible := true;
        Field6Visible := true;
        Field7Visible := true;
        Field8Visible := true;
        Field9Visible := true;
        Field10Visible := true;
        Field11Visible := true;
        Field12Visible := true;
        Field13Visible := true;
        Field14Visible := true;
        Field15Visible := true;
        Field16Visible := true;
        Field17Visible := true;
        Field18Visible := true;
        Field19Visible := true;
        Field20Visible := true;
        Field21Visible := true;
        Field22Visible := true;
        Field23Visible := true;
        Field24Visible := true;
        Field25Visible := true;
        Field26Visible := true;
        Field27Visible := true;
        Field28Visible := true;
        Field29Visible := true;
        Field30Visible := true;
        Field31Visible := true;

    end;

    PROCEDURE Pend(var Cab: Record "Cabecera Prestamo"): Decimal;
    BEGIN
        Cab.CALCFIELDS(Liquidado);
        if Cab.GETFILTER("Filtro Fecha Liquidación") <> '' THEN
            if CAb."Fecha Préstamo" > Cab.GETRANGEMAX("Filtro Fecha Liquidación") THEN EXIT(0);
        EXIT(Cab."Importe Prestamo" - Cab.Liquidado);
    END;

    PROCEDURE Vto(var Cab: Record "Cabecera Prestamo"): Date;
    BEGIN
        if Cab."Fecha Préstamo" = 0D THEN EXIT(0D);
        EXIT(CALCDATE(STRSUBSTNO('%1M', Cab.Meses), Cab."Fecha Préstamo"));
    END;

    PROCEDURE Cab(): Text[1024];
    VAR
        r270: Record 270;
    BEGIN
        EXIT(Rec."Cabecera Prestamo2" + ' ' + FORMAT(Rec."Fecha Préstamo", 0, '<Day,2>/<Month,2>/<Year>')
        + ' ' + FORMAT(Rec."Importe Prestamo", 0, '<Precision,2:2><Standard Format,0>'));//+' '+r270."Name 2");
    END;

    PROCEDURE Banc(): Text[250];
    VAR
        r270: Record 270;
    BEGIN
        r270.CHANGECOMPANY(Rec.Empresa);
        if NOT r270.GET(Rec.Banco) THEN r270.INIT;
        EXIT(r270."Name 2");
    END;

    /// <summary>
    /// DrilDown.
    /// </summary>
    /// <param name="i">Integer.</param>
    procedure DrilDown(i: Integer)
    var
        Cab: Record "Cabecera Prestamo";
        Pres: Page "Cabecera Prestamo";
    begin
        Cab.ChangeCompany(Rec.Empresa);
        Cab.SetRange("Código Del Prestamo", Rec."Cabecera Prestamo2");
        if Cab.FindFirst() Then begin
            Pres.Empresa(Rec.Empresa);
            Pres.SetRecord(Cab);
            Pres.SetTableView(Cab);
            Pres.RunModal();
        end;

    end;


}


