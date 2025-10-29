/// <summary>
/// Table Dias Pago y terminos (ID 7001168).
/// </summary>
table 7001168 "Dias Pago y terminos"
{
    fields
    {
        field(1; "Cliente"; Code[20]) { }
        field(2; "Dia1"; Integer) { }
        field(3; "dia2"; Integer) { }
        field(4; "dia3"; Integer) { }
        field(5; "diaspago1"; Integer) { }
        field(6; "diaspago2"; Integer) { }
        field(7; "dia4"; Integer) { }
        field(8; "dia5"; Integer) { }
        field(9; "dia6"; Integer) { }
        field(10; "dia7"; Integer) { }
        field(11; "dia8"; Integer) { }
        field(12; "dia9"; Integer) { }
        field(13; "dia10"; Integer) { }
        field(14; "dia11"; Integer) { }
        field(15; "dia12"; Integer) { }
        field(16; "ccc"; Text[30]) { }
        field(17; "ccc1"; Text[30]) { }
        field(18; "ccc2"; Text[30]) { }
        field(19; "ccc3"; Text[30]) { }
    }
    KEYS
    {
        key(P; Cliente) { Clustered = true; }
    }

}

