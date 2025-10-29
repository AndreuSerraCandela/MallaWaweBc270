// page 50080 "Remesa confirming"
// {
//     //Version List=CONF2.00;
//     SourceTable = "Cab. borrador pagare";
//     PageType = Card;
//     //UpdateOnActivate=Yes;
//     layout
//     {
//         area(Content)
//         {
//             group(General)
//             {

//                 field("Cód. pagaré"; Rec."Cód. pagaré") { ApplicationArea = All; }
//                 field("Fecha registro"; Rec."Fecha registro") { ApplicationArea = All; }
//                 field("Nombre banco"; Rec."Nombre banco") { ApplicationArea = All; }
//                 field("Fecha de vto."; Rec."Fecha de vto.")
//                 {
//                     ApplicationArea = All;
//                     trigger OnLookup(var Text: Text): Boolean
//                     BEGIN
//                         CaptSelBanco := STRSUBSTNO('%1 %2 %3', "Cód. pagaré", Importe, CurrPage.CAPTION);
//                         SelBanco.DefRemeConfi(Rec, CaptSelBanco);
//                         if ACTION::LookupOK = SelBanco.RUNMODAL THEN BEGIN
//                             SelBanco.GETRECORD(CtaBanco);
//                             //  "Al descuento" := SelBanco.IsForDiscount;           FCL-11/03/04
//                             if SelBanco.IsForDiscount = 1 THEN                  //FCL-11/03/04
//                                 "CCC Nº Cuenta" := TRUE;                           //FCL-11/03/04
//                             VALIDATE("Fecha de vto.", CtaBanco."No.");
//                             MODIFY;
//                         END;
//                         CLEAR(SelBanco);
//                     END;
//                 }
//                 field("Importe"; Rec.Importe) { ApplicationArea = All; }
//             }
//             group(Auditoria)
//             {
//                 // field("Cód. auditoría"; Rec."Cód. auditoría") { ApplicationArea = All; }
//                 field("Nº Serie"; Rec."Nº Serie") { ApplicationArea = All; }
//             }

//             part("Efectos Confirming"; "Efectos confirming (2)")
//             {
//                 ApplicationArea = all;
//                 SubPageView = SORTING(Type, "Collection Agent", "Bill Gr./Pmt. Order No.", "Currency Code", Accepted, "Due Date", Place);
//                 SubPageLink = Type = CONST(Payable),
//                             "Collection Agent" = CONST(Bank),
//                             "Bill Gr./Pmt. Order No." = FIELD("Cód. pagaré");
//             }
//         }
//     }
//     actions
//     {
//         area(Navigation)
//         {
//             group("Re&mesa")
//             {
//                 Caption=  'Re&mesa';
//                 action("&Navegar")
//                 {
//                     Caption=  '&Navegar';
//                     trigger OnAction()
//                     BEGIN
//                         Opcion := STRMENU('Asociado a efecto,Asociado a remesa');
//                         CASE Opcion OF
//                             0:
//                                 EXIT;
//                             1:
//                                 CurrPage."Efectos confirming".PAGE.Navegar;
//                             2:
//                                 BEGIN
//                                     Navegar.SetDoc("Fecha registro", "Cód. pagaré");
//                                     Navegar.RUN;
//                                 END;
//                         END;
//                     END;
//                 }
//                 action(Lista)
//                 {
//                     ApplicationArea = All;
//                     ShortCutKey = F5;
//                     Caption=  'Lista';
//                     Image = List;
//                     trigger OnAction()
//                     begin
//                         Page.RunModal(0, Rec);
//                     end;

//                 }
//                 action("C&omentarios")
//                 {
//                     ApplicationArea = All;
//                     Image = Comment;
//                     Caption=  'C&omentarios';
//                     Image = Comment;
//                     //RunPageLinkType=OnUpdate;
//                     RunObject = page "BG/PO Comment Sheet";
//                     RunPageLink = "BG/PO No." = FIELD("Cód. pagaré");
//                 }
//             }
//         }
//         area(Processing)
//         {
//             group("Acci&ones")
//             {

//                 Caption=  'Acci&ones';
//                 action("Añadir efectos")
//                 {
//                     Image = ADD;
//                     ApplicationArea = All;
//                     Caption=  'Añadir efectos';
//                     trigger OnAction()
//                     BEGIN
//                         CurrPage."Efectos confirming".PAGE.AddEfecs;
//                     END;
//                 }
//                 action("Eliminar efectos")
//                 {
//                     ApplicationArea = All;
//                     Image = Delete;
//                     Caption=  'Eliminar efectos';
//                     trigger OnAction()
//                     BEGIN
//                         CurrPage."Efectos confirming".PAGE.EliminEfecs;
//                     END;
//                 }
//                 action("Clasificar efectos")
//                 {
//                     Visible = false;
//                     ApplicationArea = All;
//                     Caption=  'Clasificar efectos';
//                     Image = FilterLines;
//                     trigger OnAction()
//                     BEGIN
//                         CurrPage."Efectos confirming".PAGE.Clasificar;
//                     END;
//                 }
//                 action("Desclasificar efectos")
//                 {
//                     Visible = false;
//                     Caption = 'Desclasificar efectos';
//                     trigger OnAction()
//                     BEGIN
//                         CurrPage."Efectos confirming".PAGE.Desclasificar;
//                     END;
//                 }
//             }

//             group("&Registro")
//             {
//                 Caption=  '&Registro';
//                 action(Test)
//                 {
//                     Visible = false;
//                     ApplicationArea = All;
//                     Caption=  'Test';
//                     trigger OnAction()
//                     BEGIN
//                         if NOT FIND THEN
//                             EXIT;
//                         NoRemesa.RESET;
//                         NoRemesa := Rec;
//                         NoRemesa.SETRECFILTER;
//                         REPORT.RUN(REPORT::"Bill Group - Test", TRUE, FALSE, NoRemesa);
//                     END;
//                 }
//                 action(Registrar)
//                 {
//                     ShortCutKey = F9;
//                     ApplicationArea = All;
//                     Caption=  'Registrar';
//                     trigger OnAction()
//                     BEGIN
//                         if FIND THEN
//                             RemeReg.SoloReg(Rec);
//                     END;
//                 }
//                 action("Registrar e &imprimir")
//                 {
//                     ShortCutKey = 'Mayús+F9';
//                     ApplicationArea = All;
//                     Caption=  'Registrar e &imprimir';
//                     trigger OnAction()
//                     BEGIN
//                         if FIND THEN
//                             RemeReg.ImprYRegis(Rec);
//                     END;
//                 }
//             }
//             group("&Imprimir")
//             {

//                 Caption = '&Imprimir';
//                 action("Listado remesa")
//                 {
//                     ApplicationArea = All;
//                     Caption=  'Listado remesa';
//                     trigger OnAction()
//                     VAR
//                         BillGrListing: Integer;
//                     BEGIN
//                         if FIND THEN BEGIN
//                             NoRemesa.COPY(Rec);
//                             NoRemesa.SETRECFILTER;
//                             REPORT.RUN(REPORT::"Listado remesas confirming", TRUE, FALSE, NoRemesa);
//                         END;
//                     END;
//                 }
//                 action("Remesa")
//                 {
//                     Caption=  'Remesas efectos soporte magnético';
//                     trigger OnAction()
//                     BEGIN
//                         if FIND THEN BEGIN
//                             NoRemesa.COPY(Rec);
//                             NoRemesa.SETRECFILTER;
//                             REPORT.RUN(REPORT::"Imprimir confirming disco", TRUE, FALSE, NoRemesa);
//                         END;
//                     END;
//                 }
//             }
//         }

//     }
//     VAR
//         NoRemesa: Record "Cab. borrador pagare";
//         CtaBanco: Record 270;
//         RemeReg: Codeunit "Remesa C.-Registrar + Impr (2)";
//         SelBanco: Page "Bank Account Selection";
//         CaptSelBanco: Text[250];
//         Opcion: Integer;
//         Navegar: Page 344;

// }
// page 50066 "Remesa confirming cerradas"
// {
//     SourceTable = "Cab. borrador pagare";
//     PageType = Card;

//     layout
//     {
//         area(Content)
//         {
//             group(General)
//             {
//                 field("Cód. pagaré"; Rec."Cód. pagaré") { ApplicationArea = All; }
//                 field("Fecha registro"; Rec."Fecha registro") { ApplicationArea = All; }
//                 // field("Importe cerrado"; Rec."Importe cerrado")
//                 // {
//                 //     ApplicationArea = All;
//                 //     Caption = 'Importe';

