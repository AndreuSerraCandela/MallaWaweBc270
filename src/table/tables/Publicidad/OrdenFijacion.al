/// <summary>
/// Table Orden fijación (ID 7010481).
/// </summary>
table 7001202 "Cab Orden fijación"
{
    DrillDownPageID = "lista ordenes fijación";
    LookupPageID = "Lista ordenes fijación";
    DataCaptionFields = "Nº Orden", "Fecha fijación", "Nº Proyecto";
    fields
    {
        field(1; "Nº Orden"; Integer) { Description = 'PK'; }

        field(15; "Fecha generación"; Date) { }
        field(20; "Fecha fijación"; Date)
        {
            trigger OnValidate()
            var
                rDetOrden: Record "Orden fijación";
            begin
                rDetOrden.SetRange("Nº Orden", "Nº Orden");
                rDetOrden.ModifyAll("Fecha fijación", "Fecha fijación");
            end;
        }
        field(25; Operario; Code[20])
        {
            TableRelation = Employee;
            Description = 'FK Empleado';
        }
        field(30; "Nº Proyecto"; Code[20])
        {
            TableRelation = Job;
            Description = 'FK Proyecto';
        }
        field(35; Fijar; Text[30]) { }
        field(40; Tapar; Text[30]) { }
        field(45; Foto; Boolean) { }
        field(50; Validado; Boolean) { InitValue = true; }
        field(55; Zona; Code[20])
        {
            TableRelation = "Zonas Recursos";
            Description = 'FK Zonas';
        }
        field(56; "Tipo de Campaña"; Enum "Tipo de Movimiento")
        {

        }
        field(57; "Tipo Campaña"; enum "Tipo de Campaña Fijacion")
        { }
        field(58; "SalesPerson Code"; Code[20])
        {
            Caption = 'Comercial';
            TableRelation = "Salesperson/Purchaser";
        }
        field(59; "Nombre Comercial"; Text[250])
        {
            Caption = 'Anunciante';
            TableRelation = "Nombre Comercial".Nombre;
        }
        field(60; Grupo; Code[20])
        {
            TableRelation = "Customer"."No.";
        }
        field(61; "Fecha Retirada"; Date)
        {

        }
        field(63; "No. Opis"; Integer)
        {
            Caption = 'Nº Opis';
        }
        field(64; "Nº Vallas"; Integer)
        {
            Caption = 'Nº Vallas';
        }
        field(65; "Work Description"; BLOB)
        {
            Caption = 'Descriptión';
        }
        field(66; Image; Media) { }
        field(67; "Tipo soporte"; Option)
        {
            OptionMembers = " ",Valla,OPI,OTROS;
        }
        field(68; "Material Fijación"; enum "Material de Fijación") { }
        field(69; "Material"; Text[30]) { }
        field(71; "Título"; Text[250]) { }
        field(72; Revisión; Boolean)
        {
            Caption = 'Revisión';
        }
    }

    KEYS
    {
        Key(Principal; "Nº Orden") { Clustered = true; }
        Key(Proyecto; "Nº Proyecto", "Fecha fijación") { }

    }
    trigger OnDelete()
    var
        rDet: Record "Orden fijación";
        Images: Record "Imagenes Orden fijación";
    begin
        rDet.SETRANGE("Nº Orden", "Nº Orden");
        Images.SETRANGE("Nº Orden", "Nº Orden");
        Images.SetRange("Es Incidencia", false);
        ;
        Images.DELETEALL;
        rDet.DELETEALL;

    end;
    /// <summary>
    /// SetWorkDescription.
    /// </summary>
    /// <param name="NewWorkDescription">Text.</param>
    procedure SetWorkDescription(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Work Description");
        "Work Description".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;

    /// <summary>
    /// GetWorkDescription.
    /// </summary>
    /// <returns>Return variable WorkDescription of type Text.</returns>
    procedure GetWorkDescription() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Work Description");
        "Work Description".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Work Description")));
    end;

    PROCEDURE Duplicar(Orden: Record "Cab Orden fijación"; NFecha: Date; NTexto: Text[30]): Integer;
    VAR
        rOrden2: Record "Cab Orden fijación";
        rDet: Record "Orden fijación";
        rDetNew: Record "Orden fijación";
        rImagen: Record "Imagenes Orden fijación";
        rImagen2: Record "Imagenes Orden fijación";
        NuevaFecha: Date;
        finestra: Dialog;
        num: Integer;
    BEGIN

        if rOrden2.FIND('+') THEN
            num := rOrden2."Nº Orden" + 1;
        rOrden2 := Orden;
        rOrden2."Nº Orden" := num;
        rOrden2."Fecha generación" := WORKDATE;
        rOrden2."Fecha fijación" := NFecha;
        rOrden2.Fijar := NTexto;
        rOrden2.Tapar := Orden.Fijar;
        rOrden2.INSERT;
        rDet.SETRANGE("Nº Orden", Orden."Nº Orden");
        if rDet.FINDSET then
            repeat
                rDetNew := rDet;
                rDetNew."Nº Orden" := num;
                rDetNew."Fecha generación" := WORKDATE;
                rDetNew."Fecha fijación" := NFecha;
                rDetNew.INSERT;
            until rDet.NEXT = 0;
        rImagen.SETRANGE("Nº Orden", Orden."Nº Orden");
        if rImagen.FINDSET then
            repeat
                rImagen2 := rImagen;
                rImagen2."Nº Orden" := num;
                rImagen2.INSERT;
            until rImagen.NEXT = 0;
        exit(Num);
        //{MESSAGE('Orden #1######### creada', num);}
    END;


}
table 7001207 "Orden fijación"
{
    DataCaptionFields = "Nº Orden", "Fecha fijación", "Nº Proyecto";
    fields
    {
        field(1; "Nº Orden"; Integer) { Description = 'PK'; }
        field(5; "Nº Reserva"; Integer)
        {
            TableRelation = Reserva;
            Description = 'FK Reserva';
        }
        field(10; "Nº Recurso"; Code[20])
        {
            TableRelation = Resource;
            Description = 'FK Recurso';
        }
        field(15; "Fecha generación"; Date) { }
        field(20; "Fecha fijación"; Date) { }
        field(25; Operario; Code[20])
        {
            TableRelation = Employee;
            Description = 'FK Empleado';
        }
        field(30; "Nº Proyecto"; Code[20])
        {
            TableRelation = Job;
            Description = 'FK Proyecto';
        }
        field(35; Fijar; Text[30]) { }
        field(40; Tapar; Text[30]) { }
        field(45; Foto; Boolean) { }
        field(50; Validado; Boolean) { InitValue = true; }
        field(55; Zona; Code[20])
        {
            TableRelation = "Zonas Recursos";
            Description = 'FK Zonas';
        }
        field(56; "Tipo de Campaña"; Enum "Tipo de Movimiento")
        {

        }
        field(57; "Tipo Campaña"; enum "Tipo de Campaña Fijacion")
        { }
        field(58; "SalesPerson Code"; Code[20])
        {
            Caption = 'Comercial';
            TableRelation = "Salesperson/Purchaser";
        }
        field(59; "Nombre Comercial"; Text[250])
        {
            Caption = 'Anunciante';
            TableRelation = "Nombre Comercial".Nombre;
        }
        field(60; Grupo; Code[20])
        {
            TableRelation = "Customer"."No.";
        }
        field(61; "Fecha Retirada"; Date)
        {

        }
        field(63; "No. Opis"; Integer)
        {
            Caption = 'Nº Opis';
        }
        field(64; "Nº Vallas"; Integer)
        {
            Caption = 'Nº Vallas';
        }
        field(65; "Nº Imagen"; Integer)
        {
            Caption = 'Descriptión';
            TableRelation = "Imagenes Orden fijación"."Nº Imagen" where("Nº Orden" = field("Nº Orden"), "Nº Imagen" = field("Nº Imagen"));
        }
        field(66; Image; Media) { }
        field(68; "Image Resource"; Media) { }
        field(69; Image2; Media) { }
        field(70; "Image Resource2"; Media) { }
        // field(71; Image3; Media) { }
        // field(72; "Image Resource3"; Media) { }
        // field(73; Image4; Media) { }
        // field(74; "Image Resource4"; Media) { }
        field(67; "Estado Reserva"; Enum "Estado Reserva")
        { }
        field(71; "2ª Imagen"; Integer)
        {
            Caption = 'Descriptión';
            TableRelation = "Imagenes Orden fijación"."Nº Imagen" where("Nº Orden" = field("Nº Orden"), "Nº Imagen" = field("2ª Imagen"));
        }
        field(72; "Guardar o Tirar"; Option)
        {
            Caption = 'Guardar o Tirar';
            OptionMembers = " ",Guardar,Tirar;
        }
        field(73; "Imagen Valla Fijada"; Integer)
        {
            Caption = 'Descriptión';
            TableRelation = "Imagenes Orden fijación"."Nº Imagen" where("Nº Orden" = field("Nº Orden"), "Nº Imagen" = field("Imagen Valla Fijada"));
        }
        field(74; Retirar; Boolean)
        {
            trigger OnValidate()
            begin
                If Retirada = true Then
                    if not Confirm('Ya hay una orden de retirada para este recurso,¿Estás seguro de que quieres repetirla?', false) then
                        Error('Operación cancelada');
            end;
        }
        field(75; Retirada; Boolean)
        {

        }
        field(77; "Nº Qr"; Integer)
        {
            Caption = 'Descriptión';
            TableRelation = "Imagenes Orden fijación"."Nº Imagen" where("Nº Orden" = field("Nº Orden"), "Nº Imagen" = field("Nº Qr"));
        }
        field(76; "Qr"; Media) { }
        field(78; "Qr2"; Media) { }
        field(80; "Qr3"; Media) { }
        field(81; "Qr Retirada"; Media) { }
        field(79; "Empresa"; Text[30]) { }
        field(50008; "Observaciones"; Text[250])
        {
            Caption = 'Observaciones';

        }
        field(50009; "Material"; Text[250])
        {
            Caption = 'Material';
        }
        field(50010; Refijacion; Boolean)
        {
            Caption = 'Refijación';
        }

    }
    KEYS
    {
        Key(Principal; "Nº Orden", "Nº Reserva") { Clustered = true; }
        Key(Reserva; "Nº Reserva") { }
        Key(Recurso; "Nº Recurso") { }
        Key(Proyecto; "Nº Proyecto", "Fecha fijación") { }
        Key(Zona; Zona, "Nº Recurso") { }
    }
    PROCEDURE Duplicar(Num: Integer; rDet: Record "Orden fijación"; NFecha: Date; NTexto: Text[30]; Fijar: text);
    VAR
        NuevaFecha: Date;
        finestra: Dialog;
        rDet2: Record "Orden fijación";
    BEGIN

        rDet2 := rDet;
        rDet2."Nº Orden" := Num;
        rDet2."Fecha generación" := WORKDATE;
        rDet2."Fecha fijación" := NFecha;
        rDet2.Fijar := NTexto;
        rDet2.Tapar := Fijar;
        rDet2.INSERT;

        //{MESSAGE('Orden #1######### creada', num);}
    END;

    trigger OnInsert()
    var
        CabOrden: Record "Cab Orden fijación";
        Resource: Record Resource;
    begin
        If CabOrden.Get("Nº Orden") then begin
            Observaciones := CopyStr(CabOrden.GetWorkDescription(), 1, 250);
            Material := CopyStr(CabOrden.Material, 1, 250);
            if Resource.Get("Nº Recurso") then
                if Resource."Tipo Recurso" in ['OPIS', 'OPI'] then begin
                    CabOrden."No. Opis" := CabOrden."No. Opis" + 1;
                    CabOrden.Modify();
                end;
        end;
    end;




}
table 7001208 "Imagenes Orden fijación"
{
    DataCaptionFields = "Nº Orden";
    fields
    {
        field(1; "Nº Orden"; Integer) { Description = 'PK'; TableRelation = "Cab Orden fijación"."Nº Orden"; }
        field(5; "Nº Imagen"; Integer)
        {

        }
        field(65; "Nombre"; Text[250])
        {
            Caption = 'Nombre';

            NotBlank = true;


        }
        field(67; Url; Text[1024])
        {
            Caption = 'Nombre';

            NotBlank = true;


        }
        field(6; "Tipo"; Enum "Document Attachment File Type")
        {
            Caption = 'Tipo';

        }
        field(7; "Extension"; Text[30])
        {
            Caption = 'Extensión';

            trigger OnValidate()
            begin
                case LowerCase(Extension) of
                    'jpg', 'jpeg', 'bmp', 'png', 'tiff', 'tif', 'gif':
                        "Tipo" := "Tipo"::Image;
                    'pdf':
                        "Tipo" := "Tipo"::PDF;
                    'docx', 'doc':
                        "Tipo" := "Tipo"::Word;
                    'xlsx', 'xls':
                        "Tipo" := "Tipo"::Excel;
                    'pptx', 'ppt':
                        "Tipo" := "Tipo"::PowerPoint;
                    'msg':
                        "Tipo" := "Tipo"::Email;
                    'xml':
                        "Tipo" := "Tipo"::XML;
                    else
                        "Tipo" := "Tipo"::Other;
                end;
            end;
        }

        field(66; Image; Media) { }
        field(69; "Valla Fijada"; Boolean) { }
        field(70; Qr; Media) { }
        field(76; "Qr Retirada"; Media) { }
        field(71; "Es Qr"; Boolean) { }
        field(72; "Es Incidencia"; Boolean) { }
        field(73; Id; Integer)
        { }
        field(75; "Url Retirada"; Text[1024])
        {
            Caption = 'Nombre';

            NotBlank = true;


        }

    }
    KEYS
    {
        Key(Principal; "Nº Orden", "Nº Imagen") { Clustered = true; }

    }


    /// <summary>
    /// FromBase64ToUrl.
    /// </summary>
    /// <param name="Base64">text.</param>
    /// <param name="Filename">Text.</param>
    /// <param name="Id">VAR Integer.</param>
    /// <returns>Return variable ReturnValue of type Text.</returns>
    procedure FormBase64ToUrl(Base64: text; Filename: Text; var Id: Integer) ReturnValue: Text
    VAR
        Outstr: OutStream;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Token: Text;
        RestApiC: Codeunit Restapi;
        JsonObj: JsonObject;
        UrlToken: JsonToken;
        RequestType: Option Get,patch,put,post,delete;
        FileMgt: Codeunit "File Management";
        Json: Text;
        IdToken: JsonToken;
        Ok: Boolean;
    begin
        GeneralLedgerSetup.Get();
        case FileMgt.GetExtension(Filename) of
            'jpg', 'png', 'bmp', 'tif':
                Base64 := 'image/' + FileMgt.GetExtension(Filename) + ';base64,' + Base64;
            else
                Base64 := 'application/' + FileMgt.GetExtension(Filename) + ';base64,' + Base64;
        end;

        Repeat

            JsonObj.add('base64', base64);
            jsonobj.add('filename', filename);
            JsonObj.WriteTo(Json);
            Json := RestApiC.RestApiImagenes('https://base64-api.deploy.malla.es/' + 'save', RequestType::Post, Json);
            Clear(JsonObj);
            //Request failed with status code 400
            if Json = 'Request failed with status code 400' then
                Error('Error al guardar el archivo');
            Ok := JsonObj.ReadFrom(Json);
            if not Ok then
                sleep(5000);
        Until Ok;
        JsonObj.Get('url', UrlToken);
        JsonObj.Get('_id', IdToken);
        ReturnValue := UrlToken.AsValue().AsText;
        Id := IdToken.AsValue().AsInteger;
        exit(ReturnValue);
    end;
    /// <summary>
    /// ToBase64StringOcr.
    /// </summary>
    /// <param name="bUrl">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure ToBase64StringOcr(bUrl: Text): Text
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        JsonObj: JsonObject;
        Json: Text;
        RestapiC: Codeunit RestApi;
        RequestType: Option Get,patch,put,post,delete;
        base64Token: JsonToken;
        base64: Text;
    begin
        GeneralLedgerSetup.Get();
        JsonObj.add('url', bUrl);
        JsonObj.WriteTo(Json);
        Json := RestApiC.RestApiImagenes('https://base64-api.deploy.malla.es/' + 'fetch', RequestType::Post, Json);

        // Verificar si la respuesta es HTML (error 502, 404, etc.)
        if (StrPos(Json, '<!doctype html>') > 0) or
           (StrPos(Json, '<html>') > 0) or
           (StrPos(Json, 'NGINX 502 Error') > 0) or
           (StrPos(Json, 'Error') > 0) then begin
            exit(''); // Devolver cadena vacía si es una página de error
        end;

        // Verificar si la respuesta es JSON válido
        if not JsonObj.ReadFrom(Json) then begin
            // Si no es JSON válido, intentar extraer base64 directamente
            if (StrLen(Json) > 2) and (Json[1] = '"') and (Json[StrLen(Json)] = '"') then
                base64 := CopyStr(Json, 2, StrLen(Json) - 2)
            else
                base64 := Json;
        end else begin
            // Si es JSON válido, intentar obtener el campo base64
            if JsonObj.Get('base64', base64Token) then
                base64 := base64Token.AsValue().AsText()
            else
                base64 := CopyStr(Json, 2, StrLen(Json) - 2);
        end;

        exit(base64);
    end;

    /// <summary>
    /// DeleteId.
    /// </summary>
    /// <param name="Id">Integer.</param>
    /// <returns>Return value of type Text.</returns>
    procedure DeleteId(Id: Integer): Text
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        JsonObj: JsonObject;
        Json: Text;
        RestapiC: Codeunit RestApi;
        RequestType: Option Get,patch,put,post,delete;
        base64Token: JsonToken;
        base64: Text;
    begin
        GeneralLedgerSetup.Get();
        Json := RestApiC.RestApiImagenes('https://base64-api.deploy.malla.es/' + 'delete/' + Format(Id), RequestType::delete, '');
        //Clear(JsonObj);
        //JsonObj.ReadFrom(Json);
        //JsonObj.Get('base64', base64Token);
        exit(Json);

    end;

    /// <summary>
    /// SetWorkDescription.
    /// </summary>
    /// <param name="NewWorkDescription">Text.</param>


    /// <summary>
    /// GetWorkDescription.
    /// </summary>
    /// <returns>Return variable WorkDescription of type Text.</returns>
    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        if IncomingFileName <> '' then begin
            Validate(Extension, FileManagement.GetExtension(IncomingFileName));
            Validate("Nombre", CopyStr(FileManagement.GetFileNameWithoutExtension(IncomingFileName), 1, MaxStrLen("Nombre")));
        end;




    end;

    var
        FileManagement: Codeunit "File Management";
        IncomingFileName: Text;
        NoDocumentAttachedErr: Label 'Please attach a document first.';
        EmptyFileNameErr: Label 'Please choose a file to attach.';
        NoContentErr: Label 'The selected file has no content. Please choose another file.';
        DuplicateErr: Label 'This file is already attached to the document. Please choose another file.';

    procedure ImportAttachment(DocumentInStream: InStream; FileName: Text)
    begin
        Rec.Image.ImportStream(DocumentInStream, FileName);
        if not Rec.Image.HasValue() then
            Error(NoDocumentAttachedErr);


        Rec.Modify();
    end;

    procedure Export(ShowFileDialog: Boolean) Result: Text
    var
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        DocumentStream: OutStream;
        FullFileName: Text;
        IsHandled: Boolean;
        Base64Convert: Codeunit "Base64 Convert";
        Ins: Instream;

    begin
        If Url <> '' Then begin
            TempBlob.CreateOutStream(DocumentStream);
            Base64Convert.FromBase64(ToBase64StringOcr(Url), DocumentStream);
            TempBlob.CreateInStream(Ins);
            Image.ImportStream(Ins, Nombre + '.' + "Extension");
        end;
        exit(Result);
    end;

    procedure SaveAttachment(RecRef: RecordRef; FileName: Text; TempBlob: Codeunit "Temp Blob")
    begin
        SaveAttachment(RecRef, FileName, TempBlob, true);
    end;

    procedure SaveAttachment(RecRef: RecordRef; FileName: Text; TempBlob: Codeunit "Temp Blob"; AllowDuplicateFileName: Boolean)
    var
        DocStream: InStream;
    begin

        if FileName = '' then
            Error(EmptyFileNameErr);
        // Validate file/media is not empty
        if not TempBlob.HasValue() then
            Error(NoContentErr);

        TempBlob.CreateInStream(DocStream);
        InsertAttachment(DocStream, RecRef, FileName, AllowDuplicateFileName);
    end;

    procedure SaveAttachmentFromStream(DocStream: InStream; RecRef: RecordRef; FileName: Text)
    begin
        SaveAttachmentFromStream(DocStream, RecRef, FileName, true);
    end;

    procedure SaveAttachmentFromStream(DocStream: InStream; RecRef: RecordRef; FileName: Text; AllowDuplicateFileName: Boolean)
    begin

        if FileName = '' then
            Error(EmptyFileNameErr);

        InsertAttachment(DocStream, RecRef, FileName, AllowDuplicateFileName);
    end;

    procedure InsertAttachment(DocStream: InStream; RecRef: RecordRef; FileName: Text; AllowDuplicateFileName: Boolean)
    var
        IsHandled: Boolean;
        Base64Convert: Codeunit "Base64 Convert";
        Base64: Text;
    begin

        IncomingFileName := FileName;

        Validate(Extension, FileManagement.GetExtension(IncomingFileName));
        Validate("Nombre", CopyStr(FileManagement.GetFileNameWithoutExtension(IncomingFileName), 1, MaxStrLen("Nombre")));



        Base64 := Base64Convert.ToBase64(DocStream);
        Url := FormBase64ToUrl(Base64, Filename, "Nº Imagen");
        Id := "Nº Imagen";
        Insert(true);
    end;

    procedure InsertAttachment(DocStream: InStream; FileName: Text; AllowDuplicateFileName: Boolean)
    var
        IsHandled: Boolean;
        Base64Convert: Codeunit "Base64 Convert";
        Base64: Text;
    begin

        IncomingFileName := FileName;

        Validate(Extension, FileManagement.GetExtension(IncomingFileName));
        Validate("Nombre", CopyStr(FileManagement.GetFileNameWithoutExtension(IncomingFileName), 1, MaxStrLen("Nombre")));



        Base64 := Base64Convert.ToBase64(DocStream);
        Url := FormBase64ToUrl(Base64, Filename, "Nº Imagen");
        Id := "Nº Imagen";
        Insert(true);
    end;








    local procedure GetNextFileName(FileName: Text[250]; FileIndex: Integer): Text[250]
    begin
        exit(StrSubstNo('%1 (%2)', FileName, FileIndex));
    end;


}

