/// <summary>
/// Table Planificación Fijación (ID 50100).
/// Planificación semanal de fijaciones por proyecto (origen para informes de fijación).
/// </summary>
table 50016 "Planificación Fijación"
{
    Caption = 'Planificación Fijación';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Nº mov.';
            AutoIncrement = true;
        }
        field(10; "Nº Recurso"; Code[20])
        {
            Caption = 'Nº recurso';
            TableRelation = Resource;
        }
        field(15; "Fecha generación"; Date)
        {
            Caption = 'Fecha generación';
        }
        field(20; "Fecha fijación"; Date)
        {
            Caption = 'Fecha fijación';
        }
        field(25; Operario; Code[20])
        {
            Caption = 'Operario';
            TableRelation = Employee;
        }
        field(30; "Nº Proyecto"; Code[20])
        {
            Caption = 'Nº proyecto';
            TableRelation = Job;
        }
        field(35; Fijar; Text[30])
        {
            Caption = 'Fijar';
        }
        field(40; Tapar; Text[30])
        {
            Caption = 'Tapar';
        }
        field(45; Foto; Boolean)
        {
            Caption = 'Foto';
        }
        field(50; Validado; Boolean)
        {
            Caption = 'Validado';
            InitValue = true;
        }
        field(55; Zona; Code[20])
        {
            Caption = 'Zona';
            TableRelation = "Zonas Recursos";
        }
        field(56; "Tipo de Campaña"; Enum "Tipo de Movimiento")
        {
            Caption = 'Tipo de Campaña';
        }
        field(57; "Tipo Campaña"; Enum "Tipo de Campaña Fijacion")
        {
            Caption = 'Tipo Campaña';
        }
        field(58; "SalesPerson Code"; Code[20])
        {
            Caption = 'Cód. comercial';
            TableRelation = "Salesperson/Purchaser";
        }
        field(59; "Nombre Comercial"; Text[250])
        {
            Caption = 'Anunciante';
            TableRelation = "Nombre Comercial".Nombre;
        }
        field(60; Grupo; Code[20])
        {
            Caption = 'Grupo';
            TableRelation = Customer."No.";
        }
        field(61; "Fecha Retirada"; Date)
        {
            Caption = 'Fecha retirada';
        }
        field(63; "No. Opis"; Integer)
        {
            Caption = 'Nº Opis';
        }
        field(64; Nombre; Text[250])
        {
            Caption = 'Nombre';
        }
        field(65; "Tipo Soporte"; Option)
        {
            Caption = 'Tipo soporte';
            OptionMembers = " ",Opis,Vallas,"Vallas Peatones",Indicadores;
            OptionCaption = ' ,Opis,Vallas,Vallas Peatones,Indicadores';
        }
        field(66; "No. Soportes"; Integer)
        {
            Caption = 'Nº soportes';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(ProyectoFecha; "Nº Proyecto", "Fecha fijación", "Tipo Soporte")
        {
        }
    }
}
