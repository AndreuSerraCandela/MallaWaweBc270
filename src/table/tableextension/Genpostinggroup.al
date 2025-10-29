/// <summary>
/// TableExtension Gen. Product Pos. GroupKuara (ID 80193) extends Record Gen. Product Posting Group.
/// </summary>
tableextension 80193 "Gen. Product Pos. GroupKuara" extends "Gen. Product Posting Group"
{
    fields
    {
        // field(50015; "% Irpf Alquileres"; Decimal) { }
        // field(50016; "Cuenta Ret. IRPF"; TEXT[20]) { TableRelation = "G/L Account"; }
        // field(50017; "Grupo Iva IRPF"; CODE[20]) { TableRelation = "VAT Product Posting Group".Code; }
        field(50101; "Familia"; CODE[10]) { TableRelation = Familias."Cód. Familia"; }
        field(50102; "Sub-Familia de Economato"; Boolean) { }
        field(50103; "Id. Códigos Productos"; CODE[3]) { }
        field(50104; "Creación productos en hotel"; Boolean) { }
        field(50105; "Numerador Productos"; CODE[6]) { }
        field(50106; "% Beneficio"; Decimal) { }
        field(50107; "Redondeo"; Integer) { }
        field(50110; "Filtro hoteles"; CODE[10]) { FieldClass = FlowFilter; }
        field(50111; "Filtro fecha"; Date) { FieldClass = FlowFilter; }
        field(50112; "Filtro almacén"; CODE[10]) { FieldClass = FlowFilter; }
        field(50122; "Grupo reg. IGIC prod. genérico"; CODE[10]) { TableRelation = "VAT Product Posting Group"; }
        field(50129; "Agrupación en resumen facturas"; CODE[10]) { }
        field(50132; "Fecha ultima modificacion"; Date) { }
        field(50133; "Tipo reasignacion solicitud"; Enum "Tipo reasignacion solicitud") { }
        field(50135; "Bloqueada"; Boolean) { }
        field(50136; "Tipo"; Enum "Tipo") { }
        field(50140; "% Tolerancia"; Decimal) { }
        field(50141; "Grupo Equivalente"; CODE[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Relación Grupos"."Grupo Contable Destino" WHERE("Empresa Origen" = FIELD("Filtro Empresa Origen"), "Grupo Contable Origen" = FIELD("Code"), "Empresa Destino" = FIELD("Filtro Empresa Destino")));
        }
        field(50142; "Filtro Empresa Destino"; TEXT[30]) { FieldClass = FlowFilter; }
        field(50143; "Filtro Empresa Origen"; TEXT[30]) { FieldClass = FlowFilter; }
    }
}