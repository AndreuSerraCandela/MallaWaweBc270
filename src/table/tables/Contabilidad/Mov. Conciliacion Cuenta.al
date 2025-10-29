/// <summary>
/// Table Mov. Conciliacion cuenta (ID 7010453).
/// </summary>
table 7001103 "Mov. Conciliacion cuenta"
{

    fields
    {
        field(3; "Nº Mov."; Integer)
        {
            TableRelation = "G/L Entry";
            trigger OnLookup()
            var
                rMov: Record "G/L Entry";
            BEGIN
                rMov.RESET;
                if rMov.GET("Nº Mov.") THEN BEGIN
                    rMov.SETRECFILTER;
                    Page.RUNMODAL(Page::"General Ledger Entries", rMov);
                END;
            END;
        }
        field(5; "Nº Conciliacion"; Integer)
        {
            TableRelation = "Conciliacion cuenta";
        }
        field(7; "Importe conciliado"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(8; "Importe a conciliar"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(11; "Nº cuenta"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(13; "Fecha conciliacion"; Date)
        { }
    }
    KEYS
    {
        key(Mov; "Nº Mov.", "Nº Conciliacion")
        {
            SumIndexFields = "Importe conciliado";
            Clustered = true;
        }
        key(Cuenta; "Nº cuenta") { SumIndexFields = "Importe conciliado"; }
        key(Fecha; "Fecha conciliacion") { SumIndexFields = "Importe conciliado"; }
    }

}