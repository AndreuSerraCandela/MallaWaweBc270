/// <summary>
/// TableExtension VendedoresKuara (ID 80110) extends Record Salesperson/Purchaser.
/// </summary>
tableextension 80110 VendedoresKuara extends "Salesperson/Purchaser"
{
    fields
    {
        field(80100; Afiliacion; Text[50])
        {
            Caption = 'Afiliacion';
            DataClassification = ToBeClassified;
        }
        field(50000; "Cuenta Cobro Comision (D)"; Text[20])
        {
            TableRelation = "G/L Account"."No.";
            DataClassification = ToBeClassified;
        }
        field(50001; "Cuenta Devengo Comision (H)"; Text[30])
        {
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(50002; "Nº Común"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Global Dimension 3 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(3, "Global Dimension 3 Code");
            END;
        }
        field(50051; "Global Dimension 4 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            END;
        }
        field(50052; "Global Dimension 5 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(5, "Global Dimension 5 Code");
            END;

        }
        field(50053; "Codificacion Comercial"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Ultimo aviso Clientes"; Date)
        {

        }

    }
}