/// <summary>
/// Table Interfase Timon (ID 50006).
/// </summary>
table 50006 "Interfase Timon"
{
    fields
    {
        field(1; "Opcion Diario"; Enum "Opcion Diarios")
        {
            Description = 'Diario General, Registro Venta, Registro Compra,Diario Compras';
        }
        field(2; "Número Linea"; Integer) { }
        field(4; "Tipo Documento"; Enum "Tipo Documento Timon")
        {

        }
        field(5; "Nº Cuenta"; Code[20])
        {
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(6; "Cta.Contrapartida"; Code[50])
        {
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(7; "Nº Documento"; Code[20]) { }
        field(8; "Descripción"; Text[250]) { }
        field(9; Importe; Decimal)
        {
            AutoFormatType = 1;
        }
        field(10; "% IVA"; Decimal) { }
        field(11; "Importe IVA"; Decimal)
        {
            AutoFormatType = 2;
        }
        field(12; "Fecha Registro"; Date) { }
        field(13; "Cod. Divisa"; Code[20]) { }
        field(14; "Liq.por nº documento"; Code[20]) { }
        field(15; "Liq. por tipo movimiento"; Enum "Tipo Documento Timon")
        {

        }
        field(16; "Codigo de Cliente"; Code[20])
        {
            TableRelation = Customer;
            ValidateTableRelation = false;
        }
        field(17; "Código de Proveedor"; Code[20])
        {
            TableRelation = Vendor;
            ValidateTableRelation = false;
        }
        field(18; "Fecha Factura Proveedor"; Date) { }
        field(19; "Nº Documento Proveedor"; Code[20]) { }
        field(20; "Codigo Hotel"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            ValidateTableRelation = false;
            Caption = 'Codigo Departamento;';
        }
        field(21; "Codigo Departamento"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            ValidateTableRelation = false;
            Caption = 'Código Programa';
        }
        field(23; "Código Banco"; Code[20]) { }
        field(24; "%IVA Revsersion"; Decimal) { }
        field(25; "Importe Reversion"; Decimal) { }
        field(26; "Procesado"; Boolean) { }
        field(27; "Secuencia"; Integer) { }
        field(28; "Incidencias"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Interfase Timon Errores" WHERE("Opcion Diario" = FIELD("Opcion Diario"),
                                                                                                      "Número Linea" = FIELD("Número Linea"),
                                                                                                      "Tipo Documento" = FIELD("Tipo Documento"),
                                                                                                      "Nº Documento" = FIELD("Nº Documento"),
                                                                                                      "Secuencia Incremental" = FIELD("Secuencia Incremental")));
        }
        field(29; "Secuencia Incremental"; Integer) { }
        field(30; "Datos Iva"; Text[250]) { }
        field(31; "Base2"; Decimal) { }
        field(32; "Iva2"; Decimal) { }
        field(33; "Nº Asiento"; Integer) { }
        field(34; "Fecha Nueva"; Date) { }
        field(35; "Razon"; Text[250]) { }
        field(36; "Cif"; Text[30]) { }
        field(37; "Pais"; Text[30]) { }
        field(38; "Tipo de registro"; Integer) { }
        field(39; "Identificador"; Integer) { }
        field(40; "Empresa"; Integer) { }
        field(41; "Ejercicio"; Integer) { }
        field(42; "Diario"; Text[30]) { }
        field(43; "Proceso"; Integer) { }
        field(44; "Concepto"; Text[250]) { }
        field(45; "Descripcion2"; Text[250]) { }
        field(46; "D_H"; Text[30]) { }
        field(47; "Tipo de Factura"; Text[250]) {; Description = 'Emitida,Recibida'; }
        field(48; "Serie"; Text[30]) { }
        field(49; "Total"; Decimal) { }
        field(50; "Base3"; Decimal) { }
        field(51; "Iva3"; Decimal) { }
        field(52; "%Iva2"; Decimal) { }
        field(53; "%Iva3"; Decimal) { }
        field(54; "Base4"; Decimal) { }
        field(55; "%Iva4"; Decimal) { }
        field(56; "Iva4"; Decimal) { }
        field(57; "Base5"; Decimal) { }
        field(58; "%Iva5"; Decimal) { }
        field(59; "Iva5"; Decimal) { }
        field(60; "Ticket Inicio"; Integer) { }
        field(61; "Ticket fin"; Integer) { }
        field(62; "Caja"; Text[100]) { }
        field(63; "Descripcion SII"; Text[250]) { }
        field(64; "Base1"; Decimal) { }
        field(65; "Descripcion3"; Text[250]) { }
    }
    KEYS
    {
        Key(P; "Opcion Diario", "Tipo Documento", "Nº Documento", "Número Linea", "Secuencia Incremental")
        {
            Clustered = true;
        }
        Key(S; Secuencia) { }
        Key(O; "Opcion Diario", "Nº Documento", "Número Linea") { }
        Key(I; "Secuencia Incremental") { }
    }

}
