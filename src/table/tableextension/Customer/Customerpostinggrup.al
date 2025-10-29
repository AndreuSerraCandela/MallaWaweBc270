/// <summary>
/// TableExtension Customer Posting GroupKuara (ID 80162) extends Record Customer Posting Group.
/// </summary>
tableextension 80162 "Customer Posting GroupKuara" extends "Customer Posting Group"
{
    fields
    {
        field(50000; "Cta efectos sin fra"; CODE[20]) { TableRelation = "G/L Account"; }
        field(50200; "Cta. anticipo"; CODE[20]) { TableRelation = "G/L Account"; }
        field(50202; "Cta. depósito"; CODE[20]) { TableRelation = "G/L Account"; }
    }
}
