/// <summary>
/// Page Intercambio x Empresa (ID 50027).
/// </summary>
page 50027 "Intercambio x Empresa"
{

    ApplicationArea = All;
    Caption = 'Intercambio x Empresa';
    PageType = List;
    SourceTable = "Intercambio x Empresa";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Código Intercambio"; Rec."Código Intercambio")
                {
                    ToolTip = 'Specifies the value of the Código Intercambio field';
                    ApplicationArea = All;
                }
                field(Empresa; Rec.Empresa)
                {
                    ToolTip = 'Specifies the value of the Empresa field';
                    ApplicationArea = All;
                }
                field(Cliente; Rec.Cliente)
                {
                    ToolTip = 'Specifies the value of the Cliente field';
                    ApplicationArea = All;
                }
                field(Nombre; NombreCliente())
                {
                    ApplicationArea = All;
                }
                field("Search Namev"; Rec."Search Namev")
                {
                    ToolTip = 'Specifies the value of the Search Namev field';
                    ApplicationArea = All;
                }
                field(Proveedor; Rec.Proveedor)
                {
                    ToolTip = 'Specifies the value of the Proveedor field';
                    ApplicationArea = All;
                }
                field("Saldo Cliente"; Rec."Saldo Cliente")
                {
                    ToolTip = 'Specifies the value of the Saldo Cliente field';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        rMovCli: Record 21;
                    begin

                        rMovCli.CHANGECOMPANY(Rec.Empresa);
                        rMovCli.SETRANGE(rMovCli."Customer No.", Rec.Cliente);
                        rMovCli.SETRANGE(rMovCli."Payment Method Code", 'INTERCAM');
                        rMovCli.SETRANGE(Open, TRUE);
                        Page.RUNMODAL(0, rMovCli);
                    end;
                }
                field("Saldo Proveedor"; Rec."Saldo Proveedor")
                {
                    ToolTip = 'Specifies the value of the Saldo Proveedor field';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        rMovCli: Record 25;
                    begin

                        rMovCli.CHANGECOMPANY(Rec.Empresa);
                        rMovCli.SETRANGE(rMovCli."Vendor No.", Rec.Proveedor);
                        rMovCli.SETRANGE(rMovCli."Payment Method Code", 'INTERCAM');
                        rMovCli.SETRANGE(Open, TRUE);
                        Page.RUNMODAL(0, rMovCli);
                    end;
                }
                field("Contrato sin facturar"; Rec."Contrato sin facturar")
                {
                    ToolTip = 'Specifies the value of the Contrato sin facturar field';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Contratos: Record 36;
                        Fcontratos: Page "Lista Contratos Venta";
                    begin

                        Contratos.SETRANGE("Posting Date", Rec.Desde, Rec.Hasta);
                        Contratos.CHANGECOMPANY(Rec.Empresa);
                        Contratos.SETRANGE(Contratos."Bill-to Customer No.", Rec.Cliente);
                        Contratos.SETRANGE(Contratos."Document Type", Contratos."Document Type"::Order);
                        Contratos.SETFILTER(Contratos.Estado, '%1|%2|%3', Contratos.Estado::"Pendiente de Firma", Contratos.Estado::Firmado,
                        Contratos.Estado::"Sin Montar");
                        Contratos.SETFILTER("Payment Method Code", '%1', 'INTER*');
                        CLEAR(FContratos);
                        FContratos.CambiarEmpresa(Rec.Empresa);
                        FContratos.SETTABLEVIEW(Contratos);
                        FContratos.RUNMODAL;
                    end;
                }
                field("Albaranes sin facturar"; Rec."Albaranes sin facturar")
                {
                    ToolTip = 'Specifies the value of the Albaranes sin facturar field';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        rDev: Record "Return Shipment Header";
                        Alb: Page "Posted Purchase Receipts";
                        Dev: Page "Posted Return Shipments";
                        rLinDev: Record "Return Shipment Line";
                    begin

                        MESSAGE('Primero aparecen los albaranes y luego las devoluciones');
                        AlbaranesPendientes(Rec.Empresa, Rec.GETRANGEMIN("Date Filter"), Rec.GETRANGEMAX("Date Filter"), Rec."Código Intercambio");
                        CLEAR(Alb);
                        r120.MARKEDONLY(TRUE);

                        //r120.FINDFIRST;
                        Alb.CambiaEmpresa(Rec.Empresa);
                        Alb.SETTABLEVIEW(r120);
                        Alb.RUNMODAL;
                        //FORM.RUNMODAL(0,r120t);
                        rDev.CHANGECOMPANY(Rec.Empresa);
                        rDev.SETRANGE(rDev."Buy-from Vendor No.", Rec.Proveedor);
                        rDev.SETRANGE("Posting Date", Rec.Desde, Rec.Hasta);
                        rDev.SETRANGE(Contabilizado, TRUE);
                        If rDev.FINDFIRST THEN
                            repeat
                                if rDev.Facturado = false then
                                    rDev.Mark(TRUE) ELSE begin
                                    rLinDev.CHANGECOMPANY(Rec.Empresa);
                                    rLinDev.SETRANGE(rLinDev."Document No.", rDev."No.");
                                    rLinDev.SetFilter(rLinDev."Return Qty. Shipped Not Invd.", '<>0');
                                    if rLinDev.FINDFIRST THEN
                                        rLinDev.Mark(TRUE);
                                end;
                            UNTIL rDev.NEXT = 0;
                        rDev.MARKEDONLY(TRUE);
                        CLEAR(Dev);
                        Dev.CambiaEmpresa(Rec.Empresa);
                        Dev.SETTABLEVIEW(rDev);
                        Dev.RUNMODAL;

                    end;
                }
                field("Pedidos pendientes"; Rec."Pedidos pendientes")
                {
                    ToolTip = 'Specifies the value of the Pedidos pendientes field';
                    ApplicationArea = All;
                    trigger OndrillDown()
                    var
                        Pedido: Page "Purchase List";
                    begin

                        PedidosPendientes(Rec.Empresa, Rec.GETRANGEMIN("Date Filter"), Rec.GETRANGEMAX("Date Filter"), Rec."Código Intercambio");
                        r38.MARKEDONLY(TRUE);
                        //r120.FINDFIRST;
                        CLEAR(Pedido);
                        Pedido.CambiaEmpresa(Rec.Empresa);
                        r38.SETRANGE(r38.Status, 0, 3);
                        r38.SETRANGE("No.");
                        Pedido.SETTABLEVIEW(r38);
                        Pedido.RUNMODAL();
                    end;
                }
                field(Saldo; Rec.Saldo)
                {
                    ToolTip = 'Specifies the value of the Saldo field';
                    ApplicationArea = All;

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("&Calcular")
            {
                ApplicationArea = All;
                Scope = Repeater;
                ShortCutKey = F9;
                Image = Calculate;
                trigger OnAction()
                BEGIN
                    Calcular('', true);
                END;
            }
            action("&Calcular solo firmados")
            {
                ApplicationArea = All;
                Scope = Repeater;
                Image = Signature;
                trigger OnAction()
                BEGIN
                    Calcular('', false);
                END;
            }
            action("&Resumen")
            {
                ApplicationArea = All;
                Scope = Repeater;
                Image = SortAscending;
                trigger OnAction()
                VAR
                    Intercambio: Record Intercambio TEMPORARY;
                    Emp: Record 2000000006;
                    Inter: Record Intercambio;
                BEGIN
                    if Rec.FINDFIRST THEN
                        REPEAT
                            Inter.GET(Rec."Código Intercambio");
                            if Inter."Search Name" = '' THEN Inter."Search Name" := 'Sin clasificar';
                            if NOT Intercambio.GET(Inter."Search Name") THEN BEGIN
                                a += 1;
                                Intercambio.INIT;
                                Intercambio."No." := Inter."Search Name";
                                Intercambio.Name := Inter."Search Name";
                                ;
                                Intercambio."Name 2" := '';
                                Intercambio."Search Name" := Inter."Search Name";
                                Intercambio.INSERT;
                            END;
                            if NOT Intercambio.GET(Inter."No.") THEN BEGIN
                                Intercambio.INIT;
                                Intercambio := Inter;
                                Intercambio.Address := Inter.Name;
                                Intercambio."Last Date Modified" := 19800102D;
                                Intercambio."Credit Limit (LCY)" := 0;
                                Emp.GET(Rec.Empresa);
                                Intercambio."Name 2" := '';
                                if Rec.Saldo <> 0 THEN
                                    Intercambio.INSERT;
                            END;
                            Intercambio."Credit Limit (LCY)" += Rec.Saldo;
                            if Intercambio."Last Date Modified" = 19800102D THEN
                                Intercambio."Last Date Modified" := CalcularFecha(Rec."Código Intercambio");
                            if Intercambio."Name 2" = '' THEN
                                Intercambio."Name 2" := CalcularEmpresa(Rec."Código Intercambio", Emp.Name);

                            if Rec.Saldo <> 0 THEN
                                Intercambio.MODIFY;
                        UNTIL Rec.NEXT = 0;
                    COMMIT;
                    PAGE.RUNMODAL(Page::"Resumen List", Intercambio);
                END;
            }
            action("Filtrar Con Datos")
            {
                ApplicationArea = All;
                Scope = Repeater;
                Image = Filter;
                trigger OnAction()
                BEGIN
                    Rec.ClearMarks();
                    If Rec.Findfirst Then
                        Repeat
                            If Rec."Saldo Cliente" +
                            Rec."Saldo Proveedor" +
                            Rec."Contrato sin facturar" +
                            Rec."Albaranes sin facturar" +
                            Rec."Pedidos pendientes" <> 0 Then
                                Rec.MARK(TRUE);
                        Until Rec.Next = 0;
                    Rec.MarkedOnly(TRUE);
                END;
            }
        }
        area(Promoted)
        {
            actionref(Calcular_ref; "&Calcular") { }
            actionref(FitrarConDatos_ref; "Filtrar Con Datos") { }
        }
    }
    var
        Ventana: Dialog;
        a: Integer;
        // Sql: DotNet Sql;
        // SqlAdapter: DotNet SqlAdp;
        // SqlCmd: DotNet SqlCmd;
        // Datatable: DotNet DataTable;
        // //SqlCommand: DotNet "System.Data.SqlClient.SqlCommand";
        //SqlDataReader: DotNet "System.Data.SqlClient.SqlDataReader";
        //Sql: DotNet "System Data" //	Automation	'Microsoft ActiveX Data Objects 2.7 Library'.Connection;
        //Trec:	Automation	'Microsoft ActiveX Data Objects 2.7 Library'.Recordset;
        // cquery: Text[1024];
        // cquery2: Text[1024];
        r120t: Record "Purch. Rcpt. Header" temporary;
        r120: Record "Purch. Rcpt. Header";
        r38: Record "Purchase Header";

    trigger OnOpenPage();
    begin
        Rec.SetRange(Blocked, rec.Blocked::" ");
    end;

    PROCEDURE TotalesDocumentos(No: Code[20]; pEmpresa: Text[30]): Decimal;
    VAR
        Contrato: Record 36;
        rCabVenta: Record 36;
        ImpBorFac: Decimal;
        ImpBorAbo: Decimal;
        ImpFac: Decimal;
        ImpAbo: Decimal;
        rCabFac: Record 112;
        rCabAbo: Record 114;
        RegisVtas: Codeunit 80;
        TotImp: Decimal;
        TotCont: Decimal;
        rCabFacL: Record 113;
        rCabAboL: Record 115;
        SalesLine: Record 37;
        Importe: Decimal;
        BImporte: Decimal;
        BImpBorFac: Decimal;
        BImpBorAbo: Decimal;
        BImpFac: Decimal;
        BImpAbo: Decimal;
        BTotImp: Decimal;
        BTotCont: Decimal;
    BEGIN
        //FCL-31/05/04. Obtengo totales de borradores y facturas correspondientes a este contrato.
        // Contrato.Get(Contrato."Document Type"::Order, No);
        ImpBorFac := 0;
        ImpBorAbo := 0;
        ImpFac := 0;
        ImpAbo := 0;
        WITH Contrato DO BEGIN
            Contrato.CHANGECOMPANY(pEmpresa);
            Contrato.Get(Contrato."Document Type"::Order, No);
            if Estado = Estado::Anulado THEN EXIT(0);
            if Estado = Estado::Cancelado THEN EXIT(0);
            if Estado = Estado::Modificado THEN EXIT(0);
            CALCFIELDS(Contrato."Abonos Registrados", Contrato."Facturas Registradas", Contrato."Borradores de Factura",
            Contrato."Borradores de Abono");
            //if ("Borradores de Factura" <> 0) OR ("Borradores de Abono" <> 0) THEN BEGIN
            rCabVenta.RESET;
            rCabVenta.CHANGECOMPANY(pEmpresa);
            rCabVenta.SETCURRENTKEY("Nº Proyecto");
            rCabVenta.SETRANGE("Nº Proyecto", "Nº Proyecto");
            rCabVenta.SETRANGE("Nº Contrato", "No.");
            rCabVenta.SETFILTER("Document Type", '%1|%2',
               rCabVenta."Document Type"::Invoice, rCabVenta."Document Type"::"Credit Memo");
            if rCabVenta.FIND('-') THEN BEGIN
                REPEAT
                    SalesLine.CHANGECOMPANY(pEmpresa);
                    SalesLine.SETRANGE(SalesLine."Document Type", rCabVenta."Document Type");
                    SalesLine.SETRANGE(SalesLine."Document No.", rCabVenta."No.");
                    Importe := 0;
                    BImporte := 0;
                    if SalesLine.FINDFIRST THEN
                        REPEAT
                            Importe += (SalesLine.Quantity * SalesLine."Unit Price" * (1 - SalesLine."Line Discount %" / 100)) * (1 + SalesLine."VAT %" / 100);
                            BImporte += (SalesLine.Quantity * SalesLine."Unit Price" * (1 - SalesLine."Line Discount %" / 100));
                        UNTIL SalesLine.NEXT = 0;
                    if rCabVenta."Document Type" = rCabVenta."Document Type"::Invoice THEN BEGIN
                        //$009(I)
                        //ImpBorFac:=ImpBorFac + TotalSalesLineLCY."Amount Including VAT";
                        ImpBorFac := ImpBorFac + Importe;
                        BImpBorFac := BImpBorFac + BImporte;
                        //$009(F)
                    END
                    ELSE BEGIN
                        //$009(I)
                        //ImpBorAbo:=ImpBorAbo + TotalSalesLineLCY."Amount Including VAT";
                        ImpBorAbo := ImpBorAbo + Importe;
                        BImpBorAbo := BImpBorAbo + BImporte;
                        //$009(F)
                    END;
                UNTIL rCabVenta.NEXT = 0;
            END;

            //END;

            //if "Facturas Registradas" <> 0 THEN BEGIN

            rCabFac.RESET;
            rCabFac.CHANGECOMPANY(pEmpresa);
            rCabFacL.CHANGECOMPANY(pEmpresa);
            rCabFac.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
            rCabFac.SETRANGE("Nº Contrato", "No.");
            if rCabFac.FIND('-') THEN BEGIN
                REPEAT
                    rCabFacL.SETRANGE(rCabFacL."Document No.", rCabFac."No.");
                    if rCabFacL.FINDFIRST THEN
                        rCabFacL.CALCSUMS(rCabFacL."Amount Including VAT", Amount)
                    ELSE
                        rCabFacL.INIT;
                    ImpFac := ImpFac + rCabFacL."Amount Including VAT";
                    BImpFac := BImpFac + rCabFacL.Amount;
                UNTIL rCabFac.NEXT = 0;
            END;

            //END;

            //if "Abonos Registrados" <> 0 THEN BEGIN

            rCabAbo.RESET;
            rCabAbo.CHANGECOMPANY(pEmpresa);
            rCabAboL.CHANGECOMPANY(pEmpresa);
            rCabAbo.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
            rCabAbo.SETRANGE("Nº Contrato", "No.");
            if rCabAbo.FIND('-') THEN BEGIN
                REPEAT
                    rCabAboL.SETRANGE(rCabAboL."Document No.", rCabAbo."No.");
                    if rCabAboL.FINDFIRST THEN
                        rCabAboL.CALCSUMS(rCabAboL."Amount Including VAT", Amount)
                    ELSE
                        rCabAboL.INIT;
                    ImpAbo := ImpAbo + rCabAboL."Amount Including VAT";
                    BImpAbo := BImpAbo + rCabAboL.Amount;
                //$009(F)
                UNTIL rCabAbo.NEXT = 0;
            END;

            //END;

            //FCL-13/02/06. Incluyo sumatorio de totales y diferencia con el total del contrato.
            TotImp := ImpBorFac - ImpBorAbo + ImpFac - ImpAbo;
            BTotImp := BImpBorFac - BImpBorAbo + BImpFac - BImpAbo;
            rCabVenta.Reset();
            rCabVenta.CHANGECOMPANY(pEmpresa);

            if rCabVenta.GET(rCabVenta."Document Type"::Order, No) THEN BEGIN
                SalesLine.Reset();
                SalesLine.CHANGECOMPANY(pEmpresa);
                SalesLine.SETRANGE(SalesLine."Document Type", rCabVenta."Document Type");
                SalesLine.SETRANGE(SalesLine."Document No.", rCabVenta."No.");
                Importe := 0;
                BImporte := 0;
                if SalesLine.FINDFIRST THEN
                    REPEAT
                        Importe += (SalesLine.Quantity * SalesLine."Unit Price" * (1 - SalesLine."Line Discount %" / 100)) * (1 + SalesLine."VAT %" / 100);
                        BImporte += (SalesLine.Quantity * SalesLine."Unit Price" * (1 - SalesLine."Line Discount %" / 100));
                    UNTIL SalesLine.NEXT = 0;

                TotCont := Importe;
                BTotCont := BImporte;
            END;
        END;
        if ABS((BImpBorFac - BImpBorAbo) + (BTotCont - BTotImp)) < 1 THEN EXIT(0);
        EXIT(-((ImpBorFac - ImpBorAbo) + (TotCont - TotImp)));
    END;

    PROCEDURE Contab(Num: Code[20]): Boolean;
    VAR
        Imp: Decimal;
        r17: Record "G/L Entry";
    BEGIN
        r17.SETCURRENTKEY(r17."Document No.");
        r17.SETRANGE(r17."Document No.", Num);
        if r17.FINDFIRST THEN
            REPEAT
                if COPYSTR(r17."G/L Account No.", 1, 1) = '6' THEN Imp := Imp + r17.Amount;
                if COPYSTR(r17."G/L Account No.", 1, 1) = '2' THEN Imp := Imp + r17.Amount;
                if COPYSTR(r17."G/L Account No.", 1, 2) = '47' THEN Imp := Imp + r17.Amount;
            UNTIL r17.NEXT = 0;
        if Imp = 0 THEN EXIT(FALSE);
        EXIT(TRUE);
    END;

    PROCEDURE NombreCliente(): Text[80];
    VAR
        rInter: Record Intercambio;
    BEGIN
        if rInter.GET(Rec."Código Intercambio") THEN EXIT(rInter.Name);
    END;

    PROCEDURE Conectar();
    VAR
    //     oConect: Label 'server=192.168.10.226;database=MALLA2009;Connection Timeout=300;Trusted_Connection=false;Max Pool Size=100;Min Pool Size=5;UID=mac;Pwd=1111',
    //   ENU = 'server=192.168.10.215;database=MALLA;Connection Timeout=300;Trusted_Connection=false;Max Pool Size=100;Min Pool Size=5;UID=mac;Pwd=1111';
    //     ContecionString: Text[1024];
    BEGIN
        // ContecionString := 'Driver={SQL Server};' +
        // 'Server=192.168.10.226;Database=MALLA2009;Connection Timeout=300;' +
        // 'UID=mac;PWD=1111';
        // //if ISCLEAR(Sql) THEN
        // //CREATE(Sql);
        // Sql := Sql.SqlConnection(ContecionString);
        // SqlCmd := Sql.CreateCommand;
        // //SqlCmd.CommandTimeout:=3600;
        // Sql.Open();
        // //Driver={ODBC Driver 13 for SQL Server};server=localhost;database=WideWorldImporters;trusted_connection=Yes;
        // //Sql:=Sql.SqlConnection('server=192.168.10.215;database=MALLA;Connection Timeout=300;'+
        // //'Trusted_Connection=false;Max Pool Size=100;Min Pool Size=5;UID=mac;Pwd=1111');
        // //SqlCmd:=Sql.CreateCommand;
        // //SqlCmd.CommandTimeout:=3600;
        // //Sql.Open();
    END;

    PROCEDURE CalculaAlb(Fdesde: Date; Fhasta: Date; intercam: Code[10]; Empresa: Text[30]): Decimal;
    VAR
        c: Label '';
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        lin: Record "Purch. Rcpt. Header";
        Det: Record "Purch. Rcpt. Line";
        Inter: Record "Intercambio x Empresa";
    BEGIN
        //     cquery := 'Select ISNULL(CAST(SUM(Importe) as float),0) as Importe From AlbaranesIntercambio ' +
        //    ' Where [Posting Date]>=' + c + FORMAT(Fdesde, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And [Posting Date]<=' + c + FORMAT(Fhasta, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And Codigo_Inter=' + c + intercam + c + ' AND Empresa=' + c + Empresa + c;
        //     SqlCmd.CommandText := cquery;
        //     SqlAdapter := SqlAdapter.SqlDataAdapter(SqlCmd);
        //     Datatable := Datatable.DataTable;
        //     SqlAdapter.Fill(Datatable);
        //     OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        //     LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic

        //     Importe := Datatable.Rows.Item(0).Item('Importe');//.Value;
        //                                                       //Str := ADOrs.Fields.Item('Street').Value;
        Inter.SetRange(Empresa, Empresa);
        Inter.SetRange("Código Intercambio", intercam);
        if Not Inter.FindFirst() then Inter.Init();
        lin.ChangeCompany(Empresa);
        lIn.SetRange("Buy-from Vendor No.", Inter.Proveedor);
        Lin.SetRange("Payment Method Code", 'INTERCAM');
        if Lin.FindFirst() Then
            repeat
                Det.ChangeCompany(Empresa);
                Det.SetRange("Document No.", lin."No.");
                if Det.FindFirst() Then
                    repeat
                        Importe += ((Det.Quantity - Det."Quantity Invoiced")) * Det."Direct Unit Cost" * (1 - Det."Line Discount %" / 100) * (1 + Det."VAT %" / 100);
                    until Det.Next() = 0;
            until Lin.Next() = 0;
        //SqlAdd:=SqlAdd.SqlDataAdapter(SqlCmd);
        //Trec:=Trec.DataTable;
        //SqlAdd.Fill(Trec);
        //Lineas:=10000;
        //Lineas:=Trec.GetRows.Count;
        // Se recorren los movimientos de Navision
        //a:=0;
        //if Lineas>0 THEN BEGIN
        //  Code:=STRSUBSTNO('%1',Trec.Rows.Item(0).Item('Importe'));
        //  Code:=CONVERTSTR(Code,'.',',');
        //  EVALUATE(Importe,Code);
        //END;
        //CLEAR(Trec);
        EXIT(Importe);
    END;

    PROCEDURE CalculaSaldoP(intercam: Code[10]; pEmpresa: Text[30]): Decimal;
    VAR
        c: Label '';
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        Inter: Record "Intercambio x Empresa";
        lin: Record 25;
        det: Record 380;
    BEGIN
        //     cquery := 'Select ISNULL(CAST(SUM(Importe) as float),0) as Importe From SaldosProveedoresIntercambio ' +
        //    ' Where Codigo_Inter=' + c + intercam + c + ' AND Empresa=' + c + Empresa + c;
        //     SqlCmd.CommandText := cquery;
        //     SqlAdapter := SqlAdapter.SqlDataAdapter(SqlCmd);
        //     Datatable := Datatable.DataTable;
        //     SqlAdapter.Fill(Datatable);
        //     Importe := Datatable.Rows.Item(0).Item('Importe');
        //     // if ISCLEAR(Trec) THEN
        //     //     CREATE(Trec);
        //     OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        //     LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic

        // Trec.Open(cquery, Sql, OpenMethod, LockMethod);
        // Trec.MoveFirst;
        // Importe := Trec.Fields.Item('Importe').Value;//.Value;
        //Str := ADOrs.Fields.Item('Street').Value;

        //SqlAdd:=SqlAdd.SqlDataAdapter(SqlCmd);
        //Trec:=Trec.DataTable;
        //SqlAdd.Fill(Trec);
        //Lineas:=10000;
        //Lineas:=Trec.Rows.Count;
        // Se recorren los movimientos de Navision
        //a:=0;
        //if Lineas>0 THEN BEGIN
        //  Code:=STRSUBSTNO('%1',Trec.Rows.Item(0).Item('Importe'));
        //  Code:=CONVERTSTR(Code,'.',',');
        //  EVALUATE(Importe,Code);
        //END;
        //CLEAR(Trec);
        Inter.SetRange(Empresa, pEmpresa);
        Inter.SetRange("Código Intercambio", intercam);
        if Not Inter.FindFirst() then Inter.Init();
        lin.ChangeCompany(pEmpresa);
        lIn.SetRange("Vendor No.", Inter.Proveedor);
        Lin.SetRange("Payment Method Code", 'INTERCAM');
        if Lin.FindFirst() Then
            repeat
                Det.ChangeCompany(pEmpresa);
                Det.SetRange("Vendor Ledger Entry No.", lin."Entry No.");
                //Det.FindFirst();
                Det.Calcsums(Amount);
                Importe += Det.Amount;
            until Lin.Next() = 0;
        EXIT(-Importe);
    END;

    PROCEDURE CalculaSaldoC(intercam: Code[10]; pEmpresa: Text[30]): Decimal;
    VAR
        c: Label '';
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        SaldoInter: Record 379;
        Inter: Record "Intercambio x Empresa";
        Lin: Record "Cust. Ledger Entry";
    BEGIN
        //         SELECT     (SELECT     TOP 1 INTER.[Código Intercambio]
        //            FROM          [Intercambio x Empresa] INTER
        //        WHERE      INTER.Cliente = LIN.[Customer No_] AND INTER.Empresa = 'Apartamentos los Tilos') AS Codigo_Inter, [Posting Date], 'Apartamentos los Tilos' AS Empresa,
        //                           (SELECT     Sum([Amount (LCY)])
        //                             FROM          [Apartamentos los Tilos$Detailed Cust_ Ledg_ Entry] DET
        //                             WHERE      Det.[Cust_ Ledger Entry No_] = Lin.[Entry No_]) AS Importe
        // FROM         [Apartamentos los Tilos$Cust_ Ledger Entry] AS LIN
        // WHERE     (SELECT     COUNT(INTER.[Código Intercambio])
        //                        FROM          [Intercambio x Empresa] INTER
        //                        WHERE      INTER.Cliente = LIN.[Customer No_] AND INTER.Empresa = 'Apartamentos los Tilos') <> 0 AND LIN.[Cod_ Forma Pago] = 'INTERCAM'
        // AND LIN.[Open] = 1
        //cquery := 'Select ISNULL(CAST(SUM(Importe) as float),0) as Importe From SaldosClientesIntercambio ' +
        //' Where Codigo_Inter=' + c + intercam + c + ' AND Empresa=' + c + Empresa + c;
        // if ISCLEAR(Trec) THEN
        //     CREATE(Trec);
        // OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        // LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic

        // Trec.Open(cquery, Sql, OpenMethod, LockMethod);
        // Trec.MoveFirst;
        // Importe := Trec.Fields.Item('Importe').Value;//.Value;
        //      
        Inter.SetRange(Empresa, pEmpresa);
        Inter.SetRange("Código Intercambio", intercam);
        if Not Inter.FindFirst() then Inter.Init();
        lin.ChangeCompany(pEmpresa);
        lIn.SetRange("Customer No.", Inter.Cliente);
        Lin.SetRange("Payment Method Code", 'INTERCAM');
        Lin.SetRange(Open, true);
        if Lin.FindFirst() Then
            repeat

                SaldoInter.ChangeCompany(pEmpresa);
                SaldoInter.SetRange("Cust. Ledger Entry No.", Lin."Entry No.");
                SaldoInter.CalcSums("Amount (LCY)");
                Importe += SaldoInter."Amount (LCY)";
            until Lin.Next() = 0;
        exit(Importe);

        //Str := ADOrs.Fields.Item('Street').Value;
        // SqlCmd.CommandText := cquery;
        // SqlAdapter := SqlAdapter.SqlDataAdapter(SqlCmd);
        // Datatable := Datatable.DataTable;
        // SqlAdapter.Fill(Datatable);
        // Importe := Datatable.Rows.Item(0).Item('Importe');
        //SqlAdd:=SqlAdd.SqlDataAdapter(SqlCmd);
        //Trec:=Trec.DataTable;
        //SqlAdd.Fill(Trec);
        //Lineas:=10000;
        //Lineas:=Trec.Rows.Count;
        // Se recorren los movimientos de Navision
        //a:=0;
        //if Lineas>0 THEN BEGIN
        //  Code:=STRSUBSTNO('%1',Trec.Rows.Item(0).Item('Importe'));
        //  Code:=CONVERTSTR(Code,'.',',');
        //  EVALUATE(Importe,Code);
        //END;
        //CLEAR(Trec);
        EXIT(Importe);
    END;

    PROCEDURE Calcular(Interc: Code[20]; SF: Boolean);
    VAR
        IxE: Record "Intercambio x Empresa";
        Contratos: Record 36;
        rAlb: Record "Purch. Rcpt. Header";
        r121: Record "Purch. Rcpt. Line";
        rDev: Record 6650;
        r121D: Record 6651;
        r25: Record 25;
        r21: Record 21;
        r380: Record 380;
        r379: Record 379;
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN ERROR('Especifique filtro fecha');
        if Interc <> '' THEN
            IxE.SETRANGE(IxE."Código Intercambio", Interc);
        Rec.Copyfilter("Date Filter", IxE."Date Filter");

        Conectar;
        Ventana.OPEN('#########1## de #########2##');
        Ventana.UPDATE(2, IxE.COUNT);
        if IxE.FINDFIRST THEN
            REPEAT
                a += 1;
                Ventana.UPDATE(1, a);
                IxE."Contrato sin facturar" := 0;
                if IxE.Cliente <> '' THEN BEGIN
                    Rec.COPYFILTER("Date Filter", Contratos."Posting Date");
                    Contratos.CHANGECOMPANY(IxE.Empresa);
                    Contratos.SETRANGE(Contratos."Bill-to Customer No.", IxE.Cliente);
                    Contratos.SETFILTER(Contratos.Estado, '%1|%2|%3', Contratos.Estado::"Pendiente de Firma",
                    Contratos.Estado::Firmado, Contratos.Estado::"Sin Montar");
                    if Not Sf Then
                        Contratos.SETFILTER(Contratos.Estado, '%1|%2', Contratos.Estado::Firmado, Contratos.Estado::"Sin Montar");
                    Contratos.SETRANGE(Contratos."Document Type", Contratos."Document Type"::Order);
                    Contratos.SETFILTER("Payment Method Code", '%1', 'INTER*');
                    if Contratos.FINDFIRST THEN
                        REPEAT
                            IxE."Contrato sin facturar" -= TotalesDocumentos(Contratos."No.", IxE.Empresa);
                        UNTIL Contratos.NEXT = 0;
                    IxE."Saldo Cliente" := CalculaSaldoC(IxE."Código Intercambio", IxE.Empresa);
                END;
                if IxE.Proveedor <> '' THEN BEGIN
                    IxE."Albaranes sin facturar" := CalculaAlb(Rec.GETRANGEMIN("Date Filter"),
                    Rec.GETRANGEMAX("Date Filter"), IxE."Código Intercambio", IxE.Empresa);
                    IxE."Pedidos pendientes" := CalculaPed(Rec.GETRANGEMIN("Date Filter"),
                    Rec.GETRANGEMAX("Date Filter"), IxE."Código Intercambio", IxE.Empresa);

                    IxE."Saldo Proveedor" := -CalculaSaldoP(IxE."Código Intercambio", IxE.Empresa);

                    rDev.SETRANGE(rDev."Buy-from Vendor No.", IxE.Proveedor);
                    Rec.COPYFILTER("Date Filter", rDev."Posting Date");
                    rDev.SETFILTER("Payment Method Code", '%1', 'INTER*');
                    rDev.CHANGECOMPANY(IxE.Empresa);
                    rDev.SETRANGE(Contabilizado, TRUE);
                    if rDev.FINDFIRST THEN
                        REPEAT
                            r121D.CHANGECOMPANY(IxE.Empresa);
                            r121D.SETRANGE("Document No.", rDev."No.");
                            if r121D.FINDFIRST THEN
                                REPEAT
                                    if Contab(rDev."No.") THEN
                                        IxE."Albaranes sin facturar" -= ((r121D.Quantity - r121D."Quantity Invoiced")
                                        * r121D."Direct Unit Cost" * (1 - r121D."Line Discount %" / 100) * (1 + r121D."VAT %" / 100));
                                UNTIL r121D.NEXT = 0;
                        UNTIL rDev.NEXT = 0;
                END;
                //AlbaranesPendientes(IxE,GETRANGEMIN("Date Filter"),GETRANGEMAXN("Date Filter"));
                IxE.Saldo := IxE."Saldo Cliente" + IxE."Saldo Proveedor" + IxE."Contrato sin facturar" - IxE."Albaranes sin facturar" -
                IxE."Pedidos pendientes";
                IxE.Desde := Rec.GETRANGEMIN("Date Filter");
                IxE.Hasta := Rec.GETRANGEMAX("Date Filter");
                IxE.MODIFY;
                COMMIT;

            UNTIL IxE.NEXT = 0;
        Ventana.CLOSE;
        // Sql.Close;
        // CLEAR(Sql);
    END;

    PROCEDURE FiltroFecha(Desde: Date; Hast: Date);
    BEGIN
        Rec.SETRANGE("Date Filter", Desde, Hast);
    END;

    PROCEDURE CalculaPed(Fdesde: Date; Fhasta: Date; intercam: Code[10]; pEmpresa: Text[30]): Decimal;
    VAR
        c: Label '';
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        Lin: Record "Purchase Line";
        Cab: Record "Purchase Header";
        Intercamcio: Record "Intercambio x Empresa";
    BEGIN
        //     cquery := 'Select ISNULL(CAST(SUM(Importe) as float),0) as Importe From PedidosIntercambio ' +
        //    ' Where [Order Date]>=' + c + FORMAT(Fdesde, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And [order Date]<=' + c + FORMAT(Fhasta, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And Codigo_Inter=' + c + intercam + c + ' AND Empresa=' + c + Empresa + c;
        //     SqlCmd.CommandText := cquery;
        //     SqlAdapter := SqlAdapter.SqlDataAdapter(SqlCmd);
        //     Datatable := Datatable.DataTable;
        //     SqlAdapter.Fill(Datatable);
        //     //     Importe := Datatable.Rows.Item(0).Item('Importe');
        //     SELECT     (SELECT     TOP 1 INTER.[Código Intercambio]
        //        FROM          [Intercambio x Empresa] INTER
        //       WHERE      INTER.Proveedor = LIN.[Buy-from Vendor No_] AND INTER.Empresa = 'Apartamentos los Tilos') AS Codigo_Inter, [Order Date],
        // 'Apartamentos los Tilos' AS Empresa, (([Qty_ to Receive]) 
        //                       * ([Direct Unit Cost] * (1 - [Line Discount %] / 100)) * (1 + [VAT %] / 100)) AS Importe
        // FROM         [Apartamentos los Tilos$Purchase Line] AS LIN
        // WHERE     (SELECT     COUNT(INTER.[Código Intercambio])
        //                        FROM          [Intercambio x Empresa] INTER
        //                        WHERE      INTER.Proveedor = LIN.[Buy-from Vendor No_] AND INTER.Empresa = 'Apartamentos los Tilos') <> 0 AND
        //                           (SELECT     Status
        //                             FROM          [Apartamentos los Tilos$Purchase Header] CAB
        //                             WHERE      CAB.No_ = LIN.[Document No_] AND [Payment Method Code] = 'INTERCAM'
        // AND CAB.[Document Type] = LIN.[Document Type]) < 4 AND (([Qty_ to Receive]) 
        //                       * ([Direct Unit Cost] * (1 - [Line Discount %] / 100)) * (1 + [VAT %] / 100)) <> 0

        Cab.ChangeCompany(pEmpresa);
        Lin.ChangeCompany(pEmpresa);
        Intercamcio.SetRange("Código Intercambio", intercam);
        Intercamcio.SetRange(Empresa, pEmpresa);
        if Not Intercamcio.FindFirst() Then Intercamcio.Init();
        Cab.SetRange("Document Type", Cab."Document Type"::Order);
        Cab.SetRange("Buy-from Vendor No.", Intercamcio.Proveedor);
        Cab.SetRange("Payment Method Code", 'INTERCAM');
        Cab.SetFilter(Status, '<>%1', Cab.Status::Canceled);
        if Cab.FindFirst() Then
            repeat
                Lin.SetRange("Document Type", Cab."Document Type");
                Lin.SetRange("Document No.", Cab."No.");
                if Lin.FindFirst() Then
                    repeat
                        Importe += (((Lin."Qty. to Receive")
                               * (Lin."Direct Unit Cost" * (1 - Lin."Line Discount %" / 100)) * (1 + Lin."VAT %" / 100)));
                    until Lin.Next() = 0;
            until Cab.Next() = 0;
        // if ISCLEAR(Trec) THEN
        //     CREATE(Trec);
        // OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        // LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic

        // Trec.Open(cquery, Sql, OpenMethod, LockMethod);
        // Trec.MoveFirst;
        // Importe := Trec.Fields.Item('Importe').Value;//.Value;
        //Str := ADOrs.Fields.Item('Street').Value;

        //SqlAdd:=SqlAdd.SqlDataAdapter(SqlCmd);
        //Trec:=Trec.DataTable;
        //SqlAdd.Fill(Trec);
        //Lineas:=10000;
        //Lineas:=Trec.Rows.Count;
        // Se recorren los movimientos de Navision
        //a:=0;
        //if Lineas>0 THEN BEGIN
        //  Code:=STRSUBSTNO('%1',Trec.Rows.Item(0).Item('Importe'));
        //  Code:=CONVERTSTR(Code,'.',',');
        //  EVALUATE(Importe,Code);
        //END;
        //CLEAR(Trec);
        EXIT(Importe);
    END;

    PROCEDURE AlbaranesPendientes(pEmpresa: Text[30]; Fdesde: Date; Fhasta: Date; intercam: Code[10]): Decimal;
    VAR
        c: Label '';
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        lin: Record "Purch. Rcpt. Header";
        Det: Record "Purch. Rcpt. Line";
        Inter: Record "Intercambio x Empresa";
    BEGIN
        //     cquery := 'Select ISNULL(CAST(SUM(Importe) as float),0) as Importe From AlbaranesIntercambio ' +
        //    ' Where [Posting Date]>=' + c + FORMAT(Fdesde, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And [Posting Date]<=' + c + FORMAT(Fhasta, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And Codigo_Inter=' + c + intercam + c + ' AND Empresa=' + c + Empresa + c;
        //     SqlCmd.CommandText := cquery;
        //     SqlAdapter := SqlAdapter.SqlDataAdapter(SqlCmd);
        //     Datatable := Datatable.DataTable;
        //     SqlAdapter.Fill(Datatable);
        //     OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        //     LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic

        //     Importe := Datatable.Rows.Item(0).Item('Importe');//.Value;
        //    
        r120.Reset();
        r120.ClearMarks();                                                   //Str := ADOrs.Fields.Item('Street').Value;
        Inter.SetRange(Empresa, pEmpresa);
        Inter.SetRange("Código Intercambio", intercam);
        if Not Inter.FindFirst() then Inter.Init();
        lin.ChangeCompany(pEmpresa);
        lIn.SetRange("Buy-from Vendor No.", Inter.Proveedor);
        Lin.SetRange("Payment Method Code", 'INTERCAM');
        if Lin.FindFirst() Then
            repeat
                Importe := 0;
                Det.ChangeCompany(pEmpresa);
                Det.SetRange("Document No.", lin."No.");
                if Det.FindFirst() Then
                    repeat
                        Importe += ((Det.Quantity - Det."Quantity Invoiced")) * Det."Direct Unit Cost" * (1 - Det."Line Discount %" / 100) * (1 + Det."VAT %" / 100);

                    until Det.Next() = 0;
                if Importe <> 0 Then begin
                    r120.ChangeCompany(pEmpresa);
                    r120.Get(Lin."No.");
                    r120.Mark(true);
                end;
            until Lin.Next() = 0;
        //SqlAdd:=SqlAdd.SqlDataAdapter(SqlCmd);
        //Trec:=Trec.DataTable;
        //SqlAdd.Fill(Trec);
        //Lineas:=10000;
        //Lineas:=Trec.GetRows.Count;
        // Se recorren los movimientos de Navision
        //a:=0;
        //if Lineas>0 THEN BEGIN
        //  Code:=STRSUBSTNO('%1',Trec.Rows.Item(0).Item('Importe'));
        //  Code:=CONVERTSTR(Code,'.',',');
        //  EVALUATE(Importe,Code);
        //END;
        //CLEAR(Trec);
        EXIT(Importe);
    END;

    PROCEDURE PedidosPendientes(pEmpresa: Text[30]; Fdesde: Date; Fhasta: Date; intercam: Code[20]);
    VAR
        rEmp: Record "Company Information";
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        c: Label '';
        Primero: Boolean;
        r121: Record "Purch. Rcpt. Line";
        Documento: Text[30];
        a: Integer;
        b: Integer;
        cab: Record "Purchase Header";
        lin: Record "Purchase Line";
        intercambio: Record "Intercambio x Empresa";
    BEGIN
        Cab.ChangeCompany(pEmpresa);
        r38.ChangeCompany(pEmpresa);
        r38.ReSET;
        r38.ClearMarks();
        Lin.ChangeCompany(pEmpresa);
        Intercambio.SetRange("Código Intercambio", intercam);
        intercambio.SetRange(Empresa, pEmpresa);
        if Not Intercambio.FindFirst() Then Intercambio.Init();
        Cab.SetRange("Buy-from Vendor No.", Intercambio.Proveedor);
        Cab.SetRange("Payment Method Code", 'INTERCAM');
        Cab.setrange("Document Type", Cab."Document Type"::Order);
        Cab.SetFilter(Status, '<>%1', Cab.Status::Canceled);
        if Cab.FindFirst() Then
            repeat
                Lin.SetRange("Document Type", Cab."Document Type");
                Lin.SetRange("Document No.", Cab."No.");
                Importe := 0;
                if Lin.FindFirst() Then
                    repeat
                        Importe += (((Lin."Qty. to Receive")
                               * (Lin."Direct Unit Cost" * (1 - Lin."Line Discount %" / 100)) * (1 + Lin."VAT %" / 100)));
                    until Lin.Next() = 0;
                if Importe <> 0 Then begin
                    r38.Get(Cab."Document Type", cab."No.");
                    r38.Mark(True);
                end;
            until Cab.Next() = 0;
        //UNTIL a>b;
        //Sql.Close;
        //CLEAR(Sql);
        //CLEAR(Trec);
    END;

    PROCEDURE CalcularFecha(Interc: Code[20]): Date;
    VAR
        IxE: Record 7001119;
        Contratos: Record 36;
        rAlb: Record "Purch. Rcpt. Header";
        r121: Record "Purch. Rcpt. Line";
        rDev: Record 6650;
        r121D: Record 6651;
        r25: Record 25;
        r21: Record 21;
        r380: Record 380;
        r379: Record 379;
        Fecha: Date;
    BEGIN
        Fecha := 19800101D;
        if Interc <> '' THEN
            IxE.SETRANGE(IxE."Código Intercambio", Interc);
        if IxE.FINDFIRST THEN
            REPEAT
                a += 1;
                if IxE.Cliente <> '' THEN BEGIN
                    Contratos.CHANGECOMPANY(IxE.Empresa);
                    Contratos.SETCURRENTKEY("Bill-to Customer No.", "Fecha fin proyecto");
                    Contratos.SETRANGE(Contratos."Bill-to Customer No.", IxE.Cliente);
                    Contratos.SETFILTER(Contratos.Estado, '<>%1|<>%2', Contratos.Estado::Anulado, Contratos.Estado::Modificado);
                    //Contratos.Estado::Firmado,Contratos.Estado::"Sin Montar");
                    Contratos.SETRANGE(Contratos."Document Type", Contratos."Document Type"::Order);
                    Contratos.SETFILTER("Payment Method Code", '%1', 'INTER*');
                    if Contratos.FINDLAST THEN BEGIN
                        if Fecha < Contratos."Fecha fin proyecto" THEN Fecha := Contratos."Fecha fin proyecto";
                    END;
                END;
            UNTIL IxE.NEXT = 0;
        EXIT(Fecha);
    END;

    PROCEDURE CalcularEmpresa(Interc: Code[20]; pEmpresa: Text[30]): Text[30];
    VAR
        IxE: Record 7001119;
        Contratos: Record 36;
        rAlb: Record "Purch. Rcpt. Header";
        r121: Record "Purch. Rcpt. Line";
        rDev: Record 6650;
        r121D: Record 6651;
        r25: Record 25;
        r21: Record 21;
        r380: Record 380;
        r379: Record 379;
        Fecha: Date;
    BEGIN
        Fecha := 19800101D;
        if Interc <> '' THEN
            IxE.SETRANGE(IxE."Código Intercambio", Interc);
        if IxE.FINDFIRST THEN
            REPEAT
                a += 1;
                if IxE.Cliente <> '' THEN BEGIN
                    Contratos.CHANGECOMPANY(IxE.Empresa);
                    Contratos.SETCURRENTKEY("Bill-to Customer No.", "Fecha fin proyecto");
                    Contratos.SETRANGE(Contratos."Bill-to Customer No.", IxE.Cliente);
                    Contratos.SETFILTER(Contratos.Estado, '<>%1|<>%2', Contratos.Estado::Anulado, Contratos.Estado::Modificado);
                    //Contratos.Estado::Firmado,Contratos.Estado::"Sin Montar");
                    Contratos.SETRANGE(Contratos."Document Type", Contratos."Document Type"::Order);
                    Contratos.SETFILTER("Payment Method Code", '%1', 'INTER*');
                    if Contratos.FINDLAST THEN BEGIN
                        if Fecha < Contratos."Fecha fin proyecto" THEN BEGIN
                            Fecha := Contratos."Fecha fin proyecto";
                            pEmpresa := IxE.Empresa;
                        END;
                    END;
                END;
            UNTIL IxE.NEXT = 0;
        EXIT(pEmpresa);
    END;
}
page 7001101 "Intercambio x Empresa LP"
{

    Caption = 'Intercambio x Empresa';
    PageType = ListPart;
    SourceTable = "Intercambio x Empresa";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Código Intercambio"; Rec."Código Intercambio")
                {
                    ToolTip = 'Specifies the value of the Código Intercambio field';
                    ApplicationArea = All;
                }
                field(Empresa; Rec.Empresa)
                {
                    ToolTip = 'Specifies the value of the Empresa field';
                    ApplicationArea = All;
                }
                field(Cliente; Rec.Cliente)
                {
                    ToolTip = 'Specifies the value of the Cliente field';
                    ApplicationArea = All;
                }
                field(Nombre; NombreCliente())
                {
                    ApplicationArea = All;
                }
                field("Search Namev"; Rec."Search Namev")
                {
                    ToolTip = 'Specifies the value of the Search Namev field';
                    ApplicationArea = All;
                }
                field(Proveedor; Rec.Proveedor)
                {
                    ToolTip = 'Specifies the value of the Proveedor field';
                    ApplicationArea = All;
                }
                field("Saldo Cliente"; Rec."Saldo Cliente")
                {
                    ToolTip = 'Specifies the value of the Saldo Cliente field';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        rMovCli: Record 21;
                    begin

                        rMovCli.CHANGECOMPANY(Rec.Empresa);
                        rMovCli.SETRANGE(rMovCli."Customer No.", Rec.Cliente);
                        rMovCli.SETRANGE(rMovCli."Payment Method Code", 'INTERCAM');
                        rMovCli.SETRANGE(Open, TRUE);
                        Page.RUNMODAL(0, rMovCli);
                    end;
                }
                field("Saldo Proveedor"; Rec."Saldo Proveedor")
                {
                    ToolTip = 'Specifies the value of the Saldo Proveedor field';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        rMovCli: Record 25;
                    begin

                        rMovCli.CHANGECOMPANY(Rec.Empresa);
                        rMovCli.SETRANGE(rMovCli."Vendor No.", Rec.Proveedor);
                        rMovCli.SETRANGE(rMovCli."Payment Method Code", 'INTERCAM');
                        rMovCli.SETRANGE(Open, TRUE);
                        Page.RUNMODAL(0, rMovCli);
                    end;
                }
                field("Contrato sin facturar"; Rec."Contrato sin facturar")
                {
                    ToolTip = 'Specifies the value of the Contrato sin facturar field';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Contratos: Record 36;
                        Fcontratos: Page "Lista Contratos Venta";
                    begin

                        Contratos.SETRANGE("Posting Date", Rec.Desde, Rec.Hasta);
                        Contratos.CHANGECOMPANY(Rec.Empresa);
                        Contratos.SETRANGE(Contratos."Bill-to Customer No.", Rec.Cliente);
                        Contratos.SETRANGE(Contratos."Document Type", Contratos."Document Type"::Order);
                        Contratos.SETFILTER(Contratos.Estado, '%1|%2|%3', Contratos.Estado::"Pendiente de Firma", Contratos.Estado::Firmado,
                        Contratos.Estado::"Sin Montar");
                        Contratos.SETFILTER("Payment Method Code", '%1', 'INTER*');
                        CLEAR(FContratos);
                        FContratos.CambiarEmpresa(Rec.Empresa);
                        FContratos.SETTABLEVIEW(Contratos);
                        FContratos.RUNMODAL;
                    end;
                }
                field("Albaranes sin facturar"; Rec."Albaranes sin facturar")
                {
                    ToolTip = 'Specifies the value of the Albaranes sin facturar field';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        rDev: Record "Return Shipment Header";
                        Alb: Page "Posted Purchase Receipts";
                        Dev: Page "Posted Return Shipments";
                    begin

                        MESSAGE('Primero aparecen los albaranes y luego las devoluciones');
                        AlbaranesPendientes(Rec.Empresa, Rec.GETRANGEMIN("Date Filter"), Rec.GETRANGEMAX("Date Filter"), Rec."Código Intercambio");
                        CLEAR(Alb);
                        r120.MARKEDONLY(TRUE);

                        //r120.FINDFIRST;
                        Alb.CambiaEmpresa(Rec.Empresa);
                        Alb.SETTABLEVIEW(r120);
                        Alb.RUNMODAL;
                        //FORM.RUNMODAL(0,r120t);
                        rDev.CHANGECOMPANY(Rec.Empresa);
                        rDev.SETRANGE(rDev."Buy-from Vendor No.", Rec.Proveedor);
                        rDev.SETFILTER("Payment Method Code", '%1', 'INTER*');
                        rDev.SETRANGE("Posting Date", Rec.Desde, Rec.Hasta);
                        rDev.SETRANGE(Contabilizado, TRUE);
                        CLEAR(Dev);
                        Dev.CambiaEmpresa(Rec.Empresa);

                        Dev.SETTABLEVIEW(rDev);
                        Dev.RUNMODAL;
                    end;
                }
                field("Pedidos pendientes"; Rec."Pedidos pendientes")
                {
                    ToolTip = 'Specifies the value of the Pedidos pendientes field';
                    ApplicationArea = All;
                    trigger OndrillDown()
                    var
                        Pedido: Page "Purchase List";
                    begin

                        PedidosPendientes(Rec.Empresa, Rec.GETRANGEMIN("Date Filter"), Rec.GETRANGEMAX("Date Filter"), Rec."Código Intercambio");
                        r38.MARKEDONLY(TRUE);
                        //r120.FINDFIRST;
                        CLEAR(Pedido);
                        Pedido.CambiaEmpresa(Rec.Empresa);
                        r38.SETRANGE(r38.Status, 0, 3);
                        r38.SETRANGE("No.");
                        Pedido.SETTABLEVIEW(r38);
                        Pedido.RUNMODAL();
                    end;
                }
                field(Saldo; Rec.Saldo)
                {
                    ToolTip = 'Specifies the value of the Saldo field';
                    ApplicationArea = All;

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("&Calcular")
            {
                ApplicationArea = All;
                Scope = Repeater;
                ShortCutKey = F9;
                Image = Calculate;
                trigger OnAction()
                BEGIN
                    Calcular('', true);
                END;
            }
            action("&Calcular solo firmados")
            {
                ApplicationArea = All;
                Scope = Repeater;
                Image = Signature;
                trigger OnAction()
                BEGIN
                    Calcular('', false);
                END;
            }
            action("&Resumen")
            {
                ApplicationArea = All;
                Scope = Repeater;
                Image = SortAscending;
                trigger OnAction()
                VAR
                    Intercambio: Record Intercambio TEMPORARY;
                    Emp: Record 2000000006;
                    Inter: Record Intercambio;
                BEGIN
                    if Rec.FINDFIRST THEN
                        REPEAT
                            Inter.GET(Rec."Código Intercambio");
                            if Inter."Search Name" = '' THEN Inter."Search Name" := 'Sin clasificar';
                            if NOT Intercambio.GET(Inter."Search Name") THEN BEGIN
                                a += 1;
                                Intercambio.INIT;
                                Intercambio."No." := Inter."Search Name";
                                Intercambio.Name := Inter."Search Name";
                                ;
                                Intercambio."Name 2" := '';
                                Intercambio."Search Name" := Inter."Search Name";
                                Intercambio.INSERT;
                            END;
                            if NOT Intercambio.GET(Inter."No.") THEN BEGIN
                                Intercambio.INIT;
                                Intercambio := Inter;
                                Intercambio.Address := Inter.Name;
                                Intercambio."Last Date Modified" := 19800102D;
                                Intercambio."Credit Limit (LCY)" := 0;
                                Emp.GET(Rec.Empresa);
                                Intercambio."Name 2" := '';
                                if Rec.Saldo <> 0 THEN
                                    Intercambio.INSERT;
                            END;
                            Intercambio."Credit Limit (LCY)" += Rec.Saldo;
                            if Intercambio."Last Date Modified" = 19800102D THEN
                                Intercambio."Last Date Modified" := CalcularFecha(Rec."Código Intercambio");
                            if Intercambio."Name 2" = '' THEN
                                Intercambio."Name 2" := CalcularEmpresa(Rec."Código Intercambio", Emp.Name);

                            if Rec.Saldo <> 0 THEN
                                Intercambio.MODIFY;
                        UNTIL Rec.NEXT = 0;
                    COMMIT;
                    PAGE.RUNMODAL(Page::"Resumen List", Intercambio);
                END;
            }
        }
    }
    var
        Ventana: Dialog;
        a: Integer;
        // Sql: DotNet Sql;
        // SqlAdapter: DotNet SqlAdp;
        // SqlCmd: DotNet SqlCmd;
        // Datatable: DotNet DataTable;
        // //SqlCommand: DotNet "System.Data.SqlClient.SqlCommand";
        //SqlDataReader: DotNet "System.Data.SqlClient.SqlDataReader";
        //Sql: DotNet "System Data" //	Automation	'Microsoft ActiveX Data Objects 2.7 Library'.Connection;
        //Trec:	Automation	'Microsoft ActiveX Data Objects 2.7 Library'.Recordset;
        // cquery: Text[1024];
        // cquery2: Text[1024];
        r120t: Record "Purch. Rcpt. Header" temporary;
        r120: Record "Purch. Rcpt. Header";
        r38: Record "Purchase Header";


    PROCEDURE TotalesDocumentos(No: Code[20]; pEmpresa: Text[30]): Decimal;
    VAR
        Contrato: Record 36;
        rCabVenta: Record 36;
        ImpBorFac: Decimal;
        ImpBorAbo: Decimal;
        ImpFac: Decimal;
        ImpAbo: Decimal;
        rCabFac: Record 112;
        rCabAbo: Record 114;
        RegisVtas: Codeunit 80;
        TotImp: Decimal;
        TotCont: Decimal;
        rCabFacL: Record 113;
        rCabAboL: Record 115;
        SalesLine: Record 37;
        Importe: Decimal;
        BImporte: Decimal;
        BImpBorFac: Decimal;
        BImpBorAbo: Decimal;
        BImpFac: Decimal;
        BImpAbo: Decimal;
        BTotImp: Decimal;
        BTotCont: Decimal;
    BEGIN
        //FCL-31/05/04. Obtengo totales de borradores y facturas correspondientes a este contrato.
        // Contrato.Get(Contrato."Document Type"::Order, No);
        ImpBorFac := 0;
        ImpBorAbo := 0;
        ImpFac := 0;
        ImpAbo := 0;
        WITH Contrato DO BEGIN
            Contrato.CHANGECOMPANY(pEmpresa);
            Contrato.Get(Contrato."Document Type"::Order, No);
            if Estado = Estado::Anulado THEN EXIT(0);
            if Estado = Estado::Cancelado THEN EXIT(0);
            CALCFIELDS(Contrato."Abonos Registrados", Contrato."Facturas Registradas", Contrato."Borradores de Factura",
            Contrato."Borradores de Abono");
            //if ("Borradores de Factura" <> 0) OR ("Borradores de Abono" <> 0) THEN BEGIN
            rCabVenta.RESET;
            rCabVenta.CHANGECOMPANY(pEmpresa);
            rCabVenta.SETCURRENTKEY("Nº Proyecto");
            rCabVenta.SETRANGE("Nº Proyecto", "Nº Proyecto");
            rCabVenta.SETRANGE("Nº Contrato", "No.");
            rCabVenta.SETFILTER("Document Type", '%1|%2',
               rCabVenta."Document Type"::Invoice, rCabVenta."Document Type"::"Credit Memo");
            if rCabVenta.FIND('-') THEN BEGIN
                REPEAT
                    SalesLine.CHANGECOMPANY(pEmpresa);
                    SalesLine.SETRANGE(SalesLine."Document Type", rCabVenta."Document Type");
                    SalesLine.SETRANGE(SalesLine."Document No.", rCabVenta."No.");
                    Importe := 0;
                    BImporte := 0;
                    if SalesLine.FINDFIRST THEN
                        REPEAT
                            Importe += (SalesLine.Quantity * SalesLine."Unit Price" * (1 - SalesLine."Line Discount %" / 100)) * (1 + SalesLine."VAT %" / 100);
                            BImporte += (SalesLine.Quantity * SalesLine."Unit Price" * (1 - SalesLine."Line Discount %" / 100));
                        UNTIL SalesLine.NEXT = 0;
                    if rCabVenta."Document Type" = rCabVenta."Document Type"::Invoice THEN BEGIN
                        //$009(I)
                        //ImpBorFac:=ImpBorFac + TotalSalesLineLCY."Amount Including VAT";
                        ImpBorFac := ImpBorFac + Importe;
                        BImpBorFac := BImpBorFac + BImporte;
                        //$009(F)
                    END
                    ELSE BEGIN
                        //$009(I)
                        //ImpBorAbo:=ImpBorAbo + TotalSalesLineLCY."Amount Including VAT";
                        ImpBorAbo := ImpBorAbo + Importe;
                        BImpBorAbo := BImpBorAbo + BImporte;
                        //$009(F)
                    END;
                UNTIL rCabVenta.NEXT = 0;
            END;

            //END;

            //if "Facturas Registradas" <> 0 THEN BEGIN

            rCabFac.RESET;
            rCabFac.CHANGECOMPANY(pEmpresa);
            rCabFacL.CHANGECOMPANY(pEmpresa);
            rCabFac.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
            rCabFac.SETRANGE("Nº Contrato", "No.");
            if rCabFac.FIND('-') THEN BEGIN
                REPEAT
                    rCabFacL.SETRANGE(rCabFacL."Document No.", rCabFac."No.");
                    if rCabFacL.FINDFIRST THEN
                        rCabFacL.CALCSUMS(rCabFacL."Amount Including VAT", Amount)
                    ELSE
                        rCabFacL.INIT;
                    ImpFac := ImpFac + rCabFacL."Amount Including VAT";
                    BImpFac := BImpFac + rCabFacL.Amount;
                UNTIL rCabFac.NEXT = 0;
            END;

            //END;

            //if "Abonos Registrados" <> 0 THEN BEGIN

            rCabAbo.RESET;
            rCabAbo.CHANGECOMPANY(pEmpresa);
            rCabAboL.CHANGECOMPANY(pEmpresa);
            rCabAbo.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
            rCabAbo.SETRANGE("Nº Contrato", "No.");
            if rCabAbo.FIND('-') THEN BEGIN
                REPEAT
                    rCabAboL.SETRANGE(rCabAboL."Document No.", rCabAbo."No.");
                    if rCabAboL.FINDFIRST THEN
                        rCabAboL.CALCSUMS(rCabAboL."Amount Including VAT", Amount)
                    ELSE
                        rCabAboL.INIT;
                    ImpAbo := ImpAbo + rCabAboL."Amount Including VAT";
                    BImpAbo := BImpAbo + rCabAboL.Amount;
                //$009(F)
                UNTIL rCabAbo.NEXT = 0;
            END;

            //END;

            //FCL-13/02/06. Incluyo sumatorio de totales y diferencia con el total del contrato.
            TotImp := ImpBorFac - ImpBorAbo + ImpFac - ImpAbo;
            BTotImp := BImpBorFac - BImpBorAbo + BImpFac - BImpAbo;
            rCabVenta.Reset();
            rCabVenta.CHANGECOMPANY(pEmpresa);

            if rCabVenta.GET(rCabVenta."Document Type"::Order, No) THEN BEGIN
                SalesLine.Reset();
                SalesLine.CHANGECOMPANY(pEmpresa);
                SalesLine.SETRANGE(SalesLine."Document Type", rCabVenta."Document Type");
                SalesLine.SETRANGE(SalesLine."Document No.", rCabVenta."No.");
                Importe := 0;
                BImporte := 0;
                if SalesLine.FINDFIRST THEN
                    REPEAT
                        Importe += (SalesLine.Quantity * SalesLine."Unit Price" * (1 - SalesLine."Line Discount %" / 100)) * (1 + SalesLine."VAT %" / 100);
                        BImporte += (SalesLine.Quantity * SalesLine."Unit Price" * (1 - SalesLine."Line Discount %" / 100));
                    UNTIL SalesLine.NEXT = 0;

                TotCont := Importe;
                BTotCont := BImporte;
            END;
        END;
        if ABS((BImpBorFac - BImpBorAbo) + (BTotCont - BTotImp)) < 1 THEN EXIT(0);
        EXIT(-((ImpBorFac - ImpBorAbo) + (TotCont - TotImp)));
    END;

    PROCEDURE Contab(Num: Code[20]): Boolean;
    VAR
        Imp: Decimal;
        r17: Record "G/L Entry";
    BEGIN
        r17.SETCURRENTKEY(r17."Document No.");
        r17.SETRANGE(r17."Document No.", Num);
        if r17.FINDFIRST THEN
            REPEAT
                if COPYSTR(r17."G/L Account No.", 1, 1) = '6' THEN Imp := Imp + r17.Amount;
                if COPYSTR(r17."G/L Account No.", 1, 1) = '2' THEN Imp := Imp + r17.Amount;
                if COPYSTR(r17."G/L Account No.", 1, 2) = '47' THEN Imp := Imp + r17.Amount;
            UNTIL r17.NEXT = 0;
        if Imp = 0 THEN EXIT(FALSE);
        EXIT(TRUE);
    END;

    PROCEDURE NombreCliente(): Text[80];
    VAR
        rInter: Record Intercambio;
    BEGIN
        if rInter.GET(Rec."Código Intercambio") THEN EXIT(rInter.Name);
    END;

    PROCEDURE Conectar();
    VAR
    //     oConect: Label 'server=192.168.10.226;database=MALLA2009;Connection Timeout=300;Trusted_Connection=false;Max Pool Size=100;Min Pool Size=5;UID=mac;Pwd=1111',
    //   ENU = 'server=192.168.10.215;database=MALLA;Connection Timeout=300;Trusted_Connection=false;Max Pool Size=100;Min Pool Size=5;UID=mac;Pwd=1111';
    //     ContecionString: Text[1024];
    BEGIN
        // ContecionString := 'Driver={SQL Server};' +
        // 'Server=192.168.10.226;Database=MALLA2009;Connection Timeout=300;' +
        // 'UID=mac;PWD=1111';
        // //if ISCLEAR(Sql) THEN
        // //CREATE(Sql);
        // Sql := Sql.SqlConnection(ContecionString);
        // SqlCmd := Sql.CreateCommand;
        // //SqlCmd.CommandTimeout:=3600;
        // Sql.Open();
        // //Driver={ODBC Driver 13 for SQL Server};server=localhost;database=WideWorldImporters;trusted_connection=Yes;
        // //Sql:=Sql.SqlConnection('server=192.168.10.215;database=MALLA;Connection Timeout=300;'+
        // //'Trusted_Connection=false;Max Pool Size=100;Min Pool Size=5;UID=mac;Pwd=1111');
        // //SqlCmd:=Sql.CreateCommand;
        // //SqlCmd.CommandTimeout:=3600;
        // //Sql.Open();
    END;

    PROCEDURE CalculaAlb(Fdesde: Date; Fhasta: Date; intercam: Code[10]; Empresa: Text[30]): Decimal;
    VAR
        c: Label '';
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        lin: Record "Purch. Rcpt. Header";
        Det: Record "Purch. Rcpt. Line";
        Inter: Record "Intercambio x Empresa";
    BEGIN
        //     cquery := 'Select ISNULL(CAST(SUM(Importe) as float),0) as Importe From AlbaranesIntercambio ' +
        //    ' Where [Posting Date]>=' + c + FORMAT(Fdesde, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And [Posting Date]<=' + c + FORMAT(Fhasta, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And Codigo_Inter=' + c + intercam + c + ' AND Empresa=' + c + Empresa + c;
        //     SqlCmd.CommandText := cquery;
        //     SqlAdapter := SqlAdapter.SqlDataAdapter(SqlCmd);
        //     Datatable := Datatable.DataTable;
        //     SqlAdapter.Fill(Datatable);
        //     OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        //     LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic

        //     Importe := Datatable.Rows.Item(0).Item('Importe');//.Value;
        //                                                       //Str := ADOrs.Fields.Item('Street').Value;
        Inter.SetRange(Empresa, Empresa);
        Inter.SetRange("Código Intercambio", intercam);
        if Not Inter.FindFirst() then Inter.Init();
        lin.ChangeCompany(Empresa);
        lIn.SetRange("Buy-from Vendor No.", Inter.Proveedor);
        Lin.SetRange("Payment Method Code", 'INTERCAM');
        if Lin.FindFirst() Then
            repeat
                Det.ChangeCompany(Empresa);
                Det.SetRange("Document No.", lin."No.");
                if Det.FindFirst() Then
                    repeat
                        Importe += ((Det.Quantity - Det."Quantity Invoiced")) * Det."Direct Unit Cost" * (1 - Det."Line Discount %" / 100) * (1 + Det."VAT %" / 100);
                    until Det.Next() = 0;
            until Lin.Next() = 0;
        //SqlAdd:=SqlAdd.SqlDataAdapter(SqlCmd);
        //Trec:=Trec.DataTable;
        //SqlAdd.Fill(Trec);
        //Lineas:=10000;
        //Lineas:=Trec.GetRows.Count;
        // Se recorren los movimientos de Navision
        //a:=0;
        //if Lineas>0 THEN BEGIN
        //  Code:=STRSUBSTNO('%1',Trec.Rows.Item(0).Item('Importe'));
        //  Code:=CONVERTSTR(Code,'.',',');
        //  EVALUATE(Importe,Code);
        //END;
        //CLEAR(Trec);
        EXIT(Importe);
    END;

    PROCEDURE CalculaSaldoP(intercam: Code[10]; pEmpresa: Text[30]): Decimal;
    VAR
        c: Label '';
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        Inter: Record "Intercambio x Empresa";
        lin: Record 25;
        det: Record 380;
    BEGIN
        //     cquery := 'Select ISNULL(CAST(SUM(Importe) as float),0) as Importe From SaldosProveedoresIntercambio ' +
        //    ' Where Codigo_Inter=' + c + intercam + c + ' AND Empresa=' + c + Empresa + c;
        //     SqlCmd.CommandText := cquery;
        //     SqlAdapter := SqlAdapter.SqlDataAdapter(SqlCmd);
        //     Datatable := Datatable.DataTable;
        //     SqlAdapter.Fill(Datatable);
        //     Importe := Datatable.Rows.Item(0).Item('Importe');
        //     // if ISCLEAR(Trec) THEN
        //     //     CREATE(Trec);
        //     OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        //     LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic

        // Trec.Open(cquery, Sql, OpenMethod, LockMethod);
        // Trec.MoveFirst;
        // Importe := Trec.Fields.Item('Importe').Value;//.Value;
        //Str := ADOrs.Fields.Item('Street').Value;

        //SqlAdd:=SqlAdd.SqlDataAdapter(SqlCmd);
        //Trec:=Trec.DataTable;
        //SqlAdd.Fill(Trec);
        //Lineas:=10000;
        //Lineas:=Trec.Rows.Count;
        // Se recorren los movimientos de Navision
        //a:=0;
        //if Lineas>0 THEN BEGIN
        //  Code:=STRSUBSTNO('%1',Trec.Rows.Item(0).Item('Importe'));
        //  Code:=CONVERTSTR(Code,'.',',');
        //  EVALUATE(Importe,Code);
        //END;
        //CLEAR(Trec);
        Inter.SetRange(Empresa, pEmpresa);
        Inter.SetRange("Código Intercambio", intercam);
        if Not Inter.FindFirst() then Inter.Init();
        lin.ChangeCompany(pEmpresa);
        lIn.SetRange("Vendor No.", Inter.Proveedor);
        Lin.SetRange("Payment Method Code", 'INTERCAM');
        if Lin.FindFirst() Then
            repeat
                Det.ChangeCompany(pEmpresa);
                Det.SetRange("Vendor Ledger Entry No.", lin."Entry No.");
                //Det.FindFirst();
                Det.Calcsums(Amount);
                Importe += Det.Amount;
            until Lin.Next() = 0;
        EXIT(-Importe);
    END;

    PROCEDURE CalculaSaldoC(intercam: Code[10]; pEmpresa: Text[30]): Decimal;
    VAR
        c: Label '';
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        SaldoInter: Record 379;
        Inter: Record "Intercambio x Empresa";
        Lin: Record "Cust. Ledger Entry";
    BEGIN
        //         SELECT     (SELECT     TOP 1 INTER.[Código Intercambio]
        //            FROM          [Intercambio x Empresa] INTER
        //        WHERE      INTER.Cliente = LIN.[Customer No_] AND INTER.Empresa = 'Apartamentos los Tilos') AS Codigo_Inter, [Posting Date], 'Apartamentos los Tilos' AS Empresa,
        //                           (SELECT     Sum([Amount (LCY)])
        //                             FROM          [Apartamentos los Tilos$Detailed Cust_ Ledg_ Entry] DET
        //                             WHERE      Det.[Cust_ Ledger Entry No_] = Lin.[Entry No_]) AS Importe
        // FROM         [Apartamentos los Tilos$Cust_ Ledger Entry] AS LIN
        // WHERE     (SELECT     COUNT(INTER.[Código Intercambio])
        //                        FROM          [Intercambio x Empresa] INTER
        //                        WHERE      INTER.Cliente = LIN.[Customer No_] AND INTER.Empresa = 'Apartamentos los Tilos') <> 0 AND LIN.[Cod_ Forma Pago] = 'INTERCAM'
        // AND LIN.[Open] = 1
        //cquery := 'Select ISNULL(CAST(SUM(Importe) as float),0) as Importe From SaldosClientesIntercambio ' +
        //' Where Codigo_Inter=' + c + intercam + c + ' AND Empresa=' + c + Empresa + c;
        // if ISCLEAR(Trec) THEN
        //     CREATE(Trec);
        // OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        // LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic

        // Trec.Open(cquery, Sql, OpenMethod, LockMethod);
        // Trec.MoveFirst;
        // Importe := Trec.Fields.Item('Importe').Value;//.Value;
        //      
        Inter.SetRange(Empresa, pEmpresa);
        Inter.SetRange("Código Intercambio", intercam);
        if Not Inter.FindFirst() then Inter.Init();
        lin.ChangeCompany(pEmpresa);
        lIn.SetRange("Customer No.", Inter.Cliente);
        Lin.SetRange("Payment Method Code", 'INTERCAM');
        Lin.SetRange(Open, true);
        if Lin.FindFirst() Then
            repeat

                SaldoInter.ChangeCompany(pEmpresa);
                SaldoInter.SetRange("Cust. Ledger Entry No.", Lin."Entry No.");
                SaldoInter.CalcSums("Amount (LCY)");
                Importe += SaldoInter."Amount (LCY)";
            until Lin.Next() = 0;
        exit(Importe);

        //Str := ADOrs.Fields.Item('Street').Value;
        // SqlCmd.CommandText := cquery;
        // SqlAdapter := SqlAdapter.SqlDataAdapter(SqlCmd);
        // Datatable := Datatable.DataTable;
        // SqlAdapter.Fill(Datatable);
        // Importe := Datatable.Rows.Item(0).Item('Importe');
        //SqlAdd:=SqlAdd.SqlDataAdapter(SqlCmd);
        //Trec:=Trec.DataTable;
        //SqlAdd.Fill(Trec);
        //Lineas:=10000;
        //Lineas:=Trec.Rows.Count;
        // Se recorren los movimientos de Navision
        //a:=0;
        //if Lineas>0 THEN BEGIN
        //  Code:=STRSUBSTNO('%1',Trec.Rows.Item(0).Item('Importe'));
        //  Code:=CONVERTSTR(Code,'.',',');
        //  EVALUATE(Importe,Code);
        //END;
        //CLEAR(Trec);
        EXIT(Importe);
    END;

    PROCEDURE Calcular(Interc: Code[20]; SF: Boolean);
    VAR
        IxE: Record "Intercambio x Empresa";
        Contratos: Record 36;
        rAlb: Record "Purch. Rcpt. Header";
        r121: Record "Purch. Rcpt. Line";
        rDev: Record 6650;
        r121D: Record 6651;
        r25: Record 25;
        r21: Record 21;
        r380: Record 380;
        r379: Record 379;
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN ERROR('Especifique filtro fecha');
        if Interc <> '' THEN
            IxE.SETRANGE(IxE."Código Intercambio", Interc);
        Rec.Copyfilter("Date Filter", IxE."Date Filter");

        Conectar;
        Ventana.OPEN('#########1## de #########2##');
        Ventana.UPDATE(2, IxE.COUNT);
        if IxE.FINDFIRST THEN
            REPEAT
                a += 1;
                Ventana.UPDATE(1, a);
                IxE."Contrato sin facturar" := 0;
                if IxE.Cliente <> '' THEN BEGIN
                    Rec.COPYFILTER("Date Filter", Contratos."Posting Date");
                    Contratos.CHANGECOMPANY(IxE.Empresa);
                    Contratos.SETRANGE(Contratos."Bill-to Customer No.", IxE.Cliente);
                    Contratos.SETFILTER(Contratos.Estado, '%1|%2|%3', Contratos.Estado::"Pendiente de Firma",
                    Contratos.Estado::Firmado, Contratos.Estado::"Sin Montar");
                    if Not Sf Then
                        Contratos.SETFILTER(Contratos.Estado, '%1|%2', Contratos.Estado::Firmado, Contratos.Estado::"Sin Montar");
                    Contratos.SETRANGE(Contratos."Document Type", Contratos."Document Type"::Order);
                    Contratos.SETFILTER("Payment Method Code", '%1', 'INTER*');
                    if Contratos.FINDFIRST THEN
                        REPEAT
                            IxE."Contrato sin facturar" -= TotalesDocumentos(Contratos."No.", IxE.Empresa);
                        UNTIL Contratos.NEXT = 0;
                    IxE."Saldo Cliente" := CalculaSaldoC(IxE."Código Intercambio", IxE.Empresa);
                END;
                if IxE.Proveedor <> '' THEN BEGIN
                    IxE."Albaranes sin facturar" := CalculaAlb(Rec.GETRANGEMIN("Date Filter"),
                    Rec.GETRANGEMAX("Date Filter"), IxE."Código Intercambio", IxE.Empresa);
                    IxE."Pedidos pendientes" := CalculaPed(Rec.GETRANGEMIN("Date Filter"),
                    Rec.GETRANGEMAX("Date Filter"), IxE."Código Intercambio", IxE.Empresa);

                    IxE."Saldo Proveedor" := -CalculaSaldoP(IxE."Código Intercambio", IxE.Empresa);

                    rDev.SETRANGE(rDev."Buy-from Vendor No.", IxE.Proveedor);
                    Rec.COPYFILTER("Date Filter", rDev."Posting Date");
                    rDev.SETFILTER("Payment Method Code", '%1', 'INTER*');
                    rDev.CHANGECOMPANY(IxE.Empresa);
                    rDev.SETRANGE(Contabilizado, TRUE);
                    if rDev.FINDFIRST THEN
                        REPEAT
                            r121D.CHANGECOMPANY(IxE.Empresa);
                            r121D.SETRANGE("Document No.", rDev."No.");
                            if r121D.FINDFIRST THEN
                                REPEAT
                                    if Contab(rDev."No.") THEN
                                        IxE."Albaranes sin facturar" -= ((r121D.Quantity - r121D."Quantity Invoiced")
                                        * r121D."Direct Unit Cost" * (1 - r121D."Line Discount %" / 100) * (1 + r121D."VAT %" / 100));
                                UNTIL r121D.NEXT = 0;
                        UNTIL rDev.NEXT = 0;
                END;
                //AlbaranesPendientes(IxE,GETRANGEMIN("Date Filter"),GETRANGEMAXN("Date Filter"));
                IxE.Saldo := IxE."Saldo Cliente" + IxE."Saldo Proveedor" + IxE."Contrato sin facturar" - IxE."Albaranes sin facturar" -
                IxE."Pedidos pendientes";
                IxE.Desde := Rec.GETRANGEMIN("Date Filter");
                IxE.Hasta := Rec.GETRANGEMAX("Date Filter");
                IxE.MODIFY;
                COMMIT;

            UNTIL IxE.NEXT = 0;
        Ventana.CLOSE;
        // Sql.Close;
        // CLEAR(Sql);
    END;

    PROCEDURE FiltroFecha(Desde: Date; Hast: Date);
    BEGIN
        Rec.SETRANGE("Date Filter", Desde, Hast);
    END;

    PROCEDURE CalculaPed(Fdesde: Date; Fhasta: Date; intercam: Code[10]; pEmpresa: Text[30]): Decimal;
    VAR
        c: Label '';
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        Lin: Record "Purchase Line";
        Cab: Record "Purchase Header";
        Intercamcio: Record "Intercambio x Empresa";
    BEGIN
        //     cquery := 'Select ISNULL(CAST(SUM(Importe) as float),0) as Importe From PedidosIntercambio ' +
        //    ' Where [Order Date]>=' + c + FORMAT(Fdesde, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And [order Date]<=' + c + FORMAT(Fhasta, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And Codigo_Inter=' + c + intercam + c + ' AND Empresa=' + c + Empresa + c;
        //     SqlCmd.CommandText := cquery;
        //     SqlAdapter := SqlAdapter.SqlDataAdapter(SqlCmd);
        //     Datatable := Datatable.DataTable;
        //     SqlAdapter.Fill(Datatable);
        //     //     Importe := Datatable.Rows.Item(0).Item('Importe');
        //     SELECT     (SELECT     TOP 1 INTER.[Código Intercambio]
        //        FROM          [Intercambio x Empresa] INTER
        //       WHERE      INTER.Proveedor = LIN.[Buy-from Vendor No_] AND INTER.Empresa = 'Apartamentos los Tilos') AS Codigo_Inter, [Order Date],
        // 'Apartamentos los Tilos' AS Empresa, (([Qty_ to Receive]) 
        //                       * ([Direct Unit Cost] * (1 - [Line Discount %] / 100)) * (1 + [VAT %] / 100)) AS Importe
        // FROM         [Apartamentos los Tilos$Purchase Line] AS LIN
        // WHERE     (SELECT     COUNT(INTER.[Código Intercambio])
        //                        FROM          [Intercambio x Empresa] INTER
        //                        WHERE      INTER.Proveedor = LIN.[Buy-from Vendor No_] AND INTER.Empresa = 'Apartamentos los Tilos') <> 0 AND
        //                           (SELECT     Status
        //                             FROM          [Apartamentos los Tilos$Purchase Header] CAB
        //                             WHERE      CAB.No_ = LIN.[Document No_] AND [Payment Method Code] = 'INTERCAM'
        // AND CAB.[Document Type] = LIN.[Document Type]) < 4 AND (([Qty_ to Receive]) 
        //                       * ([Direct Unit Cost] * (1 - [Line Discount %] / 100)) * (1 + [VAT %] / 100)) <> 0

        Cab.ChangeCompany(pEmpresa);
        Lin.ChangeCompany(pEmpresa);
        Intercamcio.SetRange("Código Intercambio", intercam);
        Intercamcio.SetRange(Empresa, pEmpresa);
        if Not Intercamcio.FindFirst() Then Intercamcio.Init();
        Cab.SetRange("Document Type", Cab."Document Type"::Order);
        Cab.SetRange("Buy-from Vendor No.", Intercamcio.Proveedor);
        Cab.SetRange("Payment Method Code", 'INTERCAM');
        Cab.SetFilter(Status, '<>%1', Cab.Status::Canceled);
        if Cab.FindFirst() Then
            repeat
                Lin.SetRange("Document Type", Cab."Document Type");
                Lin.SetRange("Document No.", Cab."No.");
                if Lin.FindFirst() Then
                    repeat
                        Importe += (((Lin."Qty. to Receive")
                               * (Lin."Direct Unit Cost" * (1 - Lin."Line Discount %" / 100)) * (1 + Lin."VAT %" / 100)));
                    until Lin.Next() = 0;
            until Cab.Next() = 0;
        // if ISCLEAR(Trec) THEN
        //     CREATE(Trec);
        // OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        // LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic

        // Trec.Open(cquery, Sql, OpenMethod, LockMethod);
        // Trec.MoveFirst;
        // Importe := Trec.Fields.Item('Importe').Value;//.Value;
        //Str := ADOrs.Fields.Item('Street').Value;

        //SqlAdd:=SqlAdd.SqlDataAdapter(SqlCmd);
        //Trec:=Trec.DataTable;
        //SqlAdd.Fill(Trec);
        //Lineas:=10000;
        //Lineas:=Trec.Rows.Count;
        // Se recorren los movimientos de Navision
        //a:=0;
        //if Lineas>0 THEN BEGIN
        //  Code:=STRSUBSTNO('%1',Trec.Rows.Item(0).Item('Importe'));
        //  Code:=CONVERTSTR(Code,'.',',');
        //  EVALUATE(Importe,Code);
        //END;
        //CLEAR(Trec);
        EXIT(Importe);
    END;

    PROCEDURE AlbaranesPendientes(pEmpresa: Text[30]; Fdesde: Date; Fhasta: Date; intercam: Code[10]): Decimal;
    VAR
        c: Label '';
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        lin: Record "Purch. Rcpt. Header";
        Det: Record "Purch. Rcpt. Line";
        Inter: Record "Intercambio x Empresa";
    BEGIN
        //     cquery := 'Select ISNULL(CAST(SUM(Importe) as float),0) as Importe From AlbaranesIntercambio ' +
        //    ' Where [Posting Date]>=' + c + FORMAT(Fdesde, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And [Posting Date]<=' + c + FORMAT(Fhasta, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //    ' And Codigo_Inter=' + c + intercam + c + ' AND Empresa=' + c + Empresa + c;
        //     SqlCmd.CommandText := cquery;
        //     SqlAdapter := SqlAdapter.SqlDataAdapter(SqlCmd);
        //     Datatable := Datatable.DataTable;
        //     SqlAdapter.Fill(Datatable);
        //     OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        //     LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic

        //     Importe := Datatable.Rows.Item(0).Item('Importe');//.Value;
        //    
        r120.Reset();
        r120.ClearMarks();                                                   //Str := ADOrs.Fields.Item('Street').Value;
        Inter.SetRange(Empresa, pEmpresa);
        Inter.SetRange("Código Intercambio", intercam);
        if Not Inter.FindFirst() then Inter.Init();
        lin.ChangeCompany(pEmpresa);
        lIn.SetRange("Buy-from Vendor No.", Inter.Proveedor);
        Lin.SetRange("Payment Method Code", 'INTERCAM');
        if Lin.FindFirst() Then
            repeat
                Importe := 0;
                Det.ChangeCompany(pEmpresa);
                Det.SetRange("Document No.", lin."No.");
                if Det.FindFirst() Then
                    repeat
                        Importe += ((Det.Quantity - Det."Quantity Invoiced")) * Det."Direct Unit Cost" * (1 - Det."Line Discount %" / 100) * (1 + Det."VAT %" / 100);

                    until Det.Next() = 0;
                if Importe <> 0 Then begin
                    r120.ChangeCompany(pEmpresa);
                    r120.Get(Lin."No.");
                    r120.Mark(true);
                end;
            until Lin.Next() = 0;
        //SqlAdd:=SqlAdd.SqlDataAdapter(SqlCmd);
        //Trec:=Trec.DataTable;
        //SqlAdd.Fill(Trec);
        //Lineas:=10000;
        //Lineas:=Trec.GetRows.Count;
        // Se recorren los movimientos de Navision
        //a:=0;
        //if Lineas>0 THEN BEGIN
        //  Code:=STRSUBSTNO('%1',Trec.Rows.Item(0).Item('Importe'));
        //  Code:=CONVERTSTR(Code,'.',',');
        //  EVALUATE(Importe,Code);
        //END;
        //CLEAR(Trec);
        EXIT(Importe);
    END;

    PROCEDURE PedidosPendientes(pEmpresa: Text[30]; Fdesde: Date; Fhasta: Date; intercam: Code[20]);
    VAR
        rEmp: Record "Company Information";
        Importe: Decimal;
        Code: Text[30];
        Lineas: Integer;
        OpenMethod: Integer;
        LockMethod: Integer;
        c: Label '';
        Primero: Boolean;
        r121: Record "Purch. Rcpt. Line";
        Documento: Text[30];
        a: Integer;
        b: Integer;
        cab: Record "Purchase Header";
        lin: Record "Purchase Line";
        intercambio: Record "Intercambio x Empresa";
    BEGIN
        //    Conectar;
        //    rEmp.ChangeCompany(pEmpresa);
        //    rEmp.GET();
        //     cquery := 'SELECT     (SELECT     TOP 1 INTER.[Código Intercambio] ' +
        //    'FROM          [Intercambio x Empresa] INTER ' +
        //    'WHERE      INTER.Proveedor = LIN.[Buy-from Vendor No_] AND INTER.Empresa = ' + c + pEmpresa + c + ') ' +
        //    'AS Codigo_Inter, ' + c + pEmpresa + c + ' AS Empresa, ' +
        //    '(([Qty_ to Receive]) * ([Direct Unit Cost] * (1 - [Line Discount %] / 100)) *(1+"VAT %"/100)) AS Importe '
        //    + ',[Document No_] As Documento ' +
        //    ' FROM [' + rEmp."Nombre Ficheros" + '$Purchase Line] AS LIN ' +
        //    'WHERE (SELECT     COUNT(INTER.[Código Intercambio]) ' +
        //    'FROM  [Intercambio x Empresa] INTER';
        //     cquery2 := ' WHERE INTER.Proveedor = LIN.[Buy-from Vendor No_] AND INTER.Empresa = ' + c + pEmpresa + c +
        //     ' AND INTER.[Código Intercambio]=' + c + "Código Intercambio" + c + ') <> 0' +
        //     ' AND (([Qty_ to Receive]) * ([Direct Unit Cost] * (1 - [Line Discount %] / 100)) *(1+"VAT %"/100))<>0 ' +
        //     ' AND (Select [Posting Date] From [' + rEmp."Nombre Ficheros" + '$Purchase Header] CAB' +
        //     ' Where CAB.[Document Type]=LIN.[Document Type]  AND [Payment Method Code]=' + c + 'INTERCAM' + c + 'AND' +
        //     ' CAB."No_"=LIN.[Document No_])  >=' + c + FORMAT(Fdesde, 0, '<Day,2>/<Month,2>/<Year>') + c +
        //     ' AND (Select [Posting Date] From [' + rEmp."Nombre Ficheros" + '$Purchase Header] CAB' +
        //     ' Where CAB.[Document Type]=LIN.[Document Type] AND' +
        //     ' CAB."No_"=LIN.[Document No_]) <=' + c + FORMAT(Fhasta, 0, '<Day,2>/<Month,2>/<Year>') + c;
        //     SqlCmd.CommandText := cquery + cquery2;
        //     SqlAdapter := SqlAdapter.SqlDataAdapter(SqlCmd);
        //     Datatable := Datatable.DataTable;
        //     SqlAdapter.Fill(Datatable);
        //     Lineas := 10000;
        //     Lineas := Datatable.Rows.Count;
        //   if ISCLEAR(Trec) THEN
        //   //ERROR(cquery);
        //   CREATE(Trec);
        //   OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        //   LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic

        //   Trec.Open(cquery+cquery2,Sql,OpenMethod,LockMethod);
        // r38.CLEARMARKS;
        // a := 0;
        // //b:=Trec.RecordCount();
        // Primero := TRUE;
        // r38.RESET;
        // Cab.ChangeCompany(Empresa);
        // Lin.ChangeCompany(Empresa);
        // if Intercambio.FindFirst() Then
        //     repeat
        //         cab.SetRange("Buy-from Vendor No.", Intercambio.Proveedor);
        //         //cab.SetRange(Contabilizado,True);
        //         cab.SetRange("Payment Method Code", 'INTERCAM');
        //         cab.SetRange("Posting Date", Fdesde, Fhasta);
        //         if cab.FindFirst() Then
        //             repeat
        //                 lin.SetRange("Document No.", cab."No.");
        //                 if lin.FindFirst() then
        //                     repeat
        //                         while ((lin."Qty. to Receive") * (lin."Direct Unit Cost" * (1 - lin."Line Discount %" / 100)) * (1 + lin."VAT %" / 100)) <> 0 do begin
        //                             //WHILE NOT Trec.EOF DO BEGIN
        //                             //REPEAT

        //                             //    if Primero THEN Trec.MoveFirst
        //                             //    ELSE
        //                             //     Trec.MoveNext;
        //                             //   if NOT Trec.EOF THEN
        //                             //    BEGIN

        //                             r38.CHANGECOMPANY(pEmpresa);
        //                             Primero := FALSE;
        //                             Documento := lin."Document No.";
        //                             r38.SETFILTER(r38."Document Type", '%1|%2'
        //                             , r38."Document Type"::Order, r38."Document Type"::"Return Order");

        //                             r38.SETRANGE(r38."No.", Documento);
        //                             if r38.FINDFIRST THEN
        //                                 r38.MARK := TRUE;
        //                             //END ;//ELSE b:=99;
        //                             a += 1;
        //                             lin.FindLast();
        //                         END;
        //                     until lin.Next() = 0;
        //             until cab.Next() = 0;
        //     until intercambio.Next() = 0;
        Cab.ChangeCompany(pEmpresa);
        r38.ChangeCompany(pEmpresa);
        Lin.ChangeCompany(pEmpresa);
        Intercambio.SetRange("Código Intercambio", intercam);
        intercambio.SetRange(Empresa, pEmpresa);
        if Not Intercambio.FindFirst() Then Intercambio.Init();
        Cab.SetRange("Buy-from Vendor No.", Intercambio.Proveedor);
        Cab.SetRange("Payment Method Code", 'INTERCAM');
        Cab.SetFilter(Status, '<>%1', Cab.Status::Canceled);
        if Cab.FindFirst() Then
            repeat
                Lin.SetRange("Document Type", Cab."Document Type");
                Lin.SetRange("Document No.", Cab."No.");
                Importe := 0;
                if Lin.FindFirst() Then
                    repeat
                        Importe += (((Lin."Qty. to Receive")
                               * (Lin."Direct Unit Cost" * (1 - Lin."Line Discount %" / 100)) * (1 + Lin."VAT %" / 100)));
                    until Lin.Next() = 0;
                if Importe <> 0 Then begin
                    r38.Get(Cab."Document Type", cab."No.");
                    r38.Mark(True);
                end;
            until Cab.Next() = 0;
        //UNTIL a>b;
        //Sql.Close;
        //CLEAR(Sql);
        //CLEAR(Trec);
    END;

    PROCEDURE CalcularFecha(Interc: Code[20]): Date;
    VAR
        IxE: Record 7001119;
        Contratos: Record 36;
        rAlb: Record "Purch. Rcpt. Header";
        r121: Record "Purch. Rcpt. Line";
        rDev: Record 6650;
        r121D: Record 6651;
        r25: Record 25;
        r21: Record 21;
        r380: Record 380;
        r379: Record 379;
        Fecha: Date;
    BEGIN
        Fecha := 19800101D;
        if Interc <> '' THEN
            IxE.SETRANGE(IxE."Código Intercambio", Interc);
        if IxE.FINDFIRST THEN
            REPEAT
                a += 1;
                if IxE.Cliente <> '' THEN BEGIN
                    Contratos.CHANGECOMPANY(IxE.Empresa);
                    Contratos.SETCURRENTKEY("Bill-to Customer No.", "Fecha fin proyecto");
                    Contratos.SETRANGE(Contratos."Bill-to Customer No.", IxE.Cliente);
                    Contratos.SETFILTER(Contratos.Estado, '<>%1|<>%2', Contratos.Estado::Anulado, Contratos.Estado::Modificado);
                    //Contratos.Estado::Firmado,Contratos.Estado::"Sin Montar");
                    Contratos.SETRANGE(Contratos."Document Type", Contratos."Document Type"::Order);
                    Contratos.SETFILTER("Payment Method Code", '%1', 'INTER*');
                    if Contratos.FINDLAST THEN BEGIN
                        if Fecha < Contratos."Fecha fin proyecto" THEN Fecha := Contratos."Fecha fin proyecto";
                    END;
                END;
            UNTIL IxE.NEXT = 0;
        EXIT(Fecha);
    END;

    PROCEDURE CalcularEmpresa(Interc: Code[20]; pEmpresa: Text[30]): Text[30];
    VAR
        IxE: Record 7001119;
        Contratos: Record 36;
        rAlb: Record "Purch. Rcpt. Header";
        r121: Record "Purch. Rcpt. Line";
        rDev: Record 6650;
        r121D: Record 6651;
        r25: Record 25;
        r21: Record 21;
        r380: Record 380;
        r379: Record 379;
        Fecha: Date;
    BEGIN
        Fecha := 19800101D;
        if Interc <> '' THEN
            IxE.SETRANGE(IxE."Código Intercambio", Interc);
        if IxE.FINDFIRST THEN
            REPEAT
                a += 1;
                if IxE.Cliente <> '' THEN BEGIN
                    Contratos.CHANGECOMPANY(IxE.Empresa);
                    Contratos.SETCURRENTKEY("Bill-to Customer No.", "Fecha fin proyecto");
                    Contratos.SETRANGE(Contratos."Bill-to Customer No.", IxE.Cliente);
                    Contratos.SETFILTER(Contratos.Estado, '<>%1|<>%2', Contratos.Estado::Anulado, Contratos.Estado::Modificado);
                    //Contratos.Estado::Firmado,Contratos.Estado::"Sin Montar");
                    Contratos.SETRANGE(Contratos."Document Type", Contratos."Document Type"::Order);
                    Contratos.SETFILTER("Payment Method Code", '%1', 'INTER*');
                    if Contratos.FINDLAST THEN BEGIN
                        if Fecha < Contratos."Fecha fin proyecto" THEN BEGIN
                            Fecha := Contratos."Fecha fin proyecto";
                            pEmpresa := IxE.Empresa;
                        END;
                    END;
                END;
            UNTIL IxE.NEXT = 0;
        EXIT(pEmpresa);
    END;
}
