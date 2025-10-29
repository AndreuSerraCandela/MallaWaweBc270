/// <summary>
/// TableExtension DocumentSendingProfilekuara (ID 80116) extends Record Document Sending Profile.
/// </summary>
tableextension 80116 DocumentSendingProfilekuara extends "Document Sending Profile"
{

    fields
    {
        field(80153; "Report Facturas"; Integer) { TableRelation = AllObj."Object ID" WHERE("Object type" = CONST(Report)); }
        field(89154; "Report Abonos"; Integer) { TableRelation = AllObj."Object ID" WHERE("Object type" = CONST(Report)); }
        field(80155; "Printer Name"; Text[250])
        {
            TableRelation = Printer;
            Caption = 'Nombre impresora';
        }
        field(80156; "Enviar Ahora"; Boolean)
        {
            Caption = 'Una parte relacionada seleccionada';
        }
        field(80157; "Orden"; Integer) { }
    }
}

