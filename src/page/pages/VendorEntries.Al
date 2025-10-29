/// <summary>
/// Page Vendor LedgerEntries (ID 7001124).
/// </summary>
// page 7001124 "Vendor LedgerEntries"
// {
//     ApplicationArea = Basic, Suite;
//     Caption = 'Vendor Ledger Entries';
//     DataCaptionFields = "Vendor No.";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     Permissions = TableData "Vendor Ledger Entry" = m;
//     SourceTable = "Vendor Ledger Entry";
//     SourceTableView = SORTING("Vendor No.", "Posting Date") ORDER(Descending);
//     UsageCategory = History;
//     AdditionalSearchTerms = 'Vendor Check, Pay Vendor, Vendor Bills';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     Caption = 'Fecha Registro';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica la fecha de registro del movimiento.';
//                 }
//                 field("Document Date"; Rec."Document Date")
//                 {
//                     Caption = 'Fecha Documento';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica la fecha del documento del movimiento.';
//                 }
//                 // field("Invoice Received Date"; Rec."Invoice Received Date")
//                 // {
//                 //     Caption = 'Fecha Recibido';
//                 //     ApplicationArea = Basic, Suite;
//                 //     Editable = false;
//                 //     ToolTip = 'Especifica la fecha en la que se recibió la factura del proveedor.';
//                 //     Visible = false;
//                 // }
//                 field("Autodocument No."; Rec."Autodocument No.")
//                 {
//                     Caption = 'Autodocumento';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Este campo se utiliza internamente.';
//                 }
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     Caption = 'Tipo Documento';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     StyleExpr = StyleTxt;
//                     ToolTip = 'Especifica el tipo de documento al que pertenecel movimiento.';
//                 }
//                 field("Document No."; Rec."Document No.")
//                 {
//                     Caption = 'Nº Documento';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     StyleExpr = StyleTxt;
//                     ToolTip = 'Especifica el número de documento del movimiento.';
//                 }
//                 field("Bill No."; Rec."Bill No.")
//                 {
//                     Caption = 'Nº Efecto';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el número de efecto relacionado con el movimiento de proveedor.';
//                 }
//                 field("Document Situation"; Rec."Document Situation")
//                 {
//                     Caption = 'Situación Documento';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica la ubicación del documento.';
//                 }
//                 field("Document Status"; Rec."Document Status")
//                 {
//                     Caption = 'Estado Documento';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el estado del documento.';
//                 }
//                 field("External Document No."; Rec."External Document No.")
//                 {
//                     Caption = 'Nº Documento Externo';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el número de documento externo del movimiento.';

