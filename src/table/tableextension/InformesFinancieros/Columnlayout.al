/// <summary>
/// TableExtension Column LayoutKuara (ID 80220) extends Record Column Layout.
/// </summary>
tableextension 80220 "Column LayoutKuara" extends "Column Layout"
{
    fields
    {
        field(50020; "Empresa"; TEXT[30]) { TableRelation = Company; }
        field(50021; "Dimension 5 Totaling"; TEXT[80])
        {
            CaptionClass = GetCaptionClass(10);
            TableRelation = "Dimension Value".Code where("Global Dimension No." = Const(5));
        }
        field(50022; "Salesperson Filter"; CODE[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50001; "Banco"; CODE[20]) { }
        field(50024; "Payment Method Code"; CODE[10]) { }

    }
}
