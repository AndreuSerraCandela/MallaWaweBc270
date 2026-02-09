/// <summary>
/// Page Lista ordenes fijación (ID 50098).
/// </summary>
page 50250 "Lista ordenes fijación"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cab Orden fijación";
    CardpageId = "Ficha Orden fijacion";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Nº Orden"; Rec."Nº Orden")
                {
                    ApplicationArea = All;
                }
                // field("Nº Reserva"; Rec."Nº Reserva")
                // {
                //     ApplicationArea = All;
                // }
                // field("Nº Recurso"; Rec."Nº Recurso")
                // {
                //     ApplicationArea = All;
                // }
                // field("Descripción Recurso"; DescripcionRecurso())
                // {
                //     ApplicationArea = All;
                // }
                field("Fecha generación"; Rec."Fecha generación")
                {
                    ApplicationArea = All;
                }
                field("Fecha fijación"; Rec."Fecha fijación")
                {
                    ApplicationArea = All;
                }
                field(Operario; Rec.Operario)
                {
                    ApplicationArea = All;
                }
                field("Nº Proyecto"; Rec."Nº Proyecto")
                {
                    ApplicationArea = All;
                }
                field(Fijar; Rec.Fijar)
                {
                    ApplicationArea = All;
                }
                field(Tapar; Rec.Tapar)
                {
                    ApplicationArea = All;
                }
                field(Foto; Rec.Foto)
                {
                    ApplicationArea = All;
                }
                field(Validado; Rec.Validado)
                {
                    ApplicationArea = All;
                }
                field(Zona; Rec.Zona)
                {
                    ApplicationArea = All;
                }
            }
        }

    }
    actions
    {

        area(Navigation)
        {
            group(Orden)
            {
                Caption = '&Orden';
                action(Ficha)
                {
                    Caption = '&Ficha';
                    ShortcutKey = 'Mayús+F5';
                    RunObject = Page "Ficha Orden fijacion";
                    ApplicationArea = ALL;
                    RunPageLink = "Nº Orden" = field("Nº Orden");
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



                action("Validad/Desvalidar")
                {
                    Caption = '&Validar/Desvalidar';
                    ApplicationArea = ALL;
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


            }

        }
    }

}
page 7001177 "Detalle ordenes fijación"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Orden fijación";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Nº Orden"; Rec."Nº Orden")
                {
                    ApplicationArea = All;
                }
                field("Nº Reserva"; Rec."Nº Reserva")
                {
                    ApplicationArea = All;
                }
                field("Nº Recurso"; Rec."Nº Recurso")
                {
                    ApplicationArea = All;
                }
                field("Descripción Recurso"; DescripcionRecurso())
                {
                    ApplicationArea = All;
                }
                field("Fecha generación"; Rec."Fecha generación")
                {
                    ApplicationArea = All;
                }
                field("Fecha fijación"; Rec."Fecha fijación")
                {
                    ApplicationArea = All;
                }
                field(Operario; Rec.Operario)
                {
                    ApplicationArea = All;
                }
                field("Nº Proyecto"; Rec."Nº Proyecto")
                {
                    ApplicationArea = All;
                }
                field(Fijar; Rec.Fijar)
                {
                    ApplicationArea = All;
                }
                field(Tapar; Rec.Tapar)
                {
                    ApplicationArea = All;
                }
                field(Foto; Rec.Foto)
                {
                    ApplicationArea = All;
                }
                field(Validado; Rec.Validado)
                {
                    ApplicationArea = All;
                }
                field(Zona; Rec.Zona)
                {
                    ApplicationArea = All;
                }
            }
        }

    }
    actions
    {
        area(Navigation)
        {
            group(Orden)
            {
                Caption = '&Orden';
                action(Ficha)
                {
                    Caption = '&Ficha';
                    ShortcutKey = 'Mayús+F5';
                    RunObject = Page "Ficha Orden fijacion";
                    ApplicationArea = ALL;
                    RunPageLink = "Nº Orden" = field("Nº Orden");
                }




                action("Validad/Desvalidar")
                {
                    Caption = '&Validar/Desvalidar';
                    ApplicationArea = ALL;
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

            }
        }
    }
    /// <summary>
    /// DescripcionRecurso.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure DescripcionRecurso(): Text
    VAR
        rRecurso: Record Resource;
    BEGIN
        if Rec."Nº Recurso" <> '' THEN BEGIN
            if rRecurso.GET(Rec."Nº Recurso") then
                EXIT(rRecurso.Name);
        END ELSE
            EXIT('');
    END;
}
page 7001178 "SubPage ordenes fijación"
{
    PageType = ListPart;
    SourceTable = "Orden fijación";
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("Nº Reserva"; Rec."Nº Reserva")
                {
                    ApplicationArea = All;
                }
                field("Nº Recurso"; Rec."Nº Recurso")
                {
                    ApplicationArea = All;
                }
                field("Descripción Recurso"; DescripcionRecurso())
                {
                    ApplicationArea = All;
                    StyleExpr = Color;
                }
                field("Fecha generación"; Rec."Fecha generación")
                {
                    ApplicationArea = All;
                }
                field("Fecha fijación"; Rec."Fecha fijación")
                {
                    ApplicationArea = All;
                }
                field(Operario; Rec.Operario)
                {
                    ApplicationArea = All;
                }
                field("Nº Proyecto"; Rec."Nº Proyecto")
                {
                    ApplicationArea = All;
                }
                field(Fijar; Rec.Fijar)
                {
                    ApplicationArea = All;
                }
                field(Tapar; Rec.Tapar)
                {
                    ApplicationArea = All;
                }
                field(Material; Rec.Material)
                {
                    ApplicationArea = All;
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ApplicationArea = All;
                }
                field(Foto; Rec.Foto)
                {
                    ApplicationArea = All;
                }
                field(Validado; Rec.Validado)
                {
                    ApplicationArea = All;
                }
                field(Zona; Rec.Zona)
                {
                    ApplicationArea = All;
                }
                field("Fecha Retirada"; Rec."Fecha Retirada")
                {
                    ApplicationArea = All;
                }
                field("Guardar o Tirar"; Rec."Guardar o Tirar")
                {
                    ApplicationArea = All;
                }
                field(Retirar; Rec.Retirar)
                {
                    ApplicationArea = All;
                }
                field(Retirada; Rec.Retirada)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }

    }
    trigger OnAfterGetRecord()
    begin
        If Rec."Nº Imagen" = 0 Then Color := 'Unfavorable' else Color := 'Favorable';
    end;
    // actions
    // {
    //     area(Navigation)
    //     {
    //         group(Orden)
    //         {
    //             Caption = '&Orden';
    //             action(Ficha)
    //             {
    //                 Caption = '&Ficha';
    //                 ShortcutKey = 'Mayús+F5';
    //                 RunObject = Page "Ficha Orden fijacion";
    //                 ApplicationArea = ALL;
    //                 RunPageLink = "Nº Orden" = field("Nº Orden");
    //             }




    //             action("Validad/Desvalidar")
    //             {
    //                 Caption = '&Validar/Desvalidar';
    //                 ApplicationArea = ALL;
    //                 trigger OnAction()
    //                 VAR
    //                     rOrden: Record "Cab Orden fijación";
    //                     cuenta: Integer;
    //                 BEGIN
    //                     if CONFIRM('Validar/Desvalidar todas ordenes marcadas?') THEN BEGIN
    //                         cuenta := 0;
    //                         CurrPage.SETSELECTIONFILTER(rOrden);
    //                         if rOrden.FIND('-') THEN
    //                             REPEAT
    //                                 if NOT rOrden.Validado THEN
    //                                     rOrden.Validado := TRUE
    //                                 ELSE
    //                                     rOrden.Validado := FALSE;
    //                                 rOrden.MODIFY;
    //                                 cuenta := cuenta + 1;
    //                             UNTIL rOrden.NEXT = 0;
    //                         MESSAGE('Se han validado/desvalidado %1 ordenes de fijación', cuenta);
    //                     END ELSE
    //                         EXIT;
    //                 END;
    //             }
    //             action("Duplicación masiva ordenes")
    //             {
    //                 ApplicationArea = ALL;
    //                 Caption = '&Duplicación masiva ordenes';
    //                 RunObject = report "Proceso duplicar ordenes masiv";

    //             }
    //         }
    //     }
    // }
    /// <summary>
    /// DescripcionRecurso.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure DescripcionRecurso(): Text
    VAR
        rRecurso: Record Resource;
    BEGIN
        If Rec."Empresa" <> '' then
            rRecurso.ChangeCompany(Rec."Empresa");
        if Rec."Nº Recurso" <> '' THEN BEGIN
            if rRecurso.GET(Rec."Nº Recurso") then
                EXIT(rRecurso.Name);
        END ELSE
            EXIT('');
    END;

    var
        Color: Text;
        VallaFijada: Boolean;
}
page 7001179 "Imagenes Orden fijacion"
{
    Caption = 'Imagenes Orden fijacion';
    DelayedInsert = true;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Imagenes Orden fijación";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Nombre; Rec."Nombre")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Espeficica el nombre del archivo adjunto.';


                }
                field("Extension"; Rec."Extension")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the Extension of the attachment.';
                }
                field("Tipo"; Rec."Tipo")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the type of document that the attachment is.';
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OpenInOneDrive)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Open in OneDrive';
                ToolTip = 'Copy the file to your Business Central folder in OneDrive and open it in a new window so you can manage or share the file.', Comment = 'OneDrive should not be translated';
                Image = Cloud;
                Visible = ShareOptionsVisible;
                Enabled = not IsMultiSelect;
                Scope = Repeater;
                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    DocumentServiceMgt: Codeunit "Document Service Management";
                    FileName: Text;
                    FileExtension: Text;
                begin
                    FileName := FileManagement.StripNotsupportChrInFileName(Rec."Nombre");
                    FileExtension := StrSubstNo(FileExtensionLbl, Rec."Extension");

                    DocumentServiceMgt.OpenInOneDriveFromMedia(FileName, FileExtension, Rec.Image.MediaId());
                end;
            }
            action(EditInOneDrive)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Edit in OneDrive';
                ToolTip = 'Copy the file to your Business Central folder in OneDrive and open it in a new window so you can edit the file.', Comment = 'OneDrive should not be translated';
                Image = Cloud;
                Visible = (ShareOptionsVisible and ShareEditOptionVisible);
                Enabled = not IsMultiSelect;
                Scope = Repeater;

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    DocumentServiceMgt: Codeunit "Document Service Management";
                    FileName: Text;
                    FileExtension: Text;
                begin
                    FileName := FileManagement.StripNotsupportChrInFileName(Rec."Nombre");
                    FileExtension := StrSubstNo(FileExtensionLbl, Rec."Extension");

                    if DocumentServiceMgt.EditInOneDriveFromMedia(FileName, FileExtension, Rec.Image.MediaId()) then begin
                        If Rec.Nombre = '' Then Rec.Nombre := FileName;
                        If Rec.Nombre = '' Then Error('El nombre del archivo no puede estar vacío');
                        Rec.Modify();
                    end;
                end;
            }
            action(ShareWithOneDrive)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Share';
                ToolTip = 'Copy the file to your Business Central folder in OneDrive and share the file. You can also see who it''s already shared with.', Comment = 'OneDrive should not be translated';
                Image = Share;
                Visible = ShareOptionsVisible;
                Enabled = not IsMultiSelect;
                Scope = Repeater;
                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    DocumentServiceMgt: Codeunit "Document Service Management";
                    FileName: Text;
                    FileExtension: Text;
                begin
                    FileName := FileManagement.StripNotsupportChrInFileName(Rec."Nombre");
                    FileExtension := StrSubstNo(FileExtensionLbl, Rec."Extension");

                    DocumentServiceMgt.ShareWithOneDriveFromMedia(FileName, FileExtension, Rec.Image.MediaId());
                end;
            }
            action(AttachFromEmail)
            {
                ApplicationArea = All;
                Caption = 'Adjuntar desde email';
                Image = Email;
                Enabled = EmailHasAttachments;
                Scope = Page;
                ToolTip = 'Adjuntar archivos directamente desde email.';
                Visible = IsOfficeAddin;

                trigger OnAction()
                begin
                    InitiateAttachFromEmail();
                end;
            }

        }

    }

    trigger OnInit()
    begin
        FlowFieldsEditable := true;
        IsOfficeAddin := OfficeMgmt.IsAvailable();
        if IsOfficeAddin then
            EmailHasAttachments := OfficeMgmt.EmailHasAttachments
        else
            EmailHasAttachments := false;
    end;

    trigger OnAfterGetCurrRecord()
    var
        SelectedDocumentAttachment: Record "Imagenes Orden fijación";
        DocumentSharing: Codeunit "Document Sharing";
    begin
        CurrPage.SetSelectionFilter(SelectedDocumentAttachment);
        IsMultiSelect := SelectedDocumentAttachment.Count() > 1;
        if OfficeMgmt.IsAvailable() or OfficeMgmt.IsPopOut() then begin
            ShareOptionsVisible := false;
            ShareEditOptionVisible := false;
        end else begin
            ShareOptionsVisible := (Rec.Image.HasValue()) and (DocumentSharing.ShareEnabled());
            ShareEditOptionVisible := DocumentSharing.EditEnabledForFile('.' + Rec."Extension");
        end;
        DownloadEnabled := (Rec.Image.HasValue() or (Rec.Url <> '')) and (not IsMultiSelect);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Nombre" := SelectFileTxt;
    end;

    var
        OfficeMgmt: Codeunit "Office Management";
        OfficeHostMgmt: Codeunit "Office Host Management";
        SalesDocumentFlow: Boolean;
        FileExtensionLbl: Label '.%1', Locked = true;
        FileDialogTxt: Label 'Adjunto(s) (%1)|%1', Comment = '%1=Tipos, such as *.txt or *.docx';
        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;
        ImportTxt: Label 'Adjuntar archivo', Locked = true;
        SelectFileTxt: Label 'Adjuntar Archivos(s)...';
        PurchaseDocumentFlow: Boolean;
        ShareOptionsVisible: Boolean;
        ShareEditOptionVisible: Boolean;
        DownloadEnabled: Boolean;
        FlowToPurchTxt: Label 'Flow to Purch. Trx';
        FlowToSalesTxt: Label 'Flow to Sales Trx';
        FlowFieldsEditable: Boolean;
        EmailHasAttachments: Boolean;
        IsOfficeAddin: Boolean;
        IsMultiSelect: Boolean;
        MenuOptionsTxt: Label 'Attach from email,Upload file', Comment = 'Comma seperated phrases must be translated seperately.';
        SelectInstructionTxt: Label 'Choose the files to attach.';

    protected var
        FromRecRef: RecordRef;
        VallaFijada: Boolean;
        EsIncidencia: Boolean;

    local procedure InitiateAttachFromEmail()
    begin
        OfficeMgmt.InitiateSendToAttachments(FromRecRef);
        CurrPage.Update(true);
    end;



    procedure MarcaIncidencia()
    begin
        EsIncidencia := true;
    end;




    local procedure GetCaptionClass(FieldNo: Integer): Text
    begin
        if SalesDocumentFlow and PurchaseDocumentFlow then
            case FieldNo of
                9:
                    exit(FlowToPurchTxt);
                11:
                    exit(FlowToSalesTxt);
            end;
    end;






}