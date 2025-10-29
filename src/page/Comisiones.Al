/// <summary>
/// Page Comisiones Vendedor/Programa (ID 7001123).
/// </summary>
page 7001123 "Comisiones Vendedor/Programa"
{
    //Version List=MLL1.00;
    //area(Content){ Repeater(Detalle){ID=1;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Comision vendedor/programa";
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {

                field("Cód. Vendedor"; Rec."Cód. Vendedor") { ApplicationArea = All; }
                field("Cód. Principal"; Rec."Cód. Principal") { ApplicationArea = All; }
                field(Dimension3; Dimension(3)) { ApplicationArea = All; Caption = 'Principal'; }

                field("Cód. Programa"; Rec."Cód. Programa") { ApplicationArea = All; }
                field(Dimension2; Dimension(2)) { ApplicationArea = All; Caption = 'Programa'; }

                field("% comisión"; Rec."% comisión") { ApplicationArea = All; }
            }
        }
    }
    PROCEDURE Dimension(Dim: Integer): Text[50];
    VAR
        r349: Record 349;
    BEGIN
        r349.SETRANGE(r349."Global Dimension No.", Dim);
        CASE Dim OF
            2:
                r349.SETRANGE(r349.Code, Rec."Cód. Programa");
            3:
                r349.SETRANGE(r349.Code, Rec."Cód. Principal");
        END;
        if r349.FINDFIRST THEN EXIT(r349.Name);
    END;

}