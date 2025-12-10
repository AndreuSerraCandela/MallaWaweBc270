/// <summary>
/// TableExtension Payment BufferKuara (ID 80234) extends Record Payment Buffer.
/// </summary>

// #pragma warning disable AL0432
// tableextension 80234 "Payment BufferKuara" extends "Payment Buffer"
// #pragma warning restore AL0432

// {
//     fields
//     {
//         field(50001; "Due Date"; Date) { }
//         field(50002; "Description"; TEXT[50]) { }
//         field(50003; "On Hold"; TEXT[3]) { }
//         field(50004; "Nombre"; TEXT[50]) { }
//         field(50005; "Banco"; CODE[10]) { }
//         field(50006; "Document Type"; Enum "Document Type Kuara") { }
//         field(50007; "Document Situation"; Enum "Document Situacion") { }
//         field(50008; "Cod. Forma Pago"; CODE[20]) { TableRelation = "Bank Account"; }
//     }
// }
