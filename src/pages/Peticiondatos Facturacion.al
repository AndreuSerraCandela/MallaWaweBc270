/// <summary>
/// Page Petición datos Facturación (ID 50010).
/// </summary>
page 50207 "Petición datos Facturación"
{
    PageType = StandardDialog;
    layout
    {
        area(Content)
        {
            Field("Fecha Inicial"; fechai)
            {
                ApplicationArea = ALL;
                Caption = 'fecha inicial';

            }
            Field("Fecha Final"; fechaf)
            {
                ApplicationArea = ALL;
                Caption = 'fecha final';

            }
            Field("Fecha Registro"; fechaReg)
            {
                ApplicationArea = ALL;
                Caption = 'fecha registro';

            }
        }
    }

    VAR
        fechaI: Date;
        fechaF: Date;
        fechaReg: Date;

    PROCEDURE Recoge_Fechas(VAR fI: Date; VAR fF: Date; VAR fReg: Date);
    BEGIN
        fI := fechaI;
        fF := fechaF;
        fReg := fechaReg;
    END;
    /* 
        BEGIN
        {
          $001 FCL-22/03/10. Incluyo fecha registro
        }
        END.
      } */
}
