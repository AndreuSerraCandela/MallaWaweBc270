/// <summary>
/// TableExtension BG/PO Post. BufferKuara (ID 80342) extends Record BG/PO Post. Buffer.
/// </summary>
tableextension 80343 "Bank Statement BufferKuara" extends "Bank Statement Matching Buffer"
{
    fields
    {
        field(51003; "Document No."; Code[20])
        {
            Caption = 'Nº Documento';
        }
        field(51004; "Posting Date"; Date)
        {
            Caption = 'Fecha Registro';
        }
        field(51005; "Remaining Amount"; Decimal)
        {
            Caption = 'Importe Pendiente';
        }
        field(51007; "Account Name"; Text[100])
        {
            Caption = 'Nombre';
        }
        field(51008; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Tipo Documento';
        }
        field(51009; "Bill No."; Code[20])
        {
            Caption = 'Nº Efecto';
        }
        field(51010; "Match Score"; Integer)
        {
            Caption = 'Puntuación';
        }
    }
    keys
    {
        key(Score; "Match Score") { }
    }
}
