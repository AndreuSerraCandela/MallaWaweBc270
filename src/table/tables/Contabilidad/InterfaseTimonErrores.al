
table 7001111 "Interfase Timon Errores"
{
    fields
    {
        field(1; "Opcion Diario"; Enum "Opcion Diarios")
        {

        }
        field(2; "Número Linea"; Integer) { }
        field(4; "Tipo Documento"; Enum "Tipo Documento Timon")
        {

        }
        field(7; "Nº Documento"; Code[20]) { }
        field(8; "Descripción Error"; Text[50]) { }
        field(27; "Secuencia"; Integer) { }
        field(28; "Secuencia Error"; Integer) { }
        field(29; "Secuencia Incremental"; Integer) { }
    }
    KEYS
    {
        Key(P; "Opcion Diario", "Tipo Documento", "Nº Documento", "Número Linea", "Secuencia Incremental", "Secuencia Error")
        {
            Clustered = true;
        }
        Key(S; "Secuencia Incremental") { }
        Key(O; "Opcion Diario", "Nº Documento", "Número Linea") { }
        Key(SS; Secuencia) { }
    }

}
