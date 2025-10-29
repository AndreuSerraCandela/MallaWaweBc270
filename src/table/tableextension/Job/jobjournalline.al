/// <summary>
/// TableExtension Job Journal LineKuara (ID 80189) extends Record Job Journal Line.
/// </summary>
tableextension 80189 "Job Journal LineKuara" extends "Job Journal Line"
{
    fields
    {
        modify("Job Task No.")
        {
            trigger OnAfterValidate()
            begin
                If ("Job Task No." <> '10') And ("Job Task No." <> '') then Error('La tarea solo puede ser 10');
            end;
        }
        field(50000; "Cód. proveedor"; CODE[20]) { TableRelation = Vendor; }
        field(50001; "Cód. cliente"; CODE[20]) { TableRelation = Customer; }
        field(50005; "Cod. Vendedor"; CODE[10]) { TableRelation = "Salesperson/Purchaser"; }
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