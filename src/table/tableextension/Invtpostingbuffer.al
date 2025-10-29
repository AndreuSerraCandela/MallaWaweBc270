
/// <summary>
/// TableExtension Invt. Posting BufferKuara (ID 80154) extends Record Invt. Posting Buffer.
/// </summary>
#pragma warning disable AL0432
tableextension 80154 "Invt. Posting BufferKuara" extends "Invt. Posting Buffer"
#pragma warning restore AL0432

{
    fields
    {
        field(50001; "Descripción"; TEXT[50]) { ObsoleteState = Removed; }
        field(50002; "Entry No.2"; Integer) { ObsoleteState = Removed; }
        //modify("Entry No.")
        //{
        // trigger OnAfterValidate()
        // begin
        //     "Entry No.2" := "Entry No.";
        // end;
        //}
    }

    keys
    {

        // key(EntryNo; "Entry No.2") { }

    }
}
