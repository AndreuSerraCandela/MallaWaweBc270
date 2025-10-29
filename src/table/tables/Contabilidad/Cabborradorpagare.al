/// <summary>
/// Table Cab. borrador pagare (ID 7001184).
/// </summary>
table 7001184 "Cab. borrador pagare"
{


    fields
    {
        field(1; "Cód. pagaré"; Code[20])
        {
            trigger OnValidate()
            BEGIN
                if "Cód. pagaré" <> xRec."Cód. pagaré" THEN BEGIN
                    recCfgCartera.GET;
#pragma warning disable AL0432
                    cduNoSerie.TestManual(recCfgCartera."Nº serie borrador pagare");
#pragma warning restore AL0432
                    "Nº Serie" := '';
                END;
            END;
        }
        field(2; "Cód. proveedor"; Code[20]) { TableRelation = Vendor; }
        field(3; "Fecha de vto."; Date) { Caption = 'Fecha de vencimiento'; }
        field(4; "Importe"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Lin. borrador pagare".Importe WHERE("Cód. pagaré" = FIELD("Cód. pagaré")));
            AutoFormatType = 1;
        }
        field(5; "Cód. banco"; Code[20])
        {
            TableRelation = "Bank Account";
            trigger OnValidate()
            BEGIN
                if recBanco.GET("Cód. banco") THEN BEGIN
                    "Nombre banco" := recBanco.Name;
                    "Dirección banco" := recBanco.Address;
                    "CCC Nº Cuenta" := recBanco."CCC Bank Account No.";
                    "CCC Banco" := recBanco."CCC Bank No.";
                    "CCC D.C." := recBanco."CCC Control Digits";
                    "CCC Oficina" := recBanco."CCC Bank Branch No."
                END;
            END;
        }
        field(6; "CCC Nº Cuenta"; Text[20]) { Caption = 'Código cuenta cliente'; }
        field(7; "Nombre banco"; Text[30]) { }
        field(9; "Nº Serie"; Code[10]) { TableRelation = "No. Series"; }
        field(11; "Dirección banco"; Text[30]) { }
        field(12; "CCC Banco"; Code[4]) { }
        field(13; "CCC D.C."; Code[2]) { }
        field(14; "CCC Oficina"; Code[4]) { Caption = 'Cód. oficina'; }
        field(15; "Contabilizado"; Boolean) { }
        field(16; "Cód. divisa"; Code[20]) { TableRelation = Currency; }
        field(17; "Nº documento propio"; Text[30])
        {
            trigger OnValidate()
            BEGIN
                if "Nº documento propio" <> '' THEN BEGIN
                    recCfgCartera.GET;
                    if recBanco.GET("Cód. banco") THEN BEGIN
                        CASE recBanco."Tipo pagare" OF
                            recBanco."Tipo pagare"::Tipo1:
                                BEGIN
                                    recCfgCartera."Ult. no. pagare tipo 1" := "Nº documento propio";
                                    recCfgCartera.MODIFY;
                                END;
                            recBanco."Tipo pagare"::Tipo2:
                                BEGIN
                                    recCfgCartera."Ult. no. pagare tipo 2" := "Nº documento propio";
                                    recCfgCartera.MODIFY;
                                END;
                        END;
                    END;
                END;
            END;
        }
        field(18; "Su/Ntra. ref."; Text[30]) { }
        field(19; "Fecha registro"; Date) { }
        field(20; Impresa; Boolean) { }
    }
    KEYS
    {
        key(A; "Cód. pagaré") { Clustered = true; }
        key(B; "Cód. banco", "Nº documento propio") { }
        key(P; Contabilizado) { }
    }
    VAR
        recCfgCartera: Record 7000016;
#if CLEAN24
#pragma warning disable AL0432
        cduNoSerie: Codeunit NoSeriesManagement;
#pragma warning restore AL0432
#else
        cduNoSerie: Codeunit "No. Series";
#endif
        recBanco: Record 270;
        recPagare: Record "Cab. borrador pagare";
        Text001: Label 'No es posible modificar este borrador de pagarés porque ya ha sido contabilizado.';
        Text002: Label 'No es posible eliminar este borrador de pagarés porque ya ha sido contabilizado.';

    trigger OnInsert()
    BEGIN
        if "Cód. pagaré" = '' THEN BEGIN
            recCfgCartera.GET;
            recCfgCartera.TESTFIELD("Nº serie borrador pagare");
#if CLEAN24
#pragma warning disable AL0432
            cduNoSerie.InitSeries(recCfgCartera."Nº serie borrador pagare", xRec."Nº Serie", 0D, "Cód. pagaré", "Nº Serie");
#pragma warning restore AL0432
#else
            If cduNoSerie.AreRelated(recCfgCartera."Nº serie borrador pagare", "Nº Serie") THEN
                Rec."Nº Serie" := xRec."Nº Serie";
#endif

        END;
    END;

    trigger OnModify()
    BEGIN
        if Contabilizado THEN
            ERROR(Text001);
    END;

    trigger OnDelete()
    BEGIN
        if Contabilizado THEN
            ERROR(Text002);

        BorrarLineas;
        ActualizarRelPagos;
    END;

    PROCEDURE AssistEdit(recPrmPagAnt: Record "Cab. borrador pagare"): Boolean;
    var

    BEGIN

        recPagare.COPY(Rec);
        recCfgCartera.GET;
        recCfgCartera.TESTFIELD("Nº serie borrador pagare");
#if CLEAN24
#pragma warning disable AL0432
        if cduNoSerie.SelectSeries(recCfgCartera."Nº serie borrador pagare", recPrmPagAnt."Nº Serie", recPagare."Nº Serie") THEN BEGIN
#pragma warning restore AL0432
#pragma warning disable AL0432
            cduNoSerie.SetSeries(recPagare."Cód. pagaré");
#pragma warning restore AL0432
            Rec := recPagare;
            EXIT(TRUE);
        END;
#else
        if cduNoSerie.LookupRelatedNoSeries(recCfgCartera."Nº serie borrador pagare", recPrmPagAnt."Nº Serie", recPagare."Nº Serie") then begin
            recPagare."Cód. pagaré" := cduNoSerie.GetNextNo(recPagare."Nº Serie");
            Rec := recPagare;
            exit(true);
        end;
#endif

    END;

    PROCEDURE TraerNoDocumentoPropio(): Text[30];
    VAR
        rPagares: Record "Cab. borrador pagare";
        rBanco: Record 270;
    BEGIN
        recCfgCartera.GET;

        if recBanco.GET("Cód. banco") THEN BEGIN
            CASE recBanco."Tipo pagare" OF
                recBanco."Tipo pagare"::Tipo1:
                    BEGIN
                        recCfgCartera."Ult. no. pagare tipo 1" := INCSTR(recCfgCartera."Ult. no. pagare tipo 1");
                        recCfgCartera.MODIFY;
                        EXIT(recCfgCartera."Ult. no. pagare tipo 1");
                    END;
                recBanco."Tipo pagare"::Tipo2:
                    BEGIN
                        recCfgCartera."Ult. no. pagare tipo 2" := INCSTR(recCfgCartera."Ult. no. pagare tipo 2");
                        recCfgCartera.MODIFY;
                        EXIT(recCfgCartera."Ult. no. pagare tipo 2");
                    END;
            END;
        END;
    END;

    LOCAL PROCEDURE BorrarLineas();
    VAR
        recLinPagare: Record "Lin. borrador pagare";
    BEGIN
        recLinPagare.RESET;
        recLinPagare.SETRANGE("Cód. pagaré", "Cód. pagaré");
        recLinPagare.DELETEALL;
    END;

    PROCEDURE ActualizarRelPagos();
    VAR
        recLinRelPagos: Record "Lin. relacion pagos";
    BEGIN
        recLinRelPagos.RESET;
        recLinRelPagos.SETRANGE("Pagaré generado", TRUE);
        recLinRelPagos.SETRANGE("No. borrador pagare", "Cód. pagaré");
        if recLinRelPagos.FINDSET THEN
            REPEAT
                CLEAR(recLinRelPagos."Pagaré generado");
                CLEAR(recLinRelPagos."No. borrador pagare");
                recLinRelPagos.MODIFY;
            UNTIL recLinRelPagos.NEXT = 0;
    END;

}
