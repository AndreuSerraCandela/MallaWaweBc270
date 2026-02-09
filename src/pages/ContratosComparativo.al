/// <summary>
/// Page Comparativo Compra/Venta Contr (ID 50070).
/// </summary>
page 50232 "Comparativo Compra/Venta Contr"
{

    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = true;

    SourceTable = 37;
    SourceTableTemporary = true;


    layout
    {
        area(Content)
        {

            repeater(Detalle)
            {
                field(Disc2; Disc)
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnValidate()
                    BEGIN
                        if Rec."No." = '' THEN BEGIN
                            Rec."Allow Invoice Disc." := NOT Rec."Allow Invoice Disc.";
                            Rec.SETRANGE("Document No.", Rec."Document No.");
                            Rec.MODIFY;
                            Rec.SETRANGE("Drop Shipment");
                            Rec.SETFILTER("No.", '<>%1', '');
                            Rec.MODIFYALL("Drop Shipment", NOT Rec."Allow Invoice Disc.");
                            Rec.SETRANGE("Document No.");
                            Rec.SETRANGE("No.");
                            Rec.SETRANGE("Drop Shipment", TRUE);
                        END;
                    END;
                }

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    // OnFormat=BEGIN
                    //         CurrForm."Document No.".UPDATEFONTBOLD("No."='');
                    //         if "No."<>'' THEN
                    //         CurrForm."Document No.".UPDATEINDENT:=114;
                    //         END;
                }

                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    //ValidateTableRelation=false;}
                    //  OnFormat=BEGIN
                    //             CurrForm."Sell-to Customer No.".UPDATEFONTBOLD("No."='');
                    //           END;
                    //            
                }


                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    TableRelation = "Salesperson/Purchaser";
                    Caption = 'Vendedor';
                    Editable = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    // OnFormat=BEGIN
                    //         CurrForm."Job No.".UPDATEFONTBOLD("No."='');
                    //         END;
                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Pedido';
                    trigger OnLookup(var Text: Text): Boolean
                    VAR
                        r120: Record 38;
                    BEGIN
                        r120.SETRANGE(r120."No.", Rec."No.");
                        Page.RUNMODAL(0, r120);
                    END;
                }


                //ValidateTableRelation=false;



                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = All;
                    Caption = 'Recurso';
                    TableRelation = Resource;
                }


                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Proveedor';
                    TableRelation = Vendor;
                    Editable = false;
                    trigger OnLookUp(var Text: Text): Boolean
                    VAR
                        r23: Record Vendor;
                    BEGIN
                        r23.SETRANGE(r23."No.", Rec."Bill-to Customer No.");
                        Page.RUNMODAL(0, r23);
                    END;
                }

                field(Description; Rec.Description) { ApplicationArea = All; Editable = false; }
                //  OnFormat=BEGIN
                //             CurrForm.Description.UPDATEFONTBOLD("No."='');
                //           END;
                //            }


                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Caption = 'Compra';
                    Editable = false;
                    // OnFormat=BEGIN
                    //         CurrForm."Unit Cost (LCY)".UPDATEFONTBOLD("No."='');
                    //         if ("No."='') {AND ("Allow Invoice Disc."=FALSE)} THEN
                    //             Text:='';
                    //         END;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Venta';
                    // OnFormat=BEGIN
                    //         CurrForm."Unit Price".UPDATEFONTBOLD("No."='');
                    //         END;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

                    Caption = 'Total Venta';

                    //  OnFormat=BEGIN
                    //             CurrForm.Amount.UPDATEFONTBOLD("No."='');
                    //           END;
                }

                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;

                    Caption = 'Total Coste';
                    // OnFormat=BEGIN
                    //         CurrForm."Line Discount Amount".UPDATEFONTBOLD("No."='');
                    //         END;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Launch &Web Source")
            {
                ApplicationArea = All;
                Image = Close;
                ShortCutKey = F11;
                Caption = '&Cerrar Todos';
                trigger OnAction()
                VAR
                    ContactWebSource: Record 5060;
                BEGIN
                    Rec.SETRANGE("Drop Shipment");
                    Rec.SETFILTER("No.", '<>%1', '');
                    Rec.MODIFYALL("Drop Shipment", FALSE);
                    Rec.SETFILTER("No.", '%1', '');
                    Rec.MODIFYALL("Allow Invoice Disc.", TRUE);
                    Rec.SETRANGE("No.");
                    Rec.SETRANGE("Drop Shipment", TRUE);
                END;
            }
            action("Print Cover &Sheet")
            {
                ApplicationArea = All;
                Image = Open;
                ShortCutKey = 'Mayús+F11';
                Caption = '&Abrir Todos';
                trigger OnAction()
                VAR
                    Cont: Record 5050;
                BEGIN
                    Rec.SETRANGE("Drop Shipment");
                    Rec.SETFILTER("No.", '<>%1', '');
                    Rec.MODIFYALL("Drop Shipment", TRUE);
                    Rec.SETFILTER("No.", '%1', '');
                    Rec.MODIFYALL("Allow Invoice Disc.", FALSE);
                    Rec.SETRANGE("No.");
                    Rec.SETRANGE("Drop Shipment", TRUE);
                END;
            }
        }
    }

    VAR
        r36: Record 36;
        r38: Record 38;
        a: Integer;
        VentanaD: Page Dialogo;
        Ventana: Dialog;
        b: Integer;
        Fd: Date;
        Fh: Date;
        r37: Record 37;
        Cd: Code[20];
        CH: Code[20];


    trigger OnOpenPage()
    VAR
        r39: Record 39;
        cost: Decimal;
        imp: Decimal;
    BEGIN
        VentanaD.SetCodes(Cd, Ch, 'Desde Contrato hasta contrato');
        VentanaD.RunModal();
        VentanaD.GetCodes(Cd, CH);
        Ventana.OPEN('Calculando Documentos #########1## de ###########2##');
        r36.SETRANGE(r36."Document Type", r36."Document Type"::Order);
        r36.SETRANGE(r36."No.", Cd, CH);
        Ventana.UPDATE(2, r36.COUNT);
        if r36.FINDFIRST THEN BEGIN
            Fd := r36."Fecha inicial proyecto";
            REPEAT
                if r36."Fecha inicial proyecto" <> 0D THEN Fh := r36."Fecha inicial proyecto";
                b := b + 1;
                Ventana.UPDATE(1, b);
                if r36."Nº Proyecto" <> '' THEN BEGIN
                    r38.SETCURRENTKEY(r38."Nº Proyecto");
                    r38.SETRANGE(r38."Nº Proyecto", r36."Nº Proyecto");
                    a := 10000;
                    cost := 0;
                    Rec."Document Type" := Rec."Document Type"::Order;
                    Rec."Document No." := r36."No.";
                    Rec."Line No." := a;//Format(a);
                    Rec."No." := '';
                    Rec."Sell-to Customer No." := r36."Sell-to Customer No.";
                    if r38.FINDFIRST THEN BEGIN
                        Rec."Bill-to Customer No." := r38."Pay-to Vendor No.";
                        if r38."Pay-to Vendor No." = '' THEN Rec."Bill-to Customer No." := r38."Buy-from Vendor No.";
                    END ELSE
                        Rec."Bill-to Customer No." := '';
                    Rec."Job No." := r36."Nº Proyecto";
                    Rec."Unit Price" := TotalesDocumentos(r36."Nº Proyecto", r36."No.");
                    Rec."Unit Cost (LCY)" := 0;
                    Rec.Description := r36."Posting Description";
                    Rec."Shipping Agent Code" := r36."Salesperson Code";
                    Rec."Drop Shipment" := TRUE;
                    Rec.INSERT;
                    if r38.FINDFIRST THEN BEGIN
                        REPEAT
                            a := a + 10000;
                            //r38.CALCFIELDS(r38.Amount);
                            Rec."Document Type" := Rec."Document Type"::Order;
                            Rec."Document No." := r36."No.";
                            Rec."No." := r38."No.";
                            Rec.Description := r38."Posting Description";
                            Rec."Line No." := a;//Format(a);
                            Rec."Sell-to Customer No." := r36."Sell-to Customer No.";
                            Rec."Bill-to Customer No." := r38."Pay-to Vendor No.";
                            if r38."Pay-to Vendor No." = '' THEN Rec."Bill-to Customer No." := r38."Buy-from Vendor No.";
                            Rec."Job No." := r36."Nº Proyecto";
                            Rec."Unit Price" := 0;
                            if r36.Estado IN [r36.Estado::Cancelado, r36.Estado::Anulado, r36.Estado::Modificado] THEN BEGIN
                                imp := eContabilizado(r38."No.");
                                Rec."Unit Cost (LCY)" := imp;
                                Rec."Drop Shipment" := TRUE;
                                Rec.INSERT;
                                cost := cost + imp;

                            END ELSE BEGIN
                                r39.SETRANGE(r39."Document Type", r38."Document Type");
                                r39.SETRANGE(r39."Document No.", r38."No.");
                                if r39.FINDFIRST THEN r39.CALCSUMS(r39."Line Amount");
                                if r39."Document Type" = r39."Document Type"::"Return Order" THEN
                                    Rec."Unit Cost (LCY)" := -r39."Line Amount"
                                ELSE
                                    Rec."Unit Cost (LCY)" := r39."Line Amount";
                                Rec."Drop Shipment" := TRUE;
                                Rec.INSERT;
                                if r39."Document Type" = r39."Document Type"::"Return Order" THEN
                                    cost := cost - r39."Line Amount"
                                ELSE
                                    cost := cost + r39."Line Amount";
                            END;
                        UNTIL r38.NEXT = 0;
                    END;
                    Rec.GET(Rec."Document Type", Rec."Document No.", 10000);
                    Rec."Unit Cost (LCY)" := cost;
                    Rec.MODIFY;
                    Rec.SETRANGE("Document Type", Rec."Document Type");
                    Rec.SETRANGE("Document No.", Rec."Document No.");
                    Rec.MODIFYALL("Line Discount Amount", cost);
                    Rec.MODIFYALL(Amount, Rec."Unit Price");
                    Rec.RESET;
                END;
                r37.SETRANGE("Document Type", r36."Document Type");
                r37.SETRANGE("Document No.", r36."No.");
                if r37.FINDFIRST THEN
                    REPEAT
                        a := a + 10000;
                        Rec."Sell-to Customer No." := r36."Sell-to Customer No.";
                        Rec."Bill-to Customer No." := r38."Pay-to Vendor No.";
                        if r38."Pay-to Vendor No." = '' THEN Rec."Bill-to Customer No." := r38."Buy-from Vendor No.";
                        Rec."Job No." := r36."Nº Proyecto";
                        Rec."Unit Price" := TotalesDocumentos(r36."Nº Proyecto", r36."No.");
                        Rec."Unit Cost (LCY)" := 0;
                        Rec."No." := '';
                        Rec."Shipment No." := r37."No.";
                        Rec."Line No." := a;
                        Rec.Description := r37.Description;
                        Rec."Unit Price" := r37."Line Amount";
                        Rec."Unit Cost" := 0;
                        Rec."Drop Shipment" := FALSE;
                        Rec.INSERT;
                    UNTIL r37.NEXT = 0;

            UNTIL r36.NEXT = 0;
        END;
        r38.RESET;
        r38.SETCURRENTKEY(r38."Nº Proyecto");
        r38.SETRANGE(r38."Nº Proyecto", '');
        r38.SETRANGE(r38."Posting Date", Fd, Fh);
        a := 10000;
        cost := 0;
        Rec."Document Type" := Rec."Document Type"::Order;
        Rec."Document No." := 'Sin Contrato';
        Rec."Line No." := a;//Format(a);
        Rec."No." := '';
        Rec."Sell-to Customer No." := '';
        if r38.FINDFIRST THEN BEGIN
            Rec."Bill-to Customer No." := r38."Pay-to Vendor No.";
            if r38."Pay-to Vendor No." = '' THEN Rec."Bill-to Customer No." := r38."Buy-from Vendor No.";
        END ELSE
            Rec."Bill-to Customer No." := '';
        Rec."Job No." := 'Sin Proyecto';
        Rec."Unit Price" := 0;
        Rec."Unit Cost (LCY)" := 0;
        Rec.Description := 'Sin contrato ni proyecto';
        Rec."Shipping Agent Code" := r38."Purchaser Code";
        Rec."Drop Shipment" := TRUE;
        Rec.INSERT;
        if r38.FINDFIRST THEN BEGIN
            REPEAT
                a := a + 10000;
                //r38.CALCFIELDS(r38.Amount);
                Rec."Document Type" := Rec."Document Type"::Order;
                Rec."Document No." := 'Sin Contrato';
                Rec."No." := r38."No.";
                Rec.Description := r38."Posting Description";
                Rec."Line No." := a;//Format(a);
                Rec."Sell-to Customer No." := '';
                Rec."Bill-to Customer No." := r38."Pay-to Vendor No.";
                Rec."Job No." := 'Sin Proyecto';
                Rec."Unit Price" := 0;
                r39.SETRANGE(r39."Document Type", r38."Document Type");
                r39.SETRANGE(r39."Document No.", r38."No.");
                if r39.FINDFIRST THEN r39.CALCSUMS(r39."Line Amount");
                if r39."Document Type" = r39."Document Type"::"Return Order" THEN
                    Rec."Unit Cost (LCY)" := -r39."Line Amount"
                ELSE
                    Rec."Unit Cost (LCY)" := r39."Line Amount";
                Rec."Drop Shipment" := TRUE;
                Rec.INSERT;
                if r39."Document Type" = r39."Document Type"::"Return Order" THEN
                    cost := cost - r39."Line Amount"
                ELSE
                    cost := cost + r39."Line Amount";
            UNTIL r38.NEXT = 0;
        END;
        Rec.RESET;
        Ventana.CLOSE;
        Rec.SETRANGE("Drop Shipment", TRUE);
    END;

    PROCEDURE TotalesDocumentos(pNumProyecto: Code[20]; wNum: Code[20]): Decimal;
    VAR
        TempSalesLine: Record 37 TEMPORARY;
        rCabVenta: Record 36;
        ImpBorFac: Decimal;
        ImpBorAbo: Decimal;
        ImpAbo: Decimal;
        ImpFac: Decimal;
        TotImp: Decimal;
        TotCont: Decimal;
        TotalSalesLine: Record 37;
        TotalSalesLineLCY: Record 37;
        rCabFac: Record 112;
        rCabAbo: Record 114;
        RegisVtas: Codeunit 80;
        wDecimal: Decimal;
        wTexto: Text[30];
    BEGIN
        //$002 Obtengo totales de borradores y facturas correspondientes a este contrato.

        ImpBorFac := 0;
        ImpBorAbo := 0;
        ImpFac := 0;
        ImpAbo := 0;
        TotImp := 0;
        TotCont := 0;
        WITH r36 DO BEGIN
            CALCFIELDS("Borradores de Factura", "Borradores de Abono",
                       "Facturas Registradas", "Abonos Registrados");

            if ("Borradores de Factura" <> 0) OR ("Borradores de Abono" <> 0) THEN BEGIN

                rCabVenta.RESET;
                rCabVenta.SETCURRENTKEY("Nº Proyecto");
                rCabVenta.SETRANGE("Nº Proyecto", pNumProyecto);
                rCabVenta.SETRANGE("Nº Contrato", wNum);
                rCabVenta.SETFILTER("Document Type", '%1|%2',
                   rCabVenta."Document Type"::Invoice, rCabVenta."Document Type"::"Credit Memo");
                if rCabVenta.FIND('-') THEN BEGIN
                    REPEAT
                        CLEAR(TotalSalesLine);
                        CLEAR(TotalSalesLineLCY);
                        CLEAR(RegisVtas);
                        CLEAR(TempSalesLine);
                        RegisVtas.GetSalesLines(rCabVenta, TempSalesLine, 0);
                        CLEAR(RegisVtas);
                        RegisVtas.SumSalesLinesTemp(
                          rCabVenta, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
                          wDecimal, wTexto, wDecimal, wDecimal, wDecimal);
                        if rCabVenta."Document Type" = rCabVenta."Document Type"::Invoice THEN BEGIN
                            ImpBorFac := ImpBorFac + TotalSalesLineLCY.Amount;
                        END
                        ELSE BEGIN
                            ImpBorAbo := ImpBorAbo + TotalSalesLineLCY.Amount;
                        END;
                    UNTIL rCabVenta.NEXT = 0;
                END;

            END;

            if "Facturas Registradas" <> 0 THEN BEGIN

                rCabFac.RESET;
                rCabFac.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
                rCabFac.SETRANGE("Nº Contrato", wNum);
                if rCabFac.FIND('-') THEN BEGIN
                    REPEAT
                        rCabFac.CALCFIELDS("Amount Including VAT", Amount);
                        ImpFac := ImpFac + rCabFac.Amount;
                    UNTIL rCabFac.NEXT = 0;
                END;

            END;

            if "Abonos Registrados" <> 0 THEN BEGIN

                rCabAbo.RESET;
                rCabAbo.SETCURRENTKEY("Nº Proyecto", "Nº Contrato");
                rCabAbo.SETRANGE("Nº Contrato", wNum);
                if rCabAbo.FIND('-') THEN BEGIN
                    REPEAT
                        rCabAbo.CALCFIELDS("Amount Including VAT", Amount);
                        ImpAbo := ImpAbo + rCabAbo.Amount;
                    UNTIL rCabAbo.NEXT = 0;
                END;

            END;

            //FCL-13/02/06. Incluyo sumatorio de totales y diferencia con el total del contrato.
            TotImp := ImpBorFac - ImpBorAbo + ImpFac - ImpAbo;
            EXIT(TotImp);
            if rCabVenta.GET(rCabVenta."Document Type"::Order, wNum) THEN BEGIN
                CLEAR(TotalSalesLine);
                CLEAR(TotalSalesLineLCY);
                CLEAR(RegisVtas);
                CLEAR(TempSalesLine);
                RegisVtas.GetSalesLines(rCabVenta, TempSalesLine, 0);
                CLEAR(RegisVtas);
                RegisVtas.SumSalesLinesTemp(rCabVenta, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
                                            wDecimal, wTexto, wDecimal, wDecimal, wDecimal);
                TotCont := TotalSalesLineLCY.Amount;
            END;
        END;
    END;

    PROCEDURE Disc(): Integer;
    BEGIN
        if (Rec."Allow Invoice Disc.") AND (Rec."No." = '') THEN EXIT(0);
        if (Rec."Allow Invoice Disc." = FALSE) AND (Rec."No." = '') THEN EXIT(1);
        EXIT(2);
    END;

    PROCEDURE eContabilizado(DocNo: Code[20]): Decimal
    VAR
        r120: Record "Purch. Rcpt. Header";
        r17: Record "G/L Entry";
        pContabilizado: Decimal;
    BEGIN
        r120.SETCURRENTKEY("Order No.");
        r120.SETRANGE(r120."Order No.", DocNo);
        if r120.FINDFIRST THEN
            REPEAT
                r17.SETCURRENTKEY(r17."G/L Account No.", r17."Document No.");
                r17.SETRANGE(r17."Document No.", r120."No.");
                r17.SETRANGE("G/L Account No.", '6', '7');
                if r17.FINDFIRST THEN r17.CALCSUMS(r17.Amount);
                pContabilizado := pContabilizado + r17.Amount;
                r17.SETRANGE("G/L Account No.", '47', '48');
                if r17.FINDFIRST THEN BEGIN
                    r17.CALCSUMS(r17.Amount);
                    pContabilizado := pContabilizado + r17.Amount;
                END;

            UNTIL r120.NEXT = 0;
        EXIT(pContabilizado);
    END;


}
