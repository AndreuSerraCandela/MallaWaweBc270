/// <summary>
/// Table Saldo Interempresa (ID 7001170).
/// </summary>
table 7001170 "Saldo Interempresa"
{
    fields
    {
        field(57; "Source Type"; Enum "Gen. Journal Source Type")
        {
            Caption = 'Tipo procedencia mov.';

        }
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
        field(50005; "Saldo en Contab"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("Filtro Cuenta"),
                    "Posting Date" = FIELD("Filtro Fecha"),
                    "Document Type" = FIELD("Document Type"),
                    "Source No." = FIELD("Source No."),
                    "Source Type" = FIELD("Source Type"),
                    "IC Partner Code" = FILTER('')));
            Editable = false;
            AutoFormatType = 1;
        }
        field(50006; "Filtro Cuenta"; Text[30]) { FieldClass = FlowFilter; }
        field(50007; "Filtro Fecha"; Date) { FieldClass = FlowFilter; }
        field(50008; "Tiene Mov."; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("G/L Entry" WHERE("G/L Account No." = FIELD("Filtro Cuenta"),
                    "Posting Date" = FIELD("Filtro Fecha"),
                    "Source No." = FIELD("Source No."),
                    "Source Type" = FIELD("Source Type")));
            Editable = false;
            AutoFormatType = 1;
        }
        field(50009; "Debe en Contab"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry"."Debit Amount" WHERE("Source Type" = FIELD("Source Type filter"),
                    "IC Partner Code" = FIELD("IC Partner"),
                    "G/L Account No." = FIELD("Filtro Cuenta"),
                    "Posting Date" = FIELD("Filtro Fecha"),
                    "Document Type" = FIELD("Document Type")));
            Editable = false;
            AutoFormatType = 1;
        }
        field(50010; "Haber en Contab"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry"."Credit Amount" WHERE("Source Type" = FIELD("Source Type filter"),
                    "IC Partner Code" = FIELD("IC Partner"),
                    "G/L Account No." = FIELD("Filtro Cuenta"),
                    "Posting Date" = FIELD("Filtro Fecha"),
                    "Document Type" = FIELD("Document Type")));
            Editable = false;
            AutoFormatType = 1;
        }
        field(50011; "Document Type"; Enum "Document Type Kuara")
        {
            FieldClass = FlowFilter;
            Caption = 'Tipo documento';

        }
        field(50012; "Saldo Contrato"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Cuentas temp det".Saldo WHERE(Cuenta = FIELD("Filtro Cuenta"),
                    Contrato = FIELD("Source No.")));
        }
        field(50013; "Saldo en otra empresa"; Decimal) { }
        field(50014; "Saldo en otra empresa Albara"; Decimal) {; }
        field(50015; "Saldo en otra Empresa Fact/Abo"; Decimal) {; }
        field(50016; "IC Partner"; Code[20]) { }
        field(50017; "Source Type filter"; Enum "Gen. Journal Source Type")
        {
            FieldClass = FlowFilter;
            Caption = 'filtro Tipo procedencia mov.';

        }
        field(50018; "Tiene Mov. Activo"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("G/L Entry" WHERE("G/L Account No." = FIELD("Filtro Cuenta"),
                    "Posting Date" = FIELD("Filtro Fecha"),
                    "IC Partner Code" = FIELD("IC Partner")));
            Editable = false;
            AutoFormatType = 1;
        }
        field(50019; "Saldo en Contab activos"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("Filtro Cuenta"),
                    "Posting Date" = FIELD("Filtro Fecha"),
                    "Document Type" = FIELD("Document Type"),
                    "IC Partner Code" = FIELD("IC Partner"),
                    "Source Type" = FIELD("Source Type filter")));
            Editable = false;
            AutoFormatType = 1;
        }
    }
    KEYS
    {
        key(P; "Source Type", "Source No.") { Clustered = true; }
    }

}
