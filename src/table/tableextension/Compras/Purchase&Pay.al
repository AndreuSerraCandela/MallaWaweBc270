/// <summary>
/// TableExtension Purchases Pay.SetupKuara (ID 80214) extends Record Purchases Payables Setup.
/// </summary>
tableextension 80214 "Purchases & Pay.SetupKuara" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Nº serie pagarés"; CODE[10]) { TableRelation = "No. Series"; }
        field(50001; "Carta pago fraccionado"; Boolean) { }
        field(50005; "Recursos en proforma"; Boolean) { }
        field(50006; "Impr recursos carta pago"; Boolean) { }
        field(50007; "Forma de Pago Emplz. Pag"; CODE[20]) { TableRelation = "Payment Method".Code; }
        field(50008; "Términos de pago emplazamiento"; CODE[20]) { TableRelation = "Payment Method".Code; }
        field(50009; "Cuenta FPR Emplz."; TEXT[30]) { TableRelation = "G/L Account"; }
        field(50010; "Forma de Pago Emplz. Trans"; CODE[20]) { TableRelation = "Payment Method".Code; }
        //field(50011; "Cuenta IRPF Emplz."; TEXT[30]) { TableRelation = "G/L Account"; }
        field(54006; "Activar contabilización albara"; Boolean) { }
        field(54007; "Num. serie fact. Empl"; CODE[10]) { TableRelation = "No. Series"; }
        field(90000; "Nº serie anulaciones"; CODE[10]) { TableRelation = "No. Series"; }
        field(90001; "Grupo Neg Empla"; CODE[10]) { TableRelation = "VAT Business Posting Group"; }
        field(54009; "Nº serie fact. Empl"; CODE[10]) { ObsoleteState = Removed; }
    }
}
