/// <summary>
/// Table Dias tarifa publicidad (ID 7001133).
/// </summary>
table 7001133 "Dias tarifa publicidad"
{
    fields
    {
        field(1; "Cod. Soporte"; Code[20]) { TableRelation = Vendor WHERE(Soporte = CONST(true)); }
        field(2; "Codigo"; Code[10]) { Caption = 'Código'; }
        field(3; "Descripcion"; Text[30]) { Caption = 'Descripción'; }
        field(4; "Lunes"; Boolean) { Caption = 'Lunes'; }
        field(5; "Martes"; Boolean) { Caption = 'Martes'; }
        field(6; "Miercoles"; Boolean) { Caption = 'Miercoles'; }
        field(7; "Jueves"; Boolean) { Caption = 'Jueves'; }
        field(8; "Viernes"; Boolean) { Caption = 'Viernes'; }
        field(9; "Sabado"; Boolean) { Caption = 'Sabado'; }
        field(10; "Domingo"; Boolean) { Caption = 'Domingo'; }
        field(11; "Conjunto"; Boolean) { Caption = 'Conjunto'; }
        field(12; "Festivos"; Boolean) { }
        field(20; "Seccion"; Code[20])
        {
            TableRelation = "Seccion publicidad"."Cód. seccion";
            Caption = 'Sección';
        }
    }
    KEYS
    {
        key(P; "Cod. Soporte", Codigo, Seccion) { Clustered = true; }
    }
    VAR
        rLinTarifas: Record "Price List Line";

    trigger OnDelete()
    BEGIN
        rLinTarifas.RESET;
        rLinTarifas.SetRange("Source Type", rLinTarifas."Source Type"::Vendor);
        rLinTarifas.SETRANGE("Source No.", "Cod. Soporte");
        rLinTarifas.SETRANGE("Dia tarifa", Codigo);
        if rLinTarifas.FIND('-') THEN
            rLinTarifas.DELETEALL;
    END;
}

