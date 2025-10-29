/// <summary>
/// TableExtension Issued Reminder HeaderKuara (ID 80207) extends Record Issued Reminder Header.
/// </summary>
tableextension 80207 "Issued Reminder HeaderKuara" extends "Issued Reminder Header"
{
    fields
    {
        field(50001; "Contact No."; CODE[20]) { TableRelation = Contact; }
        field(50002; "To-do No."; CODE[20]) { }
    }
}
