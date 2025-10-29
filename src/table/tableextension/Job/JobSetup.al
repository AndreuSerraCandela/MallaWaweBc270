tableextension 80216 "Jobs SetupKuara" extends "Jobs Setup"
{
    fields
    {
        field(50000; "Nº serie tarifa"; CODE[10]) { TableRelation = "No. Series"; }
        field(50005; "Cód. Proyecto Genérico"; CODE[20]) { TableRelation = Job; }
        field(50010; "Nº serie orden publicidad"; CODE[10]) { TableRelation = "No. Series"; }
        field(50015; "Tarifa manual prensa"; CODE[20]) { TableRelation = Resource WHERE("Global Dimension 1 Code" = CONST('GENERAL')); }
        field(50016; "Tarifa manual radio"; CODE[20]) { TableRelation = Resource WHERE("Global Dimension 1 Code" = CONST('GENERAL')); }
        field(50017; "Tarifa manual cine"; CODE[20]) { TableRelation = Resource WHERE("Global Dimension 1 Code" = CONST('GENERAL')); }

        field(50018; "Imprimir orden al validad"; Enum "Imprimir orden al validar")
        {

        }
        field(50020; "Dpto. General"; CODE[20])
        {
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(50021; "Dpto. Exterior"; CODE[20])
        {
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(50025; "Limite paso Proyecto a Contrat"; DateFormula) { }
        field(50030; "Impr. Ped. Compra asociado Cto"; Boolean) { }
        field(50035; "Facturar solo si Cto Firmado"; Boolean) { }
        field(50040; "Poder modificar fecha firmado"; Boolean) { }
        field(50041; "Poder modificar renovado"; Boolean) { }
        field(50042; "Proy Impr Iva/Total"; Boolean) { }
        field(50043; "Proy Impr Sop/Sec"; Boolean) { }
        field(50044; "Proy Impr Tot sin IVA"; Boolean) { }
        field(54042; "Internal Job Nos."; CODE[10]) { TableRelation = "No. Series"; }
        field(54043; "Correlación de ingresos-gastos"; Boolean) { }
        field(54044; "Cuenta Contable Emplazamientos"; TEXT[30]) { TableRelation = "G/L Account"; }
        field(54045; "Grupo Contable emplazamiento"; CODE[20]) { TableRelation = "Vendor Posting Group".Code; }
        field(54046; "Cliente Varios"; CODE[20]) { TableRelation = Customer; }
        field(50047; "Clausula Buses"; Text[1024]) { }
        field(50048; "Clausula Intercambio"; Text[1024]) { }
        field(50049; "No Comprobar Recursos"; Boolean) { }
        field(50050; "Crear Factura Interempresas"; Boolean) { }
        //field(50060; "Responsable Taller"; guid) { TableRelation = User."User Security ID"; }
        field(50061; "Crear subtareas"; Boolean) { }
        field(50062; "Nuevo sistema producción"; Boolean) { }
    }
}
