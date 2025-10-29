// page 80264 Prestamos
// {
//     PageType = List;
//     UsageCategory = Lists;
//     ApplicationArea = All;
//     SourceTable = "Cabecera Prestamo";
//     SourceTableView = SORTING(Empresa)
//                     WHERE(Empresa = FILTER(<> ''),
//                           "Importe Prestamo" = FILTER(<> 0));
//     CardPageId = "Cabecera Prestamo";


//     layout
//     {
//         area(Content)
//         {
//             group(Filtros)
//             {
//                 field(Desde; Desde)
//                 {
//                     ApplicationArea = All;
//                     trigger OnValidate()
//                     begin
//                         CurrPage.Update();
//                     end;
//                 }
//                 field(Hasta; Hasta)
//                 {
//                     ApplicationArea = All;
//                     trigger OnValidate()
//                     begin
//                         CurrPage.Update();
//                     end;
//                 }
//                 field("Tipo Periodo"; PeriodType)
//                 {
//                     ApplicationArea = All;
//                     trigger OnValidate()
//                     begin
//                         CurrPage.Update();
//                     end;
//                 }
//                 field(TipoImporte; tipoImporte)
//                 {
//                     ApplicationArea = All;
//                     trigger OnValidate()
//                     begin
//                         CurrPage.Update();
//                     end;
//                 }
//             }

//             repeater(Detalle)
//             {
//                 field(Empresa; Rec.Empresa)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Código Del Prestamo"; Cab)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Banco; Banc)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Liquidado; Rec.Liquidado)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Pendiente; Pend) { ApplicationArea = All; }
//                 field("Fecha Vto"; Vto) { ApplicationArea = All; }
//                 field(Leasing; Rec.Leasing) { ApplicationArea = All; }
//                 field(Meses; Rec.Meses) { ApplicationArea = All; }
//                 field(Field1; MATRIX_CellData[1])
//                 {
//                     ApplicationArea = All;
//                     AutoFormatExpression = FormatStr;
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + MATRIX_ColumnCaptions[1];
//                     //Style = Strong;
//                     //StyleExpr = Emphasize;
//                     Visible = true;// Field1Visible;


//                 }
//             }
//         }
//     }
//     actions
//     {

