/// <summary>
/// Table Diario Incidencias Rescursos (ID 7010471).
/// </summary>
table 7001166 "Diario Incidencias Rescursos"
{
    fields
    {
        field(1; "Nº Incidencia"; Integer)
        {
            NotBlank = true;
            //Description =PK 
        }
        field(5; "Fecha"; Date) { }
        field(6; Motivo; Enum "Motivo Incidencia") { }
        field(10; "Cód. Cliente"; Code[20])
        {
            TableRelation = Customer;
            Description = 'FK Cliente';
        }
        field(11; "Nombre Cliente"; Text[100])
        {
            TableRelation = Customer;
            Description = 'FK Cliente';
        }
        field(15; "Nº Proyecto"; Code[20])
        {
            TableRelation = Job;
            Description = 'FK Proyecto';
        }
        field(20; "Cód. fase"; Code[10]) { }
        field(25; "Cód. subfase"; Code[10]) { }
        field(30; "Cód. tarea"; Code[10]) { }
        field(35; "Nº linea proyecto"; Integer) { }
        field(40; "Nº Recurso"; Code[20])
        {
            TableRelation = Resource;
            Description = 'FK Recurso';
        }
        field(45; "Cód. variante"; Code[10])
        {
            TableRelation = "Item Variant".Code;
            //WHERE ("Item No."=FIELD("Nº Incidencia")); 
        }
        field(46; "Incidencia de Bloqueo"; Enum Bloqueo)
        {
            Caption = 'Incidencia de Bloqueo';
        }
        field(47; Vendedor; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            Description = 'Vendedor';
        }

    }
    keys
    {
        //creame una clave por incidencia y fecha
        key(Principal; "Nº Incidencia", "Fecha") { Clustered = true; }
        key(Recurso; "Nº Recurso", "Fecha") { }
    }
}