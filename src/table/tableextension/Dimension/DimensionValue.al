/// <summary>
/// TableExtension Dimension ValueKuara (ID 80223) extends Record Dimension Value.
/// </summary>
tableextension 80223 "Dimension ValueKuara" extends "Dimension Value"
{
    fields
    {
        field(50001; "Gen. Prod. Posting Group"; CODE[10]) { TableRelation = "Gen. Product Posting Group"; }
        field(50002; "Permite"; Boolean) { }
        field(50003; Agrupacion; Code[20])
        {
            TableRelation = "Dimension Value";
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                DimVal: Record "Dimension Value";
                Dim: Record "Dimension";
            begin
                Dim.Get(Rec."Dimension Code");
                DimVal.SETRANGE("Dimension Code", dim.Agrupacion);
                If Page.RunModal(0, DimVal) = ACTION::LookupOK Then
                    Rec.Agrupacion := DimVal.Code;
            end;
        }
    }

}