//                 //     //    { 15  ;Label        ;9900 ;2090 ;3300 ;440  ;
//                 // }
//                 field("Dirección banco"; Rec."Dirección banco") { ApplicationArea = All; }
//                 field("Fecha de vto."; Rec."Fecha de vto.")
//                 {
//                     ApplicationArea = All;
//                     trigger OnLookup(var Text: Text): Boolean
//                     BEGIN
//                         CaptSelBanco := STRSUBSTNO('%1 %2 %3', "Cód. pagaré", Importe, CurrPage.CAPTION);
//                         SelBanco.DefRemeConfi(Rec, CaptSelBanco);
//                         if ACTION::LookupOK = SelBanco.RUNMODAL THEN BEGIN
//                             SelBanco.GETRECORD(CtaBanco);
//                             //  "Al descuento" := SelBanco.IsForDiscount;         //FCL-11/03/04
//                             if SelBanco.IsForDiscount = 1 THEN                  //FCL-11/03/04
//                                 "CCC Nº Cuenta" := TRUE;                           //FCL-11/03/04
//                             VALIDATE("Fecha de vto.", CtaBanco."No.");
//                             MODIFY;
//                         END;
//                         CLEAR(SelBanco);
//                     END;
//                 }

//                 field(Importe; Rec.Importe) { ApplicationArea = All; }


//             }

//             group(Auditoria)
//             {
//                 field("Cód. auditoría"; Rec."Cód. auditoría") { ApplicationArea = All; }
//                 field("Nº Serie"; Rec."Nº Serie") { ApplicationArea = All; }
//             }
//             part(SubForm; "Efectos conf. en rem. cerr (2)")
//             {
//                 //Name='Efectos confirming cerradas';

//                 SubPageView = SORTING(Type, "Entry No.");
//                 SubPageLink = Type = CONST(Payable),
//                   "Collection Agent" = CONST(Bank),
//                   "Bill Gr./Pmt. Order No." = FIELD("Cód. pagaré");
//             }
//         }
//     }
//     actions
//     {
//         area(Navigation)
//         {
//             action(Navegar)
//             {
//                 Caption = '&Navegar';
//                 trigger OnAction()
//                 BEGIN
//                     Opcion := STRMENU('Asociado a efecto,Asociado a remesa');
//                     CASE Opcion OF
//                         0:
//                             EXIT;
//                         1:
//                             CurrPage."Efectos confirming cerradas".PAGE.Navegar;
//                         2:
//                             BEGIN
//                                 Navegar.SetDoc("Fecha registro", "Cód. pagaré");
//                                 Navegar.RUN;
//                             END;
//                     END;
//                 END;
//             }
//             action("Co&mments")
//             {
//                 ApplicationArea = Comments;
//                 Caption = 'Co&mments';
//                 Caption=  'Comentarios';
//                 Image = ViewComments;
//                 Promoted = true;
//                 RunObject = Page "BG/PO Comment Sheet";
//                 RunPageLink = " BG/PO No." = FIELD("Cód. pagaré");



//             }
//         }
//         area(Procesing)
//         {
//             group("Re&mesa")
//             {
//                 action(Lista)
//                 {
//                     Image = List;
//                     ApplicationArea = All;
//                     ShortCutKey = F5;
//                     Caption = 'Lista';
//                     trigger OnAction()
//                     Begin
//                         Page.Runmodal(0, Rec);
//                     End;
//                 }

//             }
//         }
//     }
//     VAR
//         NoRemesa: Record "Cab. borrador pagare";
//         CtaBanco: Record 270;
//         RemeReg: Codeunit "Registrar pagarés";
//         SelBanco: Page "Bank Account Selection";
//         CaptSelBanco: Text[250];
//         Opcion: Integer;
//         Navegar: PAge 344;



// }



// page 50070 "Matriz Contratos"
// {
//   //Pendiente
//   InsertAllowed = false;
//     SourceTable = 50889;
//     trigger OnOpenPage()
//     BEGIN
//         Calcula;
//     END;


// layout
//   {
//     { 1000000000;MatrixBox;0  ;770  ;12210;5500 ;Name=MatrixBox;
// HorzGlue=Both;
// VertGlue=Both;
// MatrixSourceTable=Table50890;
// trigger OnAfterGetRecord()BEGIN
//                    SETRANGE("Filtro Cuenta",CurrPage.MatrixBox.MatrixRec.Cuenta);
//                    CALCFIELDS("Saldo Contrato");
//                  END;
//                   }
// field(){ApplicationArea=All;}

// CaptionML=ENU='Source No.',
//            ESP='No Contrato';
// "Source No.;Rec."Source No.
// trigger OnLookup(var Text: Text): BooleanVAR
//            r36 : Record 36;
//          BEGIN
//            r36.GET(r36."Document Type"::Order,"Source No.");
//            PAGE.RUNMODAL(42,r36);
//          END;
//           }
// //    { 1000000004;Label  ;0    ;0    ;0    ;0    ;

// field(){ApplicationArea=All;}

// CaptionML=ESP=Nombre;
// Nombre(Rec);Rec.Nombre(Rec)
// //    { 1103355001;Label  ;2196 ;-1030;3300 ;440  ;

// field(){ApplicationArea=All;}

// CaptionML=ESP=Cód Vendedor;
// Vendedor(Rec);Rec.Vendedor(Rec)
// //    { 1103355003;Label  ;6032 ;-1030;3300 ;440  ;

// field(){ApplicationArea=All;}

// CaptionML=ESP=Vendedor;
// VendedorN(Rec);Rec.VendedorN(Rec)
// //    { 1000000012;Label  ;0    ;0    ;0    ;0    ;

// field(){ApplicationArea=All;}
// InMatrix=Yes;
// "Saldo Contrato;Rec."Saldo Contrato
// trigger OnDrillDown() BEGIN
//               r17.SETCURRENTKEY(r17."G/L Account No.",r17."Posting Date");
//               COPYFILTER("Filtro Fecha",r17."Posting Date");
//               r17.SETRANGE(r17."G/L Account No.",CurrPage.MatrixBox.MatrixRec.Cuenta);
//               r17.SETRANGE(r17."Nº Contrato","Source No.");
//               PAGE.RUNMODAL(0,r17);
//             END;
//              }
// //    { 1000000006;Label  ;0    ;0    ;0    ;0    ;
// field(){ApplicationArea=All;}
// InMatrixHeading=Yes;
// CurrPage.MatrixBox.MatrixRec.Cuenta;Rec.CurrPage.MatrixBox.MatrixRec.Cuenta
//     { 1000000008;Frame  ;0    ;0    ;11660;660  ;ShowCaption=No }
// field(){ApplicationArea=All;}

// "Filtro Fecha;Rec."Filtro Fecha
// trigger OnValidate() BEGIN
//              Calcula;
//            END;
//             }
// //    { 1000000010;Label  ;110  ;110  ;2860 ;440  ;
//     { 1000000014;CommandButton;8800;110;550;440 ;Visible=false;


// CaptionML=ESP=F;
// ToolTipML=ESP='Factura';
// trigger OnAction() BEGIN
//          SETRANGE("Document Type","Document Type"::Invoice,"Document Type"::"Credit Memo");
//        END;
//         }
//     { 1000000015;CommandButton;9460;110;550;440 ;Visible=false;


// CaptionML=ESP=T;
// ToolTipML=ESP='Todo';
// trigger OnAction() BEGIN
//          SETRANGE("Document Type");
//        END;
//         }
//     { 1000000017;CommandButton;10120;110;1320;440;
// Visible=false;


// CaptionML=ESP=F-T;
// ToolTipML=ESP='Todos-Factura';
// trigger OnAction() BEGIN
//          SETFILTER("Document Type",'%1|%2|%3|%4|%5|%6',"Document Type"::" ","Document Type"::Payment,
//          "Document Type"::"Finance Charge Memo","Document Type"::Reminder,"Document Type"::Refund,"Document Type"::Bill);
//        END;
//         }
//     { 1000000018;CommandButton;8140;110;550;440 ;Visible=false;


