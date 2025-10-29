/// <summary>
/// TableExtension G/L Budget EntryKuara (ID 80165) extends Record G/L Budget Entry.
/// </summary>
tableextension 80165 "G/L Budget EntryKuara" extends "G/L Budget Entry"
{
    fields
    {
        field(50001; "Eliminaciones"; Boolean) { }
        field(50026; "Budget Dimension 5 Code"; CODE[20]) { CaptionClass = GetCaptionClass(5); }
        field(51023; "Global Dimension 3 Code"; CODE[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(51024; "Global Dimension 4 Code"; CODE[20])
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