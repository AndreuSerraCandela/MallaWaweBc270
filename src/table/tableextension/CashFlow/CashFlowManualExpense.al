/// <summary>
/// TableExtension Neutral PaymentsKuara (ID 80330) extends Record Cash Flow Manual Expense.
/// </summary>
tableextension 80330 "Neutral PaymentsKuara" extends "Cash Flow Manual Expense"
{
    fields
    {
        field(50000; "Banco"; CODE[20]) { }
        field(50001; "Una Sola Vez"; Boolean) { }
    }
}