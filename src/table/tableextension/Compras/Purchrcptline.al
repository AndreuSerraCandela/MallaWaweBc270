/// <summary>
/// TableExtension Purch. Rcpt. LineKuara (ID 80174) extends Record Purch. Rcpt. Line.
/// </summary>
tableextension 80174 "Purch. Rcpt. LineKuara" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50008; "Bill-to Name"; TEXT[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Job."Bill-to Name" WHERE("No." = FIELD("Job No.")));
            TableRelation = Customer;
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
        field(54001; "Empresa Origen"; TEXT[30]) { }
        field(54002; "Proyecto Origen"; CODE[20]) { }
        field(54003; "Recurso"; CODE[20]) { }
        field(54028; "Line Discount Amount"; Decimal) { }
        field(54029; "Amount"; Decimal) { }
        field(54030; "Amount Including VAT"; Decimal) { }
        field(54079; "Linea de proyecto"; Integer) { }
        field(54103; "Line Amount"; Decimal) { }
        field(54104; "Importe Facturado"; Decimal) { }
        field(54105; "Importe Pte Facturar"; Decimal) { }
        field(54106; "Finalizado"; Boolean) { }
        field(70000; "Tipo sit. inmueble SII"; CODE[10]) { }
        field(70001; "Ref. catastral inmueble SII"; TEXT[30]) { }
        field(80120; "Recurso Agrupado"; Boolean) { }
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

    /// <summary>
    /// InsertInvLineFromRcptLine2.
    /// </summary>
    /// <param name="PurchLine">VAR Record "Purchase Line".</param>
    /// <param name="q">Decimal.</param>
    procedure InsertInvLineFromRcptLine2(var PurchLine: Record "Purchase Line"; q: Decimal)
    var
        PurchInvHeader: Record "Purchase Header";
        PurchOrderHeader: Record "Purchase Header";
        PurchOrderLine: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line" temporary;
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        TranslationHelper: Codeunit "Translation Helper";
        NextLineNo: Integer;
        ExtTextLine: Boolean;
        IsHandled: Boolean;
        DirectUnitCost: Decimal;
        Text001: Label 'El programa no puede encontrar esta linea de compra.';
        Text000: Label 'Albaran No. %1:';
    begin
        PurchLine.SetRange("Document No.", PurchLine."Document No.");

        TempPurchLine := PurchLine;
        if PurchLine.Find('+') then
            NextLineNo := PurchLine."Line No." + 10000
        else
            NextLineNo := 10000;

        if PurchInvHeader."No." <> TempPurchLine."Document No." then
            PurchInvHeader.Get(TempPurchLine."Document Type", TempPurchLine."Document No.");

        //OnInsertInvLineFromRcptLineOnBeforeCheckPurchLineReceiptNo(Rec, PurchLine, TempPurchLine, NextLineNo);

        if PurchLine."Receipt No." <> "Document No." then begin
            PurchLine.Init();
            PurchLine."Line No." := NextLineNo;
            PurchLine."Document Type" := TempPurchLine."Document Type";
            PurchLine."Document No." := TempPurchLine."Document No.";
            TranslationHelper.SetGlobalLanguageByCode(PurchInvHeader."Language Code");
            PurchLine.Description := StrSubstNo(Text000, "Document No.");
            TranslationHelper.RestoreGlobalLanguage;
            IsHandled := false;
            //  OnBeforeInsertInvLineFromRcptLineBeforeInsertTextLine(Rec, PurchLine, NextLineNo, IsHandled);
            if not IsHandled then begin
                PurchLine.Insert();
                //       OnAfterDescriptionPurchaseLineInsert(PurchLine, Rec, NextLineNo);
                NextLineNo := NextLineNo + 10000;
            end;
        end;

        TransferOldExtLines.ClearLineNumbers;

        repeat
            ExtTextLine := (TransferOldExtLines.GetNewLineNumber("Attached to Line No.") <> 0);

            if PurchOrderLine.Get(
                 PurchOrderLine."Document Type"::Order, "Order No.", "Order Line No.") and
               not ExtTextLine
            then begin
                if (PurchOrderHeader."Document Type" <> PurchOrderLine."Document Type"::Order) or
                   (PurchOrderHeader."No." <> PurchOrderLine."Document No.")
                then
                    PurchOrderHeader.Get(PurchOrderLine."Document Type"::Order, "Order No.");

                InitCurrency("Currency Code");

                if PurchInvHeader."Prices Including VAT" then begin
                    if not PurchOrderHeader."Prices Including VAT" then
                        PurchOrderLine."Direct Unit Cost" :=
                          Round(
                            PurchOrderLine."Direct Unit Cost" * (1 + PurchOrderLine."VAT %" / 100),
                            Currency."Unit-Amount Rounding Precision");
                end else begin
                    if PurchOrderHeader."Prices Including VAT" then
                        PurchOrderLine."Direct Unit Cost" :=
                          Round(
                            PurchOrderLine."Direct Unit Cost" / (1 + PurchOrderLine."VAT %" / 100),
                            Currency."Unit-Amount Rounding Precision");
                end;
            end else begin
                if ExtTextLine then begin
                    PurchOrderLine.Init();
                    PurchOrderLine."Line No." := "Order Line No.";
                    PurchOrderLine.Description := Description;
                    PurchOrderLine."Description 2" := "Description 2";
                    // OnInsertInvLineFromRcptLineOnAfterAssignDescription(Rec, PurchOrderLine);
                end else
                    Error(Text001);
            end;

            CopyFromPurchRcptLine(PurchLine, PurchOrderLine, TempPurchLine, NextLineNo);
            q := Round(q, 0.00001, '=');
            if (not ExtTextLine) and (q <> 0) then begin
                PurchLine.VALIDATE(Quantity, q);

                IsHandled := false;
                DirectUnitCost := PurchOrderLine."Direct Unit Cost";
                // OnInsertInvLineFromRcptLineOnBeforeSetDirectUnitCost(PurchLine, PurchOrderLine, DirectUnitCost);
                PurchLine.Validate("Direct Unit Cost", DirectUnitCost);
                PurchOrderLine."Line Discount Amount" :=
                  Round(
                    PurchOrderLine."Line Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
                    Currency."Amount Rounding Precision");
                if PurchInvHeader."Prices Including VAT" then begin
                    if not PurchOrderHeader."Prices Including VAT" then
                        PurchOrderLine."Line Discount Amount" :=
                          Round(
                            PurchOrderLine."Line Discount Amount" *
                            (1 + PurchOrderLine."VAT %" / 100), Currency."Amount Rounding Precision");
                end else
                    if PurchOrderHeader."Prices Including VAT" then
                        PurchOrderLine."Line Discount Amount" :=
                          Round(
                            PurchOrderLine."Line Discount Amount" /
                            (1 + PurchOrderLine."VAT %" / 100), Currency."Amount Rounding Precision");
                PurchLine.Validate("Line Discount Amount", PurchOrderLine."Line Discount Amount");
                PurchLine."Line Discount %" := PurchOrderLine."Line Discount %";
                //OnInsertInvLineFromRcptLineOnBeforePurchLineUpdatePrePaymentAmounts(PurchLine, PurchOrderLine);
                PurchLine.UpdatePrePaymentAmounts;
                if PurchOrderLine.Quantity = 0 then
                    PurchLine.Validate("Inv. Discount Amount", 0)
                else
                    PurchLine.Validate(
                      "Inv. Discount Amount",
                      Round(
                        PurchOrderLine."Inv. Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
                        Currency."Amount Rounding Precision"));
            end;

            PurchLine."Attached to Line No." :=
              TransferOldExtLines.TransferExtendedText(
                "Line No.",
                NextLineNo,
                "Attached to Line No.");
            PurchLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            PurchLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            PurchLine."Dimension Set ID" := "Dimension Set ID";

            if "Sales Order No." = '' then
                PurchLine."Drop Shipment" := false
            else
                PurchLine."Drop Shipment" := true;

            IsHandled := false;
            //OnBeforeInsertInvLineFromRcptLine(Rec, PurchLine, PurchOrderLine, IsHandled);
            if not IsHandled then
                PurchLine.Insert();
            //OnAfterInsertInvLineFromRcptLine(PurchLine, PurchOrderLine, NextLineNo, Rec);

            ItemTrackingMgt.CopyHandledItemTrkgToInvLine(PurchOrderLine, PurchLine);

            NextLineNo := NextLineNo + 10000;
            if "Attached to Line No." = 0 then
                SetRange("Attached to Line No.", "Line No.");
        until (Next = 0) or ("Attached to Line No." = 0);
    end;

    /// <summary>
    /// InsertInvLineFromRcptLine4.
    /// </summary>
    /// <param name="PurchLine">VAR Record "Purchase Line".</param>
    /// <param name="q">Decimal.</param>
    /// <param name="PurchInvHeader">VAR Record 38.</param>
    /// <param name="PurchRecpLine">VAR Record 121.</param>
    procedure InsertInvLineFromRcptLine4(var PurchLine: Record "Purchase Line"; q: Decimal; var PurchInvHeader: Record 38; var PurchRecpLine: Record 121)
    var
        PurchOrderHeader: Record "Purchase Header";
        PurchOrderLine: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line" temporary;
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        TranslationHelper: Codeunit "Translation Helper";
        NextLineNo: Integer;
        ExtTextLine: Boolean;
        IsHandled: Boolean;
        DirectUnitCost: Decimal;
        Text001: Label 'El programa no puede encontrar esta linea de compra.';
        Text000: Label 'Albaran No. %1:';
    begin
        Rec.SetRange("Document No.", PurchRecpLine."Document No.");
        Rec.SetRange("Line No.", PurchRecpLine."Line No.");
        if Not FindFirst() Then begin
            Rec := PurchRecpLine;
        end;
        TempPurchLine := PurchLine;
        if PurchLine.Find('+') then
            NextLineNo := PurchLine."Line No." + 10000
        else
            NextLineNo := 10000;

        if PurchInvHeader."No." <> TempPurchLine."Document No." then
            PurchInvHeader.Get(TempPurchLine."Document Type", TempPurchLine."Document No.");

        //OnInsertInvLineFromRcptLineOnBeforeCheckPurchLineReceiptNo(Rec, PurchLine, TempPurchLine, NextLineNo);

        if PurchLine."Receipt No." <> PurchRecpLine."Document No." then begin
            PurchLine.Init();
            PurchLine."Line No." := NextLineNo;
            PurchLine."Document Type" := TempPurchLine."Document Type";
            PurchLine."Document No." := TempPurchLine."Document No.";
            TranslationHelper.SetGlobalLanguageByCode(PurchInvHeader."Language Code");
            PurchLine.Description := StrSubstNo(Text000, "Document No.");
            TranslationHelper.RestoreGlobalLanguage;
            IsHandled := false;
            //  OnBeforeInsertInvLineFromRcptLineBeforeInsertTextLine(Rec, PurchLine, NextLineNo, IsHandled);
            if not IsHandled then begin
                PurchLine.Insert();
                //       OnAfterDescriptionPurchaseLineInsert(PurchLine, Rec, NextLineNo);
                NextLineNo := NextLineNo + 10000;
            end;
        end;

        TransferOldExtLines.ClearLineNumbers;

        repeat
            ExtTextLine := (TransferOldExtLines.GetNewLineNumber("Attached to Line No.") <> 0);

            if PurchOrderLine.Get(
                 PurchOrderLine."Document Type"::Order, PurchRecpLine."Order No.", PurchRecpLine."Order Line No.") and
               not ExtTextLine
            then begin
                if (PurchOrderHeader."Document Type" <> PurchOrderLine."Document Type"::Order) or
                   (PurchOrderHeader."No." <> PurchOrderLine."Document No.")
                then
                    PurchOrderHeader.Get(PurchOrderLine."Document Type"::Order, PurchRecpLine."Order No.");

                InitCurrency("Currency Code");

                if PurchInvHeader."Prices Including VAT" then begin
                    if not PurchOrderHeader."Prices Including VAT" then
                        PurchOrderLine."Direct Unit Cost" :=
                          Round(
                            PurchOrderLine."Direct Unit Cost" * (1 + PurchOrderLine."VAT %" / 100),
                            Currency."Unit-Amount Rounding Precision");
                end else begin
                    if PurchOrderHeader."Prices Including VAT" then
                        PurchOrderLine."Direct Unit Cost" :=
                          Round(
                            PurchOrderLine."Direct Unit Cost" / (1 + PurchOrderLine."VAT %" / 100),
                            Currency."Unit-Amount Rounding Precision");
                end;
            end else begin
                if ExtTextLine then begin
                    PurchOrderLine.Init();
                    PurchOrderLine."Line No." := PurchRecpLine."Order Line No.";
                    PurchOrderLine.Description := PurchRecpLine.Description;
                    PurchOrderLine."Description 2" := PurchRecpLine."Description 2";
                    // OnInsertInvLineFromRcptLineOnAfterAssignDescription(Rec, PurchOrderLine);
                end else
                    Error(Text001);
            end;

            q := Round(q, 0.00001, '=');
            if (not ExtTextLine) and (q <> 0) then begin
                CopyFromPurchRcptLine(PurchLine, PurchOrderLine, TempPurchLine, NextLineNo);

                PurchLine.VALIDATE(Quantity, q);
                PurchLine.Quantity := q;
                IsHandled := false;
                DirectUnitCost := PurchOrderLine."Direct Unit Cost";
                // OnInsertInvLineFromRcptLineOnBeforeSetDirectUnitCost(PurchLine, PurchOrderLine, DirectUnitCost);
                PurchLine.Validate("Direct Unit Cost", DirectUnitCost);
                PurchOrderLine."Line Discount Amount" :=
                  Round(
                    PurchOrderLine."Line Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
                    Currency."Amount Rounding Precision");
                if PurchInvHeader."Prices Including VAT" then begin
                    if not PurchOrderHeader."Prices Including VAT" then
                        PurchOrderLine."Line Discount Amount" :=
                          Round(
                            PurchOrderLine."Line Discount Amount" *
                            (1 + PurchOrderLine."VAT %" / 100), Currency."Amount Rounding Precision");
                end else
                    if PurchOrderHeader."Prices Including VAT" then
                        PurchOrderLine."Line Discount Amount" :=
                          Round(
                            PurchOrderLine."Line Discount Amount" /
                            (1 + PurchOrderLine."VAT %" / 100), Currency."Amount Rounding Precision");

                PurchLine.Validate("Line Discount Amount", PurchOrderLine."Line Discount Amount");
                PurchLine."Line Discount %" := PurchOrderLine."Line Discount %";
                //OnInsertInvLineFromRcptLineOnBeforePurchLineUpdatePrePaymentAmounts(PurchLine, PurchOrderLine);
                PurchLine.UpdatePrePaymentAmounts;
                if PurchOrderLine.Quantity = 0 then
                    PurchLine."Inv. Discount Amount" := 0
                else
                    PurchLine.Validate(
                      "Inv. Discount Amount",
                      Round(
                        PurchOrderLine."Inv. Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
                        Currency."Amount Rounding Precision"));
            end;

            PurchLine."Attached to Line No." :=
              TransferOldExtLines.TransferExtendedText(
                PurchRecpLine."Line No.",
                NextLineNo,
                PurchRecpLine."Attached to Line No.");
            PurchLine."Shortcut Dimension 1 Code" := PurchRecpLine."Shortcut Dimension 1 Code";
            PurchLine."Shortcut Dimension 2 Code" := PurchRecpLine."Shortcut Dimension 2 Code";
            PurchLine."Dimension Set ID" := PurchRecpLine."Dimension Set ID";

            if "Sales Order No." = '' then
                PurchLine."Drop Shipment" := false
            else
                PurchLine."Drop Shipment" := true;

            IsHandled := false;
            //OnBeforeInsertInvLineFromRcptLine(Rec, PurchLine, PurchOrderLine, IsHandled);
            if not IsHandled then
                PurchLine.Insert();
            //OnAfterInsertInvLineFromRcptLine(PurchLine, PurchOrderLine, NextLineNo, Rec);

            ItemTrackingMgt.CopyHandledItemTrkgToInvLine(PurchOrderLine, PurchLine);

            NextLineNo := NextLineNo + 10000;
            if PurchRecpLine."Attached to Line No." = 0 then
                SetRange("Attached to Line No.", PurchRecpLine."Line No.");
        until (Next = 0) or ("Attached to Line No." = 0);
    end;

    local procedure CopyFromPurchRcptLine(var PurchLine: Record "Purchase Line"; PurchOrderLine: Record "Purchase Line"; TempPurchLine: Record "Purchase Line"; NextLineNo: Integer)
    begin
        PurchLine := PurchOrderLine;
        PurchLine."Line No." := NextLineNo;
        PurchLine."Document Type" := TempPurchLine."Document Type";
        PurchLine."Document No." := TempPurchLine."Document No.";
        PurchLine."Variant Code" := "Variant Code";
        PurchLine."Location Code" := "Location Code";
        PurchLine."Quantity (Base)" := 0;
        PurchLine.Quantity := 0;
        PurchLine."Outstanding Qty. (Base)" := 0;
        PurchLine."Outstanding Quantity" := 0;
        PurchLine."Quantity Received" := 0;
        PurchLine."Qty. Received (Base)" := 0;
        PurchLine."Quantity Invoiced" := 0;
        PurchLine."Qty. Invoiced (Base)" := 0;
        PurchLine.Amount := 0;
        PurchLine."Amount Including VAT" := 0;
        PurchLine."Sales Order No." := '';
        PurchLine."Sales Order Line No." := 0;
        PurchLine."Drop Shipment" := false;
        PurchLine."Special Order Sales No." := '';
        PurchLine."Special Order Sales Line No." := 0;
        PurchLine."Special Order" := false;
        PurchLine."Receipt No." := "Document No.";
        PurchLine."Receipt Line No." := "Line No.";
        PurchLine."Appl.-to Item Entry" := 0;

        // OnAfterCopyFromPurchRcptLine(PurchLine, Rec);
    end;
}