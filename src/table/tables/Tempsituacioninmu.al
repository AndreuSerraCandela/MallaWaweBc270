/// <summary>
/// Table Temp. situación inmueble SII (ID 7001146).
/// </summary>
table 7001146 "Temp. situación inmueble SII"
{
    fields
    {
        field(1; "Situación inmueble"; Code[10]) { }
        field(2; "Ref. catastral"; Text[30]) { }
    }
    KEYS
    {
        key(P; "Situación inmueble") { Clustered = true; }
    }
}
