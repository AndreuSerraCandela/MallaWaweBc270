/// <summary>
/// TableExtension Sales Invoice HeaderKuara (ID 80169) extends Record Sales Invoice Header.
/// </summary>
tableextension 80169 "Sales Invoice HeaderKuara" extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "Tipo"; Enum "Tipo Venta Job") { }
        field(50005; "Firmado"; Enum "Firmado") { }
        field(50006; "Fecha Firma"; Date) { }
        field(50010; "Fecha inicial proyecto"; Date) { }
        field(50011; "Fecha fin proyecto"; Date) { }
        field(50015; "Cód. términos facturacion"; CODE[10])
        {
            TableRelation = "Términos facturación";
        }
        field(50018; "Subtipo"; Enum "Subtipo") { }
        field(50030; "Nº Contrato"; CODE[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order), "No." = FIELD("Nº Contrato"));
        }
        field(50041; "Soporte de"; Enum "Soporte de") { }
        field(50045; "Comentario Cabecera"; TEXT[50]) { }
        field(50062; "Interc./Compens."; Enum "Interc./Compens.") { Caption = 'Interc./Compens./Dona.'; }
        field(50063; "Proyecto origen"; CODE[20]) { TableRelation = Job; }
        field(50064; "Renovado"; Boolean) { }
        field(50065; "Fecha inicial factura"; Date) { }
        field(50066; "Fecha final factura"; Date) { }
        field(50070; "Ajustada"; Boolean) { }
        field(50075; "Nº Proyecto"; CODE[20]) { TableRelation = Job; }
        field(54095; "Nº pedido"; Code[20]) { }
        field(50076; "Eliminar"; TEXT[30]) { }
        field(50077; "Nº Proyecto2"; CODE[20])
        {
            TableRelation = Job;
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Line"."Job No." WHERE("Document No." = FIELD("No."), Type = CONST(Resource)));
        }
        field(50095; "Albarán Empresa Origen"; CODE[20]) { }
        field(50103; "Cod cadena"; CODE[10]) { TableRelation = "Codigos cadena"; }
        field(50110; "Pte verificar"; Boolean) { }
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
        field(50097; "Factura Compra"; Code[20]) { }
        field(51102; "Nº Remesa Fact. Electrónica"; Integer) { }
        field(52000; "Pte Contabilicación"; Boolean) { }
        field(52003; "Fact. Electrónica Activada"; Boolean) { }
        field(60000; "Enviada E-Mail"; Boolean) { }
        field(60017; "Document Sending Profile"; CODE[20])
        {
            TableRelation = "Document Sending Profile";
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer."Document Sending Profile" WHERE("No." = FIELD("Sell-to Customer No.")));
        }
        field(60030; "Situación Efactura"; Enum "Situación Efactura") { }
        field(70000; "Nuestra Cuenta"; CODE[20]) { TableRelation = "Bank Account"; }
        field(70001; "Nuestra Cuenta Prepago"; CODE[20]) { TableRelation = "Bank Account"; }
        field(80000; "Tipo factura SII"; CODE[2]) { }
        field(80001; "Clave registro SII expedidas"; CODE[2]) { }
        field(80006; "Descripción operación"; TEXT[250]) { }
        field(80007; "Tipo factura rectificativa"; CODE[1]) { }
        field(80008; "Reportado SII"; Boolean) { }
        field(80009; "Nombre fichero SII"; TEXT[250]) { }
        field(80010; "Fecha/hora subida fichero SII"; DateTime) { }
        field(80011; "Estado"; TEXT[30]) { }
        field(80012; "Reportado SII primer semestre"; Boolean) { }
        field(54096; "Customer Order No."; Code[20]) { Caption = 'Nº de pedido cliente'; }
        field(90013; "Oficina contable"; Text[30]) { }
        field(90014; "Organo gestor"; Text[30]) { }
        field(90015; "Unidad tramitadora"; Text[30]) { }
        field(50094; "Vendedor Origen"; Code[20]) { }
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
        //     CalcFormula = Sum("Sales Invoice Line"."Retention Amount (GE)" WHERE("Document No." = FIELD("No.")));

        //     Caption = 'Importe retención (BE)';
        //     Editable = false;
        // }
        // field(95003; "Retention Amount (IRPF)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Sales Invoice Line"."Retention Amount (IRPF)" WHERE("Document No." = FIELD("No.")));

        //     Caption = 'Importe retención (IRPF)';
        //     Editable = false;
        // }
        field(60019; "Nombre Comercial"; Text[250])
        {
            Caption = 'Anunciante';
            TableRelation = "Nombre Comercial".Nombre;
        }
    }
}

