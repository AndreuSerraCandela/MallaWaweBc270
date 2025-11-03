/// <summary>
/// Page Estadisticas Venta (ID 50048).
/// </summary>
page 50048 "Estadisticas Venta"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "G/L Entry";
    SourceTableView = SORTING("G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date")
                    WHERE("G/L Account No." = FILTER(7 .. 8));
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field(Año; FORMAT(Rec."Posting Date", 0, '<Year4>')) { ApplicationArea = all; }
                field(Mes; FORMAT(Rec."Posting Date", 0, '<Month,2>')) { ApplicationArea = all; }
                field("Día"; FORMAT(Rec."Posting Date", 0, '<Day,2>')) { ApplicationArea = all; }
                field(Fecha; Rec."Posting Date") { ApplicationArea = all; }
                field("Cód. Vendedor"; Rec."Sales/Person Code") { ApplicationArea = all; }
                field(Vendedor; NVendedor) { ApplicationArea = all; }
                field(Contrato; NContrato) { ApplicationArea = all; }
                field("Número docuemto"; Rec."Document No.") { ApplicationArea = all; }
                field("Forma de pago"; FP) { ApplicationArea = all; }
                field(Cuenta; Rec."G/L Account No.") { ApplicationArea = all; }
                field("Nombre Cuenta"; NCuenta) { ApplicationArea = all; }
                field("Cód. Cliente"; Rec."Source No.") { ApplicationArea = all; }
                field("Nombre Cliente"; NCliente) { ApplicationArea = all; }
                field("Descripción Ampliada"; DescriptionA) { ApplicationArea = all; }
                field(Departamento; Rec."Global Dimension 1 Code") { ApplicationArea = all; }
                field("Descripción Departamento"; DescripCionDim(1, Rec."Global Dimension 1 Code")) { ApplicationArea = all; }
                field(Principal; Rec."Global Dimension 3 Code") { ApplicationArea = all; }
                field("Descripción Principal"; DescripCionDim(3, Rec."Global Dimension 3 Code")) { ApplicationArea = all; }
                field(Zona; Rec."Global Dimension 4 Code") { ApplicationArea = all; }
                field("Descripción Zona"; DescripCionDim(4, Rec."Global Dimension 4 Code")) { ApplicationArea = all; }
                field(Soporte; Rec."Global Dimension 5 Code") { ApplicationArea = all; }
                field("Descripción Soporte"; DescripCionDim(5, Rec."Global Dimension 5 Code")) { ApplicationArea = all; }
                field(Importe; Rec.Amount) { ApplicationArea = all; }
            }
        }
    }


    PROCEDURE NVendedor(): Text[50];
    VAR
        ven: Record 13;
    BEGIN
        if ven.GET(Rec."Sales/Person Code") THEN EXIT(ven.Name);
    END;

    PROCEDURE DescriptionA(): Text[1024];
    VAR
        rCli: Record Customer;
        rVen: Record Vendor;
    BEGIN
        if Rec."Source Type" = Rec."Source Type"::Vendor THEN
            if rVen.GET(Rec."Source No.") THEN EXIT(Rec.Description + '-' + rVen.Name);
        if Rec."Source Type" = Rec."Source Type"::Customer THEN
            if rCli.GET(Rec."Source No.") THEN EXIT(Rec.Description + '-' + rCli.Name);
    END;

    PROCEDURE NContrato(): Code[50];
    VAR
        r120: Record "Purch. Rcpt. Header";
        r112: Record 112;
        r114: Record 114;
    BEGIN
        if (Rec."Núm. Contrato" <> '') AND (Rec."Núm. Contrato" <> '--') THEN EXIT(Rec."Núm. Contrato");
        if STRLEN(Rec."Document No.") > 20 THEN EXIT('--');
        if r112.GET(Rec."Document No.") THEN EXIT(r112."Nº Contrato");
        if r114.GET(Rec."Document No.") THEN EXIT(r114."Nº Contrato");
        Rec.CALCFIELDS("Núm. Contrato");
        if (Rec."Núm. Contrato" = '--') OR (Rec."Job No." = '') THEN BEGIN
            if r120.GET(COPYSTR(Rec."Document No.", 1, MAXSTRLEN(r120."No."))) THEN BEGIN
                r120.CALCFIELDS(r120."Nº Contrato Venta");
                EXIT(r120."Nº Contrato Venta");
            END;
        END;
        if Rec."Job No." = '' THEN EXIT('--');
        EXIT(Rec."Núm. Contrato");
    END;

    PROCEDURE DescripCionDim(Dim: Integer; Code: Code[20]): Text[100];
    VAR
        r349: Record 349;
    BEGIN
        r349.SETRANGE(r349."Global Dimension No.", Dim);
        r349.SETRANGE(r349.Code, Code);
        if r349.FINDFIRST THEN BEGIN
            if r349.Name = '' THEN EXIT(r349.Code);
            EXIT(r349.Name);
        END;
    END;

    PROCEDURE NCliente(): Text[100];
    VAR
        r18: Record Customer;
    BEGIN
        if r18.GET(Rec."Source No.") THEN EXIT(r18.Name);
    END;

    PROCEDURE NCuenta(): Text[100];
    VAR
        r15: Record 15;
    BEGIN
        if r15.GET(Rec."G/L Account No.") THEN EXIT(r15.Name);
    END;

    PROCEDURE FP(): Code[20];
    VAR
        r21: Record 21;
        r120: Record "Purch. Rcpt. Header";
        r112: Record 112;
        r114: Record 114;
    BEGIN
        //if r21.GET("Entry No.") THEN EXIT(r21."Cod. Forma Pago");
        if r112.GET(Rec."Document No.") THEN EXIT(r112."Payment Method Code");
        if r114.GET(Rec."Document No.") THEN EXIT(r114."Payment Method Code");
    END;


}