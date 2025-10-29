/// <summary>
/// TableExtension EmployeeKuara (ID 80273) extends Record Employee.
/// </summary>
tableextension 80273 "EmployeeKuara" extends "Employee"
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
        field(80013; "username gotimecloud"; text[250])
        {
            ObsoleteState = Removed;
            Description = '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918';
        }
        field(80014; "password gotimecloud"; text[250])
        {
            ObsoleteState = Removed;
            Description = '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918malla';
            ExtendedDatatype = Masked;
        }
        field(80015; "Turno Continuo"; Boolean)
        {
            ObsoleteState = Removed;
        }
        field(80016; "Firma de Contratos"; Boolean)
        {
            ObsoleteState = Removed;
        }
        field(80017; "VAT Registration No."; Text[20])
        {
            ObsoleteState = Removed;
            Caption = 'NiF';
        }
    }
}
