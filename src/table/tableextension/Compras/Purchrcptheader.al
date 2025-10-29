/// <summary>
/// TableExtension Purch. Rcpt. HeaderKuara (ID 80173) extends Record Purch. Rcpt. Header.
/// </summary>
tableextension 80173 "Purch. Rcpt. HeaderKuara" extends "Purch. Rcpt. Header"
{
    fields
    {
        modify("Order No.")
        {
            TableRelation = "Purchase Header"."No." where("No." = field("Order No."), "Document Type" = Const(Order));

        }
        field(50017; "Nº Contrato Venta"; CODE[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."No." WHERE("Document Type" = CONST(Order), "Nº Proyecto" = FIELD("Nº Proyecto")));
            TableRelation = "Sales Header" where("Document Type" = const(Order));

        }
        field(50075; "Nº Proyecto"; CODE[20]) { TableRelation = Job; }
        field(50077; "Banco"; CODE[20]) { TableRelation = "Bank Account"; }
        field(50079; "Genera Prev. de pagos"; Boolean) { }
        field(50080; "Forzar Traspaso"; Boolean) { }
        field(51040; "Shortcut Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';

        }
        field(51041; "Shortcut Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';

        }
        field(51042; "Shortcut Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';

        }
        field(54001; "Contabilizado"; Boolean) { }
        field(54002; "Facturado"; Boolean) { }
        field(54003; "Finalizado"; Boolean) { }
        field(54004; "Finalizado2"; Boolean) { }
        field(54060; "Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purch. Rcpt. Line".Amount WHERE("Document No." = FIELD("No.")));
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";

        }
        field(54061; "Amount Including VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purch. Rcpt. Line"."Amount Including VAT" WHERE("Document No." = FIELD("No.")));
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(54104; "Importe Facturado"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purch. Rcpt. Line"."Importe Facturado" WHERE("Document No." = FIELD("No.")));
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(54105; "Importe Pte Facturar"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purch. Rcpt. Line"."Importe Pte Facturar" WHERE("Document No." = FIELD("No.")));
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(54106; "No Factura"; CODE[20]) { }
        field(55017; "Vendedor"; CODE[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Job."Cód. vendedor" WHERE("No." = FIELD("Nº Proyecto")));
            TableRelation = "Salesperson/Purchaser";
        }
        field(80000; "Tipo factura SII"; CODE[2]) { }
        field(80002; "Clave registro SII recibidas"; CODE[2]) { }
        field(80006; "Descripción operación"; TEXT[250]) { }
        field(80008; "Reportado SII"; Boolean) { }
        field(80009; "Nombre fichero SII"; TEXT[250]) { }
        field(80010; "Fecha/hora subida fichero SII"; DateTime) { }
        field(50018; "Factura Pasada"; Boolean)
        {

        }
    }
    trigger OnAfterDelete()
    var
        Control: Codeunit "ControlProcesos";
    begin
        if Contabilizado then
            Control.BORRCAALB();

    end;

    procedure DescripcionProyecto(OrderNo: Code[20]): Text
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        if PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, OrderNo) then
            exit(PurchaseHeader."Descripcion proyecto");
    end;

    PROCEDURE TraeNombreProyecto(numproy: Code[20]): Text[100];
    VAR
        rProy: Record 167;
    BEGIN
        if rProy.GET(numproy) THEN
            EXIT(rProy.Description);
    END;

    PROCEDURE TraeFechaProy(fi: Text[1]): Date;
    VAR
        r36: Record 36;
    BEGIN
        Rec.CALCFIELDS("Nº Contrato Venta");
        if r36.GET(r36."Document Type"::Order, Rec."Nº Contrato Venta") THEN BEGIN
            if fi = 'I' THEN EXIT(r36."Fecha inicial proyecto");
            if fi = 'F' THEN EXIT(r36."Fecha fin proyecto");
        END;
        EXIT(0D);
    END;

    PROCEDURE eContabilizado(No: Code[20]): Decimal;
    VAR
        r17: Record "G/L Entry";
        Importe: Decimal;
    BEGIN
        r17.SETCURRENTKEY(r17."Document No.");
        r17.SETRANGE(r17."Document No.", No);
        if r17.FINDFIRST THEN
            REPEAT
                if (COPYSTR(r17."G/L Account No.", 1, 1) = '6') OR (COPYSTR(r17."G/L Account No.", 1, 1) = '2') THEN Importe := Importe + r17.Amount;
            UNTIL r17.NEXT = 0;
        EXIT(Importe);
    END;

    PROCEDURE eFacturado(No: Code[20]): Decimal;
    VAR
        r121: Record "Purch. Rcpt. Line";
        Importe: Decimal;
    BEGIN
        if eFacturado2(Rec."No.") = eContabilizado(No) THEN EXIT(eFacturado2(No));
        r121.SETRANGE(r121."Document No.", No);
        if r121.FINDFIRST THEN
            REPEAT
                Importe := Importe + r121."Quantity Invoiced" * r121."Direct Unit Cost"
                * (1 - r121."Line Discount %" / 100);
            UNTIL r121.NEXT = 0;
        if Pasada(Rec."No.") THEN
            EXIT(Importe);
    END;

    PROCEDURE Pasada(No: Code[20]): Boolean;
    VAR
        r123: Record 123;
        r122: Record "Purch. Inv. Header";
        r125: Record 125;
        r25: Record 25;
    BEGIN
        r25.SETCURRENTKEY(r25."Document No.");
        r25.SETRANGE(r25."Document No.", No);
        if r25.FINDFIRST THEN EXIT(TRUE);

        r123.SETCURRENTKEY(r123.Description);
        r123.SETFILTER(r123.Description, '%1', '*' + No + '*');
        if NOT r123.FINDFIRST THEN BEGIN
            r125.SETCURRENTKEY(r125.Description);
            r125.SETFILTER(r125.Description, '%1', '*' + No + '*');
            if NOT r125.FINDFIRST THEN EXIT(FALSE);
            EXIT(TRUE);
        END;
        if NOT r122.GET(r123."Document No.") THEN
            EXIT(FALSE);
        EXIT(TRUE);
    END;

    PROCEDURE eFacturado2(No: Code[20]): Decimal;
    VAR
        r17: Record "G/L Entry";
        Importe: Decimal;
    BEGIN
        r17.SETCURRENTKEY("G/L Account No.", "Document No.", "Posting Date", "Tax Area Code");
        r17.SETRANGE(r17."Tax Area Code", No);
        r17.SETFILTER(r17."Document No.", '<>%1', No);
        r17.SETRANGE(r17."G/L Account No.", '40090000', '40099999');
        if r17.FINDFIRST THEN BEGIN
            r17.CALCSUMS(Amount);
            Importe := r17.Amount;
        END;
        r17.SETCURRENTKEY("G/L Account No.", "Document No.", "Posting Date", "Tax Area Code");
        r17.SETRANGE(r17."Tax Area Code", No);
        r17.SETFILTER(r17."Document No.", '<>%1', No);
        r17.SETRANGE(r17."G/L Account No.", '41090000', '41099999');
        if r17.FINDFIRST THEN BEGIN
            r17.CALCSUMS(Amount);
            Importe += r17.Amount;
        END;

        EXIT(Importe);
    END;

    procedure Pdte(No: Code[20]; PostingDate: Text; Empresa: Text[30]): Decimal
    var
        T: Decimal;
        r17: Record "G/L Entry";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin


        r17.CHANGECOMPANY(Empresa);
        r17.SETCURRENTKEY("Posting Date", r17."G/L Account No.", r17."Document No.");
        if PostingDate <> '' then
            r17.SETFILTER(r17."Posting Date", PostingDate);

        r17.SETRANGE(r17."Document No.", No);
        r17.SETRANGE("G/L Account No.", '4009', '40099');
        if r17.FINDFIRST THEN r17.CALCSUMS(r17.Amount);
        T := T + r17.Amount;
        r17.SETRANGE("G/L Account No.", '4109', '41099');
        if r17.FINDFIRST THEN BEGIN
            r17.CALCSUMS(r17.Amount);
            T := T + r17.Amount;
        END;
        r17.SETCURRENTKEY("Posting Date", r17."G/L Account No.", r17."Tax Area Code");
        r17.SETRANGE(r17."Document No.");
        r17.SETRANGE("Tax Area Code", No);
        r17.SETRANGE("G/L Account No.", '4009', '40099');
        if r17.FINDFIRST THEN r17.CALCSUMS(r17.Amount);
        T := T + r17.Amount;
        r17.SETRANGE("G/L Account No.", '4109', '41099');
        if r17.FINDFIRST THEN BEGIN
            r17.CALCSUMS(r17.Amount);
            T := T + r17.Amount;
        END;
        EXIT(T);
    end;




}