//                 }
//                 field("Vendor No."; Rec."Vendor No.")
//                 {
//                     Caption = 'Nº Proveedor';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el número del proveedor que envió la factura.';
//                 }
//                 field("Vendor Name"; Rec."Vendor Name")
//                 {
//                     Caption = 'Nombre Proveedor';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     Visible = VendNameVisible;
//                 }
//                 field("Message to Recipient"; Rec."Message to Recipient")
//                 {
//                     Caption = 'Mensaje Destinatario';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el mensaje que se muestra en la factura.';
//                     Visible = false;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     Caption = 'Descripción';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica la descripción del movimiento.';
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     Editable = false;
//                     ToolTip = 'Especifica el código de la dimensión global que está vinculada al registro o movimiento con fines de análisis. En todas las tarjetas, documentos, informes y listas están disponibles dos dimensiones globales, normalmente para las actividades más importantes de la empresa.';
//                     Visible = Dim1Visible;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     Editable = false;
//                     ToolTip = 'Especifica el código de la dimensión global que está vinculada al registro o movimiento con fines de análisis. En todas las tarjetas, documentos, informes y listas están disponibles dos dimensiones globales, normalmente para las actividades más importantes de la empresa.';
//                     Visible = Dim2Visible;
//                 }
//                 field("Vendor Posting Group"; Rec."Vendor Posting Group")
//                 {
//                     Caption = 'Grupo Contable';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el grupo contable del proveedor.';
//                     Visible = false;
//                 }
//                 field("IC Partner Code"; Rec."IC Partner Code")
//                 {
//                     Caption = 'Código Intercompañía';
//                     ApplicationArea = Intercompany;
//                     Editable = false;
//                     ToolTip = 'Especifica el código de la compañía intercompañía.';
//                     Visible = false;
//                 }
//                 field("Purchaser Code"; Rec."Purchaser Code")
//                 {
//                     Caption = 'Código Comprador';
//                     ApplicationArea = Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el código del comprador.';
//                     Visible = false;
//                 }
//                 field("Currency Code"; Rec."Currency Code")
//                 {
//                     Caption = 'Código Divisa';
//                     ApplicationArea = Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el código de la divisa del movimiento.';
//                 }
//                 field("Payment Method Code"; Rec."Payment Method Code")
//                 {
//                     Caption = 'Código Forma Pago';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el código de la forma de pago del movimiento.';
//                 }
//                 field(Banco; Rec.Banco)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Payment Reference"; Rec."Payment Reference")
//                 {
//                     Caption = 'Referencia Pago';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica la referencia de pago del movimiento.';
//                 }
//                 field("Creditor No."; Rec."Creditor No.")
//                 {
//                     Caption = 'Nº Acreedor';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el número de acreedor del movimiento.';
//                 }
//                 field("Original Amount"; Rec."Original Amount")
//                 {
//                     Caption = 'Importe Original';
//                     Visible = false;
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el importe original del movimiento.';
//                 }
//                 field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)")
//                 {
//                     Caption = 'Importe Original (DL)';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el importe original del movimiento en divisa local.';
//                     Visible = false;
//                 }
//                 field(Amount; Rec.Amount)
//                 {
//                     Caption = 'Importe';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el importe del movimiento.';
//                     Visible = AmountVisible;
//                 }
//                 field("Amount (LCY)"; Rec."Amount (LCY)")
//                 {
//                     Caption = 'Importe (DL)';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el importe del movimiento en divisa local.';
//                     Visible = false;
//                 }
//                 field("Debit Amount"; Rec."Debit Amount")
//                 {
//                     Caption = 'Importe Debe';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el importe debe del movimiento que representa los débitos.';
//                     Visible = DebitCreditVisible;
//                 }
//                 field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
//                 {
//                     Caption = 'Importe Debe (DL)';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el importe debe del movimiento que representa los débitos en divisa local.';
//                     Visible = false;
//                 }
//                 field("Credit Amount"; Rec."Credit Amount")
//                 {
//                     Caption = 'Importe Haber';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el importe haber del movimiento que representa los créditos.';
//                     Visible = DebitCreditVisible;
//                 }
//                 field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
//                 {
//                     Caption = 'Importe Haber (DL)';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el importe haber del movimiento que representa los créditos en divisa local.';
//                     Visible = false;
//                 }
//                 field("Remaining Amount"; Rec."Remaining Amount")
//                 {
//                     Caption = 'Importe Pendiente';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el importe pendiente del movimiento.';
//                 }
//                 field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
//                 {
//                     Caption = 'Importe Pendiente (DL)';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el importe pendiente del movimiento en divisa local.';
//                     Visible = false;
//                 }
//                 field("Bal. Account Type"; Rec."Bal. Account Type")
//                 {
//                     Caption = 'Contrapartida';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el tipo de cuenta de contrapartida del movimiento.';
//                     Visible = false;
//                 }
//                 field("Bal. Account No."; Rec."Bal. Account No.")
//                 {
//                     Caption = 'Cuenta Contrapartida';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el número de cuenta de contrapartida del movimiento.';
//                     Visible = false;
//                 }
//                 field("Due Date"; Rec."Due Date")
//                 {
//                     Caption = 'Fecha Vencimiento';
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleTxt;
//                     ToolTip = 'Especifica la fecha de vencimiento del movimiento.';
//                 }
//                 field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
//                 {
//                     Caption = 'Fecha Descuento prepago';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica la fecha de descuento prepago del movimiento.';
//                 }
//                 field("Pmt. Disc. Tolerance Date"; Rec."Pmt. Disc. Tolerance Date")
//                 {
//                     Caption = 'Fecha Tolerancia Descuento';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica la fecha de tolerancia de descuento del movimiento.';
//                 }
//                 field("Original Pmt. Disc. Possible"; Rec."Original Pmt. Disc. Possible")
//                 {
//                     Caption = 'Descuento prepago original';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el descuento prepago original del movimiento.';
//                     Visible = false;
//                 }
//                 field("Remaining Pmt. Disc. Possible"; Rec."Remaining Pmt. Disc. Possible")
//                 {
//                     Caption = 'Descuento prepago pendiente';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el descuento prepago pendiente del movimiento.';
//                     Visible = false;
//                 }
//                 field("Pmt. Disc. Rcd.(LCY)"; Rec."Pmt. Disc. Rcd.(LCY)")
//                 {
//                     Caption = 'Descuento prepago recibido (DL)';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el descuento prepago recibido del movimiento en divisa local.';
//                 }
//                 field("Max. Payment Tolerance"; Rec."Max. Payment Tolerance")
//                 {
//                     Caption = 'Tolerancia Pago';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica la tolerancia de pago del movimiento.';
//                 }
//                 field(Open; Rec.Open)
//                 {
//                     Caption = 'Pendiente';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica si el movimiento está pendiente.';
//                 }
//                 field("On Hold"; Rec."On Hold")
//                 {
//                     Caption = 'En Espera';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica si el movimiento está retenido.';
//                 }
//                 field("User ID"; Rec."User ID")
//                 {
//                     Caption = 'Usuario';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el usuario que creó el movimiento.';
//                     Visible = false;