//         // { 1180190013;TextBox;24250;4620 ;11177;440  ;ParentControl=1180190000;
//         //                                              InMatrix=Yes;
//         //                                              field(Importe }
//         // { 1180190017;TextBox;16610;330  ;1700 ;440  ;ParentControl=1180190013;
//         //                                              InMatrixHeading=Yes;
//         //                                              field(PeriodFormMgt.CreatePeriodFormat(PeriodType,CurrForm.Matrix.MatrixRec."Period Start") }
//         // { 1180190018;OptionButton;1980;14410;550;550;VertGlue=Bottom;
//         //                                              FocusOnClick=No;
//         //                                              ShowCaption=No;
//         //                                              Border=Yes;
//         //                                              BitmapPos=Center;
//         //                                              Bitmap=12;
//         //                                              ToolTipML=[ENU=Quarter;
//         //                                                         ESP=Trimestre];
//         //                                              field(PeriodType;
//         //                                              OptionValue=Quarter }
//         // { 1180190019;OptionButton;1430;14410;550;550;VertGlue=Bottom;
//         //                                              FocusOnClick=No;
//         //                                              ShowCaption=No;
//         //                                              Border=Yes;
//         //                                              BitmapPos=Center;
//         //                                              Bitmap=11;
//         //                                              ToolTipML=[ENU=Month;
//         //                                                         ESP=Mes];
//         //                                              field(PeriodType;
//         //                                              OptionValue=Month }
//         // { 1180190020;OptionButton;880;14410;550;550 ;VertGlue=Bottom;
//         //                                              FocusOnClick=No;
//         //                                              ShowCaption=No;
//         //                                              Border=Yes;
//         //                                              BitmapPos=Center;
//         //                                              Bitmap=10;
//         //                                              ToolTipML=[ENU=Week;
//         //                                                         ESP=Semana];
//         //                                              field(PeriodType;
//         //                                              OptionValue=Week }
//         // { 1180190021;OptionButton;330;14410;550;550 ;VertGlue=Bottom;
//         //                                              FocusOnClick=No;
//         //                                              ShowCaption=No;
//         //                                              Border=Yes;
//         //                                              BitmapPos=Center;
//         //                                              Bitmap=9;
//         //                                              ToolTipML=[ENU=Day;
//         //                                                         ESP=Día];
//         //                                              field(PeriodType;
//         //                                              OptionValue=Day }
//         // { 1180190022;OptionButton;3080;14410;550;550;VertGlue=Bottom;
//         //                                              FocusOnClick=No;
//         //                                              ShowCaption=No;
//         //                                              Border=Yes;
//         //                                              BitmapPos=Center;
//         //                                              Bitmap=14;
//         //                                              ToolTipML=[ENU=Accounting Period;
//         //                                                         ESP=Periodo contable];
//         //                                              field(PeriodType;
//         //                                              OptionValue=Accounting Period }
//         // { 1180190023;OptionButton;2530;14410;550;550;VertGlue=Bottom;
//         //                                              FocusOnClick=No;
//         //                                              ShowCaption=No;
//         //                                              Border=Yes;
//         //                                              BitmapPos=Center;
//         //                                              Bitmap=13;
//         //                                              ToolTipML=[ENU=Year;
//         //                                                         ESP=A¤o];
//         //                                              field(PeriodType;
//         //                                              OptionValue=Year }
//         // { 1180190024;OptionButton;3850;14410;550;550;VertGlue=Bottom;
//         //                                              FocusOnClick=No;
//         //                                              ShowCaption=No;
//         //                                              Border=Yes;
//         //                                              BitmapPos=Center;
//         //                                              Bitmap=18;
//         //                                              ToolTipML=[ENU=Net Change;
//         //                                                         ESP=Saldo periodo];
//         //                                              field(QtyType;
//         //                                              OptionValue=Net Change }
//         // { 1180190025;OptionButton;4400;14410;550;550;VertGlue=Bottom;
//         //                                              FocusOnClick=No;
//         //                                              ShowCaption=No;
//         //                                              Border=Yes;
//         //                                              BitmapPos=Center;
//         //                                              Bitmap=19;
//         //                                              ToolTipML=[ENU=Balance at Date;
//         //                                                         ESP=Saldo a la fecha];
//         //                                              field(QtyType;
//         //                                              OptionValue=Balance at Date }
//         // { 1180190029;OptionButton;440;110;3740;440  ;CaptionML=ESP=Amortización;
//         //                                              field(tipoImporte;
//         //                                              OptionValue=Amotización }
//         // { 1180190030;OptionButton;4510;110;3740;440 ;CaptionML=ESP=Intereses;
//         //                                              field(tipoImporte;
//         //                                              OptionValue=Intereses }
//         // { 1180190031;OptionButton;7920;110;3740;440 ;CaptionML=ESP=Cuota;
//         //                                              field(tipoImporte;
//         //                                              OptionValue=Cuota }
//         // { 1180190016;TextBox;8470 ;14410;2310 ;440  ;VertGlue=Bottom;
//         //                                              ForeColor=8388608;
//         //                                              field("Filtro Fecha Liquidación" }
//         // { 1180190026;Label  ;5060 ;14410;3300 ;440  ;ParentControl=1180190016;
//         //                                              ForeColor=8388608 }
//     }
//     VAR
//         tipoImporte: Option Amotización,Intereses,Cuota;
//         PeriodFormMgt: Codeunit 359;
//         PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
//         QtyType: Option "Net Change","Balance at Date";
//         MatrixMgt: Codeunit "Matrix Management";
//         Desde: Date;
//         Hasta: Date;
//         LineDimCode: Text[30];
//         ColumnDimCode: Text[30];
//         ExcludeClosingDateFilter: Text;
//         InternalDateFilter: Text;
//         MatrixAmount: Decimal;
//         PeriodInitialized: Boolean;
//         CurrExchDate: Date;

