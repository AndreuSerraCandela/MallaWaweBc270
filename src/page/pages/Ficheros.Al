
page 7001165 "Visor"
{
    PageType = Worksheet;
    Extensible = true;

    Caption = 'Visor Kuara';

    layout
    {


        area(Content)
        {

            usercontrol(Ocr; KuaraFirmas)
            {

                ApplicationArea = All;

                trigger OnControlAddInReady()
                begin
                    InitializeOcrViewer(Url);
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


    /// <summary>
    /// SetUrl.
    /// </summary>
    /// <param name="pUrl">Text.</param>
    procedure SetUrl(pUrl: Text)
    begin
        Url := pUrl;

    end;

    trigger OnAfterGetRecord()
    begin
        InitializeOcrViewer(Url);
    end;

    local procedure InitializeOcrViewer(PageUrl: Text)
    var
        GeneralSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        Http: Text;

    begin
        GeneralSetup.Get;
        // UserSetup.Get(UserId);
        // Http := 'http://localhost:2064/';
        // if GeneralSetup.URLOCR <> '' then Http := GeneralSetup.URLOCR;
        //if PageUrl <> '' Then Http := Http + PageUrl else Http := Http + 'default.aspx/';
        CurrPage.Ocr.InitializeControl(PageUrl)
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
    /// <param name="Base64Data">Text.</param>
    procedure LoadPdfFromBlob(Base64Data: Text)
    begin
        ContentType := ContentType::BASE64;
        Content := Base64Data;
    end;


}