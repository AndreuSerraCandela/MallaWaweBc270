/// <summary>
/// Table Cabecera Prestamo (ID 7001164).
/// </summary>
table 7001164 "Cabecera Prestamo"
{
    LookupPageId = "Lista Prestamos";

    fields
    {
        field(1; "Código Del Prestamo"; Text[100]) { }
        field(2; "Cuenta L/P"; Text[30]) { TableRelation = "G/L Account"; }
        field(3; "Cuenta c/P"; Text[30]) { TableRelation = "G/L Account"; }
        field(4; "Cuenta intrereses"; Text[30]) { TableRelation = "G/L Account"; }
        field(5; "Cuenta Gastos"; Text[30]) { TableRelation = "G/L Account"; }
        field(6; "Interes Anual"; Decimal) { DecimalPlaces = 2 : 5; }
        field(7; "Años"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                Meses := ROUND("Años" * "Cuotas Anuales", 1, '=');
            END;
        }
        field(8; "Cuotas Anuales"; Integer)
        {
            trigger OnValidate()
            BEGIN
                Meses := ROUND("Años" * "Cuotas Anuales", 1, '=');
            END;
        }
        field(9; "Importe Prestamo"; Decimal) { }
        field(10; "Fecha Préstamo"; Date) { }
        field(11; "Fecha 1ª Amortización"; Date) { }
        field(12; "Banco"; Code[20]) { TableRelation = "Bank Account"; }
        field(13; "Meses"; Integer) { }
        field(16; "Global Dimension 1 Code"; Code[20])
        {

            Caption = 'Cód. dimensión global 1';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            END;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {

            Caption = 'Cód. dimensión global 2';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            END;
        }
        field(18; "Amortización"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detalle Prestamo".Amortización WHERE("Código Del Prestamo" = FIELD("Código Del Prestamo"),
                    Fecha = FIELD("Filtro Fecha")));
        }
        field(19; "Intereses"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detalle Prestamo".Intereses WHERE("Código Del Prestamo" = FIELD("Código Del Prestamo"),
        Fecha = FIELD("Filtro Fecha")));
        }
        field(20; "Cuota"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detalle Prestamo"."A Pagar" WHERE("Código Del Prestamo" = FIELD("Código Del Prestamo"),
        Fecha = FIELD("Filtro Fecha")));
        }
        field(21; "Liquidado"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detalle Prestamo".Amortización WHERE("Código Del Prestamo" = FIELD("Código Del Prestamo"),
        Fecha = FIELD(UPPERLIMIT("Filtro Fecha Liquidación")),
        Liquidado = CONST(true)));
        }
        field(51016; "Global Dimension 3 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            Caption = 'Cód. dimensión global 3';
            CaptionClass = '1,2,3';
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(3, "Global Dimension 3 Code");
            END;
        }
        field(51017; "Global Dimension 4 Code"; Code[20])
        {

            Caption = 'Cód. dimensión global 4';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            END;
        }
        field(51018; "Leasing"; Boolean) { Caption = 'Leasing'; }
        field(51019; "Proveedor Leasing"; Code[20]) { Caption = 'Proveedor Lweasing/Renting'; TableRelation = Vendor; }
        field(51020; "Iva"; Decimal) { }
        field(51021; "Valor Residual"; Decimal) { }
        field(51022; "Filtro Fecha"; Date) { FieldClass = FlowFilter; }
        field(51023; "Filtro Fecha Liquidación"; Date) { FieldClass = FlowFilter; }
        field(51024; "Empresa"; Text[30]) { }
        field(51025; "Cabecera Prestamo2"; Text[100]) { }
        field(51026; "Global Dimension 5 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            Caption = 'Cód. dimensión global 5';
            CaptionClass = '1,2,5';
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            END;
        }
        field(51027; "Importe Pendiente"; Decimal)
        { }
        field(51028; Ocultar; Boolean)
        { }
        field(51029; "Renting"; Boolean) { }
        field(50030; Seguro; Decimal) { }
        field(50031; Mantenimiento; Decimal) { }
        field(50032; "En vigor"; Boolean) { }
        field(50033; "Cabecera Prestamo3"; Text[100]) { }
    }

    KEYS
    {
        key(P; "Código Del Prestamo") { Clustered = true; }
        key(A; Empresa) { }
    }
    VAR
        DimMgt: Codeunit 408;

    trigger OnInsert()
    BEGIN
        // Revisar
        // DimMgt.UpdateDefaultDim(
        // DATABASE::"Cabecera Prestamo", "Código Del Prestamo",
        //     "Global Dimension 1 Code", "Global Dimension 2 Code");//,
        //                                                           //"Global Dimension 3 Code", "Global Dimension 4 Code", "Global Dimension 5 Code");
    END;

    trigger OnDelete()
    BEGIN
        // DimMgt.DeleteDefaultDim(DATABASE::"Cabecera Prestamo", "Código Del Prestamo");
    END;

    PROCEDURE ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]);
    BEGIN
        // DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        // DimMgt.SaveDefaultDim(DATABASE::"Cabecera Prestamo", "Código Del Prestamo"
        // , FieldNumber, ShortcutDimCode);
        // MODIFY;
    END;


}

