/// <summary>
/// TableExtension Cartera Doc.Kuara (ID 80335) extends Record Cartera Doc..
/// </summary>
tableextension 80335 "Cartera Doc.Kuara" extends "Cartera Doc."
{
    fields
    {
        field(50001; "No. Borrador factura"; CODE[20]) { }
        field(50700; "Original Document No. ant"; CODE[20]) { }
        field(51200; "Direct Debit Mandate ID5"; CODE[35])
        {
            TableRelation = "SEPA Direct Debit Mandate".ID WHERE("Customer No." = FIELD("Account No."));
        }
        field(55000; "Importe Pendiente prov"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor Ledger Entry No." = FIELD("Entry No.")));
        }
        field(70000; "Banco"; CODE[10]) { TableRelation = "Bank Account"; }
        field(70001; "Nº Impreso"; CODE[20]) { }
        field(70002; "¨Esta Impreso?"; Enum "¿Esta Impreso?") { Caption = '¿Está impreso?'; }
        field(70003; "Estado Confirming"; Enum "Estado Confirming") { }
        field(70004; "Pendiente liq. conf."; Boolean) { }
        field(70005; "Nº Pagaré Emplzazaminto"; TEXT[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Mov. emplazamientos"."No pagare" WHERE("Nº proveedor" = FIELD("Account No."), "Nº Factura definitivo" = FIELD("Document No."), "Fecha prevista pago" = FIELD("Due Date")));
        }
        field(70006; "Transferencia"; Boolean) { }
        field(70007; "Importe Factura"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Amount Including VAT" WHERE("Document Type" = CONST(Invoice), "Document No." = FIELD("No. Borrador factura")));
        }
        field(70008; "Importe Base"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Amount WHERE("Document Type" = CONST(Invoice), "Document No." = FIELD("No. Borrador factura")));
        }
        field(70009; "Iban Cliente"; CODE[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Customer Bank Account".IBAN WHERE("Customer No." = FIELD("Account No."), Code = FIELD("Cust./Vendor Bank Acc. Code")));
        }
        field(70010; "Entidad Cliente"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Customer Bank Account"."CCC Bank No." WHERE("Customer No." = FIELD("Account No."), Code = FIELD("Cust./Vendor Bank Acc. Code")));
        }
        field(70011; "Entidad Proveedor"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Vendor Bank Account"."CCC Bank No." WHERE("Vendor No." = FIELD("Account No."), Code = FIELD("Cust./Vendor Bank Acc. Code")));
        }

    }
}
