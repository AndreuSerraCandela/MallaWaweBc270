/// <summary>
/// Table Relación Hoteles (ID 50007).
/// </summary>
table 50007 "Relación Hoteles"
{
    fields
    {
        field(1; "Hotel"; Code[20])
        {
            //TableRelation=Hoteles;
            trigger OnLookup()
            BEGIN
                r349.SETRANGE(r349."Dimension Code", 'DEPARTAMENTO');
                if r349.GET('DEPARTAMENTO', Hotel) THEN;
                if Page.RUNMODAL(537, r349) = ACTION::LookupOK THEN
                    Hotel := r349.Code;
            END;
        }
        field(2; "Bloquear General"; Boolean) { }
        field(3; "Sección Diario"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = CONST('GENERAL'));
        }
        field(4; "Serie Compras"; Code[20]) { TableRelation = "No. Series".Code; }
        field(5; "Serie Ventas"; Code[20]) { TableRelation = "No. Series".Code; }
        field(6; "Bloquear Compras"; Boolean) { }
        field(7; "Bloquear Ventas"; Boolean) { }
        field(8; "Sección Diario Compras"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = CONST('GENERAL'));
        }
    }
    KEYS
    {
        Key(P; Hotel) { Clustered = true; }
    }
    var
        r349: Record 349;

}
