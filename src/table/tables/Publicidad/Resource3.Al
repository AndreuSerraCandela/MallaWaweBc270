/// <summary>
/// Table Resource3 (ID 7001114).
/// </summary>
table 7001114 Resource3
{
    Extensible = true;
    Caption = 'Resource3';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

        }
        field(2; Type; Enum "Resource Type")
        {
            Caption = 'Type';
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';

        }
        field(4; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
        }
        field(5; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(6; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(7; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(8; City; Text[30])
        {
            Caption = 'City';
        }
        field(9; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(10; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
        }
        field(11; Education; Text[30])
        {
            Caption = 'Education';
        }
        field(12; "Contract Class"; Text[30])
        {
            Caption = 'Contract Class';
        }
        field(13; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
        }
        field(14; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            TableRelation = "Resource Group";

        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

        }
        field(18; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";

        }
        field(19; "Direct Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
            MinValue = 0;

        }
        field(20; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 2 : 2;

        }
        field(21; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            MinValue = 0;

        }
        field(22; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;

        }
        field(23; "Price/Profit Calculation"; Option)
        {
            Caption = 'Price/Profit Calculation';
            OptionCaption = 'Profit=Price-Cost,Price=Cost+Profit,No Relationship';
            OptionMembers = "Profit=Price-Cost","Price=Cost+Profit","No Relationship";

        }
        field(24; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;

        }
        field(25; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(26; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(27; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Resource),
                                                      "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; Blocked; Boolean)
        {
            Caption = 'Blocked';

        }
        field(39; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(40; "Unit of Measure Filter"; Code[10])
        {
            Caption = 'Unit of Measure Filter';
            FieldClass = FlowFilter;
            TableRelation = "Unit of Measure";
        }
        field(41; Capacity; Decimal)
        {
            CalcFormula = Sum("Res. Capacity Entry".Capacity WHERE("Resource No." = FIELD("No."),
                                                                    Date = FIELD("Date Filter")));
            Caption = 'Capacity';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(42; "Qty. on Order (Job)"; Decimal)
        {
            CalcFormula = Sum("Job Planning Line"."Quantity (Base)" WHERE(Status = CONST(Order),
                                                                           "Schedule Line" = CONST(true),
                                                                           Type = CONST(Resource),
                                                                           "No." = FIELD("No."),
                                                                           "Planning Date" = FIELD("Date Filter")));
            Caption = 'Qty. on Order (Job)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(43; "Qty. Quoted (Job)"; Decimal)
        {
            CalcFormula = Sum("Job Planning Line"."Quantity (Base)" WHERE(Status = CONST(Quote),
                                                                           "Schedule Line" = CONST(true),
                                                                           Type = CONST(Resource),
                                                                           "No." = FIELD("No."),
                                                                           "Planning Date" = FIELD("Date Filter")));
            Caption = 'Qty. Quoted (Job)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(44; "Usage (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Res. Ledger Entry"."Quantity (Base)" WHERE("Entry Type" = CONST(Usage),
                                                                           Chargeable = FIELD("Chargeable Filter"),
                                                                           "Unit of Measure Code" = FIELD("Unit of Measure Filter"),
                                                                           "Resource No." = FIELD("No."),
                                                                           "Posting Date" = FIELD("Date Filter")));
            Caption = 'Usage (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Usage (Cost)"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Sum("Res. Ledger Entry"."Total Cost" WHERE("Entry Type" = CONST(Usage),
                                                                      Chargeable = FIELD("Chargeable Filter"),
                                                                      "Unit of Measure Code" = FIELD("Unit of Measure Filter"),
                                                                      "Resource No." = FIELD("No."),
                                                                      "Posting Date" = FIELD("Date Filter")));
            Caption = 'Usage (Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; "Usage (Price)"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Sum("Res. Ledger Entry"."Total Price" WHERE("Entry Type" = CONST(Usage),
                                                                       Chargeable = FIELD("Chargeable Filter"),
                                                                       "Unit of Measure Code" = FIELD("Unit of Measure Filter"),
                                                                       "Resource No." = FIELD("No."),
                                                                       "Posting Date" = FIELD("Date Filter")));
            Caption = 'Usage (Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "Sales (Qty.)"; Decimal)
        {
            CalcFormula = - Sum("Res. Ledger Entry"."Quantity (Base)" WHERE("Entry Type" = CONST(Sale),
                                                                            "Unit of Measure Code" = FIELD("Unit of Measure Filter"),
                                                                            "Resource No." = FIELD("No."),
                                                                            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Sales (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(48; "Sales (Cost)"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = - Sum("Res. Ledger Entry"."Total Cost" WHERE("Entry Type" = CONST(Sale),
                                                                       "Unit of Measure Code" = FIELD("Unit of Measure Filter"),
                                                                       "Resource No." = FIELD("No."),
                                                                       "Posting Date" = FIELD("Date Filter")));
            Caption = 'Sales (Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; "Sales (Price)"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = - Sum("Res. Ledger Entry"."Total Price" WHERE("Entry Type" = CONST(Sale),
                                                                        "Unit of Measure Code" = FIELD("Unit of Measure Filter"),
                                                                        "Resource No." = FIELD("No."),
                                                                        "Posting Date" = FIELD("Date Filter")));
            Caption = 'Sales (Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Chargeable Filter"; Boolean)
        {
            Caption = 'Chargeable Filter';
            FieldClass = FlowFilter;
        }
        field(51; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

        }
        field(52; Picture; BLOB)
        {
            Caption = 'Picture';
            ObsoleteReason = 'Replaced by Image field';
            ObsoleteState = Removed;
            SubType = Bitmap;
            ObsoleteTag = '15.0';
        }
        field(53; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = if ("Country/Region Code" = CONST('')) "Post Code"
            ELSE
            if ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

        }
        field(54; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
            Caption = 'County';
        }
        field(55; "Automatic Ext. Texts"; Boolean)
        {
            Caption = 'Automatic Ext. Texts';
        }
        field(56; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(57; "Tax Group Code"; Code[20])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(58; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(59; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

        }
        field(60; "IC Partner Purch. G/L Acc. No."; Code[20])
        {
            Caption = 'IC Partner Purch. G/L Acc. No.';
            TableRelation = "IC G/L Account";
        }
        field(140; Image; Media)
        {
            Caption = 'Image';
        }
        field(150; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';

        }
        field(900; "Qty. on Assembly Order"; Decimal)
        {
            CalcFormula = Sum("Assembly Line"."Remaining Quantity (Base)" WHERE("Document Type" = CONST(Order),
                                                                                 Type = CONST(Resource),
                                                                                 "No." = FIELD("No."),
                                                                                 "Due Date" = FIELD("Date Filter")));
            Caption = 'Qty. on Assembly Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(950; "Use Time Sheet"; Boolean)
        {
            Caption = 'Use Time Sheet';

        }
        field(951; "Time Sheet Owner User ID"; Code[50])
        {
            Caption = 'Time Sheet Owner User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup";

        }
        field(952; "Time Sheet Approver User ID"; Code[50])
        {
            Caption = 'Time Sheet Approver User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup";

        }
        field(1700; "Default Deferral Template Code"; Code[10])
        {
            Caption = 'Default Deferral Template Code';
            TableRelation = "Deferral Template"."Deferral Code";
        }
        field(5900; "Qty. on Service Order"; Decimal)
        {
            CalcFormula = Sum("Service Order Allocation"."Allocated Hours" WHERE(Posted = CONST(false),
                                                                                  "Resource No." = FIELD("No."),
                                                                                  "Allocation Date" = FIELD("Date Filter"),
                                                                                  Status = CONST(Active)));
            Caption = 'Qty. on Service Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5901; "Service Zone Filter"; Code[10])
        {
            Caption = 'Service Zone Filter';
            TableRelation = "Service Zone";
        }
        field(5902; "In Customer Zone"; Boolean)
        {
            CalcFormula = Exist("Resource Service Zone" WHERE("Resource No." = FIELD("No."),
                                                               "Service Zone Code" = FIELD("Service Zone Filter")));
            Caption = 'In Customer Zone';
            Editable = false;
            FieldClass = FlowField;
        }
        // field(80026; "Fecha de baja"; Boolean)
        // {
        //     Caption = 'No usar';
        //     DataClassification = ToBeClassified;
        // }
        field(80027; "Fecha baja"; Date)
        {
            Caption = 'Fecha baja';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            VAR
                rAct: Record 5600;
                CCod: Codeunit ControlProcesos;
            BEGIN
                rAct.SETRANGE(rAct.Recurso, "No.");
                if rAct.FINDFIRST THEN BEGIN
                    // MESSAGE('Este recurso tiene un activo relacionado. Se va a dar de baja');
                    CLEAR(CCod);
                    CCod.Baja(rAct."No.", "No.");
                END;
            END;
            //Description=$004 
        }
        field(50001; "Categoria"; Enum "Categoria")
        {
            InitValue = " ";

        }
        field(50002; "Iluminado"; Boolean)
        {
            InitValue = false;
        }
        field(50003; "Tipo Recurso"; Code[10])
        {
            TableRelation = "Tipo Recurso";

            //Description=FK Tipo Recurso 
        }
        field(50004; "Historia"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist(Reserva WHERE("Nº Recurso" = FIELD("No.")));
            //Description=Campo calculado historia 
        }
        field(50005; "Nº Dias Reservados"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Diario Reserva" WHERE("Nº Recurso" = FIELD("No."),
                        Fecha = FIELD("Date Filter")));
            //Description=Campo suma reservas del recurso;
            Editable = false;
        }
        field(50006; "Ocupado"; Boolean)
        {
            InitValue = false;
            //Description=Campo para saber los recursos libres a la hora de cambiar una reserva 
        }
        field(50007; "Estado actual"; Enum "Estado Reserva")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Diario Reserva".Estado WHERE("Nº Recurso" = FIELD("No."),
                                Fecha = FIELD("Date Filter")));
            //OptionString=Reservado,Reservado fijo,Ocupado,Ocupado fijo,Libre;
            Editable = false;
        }
        field(50008; "Medidas"; Code[20]) { TableRelation = Medidas; }
        field(50009; "Zona"; Code[20])
        {
            TableRelation = "Zonas Recursos";
            //Description=FK Zonas 
        }
        field(50010; "Orientación"; Enum "Orientación") { }//Indistinto,Entrada,Salida }
        field(50015; "Enunciado Cto. Venta"; Text[30])
        {
            //Description=Si hay algo, sustituye la descripcion en el cto. vta. 
        }
        field(50020; "Carretera"; Text[20])
        {
            //Description=Punto kilometrico 
        }
        field(50025; "Municipio"; Code[15]) { }
        field(50026; "C.P. Municipio"; Code[5]) { }
        field(50030; "Prohibiciones"; Text[50])
        {
        }
        field(50031; "Tiene Prohibiciones"; Boolean) { Editable = false; }
        field(50035; "Tipo Montaje"; Enum "Tipo Montaje")
        {
            //" ,V,T,VT,BP";
            //Description=$002 
        }
        field(50036; "Filtro Proveedor"; Code[20]) { FieldClass = FlowFilter; }
        field(50037; "Filtro Seccion"; Code[20]) { FieldClass = FlowFilter; }
        field(50038; "Tiene Tarifas"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Price List Line" WHERE("Asset Type" = CONST(Resource),
                                "Asset No." = FIELD("No."),
                                "Source No." = FIELD("Filtro Proveedor"),
                                Seccion = FIELD("Filtro Seccion")));
        }
        field(50039; "No. Orden"; Integer)
        {
            BlankZero = true;

        }
        field(50040; "Peligrosidad"; Code[20])
        {
            TableRelation = "Codigos peligrosidad";
            //Description=$003 
        }
        field(50041; "Linea vida"; Boolean)
        {
            Caption = 'Línea vida';
            //Description=$003 
        }
        // field(50042; "Fecha baja"; Boolean)
        // {

        // }
        field(50043; "Clave orden"; Code[30]) { }//        ;Description=$005 }
        field(50044; "Empresa"; Enum "Empresa")
        {//=Común,BAPUEXSA,Basisa,CRUCEROS PROVIDENCIA,ES FORTI 49,Grepsa,Ibiza Publicidad,INVERSIONES EN MEDIOS PUBL.,JUNIPERO SERRA DE CONST.,Malla de Promociones y RR.PP.,Malla de serv. técnicos,Malla Publicidad,Mediterranea,Menorca de Publicidad,PISCIS DOS TRES HACHE,PITOSPORUM,Publicidad Continental,SA VINYA DELS MOSCATELLS,TOLO 54,VIA ROMA Nº 20;
        }
        field(50045; "Tipo fijacion"; Enum "Tipo fijacion") { }
        field(50046; "Observaciones peligrosidad"; Text[80]) { }
        field(50047; "Nº En Empresa origen"; Code[20]) { }
        field(50048; "Empresa Origen"; Text[30]) { }
        field(50049; "Emplazamiento"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Resource"."No." WHERE("No." = FIELD("No.")));
        }
        //field(50050; "Irpf"; Boolean) { }
        field(50051; "Principal"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Table ID" = CONST(156),
                                "No." = FIELD("No."),
                                "Dimension Code" = CONST('PRINCIPAL')));
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('PRINCIPAL'));
            Editable = true;
        }
        field(50052; "Soporte"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Table ID" = CONST(156),
                                "No." = FIELD("No."),
                                "Dimension Code" = CONST('SOPORTE')));
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SOPORTE'));
        }
        field(50053; "Dimensión Zona"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Table ID" = CONST(156),
                                "No." = FIELD("No."),
                                "Dimension Code" = CONST('ZONA')));
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('ZONA'));
        }
        field(51016; "Global Dimension 3 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            CaptionClass = '1,2,3';

        }
        field(51017; "Global Dimension 4 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            CaptionClass = '1,2,4';
        }
        field(51018; "Global Dimension 5 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            CaptionClass = '1,2,5';
        }
        field(51019; "Recurso Agrupado"; Boolean) { }
        field(51020; "Producción"; Boolean) { }
        field(51021; "Tipo Recurso principal"; Code[10]) { TableRelation = "Tipo Recurso"; }
        field(51022; "Zona Comercial"; Code[20]) { TableRelation = "Zonas comerciales".Zona; }
        field(51023; "PuntoX"; Decimal) {; DecimalPlaces = 8 : 8; }
        field(51024; "PuntoY"; Decimal) {; DecimalPlaces = 8 : 8; }
        field(51025; "Customer Price Group"; Code[10])
        {
            TableRelation = "Customer Price Group";
            Caption = 'Categoría Tarifa';
        }
        field(51026; "Activo"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Fixed Asset"."No." WHERE(Recurso = FIELD("No.")));
        }
        field(51027; "Seleccionar"; Boolean) { }
        field(51028; "Alquiler Anual"; Decimal) { }
        field(51029; "Local - Alquiler 7 Meses"; Decimal) { }
        field(51030; "Nacional - Alquiler Anual"; Decimal) { }
        field(51031; "Nacional - Alquiler 7 Meses"; Decimal) { }
        field(51032; "Material fijación"; Enum "Material de Fijación")
        {//Sin especificar,Solo Vinilo,Vinilo y Papel,Vinilo y lona;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; "Gen. Prod. Posting Group")
        {
        }
        key(Key4; Name)
        {
        }
        key(Key5; Type)
        {
        }
        key(Key6; "Base Unit of Measure")
        {
        }
        key(Key7; "Resource Group No.")
        {
        }
        key(Key8; SystemModifiedAt)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, Type, "Base Unit of Measure")
        {
        }
        fieldgroup(Brick; "No.", Name, Type, "Base Unit of Measure", Image)
        {
        }
    }

}

