/// <summary>
/// TableExtension Bank Account Ledger EntryKuara (ID 80198) extends Record Bank Account Ledger Entry.
/// </summary>
tableextension 80198 "Bank Account Ledger EntryKuara" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50002; "Tipo conciliación"; Enum "Tipo conciliación") { }
        field(50003; "Liq. por Id."; CODE[10]) { }
        field(50004; "Nº conciliación"; Integer) { }
        field(51023; "Global Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
        }
        field(51024; "Global Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
        }
        field(51025; "Global Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
        }
        field(51026; "Nº Cuenta"; TEXT[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."G/L Account No." WHERE("Entry No." = FIELD("Entry No.")));
        }
    }
}
