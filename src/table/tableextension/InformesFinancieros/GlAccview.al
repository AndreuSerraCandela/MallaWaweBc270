/// <summary>
/// TableExtension G/L Account (Ana. View)Kuara (ID 80236) extends Record G/L Account (Analysis View).
/// </summary>
tableextension 80236 "G/L Account (Ana. View)Kuara" extends "G/L Account (Analysis View)"
{
    fields
    {
        field(50000; "Dimension 5 Filter"; CODE[20]) { FieldClass = FlowFilter; TableRelation = "Dimension Value"; }
    }
}
