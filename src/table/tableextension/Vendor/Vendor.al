/// <summary>
/// TableExtension ProveedorKuara (ID 80106) extends Record Vendor.
/// </summary>
tableextension 80106 ProveedorKuara extends "Vendor"
{
    fields
    {
        // Add changes to table fields here

        field(80002; "Traspasado"; boolean)
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }

        field(50000; Contabilidad; Decimal) { DataClassification = ToBeClassified; }
        field(50005; "Saldo en Contab"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("G/L Entry".Amount WHERE("Source Type" = CONST(Vendor),
                                                                                              "Source No." = FIELD("No."),
                                                                                              "G/L Account No." = FILTER('4000..4005:|401..402:|403..404:|4100..4105:|411..419:'),
                                                                                              "Gen. Posting Type" = CONST(" ")));
            Editable = false;
        }
        field(50006; "Saldo en Cta Efecto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("Source Type" = CONST(Vendor),
                                                                                             "Source No." = FIELD("No."),
                                                                                             "G/L Account No." = FILTER('4010..4010:')));
        }
        field(50007; "Saldo en Efecto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Cartera Doc."."Remaining Amt. (LCY)" WHERE(Type = CONST(Payable),
                                                                                                                "Account No." = FIELD("No.")));
        }
        field(50008; "Onomástica"; Code[20])
        {
            ; TableRelation = "Grupo de empresas";
            DataClassification = ToBeClassified;
        }
        field(50009; "Saldo real (DL)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                            "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                            "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                            "Currency Code" = FIELD("Currency Filter"),
                            "Excluded from calculation" = CONST(false),
                            "Entry Type" = FILTER("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)")));
            Caption = 'Saldo real (DL)';
            Description = 'FCL-06/04. Creado porque tienen mal el importe pendiente .';
            Editable = false;
            AutoFormatType = 1;
        }
        field(50010; "Saldo real periodo (DL)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
            "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
            "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
            "Currency Code" = FIELD("Currency Filter"),
            "Excluded from calculation" = CONST(false),
            "Entry Type" = FILTER("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)"),
            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Saldo real periodo (DL)';
            Description = 'FCL-05/05. Igual que el anterior con filtro fecha.';
            Editable = false;
            AutoFormatType = 1;
        }
        field(50013; "Saldo Movimientos"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos".Importe WHERE("Periodo Pago" = FIELD(FILTER("Filtro Docuemnto2")),
                                                                                                        "Nº proveedor" = FIELD("No.")));
        }
        field(50014; "Saldo Contabilidad"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FILTER('621..6229999999|400901315..400901326'),
                                                                                             "Periodo de Pago" = FIELD(FILTER("Filtro Docuemnto")),
                                                                                             "Source No." = FIELD("No.")));
        }
        field(50015; "Importe emplazamientos"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos"."Importe total" WHERE("Nº proveedor" = FIELD("No.")));
            Description = '$002';
        }
        field(50016; "Filtro Docuemnto"; Text[30]) { FieldClass = FlowFilter; }
        field(50017; "Filtro Docuemnto2"; Code[30]) { FieldClass = FlowFilter; }
        field(50020; "Importe pte. emplazamientos"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos"."Importe pendiente" WHERE("Nº proveedor" = FIELD("No.")));
            Description = '$002';
        }
        field(50021; Movimientos; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Vendor Ledger Entry" WHERE("Vendor No." = FIELD("No.")));
        }
        field(50030; "Fecha ult movimiento"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("G/L Entry"."Posting Date" WHERE("Source Type" = CONST(Vendor),
                                                                                                     "Source No." = FIELD("No."),
                                                                                                     "G/L Account No." = FILTER('400000001..400499999:|4100..4105:|4109|4030..4039:|4010..4019:|4110..4119:')));
            Caption = 'Fecha Último movimiento';
            Description = '$002';
        }
        field(50031; "Fecha ult factura"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Vendor Ledger Entry"."Posting Date" WHERE("Vendor No." = FIELD("No."),
                                                                                                               "Document Type" = FILTER(Invoice)));
            Caption = 'Fecha Última factura';
            Description = '$002';
        }
        field(50032; "Omitir 347"; Boolean) { DataClassification = ToBeClassified; }
        field(50033; "Tiene Emplazamientos"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Emplazamientos proveedores" WHERE("Nº Proveedor" = FIELD("No.")));
        }
        field(50034; Banco; Code[20])
        {
            TableRelation = "Bank Account";
            DataClassification = ToBeClassified;
        }
        field(50035; "Generar Cartera Albarán"; Boolean) { DataClassification = ToBeClassified; }
        field(50050; "Global Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cód. dimensión global 3';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(3, "Global Dimension 3 Code");
            END;

        }
        field(50051; "Global Dimension 4 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cód. dimensión global 4';
            CaptionClass = '1,2,4;';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            END;

        }
        field(50052; "Global Dimension 5 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cód. dimensión global 5';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(5, "Global Dimension 5 Code");
            END;

        }
        field(50053; "Contacto Facturación"; Text[250]) { DataClassification = ToBeClassified; }
        field(50501; Albaranes; Decimal) { DataClassification = ToBeClassified; }
        field(50502; AlbaranesFac; Decimal) { DataClassification = ToBeClassified; }
        field(50503; AlbaranesCont; Decimal) { DataClassification = ToBeClassified; }
        field(50504; Devoluciones; Decimal) { DataClassification = ToBeClassified; }
        field(51029; "Global Dimension 3 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            Caption = 'Filtro dimensión global 3';
            CaptionClass = '1,3,3';
        }
        field(51030; "Global Dimension 4 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            Caption = 'Filtro dimensión global  4';
            CaptionClass = '1,3,4';
        }
        field(51031; "Global Dimension 5 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            Caption = 'Filtro dimensión global  5';
            CaptionClass = '1,3,5';
        }
        field(80000; "Tipo ID emisor"; Code[2])
        {
            DataClassification = ToBeClassified;
            Description = 'SII';
            Editable = true;
        }
        field(80001; "ID emisor"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'SII';
            Editable = true;
        }
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
        field(5055250; "Liq. Payment Terms Code"; Code[10])
        {
            TableRelation = "Payment Terms";
            DataClassification = ToBeClassified;
            Caption = 'Cód. términos pago liquidez';
        }
        field(7010600; Soporte; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '001';
        }
        field(7010605; Medio; Enum "Medio")
        {
            DataClassification = ToBeClassified;
            //OptionMembers = Prensa,Radio,Audiovisuales,Otros;
            Description = '001';
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
        //     Caption = 'Código grupo retención (IRPF)';
        //     ObsoleteState = Removed;
        //     TableRelation = "Payments Retention Group".Code WHERE("Retention Type" = CONST(IRPF));
        //     DataClassification = ToBeClassified;
        // }
        field(50505; "Saldo periodo Contab"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("G/L Entry".Amount WHERE("Source Type" = CONST(Vendor),
                                                                                              "Source No." = FIELD("No."),
                                                                                              "G/L Account No." = FILTER('4000..4005:|401..402:|403..404:|4100..4105:|411..419:'),
                                                                                              "Gen. Posting Type" = CONST(" "), "Posting Date" = field("Date Filter")));
            Editable = false;
        }

    }

    var
        myInt: Integer;

}