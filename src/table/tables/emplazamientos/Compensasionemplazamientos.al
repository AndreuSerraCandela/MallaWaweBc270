/// <summary>
/// Table Compensaciones emplazamientos (ID 7010485).
/// </summary>
table 7001206 "Compensaciones emplazamientos"
{


    fields
    {
        field(1; "Nº proveedor"; Code[20]) { TableRelation = Vendor; }
        field(2; "Nº emplazamiento"; Code[20])
        {
            // TableRelation = "Emplazamientos proveedores"."Nº Emplazamiento" WHERE("Nº Proveedor" = FIELD("Nº proveedor"));
            SqlDataType = Varchar;
        }
        field(3; "No. compensacion"; Integer) { Caption = 'Nº compensación'; }
        field(4; "Accion"; Code[5]) { Caption = 'Acción'; }
        field(5; "Fecha creacion"; Date) { Caption = 'Fecha creación'; }
        field(6; "Tamaño"; Text[20]) { }
        field(7; "Tipo"; Text[30]) { }
        field(8; "Motivo"; Text[30]) { }
        field(9; "Fecha instalacion"; Date) { Caption = 'Fecha instalación'; }
        field(10; "Observaciones"; Text[100]) { }
        field(11; "Nº Recurso"; Code[20]) { TableRelation = Resource."No."; }
        field(12; "Fecha Retirada"; Date) { }
    }
    KEYS
    {
        key(P; "Nº proveedor", "Nº emplazamiento", Accion, "No. compensacion")
        {
            Clustered = true;
        }
        key(R; "Nº Recurso", "Fecha instalacion", Accion) { }
    }
    Var
        rCompEmp: Record "Compensaciones emplazamientos";

    trigger OnInsert()
    BEGIN
        rCompEmp.RESET;
        rCompEmp.SETRANGE("Nº proveedor", "Nº proveedor");
        rCompEmp.SETRANGE("Nº emplazamiento", "Nº emplazamiento");
        rCompEmp.SETRANGE(Accion, Accion);
        if rCompEmp.FIND('+') THEN BEGIN
            "No. compensacion" := rCompEmp."No. compensacion" + 10;
        END
        ELSE BEGIN
            "No. compensacion" := 10;
        END;
    END;

}

