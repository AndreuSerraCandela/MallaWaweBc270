/// <summary>
/// TableExtension PurchaseHeaderKuara (ID 80105) extends Record Purchase Header.
/// </summary>
tableextension 80105 PurchaseHeaderKuara extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here



        field(50002; "Desactiva Validaciones"; Boolean) { }
        field(50003; "Periodo de Pago"; Text[30]) { }
        field(50004; "Emplazamiento"; Text[30]) { }
        field(50005; Firmado; Enum "Firmado")
        {
            DataClassification = ToBeClassified;

        }
        field(50006; "Fecha Firma"; Date) { }
        field(50010; "Fecha inicial proyecto"; Date) { }
        field(50011; "Fecha fin proyecto"; Date) { }
        field(50012; "Factura recibida"; Boolean) { }
        field(50017; "Nº Contrato Venta"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."No." WHERE("Document Type" = CONST(Order),
                            "Nº Proyecto" = FIELD("Nº Proyecto")));
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            ValiDateTableRelation = false;
            Editable = false;
        }
        field(50019; "Nombre Cliente Venta"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Sell-to Customer Name" WHERE("Document Type" = CONST(Order),
                            "Nº Proyecto" = FIELD("Nº Proyecto")));
            Editable = false;
        }
        field(50020; "Nombre 2 Cliente Venta"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Sell-to Customer Name 2" WHERE("Document Type" = CONST(Order),
                            "Nº Proyecto" = FIELD("Nº Proyecto")));
            Editable = false;
        }
        field(50021; "Cód. cliente venta"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Sell-to Customer No." WHERE("Document Type" = CONST(Order),
                            "Nº Proyecto" = FIELD("Nº Proyecto")));
            //Description=FCL-08/10/04 
        }
        field(50022; "Descripcion proyecto"; Text[100])
        {
            Caption = 'Descripción proyecto';
            //Description=$002 
        }
        field(50075; "Nº Proyecto"; Code[20])
        {
            TableRelation = Job;
            trigger OnValiDate()
            VAR
                r39: Record 39;
                rProyecto: Record Job;
            BEGIN
                // $001 -
                //MessageIfPurchLinesExist(FIELDCAPTION("Nº Proyecto"));
                "Your Reference" := 'Proyecto ' + "Nº Proyecto";
                r39.SETRANGE(r39."Document Type", "Document Type");
                r39.SETRANGE(r39."Document No.", "No.");
                r39.MODIFYALL(r39."Job No.", "Nº Proyecto");
                // $001 +

                //$003(I)
                if "Descripcion proyecto" = '' THEN BEGIN
                    if rProyecto.GET("Nº Proyecto") THEN
                        VALIDate("Descripcion proyecto", rProyecto.Description);
                END;
                //$003(F)
            END;
            //Description=MNC - Mig 5.0 
        }
        field(50076; "Factura emplazamiento"; Boolean) { }
        field(50077; "Banco"; Code[20]) { TableRelation = "Bank Account"; }
        field(50078; "Emplazamiento con vto"; Boolean) { }
        field(50079; "Genera Prev. de pagos"; Boolean) { }
        field(50080; "Forzar Traspaso"; Boolean) { }
        field(51040; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Cód. dim. acceso dir. 3';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            trigger OnValiDate()
            BEGIN
                ValiDateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            END;


        }
        field(51041; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Cód. dim. acceso dir. 4';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            trigger OnValiDate()
            BEGIN
                ValiDateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            END;
        }
        field(51042; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Cód. dim. acceso dir. 5';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            trigger OnValiDate()
            BEGIN
                ValiDateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            END;
        }
        field(51043; "Nº Contrato"; Code[20])
        {

            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            ValiDateTableRelation = false;

        }
        field(51044; ContabilizaInter; Boolean) { }
        field(51045; EnProceso; Boolean) { }
        field(70000; "Nº Impreso"; Text[30]) { }
        field(80000; "Tipo factura SII"; Code[2])
        {         //Description=SII;
            Editable = true;
        }
        field(80006; "Descripción operación"; Text[250])
        {      //Description=SII;
            Editable = true;
        }
        field(80007; "Tipo factura rectificativa"; Code[1])
        {   //Description=SII;
            Editable = true;
        }
        field(80015; "Obviar SII"; Boolean) { }
        field(90000; "Anulación"; Boolean) { }       //Description=AF3.70 (FCL-17/03/04) }
        // field(95000; "Retention Group Code (GE)"; Code[20])
        // {
        //     ObsoleteState = Removed;
        //     TableRelation = "Payments Retention Group".Code WHERE("Retention Type" = CONST("Good Execution"));
        //     DataClassification = ToBeClassified;

        //     Caption = 'Código grupo retención (BE)';
        // }
        // field(95001; "Retention Group Code (IRPF)"; Code[20])
        // {
        //     ObsoleteState = Removed;
        //     TableRelation = "Payments Retention Group".Code WHERE("Retention Type" = CONST(IRPF));
        //     DataClassification = ToBeClassified;

        //     Caption = 'Código grupo retención (IRPF)';
        // }
        // field(95002; "Retention Amount (GE)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Purchase Line"."Retention Amount (GE)" WHERE("Document Type" = FIELD("Document Type"),
        //                                                                                                           "Document No." = FIELD("No.")));

        //     Caption = 'Importe retención (BE)';
        //     Editable = false;
        // }
        // field(95003; "Retention Amount (IRPF)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Purchase Line"."Retention Amount (IRPF)" WHERE("Document Type" = FIELD("Document Type"),
        //                                                                                                             "Document No." = FIELD("No.")));

        //     Caption = 'Importe retención (IRPF)';
        //     Editable = false;
        // }
        field(80100; "Renovacion en:"; DateFormula)
        {
            trigger OnValidate()
            begin

            end;
        }
        field(80101; "Fecha Prevista Renovación"; Date)
        {

        }
        field(80102; "Pedido Original"; Code[10])
        {
            TableRelation = "Purchase Header" where("Document Type" = const(Order));
        }
        field(80103; "Empresa Factura"; Text[30])
        {

        }
        // field(92101; "Order Type"; Code[20])
        // {
        //     Caption = 'Tipo de pedido';
        //     TableRelation = "Transaction Type";
        // }
        // field(92102; "Imputación Realizada."; Boolean)
        // {

        // }

    }

    var
        GlSetup: Record "General Ledger Setup";

    Procedure UpdateFieldsSII(): Boolean
    begin

        //-SII1
        GLSetup.GET;
        if NOT GLSetup."Activar SII" THEN
            EXIT;
        // Si ya están informados no volver a informarlos..
        //if ("Tipo factura SII" <> '') AND ("Descripción operación" <> '') THEN
        //EXIT;
        "Tipo factura SII" := 'F1';
        if "Document Type" IN ["Document Type"::"Credit Memo", "Document Type"::"Return Order"] THEN BEGIN
            "Tipo factura rectificativa" := 'I';
        END;
        "Descripción operación" := "Posting Description";
        EXIT(TRUE);
        //+SII1
    end;



    /// <summary>
    /// RenoveDocument.
    /// </summary>
    /// <returns>Return value of type Code[20].</returns>


    procedure Navigate()
    var
        NavigatePage: Page Navigate;
    begin
        NavigatePage.SetDoc("Posting Date", "No.");
        NavigatePage.SetRec(Rec);
        NavigatePage.Run();
    end;
}