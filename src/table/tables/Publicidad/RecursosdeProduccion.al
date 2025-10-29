/// <summary>
/// Table Recursos de Producción (ID 7001123).
/// </summary>
table 7001123 "Recursos de Producción"
{
    Caption = 'Recursos de Producción';

    LookupPageId = "Producciones x Recurso";
    DrillDownPageId = "Producciones x Recurso";
    fields
    {
        field(1; "Tipo de Soporte"; Code[20])
        {
            Caption = 'Tipo de Soporte';
            TableRelation = "Tipo Recurso".Tipo where("Crea Reservas" = const(true));

        }
        field(2; Material; Text[30])
        {
            Caption = 'Material';
            TableRelation = Material."Código";

        }
        field(3; "Recurso No."; Code[20])
        {
            Caption = 'Recurso No.';
            TableRelation = Resource."No." where("Producción" = const(true));

        }
        field(4; Venta; Decimal)
        {
            Caption = 'Venta';

        }
        field(5; "Descuento Compra"; Decimal)
        {
            Caption = 'Descuento Compra';
            trigger OnValidate()
            begin
                Compra := Venta * (1 - "Descuento Compra" / 100);
            end;

        }
        field(6; "Descuento Venta"; Decimal)
        {
            Caption = 'Descuento Venta';

        }
        field(7; Compra; Decimal)
        {
            Caption = 'Compra';

        }
        field(8; Empresa; Text[30])
        {
            TableRelation = Company;
        }
        field(9; "Nº Proyecto"; Code[20])
        {
            TableRelation = Job;
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                JOB: Record Job;
                jOBoRIGEN: Record Job;
            begin
                if Empresa <> '' Then JOB.ChangeCompany(Empresa);
                If "Proyecto Origen" <> '' Then
                    iF jOBoRIGEN.Get("Proyecto Origen") then
                        JOB.SetRange("Bill-to Customer No.", jOBoRIGEN."Bill-to Customer No.");

                if Page.RunModal(0, JOB) = Action::LookupOK Then "Nº Proyecto" := JOB."No.";
            end;
        }
        field(10; Incluida; Boolean)
        {

        }
        field(11; Descripcion; Text[50])
        {
            Caption = 'Descripción';
        }
        field(12; "Precio Unitario"; Decimal)
        {
            Caption = 'Precio Unitario';
            trigger OnValidate()
            var
                rProd: Record "Recursos de Producción";
            begin

                If IsTemporary Then begin
                    rProd.Get("Tipo de Soporte", Material, "Recurso No.");
                    If "Precio Unitario" = 0 then
                        Error('El precio unitario no puede ser 0');
                    // La diferencia no puede ser superior al 25%
                    If rProd."Precio Unitario" <> 0 then
                        if (Abs(rProd."Precio Unitario" - "Precio Unitario") / rProd."Precio Unitario") * 100 > 25 then
                            Error('No ha elegido el material correcto. revise las opciones');
                    if rProd."Precio Unitario" = 0 then
                        Message('No tinen configurado el precio unitario del material');
                end;
            end;
        }
        field(13; "Cantidad"; Decimal)
        {
            Caption = 'Cantidad';
            trigger OnValidate()
            begin
                Venta := Cantidad * "Precio Unitario";
                Compra := Cantidad * "Precio Unitario" * (1 - "Descuento Compra" / 100);
            end;
        }
        field(14; "Proyecto Origen"; Code[20])
        {
            TableRelation = Job;
            ValidateTableRelation = false;

        }
        field(15; "Empresa Origen"; Text[30])
        {
            TableRelation = Company;
        }


    }
    keys
    {
        key(PK; "Tipo de Soporte", Material, "Recurso No.")
        {
            Clustered = true;
        }
    }
}
