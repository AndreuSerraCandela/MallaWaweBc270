/// <summary>
/// Page Petición Datos Agrupación (ID 50033).
/// </summary>
page 50033 "Petición Datos Agrupación"
{
    PageType = StandardDialog;
    layout
    {
        area(Content)
        {
            Field(Descripcion; Descripcion)
            {
                ApplicationArea = ALL;
                Caption = 'Descripción';

            }

        }
    }

    VAR
        Descripcion: Text;

    PROCEDURE Recoge_Des(VAR Des: text);
    BEGIN
        Des := Descripcion;

    END;
    /* 
        BEGIN
        {
          $001 FCL-22/03/10. Incluyo fecha registro
        }
        END.
      } */
}
