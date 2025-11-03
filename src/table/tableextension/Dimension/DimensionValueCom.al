/// <summary>
/// TableExtension Dimension Value Combi.Kuara (ID 80225) extends Record Dimension Value Combination.
/// </summary>
tableextension 80225 "Dimension Value Combi.Kuara" extends "Dimension Value Combination"
{
    fields
    {
        field(50000; "Dimension Pincipal"; CODE[20]) { TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('PRINCIPAL')); }
        field(50001; "Dimension Soporte"; CODE[20]) { TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SOPORTE')); }
        field(50002; "Dimension Zona"; CODE[20]) { TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('ZONA')); }
    }

}
