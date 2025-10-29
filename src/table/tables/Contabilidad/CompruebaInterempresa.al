/// <summary>
/// Table Comprueba Interempresa (ID 7001162).
/// </summary>
table 7001162 "Comprueba Interempresa"
{
    fields
    {
        field(57; "Empresa"; Text[30])
        {
            TableRelation = Company;
            Caption = 'Tipo procedencia mov.';
        }
        field(58; "Source No."; Code[20])
        {
            TableRelation = "IC Partner";
            Caption = 'Cód. procedencia mov.';
        }
        field(50005; "Saldo Ventas"; Decimal)
        {
            Editable = false;
            AutoFormatType = 1;
        }
        field(50007; "Filtro Fecha"; Date) { FieldClass = FlowFilter; }
        field(50009; "Saldo Compras"; Decimal)
        {
            Editable = false;
            AutoFormatType = 1;
        }
        field(50011; "Document Type"; Enum "Document Type Kuara")
        {
            FieldClass = FlowFilter;
        }
        field(50012; "Saldo FPR"; Decimal) { }
    }
    KEYS
    {
        key(P; Empresa, "Source No.") { Clustered = true; }
    }

}

