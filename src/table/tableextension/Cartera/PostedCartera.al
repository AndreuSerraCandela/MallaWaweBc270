/// <summary>
/// TableExtension Posted Cartera Doc.Kuara (ID 80336) extends Record Posted Cartera Doc..
/// </summary>
tableextension 80336 "Posted Cartera Doc.Kuara" extends "Posted Cartera Doc."
{
    fields
    {
        modify("Cust./Vendor Bank Acc. Code")
        {
            TableRelation = if (Type = CONST(Payable)) "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("Account No."))
            else
            "Customer Bank Account".Code WHERE("Customer No." = FIELD("Account No."));

        }
        field(50000; "Al descuento (2)"; Boolean) { }
        field(50001; "No. Borrador factura"; CODE[20]) { }
        field(52000; "Fecha Descuento"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Posted Bill Group"."Posting Date" WHERE("No." = FIELD("Bill Gr./Pmt. Order No.")));
        }
        field(52002; "Banco"; CODE[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Posted Bill Group"."Bank Account No." WHERE("No." = FIELD("Bill Gr./Pmt. Order No.")));
        }
        field(52003; "Al Descuento"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Posted Bill Group"."Remesa al descuento" WHERE("No." = FIELD("Bill Gr./Pmt. Order No.")));
        }
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
        field(70010; "Entidad Cliente"; CODE[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Customer Bank Account"."Bank Account No." WHERE("Customer No." = FIELD("Account No."), Code = FIELD("Cust./Vendor Bank Acc. Code")));
        }
        field(70011; "Entidad Proveedor"; CODE[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Vendor Bank Account"."Bank Account No." WHERE("Vendor No." = FIELD("Account No."), Code = FIELD("Cust./Vendor Bank Acc. Code")));
        }
    }
}
