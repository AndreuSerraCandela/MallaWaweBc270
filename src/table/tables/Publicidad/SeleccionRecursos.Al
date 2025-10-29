/// <summary>
/// Table SeleccionRecursos (ID 7001154).
/// </summary>
table 7001154 SeleccionRecursos
{
    DataPerCompany = false;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

        }

        field(3; Name; Text[100])
        {
            Caption = 'Name';

        }

        field(50001; "Categoria"; Enum "Categoria")
        {
            InitValue = " ";

        }
        field(50003; "Tipo Recurso"; Code[10])
        {
            TableRelation = "Tipo Recurso";

            //Description=FK Tipo Recurso 
        }

        field(50030; "Prohibiciones"; Text[50])
        {
        }
        field(50031; "Tiene Prohibiciones"; Boolean) { Editable = false; }
        field(50048; "Empresa"; Text[1024]) { }
        field(51025; "Customer Price Group"; Code[10])
        {
            TableRelation = "Customer Price Group";
            Caption = 'Categoría Tarifa';
        }
        field(51026; "Activo"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Fixed Asset"."No." WHERE(Recurso = FIELD("No.")));
        }
        field(51027; "Seleccionar"; Boolean) { }
        field(51028; "Alquiler Anual"; Decimal) { }
        field(51029; "Local - Alquiler 7 Meses"; Decimal) { }
        field(51030; "Nacional - Alquiler Anual"; Decimal) { }
        field(51031; "Nacional - Alquiler 7 Meses"; Decimal) { }
        field(51023; "PuntoX"; Decimal) {; DecimalPlaces = 8 : 8; }
        field(51024; "PuntoY"; Decimal) {; DecimalPlaces = 8 : 8; }
        field(50008; "Medidas"; Code[20]) { TableRelation = Medidas; }
        field(50009; Image; Media) { }
        field(50010; UserId; Text[30]) { }
        field(50011; Municipio; Code[15]) { }

    }

    keys
    {
        key(Key1; "No.", Empresa, UserId)
        {
            Clustered = true;
        }
        key(Empresa; Empresa, "Tipo Recurso", Municipio)
        {
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Tipo Recurso")
        {
        }
        fieldgroup(Brick; "No.", Name, "Tipo Recurso")
        {
        }
    }

}