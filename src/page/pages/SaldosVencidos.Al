page 7001166 "saldos vencidos clientes"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = 18;

    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Nº"; Rec."No.") { ApplicationArea = All; }
                field(Nombre; Rec.Name) { ApplicationArea = All; }
                field("Saldo en Plazo"; SaldoVdo('Ok'))
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    BEGIN
                        Drill('OK');
                    END;
                }
                field("Saldo Fuera de Plazo"; SaldoVdo('NoOk'))
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    BEGIN
                        Drill('NoOk');
                    END;
                }
                field(Total; SaldoVdoT)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    BEGIN
                        Drill('Todos');
                    END;
                }
                field(Saldo; Rec."Net Change (LCY)")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    VAR
                        CustLedgerEntry: Record 21;
                    BEGIN
                        CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", Rec."No.");
                        Rec.COPYFILTER("Date Filter", CustLedgerEntry."Posting Date");
                        Page.RUNMODAL(0, CustLedgerEntry);
                    END;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Ver Todos no vencidos")
            {
                ApplicationArea = All;
                Visible = false;
                Image = Entries;
                trigger Onaction()
                BEGIN
                    DrillT(0);
                END;
            }
            action("Ver Todos 30")
            {
                ApplicationArea = All;
                Visible = false;
                Image = Entries;
                trigger Onaction()
                BEGIN

                    DrillT(30);
                END;
            }
            action("Ver Todos 60")
            {
                ApplicationArea = All;
                Visible = false;
                Image = Entries;
                trigger Onaction()
                BEGIN

                    DrillT(60);
                END;
            }
            action("Ver Todos 90")
            {
                ApplicationArea = All;
                Visible = false;
                Image = Entries;
                trigger Onaction()
                BEGIN

                    DrillT(90);
                END;
            }
            action("Ver Todos +90")
            {
                ApplicationArea = All;
                Visible = false;
                Image = Entries;
                trigger Onaction()
                BEGIN

                    DrillT(91);
                END;
            }
            action("Ver Todos")
            {
                ApplicationArea = All;
                //Visible=false;
                Image = Entries;
                trigger Onaction()
                BEGIN

                    DrillT(92);
                END;
            }
            action(Calcular)
            {
                ApplicationArea = All;
                Image = Calculate;
                trigger OnAction()
                BEGIN
                    SaldoVdoTCalcT;
                    Calculado := TRUE;
                END;
            }
        }
    }

    VAR
        Ventana: Dialog;
        a: Integer;
        CustLedgerEntry: Record 21 TEMPORARY;
        Calculado: Boolean;
        CustLedgerEntryA: Record 21 TEMPORARY;

    PROCEDURE SaldoVdo(Per: Text[30]): Decimal;
    VAR
        DetCustLedgerEntry: Record 379;
        DetCustLedgerEntry2: Record 379;
        ImporteOk: Decimal;
        ImporteNoOk: Decimal;
    BEGIN
        if Rec.GETFILTER(Rec."Date Filter") = '' THEN EXIT(0);
        if Calculado = FALSE THEN EXIT(0);
        CustLedgerEntryA.SETRANGE(CustLedgerEntryA."Customer No.", Rec."No.");
        //if NOT CustLedgerEntry.FINDFIRST THEN
        //SaldoVdoTCalc;
        if CustLedgerEntryA.FINDFIRST THEN BEGIN
            ImporteNoOk := ImporteNoOk + CustLedgerEntryA."Remaining Amount (LCY) stats.";
            ImporteOk := ImporteOk + CustLedgerEntryA."Amount (LCY) stats.";
        END;
        if Per = 'Ok' THEN
            EXIT(ImporteOk);
        EXIT(ImporteNoOk);
    END;

    PROCEDURE Drill(Per: Text[30]);
    VAR
        DetCustLedgerEntry: Record 379;
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN EXIT;
        //Ventana.OPEN('Calculando Mov. ########1# de #########2');
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", Rec."No.");
        if NOT CustLedgerEntry.FINDFIRST THEN
            SaldoVdoTCalc;
        if Per = 'Ok' THEN
            CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", Rec.GETRANGEMAX("Date Filter") - 60, Rec.GETRANGEMAX("Date Filter"))
        ELSE
            CustLedgerEntry.SETRANGE(CustLedgerEntry."Due Date", 0D, Rec.GETRANGEMAX("Date Filter") - 61);
        if Per = 'Todos' THEN CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date");
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Remaining Amount (LCY) stats.", '<>%1', 0);
        Page.RUNMODAL(Page::"Mov. Clien Pendientes a fecha", CustLedgerEntry);
    END;

    PROCEDURE DrillT(Per: Integer);
    VAR
        DetCustLedgerEntry: Record 379;
        CustLedgerEntry: Record 21 temporary;
        CustLedgerEntryr: Record 21;
        Glentry: Record "G/L Entry";
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN EXIT;
        Ventana.OPEN('Calculando Mov. ########1# de #########2');
        DetCustLedgerEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date",
        DetCustLedgerEntry."Excluded from calculation");
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Excluded from calculation", FALSE);
        //DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Customer No.","No.");
        CASE Per OF
            0:
                BEGIN
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Initial Entry Due Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;
            30:
                BEGIN
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Initial Entry Due Date", Rec.GETRANGEMAX("Date Filter") + 1, Rec.GETRANGEMAX("Date Filter") + 30);
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;
            60:
                BEGIN
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Initial Entry Due Date", Rec.GETRANGEMAX("Date Filter") + 31, Rec.GETRANGEMAX("Date Filter") + 60);
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;
            90:
                BEGIN
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Initial Entry Due Date", Rec.GETRANGEMAX("Date Filter") + 61, Rec.GETRANGEMAX("Date Filter") + 90);
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;
            91:
                BEGIN
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Initial Entry Due Date", Rec.GETRANGEMAX("Date Filter") + 91, 99991231D);
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;
            92:
                BEGIN
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Initial Entry Due Date", 0D, 99991231D);
                    DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;

        END;
        a := 0;
        Ventana.UPDATE(2, DetCustLedgerEntry.COUNT);
        if DetCustLedgerEntry.FINDFIRST THEN
            REPEAT
                a := a + 1;
                Ventana.UPDATE(1, a);
                if NOT CustLedgerEntry.GET(DetCustLedgerEntry."Cust. Ledger Entry No.") THEN BEGIN
                    If CustLedgerEntryr.GET(DetCustLedgerEntry."Cust. Ledger Entry No.") THEN
                        CustLedgerEntry := CustLedgerEntryr;
                    CustLedgerEntry."Entry No." := DetCustLedgerEntry."Cust. Ledger Entry No.";
                    CustLedgerEntry."Remaining Amount (LCY) stats." := 0;
                    CustLedgerEntry."Amount (LCY) stats." := 0;
                    CustLedgerEntry."Due Date" := CustLedgerEntryr."Due Date";
                    If Glentry.GET(DetCustLedgerEntry."Cust. Ledger Entry No.") THEN
                        CustLedgerEntry.Cuenta := Glentry."G/L Account No."
                    ELSE
                        CustLedgerEntry.Cuenta := '';
                    CustLedgerEntry.INSERT;

                END;
                if NOT CustLedgerEntryr.GET(DetCustLedgerEntry."Cust. Ledger Entry No.") THEN CustLedgerEntryr.INIT;
                CustLedgerEntry."Customer No." := DetCustLedgerEntry."Customer No.";
                if DetCustLedgerEntry."Entry Type" = DetCustLedgerEntry."Entry Type"::"Initial Entry" THEN
                    CustLedgerEntry."Posting Date" := DetCustLedgerEntry."Posting Date";
                CustLedgerEntry."Document Type" := CustLedgerEntryr."Document Type";
                CustLedgerEntry."Document No." := CustLedgerEntryr."Document No.";
                CustLedgerEntry.Description := CustLedgerEntryr.Description;
                //CustLedgerEntry."Due Date":=CustLedgerEntry."Due Date";
                CustLedgerEntry."Remaining Amount (LCY) stats." := CustLedgerEntry."Remaining Amount (LCY) stats." +
                DetCustLedgerEntry."Amount (LCY)";
                if DetCustLedgerEntry."Entry Type" = DetCustLedgerEntry."Entry Type"::"Initial Entry" THEN
                    CustLedgerEntry."Amount (LCY) stats." := DetCustLedgerEntry."Amount (LCY)"
                ELSE
                    CustLedgerEntry."Due Date" := DetCustLedgerEntry."Posting Date";
                CustLedgerEntry.MODIFY;
            UNTIL DetCustLedgerEntry.NEXT = 0;
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Remaining Amount (LCY) stats.", '<>%1', 0);
        Ventana.CLOSE;
        page.RUNMODAL(Page::"Mov. Clien Pendientes a fecha", CustLedgerEntry);
    END;

    PROCEDURE SaldoVdoT(): Decimal;
    VAR
        DetCustLedgerEntry: Record 379;
        DetCustLedgerEntry2: Record 379;
        Importe: Decimal;
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN EXIT(0);
        DetCustLedgerEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date",
        DetCustLedgerEntry."Excluded from calculation");
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Excluded from calculation", FALSE);
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Customer No.", Rec."No.");
        //DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Entry Type",DetCustLedgerEntry."Entry Type"::"Initial Entry");
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
        //
        //DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Initial Entry Due Date",0D,Rec.GETRANGEMAX("Date Filter"));
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));

        if DetCustLedgerEntry.FINDFIRST THEN
            DetCustLedgerEntry.CALCSUMS(DetCustLedgerEntry."Amount (LCY)");
        EXIT(DetCustLedgerEntry."Amount (LCY)");
    END;

    PROCEDURE SaldoVdoTCalc(): Decimal;
    VAR
        DetCustLedgerEntry: Record 379;
        DetCustLedgerEntry2: Record 379;
        Importe: Decimal;
        Glentry: Record "G/L Entry";
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN EXIT(0);
        DetCustLedgerEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date",
        DetCustLedgerEntry."Excluded from calculation");
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Excluded from calculation", FALSE);
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Customer No.", Rec."No.");
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
        //
        //DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Initial Entry Due Date",0D,Rec.GETRANGEMAX("Date Filter"));
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", Rec."No.");
        CustLedgerEntry.DELETEALL;
        if DetCustLedgerEntry.FINDFIRST THEN
            REPEAT
                a := a + 1;
                //Ventana.UPDATE(1,a);
                if NOT CustLedgerEntry.GET(DetCustLedgerEntry."Cust. Ledger Entry No.") THEN BEGIN
                    CustLedgerEntry."Entry No." := DetCustLedgerEntry."Cust. Ledger Entry No.";
                    CustLedgerEntry."Remaining Amount (LCY) stats." := 0;
                    CustLedgerEntry."Amount (LCY) stats." := 0;
                    CustLedgerEntry."Due Date" := 0D;
                    If Glentry.GET(DetCustLedgerEntry."Cust. Ledger Entry No.") THEN
                        CustLedgerEntry."Nº Factura Borrador" := Glentry."G/L Account No."
                    ELSE
                        CustLedgerEntry."Nº Factura Borrador" := '';
                    CustLedgerEntry.INSERT;

                END;
                CustLedgerEntry."Customer No." := DetCustLedgerEntry."Customer No.";
                if DetCustLedgerEntry."Entry Type" = DetCustLedgerEntry."Entry Type"::"Initial Entry" THEN
                    CustLedgerEntry."Posting Date" := DetCustLedgerEntry."Posting Date";
                CustLedgerEntry."Document Type" := DetCustLedgerEntry."Document Type";
                CustLedgerEntry."Document No." := DetCustLedgerEntry."Document No.";
                CustLedgerEntry.Description := CustLedgerEntry.Description;
                //CustLedgerEntry."Due Date":=CustLedgerEntry."Due Date";
                CustLedgerEntry."Remaining Amount (LCY) stats." := CustLedgerEntry."Remaining Amount (LCY) stats." +
                DetCustLedgerEntry."Amount (LCY)";
                if DetCustLedgerEntry."Entry Type" = DetCustLedgerEntry."Entry Type"::"Initial Entry" THEN
                    CustLedgerEntry."Amount (LCY) stats." := DetCustLedgerEntry."Amount (LCY)"
                ELSE
                    CustLedgerEntry."Due Date" := DetCustLedgerEntry."Posting Date";
                CustLedgerEntry.MODIFY;
            UNTIL DetCustLedgerEntry.NEXT = 0;
        CustLedgerEntry.RESET;
    END;

    PROCEDURE SaldoVdoTCalcT(): Decimal;
    VAR
        DetCustLedgerEntry: Record 379;
        DetCustLedgerEntry2: Record 379;
        CustLedgerEntryDef: Record 21;
        Importe: Decimal;
        Glentry: Record "G/L Entry";
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN BEGIN
            MESSAGE('Especifique filtro fecha');
            EXIT(0);
        END;
        Ventana.OPEN('Calculando Mov. ########1# de #########2');
        DetCustLedgerEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date",
        DetCustLedgerEntry."Excluded from calculation");
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Excluded from calculation", FALSE);
        //DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Customer No.","No.");
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
        //
        //DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Initial Entry Due Date",0D,Rec.GETRANGEMAX("Date Filter"));
        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
        CustLedgerEntry.DELETEALL;
        CustLedgerEntryA.DELETEALL;
        Ventana.UPDATE(2, DetCustLedgerEntry.COUNT);
        if DetCustLedgerEntry.FINDFIRST THEN
            REPEAT
                a := a + 1;
                Ventana.UPDATE(1, a);
                if NOT CustLedgerEntry.GET(DetCustLedgerEntry."Cust. Ledger Entry No.") THEN BEGIN
                    CustLedgerEntry."Entry No." := DetCustLedgerEntry."Cust. Ledger Entry No.";
                    if not CustLedgerEntryDef.GET(DetCustLedgerEntry."Cust. Ledger Entry No.") THEN
                        CustLedgerEntrydef.Init();
                    CustLedgerEntry."Remaining Amount (LCY) stats." := 0;
                    CustLedgerEntry."Amount (LCY) stats." := 0;
                    CustLedgerEntry."Due Date" := CustLedgerEntryDef."Due Date";
                    CustLedgerEntry."Document Type" := CustLedgerEntryDef."Document Type";
                    CustLedgerEntry."Document No." := CustLedgerEntryDef."Document No.";
                    CustLedgerEntry.Description := CustLedgerEntryDef.Description;
                    If Glentry.GET(CustLedgerEntryDef."Entry No.") THEN
                        CustLedgerEntry.Cuenta := Glentry."G/L Account No."
                    ELSE
                        CustLedgerEntry.Cuenta := '';
                    CustLedgerEntry.INSERT;

                END;
                CustLedgerEntry."Customer No." := DetCustLedgerEntry."Customer No.";
                if DetCustLedgerEntry."Entry Type" = DetCustLedgerEntry."Entry Type"::"Initial Entry" THEN
                    CustLedgerEntry."Posting Date" := DetCustLedgerEntry."Posting Date";
                // CustLedgerEntry."Document Type" := DetCustLedgerEntry."Document Type";
                // CustLedgerEntry."Document No." := DetCustLedgerEntry."Document No.";
                // CustLedgerEntry.Description := CustLedgerEntry.Description;
                //CustLedgerEntry."Due Date":=CustLedgerEntry."Due Date";
                CustLedgerEntry."Remaining Amount (LCY) stats." := CustLedgerEntry."Remaining Amount (LCY) stats." +
                DetCustLedgerEntry."Amount (LCY)";
                if DetCustLedgerEntry."Entry Type" = DetCustLedgerEntry."Entry Type"::"Initial Entry" THEN
                    CustLedgerEntry."Amount (LCY) stats." := DetCustLedgerEntry."Amount (LCY)"
                ELSE
                    CustLedgerEntry."Due Date" := DetCustLedgerEntry."Posting Date";
                CustLedgerEntry.MODIFY;
                CustLedgerEntryA.SETCURRENTKEY(CustLedgerEntryA."Customer No.");
                CustLedgerEntryA.SETRANGE(CustLedgerEntryA."Customer No.", CustLedgerEntry."Customer No.");

                if NOT CustLedgerEntryA.FINDFIRST THEN BEGIN
                    CustLedgerEntryA.INIT;
                    CustLedgerEntryA."Entry No." := CustLedgerEntry."Entry No.";
                    CustLedgerEntryA."Customer No." := CustLedgerEntry."Customer No.";
                    If Glentry.GET(CustLedgerEntry."Entry No.") THEN
                        CustLedgerEntryA.Cuenta := Glentry."G/L Account No."
                    ELSE
                        CustLedgerEntryA.Cuenta := '';
                    if CustLedgerEntryA.INSERT THEN;
                END;
                if CustLedgerEntry."Posting Date" <= Rec.GETRANGEMAX("Date Filter") - 60 THEN
                    CustLedgerEntryA."Remaining Amount (LCY) stats." := CustLedgerEntryA."Remaining Amount (LCY) stats." +
                    DetCustLedgerEntry."Amount (LCY)"
                ELSE
                    CustLedgerEntryA."Amount (LCY) stats." := CustLedgerEntryA."Amount (LCY) stats." + DetCustLedgerEntry."Amount (LCY)";
                CustLedgerEntryA.MODIFY;


            UNTIL DetCustLedgerEntry.NEXT = 0;
        Ventana.CLOSE;
    END;


}
page 7001170 "Mov. Clien Pendientes a fecha"
{
    PageType = list;
    SourceTable = 21;

    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {


                field("Nº Mov"; Rec."Entry No.") { ApplicationArea = All; }
                field("Cliente"; Rec."Customer No.") { ApplicationArea = All; }
                field("Fecha Registro"; Rec."Posting Date") { ApplicationArea = All; }
                field("Fecha de Cobro"; Rec."Due Date") { ApplicationArea = All; }
                field("Tipo Documento"; Rec."Document Type") { ApplicationArea = All; }
                field("Nº Documento"; Rec."Document No.") { ApplicationArea = All; }
                field("Descripción"; Rec.Description) { ApplicationArea = All; }
                field("Importe"; Rec."Amount (LCY) stats.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    Begin
                        DetCustLedgerEntry.RESET;
                        DetCustLedgerEntry.SETCURRENTKEY(DetCustLedgerEntry."Cust. Ledger Entry No.");
                        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Cust. Ledger Entry No.", Rec."Entry No.");
                        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Entry Type", DetCustLedgerEntry."Entry Type"::"Initial Entry");
                        Page.RUNMODAL(0, DetCustLedgerEntry);
                    END;
                }
                field("Importe Pendiente"; Rec."Remaining Amount (LCY) stats.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    BEGIN
                        DetCustLedgerEntry.RESET;
                        DetCustLedgerEntry.SETCURRENTKEY(DetCustLedgerEntry."Cust. Ledger Entry No.");
                        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Cust. Ledger Entry No.", Rec."Entry No.");
                        Page.RUNMODAL(0, DetCustLedgerEntry);
                    END;
                }
                field("Cuenta"; Rec.Cuenta) { ApplicationArea = All; }

            }
        }
    }

    VAR
        DetCustLedgerEntry: Record 379;

}
page 7001174 "saldos vencidos proveedores"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = 23;

    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Nº"; Rec."No.") { ApplicationArea = All; }
                field(Nombre; Rec.Name) { ApplicationArea = All; }
                field("Saldo en Plazo"; SaldoVdo('Ok'))
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    BEGIN
                        Drill('OK');
                    END;
                }
                field("Saldo Fuera de Plazo"; SaldoVdo('NoOk'))
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    BEGIN
                        Drill('NoOk');
                    END;
                }
                field(Total; SaldoVdoT)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    BEGIN
                        Drill('Todos');
                    END;
                }
                field(Saldo; Rec."Net Change (LCY)")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    VAR
                        VendorLedgerEntry: Record 25;
                    BEGIN
                        VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Vendor No.", Rec."No.");
                        Rec.COPYFILTER("Date Filter", VendorLedgerEntry."Posting Date");
                        Page.RUNMODAL(0, VendorLedgerEntry);
                    END;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Ver Todos no vencidos")
            {
                ApplicationArea = All;
                Visible = false;
                Image = Entries;
                trigger Onaction()
                BEGIN
                    DrillT(0);
                END;
            }
            action("Ver Todos 30")
            {
                ApplicationArea = All;
                Visible = false;
                Image = Entries;
                trigger Onaction()
                BEGIN

                    DrillT(30);
                END;
            }
            action("Ver Todos 60")
            {
                ApplicationArea = All;
                Visible = false;
                Image = Entries;
                trigger Onaction()
                BEGIN

                    DrillT(60);
                END;
            }
            action("Ver Todos 90")
            {
                ApplicationArea = All;
                Visible = false;
                Image = Entries;
                trigger Onaction()
                BEGIN

                    DrillT(90);
                END;
            }
            action("Ver Todos +90")
            {
                ApplicationArea = All;
                Visible = false;
                Image = Entries;
                trigger Onaction()
                BEGIN

                    DrillT(91);
                END;
            }
            action("Ver Todos")
            {
                ApplicationArea = All;
                //Visible=false;
                Image = Entries;
                trigger Onaction()
                BEGIN

                    DrillT(92);
                END;
            }
            action(Calcular)
            {
                ApplicationArea = All;
                Image = Calculate;
                trigger OnAction()
                BEGIN
                    SaldoVdoTCalcT;
                    Calculado := TRUE;
                END;
            }
        }
    }

    VAR
        Ventana: Dialog;
        a: Integer;
        VendorLedgerEntry: Record 25 TEMPORARY;
        Calculado: Boolean;
        VendorLedgerEntryA: Record 25 TEMPORARY;

    PROCEDURE SaldoVdo(Per: Text[30]): Decimal;
    VAR
        DetVendorLedgerEntry: Record 380;
        DetVendorLedgerEntry2: Record 380;
        ImporteOk: Decimal;
        ImporteNoOk: Decimal;
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN EXIT(0);
        if Calculado = FALSE THEN EXIT(0);
        VendorLedgerEntryA.SETRANGE(VendorLedgerEntryA."Vendor No.", Rec."No.");
        //if NOT VendorLedgerEntry.FINDFIRST THEN
        //SaldoVdoTCalc;
        if VendorLedgerEntryA.FINDFIRST THEN BEGIN
            ImporteNoOk := ImporteNoOk + VendorLedgerEntryA."Remaining Amount (LCY) stats.";
            ImporteOk := ImporteOk + VendorLedgerEntryA."Amount (LCY) stats.";
        END;
        if Per = 'Ok' THEN
            EXIT(ImporteOk);
        EXIT(ImporteNoOk);
    END;

    PROCEDURE Drill(Per: Text[30]);
    VAR
        DetVendorLedgerEntry: Record 380;
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN EXIT;
        //Ventana.OPEN('Calculando Mov. ########1# de #########2');
        VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Vendor No.", Rec."No.");
        if NOT VendorLedgerEntry.FINDFIRST THEN
            SaldoVdoTCalc;
        if Per = 'Ok' THEN
            VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Posting Date", Rec.GETRANGEMAX("Date Filter") - 60, Rec.GETRANGEMAX("Date Filter"))
        ELSE
            VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter") - 61);
        if Per = 'Todos' THEN VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Posting Date");
        VendorLedgerEntry.SETFILTER(VendorLedgerEntry."Remaining Amount (LCY) stats.", '<>%1', 0);
        Page.RUNMODAL(Page::"Mov. Prov Pendientes a fecha", VendorLedgerEntry);
    END;

    PROCEDURE DrillT(Per: Integer);
    VAR
        DetVendorLedgerEntry: Record 380;
        VendorLedgerEntry: Record 25 temporary;
        VendorLedgerEntryr: Record 25;
        Glentry: Record "G/L Entry";
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN EXIT;
        Ventana.OPEN('Calculando Mov. ########1# de #########2');
        DetVendorLedgerEntry.SETCURRENTKEY("Vendor No.", "Initial Entry Due Date", "Posting Date",
        DetVendorLedgerEntry."Excluded from calculation");
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Excluded from calculation", FALSE);
        //DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Vendoromer No.","No.");
        CASE Per OF
            0:
                BEGIN
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Initial Entry Due Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;
            30:
                BEGIN
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Initial Entry Due Date", Rec.GETRANGEMAX("Date Filter") + 1, Rec.GETRANGEMAX("Date Filter") + 30);
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;
            60:
                BEGIN
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Initial Entry Due Date", Rec.GETRANGEMAX("Date Filter") + 31, Rec.GETRANGEMAX("Date Filter") + 60);
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;
            90:
                BEGIN
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Initial Entry Due Date", Rec.GETRANGEMAX("Date Filter") + 61, Rec.GETRANGEMAX("Date Filter") + 90);
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;
            91:
                BEGIN
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Initial Entry Due Date", Rec.GETRANGEMAX("Date Filter") + 91, 99991231D);
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;
            92:
                BEGIN
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Initial Entry Due Date", 0D, 99991231D);
                    DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
                END;

        END;
        a := 0;
        Ventana.UPDATE(2, DetVendorLedgerEntry.COUNT);
        if DetVendorLedgerEntry.FINDFIRST THEN
            REPEAT
                a := a + 1;
                Ventana.UPDATE(1, a);
                if NOT VendorLedgerEntry.GET(DetVendorLedgerEntry."Vendor Ledger Entry No.") THEN BEGIN
                    if VendorLedgerEntryr.GET(DetVendorLedgerEntry."Vendor Ledger Entry No.") THEN VendorLedgerEntry := VendorLedgerEntryr;
                    VendorLedgerEntry."Entry No." := DetVendorLedgerEntry."Vendor Ledger Entry No.";
                    VendorLedgerEntry."Remaining Amount (LCY) stats." := 0;
                    VendorLedgerEntry."Amount (LCY) stats." := 0;
                    VendorLedgerEntry."Due Date" := VendorLedgerEntryr."Due Date";
                    If Glentry.GET(VendorLedgerEntryr."Entry No.") THEN
                        VendorLedgerEntry.Cuenta := Glentry."G/L Account No."
                    ELSE
                        VendorLedgerEntry.Cuenta := '';
                    VendorLedgerEntry.INSERT;

                END;
                if NOT VendorLedgerEntryr.GET(DetVendorLedgerEntry."Vendor Ledger Entry No.") THEN VendorLedgerEntryr.INIT;
                VendorLedgerEntry."Vendor No." := DetVendorLedgerEntry."Vendor No.";
                if DetVendorLedgerEntry."Entry Type" = DetVendorLedgerEntry."Entry Type"::"Initial Entry" THEN
                    VendorLedgerEntry."Posting Date" := DetVendorLedgerEntry."Posting Date";
                VendorLedgerEntry."Document Type" := VendorLedgerEntryr."Document Type";
                VendorLedgerEntry."Document No." := VendorLedgerEntryr."Document No.";
                VendorLedgerEntry.Description := VendorLedgerEntryr.Description;
                //VendorLedgerEntry."Due Date":=VendorLedgerEntry."Due Date";
                VendorLedgerEntry."Remaining Amount (LCY) stats." := VendorLedgerEntry."Remaining Amount (LCY) stats." +
                DetVendorLedgerEntry."Amount (LCY)";
                if DetVendorLedgerEntry."Entry Type" = DetVendorLedgerEntry."Entry Type"::"Initial Entry" THEN
                    VendorLedgerEntry."Amount (LCY) stats." := DetVendorLedgerEntry."Amount (LCY)"
                ELSE
                    VendorLedgerEntry."Due Date" := DetVendorLedgerEntry."Posting Date";
                VendorLedgerEntry.MODIFY;
            UNTIL DetVendorLedgerEntry.NEXT = 0;
        VendorLedgerEntry.SETFILTER(VendorLedgerEntry."Remaining Amount (LCY) stats.", '<>%1', 0);
        Ventana.CLOSE;
        page.RUNMODAL(Page::"Mov. Prov Pendientes a fecha", VendorLedgerEntry);
    END;

    PROCEDURE SaldoVdoT(): Decimal;
    VAR
        DetVendorLedgerEntry: Record 380;
        DetVendorLedgerEntry2: Record 380;
        Importe: Decimal;
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN EXIT(0);
        DetVendorLedgerEntry.SETCURRENTKEY("Vendor No.", "Initial Entry Due Date", "Posting Date",
        DetVendorLedgerEntry."Excluded from calculation");
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Excluded from calculation", FALSE);
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Vendor No.", Rec."No.");
        //DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Entry Type",DetVendorLedgerEntry."Entry Type"::"Initial Entry");
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
        //
        //DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Initial Entry Due Date",0D,Rec.GETRANGEMAX("Date Filter"));
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));

        if DetVendorLedgerEntry.FINDFIRST THEN
            DetVendorLedgerEntry.CALCSUMS(DetVendorLedgerEntry."Amount (LCY)");
        EXIT(DetVendorLedgerEntry."Amount (LCY)");
    END;

    PROCEDURE SaldoVdoTCalc(): Decimal;
    VAR
        DetVendorLedgerEntry: Record 380;
        DetVendorLedgerEntry2: Record 380;
        VendorLedgerEntryDef: Record 25;
        Importe: Decimal;
        Glentry: Record "G/L Entry";
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN EXIT(0);
        DetVendorLedgerEntry.SETCURRENTKEY("Vendor No.", "Initial Entry Due Date", "Posting Date",
        DetVendorLedgerEntry."Excluded from calculation");
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Excluded from calculation", FALSE);
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Vendor No.", Rec."No.");
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
        //
        //DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Initial Entry Due Date",0D,Rec.GETRANGEMAX("Date Filter"));
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
        VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Vendor No.", Rec."No.");
        VendorLedgerEntry.DELETEALL;
        if DetVendorLedgerEntry.FINDFIRST THEN
            REPEAT
                a := a + 1;
                //Ventana.UPDATE(1,a);
                if NOT VendorLedgerEntry.GET(DetVendorLedgerEntry."Vendor Ledger Entry No.") THEN BEGIN
                    If not VendorLedgerEntryDef.GET(DetVendorLedgerEntry."Vendor Ledger Entry No.") THEN VendorLedgerEntryDef.Init();
                    VendorLedgerEntry."Entry No." := DetVendorLedgerEntry."Vendor Ledger Entry No.";
                    VendorLedgerEntry."Remaining Amount (LCY) stats." := 0;
                    VendorLedgerEntry."Amount (LCY) stats." := 0;
                    VendorLedgerEntry."Due Date" := VendorLedgerEntryDef."Due Date";
                    VendorLedgerEntry."Document Type" := VendorLedgerEntryDef."Document Type";
                    VendorLedgerEntry."Document No." := VendorLedgerEntryDef."Document No.";
                    VendorLedgerEntry.Description := VendorLedgerEntryDef.Description;
                    If Glentry.GET(VendorLedgerEntryDef."Entry No.") THEN
                        VendorLedgerEntry.Cuenta := Glentry."G/L Account No."
                    ELSE
                        VendorLedgerEntry.Cuenta := '';
                    VendorLedgerEntry.INSERT;

                END;
                VendorLedgerEntry."Vendor No." := DetVendorLedgerEntry."Vendor No.";
                if DetVendorLedgerEntry."Entry Type" = DetVendorLedgerEntry."Entry Type"::"Initial Entry" THEN
                    VendorLedgerEntry."Posting Date" := DetVendorLedgerEntry."Posting Date";
                // VendorLedgerEntry."Document Type" := DetVendorLedgerEntry."Document Type";
                // VendorLedgerEntry."Document No." := DetVendorLedgerEntry."Document No.";
                // VendorLedgerEntry.Description := VendorLedgerEntry.Description;
                //VendorLedgerEntry."Due Date":=VendorLedgerEntry."Due Date";
                VendorLedgerEntry."Remaining Amount (LCY) stats." := VendorLedgerEntry."Remaining Amount (LCY) stats." +
                DetVendorLedgerEntry."Amount (LCY)";
                if DetVendorLedgerEntry."Entry Type" = DetVendorLedgerEntry."Entry Type"::"Initial Entry" THEN
                    VendorLedgerEntry."Amount (LCY) stats." := DetVendorLedgerEntry."Amount (LCY)"
                ELSE
                    VendorLedgerEntry."Due Date" := DetVendorLedgerEntry."Posting Date";
                VendorLedgerEntry.MODIFY;
            UNTIL DetVendorLedgerEntry.NEXT = 0;
        VendorLedgerEntry.RESET;
    END;

    PROCEDURE SaldoVdoTCalcT(): Decimal;
    VAR
        DetVendorLedgerEntry: Record 380;
        DetVendorLedgerEntry2: Record 380;
        VendorLedgerEntryDef: Record 25;
        Glentry: Record "G/L Entry";
        Importe: Decimal;
    BEGIN
        if Rec.GETFILTER("Date Filter") = '' THEN BEGIN
            MESSAGE('Especifique filtro fecha');
            EXIT(0);
        END;
        Ventana.OPEN('Calculando Mov. ########1# de #########2');
        DetVendorLedgerEntry.SETCURRENTKEY("Vendor No.", "Initial Entry Due Date", "Posting Date",
        DetVendorLedgerEntry."Excluded from calculation");
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Excluded from calculation", FALSE);
        //DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Vendoromer No.","No.");
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
        //
        //DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Initial Entry Due Date",0D,Rec.GETRANGEMAX("Date Filter"));
        DetVendorLedgerEntry.SETRANGE(DetVendorLedgerEntry."Posting Date", 0D, Rec.GETRANGEMAX("Date Filter"));
        VendorLedgerEntry.DELETEALL;
        VendorLedgerEntryA.DELETEALL;
        Ventana.UPDATE(2, DetVendorLedgerEntry.COUNT);
        if DetVendorLedgerEntry.FINDFIRST THEN
            REPEAT
                a := a + 1;
                Ventana.UPDATE(1, a);
                if NOT VendorLedgerEntry.GET(DetVendorLedgerEntry."Vendor Ledger Entry No.") THEN BEGIN
                    VendorLedgerEntry."Entry No." := DetVendorLedgerEntry."Vendor Ledger Entry No.";
                    VendorLedgerEntry."Remaining Amount (LCY) stats." := 0;
                    VendorLedgerEntry."Amount (LCY) stats." := 0;
                    VendorLedgerEntry."Due Date" := 0D;
                    If Glentry.GET(DetVendorLedgerEntry."Vendor Ledger Entry No.") THEN
                        VendorLedgerEntry.Cuenta := Glentry."G/L Account No."
                    ELSE
                        VendorLedgerEntry.Cuenta := '';
                    VendorLedgerEntry.INSERT;

                END;
                VendorLedgerEntry."Vendor No." := DetVendorLedgerEntry."Vendor No.";
                if DetVendorLedgerEntry."Entry Type" = DetVendorLedgerEntry."Entry Type"::"Initial Entry" THEN
                    VendorLedgerEntry."Posting Date" := DetVendorLedgerEntry."Posting Date";
                VendorLedgerEntry."Document Type" := DetVendorLedgerEntry."Document Type";
                VendorLedgerEntry."Document No." := DetVendorLedgerEntry."Document No.";
                VendorLedgerEntry.Description := VendorLedgerEntry.Description;
                //VendorLedgerEntry."Due Date":=VendorLedgerEntry."Due Date";
                VendorLedgerEntry."Remaining Amount (LCY) stats." := VendorLedgerEntry."Remaining Amount (LCY) stats." +
                DetVendorLedgerEntry."Amount (LCY)";
                if DetVendorLedgerEntry."Entry Type" = DetVendorLedgerEntry."Entry Type"::"Initial Entry" THEN
                    VendorLedgerEntry."Amount (LCY) stats." := DetVendorLedgerEntry."Amount (LCY)"
                ELSE
                    VendorLedgerEntry."Due Date" := DetVendorLedgerEntry."Posting Date";
                VendorLedgerEntry.MODIFY;
                VendorLedgerEntryA.SETCURRENTKEY(VendorLedgerEntryA."Vendor No.");
                VendorLedgerEntryA.SETRANGE(VendorLedgerEntryA."Vendor No.", VendorLedgerEntry."Vendor No.");

                if NOT VendorLedgerEntryA.FINDFIRST THEN BEGIN
                    VendorLedgerEntryA.INIT;
                    VendorLedgerEntryA."Entry No." := VendorLedgerEntry."Entry No.";
                    VendorLedgerEntryA."Vendor No." := VendorLedgerEntry."Vendor No.";
                    If Glentry.GET(VendorLedgerEntryA."Entry No.") THEN
                        VendorLedgerEntryA.Cuenta := Glentry."G/L Account No."
                    ELSE
                        VendorLedgerEntryA.Cuenta := '';
                    if VendorLedgerEntryA.INSERT THEN;
                END;
                if VendorLedgerEntry."Posting Date" <= Rec.GETRANGEMAX("Date Filter") - 60 THEN
                    VendorLedgerEntryA."Remaining Amount (LCY) stats." := VendorLedgerEntryA."Remaining Amount (LCY) stats." +
                    DetVendorLedgerEntry."Amount (LCY)"
                ELSE
                    VendorLedgerEntryA."Amount (LCY) stats." := VendorLedgerEntryA."Amount (LCY) stats." + DetVendorLedgerEntry."Amount (LCY)";
                VendorLedgerEntryA.MODIFY;


            UNTIL DetVendorLedgerEntry.NEXT = 0;
        Ventana.CLOSE;
    END;


}
page 7001169 "Mov. Prov Pendientes a fecha"
{
    PageType = list;
    SourceTable = 25;

    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {


                field("Nº Mov"; Rec."Entry No.") { ApplicationArea = All; }
                field("Proveedor"; Rec."Vendor No.") { ApplicationArea = All; }
                field("Fecha Registro"; Rec."Posting Date") { ApplicationArea = All; }
                field("Fecha de Cobro"; Rec."Due Date") { ApplicationArea = All; }
                field("Tipo Documento"; Rec."Document Type") { ApplicationArea = All; }
                field("Nº Documento"; Rec."Document No.") { ApplicationArea = All; }
                field("Descripción"; Rec.Description) { ApplicationArea = All; }
                field("Importe"; Rec."Amount (LCY) stats.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    Begin
                        DetCustLedgerEntry.RESET;
                        DetCustLedgerEntry.SETCURRENTKEY(DetCustLedgerEntry."Vendor Ledger Entry No.");
                        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Vendor Ledger Entry No.", Rec."Entry No.");
                        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Entry Type", DetCustLedgerEntry."Entry Type"::"Initial Entry");
                        Page.RUNMODAL(0, DetCustLedgerEntry);
                    END;
                }
                field("Importe Pendiente"; Rec."Remaining Amount (LCY) stats.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    BEGIN
                        DetCustLedgerEntry.RESET;
                        DetCustLedgerEntry.SETCURRENTKEY(DetCustLedgerEntry."Vendor Ledger Entry No.");
                        DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Vendor Ledger Entry No.", Rec."Entry No.");
                        Page.RUNMODAL(0, DetCustLedgerEntry);
                    END;
                }
                field("Cuenta"; Rec.Cuenta) { ApplicationArea = All; }

            }
        }
    }

    VAR
        DetCustLedgerEntry: Record 380;

}






