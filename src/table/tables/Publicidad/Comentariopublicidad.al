/// <summary>
/// Table Comentario orden publicidad (ID 7001139).
/// </summary>
table 7001139 "Comentario orden publicidad"
{
    Caption = 'Comentario orden publicidad';

    fields
    {
        field(1; "Tipo orden"; Enum "Tipo orden")
        {
            Caption = 'Tipo de orden';

        }
        field(2; "No."; Code[20]) { Caption = 'Nº'; }
        field(3; "No. linea"; Integer) { Caption = 'Nº línea'; }
        field(4; "Fecha"; Date) { Caption = 'Fecha'; }
        field(6; "Comentario"; Text[60]) { Caption = 'Comentario'; }
    }
    KEYS
    {
        key(P; "Tipo orden", "No.", "No. linea") { Clustered = true; }
    }

    PROCEDURE SetUpNewLine();
    VAR
        rLinCom: Record "Comentario orden publicidad";
    BEGIN
        rLinCom.SETRANGE("Tipo orden", "Tipo orden");
        rLinCom.SETRANGE("No.", "No.");
        if NOT rLinCom.FIND('-') THEN
            Fecha := WORKDATE;
    END;


}

