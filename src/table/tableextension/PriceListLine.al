
/// <summary>
/// TableExtension ResourcePriceKuara (ID 80187) extends Record Price List line.
/// </summary>
tableextension 80187 "ResourcePriceKuara" extends "Price List line"
{
    fields
    {
        field(54002; Agencia; Boolean)
        {
            trigger OnValidate()
            begin
                If Agencia then begin
                    "Source Type" := "Source Type"::"Customer Price Group";
                    "Source No." := 'AGENCIA';
                end else begin
                    "Source Type" := "Source Type"::"All Customers";
                    "Source No." := '';
                end;
            end;
        }

        modify("Work Type Code")
        {

            Caption = 'Dia tarifa';
            trigger OnAfterValidate()
            begin
                Rec."Dia tarifa" := Rec."Work Type Code";
            end;

            trigger OnBeforeValidate()
            var
                wType: Record "Work Type";
            begin
                if not wType.Get("Work Type Code") then begin
                    wType.Init();
                    wType.Code := "Work Type Code";
                    wType.Insert();
                end;
            end;

        }
        field(50000; "Dia tarifa"; CODE[10])
        {

        }
        field(50001; "Seccion"; CODE[20]) { }
        //field(50002; "Vendor No."; CODE[20]) { TableRelation = Vendor; }
        // field(50003; "Currency Code"; CODE[10]) { TableRelation = Currency; }
        // field(50004; "Starting Date"; Date) { }
        // field(50015; "Ending Date"; Date) { }
        field(54016; "Dest. Type"; Enum "Dest. Type") { }
        field(54017; "Dest. Code"; CODE[20])
        {
            ValidateTableRelation = false;
            TableRelation = if ("Dest. Type" = CONST(Resource)) Resource
            ELSE
            if ("Dest. Type" = CONST("Group(Resource)")) "Resource Group";
        }
        modify("Unit Price")
        {
            Caption = 'Local - Alquiler Anual';
        }
        field(51029; "Local - Alquiler 7 Meses"; Decimal) { }
        field(51030; "Nacional - Alquiler Anual"; Decimal) { }
        field(51031; "Nacional - Alquiler 7 Meses"; Decimal) { }
        //Precis mes
        field(51032; "Local - Alquiler 1 Mes"; Decimal) { }
        field(51033; "Nacional - Alquiler 1 Mes"; Decimal) { }
        field(51034; "Tipo de tarifa"; Enum "Tipo de tarifa")
        {
            trigger OnValidate()
            begin
                case "Tipo de tarifa" of
                    "Tipo de tarifa"::" ":
                        begin
                            "Asset Type" := "Asset Type"::" "
                        end;
                    "Tipo de tarifa"::"Item":
                        begin
                            "Asset Type" := "Asset Type"::Item;
                        end;
                    "Tipo de tarifa"::"Item Discount Group":
                        begin
                            "Asset Type" := "Asset Type"::"Item Discount Group";
                        end;
                    "Tipo de tarifa"::"Resource":
                        begin
                            "Asset Type" := "Asset Type"::Resource;
                        end;
                    "Tipo de tarifa"::"Resource Group":
                        begin
                            "Asset Type" := "Asset Type"::"Resource Group";
                        end;
                    "Tipo de tarifa"::"Service Cost":
                        begin
                            "Asset Type" := "Asset Type"::"Service Cost";
                        end;
                    "Tipo de tarifa"::"G/L Account":
                        begin
                            "Asset Type" := "Asset Type"::"G/L Account";
                        end;
                end;
            end;
        }
        modify("Asset Type")
        {
            Caption = 'Tipo Tarifa';
            trigger OnAfterValidate()
            begin
                case "Asset Type" of
                    "Asset Type"::" ":
                        begin
                            "Tipo de tarifa" := "Tipo de tarifa"::" "
                        end;
                    "Asset Type"::"Item":
                        begin
                            "Tipo de tarifa" := "Tipo de tarifa"::Item;
                        end;
                    "Asset Type"::"Item Discount Group":
                        begin
                            "Tipo de tarifa" := "Tipo de tarifa"::"Item Discount Group";
                        end;
                    "Asset Type"::"Resource":
                        begin
                            "Tipo de tarifa" := "Tipo de tarifa"::Resource;
                        end;
                    "Asset Type"::"Resource Group":
                        begin
                            "Tipo de tarifa" := "Tipo de tarifa"::"Resource Group";
                        end;
                    "Asset Type"::"Service Cost":
                        begin
                            "Tipo de tarifa" := "Tipo de Tarifa"::"Service Cost";
                        end;
                    "Asset Type"::"G/L Account":
                        begin
                            "Tipo de tarifa" := "Tipo de tarifa"::"G/L Account";
                        end;
                end;
            end;
        }
        field(51035; Duracion; Decimal)
        {
            Caption = 'Duración';
        }
        field(51036; "Tipo Duracion"; Enum "Duracion")
        {
            Caption = 'Tipo Duración';
            trigger OnValidate()
            begin
                If "Tipo Duracion" = "Tipo Duracion"::" " Then
                    Validate(Duracion, 1);
            end;
        }


    }

}
enum 80177 "Tipo de Tarifa" implements "Price Asset"
{
    value(0; " ")
    {
        Caption = '(All)';
        Implementation = "Price Asset" = "Price Asset - All";
    }
    value(10; Item)
    {
        Caption = 'Producto';
        Implementation = "Price Asset" = "Price Asset - Item";
    }
    value(20; "Item Discount Group")
    {
        Caption = 'Tarifa';
        Implementation = "Price Asset" = "Price Asset - Item Disc. Group";
    }
    value(30; Resource)
    {
        Caption = 'Resourso';
        Implementation = "Price Asset" = "Price Asset - Resource";
    }
    value(40; "Resource Group")
    {
        Caption = 'Familia Recurso';
        Implementation = "Price Asset" = "Price Asset - Resource Group";
    }
    value(50; "Service Cost")
    {
        Caption = 'Coste Servicio';
        Implementation = "Price Asset" = "Price Asset - Service Cost";
    }
    value(60; "G/L Account")
    {
        Caption = 'Cuenta Contable';
        Implementation = "Price Asset" = "Price Asset - G/L Account";
    }
}

