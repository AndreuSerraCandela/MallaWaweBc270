/// <summary>
/// TableExtension Analysis View Bud EntryKuara (ID 80231) extends Record Analysis View Budget Entry.
/// </summary>
tableextension 80231 "Analysis View Bud EntryKuara" extends "Analysis View Budget Entry"
{
    fields
    {
        field(50000; "Dimension 5 Value Code"; CODE[20])
        {
            CaptionClass = GetCaptionClass(10);
            TableRelation = "Dimension Value".Code where("Global Dimension No." = Const(5));
        }
    }
}
