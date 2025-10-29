/// <summary>
/// Page Intercambio List (ID 50026).
/// </summary>
page 50026 "Intercambio List"
{
    Caption = 'Lista Intercambio';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Ficha Intercambio";
    SourceTable = Intercambio;
    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; rec.Name) { ApplicationArea = All; }
                field("VAT Registration No."; Rec."VAT Registration No.") { ApplicationArea = All; }
                field("Name 2"; rec."Name 2") { ApplicationArea = All; }
                field(Address; rec.Address) { ApplicationArea = All; }
                field("Address 2"; rec."Address 2") { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field("Post Code"; Rec."Post Code") { ApplicationArea = All; }
                field("Country/Region Code"; Rec."Country/Region Code") { ApplicationArea = All; }
                field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field("Fax No."; Rec."Fax No.") { ApplicationArea = All; }
                field(Contact; Rec.Contact) { ApplicationArea = All; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
                field("Payment Method Code"; Rec."Payment Method Code") { ApplicationArea = All; }
                field("Payment Terms Code"; Rec."Payment Terms Code") { ApplicationArea = All; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
                field("Search Name"; Rec."Search Name") { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Ficha")
            {
                ApplicationArea = All;
                Image = List;
                ShortCutKey = 'Mayús+F5';
                //       CaptionML=ESP=Ficha;
                RunObject = Page "Ficha Intercambio";
                RunPageLink = "No." = FIELD("No.");
            }
            action("&Desplegar")
            {
                ApplicationArea = All;
                Image = BOMLevel;
                ShortCutKey = F11;
                //CaptionML=ESP=Desplegar;
                trigger OnAction()
                VAR
                    rEmpresa: Record 2000000006;
                    Customer: Record Customer;
                    Vendor: Record Vendor;
                    RxE: Record "Intercambio x Empresa";
                    Cli: Code[20];
                    Prov: Code[20];
                BEGIN
                    Desplegar(Rec);
                END;
            }
            action("&Ver Clientes/Provee x Empresa")
            {
                ApplicationArea = All;
                Image = Find;
                //CaptionML=ESP=Ver Clientes/Provee x Empresa;
                trigger OnAction()
                VAR
                    RxE: Record "Intercambio x Empresa";
                BEGIN
                    RxE.SETRANGE(RxE."Código Intercambio", Rec."No.");
                    Page.RUNMODAL(Page::"Intercambio x Empresa", RxE);
                END;
            }
            action("Copiar &Datos del cliente")
            {
                ApplicationArea = All;
                ShortCutKey = F6;
                Image = Copy;
                //CaptionML=ESP=Copiar Datos del cliente;
                trigger OnAction()
                VAR
                    Customer: Record Customer;
                BEGIN
                    if Page.RUNMODAL(0, Customer) = ACTION::LookupOK THEN BEGIN
                        //"No.":=Customer."No.";
                        if Rec."No." = '' THEN Rec.INSERT(TRUE);
                        //"Search Name":=Customer."Search Name";
                        Rec.Name := Customer.Name;
                        Rec."Name 2" := Customer."Name 2";
                        Rec.Address := Customer.Address;
                        Rec."Address 2" := Customer."Address 2";
                        Rec.City := Customer.City;
                        Rec.Contact := Customer.Contact;
                        Rec."Phone No." := Customer."Phone No.";
                        Rec."Telex No." := Customer."Telex No.";
                        Rec."Our Account No." := Customer."Our Account No.";
                        Rec."Territory Code" := Customer."Territory Code";
                        Rec."Global Dimension 1 Code" := Customer."Global Dimension 1 Code";
                        Rec."Global Dimension 2 Code" := Customer."Global Dimension 2 Code";
                        Rec."Chain Name" := Customer."Chain Name";
                        Rec."Budgeted Amount" := Customer."Budgeted Amount";
                        Rec."Credit Limit (LCY)" := Customer."Credit Limit (LCY)";
                        Rec."Currency Code" := Customer."Currency Code";
                        Rec."Payment Terms Code" := Customer."Payment Terms Code";
                        Rec."Salesperson Code" := Customer."Salesperson Code";
                        Rec."Shipment Method Code" := Customer."Shipment Method Code";
                        Rec."Shipping Agent Code" := Customer."Shipping Agent Code";
                        Rec."Country/Region Code" := Customer."Country/Region Code";
                        Rec.Blocked := Customer.Blocked;
                        Rec."Payment Method Code" := Customer."Payment Method Code";
                        Rec."Last Date Modified" := Customer."Last Date Modified";
                        Rec."Fax No." := Customer."Fax No.";
                        Rec."VAT Registration No." := Customer."VAT Registration No.";
                        Rec."Post Code" := Customer."Post Code";
                        Rec.County := Customer.County;
                        Rec."E-Mail" := Customer."E-Mail";
#if CLEAN24
#pragma warning disable AL0432
                        Rec."Home Page" := Customer."Home Page";
#pragma warning restore AL0432
#else
#pragma warning disable AL0432
                        Rec."Home Page" := Customer."Home Page";
#endif
                        Rec."Primary Contact No." := Customer."Primary Contact No.";
                        Rec."E-Mail-Facturación" := Customer."E-Mail Efactura";

                        Rec.MODIFY;
                    END;
                END;
            }
            action("Crear automá&ticamente")
            {
                Image = Create;
                ApplicationArea = All;
                Visible = false;
                //CaptionML=ESP=Crear automáticamente;
                trigger OnAction()
                VAR
                    Inter: Record Intercambio;
                    rEmpresa: Record Company;
                    Customer: Record Customer;
                    Vendor: Record Vendor;
                    RxE: Record "Intercambio x Empresa";
                    Cli: Code[20];
                    Prov: Code[20];
                    rEmp: Record "Company Information";
                    Control: Codeunit ControlProcesos;
                BEGIN

                    Inter.DELETEALL;
                    if COMPANYNAME <> 'Malla Publicidad' THEN ERROR('Solo se puede ejecutar desde Malla');
                    //rEmpresa.SETFILTER(rEmpresa."Clave Recursos",'<>%1','');
                    rEmpresa.SetRange("Evaluation Company", false);
                    if rEmpresa.FINDFIRST THEN
                        REPEAT
                            if Control.Permiso_Empresas(rEmpresa.Name) then begin
                                rEmp.ChangeCompany(rEmpresa.Name);
                                if not rEmp.Get() Then rEmp.Init();
                                if rEmp."Clave Recursos" <> '' then begin
                                    Customer.CHANGECOMPANY(rEmpresa.Name);
                                    Vendor.CHANGECOMPANY(rEmpresa.Name);
                                    Customer.SETRANGE(Customer."Payment Method Code", 'INTERCAM');
                                    Customer.SETFILTER("VAT Registration No.", '<>%1', '');
                                    if Customer.FINDFIRST THEN
                                        REPEAT
                                            Inter.SETRANGE(Inter."VAT Registration No.", Customer."VAT Registration No.");
                                            if NOT Inter.FINDFIRST THEN BEGIN
                                                WITH Inter DO BEGIN
                                                    "No." := '';
                                                    if "No." = '' THEN INSERT(TRUE);
                                                    //    "Search Name":=Customer."Search Name";
                                                    Name := Customer.Name;
                                                    "Name 2" := Customer."Name 2";
                                                    Address := Customer.Address;
                                                    "Address 2" := Customer."Address 2";
                                                    City := Customer.City;
                                                    Contact := Customer.Contact;
                                                    "Phone No." := Customer."Phone No.";
                                                    "Telex No." := Customer."Telex No.";
                                                    "Our Account No." := Customer."Our Account No.";
                                                    "Territory Code" := Customer."Territory Code";
                                                    "Global Dimension 1 Code" := Customer."Global Dimension 1 Code";
                                                    "Global Dimension 2 Code" := Customer."Global Dimension 2 Code";
                                                    "Chain Name" := Customer."Chain Name";
                                                    "Budgeted Amount" := Customer."Budgeted Amount";
                                                    "Credit Limit (LCY)" := Customer."Credit Limit (LCY)";
                                                    "Currency Code" := Customer."Currency Code";
                                                    "Payment Terms Code" := Customer."Payment Terms Code";
                                                    "Salesperson Code" := Customer."Salesperson Code";
                                                    "Shipment Method Code" := Customer."Shipment Method Code";
                                                    "Shipping Agent Code" := Customer."Shipping Agent Code";
                                                    "Country/Region Code" := Customer."Country/Region Code";
                                                    Blocked := Customer.Blocked;
                                                    "Payment Method Code" := Customer."Payment Method Code";
                                                    "Last Date Modified" := Customer."Last Date Modified";
                                                    "Fax No." := Customer."Fax No.";
                                                    "VAT Registration No." := Customer."VAT Registration No.";
                                                    "Post Code" := Customer."Post Code";
                                                    County := Customer.County;
                                                    "E-Mail" := Customer."E-Mail";
#pragma warning disable AL0432
                                                    "Home Page" := Customer."Home Page";
#pragma warning restore AL0432
                                                    "Primary Contact No." := Customer."Primary Contact No.";
                                                    "E-Mail-Facturación" := Customer."E-Mail Efactura";
                                                    MODIFY;
                                                    Desplegar(Inter);
                                                    COMMIT;
                                                END;
                                            END;
                                        UNTIL Customer.NEXT = 0;
                                    Vendor.SETRANGE("Payment Method Code", 'INTERCAM');
                                    Vendor.SETFILTER("VAT Registration No.", '<>%1', '');

                                    if Vendor.FINDFIRST THEN
                                        REPEAT
                                            Inter.SETRANGE(Inter."VAT Registration No.", Vendor."VAT Registration No.");
                                            if NOT Inter.FINDFIRST THEN BEGIN
                                                WITH Inter DO BEGIN
                                                    "No." := '';
                                                    if "No." = '' THEN INSERT(TRUE);
                                                    //  "Search Name":=Vendor."Search Name";
                                                    Name := Vendor.Name;
                                                    "Name 2" := Vendor."Name 2";
                                                    Address := Vendor.Address;
                                                    "Address 2" := Vendor."Address 2";
                                                    City := Vendor.City;
                                                    Contact := Vendor.Contact;
                                                    "Phone No." := Vendor."Phone No.";
                                                    "Telex No." := Vendor."Telex No.";
                                                    "Our Account No." := Vendor."Our Account No.";
                                                    "Territory Code" := Vendor."Territory Code";
                                                    "Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                                    "Global Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                                    "Chain Name" := '';
                                                    "Budgeted Amount" := Vendor."Budgeted Amount";
                                                    "Credit Limit (LCY)" := 0;
                                                    "Currency Code" := Vendor."Currency Code";
                                                    "Payment Terms Code" := Vendor."Payment Terms Code";
                                                    "Salesperson Code" := '';
                                                    "Shipment Method Code" := Vendor."Shipment Method Code";
                                                    "Shipping Agent Code" := Vendor."Shipping Agent Code";
                                                    "Country/Region Code" := Vendor."Country/Region Code";
                                                    Blocked := Vendor.Blocked;
                                                    "Payment Method Code" := Vendor."Payment Method Code";
                                                    "Last Date Modified" := Vendor."Last Date Modified";
                                                    "Fax No." := Vendor."Fax No.";
                                                    "VAT Registration No." := Vendor."VAT Registration No.";
                                                    "Post Code" := Vendor."Post Code";
                                                    County := Vendor.County;
                                                    "E-Mail" := Vendor."E-Mail";
#pragma warning disable AL0432
                                                    "Home Page" := Vendor."Home Page";
#pragma warning restore AL0432
                                                    "Primary Contact No." := Vendor."Primary Contact No.";

                                                    MODIFY;
                                                    Desplegar(Inter);
                                                    COMMIT;
                                                END;
                                            END;

                                        UNTIL Vendor.NEXT = 0;
                                end;
                            end;
                        UNTIL rEmpresa.NEXT = 0;
                END;
            }
            action("Ver Detalle &Todos")
            {
                ApplicationArea = All;
                Image = AllLines;
                // PushAction=RunObject;                // CaptionML=ESP=Ver Detalle Todos;
                RunObject = Page "Intercambio x Empresa";
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(Blocked, Rec.Blocked::" ");
    end;


    PROCEDURE Desplegar(VAR Inter: Record Intercambio);
    VAR
        rEmpresa: Record Company;
        rEmp: Record "Company Information";
        Customer: Record Customer;
        Vendor: Record Vendor;
        RxE: Record 7001119;
        Cli: Code[20];
        Prov: Code[20];
        Control: Codeunit ControlProcesos;
    BEGIN
        //rEmpresa.SETFILTER(rEmpresa."Clave Recursos",'<>%1','');
        rEmpresa.SetRange("Evaluation Company", false);
        if rEmpresa.FINDFIRST THEN
            REPEAT
                if Control.Permiso_Empresas(rEmpresa.Name) then begin
                    rEmp.ChangeCompany((rEmpresa.Name));
                    if not rEmp.get() then rEmp.Init();
                    ;
                    if rEmp."Clave Recursos" <> '' Then begin
                        Customer.CHANGECOMPANY(rEmpresa.Name);
                        Vendor.CHANGECOMPANY(rEmpresa.Name);
                        WITH Inter DO BEGIN
                            Customer.SETRANGE("VAT Registration No.", "VAT Registration No.");
                            if NOT Customer.FINDFIRST THEN Cli := '' ELSE Cli := Customer."No.";
                            Vendor.SETRANGE("VAT Registration No.", "VAT Registration No.");
                            if NOT Vendor.FINDFIRST THEN Prov := '' ELSE Prov := Vendor."No.";
                            if RxE.GET("No.", rEmpresa.Name) THEN RxE.DELETE;
                            RxE.INIT;
                            RxE.Empresa := rEmpresa.Name;
                            RxE."Código Intercambio" := "No.";
                            RxE.Cliente := Cli;
                            RxE.Proveedor := Prov;
                            if (Cli <> '') OR (Prov <> '') THEN
                                RxE.INSERT;
                        END;
                    End;
                end;
            UNTIL rEmpresa.NEXT = 0;
    END;

}

