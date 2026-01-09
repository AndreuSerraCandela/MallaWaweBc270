/// <summary>
/// TableExtension JobKuara (ID 80101) extends Record Job.
/// </summary>
tableextension 80101 JobKuara extends "Job"
{
    fields
    {
        // Add changes to table fields here


        modify("Bill-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                rClie: Record Customer;
            begin

                if rClie.GET("Bill-to Customer No.") THEN BEGIN
                    VALIDATE("Cód. vendedor", rClie."Salesperson Code");
                    // MNC 291200
                    "Cód. divisa" := rClie."Currency Code";
                    rClie.TestField("VAT Bus. Posting Group");
                    rClie.TestField("Customer Posting Group");
                    rClie.TestField("Payment Terms Code");
                    rClie.TestField("Payment Method Code");
                    rclie.TestField("Gen. Bus. Posting Group");
                    rclie.TestField("Salesperson Code");
                    rclie.TestField("VAT Registration No.");
                    VALIDATE("payment method code", rClie."Payment Method Code");              //$012
                END else
                    Message('No existe el cliente');

                //$001
                // {
                // if ("Bill-to Customer No." = '') OR ("Bill-to Customer No." <> xRec."Bill-to Customer No.") THEN
                // if JobLedgEntryExist OR JobPlanningLineExist THEN
                //     ERROR(Text000,FIELDCAPTION("Bill-to Customer No."),TABLECAPTION);
                // }
                // UpdateCust;
                if ("Bill-to Customer No." <> xRec."Bill-to Customer No.") THEN BEGIN
                    CLEAR(rReserva);
                    rReserva.RESET;
                    rReserva.SETCURRENTKEY("Nº Proyecto", "Fecha inicio");
                    rReserva.SETRANGE("Nº Proyecto", "No.");
                    rReserva.MODIFYALL("Cód. Cliente", "Bill-to Customer No.", TRUE);
                END;
            end;
        }
        modify("Ending Date")
        {
            trigger OnAfterValidate()
            begin

                // if ("Ending Date" < "Starting Date") THEN
                //   ERROR('Cuidado! La fecha final es menor a la fecha de inicio');

            end;
        }
        field(50000; Tipo; Enum "Tipo Venta Job")
        {
            trigger OnValidate()
            begin
                RevisaOpciones;
            end;

        }
        field(50001; "Cód. vendedor"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50005; Firmado; Enum "Firmado")
        {
            // trigger OnValidate()
            // BEGIN
            //     if (Firmado = Firmado::Firmado) THEN
            //         Firma;
            // END;

        }
        field(50006; "Fecha Firma"; Date)
        { }
        field(50010; "Nº lineas"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Job Planning Line" WHERE("Job No." = FIELD("No."),
            "Line Type" = CONST(Budget)));
        }
        field(50015; "Esperar Orden Cliente"; Boolean)
        {
            InitValue = false;
        }
        field(50018; "Subtipo"; Enum "Subtipo")
        {
        }
        field(50019; "Según disponibilidad"; Boolean)
        {
            trigger OnValidate()
            var
                rLin: Record "Job Planning Line";
                Contratos: Record "Sales Header";
                Res: Record Resource;
                Tipo: Record "Tipo Recurso";
            begin
                Contratos.SetRange("Nº Proyecto", "No.");
                if Contratos.FindFirst() then Error('Ya tiene contrato');
                rLin.SetRange("Job No.", "No.");
                if rLin.FindFirst() then
                    repeat
                        if Res.Get(rLin."No.") then begin
                            if not Tipo.Get(Res."Tipo Recurso") Then TIPO.Init();
                            if (Res."Recurso Agrupado" = false) and (Rec."Según disponibilidad") and (Tipo."Crea Reservas") Then begin
                                rLin.Validate("Crear pedidos", rLin."Crear pedidos"::"De Compra");
                                rLin.Validate("Imprmir en Contrato/Factura", false);
                            end else begin
                                rLin.Validate("Imprmir en Contrato/Factura", true);
                            end;
                        end;
                    until rLin.Next() = 0;
            end;
        }
        field(50020; "Cód. divisa"; Code[10])
        {
            TableRelation = Currency;
            //Caption = 'Currency Code 2', ESP = 'Cód. Divisa2';
        }
        field(50025; Renovado; Boolean)
        { }
        field(50041; "Soporte de"; Enum "Soporte de")
        {
            trigger OnValidate()
            BEGIN
                RevisaOpciones;
            END;

        }
        field(50042; "Interc./Compens."; Enum "Interc./Compens.")
        {
            Caption = 'Interc./Compens./Dona.';

            Description = 'FCL-18/05/04';
        }
        field(50043; "Proyecto original"; Code[20])
        {
            TableRelation = Job;
            Description = 'Es el proyecto inicial';
            trigger OnValidate()
            VAR
                lJob: Record Job;
            BEGIN
                if lJob.GET("Proyecto original") THEN BEGIN
                    lJob.Renovado := TRUE;
                    lJob.MODIFY;
                END;
            END;

        }
        field(50045; "Fija/Papel"; Enum "Fija/Papel")
        {

            Description = '$003';
        }
        field(50050; "Cod forma pago"; Code[10])
        {
            ObsoleteState = Removed;
            TableRelation = "Payment Method".Code;
            // WHERE 
            //("Cobro/Pagos/Ambos"=FILTER(Cobro|Ambos),
            //Visible=CONST(Yes));
            //Caption=  'Cód. forma pago';
        }
        field(50052; "Global Dimension 5 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(5));
            //Caption = 'Global Dimension 5 Code', ESP = 'Cód. dimensión global 5';
            CaptionClass = '1,2,5';
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(5, "Global Dimension 5 Code");
            END;


        }
        field(50087; "Estado Contrato"; Enum "Estado Contrato")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header".Estado WHERE("Document Type" = FILTER(Order),
            "Nº Proyecto" = FIELD("No.")));

            Description = '$002';
            Editable = false;
        }
        field(50088; "Fecha Estado Contrato"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Fecha Estado" WHERE("Document Type" = FILTER(Order),
                          "Nº Proyecto" = FIELD("No.")));
            Description = '$002';
            Editable = false;
        }
        field(50089; "Proyecto Antiguo"; Code[10])
        {

            Description = 'FCL- Campo añadido por ASC';
        }
        field(50090; "Proyecto origen"; Code[20])
        {
            TableRelation = Job;
            Description = 'Es el proyecto a partir de el que se ha creado el actual';
        }
        field(50091; "No Documento externo"; Code[20])
        {

            Caption = 'Nº documento externo';

        }
        field(50200; Procesado; Boolean)
        {
            Description = '$011-Creado para proceso temporal';
        }
        field(50201; "Antiguo proyecto original"; Code[20])
        {
            TableRelation = Job;
            Description = '$011-Creado para proceso temporal';
        }
        field(50202; "Proyecto en empresa Origen"; Code[20])
        { }
        field(50203; "Empresa Origen"; Text[30])
        { }
        field(50204; "Recurso Principal"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Planning Line"."No." WHERE(Type = CONST(Resource), "Job No." = FIELD("No.")));
        }
        field(50205; "Vendedor Origen"; Code[20])
        { }
        field(51021; "Global Dimension 3 Code"; Code[20])
        {
            //  Caption = 'Global Dimension 3 Code', ESP = 'Cód. dimensión global 3';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(3, "Global Dimension 3 Code");
                MODIFY;
            END;

        }
        field(51022; "Global Dimension 4 Code"; Code[20])
        {
            // Caption = 'Global Dimension 4 Code', ESP = 'Cód. dimensión global 4';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
                MODIFY;
            END;

        }
        field(51023; "No Pay"; Boolean)
        {
            trigger OnValidate()
            BEGIN
                //"Proyecto de fijación" := "No Pay";
                CLEAR(rReserva);
                rReserva.RESET;
                rReserva.SETCURRENTKEY("Nº Proyecto", "Fecha inicio");
                rReserva.SETRANGE("Nº Proyecto", "No.");
                rReserva.MODIFYALL("No Pay", "No Pay", TRUE);
            END;
        }
        field(51024; "Proyecto de fijación"; Boolean)
        {
            trigger OnValidate()
            BEGIN
                //"No Pay" := "Proyecto de fijación";
                CLEAR(rReserva);
                rReserva.RESET;
                rReserva.SETCURRENTKEY("Nº Proyecto", "Fecha inicio");
                rReserva.SETRANGE("Nº Proyecto", "No.");
                rReserva.MODIFYALL("Proyecto de fijación", "Proyecto de fijación", TRUE);
            END;
        }
        field(51025; "Tipo de Fijación"; Code[20])
        {
            TableRelation = "Standard Text".Code WHERE("Para Fijación" = CONST(true));
            trigger OnValidate()
            BEGIN
                CLEAR(rReserva);
                rReserva.RESET;
                rReserva.SETCURRENTKEY("Nº Proyecto", "Fecha inicio");
                rReserva.SETRANGE("Nº Proyecto", "No.");
                rReserva.MODIFYALL("Tipo de Fijación", "Tipo de Fijación", TRUE);
            END;
        }

        field(60019; "Nombre Comercial"; Text[250])
        {
            Caption = 'Anunciante';
            TableRelation = "Nombre Comercial".Nombre;
        }
        field(60020; "Proyecto Mixto"; Boolean)
        {

        }
        field(60021; "Nº Contrato"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."No." WHERE("Document Type" = FILTER(Order),
                          "Nº Proyecto" = FIELD("No.")));
            TableRelation = "Sales Header"."No.";
        }
        //Fechas Flexibles Campo booleano
        field(60022; "Fechas Flexibles"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60023; "Fijar"; Boolean)
        {

        }
        field(60024; "Fecha Fijación"; Date)
        {

        }
        field(60025; "Tipo Soporte"; Option)
        {
            OptionMembers = "Opis","Vallas","Vallas Peantones","Indicadores";
        }
        field(60026; "No. soportes"; Integer)
        {
            Caption = 'Nº soportes';
        }


    }

    var
        myInt: Integer;
        rReserva: Record Reserva;

    /// <summary>
    /// Lineas.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure Lineas(): Integer
    var
        JobLine: Record "Job Planning Line";
    begin
        JobLine.SetRange("Job No.", Rec."No.");
        exit(JobLine.Count);
    end;

    PROCEDURE RevisaOpciones();
    VAR
        rLinProy: Record "Job Planning Line";
    BEGIN
        // $003
        CASE Tipo OF
            Tipo::"Por Campaña":
                BEGIN
                    "Fija/Papel" := "Fija/Papel"::Papel;
                END;
            Tipo::Otros:
                BEGIN            // unico caso que se tocan las otras opciones
                    "Fija/Papel" := "Fija/Papel"::" ";
                    Subtipo := Subtipo::Combinado;
                    "Soporte de" := "Soporte de"::"Fijación";
                END;
            //$014(I)
            Tipo::Reserva:
                BEGIN
                END;
            Tipo::Propuesta:
                BEGIN
                END;
            //$014(F)
            ELSE BEGIN
                if ("Soporte de" = "Soporte de"::Fijación) THEN
                    "Fija/Papel" := "Fija/Papel"::Papel
                ELSE
                    "Fija/Papel" := "Fija/Papel"::Fija;
            END;
        END;

        //$013(I)
        rLinProy.RESET;
        rLinProy.SETRANGE("Job No.", "No.");
        if rLinProy.FINDSET THEN BEGIN
            REPEAT
                if rLinProy."Fija/Papel" <> "Fija/Papel" THEN BEGIN
                    rLinProy."Fija/Papel" := "Fija/Papel";
                    rLinProy.MODIFY;
                END;
            UNTIL rLinProy.NEXT = 0;
        END;
        //$013(F)
    END;

    PROCEDURE Firma();
    VAR
        rCabC: Record "Purchase Header";
        rCabV: Record "Sales Header";
    BEGIN
        // FCL-24/02/04. Migración de 2.0. a 3.70.

        if (Status = Status::Open) THEN BEGIN
            Firmado := Firmado::Firmado;
            "Fecha Firma" := TODAY;
            MODIFY;
            rCabC.SETCURRENTKEY("Nº Proyecto");
            rCabC.SETRANGE("Nº Proyecto", "No.");
            rCabC.MODIFYALL(Firmado, rCabC.Firmado::Firmado);
            rCabV.SETCURRENTKEY("Nº Proyecto");
            rCabV.SETRANGE("Nº Proyecto", "No.");
            rCabV.MODIFYALL(Firmado, rCabV.Firmado::Firmado);
        END ELSE
            ERROR('Solo se puede firmar un proyecto si esta en estado = Contrato');
    END;

    /// <summary>
    /// UpdateCustEmp.
    /// </summary>
    /// <param name="Cust">VAR Record Customer.</param>
    /// <param name="Emp">Text[30].</param>
    procedure UpdateCustEmp(var Cust: Record Customer; Emp: Text[30])
    begin

        if "Bill-to Customer No." <> '' THEN BEGIN
            Cust.GET("Bill-to Customer No.");
            Cust.TESTFIELD("Customer Posting Group");
            Cust.TESTFIELD("Bill-to Customer No.", '');
            "Bill-to Name" := Cust.Name;
            "Bill-to Name 2" := Cust."Name 2";
            "Bill-to Address" := Cust.Address;
            "Bill-to Address 2" := Cust."Address 2";
            "Bill-to City" := Cust.City;
            "Bill-to Post Code" := Cust."Post Code";
            "Bill-to Country/Region Code" := Cust."Country/Region Code";
            "Currency Code" := Cust."Currency Code";
            "Customer Disc. Group" := Cust."Customer Disc. Group";
            "Customer Price Group" := Cust."Customer Price Group";
            "Language Code" := Cust."Language Code";
            "Bill-to County" := Cust.County;
            UpdateBillToContEmp("Bill-to Customer No.", Cust, Emp);
        END ELSE BEGIN
            "Bill-to Name" := '';
            "Bill-to Name 2" := '';
            "Bill-to Address" := '';
            "Bill-to Address 2" := '';
            "Bill-to City" := '';
            "Bill-to Post Code" := '';
            "Bill-to Country/Region Code" := '';
            "Currency Code" := '';
            "Customer Disc. Group" := '';
            "Customer Price Group" := '';
            "Language Code" := '';
            "Bill-to County" := '';
            VALIDATE("Bill-to Contact No.", '');
        END;
    end;

    /// <summary>
    /// UpdateBillToContEmp.
    /// </summary>
    /// <param name="CustomerNo">Code[20].</param>
    /// <param name="Cust">VAR Record Customer.</param>
    /// <param name="Emp">Text[30].</param>
    procedure UpdateBillToContEmp(CustomerNo: Code[20]; var Cust: Record Customer; Emp: Text[30])
    var
        ContBusRel: Record "Contact Business Relation";
    begin

        if Cust.GET(CustomerNo) THEN BEGIN
            if Cust."Primary Contact No." <> '' THEN
                "Bill-to Contact No." := Cust."Primary Contact No."
            ELSE BEGIN
                ContBusRel.CHANGECOMPANY(Emp);
                ContBusRel.RESET;
                ContBusRel.SETCURRENTKEY("Link to Table", "No.");
                ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Customer);
                ContBusRel.SETRANGE("No.", "Bill-to Customer No.");
                if ContBusRel.FIND('-') THEN
                    "Bill-to Contact No." := ContBusRel."Contact No.";
            END;
            "Bill-to Contact" := Cust.Contact;
        END;

    end;

    procedure Navigate()
    var
        NavigatePage: Page Navigate;
    begin
        NavigatePage.SetDoc("Starting Date", "No.");
        NavigatePage.SetRec(Rec);
        NavigatePage.Run();
    end;
}