// CaptionML=ESP=A;
// ToolTipML=ESP='Albarane';
// trigger OnAction() BEGIN
//          SETRANGE("Document Type","Document Type"::Albar n);
//        END;
//         }
//     { 1000000013;group(){;9900;6490;2200;550  ;HorzGlue=Right;
// 
// CaptionML=ENU='F&unctions',
//            ESP='Acci&ones';
// Menu=MENUITEMS
// {
//   { ID=1000000016;
//     Visible=false;
//     CaptionML=ESP=Generar Apuntes;
//     trigger OnAction() VAR
//              r81 : Record "Gen. Journal Line";
//              r152 : Record 15;
//              r50889 : Record 50889;
//            BEGIN
//               Ventana.OPEN('Generando Apuntes Cuenta #########1## Contrapartida ###########2##');
//               r152.SETRANGE(r152."Account Type",r152."Account Type"::Posting);
//               if r152.FINDFIRST THEN REPEAT
//               Ventana.UPDATE(2,r152."No.");
//                COPYFILTER("Filtro Fecha",r50889."Filtro Fecha");
//                r50889.SETRANGE("Filtro Cuenta",r152."No.");
//                COPYFILTER("Document Type",r50889."Document Type");
//                if r50889.FINDFIRST THEN REPEAT
//                 Ventana.UPDATE(1,r50889."Source No.");
//                 r50889.CALCFIELDS("Debe en Contab","Haber en Contab");
//                 if r50889."Debe en Contab"<>0 THEN BEGIN
//                   Apunte(CuentaCP(r50889),CuentaG(r152),
//                   r50889."Debe en Contab",0,r50889.GETRANGEMAX("Filtro Fecha"),FORMAT(r50889.GETRANGEMAX("Filtro Fecha"),0,
//                   '<Day,2><Month,2>'),COPYSTR(Nombre(r50889),1,30));
//                 END;
//                 if r50889."Haber en Contab"<>0 THEN BEGIN
//                   Apunte(CuentaCP(r50889),CuentaG(r152),0,
//                   r50889."Haber en Contab",r50889.GETRANGEMAX("Filtro Fecha"),FORMAT(r50889.GETRANGEMAX("Filtro Fecha"),0,
//                   '<Day,2><Month,2>'),COPYSTR(Nombre(r50889),1,30));
//                 END;
//                UNTIL r50889.NEXT=0;
//              UNTIL r152.NEXT=0;
//              Ventana.CLOSE;
//            END;
//             }
// }
//  }
//   }
//   }
//     VAR
//       r18 : Record Customer;
//       r23 : Record Vendor;
//       rGrp : Record "Vendor Posting Group";
//       rGrc : Record 92;
//       r15 : Record 15;
//       r50889 : Record 50889;
//       Ventana : Dialog;
//       a : Integer;
//       r17 : Record "G/L Entry";
//       rCuetemp : Record 50892;

//     PROCEDURE Nombre(VAR r50889 : Record 50889) : Text[50];
//     VAR
//       r36 : Record 36;
//     BEGIN
//       if r36.GET(r36."Document Type"::Order,"Source No.") THEN EXIT(r36."Posting Description");
//     END;

//     PROCEDURE Apunte(Cuenta : Text[30];Contra : Text[30];Debe : Decimal;Haber : Decimal;Fecha : Date;Doc : Text[30];Des : Text[30]);
//     VAR
//       r81 : Record "Gen. Journal Line";
//       a : Integer;
//       r81I : Record "Gen. Journal Line";
//       rBis : Record 220;
//     BEGIN
//       if Contra=Cuenta THEN EXIT;
//       rBis.CHANGECOMPANY('Consolidacion');
//       rBis.SETRANGE(rBis."Company Name",COMPANYNAME);
//       rBis.FINDFIRST;
//       r81.SETRANGE(r81."Journal Template Name",'GENERAL');
//       r81.SETRANGE("Journal Batch Name",'INTER');
//       if r81.FINDLAST THEN
//        a:=r81."Line No."+10000
//       ELSE
//       a:=10000;
//       r81.VALIDATE(r81."Journal Template Name",'GENERAL');
//       r81.VALIDATE(r81."Journal Batch Name",'GENERICO');
//       r81.VALIDATE(r81."Line No.",a);
//       r81.VALIDATE(r81."Account Type",r81."Account Type"::"G/L Account");
//       r81."Account No.":=Contra;
//       r81.VALIDATE(r81."Posting Date",Fecha);
//       r81.VALIDATE(r81."Document No.",Doc);
//       r81.VALIDATE(r81.Description,Des);
//       if Haber<>0 THEN
//        r81.VALIDATE(r81."Debit Amount",Haber);
//       if Debe<>0 THEN
//        r81.VALIDATE(r81."Credit Amount",Debe);
//       r81I.CHANGECOMPANY('Consolidacion');
//       r81I.SETRANGE(r81I."Journal Template Name",'GENERAL');
//       r81I.SETRANGE("Journal Batch Name",'GENERICO');
//       if r81I.FINDLAST THEN
//        a:=r81I."Line No."+10000
//       ELSE
//       a:=10000;
//       r81I:=r81;
//       r81I."Line No.":=a;
//       r81I."Business Unit Code":=rBis.Code;
//       r81I.Eliminaciones:=TRUE;
//       r81I.INSERT;

//       r81.VALIDATE(r81."Journal Template Name",'GENERAL');
//       r81.VALIDATE(r81."Journal Batch Name",'GENERICO');
//       r81.VALIDATE(r81."Line No.",a+10000);
//       r81.VALIDATE(r81."Account Type",r81."Account Type"::"G/L Account");
//       r81."Account No.":=Cuenta;
//       r81.VALIDATE(r81."Posting Date",Fecha);
//       r81.VALIDATE(r81."Document No.",Doc);
//       r81.VALIDATE(r81.Description,Des);
//       if Haber<>0 THEN
//        r81.VALIDATE(r81."Credit Amount",Haber);
//       if Debe<>0 THEN
//        r81.VALIDATE(r81."Debit Amount",Debe);
//       r81I.CHANGECOMPANY('Consolidacion');
//       r81I.SETRANGE(r81I."Journal Template Name",'GENERAL');
//       r81I.SETRANGE("Journal Batch Name",'GENERICO');
//       if r81I.FINDLAST THEN
//        a:=r81I."Line No."+10000
//       ELSE
//       a:=10000;
//       r81I:=r81;
//       r81I."Line No.":=a;
//       r81I."Business Unit Code":=rBis.Code;
//       r81I.Eliminaciones:=TRUE;
//       r81I.INSERT;
//     END;

//     PROCEDURE CuentaCP(VAR r50889 : Record 50889) : Text[30];
//     BEGIN
//       if r50889."Source Type"=r50889."Source Type"::Vendor THEN BEGIN
//        r23.GET(r50889."Source No.");
//        rGrp.GET(r23."Vendor Posting Group");
//        r15.GET(rGrp."Payables Account");
//        EXIT(CuentaG(r15));
//       END;
//       if r50889."Source Type"=r50889."Source Type"::Customer THEN BEGIN
//        r18.GET(r50889."Source No.");
//        rGrc.GET(r18."Customer Posting Group");
//        r15.GET(rGrc."Receivables Account");
//        EXIT(CuentaG(r15));
//       END;
//     END;

//     PROCEDURE CuentaG(VAR r15 : Record 15) : Text[30];
//     BEGIN
//       EXIT(r15."Consol. Debit Acc.");
//     END;

//     PROCEDURE Calcula();
//     BEGIN
//       if GETFILTER("Filtro Fecha")='' THEN SETRANGE("Filtro Fecha",CALCDATE('PA+1D-2A',TODAY),CALCDATE('PA+2A',TODAY));
//       DELETEALL;
//       rCuetemp.DELETEALL;
//       CurrPage.MatrixBox.MatrixRec.DELETEALL;
//       r17.SETCURRENTKEY(r17."G/L Account No.",r17."Posting Date");
//       r17.SETFILTER(r17."G/L Account No.",'%1|%2','6*','7*');
//       COPYFILTER("Filtro Fecha",r17."Posting Date");
//        Ventana.OPEN('Comprobando Cuentas #########1## de #########2##');
//       Ventana.UPDATE(2,r17.COUNT);
//       if r17.FINDFIRST THEN REPEAT
//         a:=a+1;
//         Ventana.UPDATE(1,a);
//         r17.CALCFIELDS(r17."Nº Contrato");
//         if r17."Nº Contrato"<>'' THEN BEGIN
//          if NOT GET(xRec."Source Type"::" ",r17."Nº Contrato") THEN
//            BEGIN
//             "Source No.":=r17."Nº Contrato";

