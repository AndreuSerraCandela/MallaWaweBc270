/// <summary>
/// Page Proveedores x Empresa (ID 7001100).
/// </summary>
page 7001100 "Proveedores x Empresa"
{

    ApplicationArea = All;
    Caption = 'Proveedores x Empresa';
    PageType = ListPart;
    SourceTable = "Proveedores x Empresa";


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Código Proveedor"; Rec."Código Proveedor")
                {
                    ToolTip = 'Specifies the value of the Código ProveedorCompra field';
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
                field(Nombre; NombreProveedor())
                {
                    ApplicationArea = All;
                }

                field(Proveedor; Rec.Proveedor)
                {
                    ToolTip = 'Specifies the value of the Proveedor field';
                    ApplicationArea = All;
                }

                field(Compras; Rec."Saldo")
                {
                    ToolTip = 'Specifies the value of the Saldo Proveedor field';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        rMovCli: Record 38;
                    begin

                        rMovCli.CHANGECOMPANY(Rec.Empresa);
                        Rec.CopyFilter("Date Filter", rMovCli."Posting Date");
                        rMovCli.SETRANGE(rMovCli."Buy-From Vendor No.", Rec.Proveedor);
                        Page.RUNMODAL(0, rMovCli);
                    end;
                }
                // field("Contrato sin facturar"; Rec."Contrato sin facturar")
                // {
                //     ToolTip = 'Specifies the value of the Contrato sin facturar field';
                //     ApplicationArea = All;
                //     trigger OnDrillDown()
                //     var
                //         Contratos: Record 36;
                //         Fcontratos: Page "Lista Contratos Venta";
                //     begin

                //         Contratos.SETRANGE("Posting Date", Rec.Desde, Rec.Hasta);
                //         Contratos.CHANGECOMPANY(Rec.Empresa);
                //         Contratos.SETRANGE(Contratos."Bill-to Customer No.", Rec.Cliente);
                //         Contratos.SETRANGE(Contratos."Document Type", Contratos."Document Type"::Order);
                //         Contratos.SETFILTER(Contratos.Estado, '%1|%2|%3', Contratos.Estado::"Pendiente de Firma", Contratos.Estado::Firmado,
                //         Contratos.Estado::"Sin Montar");
                //         Contratos.SETFILTER("Payment Method Code", '%1', 'INTER*');
                //         CLEAR(FContratos);
                //         FContratos.CambiarEmpresa(Rec.Empresa);
                //         FContratos.SETTABLEVIEW(Contratos);
                //         FContratos.RUNMODAL;
                //     end;
                // }
                // field("Albaranes sin facturar"; Rec."Albaranes sin facturar")
                // {
                //     ToolTip = 'Specifies the value of the Albaranes sin facturar field';
                //     ApplicationArea = All;
                //     trigger OnDrillDown()
                //     var
                //         rDev: Record "Return Shipment Header";
                //         Alb: Page "Posted Purchase Receipts";
                //         Dev: Page "Posted Return Shipments";
                //     begin

                //         MESSAGE('Primero aparecen los albaranes y luego las devoluciones');
                //         AlbaranesPendientes(Rec.Empresa, Rec.GETRANGEMIN("Date Filter"), Rec.GETRANGEMAX("Date Filter"), Rec."Código ProveedorCompra");
                //         CLEAR(Alb);
                //         r120.MARKEDONLY(TRUE);

                //         //r120.FINDFIRST;
                //         Alb.CambiaEmpresa(Rec.Empresa);
                //         Alb.SETTABLEVIEW(r120);
                //         Alb.RUNMODAL;
                //         //FORM.RUNMODAL(0,r120t);
                //         rDev.CHANGECOMPANY(Rec.Empresa);
                //         rDev.SETRANGE(rDev."Buy-from Vendor No.", Rec.Proveedor);
                //         rDev.SETRANGE("Posting Date", Rec.Desde, Rec.Hasta);
                //         rDev.SETRANGE(Contabilizado, TRUE);
                //         CLEAR(Dev);
                //         Dev.CambiaEmpresa(Rec.Empresa);

                //         Dev.SETTABLEVIEW(rDev);
                //         Dev.RUNMODAL;
                //     end;
                // }
                // field("Pedidos pendientes"; Rec."Pedidos pendientes")
                // {
                //     ToolTip = 'Specifies the value of the Pedidos pendientes field';
                //     ApplicationArea = All;
                //     trigger OndrillDown()
                //     var
                //         Pedido: Page "Purchase List";
                //     begin

                //         PedidosPendientes(Rec.Empresa, Rec.GETRANGEMIN("Date Filter"), Rec.GETRANGEMAX("Date Filter"), Rec."Código ProveedorCompra");
                //         r38.MARKEDONLY(TRUE);
                //         //r120.FINDFIRST;
                //         CLEAR(Pedido);
                //         Pedido.CambiaEmpresa(Rec.Empresa);
                //         r38.SETRANGE(r38.Status, 0, 3);
                //         r38.SETRANGE("No.");
                //         Pedido.SETTABLEVIEW(r38);
                //         Pedido.RUNMODAL();
                //     end;
                // }
                // field(Saldo; Rec.Saldo)
                // {
                //     ToolTip = 'Specifies the value of the Saldo field';
                //     ApplicationArea = All;

                // }
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
                trigger OnAction()
                BEGIN
                    Calcular('');
                END;
            }
            // action("&Resumen")
            // {
            //     ApplicationArea = All;
            //     Scope = Repeater;
            //     trigger OnAction()
            //     VAR
            //         ProveedorCompra: Record "Proveedores Compra" TEMPORARY;
            //         Emp: Record 2000000006;
            //         Inter: Record "Proveedores Compra";
            //     BEGIN
            //         if Rec.FINDFIRST THEN
            //             REPEAT
            //                 Inter.GET(Rec."Código Proveedor");
            //                 if Inter."Search Name" = '' THEN Inter."Search Name" := 'Sin clasificar';
            //                 if NOT ProveedorCompra.GET(Inter."Search Name") THEN BEGIN
            //                     a += 1;
            //                     ProveedorCompra.INIT;
            //                     ProveedorCompra."No." := Inter."Search Name";
            //                     ProveedorCompra.Name := Inter."Search Name";
            //                     ;
            //                     ProveedorCompra."Name 2" := '';
            //                     ProveedorCompra."Search Name" := Inter."Search Name";
            //                     ProveedorCompra.INSERT;
            //                 END;
            //                 if NOT ProveedorCompra.GET(Inter."No.") THEN BEGIN
            //                     ProveedorCompra.INIT;
            //                     ProveedorCompra := Inter;
            //                     ProveedorCompra.Address := Inter.Name;
            //                     ProveedorCompra."Last Date Modified" := 19800102D;
            //                     ProveedorCompra."Credit Limit (LCY)" := 0;
            //                     Emp.GET(Rec.Empresa);
            //                     ProveedorCompra."Name 2" := '';
            //                     if Rec.Saldo <> 0 THEN
            //                         ProveedorCompra.INSERT;
            //                 END;
            //                 ProveedorCompra."Credit Limit (LCY)" += Rec.Saldo;


            //                 if Rec.Saldo <> 0 THEN
            //                     ProveedorCompra.MODIFY;
            //             UNTIL Rec.NEXT = 0;
            //         COMMIT;
            //         PAGE.RUNMODAL(7001105, ProveedorCompra);
            //     END;
            // }
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


    PROCEDURE TotalesDocumentos(No: Code[20]; pEmpresa: Text[30]; Desde: Date; Hasta: Date): Decimal;
    VAR
        PurchaseHeader: Record 38;
        PurchaseLine: Record 39;
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
        Importe := 0;


        PurchaseHeader.RESET;
        PurchaseHeader.CHANGECOMPANY(pEmpresa);
        PurchaseHeader.SetRange("Posting Date", Desde, Hasta);
        PurchaseHeader.SETRANGE("Buy-From Vendor No.", No);
        PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
        PurchaseHeader.SETFILTER("Document Type", '%1|%2',
           PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::"Return Order");
        if PurchaseHeader.FIND('-') THEN BEGIN
            REPEAT
                PurchaseLine.CHANGECOMPANY(pEmpresa);
                PurchaseLine.SETRANGE(PurchaseLine."Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SETRANGE(PurchaseLine."Document No.", PurchaseHeader."No.");
                Importe := 0;

                if PurchaseLine.FINDFIRST THEN
                    REPEAT
                        Importe += (PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost" * (1 - PurchaseLine."Line Discount %" / 100));// * (1 + PurchaseLine."VAT %" / 100);
                                                                                                                                          //BImporte += (PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost" * (1 - PurchaseLine."Line Discount %" / 100));
                    UNTIL PurchaseLine.NEXT = 0;

            UNTIL PurchaseHeader.NEXT = 0;
        END;

        EXIT(Importe);
    END;

    // PROCEDURE Contab(Num: Code[20]): Boolean;
    // VAR
    //     Imp: Decimal;
    //     r17: Record "G/L Entry";
    // BEGIN
    //     r17.SETCURRENTKEY(r17."Document No.");
    //     r17.SETRANGE(r17."Document No.", Num);
    //     if r17.FINDFIRST THEN
    //         REPEAT
    //             if COPYSTR(r17."G/L Account No.", 1, 1) = '6' THEN Imp := Imp + r17.Amount;
    //             if COPYSTR(r17."G/L Account No.", 1, 1) = '2' THEN Imp := Imp + r17.Amount;
    //             if COPYSTR(r17."G/L Account No.", 1, 2) = '47' THEN Imp := Imp + r17.Amount;
    //         UNTIL r17.NEXT = 0;
    //     if Imp = 0 THEN EXIT(FALSE);
    //     EXIT(TRUE);
    // END;

    PROCEDURE NombreProveedor(): Text[80];
    VAR
        rInter: Record "Proveedores Compra";
    BEGIN
        if rInter.GET(Rec."Código Proveedor") THEN EXIT(rInter.Name);
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


    PROCEDURE Calcular(Interc: Code[20]);
    VAR
        IxE: Record "Proveedores x Empresa";
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
            IxE.SETRANGE(IxE."Código Proveedor", Interc);
        Rec.Copyfilter("Date Filter", IxE."Date Filter");


        Ventana.OPEN('#########1## de #########2##');
        Ventana.UPDATE(2, IxE.COUNT);
        if IxE.FINDFIRST THEN
            REPEAT
                a += 1;
                Ventana.UPDATE(1, a);
                IxE."Saldo" := 0;
                IxE.Desde := Rec.GETRANGEMIN("Date Filter");
                IxE.Hasta := Rec.GETRANGEMAX("Date Filter");
                IxE.Saldo := TotalesDocumentos(IxE.Proveedor, IxE.Empresa, Ixe.Desde, Ixe.Hasta);

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


}