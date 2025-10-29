/// <summary>
/// TableExtension Purch. Inv. LineKuara (ID 80176) extends Record Purch. Inv. Line.
/// </summary>
tableextension 80176 "Purch. Inv. LineKuara" extends "Purch. Inv. Line"
{
    fields
    {
        field(50011; "Periodo de Pago"; TEXT[30]) { }
        field(50063; "Receipt No. Ant"; CODE[20]) { }
        field(50064; "Receipt Line No. Ant"; Integer) { }
        field(50065; "Existe Albaran"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Purch. Rcpt. Line" WHERE("Document No." = FIELD("Receipt No.")));
        }
        field(50091; "Fecha inicial recurso"; Date) { }
        field(50092; "Fecha final recurso"; Date) { }
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
        field(54001; "Empresa Origen"; TEXT[30]) { }
        field(54002; "Proyecto Origen"; CODE[20]) { }
        field(54003; "Recurso"; CODE[20]) { }
        field(54004; "Recurso agrupado"; boolean) { }

        field(54079; "Linea de proyecto"; Integer) { }
        field(70000; "Tipo sit. inmueble SII"; CODE[10]) { }
        field(70001; "Ref. catastral inmueble SII"; TEXT[30]) { }
        field(92000; "Código Del Prestamo"; Text[100]) { }
        // field(95000; "Retention % (GE)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     ObsoleteState = Removed;
        //     Caption = '% retención (BE)';
        //     Editable = false;
        // }
        // field(95001; "Retention % (IRPF)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     ObsoleteState = Removed;
        //     Caption = '% retención (IRPF)';
        //     Editable = false;
        // }
        // field(95002; "Retention Amount (GE)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     ObsoleteState = Removed;
        //     Caption = 'Importe retención (BE)';
        //     Editable = false;
        // }
        // field(95003; "Retention Amount (IRPF)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     ObsoleteState = Removed;
        //     Caption = 'Importe retención (IRPF)';
        //     Editable = false;
        // }

    }
}
