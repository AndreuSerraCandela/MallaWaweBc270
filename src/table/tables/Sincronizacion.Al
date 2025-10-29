/// <summary>
/// Table Sincronization Setup (Field) (ID 7001149).
/// </summary>
table 7001149 "Sincronization Setup (Field)"
{
    Caption = 'Conf. Campos sincronización';
    DataPerCompany = false;
    fields
    {
        field(1; "Table No."; Integer)
        {
            Caption = 'Nº tabla';
            TableRelation = "Sincronization Setup (Table)";
        }
        field(2; "Field No."; Integer)
        {
            Caption = 'Nº Campo';
            TableRelation = Field."No." WHERE(TableNo = FIELD("Table No."));
        }
        field(3; "Field Caption"; Text[100])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE(TableNo = FIELD("Table No."),
                                                              "No." = FIELD("Field No.")));
            Caption = 'Descripción campo';
            FieldClass = FlowField;
        }

        field(9; "Table Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Table No.")));
            Caption = 'Nombre tabla';
            FieldClass = FlowField;
        }
        field(10; "Excluir"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Table No.", "Field No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


}
table 7001150 "Sincronization Setup (Table)"
{
    Caption = 'Conf. Sincronización Tabla';
    ReplicateData = true;

    fields
    {
        field(1; "Table No."; Integer)
        {
            Caption = 'Nº Tabla';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(2; "Table Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Table No.")));
            Caption = 'Nombre tabla';
            FieldClass = FlowField;
        }
        // field(3; "Log Insertion"; Option)
        // {
        //     Caption = 'Conf modificación';
        //     OptionCaption = ' ,Some Fields,All Fields';
        //     OptionMembers = " ","Some Fields","All Fields";

        //     trigger OnValidate()
        //     var
        //         ConfirmManagement: Codeunit "Confirm Management";
        //     begin
        //         if (xRec."Log Insertion" = xRec."Log Insertion"::"Some Fields") and (xRec."Log Insertion" <> "Log Insertion") then
        //             if ConfirmManagement.GetResponseOrDefault(
        //                  StrSubstNo(
        //                    Text001, xRec.FieldCaption("Log Insertion"), xRec."Log Insertion"), true)
        //             then
        //                 DelChangeLogFields(0);
        //     end;
        // }
        field(4; "Log Modification"; Boolean)
        {
            Caption = 'Campos excluidos';

            trigger OnValidate()
            var
                ConfirmManagement: Codeunit "Confirm Management";
            begin
                if xRec."Log Modification" then
                    DelChangeLogFields(1)
                else
                    ChangeLogFields(1);
            end;
        }
        // field(5; "Log Deletion"; Option)
        // {
        //     Caption = 'Log Deletion';
        //     OptionCaption = ' ,Some Fields,All Fields';
        //     OptionMembers = " ","Some Fields","All Fields";

        //     trigger OnValidate()
        //     var
        //         ConfirmManagement: Codeunit "Confirm Management";
        //     begin
        //         if (xRec."Log Deletion" = xRec."Log Deletion"::"Some Fields") and (xRec."Log Deletion" <> "Log Deletion") then
        //             if ConfirmManagement.GetResponseOrDefault(
        //                  StrSubstNo(
        //                    Text001, xRec.FieldCaption("Log Deletion"), xRec."Log Deletion"),
        //                  true)
        //             then
        //                 DelChangeLogFields(2);
        //     end;
        // }
        // field(6; "Monitor Sensitive Field"; Boolean)
        // {
        //     DataClassification = SystemMetadata;
        // }
    }

    keys
    {
        key(Key1; "Table No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'You have changed the %1 field to no longer be %2. Do you want to remove the field selections?';

    /// <summary>
    /// DelChangeLogFields.
    /// </summary>
    /// <param name="InsModDel">Integer.</param>
    procedure DelChangeLogFields(InsModDel: Integer)
    var
        ChangeLogSetupField: Record "Sincronization Setup (Field)";
    begin
        ChangeLogSetupField.SetRange("Table No.", "Table No.");
        ChangeLogSetupField.DeleteAll();
    end;

    /// <summary>
    /// ChangeLogFields.
    /// </summary>
    /// <param name="InsModDel">Integer.</param>
    procedure ChangeLogFields(InsModDel: Integer)
    var
        ChangeLogSetupField: Record "Sincronization Setup (Field)";
        Fields: Record Field;
    begin
        Fields.SetRange(TableNo, "Table No.");
        Fields.SetRange(Class, Fields.Class::Normal);
        if Fields.FindFirst() Then
            Repeat
                //Crea el registro en la tabla de configuración de campos, si no existe
                ChangeLogSetupField.SetRange("Table No.", "Table No.");
                ChangeLogSetupField.SetRange("Field No.", Fields."No.");
                if not ChangeLogSetupField.FindFirst() then begin
                    ChangeLogSetupField."Table No." := Fields."TableNo";
                    ChangeLogSetupField."Field No." := Fields."No.";
                    ChangeLogSetupField.Insert();
                end;
            until Fields.Next() = 0;
    end;
}