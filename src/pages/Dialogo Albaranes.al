/// <summary>
/// Page Dialogo Albaranes (ID 50007).
/// </summary>
page 50204 "Dialogo Albaranes"
{

    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            Field(Albaranes; Albaranes)
            {
                ApplicationArea = ALL;
                Caption = 'Cuantos albaranes quiere';
            }

            Field(Distancia; Distancia)
            {
                ApplicationArea = ALL;
                Caption = 'Con que distancia';
            }

            Field(Inicio; Inicio)
            {
                ApplicationArea = ALL;
                Caption = 'Arrancando desde';
            }
        }
    }
    VAR
        Albaranes: Integer;
        Distancia: DateFormula;
        Inicio: Date;

    PROCEDURE SetCampos(pAlbaranes: Integer; pDistancia: DateFormula; pInicio: Date);
    BEGIN
        // Setter method to initialize the Date and Time fields on the page
        Albaranes := pAlbaranes;
        Distancia := pDistancia;
        Inicio := pInicio;
    END;

    PROCEDURE GetCampos(VAR pAlbaranes: Integer; VAR pDistancia: DateFormula; VAR pInicio: Date);
    BEGIN
        // Getter method for the entered datatime value
        pAlbaranes := Albaranes;
        pDistancia := Distancia;
        pInicio := Inicio;
    END;

}