//            INSERT;
//          END;
//          if NOT rCuetemp.GET(r17."G/L Account No.",r17."Nº Contrato") THEN BEGIN
//           rCuetemp.Cuenta:=r17."G/L Account No.";
//           rCuetemp.Contrato:=r17."Nº Contrato";
//           rCuetemp.Saldo:=0;
//           rCuetemp.INSERT;
//          END;
//          rCuetemp.Saldo:=rCuetemp.Saldo+r17.Amount;
//          rCuetemp.MODIFY;
//          if r15.GET(r17."G/L Account No.") THEN;
//          CurrPage.MatrixBox.MatrixRec.INIT;
//          CurrPage.MatrixBox.MatrixRec.Cuenta:=r15."No.";
//          CurrPage.MatrixBox.MatrixRec.Nombre:=r15.Name;
//          if CurrPage.MatrixBox.MatrixRec.INSERT THEN;
//         END;
//       UNTIL r17.NEXT=0;
//       Ventana.CLOSE;
//     END;

//     PROCEDURE Vendedor(VAR r50889 : Record 50889) : Text[50];
//     VAR
//       r36 : Record 36;
//     BEGIN
//       if r36.GET(r36."Document Type"::Order,"Source No.") THEN EXIT(r36."Salesperson Code");
//     END;

//     PROCEDURE VendedorN(VAR r50889 : Record 50889) : Text[50];
//     VAR
//       r36 : Record 36;
//       r13 : Record 13;
//     BEGIN
//       if r36.GET(r36."Document Type"::Order,"Source No.") THEN
//        if r13.GET(r36."Salesperson Code") THEN EXIT(r13.Name);
//     END;

//     BEGIN
//     END.
//   }
// }

// page 50032 "Panorama esq. cta. agrupado"
// {
//     Caption = 'Gathered Acc. Schedule Overview',
//                ESP = 'Panorama esq. cta. agrupado';
//     SourceTable = "Acc. Schedule Line";
//     // DataCaptionExpression = MontarCaption;

//     layout
//     {
//         area(Content)
//         {
//             group(General)
//             {
//                 group(Filtros)
//                 {
//                     field(CurrentSchedName; CurrentSchedName)
//                     {
//                         ApplicationArea = All;
//                         Lookup = true;
//                         Caption = 'Account Schedule Name',
//                         ESP = 'Nombre esquema cuenta';
//                         LookupPageId = "Account Schedule Names";
//                         // trigger OnValidate()
//                         // BEGIN
//                         //     AccSchedManagement.CheckName(CurrentSchedName);
//                         // END;

//                         trigger OnLookup(var Text: Text): Boolean
//                         BEGIN
//                             EXIT(AccSchedManagement.LookupName(CurrentSchedName, Text));
//                         END;

//                         trigger OnValidate()
//                         VAR
//                             AccSchedName: Record 84;
//                             PrevAnalysisView: Record 363;
//                         BEGIN
//                             AccSchedManagement.CheckName(CurrentSchedName);
//                             CurrPage.SAVERECORD;
//                             AccSchedManagement.SetName(CurrentSchedName, Rec);
//                             if AccSchedName.GET(CurrentSchedName) THEN
//                                 if (AccSchedName."Default Column Layout" <> '') AND
//                                    (CurrentColumnName <> AccSchedName."Default Column Layout")
//                                 THEN BEGIN
//                                     CurrentColumnName := AccSchedName."Default Column Layout";
//                                     AccSchedManagement.CopyColumnsToTemp(CurrentColumnName, TempColumnLayout);
//                                     AccSchedManagement.SetColumnName(CurrentColumnName, CurrPage.AccSchedMatrix.MatrixRec);
//                                 END;

//                             if AccSchedName."Analysis View Name" <> AnalysisView.Code THEN BEGIN
//                                 PrevAnalysisView := AnalysisView;
//                                 if AccSchedName."Analysis View Name" <> '' THEN
//                                     AnalysisView.GET(AccSchedName."Analysis View Name")
//                                 ELSE BEGIN
//                                     CLEAR(AnalysisView);
//                                     AnalysisView."Dimension 1 Code" := GLSetup."Global Dimension 1 Code";
//                                     AnalysisView."Dimension 2 Code" := GLSetup."Global Dimension 2 Code";
//                                 END;
//                                 if PrevAnalysisView."Dimension 1 Code" <> AnalysisView."Dimension 1 Code" THEN
//                                     SETRANGE("Dimension 1 Filter");
//                                 if PrevAnalysisView."Dimension 2 Code" <> AnalysisView."Dimension 2 Code" THEN
//                                     SETRANGE("Dimension 2 Filter");
//                                 if PrevAnalysisView."Dimension 3 Code" <> AnalysisView."Dimension 3 Code" THEN
//                                     SETRANGE("Dimension 3 Filter");
//                                 if PrevAnalysisView."Dimension 4 Code" <> AnalysisView."Dimension 4 Code" THEN
//                                     SETRANGE("Dimension 4 Filter");
//                             END;

//                             CurrPage.Dim1Filter.ENABLED := AnalysisView."Dimension 1 Code" <> '';
//                             CurrPage.Dim2Filter.ENABLED := AnalysisView."Dimension 2 Code" <> '';
//                             CurrPage.Dim3Filter.ENABLED := AnalysisView."Dimension 3 Code" <> '';
//                             CurrPage.Dim4Filter.ENABLED := AnalysisView."Dimension 4 Code" <> '';

//                             CurrPage.UPDATE(FALSE);
//                             CurrPage.UPDATECONTROLS;
//                         END;
//                     }
//                     field(CurrentColumnNam; CurrentColumnName)
//                     {
//                         ApplicationArea = All;
//                         Lookup = true;
//                         Caption = 'Column Layout Name',
//                         ESP = 'Nombre plantilla columna';
//                         TableRelation = "Column Layout Name".Name;
//                         trigger OnValidate()
//                         BEGIN
//                             AccSchedManagement.CheckColumnName(CurrentColumnName);
//                             AccSchedManagement.CopyColumnsToTemp(CurrentColumnName, TempColumnLayout);
//                             AccSchedManagement.SetColumnName(CurrentColumnName, CurrPage.AccSchedMatrix.MatrixRec);
//                             CurrPage.UPDATE(FALSE);
//                         END;

//                         trigger OnLookup(var Text: Text): Boolean
//                         BEGIN
//                             EXIT(AccSchedManagement.LookupColumnName(CurrentColumnName, Text));
//                         END;

//                     }
//                     field("Date Filter"; Rec."Date Filter")
//                     {
//                         ApplicationArea = All;
//                         trigger OnValidate()
//                         BEGIN
//                             CurrPage.UPDATE;
//                         END;
//                     }


//                     field("Budget Filter"; Rec."G/L Budget Filter") { ApplicationArea = All; }
//                 }
//                 group(Dimentiones)
//                 {
//                     field("Dimension 2 Filter"; Rec."Dimension 2 Filter")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Dimension 2 Filter',
//                         ESP = 'Filtro dimensión 2';
//                         CaptionClass = FormGetCaptionClassLocal(2);
//                         trigger OnLookup(var Text: Text): Boolean
//                         BEGIN
//                             EXIT(FormLookUpDimFilter(AnalysisView."Dimension 2 Code", Text));
//                         END;

//                         trigger OnValidate()
//                         BEGIN
//                             CurrPage.UPDATE;
//                         END;
//                     }
//                     field("Dimension 1 Filter"; Rec."Dimension 1 Filter")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Dimension 1 Filter',
//                         ESP = 'Filtro dimensión 1';
//                         CaptionClass = FormGetCaptionClassLocal(1);
//                         trigger OnLookup(var Text: Text): Boolean
//                         BEGIN
//                             EXIT(FormLookUpDimFilter(AnalysisView."Dimension 1 Code", Text));
//                         END;

//                         trigger OnValidate()
//                         BEGIN
//                             CurrPage.UPDATE;
//                         END;
//                     }
//                     field("Dimension 3 Filter"; Rec."Dimension 3 Filter")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Dimension 3 Filter',
//                         ESP = 'Filtro dimensión 3';
//                         CaptionClass = FormGetCaptionClassLocal(3);
//                         trigger OnLookup(var Text: Text): Boolean
//                         BEGIN
//                             EXIT(FormLookUpDimFilter(AnalysisView."Dimension 3 Code", Text));
//                         END;

