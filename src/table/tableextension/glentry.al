/// <summary>
/// TableExtension G/L EntryKuara (ID 80146) extends Record G/L Entry.
/// </summary>
tableextension 80146 "G/L EntryKuara" extends "G/L Entry"
{
    fields
    {
        field(50000; "Marca"; CODE[1]) { }
        field(50001; "Eliminaciones"; Boolean) { }
        field(50002; "Núm. Contrato"; CODE[20])
        {
            Caption = 'Nº Contrato';
            TableRelation = "Sales Header"."No.";
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."No." WHERE("Nº Proyecto" = FIELD("Job No.")));

        }
        field(50003; "Periodo de Pago"; TEXT[30]) { }
        field(50005; "Pago Impuestos"; Boolean) { }
        field(50024; "Sales/Person Code"; CODE[20])
        {
            TableRelation = "Salesperson/Purchaser".Code;
            FieldClass = FlowField;
            CalcFormula = Lookup("Cust. Ledger Entry"."Salesperson Code" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No.")));
        }
        field(50025; "Grupo Cliente"; CODE[20])
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Error FieldClass';
            Caption = 'Usar Customer Group';
        }
        field(50026; "SalesPerson Code"; CODE[10])
        {
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50201; "Importe a Conciliar"; Decimal) { Caption = 'Importe a conciliar'; }
        field(50202; "Pendiente"; Boolean) { }
        field(50203; "Importe pendiente"; Decimal) { }
        field(50204; "Usuario conciliacion"; CODE[50])
        {
            TableRelation = User;
        }
        field(50205; "Importe conciliado"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. Conciliacion cuenta"."Importe conciliado" WHERE("Nº Mov." = FIELD("Entry No."), "Fecha conciliacion" = FIELD("Filtro fecha conciliación")));
        }
        field(50206; "Filtro fecha conciliacion"; Date)
        {
            //Enabled = false;
            Caption = 'No usar';
            ObsoleteState = Removed;
            ObsoleteReason = 'Error Field Class';
        }
        field(50207; "Circuitos"; Boolean) { }
        field(51001; "Banco"; CODE[10])
        {
            TableRelation = "Bank Account";
        }
        field(51023; "Global Dimension 3 Code"; CODE[20])
        {
            Caption = 'Principal';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            //CaptionClass = '1,2,3';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(3, "Global Dimension 3 Code");
            end;

        }
        field(51024; "Global Dimension 4 Code"; CODE[20])
        {
            Caption = 'Zona';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            //CaptionClass = '1,2,4';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            end;
        }
        field(51025; "Global Dimension 5 Code"; CODE[20])
        {
            Caption = 'Soporte';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            //CaptionClass = '1,2,5';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(5, "Global Dimension 5 Code");
            end;
        }
        // field(50226; "Importe a conciliar"; Decimal) { ObsoleteState = Removed; }
        field(56000; "Importe Activo"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("FA Ledger Entry".Amount WHERE("G/L Entry No." = field("Entry No.")));
        }
        field(69069; "Debe div.-adic2"; Decimal) { }
        field(69070; "Haber div.-adic2"; Decimal) { }
        field(80000; "Tipo factura SII"; CODE[2]) { }
        field(80001; "Clave registro SII expedidas"; CODE[2]) { }
        field(80002; "Clave registro SII recibidas"; CODE[2]) { }
        field(80003; "Tipo desglose emitidas"; CODE[3]) { }
        field(80004; "Sujeta exenta"; CODE[3]) { }
        field(80005; "Tipo de operación"; CODE[2]) { }
        field(80006; "Descripción operación"; TEXT[250]) { }
        field(80007; "Tipo factura rectificativa"; CODE[1]) { }
        field(80009; "Tipo desglose recibidas"; CODE[3]) { }
        field(80010; "Filtro fecha conciliación"; Date)
        {
            FieldClass = FlowFilter;

        }
        field(80012; "Nº Contrato"; CODE[20])
        {
            Caption = 'Núm Contrato';
            TableRelation = "Sales Header"."No.";

            // LookupPageId = "Sales List";
            // DrillDownPageId = "Sales List";

        }


        field(80011; "Customer Group"; CODE[20])
        {
            Caption = 'Grupo Cliente';
            FieldClass = FlowField;
            CalcFormula = Lookup("Cust. Ledger Entry"."Customer Posting Group" WHERE("Document No." = FIELD("Document No.")));
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