/// <summary>
/// Table Intercambio x Empresa (ID 7001119).
/// </summary>
table 7001119 "Intercambio x Empresa"
{

    DataPerCompany = false;

    fields
    {
        field(1; "Código Intercambio"; Code[20]) { TableRelation = Intercambio; }
        field(2; "Empresa"; Text[30]) { TableRelation = Company.Name; }
        field(3; "Cliente"; Code[20])
        {
            TableRelation = Customer;
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                Customer: Record Customer;
            begin
                Customer.ChangeCompany(Empresa);
                if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then
                    "Cliente" := Customer."No.";
            end;
        }
        field(4; "Proveedor"; Code[20])
        {
            TableRelation = Vendor;
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                Vendor: Record Vendor;
            begin
                Vendor.ChangeCompany(Empresa);
                if Page.RunModal(Page::"Vendor List", Vendor) = Action::LookupOK then
                    "Proveedor" := Vendor."No.";
            end;
        }
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
        field(58; "Search Namev"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Intercambio."Search Name" WHERE("No." = FIELD("Código Intercambio")));
            TableRelation = Intercambio;
            Caption = 'Alias';
        }
        field(39; "Blocked"; Enum "Customer Blocked")
        {

        }
    }

    KEYS
    {
        key(P; "Código Intercambio", Empresa) { Clustered = true; }
    }

}

