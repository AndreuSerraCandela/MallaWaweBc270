/// <summary>
/// TableExtension Sales Shipment LineKuara (ID 80168) extends Record Sales Shipment Line.
/// </summary>
tableextension 80168 "Sales Shipment LineKuara" extends "Sales Shipment Line"
{
    fields
    {
        field(80100; DescuentoFicha; Decimal)
        {
            ObsoleteState = Removed;
            DataClassification = ToBeClassified;
        }
        field(50000; "Cdad. Facturada MLL"; Decimal) { Description = 'Control porcentaje facturado en MLL'; }
        field(50001; "Medidas"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Medidas WHERE("No." = FIELD("No.")));
        }

        field(50003; "Reparto"; Enum "Reparto")
        {
        }
        field(50030; "No. Orden Publicidad"; Code[20])
        {


        }
        field(50076; "Cod. Fase"; Code[10]) { Description = 'MNC - Mig 5.0'; }
        field(50077; "Cod. Subfase"; Code[10]) { Description = 'MNC - Mig 5.0'; }
        field(50080; "Linea Marcada a Borrador"; Boolean)
        {

        }
        field(50085; "Cantidad a Borrador"; Integer) { Description = '$004'; }
        field(50090; "Cantidad pasada Borrador"; Integer) { Description = '$004'; }
        field(50091; "Fecha inicial recurso"; Date) { Description = '$007'; }
        field(50092; "Fecha final recurso"; Date) { Description = '$007'; }
        field(50093; "Precio a Borrador"; Decimal) { Description = '$008'; }
        field(50094; "No linea proyecto"; Integer)
        {
            TableRelation = "Job Planning Line"."Line No." WHERE("Job No." = FIELD("Job No."));
            Caption = 'No. línea proyecto';
            Description = '$009';
        }
        field(50095; "Imprimir fecha recurso"; Boolean) { Description = '$010'; }
        field(50096; "No Orden Recurso"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."No. Orden" WHERE("No." = FIELD("No.")));
            Caption = 'No. Orden Recurso';
            Description = '$012';
            Editable = false;
        }
        field(50098; "Remarcar"; Boolean) { Description = '$015'; }

        field(54000; "Imprimir"; Boolean) { InitValue = true; }
        field(70000; "Tipo sit. inmueble SII"; Code[10]) { Description = 'SII'; }
        field(70001; "Ref. catastral inmueble SII"; Text[30]) { Description = 'SII'; }

        // field(95000; "Retention % (GE)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;

        //     Caption = '% retención (BE)';
        // }
        // field(95001; "Retention % (IRPF)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     //CaptionML=[ENU=On Hold % (IRPF);
        //     Caption = '% retención (IRPF)';
        // }
        // field(95002; "Retention Amount (GE)"; Decimal) { DataClassification = ToBeClassified; Caption = 'Importe retención (BE)'; }
        // field(95003; "Retention Amount (IRPF)"; Decimal) { DataClassification = ToBeClassified; Caption = 'Importe retención (IRPF)'; }
        field(50002; "Cód. proveedor"; CODE[20]) { TableRelation = Vendor; }
        field(50005; "Comision ya devengada"; Boolean) { }
        field(50028; "Line Discount Amount"; Decimal) { AutoFormatExpression = GetCurrencyCode; }
        field(80029; "Amount"; Decimal) { AutoFormatExpression = GetCurrencyCode; }
        field(80030; "Amount Including VAT"; Decimal) { AutoFormatExpression = GetCurrencyCode; }
        field(50069; "Inv. Discount Amount"; Decimal) { AutoFormatExpression = GetCurrencyCode; }
        field(50103; "Line Amount"; Decimal) { AutoFormatExpression = GetCurrencyCode; CaptionClass = GetCaptionClass(FIELDNO("Line Amount")); }
        field(50104; "VAT Difference"; Decimal) { AutoFormatExpression = GetCurrencyCode; }
        field(50106; "VAT Identifier"; CODE[10]) { }
        field(50200; "Cod ordenacion"; CODE[20]) { }
        field(50700; "Pmt. Disc. Given Amount"; Decimal) { AutoFormatExpression = GetCurrencyCode; Editable = false; }
#if not CLEAN27
        field(50701; "EC %"; Decimal) { }
        field(50702; "EC Difference"; Decimal) { }
#endif
        field(51040; "Shortcut Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';

        }
        field(51041; "Shortcut Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';

        }
        field(51042; "Shortcut Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';

        }

        field(54001; "Empresa Origen"; TEXT[30]) { }
        field(54002; "Proyecto Origen"; CODE[20]) { }
        field(54004; "Zona Recurso"; CODE[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Zona WHERE("No." = FIELD("No.")));
        }
        field(54005; "Fecha Registro Factura"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Shipment Header"."Posting Date" WHERE("No." = FIELD("Document No.")));
        }
        field(54006; "Recurso Agrupado"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."Recurso Agrupado" WHERE("No." = FIELD("No.")));
        }
        field(54007; "Tipo Recurso"; CODE[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."Tipo Recurso" WHERE("No." = FIELD("No.")));
        }
        field(54008; "Fecha Inicio Proyecto"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Job."Starting Date" WHERE("No." = FIELD("Job No.")));
        }
        field(54009; "Fecha Fin Proyecto"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Job."Ending Date" WHERE("No." = FIELD("Job No.")));
        }
        field(50107; "Precio Tarifa"; Decimal)
        {

        }
        field(50053; "Dto. Tarifa"; Decimal)
        {

        }
        field(50054; "% Dto. Venta 1"; Decimal)
        {

        }
        field(50055; "% Dto. Venta 2"; Decimal)
        {

        }

        field(51035; Duracion; Decimal)
        {
            Caption = 'Duración';
            ;
        }
        field(51036; "Tipo Duracion"; Enum "Duracion")
        {
            Caption = 'Tipo Duración';
        }
        field(50037; "Cdad. Soportes"; Decimal)
        {

        }
        field(54096; "Customer Order No."; Code[20]) { Caption = 'Nº de pedido cliente'; }

    }
}
