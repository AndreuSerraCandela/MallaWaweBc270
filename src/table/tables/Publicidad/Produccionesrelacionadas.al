/// <summary>
/// Table Produccines Relacionadas (ID 7001195).
/// </summary>
table 7001195 "Produccines Relacionadas"
{
    Caption = 'Producciones Relacionadas';
    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Nº línea';
            Editable = true;
        }
        field(2; "Job No."; Code[20])
        {
            TableRelation = Job;
            Caption = 'Nº proyecto';
            Editable = true;
        }
        field(3; "Type"; Enum "Tipo (presupuesto)")
        {

            Caption = 'Tipo';
            trigger OnValidate()
            BEGIN
                VALIDATE("No.", '');
                if Type = Type::Producto THEN BEGIN
                END;
            END;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'Nº';
            TableRelation = if (Type = CONST(Recurso)) Resource
            ELSE
            if (Type = CONST(Producto)) Item
            ELSE
            if (Type = CONST(Cuenta)) "G/L Account"
            ELSE
            if (Type = CONST(Texto)) "Standard Text"
            ELSE
            if (Type = CONST(Familia)) "Resource Group"
            ELSE
            if (Type = CONST("Activo Fijo")) "Fixed Asset";
            trigger OnValidate()
            BEGIN
                GetJob;
                if "No." = '' THEN BEGIN
                    Description := '';
                    EXIT;
                END;

                CASE Type OF
                    Type::Recurso:
                        BEGIN
                            //FCL-24/02/04 (I). Migración de 2.0. a 3.70.
                            Res.GET("No.");
                            Description := Res.Name;
                        END;
                    Type::Producto:
                        BEGIN
                            GetItem;
                            Description := Item.Description;
                            if Job."Language Code" <> '' THEN
                                GetItemTranslation;
                        END;
                    Type::Cuenta:
                        BEGIN
                            GLAcc.GET("No.");
                            GLAcc.CheckGLAcc;
                            Description := GLAcc.Name;
                        END;
                    Type::Texto:
                        BEGIN
                            StdTxt.GET("No.");
                            Description := StdTxt.Description;
                        END;
                    Type::Familia:
                        // $001
                        BEGIN
                            rFamilia.GET("No.");
                            Description := rFamilia.Name;
                        END;
                END;

                GetJob;
            END;

        }
        field(5; "Line No.2"; Integer)
        {
            Caption = 'Nº línea origen';
            Editable = true;
        }
        field(6; "Job No.2"; Code[20])
        {
            TableRelation = Job;
            Caption = 'Nº proyecto origen';
            Editable = true;
        }
        field(7; "Type2"; Enum "Tipo (presupuesto)")
        {
            Caption = 'Tipo origen';
            trigger OnValidate()
            BEGIN
                VALIDATE("No.", '');
                if Type = Type::Producto THEN BEGIN
                END;
            END;

        }
        field(8; "No.2"; Code[20])
        {
            Caption = 'Nº Origen';
            TableRelation = if (Type = CONST(Recurso)) Resource
            ELSE
            if (Type = CONST(Producto)) Item
            ELSE
            if (Type = CONST(Cuenta)) "G/L Account"
            ELSE
            if (Type = CONST(Texto)) "Standard Text"
            ELSE
            if (Type = CONST(Familia)) "Resource Group"
            ELSE
            if (Type = CONST("Activo Fijo")) "Fixed Asset";
            trigger OnValidate()
            BEGIN
                GetJob;
                if "No.2" = '' THEN BEGIN
                    "Description 2" := '';
                    EXIT;
                END;

                CASE Type OF
                    Type::Recurso:
                        BEGIN
                            Res.GET("No.2");
                            "Description 2" := Res.Name;
                        END;
                    Type::Producto:
                        BEGIN
                            GetItem2;
                            "Description 2" := Item.Description;
                            if Job."Language Code" <> '' THEN
                                GetItemTranslation2;
                        END;
                    Type::Cuenta:
                        BEGIN
                            GLAcc.GET("No.2");
                            "Description 2" := GLAcc.Name;
                        END;
                    Type::Texto:
                        BEGIN
                            StdTxt.GET("No.2");
                            "Description 2" := StdTxt.Description;
                        END;
                    Type::Familia:
                        // $001
                        BEGIN
                            rFamilia.GET("No.2");
                            "Description 2" := rFamilia.Name;
                        END;
                END;
            END;

        }
        field(9; "Description"; Text[150]) { Caption = 'Descripción'; }
        field(10; "Description 2"; Text[150]) { Caption = 'Descripción origen'; }
        field(11; "Empresa"; Text[30]) { }
    }
    KEYS
    {
        key(P; "Line No.", "Job No.", "Line No.2", "Job No.2") { Clustered = true; }
        key(A; "Job No.", "No.") { }
    }

    VAR
        GLAcc: Record 15;
        Location: Record 14;
        Item: Record 27;
        JobEntryNo: Record 1015;
        JT: Record 1001;
        ItemVariant: Record 5401;
        Res: Record 156;
        ResCost: Record "Price List Line";
        WorkType: Record 200;
        Job: Record 167;
        ResUnitofMeasure: Record 205;
        ItemJnlLine: Record 83;
        CurrExchRate: Record "Currency Exchange Rate";
        SKU: Record 5700;
        StdTxt: Record 7;
        Currency: Record "Currency";
        ItemTranslation: Record 30;
        rTexto: Record "Texto Presupuesto";
        rTipus: Record "Tipo Recurso";
        rFamilia: Record 152;
        rOrden: Record "Cab. orden publicidad";
        SalesPriceCalcMgt: Codeunit "Price Calculation - V16";// 7000;
        PurchPriceCalcMgt: Codeunit "Price Calculation - V16";//7010;
        UOMMgt: Codeunit 5402;
        ResFindUnitCost: Codeunit "Price Calculation - V16";//220;
        ItemCheckAvail: Codeunit 311;
        Gest_Rvas: Codeunit ControlProcesos;
        CurrencyDate: Date;
        DontUseCostFactor: Boolean;
        wP: Decimal;
        rDim: Record 352;
        Text002: Label 'false se puede cambiar el nombre a %1.';
        Text003: Label '%1 no puede ser %2.';
        Text004: Label 'Debe especificar %1 %2 en la línea de planificación.';
        Text50000: Label 'Cuidado! La fecha de final es menor a la fecha de inicio.';
        Text50001: Label 'OJO. El proyecto ya esta en estado Contrato, y ya se han \creado los pedidos de venta y compra. Si quiere modificarlos\debera hacerlo a mano.';
        Text50002: Label 'Esta linea ya tiene reservas asociadas. No se puede modificar este campo.';
        Text50003: Label 'false se puede eliminar esta linea, ya que tiene una orden de publicidad Validada.';

    trigger OnInsert()
    var
        Prod: Record "Produccines Relacionadas";
        Res: Record Resource;

    begin
        if Rec.Empresa <> Companyname then
            if Rec.Empresa <> '' then begin
                if Res.Get(Rec."No.") Then begin
                    Prod.ChangeCompany(Rec.Empresa);
                    Prod.Init;
                    Prod := Rec;
                    Prod."No." := Res."Nº En Empresa origen";
                    Prod."Job No." := Rec."Job No.2";
                    Prod.Empresa := '';
                    if Res.Get("No.2") Then
                        Prod."No.2" := Res."Nº En Empresa origen";
                    Prod.Insert();
                end else begin
                    Prod.ChangeCompany(Rec.Empresa);
                    Prod.Init;
                    Prod := Rec;
                    Prod."Job No." := Rec."Job No.2";
                    Prod.Empresa := '';
                    if Res.Get("No.2") Then
                        Prod."No.2" := Res."Nº En Empresa origen";
                    Prod.Insert();
                end;
            end;
    end;

    trigger OnDelete()
    var
        Prod: Record "Produccines Relacionadas";
        Res: Record Resource;

    begin
        if Rec.Empresa <> Companyname then
            if Rec.Empresa <> '' then begin
                Prod.ChangeCompany(Rec.Empresa);
                if Prod.Get(Rec."Line No.", Rec."Job No.2", Rec."Line No.2", Rec."Job No.2") then
                    Prod.Delete;
            end;
    end;

    trigger OnModify()
    var
        Prod: Record "Produccines Relacionadas";
        Res: Record Resource;

    begin
        if Rec.Empresa <> Companyname then
            if Rec.Empresa <> '' then begin
                Prod.ChangeCompany(Rec.Empresa);
                if Prod.Get(Rec."Line No.", Rec."Job No.2", Rec."Line No.2", Rec."Job No.2") then
                    Prod.Delete;
                if Res.Get(Rec."No.") Then begin
                    Prod.ChangeCompany(Rec.Empresa);
                    Prod.Init;
                    Prod := Rec;
                    Prod."No." := Res."Nº En Empresa origen";
                    Prod."Job No." := Rec."Job No.2";
                    Prod.Empresa := '';
                    if Res.Get("No.2") Then
                        Prod."No.2" := Res."Nº En Empresa origen";
                    Prod.Insert();
                end else begin
                    Prod.ChangeCompany(Rec.Empresa);
                    Prod.Init;
                    Prod := Rec;
                    Prod."Job No." := Rec."Job No.2";
                    Prod.Empresa := '';
                    if Res.Get("No.2") Then
                        Prod."No.2" := Res."Nº En Empresa origen";
                    Prod.Insert();
                end;
            end;
    end;

    PROCEDURE GetJob();
    BEGIN
        TESTFIELD("Job No.");
        if "Job No." <> Job."No." THEN BEGIN
            Job.GET("Job No.");
            if Job."Currency Code" = '' THEN
                Currency.InitRoundingPrecision
            ELSE BEGIN
                Currency.GET(Job."Currency Code");
                Currency.TESTFIELD("Amount Rounding Precision");
            END;
        END;
    END;

    LOCAL PROCEDURE GetItem();
    BEGIN
        TESTFIELD("No.");
        if "No." <> Item."No." THEN
            Item.GET("No.");
    END;

    PROCEDURE Caption(): Text[250];
    VAR
        Job: Record 167;
        JT: Record 1001;
    BEGIN
        if NOT Job.GET("Job No.") THEN
            EXIT('');
        EXIT(STRSUBSTNO('%1 %2 %3 %4',
            Job."No.",
            Job.Description,
            '',
            ''));
    END;

    PROCEDURE GetItemTranslation();
    BEGIN
        GetJob;
        if ItemTranslation.GET("No.", '', Job."Language Code") THEN BEGIN
            Description := ItemTranslation.Description;
        END;
    END;

    LOCAL PROCEDURE GetItem2();
    BEGIN
        TESTFIELD("No.");
        if "No." <> Item."No." THEN
            Item.GET("No.");
    END;

    PROCEDURE GetItemTranslation2();
    BEGIN
        GetJob;
        if ItemTranslation.GET("No.2", '', Job."Language Code") THEN BEGIN
            "Description 2" := ItemTranslation.Description;
        END;
    END;


}

