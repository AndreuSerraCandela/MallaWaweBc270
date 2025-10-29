/// <summary>
/// TableExtension Dimension Code BufferKuara (ID 80232) extends Record Dimension Code Buffer.
/// </summary>
tableextension 80232 "Dimension Code BufferKuara" extends "Dimension Code Buffer"
{
    fields
    {
        field(50000; "Filtro Fp"; CODE[20]) { FieldClass = FlowFilter; TableRelation = "Payment Method"; }
        field(50001; "Filtro Banco"; CODE[20]) { FieldClass = FlowFilter; TableRelation = "Bank Account"; }
        field(50002; "IBF"; Decimal) { }
        field(50003; "IBA"; Decimal) { }
        field(50004; "IF"; Decimal) { }
        field(50005; "IA"; Decimal) { }
        field(50006; "TC"; Decimal) { }
        field(50007; "IG"; Decimal) { }
        field(50008; "IP"; Decimal) { }
        field(50009; "ID"; Decimal) { }
        field(50010; "TI"; Decimal) { }
        field(51000; "Dimension 5 Value Filter"; CODE[20]) { FieldClass = FlowFilter; TableRelation = "Dimension Value"; }
    }
}
