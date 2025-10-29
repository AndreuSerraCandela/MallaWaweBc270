/// <summary>
/// TableExtension Fixed AssetKuara (ID 80279) extends Record Fixed Asset.
/// </summary>
tableextension 80279 "Fixed AssetKuara" extends "Fixed Asset"
{
    fields
    {
        field(51016; "Global Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
        }
        field(51017; "Global Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
        }
        field(51021; "Global Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
        }
        field(51018; "No Recursos"; Integer) { }
        field(51019; "Mód. Montado"; Decimal) { }
        field(51020; "Recurso"; CODE[20]) { }

        field(51022; "Emplazamiento"; CODE[20]) { }
        field(51023; "Coste"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("FA Ledger Entry".Amount WHERE("FA No." = FIELD("No."), "FA Posting Type" = CONST("Acquisition Cost"), "FA Posting Category" = CONST(" ")));
        }
        field(52000; "Recurso Otra Empresa"; CODE[20]) { TableRelation = Resource; }
        field(52001; "Fecha Baja Activo"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."Fecha baja" WHERE("No." = FIELD(Recurso)));
        }
        field(52016; "Depreciation"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("FA Ledger Entry".Amount WHERE("FA No." = FIELD("No."), "FA Posting Category" = CONST(" "), "FA Posting Type" = CONST(Depreciation), "FA Posting Date" = FIELD("FA Posting Date Filter")));
        }
        field(52017; "Book Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("FA Ledger Entry".Amount WHERE("FA No." = FIELD("No."), "Part of Book Value" = CONST(true), "FA Posting Date" = FIELD("FA Posting Date Filter")));
        }
        field(52019; "Gain/Loss"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("FA Ledger Entry".Amount WHERE("FA No." = FIELD("No."), "FA Posting Category" = CONST(" "), "FA Posting Type" = CONST("Gain/Loss"), "FA Posting Date" = FIELD("FA Posting Date Filter")));
        }
        field(52020; "Baja 143"; Boolean) { }
        field(52021; "Fecha Baja"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("FA Ledger Entry"."FA Posting Date" WHERE("FA No." = FIELD("No."), "FA Posting Type" = CONST("Proceeds on Disposal")));
        }
        field(52022; "Baja Recurso"; Date) { TableRelation = Resource."Fecha baja" WHERE("No." = FIELD(Recurso)); }
    }
}
