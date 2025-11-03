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




}

