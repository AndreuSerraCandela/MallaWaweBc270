/// <summary>
/// TableExtension IC Inbox Jnl. LineKuara (ID 80251) extends Record IC Inbox Jnl. Line.
/// </summary>
tableextension 80251 "IC Inbox Jnl. LineKuara" extends "IC Inbox Jnl. Line"
{
    fields
    {
        field(50000; "Cuenta Intermedia"; Boolean) { }
        field(50001; "Código Asiento"; CODE[20]) { }
    }
}
