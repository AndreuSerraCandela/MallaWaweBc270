/// <summary>
/// TableExtension Cust. Ledger EntryKuara (ID 80147) extends Record Cust. Ledger Entry.
/// </summary>
tableextension 80147 "Cust. Ledger EntryKuara" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "Existe Contab"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("G/L Entry" WHERE("Entry No." = FIELD("Entry No.")));
        }
        field(50001; "Banco"; CODE[10])
        {
            TableRelation = "Bank Account";
        }
        field(50005; "Nº Contrato"; CODE[20])
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Error FieldClass';
            Caption = 'Usar Núm Contrato';
        }
        field(50006; "Nº Factura Borrador"; CODE[20])
        { }
        field(50010; "Recibo impreso"; Boolean) { }
        field(50011; "Amount to Apply (LCY)"; Decimal) { }
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
        field(51200; "Direct Debit Mandate ID5"; CODE[35]) { }
        field(70001; "Cod. Forma Pago"; CODE[10])
        {
            TableRelation = "Payment Method".Code WHERE("Cobro/Pagos/Ambos" = FILTER(Cobro | Ambos), Visible = CONST(true));
        }
        field(80005; "Núm Contrato"; CODE[20])
        {
            Caption = 'Nº Contrato';
            TableRelation = "Sales Header";
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Nº Contrato" WHERE("No." = FIELD("Document No.")));
        }
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
