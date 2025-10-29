/// <summary>
/// TableExtension LocationKuara (ID 80144) extends Record Location.
/// </summary>
tableextension 80144 "LocationKuara" extends "Location"
{
    fields
    {
        field(50101; "Filtro TPV"; CODE[10])
        {
            FieldClass = FlowFilter;
        }
        field(50110; "Clasificación"; CODE[10])
        {
            TableRelation = "Base Calendar".Code;
        }
        field(50115; "Global Dimension 2 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';

        }
        field(50116; "Empresa Fiscal"; TEXT[30])
        {
            TableRelation = Company.Name;
        }
        field(50117; "Global Dimension 1 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';

        }
        field(50118; "Almacén En Central Compras"; Boolean)
        {

        }
        field(50119; "Cliente Almacen"; CODE[20])
        {
            TableRelation = Customer."No.";
        }
        field(50120; "Proveedor Almacen"; CODE[20])
        {
            TableRelation = Vendor."No.";
        }
        field(50121; "Tipo"; Enum "Tipo Economato") { }
        field(50124; "Cód. Hotel"; CODE[10]) { }
        field(50125; "Almacén Desayuno"; CODE[10])
        {
            TableRelation = Location.Code;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Code = "Almacén Desayuno" THEN ERROR(Text202, "Almacén Desayuno", Code);
            end;
        }
        field(50126; "Almacén Consumo Directo"; CODE[10])
        {
            TableRelation = Location.Code;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Code = "Almacén Consumo Directo" THEN ERROR(Text203, "Almacén Consumo Directo", Code);
            end;

        }
        field(50127; "Cta. Existencias"; TEXT[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50128; "Cta. Compras"; TEXT[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50137; "Filtro Subtipo"; Enum "Filtro Subtipo")
        {
            Caption = 'No usar';
            ObsoleteState = Removed;
            ObsoleteReason = 'Error Field Class';


        }
        field(50139; "Cta. Contable Existencias Alt."; TEXT[13])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50140; "Cta. Contable Consumos Alt."; TEXT[13])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50143; "Cód. Zona"; CODE[10])
        {

        }
        field(50144; "Control regularización cierres"; Enum "Control regularización cierres") { }
        field(50146; "Cta. Existencias TPV"; TEXT[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50147; "Cierre automático"; Boolean) { }
        field(50148; "Periodo cierre automático"; Enum "Periodo cierre automático") { }
        field(50149; "Periodo cierre manual"; Enum "Periodo cierre manual") { }
        field(50152; "Source Counter"; Integer) { }
        field(50154; "Fecha ultima modificacion"; Date) { }
        field(50155; "Cliente exento Impuestos"; Boolean) { }
        field(50156; "Grupo registro exento Imp."; CODE[10])
        {
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(50157; "Libro amortizacion"; CODE[10])
        {
            TableRelation = "FA Depreciation Book";
        }
        field(50158; "Almacen de consumo"; Boolean) { }
        field(50159; "Control stock maximo"; Enum "Control stock maximo") { }
        field(50160; "Filtro x Subtipo"; Enum "Filtro Subtipo")
        {
            Caption = 'Filtro Subtipo';
            FieldClass = FlowFilter;


        }
    }
    var
        Text200: Label 'No se puede borrar un almacén con movimientos';
        Text201: Label 'Falta la configuración de contabilidad para el hotel %1';
        Text202: Label 'El almacén desayuno %1 no puede ser igual al código de almacén %2.';
        Text203: Label 'El almacén consumo directo %1 no puede ser igual al código de almacén %2.';
        Text204: Label 'No se puede renombrar un almacén con movimientos';

}