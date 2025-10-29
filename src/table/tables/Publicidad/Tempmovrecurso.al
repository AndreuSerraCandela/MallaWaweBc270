/// <summary>
/// Table Temp. Mov. recurso (ID 7001177).
/// </summary>
table 7001177 "Temp. Mov. recurso"
{
    Caption = 'Temp. Mov. recurso';

    fields
    {
        field(1; "Entry No."; Integer) { Caption = 'Nº mov.'; }
        field(2; "Entry Type"; Enum "Res. Journal Line Entry Type")
        {
            Caption = 'Tipo movimiento';

        }
        field(3; "Document No."; Code[20]) { Caption = 'Nº documento'; }
        field(4; "Posting Date"; Date) { Caption = 'Fecha registro'; }
        field(5; "Resource No."; Code[20])
        {
            TableRelation = Resource;
            Caption = 'Nº recurso';
        }
        field(6; "Resource Group No."; Code[20])
        {
            TableRelation = "Resource Group";
            Caption = 'Nº fam. recurso';
        }
        field(7; "Description"; Text[50]) { Caption = 'Descripción'; }
        field(8; "Work Type Code"; Code[10])
        {
            TableRelation = "Work Type";
            Caption = 'Cód. tipo trabajo';
        }
        field(9; "Job No."; Code[20])
        {
            TableRelation = Job;
            Caption = 'Nº proyecto';
        }
        field(10; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
            Caption = 'Cód. unidad medida';
        }
        field(11; "Quantity"; Decimal)
        {
            Caption = 'Cantidad';
            DecimalPlaces = 0 : 5;
        }
        field(12; "Direct Unit Cost"; Decimal)
        {
            Caption = 'Coste unit. directo';
            AutoFormatType = 2;
        }
        field(13; "Unit Cost"; Decimal)
        {
            Caption = 'Coste unitario';
            AutoFormatType = 2;
        }
        field(14; "Total Cost"; Decimal)
        {
            Caption = 'Coste total';
            AutoFormatType = 1;
        }
        field(15; "Unit Price"; Decimal)
        {
            Caption = 'Precio venta';
            AutoFormatType = 2;
        }
        field(16; "Total Price"; Decimal)
        {
            Caption = 'Importe venta';
            AutoFormatType = 1;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Caption = 'Cód. dimensión global 1';
            CaptionClass = '1,1,1';
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Caption = 'Cód. dimensión global 2';
            CaptionClass = '1,1,2';
        }
        field(20; "User ID"; Code[50])
        {
            ValidateTableRelation = false;
            Caption = 'Id. usuario';
            TableRelation = User;
            trigger OnLookup()
            VAR
                LoginMgt: Codeunit 418;
            BEGIN
                // LoginMgt.LookupUserID("User ID");
            END;

        }
        field(21; "Source Code"; Code[10])
        {
            TableRelation = "Source Code";
            Caption = 'Cód. origen';
        }
        field(22; "Chargeable"; Boolean)
        {
            ; InitValue = true;
            Caption = 'Facturable';
        }
        field(23; "Journal Batch Name"; Code[10]) { Caption = 'falsembre sección diario'; }
        field(24; "Reason Code"; Code[10])
        {
            TableRelation = "Reason Code";
            Caption = 'Cód. auditoría';
        }
        field(25; "Gen. Bus. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Business Posting Group";
            Caption = 'Grupo contable negocio';
        }
        field(26; "Gen. Prod. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
            Caption = 'Grupo contable producto';
        }
        field(27; "Document Date"; Date) { Caption = 'Fecha emisión documento'; }
        field(28; "External Document No."; Code[20]) { Caption = 'Nº documento externo'; }
        field(29; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'falses. serie';
        }
        field(30; "Source Type"; Enum "Res. Journal Line Source Type")
        {
            Caption = 'Tipo procedencia mov.';

        }
        field(31; "Source No."; Code[20])
        {
            TableRelation = if ("Source Type" = CONST(Customer)) Customer."No.";
            Caption = 'Cód. procedencia mov.';
        }
        field(32; "Qty. per Unit of Measure"; Decimal) { Caption = 'Cdad. por unidad medida'; }
        field(33; "Quantity (Base)"; Decimal) { Caption = 'Cantidad (base)'; }
        field(50000; "Cód. proveedor"; Code[20])
        {
            TableRelation = Vendor;
            Description = 'FCL-23/11/04';
        }
    }
    KEYS
    {
        key(P; "Entry No.") { Clustered = true; }
        key(A; "Resource No.", "Posting Date") { }
        key(B; "Entry Type", Chargeable, "Unit of Measure Code", "Resource No.", "Posting Date")
        {
            SumIndexfields = Quantity, "Total Cost", "Total Price", "Quantity (Base)";
        }
        key(C; "Entry Type", Chargeable, "Unit of Measure Code", "Resource Group No.", "Posting Date")
        {
            SumIndexfields = Quantity, "Total Cost", "Total Price", "Quantity (Base)";
        }
        key(D; "Document No.", "Posting Date") { }
        key(E; "Entry Type", "Source Type", "Source No.", "Cód. proveedor", "Resource No.", "Posting Date", "Document No.") { }
    }
}

