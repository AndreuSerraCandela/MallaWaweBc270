/// <summary>
/// TableExtension Handled IC Out Jnl. LineKuara (ID 80249) extends Record Handled IC Outbox Jnl. Line.
/// </summary>
tableextension 80249 "Handled IC Out Jnl. LineKuara" extends "Handled IC Outbox Jnl. Line"
{
    fields
    {
        field(50000; "Cuenta Intermedia"; Boolean) { }
        field(50001; "Código Asiento"; CODE[20]) { }
    }
}
