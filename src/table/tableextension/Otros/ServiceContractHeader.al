/// <summary>
/// TableExtension Service Contract HeaderKuara (ID 80299) extends Record Service Contract Header.
/// </summary>
tableextension 80299 "Service Contract HeaderKuara" extends "Service Contract Header"
{
    fields
    {
        field(51024; "Shortcut Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(51025; "Shortcut Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(51026; "Shortcut Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
    }
}
