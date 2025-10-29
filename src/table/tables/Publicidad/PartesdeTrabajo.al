/// <summary>
/// Table Partes de Trabajo (ID 7001165).
/// </summary>
table 7001165 "Partes de Trabajo"
{
    DataPerCompany = false;


    fields
    {
        field(1; "Nº Parte"; Code[20]) { }
        field(2; "Fecha Parte"; Date) { }
        field(3; "Hora Entrada"; Time) { }
        field(4; "Hora Salida"; Time)
        {
            trigger OnValidate()
            BEGIN
                Horas := ROUND(("Hora Salida" - "Hora Entrada") / 1000 / 60 / 60, 0.05, '=');
            END;
        }
        field(5; "Horas"; Decimal) { }
        field(6; "Empresa"; Text[30]) { TableRelation = Company; }
        field(7; "Texto Trabajo"; Text[250]) { }
    }
    KEYS
    {
        key(P; "Nº Parte")
        {
            SumIndexfields = Horas;
            Clustered = true;
        }
        key(F; "Fecha Parte") { SumIndexfields = Horas; }
    }
    VAR
        rSelf: Record "Partes de Trabajo";

    trigger OnInsert()
    BEGIN
        "Nº Parte" := '0001';
        if rSelf.FINDLAST THEN
            "Nº Parte" := INCSTR(rSelf."Nº Parte");
        "Nº Parte" := INCSTR("Nº Parte");
        "Nº Parte" := INCSTR("Nº Parte");
        "Nº Parte" := INCSTR("Nº Parte");
        "Nº Parte" := INCSTR("Nº Parte");
        "Fecha Parte" := TODAY;
        "Hora Entrada" := TIME;
    END;

}

