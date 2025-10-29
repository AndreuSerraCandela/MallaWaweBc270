/// <summary>
/// TableExtension Detailed Vendor EntryKuara (ID 80238) extends Record Detailed Vendor Ledg. Entry.
/// </summary>
tableextension 80238 "Detailed Vendor EntryKuara" extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        field(51023; "Initial Entry Global Dim. 3"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
        }
        field(51024; "Initial Entry Global Dim. 4"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
        }
        field(51025; "Initial Entry Global Dim. 5"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
        }
    }
}
