/// <summary>
/// Table Cuentas temp (ID 7010477).
/// </summary>
table 7001200 "Cuentas temp"
{

    fields
    {
        field(1; "Cuenta"; Code[20]) { TableRelation = "G/L Account"."No."; }
        field(2; "Nombre"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Account".Name WHERE("No." = FIELD(Cuenta)));
        }
    }
    KEYS
    {
        key(P; Cuenta) { Clustered = true; }
    }

}

