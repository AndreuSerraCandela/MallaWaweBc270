// /// <summary>
// /// Page Ocr Viewer (ID 7001174).
// /// </summary>
// page 7001174 "Ocr Viewer"
// {
//     PageType = Worksheet;
//     Extensible = true;

//     Caption = 'Kuara Frimas';

//     layout
//     {

//         area(Content)
//         {

//             usercontrol(Ocr; KuaraFirmas)
//             {

//                 ApplicationArea = All;

//                 trigger OnControlAddInReady()
//                 begin
//                     InitializeOcrViewer(Url, Name);
//                 end;

//             }

//         }
//     }

//     var
//         ControlIsReady: Boolean;
//         Data: JsonObject;
//         ContentType: Option URL,BASE64;
//         Content: Text;
//         Url: Text;
//         Name: Text;

//         UlrCompleta: Boolean;
//         User: Text;
//         Pass: Text;



//     /// <summary>
//     /// SetUrl.
//     /// </summary>
//     /// <param name="pUrl">Text.</param>
//     /// <param name="pName">Text.</param>
//     procedure SetUrl(pUrl: Text; pName: Text)
//     begin
//         Url := pUrl;
//         Name := pName;
//     end;
//     /// <summary>
//     /// SetUrl2.
//     /// </summary>
//     /// <param name="pUrl">Text.</param>
//     /// <param name="puser">Text.</param>
//     /// <param name="ppass">Text.</param>
//     /// <param name="PName">Text.</param>
//     procedure SetUrl2(pUrl: Text; puser: Text; ppass: Text; PName: Text)
//     begin
//         Url := pUrl;
//         UlrCompleta := true;
//         User := puser;
//         Pass := pPass;
//         Name := PName;
//     end;


//     local procedure InitializeOcrViewer(PageUrl: Text; PName: Text)
//     var
//         GeneralSetup: Record "General Ledger Setup";
//         UserSetup: Record "User Setup";
//         Http: Text;
//     begin
//         GeneralSetup.Get;
//         if not UserSetup.Get(UserId) Then usersetup.Init();
//         Http := 'http://localhost:2064/';
//         if GeneralSetup.URLOCR <> '' then Http := GeneralSetup.URLOCR;
//         if PageUrl <> '' Then Http := Http + PageUrl else Http := Http + 'default.aspx/';
//         CurrPage.Ocr.InitializeControl(Http);
//     end;


//     /// <summary>
//     /// LoadPdfViaUrl.
//     /// </summary>
//     /// <param name="Url">Text.</param>
//     procedure LoadPdfViaUrl(Url: Text)
//     begin
//         ContentType := ContentType::URL;
//         Content := Url;
//     end;

//     /// <summary>
//     /// LoadPdfFromBlob.
//     /// </summary>
//     /// <param name="Base64Data">Text.</param>
//     procedure LoadPdfFromBlob(Base64Data: Text)
//     begin
//         ContentType := ContentType::BASE64;
//         Content := Base64Data;
//     end;

// }