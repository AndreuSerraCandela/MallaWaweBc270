/// <summary>
/// Page Ocr Viewer (ID 7001107).
/// </summary>
page 7001107 "Ocr Viewer Part"
{
    PageType = CardPart;
    Extensible = true;
    SourceTable = "Imagenes Orden fijación";
    Caption = 'Web';

    layout
    {

        area(Content)
        {


            field(Image; Rec.Image)
            {
                ShowCaption = false;
                ApplicationArea = All;
            }


        }
    }
    actions
    {
        area(Processing)
        {
            action("Ampliar")
            {
                Caption = 'Abrir enlace';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Hyperlink(Url);
                end;
            }
        }
    }

    var
        ControlIsReady: Boolean;
        Data: JsonObject;
        ContentType: Option URL,BASE64;
        Content: Text;
        Url: Text;
        UlrCompleta: Boolean;
        User: Text;
        Pass: Text;
        Name: Text;

    /// <summary>
    /// SetUrl.
    /// </summary>
    /// <param name="pUrl">Text.</param>
    procedure SetUrl(pUrl: Text)
    begin
        Url := pUrl;

    end;

    trigger OnAfterGetRecord()
    var
        base64: Text;
        Base64Convert: Codeunit "Base64 Convert";
        OutStr: OutStream;
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";
    begin
        Url := Rec.Url;
        if Url = '' Then exit;
        Base64 := Rec.ToBase64StringOcr(Url);
        TempBlob.CreateOutStream(OutStr);
        Base64Convert.FromBase64(base64, OutStr);
        TempBlob.CreateInStream(InStr);
        Clear(Rec.image);
        Rec.Image.ImportStream(InStr, Rec.Nombre);
    end;

    /// <summary>
    /// SetUrl2.
    /// </summary>



    // local procedure InitializePageViewer(PageUrl: Text)
    // var
    //     GeneralSetup: Record "General Ledger Setup";
    //     UserSetup: Record "User Setup";
    //     Http: Text;
    // begin
    //     if Url <> '' then
    //         CurrPage.web.InitializeControl(PageUrl);
    //     //CurrPage.Web.addButton('Ampliar', Url);
    // end;





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
    /// <param name="Base64Data">Text.</param>
    procedure LoadPdfFromBlob(Base64Data: Text)
    begin
        ContentType := ContentType::BASE64;
        Content := Base64Data;
    end;

}
