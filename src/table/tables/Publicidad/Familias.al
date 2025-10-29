/// <summary>
/// Table Familias (ID 7010466).
/// </summary>
table 7001156 Familias
{
    fields
    {
        field(1; "Cód. Familia"; Code[10])
        {
            Caption = 'Cód. Familia';
            NotBlank = true;
        }
        field(2; Descripción; Text[30]) { Caption = 'Descripción'; }
        field(3; "Cód. Grupo Familias"; Code[10])
        {
            TableRelation = "Grupo familias"."Cód. Grupo Familias";
            Caption = 'Cód. Grupo Familias';
        }
        field(4; "ID. Código Familia"; Code[2])
        {
            Caption = 'ID. Código Familia';
            trigger OnValidate()
            BEGIN

                //if NOT(rIns.GET('1')) THEN
                //  ERROR(Text001);

                //if NOT(rIns."Codif. de productos automática") THEN
                //  if "ID. Código Familia" <> '' THEN
                //    ERROR(Text002);

                rFam.RESET;
                rFam.SETCURRENTKEY("ID. Código Familia");
                rFam.SETRANGE("ID. Código Familia", "ID. Código Familia");
                if rFam.FIND('-') THEN
                    REPEAT
                        if rFam."Cód. Familia" <> "Cód. Familia" THEN
                            ERROR(Text003, rFam."Cód. Familia");
                    UNTIL rFam.NEXT = 0;
            END;

        }
        field(7000100; SourceCounter; Integer) { Caption = 'SourceCounter'; }
    }
    KEYS
    {
        key(Fam; "Cód. Familia") { Clustered = true; }
        key(Id; "ID. Código Familia") { }
        Key(Grupo; "Cód. Grupo Familias") { }
    }
    VAR
        Text000: Label 'Existen subfamilias asociadas a esta familia';
        Text001: Label 'Falta introducir los Datos de la instalación';
        Text002: Label 'No se trabaja con codificación automática';
        Text003: Label 'Ya existe este ID. de Familia para el Código %1';
        rFam: Record Familias;
        rSubFam: Record 251;
        rTable: Record Familias;

    trigger OnInsert()
    BEGIN
        SourceCounter := ActSourceCounter;
    END;

    trigger OnModify()
    BEGIN
        SourceCounter := ActSourceCounter;
    END;

    trigger OnDelete()
    BEGIN

        rSubFam.SETCURRENTKEY(Familia);
        rSubFam.SETRANGE(Familia, "Cód. Familia");
        if rSubFam.FIND('-') THEN
            ERROR(Text000);

        if rTable.SETCURRENTKEY(SourceCounter) THEN BEGIN
            rTable.FIND('+');
            if ((rTable.SourceCounter <> 0) AND (rTable.SourceCounter = SourceCounter)) THEN BEGIN
                if rTable.FIND('><') THEN BEGIN
                    rTable.SourceCounter := SourceCounter;
                    rTable.MODIFY();
                END
            END;
        END;
    END;


    PROCEDURE ActSourceCounter() pCounter: Integer;
    BEGIN
        pCounter := 0;

        rTable.RESET;
        rTable.SETCURRENTKEY(rTable.SourceCounter);
        if rTable.FIND('+') THEN
            pCounter := rTable.SourceCounter + 1;
    END;


}