//                         trigger OnValidate()
//                         BEGIN
//                             CurrPage.UPDATE;
//                         END;
//                     }
//                     field("Dimension 4 Filter"; Rec."Dimension 4 Filter")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Dimension 4 Filter',
//                         ESP = 'Filtro dimensión 4';
//                         CaptionClass = FormGetCaptionClassLocal(4);
//                         trigger OnLookup(var Text: Text): Boolean
//                         BEGIN
//                             EXIT(FormLookUpDimFilter(AnalysisView."Dimension 4 Code", Text));
//                         END;

//                         trigger OnValidate()
//                         BEGIN
//                             CurrPage.UPDATE;
//                         END;
//                     }
//                     field("Dimension 5 Filter"; Rec."Dimension 5 Filter")
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Dimension 5 Filter',
//                         ESP = 'Filtro dimensión 5';
//                         CaptionClass = FormGetCaptionClassLocal(5);
//                         trigger OnLookup(var Text: Text): Boolean
//                         BEGIN
//                             EXIT(FormLookUpDimFilter(AnalysisView."Dimension 5 Code", Text));
//                         END;

//                         trigger OnValidate()
//                         BEGIN
//                             CurrPage.UPDATE;
//                         END;
//                     }
//                 }
//                 group(Otros)
//                 {
//                     field(UseAmtsInAddCur; UseAmtsInAddCurr)
//                     {
//                         ApplicationArea = All;
//                         ShowCaption = false;
//                         Caption = 'Show Amounts in Add. Reporting Currency',
//                         ESP = 'Muestra importes en div.-adic.';
//                         trigger OnValidate()
//                         BEGIN
//                             CurrPage.UPDATE;
//                         END;
//                     }
//                     field(ShowError; ShowError)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Show Error',
//                         ESP = 'Mostrar error';
//                         OptionCaption = 'None,Division by Zero,Period Error,Both',
//                         ESP = 'Ninguno,División entre cero,Error Periodo,Ambos';


//                     }
//                     field(AgrupBusca; AgrupBuscar)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Gather',
//                         ESP = 'Agrupación';
//                         trigger OnValidate()
//                         BEGIN
//                             AccSchedManagement.DefAgrupacion(AgrupBuscar);
//                         END;

//                         trigger OnLookup(var Text: Text): Boolean
//                         BEGIN
//                             Agrupacion.SETRANGE("Cod. grupo");
//                             Agrupacion.SETRANGE(Empresa, COMPANYNAME);
//                             CLEAR(ListaAgrupacionesG);
//                             ListaAgrupacionesG.SETTABLEVIEW(Agrupacion);
//                             ListaAgrupacionesG.SETRECORD(Agrupacion);
//                             ListaAgrupacionesG.EDITABLE(FALSE);
//                             ListaAgrupacionesG.LOOKUPMODE(TRUE);
//                             if ListaAgrupacionesG.RUNMODAL <> ACTION::LookupOK THEN
//                                 EXIT;

//                             ListaAgrupacionesG.GETRECORD(Agrupacion);

//                             AgrupBuscar := Agrupacion."Cod. grupo";
//                             AccSchedManagement.DefAgrupacion(AgrupBuscar);

//                             CurrPage.UPDATE;
//                         END;
//                     }
//                     field(EmpresaBusca; EmpresaBuscar)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Company',
//            ESP = 'Empresa';
//                         trigger OnValidate()
//                         BEGIN
//                             if EmpresaBuscar = '' THEN
//                                 EmpresaBuscar := COMPANYNAME;

//                             AccSchedManagement.DefEmpresa(EmpresaBuscar, TRUE);
//                             CurrPage.UPDATE;
//                         END;

//                         trigger OnLookup(var Text: Text): Boolean
//                         BEGIN
//                             Agrupacion.SETRANGE("Cod. grupo", AgrupBuscar);
//                             Agrupacion.SETRANGE(Empresa);

//                             CLEAR(ListaAgrupacionesE);
//                             ListaAgrupacionesE.SETTABLEVIEW(Agrupacion);
//                             ListaAgrupacionesE.SETRECORD(Agrupacion);
//                             ListaAgrupacionesE.EDITABLE(FALSE);
//                             ListaAgrupacionesE.LOOKUPMODE(TRUE);
//                             if ListaAgrupacionesE.RUNMODAL <> ACTION::LookupOK THEN
//                                 EXIT(FALSE);
//                             ListaAgrupacionesE.GETRECORD(Agrupacion);

//                             EmpresaBuscar := Agrupacion.Empresa;

//                             AccSchedManagement.DefEmpresa(EmpresaBuscar, TRUE);

//                             CurrPage.UPDATE;
//                         END;
//                     }
//                 }
//             }
//             repeater(Detalle)
//             {
//                 field("Row No."; Rec."Row No.")
//                 {
//                     ApplicationArea = All;
//                     Style = Strong;
//                     StyleExpr = Bold;
//                 }
//                 field(Descriptio; Rec.Description)
//                 {
//                     ApplicationArea = All;
//                     Style = Strong;
//                     StyleExpr = Bold;
//                 }
//                 field(ColumnValues1; ColumnValues[1])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(1);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[1];
//                     StyleExpr = ColumnStyle1;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(1);
//                     end;
//                 }
//                 field(ColumnValues2; ColumnValues[2])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(2);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[2];
//                     StyleExpr = ColumnStyle2;
//                     Visible = NoOfColumns >= 2;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(2);
//                     end;
//                 }
//                 field(ColumnValues3; ColumnValues[3])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(3);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[3];
//                     StyleExpr = ColumnStyle3;
//                     Visible = NoOfColumns >= 3;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(3);
//                     end;
//                 }
//                 field(ColumnValues4; ColumnValues[4])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(4);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[4];
//                     StyleExpr = ColumnStyle4;
//                     Visible = NoOfColumns >= 4;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(4);
//                     end;
//                 }
//                 field(ColumnValues5; ColumnValues[5])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(5);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[5];
//                     StyleExpr = ColumnStyle5;
//                     Visible = NoOfColumns >= 5;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(5);
//                     end;
//                 }
//                 field(ColumnValues6; ColumnValues[6])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(6);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[6];
//                     StyleExpr = ColumnStyle6;
//                     Visible = NoOfColumns >= 6;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(6);
//                     end;
//                 }
//                 field(ColumnValues7; ColumnValues[7])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(7);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[7];
//                     StyleExpr = ColumnStyle7;
//                     Visible = NoOfColumns >= 7;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(7);
//                     end;
//                 }
//                 field(ColumnValues8; ColumnValues[8])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(8);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[8];
//                     StyleExpr = ColumnStyle8;
//                     Visible = NoOfColumns >= 8;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(8);
//                     end;
//                 }
//                 field(ColumnValues9; ColumnValues[9])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(9);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[9];
//                     StyleExpr = ColumnStyle9;
//                     Visible = NoOfColumns >= 9;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(9);
//                     end;
//                 }
//                 field(ColumnValues10; ColumnValues[10])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(10);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[10];
//                     StyleExpr = ColumnStyle10;
//                     Visible = NoOfColumns >= 10;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(10);
//                     end;
//                 }
//                 field(ColumnValues11; ColumnValues[11])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(11);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[11];
//                     StyleExpr = ColumnStyle11;
//                     Visible = NoOfColumns >= 11;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(11);
//                     end;
//                 }
//                 field(ColumnValues12; ColumnValues[12])
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AutoFormatExpression = FormatStr(12);
//                     AutoFormatType = 11;
//                     BlankZero = true;
//                     CaptionClass = '3,' + ColumnCaptions[12];
//                     StyleExpr = ColumnStyle12;
//                     Visible = NoOfColumns >= 12;

//                     trigger OnDrillDown()
//                     begin
//                         DrillDown(12);
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             group("Acci&ones")
//             {
//                 Caption = 'F&unctions',
//            ESP = 'Acci&ones';
//                 action("Export to Excel")
//                 {
//                     Image = Excel;
//                     ApplicationArea = All;
//                     Caption = 'Export to Excel',
//                ESP = 'Exportar a Excel';
//                     trigger OnAction()
//                     VAR
//                         ExportAccSchedToExcel: Report 29;
//                     BEGIN
//                         ExportAccSchedToExcel.SetOptions(Rec, CurrentColumnName, UseAmtsInAddCurr);

//                         //$001-
//                         ExportAccSchedToExcel.DefEmpresa(EmpresaBuscar);
//                         ExportAccSchedToExcel.DefAgrupacion(AgrupBuscar);
//                         //$001+

