/// <summary>
/// TableExtension Vendor Ledger EntryKuara (ID 80148) extends Record Vendor Ledger Entry.
/// </summary>
tableextension 80148 "Vendor Ledger EntryKuara" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50001; "Banco"; CODE[10])
        {
            TableRelation = "Bank Account";
        }
        field(51023; "Global Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(3, "Global Dimension 3 Code");
            end;

        }
        field(51024; "Global Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            end;
        }
        field(51025; "Global Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(5, "Global Dimension 5 Code");
            end;
        }
        field(70000; "Usuario"; CODE[50])
        {
            TableRelation = User;
        }
        field(70001; "Cod. Forma Pago"; CODE[20])
        {
            TableRelation = "Payment Method";
        }
        field(70002; "Nº Impreso"; CODE[20]) { }
        field(70003; "Estado Confirming"; Enum "Estado Confirming") { }
        field(70005; "Mod"; Boolean) { }
        modify("Global Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        modify("Global Dimension 2 Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(90000; Cuenta; Code[20])
        {
            TableRelation = "G/L Account"."No.";
            DataClassification = ToBeClassified;
        }
    }
    /// <summary>
    /// ValidateShortcutDimCode.
    /// </summary>
    /// <param name="FieldNumber">Integer.</param>
    /// <param name="ShortcutDimCode">VAR Code[20].</param>
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin

        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        Modify();
    end;
}
