/// <summary>
/// TableExtension CueMarketing (ID 80113) extends Record Relationship Mgmt. Cue.
/// </summary>
tableextension 80113 CueMarketing extends "Relationship Mgmt. Cue"
{
    fields
    {
        field(80001; Task; Integer)
        {
            Caption = 'Correos';
            CalcFormula = Count("Interaction Log Entry");
            FieldClass = FlowField;

        }
        field(80002; Interacciones; Integer)
        {
            Caption = 'Visitas';
            CalcFormula = Count("To-do" where(Type = filter(<> "Phone Call")));
            FieldClass = FlowField;
        }
        field(80102; Llamadas; Integer)
        {
            Caption = 'Llamadas';
            CalcFormula = Count("To-do" where(Type = const("Phone Call")));
            FieldClass = FlowField;
        }
        field(80005; Actividades; Integer)
        {
            Caption = 'Actividades';
            CalcFormula = Count("To-do" where("Activity Code" = filter(<> '')));
            FieldClass = FlowField;
        }
        field(80103; "Oport. Ptes. de Comunicar"; Integer)
        {
            Caption = 'Oportunidades no comunicadas';
            FieldClass = FlowField;
            CalcFormula = Count(Opportunity where(Estado = const("Pendiente Comunicar a Medios")));

        }
        field(80104; "Oport. Comunicadas"; Integer)
        {
            Caption = 'Oportunidades comunicadas';
            FieldClass = FlowField;
            CalcFormula = Count(Opportunity where(Estado = const("Comunicado a Medios")));

        }

    }
}