//                         ExportAccSchedToExcel.RUN;
//                     END;
//                 }
//                 action("&Print")
//                 {
//                     Image = Report;
//                     ApplicationArea = All;
//                     Caption = 'Print',
//                ESP = 'Imprimir';
//                     trigger OnAction()
//                     VAR
//                         AccSched: Report 25;
//                         DateFilter: Text[30];
//                         BudgetFilter: Text[30];
//                         BusUnitFilter: Text[30];
//                         Dim1Filter: Text[250];
//                         Dim2Filter: Text[250];
//                         Dim3Filter: Text[250];
//                         Dim4Filter: Text[250];
//                     BEGIN
//                         AccSched.SetAccSchedName(CurrentSchedName);
//                         AccSched.SetColumnLayoutName(CurrentColumnName);
//                         DateFilter := GETFILTER("Date Filter");
//                         BudgetFilter := GETFILTER("Cost Budget Filter");//"Budget Filter");
//                         BusUnitFilter := GETFILTER("Business Unit Filter");
//                         Dim1Filter := GETFILTER("Dimension 1 Filter");
//                         Dim2Filter := GETFILTER("Dimension 2 Filter");
//                         Dim3Filter := GETFILTER("Dimension 3 Filter");
//                         Dim4Filter := GETFILTER("Dimension 4 Filter");
//                         AccSched.SetFilters(DateFilter, BudgetFilter, '', BusUnitFilter, Dim1Filter, Dim2Filter, Dim3Filter, Dim4Filter);
//                         //  {
//                         //  AccSched.SetFilter(
//                         //    GETFILTER("Date Filter"),GETFILTER("Budget Filter"),GETFILTER("Business Unit Filter"),
//                         //    GETFILTER("Dimension 1 Filter"),GETFILTER("Dimension 2 Filter"),
//                         //    GETFILTER("Dimension 3 Filter"),GETFILTER("Dimension 4 Filter"));
//                         //  }
//                         AccSched.RUN;
//                     END;
//                 }
//                 action("Mostrar gráfico de barras")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Show Bar Chart',
//                ESP = 'Mostrar gráfico de barras';
//                     trigger OnAction()
//                     BEGIN
//                         ShowBarChart;
//                     END;
//                 }
//                 action("Exp. esq. ctas. a formato ASC")
//                 {
//                     //ApplicationArea=ALL;
//                     Caption = 'Export Schedules to ASC format',
//                ESP = 'Exp. esq. ctas. a formato ASC';
//                     RunObject = Report 10720;
//                 }
//             }
//         }

//     }
//     VAR
//         Text000: Label 'DEFAULT;ESP=GENERICO';
//         Text001: Label '* ERROR *;ESP=* ERROR *';
//         Text002: Label 'Column formula: %1;ESP=Fórmula columna: %1';
//         Text003: Label 'Row formula: %1;ESP=Fórmula fila: %1';
//         TempColumnLayout: Record 334 TemPORARY;
//         AccSchedName: Record 84;
//         AnalysisViewor: Record 363;
//         GLSetupor: Record "General Ledger Setup";
//         //AccSchedManagement: Codeunit 8;
//         CurrentSchedName: Code[10];
//         CurrentColumnName: Code[10];
//         NewCurrentSchedName: Code[10];
//         NewCurrentColumnName: Code[10];
//         ShowError: Option None,"Division by Zero","Period Error",Both;
//         ColumnValue: Decimal;
//         PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
//         UseAmtsInAddCurr: Boolean;
//         Text004: Label 'Not Available;ESP=No disponible';
//         Text005: Label '1,6,,Dimension %1 Filter;ESP=1,6,,Filtro dimensión %1';
//         EmpresaBuscar: Text[30];
//         Company: Text[30];
//         AgrupBuscar: Code[10];
//         Agrupacion: Record Agrupa;
//         ListaAgrupacionesG: Page "Lista de códigos de agrupación";
//         ListaAgrupacionesE: Page "Lista empresas grupo";
//         Text006: Label 'No se puede acceder a los datos de otras empresas a traves de la empresa';
//         Text007: Label '" de "';
//         Text008: Label '" en "';
//         ColumnLayoutArr: array[12] of Record "Column Layout";
//         //AccSchedName: Record "Acc. Schedule Name";
//         AnalysisView: Record "Analysis View";
//         GLSetup: Record "General Ledger Setup";
//         AccSchedManagement: Codeunit AccSchedManagement;
//         MatrixMgt: Codeunit "Matrix Management";
//         NoOfColumns: Integer;
//         ColumnOffset: Integer;
//         ColumnStyle1: Text;
//         
//         ColumnStyle2: Text;
//         
//         ColumnStyle3: Text;
//         
//         ColumnStyle4: Text;
//         
//         ColumnStyle5: Text;
//         
//         ColumnStyle6: Text;
//         
//         ColumnStyle7: Text;
//         
//         ColumnStyle8: Text;
//         
//         ColumnStyle9: Text;
//         
//         ColumnStyle10: Text;
//         
//         ColumnStyle11: Text;
//         
//         ColumnStyle12: Text;
//         ColumnValues: array[12] of Decimal;
//         ColumnCaptions: array[12] of Text;

//     local procedure UpdateColumnCaptions()
//     var
//         ColumnNo: Integer;
//         i: Integer;
//     begin
//         Clear(ColumnCaptions);
//         if TempColumnLayout.FindSet then
//             repeat
//                 ColumnNo := ColumnNo + 1;
//                 if (ColumnNo > ColumnOffset) and (ColumnNo - ColumnOffset <= ArrayLen(ColumnCaptions)) then
//                     ColumnCaptions[ColumnNo - ColumnOffset] := TempColumnLayout."Column Header";
//             until (ColumnNo - ColumnOffset = ArrayLen(ColumnCaptions)) or (TempColumnLayout.Next() = 0);
//         // Set unused columns to blank to prevent RTC to display control ID as caption
//         for i := ColumnNo - ColumnOffset + 1 to ArrayLen(ColumnCaptions) do
//             ColumnCaptions[i] := ' ';
//         NoOfColumns := ColumnNo;
//     end;

//     trigger OnOpenPage()
//     BEGIN
//         GLSetup.GET;
//         UseAmtsInAddCurr := false;
//         GLSetup.Get();
//         UseAmtsInAddCurrVisible := GLSetup."Additional Reporting Currency" <> '';
//         if NewCurrentSchedName <> '' then
//             CurrentSchedName := NewCurrentSchedName;
//         if CurrentSchedName = '' then
//             CurrentSchedName := Text000;
//         if NewCurrentColumnName <> '' then
//             CurrentColumnName := NewCurrentColumnName;
//         if CurrentColumnName = '' then
//             CurrentColumnName := Text000;
//         if NewPeriodTypeSet then
//             PeriodType := ModifiedPeriodType;

//         AccSchedManagement.CopyColumnsToTemp(CurrentColumnName, TempColumnLayout);
//         AccSchedManagement.OpenSchedule(CurrentSchedName, Rec);
//         AccSchedManagement.OpenColumns(CurrentColumnName, TempColumnLayout);
//         AccSchedManagement.CheckAnalysisView(CurrentSchedName, CurrentColumnName, true);
//         UpdateColumnCaptions;
//         if AccSchedName.Get(CurrentSchedName) then
//             if AccSchedName."Analysis View Name" <> '' then
//                 AnalysisView.Get(AccSchedName."Analysis View Name")
//             else begin
//                 Clear(AnalysisView);
//                 AnalysisView."Dimension 1 Code" := GLSetup."Global Dimension 1 Code";
//                 AnalysisView."Dimension 2 Code" := GLSetup."Global Dimension 2 Code";
//             end;

//         AccSchedManagement.FindPeriod(Rec, '', PeriodType);
//         SetFilter(Show, '<>%1', Show::No);
//         SetRange("Dimension 1 Filter");
//         SetRange("Dimension 2 Filter");
//         SetRange("Dimension 3 Filter");
//         SetRange("Dimension 4 Filter");
//         SetRange("Cost Center Filter");
//         SetRange("Cost Object Filter");
//         SetRange("Cash Flow Forecast Filter");
//         SetRange("Cost Budget Filter");
//         SetRange("G/L Budget Filter");
//         UpdateDimFilterControls;
//         DateFilter := GetFilter("Date Filter");
//         EmpresaBuscar := COMPANYNAME;
//         AgrupBuscar := '';

