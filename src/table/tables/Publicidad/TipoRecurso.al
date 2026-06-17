/// <summary>
/// Table Tipo Recurso (ID 7010451).
/// </summary>
table 7001101 "Tipo Recurso"
{
    Caption = 'Tipo Recurso';
    DataClassification = ToBeClassified;
    LookupPageId = "Tabla Tipo Recurso";
    DrillDownPageId = "Tabla Tipo Recurso";
    fields
    {
        field(1; Tipo; Code[10])
        {
            Caption = 'Tipo';
            DataClassification = ToBeClassified;
        }
        field(2; "Descripción"; Text[30])
        {
            Caption = 'Descripción';
            DataClassification = ToBeClassified;
        }
        field(3; "Cód. Departamento"; Code[20])
        {
            Caption = 'Cód. Departamento';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; Exterior; Boolean)
        {
            Caption = 'Exterior';
            DataClassification = ToBeClassified;
        }
        field(5; "Crea Reservas"; Boolean)
        {
            Caption = 'Crea Reservas';
            DataClassification = ToBeClassified;
        }
        field(6; "Cód. Principal"; Code[20])
        {
            Caption = 'Cód. Principal';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(7; "Asociar a emplazamiento"; Boolean)
        {
            Caption = 'Asociar a emplazamiento';
            DataClassification = ToBeClassified;
        }
        field(8; "Ruta Imagenes"; Text[1024]) { }
        //Añade Gen. Prod Posting Group y Vat Prod Posting Group
        field(9; "Vat Prod. Posting Group"; Code[10])
        {
            Caption = 'Grupo IVA';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(10; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Grupo Contable';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(11; "% Dto. Compra"; Decimal)
        {
            Caption = '% Dto. Compra';
            DataClassification = ToBeClassified;
        }
        field(12; "Tiene Medidas"; Boolean)
        {
            Caption = 'Tiene Medidas';
            DataClassification = ToBeClassified;
        }
        field(13; "Ocultar Tipo Recurso"; Boolean)
        {
            Caption = 'Ocultar Tipo Recurso';
            DataClassification = ToBeClassified;
        }
        //Tipo Comun
        field(14; "Tipo Comun"; Code[20])
        {
            Caption = 'Tipo Comun';
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                TipoRecurso: Record "Tipo Recurso";
            BEGIN
                //Busca especificamente en la empresa Malla Publicidad
                TipoRecurso.ChangeCompany('Malla Publicidad');
                if Page.RunModal(Page::"Tabla Tipo Recurso", TipoRecurso) in [Action::LookupOK, Action::OK] THEN
                    Rec.VALIDATE("Tipo Comun", TipoRecurso.Tipo);
            END;

            trigger OnValidate()
            var
                TipoRecurso: Record "Tipo Recurso";
                Empresas: record Company;
            BEGIN
                //Busca especificamente en la empresa Malla Publicidad
                TipoRecurso.ChangeCompany('Malla Publicidad');
                If xRec."Tipo Comun" = '' Then
                    If Not TipoRecurso.Get(Rec."Tipo Comun") then
                        ERROR('El Tipo Comun debe existir como Tipo en Malla Publicidad, una vez ceado, puede modificarlo');
                if empresas.findset then
                    repeat
                        TipoRecurso.changecompany(empresas.name);
                        TipoRecurso.SetRange("Tipo Comun", xRec."Tipo Comun");
                        TipoRecurso.ModifyAll("Tipo Comun", Rec."Tipo Comun");
                    until empresas.next = 0;
            END;
        }
    }
    keys
    {
        key(PK; Tipo)
        {
            Clustered = true;
        }
    }

}
