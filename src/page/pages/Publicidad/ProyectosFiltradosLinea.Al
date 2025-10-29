/// <summary>
/// Page Proyectos filtrados por linea (ID 50094).
/// </summary>
page 50094 "Proyectos filtrados por linea"
{
    Caption = 'Proyectos filtrados por linea';
    SourceTable = "Temp Job";
    PageType = List;
    UsageCategory = Lists;
    layout
    {
        area(Content)

        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
            }
            field("Nº Contrato"; "Nº Contrato")
            {
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                VAR
                    rContrato: Record 36;
                BEGIN
                    //$002
                    rContrato.RESET;
                    rContrato.SETRANGE("Document Type", rContrato."Document Type"::Order);
                    rContrato.SETRANGE("No.", "Nº Contrato");
                    if rContrato.FIND('-') THEN
                        PAGE.RUN(page::"Ficha Contrato Venta", rContrato);
                END;
            }
            field("Bill-to Name"; Rec."Bill-to Name")
            {
                ApplicationArea = All;
            }
            field("Cód. divisa"; Rec."Cód. divisa")
            {
                ApplicationArea = All;
            }
            field("Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Job Posting Group"; Rec."Job Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field("Cód. vendedor"; Rec."Cód. vendedor")
            {
                ApplicationArea = All;
            }
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;
            }
            field("Starting Date"; Rec."Starting Date")
            {
                ApplicationArea = All;
            }
            field("Ending Date"; Rec."Ending Date")
            {
                ApplicationArea = All;
            }
            field("Search Description"; Rec."Search Description")
            {
                ApplicationArea = All;
            }
            field("Proyecto original"; Rec."Proyecto original")
            {
                ApplicationArea = All;
            }
            field("Proyecto origen"; Rec."Proyecto origen")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Lista)
            {
                Image = List;
                ApplicationArea = All;
                RunObject = page "Job List";

            }
        }
    }
    VAR
        "Nº Contrato": Code[20];

    trigger OnAfterGetRecord()
    BEGIN
        TraeNumContrato;
    END;

    PROCEDURE TraeNumContrato();
    VAR
        rContrato: Record 36;
    BEGIN
        //$002
        rContrato.RESET;
        rContrato.SETCURRENTKEY("Nº Proyecto");
        rContrato.SETRANGE("Document Type", rContrato."Document Type"::Order);
        rContrato.SETRANGE("Nº Proyecto", Rec."No.");
        if rContrato.FIND('-') THEN BEGIN
            "Nº Contrato" := rContrato."No.";
        END
        ELSE BEGIN
            "Nº Contrato" := '';
        END;
    END;


}