//         AccSchedManagement.DefEmpresa(EmpresaBuscar, TRUE);
//         AccSchedManagement.DefAgrupacion(AgrupBuscar);
//         //OnBeforeCurrentColumnNameOnAfterValidate(CurrentColumnName);

//         //

//         FindPeriod('');
//         CurrPage.Dim1Filter.ENABLED := AnalysisView."Dimension 1 Code" <> '';
//         CurrPage.Dim2Filter.ENABLED := AnalysisView."Dimension 2 Code" <> '';
//         CurrPage.Dim3Filter.ENABLED := AnalysisView."Dimension 3 Code" <> '';
//         CurrPage.Dim4Filter.ENABLED := AnalysisView."Dimension 4 Code" <> '';
//         // CurrPage.Dim5Filter.ENABLED := AnalysisView."Dimension 5 Code" <> '';
//         CurrPage.UPDATECONTROLS;
//     END;
//     // trigger OnFindRecord() VAR
//     //   Found: Boolean;
//     //   BEGIN
//     //     Found := TempColumnLayout.FIND(Which);
//     //     if Found THEN
//     //       CurrPage.AccSchedMatrix.MatrixRec := TempColumnLayout;
//     //       EXIT(Found);
//     //   END;
//     local procedure FormGetCaptionClass(DimNo: Integer): Text[250]
//     begin
//         case DimNo of
//             1:
//                 begin
//                     if AnalysisView."Dimension 1 Code" <> '' then
//                         exit('1,6,' + AnalysisView."Dimension 1 Code");

//                     exit(StrSubstNo(Text005, DimNo));
//                 end;
//             2:
//                 begin
//                     if AnalysisView."Dimension 2 Code" <> '' then
//                         exit('1,6,' + AnalysisView."Dimension 2 Code");

//                     exit(StrSubstNo(Text005, DimNo));
//                 end;
//             3:
//                 begin
//                     if AnalysisView."Dimension 3 Code" <> '' then
//                         exit('1,6,' + AnalysisView."Dimension 3 Code");

//                     exit(StrSubstNo(Text005, DimNo));
//                 end;
//             4:
//                 begin
//                     if AnalysisView."Dimension 4 Code" <> '' then
//                         exit('1,6,' + AnalysisView."Dimension 4 Code");

//                     exit(StrSubstNo(Text005, DimNo));
//                 end;
//             5:
//                 exit(FieldCaption("Date Filter"));
//             6:
//                 exit(FieldCaption("Cash Flow Forecast Filter"));
//         end;
//     end;

//     local procedure GetStyle(ColumnNo: Integer; RowLineNo: Integer; ColumnLineNo: Integer)
//     var
//         ColumnStyle: Text;
//         ErrorType: Option "None","Division by Zero","Period Error",Both;
//     begin
//         AccSchedManagement.CalcFieldError(ErrorType, RowLineNo, ColumnLineNo);
//         if ErrorType > ErrorType::None then
//             ColumnStyle := 'Unfavorable'
//         else
//             if Bold then
//                 ColumnStyle := 'Strong'
//             else
//                 ColumnStyle := 'Standard';

//         case ColumnNo of
//             1:
//                 ColumnStyle1 := ColumnStyle;
//             2:
//                 ColumnStyle2 := ColumnStyle;
//             3:
//                 ColumnStyle3 := ColumnStyle;
//             4:
//                 ColumnStyle4 := ColumnStyle;
//             5:
//                 ColumnStyle5 := ColumnStyle;
//             6:
//                 ColumnStyle6 := ColumnStyle;
//             7:
//                 ColumnStyle7 := ColumnStyle;
//             8:
//                 ColumnStyle8 := ColumnStyle;
//             9:
//                 ColumnStyle9 := ColumnStyle;
//             10:
//                 ColumnStyle10 := ColumnStyle;
//             11:
//                 ColumnStyle11 := ColumnStyle;
//             12:
//                 ColumnStyle12 := ColumnStyle;
//         end;
//     end;

//     local procedure AdjustColumnOffset(Delta: Integer)
//     var
//         OldColumnOffset: Integer;
//     begin
//         OldColumnOffset := ColumnOffset;
//         ColumnOffset := ColumnOffset + Delta;
//         if ColumnOffset + 12 > TempColumnLayout.Count then
//             ColumnOffset := TempColumnLayout.Count - 12;
//         if ColumnOffset < 0 then
//             ColumnOffset := 0;
//         if ColumnOffset <> OldColumnOffset then begin
//             UpdateColumnCaptions;
//             CurrPage.Update(false);
//         end;
//     end;

//     trigger OnNextRecord(Steps: Integer): Integer
//     VAR
//         ResultSteps: Integer;
//     BEGIN
//         ResultSteps := TempColumnLayout.NEXT(Steps);
//         if ResultSteps <> 0 THEN
//             CurrPage.AccSchedMatrix.MatrixRec := TempColumnLayout;
//         EXIT(ResultSteps);
//     END;

//     trigger OnAfterGetRecord()
//     var
//         ColumnNo: Integer;
//     begin
//         Clear(ColumnValues);

//         if (Totaling = '') or (not TempColumnLayout.FindSet) then
//             exit;

//         repeat
//             ColumnNo := ColumnNo + 1;
//             if (ColumnNo > ColumnOffset) and (ColumnNo - ColumnOffset <= ArrayLen(ColumnValues)) then begin
//                 ColumnValues[ColumnNo - ColumnOffset] :=
//                   RoundNone(
//                     MatrixMgt.RoundValue(
//                       AccSchedManagement.CalcCell(Rec, TempColumnLayout, UseAmtsInAddCurr),
//                       TempColumnLayout."Rounding Factor"),
//                     TempColumnLayout."Rounding Factor");
//                 ColumnLayoutArr[ColumnNo - ColumnOffset] := TempColumnLayout;
//                 GetStyle(ColumnNo - ColumnOffset, "Line No.", TempColumnLayout."Line No.");
//             end;
//         until TempColumnLayout.Next() = 0;
//         AccSchedManagement.ForceRecalculate(false);
//     end;



//     Procedure DrillDown(a: Integer)
//     VAR
//         GLAcc: Record 15;
//         GLAccAnalysisView: Record 376;
//         ColumnLayout: Record 334;
//         ChartofAccAnalysisView: Page 569;
//     BEGIN
//         if CurrPage.AccSchedMatrix.MatrixRec."Column Type" = ColumnLayout."Column Type"::Formula THEN
//             MESSAGE(Text002, CurrPage.AccSchedMatrix.MatrixRec.Formula)
//         ELSE
//             if "Totaling Type" = "Totaling Type"::Formula THEN
//                 MESSAGE(Text003, Totaling)
//             ELSE
//                 if Totaling <> '' THEN BEGIN
//                     COPYFILTER("Business Unit Filter", GLAcc."Business Unit Filter");
//                     COPYFILTER("Budget Filter", GLAcc."Budget Filter");
//                     AccSchedManagement.SetGLAccRowFilters(GLAcc, Rec);
//                     AccSchedManagement.SetGLAccColumnFilters(GLAcc, Rec, CurrPage.AccSchedMatrix.MatrixRec);
//                     AccSchedName.GET(CurrentSchedName);
//                     if AccSchedName."Analysis View Name" = '' THEN BEGIN
//                         COPYFILTER("Dimension 1 Filter", GLAcc."Global Dimension 1 Filter");
//                         COPYFILTER("Dimension 2 Filter", GLAcc."Global Dimension 2 Filter");
//                         GLAcc.FILTERGROUP(2);
//                         GLAcc.SETFILTER("Global Dimension 1 Filter", AccSchedManagement.GetDimTotalingFilter(1, "Dimension 1 Totaling"));
//                         GLAcc.SETFILTER("Global Dimension 2 Filter", AccSchedManagement.GetDimTotalingFilter(2, "Dimension 2 Totaling"));
//                         GLAcc.FILTERGROUP(0);


//                         if Company <> '' THEN            //$001
//                             GLAcc.CHANGECOMPANY(Company);  //

//                         PAGE.RUN(PAGE::"Chart of Accounts (G/L)", GLAcc);

//                         if Company <> '' THEN                //$001
//                             GLAcc.CHANGECOMPANY(COMPANYNAME);  //

