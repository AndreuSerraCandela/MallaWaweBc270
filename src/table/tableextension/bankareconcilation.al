/// <summary>
/// TableExtension Bank Acc. Reconci.LineKuara (ID 80200) extends Record Bank Acc. Reconciliation Line.
/// </summary>
tableextension 80200 "Bank Acc. Reconci.LineKuara" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; "Concepto común"; CODE[2]) { }
        field(50001; "Tipo conciliación"; Enum "Tipo conciliación") { }
        field(50002; "Liq. por Id."; CODE[10]) { }
        field(50003; "Nº conciliación"; Integer) { }
    }
}
