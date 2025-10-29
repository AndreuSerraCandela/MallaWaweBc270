/// <summary>
/// Page PDF Viewer Part (ID 7001171).
/// </summary>
page 7001171 "PDF Viewer Part"
{
    PageType = CardPart;
    Caption = 'PDF Viewer';

    layout
    {
        area(Content)
        {
            usercontrol(PDFViewer; PDFViewer)
            {
                ApplicationArea = All;
                trigger OnControlAddInReady()
                begin
                    InitializePDFViewer();
                end;

                trigger OnPdfViewerReady()
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
                Image = Find;
                ApplicationArea = ALL;
                // Promoted = true;
                // PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    Pagina: Page "Pdf Viewer";
                begin

                    Pagina.LoadPdfFromBlob(Content);

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

            // area(Promoted)
            // {
            // actionref(Anterior_Promoted;Anterior){}
            // actionref(Siguiente_Promoted;Siguiente){}
            // actionref(Ampliar_Promoted;Ampliar){}
        }
        //}


    }

    var
        ControlIsReady: Boolean;
        Data: JsonObject;
        DataType: Option URL,BASE64;
        Content: Text;
        LDirection: Option Previos,Next;
        DocumentAttCh: Record "Document Attachment";
        wRecordId: RecordId;

    local procedure InitializePDFViewer()
    var
        PDFViewerMgt: Codeunit "Gestion Reservas";
    begin
        CurrPage.PDFViewer.InitializeControl(PDFViewerMgt.GetPdfViewerUrl());
    end;

    local procedure ShowData()
    begin
        if not ControlIsReady then
            exit;

        if not Data.Contains('content') then
            exit;

        CurrPage.PDFViewer.LoadDocument(Data);

        Clear(Data);
    end;

    /// <summary>
    /// LoadPdfViaUrl.
    /// </summary>
    /// <param name="Url">Text.</param>
    procedure LoadPdfViaUrl(Url: Text)
    begin
        Clear(Data);
        Content := Url;
        Data.Add('type', 'url');
        Data.Add('content', Url);
        ShowData();
    end;

    /// <summary>
    /// LoadPdfFromBase64.
    /// </summary>
    /// <param name="Base64Data">Text.</param>
    procedure LoadPdfFromBase64(Base64Data: Text)
    begin
        Content := Base64Data;
        Clear(Data);
        Data.Add('type', 'base64');
        Data.Add('content', Base64Data);
        ShowData();
    end;
    /// <summary>
    /// Next_PreviosDocumennt.
    /// </summary>
    /// <param name="Direction">Option Previos,Next.</param>
    procedure Next_PreviosDocumennt(Direction: Option Previos,Next)
    var
        DocumentStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        Bs64: Codeunit "Base64 Convert";
        Int: InStream;
        Base64Data: Text;
    begin
        if Direction = Direction::Next then
            if DocumentAttCh.Next() = 0 tHEN;
        if Direction = Direction::Previos then
            if DocumentAttCh.Next(-1) = 0 tHEN;
        TempBlob.CreateOutStream(DocumentStream);
        DocumentAttCh."Document Reference ID".ExportStream(DocumentStream);
        TempBlob.CreateInStream(Int);
        Base64Data := Bs64.ToBase64(Int);
        LoadPdfFromBase64(Base64Data);
    end;
    /// <summary>
    /// Registro.
    /// </summary>
    /// <param name="LRecorId">RecordId.</param>
    /// <param name="MostrarPrimero">Boolean.</param>
    procedure Registro(LRecorId: RecordId; MostrarPrimero: Boolean)
    var
        RecRef: RecordRef;
        DocTypeS: Enum "Sales Document Type";
        DocTypeD: Enum "Purchase Document Type";
        DocumentStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        Bs64: Codeunit "Base64 Convert";
        Int: InStream;
        Base64Data: Text;
    begin
        wRecordId := LRecorId;
        RecRef.Get(LRecorId);
        DocumentAttCh.SetRange("Table ID", LRecorId.TableNo);
        if LRecorId.TableNo > 100 then
            DocumentAttCh.SetRange("No.", RecRef.Field(1).Value);
        Case LRecorId.TableNo of
            36:
                begin
                    DocTypeS := RecRef.Field(1).Value;
                    DocumentAttCh.SetRange("No.", RecRef.Field(3).Value);
                    Case DocTypeS of
                        DocTypeS::"Blanket Order":
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::"Blanket Order");
                        DocTypeS::"Credit Memo":
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::"Credit Memo");
                        DocTypeS::Order:
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::Order);
                        DocTypeS::Quote:
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::Quote);
                        DocTypeS::Invoice:
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::Invoice);
                        DocTypeS::"Return Order":
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::"Return Order");
                    End;
                end;
            112:
                DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::Invoice);
            114:
                DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::"Credit Memo");
            38:
                begin
                    DocumentAttCh.SetRange("No.", RecRef.Field(3).Value);
                    DocTyped := RecRef.Field(1).Value;
                    Case DocTyped of
                        DocTyped::"Blanket Order":
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::"Blanket Order");
                        DocTyped::"Credit Memo":
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::"Credit Memo");
                        DocTyped::Order:
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::Order);
                        DocTyped::Quote:
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::Quote);
                        DocTyped::Invoice:
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::Invoice);
                        DocTyped::"Return Order":
                            DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::"Return Order");
                    End;
                end;
            122:
                DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::Invoice);
            144:
                DocumentAttCh.SetRange("Document Type", DocumentAttCh."Document Type"::"Credit Memo");
        end;

        if (MostrarPrimero) then
            if (DocumentAttCh.FindFirst()) then begin
                TempBlob.CreateOutStream(DocumentStream);
                DocumentAttCh."Document Reference ID".ExportStream(DocumentStream);
                TempBlob.CreateInStream(Int);
                Base64Data := Bs64.ToBase64(Int);
                LoadPdfFromBase64(Base64Data);
            end;
    end;
}