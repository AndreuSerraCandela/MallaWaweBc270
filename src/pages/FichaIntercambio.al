/// <summary>
/// Page Ficha Intercambio (ID 50099).
/// </summary>
page 50099 "Ficha Intercambio"
{

    Caption = 'Ficha Intercambio';
    PageType = Card;
    SourceTable = Intercambio;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field';
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field';
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field';
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field';
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field';
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field';
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field';
                    ApplicationArea = All;
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    ToolTip = 'Specifies the value of the Primary Contact No. field';
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field';
                    ApplicationArea = All;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ToolTip = 'Specifies the value of the VAT Registration No. field';
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies the value of the Search Name field';
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field';
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field';
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field';
                    ApplicationArea = All;
                }
            }
            part(Lineas; "Intercambio x Empresa lp")
            {
                SubpageLink = "Código Intercambio" = FIELD("No."),
                "Date Filter" = FIELD("Date Filter");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Acci&ones")
            {

                action("&Ver Clientes/Provee x Empresa")
                {
                    ApplicationArea = All;
                    Image = Find;
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
                    Image = Copy;
                    ShortCutKey = F6;
                    trigger OnAction()
                    VAR
                        Customer: Record Customer;
                    BEGIN
                        if Page.RUNMODAL(0, Customer) = ACTION::LookupOK THEN BEGIN
                            //"No.":=Customer."No.";
                            if Rec."No." = '' THEN Rec.INSERT(TRUE);
                            //  "Search Name":=Customer."Search Name";
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
                action("&Calcular")
                {
                    ApplicationArea = All;
                    Image = Calculate;
                    ShortCutKey = F9;
                    //CaptionML=ESP=Calcular;
                    trigger OnAction()
                    BEGIN
                        CurrPage.Lineas.Page.FiltroFecha(Rec.GETRANGEMIN("Date Filter"), Rec.GETRANGEMAX("Date Filter"));
                        CurrPage.Lineas.Page.Calcular(Rec."No.", true);
                    END;

                }
                action("&Calcular solo firmados")
                {
                    ApplicationArea = All;
                    Image = Signature;
                    ShortcutKey = "Shift+F9";
                    trigger OnAction()
                    BEGIN
                        CurrPage.Lineas.Page.FiltroFecha(Rec.GETRANGEMIN("Date Filter"), Rec.GETRANGEMAX("Date Filter"));
                        CurrPage.Lineas.Page.Calcular(Rec."No.", false);
                    END;
                }

            }
        }

    }

    VAR
        CustomizedCalEntry: Record 7603;
        Text001: Label '¿Desea permitir la tolerancia de pago para movimientos pendientes?';
        CustomizedCalendar: Record 7602;
        Text002: Label '¿Confirma que desea eliminar la tolerancia pago de los movimientos actualmente pendientes?';
        rLinComent: Record 97;
        CalendarMgmt: Codeunit 7600;
        PaymentToleranceMgt: Codeunit 426;
        SalesInfoPaneMgt: Codeunit 7171;
        //iCli: Report 7010629;
        MatComent: ARRAY[5] OF Text[80];

    PROCEDURE ActivateFields();
    BEGIN
    END;


    PROCEDURE ObtenerComentarios();
    VAR
        indice: Integer;
    BEGIN
    END;


}
