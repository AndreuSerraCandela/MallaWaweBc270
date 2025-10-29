/// <summary>
/// TableExtension Acc. Schedule LineKuara (ID 80160) extends Record Acc. Schedule Line.
/// </summary>
tableextension 80160 "Acc. Schedule LineKuara" extends "Acc. Schedule Line"
{
    fields
    {
        field(50000; "Grupo Contable"; CODE[20])
        {
            TableRelation = if ("Totaling Type" = CONST(Vendor)) "Vendor Posting Group"."Code"
            ELSE
            if ("Totaling Type" = CONST(Customer)) "Customer Posting Group"."Code";
        }
        field(50001; "Filtro Eliminaciones"; Boolean) { FieldClass = FlowFilter; }
        field(50002; "Dimension 5 Filter"; CODE[20])
        {
            FieldClass = FlowFilter;
            CaptionClass = GetCaptionClass(9);
        }
        field(50003; "Dimension 5 Totaling"; TEXT[80])
        {
            CaptionClass = GetCaptionClass(10);
            trigger OnValidate()
            var
                AccSchedName: Record "Acc. Schedule Name";
                GlAcc: Record "G/L Account";
            begin

                CASE "Totaling Type" OF
                    "Totaling Type"::"Posting Accounts", "Totaling Type"::"Total Accounts":
                        BEGIN
                            // if AccSchedName."Acc. No. Referred to old Acc." THEN BEGIN
                            GLAcc.SETFILTER("No.", Totaling);
                            GLAcc.CALCFIELDS(Balance);
                            // END ELSE BEGIN
                            // HistoricGLAcc.SETFILTER("No.",Totaling);
                            // HistoricGLAcc.CALCFIELDS(Balance);
                            //END;
                        END;
                    "Totaling Type"::Formula:
                        BEGIN
                            Totaling := UPPERCASE(Totaling);
                            CheckFormula(Totaling);
                        END;
                END;
            end;
        }
        field(50004; "Salesperson Filter"; CODE[20]) { FieldClass = FlowFilter; Caption = 'Filtro Vendedor'; }
        field(50005; "Salesperson Code"; CODE[20]) { TableRelation = "Salesperson/Purchaser"; Caption = 'Cód Vendedor'; }
        field(50006; Company; Text[30]) { TableRelation = Company; Caption = 'Empresa'; }
        field(51001; "Banco"; CODE[20]) { }
        field(51024; "Payment Method Code"; CODE[20]) { Caption = 'Código Forma de Pago'; }
        field(51005; "Total"; Decimal) { }
    }
}