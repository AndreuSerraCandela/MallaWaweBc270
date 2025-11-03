/// <summary>
/// TableExtension Payment MethodKuara (ID 80204) extends Record Payment Method.
/// </summary>
tableextension 80204 "Payment MethodKuara" extends "Payment Method"
{
    fields
    {
        field(50000; "Remesa sin factura"; Boolean) { }
        field(50001; "Imprimir recibo"; Boolean) { }
        field(50002; "Domiciliacion cliente"; Boolean) { }
        field(50004; "Banco transferencia"; CODE[20]) { TableRelation = "Bank Account"; }
        field(50005; "Banco Obligatorio"; Boolean) { }
        field(50006; "Cobro/Pagos/Ambos"; Enum "Cobro/Pagos/Ambos") { }
        field(50007; "En Todas Las Empresas"; Boolean) { }
        field(50008; "Visible"; Boolean) { }
        field(50009; "Intercambio"; Boolean) { }
        field(50010; "Sin Banco"; Boolean) { }
        field(50011; "Forma de Pago Emplazamiento"; TEXT[30]) { }
        field(60025; "Código Efactura"; CODE[2]) { }
        field(60027; "Cód. banco Efactura"; CODE[20]) { TableRelation = "Bank Account"; }
        field(70000; "Pago Confirming"; Enum "Pago Confirming") { }
        field(80000; "Medio pago SII"; CODE[2]) { }
        field(80001; RowNo; Integer) { }
    }

}