//         MATRIX_ColumnOrdinal: Integer;
//         MATRIX_NoOfMatrixColumns: Integer;
//         MATRIX_CellData: array[32] of Decimal;
//         MATRIX_ColumnCaptions: array[32] of Text[1024];
//         MATRIX_PrimKeyFirstCol: Text[1024];
//         RoundingFactorFormatString: Text;
//         MATRIX_CurrSetLength: Integer;
//         
//         Field1Visible: Boolean;
//         
//         Field2Visible: Boolean;
//         
//         Field3Visible: Boolean;
//         
//         Field4Visible: Boolean;
//         
//         Field5Visible: Boolean;
//         
//         Field6Visible: Boolean;
//         
//         Field7Visible: Boolean;
//         
//         Field8Visible: Boolean;
//         
//         Field9Visible: Boolean;
//         
//         Field10Visible: Boolean;
//         
//         Field11Visible: Boolean;
//         
//         Field12Visible: Boolean;
//         
//         Field13Visible: Boolean;
//         
//         Field14Visible: Boolean;
//         
//         Field15Visible: Boolean;
//         
//         Field16Visible: Boolean;
//         
//         Field17Visible: Boolean;
//         
//         Field18Visible: Boolean;
//         
//         Field19Visible: Boolean;
//         
//         Field20Visible: Boolean;
//         
//         Field21Visible: Boolean;
//         
//         Field22Visible: Boolean;
//         
//         Field23Visible: Boolean;
//         
//         Field24Visible: Boolean;
//         
//         Field25Visible: Boolean;
//         
//         Field26Visible: Boolean;
//         
//         Field27Visible: Boolean;
//         
//         Field28Visible: Boolean;
//         
//         Field29Visible: Boolean;
//         
//         Field30Visible: Boolean;
//         
//         Field31Visible: Boolean;
//         
//         Field32Visible: Boolean;
//         Emphasize: Boolean;
//         Fechas: Record Date;
//         Fecha: Date;

//     trigger OnOpenPage()
//     BEGIN

//         Contruye;
//         tipoImporte := tipoImporte::Cuota;
//         PeriodType := PeriodType::Month;
//     END;

//     local procedure FormatStr(): Text
//     begin
//         exit(RoundingFactorFormatString);
//     end;

//     PROCEDURE Importe(): Decimal;
//     Var
//         Cab: record "Cabecera Prestamo";
//     BEGIN
//         if QtyType = QtyType::"Net Change" THEN
//             if Fechas."Period Start" = Fechas."Period End" THEN
//                 Rec.SETRANGE("Filtro Fecha", Fechas."Period Start")
//             ELSE
//                 Rec.SETRANGE("Filtro Fecha", Fechas."Period Start", Fechas."Period End")
//         ELSE
//             Rec.SETRANGE("Filtro Fecha", 0D, Fechas."Period End");
//         Rec.CALCFIELDS(Amortización, Intereses, Cuota);
//         CASE tipoImporte OF
//             tipoImporte::Amotización:
//                 EXIT(Rec.Amortización);
//             tipoImporte::Intereses:
//                 EXIT(Rec.Intereses);
//             tipoImporte::Cuota:
//                 EXIT(Rec.Cuota);
//         END;
//     END;

//     trigger OnAfterGetRecord()
//     var
//         MATRIX_CurrentColumnOrdinal: Integer;
//         MATRIX_Steps: Integer;

//     begin
//         // if CurrForm.TotalAmount.VISIBLE THEN
//         if Desde = 0D then
//             Desde := CalcDate('PA+1D-1A', WorkDate());
//         if Hasta = 0D Then Hasta := CalcDate('PA', WorkDate());
//         case PeriodType of
//             PeriodType::Day:
//                 Fechas.SetRange("Period Type", Fechas."Period Type"::Date);
//             PeriodType::Month, PeriodType::"Accounting Period":
//                 Fechas.SetRange("Period Type", Fechas."Period Type"::Month);
//             PeriodType::Quarter:
//                 Fechas.SetRange("Period Type", Fechas."Period Type"::Quarter);
//             PeriodType::Week:
//                 Fechas.SetRange("Period Type", Fechas."Period Type"::Week);
//             PeriodType::Year:
//                 Fechas.SetRange("Period Type", Fechas."Period Type"::Year);
//         end;
//         Fechas.SetRange("Period Start", Desde, Hasta);
//         Fechas.FindFirst();
//         Fecha := Fechas."Period Start";
//         MATRIX_CurrentColumnOrdinal := 0;

//         for MATRIX_CurrentColumnOrdinal := 0 to 31 do begin
//             MATRIX_ColumnOrdinal := MATRIX_CurrentColumnOrdinal;
//             PeriodFormMgt.NextDate(MATRIX_CurrentColumnOrdinal, Fechas, PeriodType);

//             ;
//             Fecha := Fechas."Period Start";
//             MATRIX_ColumnCaptions[MATRIX_CurrentColumnOrdinal] := PeriodFormMgt.CreatePeriodFormat(PeriodType, Fecha);
//             MATRIX_CellData[MATRIX_CurrentColumnOrdinal] := Importe();
//             MATRIX_CurrentColumnOrdinal += 1
//         end;



