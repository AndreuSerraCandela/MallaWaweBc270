/// <summary>
/// TableExtension Vendor Posting GroupKuara (ID 80163) extends Record Vendor Posting Group.
/// </summary>
tableextension 80163 "Vendor Posting GroupKuara" extends "Vendor Posting Group"
{
    fields
    {
        field(50000; "FPR"; CODE[20]) { TableRelation = "G/L Account"; }
    }
}
