/// <summary>
/// TableExtension Purchase LineKuara (ID 80151) extends Record Purchase Line.
/// </summary>
tableextension 80151 "Purchase LineKuara" extends "Purchase Line"
{
    fields
    {
        field(50011; "Periodo de Pago"; TEXT[30])
        {
            TableRelation = "Periodos pago emplazamientos"."Cód. Periodo Pago";
        }
        field(50030; "No. Orden Publicidad"; CODE[20]) { }
        field(50076; "Cod. Fase"; CODE[10]) { }
        field(50077; "Cod. Subfase"; CODE[10]) { }
        field(50091; "Fecha inicial recurso"; Date) { }
        field(50092; "Fecha final recurso"; Date) { }
        field(51040; "Shortcut Dimension 3 Code"; CODE[20])
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
        field(51041; "Shortcut Dimension 4 Code"; CODE[20])
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
        field(51042; "Shortcut Dimension 5 Code"; CODE[20])
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
        field(54001; "Empresa Origen"; TEXT[30]) { }
        field(54002; "Proyecto Origen"; CODE[20]) { }
        field(54003; "Recurso"; CODE[20]) { }
        field(54005; "No linea proyecto"; Integer) { }
        field(54078; "Cantidad a dividir"; Decimal) { }
        field(54079; "Linea de proyecto"; Integer) { }
        field(54080; "Cantidad a Imprimir"; Decimal) { }
        field(54081; "No imprimir"; Boolean) { }
        field(70000; "Tipo sit. inmueble SII"; CODE[10]) { }
        field(70001; "Ref. catastral inmueble SII"; TEXT[30])
        {
            // TableRelation = "Ref Catastral Address"."Ref. catastral" WHERE("Vendor No." = FIELD("Buy-from Vendor No."));
            trigger OnLookup()
            var
                rRefCat: Record "Ref Catastral Address";

            begin
                rRefCat.SETRANGE("Vendor No.", "Buy-from Vendor No.");
                If Page.Runmodal(0, rRefCat) = ACTION::LookupOK THEN
                    "Ref. catastral inmueble SII" := rRefCat."Ref. catastral";
            end;


        }
        field(92000; "Código Del Prestamo"; Text[100]) { }
        // field(95000; "Retention % (GE)"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     ObsoleteState = Removed;

        //     Caption = '% retención (BE)';
        // }
        // field(95001; "Retention % (IRPF)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     DataClassification = ToBeClassified;

        //     Caption = '% retención (IRPF)';
        // }
        // field(95002; "Retention Amount (GE)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     DataClassification = ToBeClassified;

        //     Caption = 'Importe retención (BE)';
        // }
        // field(95003; "Retention Amount (IRPF)"; Decimal)
        // {
        //     ObsoleteState = Removed;
        //     DataClassification = ToBeClassified;

        //     Caption = 'Importe retención (IRPF)';
        // }
        field(50105; "Linea Origen"; Integer)
        { }
        field(50106; "Contrato Origen"; Code[20])
        { }
        field(50107; "Empresa Venta"; Text[30])
        { }


    }
    /// <summary>
    /// FiltroTexto.
    /// </summary>
    procedure FiltroTexto()
    var
        rTexto: Record "Texto Presupuesto";
    begin

        //FCL-24/02/04. Migración 2.0. a 3.70.

        rTexto.SETRANGE("Nº proyecto", "Job No.");
        // $001 -
        // {
        // rTexto.SETRANGE("Cód. fase",     "Phase Code");
        // rTexto.SETRANGE("Cód. subfase",  "Task Code");
        // rTexto.SETRANGE("Cód. tarea",    "Step Code");
        // }
        rTexto.SETRANGE("Cód. tarea", "Job Task No.");
        rTexto.SETRANGE("Nº linea aux", "Line No.");
        // $001 +
        rTexto.SETRANGE("Cód. variante", "Variant Code");
        rTexto.SETFILTER(rTexto."Tipo linea", '%1|%2',
                        rTexto."Tipo linea"::Compra, rTexto."Tipo linea"::Ambos); //FCL-24/05/04
        Page.RUNMODAL(page::"Texto Presupuesto", rTexto);
    end;
}