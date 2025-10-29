/// <summary>
/// TableExtension Bank AccountKuara (ID 80197) extends Record Bank Account.
/// </summary>
tableextension 80197 "Bank AccountKuara" extends "Bank Account"
{
    fields
    {
        field(50000; "Tipo pagare"; Enum "Tipo pagare") { }
        field(50001; "Excluir de Liquidez"; Boolean) { }
        field(50050; "Global Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(3, "Global Dimension 3 Code");
            end;
        }
        field(50051; "Global Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            end;
        }
        field(50052; "Global Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            trigger OnValidate()
            var

            begin
                ValidateShortcutDimCode(5, "Global Dimension 5 Code");
            end;
        }
        field(50115; "SEPA CT Msg. ID No. Series"; CODE[10]) { TableRelation = "No. Series"; }
        field(50170; "Creditor No. ant"; CODE[35]) { }
        field(50180; "Banco para Transf. Clientes"; Boolean) { }
        field(70000; "Tipo impreso pagaré"; Enum "Tipo impreso pagaré") { }
        field(70001; "Ult. nº confirming"; CODE[20]) { }
        field(70002; "Fecha regis. ult. confirming"; Date) { }
        field(70005; "Tipo Pagarés"; Enum "Tipo Pagarés") { }
        field(70050; "Informe Pagare"; Integer) { TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report), "Object Name" = FILTER('*@pag*')); }
        field(71001; "Nº Inicial pagare"; CODE[20]) { }
        field(71002; "Nº Final pagare"; CODE[20]) { }
        field(71003; "Ult. nº pagare"; CODE[20]) { }
    }
}