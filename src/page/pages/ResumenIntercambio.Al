/// <summary>
/// Page Resumen List (ID 7001150).
/// </summary>
page 7001150 "Resumen List"
{
    Editable = False;
    Caption = 'Lista de intercambio';
    PageType = List;
    SourceTable = Intercambio;
    SourceTableTemporary = true;
    SourceTableView = SORTING("Search Name", Address);

    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field(Nombre; Rec.Name)
                {
                    ApplicationArea = All;
                    StyleExpr = (Rec."No." = Rec."Search Name");
                    Style = StrongAccent;
                }
                field(Empresa; Rec."Name 2") { ApplicationArea = All; }
                field(Fecha; Fec)
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                    StyleExpr = CompruebaFecha;
                }
                field(Saldo; Rec."Credit Limit (LCY)") { ApplicationArea = All; }
            }
        }
    }
    //    actions
    //    {
    //        area(Processing)
    //        {

    //        action(Ficha)
    //                                                      PushAction=RunObject;
    //                                                      ShortCutKey=Mayús+F5;
    //                                                      CaptionML=ESP=Ficha;
    //                                                      RunObject=Form 50005;
    //                                                      RunFormLink=No.=FIELD(No.) }
    //                                                    { ID=1000000006;
    //                                                      PushAction=RunObject;
    //                                                      CaptionML=ESP=Ver Detalle Todos;
    //                                                      RunObject=Form 50007 }
    //                                                  }
    //                                                   }
    //   }
    Var
        ComprueBafecha: Boolean;

    trigger OnAfterGetRecord()
    begin
        ComprueBafecha := ((Rec."Last Date Modified" = 19800102D) OR (Rec."Last Date Modified" < TODAY)
                                                                 OR (Rec."Last Date Modified" = 19800101D));

    end;

    PROCEDURE Fec(): Text[30];
    BEGIN
        if Rec."Last Date Modified" = 19800201D THEN EXIT('Finalizado');
        if Rec."Last Date Modified" = 19800101D THEN EXIT('Finalizado');
        EXIT(FORMAT(Rec."Last Date Modified", 0, '<Day,2>/<Month,2>/<Year>'));
    END;


}

