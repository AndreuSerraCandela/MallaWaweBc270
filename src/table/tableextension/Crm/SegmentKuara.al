/// <summary>
/// TableExtension SegmentKuara (ID 80136) extends Record Segment Header.
/// </summary>
tableextension 80136 SegmentKuara extends "Segment Header"
{
    fields
    {
        field(80001; Resource; Code[20])
        {
            Caption = 'Recurso';
            TableRelation = Resource;

        }
    }
}
