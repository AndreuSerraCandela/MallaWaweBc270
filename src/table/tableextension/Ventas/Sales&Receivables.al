/// <summary>
/// TableExtension Sales Receivables SetupKuara (ID 80213) extends Record Sales Receivables Setup.
/// </summary>
tableextension 80213 "Sales & Receivables SetupKuara" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Facturación resaltada"; Enum "Facturación resaltada") { }
        field(50001; "Forma pago prepago"; CODE[10]) { TableRelation = "Payment Method"; }
        field(50002; "Pie 1 factura"; TEXT[200]) { }
        field(50003; "Pie 2 factura"; TEXT[200]) { }
        field(50004; "Pie 3 factura"; TEXT[200]) { }
        field(50005; "Internal Order Nos."; CODE[10]) { TableRelation = "No. Series"; }
        field(50006; "Texto 2 LOPD"; TEXT[115]) { ObsoleteState = Removed; }
        field(50007; "Texto 3 LOPD"; TEXT[115]) { ObsoleteState = Removed; }
        field(50008; "Texto 4 LOPD"; TEXT[115]) { ObsoleteState = Removed; }
        field(50009; "Texto 5 LOPD"; TEXT[115]) { ObsoleteState = Removed; }
        field(50010; "Texto 6 LOPD"; TEXT[115]) { ObsoleteState = Removed; }
        field(50019; "Texto 7 LOPD"; TEXT[115]) { ObsoleteState = Removed; }
        field(50011; "Texto 1 LOPD"; TEXT[1248]) { }
        field(50012; "Impresora Pdf"; TEXT[30]) { }
        field(50013; "Ruta Pdf generados"; TEXT[100]) { }
        field(50014; "Texto empresa"; TEXT[100]) { }
        // field(50016; "% Irpf"; Decimal) { }
        // field(50017; "Cuenta Ret. IRPF"; TEXT[30]) { TableRelation = "G/L Account"; }
        // field(50018; "% Irpf Alquileres"; Decimal) { }
        field(50045; "Direct Debit Mandate Nos. ant"; CODE[10]) { TableRelation = "No. Series"; }
        field(50046; "Prepay. Terms Code"; Code[20])
        {
            TableRelation = "Payment Terms";
        }
        field(90000; "Nº serie anulaciones"; CODE[10]) { TableRelation = "No. Series"; }
        field(90001; "nodeRef Alfresco"; Text[250]) { }
        field(90002; posKey; Text[30]) { }
        field(90003; "Firma visible"; Boolean) { }
        field(90004; "Página firma"; integer) { }
        field(90005; xPos; integer) { }
        field(90006; yPos; integer) { }
        field(90007; posKey2; Text[30]) { }
        field(90009; xPos2; integer) { }
        field(90010; yPos2; integer) { }
        field(90016; DocumentType; Text[30])
        {

        }
        field(90008; "Activar Cont a 0"; Boolean) { }
        field(90013; "Activar Prepago"; Boolean) { }
        field(90011; "Url Pdf"; Text[250]) { }
        field(90012; Carta; Option)
        {
            OptionMembers = Juntos,"1 Envio","2 Envios";
        }
        field(90014; "Activar e-informa"; Boolean) { }
        field(90015; "Activar Aviso Cobro"; Boolean) { }

    }
}
