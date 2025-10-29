/// <summary>
/// TableExtension G/L Budget NameKuara (ID 80164) extends Record G/L Budget Name.
/// </summary>
tableextension 80164 "G/L Budget NameKuara" extends "G/L Budget Name"
{
    fields
    {
        field(50000; "Budget Dimension 5 Code"; CODE[20])
        {
            TableRelation = Dimension;
        }
        field(50001; "Email"; Text[200])
        {

        }
    }
}