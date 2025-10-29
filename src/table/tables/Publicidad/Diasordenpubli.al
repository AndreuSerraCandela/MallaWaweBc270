/// <summary>
/// Table Dias orden publicidad (ID 7001134).
/// </summary>
table 7001134 "Dias orden publicidad"
{
    fields
    {
        field(1; "Tipo orden"; Enum "Tipo orden") { }
        field(2; "No. orden"; Code[20]) { }
        field(3; "Dia"; Date)
        {
            trigger OnValidate()
            BEGIN
                if Dia <> 0D THEN
                    EVALUATE("Dia semana", FORMAT(Dia, 0, '<WeekDay>'))
                ELSE
                    CLEAR("Dia semana");
            END;
        }
        field(4; "Dia semana"; Enum "Dia Semana") { }
        field(5; "Periodo"; Boolean) { }
        field(6; "Inicio periodo"; Date) { }
        field(7; "Fin periodo"; Date) { }
        field(8; Empresa; Text[30])
        {

        }
        field(9; Ventas; Decimal)
        { }
        field(10; Comercial; Code[20])
        {

        }
        field(11; "Motivo Incidencia"; Enum "Motivo Incidencia")
        {

        }
        field(12; "Nº proyecto"; Code[20])
        {

        }
    }
    KEYS
    {
        key(P; "Tipo orden", "No. orden", Dia) { Clustered = true; }
    }
}

