/// <summary>
/// Table Grupo familias (ID 7010467).
/// </summary>
table 7001158 "Grupo familias"
{

    fields
    {
        field(1; "Cód. Grupo Familias"; Code[10]) { Caption = 'Cód. Grupo Familias'; }
        field(2; Descripción; Text[30]) { Caption = 'Descripción'; }
        field(3; "Id. Códigos Grupos"; Code[2])
        {
            Caption = 'Id. Códigos Grupos';
            trigger OnValidate()
            BEGIN

                // if NOT(rIns.GET('1')) THEN
                //     ERROR(Text001);

                // if NOT(rIns."Codif. de productos automática") THEN
                //     if "Id. Códigos Grupos" <> '' THEN
                //         ERROR(Text002);

                rGru.RESET;
                rGru.SETCURRENTKEY("Cód. Grupo Familias");
                rGru.SETRANGE("Cód. Grupo Familias", "Cód. Grupo Familias");
                if rGru.FIND('-') THEN
                    REPEAT
                        if rGru."Cód. Grupo Familias" <> "Cód. Grupo Familias" THEN
                            ERROR(Text003, rGru."Cód. Grupo Familias");
                    UNTIL rGru.NEXT = 0;
            END;

        }
        field(5; "Almacén central asignado"; Code[10])
        {
            TableRelation = Location.Code;
            Caption = 'Almacén central asignado';
        }
        field(7000100; SourceCounter; Integer) { }
    }
    KEYS
    {
        Key(Id; "Cód. Grupo Familias") { Clustered = true; }
        Key(Codigo; "Id. Códigos Grupos") { }

    }

    VAR
        Text000: Label 'Existen familias asociadas a este grupo';
        Text001: Label 'Falta introducir los Datos de la instalación';
        Text002: Label 'No se trabaja con codificación automática';
        Text003: Label 'Ya existe este ID. de Grupo para el Código %1';
        rGru: Record "Grupo familias";
        rFam: Record Familias;
        rTable: Record "Grupo familias";

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

        rFam.SETCURRENTKEY("Cód. Grupo Familias");
        rFam.SETRANGE("Cód. Grupo Familias", "Cód. Grupo Familias");
        if rFam.FIND('-') THEN
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
