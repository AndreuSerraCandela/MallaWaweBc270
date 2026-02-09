/// <summary>
/// Page Dialogo fecha contrato (ID 50008).
/// </summary>
page 50205 "Dialogo fecha contrato"
{

    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            Field("Inicio Contrato"; Inicio)
            {
                ApplicationArea = ALL;
                Caption = 'fecha inicio contrato';
            }
        }
    }
    VAR
        Inicio: Date;

    PROCEDURE SetCampos(pInicio: Date);
    BEGIN
        // Setter method to initialize the Date and Time fields on the page
        Inicio := pInicio;
    END;

    PROCEDURE GetCampos(VAR pInicio: Date);
    BEGIN
        // Getter method for the entered datatime value
        pInicio := Inicio;
    END;

}

