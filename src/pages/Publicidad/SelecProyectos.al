
/// <summary>
/// Page Sel. proyectos a traspasar (ID 50081).
/// </summary>
page 50237 "Sel. proyectos a traspasar"
{
    //Version List=MLL;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    Caption = 'Seleccionar proyectos a traspasar';
    AdditionalSearchTerms = 'Sel.presupuestos a traspasar';
    //area(Content){ Repeater(Detalle){ID=1;
    SourceTable = 167;
    SourceTableView = SORTING("No.")
                    WHERE(Status = CONST(Quote),
                          "Proyecto en empresa Origen" = FILTER(<> ''));
    layout
    {
        area(Content)
        {
            Repeater(Detalle)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Description"; Rec.Description) { ApplicationArea = All; }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.") { ApplicationArea = All; }
                field("Bill-to Name"; Rec."Bill-to Name") { ApplicationArea = All; }
                field("Proyecto en empresa Origen"; Rec."Proyecto en empresa Origen") { ApplicationArea = All; }
                field("Empresa Origen"; Rec."Empresa Origen") { ApplicationArea = All; }
                field("Creation Date"; Rec."Creation Date") { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            group("Acci&ones")
            {
                Caption = 'Acci&ones';
                action("Crear presupuestos")
                {
                    Caption = 'Crear presupuestos';
                    trigger OnAction()
                    BEGIN
                        if NOT CONFIRM(Text001) THEN
                            ERROR(Text002);
                        CurrPage.SETSELECTIONFILTER(rCabVenta);
                        if rCabVenta.FINDFIRST THEN BEGIN
                            REPEAT
                                rCabVenta.VALIDATE(rCabVenta."Bill-to Customer No.");
                                rCabVenta.Status := rCabVenta.Status::Planning;
                                rCabVenta.MODIFY;
                            UNTIL rCabVenta.NEXT = 0;
                        END;
                    END;
                }
            }
        }
    }
    VAR
        Text001: Label '¿Confirma que desea generar presupuesto para cada una de los presupuestos seleccionadas?';
        Text002: Label 'Proceso cancelado a petición del usuario';
        rCabVenta: Record 167;
        wLinea: Integer;

}