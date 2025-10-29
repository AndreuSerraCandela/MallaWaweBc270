/// <summary>
/// TableExtension Analysis ViewKuara (ID 80229) extends Record Analysis View.
/// </summary>
tableextension 80229 "Analysis ViewKuara" extends "Analysis View"
{
    fields
    {
        field(50000; "Dimension 5 Totaling"; TEXT[80])
        {

            TableRelation = "Dimension Value".Code where("Global Dimension No." = Const(5));
            ValidateTableRelation = false;
        }
        field(50021; "Payment Method Code"; CODE[20]) { }
        field(50002; "Bank Account"; CODE[20]) { }

    }
}
