/// <summary>
/// TableExtension Purchase Header ArchiveKuara (ID 80269) extends Record Purchase Header Archive.
/// </summary>
tableextension 80269 "Purchase Header ArchiveKuara" extends "Purchase Header Archive"
{
    fields
    {
        field(50000; "Pedido Periodo"; Boolean) { }
        field(51040; "Shortcut Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';

        }
        field(51041; "Shortcut Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';

        }
        field(51042; "Shortcut Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';

        }
        field(51096; "Empresa Origen Alb"; TEXT[30]) { }
    }
    
}
