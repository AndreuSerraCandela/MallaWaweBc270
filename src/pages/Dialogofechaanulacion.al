/// <summary>
/// Page Dialogo fecha anulación (ID 50009).
/// </summary>
page 50206 "Dialogo fecha anulación"
{

    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            Field("Fecha Anulación"; Inicio)
            {
                ApplicationArea = ALL;
                Caption = 'fecha anulación';

            }
            Field("Fecha Fin Reservas"; Ffin)
            {
                ApplicationArea = ALL;
                Caption = 'fecha fecha fin reservas';
                ToolTip = 'si es anulación no la tentrá en cuenta';
            }
        }
    }
    VAR
        Inicio: Date;
        FFin: Date;

    PROCEDURE SetCampos(pInicio: Date; pFin: Date);
    BEGIN
        // Setter method to initialize the Date and Time fields on the page
        Inicio := pInicio;
        Ffin := pFin;

    END;

    PROCEDURE GetCampos(VAR pInicio: Date; var pFin: Date);
    BEGIN
        // Getter method for the entered datatime value
        pInicio := Inicio;
        pFin := FFin
    END;

}