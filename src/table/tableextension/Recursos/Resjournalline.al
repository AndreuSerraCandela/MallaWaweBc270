/// <summary>
/// TableExtension Res. Journal LineKuara (ID 80188) extends Record Res. Journal Line.
/// </summary>
tableextension 80188 "Res. Journal LineKuara" extends "Res. Journal Line"
{
    fields
    {
        field(50000; "Cód. proveedor"; CODE[20]) { TableRelation = Vendor; }
        field(50005; "Cod. Vendedor"; CODE[10]) { TableRelation = "Salesperson/Purchaser"; }
        field(50018; "Shortcut Dimension 3 Code"; CODE[20])
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
        field(50019; "Shortcut Dimension 4 Code"; CODE[20])
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