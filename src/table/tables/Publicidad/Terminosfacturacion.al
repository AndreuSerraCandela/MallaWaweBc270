/// <summary>
/// Table Términos facturación (ID 7010461).
/// </summary>
Table 7001142 "Términos facturación"
{
    DrillDownPageId = "Términos de facturación";
    LookupPageId = "Términos de facturación";

    fields
    {
        field(1; "Código"; Code[10]) { NotBlank = true; }
        field(5; "Descripción"; Text[50]) { }
        field(10; "Nº de plazos"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Plazos de facturación" WHERE("Cód. términos facturación" = FIELD(Código)));
            BlankZero = true;
            Editable = false;
        }
        field(50011; "Código interempreas"; Code[10]) { TableRelation = "Términos facturación".Código; }
        field(60; "Nº de Facturas"; Integer)
        {
            trigger OnValidate()
            var
                Plaz: Record "Plazos de facturación";
            begin
                if Rec."Nº de Facturas" <> 0 then begin
                    Plaz.SetRange("Cód. términos facturación", Rec."Código");
                    Plaz.DeleteAll();
                end;
            end;
        }
        field(75; "Cálculo de Plazos"; DateFormula)
        { }
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
