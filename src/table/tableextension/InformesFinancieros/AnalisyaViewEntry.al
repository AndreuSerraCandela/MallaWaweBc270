/// <summary>
/// TableExtension Analysis View EntryKuara (ID 80230) extends Record Analysis View Entry.
/// </summary>
tableextension 80230 "Analysis View EntryKuara" extends "Analysis View Entry"
{
    fields
    {
        field(50000; "Dimension 5 Value Code"; CODE[20])
        {
            CaptionClass = GetCaptionClass(10);
            TableRelation = "Dimension Value".Code where("Global Dimension No." = Const(5));
        }
        field(50022; "Payment Method Code"; Code[20]) { }
        field(50001; "Bank Account"; CODE[20]) { }
    }
}
