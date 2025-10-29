/// <summary>
/// Table Conciliacion cuenta (ID 7010454).
/// </summary>
Table 7001104 "Conciliacion cuenta"
{


    fields
    {
        field(1; "Nº"; Integer)
        {
            Editable = false;
        }
        field(3; Comentario; Text[50])
        { }
        field(5; Usuario; Code[50])
        {
            TableRelation = User;
        }
        field(7; Fecha; Date) { }
        field(9; Hora; Time) { }
    }
    keys
    {
        Key(N; "Nº")
        {

            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        rMovCon: Record "Mov. Conciliacion cuenta";
    BEGIN
        rMovCon.RESET;
        rMovCon.SETRANGE("Nº Conciliacion", "Nº");
        if rMovCon.FIND('-') THEN
            rMovCon.DELETEALL;
    END;


}
