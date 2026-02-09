page 50215 "Tabla Reservas"
{
    SourceTable = Reserva;
    PageType = List;
    UsageCategory = Lists;

    layout

    {
        area(Content)
        {
            repeater(Detalle)
            {

                Editable = true;
                field(Seleccionar; Rec.Seleccionar)
                {
                    ApplicationArea = All;
                    Visible = Seleccion;
                }
                field("Nº Reserva"; Rec."Nº Reserva")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Fecha inicio"; Rec."Fecha inicio")
                {
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                }
                field("Fecha fin"; Rec."Fecha fin")
                {
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                }
                field("Nº Recurso"; Rec."Nº Recurso")
                {
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                }
                field(Zona; Rec.Zona)
                {
                    ApplicationArea = All;
                    Editable = Not Seleccion;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                }
                field(Descripcion; Rec.Descripción)
                {
                    Caption = 'Descripción';
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                }
                field("Recurso Agrupado"; Rec."Recurso Agrupado")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Linea Agrupado"; Rec."Linea Agrupado")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nº Proyecto"; Rec."Nº proyecto")
                {
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                    //  OnPageat=BEGIN
                    //             if NOT rProyecto.GET("Nº Proyecto") THEN rProyecto.INIT;
                    //           END;
                }
                field("Cód. fase"; Rec."Cód. fase")
                {
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                }
                field("Cód. subfase"; Rec."Cód. subfase")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cód. tarea"; Rec."Cód. tarea")
                {
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                }
                field("Nº linea proyecto"; Rec."Nº linea proyecto")
                {
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                }
                field("Tipo (presupuesto)"; Rec."Tipo (presupuesto)")
                {
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                }
                field("Nº (presupuesto)"; Rec."Nº (presupuesto)")
                {
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                }
                field("Orden fijación creada"; Rec."Orden fijación creada")
                {
                    ApplicationArea = all;
                    Editable = Not Seleccion;
                }
                field(Municipo; Rec.Municipo)
                {
                    ApplicationArea = All;
                    Editable = Not Seleccion;
                }
                field("Punto X"; rRec.PuntoX)
                {
                    ApplicationArea = All;
                    Editable = Not Seleccion;
                }
                field("Punto Y"; rReC."PuntoY")
                {
                    ApplicationArea = All;
                    Editable = Not Seleccion;
                }
                field("Cód Zona"; rRec."Global Dimension 4 Code")
                {
                    ApplicationArea = All;
                    Editable = Not Seleccion;
                }
                field(Contrato; Procedure_Contrato(Rec."Nº proyecto"))
                {
                    ApplicationArea = All;
                    Editable = Not Seleccion;
                }


            }
            group(Pie)
            {
                field("Descripción"; rProyecto."Description")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }
            }
        }
    }
    actions
    {

        area(Processing)
        {
            group(Reserva)
            {
                Image = Reserve;
                action(Ficha)
                {
                    Caption = '&Ficha';
                    Image = Card;
                    ApplicationArea = ALL;
                    RunObject = Page "Ficha Reserva";
                    RunPageOnRec = true;
                }
                action("Diario Reserva")
                {
                    Caption = '&Diario Reserva';
                    Image = ReservationLedger;
                    ApplicationArea = ALL;
                    RunObject = Page "Diario Reserva";
                    RunPageView = SORTING("Nº Reserva", Fecha);
                    RunPageLink = "Nº Reserva" = FIELD("Nº Reserva");
                }

                action("Orden ficación")
                {
                    Caption = 'O&rden fijación';
                    Image = AddWatch;
                    ApplicationArea = ALL;
                    trigger OnAction()
                    var
                        rOrden: Record "Cab Orden fijación";
                        rLinFijacion: Record "Orden fijación";
                    begin
                        rLinFijacion.SETRANGE("Nº Reserva", Rec."Nº Reserva");
                        if rLinFijacion.FindSet() then begin
                            rOrden.SETRANGE("Nº Orden", rLinFijacion."Nº Orden");
                            if rOrden.FindSet() then begin
                                Page.RunModal(Page::"Ficha Orden Fijacion", rOrden);
                            end;
                        end;
                    end;

                }
                action("Eliminar Reserva")
                {
                    ShortCutKey = 'Ctrl-';
                    Image = Delete;
                    ApplicationArea = ALL;
                    Caption = 'Eliminar reserva';
                    trigger OnAction()
                    VAR
                        rReserva: Record Reserva;
                    BEGIN
                        //$001
                        CurrPage.SETSELECTIONFILTER(rReserva);
                        if rReserva.FIND('-') THEN
                            REPEAT
                                rReserva.DELETE(TRUE);
                            UNTIL rReserva.NEXT = 0;
                    END;
                }
                action("Asignar Recurso Agrupado")
                {
                    Caption = 'Asignar Recurso Agrupado';
                    Image = ResourceGroup;
                    ApplicationArea = ALL;
                    trigger OnAction()
                    VAR
                        rRes: Record Reserva;
                        rDet: Record 1003;
                        rRec: Record 156;
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(rRes);
                        MESSAGE('Elija una línea del proyecto');
                        rDet.SETRANGE(rDet."Job No.", Rec."Nº Proyecto");
                        if Page.RUNMODAL(0, rDet) = ACTION::LookupOK THEN BEGIN
                            if NOT rRec.GET(rDet."No.") THEN
                                ERROR('Ponga esto en manos de alguien que sepa lo que hace, esta línea ni siquiera es de recurso,\'
                                + 'como puede ser un recurso agrupado !!!!!!!?');
                            if NOT rRec."Recurso Agrupado" THEN
                                ERROR('Ponga esto en manos de alguien que sepa lo que hace, este no es un recurso agrupado,\'
                                + 'que parte de asignar recurso agrupado no entiende !!!!!!!?');

                            if rRes.FINDFIRST THEN
                                REPEAT
                                    rRes."Recurso Agrupado" := rRec."No.";
                                    rRes."Linea Agrupado" := rDet."Line No.";
                                    rRes.MODIFY;
                                UNTIL rRes.NEXT = 0;
                        END;
                    END;
                }
            }
            action("Seleccionar Marcados")
            {
                Caption = 'Seleccionar Marcados';
                Image = SelectMore;
                ApplicationArea = ALL;
                Visible = Seleccion;
                trigger OnAction()
                var
                    rReserva: Record Reserva;
                begin
                    CurrPage.SETSELECTIONFILTER(rReserva);
                    if rReserva.FINDSET() then
                        REPEAT
                            Rec.Get(rReserva."Nº Reserva");
                            Rec.Seleccionar := true;
                            Rec.MODIFY();
                        UNTIL rReserva.NEXT = 0;
                    Rec.ClearMarks();
                    CurrPage.UPDATE(false);

                end;
            }
        }
        area(Promoted)
        {
            actionref("Marcados"; "Seleccionar Marcados")
            {

            }
        }
    }
    VAR
        rRec: Record 156;
        rProyecto: Record 167;
        wEmpresa: Text[30];
        Seleccion: Boolean;

    trigger OnAfterGetRecord()
    begin
        if wEmpresa <> '' then begin
            rRec.ChangeCompany(wEmpresa);
            rProyecto.ChangeCompany(wEmpresa);
        end;
        if not rProyecto.Get(Rec."Nº Proyecto") Then rProyecto.Init();
        if Not rRec.Get(Rec."Nº Recurso") Then rRec.Init();
        rRec.CalcFields("Dimensión Zona");
        if rRec."Global Dimension 4 Code" = '' Then rRec."Global Dimension 4 Code" := rRec."Dimensión Zona";
    end;

    PROCEDURE EncuentraCircuito(Proy: Code[20]): Boolean;
    VAR
        r1003: Record 1003;
    BEGIN
        r1003.SETCURRENTKEY("Job No.", Type, "No.", "Planning Date", "Fecha Final");
        r1003.SETRANGE(Type, r1003.Type::Resource);
        r1003.SETRANGE("Job No.", Proy);
        r1003.CALCFIELDS("Calculo Recurso Agrupado");
        r1003.SETRANGE("Calculo Recurso Agrupado", TRUE);
        EXIT(r1003.FINDFIRST);
    END;

    procedure Procedure_Contrato(pProyecto: Code[20]): Text
    var
        SalesHeader: Record "Sales Header";
    begin
        if wEmpresa <> '' then
            SalesHeader.ChangeCompany(wEmpresa);
        SalesHeader.SETRANGE("Nº Proyecto", pProyecto);
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FINDFIRST then
            exit(SalesHeader."No.");
    end;

    procedure Seleccionable(pEmpresa: Text)
    begin
        Seleccion := True;
        wEmpresa := pEmpresa;
        if wEmpresa <> '' then
            Rec.ChangeCompany(wEmpresa);

    end;


    //   $001 FCL-220311. Creo la opción para eliminar reservas y bloqueo F4, ya que al eliminar varias se queda colgado
    //                    al visualizar el Page incluído en OnDelete; con la modififación se ejecutarán de 1 en 1.

}