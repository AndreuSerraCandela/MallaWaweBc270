/// <summary>
/// TableExtension Return Shipment LineKuara (ID 80304) extends Record Return Shipment Line.
/// </summary>
tableextension 80304 "Return Shipment LineKuara" extends "Return Shipment Line"
{
    fields
    {
        field(50008; "Bill-to Name"; TEXT[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Job."Bill-to Name" WHERE("No." = FIELD("Job No.")));
        }
        field(50011; "Periodo de Pago"; TEXT[30]) { }
        field(50012; "Facturado"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Rcpt. Header".Facturado WHERE("No." = FIELD("Document No.")));
        }
        field(50091; "Fecha inicial recurso"; Date) { }
        field(50092; "Fecha final recurso"; Date) { }
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
        field(54029; "Amount"; Decimal) { AutoFormatType = 1; }
        field(54030; "Amount Including VAT"; Decimal) { AutoFormatType = 1; }
        field(54103; "Line Amount"; Decimal) { AutoFormatType = 1; }
        field(54104; "Importe Facturado"; Decimal) { }
        field(54105; "Importe Pte Facturar"; Decimal) { }
        field(70000; "Tipo sit. inmueble SII"; CODE[10]) { }
        field(70001; "Ref. catastral inmueble SII"; TEXT[30]) { }
    }
    var
        Currency: Record Currency;
        CurrencyRead: Boolean;

    local procedure InitCurrency(CurrencyCode: Code[10])
    begin
        if (Currency.Code = CurrencyCode) and CurrencyRead then
            exit;

        if CurrencyCode <> '' then
            Currency.Get(CurrencyCode)
        else
            Currency.InitRoundingPrecision;
        CurrencyRead := true;
    end;

    PROCEDURE InsertInvLineFromRetShptLine2(VAR PurchLine: Record 39; q: Decimal);
    VAR
        PurchHeader: Record 38;
        PurchHeader2: Record 38;
        PurchOrderLine: Record 39;
        TempPurchLine: Record 39 TEMPORARY;
        PurchSetup: Record "Purchases & Payables Setup";
        TransferOldExtLines: Codeunit 379;
        ItemTrackingMgt: Codeunit 6500;
        NextLineNo: Integer;
        ExtTextLine: Boolean;
        Text001: Label 'El programa no puede encontrar esta linea de compra.';
        Text000: Label 'Devolución No. %1:';
    BEGIN
        SETRANGE("Document No.", "Document No.");

        TempPurchLine := PurchLine;
        if PurchLine.FIND('+') THEN
            NextLineNo := PurchLine."Line No." + 10000
        ELSE
            NextLineNo := 10000;

        if PurchHeader."No." <> TempPurchLine."Document No." THEN
            PurchHeader.GET(TempPurchLine."Document Type", TempPurchLine."Document No.");

        if PurchLine."Return Shipment No." <> "Document No." THEN BEGIN
            PurchLine.INIT;
            PurchLine."Line No." := NextLineNo;
            PurchLine."Document Type" := TempPurchLine."Document Type";
            PurchLine."Document No." := TempPurchLine."Document No.";
            PurchLine.Description := STRSUBSTNO(Text000, "Document No.");
            PurchLine.INSERT;
            NextLineNo := NextLineNo + 10000;
        END;

        TransferOldExtLines.ClearLineNumbers;
        PurchSetup.GET;
        REPEAT
            ExtTextLine := (TransferOldExtLines.GetNewLineNumber("Attached to Line No.") <> 0);

            if NOT PurchOrderLine.GET(
                 PurchOrderLine."Document Type"::"Return Order", "Return Order No.", "Return Order Line No.")
            THEN BEGIN
                if ExtTextLine THEN BEGIN
                    PurchOrderLine.INIT;
                    PurchOrderLine."Line No." := "Return Order Line No.";
                    PurchOrderLine.Description := Description;
                    PurchOrderLine."Description 2" := "Description 2";
                END ELSE
                    ERROR(Text001);
            END ELSE BEGIN
                if (PurchHeader2."Document Type" <> PurchOrderLine."Document Type"::"Return Order") OR
                   (PurchHeader2."No." <> PurchOrderLine."Document No.")
                THEN
                    PurchHeader2.GET(PurchOrderLine."Document Type"::"Return Order", "Return Order No.");

                InitCurrency("Currency Code");

                if PurchHeader."Prices Including VAT" THEN BEGIN
                    if NOT PurchHeader2."Prices Including VAT" THEN
                        PurchOrderLine."Direct Unit Cost" :=
                          ROUND(
                            PurchOrderLine."Direct Unit Cost" * (1 + PurchOrderLine."VAT %" / 100),
                            Currency."Unit-Amount Rounding Precision");
                END ELSE BEGIN
                    if PurchHeader2."Prices Including VAT" THEN
                        PurchOrderLine."Direct Unit Cost" :=
                          ROUND(
                            PurchOrderLine."Direct Unit Cost" / (1 + PurchOrderLine."VAT %" / 100),
                            Currency."Unit-Amount Rounding Precision");
                END;
            END;
            PurchLine := PurchOrderLine;
            PurchLine."Line No." := NextLineNo;
            PurchLine."Document Type" := TempPurchLine."Document Type";
            PurchLine."Document No." := TempPurchLine."Document No.";
            PurchLine."Variant Code" := "Variant Code";
            PurchLine."Location Code" := "Location Code";
            PurchLine."Return Reason Code" := "Return Reason Code";
            PurchLine."Quantity (Base)" := 0;
            PurchLine.Quantity := 0;
            PurchLine."Outstanding Qty. (Base)" := 0;
            PurchLine."Outstanding Quantity" := 0;
            PurchLine."Return Qty. Shipped" := 0;
            PurchLine."Return Qty. Shipped (Base)" := 0;
            PurchLine."Quantity Invoiced" := 0;
            PurchLine."Qty. Invoiced (Base)" := 0;
            PurchLine."Sales Order No." := '';
            PurchLine."Sales Order Line No." := 0;
            PurchLine."Drop Shipment" := FALSE;
            PurchLine."Return Shipment No." := "Document No.";
            PurchLine."Return Shipment Line No." := "Line No.";
            PurchLine."Appl.-to Item Entry" := 0;

            if NOT ExtTextLine THEN BEGIN
                PurchLine.VALIDATE(Quantity, q);
                //PurchLine.VALIDATE(Quantity,Quantity - "Quantity Invoiced");
                PurchLine.VALIDATE("Direct Unit Cost", PurchOrderLine."Direct Unit Cost");
                PurchLine.VALIDATE("Line Discount %", PurchOrderLine."Line Discount %");
                if PurchOrderLine.Quantity = 0 THEN
                    PurchLine.VALIDATE("Inv. Discount Amount", 0)
                ELSE
                    PurchLine.VALIDATE(
                      "Inv. Discount Amount",
                      ROUND(
                        PurchOrderLine."Inv. Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
                        Currency."Amount Rounding Precision"));
            END;
            PurchLine."Attached to Line No." :=
              TransferOldExtLines.TransferExtendedText(
                "Line No.",
                NextLineNo,
                "Attached to Line No.");
            PurchLine."Shortcut Dimension 1 Code" := PurchOrderLine."Shortcut Dimension 1 Code";
            PurchLine."Shortcut Dimension 2 Code" := PurchOrderLine."Shortcut Dimension 2 Code";
            PurchLine."Dimension Set ID" := PurchOrderLine."Dimension Set ID";

            //OnBeforeInsertInvLineFromRetShptLine(PurchLine,PurchOrderLine);
            PurchLine.INSERT;
            //OnAfterInsertInvLineFromRetShptLine(PurchLine);

            ItemTrackingMgt.CopyHandledItemTrkgToInvLine(PurchOrderLine, PurchLine);

            NextLineNo := NextLineNo + 10000;
            if "Attached to Line No." = 0 THEN
                SETRANGE("Attached to Line No.", "Line No.");
        UNTIL (NEXT = 0) OR ("Attached to Line No." = 0);
    END;

}
