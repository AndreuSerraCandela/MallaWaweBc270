/// <summary>
/// Table Emplazamientos x Recursos (ID 7010458).
/// </summary>
table 50099 "Emplazamientos x Recursos"
{
    ObsoleteState = Removed;



    fields
    {
        field(1; "Nº Emplazamiento"; Code[20])
        {
            //TableRelation = "Emplazamientos proveedores"."Nº Emplazamiento" WHERE("Nº Emplazamiento" = FIELD("Nº Emplazamiento"));
            NotBlank = true;
        }
        field(5; "Nº Recurso"; Code[20])
        {
            TableRelation = Resource;
        }
        field(10; "Descripción emplazamiento"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Emplazamientos proveedores".Descripción WHERE("Nº Emplazamiento" = FIELD("Nº Emplazamiento")));
            TableRelation = "Emplazamientos proveedores".Descripción WHERE("Nº Emplazamiento" = FIELD("Nº Emplazamiento"));
            ValidateTableRelation = false;

            Editable = false;
        }
        field(11; "Descripción recurso"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Name WHERE("No." = FIELD("Nº Recurso")));
        }
        field(15; "Medidas recurso"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Medidas WHERE("No." = FIELD("Nº Recurso")));

            Editable = false;
        }
        field(20; "Municipio recurso"; Code[15])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Municipio WHERE("No." = FIELD("Nº Recurso")));

            Editable = false;
        }
        field(25; "Prohibiciones"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."Tiene Prohibiciones" WHERE("No." = FIELD("Nº Recurso")));

            Editable = false;
        }
        field(26; "Activo"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Fixed Asset"."No." WHERE(Recurso = FIELD("Nº Recurso")));
        }
        field(35; "Suelo"; Enum "Suelo") { }
        field(80; "Fecha instalación"; Date) { }
        field(90; "Carretera"; Code[20]) { }
        field(91; "Está en Carretera"; Boolean) { }
        field(50117; "Punto Kilométrico"; Decimal)
        {
            ; DecimalPlaces = 3 : 3;
            MaxValue = 999;
        }
        field(50118; "Solicitado CIM"; Boolean) { Caption = 'Solicitado Consell'; }
        field(50119; "Fecha Solicitud CIM"; Date) { Caption = 'Fecha Solicitud Consell'; }
        field(50120; "Autorizado CIM"; Boolean) { Caption = 'Autorizado Consell'; }
        field(50121; "Fecha Autorización CIM"; Date) { Caption = 'Fecha Autorización Consell'; }
        field(50122; "Nº Autorización CIM"; Text[30]) { Caption = 'Nº Autorización Consell'; }
        field(50123; "Denegado CIM"; Boolean) { Caption = 'Denegado Consell'; }
        field(50124; "Fecha Denegación CIM"; Date) { Caption = 'Fecha Denegación Consell'; }
        field(50125; "CIM"; Boolean) { Caption = 'Consell'; }
        field(50126; "Ayuntamiento"; Boolean) { }
        field(50127; "Resource Group No."; Code[20])
        {
            Caption = 'Nº fam. recurso';
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource."Resource Group No." WHERE("No." = FIELD("Nº Recurso")));
            TableRelation = "Resource Group";
        }
        field(50128; "Solicitado AYU."; Boolean) { }
        field(50129; "Fecha Solicitud AYU."; Date) { }
        field(50130; "Autorizado AYU."; Boolean) { }
        field(50131; "Fecha Autorización AYU."; Date) { }
        field(50132; "Nº Autorización AYU."; Text[30]) { }
        field(50133; "Denegado AYU."; Boolean) { }
        field(50144; "Fecha Denegación AYU."; Date) { }
        //PESTAÑA EXPEDIENTE ADMVO
        //.* Poder adjuntar la documentacion en pdf. O jpg

        field(50145; "Expediente"; Text[250]) { Caption = 'Expediente'; }

        field(50146; "Sanción"; Boolean) { Caption = 'Sanción'; }
        field(50147; "Fehca Pago"; Boolean) { Caption = 'Sanción'; }

        field(50148; "Boletín"; Text[30]) { Caption = 'Boletín'; }

        field(50149; "Incoación"; Text[30]) { }

        field(50150; "Propuesta resolución"; Text[30]) { }

        field(50151; "Resolución"; Text[30]) { }

        field(50152; "Observaciones resolución"; Text[250]) { }

        field(50153; "Resolución recurso"; Text[30]) { }
        // PESTAÑA RCa;Text[30]){}

        field(50154; RCA; Boolean) { caption = 'Recurso Contencioso Administrativo'; }
        field(50165; "Visto Rca"; Boolean) { }

        field(50155; "Comunicación RCA"; Text[30]) { }



        field(50156; "Interposición"; Date) { }
        field(50157; Mc; Text[30]) { }

        field(50158; Demanda; Text[30]) { }

        field(50159; "Contestación demanda"; Text[30]) { }

        field(50160; "Observaciones interposición"; Text[250]) { }



        // PESTAÑA Solicitudes;Text[30]){}

        field(50161; Emplazamiento; Text[30]) { }

        field(50162; Ubicación; Text[30]) { }

        field(50163; Fases; Text[30]) { }


        field(50164; "Observaciones Solicitudes"; Text[30]) { }



    }
    KEYS
    {
        key(Emplazamiento; "Nº Emplazamiento", "Nº Recurso") { Clustered = true; }
    }

}
