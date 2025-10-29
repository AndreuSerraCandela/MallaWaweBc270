/// <summary>
/// Table Filtros Recursos (ID 7001151).
/// </summary>
table 7001151 "Filtros Recursos"
{
    fields
    {
        field(1; Usuario; Text[50])
        {

        }
        field(2; "Nombre del filtro"; Text[250]) { }
        field(3; PeriodType; Option)
        {
            OptionMembers = Día,Semana,Mes;
            ObsoleteState = Removed;

        }
        field(4; Desde; Date)
        {

        }
        field(5; Hasta; Date)
        {

        }

        field(6; "Filtro Tipo Recurso"; Text[1024])
        {

        }
        field(7; "Filtro Familia"; Text[1024])
        {

        }
        field(8; "Filtro Zona"; Text[1024])
        {

        }
        field(9; "Filtro dimension Zona"; Text[1024])
        {

        }
        field(10; Lunes; Boolean)
        {

        }
        field(11; Martes; Boolean)
        {


        }
        field(12; "Miércoles"; Boolean)
        {

        }
        field(13; Jueves; Boolean)
        {

        }
        field(14; Viernes; Boolean)
        {
        }
        field(15; "Sábado"; Boolean)
        {

        }
        field(16; Domingo; Boolean)
        {

        }
        field(17; Filtros; TableFilter)
        { }
        field(18; PeriodTypeNew; Enum "Analysis Period Type") { }
    }
    keys
    {
        key(PK; Usuario, "Nombre del filtro") { Clustered = true; }
    }
}