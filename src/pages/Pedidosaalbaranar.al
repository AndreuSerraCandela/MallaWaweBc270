/// <summary>
/// Page Pedidos a albaranar (ID 50006).
/// </summary>
page 50006 "Pedidos a albaranar"
{

    SourceTable = "Pedidos Pendientes";


    //SourceTableView = SORTING("Entry No.2");

    PageType = List;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(Albaranes; Rec."Entry No.")
                {
                    ApplicationArea = ALL;
                    Style = Strong;
                    StyleExpr = IsFirstDocLine;
                }
                field("Nº Pedido"; Rec."Order No.")
                {
                    ApplicationArea = ALL;
                    TableRelation = "Purchase Header"."No.";
                }
                field("Fecha registro propuesta"; Rec."Posting Date") { ApplicationArea = ALL; }
                field("No."; Rec."Location Code") { ApplicationArea = ALL; }

                field("Descripción"; Rec.Description) { ApplicationArea = ALL; }

                field(Cantidad; Rec.Amount) { ApplicationArea = ALL; }
                field(Importe; Rec."Amount (ACY)") { ApplicationArea = ALL; }
            }
        }
    }

    VAR

        TempPurchRcptLine: Record "Pedidos Pendientes" TEMPORARY;

        PurchLine: Record 39;
        ImporteL: Decimal;
        Importe: Decimal;

        LineasAlb: Record "Pedidos Pendientes";

        IsFirstDocLine: Boolean;

    LOCAL PROCEDURE ProIsFirstDocLine(): Boolean;
    VAR

        PurchRcptLine: Record "Pedidos Pendientes";

    BEGIN
        TempPurchRcptLine.RESET;
        TempPurchRcptLine.COPYFILTERS(Rec);
        TempPurchRcptLine.SETRANGE("Entry No.", Rec."Entry No.");
        if NOT TempPurchRcptLine.FIND('-') THEN BEGIN
            PurchRcptLine.COPYFILTERS(Rec);
            PurchRcptLine.SETRANGE("Entry No.", Rec."Entry No.");
            if PurchRcptLine.FIND('-') THEN BEGIN
                TempPurchRcptLine := PurchRcptLine;
                TempPurchRcptLine.INSERT;
            END;
        END;
        if Rec."Location Code" = TempPurchRcptLine."Location Code" THEN
            EXIT(TRUE);
    END;

    trigger OnAfterGetRecord()
    begin
        IsFirstDocLine := ProIsFirstDocLine();
    end;

}