//                     END ELSE BEGIN
//                         GLAcc.COPYFILTER("Date Filter", GLAccAnalysisView."Date Filter");
//                         GLAcc.COPYFILTER("Budget Filter", GLAccAnalysisView."Budget Filter");
//                         GLAcc.COPYFILTER("Business Unit Filter", GLAccAnalysisView."Business Unit Filter");
//                         GLAccAnalysisView.SETRANGE("Analysis View Filter", AccSchedName."Analysis View Name");
//                         COPYFILTER("Dimension 1 Filter", GLAccAnalysisView."Dimension 1 Filter");
//                         COPYFILTER("Dimension 2 Filter", GLAccAnalysisView."Dimension 2 Filter");
//                         COPYFILTER("Dimension 3 Filter", GLAccAnalysisView."Dimension 3 Filter");
//                         COPYFILTER("Dimension 4 Filter", GLAccAnalysisView."Dimension 4 Filter");
//                         GLAccAnalysisView.FILTERGROUP(2);
//                         GLAccAnalysisView.SETFILTER("Dimension 1 Filter", AccSchedManagement.GetDimTotalingFilter(1, "Dimension 1 Totaling"));
//                         GLAccAnalysisView.SETFILTER("Dimension 2 Filter", AccSchedManagement.GetDimTotalingFilter(2, "Dimension 2 Totaling"));
//                         GLAccAnalysisView.SETFILTER("Dimension 3 Filter", AccSchedManagement.GetDimTotalingFilter(3, "Dimension 3 Totaling"));
//                         GLAccAnalysisView.SETFILTER("Dimension 4 Filter", AccSchedManagement.GetDimTotalingFilter(4, "Dimension 4 Totaling"));
//                         GLAccAnalysisView.FILTERGROUP(0);

//                         if Company <> '' THEN                              //$001
//                             GLAccAnalysisView.CHANGECOMPANY(Company);        //

//                         CLEAR(ChartofAccAnalysisView);
//                         ChartofAccAnalysisView.InsertTempGLAccAnalysisViews(GLAcc);
//                         ChartofAccAnalysisView.SETTABLEVIEW(GLAccAnalysisView);
//                         ChartofAccAnalysisView.RUN;

//                         if Company <> '' THEN                              //$001
//                             GLAccAnalysisView.CHANGECOMPANY(COMPANYNAME);    //

//                     END;
//                 END;
//     END;

//     procedure FormatStr(ColumnNo: Integer): Text
//     begin
//         exit(MatrixMgt.GetFormatString(ColumnLayoutArr[ColumnNo]."Rounding Factor", UseAmtsInAddCurr));
//     end;

//     PROCEDURE SetAccSchedNamehed(NewAccSchedName: Code[10]);
//     VAR
//         AccSchedName: Record 84;
//     BEGIN
//         NewCurrentSchedName := NewAccSchedName;
//         if AccSchedName.GET(NewCurrentSchedName) THEN
//             if AccSchedName."Default Column Layout" <> '' THEN
//                 NewCurrentColumnName := AccSchedName."Default Column Layout";
//     END;

//     LOCAL PROCEDURE FindPeriod(SearchText: Code[10]);
//     VAR
//         Calendar: Record 2000000007;
//         PeriodFormMgt: Codeunit 359;
//     BEGIN
//         if GETFILTER("Date Filter") <> '' THEN BEGIN
//             Calendar.SETFILTER("Period Start", GETFILTER("Date Filter"));
//             if NOT PeriodFormMgt.FindDate('+', Calendar, PeriodType) THEN
//                 PeriodFormMgt.FindDate('+', Calendar, PeriodType::Day);
//             Calendar.SETRANGE("Period Start");
//         END;
//         PeriodFormMgt.FindDate(SearchText, Calendar, PeriodType);
//         SETRANGE("Date Filter", Calendar."Period Start", Calendar."Period End");
//         if GETRANGEMIN("Date Filter") = GETRANGEMAX("Date Filter") THEN
//             SETRANGE("Date Filter", GETRANGEMIN("Date Filter"));
//     END;

//     LOCAL PROCEDURE FormLookUpDimFilter(Dim: Code[20]; VAR Texto: Text[1024]): Boolean;
//     VAR
//         DimVal: Record 349;
//         DimValList: Page 560;
//     BEGIN
//         if Dim = '' THEN
//             EXIT(FALSE);
//         DimValList.LOOKUPMODE(TRUE);
//         DimVal.SETRANGE("Dimension Code", Dim);
//         DimValList.SETTABLEVIEW(DimVal);
//         if DimValList.RUNMODAL = ACTION::LookupOK THEN BEGIN
//             DimValList.GETRECORD(DimVal);
//             Texto := DimValList.GetSelectionFilter;
//             EXIT(TRUE);
//         END ELSE
//             EXIT(FALSE)
//     END;

//     LOCAL PROCEDURE FormGetCaptionClassLocal(DimNo: Integer): Text[250];
//     BEGIN
//         CASE DimNo OF
//             1:
//                 BEGIN
//                     if AnalysisView."Dimension 1 Code" <> '' THEN
//                         EXIT('1,6,' + AnalysisView."Dimension 1 Code")
//                     ELSE
//                         EXIT(STRSUBSTNO(Text005, DimNo));
//                 END;
//             2:
//                 BEGIN
//                     if AnalysisView."Dimension 2 Code" <> '' THEN
//                         EXIT('1,6,' + AnalysisView."Dimension 2 Code")
//                     ELSE
//                         EXIT(STRSUBSTNO(Text005, DimNo));
//                 END;
//             3:
//                 BEGIN
//                     if AnalysisView."Dimension 3 Code" <> '' THEN
//                         EXIT('1,6,' + AnalysisView."Dimension 3 Code")
//                     ELSE
//                         EXIT(STRSUBSTNO(Text005, DimNo));
//                 END;
//             4:
//                 BEGIN
//                     if AnalysisView."Dimension 4 Code" <> '' THEN
//                         EXIT('1,6,' + AnalysisView."Dimension 4 Code")
//                     ELSE
//                         EXIT(STRSUBSTNO(Text005, DimNo));
//                 END;
//         END;
//     END;

//     LOCAL PROCEDURE ShowBarChart();
//     VAR
//         AccSchedLine: Record 85;
//         //AccSchedBarChart: Page "Acc. Schedule Line Bar Chart";
//         NoOfRows: integer;
//         LineNo: Array[3] OF Integer;
//         DateFilter: Text[80];
//         BudgetFilter: Text[80];
//         Dim1Filter: Text[80];
//         Dim2Filter: Text[80];
//         Dim3Filter: Text[80];
//         Dim4Filter: Text[80];
//     BEGIN
//         CurrPage.SETSELECTIONFILTER(AccSchedLine);
//         AccSchedLine.MARKEDONLY(TRUE);
//         if NOT AccSchedLine.FIND('-') THEN BEGIN
//             NoOfRows := 1;
//             LineNo[NoOfRows] := "Line No.";
//         END ELSE
//             REPEAT
//                 NoOfRows := NoOfRows + 1;
//                 LineNo[NoOfRows] := AccSchedLine."Line No.";
//             UNTIL (NoOfRows = 3) OR (AccSchedLine.NEXT = 0);

//         // AccSchedBarChart.SetParams(
//         //   CurrentSchedName, CurrentColumnName, LineNo[1], LineNo[2], LineNo[3], PeriodType, UseAmtsInAddCurr);

//         // DateFilter := GETFILTER("Date Filter");
//         // BudgetFilter := GETFILTER("Budget Filter");
//         // Dim1Filter := GETFILTER("Dimension 1 Filter");
//         // Dim2Filter := GETFILTER("Dimension 2 Filter");
//         // Dim3Filter := GETFILTER("Dimension 3 Filter");
//         // Dim4Filter := GETFILTER("Dimension 4 Filter");
//         // AccSchedBarChart.SetFilters(DateFilter, BudgetFilter, Dim1Filter, Dim2Filter, Dim3Filter, Dim4Filter);
//         // AccSchedBarChart.RUN;
//     END;

//     PROCEDURE MontarCaption(): Text[100];
//     BEGIN
//         // MontarCaption

//         if AgrupBuscar = '' THEN
//             EXIT(COPYSTR(CurrentSchedName + ' - ' + CurrentColumnName + Text008 + EmpresaBuscar, 1, 100))
//         ELSE
//             EXIT(COPYSTR(CurrentSchedName + ' - ' + CurrentColumnName + Text008 + EmpresaBuscar + Text007 + AgrupBuscar, 1, 100));
//     END;


// }
