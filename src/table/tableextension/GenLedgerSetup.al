/// <summary>
/// TableExtension ConfKuara (ID 80131) extends Record General Ledger Setup.
/// </summary>
tableextension 80131 ConfKuara extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here
        // field(80100; URL; Text[250])
        // {
        //     DataClassification = ToBeClassified;
        //     ObsoleteState = Removed;
        // }
        // field(80120; "Usuario Validación"; Text[250])
        // {
        //     ObsoleteState = Removed;
        // }
        // field(80121; "Usuario Contabilizazión"; Text[250])
        // {
        //     ObsoleteState = Removed;
        // }
        // field(80101; URLOCR; Text[250])
        // {
        //     ObsoleteState = Removed;
        //     DataClassification = ToBeClassified;
        // }

        field(50107; "Empresa de Gestión"; Text[30]) { TableRelation = Company; }//	Fk Empresas
        field(50705; "VAT Cash Regime ant"; Boolean) { }
        field(70000; "Ult. nº pagaré"; Code[20]) { }
        field(70003; "Ult. nº remesa confirming"; Code[20]) { }
        field(70004; "Cod. Confirming"; Code[2]) { TableRelation = "Payment Method"; }
        field(70005; "Parámetro Pagares"; Code[10]) { }	//FK Formas de Pago
        field(70006; "Directorio Contabilizaciones"; Text[250]) { }
        field(70007; "Cuenta Anticipo"; Code[10]) { TableRelation = "G/L Account"; }
        field(80000; "NIF titular registro"; Code[9]) { }	//SII
        field(80001; "Nombre titular registro"; Text[50]) { }	//SII
        field(80002; "Ruta fichero SII"; Text[250]) { }	//SII
        field(80003; "Activar SII"; Boolean) { }	//SII
        field(80004; "Exportar SII desde fecha"; Date) { }
        field(80005; "Ruta fichero SII IN"; Text[250]) { }	//SII
        field(80006; "No Comprobar Consistencia"; Boolean) { }
        field(80007; "No Comprobar Redondeo"; Boolean) { }
        // field(92100; "Ocr Url Api"; Text[250])
        // {
        //     Caption = 'Url Api Ocr';
        //     DataClassification = ToBeClassified;
        // }
        // field(92120; "Validation User"; Text[250])
        // {
        //     Caption = 'Usuario Validación';

        // }
        // field(92121; "General Ledger User"; Text[250])
        // {
        //     Caption = 'Usuario Contabilización';

        // }
        // field(92101; "OCR Url"; Text[250])
        // {
        //     Caption = 'Url Ocr';
        //     DataClassification = ToBeClassified;
        // }

        // field(92124; "Tipo Pedido"; Code[20])
        // {
        //     Caption = 'Tipo pedido por defecto';
        //     TableRelation = "Transaction Type";
        // }
        // field(92125; "Imputación Obligatoria"; Boolean)
        // {

        // }
        // field(92126; "Ocr Token Date"; DateTime)
        // {
        //     Caption = 'Fecha Token Ocr';

        // }
        // field(92127; "Ocr Token"; Text[1024])
        // {
        //     Caption = 'Token Ocr';

        // }
        // field(92128; "Ocr User"; Text[250])
        // {
        //     Caption = 'Usuario Ocr';

        // }
        // field(92129; "Ocr PassWord"; Text[250])
        // {
        //     Caption = 'Password Ocr';

        // }
        // field(92130; "QWark Date Token"; DateTime)
        // {
        //     Caption = 'Fecha Token Qwark';

        // }
        // field(92131; "Qwark Token"; Text[1024])
        // {
        //     Caption = 'Token Qwark';

        // }
        // field(92132; "Qwark User"; Text[250])
        // {
        //     Caption = 'Usuario Qwark';
        // }
        // field(92133; "Qwark PassWord"; Text[250])
        // {
        //     Caption = 'Password Qwark';
        // }
        // field(92134; "Qwark URL Api"; Text[250])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(92135; "Alfresco Url"; Text[250])
        // {

        // }
        // field(92136; "Alfresco User"; Text[250])
        // {
        // }
        // field(92137; "Alfresco Password"; Text[250])
        // {
        // }
        // field(92138; "Alfresco Invoice Folder"; Text[250])
        // {
        //     Caption = 'Carpeta Facturas Alfresco';
        // }
        // field(92139; "Alfresco Order Folder"; Text[250])
        // {
        //     Caption = 'Carpeta Pedidos Alfresco';
        // }
        // field(92140; "Alfresco Spenses Folder"; Text[250])
        // {
        //     Caption = 'Carpeta Gastos Alfresco';

        // }
    }

    var
        myInt: Integer;
}