//                     trigger OnDrillDown()
//                     var
//                         UserMgt: Codeunit "User Management";
//                     begin
//                         UserMgt.DisplayUserInformation(Rec."User ID");
//                     end;
//                 }
//                 field("Source Code"; Rec."Source Code")
//                 {
//                     Caption = 'Código Origen';
//                     ApplicationArea = Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el código de origen del movimiento.';
//                     Visible = false;
//                 }
//                 field("Reason Code"; Rec."Reason Code")
//                 {
//                     Caption = 'Código Motivo';
//                     ApplicationArea = Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el código de motivo del movimiento.';
//                     Visible = false;
//                 }
//                 field(Reversed; Rec.Reversed)
//                 {
//                     Caption = 'Revertido';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica si el movimiento está revertido.';
//                     Visible = false;
//                 }
//                 field("Reversed by Entry No."; Rec."Reversed by Entry No.")
//                 {
//                     Caption = 'Revertido por nº movimiento';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el número de movimiento revertido.';
//                     Visible = false;
//                 }
//                 field("Reversed Entry No."; Rec."Reversed Entry No.")
//                 {
//                     Caption = 'Nº Movimiento Revertido';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el número del movimiento original que fue deshecho por la transacción revertida.';
//                     Visible = false;
//                 }
//                 field("Entry No."; Rec."Entry No.")
//                 {
//                     Caption = 'Nº Movimiento';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica el número del movimiento.';
//                 }
//                 field("Exported to Payment File"; Rec."Exported to Payment File")
//                 {
//                     Caption = 'Exportado a Archivo Pago';
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                     ToolTip = 'Especifica que el movimiento se creó como resultado de la exportación de una línea de diario de pago.';

//                     trigger OnValidate()
//                     var
//                         ConfirmManagement: Codeunit "Confirm Management";
//                     begin
//                         if not ConfirmManagement.GetResponseOrDefault(ExportToPaymentFileConfirmTxt, true) then
//                             Error('');
//                     end;
//                 }
//                 field("Dimension Set ID"; Rec."Dimension Set ID")
//                 {
//                     Caption = 'Id Dimension';
//                     ApplicationArea = Dimensions;
//                     ToolTip = 'Especifica una referencia a una combinación de valores de dimensión. Los valores reales se almacenan en la tabla de movimientos de conjunto de dimensiones.';
//                     Visible = false;
//                 }
//                 field(RecipientBankAcc; Rec."Recipient Bank Account")

