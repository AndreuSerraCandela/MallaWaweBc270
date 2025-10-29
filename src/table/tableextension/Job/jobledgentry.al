/// <summary>
/// TableExtension Job Ledger EntryKuara (ID 80180) extends Record Job Ledger Entry.
/// </summary>
tableextension 80180 "Job Ledger EntryKuara" extends "Job Ledger Entry"
{
    fields
    {
        field(50000; "Cód. proveedor"; CODE[20]) { TableRelation = Vendor; }
        field(50001; "Cód. cliente"; CODE[20]) { TableRelation = Customer; }
        field(50005; "Cod. Vendedor"; CODE[10]) { TableRelation = "Salesperson/Purchaser"; }
        field(51021; "Global Dimension 3 Code"; CODE[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(51022; "Global Dimension 4 Code"; CODE[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(51025; "Global Dimension 5 Code"; CODE[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
    }
}