/// <summary>
/// Table Pagare/Confirming-Factura (ID 7001193).
/// </summary>
table 7001193 "Pagare/Confirming-Factura"
{
    Caption = 'Pagare/Confirming-Factura2';
    fields
    {
        field(1; "Pagaré/Confirming"; Code[20]) { Caption = 'Pagaré/Confirming'; }
        field(4; "Tipo documento"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Tipo documento';

        }
        field(5; "Numero"; Code[20]) { Caption = 'Numero'; }
        field(6; "Nº Efecto"; Code[10]) { Caption = 'Nº Efecto'; }
        field(10; "Importe original"; Decimal)
        {
            Caption = 'Importe original';
            AutoFormatType = 1;
        }
        field(15; "Importe a pagar"; Decimal)
        {
            Caption = 'Importe a pagar';
            AutoFormatType = 1;
        }
        field(20; "Nº Externo"; Code[20]) { Caption = 'Nº Externo'; }
        field(25; "Efecto Interno"; Code[20]) { Caption = 'Efecto Interno'; }
        field(30; "Cód. proveedor"; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Cód. proveedor';
            Description = 'FK Proveedor';
        }
        field(32; "Fecha emisión documento"; Date) { Caption = 'Fecha emisión documento'; }
        field(34; "Fecha vencimiento"; Date) { Caption = 'Fecha vencimiento'; }
    }
    KEYS
    {
        key(P; "Pagaré/Confirming", "Tipo documento", Numero, "Nº Efecto")
        {
            Clustered = true;
        }
        key(I; "Importe original") { }
        key(C; "Pagaré/Confirming", "Efecto Interno") { }
        key(V; "Cód. proveedor", "Fecha vencimiento") { }
        key(B; "Fecha vencimiento") { }
    }

}