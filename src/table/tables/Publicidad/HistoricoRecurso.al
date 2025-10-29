/// <summary>
/// Table Historico Recurso (ID 7001186).
/// </summary>
table 7001186 "Historico Recurso"
{
    FIELDS
    {
        field(1; "Nº Recurso"; Code[20])
        {
            TableRelation = Resource;
            Description = 'PK,FK Recurso';
        }
        field(5; "Nº linea"; Integer) { }
        field(10; "Fecha"; Date) { }
        field(15; "Hora"; Time) { }
        field(20; "Usuario"; Code[10]) { }
        field(25; "Nº proyecto"; Code[20])
        {
            TableRelation = Job;
            Description = 'FK Proyecto';
        }
        field(30; "Cód. fase"; Code[10])
        {//TableRelation=Table161;
            Description = 'FK Fase';
        }
        field(35; "Cód. subfase"; Code[10])
        {//;TableRelation=Table162;
            Description = 'FK Subfase';
        }
        field(40; "Cód. tarea"; Code[10])
        {//TableRelation=Table163;
            Description = 'FK Tarea';
        }
        //field(45  ;No ;Estado anterior     ;Option        ;OptionString=Libre,Reservado,Ocupado }
        //field(50  ;No ;Estado posterior    ;Option        ;OptionString=Libre,Reservado,Ocupado }
        field(55; "Nº Reserva"; Integer)
        {
            TableRelation = Reserva;
            Description = 'FK Reserva';
        }
        field(60; "Fecha inicio"; Date) { }
        field(65; "Fecha fin"; Date) { }
        field(70; "Estado Reserva"; Enum "Estado Reserva") { }
    }
    KEYS
    {
        Key(P; "Nº Recurso", "Nº linea") { Clustered = true; }
        Key(A; "Nº Reserva") { }
        Key(B; Fecha) { }
    }

}