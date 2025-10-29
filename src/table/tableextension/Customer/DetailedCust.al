/// <summary>
/// TableExtension Detailed Cust. EntryKuara (ID 80237) extends Record Detailed Cust. Ledg. Entry.
/// </summary>
tableextension 80237 "Detailed Cust. EntryKuara" extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        field(50000; "Asociado a efecto no."; Integer) { }
        field(50005; "Exste Mov"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Cust. Ledger Entry" WHERE("Entry No." = FIELD("Cust. Ledger Entry No.")));
        }
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
