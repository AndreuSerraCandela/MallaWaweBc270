/// <summary>
/// Table Intercambio (ID 7001118).
/// </summary>
table 7001118 Intercambio
{
    DataPerCompany = false;
    Permissions = TableData 21 = r;
    DataCaptionfields = "No.", Name;


    fields
    {
        field(1; "No."; Code[50])
        {        // AltSearchField="Search Name";
            Caption = 'Nº';
        }
        field(2; "Name"; Text[50])
        {
            Caption = 'Nombre';
            trigger OnValidate()
            BEGIN
                if ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN
                    "Search Name" := Name;
            END;
        }
        field(3; "Search Name"; Code[50]) { Caption = 'Calsificación'; TableRelation = "Clasificación Intercambio"; }
        field(4; "Name 2"; Text[50]) { Caption = 'Nombre 2'; }
        field(5; "Address"; Text[50]) { Caption = 'Dirección'; }
        field(6; "Address 2"; Text[50]) { Caption = 'Dirección 2'; }
        field(7; "City"; Text[30])
        {

            Caption = 'Población';
            trigger OnValidate()
            BEGIN
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", false);
            END;

            trigger OnLookup()
            BEGIN
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            END;
        }
        field(8; "Contact"; Text[50]) { Caption = 'Contacto'; }
        field(9; "Phone No."; Text[30]) { Caption = 'Nº teléfono'; }
        field(10; "Telex No."; Text[20]) { Caption = 'Nº telex'; }
        field(14; "Our Account No."; Text[20]) { Caption = 'Ntro. nº cuenta'; }
        field(15; "Territory Code"; Code[10])
        {
            TableRelation = Territory;
            Caption = 'Cód. territorio';
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Caption = 'Cód. dimensión global 1';
            CaptionClass = '1,1,1';
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Caption = 'Cód. dimensión global 2';
            CaptionClass = '1,1,2';
        }
        field(18; "Chain Name"; Code[10]) { Caption = 'Cód. cadena'; }
        field(19; "Budgeted Amount"; Decimal)
        {
            Caption = 'Importe pptdo.';
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(20; "Credit Limit (LCY)"; Decimal)
        {
            Caption = 'Crédito máximo (DL)';
            AutoFormatType = 1;
        }
        field(22; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Caption = 'Cód. divisa';
        }
        field(27; "Payment Terms Code"; Code[10])
        {
            TableRelation = "Payment Terms";
            Caption = 'Cód. términos pago';
        }
        field(29; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Cód. vendedor';
        }
        field(30; "Shipment Method Code"; Code[10])
        {
            TableRelation = "Shipment Method";
            Caption = 'Cód. condiciones envío';
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            TableRelation = "Shipping Agent";
            Caption = 'Cód. transportista';
        }
        field(35; "Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Caption = 'Cód. país/región';
        }
        field(39; "Blocked"; Enum "Customer Blocked")
        {
            trigger OnValidate()
            var
                IntercambioxEmpresa: Record 7001119;
            BEGIN
                IntercambioxEmpresa.SETRANGE("Código Intercambio", "No.");
                IntercambioxEmpresa.ModifyAll(Blocked, "Blocked");
            END;
        }
        field(47; "Payment Method Code"; Code[10])
        {
            TableRelation = "Payment Method".Code WHERE("Cobro/Pagos/Ambos" = FILTER('Cobro|Ambos'),
                                                                    Visible = CONST(true));
            Caption = 'Cód. forma pago';
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Fecha últ. modificación';
            Editable = false;
        }
        field(55; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Filtro fecha';
        }
        field(84; "Fax No."; Text[30]) { Caption = 'Nº fax'; }
        field(86; "VAT Registration No."; Text[20])
        {

            Caption = 'CIF/NIF';
            trigger OnValidate()
            VAR
                VATRegNoFormat: Record 381;
            BEGIN
                VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", "No.", DATABASE::Customer);
            END;
        }
        field(91; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            //TestTableRelation=false;
            Caption = 'C.P.';
            trigger OnValidate()
            BEGIN
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", false);
            END;

            trigger OnLookup()
            BEGIN
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            END;

        }
        field(92; "County"; Text[30]) { Caption = 'Provincia'; }
        field(102; "E-Mail"; Text[80]) { Caption = 'Correo electrónico'; }
        field(103; "Home Page"; Text[80]) { Caption = 'Página Web'; }
        field(5049; "Primary Contact No."; Code[20])
        {
            TableRelation = Contact;
            Caption = 'Nº contacto principal';
            trigger OnValidate()
            VAR
                Cont: Record 5050;
                ContBusRel: Record 5054;
            BEGIN
            END;

            trigger OnLookup()
            VAR
                Cont: Record 5050;
                ContBusRel: Record 5054;
            BEGIN
            END;
        }

        field(60018; "E-Mail-Facturación"; Text[80]) { Caption = 'Correo Facturación'; }
    }
    KEYS
    {
        Key(P; "No.") { Clustered = true; }
        Key(A; "Search Name") { }
        Key(B; "Country/Region Code") { }
        Key(C; Name, Address, City) { }
        Key(D; "VAT Registration No.") { }
        Key(E; "Search Name", Address) { }
    }



    trigger OnInsert()
    VAR
        rSelf: Record 7001118;
        Num: Code[20];
    BEGIN
        if "No." = '' THEN BEGIN
            Num := 'INT000001';
            if rSelf.FINDLAST THEN Num := rSelf."No.";
            IncrementNoText(Num, 10);

        END;
    END;

    trigger OnModify()
    BEGIN
        "Last Date Modified" := TODAY;
    END;

    trigger OnDelete()
    VAR
        Detalle: Record 7001119;
    BEGIN
        Detalle.SETRANGE(Detalle."Código Intercambio", "No.");
        Detalle.DELETEALL(TRUE);
    END;

    trigger OnRename()
    BEGIN
        "Last Date Modified" := TODAY;
        ERROR('No se puede renombrar');
    END;

    VAR
        SalesSetup: Record 311;
        PostCode: Record 225;
#if CLEAN24
#pragma warning disable AL0432
        NoSeriesMgt: Codeunit NoSeriesManagement;
#pragma warning restore AL0432
#else
        NoSeriesMgt: Codeunit "No. Series";
#endif

    PROCEDURE DisplayMap();
    VAR
        MapPoint: Record 800;
        MapMgt: Codeunit 802;
    BEGIN
        if MapPoint.FIND('-') THEN
            MapMgt.MakeSelection(DATABASE::Customer, GETPOSITION);
    END;

    procedure IncrementNoText(var No: Code[20]; IncrementByNo: Decimal)
    var
        BigIntNo: BigInteger;
        BigIntIncByNo: BigInteger;
        StartPos: Integer;
        EndPos: Integer;
        NewNo: Code[20];
    begin
        GetIntegerPos(No, StartPos, EndPos);
        Evaluate(BigIntNo, CopyStr(No, StartPos, EndPos - StartPos + 1));
        BigIntIncByNo := IncrementByNo;
        NewNo := CopyStr(Format(BigIntNo + BigIntIncByNo, 0, 1), 1, MaxStrLen(NewNo));
        ReplaceNoText(No, NewNo, 0, StartPos, EndPos);
    end;

    local procedure GetIntegerPos(No: Code[20]; var StartPos: Integer; var EndPos: Integer)
    var
        IsDigit: Boolean;
        i: Integer;
    begin
        StartPos := 0;
        EndPos := 0;
        if No <> '' then begin
            i := StrLen(No);
            repeat
                IsDigit := No[i] in ['0' .. '9'];
                if IsDigit then begin
                    if EndPos = 0 then
                        EndPos := i;
                    StartPos := i;
                end;
                i := i - 1;
            until (i = 0) or (StartPos <> 0) and not IsDigit;
        end;
    end;

    local procedure ReplaceNoText(var No: Code[20]; NewNo: Code[20]; FixedLength: Integer; StartPos: Integer; EndPos: Integer)
    var
        StartNo: Code[20];
        EndNo: Code[20];
        ZeroNo: Code[20];
        NewLength: Integer;
        OldLength: Integer;
        NumberLengthErr: Label 'The number %1 cannot be extended to more than 20 characters.', Comment = '%1=No.';
    begin
        if StartPos > 1 then
            StartNo := CopyStr(CopyStr(No, 1, StartPos - 1), 1, MaxStrLen(StartNo));
        if EndPos < StrLen(No) then
            EndNo := CopyStr(CopyStr(No, EndPos + 1), 1, MaxStrLen(EndNo));
        NewLength := StrLen(NewNo);
        OldLength := EndPos - StartPos + 1;
        if FixedLength > OldLength then
            OldLength := FixedLength;
        if OldLength > NewLength then
            ZeroNo := CopyStr(PadStr('', OldLength - NewLength, '0'), 1, MaxStrLen(ZeroNo));
        if StrLen(StartNo) + StrLen(ZeroNo) + StrLen(NewNo) + StrLen(EndNo) > 20 then
            Error(NumberLengthErr, No);
        No := CopyStr(StartNo + ZeroNo + NewNo + EndNo, 1, MaxStrLen(No));
    end;
}
