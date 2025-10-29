/// <summary>
/// Table Recordatorios (ID 7001196).
/// </summary>
table 7001196 Recordatorios
{
    Caption = 'Recordatorios.';
    fields
    {
        field(1; "Tipo documento"; Enum "Sales Document Type From")
        {
            Caption = 'Tipo documento';

        }
        field(2; "Nº"; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FIELD("Tipo documento"));
            Caption = 'Nº';
        }
        field(3; "Nº Linea"; Integer) { Caption = 'Nº línea'; }
        field(4; "Fecha"; Date) { Caption = 'Fecha'; }
        field(6; "Recordatorio"; Text[80]) { Caption = 'Recordatorio'; }
    }
    KEYS
    {
        key(P; "Tipo documento", "Nº", "Nº Linea") { Clustered = true; }
    }
    PROCEDURE SetUpNewLine();
    VAR
        rRecordatorios: Record Recordatorios;
    BEGIN
        rRecordatorios.SETRANGE("Tipo documento", "Tipo documento");
        rRecordatorios.SETRANGE("Nº", "Nº");
        if NOT rRecordatorios.FIND('-') THEN
            Fecha := WORKDATE;
    END;

}

