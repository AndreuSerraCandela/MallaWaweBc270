// /// <summary>
// /// TableExtension IncomingDocumentAttCh (ID 80139) extends Record Incoming Document Attachment.
// /// </summary>
/// <summary>
/// TableExtension IncomingDocumentAttCh (ID 80139) extends Record Incoming Document Attachment.
/// </summary>
// tableextension 80139 IncomingDocumentAttCh extends "Incoming Document Attachment"
// {
//     // fields
//     // {
//     //     field(80100; Comunicado; Boolean)
//     //     {
//     //         DataClassification = ToBeClassified;
//     //     }
//     //     field(80101; "Link ID"; Integer)
//     //     {

//     //     }
//     //     field(80102; PasadoaFactura; Boolean)
//     //     {
//     //         DataClassification = ToBeClassified;
//     //     }

//     // }

//     // end;

//     // /// <summary>
//     // /// ViewInPdfViewer.
//     // /// </summary>
//     // procedure ViewInPdfViewer()
//     // var
//     //     PDFViever: Page "PDF Viewer";
//     // begin
//     //     if Type <> Type::PDF then
//     //         exit;
//     //     PDFViever.LoadPdfFromBlob(ToBase64String());
//     //     PDFViever.Run();
//     // end;

//     // /// <summary>
//     // /// ToBase64String.
//     // /// </summary>
//     // /// <returns>Return variable ReturnValue of type Text.</returns>
//     // procedure ToBase64String() ReturnValue: Text
//     // var
//     //     insStr: InStream;
//     //     TempBlob2: Codeunit "Base64 Convert";
//     // begin
//     //     CalcFields(Content);
//     //     if not Content.HasValue() then
//     //         exit;
//     //     Content.CreateInStream(insStr);
//     //     ReturnValue := TempBlob2.ToBase64(insStr);
//     // end;
//}