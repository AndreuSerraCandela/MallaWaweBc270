/// <summary>
/// TableExtension Reminder HeaderKuara (ID 80205) extends Record Reminder Header.
/// </summary>
tableextension 80205 "Reminder HeaderKuara" extends "Reminder Header"
{
    fields
    {
        field(50001; "Contact No."; CODE[20]) { TableRelation = Contact; }
        field(50002; "To-do No."; CODE[20]) { }
        field(50003; "Observaciones"; TEXT[250]) { }
        field(50004; "Grupo Empresas"; CODE[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Contact Industry Group"."Industry Group Code" WHERE("Contact No." = FIELD("Contact No.")));
            TableRelation = "Industry Group".Code WHERE(Code = FIELD("Grupo Empresas"));
        }
        field(51040; "Shortcut Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(51041; "Shortcut Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(51042; "Shortcut Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
    }
    /// <summary>
    /// CreateTodo.
    /// </summary>
    procedure CreateTodo()
    var
        TempTodo: Record "To-do" temporary;
    begin

        TESTFIELD("Contact No.");
        TempTodo.CreateToDoFromReminder(Rec);
    end;
}
