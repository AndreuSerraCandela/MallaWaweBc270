/// <summary>
/// TableExtension Return Receipt HeaderKuara (ID 80305) extends Record Return Receipt Header.
/// </summary>
tableextension 80305 "Return Receipt HeaderKuara" extends "Return Receipt Header"
{
    fields
    {
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
        field(80000; "Tipo Factura SII"; CODE[2]) { }
        field(80001; "Clave registro SII expedidas"; CODE[2]) { }
        field(80006; "Descripción operacion"; TEXT[250]) { }
        field(80007; "Tipo factura rectificativa"; CODE[1]) { }
    }



}
