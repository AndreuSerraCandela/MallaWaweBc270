/// <summary>
/// Enum Tipo de Contratacion (ID 50001).
/// </summary>
enum 50001 "Tipo de Contratacion"
{
    Extensible = true;

    value(0; Anual)
    {
        Caption = 'Anual';
    }
    value(1; Temporada)
    {
        Caption = 'Temporada';
    }
    value(2; "Por meses")
    {
        Caption = 'Por meses';
    }

}
