/// <summary>
/// TableExtension Cartera SetupKuara (ID 80344) extends Record Cartera Setup.
/// </summary>
tableextension 80344 "Cartera SetupKuara" extends "Cartera Setup"
{
    fields
    {
        field(50000; "Nº serie borrador pagare"; CODE[10]) { TableRelation = "No. Series"; }
        field(50001; "Forma Pago Pagare"; CODE[20]) { TableRelation = "Payment Method"; }
        field(50002; "Registro aut. pagarés"; Boolean) { }
        field(50003; "Ult. no. pagare tipo 1"; TEXT[30]) { }
        field(50004; "Ult. no. pagare tipo 2"; TEXT[30]) { }
        field(50006; "Diario reg. pagares"; CODE[10]) { TableRelation = "Gen. Journal Template"; }
        field(50007; "Seccion reg. pagares"; CODE[10]) { TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Diario reg. pagares")); }
        field(50008; "Nº serie relacion pagos"; CODE[10]) { TableRelation = "No. Series"; }
        field(50009; "Seccion remesa sin factura"; CODE[10]) { TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = CONST('CARTERA')); }
        field(50010; "Diario reg. remesas"; CODE[10]) { TableRelation = "Gen. Journal Template"; }
        field(50011; "Seccion reg. remesas"; CODE[10]) { TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Diario reg. remesas")); }
    }
}
