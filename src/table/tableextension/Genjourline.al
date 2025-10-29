/// <summary>
/// TableExtension Gen. Journal LineKuara (ID 80158) extends Record Gen. Journal Line.
/// </summary>
tableextension 80158 "Gen. Journal LineKuara" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Código Asiento"; CODE[10])
        {
            TableRelation = "Configuración Grupo Empresas"."Código Apunte";
        }
        field(50001; "Eliminaciones"; Boolean) { }
        field(50002; "Nº Contrato"; CODE[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."No." WHERE("Nº Proyecto" = FIELD("Job No.")));
        }
        field(50003; "Cod banco"; CODE[20])
        {
            TableRelation = "Bank Account";
        }
        field(50004; "Emplazamiento"; TEXT[30]) { }
        field(50005; "Pago Impuestos"; Boolean) { }
        field(50010; "No. Borrador factura"; CODE[20]) { }
        field(50011; "Periodo de Pago"; TEXT[30])
        {
            TableRelation = "Periodos pago emplazamientos";
        }
        field(50013; "Tipo Cuenta Importe"; Enum "Tipo Cuenta Importe") { }
        field(50288; "Recipient Bank Account Ant"; CODE[10])
        {
            TableRelation = if ("Account Type" = CONST(Customer)) "Customer Bank Account"."Code" WHERE("Customer No." = FIELD("Account No."))
            ELSE
            if ("Account Type" = CONST(Vendor)) "Vendor Bank Account"."Code" WHERE("Vendor No." = FIELD("Account No."))
            ELSE
            if ("Bal. Account Type" = CONST(Customer)) "Customer Bank Account"."Code" WHERE("Customer No." = FIELD("Bal. Account No."))
            ELSE
            if ("Bal. Account Type" = CONST(Vendor)) "Vendor Bank Account"."Code" WHERE("Vendor No." = FIELD("Bal. Account No."));
        }
        field(50289; "Message to Recipient ant"; TEXT[70]) { }
        field(50290; "Exported to Payment File Ant"; Boolean) { }
        field(50291; "Has Payment Export Error Ant"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Payment Jnl. Export Error Text"
                        WHERE("Journal Template Name" = FIELD("Journal Template Name"), "Journal Batch Name" =
                        FIELD("Journal Batch Name"), "Journal Line No." = FIELD("Line No.")));
        }
        field(50709; "Bank Account Name"; TEXT[50]) { }
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
        field(51200; "Direct Debit Mandate IDAnt"; CODE[35])
        {
            TableRelation = if ("Account Type" = CONST(Customer)) "SEPA Direct Debit Mandate" WHERE("Customer No." = FIELD("Account No."));
        }
        field(51201; "Circuito"; Boolean) { }
        field(54705; "Corrected Invoice No. ant"; CODE[20]) { }
        field(55000; "Nº Albar n"; CODE[20]) { Caption = 'Nº Albarán'; }
        field(70000; "Banco"; CODE[20])
        {
            TableRelation = "Bank Account";
        }
        field(70001; "Liquida Facturas en Remesa"; Boolean) { }
        field(70002; "Nº Impreso"; TEXT[30]) { }
        field(70006; "Transferencia"; Boolean) { }
        field(80000; "Tipo factura SII"; CODE[2]) { }
        field(80001; "Clave registro SII expedidas"; CODE[2]) { }
        field(80002; "Clave registro SII recibidas"; CODE[2]) { }
        field(80003; "Tipo desglose emitidas"; CODE[3]) { }
        field(80004; "Sujeta exenta"; CODE[3]) { }
        field(80005; "Tipo de operación"; CODE[2]) { }
        field(80006; "Descripción operación"; TEXT[250]) { }
        field(80007; "Tipo factura rectificativa"; CODE[1]) { }
        field(80008; "Obviar SII"; Boolean) { }
        field(80009; "Tipo desglose recibidas"; CODE[3]) { }

        field(80010; Retention; Boolean)
        { }


    }
}
