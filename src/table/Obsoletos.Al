/// <summary>
/// Table Temp. Mov. emplazamientos (ID 80101).
/// </summary>
table 80101 "Temp. Mov. emplazamientos"
{
    ObsoleteState = Removed;

    fields
    {
        field(1; "Nº proveedor"; Code[20]) { TableRelation = Vendor; }
        field(2; "Nº emplazamiento"; Code[20]) { TableRelation = "Emplazamientos proveedores"."Nº Emplazamiento" WHERE("Nº Proveedor" = FIELD("Nº proveedor")); }
        field(3; "Nº mov."; Integer) { }
        field(5; "Periodo Pago"; Code[30]) { TableRelation = "Periodos pago emplazamientos"; }
        field(7; "Texto linea"; Text[50]) { }
        field(15; "Fecha vencimiento"; Date) { }
        field(20; "Fecha prevista pago"; Date) { }
        field(22; "Cód. Divisa"; Code[10])
        {
            TableRelation = Currency;
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(45; "Estado"; Enum "Estado Movimientos")
        {

        }
        field(50; "Reclamado"; Enum "Reclamado")
        {

        }
        field(55; "Responsable"; Code[3]) { }
        field(60; "Importancia"; Code[10]) { }
        field(65; "Observaciones"; Text[80]) { }
        field(70; "Importe"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(71; "% IVA"; Decimal) { }
        field(72; "IVA"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(75; "Total"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(76; "Gastos"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(80; "Importe total"; Decimal) { }
        field(85; "Importe pendiente"; Decimal) { }
        field(90; "Fecha pago"; Date) { }
        field(95; "Importe pagado"; Decimal) { }
        field(100; "Canon Total Periodo"; Decimal) { }
        field(105; "Nombre Proveedor"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Nº proveedor")));
        }
        field(110; "Pago mediante"; Text[30]) { }
        field(115; "Semana"; Integer) { }
        field(120; "Año"; Integer) { }
        field(125; "Pagador"; Enum "Pagador") { }
        field(130; "Entregado"; Boolean) { }
        field(135; "Impreso"; Boolean) { }
        field(140; "Fecha impresion"; Date) { }
        field(145; "% IRPF"; Decimal) { }
        field(146; "Importe IRPF"; Decimal) { }
        field(150; "Pagare impreso"; Boolean) { Caption = 'Pagaré impreso'; }
        field(151; "Fecha impr pagare"; Date) { Caption = 'Fecha impresión pagaré'; }
        field(152; "No prevision"; Code[20]) { Caption = 'false. previsión'; }
        field(153; "Año periodo"; Text[4])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Periodos pago emplazamientos"."Año" WHERE("Cód. Periodo Pago" = FIELD("Periodo Pago")));
        }
        field(500; "Usuario"; Code[20]) { TableRelation = "User Setup"; }
        field(501; "User"; Code[50]) { TableRelation = "User Setup"; }
    }
    KEYS
    {
        key(P; Usuario, "Nº proveedor", "Nº emplazamiento", "Periodo Pago")
        {
            Clustered = true;
        }
    }
    PROCEDURE CargarTabla(pCodProv: Code[20]; pEmplaz: Code[20]);
    VAR
        rMovEmp: Record "Mov. emplazamientos";
        rTemp: Record "Temp. Movs. emplazamientos";
        wPeriodoAnt: Code[30];
        wImporte: Decimal;
    BEGIN
        rTemp.RESET;
        rTemp.SETRANGE(User, USERID);
        rTemp.DELETEALL;

        CLEAR(wPeriodoAnt);
        rMovEmp.RESET;
        rMovEmp.SETCURRENTKEY("Nº proveedor", "Nº emplazamiento", "Periodo Pago");
        rMovEmp.SETRANGE("Nº proveedor", pCodProv);
        rMovEmp.SETRANGE("Nº emplazamiento", pEmplaz);
        if rMovEmp.FIND('-') THEN BEGIN
            REPEAT
                wImporte := rMovEmp."Importe total" - rMovEmp.Gastos - rMovEmp.IVA + rMovEmp."Importe IRPF";
                if rMovEmp."Periodo Pago" <> wPeriodoAnt THEN BEGIN
                    wPeriodoAnt := rMovEmp."Periodo Pago";
                    rTemp.INIT;
                    rTemp.TRANSFERfields(rMovEmp);
                    rTemp.User := USERID;
                    rTemp."Canon Total Periodo" := wImporte;
                    rTemp.INSERT;
                END
                ELSE BEGIN
                    rTemp.RESET;
                    rTemp.SETRANGE(User, USERID);
                    rTemp.SETRANGE("Nº proveedor", pCodProv);
                    rTemp.SETRANGE("Nº emplazamiento", pEmplaz);
                    rTemp.SETRANGE("Periodo Pago", rMovEmp."Periodo Pago");
                    if rTemp.FIND('-') THEN BEGIN
                        rTemp."Canon Total Periodo" += wImporte;
                        rTemp.MODIFY;
                    END;
                END;
            UNTIL rMovEmp.NEXT = 0;
        END;

        COMMIT;

        Page.RUNMODAL(7001255);
    END;
}
table 80111 "Ultimas reservas recurso"
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Cod Recurso"; Code[20])
        {
            TableRelation = Resource;
            Caption = 'Cód. Recurso';
        }
        field(2; "Nombre"; Text[50]) { }
        field(3; "Medidas"; Code[20]) { TableRelation = Medidas; }
        field(4; "Zona"; Code[20]) { TableRelation = "Zonas Recursos"; }
        field(5; "Nº fam recurso"; Code[20])
        {
            TableRelation = "Resource Group";
            Caption = 'Nº fam. recurso';
        }
        field(6; "Iluminado"; Boolean) { InitValue = false; }
        field(7; "Ult proyecto"; Code[20])
        {
            TableRelation = Job;
            Caption = 'Ult. proyecto';
        }
        field(8; "Fecha inicial"; Date) { }
        field(9; "Soporte de"; Enum "Soporte de") { }
        field(10; "Fecha final"; Date) { }
        field(11; "Fija/Papel"; Enum "Fija/Papel")
        {

        }
        field(12; "Fecha baja"; Date) { }
        field(50; "Usuario"; Code[20]) { TableRelation = User; }
    }
    KEYS
    {
        key(P; Usuario, "Cod Recurso") { Clustered = true; }
    }
}

/// <summary>
/// Table Cabecera Importaciones Garden (ID 80112).
/// </summary>
table 80112 "Cabecera Importaciones Garden"
{

    ObsoleteState = Removed;


    fields
    {
        field(1; "Secuencia"; Integer) { }
        field(2; "Nombre del Fichero"; Text[100]) { }
        field(3; "Contabilizado"; Boolean) { }
        field(4; "Incidencias"; Boolean) { }
        field(5; "Fecha"; Date) { }
        field(6; "Filtro Fecha"; Date) { FieldClass = FlowFilter; }
        field(7; "Departamento"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; "Filtro Departamento"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            ValidateTableRelation = false;
        }
        field(9; Procesado; Boolean) { }
        field(10; "Fecha Proceso"; Date) { }
    }
    KEYS
    {
        Key(P; Secuencia) { Clustered = true; }
        Key(F; Fecha, Departamento, "Nombre del Fichero", Procesado) { }
    }
    VAR
        rApu: Record 50006;

    trigger OnDelete()
    BEGIN
        rApu.SETCURRENTKEY(Secuencia);
        rApu.SETRANGE(rApu.Secuencia, Secuencia);
        rApu.DELETEALL;
    END;

}
/// <summary>
/// Table Cód. Proveedores (ID 7001123).
/// </summary>
table 80113 "Cód. Proveedores"
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Proveedores"; Code[20]) { }
        field(2; "Albaranes"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purch. Rcpt. Header" WHERE("Buy-from Vendor No." = FIELD(Proveedores)));
        }
    }
    KEYS
    {
        key(P; Proveedores) { Clustered = true; }
    }
}
/// <summary>
/// Table Compensaciones emplazamie (ID 7001144).
/// </summary>
table 80114 "Compensaciones emplazamie"

