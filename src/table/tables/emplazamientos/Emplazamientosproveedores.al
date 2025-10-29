/// <summary>
/// Table Emplazamientos proveedores (ID 7010457).
/// </summary>
table 7001107 "Emplazamientos proveedores"
{

    fields
    {
        field(1; "Nº Proveedor"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(5; "Nº Emplazamiento"; Code[20])
        {
            // TableRelation = "Emplazamientos proveedores"."Nº Emplazamiento" WHERE("Nº Proveedor" = FIELD("Nº Proveedor"));
            // ValidateTableRelation = false;
            // NotBlank = true;
        }
        field(10; "Descripción"; Text[50]) { }
        field(12; "Municipio emplazamiento"; Code[15]) { }
        field(13; "Zona"; Text[20]) { }
        field(15; "Contratado"; text[30]) { }
        field(20; "Observaciones"; Text[250]) { }
        field(35; "Suelo"; Enum "Suelo") { }
        field(40; "Periodo pago"; Code[30])
        {
            TableRelation = "Periodos pago emplazamientos";
        }
        field(45; "Total pago periodo"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos"."Importe total" WHERE("Nº proveedor" = FIELD("Nº Proveedor"),
                                                                    "Nº emplazamiento" = FIELD("Nº Emplazamiento"),
                                                                    "Periodo Pago" = FIELD("Periodo pago")));
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(50; "Total prevision"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(55; "Fecha previsión"; Date)
        {
            trigger OnValidate()
            BEGIN

                //FCL-03/06/04
                if "Fecha previsión" <> 0D THEN BEGIN
                    "Mes previsión" := DATE2DMY("Fecha previsión", 2);
                END
                ELSE BEGIN
                    "Mes previsión" := 0;
                END;
            END;
        }
        field(60; "n/Banco Domiciliacion"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(61; "Pagos a"; Text[50]) { }
        field(62; "Canon"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
            trigger OnValidate()
            BEGIN
                VALIDATE("% IVA");                           //FCL-02/06/04
                VALIDATE("% IRPF");                          //$001
            END;


        }
        field(63; "IVA"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(64; "Total"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(65; "Gastos"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(66; "% IVA"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                if ("% IVA" = 0) THEN BEGIN
                    IVA := 0;
                    //Total := Canon + IVA;                           //$001
                END ELSE BEGIN
                    IVA := ROUND((Canon * "% IVA" / 100), 0.01);
                    //Total := Canon + IVA;                           //$001
                END;

                CalcularTotal;                                      //$001
            END;
        }
        field(67; "Cód. Divisa"; Code[10]) { TableRelation = Currency; }
        field(70; "s/Cuenta Ingreso"; Text[50])
        {
            trigger OnValidate()
            VAR
                CompanyInfo: Record 79;
                VandorB: Record 288;
                Entidad: Text[4];
                Oficina: Text[4];
                DigitoControl: Text[2];
                Cuenta: Text[10];
                CCC: Text[20];
                Codigo: Code[20];
                Vendor: Record Vendor;
            BEGIN
                "s/Cuenta Ingreso" := DELCHR("s/Cuenta Ingreso");
                CompanyInfo.CheckIBAN("s/Cuenta Ingreso");
                //ES0304872157772000006686
                //04872157772000006686
                //12345678901234567890
                CCC := COPYSTR("s/Cuenta Ingreso", 5, 20);
                Entidad := COPYSTR(CCC, 1, 4);
                Oficina := COPYSTR(CCC, 5, 4);
                DigitoControl := COPYSTR(CCC, 9, 2);
                Cuenta := COPYSTR(CCC, 11, 10);
                VandorB.SETRANGE(VandorB."Vendor No.", "Nº Proveedor");
                VandorB.SETRANGE(VandorB."CCC No.", CCC);
                if NOT VandorB.FINDFIRST THEN BEGIN
                    VandorB.SETRANGE(VandorB."CCC No.");
                    if NOT VandorB.FIND('+') THEN
                        Codigo := '1'
                    ELSE
                        Codigo := INCSTR(VandorB.Code);
                    VandorB.INIT;
                    VandorB."Vendor No." := "Nº Proveedor";
                    VandorB.Code := Codigo;
                    VandorB."CCC Bank No." := Entidad;
                    VandorB."CCC Bank Branch No." := Oficina;
                    VandorB."CCC Control Digits" := DigitoControl;
                    VandorB."CCC Bank Account No." := Cuenta;
                    VandorB."CCC No." := CCC;
                    VandorB.INSERT;
                END;
                VandorB.IBAN := "s/Cuenta Ingreso";
                VandorB.MODIFY;
                Vendor.GET("Nº Proveedor");
                Vendor."Preferred Bank Account Code" := VandorB.Code;
                Vendor.MODIFY;
            END;
        }
        field(75; "Fecha firma contrato"; Date) { }
        field(76; "Fecha vto. contrato"; Date) { }
        field(77; "Duración"; Code[20]) {; DateFormula = true; }
        field(78; "Futuro"; Boolean) { }
        field(79; "Antiguedad"; Date) { Caption = 'Antigüedad'; }
        field(80; "Fecha instalación"; Date) { }
        field(81; "Responsable"; Code[3]) { }
        field(82; "Cod. Pago"; Code[3]) { }
        field(83; "Texto forma de pago"; text[30]) { }
        field(84; "Ipc"; Boolean) { }
        field(85; "Nombre Proveedor"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Nº Proveedor")));
            Editable = false;
        }
        field(86; "Renovación"; Code[20])
        {
            DateFormula = true;
        }
        field(88; "Comentario Recibo"; Text[80]) { }
        field(90; "Carretera"; Code[20]) { }
        field(91; "Cód. termino pago empl."; Code[10])
        {
            TableRelation = "Términos pagos emplazamientos";
        }
        field(99; "Cód. termino Prevision empl."; Code[10])
        {
            TableRelation = "Términos pagos emplazamientos";
        }
        field(92; "Día vencimiento"; Integer) { }
        field(93; "Mes vencimiento 1º"; Integer) { }
        field(94; "Mes previsión"; Integer) { }
        field(95; "Módulo montado"; Decimal) { }
        field(96; "Módulo contratado"; Decimal) { }
        field(100; "Importe movs."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos"."Importe total" WHERE("Nº proveedor" = FIELD("Nº Proveedor"),
                                                                    "Nº emplazamiento" = FIELD("Nº Emplazamiento")));

        }
        field(105; "Importe pendiente"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos"."Importe pendiente" WHERE("Nº proveedor" = FIELD("Nº Proveedor"),
                                                                        "Nº emplazamiento" = FIELD("Nº Emplazamiento")));
        }
        field(106; "% IRPF"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                if ("% IRPF" = 0) THEN BEGIN
                    "Importe IRPF" := 0;
                END ELSE BEGIN
                    "Importe IRPF" := ROUND((Canon * "% IRPF" / 100), 0.01);
                END;

                CalcularTotal;
            END;

        }
        field(107; "Importe IRPF"; Decimal) { }
        field(110; "Pagare al portador"; Boolean) { }

        field(111; "Emite Factura"; Boolean) { }
        field(112; "CM"; Boolean) { }
        field(113; "No Entregado"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Mov. emplazamientos" WHERE("Nº proveedor" = FIELD("Nº Proveedor"),
                                                    "Nº emplazamiento" = FIELD("Nº Emplazamiento"),
                                                    Entregado = CONST(false),
                                                    "Fecha vencimiento" = FIELD("Filtro Fecha")));
        }
        field(114; "Filtro Fecha"; Date)
        { FieldClass = FlowFilter; }
        field(50075; "Fecha firma contrato Des"; Date) { }
        field(50076; "Fecha vto. contrato Des"; Date) { }
        field(50115; "Intocable"; Enum "Intocable Emplazamiento") { }
        field(50116; "Estado"; Enum "Estado Emplazamiento")
        {

        }
        field(50117; "Punto Kilométrico"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            MaxValue = 999;
        }
        field(50118; "Filtro Activo"; Code[20]) { FieldClass = FlowFilter; }
        field(50119; "Activo"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Fixed Asset"."No." WHERE("No." = FIELD("Filtro Activo")));
        }
        field(50120; "Emplazamiento Principal"; Code[20]) { TableRelation = "Emplazamientos proveedores"."Nº Emplazamiento"; }
        field(50121; "Principal\Componente"; Enum "Principal\Componente") { }
        field(50122; "City"; text[30])
        {
            Caption = 'Población';
            trigger OnValidate()

            BEGIN
                Pais := 'ESP';
                PostCode.ValidateCity(City, "Post Code", County, Pais, false);
            END;

            trigger OnLookup()
            BEGIN
                Pais := 'ESP';
                PostCode.LookupPostCode(City, "Post Code", County, Pais);
            END;
        }
        field(50123; "Post Code"; Code[20])
        {

            ValidateTableRelation = false;
            Caption = 'C.P.';
            TableRelation = "Post Code";
            trigger OnValidate()
            BEGIN
                Pais := 'ESP';
                PostCode.ValidateCity(City, "Post Code", County, Pais, false);
            END;

            trigger OnLookup()
            BEGIN
                Pais := 'ESP';
                PostCode.LookupPostCode(City, "Post Code", County, Pais);
            END;
        }
        field(50124; "County"; text[30])
        {
            Caption = 'Provincia';
        }
        field(50125; "Exonerado IRPF"; Boolean) { }
        field(50126; "Contacto"; Text[50]) { }
        field(50127; "Empresa"; Text[50]) { }
        field(50128; "Teléfono"; text[30]) { }
        field(50129; "Resaltar"; Boolean) { }
        field(50130; "E-Mail"; Text[80])
        {
            Caption = 'Correo electrónico';
        }
        field(50131; "Numero Nuevo"; Code[20]) { }
        field(50132; "Observaciones Permisos"; Text[250]) { }
        field(50014; "Saldo Contabilidad"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FILTER('621..6229999999|400901315..400901326'),
                                                                                             "Periodo de Pago" = FIELD(FILTER("Filtro Docuemnto")),
                                                                                             "Source No." = FIELD("Nº Proveedor")));
        }
        field(50013; "Saldo Movimientos"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos".Importe WHERE("Periodo Pago" = FIELD(FILTER("Filtro Docuemnto2")),
                                                                                                        "Nº proveedor" = FIELD("Nº Proveedor")));
        }
        field(50016; "Filtro Docuemnto"; Text[30]) { FieldClass = FlowFilter; }
        field(50017; "Filtro Docuemnto2"; Code[30]) { FieldClass = FlowFilter; }
        // field(60014; "Saldo Contabilidad Prev"; Decimal)
        // {
        //     //FieldClass = FlowField;
        //     //CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FILTER('621..6229999999|400901315..400901326'),
        //     //                                                         "Periodo de Pago" = FIELD(FILTER("Filtro Docuemnto")),
        //     //                                                         "Source No." = FIELD("Nº Proveedor")));
        // }
        // field(60013; "Saldo Movimientos Prev"; Decimal)
        // {
        //     //FieldClass = FlowField;
        //     //CalcFormula = Sum("Mov. emplazamientos".Importe WHERE("Periodo Pago" = FIELD(FILTER("Filtro Docuemnto2")),
        //     //                                                                                            "Nº proveedor" = FIELD("Nº Proveedor")));
        // }
        field(50105; "Importe Regularizado"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos"."Regularización" WHERE("Nº proveedor" = FIELD("Nº Proveedor"),
                                                                        "Nº emplazamiento" = FIELD("Nº Emplazamiento")));
        }
    }
    KEYS
    {
        Key(Proveedor; "Nº Proveedor", "Nº Emplazamiento") { Clustered = true; }
        Key(Emplazamiento; "Nº Emplazamiento") { }
        Key(Tenovacion; Renovación) { }
    }
    VAR
        PostCode: Record "Post Code";
        Pais: Code[20];

    PROCEDURE CalcularTotal();
    BEGIN
        //$001

        Total := Canon - "Importe IRPF" + IVA;
    END;

    // trigger OnInsert()
    // var
    //     Empl: Record Emplazamientos;
    // begin
    //     if ("Emplazamiento Principal" = "Nº Emplazamiento") Or
    //     ("Emplazamiento Principal" = '') Then begin
    //         if Empl.Get("Nº Emplazamiento") Then Empl.Delete();
    //         Empl.TransferFields(Rec);
    //         Empl.Insert();
    //     end;
    // end;

    // trigger OnModify()
    // var
    //     Empl: Record Emplazamientos;
    // begin
    //     if ("Emplazamiento Principal" = "Nº Emplazamiento") Or
    //     ("Emplazamiento Principal" = '') Then begin
    //         if Empl.Get("Nº Emplazamiento") Then Empl.Delete();
    //         //Empl.TransferFields(Rec);
    //         //Empl.Insert(); 
    //     end;
    // end;


}
table 7010457 "Emplazamientos proveedores new"
{

    fields
    {
        field(1; "Nº Proveedor"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(5; "Nº Emplazamiento"; Code[20])
        {
            // TableRelation = "Emplazamientos proveedores"."Nº Emplazamiento" WHERE("Nº Proveedor" = FIELD("Nº Proveedor"));
            // ValidateTableRelation = false;
            // NotBlank = true;
        }
        field(10; "Descripción"; Text[50]) { }
        field(12; "Municipio emplazamiento"; Code[15]) { }
        field(13; "Zona"; Text[20]) { }
        field(15; "Contratado"; text[30]) { }
        field(20; "Observaciones"; Text[250]) { }
        field(35; "Suelo"; Enum "Suelo") { }
        field(40; "Periodo pago"; Code[30])
        {
            TableRelation = "Periodos pago emplazamientos";
        }
        field(45; "Total pago periodo"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos"."Importe total" WHERE("Nº proveedor" = FIELD("Nº Proveedor"),
                                                                    "Nº emplazamiento" = FIELD("Nº Emplazamiento"),
                                                                    "Periodo Pago" = FIELD("Periodo pago")));
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(50; "Total prevision"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(55; "Fecha previsión"; Date)
        {
            trigger OnValidate()
            BEGIN

                //FCL-03/06/04
                if "Fecha previsión" <> 0D THEN BEGIN
                    "Mes previsión" := DATE2DMY("Fecha previsión", 2);
                END
                ELSE BEGIN
                    "Mes previsión" := 0;
                END;
            END;
        }
        field(60; "n/Banco Domiciliacion"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(61; "Pagos a"; Text[50]) { }
        field(62; "Canon"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
            trigger OnValidate()
            BEGIN
                VALIDATE("% IVA");                           //FCL-02/06/04
                VALIDATE("% IRPF");                          //$001
            END;


        }
        field(63; "IVA"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(64; "Total"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(65; "Gastos"; Decimal)
        {
            AutoFormatType = 1;
            AutoFormatExpression = "Cód. Divisa";
        }
        field(66; "% IVA"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                if ("% IVA" = 0) THEN BEGIN
                    IVA := 0;
                    //Total := Canon + IVA;                           //$001
                END ELSE BEGIN
                    IVA := ROUND((Canon * "% IVA" / 100), 0.01);
                    //Total := Canon + IVA;                           //$001
                END;

                CalcularTotal;                                      //$001
            END;
        }
        field(67; "Cód. Divisa"; Code[10]) { TableRelation = Currency; }
        field(70; "s/Cuenta Ingreso"; Text[50])
        {
            trigger OnValidate()
            VAR
                CompanyInfo: Record 79;
                VandorB: Record 288;
                Entidad: Text[4];
                Oficina: Text[4];
                DigitoControl: Text[2];
                Cuenta: Text[10];
                CCC: Text[20];
                Codigo: Code[20];
                Vendor: Record Vendor;
            BEGIN
                "s/Cuenta Ingreso" := DELCHR("s/Cuenta Ingreso");
                CompanyInfo.CheckIBAN("s/Cuenta Ingreso");
                //ES0304872157772000006686
                //04872157772000006686
                //12345678901234567890
                CCC := COPYSTR("s/Cuenta Ingreso", 5, 20);
                Entidad := COPYSTR(CCC, 1, 4);
                Oficina := COPYSTR(CCC, 5, 4);
                DigitoControl := COPYSTR(CCC, 9, 2);
                Cuenta := COPYSTR(CCC, 11, 10);
                VandorB.SETRANGE(VandorB."Vendor No.", "Nº Proveedor");
                VandorB.SETRANGE(VandorB."CCC No.", CCC);
                if NOT VandorB.FINDFIRST THEN BEGIN
                    VandorB.SETRANGE(VandorB."CCC No.");
                    if NOT VandorB.FIND('+') THEN
                        Codigo := '1'
                    ELSE
                        Codigo := INCSTR(VandorB.Code);
                    VandorB.INIT;
                    VandorB."Vendor No." := "Nº Proveedor";
                    VandorB.Code := Codigo;
                    VandorB."CCC Bank No." := Entidad;
                    VandorB."CCC Bank Branch No." := Oficina;
                    VandorB."CCC Control Digits" := DigitoControl;
                    VandorB."CCC Bank Account No." := Cuenta;
                    VandorB."CCC No." := CCC;
                    VandorB.INSERT;
                END;
                VandorB.IBAN := "s/Cuenta Ingreso";
                VandorB.MODIFY;
                Vendor.GET("Nº Proveedor");
                Vendor."Preferred Bank Account Code" := VandorB.Code;
                Vendor.MODIFY;
            END;
        }
        field(75; "Fecha firma contrato"; Date) { }
        field(76; "Fecha vto. contrato"; Date) { }
        field(77; "Duración"; Code[20]) {; DateFormula = true; }
        field(78; "Futuro"; Boolean) { }
        field(79; "Antiguedad"; Date) { Caption = 'Antigüedad'; }
        field(80; "Fecha instalación"; Date) { }
        field(81; "Responsable"; Code[3]) { }
        field(82; "Cod. Pago"; Code[3]) { }
        field(83; "Texto forma de pago"; text[30]) { }
        field(84; "Ipc"; Boolean) { }
        field(85; "Nombre Proveedor"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Nº Proveedor")));
            Editable = false;
        }
        field(86; "Renovación"; Code[20])
        {
            DateFormula = true;
        }
        field(88; "Comentario Recibo"; Text[80]) { }
        field(90; "Carretera"; Code[20]) { }
        field(91; "Cód. termino pago empl."; Code[10])
        {
            TableRelation = "Términos pagos emplazamientos";
        }
        field(92; "Día vencimiento"; Integer) { }
        field(93; "Mes vencimiento 1º"; Integer) { }
        field(94; "Mes previsión"; Integer) { }
        field(95; "Módulo montado"; Decimal) { }
        field(96; "Módulo contratado"; Decimal) { }
        field(100; "Importe movs."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos"."Importe total" WHERE("Nº proveedor" = FIELD("Nº Proveedor"),
                                                                    "Nº emplazamiento" = FIELD("Nº Emplazamiento")));

        }
        field(105; "Importe pendiente"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos"."Importe pendiente" WHERE("Nº proveedor" = FIELD("Nº Proveedor"),
                                                                        "Nº emplazamiento" = FIELD("Nº Emplazamiento")));
        }
        field(106; "% IRPF"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                if ("% IRPF" = 0) THEN BEGIN
                    "Importe IRPF" := 0;
                END ELSE BEGIN
                    "Importe IRPF" := ROUND((Canon * "% IRPF" / 100), 0.01);
                END;

                CalcularTotal;
            END;

        }
        field(107; "Importe IRPF"; Decimal) { }
        field(110; "Pagare al portador"; Boolean) { }

        field(111; "Emite Factura"; Boolean) { }
        field(112; "CM"; Boolean) { }
        field(113; "No Entregado"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Mov. emplazamientos" WHERE("Nº proveedor" = FIELD("Nº Proveedor"),
                                                    "Nº emplazamiento" = FIELD("Nº Emplazamiento"),
                                                    Entregado = CONST(false),
                                                    "Fecha vencimiento" = FIELD("Filtro Fecha")));
        }
        field(114; "Filtro Fecha"; Date)
        { FieldClass = FlowFilter; }
        field(50075; "Fecha firma contrato Des"; Date) { }
        field(50076; "Fecha vto. contrato Des"; Date) { }
        field(50115; "Intocable"; Enum "Intocable Emplazamiento") { }
        field(50116; "Estado"; Enum "Estado Emplazamiento")
        {

        }
        field(50117; "Punto Kilométrico"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            MaxValue = 999;
        }
        field(50118; "Filtro Activo"; Code[20]) { FieldClass = FlowFilter; }
        field(50119; "Activo"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Fixed Asset"."No." WHERE("No." = FIELD("Filtro Activo")));
        }
        field(50120; "Emplazamiento Principal"; Code[20]) { TableRelation = "Emplazamientos proveedores"."Nº Emplazamiento"; }
        field(50121; "Principal\Componente"; Enum "Principal\Componente") { }
        field(50122; "City"; text[30])
        {
            Caption = 'Población';
            trigger OnValidate()

            BEGIN
                Pais := 'ESP';
                PostCode.ValidateCity(City, "Post Code", County, Pais, false);
            END;

            trigger OnLookup()
            BEGIN
                Pais := 'ESP';
                PostCode.LookupPostCode(City, "Post Code", County, Pais);
            END;
        }
        field(50123; "Post Code"; Code[20])
        {

            ValidateTableRelation = false;
            Caption = 'C.P.';
            TableRelation = "Post Code";
            trigger OnValidate()
            BEGIN
                Pais := 'ESP';
                PostCode.ValidateCity(City, "Post Code", County, Pais, false);
            END;

            trigger OnLookup()
            BEGIN
                Pais := 'ESP';
                PostCode.LookupPostCode(City, "Post Code", County, Pais);
            END;
        }
        field(50124; "County"; text[30])
        {
            Caption = 'Provincia';
        }
        field(50125; "Exonerado IRPF"; Boolean) { }
        field(50126; "Contacto"; Text[50]) { }
        field(50127; "Empresa"; Text[50]) { }
        field(50128; "Teléfono"; text[30]) { }
        field(50129; "Resaltar"; Boolean) { }
        field(50130; "E-Mail"; Text[80])
        {
            Caption = 'Correo electrónico';
        }
        field(50131; "Numero Nuevo"; Code[20]) { }
        field(50132; "Observaciones Permisos"; Text[250]) { }
        field(50014; "Saldo Contabilidad"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FILTER('621..6229999999|400901315..400901326'),
                                                                                             "Periodo de Pago" = FIELD(FILTER("Filtro Docuemnto")),
                                                                                             "Source No." = FIELD("Nº Proveedor")));
        }
        field(50013; "Saldo Movimientos"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos".Importe WHERE("Periodo Pago" = FIELD(FILTER("Filtro Docuemnto2")),
                                                                                                        "Nº proveedor" = FIELD("Nº Proveedor")));
        }
        field(50016; "Filtro Docuemnto"; Text[30]) { FieldClass = FlowFilter; }
        field(50017; "Filtro Docuemnto2"; Code[30]) { FieldClass = FlowFilter; }
        // field(60014; "Saldo Contabilidad Prev"; Decimal)
        // {
        //     //FieldClass = FlowField;
        //     //CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FILTER('621..6229999999|400901315..400901326'),
        //     //                                                         "Periodo de Pago" = FIELD(FILTER("Filtro Docuemnto")),
        //     //                                                         "Source No." = FIELD("Nº Proveedor")));
        // }
        // field(60013; "Saldo Movimientos Prev"; Decimal)
        // {
        //     //FieldClass = FlowField;
        //     //CalcFormula = Sum("Mov. emplazamientos".Importe WHERE("Periodo Pago" = FIELD(FILTER("Filtro Docuemnto2")),
        //     //                                                                                            "Nº proveedor" = FIELD("Nº Proveedor")));
        // }
        field(50105; "Importe Regularizado"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Mov. emplazamientos"."Regularización" WHERE("Nº proveedor" = FIELD("Nº Proveedor"),
                                                                        "Nº emplazamiento" = FIELD("Nº Emplazamiento")));
        }
    }
    KEYS
    {
        Key(Proveedor; "Nº Proveedor", "Nº Emplazamiento") { Clustered = true; }
        Key(Emplazamiento; "Nº Emplazamiento") { }
        Key(Tenovacion; Renovación) { }
    }
    VAR
        PostCode: Record "Post Code";
        Pais: Code[20];

    PROCEDURE CalcularTotal();
    BEGIN
        //$001

        Total := Canon - "Importe IRPF" + IVA;
    END;

    // trigger OnInsert()
    // var
    //     Empl: Record Emplazamientos;
    // begin
    //     if ("Emplazamiento Principal" = "Nº Emplazamiento") Or
    //     ("Emplazamiento Principal" = '') Then begin
    //         if Empl.Get("Nº Emplazamiento") Then Empl.Delete();
    //         Empl.TransferFields(Rec);
    //         Empl.Insert();
    //     end;
    // end;

    // trigger OnModify()
    // var
    //     Empl: Record Emplazamientos;
    // begin
    //     if ("Emplazamiento Principal" = "Nº Emplazamiento") Or
    //     ("Emplazamiento Principal" = '') Then begin
    //         if Empl.Get("Nº Emplazamiento") Then Empl.Delete();
    //         //Empl.TransferFields(Rec);
    //         //Empl.Insert(); 
    //     end;
    // end;


}

