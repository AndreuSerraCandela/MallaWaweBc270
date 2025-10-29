/// <summary>
/// TableExtension Res. Ledger EntryKuara (ID 80186) extends Record Res. Ledger Entry.
/// </summary>
tableextension 80186 "Res. Ledger EntryKuara" extends "Res. Ledger Entry"
{
    fields
    {
        field(50000; "Cód. proveedor"; CODE[20]) { TableRelation = Vendor; }
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