/// <summary>
/// TableExtension OportunicadesLin (ID 80141) extends Record Opportunity Entry.
/// </summary>
tableextension 80141 OportunicadesLin extends "Opportunity Entry"
{
    fields
    {
        field(80101; "Zona Soporte"; Code[20])
        {
            Caption = 'Zona Soporte';
            DataClassification = ToBeClassified;
        }
        field(80102; "Tipo Soporte"; Enum "Tipo de Soporte")
        {
            Caption = 'Tipo Soporte';
            DataClassification = ToBeClassified;
        }
        field(80103; "Tipo de Campaña"; Enum "Tipo de Campaña")
        {
            Caption = 'Tipo de Campaña';
            DataClassification = ToBeClassified;
        }
        field(80104; "Recurso Solicitado"; Code[20])
        {
            Caption = 'Recurso Solicitado';
            TableRelation = Resource;
            ValidateTableRelation = false;
            //TestTableRelation=false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Res: Record Resource;
            begin
                if Res.Get("Recurso Solicitado") then
                    "Descripcion Recurso" := Res.Name;
            end;

        }
        field(80105; "Descripción Recurso"; Code[20])
        {
            ObsoleteState = Removed;
            Caption = 'No se usa';
            DataClassification = ToBeClassified;

        }
        field(80108; "Descripcion Recurso"; Text[200])
        {
            Caption = 'Descripción Recurso Solicitado';
            DataClassification = ToBeClassified;

        }
        field(80106; "Fecha Inicio"; Date)
        {
            Caption = 'Fecha Inicio';
            DataClassification = ToBeClassified;

        }
        field(80107; "Fecha Fin"; Date)
        {
            Caption = 'Fecha Fin';
            DataClassification = ToBeClassified;

        }

    }

}
