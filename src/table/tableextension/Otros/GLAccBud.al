/// <summary>
/// TableExtension G/L Acc. Budget BufferKuara (ID 80235) extends Record G/L Acc. Budget Buffer.
/// </summary>
tableextension 80235 "G/L Acc. Budget BufferKuara" extends "G/L Acc. Budget Buffer"
{
    fields
    {
        field(50000; "Filtro Eliminaciones"; Boolean) { FieldClass = FlowFilter; }
    }
}
