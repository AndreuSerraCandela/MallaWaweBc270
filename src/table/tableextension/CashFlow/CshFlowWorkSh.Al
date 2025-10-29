/// <summary>
/// TableExtension CshFlowWorkSh (ID 80221) extends Record Cash Flow Worksheet Line.
/// </summary>
tableextension 80221 CshFlowWorkSh extends "Cash Flow Worksheet Line"
{
    fields
    {

        field(50003; "Cod banco"; Code[20]) { Description = 'PAG 001'; }
        field(50004; "Payment Method Code"; Code[10]) { Caption = 'Forma de Pago'; }
        field(50005; "Es Cartera"; Boolean) { }
        field(50006; "Nombre Banco"; Text[100]) { }
        field(50007; "Concepto"; Text[100]) { }
        field(50009; "Fecha Registro"; Date) { }
        field(51024; "Shortcut Dimension 3 Code"; Code[20]) { }
        field(51025; "Shortcut Dimension 4 Code"; Code[20]) { }
        field(51026; "Shortcut Dimension 5 Code"; Code[20]) { }
        field(51027; "Atrasados"; Boolean) { }
        field(51028; "Anotación"; Text[250]) { }
        field(51029; "Due Date"; Date) { }
        field(51030; "Fecha Anotacion"; Date) { }
        modify("Cash Flow Date")
        {
            trigger OnAfterValidate()
            begin
                "Due Date" := "Cash Flow Date";
            end;
        }
    }
}
