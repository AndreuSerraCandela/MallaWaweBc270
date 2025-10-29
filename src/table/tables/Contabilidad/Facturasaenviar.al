/// <summary>
/// Table Facturas a Enviar (ID 7001130).
/// </summary>
table 7001130 "Facturas a Enviar"
{
    DataPerCompany = true;
    Caption = 'Facturas a Enviar';
    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Venta a-Nº cliente';
            NotBlank = true;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'Nº';
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Factura-a Nº cliente';
            NotBlank = true;
        }
        field(5; "Bill-to Name"; Text[50])
        {
            Caption = 'Fact. a-Nombre';
        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Fact. a-Nombre 2';
        }
        field(7; "Bill-to Address"; Text[50])
        {
            Caption = 'Fact. a-Dirección';
        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Fact. a-Dirección 2';
        }
        field(9; "Bill-to City"; Text[30])
        {
            Caption = 'Fact. a-Población';
        }
        field(10; "Bill-to Contact"; Text[50])
        {
            Caption = 'Fact. a-Atención';
        }
        field(11; "Your Reference"; Text[30])
        {
            Caption = 'Su/Ntra. ref.';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
            Caption = 'Cód. dirección envío cliente';
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Caption = 'Envío a-Nombre';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Envío a-Nombre 2';
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Envío a-Dirección';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Envío a-Dirección 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Envío a-Población';
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Caption = 'Envío a-Atención';
        }
        field(19; "Order Date"; Date)
        {
            Caption = 'Fecha pedido';
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Fecha registro';
        }
        field(21; "Shipment Date"; Date)
        {
            Caption = 'Fecha envío';
        }
        field(22; "Posting Description"; Text[50])
        {
            Caption = 'Texto de registro';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            TableRelation = "Payment Terms";
            Caption = 'Cód. términos pago';
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Fecha vencimiento';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = '% Dto. P.P.';
            DecimalPlaces = 0 : 6;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Fecha dto. P.P.';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            TableRelation = "Shipment Method";
            Caption = 'Cód. condiciones envío';
        }
        field(28; "Location Code"; Code[10])
        {
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            Caption = 'Cód. almacén';
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Caption = 'Cód. dim. acceso dir. 1';
            CaptionClass = '1,2,1';
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Caption = 'Cód. dim. acceso dir. 2';
            CaptionClass = '1,2,2';
        }
        field(31; "Customer Posting Group"; Code[10])
        {
            TableRelation = "Customer Posting Group";
            Caption = 'Grupo contable cliente';
            Editable = false;
        }
        field(32; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Caption = 'Cód. divisa';
            Editable = false;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Factor divisa';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(34; "Customer Price Group"; Code[10])
        {
            TableRelation = "Customer Price Group";
            Caption = 'Grupo precio cliente';
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Precios IVA incluido';
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Cód. dto. factura';
        }
        field(40; "Customer Disc. Group"; Code[10])
        {
            TableRelation = "Customer Discount Group";
            Caption = 'Grupo dto. cliente';
        }
        field(41; "Language Code"; Code[10])
        {
            TableRelation = Language;
            Caption = 'Cód. idioma';
        }
        field(43; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Cód. vendedor';
        }
        field(44; "Order No."; Code[20])
        {
            Caption = 'Nº pedido';
        }
        field(46; "Comment"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Comment Line" WHERE("Document Type" = CONST("Posted Invoice"),
                                                                                                 "No." = FIELD("No."),
                                                                                                 "Document Line No." = CONST(0)));
            Caption = 'Comentario';
            Editable = false;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'Nº copias impresas';
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'Esperar';
        }
        field(52; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Liq. por tipo documento';

        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Liq. por nº documento';
        }
        field(55; "Bal. Account No."; Code[20])
        {
            TableRelation = if ("Bal. Account Type" = CONST(Cuenta)) "G/L Account"
            ELSE
            if ("Bal. Account Type" = CONST(Banco)) "Bank Account";
            Caption = 'Cta. contrapartida';
        }
        field(60; "Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line".Amount WHERE("Document No." = FIELD("No.")));
            Caption = 'Importe';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line"."Amount Including VAT" WHERE("Document No." = FIELD("No.")));
            Caption = 'Importe IVA incl.';
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'CIF/NIF';
        }
        field(73; "Reason Code"; Code[10])
        {
            TableRelation = "Reason Code";
            Caption = 'Cód. auditoría';
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Business Posting Group";
            Caption = 'Grupo contable negocio';
        }
        field(75; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'Op. triangular';
        }
        field(76; "Transaction Type"; Code[10])
        {
            TableRelation = "Transaction Type";
            Caption = 'Naturaleza transacción';
        }
        field(77; "Transport Method"; Code[10])
        {
            TableRelation = "Transport Method";
            Caption = 'Modo transporte';
        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Caption = 'Cód. IVA país/región';
        }
        field(79; "Sell-to Customer Name"; Text[50])
        {
            Caption = 'Venta a-Nombre';
        }
        field(80; "Sell-to Customer Name 2"; Text[50])
        {
            Caption = 'Venta a-Nombre 2';
        }
        field(81; "Sell-to Address"; Text[50])
        {
            Caption = 'Venta a-Dirección';
        }
        field(82; "Sell-to Address 2"; Text[50])
        {
            Caption = 'Venta a-Dirección 2';
        }
        field(83; "Sell-to City"; Text[30])
        {
            Caption = 'Venta a-Población';
        }
        field(84; "Sell-to Contact"; Text[50])
        {
            Caption = 'Venta a-Atención';
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            Caption = 'Fact. a-C.P.';
        }
        field(86; "Bill-to County"; Text[30])
        {
            Caption = 'Fact. a-Provincia';
        }
        field(87; "Bill-to Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Caption = 'Fact. a-Cód. país/región';
        }
        field(88; "Sell-to Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            Caption = 'Venta a-C.P.';
        }
        field(89; "Sell-to County"; Text[30])
        {
            Caption = 'Venta a-Provincia';
        }
        field(90; "Sell-to Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Caption = 'Venta a-Cód. país/región';
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            Caption = 'Envío a-C.P.';
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Envío a-Provincia';
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Caption = 'Envío a-Cód. país/región';
        }
        field(94; "Bal. Account Type"; Enum "Bal. Account Type")
        {
            Caption = 'Tipo contrapartida';

        }
        field(97; "Exit Point"; Code[10])
        {
            TableRelation = "Entry/Exit Point";
            Caption = 'Puerto/Aerop. carga';
        }
        field(98; "Correction"; Boolean)
        {
            Caption = 'Corrección';
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Fecha emisión documento';
        }
        field(100; "External Document No."; Code[20])
        {
            Caption = 'Nº documento externo';
        }
        field(101; "Area"; Code[10])
        {
            TableRelation = Area;
            Caption = 'Cód. provincia';
        }
        field(102; "Transaction Specification"; Code[10])
        {
            TableRelation = "Transaction Specification";
            Caption = 'Especificación transacción';
        }
        field(104; "Payment Method Code"; Code[10])
        {
            TableRelation = "Payment Method";
            Caption = 'Cód. forma pago';
        }
        field(105; "Shipping Agent Code"; Code[10])
        {
            TableRelation = "Shipping Agent";
            Caption = 'Cód. transportista';
        }
        field(106; "Package Tracking No."; Text[30])
        {
            Caption = 'Nº seguimiento bulto';
        }
        field(107; "Pre-Assigned No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Nº serie preasignado';
        }
        field(108; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Nos. serie';
            Editable = false;
        }
        field(110; "Order No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Nº serie pedido';
        }
        field(111; "Pre-Assigned No."; Code[20])
        {
            Caption = 'Nº preasignado';
        }
        field(112; "User ID"; Code[50])
        {
            TableRelation = User;
            ValidateTableRelation = false;
            Caption = 'Id. usuario';
        }
        field(113; "Source Code"; Code[20])
        {
            TableRelation = "Source Code";
            Caption = 'Cód. origen';
        }
        field(114; "Tax Area Code"; Code[20])
        {
            TableRelation = "Tax Area";
            Caption = 'Cód. Área impuesto';
        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Sujeto a impuesto';
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            TableRelation = "VAT Business Posting Group";
            Caption = 'Grupo registro IVA neg.';
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = '% Dto. base IVA';
            DecimalPlaces = 0 : 6;
            MinValue = 0;
            MaxValue = 100;
        }
        field(131; "Prepayment No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Nº serie prepago';
        }
        field(136; "Prepayment Invoice"; Boolean)
        {
            Caption = 'Factura prepago';
        }
        field(137; "Prepayment Order No."; Code[20])
        {
            Caption = 'Nº pedido prepago';
        }
        field(151; "Quote No."; Code[20])
        {
            Caption = 'Nº oferta';
            Editable = false;
        }
        field(5050; "Campaign No."; Code[20])
        {
            TableRelation = Campaign;
            Caption = 'Nº campaña';
        }
        field(5052; "Sell-to Contact No."; Code[20])
        {
            TableRelation = Contact;
            Caption = 'Venta a-Nº contacto';
        }
        field(5053; "Bill-to Contact No."; Code[20])
        {
            TableRelation = Contact;
            Caption = 'Fact. a-Nº contacto';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
            Caption = 'Centro responsabilidad';
        }
        field(5900; "Service Mgt. Document"; Boolean)
        {
            Caption = 'Doc. gestión servicios';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Permite dto. línea';
        }
        field(7200; "Get Shipment Used"; Boolean)
        {
            Caption = 'Obtener método de envío usado';
        }
        field(50000; "Tipo"; Enum "Tipo Venta Job") { }
        field(50001; "Tipo Documento"; Enum "Tipo Documento Envios") { }
        field(50005; "Firmado"; Enum "Firmado") { }
        field(50006; "Fecha Firma"; Date) { }
        field(50010; "Fecha inicial proyecto"; Date) { }
        field(50011; "Fecha fin proyecto"; Date) { }
        field(50015; "Cód. términos facturacion"; Code[10]) { TableRelation = "Términos facturación"; }
        field(50018; "Subtipo"; enum "Subtipo") { }
        field(50030; "Nº Contrato"; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order), "No." = FIELD("Nº Contrato"));
        }
        field(50041; "Soporte de"; Enum "Soporte de") { }
        field(50045; "Comentario Cabecera"; Text[50]) { }
        field(50062; "Interc./Compens."; Enum "Interc./Compens.")
        {
            Description = 'FCL-18/05/04';
        }
        field(50063; "Proyecto origen"; Code[20])
        {
            TableRelation = Job;
            Description = 'FCL-18/05/04';
        }
        field(50064; "Renovado"; Boolean) {; Description = 'FCL-18/05/04'; }
        field(50065; "Fecha inicial factura"; Date) {; Description = 'FCL-06/04. Se graba en proceso proponer facturación contratos'; }
        field(50066; "Fecha final factura"; Date) {; Description = 'FCL-06/04. Se graba en proceso proponer facturación contratos'; }
        field(50070; "Ajustada"; Boolean) { }
        field(50075; "Nº Proyecto"; Code[20])
        {
            TableRelation = Job;
            Description = 'MNC - Mig 5.0';
        }
        field(50076; "Eliminar"; Text[30]) { }
        field(50095; "Albarán Empresa Origen"; Code[20]) { }
        field(50103; "Cod cadena"; Code[10])
        {
            TableRelation = "Codigos cadena";
            Caption = 'Cód. cadena';
            Description = '$002';
        }
        field(50110; "Pte verificar"; Boolean)
        {
            Caption = 'Pte. verificar';
            Description = '$003';
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
        field(51102; "Nº Remesa Fact. Electrónica"; Integer) {; }
        field(52000; "Pte Contabilicación"; Boolean) { InitValue = true; }
        field(52003; "Fact. Electrónica Activada"; Boolean) { }
        field(60000; "Enviada E-Mail"; Boolean) { }
        field(60017; "Document Sending Profile"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer."Document Sending Profile" WHERE("No." = FIELD("Sell-to Customer No.")));
            TableRelation = "Document Sending Profile";
            Caption = 'Perfil de envío de documentos';
        }
        field(60030; "Situación Efactura"; Enum "Situación Efactura") { }
        field(70000; "Nuestra Cuenta"; Code[20]) { TableRelation = "Bank Account"; }
        field(70001; "Nuestra Cuenta Prepago"; Code[20]) { TableRelation = "Bank Account"; }
        field(70002; "Factura Blob"; BLOB) { }
        field(7000000; "Applies-to Bill No."; Code[20])
        {
            Caption = 'Liq. por nº efecto';
        }
        field(7000001; "Cust. Bank Acc. Code"; Code[20])
        {
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Bill-to Customer No."));
            Caption = 'Cód. banco cliente';
        }
        field(7000003; "Pay-at Code"; Code[20])
        {
            //TableRelation = "Customer Pmt. Address".Code WHERE("Customer No." = FIELD("Bill-to Customer No."));
            Caption = 'Pago en-Código';
        }
        field(99008509; "Date Sent"; Date)
        {
            Caption = 'Fecha enviado';
        }
        field(99008510; "Time Sent"; Time)
        {
            Caption = 'Hora envío';
        }
        field(99008516; "BizTalk Sales Invoice"; Boolean)
        {
            Caption = 'Factura venta BizTalk';
        }
        field(99008519; "Customer Order No."; Code[20])
        {
            Caption = 'Nº pedido cliente';
        }
        field(99008521; "BizTalk Document Sent"; Boolean)
        {
            Caption = 'Documento enviado BizTalk';
        }
    }
    KEYS
    {
        key(P; "No.")
        {
            Clustered = true;
        }
    }

}
