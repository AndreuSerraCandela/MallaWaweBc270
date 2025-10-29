/// <summary>
/// TableExtension Sales Cr.Memo HeaderKuara (ID 80171) extends Record Sales Cr.Memo Header.
/// </summary>
tableextension 80171 "Sales Cr.Memo HeaderKuara" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50000; "Tipo"; Enum "Tipo Venta Job") { }
        field(50005; "Firmado"; Enum "Firmado") { }
        field(50006; "Fecha Firma"; Date) { }
        field(50018; "Subtipo"; Enum "Subtipo") { }
        field(50030; "Nº Contrato"; CODE[20]) { TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order), "No." = FIELD("Nº Contrato")); }
        field(50041; "Soporte de"; Enum "Soporte de") { }
        field(50045; "Comentario Cabecera"; TEXT[50]) { }
        field(50070; "Ajustada"; Boolean) { }
        field(50075; "Nº Proyecto"; CODE[20]) { TableRelation = Job; }
        field(50095; "Albarán Empresa Origen"; CODE[20]) { }
        field(50103; "Cod cadena"; CODE[10]) { TableRelation = "Codigos cadena"; }
        field(50110; "Pte verificar"; Boolean) { }
        field(50094; "Vendedor Origen"; Code[20]) { }
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
        field(50096; "Empresa Origen Alb"; TEXT[30]) { }

        field(51102; "Nº Remesa Fact. Electrónica"; Integer) { }
        field(52000; "Pte Contabilicación"; Boolean) { }
        field(52001; "Customer Order No."; CODE[20]) { Caption = 'Nº de pedido cliente'; }
        field(52003; "Fact. Electrónica Activada"; Boolean) { }
        field(60000; "Enviada E-Mail"; Boolean) { }
        field(60017; "Document Sending Profile"; CODE[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer."Document Sending Profile" WHERE("No." = FIELD("Sell-to Customer No.")));
            TableRelation = "Document Sending Profile";
        }
        field(60030; "Situación Efactura"; Enum "Situación Efactura") { }
        field(80000; "Tipo factura SII"; CODE[2]) { }
        field(80001; "Clave registro SII expedidas"; CODE[2]) { }
        field(80006; "Descripción operación"; TEXT[250]) { }
        field(80007; "Tipo factura rectificativa"; CODE[1]) { }
        field(80008; "Reportado SII"; Boolean) { }
        field(80009; "Nombre fichero SII"; TEXT[250]) { }
        field(80010; "Fecha/hora subida fichero SII"; DateTime) { }
        field(80011; "Estado"; TEXT[30]) { }
        field(80012; "Reportado SII primer semestre"; Boolean) { }
        field(90013; "Oficina contable"; Text[30]) { }
        field(90014; "Organo gestor"; Text[30]) { }
        field(90015; "Unidad tramitadora"; Text[30]) { }
        // field(95000; "Retention Group Code (GE)"; Code[20])
        // {
        //     ObsoleteState = Removed;
        //     TableRelation = "Payments Retention Group".Code WHERE("Retention Type" = CONST("Good Execution"));
        //     DataClassification = ToBeClassified;

        //     Caption = 'Código grupo retención (BE)';
        // }
        // field(95001; "Retention Group Code (IRPF)"; Code[20])
        // {
        //     ObsoleteState = Removed;
        //     TableRelation = "Payments Retention Group".Code WHERE("Retention Type" = CONST(IRPF));
        //     DataClassification = ToBeClassified;

        //     Caption = 'Código grupo retención (IRPF)';
        // }
        // field(95002; "Retention Amount (GE)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Sales Cr.Memo Line"."Retention Amount (GE)" WHERE("Document No." = FIELD("No.")));

        //     Caption = 'Importe retención (BE)';
        //     Editable = false;
        // }
        // field(95003; "Retention Amount (IRPF)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Sales Cr.Memo Line"."Retention Amount (IRPF)" WHERE("Document No." = FIELD("No.")));

        //     Caption = 'Importe retención (IRPF)';
        //     Editable = false;
        // }
    }
}