{
    ObsoleteState = Removed;

    fields
    {
        field(1; "Nº proveedor"; Code[20]) { TableRelation = Vendor; }
        field(2; "Nº emplazamiento"; Code[20])
        {
            TableRelation = "Emplazamientos proveedores"."Nº Emplazamiento" WHERE("Nº Proveedor" = FIELD("Nº proveedor"));
            SqlDataType = Varchar;
            ValidateTableRelation = false;
        }
        field(3; "No. compensacion"; Integer) { Caption = 'Nº compensación'; }
        field(4; "Accion"; Code[5]) { Caption = 'Acción'; }
        field(5; "Fecha creacion"; Date) { Caption = 'Fecha creación'; }
        field(6; "Tamaño"; Text[15]) { }
        field(7; "Tipo"; Text[30]) { }
        field(8; "Motivo"; Text[30]) { }
        field(9; "Fecha instalacion"; Date) { Caption = 'Fecha instalación'; }
        field(10; "Observaciones"; Text[100]) { }
    }
    KEYS
    {
        key(P; "Nº proveedor", "Nº emplazamiento", Accion, "No. compensacion")
        {
            Clustered = true;
        }
    }
    VAR
        rCompEmp: Record "Compensaciones emplazamie";

    trigger OnInsert()
    BEGIN
        rCompEmp.RESET;
        rCompEmp.SETRANGE("Nº proveedor", "Nº proveedor");
        rCompEmp.SETRANGE("Nº emplazamiento", "Nº emplazamiento");
        rCompEmp.SETRANGE(Accion, Accion);
        if rCompEmp.FIND('+') THEN BEGIN
            "No. compensacion" := rCompEmp."No. compensacion" + 10;
        END
        ELSE BEGIN
            "No. compensacion" := 10;
        END;
    END;

}
/// <summary>
/// Table Configuración Importación (ID 7001120).
/// </summary>
table 80115 "Configuración Importación"
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Clave"; Code[10]) { }
        field(2; "Directorio Importación"; Text[250]) { }
        field(3; "Grupo Contable Negocio"; Code[20]) { TableRelation = "Gen. Business Posting Group".Code; }
        field(4; "Grupo Contable Producto"; Code[20]) { TableRelation = "Gen. Product Posting Group".Code; }
        field(5; "Grupo Reg. Negocio"; Code[20]) { TableRelation = "VAT Business Posting Group".Code; }
        field(6; "Directorio Procesados"; Text[250]) { }
        field(7; "Contrapartida Por defecto"; Text[30]) { TableRelation = "G/L Account"; }
        field(8; "Grupo Reg. Iva 0"; Code[20]) { TableRelation = "VAT Product Posting Group".Code; }
        field(9; "Cuenta correctora compras"; Text[30]) { TableRelation = "G/L Account"; }
    }
    KEYS
    {
        key(P; Clave) { Clustered = true; }

    }
}



