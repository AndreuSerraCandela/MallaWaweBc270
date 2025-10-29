/// <summary>
/// TableExtension Purch. Cr. Memo LineKuara (ID 80178) extends Record Purch. Cr. Memo Line.
/// </summary>
tableextension 80178 "Purch. Cr. Memo LineKuara" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50011; "Periodo de Pago"; TEXT[30]) { }
        field(50063; "Receipt No."; CODE[20]) { }
        field(50064; "Receipt Line No."; Integer) { }
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

        field(70000; "Tipo sit. inmueble SII"; CODE[10]) { }
        field(70001; "Ref. catastral inmueble SII"; TEXT[30]) { }
        field(92000; "Código Del Prestamo"; Text[100]) { }
        // field(95000; "Retention % (GE)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;

        //     Caption = '% retención (BE)';
        //     Editable = false;
        // }
        // field(95001; "Retention % (IRPF)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;

        //     Caption = '% retención (IRPF)';
        //     Editable = false;
        // }
        // field(95002; "Retention Amount (GE)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;

        //     Caption = 'Importe retención (BE)';
        //     Editable = false;
        // }
        // field(95003; "Retention Amount (IRPF)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;

        //     Caption = 'Importe retención (IRPF)';
        //     Editable = false;
        // }
        field(50105; "Linea Origen"; Integer)
        { }
        field(50106; "Contrato Origen"; Code[20])
        { }
    }
}