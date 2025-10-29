/// <summary>
/// Page Cabecera Prestamo (ID 50046).
/// </summary>
page 50046 "Cabecera Prestamo"
{
    SourceTable = "Cabecera Prestamo";
    SourceTableView = WHERE(Empresa = FILTER(''), Renting = const(false));
    PageType = Card;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Código Del Prestamo"; Rec."Código Del Prestamo") { ApplicationArea = All; }
                field(Descripción; Rec."Cabecera Prestamo2") { ApplicationArea = All; }
                field("Fecha Préstamo"; Rec."Fecha Préstamo") { ApplicationArea = All; }
                field("Fecha 1ª Amortización"; Rec."Fecha 1ª Amortización") { ApplicationArea = All; }
                field("Importe Prestamo"; Rec."Importe Prestamo") { ApplicationArea = All; }
                field(Años; Rec."Años") { ApplicationArea = All; }
                field("Cuotas Anuales"; Rec."Cuotas Anuales") { ApplicationArea = All; }
                field("Interes Anual"; Rec."Interes Anual") { ApplicationArea = All; }
                field("Cuenta L/P"; Rec."Cuenta L/P") { ApplicationArea = All; }
                field("Cuenta C/P"; Rec."Cuenta c/P") { ApplicationArea = All; }
                field("Cuenta intrereses"; Rec."Cuenta intrereses") { ApplicationArea = All; }
                field("Cuenta Gastos"; Rec."Cuenta Gastos") { ApplicationArea = All; }
                field(Banco; Rec.Banco) { ApplicationArea = All; }
                field(Meses; Rec.Meses) { ApplicationArea = All; }
                field(Leasing; Rec.Leasing) { ApplicationArea = All; }
                field("Proveedor Leasing"; Rec."Proveedor Leasing") { ApplicationArea = All; }
                field(Iva; Rec.Iva) { ApplicationArea = All; }
                field("Valor Residual"; Rec."Valor Residual") { ApplicationArea = All; }
                field("En vigor"; Rec."En vigor") { }
            }
            part(Fdet; "Detalle Prestamo")
            {
                ApplicationArea = All;
                SubPageLink = "Código Del Prestamo" = field("Código Del Prestamo");
            }

        }
    }
    actions
    {
        area(Processing)
        {
            group("Ac&ciones")
            {

                Caption = 'Ac&ciones';

                action("Calcular")
                {

                    ApplicationArea = All;
                    Image = Calculate;
                    ShortCutKey = F9;
                    Caption = 'Calcular';
                    trigger OnAction()
                    VAR
                        r5801: Record "Detalle Prestamo";
                        t: Integer;
                        CP: Decimal;
                        i: Decimal;
                        n: Decimal;
                        D: Decimal;
                        R: Decimal;
                        Divisor: Decimal;
                        Dividendo: Decimal;
                        r5801t: Record "Detalle Prestamo" TEMPORARY;
                        Liq: Boolean;
                    BEGIN
                        if NOT CONFIRM('Esta Seguro?', FALSE) THEN EXIT;
                        r5801.SETRANGE(r5801."Código Del Prestamo", Rec."Código Del Prestamo");
                        if r5801.FIND('-') THEN
                            REPEAT
                                r5801t := r5801;
                                r5801t.INSERT;
                            UNTIL r5801.NEXT = 0;
                        r5801.DELETEALL;
                        CP := Rec."Importe Prestamo";
                        D := CP;
                        i := Rec."Interes Anual" / 100 / Rec."Cuotas Anuales";
                        n := Rec.Meses;//Años*"Cuotas Anuales";
                        Divisor := (POWER(1 + i, n) - 1);
                        Dividendo := i * POWER(1 + i, n);
                        R := D / (Divisor / Dividendo);
                        FOR t := 1 TO Rec.Meses DO BEGIN
                            r5801.INIT;
                            Liq := FALSE;
                            if r5801t.GET(Rec."Código Del Prestamo", t) THEN BEGIN
                                if r5801t."% Intereses" <> 0 THEN i := r5801t."% Intereses" / 100 / Rec."Cuotas Anuales";
                                Liq := r5801t.Liquidado;
                            END;
                            if Liq THEN BEGIN
                                r5801 := r5801t;
                                CP := r5801."Capital Pendiente";
                                CP := CP - r5801.Amortización;
                            END ELSE BEGIN
                                r5801."Código Del Prestamo" := Rec."Código Del Prestamo";
                                r5801."No. Periodo" := t;
                                if t > 1 THEN
                                    r5801.Fecha := CALCDATE(FORMAT(t - 1) + 'M', Rec."Fecha 1ª Amortización")
                                ELSE
                                    r5801.Fecha := Rec."Fecha 1ª Amortización";
                                r5801."Capital Pendiente" := CP;
                                D := CP;
                                n := Rec.Meses - t + 1;//Años*"Cuotas Anuales";
                                Divisor := (POWER(1 + i, n) - 1);
                                Dividendo := (D * i * POWER(1 + i, n)) - (Rec."Valor Residual" * i);
                                if Dividendo = 0 THEN
                                    R := 0 ELSE
                                    if Dividendo / Divisor = 0 THEN
                                        R := 0 ELSE
                                        R := Dividendo / Divisor;//D/(Divisor/Dividendo);

                                // r5801.VALIDATE("Total Liquidación",R);
                                r5801."Total Liquidación" := R;
                                r5801.Intereses := CP * i;
                                if r5801.Fecha >= Rec."Fecha 1ª Amortización" THEN
                                    r5801.Amortización := R - r5801.Intereses;
                                CP := CP - r5801.Amortización;
                                r5801."A Pagar" := (r5801."Total Liquidación" + r5801.Gastos) * (1 + Rec.Iva / 100);
                                r5801."% Intereses" := i * Rec."Cuotas Anuales" * 100;
                            END;
                            r5801.INSERT;
                        END;
                    END;
                }
                action("Formalización")
                {
                    ApplicationArea = All;
                    Image = Agreement;
                    Caption = 'Formalización';
                    trigger OnAction()
                    BEGIN
                        recLinDiario.INIT;
                        CLEAR(recLinDiario);
                        SeccionDIario.GET('GENERAL', 'GENERICO');
                        recLinDiario.SETRANGE(recLinDiario."Journal Template Name", 'GENERAL');
                        recLinDiario.SETRANGE(recLinDiario."Journal Batch Name", 'GENERICO');
                        a := 10000;
                        if recLinDiario.FIND('+') THEN a := recLinDiario."Line No." + 10000;
                        recLinDiario."Line No." := a;
                        recLinDiario."Posting Date" := Rec."Fecha Préstamo";
                        recLinDiario."Journal Template Name" := 'GENERAL';
                        recLinDiario."Journal Batch Name" := 'GENERICO';
                        SeccionDIario.TESTFIELD("No. Series");
                        recLinDiario."Document No." := NumeroSerie.GetNextNo(SeccionDIario."No. Series", 0D, FALSE);
                        recLinDiario."Account Type" := recLinDiario."Account Type"::"G/L Account";
                        recLinDiario."Account No." := Rec."Cuenta L/P";
                        recLinDiario.Description := 'Formalización Prestamo';
                        recLinDiario.VALIDATE("Credit Amount", Rec."Importe Prestamo");
                        recLinDiario."Bal. Account Type" := recLinDiario."Bal. Account Type"::"G/L Account";
                        recLinDiario."Bal. Account No." := '';
                        recLinDiario.INSERT;
                        a := a + 10000;
                        recLinDiario."Line No." := a;
                        recLinDiario."Account Type" := recLinDiario."Account Type"::"Bank Account";
                        recLinDiario."Account No." := Rec.Banco;
                        recLinDiario.VALIDATE("Debit Amount", Rec."Importe Prestamo");
                        recLinDiario.INSERT;
                        COMMIT;

                        GenJnlManagement.OpenJnl(SeccionDIario.Name, recLinDiario);
                    END;
                }
                action("De L/P a C/P")
                {
                    ApplicationArea = All;
                    Image = Aging;
                    Caption = 'De L/P a C/P';
                    trigger OnAction()
                    BEGIN
                        rDet.SETRANGE(rDet."Código Del Prestamo", Rec."Código Del Prestamo");
                        rDet.SETRANGE(rDet.Fecha, CALCDATE('PA+1D-1A', WORKDATE), CALCDATE('PA', WORKDATE));
                        Import := 0;
                        if rDet.FIND('-') THEN
                            REPEAT
                                Import := Import + rDet.Amortización;
                            UNTIL rDet.NEXT = 0;
                        if Import <> 0 THEN BEGIN
                            recLinDiario.INIT;
                            CLEAR(recLinDiario);
                            SeccionDIario.GET('GENERAL', 'GENERICO');
                            recLinDiario.SETRANGE(recLinDiario."Journal Template Name", 'GENERAL');
                            recLinDiario.SETRANGE(recLinDiario."Journal Batch Name", 'GENERICO');
                            a := 10000;
                            if recLinDiario.FIND('+') THEN a := recLinDiario."Line No." + 10000;
                            recLinDiario."Line No." := a;
                            if Rec."Fecha Préstamo" > WORKDATE THEN
                                recLinDiario."Posting Date" := Rec."Fecha Préstamo"
                            ELSE
                                recLinDiario."Posting Date" := CALCDATE('PA+1D-1A', WORKDATE);
                            recLinDiario."Journal Template Name" := 'GENERAL';
                            recLinDiario."Journal Batch Name" := 'GENERICO';
                            SeccionDIario.TESTFIELD("No. Series");
                            recLinDiario."Document No." := NumeroSerie.GetNextNo(SeccionDIario."No. Series", 0D, FALSE);
                            recLinDiario."Account Type" := recLinDiario."Account Type"::"G/L Account";
                            recLinDiario."Account No." := Rec."Cuenta L/P";
                            recLinDiario.Description := 'De largo plazo a corto';
                            recLinDiario.VALIDATE("Debit Amount", Import);
                            recLinDiario."Bal. Account Type" := recLinDiario."Bal. Account Type"::"G/L Account";
                            recLinDiario."Bal. Account No." := '';
                            recLinDiario.INSERT;
                            a := a + 10000;
                            recLinDiario."Line No." := a;
                            recLinDiario."Account No." := Rec."Cuenta c/P";
                            recLinDiario.VALIDATE("Credit Amount", Import);
                            recLinDiario.INSERT;
                            COMMIT;
                            GenJnlManagement.OpenJnl(SeccionDIario.Name, recLinDiario);
                        END;
                    END;
                }
                action("Cuota Mensual")
                {
                    ApplicationArea = All;
                    Image = CalculateDepreciation;
                    ShortCutKey = F11;
                    Caption = 'Cuota Mensual';
                    trigger OnAction()
                    VAR
                        r38: Record 38;
                        r39: Record 39;
                        rGp: Record 325;
                    BEGIN
                        CurrPage.Fdet.Page.GETRECORD(rDet);
                        if Rec.Iva <> 0 THEN BEGIN
                            r38.INIT;
                            r38."Document Type" := r38."Document Type"::Invoice;
                            r38."No." := '';
                            r38."Posting Date" := WORKDATE;
                            r38."Order Date" := WORKDATE;
                            r38."Document Date" := WORKDATE;
                            r38.VALIDATE("Buy-from Vendor No.", Rec."Proveedor Leasing");
                            r38.INSERT(TRUE);
                            r38.VALIDATE("Posting Date", WORKDATE);
                            r38.MODIFY;
                            a := 10000;
                            r39."Document Type" := r39."Document Type"::Invoice;
                            r39."Document No." := r38."No.";
                            r39."Line No." := a;
                            r39.INSERT(TRUE);
                            r39.Type := r39.Type::"G/L Account";
                            r39.VALIDATE("No.", Rec."Cuenta c/P");
                            r39.Description := COPYSTR('Cuota ' + rDet."Código Del Prestamo" + ' per.' + FORMAT(rDet."No. Periodo"), 1,
                            MAXSTRLEN(r39.Description));
                            rGp.SETRANGE(rGp."VAT %", Rec.Iva);
                            rGp.FINDLAST;
                            r39."Gen. Prod. Posting Group" := 'EXTERIOR';
                            r39.VALIDATE("VAT Prod. Posting Group", rGp."VAT Prod. Posting Group");
                            r39.VALIDATE(Quantity, 1);
                            r39.VALIDATE("Direct Unit Cost", ROUND(rDet.Amortización, 0.01, '='));
                            r39.MODIFY;
                            a := a + 10000;
                            r39."Document Type" := r39."Document Type"::Invoice;
                            r39."Document No." := r38."No.";
                            r39."Line No." := a;
                            r39.INSERT(TRUE);
                            r39.Type := r39.Type::"G/L Account";
                            r39.VALIDATE("No.", Rec."Cuenta intrereses");
                            r39.Description := COPYSTR('Cuota ' + rDet."Código Del Prestamo" + ' per.' + FORMAT(rDet."No. Periodo"), 1,
                            MAXSTRLEN(r39.Description));
                            r39."Gen. Prod. Posting Group" := 'EXTERIOR';
                            r39.VALIDATE("VAT Prod. Posting Group", rGp."VAT Prod. Posting Group");
                            r39.VALIDATE("Direct Unit Cost", ROUND(rDet.Intereses, 0.01, '='));
                            r39.MODIFY;
                            if rDet.Gastos <> 0 THEN BEGIN
                                a := a + 10000;
                                r39."Line No." := a;
                                r39."Document Type" := r39."Document Type"::Invoice;
                                r39."Document No." := r38."No.";
                                r39.INSERT(TRUE);
                                r39.Type := r39.Type::"G/L Account";
                                r39.VALIDATE("No.", Rec."Cuenta Gastos");
                                r39.VALIDATE(Quantity, 1);
                                r39.Description := COPYSTR('Cuota ' + rDet."Código Del Prestamo" + ' per.' + FORMAT(rDet."No. Periodo"), 1,
                                MAXSTRLEN(r39.Description));
                                r39."Gen. Prod. Posting Group" := 'EXTERIOR';
                                r39.VALIDATE("VAT Prod. Posting Group", rGp."VAT Prod. Posting Group");
                                r39.VALIDATE("Direct Unit Cost", rDet.Gastos);
                                r39.MODIFY;
                            END;
                            // { a:=a+10000;
                            //     r39."Line No.":=a;
                            //     r39."Account Type":=r39."Account Type"::"Bank Account";
                            //     r39."Account No." :=Banco;
                            //     r39.Validate(Quantity,1);
                            //     r39.VALIDATE("Credit Amount",rDet."A Pagar");
                            //     r39.INSERT;            }
                            rDet.Liquidado := TRUE;
                            rDet.MODIFY;
                            COMMIT;
                            Page.RUNMODAL(51, r38);
                        END ELSE BEGIN
                            recLinDiario.INIT;
                            CLEAR(recLinDiario);
                            SeccionDIario.GET('GENERAL', 'GENERICO');
                            recLinDiario.SETRANGE(recLinDiario."Journal Template Name", 'GENERAL');
                            recLinDiario.SETRANGE(recLinDiario."Journal Batch Name", 'GENERICO');
                            a := 10000;
                            if recLinDiario.FIND('+') THEN a := recLinDiario."Line No." + 10000;
                            recLinDiario."Line No." := a;
                            recLinDiario."Posting Date" := rDet.Fecha;
                            recLinDiario."Journal Template Name" := 'GENERAL';
                            recLinDiario."Journal Batch Name" := 'GENERICO';
                            SeccionDIario.TESTFIELD("No. Series");
                            recLinDiario."Document No." := NumeroSerie.GetNextNo(SeccionDIario."No. Series", 0D, FALSE);
                            recLinDiario."Account Type" := recLinDiario."Account Type"::"G/L Account";
                            recLinDiario."Account No." := Rec."Cuenta c/P";
                            recLinDiario.Description := COPYSTR('Cuota ' + rDet."Código Del Prestamo" + ' per.' + FORMAT(rDet."No. Periodo"), 1,
                            MAXSTRLEN(recLinDiario.Description));
                            recLinDiario.VALIDATE("Debit Amount", rDet.Amortización);
                            recLinDiario."Bal. Account Type" := recLinDiario."Bal. Account Type"::"G/L Account";
                            recLinDiario."Bal. Account No." := '';
                            recLinDiario.INSERT;
                            a := a + 10000;
                            recLinDiario."Line No." := a;
                            recLinDiario."Account No." := Rec."Cuenta intrereses";
                            recLinDiario.VALIDATE("Debit Amount", rDet.Intereses);
                            recLinDiario.INSERT;
                            if rDet.Gastos <> 0 THEN BEGIN
                                a := a + 10000;
                                recLinDiario."Line No." := a;
                                recLinDiario."Account No." := Rec."Cuenta Gastos";
                                recLinDiario.VALIDATE("Debit Amount", rDet.Gastos);
                                recLinDiario.INSERT;
                            END;
                            a := a + 10000;
                            recLinDiario."Line No." := a;
                            recLinDiario."Account Type" := recLinDiario."Account Type"::"Bank Account";
                            recLinDiario."Account No." := Rec.Banco;
                            recLinDiario.VALIDATE("Credit Amount", rDet."A Pagar");
                            recLinDiario.INSERT;
                            rDet.Liquidado := TRUE;
                            rDet.MODIFY;
                            COMMIT;
                            GenJnlManagement.OpenJnl(SeccionDIario.Name, recLinDiario);
                        END;
                    END;
                }
                action("Cuadrar Prestamo")
                {
                    Image = AdjustEntries;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        Pendiente: Decimal;
                        Detalle: Record "Detalle Prestamo";
                    begin
                        Pendiente := Pend(Rec);
                        if Pendiente <> 0 then begin
                            Detalle.SetRange("Código Del Prestamo", Rec."Código Del Prestamo");
                            if Detalle.FindLast() Then begin
                                Detalle.Validate("Amortización", Detalle."Amortización" + Pendiente);
                                Detalle.Modify();
                            end;
                        end;
                    end;
                }
            }
        }
        area(Navigation)
        {
            group("&Prestamo")

            {
                Caption = '&Prestamo';
                action(Lista)
                {
                    ApplicationArea = All;
                    Image = List;
                    ShortCutKey = F5;
                    Caption = 'Lista';
                    RunObject = page "Lista Prestamos";
                }
                action(Dimensiones)
                {
                    ApplicationArea = All;
                    Image = Dimensions;
                    ShortCutKey = 'Mayús+Ctrl+D';
                    Caption = 'Dimensiones';
                    RunObject = Page 540;
                    RunPageLink = "Table ID" = CONST(50067),
                            "No." = FIELD("Código Del Prestamo");
                }
                action("Resumen")
                {
                    ApplicationArea = All;
                    Image = Revenue;
                    ShortCutKey = 'Mayús+F9';
                    Caption = 'Resumen';
                    RunObject = Page Prestamos;
                }
            }
        }
    }
    VAR
        recLinDiario: Record "Gen. Journal Line";
        SeccionDIario: Record "Gen. Journal Batch";
