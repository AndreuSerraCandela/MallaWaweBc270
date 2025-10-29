/// <summary>
/// Table TMP Movs. Retenciones (ID 7001166).
/// </summary>

table 7001167 "TMP Grupos Retenciones"
{

    DataPerCompany = false;
    //CaptionML=[ENU=Grupo retencion;
    Caption = 'Grupo retención';

    FIELDS
    {
        field(1; Code; Code[20])
        {        ////CaptionML=[ENU=Code;
            Caption = 'Código';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {        ////CaptionML=[ENU=Description;
            Caption = 'Descripción';
        }
        field(3; "Porcentaje retencion"; Decimal)
        {//CaptionML=[ENU=Porcentaje retencion;
            Caption = 'Porcentaje retención';
        }
        field(4; "Plazo de garantia"; DateFormula)
        {  ////CaptionML=[ENU=Plazo de garantia;
            Caption = 'Plazo de garantía';
        }
        field(5; "Cuenta de retenciones"; Code[20])
        {       ////CaptionML=[ENU=Cuenta de retenciones;
            Caption = 'Cuenta de retenciones';
        }
        field(6; "Tipo retencion"; Option)
        {////CaptionML=[ENU="Tipo retencion";
            Caption = 'Tipo retención';
            OptionMembers = "B.E",IRPF;
        }
        field(7; "Base de retencion"; Option)
        {////CaptionML=[ENU=Base de retencion;
            Caption = 'Base de retención';
            OptionMembers = "Importe factura","Importe IVA incluido";
        }
        field(8; "Tratamiento de retencion"; Option)
        {   ////CaptionML=[ENU=Tratamiento de retencion;
            Caption = 'Tratamiento de retención';
            OptionMembers = "Retención de Pago","Pte. Factura";
        }
        field(9; "Grupo IVA producto retenc."; Code[10])
        { ////CaptionML=[ENU=Grupo IVA producto retenc.;
            Caption = 'Grupo IVA producto retenc.';
        }
        field(10; "Tipo estimacion"; Option)
        {////CaptionML=[ENU=Tipo estimacion;
            Caption = 'Tipo estimación';
            //OptionCaptionML=[ENU=" ,Por módulos";
            OptionCaption = ' ,Por módulos';
            OptionMembers = " ","Por módulos";
        }
        field(50000; Empresa; Text[30]) {; TableRelation = Company; }
        // field(50001; Registros; Integer)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = Count("TMP Movs. Retenciones" WHERE(Empresa = FIELD(Empresa),
        //         "Tipo retencion" = FIELD("Tipo retencion"),
        //         "Codigo retencion" = FIELD(Code)));
        //     Editable = false;
        // }
    }
    KEYS
    {
        key(Pk; Empresa, "Tipo retencion", Code)
        {
            Clustered = true;
        }
    }
    FIELDGROUPS
    {
    }

    VAR
        Text000: Label 'La cuenta debe ser auxiliar';
        Text001: Label '"Cuando el tipo de Retencion es %1, la Base de rentencion solo puede ser Importe Factura "';
        Text002: Label 'Cuando el tipo de Retencion es %1, el Tratamiento de Retencion solo puede ser Retencion de Pago';

}