//                 {
//                     Caption = 'Cuenta Bancaria Destinatario';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica la cuenta bancaria del destinatario.';
//                 }
//                 field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     Editable = false;
//                     ToolTip = 'Especifica el código de la dimensión abreviada 3, que es uno de los códigos de dimensión que configuró en la ventana Configuración de contabilidad.';
//                     Visible = Dim3Visible;
//                 }
//                 field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     Editable = false;
//                     ToolTip = 'Especifica el código de la dimensión abreviada 4, que es uno de los códigos de dimensión que configuró en la ventana Configuración de contabilidad.';
//                     Visible = Dim4Visible;
//                 }
//                 field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     Editable = false;
//                     ToolTip = 'Especifica el código de la dimensión abreviada 5, que es uno de los códigos de dimensión que configuró en la ventana Configuración de contabilidad.';
//                     Visible = Dim5Visible;
//                 }
//                 field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     Editable = false;
//                     ToolTip = 'Specifies the code for Shortcut Dimension 6, which is one of dimension codes that you set up in the General Ledger Setup window.';
//                     Visible = Dim6Visible;
//                 }
//                 field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     Editable = false;
//                     ToolTip = 'Specifies the code for Shortcut Dimension 7, which is one of dimension codes that you set up in the General Ledger Setup window.';
//                     Visible = Dim7Visible;
//                 }
//                 field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     Editable = false;
//                     ToolTip = 'Specifies the code for Shortcut Dimension 8, which is one of dimension codes that you set up in the General Ledger Setup window.';
//                     Visible = Dim8Visible;
//                 }
//                 field("Closed at Date"; Rec."Closed at Date")
//                 {
//                     Caption = 'Cerrado a Fecha';
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Especifica la fecha en la que se cerró el movimiento.';
//                     Visible = false;
//                 }
//                 field("Remit-to Code"; Rec."Remit-to Code")
//                 {
//                     Caption = 'Código Remitente';
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Especifica el código del remitente.';
//                     Visible = true;
//                     TableRelation = "Remit Address".Code WHERE("Vendor No." = FIELD("Vendor No."));
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
//             {
//                 Caption = 'Archivos de documento entrantes';
//                 ApplicationArea = Basic, Suite;
//                 ShowFilter = false;
//             }
//             systempart(Control1900383207; Links)
//             {
//                 ApplicationArea = RecordLinks;
//                 Visible = false;
//             }
//             systempart(Control1905767507; Notes)
//             {
//                 ApplicationArea = Notes;
//                 Visible = false;
//             }
//             part(GLEntriesPart; "G/L Entries Part")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Movs contabilidad relacionados';
//                 ShowFilter = false;
//                 SubPageLink = "Posting Date" = field("Posting Date"), "Document No." = field("Document No.");
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Ent&ry")
//             {
//                 Caption = 'Mo&vimientos';
//                 Image = Entry;
//                 action(AppliedEntries)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Movimientos &Liquidadados';
//                     Image = Approve;
//                     RunObject = Page "Applied Vendor Entries";
//                     RunPageOnRec = true;
//                     Scope = Repeater;
//                     ToolTip = 'Ver los movimientos de contabilidad que se han aplicado a este registro.';
//                 }
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData Dimension = R;
//                     ApplicationArea = Dimensions;
//                     Caption = 'Dimensiones';
//                     Image = Dimensions;
//                     Scope = Repeater;
//                     ShortCutKey = 'Alt+D';
//                     ToolTip = 'Ver o editar dimensiones, como área, proyecto o departamento, que se pueden asignar a documentos de ventas y compras para distribuir costos y analizar el historial de transacciones.';

//                     trigger OnAction()
//                     begin
//                         Rec.ShowDimensions();
//                     end;
//                 }
//                 action(SetDimensionFilter)
//                 {
//                     ApplicationArea = Dimensions;
//                     Caption = 'Establecer Filtro de Dimensión';  // Traducido
//                     Ellipsis = true;
//                     Image = "Filter";
//                     ToolTip = 'Limita las movimientos según los filtros de dimensión que especifiques.';  // Traducido

//                     trigger OnAction()
//                     begin
//                         Rec.SetFilter("Dimension Set ID", DimensionSetIDFilter.LookupFilter());
//                     end;
//                 }
//                 action("Detailed &Ledger Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'movimientos Detalladas del &Libro Mayor';  // Traducido
//                     Image = View;
//                     RunObject = Page "Detailed Vendor Ledg. Entries";
//                     RunPageLink = "Vendor Ledger Entry No." = FIELD("Entry No."),
//                                 "Vendor No." = FIELD("Vendor No.");
//                     RunPageView = SORTING("Vendor Ledger Entry No.", "Posting Date");
//                     Scope = Repeater;
//                     ShortCutKey = 'Ctrl+F7';
//                     ToolTip = 'Ver un resumen de todas las movimientos publicadas y ajustes relacionados con una movimiento específica del libro de proveedores.';  // Traducido
//                 }