//     end;

//     PROCEDURE Pend(): Decimal;
//     BEGIN
//         CALCFIELDS(Liquidado);
//         if GETFILTER("Filtro Fecha Liquidación") <> '' THEN
//             if "Fecha Préstamo" > Rec.GETRANGEMAX("Filtro Fecha Liquidación") THEN EXIT(0);
//         EXIT("Importe Prestamo" - Liquidado);
//     END;

//     PROCEDURE Vto(): Date;
//     BEGIN
//         if Rec."Fecha Préstamo" = 0D THEN EXIT(0D);
//         EXIT(CALCDATE(STRSUBSTNO('%1M', Rec.Meses), Rec."Fecha Préstamo"));
//     END;

//     PROCEDURE Cab(): Text[1024];
//     VAR
//         r270: Record 270;
//     BEGIN
//         EXIT("Cabecera Prestamo2" + ' ' + FORMAT(Rec."Fecha Préstamo", 0, '<Day,2>/<Month,2>/<Year>')
//         + ' ' + FORMAT(Rec."Importe Prestamo", 0, '<Precision,2:2><Standard Format,0>'));//+' '+r270."Name 2");
//     END;

//     PROCEDURE Contruye();
//     VAR
//         a: Integer;
//         rEmp: Record 2000000006;
//         rCab: Record "Cabecera Prestamo";
//         rDet: Record "Detalle Prestamo";
//         rCab2: Record "Cabecera Prestamo" TEMPORARY;
//         rDet2: Record "Detalle Prestamo" TEMPORARY;
//     BEGIN
//         rCab.SETFILTER(rCab.Empresa, '<>%1', '');
//         rCab.DELETEALL;
//         rCab.SETRANGE(rCab.Empresa);
//         rDet.SETFILTER(rDet.Empresa, '<>%1', '');
//         rDet.DELETEALL;
//         rDet.SETRANGE(rDet.Empresa);

//         if rEmp.FINDFIRST THEN
//             REPEAT
//                 rCab.CHANGECOMPANY(rEmp.Name);
//                 rCab.SETFILTER(rCab.Empresa, '<>%1', '');
//                 rCab.DELETEALL;
//                 rCab.SETRANGE(rCab.Empresa);
//                 rDet.CHANGECOMPANY(rEmp.Name);
//                 rDet.SETFILTER(rDet.Empresa, '<>%1', '');
//                 rDet.DELETEALL;
//                 rDet.SETRANGE(rDet.Empresa);

//                 if rCab.FINDFIRST THEN
//                     REPEAT
//                         a := a + 1;
//                         rCab2 := rCab;
//                         rCab2.Empresa := rEmp.Name;
//                         rCab2."Cabecera Prestamo2" := rCab2."Código Del Prestamo";
//                         rCab2."Código Del Prestamo" := FORMAT(a) + '#';
//                         rCab2.INSERT;
//                         rDet.SETRANGE(rDet."Código Del Prestamo", rCab."Código Del Prestamo");
//                         if rDet.FINDFIRST THEN
//                             REPEAT
//                                 rDet2 := rDet;
//                                 rDet2.Empresa := rEmp.Name;
//                                 rDet2."Código Del Prestamo" := rCab2."Código Del Prestamo";
//                                 rDet2.INSERT;
//                             UNTIL rDet.NEXT = 0;
//                     UNTIL rCab.NEXT = 0;
//             UNTIL rEmp.NEXT = 0;
//         rCab.CHANGECOMPANY(COMPANYNAME);
//         rDet.CHANGECOMPANY(COMPANYNAME);
//         if rCab2.FINDFIRST THEN
//             REPEAT
//                 rCab := rCab2;
//                 rCab.INSERT;
//                 rDet2.SETRANGE(rDet2."Código Del Prestamo", rCab2."Código Del Prestamo");
//                 if rDet2.FINDFIRST THEN
//                     REPEAT
//                         rDet := rDet2;
//                         rDet.INSERT;
//                     UNTIL rDet2.NEXT = 0;
//             UNTIL rCab2.NEXT = 0;
//     END;

//     PROCEDURE Banc(): Text[250];
//     VAR
//         r270: Record 270;
//     BEGIN
//         r270.CHANGECOMPANY(Empresa);
//         if NOT r270.GET(Banco) THEN r270.INIT;
//         EXIT(r270."Name 2");
//     END;


// }

