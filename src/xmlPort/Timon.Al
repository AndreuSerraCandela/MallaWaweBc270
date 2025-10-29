XMLport 50001 Timon
{
    Format = VariableText;
    //Encoding=UTF8;
    FormatEvaluate = Legacy;// C/SIDE Format/Evaluate;
    FieldSeparator = '#';
    Direction = Import;
    UseRequestPage = false;
    schema
    {
        textelement(Dataport)
        {
            tableelement(Interfase; 50006)
            {

                fieldelement(_Identificador; Interfase.Identificador) { }

                fieldelement(_Empresa; Interfase.Empresa) { MinOccurs = Zero; }

                fieldelement(_Ejercicio; Interfase.Ejercicio) { MinOccurs = Zero; }

                fieldelement(_Diario; Interfase.Diario) { MinOccurs = Zero; }

                textelement(_Fecha)
                {
                    MinOccurs = Zero;
                    trigger OnAfterAssignVariable()
                    begin
                        //Export::OnBeforePassVariable=BEGIN
                        _Fecha := COPYSTR(_Fecha, 9, 2) + '-' + COPYSTR(_Fecha, 6, 2) + '-' + COPYSTR(_Fecha, 1, 4);
                        EVALUATE(Interfase."Fecha Registro", CONVERTSTR(_Fecha, '-', '/'));
                    END;
                }

                fieldelement(_descripcion; Interfase.Descripción) { MinOccurs = Zero; }

                fieldelement(Divisa; Interfase."Cod. Divisa") { MinOccurs = Zero; }

                fieldelement(Hotel; Interfase."Codigo Hotel") { MinOccurs = Zero; }

                fieldelement(Cuenta; Interfase."Nº Cuenta") { MinOccurs = Zero; }

                fieldelement(Contrapartida; Interfase."Cta.Contrapartida") { MinOccurs = Zero; }

                fieldelement(Documento; Interfase."Nº Documento") { MinOccurs = Zero; }

                fieldelement(_Concepto; Interfase.Concepto) { MinOccurs = Zero; }

                fieldelement(_Descripcion2; Interfase.Descripcion2) { MinOccurs = Zero; }

                fieldelement(_Importe; Interfase.Importe) { MinOccurs = Zero; }

                fieldelement(_DH; Interfase.D_H) { MinOccurs = Zero; }

                fieldelement(Tipo; Interfase."Tipo de Factura") { MinOccurs = Zero; }

                fieldelement(_Razon; Interfase.Razon) { MinOccurs = Zero; }

                fieldelement(_Cif; Interfase.Cif) { MinOccurs = Zero; }

                fieldelement(_Seria; Interfase.Serie) { MinOccurs = Zero; }

                fieldelement(DocProveedor; Interfase."Nº Documento Proveedor") { MinOccurs = Zero; }

                fieldelement(_Total; Interfase.Total) { MinOccurs = Zero; }

                fieldelement(CodCli; Interfase."Codigo de Cliente") { MinOccurs = Zero; }

                textelement(_Calle) { MinOccurs = Zero; }

                textelement(CP) { MinOccurs = Zero; }

                textelement(Pob) { MinOccurs = Zero; }

                textelement(Prov) { MinOccurs = Zero; }

                textelement(Pais) { MinOccurs = Zero; }

                textelement(_Fecha2)
                {
                    MinOccurs = Zero;
                    trigger OnAfterAssignVariable()
                    begin
                        //Export::OnBeforePassVariable=BEGIN
                        if _Fecha2 <> '' THEN
                            _Fecha2 := COPYSTR(_Fecha2, 9, 2) + '-' + COPYSTR(_Fecha2, 6, 2) + '-' + COPYSTR(_Fecha2, 1, 4);
                        if EVALUATE(Interfase."Fecha Factura Proveedor", CONVERTSTR(Fecha2, '-', '/')) THEN;
                    END;
                }

                textelement(_Moneda) { MinOccurs = Zero; }

                fieldelement(TI; Interfase."Ticket Inicio") { MinOccurs = Zero; }

                fieldelement(TF; Interfase."Ticket fin") { MinOccurs = Zero; }

                fieldelement(_Caja; Interfase.Caja) { MinOccurs = Zero; }

                fieldelement(SII; Interfase."Descripcion SII") { MinOccurs = Zero; }

                fieldelement(_Base1; Interfase.Base1) { MinOccurs = Zero; }

                fieldelement(_IVA; Interfase."% IVA") { MinOccurs = Zero; }

                fieldelement(_ImporteIva; Interfase."Importe IVA") { MinOccurs = Zero; }

                fieldelement(_Base2; Interfase.Base2) { MinOccurs = Zero; }

                fieldelement(_Iva2; Interfase."%Iva2") { MinOccurs = Zero; }

                fieldelement(_ImporteIva2; Interfase.Iva2) { MinOccurs = Zero; }

                fieldelement(_Base3; Interfase.Base3) { MinOccurs = Zero; }

                fieldelement(_IVA3; Interfase."%Iva3") { MinOccurs = Zero; }

                fieldelement(_ImporteIva3; Interfase.Iva3) { MinOccurs = Zero; }

                fieldelement(_Base4; Interfase.Base4) { MinOccurs = Zero; }

                fieldelement(_Iva4; Interfase."%Iva4") { MinOccurs = Zero; }

                fieldelement(_ImporteIva4; Interfase.Iva4) { MinOccurs = Zero; }

                fieldelement(_Base5; Interfase.Base5) { MinOccurs = Zero; }

                fieldelement(_Iva5; Interfase."%Iva5") { MinOccurs = Zero; }

                fieldelement(_ImporteIva5; Interfase.Iva5) { MinOccurs = Zero; }
                trigger OnBeforeInsertRecord()
                begin
                    Interfase."Secuencia Incremental" := a;
                    if Interfase.Identificador = 1 THEN Doc := "Interfase"."Nº Documento";
                    if Interfase."Nº Documento" = '' THEN "Interfase"."Nº Documento" := Doc;
                    a := a + 1;
                end;

                trigger OnAfterInsertRecord()
                BEGIN
                    if Interfase.Identificador = 1 THEN Doc := "Interfase"."Nº Documento";
                    if Interfase."Nº Documento" = '' THEN "Interfase"."Nº Documento" := Doc;

                END;



            }
        }
    }
    trigger OnPreXMLport()
    BEGIN
        Inter.SETCURRENTKEY(Inter."Secuencia Incremental");
        if Inter.FINDLAST THEN a := Inter."Secuencia Incremental" + 1 ELSE a := 1;
    END;


    VAR
        Calle: Text[250];
        CodigoPostal: Text[250];
        Polacion: Text[250];
        Provincia: Text[250];
        Moneda: Text[30];
        Fecha: Text[30];
        Fecha2: Text[30];
        Inter: Record 50006;
        a: Integer;
        Doc: Text[30];


}
XMLport 50003 "Timon Los Tilos"
{
    Format = VariableText;
    //Encoding=UTF8;
    FormatEvaluate = Legacy;// C/SIDE Format/Evaluate;
    FieldSeparator = '#';
    Direction = Import;
    UseRequestPage = false;
    schema
    {
        textelement(Dataport)
        {
            tableelement(Interfase; 50006)
            {

                fieldelement(_Identificador; Interfase.Identificador) { }

                fieldelement(_Empresa; Interfase.Empresa) { MinOccurs = Zero; }

                fieldelement(_Ejercicio; Interfase.Ejercicio) { MinOccurs = Zero; }

                fieldelement(_Diario; Interfase.Diario) { MinOccurs = Zero; }

                textelement(_Fecha)
                {
                    MinOccurs = Zero;
                    trigger OnAfterAssignVariable()
                    begin
                        //Export::OnBeforePassVariable=BEGIN
                        _Fecha := COPYSTR(_Fecha, 9, 2) + '-' + COPYSTR(_Fecha, 6, 2) + '-' + COPYSTR(_Fecha, 1, 4);
                        EVALUATE(Interfase."Fecha Registro", CONVERTSTR(_Fecha, '-', '/'));
                    END;
                }

                fieldelement(_descripcion; Interfase.Descripción) { MinOccurs = Zero; }

                fieldelement(Divisa; Interfase."Cod. Divisa") { MinOccurs = Zero; }

                fieldelement(Hotel; Interfase."Codigo Hotel") { MinOccurs = Zero; }

                fieldelement(Cuenta; Interfase."Nº Cuenta") { MinOccurs = Zero; }

                fieldelement(Contrapartida; Interfase."Cta.Contrapartida") { MinOccurs = Zero; }

                fieldelement(Documento; Interfase."Nº Documento") { MinOccurs = Zero; }

                fieldelement(_Concepto; Interfase.Concepto) { MinOccurs = Zero; }

                fieldelement(_Descripcion2; Interfase.Descripcion2) { MinOccurs = Zero; }

                fieldelement(_Importe; Interfase.Importe) { MinOccurs = Zero; }

                fieldelement(_DH; Interfase.D_H) { MinOccurs = Zero; }

                fieldelement(Tipo; Interfase."Tipo de Factura") { MinOccurs = Zero; }
                textelement(Nada) { MinOccurs = Zero; }

                fieldelement(_Razon; Interfase.Razon) { MinOccurs = Zero; }

                fieldelement(_Cif; Interfase.Cif) { MinOccurs = Zero; }

                fieldelement(_Seria; Interfase.Serie) { MinOccurs = Zero; }

                fieldelement(DocProveedor; Interfase."Nº Documento Proveedor") { MinOccurs = Zero; }

                fieldelement(_Total; Interfase.Total) { MinOccurs = Zero; }

                fieldelement(CodCli; Interfase."Codigo de Cliente") { MinOccurs = Zero; }

                textelement(_Calle) { MinOccurs = Zero; }

                textelement(CP) { MinOccurs = Zero; }

                textelement(Pob) { MinOccurs = Zero; }

                textelement(Prov) { MinOccurs = Zero; }

                textelement(Pais) { MinOccurs = Zero; }

                textelement(_Fecha2)
                {
                    MinOccurs = Zero;
                    trigger OnAfterAssignVariable()
                    begin
                        //Export::OnBeforePassVariable=BEGIN
                        if _Fecha2 <> '' THEN
                            _Fecha2 := COPYSTR(_Fecha2, 9, 2) + '-' + COPYSTR(_Fecha2, 6, 2) + '-' + COPYSTR(_Fecha2, 1, 4);
                        if EVALUATE(Interfase."Fecha Factura Proveedor", CONVERTSTR(Fecha2, '-', '/')) THEN;
                    END;
                }

                textelement(_Moneda) { MinOccurs = Zero; }

                fieldelement(TI; Interfase."Ticket Inicio") { MinOccurs = Zero; }

                fieldelement(TF; Interfase."Ticket fin") { MinOccurs = Zero; }

                fieldelement(_Caja; Interfase.Caja) { MinOccurs = Zero; }

                fieldelement(SII; Interfase."Descripcion SII") { MinOccurs = Zero; }

                fieldelement(_Base1; Interfase.Base1) { MinOccurs = Zero; }

                fieldelement(_IVA; Interfase."% IVA") { MinOccurs = Zero; }

                fieldelement(_ImporteIva; Interfase."Importe IVA") { MinOccurs = Zero; }

                fieldelement(_Base2; Interfase.Base2) { MinOccurs = Zero; }

                fieldelement(_Iva2; Interfase."%Iva2") { MinOccurs = Zero; }

                fieldelement(_ImporteIva2; Interfase.Iva2) { MinOccurs = Zero; }

                fieldelement(_Base3; Interfase.Base3) { MinOccurs = Zero; }

                fieldelement(_IVA3; Interfase."%Iva3") { MinOccurs = Zero; }

                fieldelement(_ImporteIva3; Interfase.Iva3) { MinOccurs = Zero; }

                fieldelement(_Base4; Interfase.Base4) { MinOccurs = Zero; }

                fieldelement(_Iva4; Interfase."%Iva4") { MinOccurs = Zero; }

                fieldelement(_ImporteIva4; Interfase.Iva4) { MinOccurs = Zero; }

                fieldelement(_Base5; Interfase.Base5) { MinOccurs = Zero; }

                fieldelement(_Iva5; Interfase."%Iva5") { MinOccurs = Zero; }

                fieldelement(_ImporteIva5; Interfase.Iva5) { MinOccurs = Zero; }
                trigger OnBeforeInsertRecord()
                begin
                    Interfase."Secuencia Incremental" := a;
                    if Interfase.Identificador = 1 THEN Doc := "Interfase"."Nº Documento";
                    if Interfase."Nº Documento" = '' THEN "Interfase"."Nº Documento" := Doc;
                    a := a + 1;
                end;

                trigger OnAfterInsertRecord()
                BEGIN
                    if Interfase.Identificador = 1 THEN Doc := "Interfase"."Nº Documento";
                    if Interfase."Nº Documento" = '' THEN "Interfase"."Nº Documento" := Doc;

                END;



            }
        }
    }
    trigger OnPreXMLport()
    BEGIN
        Inter.SETCURRENTKEY(Inter."Secuencia Incremental");
        if Inter.FINDLAST THEN a := Inter."Secuencia Incremental" + 1 ELSE a := 1;
    END;


    VAR
        Calle: Text[250];
        CodigoPostal: Text[250];
        Polacion: Text[250];
        Provincia: Text[250];
        Moneda: Text[30];
        Fecha: Text[30];
        Fecha2: Text[30];
        Inter: Record 50006;
        a: Integer;
        Doc: Text[30];
        Nada_1: Text[30];


}

