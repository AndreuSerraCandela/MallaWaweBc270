/// <summary>
/// TableExtension DocAtch (ID 80118) extends Record Document Attachment.
/// </summary>
tableextension 80118 DocAtch extends "Document Attachment"
{
    fields
    {
        field(80115; "Confidencial"; Boolean)
        {
            Caption = 'Confidencial';
            DataClassification = ToBeClassified;
        }
        field(80116; "Grupos Usuario"; Text[1024])
        {
            Caption = 'Grupos Usuario';
            FieldClass = FlowFilter;


        }
        field(80117; "Permiso Usuarios"; Boolean)
        {
            Caption = 'Usuarios';
            FieldClass = FlowField;
            CalcFormula = exist("PermisosUsuario" where(Grupo = field(filter("Grupos Usuario")), ID = field("ID"), "Table ID" = field("Table ID"), "No." = field("No."), "Document Type" = field("Document Type"), "Line No." = field("Line No.")));

        }
    }
}
table 7001147 PermisosUsuario
{
    fields
    {
        field(1; "Grupo"; Code[20])
        {
            Caption = 'Grupo';
            trigger OnLookup()
            var
                SecurityGroup: Record "Security Group Buffer" temporary;
                SecutityGroupCodeunit: Codeunit "Security Group";
            begin
                SecutityGroupCodeunit.GetGroups(SecurityGroup);
                if Page.RunModal(9871, SecurityGroup) = Action::LookupOK then
                    "Grupo" := SecurityGroup."Group ID";
            end;
            //TableRelation = "User Group";
        }
        field(2; ID; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
            Editable = false;
        }
        field(3; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(13; "Document Type"; Enum "Attachment Document Type")
        {
            Caption = 'Document Type';
        }
        field(14; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

    }
    keys
    {
        key(PK; "Grupo", "Table ID", "No.", "Document Type", "Line No.", ID)
        {
            Clustered = true;
        }

    }
}