#if CLEAN24
#pragma warning disable AL0432
        NumeroSerie: Codeunit NoSeriesManagement;
#pragma warning restore AL0432
#else
        NumeroSerie: Codeunit "No. Series";
#endif
        a: Integer;
        GenJnlManagement: Codeunit 230;
        rDet: Record "Detalle Prestamo";
        Import: Decimal;
        DefEmpresa: Text[30];

    trigger OnNewRecord(BelowxRex: Boolean)
    begin
        Rec.Renting := false;
    end;

    trigger onOpenPage()
    var
        Control: Codeunit ControlProcesos;
    begin
        If Control.AccesoProibido_Empresas(CompanyName, 'RESTRINGIDO') then
            Error('No tiene permisos para acceder a este punto del menú en esta empresa');

        if DefEmpresa <> '' THEN BEGIN
            Rec.CHANGECOMPANY(DefEmpresa);
            CurrPage.Fdet.Page.Empresa(DefEmpresa);
        END;
    END;

    PROCEDURE Pend(var Cab: Record "Cabecera Prestamo"): Decimal;
    BEGIN
        Cab.CALCFIELDS(Liquidado);
        if Cab.GETFILTER("Filtro Fecha Liquidación") <> '' THEN
            if CAb."Fecha Préstamo" > Cab.GETRANGEMAX("Filtro Fecha Liquidación") THEN EXIT(0);
        EXIT(Cab."Importe Prestamo" - Cab.Liquidado);
    END;

    PROCEDURE Empresa(Cia: Text[30]);
    BEGIN
        DefEmpresa := Cia;
    END;

    //     BEGIN
    //     END.
    //   }
}
