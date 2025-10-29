/// <summary>
/// TableExtension Sales Cr.Memo LineKuara (ID 80172) extends Record Sales Cr.Memo Line.
/// </summary>
tableextension 80172 "Sales Cr.Memo LineKuara" extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50002; "Cód. proveedor"; CODE[20]) { TableRelation = Vendor; }
        field(50005; "Comision ya devengada"; Boolean) { }
        field(50091; "Fecha inicial recurso"; Date) { }
        field(50092; "Fecha final recurso"; Date) { }
        field(50094; "No linea proyecto"; Integer) { }
        field(50095; "Imprimir fecha recurso"; Boolean) { }
        field(50098; "Remarcar"; Boolean) { }
        field(50200; "Cod ordenacion"; CODE[20]) { }
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
        field(54000; "Imprimir"; Boolean) { }
        field(54001; "Empresa Origen"; TEXT[30]) { }
        field(54002; "Proyecto Origen"; CODE[20]) { }
        field(54003; "Recurso"; CODE[20]) { }
        field(54004; "Zona Recurso"; CODE[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Zona WHERE("No." = FIELD("No.")));
        }
        field(54005; "Fecha Registro Factura"; TEXT[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Address WHERE("No." = FIELD("Document No.")));
        }
        field(70000; "Tipo sit. inmueble SII"; CODE[10]) { }
        field(70001; "Ref. catastral inmueble SII"; TEXT[30]) { }
        // field(95000; "Retention % (GE)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     DataClassification = ToBeClassified;

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
        field(50107; "Precio Tarifa"; Decimal)
        {

        }
        field(50053; "Dto. Tarifa"; Decimal)
        {

        }
        field(50054; "% Dto. Venta 1"; Decimal)
        {

        }
        field(50055; "% Dto. Venta 2"; Decimal)
        {

        }

        field(51035; Duracion; Decimal)
        {
            Caption = 'Duración';

        }
        field(51036; "Tipo Duracion"; Enum "Duracion")
        {
            Caption = 'Tipo Duración';


        }
        field(50037; "Cdad. Soportes"; Decimal)
        {

        }
    }
}
