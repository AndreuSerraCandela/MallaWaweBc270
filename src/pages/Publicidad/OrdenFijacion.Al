/// <summary>
/// Page Ficha Orden Fijacion (ID 50091).
/// </summary>
page 50245 "Ficha Orden Fijacion"
{
    PageType = Card;
    SourceTable = "Cab Orden fijación";

    layout
    {
        area(Content)
        {
            field("Nº Orden"; Rec."Nº Orden")
            {
                ApplicationArea = all;
                Editable = false;
            }



            field("Fecha Fijación"; Rec."Fecha fijación")
            {
                ApplicationArea = all;
                Editable = true;
            }

            field(Fijar; Rec.Fijar)
            {
                ApplicationArea = all;

            }

            field(Tapar; Rec.Tapar)
            {
                ApplicationArea = all;
                Editable = true;
            }

            field(Foto; Rec.Foto)
            {
                ApplicationArea = all;
                ShowCaption = false;
            }
            field("Tipo soporte"; Rec."Tipo soporte")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Material Fijación"; Rec."Material")
            {
                ApplicationArea = all;
                Editable = true;
                trigger OnValidate()
                var
                    OrdenFijacion: Record "Orden fijación";
                begin
                    OrdenFijacion.SetRange("Nº Orden", Rec."Nº Orden");
                    OrdenFijacion.ModifyAll("Material", Rec.Material, true);
                end;

            }

            field("Nº Opis"; Rec."No. Opis")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field(Revisión; Rec.Revisión)
            {
                ApplicationArea = all;
                Editable = true;
            }

            field(Validado; Rec.Validado)
            {
                ApplicationArea = all;

            }
            field(Observaciones; WorkDescription)
            {
                ApplicationArea = all;
                Editable = true;
                trigger OnValidate()
                var
                    OrdenFijacion: Record "Orden fijación";
                begin
                    Rec.SetWorkDescription(WorkDescription);
                    OrdenFijacion.SetRange("Nº Orden", Rec."Nº Orden");
                    OrdenFijacion.ModifyAll("Observaciones", CopyStr(WorkDescription, 1, 250), true);
                end;
            }
            field("Título Informe"; Rec."Título")
            {
                Caption = 'Título Informe';
                ApplicationArea = all;
                Editable = true;
            }
            part("Lineas Orden Fijacion"; "SubPage ordenes fijación")
            {
                ApplicationArea = All;
                SubPageLink = "Nº Orden" = field("Nº Orden");
            }
            part("Imagenes Orden fijación"; "Imagenes Orden fijacion")
            {
                ApplicationArea = All;
                SubPageLink = "Nº Orden" = field("Nº Orden"), "Valla Fijada" = const(false), "Es Qr" = const(false), "Es Incidencia" = const(false);
            }
            part("Imagenes Vallas Fijadas"; "Imagenes Orden fijacion")
            {
                Caption = 'Imagenes Vallas Fijadas';
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Nº Orden" = field("Nº Orden"), "Valla Fijada" = const(true);
            }
        }
        area(FactBoxes)
        {
            part(Visor; "Ocr Viewer Part")
            {
                ApplicationArea = All;
                Provider = "Imagenes Orden fijación";
                SubPageLink = "Nº Orden" = field("Nº Orden"), "Nº Imagen" = field("Nº Imagen");
            }
            part(Fijadas; "Ocr Viewer Part")
            {
                ApplicationArea = All;
                Provider = "Imagenes Vallas Fijadas";
                SubPageLink = "Nº Orden" = field("Nº Orden"), "Nº Imagen" = field("Nº Imagen"), "Es Incidencia" = filter(false);
            }



        }
    }

    actions
    {
        area(Processing)
        {
            action("Asignar Imagen a Lineas")
            {
                ApplicationArea = All;
                Caption = 'Asignar Imagen a Lineas';
                Image = Picture;
                trigger OnAction()
                var
                    rImagenesOrdenFijacion: Record "Imagenes Orden fijación";
                    rDet: Record "Orden fijación";

                begin
                    if NOT CONFIRM('Desea asignar imagen a las lineas seleccionadas?') THEN EXIT;
                    CurrPage."Lineas Orden Fijacion".Page.SETSELECTIONFILTER(rDet);
                    CurrPage."Imagenes Orden fijación".Page.GetRecord(rImagenesOrdenFijacion);

                    if rDet.FINDSET THEN
                        REPEAT
                            rDet."Nº Imagen" := rImagenesOrdenFijacion."Nº Imagen";
                            rDet.MODIFY;

                        UNTIL rDet.NEXT = 0;
                end;

            }
            action("Asignar 2ª cara a Lineas")
            {
                ApplicationArea = All;
                Caption = 'Asignar 2ª cara a Lineas';
                Image = Picture;
                trigger OnAction()
                var
                    rImagenesOrdenFijacion: Record "Imagenes Orden fijación";
                    rDet: Record "Orden fijación";

                begin
                    if NOT CONFIRM('Desea asignar imagen a las lineas seleccionadas?') THEN EXIT;
                    CurrPage."Lineas Orden Fijacion".Page.SETSELECTIONFILTER(rDet);
                    CurrPage."Imagenes Orden fijación".Page.GetRecord(rImagenesOrdenFijacion);

                    if rDet.FINDSET THEN
                        REPEAT
                            rDet."2ª Imagen" := rImagenesOrdenFijacion."Nº Imagen";
                            rDet.MODIFY;

                        UNTIL rDet.NEXT = 0;
                end;

            }
            action("Asignar Imagen Valla fijada a Lineas")
            {
                ApplicationArea = All;
                Caption = 'Asignar Imagen Valla fijada a Lineas';
                Image = Picture;
                trigger OnAction()
                var
                    rImagenesOrdenFijacion: Record "Imagenes Orden fijación";
                    rDet: Record "Orden fijación";

                begin
                    rImagenesOrdenFijacion.SetRange("Nº Orden", Rec."Nº Orden");
                    rImagenesOrdenFijacion.SetRange("Valla Fijada", true);
                    If not rImagenesOrdenFijacion.FindFirst() Then Error('Primero debe recuperar la imagenes de las vallas');
                    if NOT CONFIRM('¿Desea asignar imagen a las lineas seleccionadas?') THEN EXIT;
                    CurrPage."Lineas Orden Fijacion".Page.SETSELECTIONFILTER(rDet);
                    CurrPage."Imagenes Vallas Fijadas".Page.GetRecord(rImagenesOrdenFijacion);

                    if rDet.FINDSET THEN
                        REPEAT
                            rDet."Imagen Valla Fijada" := rImagenesOrdenFijacion."Nº Imagen";
                            rDet.MODIFY;

                        UNTIL rDet.NEXT = 0;
                end;

            }




        }
        area(Navigation)
        {
            group(Orden)
            {
                Caption = '&Orden';
                action(Lista)
                {
                    ApplicationArea = ALL;
                    Caption = '&Lista';
                    ShortcutKey = F5;
                    RunObject = Page "Lista ordenes fijación";
                }
                action("Validad/Desvaridar")
                {
                    ApplicationArea = ALL;
                    Caption = '&Validar/Desvalidar';
                    trigger OnAction()
                    VAR
                        rOrden: Record "Cab Orden fijación";
                        cuenta: Integer;
                    BEGIN
                        if CONFIRM('Validar/Desvalidar todas ordenes marcadas?') THEN BEGIN
                            cuenta := 0;
                            CurrPage.SETSELECTIONFILTER(rOrden);
                            if rOrden.FIND('-') THEN
                                REPEAT
                                    if NOT rOrden.Validado THEN
                                        rOrden.Validado := TRUE
                                    ELSE
                                        rOrden.Validado := FALSE;
                                    rOrden.MODIFY;
                                    cuenta := cuenta + 1;
                                UNTIL rOrden.NEXT = 0;
                            MESSAGE('Se han validado/desvalidado %1 ordenes de fijación', cuenta);
                        END ELSE
                            EXIT;
                    END;
                }
                action("Duplicar Orden Fijacion")
                {
                    Caption = '&Duplicar Orden Fijacion';
                    ApplicationArea = ALL;
                    trigger OnAction()
                    var
                        NuevaFecha: Date;
                        NuevoTexto: Text;
                        finestra: Page Dialogo;
                    begin
                        if NOT CONFIRM('Desea crear una nueva fijación a partir de la actual?') THEN EXIT;

                        NuevaFecha := WorkDate();
                        NuevoTexto := 'Escriba nuevo texto';
                        finestra.SetValues(NuevaFecha, NuevoTexto);
                        finestra.RunModal();
                        finestra.GetValues(NuevaFecha, NuevoTexto);
                        if NuevaFecha = 0D THEN ERROR('No puede dejar la fecha en blanco');

                        Rec.Duplicar(Rec, NuevaFecha, NuevoTexto);

                        MESSAGE('Orden creada');
                    END;
                }
            }
        }
        area(Promoted)
        {
            actionref(AsignarImagenaLineas; "Asignar Imagen a Lineas")

            {

            }
        }
    }


    VAR
        finestra: Dialog;
        NuevaFecha: Date;
        NuevoTexto: Text[30];
        workdescription: Text;

    trigger OnAfterGetRecord()
    var
        DocumentAtAchment: Record "Document Attachment";
    begin
        workdescription := Rec.GetWorkDescription();
        //CurrPage."Imagenes Vallas Fijadas".Page.FijarVallas();
        // DocumentAtAchment.SetRange("Table ID", Database::"Orden fijación");
        // DocumentAtAchment.SetRange("No.", Rec."Nº Proyecto");
        // CurrPage."Attached Documents".Page.SetTableView(DocumentAtAchment);
    end;


    trigger OnOpenPage()
    begin
        // CurrPage."Imagenes Vallas Fijadas".Page.FijarVallas();
    end;
}