/// <summary>
/// Table Prevision pagos emplazamientos (ID 7001190).
/// </summary>
table 7001190 "Prevision pagos emplazamientos"
{

    fields
    {
        field(1; "Nº proveedor"; Code[20])
        {
            TableRelation = Vendor;
            trigger OnValidate()
            BEGIN
                //FCL-25/10/04. Incluyo el nombre del proveedor.
                if rProvee.GET("Nº proveedor") THEN
                    "Nombre proveedor" := rProvee.Name;
            END;
        }
        field(2; "Nº emplazamiento"; Code[20])
        {
            // TableRelation = "Emplazamientos proveedores"."Nº Emplazamiento" WHERE("Nº Proveedor" = FIELD("Nº proveedor"));
            // ValidateTableRelation = false;
        }
        field(3; "Periodo pago"; Code[30]) { TableRelation = "Periodos pago emplazamientos"; }
        field(4; "Nº orden"; Decimal) { }
        field(10; "Importe"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(12; "Cód. Divisa"; Code[10])
        {
            TableRelation = Currency;
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(15; "Fecha vencimiento"; Date) { }
        field(20; "Impreso"; Boolean) { }
        field(25; "Fecha impresion"; Date) { }
        field(70; "Importe linea"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
            trigger OnValidate()
            BEGIN
                VALIDATE("% IVA");
                VALIDATE("% IRPF");                         //$001
            END;

        }
        field(71; "% IVA"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                if ("% IVA" = 0) THEN BEGIN
                    IVA := 0;
                END ELSE BEGIN
                    IVA := ROUND(("Importe linea" * "% IVA" / 100), 0.01);
                END;

                //$001(I)
                //VALIDATE (Total,"Importe linea"+IVA);
                VALIDATE(Total, "Importe linea" + IVA - "Importe IRPF");
                //$001(F)
            END;
        }
        field(72; "IVA"; Decimal)
        {
            ; AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(75; "Total"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
            trigger OnValidate()
            BEGIN
                VALIDATE("Importe Total", Total + Gastos);
            END;
        }
        field(76; "Gastos"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
            trigger OnValidate()
            BEGIN
                VALIDATE("Importe Total", Total + Gastos);
            END;
        }
        field(77; "Importe Total"; Decimal)
        {
            ; Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(82; "Cod. Pago"; Code[3]) { }
        field(85; "Mes previsión"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Emplazamientos proveedores"."Mes previsión" WHERE("Nº Proveedor" = FIELD("Nº proveedor"),
                                                                                                                          "Nº Emplazamiento" = FIELD("Nº emplazamiento")));
            Description = 'FCL-06/04';
        }
        field(90; "Anterior"; Boolean) { Description = 'FCL-06/04. Para marcar las previsiones anteriores al proceso automático'; }
        field(100; "No. previsión"; Code[20]) { }
        field(101; "Nombre proveedor"; Text[50]) { Description = 'FCL-25/10/04'; }
        field(102; "Canon Total Periodo"; Decimal) { }
        field(103; "% IRPF"; Decimal)
        {
            Description = '$001';
            trigger OnValidate()
            BEGIN
                if ("% IRPF" = 0) THEN BEGIN
                    "Importe IRPF" := 0;
                END ELSE BEGIN
                    "Importe IRPF" := ROUND(("Importe linea" * "% IRPF" / 100), 0.01);
                END;

                VALIDATE(Total, "Importe linea" + IVA - "Importe IRPF");
            END;


        }
        field(104; "Importe IRPF"; Decimal) {; Description = '$001'; }
    }
    KEYS
    {
        key(P; "Nº proveedor", "Nº emplazamiento", "Periodo pago", "Nº orden")
        {
            SumIndexfields = Importe;
            Clustered = true;
        }
        key(A; "Fecha vencimiento", "Nombre proveedor", "Nº emplazamiento") { }
    }
    VAR
        rEmplazamiento: Record "Emplazamientos proveedores";
        rCnfCom: Record "Purchases & Payables Setup";
        rProvee: Record Vendor;
#if CLEAN24
#pragma warning disable AL0432
        NoSeriesMgt: Codeunit NoSeriesManagement;
#pragma warning restore AL0432
#else
        NoSeriesMgt: Codeunit "No. Series";
#endif

    trigger OnInsert()
    BEGIN
        //$002. Bloqueado
        // {
        // //FCL-17/06/04. Cogeremos una numeración para las previsiones, nº orden será interno.
        // IF"No. previsión" = '' THEN BEGIN
        //   rCnfCom.GET;
        //   rCnfCom.TESTFIELD("Nº serie pagarés");
        //   NoSeriesMgt.InitSeries(rCnfCom."Nº serie pagarés",rCnfCom."Nº serie pagarés",WORKDATE,"No. previsión",rCnfCom."Nº serie pagarés");
        // END;
        // }
    END;

    trigger OnModify()
    BEGIN
        if "Cod. Pago" = '' THEN BEGIN
            if rEmplazamiento.GET("Nº proveedor", "Nº emplazamiento") THEN BEGIN
                "Cod. Pago" := rEmplazamiento."Cod. Pago";
                "Cód. Divisa" := rEmplazamiento."Cód. Divisa";
                MODIFY;
            END;
        END;
    END;

}

