/// <summary>
/// Table Iva por fechas (ID 7010482).
/// </summary>
table 7001203 "Iva por fechas"
{
    fields
    {
        field(1; "VAT Bus. Posting Group"; Code[10])
        {
            TableRelation = "VAT Business Posting Group";
            Caption = 'Grupo registro IVA neg.';
        }
        field(2; "VAT Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
            Caption = 'Grupo registro IVA prod.';
        }
        field(3; "Fecha Entrada en vigor"; Date) { }
        field(4; "New VAT Bus. Posting Group"; Code[10])
        {
            TableRelation = "VAT Business Posting Group";
            Caption = 'Nuevo Grupo registro IVA neg.';
        }
        field(5; "New VAT Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
            Caption = 'Nuevo Grupo registro IVA prod.';
        }
    }
    KEYS
    {
        key(P; "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Fecha Entrada en vigor")
        {
            Clustered = true;
        }
    }
}

