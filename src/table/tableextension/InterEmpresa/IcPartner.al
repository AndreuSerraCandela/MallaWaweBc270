/// <summary>
/// TableExtension IC PartnerKuara (ID 80246) extends Record IC Partner.
/// </summary>
tableextension 80246 "IC PartnerKuara" extends "IC Partner"
{
    fields
    {
        field(50000; "Internal Account"; CODE[20]) { TableRelation = "G/L Account"."No."; }
        field(50001; "Debit Account"; CODE[20]) { TableRelation = "G/L Account"."No."; }
        field(50002; "Credit Account"; CODE[20]) { TableRelation = "G/L Account"."No."; }
    }
}