/// <summary>
/// Table Consolida (ID 50026).
/// </summary>
table 80116 Consolida
{
    DataPerCompany = false;
    ObsoleteState = Removed;
    fields
    {
        field(1; "Cuenta"; Code[20]) { }
        field(2; "Conso debe"; Code[20]) { }
        field(3; "Conso Haber"; Code[20]) { }
    }
    KEYS
    {
        key(P; Cuenta) { Clustered = true; }
    }

}
/// <summary>
/// Table Facturas Desglose (ID 7001214).
/// </summary>
table 80117 "Facturas Desglose"
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Factura"; Code[20]) { }
        field(2; "Cuenta"; Text[30]) { }
        field(3; "Dimension1"; Code[20]) { }
        field(4; "Dimension2"; Code[20]) { }
        field(5; "Dimension3"; Code[20]) { }
        field(6; "Dimension4"; Code[20]) { }
        field(7; "Dimension5"; Code[20]) { }
        field(8; "Importe Definitivo"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("Document No." = FIELD(Factura),
                    "G/L Account No." = FIELD(Cuenta),
                    "Global Dimension 1 Code" = FIELD(Dimension1),
                    "Global Dimension 2 Code" = FIELD(Dimension2),
                    "Global Dimension 3 Code" = FIELD(Dimension3),
                    "Global Dimension 4 Code" = FIELD(Dimension4),
                    "Global Dimension 5 Code" = FIELD(Dimension5)));
        }
        field(9; "Importe Diario"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Gen. Journal Line".Amount WHERE("Document No." = FIELD(Factura),
                    "Account No." = FIELD(Cuenta),
                    "Shortcut Dimension 1 Code" = FIELD(Dimension1),
                    "Shortcut Dimension 2 Code" = FIELD(Dimension2),
                    "Shortcut Dimension 3 Code" = FIELD(Dimension3),
                    "Shortcut Dimension 4 Code" = FIELD(Dimension4),
                    "Shortcut Dimension 5 Code" = FIELD(Dimension5),
                    "Reason Code" = FILTER(<> 'DESGLO')));
            trigger OnLookup()
            VAR
                r81: Record "Gen. Journal Line";
                F39: Page 39;
            BEGIN
                r81.SETRANGE(r81."Account No.", Cuenta);
                r81.SETRANGE(r81."Document No.", Factura);
                r81.SETRANGE(r81."Shortcut Dimension 1 Code", Dimension1);
                r81.SETRANGE(r81."Shortcut Dimension 2 Code", Dimension2);
                r81.SETRANGE(r81."Shortcut Dimension 3 Code", Dimension3);
                r81.SETRANGE(r81."Shortcut Dimension 4 Code", Dimension4);
                r81.SETRANGE(r81."Shortcut Dimension 5 Code", Dimension5);
                r81.SETFILTER(r81."Reason Code", '<>%1', 'DESGLO');
                F39.SETTABLEVIEW(r81);
                F39.RUNMODAL;
            END;
        }
    }
    KEYS
    {
        key(P; Factura, Cuenta, Dimension1, Dimension2, Dimension4, Dimension5)
        {
            Clustered = true;
        }
    }
}
/// <summary>
/// Table G/L Entry Consolidado (ID 80117).
/// </summary>
table 80118 "G/L Entry Consolidado"
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Entry No."; Integer) { Caption = 'Nº mov.'; }
        field(3; "G/L Account No."; Text[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Nº cuenta';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Fecha registro';
            ClosingDates = true;
        }
        field(5; "Document Type"; Enum "Document Type Kuara")
        {
            Caption = 'Tipo documento';
        }
        field(6; "Document No."; Code[20]) { Caption = 'Nº documento'; }
        field(7; "Description"; Text[50]) { Caption = 'Descripción'; }
        field(10; "Bal. Account No."; Text[20])
        {
            TableRelation = if ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            if ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            if ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            if ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            if ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            if ("Bal. Account Type" = CONST("IC Partner")) "IC Partner";
            Caption = 'Cta. contrapartida';
        }
        field(17; "Amount"; Decimal)
        {
            Caption = 'Importe';
            AutoFormatType = 1;
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Caption = 'Cód. dimensión global 1';
            CaptionClass = '1,1,1';
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Caption = 'Cód. dimensión global 2';
            CaptionClass = '1,1,2';
        }
        field(27; "User ID"; Code[20])
        {
            TableRelation = User;
            ValidateTableRelation = false;
            Caption = 'Id. usuario';


        }
        field(28; "Source Code"; Code[10])
        {
            TableRelation = "Source Code";
            Caption = 'Cód. origen';
        }
        field(29; "System-Created Entry"; Boolean) { Caption = 'Asiento automático'; }
        field(30; "Prior-Year Entry"; Boolean) { Caption = 'Asiento post-cierre'; }
        field(41; "Job No."; Code[20])
        {
            TableRelation = Job;
            Caption = 'Nº proyecto';
        }
        field(42; "Quantity"; Decimal)
        {
            Caption = 'Cantidad';
            DecimalPlaces = 0 : 5;
        }
        field(43; "VAT Amount"; Decimal)
        {
            Caption = 'Importe IVA';
            AutoFormatType = 1;
        }
        field(45; "Business Unit Code"; Code[10])
        {
            TableRelation = "Business Unit";
            Caption = 'Cód. empresa';
        }
        field(46; "Journal Batch Name"; Code[10]) { Caption = 'Nommbre sección diario'; }
        field(47; "Reason Code"; Code[10])
        {
            TableRelation = "Reason Code";
            Caption = 'Cód. auditoría';
        }
        field(48; "Gen. Posting Type"; Enum "General Posting Type")
        {
            Caption = 'Tipo IVA';
        }
        field(49; "Gen. Bus. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Business Posting Group";
            Caption = 'Grupo contable negocio';
        }
        field(50; "Gen. Prod. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
            Caption = 'Grupo contable producto';
        }
        field(51; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Tipo contrapartida';
        }
        field(52; "Transaction No."; Integer) { Caption = 'Nº asiento'; }
        field(53; "Debit Amount"; Decimal)
        {
            Caption = 'Importe debe';
            BlankZero = true;
            AutoFormatType = 1;
        }
        field(54; "Credit Amount"; Decimal)
        {
            Caption = 'Importe haber';
            BlankZero = true;
            AutoFormatType = 1;
        }
        field(55; "Document Date"; Date)
        {
            Caption = 'Fecha emisión documento';
            ClosingDates = true;
        }
        field(56; "External Document No."; Code[20]) { Caption = 'Nº documento externo'; }
        field(57; "Source Type"; Enum "Gen. Journal Source Type") { Caption = 'Tipo procedencia mov'; }
        field(58; "Source No."; Code[20])
        {
            TableRelation = if ("Source Type" = CONST(Customer)) Customer
            ELSE
            if ("Source Type" = CONST(Vendor)) Vendor
            ELSE
            if ("Source Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            if ("Source Type" = CONST("Fixed Asset")) "Fixed Asset";
            Caption = 'Cód. procedencia mov.';
        }
        field(59; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Nos. serie';
        }
        field(60; "Tax Area Code"; Code[20])
        {
            TableRelation = "Tax Area";
            Caption = 'Cód. área impuesto';
        }
        field(61; "Tax Liable"; Boolean) { Caption = 'Sujeto a impuesto'; }
        field(62; "Tax Group Code"; Code[10])
        {
            TableRelation = "Tax Group";
            Caption = 'Cód. grupo impuesto';
        }
        field(63; "Use Tax"; Boolean) { Caption = 'Utilizar impuesto'; }
        field(64; "VAT Bus. Posting Group"; Code[10])
        {
            TableRelation = "VAT Business Posting Group";
            Caption = 'Grupo registro IVA neg.';
        }
        field(65; "VAT Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
            Caption = 'Grupo registro IVA prod.';
        }
        field(68; "Additional-Currency Amount"; Decimal)
        {
            Caption = 'Importe divisa-adicional';
            AutoFormatType = 1;
            AutoFormatExpression = GetCurrencyCode;
        }
        field(69; "Add.-Currency Debit Amount"; Decimal)
        {
            Caption = 'Debe div.-adic.';
            AutoFormatType = 1;
            AutoFormatExpression = GetCurrencyCode;
        }
        field(70; "Add.-Currency Credit Amount"; Decimal)
        {
            Caption = 'Haber div.-adic.';
            AutoFormatType = 1;
            AutoFormatExpression = GetCurrencyCode;
        }
        field(71; "Close Income Statement Dim. ID"; Integer)
        {
            Caption = 'ID dim. asiento regularización';
        }
        field(72; "IC Partner Code"; Code[20])
        {
            TableRelation = "IC Partner";
            Caption = 'Código socio IC';
        }
        field(73; "Reversed"; Boolean) { Caption = 'Revertido'; }
        field(74; "Reversed by Entry No."; Integer)
        {
            TableRelation = "G/L Entry";
            Caption = 'Revertido por el movimiento nº';

            BlankZero = true;
        }
        field(75; "Reversed Entry No."; Integer)
        {
            TableRelation = "G/L Entry";
            Caption = 'Nº movimiento revertido';
            BlankZero = true;
        }
        field(76; "G/L Account Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Account".Name WHERE("No." = FIELD("G/L Account No.")));
            Caption = 'Nommbre cuenta';
            Editable = false;
        }
        field(5400; "Prod. Order No."; Code[20]) { Caption = 'Nº orden producción'; }
        field(5600; "FA Entry Type"; Option)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'FA Entry Type';
            OptionCaption = ' ,Fixed Asset,Maintenance';
            OptionMembers = " ","Fixed Asset",Maintenance;
        }
        field(5601; "FA Entry No."; Integer)
        {
            TableRelation = if ("FA Entry Type" = CONST("Fixed Asset")) "FA Ledger Entry"
            ELSE
            if ("FA Entry Type" = CONST(Maintenance)) "Maintenance Ledger Entry";
            Caption = 'A/F Nº mov.';
            BlankZero = true;
        }
        field(10720; "New G/L Account No."; Text[20])
        {
            //TableRelation="New G/L Account"."No.";
            Caption = 'Nº de cuenta nuevo';
            // trigger OnValidate()
            // VAR
            //   GLAccEqTool: Record 10720;
            // BEGIN
            //  IF"New G/L Account No." = '' THEN BEGIN
            //     if GLAccEqTool.GET("G/L Account No.") THEN BEGIN
            //         GLAccEqTool.Ready := FALSE;
            //         GLAccEqTool.Implement := FALSE;
            //         GLAccEqTool.MODIFY;
            //     END
            //   END;
            // END;


        }
        field(10721; "Old G/L Account No."; Text[20])
        {
            //TableRelation="Historic G/L Account";
            Caption = 'Nº de cuenta antiguo';
            // trigger OnValidate()
            // VAR
            //   GLAccEqTool: Record 10720;
            // BEGIN
            //   IF"New G/L Account No." = '' THEN BEGIN
            //     if GLAccEqTool.GET("G/L Account No.") THEN BEGIN
            //       GLAccEqTool.Ready := FALSE;
            //       GLAccEqTool.Implement := FALSE;
            //       GLAccEqTool.MODIFY;
            //     END
            //   END;
            // END;


        }
        field(10722; Updated; Boolean)
        {
            Caption = 'Actualizado';
        }
        field(50000; Marca; Code[1]) { }
        field(3010551; "Cost Entry No."; Integer)
        {
            TableRelation = "Cost Entry";
            Caption = 'Nº mov. coste';
        }
        field(7000000; "Bill No."; Code[20]) { Caption = 'Nº efecto'; }
    }
    KEYS
    {
        Key(P; "Entry No.") { Clustered = true; }
        Key(G1; "G/L Account No.", "Posting Date")
        {
            SumIndexfields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
        Key(GG; "G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date")
        {
            SumIndexfields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";

        }
        Key(E1; "G/L Account No.", "Business Unit Code", "Posting Date")
        {
            SumIndexfields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";

        }
        Key(A; "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date")
        {
            SumIndexfields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
        Key(B; "Document No.", "Posting Date") { }
        Key(C; "Transaction No.") { }
        Key(D; "IC Partner Code") { }
        Key(F; "Posting Date", "G/L Account No.") { SumIndexfields = Amount, "Additional-Currency Amount"; }
        Key(G; "G/L Account No.", "Document No.", "Bill No.") { SumIndexfields = Amount, "Additional-Currency Amount"; }
        Key(H; "G/L Account No.", Description) { SumIndexfields = Amount, "Additional-Currency Amount"; }
        Key(I; "Old G/L Account No.", "Posting Date") { SumIndexfields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount"; }
        Key(J; "Posting Date", "Old G/L Account No.") { SumIndexfields = Amount, "Additional-Currency Amount"; }
        Key(K; "Old G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Close Income Statement Dim. ID", "Posting Date")
        {
            SumIndexfields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
        Key(L; "Source Type", "Source No.", "G/L Account No.") { SumIndexfields = Amount; }
        Key(M; "G/L Account No.", "Source Type", "Source No.", "Posting Date") { }
        Key(N; "G/L Account No.", "Business Unit Code", "Posting Date", "Document Type", "Document No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Source No.") { }
        Key(O; "Source Type", "Source No.", "Global Dimension 2 Code")
        {
            SumIndexfields = Amount;
        }
        Key(Q; "G/L Account No.", "Posting Date", Amount) { }
        Key(R; Marca) { }
        Key(S; "Global Dimension 2 Code", "Source Type", "Posting Date", "G/L Account No.", "Document Type", "Document No.") { }
        Key(T; "Posting Date", "Bal. Account Type", "Bal. Account No.") { }
    }
    VAR
        GLSetup: Record "General Ledger Setup";
        GLSetupRead: Boolean;

    PROCEDURE GetCurrencyCode(): Code[10]
    BEGIN
        if NOT GLSetupRead THEN BEGIN
            GLSetup.GET;
            GLSetupRead := TRUE;
        END;
        EXIT(GLSetup."Additional Reporting Currency");
    END;

    PROCEDURE ShowValueEntries();
    VAR
        GLItemLedgRelation: Record 5823;
        ValueEntry: Record 5802;
        TempValueEntry: Record 5802 temporary;
    BEGIN
    END;


}
table 80119 "TMP Movs. Retenciones"
{
    ObsoleteState = Removed;
    DataPerCompany = false;
    Caption = 'Mov. retención';

    FIELDS
    {
        field(1; "Entry No."; Integer)
        {//CaptionML=[ENU=Entry No.;
            Caption = 'Nº mov.';
            Editable = false;
        }
        field(2; Type; Option)
        {////CaptionML=[ENU=Type;
            Caption = 'Tipo';
            //OptionCaptionML=ESP=Proveedor,Cliente;
            OptionMembers = Proveedor,Cliente;
            Editable = false;
        }
        field(3; "No."; Code[20])
        {        ////CaptionML=[ENU=No.;
            Caption = 'Nº';
            Editable = false;
        }
        field(4; "Posting Date"; Date)
        {////CaptionML=[ENU=Posting Date;
            Caption = 'Fecha registro';
            Editable = false;
        }
        field(5; "Document No."; Code[20])
        {        ////CaptionML=[ENU=Document No.;
            Caption = 'Nº documento';
            Editable = false;
        }
        field(6; Description; Text[50])
        {        ////CaptionML=[ENU=Description;
            Caption = 'Descripción';
        }
        field(7; "Tipo retencion"; Option)
        {////CaptionML=[ENU="Tipo retencion";
            Caption = 'Tipo retención';
            //OptionCaptionML=[ENU=B. E.,IRPF;
            OptionCaption = 'B. E.,IRPF';
            OptionMembers = "B. E.",IRPF;
            Editable = false;
        }
        field(8; "Codigo retencion"; Code[20])
        {        ////CaptionML=[ENU=Codigo retencion;
            Caption = 'Código retención';
            Editable = false;
        }
        field(9; "Currency Code"; Code[10])
        {
            TableRelation = Currency;

            Caption = 'Cód. divisa';
            Editable = false;
        }
        field(10; Amount; Decimal)
        {//CaptionML=[ENU=Amount;
            Caption = 'Importe';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(11; "Amount (LCY)"; Decimal)
        {//CaptionML=[ENU=Amount (LCY);
            Caption = 'Importe (DL)';
            Editable = false;
            AutoFormatType = 1;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {     ////CaptionML=[ENU=Global Dimension 1 Code;
            Caption = 'Cód. dimensión global 1';
            Editable = false;
            CaptionClass = '1,1,1';
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {     ////CaptionML=[ENU=Global Dimension 2 Code;
            Caption = 'Cód. dimensión global 2';
            Editable = false;
            CaptionClass = '1,1,2';
        }
        field(14; "User ID"; Code[50])
        {
            //ValidateTableRelation = false;
            //TestTableRelation = false;
            //CaptionML=[ENU=User ID;
            Caption = 'Id. usuario';
            Editable = false;
            trigger OnLookup()
            Var
                LoginMgt: Codeunit 418;
            BEGIN
            END;

        }
        field(15; "Source Code"; Code[10])
        {//CaptionML=[ENU=Source Code;
            Caption = 'Cód. origen';
            Editable = false;
        }
        field(16; "Due Date"; Date)
        {////CaptionML=[ENU=Due Date;
            Caption = 'Fecha vencimiento';
            Editable = false;
        }
        field(17; "Document Date"; Date)
        {////CaptionML=[ENU=Document Date;
            Caption = 'Fecha emisión documento';
            Editable = false;
        }
        field(18; "External Document No."; Code[20])
        {       ////CaptionML=[ENU=External Document No.;
            Caption = 'Nº documento externo';
            Editable = false;
        }
        field(19; "Base de retencion"; Decimal)
        {//CaptionML=[ENU=Base de retencion;
            Caption = 'Base de retención';
            Editable = false;
        }
        field(20; Open; Boolean)
        {//CaptionML=[ENU=Open;
            Caption = 'Pendiente';
            Editable = true;
        }
        field(21; "Base de retencion (DL)"; Decimal)
        {    ////CaptionML=[ENU=Base de retencion (DL);
            Caption = 'Base de retención (DL)';
            Editable = false;
        }
        field(22; "Tratamiento de retencion"; Option)
        {   ////CaptionML=[ENU=Tratamiento de retencion;
            OptionCaption = 'Tratamiento de retención';
            OptionMembers = "Retención de Pago","Pte. Factura";
            Editable = false;
        }
        field(23; "Fecha liberacion"; Date)
        {////CaptionML=[ENU=Fecha liberacion;
            Caption = 'Fecha liberación';
            Editable = false;
        }
        field(24; "Liberado por no. documento"; Code[20])
        {  ////CaptionML=[ENU=Liberado por no. documento;
            Caption = 'Liberado por nº documento';
            Editable = false;
        }
        field(25; "Liq por Id."; Code[50])
        {       ////CaptionML=[ENU=Liq por Id.;
            Caption = 'Liq por Id.';
            Editable = false;
        }
        field(26; "Liberado por no. de movimiento"; Integer)
        {
            //CaptionML=[ENU=Liberado por no. de movimiento;
            Caption = 'Liberado por nº de movimiento';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {//CaptionML=[ENU=Dimension Set ID;
            Caption = 'Id. Grupo dimensiones';
            Editable = false;
        }
        field(485; "Order No."; Code[20])
        {        ////CaptionML=[ENU=Order No.;
            Caption = 'Nº Pedido';
            Editable = false;
        }
        field(486; "Blanket Order No."; Code[20])
        {        ////CaptionML=[ENU=Blanket Order No.;
            Caption = 'Nº Pedido Abierto';
            Editable = false;
        }
        field(487; "Job No."; Code[20])
        {        ////CaptionML=[ENU=Job No.;
            Caption = 'Nº proyecto';
            Editable = false;
        }
        field(50000; Empresa; Text[30]) {; TableRelation = Company; }
    }
    KEYS
    {
        key(Pk; Empresa, "Entry No.") { Clustered = true; }
    }
    FIELDGROUPS
    {
    }

    VAR
        Text1100000: Label '% Dto. P.P. (IVA excluído)';
        Text1100001: Label '% Dto. P.P. (IVA ajustado)';
        Text000: Label 'debe tener el mismo signo que %1.';
        Text001: Label 'no debe ser mayor que %1.';


}
/// <summary>
/// Table Informe de vendedores (ID 7001188).
/// </summary>
table 80120 "Informe de vendedores"
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Tipo documento"; Enum "Tipo Documento Envios") { }
        field(2; "Nº documento"; Code[20])
        {
            TableRelation = if ("Tipo documento" = CONST(Invoice)) "Sales Invoice Header"
            ELSE
            if ("Tipo documento" = CONST("Credit Memo")) "Sales Cr.Memo Header";
        }
        field(3; "Cód. departamento"; Code[20]) { TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1)); }
        field(4; "Cód. programa"; Code[20]) { TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2)); }
        field(5; "Importe Base IVA"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(6; "Cód. vendedor"; Code[20]) { TableRelation = "Salesperson/Purchaser".Code; }
        field(7; "Fecha"; Date) { }
        field(8; "Clave para ayudar"; Integer) { }
        field(9; "Nº Cliente"; Code[20])
        {
            TableRelation = Customer;
            SqlDataType = Integer;
        }
        field(10; "Cód. Divisa"; Code[10]) { }
        field(11; "Importe Base IVA (DL)"; Decimal) {; AutoFormatType = 1; }
        field(12; "Contrato"; Code[20]) { }
        field(50013; "Cód. Principal"; Code[20]) { TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3)); }
        field(50014; "Cód. Zona"; Code[20]) { TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4)); }
        field(50015; "Soporte"; Code[20]) { }
    }
    KEYS
    {
        key(P; "Clave para ayudar") { Clustered = true; }
        key(A; "Cód. vendedor", "Cód. programa") { }
        key(B; "Cód. vendedor", "Nº Cliente") { }
        key(C; "Cód. vendedor", "Nº Cliente", "Cód. programa") { }
        key(D; "Cód. vendedor", "Cód. Principal") { }
        key(E; "Cód. vendedor", "Nº Cliente", "Cód. Principal") { }
    }
}
/// <summary>
/// Table Mov. 431 (ID 7010474).
/// </summary>
table 80121 "Mov. 431"
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Mov No."; Integer) { }
        field(2; "Cuenta Antigua"; Text[30]) { }
    }
    KEYS
    {
        key(P; "Mov No.") { Clustered = true; }
    }

}

