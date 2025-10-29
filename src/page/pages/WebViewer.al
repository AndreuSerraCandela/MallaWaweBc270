/// <summary>
/// Page Web Viewer (ID 7001172).
/// </summary>
page 7001172 "Web Viewer"
{
    PageType = CardPart;
    Caption = 'Visor';
    layout
    {
        area(Content)
        {
            usercontrol(WebViewer; ImagesViewer)
            {
                ApplicationArea = All;
                trigger OnControlAddInReady()
                begin
                    InitializeViewer();

                end;

                trigger OnViewerReady()
                begin
                    ControlIsReady := true;
                    ShowData();
                end;
            }
        }

    }
    actions
    {
        area(Processing)
        {

            action(Ampliar)
            {
                Caption = 'Ampliar';
                ApplicationArea = ALL;
                Image = Find;
                trigger OnAction()
                var
                    myInt: Integer;
                    Pagina: Page "Web Viewer";
                begin
                    Pagina.LoadPdfFromBlob(Content);
                    Pagina.Amplia();
                    Pagina.Run();


                end;
            }
            action(Anterior)
            {
                Image = PreviousRecord;
                ApplicationArea = All;
                // Promoted = true;
                // PromotedIsBig = true;
                trigger OnAction()
                begin
                    Next_PreviosDocumennt(LDirection::Previos);
                end;

            }
            action(Siguiente)
            {
                Image = NextRecord;
                ApplicationArea = All;
                // Promoted = true;
                // PromotedIsBig = true;
                trigger OnAction()
                begin
                    Next_PreviosDocumennt(LDirection::Next);
                end;
            }
        }

    }

    var
        ControlIsReady: Boolean;
        Data: JsonObject;
        ContentType: Option URL,BASE64;
        Content: Text;
        LDirection: Option Previos,Next;
        wAmplia: Boolean;

    local procedure InitializeViewer()
    var
        PDFViewerMgt: Codeunit "Gestion Reservas";
    begin
        CurrPage.WebViewer.InitializeControl();
        if wAmplia then CurrPage.WebViewer.Ampliar();
    end;

    local procedure Next_PreviosDocumennt(pDirection: Option Previos,Next)
    var
        IStream: InStream;
        myInt: Integer;
        Base64String: Text;
        TempBlob2: Codeunit "Base64 Convert";
        JsonObj: Codeunit "Json Text Reader/Writer";
        JsonText: Text;
        OsTream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        Tipo: Text;
        Filename: Text;
        FileManagement: Codeunit "File Management";
        Tipos: Record "Tipo Recurso";
    begin
        if pDirection = pDirection::Next Then if NameValueBuffer.Next() = 0 Then exit;
        if pDirection = pDirection::Previos Then if NameValueBuffer.Next(-1) = 0 Then exit;
        JsonObj.WriteStartObject('');
        JsonObj.WriteStringProperty('type', 'imageLoad');

        JsonObj.WriteStartArray('data');

        //FileManagement.BLOBImportFromServerFile(TempBlob, NameValueBuffer.Name);
        FileManagement.BLOBImport(TempBlob, NameValueBuffer.Name);
        TempBlob.CreateInStream(IStream);
        //UploadIntoStream('', RD.URL1, 'ALL Files (*.*)|*.*', RD.URL1, IStream);

        Base64String := TempBlob2.ToBase64(IStream);
        JsonObj.WriteStartObject('');
        JsonObj.WriteStringProperty('type', 'image');
        Tipo := 'data:image/' + 'jpg';
        JsonObj.WriteStringProperty('content', tipo + ';base64,' + Base64String);
        JsonObj.WriteStringProperty('description', NameValueBuffer.Value);
        JsonObj.WriteEndObject();
        // until RD.Next() = 0;
        JsonObj.WriteEndArray();
        JsonObj.WriteEndObject();
        JsonText := JsonObj.GetJSonAsText();
        LoadPdfFromBlob(JsonText);
        ShowData();
    end;

    /// <summary>
    /// ShowData.
    /// </summary>
    procedure ShowData()
    begin
        if not ControlIsReady then exit;
        if Content = '' then
            exit;
        //Sleep(10000);
        Clear(Data);
        //Data.Add('type', 'imageLoad');
        //Data.Add('data', Content);
        //if not ControlIsReady then
        //  exit;
        CurrPage.WebViewer.LoadDocument(Data, Content);

        Clear(Data);
    end;

    /// <summary>
    /// LoadPdfViaUrl.
    /// </summary>
    /// <param name="Url">Text.</param>
    procedure LoadPdfViaUrl(Url: Text)
    begin
        ContentType := ContentType::URL;
        Content := Url;
    end;

    /// <summary>
    /// LoadPdfFromBlob.
    /// </summary>
    /// <param name="JsonObj">Text.</param>
    procedure LoadPdfFromBlob(JsonObj: Text)
    var
        Json: Codeunit "JSON Management";
    begin
        //       Data.ReadFrom(JsonObj);
        Content := JsonObj;
    end;
    /// <summary>
    /// CargaDocumentos.
    /// </summary>
    /// <param name="pNameValueBuffer">VAR Record "Name/Value Buffer".</param>
    procedure CargaDocumentos(var pNameValueBuffer: Record "Name/Value Buffer")
    begin
        if pNameValueBuffer.FindFirst() Then
            repeat
                if NameValueBuffer.Insert() then;
            until pNameValueBuffer.Next() = 0;
    end;

    var
        NameValueBuffer: Record "Name/Value Buffer";
    /// <summary>
    /// Amplia.
    /// </summary>
    procedure Amplia()
    begin
        wAmplia := true;
    end;

}
