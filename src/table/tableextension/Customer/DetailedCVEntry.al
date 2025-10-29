/// <summary>
/// TableExtension Detailed CV Entry BufferKuara (ID 80240) extends Record Detailed CV Ledg. Entry Buffer.
/// </summary>
tableextension 80240 "Detailed CV Entry BufferKuara" extends "Detailed CV Ledg. Entry Buffer"
{
    fields
    {
        field(51021; "Initial Entry Global Dim. 3"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
        }
        field(51022; "Initial Entry Global Dim. 4"; CODE[20])
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
