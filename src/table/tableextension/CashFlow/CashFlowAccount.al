/// <summary>
/// TableExtension Liquidity AccountKuara (ID 80326) extends Record Cash Flow Account.
/// </summary>
tableextension 80326 "Liquidity AccountKuara" extends "Cash Flow Account"
{
    fields
    {
        field(50003; "Cod banco"; CODE[20]) { TableRelation = "Bank Account"; }
        field(50004; "Payment Method Code"; CODE[10]) { TableRelation = "Payment Method"; }
        field(80005; "Amount Open"; Decimal)
        {
            ObsoleteReason = 'Error FieldClass';
            ObsoleteState = Removed;
            Caption = 'Usuar Amount Open.';
        }
        field(50005; "Amount Open."; Decimal)
        {
            Caption = 'Importe pendiente';
            FieldClass = FlowField;
            CalcFormula = Sum("Cash Flow Worksheet Line"."Amount (LCY)" WHERE("Cash Flow Account No." = FIELD("No."),
        "Cash Flow Account No." = FIELD(FILTER(Totaling)), "Cash Flow Forecast No." =
        FIELD("Cash Flow Forecast Filter"), "Cash Flow Date" = FIELD("Date Filter"),
        "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));

        }
        field(80006; "Filtro banco"; CODE[20]) { ObsoleteReason = 'Error FieldClass'; ObsoleteState = Removed; Caption = 'User Filtro banco.'; }
        field(80007; "Filtro Payment Method Code"; CODE[10]) { ObsoleteReason = 'Error FieldClass'; ObsoleteState = Removed; Caption = 'User Filtro banco.'; }
        field(50006; "Filtro banco."; CODE[20]) { FieldClass = FlowFilter; Caption = 'Filtro banco'; }
        field(50007; "Filtro Payment Method Code."; CODE[10]) { FieldClass = FlowFilter; Caption = 'Filtro forma de pago'; }
        field(50008; "Cód Prestamo"; CODE[100]) { TableRelation = "Cabecera Prestamo"; }
        field(50009; "Banco Informes"; TEXT[30]) { }
        field(50010; "Solo Cartera"; Boolean) { }
        field(50011; "Empresa"; TEXT[30]) { }
        field(50012; "Cód. Proveedor"; CODE[20]) { TableRelation = Vendor; }
        field(50013; "Cód. Cliente"; CODE[20]) { TableRelation = Customer; }
        field(50014; "Calcular vto. Cuenta"; CODE[1]) { }
        //field(50014; "Calcular vto Cuenta "; CODE[1]) { ObsoleteState = Pending; }
        field(50015; "Dias Liquidación HASTA"; DateFormula) { }
        field(50016; "Debe/Haber"; Option)
        {
            OptionMembers = " ",Debe,Haber,Ambos;
            trigger OnValidate()
            var
                deve: Option ,Debe,Haber,Ambos;
            begin
                "Debe/Haber" := "Debe/Haber"::" ";
            end;
        }
        field(50017; "Solo Atrasados"; Boolean) { }
        field(50018; "Valoracion"; Integer) { }
        field(50019; "Dias Liquidación DESDE;DateFormula"; DateFormula)
        {
            ObsoleteState = Removed;

            Caption = 'Dias Liquidación DESDE';
        }
        field(50020; "Desglosar"; Boolean) { }
        field(50021; "Vinculado a noº"; CODE[20]) { }
        field(50022; "Dia de pago"; DateFormula) { }
        field(50023; "Tipo Saldo"; Option) { OptionMembers = "Saldo a la fecha","Saldo periodo"; }
        field(51024; "Vto Resto Año"; DateFormula) { Caption = 'Vto Resto Año'; }
        field(50025; "Vto enero"; DateFormula) { }
        field(50026; "Pago Impuestos"; Boolean) { }
        field(50027; "Dias Liquidación DESDE"; DateFormula) { Caption = 'Dias Liquidación DESDE'; }
    }
    keys
    {
        key(Val; Valoracion)
        { }
    }
}
