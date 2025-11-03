/// <summary>
/// Page Petición datos Pagaré (ID 50034).
/// </summary>
page 50034 "Petición datos Pagaré"
{
    PageType = StandardDialog;
    layout
    {
        area(Content)
        {
            Field("Nº Pagos"; Pagos)
            {
                ApplicationArea = ALL;
                Caption = 'Nº Pagos';

            }

        }
    }

    VAR
        Pagos: Integer;

    PROCEDURE Recoge_Pag(): Integer;
    BEGIN
        exit(Pagos)

    END;
}