/// <summary>
/// Table Términos pagos emplazamientos (ID 7010459).
/// </summary>
table 7001108 "Términos pagos emplazamientos"
{


    fields
    {
        field(1; "Código"; Code[10]) { NotBlank = true; }
        field(5; "Descripción"; Text[30]) { }
        field(10; "Periodicidad"; DateFormula) { }
        field(15; "No. de plazos"; Integer) { }
        field(16; "Texto"; Text[10]) { }
    }
    KEYS
    {
        key(Codigo; Código) { Clustered = true; }
    }
    VAR
        Plazo: Record "Plazos de facturación";

    trigger OnDelete()
    BEGIN
        Plazo.SETRANGE("Cód. términos facturación", Código);
        Plazo.DELETEALL;
    END;

}
