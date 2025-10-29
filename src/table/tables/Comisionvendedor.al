/// <summary>
/// Table Comision vendedor/programa (ID 7001179).
/// </summary>
table 7001179 "Comision vendedor/programa"
{
    fields
    {
        field(1; "Cód. Vendedor"; Code[10]) { TableRelation = "Salesperson/Purchaser".Code; }
        field(2; "Cód. Programa"; Code[30]) { TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2)); }
        field(3; "% comisión"; Decimal) { }
        field(50004; "Cód. Principal"; Code[10]) { TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3)); }
    }
    KEYS
    {
        key(P; "Cód. Vendedor", "Cód. Programa", "Cód. Principal")
        {
            Clustered = true;
        }
        key(A; "Cód. Vendedor", "Cód. Principal") { }
    }
}
