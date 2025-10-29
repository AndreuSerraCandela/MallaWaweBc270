/// <summary>
/// Table Lin. relacion pagos (ID 7001183).
/// </summary>
table 7001183 "Lin. relacion pagos"
{

    DataCaptionfields = "Nº", "Compra a-Nombre";


    Caption = 'Lín. relación pagos';

    fields
    {
        field(1; "No. relación pagos"; Code[20]) { TableRelation = "Cab. relacion pagos"; }
        field(2; "Compra a-Nº proveedor"; Code[20])
        {
            TableRelation = Vendor;
            NotBlank = true;
            trigger OnValidate()
            BEGIN
                if recProveedor.GET("Compra a-Nº proveedor") THEN BEGIN
                    "Compra a-Nombre" := recProveedor.Name;
                    "Compra a-Nombre 2" := recProveedor."Name 2";
                END;
            END;

        }
        field(3; "Nº"; Code[20])
        {
            TableRelation = if ("Tipo documento" = CONST(Invoice)) "Purch. Inv. Header"
            ELSE
            if ("Tipo documento" = CONST("Credit Memo")) "Purch. Cr. Memo Hdr.";
        }
        field(4; "Pago-a Nº proveedor"; Code[20])
        {
            TableRelation = Vendor;
            trigger OnValidate()
            BEGIN
                if recProveedor.GET("Pago-a Nº proveedor") THEN BEGIN
                    "Pago a-Nombre" := recProveedor.Name;
                    "Pago a-Nombre 2" := recProveedor."Name 2";
                END;
            END;
        }
        field(5; "Pago a-Nombre"; Text[50]) { }
        field(6; "Pago a-Nombre 2"; Text[50]) { }
        field(11; "Su/Ntra. ref."; Text[30]) { }
        field(20; "Fecha registro"; Date) { }
        field(24; "Fecha vencimiento"; Date) { }
        field(32; "Cód. divisa"; Code[10])
        {
            TableRelation = Currency;
            Editable = false;
        }
        field(61; "Importe IVA incl."; Decimal)
        {
            AutoFormatType = 1;
        }
        field(68; "Nº documento proveedor"; Code[20])
        {
            Caption = 'Nº documento proveedor';
            trigger OnValidate()
            BEGIN
                recMovProv.RESET;
                recMovProv.SETCURRENTKEY("Document Type", "Vendor No.");
                CASE "Tipo documento" OF
                    "Tipo documento"::Invoice:
                        recMovProv.SETRANGE("Document Type", recMovProv."Document Type"::Invoice);
                    "Tipo documento"::"Credit Memo":
                        recMovProv.SETRANGE("Document Type", recMovProv."Document Type"::"Credit Memo");
                END;
                recMovProv.SETRANGE("Vendor No.", "Pago-a Nº proveedor");
                recMovProv.SETRANGE("External Document No.", "Nº documento proveedor");
                if recMovProv.FIND('-') THEN BEGIN

                    if NOT recMovProv.Open THEN
                        ERROR(Text001, "Nº documento proveedor");

                    // DEBEMOS MIRAR SI ESTµ EN OTRA RELACIàN DE PAGOS
                    recLinPago.RESET;
                    recLinPago.SETCURRENTKEY("Pago-a Nº proveedor", "Nº documento proveedor");
                    recLinPago.SETRANGE("Pago-a Nº proveedor", "Pago-a Nº proveedor");
                    recLinPago.SETRANGE("Nº documento proveedor", "Nº documento proveedor");
                    recLinPago.SETFILTER("No. relación pagos", '<>%1', "No. relación pagos");
                    if recLinPago.FINDFIRST THEN
                        ERROR(Text002, recLinPago."No. relación pagos");

                    CASE recMovProv."Document Type" OF
                        recMovProv."Document Type"::Invoice:
                            "Tipo documento" := "Tipo documento"::Invoice;
                        recMovProv."Document Type"::"Credit Memo":
                            "Tipo documento" := "Tipo documento"::"Credit Memo";
                    END;
                    "Nº" := recMovProv."Document No.";
                    VALIDATE("Compra a-Nº proveedor", recMovProv."Buy-from Vendor No.");
                    "Fecha vencimiento" := recMovProv."Due Date";
                    "Fecha registro" := recMovProv."Posting Date";
                    recMovProv.CALCfields("Remaining Amt. (LCY)");
                    "Importe IVA incl." := -recMovProv."Remaining Amt. (LCY)";
                    "Fecha emisión documento" := recMovProv."Document Date";

                END ELSE
                    ERROR(Text003, "Tipo documento", "Nº documento proveedor", "Pago-a Nº proveedor");
            END;

            trigger OnLookup()
            VAR
                recMovPro: Record 25;
                frmMovProv: Page 29;
            BEGIN
                recMovProv.RESET;
                recMovProv.SETCURRENTKEY("Document Type", "Vendor No.");
                CASE "Tipo documento" OF
                    "Tipo documento"::Invoice:
                        recMovProv.SETRANGE("Document Type", recMovProv."Document Type"::Invoice);
                    "Tipo documento"::"Credit Memo":
                        recMovProv.SETRANGE("Document Type", recMovProv."Document Type"::"Credit Memo");
                END;
                recMovProv.SETRANGE("Vendor No.", "Pago-a Nº proveedor");
                recMovProv.SETRANGE(Open, TRUE);
                CLEAR(frmMovProv);

                if "Nº documento proveedor" <> '' THEN BEGIN
                    recMovProv.SETRANGE("External Document No.", "Nº documento proveedor");
                    if recMovProv.FINDFIRST THEN
                        frmMovProv.SETRECORD(recMovProv);
                    recMovProv.SETRANGE("External Document No.");
                END;

                frmMovProv.EDITABLE := FALSE;
                frmMovProv.LOOKUPMODE := TRUE;
                frmMovProv.SETTABLEVIEW(recMovProv);
                if frmMovProv.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    frmMovProv.GETRECORD(recMovProv);
                    VALIDATE("Nº documento proveedor", recMovProv."External Document No.");
                END;
            END;
        }
        field(79; "Compra a-Nombre"; Text[50]) { }
        field(80; "Compra a-Nombre 2"; Text[50]) { }
        field(99; "Fecha emisión documento"; Date) { }
        field(104; "Cód. forma pago"; Code[10]) { TableRelation = "Payment Method"; }
        field(50000; "Tipo documento"; Enum "Tipo Documento Envios")
        {

        }
        field(50001; "Pagaré generado"; Boolean) { }
        field(50002; "No. linea"; Integer) { Caption = 'Nº línea'; }
        field(50003; "No. borrador pagare"; Code[20]) { Caption = 'Nº borrador pagaré'; }
        field(99002581; "Fecha creación"; Date) { }
    }
    KEYS
    {
        key(P; "No. relación pagos", "No. linea")
        {
            SumIndexfields = "Importe IVA incl.";
            Clustered = true;
        }
        key(A; "No. relación pagos", "Pago-a Nº proveedor", "Fecha vencimiento") { }
        key(B; "Pago-a Nº proveedor", "Nº documento proveedor") { }
        key(C; "No. relación pagos", "Compra a-Nº proveedor", "Fecha registro") { }
    }
    VAR
        recCabFactCompras: Record "Purch. Inv. Header";
        recLinComentCompra: Record 43;
        recMovProv: Record 25;
        recProveedor: Record Vendor;
        recLinPago: Record "Lin. relacion pagos";
        cduEliminaLinCompra: Codeunit 364;
        Text001: Label 'El documento proveedor nº %1 ya ha sido liquidado.';
        Text002: Label 'El documento especificado ya se encuetra en la relación de pagos nº %1';
        Text003: Label 'No se encuentra el documento %1 nº %2 del proveedor nº %3';

    trigger OnModify()
    BEGIN
        TESTFIELD("Pagaré generado", FALSE);
    END;

    trigger OnDelete()
    BEGIN
        TESTFIELD("Pagaré generado", FALSE);
    END;

    trigger OnRename()
    BEGIN
        TESTFIELD("Pagaré generado", FALSE);
    END;

}
