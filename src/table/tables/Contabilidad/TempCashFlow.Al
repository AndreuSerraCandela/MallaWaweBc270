/// <summary>
/// Table Temp Cash Flow Account (ID 7010483).
/// </summary>
table 7001204 "Temp Cash Flow Account"
{
    Caption = 'Cash Flow Account';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Cash Flow Account List";
    LookupPageID = "Cash Flow Account List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';


        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(4; "Account Type"; Enum "Cash Flow Account Type")
        {
            Caption = 'Account Type';
        }
        field(5; Comment; Boolean)
        {
            CalcFormula = Exist("Cash Flow Account Comment" WHERE("Table Name" = CONST("Cash Flow Account"),
                                                                   "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(7; "New Page"; Boolean)
        {
            Caption = 'New Page';
        }
        field(8; "No. of Blank Lines"; Integer)
        {
            Caption = 'No. of Blank Lines';
            MinValue = 0;
        }
        field(9; Indentation; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;


        }
        field(10; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(11; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(12; "Cash Flow Forecast Filter"; Code[20])
        {
            Caption = 'Cash Flow Forecast Filter';
            FieldClass = FlowFilter;
            TableRelation = "Cash Flow Forecast";
        }

        field(34; Totaling; Text[250])
        {
            Caption = 'Totaling';
            TableRelation = "Cash Flow Account";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

        }
        field(35; "Source Type"; Enum "Cash Flow Source Type")
        {
            Caption = 'Source Type';
        }
        field(36; "G/L Integration"; Option)
        {
            Caption = 'G/L Integration';
            OptionCaption = ' ,Balance,Budget,Both';
            OptionMembers = " ",Balance,Budget,Both;
        }
        field(50008; "Cód Prestamo"; CODE[100]) { }
        field(50009; "Banco Informes"; TEXT[30]) { }
        field(50010; "Solo Cartera"; Boolean) { }
        field(50011; "Empresa"; TEXT[30]) { }
        field(50012; "Cód. Proveedor"; CODE[20]) { }
        field(50013; "Cód. Cliente"; CODE[20]) { }
        field(50014; "Calcular vto Cuenta"; CODE[1]) { }
        field(50015; "Dias Liquidación HASTA"; DateFormula) { }
        field(50016; "Debe/Haber"; Option)
        {
            OptionMembers = " ",Debe,Haber,Ambos;
            trigger OnValidate()
            var
                deve: Option ,Debe,Haber,Ambos;
            begin
                "Debe/Haber" := "Debe/Haber"::" ";
            end;
        }
        field(50017; "Solo Atrasados"; Boolean) { }
        field(50018; "Valoracion"; Integer) { }
        field(50019; "Dias Liquidación DESDE;DateFormula"; DateFormula)
        {
            ObsoleteState = Removed;
            Caption = 'Dias Liquidación DESDE';
        }
        field(50020; "Desglosar"; Boolean) { }
        field(50021; "Vinculado a noº"; CODE[20]) { }
        field(50022; "Dia de pago"; DateFormula) { }
        field(50023; "Tipo Saldo"; Option) { OptionMembers = "Saldo a la fecha","Saldo periodo"; }
        field(50024; "Vto Resto Año"; DateFormula) { Caption = 'Vto Resto Año'; }
        field(50025; "Vto enero"; DateFormula) { }
        field(50026; "Pago Impuestos"; Boolean) { }
        field(50027; "Dias Liquidación DESDE"; DateFormula) { Caption = 'Dias Liquidación DESDE'; }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Valoracion)
        {
        }
    }

}