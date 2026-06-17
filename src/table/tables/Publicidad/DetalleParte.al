/// <summary>
/// Table Detalle Parte (ID 50017).
/// </summary>
table 50017 "Detalle Parte"
{
    Caption = 'Detalle Parte';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Nº Parte"; Code[20])
        {
            Caption = 'Nº Parte';
            TableRelation = "Partes de Trabajo";
        }
        field(2; Tipo; Enum "Tipo Detalle Parte")
        {
            Caption = 'Tipo';
        }
        field(3; "Nº Linea"; Integer)
        {
            Caption = 'Nº Línea';
        }
        field(4; "Nº Tarea"; Integer)
        {
            Caption = 'Nº Tarea';
            TableRelation = if (Tipo = CONST(Tarea)) "User Task".ID;
            trigger OnValidate()
            var
                UserTask: Record "User Task";
            begin
                if Tipo = Tipo::Tarea then
                    if UserTask.GET("Nº Tarea") then
                        Descripcion := UserTask.Title;
            end;
        }
        field(5; Descripcion; Text[250])
        {
            Caption = 'Descripción';
        }
        field(6; "Descripcion elim. residuos"; Text[250])
        {
            Caption = 'Descripción eliminación residuos';
        }
    }
    keys
    {
        key(PK; "Nº Parte", "Nº Linea")
        {
            Clustered = true;
        }
    }
}