//             }
//         }
//         area(processing)
//         {
//             group("F&unctions")
//             {
//                 Caption = 'F&unciones';  // Traducido
//                 Image = "Action";
//                 action(ActionApplyEntries)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Liquidar Movimientos';  // Traducido
//                     Image = ApplyEntries;
//                     Scope = Repeater;
//                     ShortCutKey = 'Shift+F11';
//                     ToolTip = 'Selecciona una o más movimientos del libro que quieras aplicar a este registro para que los documentos publicados relacionados se cierren como pagados o reembolsados.';  // Traducido

//                     // ...
//                 }
//                 action(UnapplyEntries)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'DesLiquidar movimientos';  // Traducido
//                     Ellipsis = true;
//                     Image = UnApply;
//                     Scope = Repeater;
//                     ToolTip = 'Desmarca una o más movimientos del libro que quieras desaplicar a este registro.';  // Traducido

//                     // ...
//                 }
//                 group(IncomingDocument)
//                 {
//                     Caption = 'Documento Entrante';  // Traducido
//                     Image = Documents;
//                     action(IncomingDocCard)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Ver Documento Entrante';  // Traducido
//                         Enabled = HasIncomingDocument;
//                         Image = ViewOrder;
//                         ToolTip = 'Ver cualquier registro de documento entrante y archivos adjuntos que existan para el movimiento o el documento.';  // Traducido

//                         // ...
//                     }
//                     action(SelectIncomingDoc)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Seleccionar Documento Entrante';  // Traducido
//                         Enabled = NOT HasIncomingDocument;
//                         Image = SelectLineToApply;
//                         ToolTip = 'Selecciona un registro de documento entrante y un archivo adjunto que quieras vincular a el movimiento o al documento.';  // Traducido

//                         // ...
//                     }
//                     action(IncomingDocAttachFile)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Crear Documento Entrante desde Archivo';  // Traducido
//                         Ellipsis = true;
//                         Enabled = NOT HasIncomingDocument;
//                         Image = Attach;
//                         ToolTip = 'Crea un registro de documento entrante seleccionando un archivo para adjuntar, y luego vincula el registro de documento entrante a el movimiento o al documento.';  // Traducido

//                         // ...
//                     }
//                 }
//             }
//             action("&Navigate")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Navegar';  // Traducido
//                 Image = Navigate;
//                 Scope = Repeater;
//                 ShortCutKey = 'Ctrl+Alt+Q';
//                 ToolTip = 'Encuentra movimientos y documentos que existan para el número de documento y la fecha de publicación en el documento seleccionado.';  // Traducido

//                 // ...
//             }
//             action("Show Document")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Mostrar Documento';  // Traducido
//                 Image = Document;
//                 ShortCutKey = 'Return';
//                 ToolTip = 'Muestra detalles del pago, factura o abono publicado.';  // Traducido

//                 // ...
//             }
//             action(ShowDocumentAttachment)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Mostrar Adjunto de Documento';  // Traducido
//                 Enabled = HasDocumentAttachment;
//                 Image = Attach;
//                 ToolTip = 'Ver documentos o imágenes que estén adjuntados a la factura o abono publicado.';  // Traducido

//                 // ...
//             }
//             action("Create Payment")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Crear Pago';  // Traducido
//                 Image = SuggestVendorPayments;
//                 ToolTip = 'Crear un diario de pagos basado en las facturas seleccionadas.';  // Traducido

//                 // ...
//             }
//         }

//         area(Promoted)
//         {
//             group(Category_Process)
//             {
//                 Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

//                 group(Category_Category4)
//                 {
//                     Caption = 'Line', Comment = 'Generated from the PromotedActionCategories property index 3.';
//                     ShowAs = SplitButton;

//                     actionref("Show Document_Promoted"; "Show Document")
//                     {
//                     }
//                     actionref(ShowDocumentAttachment_Promoted; ShowDocumentAttachment)
//                     {
//                     }
//                 }
//                 group("Category_Apply/Unapply")
//                 {
//                     Caption = 'Apply/Unapply';
//                     ShowAs = SplitButton;

