/// <summary>
/// Table Cab. relacion pagos (ID 7001185).
/// </summary>
table 7001185 "Cab. relacion pagos"
{



    Caption = 'Cab. relación pagos';

    fields
    {
        field(1; "No. relación pagos"; Code[20])
        {
            Caption = 'Nº relación pagos';
            trigger OnValidate()
            BEGIN
                if "No. relación pagos" <> xRec."No. relación pagos" THEN BEGIN
                    recCfgCartera.GET;
#pragma warning disable AL0432
                    cduNoSerie.TestManual(recCfgCartera."Nº serie relacion pagos");
#pragma warning restore AL0432
                    "No. serie" := '';
                END;
            END;

        }
        field(2; "No. serie"; Code[20]) { TableRelation = "No. Series"; }
        field(3; "Fecha creación"; Date) { }
        field(4; "Importe"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Lin. relacion pagos"."Importe IVA incl." WHERE("No. relación pagos" = FIELD("No. relación pagos")));
        }
        field(5; "Descripcion"; Text[90]) { Caption = 'Descripción / Observaciones'; }
    }
    KEYS
    {
        key(P; "No. relación pagos") { Clustered = true; }
    }
    VAR
        recCfgCartera: Record 7000016;
        recLinPagos: Record "Lin. relacion pagos";
#if CLEAN24
#pragma warning disable AL0432
        cduNoSerie: Codeunit NoSeriesManagement;
#pragma warning restore AL0432
#else
        cduNoSerie: Codeunit "No. Series";
#endif
    trigger OnInsert()
    BEGIN
        recCfgCartera.GET;
        if "No. relación pagos" = '' THEN BEGIN
            recCfgCartera.TESTFIELD("Nº serie relacion pagos");
#if CLEAN24
#pragma warning disable AL0432
            cduNoSerie.InitSeries(recCfgCartera."Nº serie relacion pagos", xRec."No. serie",
#pragma warning restore AL0432
                              "Fecha creación", "No. relación pagos", "No. serie");
#else
            If cduNoSerie.AreRelated(recCfgCartera."Nº serie relacion pagos", "No. Serie") THEN
                Rec."No. Serie" := xRec."No. Serie";
#endif
        END;
        "Fecha creación" := WORKDATE;
    END;

    trigger OnDelete()
    BEGIN
        recLinPagos.RESET;
        recLinPagos.SETRANGE("No. relación pagos", "No. relación pagos");
        recLinPagos.DELETEALL(TRUE);
    END;
}
