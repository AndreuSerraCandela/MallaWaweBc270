/// <summary>
/// TableExtension G/L RegisterKuara (ID 80153) extends Record G/L Register.
/// </summary>
tableextension 80153 "G/L RegisterKuara" extends "G/L Register"
{
    fields
    {
        field(50000; "Nº Asiento Calculado"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."Transaction No." WHERE("Entry No." = FIELD("Filtro movimientos")));
        }
        field(50001; "Filtro movimientos"; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(50002; "Eliminar"; Boolean) { }
    }
}
