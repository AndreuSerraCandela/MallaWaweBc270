/// <summary>
/// Table Facturas Propuestas (ID 7001140).
/// </summary>
table 7001140 "Facturas Propuestas"
{
    fields
    {
        field(1; "No. Contrato"; Code[20]) { TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order)); }
        field(5; "No. linea"; Integer) { }
        field(10; "Fecha Contrato"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Posting Date" WHERE("Document Type" = CONST(Order),
                                                                                                           "No." = FIELD("No. Contrato")));
            Description = 'FF';
            Editable = false;
        }
        field(15; "No. Proyecto"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Nº Proyecto" WHERE("Document Type" = CONST(Order),
                                                                                                          "No." = FIELD("No. Contrato")));
            Editable = false;
        }
        field(20; "Fecha Factura"; Date) { }
        field(25; "Cód. Forma Pago"; Code[10]) { TableRelation = "Payment Method"; }
        field(30; "Cód. Términos Pago"; Code[10]) { TableRelation = "Payment Terms"; }
        field(35; "Cód. términos facturacion"; Code[10]) { TableRelation = "Términos facturación"; }
        field(40; "Fecha Vencimiento"; Date)
        {
            trigger OnValidate()
            BEGIN
                if rCabVenta.GET(rCabVenta."Document Type"::Order, "No. Contrato") THEN BEGIN
                    if rCabVenta.Estado = rCabVenta.Estado::Firmado THEN
                        ERROR(Text001);
                END;
            END;
        }
        field(45; "Tipo Facturación"; Enum "Facturación resaltada")
        {

        }
        field(50; "No. Borrador Factura"; Code[20]) { }
        field(55; "Texto de registro"; Text[50]) { }
        field(60; "Importe sin IVA"; Decimal) { }
        field(61; "Importe con IVA"; Decimal) { }
        field(62; "Factura 1"; Boolean) { }
        field(63; "Customer Order No."; Code[20]) { Caption = 'Nº de pedido cliente'; }
    }
    KEYS
    {
        key(P; "No. Contrato", "No. linea") { Clustered = true; }
    }
    VAR
        rCabVenta: Record 36;
        Text001: Label 'No se permite modificar fecha de vencimiento si el contrato está firmado.';

}
