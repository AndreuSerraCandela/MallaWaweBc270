/// <summary>
/// Table Seccion publicidad (ID 7001175).
/// </summary>
table 7001175 "Seccion publicidad"
{
    DataCaptionfields = "Cód. seccion";
    Caption = 'Sección publicidad';
    fields
    {
        field(1; "Cód. seccion"; Code[20]) { Caption = 'Código sección'; }
        field(2; "Descripcion"; Text[60]) { Caption = 'Descripción'; }
    }
    KEYS
    {
        key(P; "Cód. seccion") { Clustered = true; }
    }
}

