/// <summary>
/// TableExtension Reminder LineKuara (ID 80206) extends Record Reminder Line.
/// </summary>
tableextension 80206 "Reminder LineKuara" extends "Reminder Line"
{
    fields
    {
        field(50024; "Sales/Person Code"; CODE[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Cust. Ledger Entry"."Salesperson Code" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No.")));
            TableRelation = "Salesperson/Purchaser";
        }
    }
}
