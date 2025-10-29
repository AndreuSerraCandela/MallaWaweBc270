/// <summary>
/// TableExtension Resource GroupKuara (ID 80179) extends Record Resource Group.
/// </summary>
tableextension 80179 "Resource GroupKuara" extends "Resource Group"
{
    fields
    {
        field(50000; "Cod. Departamento"; CODE[10]) { Enabled = false; TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1)); }
        field(50001; "Grupo contable producto"; CODE[10]) { TableRelation = "Gen. Product Posting Group"; }
        field(50002; "Grupo registro IVA prod."; CODE[10]) { TableRelation = "VAT Product Posting Group"; }
        field(50003; "Cód. Programa"; CODE[10]) { Enabled = false; TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2)); }
        field(50005; "Nº proveedor"; CODE[20]) { TableRelation = Vendor; }
        field(50050; "Global Dimension 3 Code"; CODE[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50051; "Global Dimension 4 Code"; CODE[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(50052; "Global Dimension 5 Code"; CODE[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }

    }
}