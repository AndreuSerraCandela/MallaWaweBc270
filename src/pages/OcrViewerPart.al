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
