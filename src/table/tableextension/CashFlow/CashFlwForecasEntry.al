/// <summary>
/// TableExtension Liquidity Ledger EntryKuara (ID 80329) extends Record Cash Flow Forecast Entry.
/// </summary>
tableextension 80329 "Liquidity Ledger EntryKuara" extends "Cash Flow Forecast Entry"
{
    fields
    {
        field(50003; "Cod banco"; CODE[20]) { }

        field(50005; "Es Cartera"; Boolean) { }
        field(50006; "Nombre Banco"; TEXT[30]) { }
        field(50007; "Concepto"; TEXT[100]) { }
        field(50008; "Empresa"; TEXT[30]) { }
        field(50009; "Fecha Registro"; Date) { }
        field(51028; "Anotación"; TEXT[250]) { }
        field(51030; "Fecha Anotacion"; Date) { }
        field(50024; "Payment Method Code"; CODE[10]) { }
    }
}