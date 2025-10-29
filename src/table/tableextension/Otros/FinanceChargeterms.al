/// <summary>
/// TableExtension Finance Charge TermsKuara (ID 80115) extends Record Finance Charge Terms.
/// </summary>
tableextension 80115 "Finance Charge TermsKuara" extends "Finance Charge Terms"
{
    fields
    {
        field(50001; "Asiento"; Integer) { }
        field(50002; "Documento"; CODE[20]) { }
        field(50003; "Documento Ext"; CODE[20]) { }
        field(50004; "Empresa Org"; TEXT[30]) { }
        field(50005; "Empresa Dest"; TEXT[30]) { }
        field(50006; "Liquidado por Id"; Boolean) { }
        field(50007; "Document Type"; Enum "Document Type Kuara") { }
        field(50008; "Nº Mov"; Integer) { }
    }
}