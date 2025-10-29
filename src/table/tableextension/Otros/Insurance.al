/// <summary>
/// TableExtension InsuranceKuara (ID 80283) extends Record Insurance.
/// </summary>
tableextension 80283 "InsuranceKuara" extends "Insurance"
{
    fields
    {
        field(51016; "Global Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
        }
        field(51017; "Global Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
        }
        field(51018; "Global Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
        }
    }
}