//                     actionref(ActionApplyEntries_Promoted; ActionApplyEntries)
//                     {
//                     }
//                     actionref(UnapplyEntries_Promoted; UnapplyEntries)
//                     {
//                     }
//                 }
//                 actionref("&Navigate_Promoted"; "&Navigate")
//                 {
//                 }
//                 actionref("Create Payment_Promoted"; "Create Payment")
//                 {
//                 }
//                 // actionref(ReverseTransaction_Promoted; ReverseTransaction)
//                 // {
//                 // }
//             }
//             group(Category_Category5)
//             {
//                 Caption = 'Entry', Comment = 'Generated from the PromotedActionCategories property index 4.';

//                 actionref(Dimensions_Promoted; Dimensions)
//                 {
//                 }
//                 actionref(SetDimensionFilter_Promoted; SetDimensionFilter)
//                 {
//                 }
//                 actionref(AppliedEntries_Promoted; AppliedEntries)
//                 {
//                 }
//                 actionref("Detailed &Ledger Entries_Promoted"; "Detailed &Ledger Entries")
//                 {
//                 }
//             }
//             group(Category_Report)
//             {
//                 Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     var
//         IncomingDocument: Record "Incoming Document";
//     begin
//         HasIncomingDocument := IncomingDocument.PostedDocExists(Rec."Document No.", Rec."Posting Date");
//         HasDocumentAttachment := Rec.HasPostedDocAttachment();
//         // if GuiAllowed() then
//         //     CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         StyleTxt := Rec.SetStyle();
//     end;

//     trigger OnInit()
//     begin
//         AmountVisible := true;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", Rec);
//         exit(false);
//     end;

//     trigger OnOpenPage()
//     begin
//         SetControlVisibility();
//         SetDimVisibility();
//         if (Rec.GetFilters() <> '') and not Rec.Find() then
//             if Rec.FindFirst() then;
//     end;

//     var
//         Navigate: Page Navigate;
//         DimensionSetIDFilter: Page "Dimension Set ID Filter";
//         HasIncomingDocument: Boolean;
//         HasDocumentAttachment: Boolean;
//         AmountVisible: Boolean;
//         DebitCreditVisible: Boolean;
//         VendNameVisible: Boolean;
//         ExportToPaymentFileConfirmTxt: Label 'Editing the Exported to Payment File field will change the payment suggestions in the Payment Journal. Edit this field only if you must correct a mistake.\Do you want to continue?';

//     protected var
//         Dim1Visible: Boolean;
//         Dim2Visible: Boolean;
//         Dim3Visible: Boolean;
//         Dim4Visible: Boolean;
//         Dim5Visible: Boolean;
//         Dim6Visible: Boolean;
//         Dim7Visible: Boolean;
//         Dim8Visible: Boolean;
//         StyleTxt: Text;

//     local procedure SetDimVisibility()
//     var
//         DimensionManagement: Codeunit DimensionManagement;
//     begin
//         DimensionManagement.UseShortcutDims(Dim1Visible, Dim2Visible, Dim3Visible, Dim4Visible, Dim5Visible, Dim6Visible, Dim7Visible, Dim8Visible);
//     end;

//     local procedure SetControlVisibility()
//     var
//         GLSetup: Record "General Ledger Setup";
//         PurchSetup: Record "Purchases & Payables Setup";
//     begin
//         GLSetup.Get();
//         AmountVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Debit/Credit Only");
//         DebitCreditVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Amount Only");
//         PurchSetup.Get();
//         VendNameVisible := PurchSetup."Copy Vendor Name to Entries";
//     end;

//     local procedure GetBatchRecord(var GenJournalBatch: Record "Gen. Journal Batch"; CreatePayment: Page "Create Payment")
//     var
//         GenJournalTemplate: Record "Gen. Journal Template";
//         JournalTemplateName: Code[10];
//         JournalBatchName: Code[10];
//     begin
//         JournalTemplateName := CreatePayment.GetTemplateName();
//         JournalBatchName := CreatePayment.GetBatchNumber();

//         GenJournalTemplate.Get(JournalTemplateName);
//         GenJournalBatch.Get(JournalTemplateName, JournalBatchName);
//     end;
// }

