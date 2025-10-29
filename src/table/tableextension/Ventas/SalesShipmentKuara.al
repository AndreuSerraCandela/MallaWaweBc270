/// <summary>
/// TableExtension SalesShipMenthKuara (ID 80135) extends Record Sales Shipment Header.
/// </summary>
tableextension 80135 SalesShipMenthKuara extends "Sales Shipment Header"
{
    fields
    {
        // Add changes to table fields here
        field(80100; "Incoming Document Entry No."; integer)
        {
            Caption = 'Documento entrante';
        }
        field(50000; "Tipo"; Enum "Tipo Venta Job") { }
        field(50005; "Firmado"; Enum "Firmado") { }
        field(50006; "Fecha Firma"; Date) { }
        field(50010; "Fecha inicial proyecto"; Date) { }
        field(50011; "Fecha fin proyecto"; Date) { }
        field(50015; "Cód. términos facturacion"; Code[10]) { TableRelation = "Términos facturación"; }
        field(50018; "Subtipo"; Enum "Subtipo") { }
        field(50030; "Nº Contrato"; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order),
                        "No." = FIELD("Nº Contrato"));
        }
        field(50041; "Soporte de"; Enum "Soporte de") { }
        field(50045; "Comentario Cabecera"; Text[50]) { }
        field(50060; "Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Shipment Line".Amount WHERE("Document No." = FIELD("No.")));
            Caption = 'Importe';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(50061; "Amount Including VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Shipment Line"."Amount Including VAT" WHERE("Document No." = FIELD("No.")));
            Caption = 'Importe IVA incl.';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(50062; "Interc./Compens."; Enum "Interc./Compens.") { }//Description=FCL-18/05/04 
        field(50063; "Proyecto origen"; Code[20])
        {
            TableRelation = Job;
            //Description=FCL-18/05/04 
        }
        field(50064; "Renovado"; Boolean)
        {
            //Description=FCL-18/05/04 
        }
        field(50065; "Fecha inicial factura"; Date)
        {
            //Description=FCL-06/04. Se graba en proceso proponer facturación contratos 
        }
        field(50066; "Fecha final factura"; Date)
        {
            //Description=FCL-06/04. Se graba en proceso proponer facturación contratos 
        }
        field(50070; "Ajustada"; Boolean) { }
        field(50075; "Nº Proyecto"; Code[20])
        {
            TableRelation = Job;
            //Description=MNC - Mig 5.0 
        }
        field(50076; "Eliminar"; Text[30]) { }
        field(50095; "Albarán Empresa Origen"; Code[20]) { }
        field(50103; "Cod cadena"; Code[10])
        {
            TableRelation = "Codigos cadena";
            Caption = 'Cód. cadena';
            //Description=$002 
        }
        field(50110; "Pte verificar"; Boolean)
        {
            Caption = 'Pte. verificar';
            //Description=$003 
        }
        field(51040; "Shortcut Dimension 3 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            Caption = 'Cód. dim. acceso dir. 3';
            CaptionClass = '1,2,3';
        }
        field(51041; "Shortcut Dimension 4 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            Caption = 'Cód. dim. acceso dir. 4';
            CaptionClass = '1,2,4';
        }
        field(51042; "Shortcut Dimension 5 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            Caption = 'Cód. dim. acceso dir. 5';
            CaptionClass = '1,2,5';
        }
        field(50096; "Empresa Origen Alb"; Text[30]) { }
        field(51102; "N§ Remesa Fact. Electrónica"; Integer) { }
        field(52000; "Pte Contabilicación"; Boolean) { InitValue = true; }
        field(52003; "Fact. Electrónica Activada"; Boolean) { }
        field(60030; "Situación Efactura"; Enum "Situación Efactura") { }
        field(70000; "Nuestra Cuenta"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(70001; "Nuestra Cuenta Prepago"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(80000; "Tipo factura SII"; Code[2])
        {
            Description = 'SII';
            Editable = false;
        }
        field(80001; "Clave registro SII expedidas"; Code[2])
        {
            Description = 'SII';
            Editable = false;
        }
        field(80006; "Descripción operación"; Text[250])
        {
            Description = 'SII';
            Editable = false;
        }
        field(80008; "Reportado SII"; Boolean)
        {
            Description = 'SII';
            Editable = false;
        }
        field(80009; "Nombre fichero SII"; Text[250])
        {
            Description = 'SII';
            Editable = false;
        }
        field(80010; "Fecha/hora subida fichero SII"; DateTime)
        {
            Description = 'SII';
            Editable = false;
        }
        field(80011; Contabilizado; Boolean)
        { }
        field(80012; "Albarán Venta"; Boolean)
        {
            Description = 'Albarán Venta';
        }


    }

    var
        myInt: Integer;
}