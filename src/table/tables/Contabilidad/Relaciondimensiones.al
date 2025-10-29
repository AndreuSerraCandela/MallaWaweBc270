/// <summary>
/// Table Relación Dimensiones (ID 7001191).
/// </summary>
table 7001191 "Relación Dimensiones"
{
    DataPerCompany = false;
    fields
    {
        field(1; "Empresa Origen"; Text[30]) { TableRelation = Company; }
        field(5; "Código Dimension"; Code[20]) { TableRelation = Dimension.Code; }
        field(8; "Empresa Destino"; Text[30]) { TableRelation = Company; }
        field(10; "Valor Dimensión"; Code[20]) { TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Código Dimension")); }
        field(11; "Valor Dimensión destino"; Text[60])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Código Dimension"));
            ValidateTableRelation = false;
            Caption = 'Valor Dimensión destino';
        }
        field(15; "Población"; Text[30]) { Caption = 'Población'; }
        field(16; "Provincia"; Code[10])
        {
            TableRelation = Area.Code;
            Caption = 'Provincia';
            trigger OnValidate()
            BEGIN

                if rCodPvc.GET(Provincia) THEN;
            END;

        }
        field(17; "Comunidad autónoma"; Code[20])
        {
            //TableRelation = Table7000106.Field1;
            Caption = 'Comunidad autónoma';
        }
        field(20; "Teléfono"; Text[30]) { Caption = 'Teléfono'; }
        field(25; "Fax"; Text[30]) { Caption = 'Fax'; }
        field(30; "Referencia 1"; Text[30]) { Caption = 'Referencia 1'; }
        field(35; "Referencia 2"; Text[30]) { Caption = 'Referencia 2'; }
        field(110; "Rango Hoteles"; Code[10])
        {
            FieldClass = FlowFilter;
            //TableRelation = Hoteles.Hotel;
            Caption = 'Rango hoteles';
            Editable = true;
        }
        field(111; "Rango Fechas"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Rango fechas';
            Editable = false;
        }
        field(112; "No Usar1"; Decimal)
        {
            Caption = 'Estancias AD';
            Editable = false;
        }
        field(113; "No Usar2"; Decimal)
        {
            Caption = 'Estancias JR';
            Editable = false;
        }
        field(114; "No Usar3"; Decimal)
        {
            Caption = 'Estancias NI';
            Editable = false;
        }
        field(115; "No Usar4"; Decimal)
        {
            Caption = 'Estancias CU';
            Editable = false;
        }
        field(116; "No Usar5"; Decimal)
        {
            Caption = 'Ocupación';
            Editable = false;
        }
        field(120; "No Usar6"; Decimal) { Caption = 'Total producción'; }
    }
    KEYS
    {
        key(P; "Empresa Origen", "Código Dimension", "Empresa Destino", "Valor Dimensión")
        {
            Clustered = true;
        }
    }
    VAR
        rCP: Record 225;
        rCodPvc: Record 284;
}
