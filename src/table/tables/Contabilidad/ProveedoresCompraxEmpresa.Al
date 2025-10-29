/// <summary>
/// Table Proveedores x Empresa (ID 7001117).
/// </summary>
table 7001117 "Proveedores x Empresa"
{

    DataPerCompany = false;

    fields
    {
        field(1; "Código Proveedor"; Code[20]) { TableRelation = "Proveedores Compra"; }
        field(2; "Empresa"; Text[30]) { TableRelation = Company.Name; }
        field(3; "Cliente"; Code[20]) { TableRelation = Customer; }
        field(4; "Proveedor"; Code[20]) { TableRelation = Vendor; }
        field(5; "Saldo Cliente"; Decimal) { }
        field(6; "Saldo Proveedor"; Decimal) { }
        field(7; "Contrato sin facturar"; Decimal) { }
        field(8; "Albaranes sin facturar"; Decimal) { }
        field(9; "Saldo"; Decimal) { }
        field(10; "Pedidos pendientes"; Decimal) { }
        field(55; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Filtro fecha';
        }
        field(56; "Desde"; Date) { }
        field(57; "Hasta"; Date) { }
        // field(58; "Search Namev"; Code[50])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = Lookup(Intercambio."Search Name" WHERE("No." = FIELD("Código Intercambio")));
        //     TableRelation = Intercambio;
        //     Caption = 'Search Name', ESP = 'Alias';
        // }
    }

    KEYS
    {
        key(P; "Código Proveedor", Empresa) { Clustered = true; }
    }

}