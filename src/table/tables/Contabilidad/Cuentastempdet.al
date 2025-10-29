/// <summary>
/// Table Cuentas temp det (ID 7010475).
/// </summary>
table 7001189 "Cuentas temp det"
{
    fields
    {
        field(1; "Cuenta"; Text[30]) { TableRelation = "G/L Account"."No."; }
        field(2; "Contrato"; Code[20]) { }
        field(3; "Saldo"; Decimal) { }
    }
    KEYS
    {
        key(P; Cuenta, Contrato)
        {
            SumIndexfields = Saldo;
            Clustered = true;
        }
    }

}

