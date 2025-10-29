/// <summary>
/// TableExtension Oportunicades (ID 80140) extends Record Opportunity.
/// </summary>
tableextension 80140 Oportunicades extends Opportunity
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
        field(80106; "Descripcion Recurso"; Text[200])
        {
            Caption = 'Descripción Recurso Solicitado';
            DataClassification = ToBeClassified;
        }
        field(80016; Estado; Enum "Estados Oportunidad")
        {
            Caption = 'Estado';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                case Estado of
                    Estado::"Comunicado a Medios":
                        Status := Status::"In Progress";
                    Estado::"Pendiente Comunicar a Medios":
                        Status := Status::"In Progress";
                    Estado::"Not Started":
                        Status := Status::"Not Started";
                    Estado::Lost:
                        Status := Status::Lost;
                    Estado::Won:
                        Status := Status::Won;
                End;
            end;
        }
        modify(Status)
        {

#pragma warning disable AL0600 // TODO: - Revisar
            OptionCaption = 'No iniciado,En progreso,Ganado,Perdido,Comunicado a medios';
#pragma warning restore AL0600 // TODO: - Revisar


        }
    }
}
