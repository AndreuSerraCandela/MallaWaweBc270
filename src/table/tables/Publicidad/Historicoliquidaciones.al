/// <summary>
/// Table Histórico liquidaciones (ID 7001129).
/// </summary>
table 7001129 "Histórico liquidaciones"
{
    fields
    {
        field(1; "Nº liq."; Integer)
        {
            Caption = 'Nº liq.';
            Description = 'PK';
        }
        field(2; "Nº mov."; Integer)
        {
            Caption = 'Nº mov.';
            Description = 'PK';
        }
        field(3; "Nº mov. liquidado"; Integer)
        {
            Caption = 'Nº mov. liquidado';
            Description = 'PK';
        }
        field(5; "Cód. divisa"; Code[10])
        {
            TableRelation = Currency;
            Caption = 'Cód. divisa';
            Description = 'FK Divisa';
        }
        field(7; "Importe liquidado"; Decimal)
        {
            Caption = 'Importe liquidado';
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. divisa";
        }
        field(9; "Importe liquidado (DL)"; Decimal)
        {
            Caption = 'Importe liquidado (DL)';
            AutoFormatType = 1;
        }
        field(11; "Fecha liquidacion"; Date) { Caption = 'Fecha liquidacion'; }
        field(13; "Tipo mov."; Enum "Tipo mov.")
        {
            Caption = 'Tipo mov.';

        }
        field(15; "Nº cuenta"; Code[20])
        {
            TableRelation = if ("Tipo mov." = CONST("G/L Account")) "G/L Account"
            ELSE
            if ("Tipo mov." = CONST(Customer)) Customer
            ELSE
            if ("Tipo mov." = CONST(Vendor)) Vendor
            ELSE
            if ("Tipo mov." = CONST("Bank Account")) "Bank Account";
            Caption = 'Nº cuenta';
        }
        field(17; "Fecha proceso"; Date) { Caption = 'Fecha proceso'; }
        field(19; "Fecha registro"; Date) { Caption = 'Fecha registro'; }
        field(50; "Importe (DL)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry".Amount WHERE("Entry No." = FIELD("Nº mov.")));
            Caption = 'Importe (DL)';
            AutoFormatType = 1;
        }
        field(52; "Descripción"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry".Description WHERE("Entry No." = FIELD("Nº mov.")));
            Caption = 'Descripción';
        }
        field(53; "Tipo documento"; Enum "Document Type Kuara")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."Document Type" WHERE("Entry No." = FIELD("Nº mov.")));
            Caption = 'Tipo documento';
            ;
        }
        field(54; "Nº documento"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."Document No." WHERE("Entry No." = FIELD("Nº mov.")));
            Caption = 'Nº documento';
        }
        field(55; "Cód. departamento"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."Global Dimension 1 Code" WHERE("Entry No." = FIELD("Nº mov.")));
            Caption = 'Cód. departamento';
        }
        field(56; "Cód. programa"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."Global Dimension 2 Code" WHERE("Entry No." = FIELD("Nº mov.")));
            Caption = 'Cód. programa';
        }
        field(57; "Fecha Vencimiento"; Date) { Caption = 'Fecha Vencimiento'; }
        field(50000; "Replicado"; Boolean) { Caption = 'Replicado'; }
    }
    KEYS
    {
        key(P; "Nº liq.", "Nº mov.", "Nº mov. liquidado") { Clustered = true; }
        key(A; "Tipo mov.", "Nº cuenta", "Fecha liquidacion", "Fecha registro")
        {
            SumIndexfields = "Importe liquidado", "Importe liquidado (DL)";
        }
        key(B; "Nº mov.", "Fecha liquidacion", "Fecha registro") { SumIndexfields = "Importe liquidado", "Importe liquidado (DL)"; }
        key(C; Replicado) { }
        key(D; "Nº mov. liquidado") { }
    }
}

