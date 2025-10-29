/// <summary>
/// Table Lin. borrador pagare (ID 7001182).
/// </summary>
table 7001182 "Lin. borrador pagare"
{
    fields
    {
        field(1; "Cód. pagaré"; Code[20]) { Caption = 'Cód. borrador factura'; }
        field(2; "No. documento"; Code[20]) { Caption = 'Nº documento'; }
        field(3; "Importe"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cod. divisa";
        }
        field(4; "Fecha documento"; Date) { Caption = 'Fecha documento'; }
        field(10; "No. linea"; Integer) { Caption = 'Nº línea'; }
        field(11; "No. mov. proveedor"; Integer) { Caption = 'Nº mov. proveedor'; }
        field(12; "No. documento proveedor"; Code[20]) { Caption = 'Nº documento proveedor'; }
        field(13; "Tipo documento"; Enum "Tipo Documento Envios") { }
        field(14; "Cod. divisa"; Code[10]) { Caption = 'Cód. divisa'; }
    }
    KEYS
    {
        key(P; "Cód. pagaré", "No. documento", "No. linea")
        {
            SumIndexfields = Importe;
            Clustered = true;
        }
    }
    VAR
        CabBorrador: Record "Cab. borrador pagare";

}