/// <summary>
/// Table Movimientos a no liquidar (ID 7010478).
/// </summary>
table 80123 "Movimientos a no liquidar"
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Secuencia"; Integer) {; AutoIncrement = true; }
        field(2; "Cuenta"; Code[20]) { }
        field(3; "Vencimiento"; Date) { }
        field(4; "Importe"; Decimal) { }
        field(5; "Documento"; Text[30]) { }
        field(6; "Fecha"; Date) { }
        field(7; "Tipo"; Text[30]) { }
        field(8; "Mov Navision"; Integer)
        {
            TableRelation = "Vendor Ledger Entry"."Entry No.";
            ValidateTableRelation = false;
        }
        field(9; "Importe2"; Decimal) { }
    }
    KEYS
    {
        key(P; Secuencia) { Clustered = true; }
    }
}
/// <summary>
/// Table Recurso (ID 7010479).
/// </summary>
table 80124 Recurso

{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Nº Recurso"; Code[20])
        {
            TableRelation = Resource;
            Description = 'PK,FK Recurso';
        }
        field(5; "Nº linea"; Integer) {; Description = 'PK'; }
        field(10; "Fecha"; Date) { }
        field(15; "Hora"; Time) { }
        field(20; "Usuario"; Code[50]) { }
        field(25; "Nº proyecto"; Code[20])
        {
            TableRelation = Job;
            Description = 'FK Proyecto';
        }
        field(30; "Cód. fase"; Code[10])
        {
            // TableRelation = Table161;
            Description = 'FK Fase';
        }
        field(35; "Cód. subfase"; Code[10])
        {
            // TableRelation = Table162;
            Description = 'FK Subfase';
        }
        field(40; "Cód. tarea"; Code[10])
        {
            //TableRelation = Table163;
            Description = 'FK Tarea';
        }
        // field(45  ;No; Estado anterior"     ;Option        OptionMembers=Libre,Reservado,Ocupado;}
        // field(50  ;No; Estado posterior"    ;Option        OptionMembers=Libre,Reservado,Ocupado;}
        field(55; "Nº Reserva"; Integer)
        {
            TableRelation = Reserva;
            Description = 'FK Reserva';
        }
        field(60; "Fecha inicio"; Date) { }
        field(65; "Fecha fin"; Date) { }
        field(70; "Estado Reserva"; Enum "Estado Reserva") { }
    }
    KEYS
    {
        key(P; "Nº Recurso", "Nº linea") { Clustered = true; }
        key(R; "Nº Reserva") { }
        key(F; Fecha) { }
    }
}
/// <summary>
/// Table Ref Catastral tastral Address (ID 7001147).
/// </summary>
table 80125 "Ref Catastral tastral Address"
{
    ObsoleteState = Removed;

    DataCaptionfields = "Vendor No.", Name, Code;

    Caption = 'Dirección Catastral';

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Nº proveedor';
            NotBlank = true;
        }
        field(2; "Code"; Code[30])
        {
            ValidateTableRelation = false;
            Caption = 'Código';
            NotBlank = true;
            TableRelation = if (Tipo = CONST(Emplazamiento)) "Emplazamientos proveedores"."Nº Emplazamiento" WHERE("Nº Proveedor" = FIELD("Vendor No."))
            ELSE
            if (Tipo = CONST(Proveedor)) "Vendor"."No."
            ELSE
            if (Tipo = CONST(Direccion)) "Order Address".Code WHERE("Vendor No." = FIELD("Vendor No."));
            trigger OnValidate()
            VAR
                Vendor: Record Vendor;
                Emplazamientos: Record "Emplazamientos proveedores";
                Direcciones: Record 224;
            BEGIN
                if "Vendor No." = '' THEN BEGIN
                    Code := '';
                    EXIT;
                END;
                if (Emplazamientos.GET("Vendor No.", Code)) AND (Tipo = Tipo::Proveedor) THEN BEGIN
                    if Code <> "Vendor No." THEN Tipo := Tipo::Emplazamiento;
                END;
                CASE Tipo OF
                    Tipo::Proveedor:
                        Vendor.GET(Code);
                    Tipo::Direccion:
                        Direcciones.GET("Vendor No.", Code);
                    Tipo::Emplazamiento:
                        Emplazamientos.GET("Vendor No.", Code);
                END;
            END;

        }
        field(3; "Name"; Text[50]) { Caption = 'Nombre'; }
        field(4; "Name 2"; Text[50]) { Caption = 'Nombre 2'; }
        field(5; "Address"; Text[50]) { Caption = 'Dirección'; }
        field(6; "Address 2"; Text[50]) { Caption = 'Dirección 2'; }
        field(7; "City"; Text[30])
        {
            Caption = 'Población';
            trigger OnValidate()
            BEGIN
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", true);
            END;

            trigger OnLookup()
            BEGIN
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            END;

        }
        field(8; "Contact"; Text[50]) { Caption = 'Contacto'; }
        field(9; "Phone No."; Text[30]) { Caption = 'Nº teléfono'; }
        field(10; "Telex No."; Text[30]) { Caption = 'Nº telex'; }
        field(35; "Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Caption = 'Cód. país/región';
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Fecha Últ. modificación';
            Editable = false;
        }
        field(84; "Fax No."; Text[30]) { Caption = 'Nº fax'; }
        field(85; "Telex Answer Back"; Text[20]) { Caption = 'Nº telex respuesta'; }
        field(91; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            ValidateTableRelation = false;

            Caption = 'C.P.';
            trigger OnValidate()
            BEGIN
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", true);
            END;

            trigger OnLookup()
            BEGIN
                PostCode.LookUpPostCode(City, "Post Code", County, "Country/Region Code");
            END;

        }
        field(92; "County"; Text[30]) { Caption = 'Provincia'; }
        field(102; "E-Mail"; Text[80]) { Caption = 'Correo electrónico'; }
        field(103; "Home Page"; Text[80]) { Caption = 'Página Web'; }
        field(104; "Ref. catastral"; Text[30]) { }
        field(105; "Situación inmueble"; Code[10]) { }
        field(106; "Tipo"; Enum "Tipo Inmueble")
        {

        }
        field(107; "Base"; Decimal) { }
        field(108; "Retención"; Decimal) { }
        field(109; "Cif"; Text[30]) { }
    }
    KEYS
    {
        key(P; "Vendor No.", Code) {; Clustered = true; }
    }

    VAR
        Text000: Label 'SinTitulo';
        Vend: Record Vendor;
        PostCode: Record 225;

    trigger OnInsert()
    BEGIN
        Vend.GET("Vendor No.");
        Name := Vend.Name;
    END;

    trigger OnModify()
    BEGIN
        "Last Date Modified" := TODAY;
    END;

    trigger OnRename()
    BEGIN
        "Last Date Modified" := TODAY;
    END;

    PROCEDURE Caption(): Text[130];
    BEGIN
        if "Vendor No." = '' THEN
            EXIT(Text000);
        Vend.GET("Vendor No.");
        EXIT(STRSUBSTNO('%1 %2 %3 %4', Vend."No.", Vend.Name, Code, Name));
    END;

    PROCEDURE DisplayMap();
    VAR
        MapPoint: Record 800;
        MapMgt: Codeunit 802;
    BEGIN
        if MapPoint.FIND('-') THEN
            MapMgt.MakeSelection(DATABASE::"Order Address", GETPOSITION);
    END;

}
/// <summary>
/// Table Relacion (ID 7010471).
/// </summary>
table 80126 Relacion
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Modulo"; Text[50]) { }
        field(2; "Descripcion"; Text[50]) { }
        field(3; "Recurso"; Code[20]) { TableRelation = Resource; }
    }
    KEYS
    {
        key(P; Modulo) { Clustered = true; }
    }
}
/// <summary>
/// Table Resumen Bancos (ID 7010470).
/// </summary>
table 80127 "Resumen Bancos"
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Fecha"; Date) { }
        field(2; "Banco"; Code[20]) { }
        field(3; "Ingreso"; Decimal) { }
        field(4; "Pago"; Decimal) { }
    }
    KEYS
    {
        key(P; Fecha, Banco) { Clustered = true; }
    }
}
/// <summary>
/// Table Saldos Cuentas Agrupación (ID 7001142).
/// </summary>
table 80128 "Saldos Cuentas Agrupación"
{
    ObsoleteState = Removed;
    DataPerCompany = false;
    fields
    {
        field(1; "Nº"; Text[20])
        {
            Caption = 'Nº';
            Description = 'PK, FK Cuenta';
        }
        field(2; "Nombre"; Text[30]) { Caption = 'Nombre'; }
        field(3; "Saldo"; Decimal)
        {
            Caption = 'Saldo';
            AutoFormatType = 1;
        }
    }

    KEYS
    {
        key(P; "Nº") { Clustered = true; }
    }

}
/// <summary>
/// Table Detalle Fechas (ID 7001128).
/// </summary>
table 80129 "Detalle Fechas"
{
    ObsoleteState = Removed;
    fields
    {
        field(1; "Fila"; Code[20]) { }
        field(2; "Fecha"; Date) { }
        field(3; "Empresa 1"; Decimal) { }
        field(4; "Empresa 2"; Decimal) { }
        field(5; "Empresa 3"; Decimal) { }
        field(6; "Empresa 4"; Decimal) { }
        field(7; "Empresa 5"; Decimal) { }
        field(8; "Empresa 6"; Decimal) { }
        field(9; "Empresa 7"; Decimal) { }
        field(10; "Empresa 8"; Decimal) { }
        field(11; "Empresa 9"; Decimal) { }
        field(12; "Empresa 10"; Decimal) { }
        field(13; "Empresa 11"; Decimal) { }
        field(14; "Total"; Decimal) { }
        field(15; "Filtro Fecha"; Date) { FieldClass = FlowFilter; }
        field(16; "Nombre Esquema"; Code[20]) { TableRelation = "Acc. Schedule Name"; }
        field(17; "Descripcion"; Text[250]) { }
        field(18; "Linea"; Integer) { }
        field(19; "Totaling Type"; Enum "Acc. Schedule Line Totaling Type")
        {

        }
    }
    KEYS
    {
        key(P; Linea, Fecha) { Clustered = true; }
    }

}



