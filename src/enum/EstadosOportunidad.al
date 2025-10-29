/// <summary>
/// Enum Estados Oportunidad (ID 50007).
/// </summary>
enum 50007 "Estados Oportunidad"
{
    Extensible = true;

    value(0; "Not Started")
    {
        Caption = 'No iniciado';
    }
    value(1; "Pendiente Comunicar a Medios")
    {
        Caption = 'Pendiente Comunicar a Medios';
    }
    value(2; "Comunicado a Medios")
    {
        Caption = 'Comunicado a Medios';
    }
    value(3; Won)
    {
        Caption = 'Ganado';
    }
    value(4; Lost)
    {
        Caption = 'Perdido';
    }

}

