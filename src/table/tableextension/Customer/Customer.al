/// <summary>
/// TableExtension ClienteKuara (ID 80107) extends Record Customer.
/// </summary>
tableextension 80107 ClienteKuara extends "Customer"
{
    fields
    {


        // Add changes to table fields here

        field(80000; "Traspasado"; boolean)
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;

        }
        field(50000; "Cód. envio genérico"; Code[10]) { TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("No.")); }
        field(50004; "Banco transferencia"; Text[250])
        {
            TableRelation = "Bank Account";
            ValidateTableRelation = false;
        }
        field(50005; "Saldo en Contab"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("Source Type" = CONST(Customer),
                                                                                             "Source No." = FIELD("No."),
                                                                                             "G/L Account No." = FILTER('4300..4305:|431..432:|433..434:|4370..4371:|440..449:')));
            Editable = false;
            AutoFormatType = 1;
        }
        field(50006; "Saldo en Cta Efectos"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("Source Type" = CONST(Customer),
                                                                                             "Source No." = FIELD("No."),
                                                                                             "G/L Account No." = FILTER('4310..4310:')));
            Editable = false;
            AutoFormatType = 1;
        }
        field(50007; "Saldo en Efecto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Cartera Doc."."Remaining Amt. (LCY)" WHERE(Type = CONST(Receivable),
                                                                                                                "Account No." = FIELD("No.")));
            Editable = false;
            AutoFormatType = 1;
        }
        field(50008; "Saldo en Contab UAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("Source Type" = CONST(Customer),
                                                                                             "Source No." = FIELD("No."),
                                                                                             "G/L Account No." = FILTER('430000001|430090002|431..432:|433..434:|4370..4371:|440..449:')));
            Editable = false;
            AutoFormatType = 1;
        }
        field(50010; "Nº copias contratos"; Integer) { }
        field(50011; "Saldo real (DL)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                    "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                    "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                    "Currency Code" = FIELD("Currency Filter"),
                                                    "Excluded from calculation" = CONST(false),
                                                    "Entry Type" = FILTER("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)")));
            Caption = 'Saldo real (DL)';
            Description = 'FCL-20/05/05. No están bien los importes pendientes.';
            Editable = false;
            AutoFormatType = 1;
        }
        field(50012; "Saldo real periodo (DL)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                "Currency Code" = FIELD("Currency Filter"),
                                                "Excluded from calculation" = CONST(false),
                                                "Entry Type" = FILTER("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)"),
                                                "Posting Date" = FIELD("Date Filter")));
            Caption = 'Saldo real periodo (DL)';
            Description = 'FCL-20/05/05. No están bien los importes pendientes.';
            Editable = false;
            AutoFormatType = 1;
        }
        field(50021; "Movimientos"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("No."),
                                                                                                 Open = CONST(true)));
        }
        field(50030; "Fecha ult movimiento"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("G/L Entry"."Posting Date" WHERE("Source Type" = CONST(Customer),
                                                    "Source No." = FIELD("No."),
                                                    "G/L Account No." = FILTER('4300..4301:|4370..4370:')));
            Caption = 'Fecha Último movimiento';
            Description = '$001';
        }
        field(50031; "Fecha ult factura"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Cust. Ledger Entry"."Posting Date" WHERE("Customer No." = FIELD("No."),
                                                                    "Document Type" = FILTER(Invoice)));
            Caption = 'Fecha Última factura';
            Description = '$001';
        }
        field(50032; "Omitir 347"; Boolean) { }
        field(50033; "Cod cadena"; Code[10])
        {
            TableRelation = "Codigos cadena";
            Caption = 'Cód. cadena.';
            Description = '$002';
        }
        field(50034; "Fecha primer movimiento"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Min("G/L Entry"."Posting Date" WHERE("Source Type" = CONST(Customer),
                                                                "Source No." = FIELD("No."),
                                                                "G/L Account No." = FILTER('4300..4301:|4370..4370:')));
            Caption = 'Fecha primer movimiento';
            Description = '$001';
        }
        field(50050; "Global Dimension 3 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            Caption = 'Cód. dimensión global 3';
            CaptionClass = '1,2,3';
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(3, "Global Dimension 3 Code");
            END;

        }
        field(50051; "Global Dimension 4 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            Caption = 'Cód. dimensión global 4';
            CaptionClass = '1,2,4';
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            END;

        }
        field(50052; "Global Dimension 5 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            Caption = 'Cód. dimensión global 5';
            CaptionClass = '1,2,5';
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(5, "Global Dimension 5 Code");
            END;
        }
        field(50132; "Partner Type Old"; Enum "Partner Type")
        {
            InitValue = Person;
            Caption = 'Tipo socio';
        }
        field(51000; "Cuenta anticipo"; Text[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Cuenta anticipo';
            Description = 'FK Cuenta';
        }
        field(51001; "Impagados"; Boolean) { }
        field(51029; "Global Dimension 3 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            // Caption = 'Global Dimension 3 Filter',
            //                                                   ESP = 'Filtro dimensión global 3';
            CaptionClass = '1,3,3';
        }
        field(51030; "Global Dimension 4 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            // Caption = 'Global Dimension 4 Filter',
            //                                                   ESP = 'Filtro dimensión global  4';
            CaptionClass = '1,3,4';
        }
        field(51031; "Global Dimension 5 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            Caption = 'Filtro dimensión global  5';
            CaptionClass = '1,3,5';
        }
        field(52000; "Cliente Ruta"; Code[10]) { }
        field(52051; "Oficina Contable"; Text[30]) { }
        field(52052; "Organo Gestor"; Text[30]) { }
        field(52053; "Unidad tramitadora"; Text[30]) { }
        field(60015; "Permite Efactura"; Boolean) { }
        field(60016; "E-Mail Efactura"; Text[80]) { }
        field(60017; "Document Sending Profile Old"; Code[20])
        {
            TableRelation = "Document Sending Profile";
            Caption = 'Perfil de envío de documentos';
        }
        field(60018; "E-Mail-Facturación"; Text[200])
        {
            Caption = 'Correo Facturación';
            trigger OnValidate()
            var
                Custom: Record "Custom Report Selection";
                ReportSelections: Record "Report Selections";
                SequenceNo: Integer;
                Customer: Record Customer;
            begin
                SequenceNo := 1;
                Custom.SetRange("Source Type", 18);
                Custom.SetRange("Source No.", Rec."No.");
                Custom.DeleteAll();
                ReportSelections.SetRange(Usage, ReportSelections.Usage::"S.Invoice");
                if ReportSelections.FindFirst() Then begin
                    Custom.Validate("Source Type", 18);
                    if Not Customer.Get(Rec."No.") then
                        Custom."Source No." := Rec."No."
                    else
                        Custom.Validate("Source No.", Rec."No.");
                    Custom.Validate(Usage, ReportSelections.Usage);
                    Custom.Validate(Sequence, SequenceNo);
                    Custom.Validate("Report ID", ReportSelections."Report ID");
                    Custom.Validate("Use for Email Body", ReportSelections."Use for Email Body");
                    Custom.Validate("Use for Email Attachment", ReportSelections."Use for Email Attachment");
                    Custom.Validate("Custom Report Layout Code", ReportSelections."Custom Report Layout Code");
                    if ReportSelections."Email Body Layout Type" = ReportSelections."Email Body Layout Type"::"Custom Report Layout" then
                        Custom.Validate("Email Body Layout Code", ReportSelections."Email Body Layout Code");
                    Custom."Send To Email" := Rec."E-Mail-Facturación";
                    Custom.Insert();
                    SequenceNo += 1;
                end;
                ReportSelections.SetRange(Usage, ReportSelections.Usage::"S.Cr.Memo");
                if ReportSelections.FindFirst() Then begin
                    Custom.Validate("Source Type", 18);
                    if Not Customer.Get(Rec."No.") then
                        Custom."Source No." := Rec."No."
                    else
                        Custom.Validate("Source No.", Rec."No.");
                    Custom.Validate(Usage, ReportSelections.Usage);
                    Custom.Validate(Sequence, SequenceNo);
                    Custom.Validate("Report ID", ReportSelections."Report ID");
                    Custom.Validate("Use for Email Body", ReportSelections."Use for Email Body");
                    Custom.Validate("Use for Email Attachment", ReportSelections."Use for Email Attachment");
                    Custom.Validate("Custom Report Layout Code", ReportSelections."Custom Report Layout Code");
                    if ReportSelections."Email Body Layout Type" = ReportSelections."Email Body Layout Type"::"Custom Report Layout" then
                        Custom.Validate("Email Body Layout Code", ReportSelections."Email Body Layout Code");
                    Custom."Send To Email" := Rec."E-Mail-Facturación";
                    Custom.Insert();
                    SequenceNo += 1;
                end;
            end;
        }

        field(80002; "Tipo ID receptor"; Code[2])
        {
            ; Description = 'SII';
            Editable = true;
        }
        field(80003; "ID receptor"; Code[20])
        {
            ; Description = 'SII';
            Editable = true;
        }
        // field(90000; "Retention Group Code (GE)"; Code[20])
        // {
        //     ObsoleteState = Removed;
        //     Caption = 'Código grupo retención (BE)';
        //     TableRelation = "Payments Retention Group".Code WHERE("Retention Type" = CONST("Good Execution"));
        //     DataClassification = ToBeClassified;
        // }
        // field(90001; "Retention Group Code (IRPF)"; Code[20])
        // {
        //     ObsoleteState = Removed;
        //     Caption = 'Código grupo retención (IRPF)';
        //     TableRelation = "Payments Retention Group".Code WHERE("Retention Type" = CONST(IRPF));
        //     DataClassification = ToBeClassified;
        // }
        field(60019; "Nombre Comercial"; Text[250])
        {
            Caption = 'Anunciante';
            TableRelation = "Nombre Comercial".Nombre;
            trigger OnValidate()
            var
                Contact: Record "Contact";
                contbusrel: Record "Contact Business Relation";
            begin
                ContBusRel.SetCurrentKey("Link to Table", "No.");
                ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::Customer);
                ContBusRel.SetRange("No.", "No.");
                if ContBusRel.FindFirst() then begin
                    Contact.SetRange("Company No.", ContBusRel."Contact No.");
                    if Contact.FindFirst() then begin
                        Contact."Nombre Comercial" := Rec."Nombre Comercial";
                        Contact.Modify();
                    end;
                end;
            end;
        }
        field(60020; "Generar facturas a 0"; Boolean)
        { }
        field(51032; "Fecha de alta"; Date)
        {
            Caption = 'Fecha de alta';
            Editable = false;
        }
        field(51033; "Fecha de recuperación"; Date)
        {
            Caption = 'Fecha de recuperación';
            Editable = false;
        }
        field(51034; "Cliente Recuperado"; Boolean)
        {
            Caption = 'Cliente Recuperado';
            Editable = false;
        }
        field(51035; Revisar; Boolean)
        {

        }
        field(51036; "Tipo Cliente"; Enum "Tipo Cliente")
        {

        }
        field(51037; Listado; Boolean)
        {

        }
        field(50038; "No. de Contratos"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                        "No. Series" = const('CONTRATO'),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'Contratos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50039; "No. de Proyectos"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Job" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Jobs';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50040; "No. de Pedidos"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                        "No. Series" = filter(<> 'CONTRATO'),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'Contratos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50041; "No. de Albaranes"; Integer)
        {
            CalcFormula = count("Sales Shipment Header" where("Sell-to Customer No." = field("No."), "Albarán Venta" = const(true)));
            Caption = 'No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        // Add changes to table fields here
        // field(93000; "Traspasado Ocr"; boolean)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(93001; "ID Ocr"; Text[250])
        // {

        // }
        // field(93003; "ID Qwark"; Text[250])
        // {

        // }

    }

    var
        myInt: Integer;
}