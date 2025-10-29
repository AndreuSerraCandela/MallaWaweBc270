/// <summary>
/// TableExtension Return Shipment HeaderKuara (ID 80303) extends Record Return Shipment Header.
/// </summary>
tableextension 80303 "Return Shipment HeaderKuara" extends "Return Shipment Header"
{
    fields
    {
        field(50017; "Nº Contrato Venta"; CODE[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."No." WHERE("Document Type" = CONST(Order), "Nº Proyecto" = FIELD("Nº Proyecto")));
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            ValidateTableRelation = false;
        }
        field(50075; "Nº Proyecto"; CODE[20]) { TableRelation = Job; }
        field(51040; "Shortcut Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';

        }
        field(51041; "Shortcut Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';

        }
        field(51042; "Shortcut Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';

        }
        field(54001; "Contabilizado"; Boolean) { }
        field(54002; "Facturado"; Boolean) { }
        field(54103; "Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Return Shipment Line".Amount WHERE("Document No." = FIELD("No.")));
        }
        field(54104; "Importe Facturado"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Return Shipment Line"."Importe Facturado" WHERE("Document No." = FIELD("No.")));
        }
        field(54105; "Importe Pte Facturar"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Return Shipment Line"."Importe Pte Facturar" WHERE("Document No." = FIELD("No.")));
        }
        field(54106; "No Abono"; CODE[20]) { }
        field(80000; "Tipo factura SII"; CODE[2]) { }
        field(80002; "Clave registro SII recibidas"; CODE[2]) { }
        field(80006; "Descripción operación"; TEXT[250]) { }
        field(80007; "Tipo factura rectificativa"; CODE[1]) { }
    }
}
