/// <summary>
/// Table Recibos (ID 7010473).
/// </summary>
table 7001173 Recibos
{

    fields
    {
        field(1; "Contrato"; Text[30]) { }
        field(2; "Fecha Registro"; Date) { }
        field(3; "Fecha Vencimiento"; Date) { }
        field(4; "Importe"; Decimal) { }
    }
    KEYS
    {
        key(P; Contrato) { Clustered = true; }
    }

}

