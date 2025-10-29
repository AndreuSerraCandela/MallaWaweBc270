/// <summary>
/// TableExtension Handled IC In Jnl. LineKuara (ID 80252) extends Record Handled IC Inbox Jnl. Line.
/// </summary>
tableextension 80252 "Handled IC In Jnl. LineKuara" extends "Handled IC Inbox Jnl. Line"
{
    fields
    {
        field(50000; "Cuenta Intermedia"; Boolean) { }
        field(50001; "Código Asiento"; CODE[20]) { }
    }
}
