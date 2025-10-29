/// <summary>
/// TableExtension Purch. Cr. Memo Hdr.Kuara (ID 80177) extends Record Purch. Cr. Memo Hdr..
/// </summary>
tableextension 80177 "Purch. Cr. Memo Hdr.Kuara" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50004; "Emplazamiento"; TEXT[30]) { }
        field(50075; "Nº Proyecto"; CODE[20]) { TableRelation = Job; }
        field(50076; "Pte verificar"; Boolean) { }
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
        field(51043; "Nº Contrato"; Code[20])
        {

            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            ValiDateTableRelation = false;

        }
        field(80000; "Tipo factura SII"; CODE[2]) { }
        field(80002; "Clave registro SII recibidas"; CODE[2]) { }
        field(80006; "Descripción operación"; TEXT[250]) { }
        field(80007; "Tipo factura rectificativa"; CODE[1]) { }
        field(80008; "Reportado SII"; Boolean) { }
        field(80009; "Nombre fichero SII"; TEXT[250]) { }
        field(80010; "Fecha/hora subida fichero SII"; DateTime) { }
        field(80011; "Estado"; TEXT[30]) { }
        field(80012; "Reportado SII primer semestre"; Boolean) { }
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
        //     CalcFormula = Sum("Purch. Cr. Memo Line"."Retention Amount (GE)" WHERE("Document No." = FIELD("No.")));

        //     Caption = 'Importe retención (BE)';
        //     Editable = false;
        // }
        // field(95003; "Retention Amount (IRPF)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Purch. Cr. Memo Line"."Retention Amount (IRPF)" WHERE("Document No." = FIELD("No.")));

        //     Caption = 'Importe retención (IRPF)';
        //     Editable = false;
        // }
    }
}