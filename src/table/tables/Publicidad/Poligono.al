/// <summary>
/// Table Poligono (ID 50000).
/// </summary>
table 50000 Poligono
{


    fields
    {
        field(1; "Zona"; Code[10]) { }
        field(2; "PuntoX"; Decimal) { DecimalPlaces = 8 : 8; }
        field(3; "PuntoY"; Decimal) { DecimalPlaces = 8 : 8; }
        field(4; "Secuencia"; Integer) { }
    }
    KEYS
    {
        Key(P; Secuencia) { Clustered = true; }
    }

}
// table 50028 "Configuración Grupo Empresas"
// {
//     DataPerCompany = false;
//     fields
//     {
//         field(1; "IC Socio Org./Des."; Code[20]) { TableRelation = "IC Partner".Code; }
//         field(2; "IC Socio Des./Org."; Code[20]) { TableRelation = "IC Partner".Code; }
//         field(3; "IC Socio Último Intermedio"; Code[20]) { TableRelation = "IC Partner".Code; }
//         field(4; "Código Apunte"; Code[20]) { }
//     }
//     KEYS
//     {
//         key(P; "Código Apunte", "IC Socio Org./Des.", "IC Socio Des./Org.")
//         {
//             Clustered = true;
//         }
//     }

// }


