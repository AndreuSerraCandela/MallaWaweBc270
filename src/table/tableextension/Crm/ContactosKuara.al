/// <summary>
/// TableExtension ContactosKuara (ID 80111) extends Record Contact.
/// </summary>
tableextension 80111 ContactosKuara extends Contact
{
    fields
    {
        field(80100; "Objeto Social"; Text[80])
        {
            Caption = 'Objeto Social';
            DataClassification = ToBeClassified;
        }
        field(80101; "Persona de Contacto"; Text[250])
        {
            Caption = 'Persona de Contacto';
            DataClassification = ToBeClassified;
        }
        field(80102; COD; Code[10])
        {
            Caption = 'COD';
            DataClassification = ToBeClassified;
        }
        field(80103; Empresa; Text[50])
        {
            Caption = 'Empresa';
            DataClassification = ToBeClassified;
        }
        field(80104; "Inversión"; Decimal)
        {
            Caption = 'Inversión';
            DataClassification = ToBeClassified;
        }
        field(80105; "Provabilidad de Firma"; Decimal)
        {
            Caption = 'Provabilidad de Firma';
            DataClassification = ToBeClassified;
        }
        field(80106; "Fecha Firma"; Date)
        {
            Caption = 'Fecha Firma';
            DataClassification = ToBeClassified;
        }
        field(80107; "Tipo de Asignacion"; Text[250])
        {
            Caption = 'Tipo de Asignacion';
            DataClassification = ToBeClassified;
        }
        field(80108; "Tipo de Soporte"; Enum "Tipo de Soporte")
        {

            Caption = 'Tipo de Soporte';
            DataClassification = ToBeClassified;
        }
        field(80109; "Tipo de Contratacion"; Enum "Tipo de Contratacion")
        {
            Caption = 'Tipo de Contratacion';
            DataClassification = ToBeClassified;
        }
        field(80110; "Tipo de Campaña"; Enum "Tipo de Campaña")
        {
            Caption = 'Tipo de Campaña';
            DataClassification = ToBeClassified;
        }
        field(80111; "Zona Comercial"; Code[20])
        {
            Caption = 'Zona Comercial';
            DataClassification = ToBeClassified;
            TableRelation = "Zonas comerciales";
        }
        field(80112; "Zona Recurso"; Code[20])
        {
            Caption = 'Zona Recurso';
            DataClassification = ToBeClassified;
            TableRelation = "Zonas Recursos";
        }
        field(80113; Firmante; Boolean)
        {
            trigger OnValidate()
            var
                Inf: Record "Sales & Receivables Setup";
            begin

                TestField(Type, Type::Person);
                Rec."Tipo firma" := Rec."Tipo firma"::emailandsms;
                Inf.Get;
                Rec.posKey := Inf.posKey2;
                //if Confirm('¿Desea que el contacto pueda firmar Sepa?', true) Then
                Rec."Firmante Sepa" := True;
            end;
        }
        field(80014; "Tipo firma"; enum TiposFirma)
        { }
        field(90002; posKey; Text[30]) { }
        field(90003; "Firmante Sepa"; Boolean)
        {
            trigger OnValidate()
            begin
                TestField(Type, Type::Person);
            end;
        }
        field(80050; Iban; Text[50])
        { }
        field(80051; "Prefijo Móvil"; Text[10])
        { }
        field(60019; "Nombre Comercial"; Text[250])
        {
            Caption = 'Anunciante';
            TableRelation = "Nombre Comercial".Nombre;
            trigger OnValidate()
            var
                Customer: Record "CUstomer";
                contbusrel: Record "Contact Business Relation";
            begin
                if not Customer.WritePermission() then exit;
                If Not contbusrel.ReadPermission() then exit;
                ContBusRel.SetCurrentKey("Link to Table", "No.");
                ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::Customer);
                ContBusRel.SetRange("Contact No.", "No.");
                if ContBusRel.FindFirst() then begin
                    Customer.Get(ContBusRel."No.");
                    Customer."Nombre Comercial" := Rec."Nombre Comercial";
                    Customer.Modify();

                end;
            end;
        }
    }
}
