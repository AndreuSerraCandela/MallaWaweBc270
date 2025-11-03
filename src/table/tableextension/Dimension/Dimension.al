/// <summary>
/// TableExtension Dimension ValueKuara (ID 80223) extends Record Dimension Value.
/// </summary>
tableextension 80224 "Dimension Kuara" extends "Dimension"
{
    fields
    {
        field(50001; "Agrupacion"; CODE[10]) { TableRelation = Dimension; }
        field(50002; "Permite"; Boolean) { }
    }

}
