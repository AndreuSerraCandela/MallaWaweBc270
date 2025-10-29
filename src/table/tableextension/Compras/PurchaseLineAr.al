/// <summary>
/// TableExtension Purchase Line ArchiveKuara (ID 80270) extends Record Purchase Line Archive.
/// </summary>
tableextension 80270 "Purchase Line ArchiveKuara" extends "Purchase Line Archive"
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
        field(54003; "Recurso"; CODE[20]) { }
        field(54001; "Empresa Origen"; TEXT[30]) { }
        field(54002; "Proyecto Origen"; CODE[20]) { }
        field(80120; "Recurso Agrupado"; Boolean) { }
    }
}
