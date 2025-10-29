/// <summary>
/// TableExtension G/L AccountKuara (ID 80145) extends Record G/L Account.
/// </summary>
tableextension 80145 "G/L AccountKuara" extends "G/L Account"
{
    fields
    {
        field(50000; "Filtro Eliminaciones"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(50004; "Salesperson Filter"; CODE[20])
        {
            FieldClass = FlowFilter;
        }
        field(50029; "Global Dimension 3 Filter"; CODE[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            CaptionClass = '1,3,3';


        }
        field(50035; "Liq. Account"; Code[20])
        {

        }
        field(50032; "Saldo del Periodo"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER(Totaling)),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                        "Global Dimension 3 Code" = FIELD("Global Dimension 3 Filter"),
                                                        "Global Dimension 4 Code" = FIELD("Global Dimension 4 Filter"),
                                                        "Global Dimension 5 Code" = FIELD("Global Dimension 5 Filter"),
                                                        "SalesPerson Code" = field("Salesperson Filter"),
                                                        Eliminaciones = FIELD("Filtro Eliminaciones"),
                                                        "Posting Date" = FIELD("Date Filter"),
                                                        "Dimension Set ID" = FIELD("Dimension Set ID Filter")));
            Caption = 'Saldo del periodo';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50132; "Saldo a la fecha"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER(Totaling)),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                        "Global Dimension 3 Code" = FIELD("Global Dimension 3 Filter"),
                                                        "Global Dimension 4 Code" = FIELD("Global Dimension 4 Filter"),
                                                        "Global Dimension 5 Code" = FIELD("Global Dimension 5 Filter"),
                                                        "SalesPerson Code" = field("Salesperson Filter"),
                                                        Eliminaciones = FIELD("Filtro Eliminaciones"),
                                                        "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                        "Dimension Set ID" = FIELD("Dimension Set ID Filter")));
            Caption = 'Saldo a la fecha';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "Global Dimension 4 Filter"; CODE[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            CaptionClass = '1,3,4';
        }
        field(50031; "Global Dimension 5 Filter"; CODE[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            CaptionClass = '1,3,5';
        }
        field(50045; "Saldo por cód. procedencia"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
            "G/L Account No." = FIELD(FILTER(Totaling)),
            "Business Unit Code" = FIELD("Business Unit Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
             "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Posting Date" = FIELD("Date Filter"),
              "Source No." = FIELD("Filtro cód. procedencia")));
        }
        field(50046; "Filtro cód. procedencia"; CODE[10])
        {
            FieldClass = FlowFilter;

        }
        field(50050; "Global Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(3, "Global Dimension 3 Code");
            end;
        }
        field(50051; "Global Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            end;
        }
        field(50052; "Global Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(5, "Global Dimension 5 Code");
            end;
        }
        field(50064; "Debe div.-adic."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry"."Add.-Currency Debit Amount" WHERE("G/L Account No." = FIELD("No."), "G/L Account No." = FIELD(Totaling), "Business Unit Code" = FIELD("Business Unit Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Posting Date" = FIELD("Date Filter")));

        }
        field(50065; "Haber div.-adic."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry"."Add.-Currency Credit Amount" WHERE("G/L Account No." = FIELD("No."), "G/L Account No." = FIELD(Totaling), "Business Unit Code" = FIELD("Business Unit Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Posting Date" = FIELD("Date Filter")));

        }
        field(50066; "IC Partner Code"; CODE[20])
        {
            TableRelation = "IC Partner";
        }
        field(50067; "Fecha £lt. mov"; Date)
        {
            Caption = 'fecha últ. mov.';
            FieldClass = FlowField;
            CalcFormula = Max("G/L Entry"."Posting Date" WHERE("G/L Account No." = FIELD("No.")));
        }
        field(50068; "Bloq. Proceso"; Boolean)
        {

        }
        field(50069; "Filtro Circuitos"; Boolean)
        {
            FieldClass = FlowFilter;

        }
        field(50070; "Debe Acumulado"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Debit Amount" WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER(Totaling)),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                        "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                        "SalesPerson Code" = field("Salesperson Filter"),
                                                        "Dimension Set ID" = FIELD("Dimension Set ID Filter")));
            Caption = 'Debe Acumulado';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50071; "Haber Acumulado"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Credit Amount" WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER(Totaling)),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                        "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                        "SalesPerson Code" = field("Salesperson Filter"),
                                                        "Dimension Set ID" = FIELD("Dimension Set ID Filter")));
            Caption = 'Haber Acumulado';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}