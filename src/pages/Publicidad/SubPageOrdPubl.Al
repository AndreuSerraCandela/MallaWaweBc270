/// <summary>
/// Page SubPage orden de publicidad (ID 50088).
/// </summary>
page 50243 "SubPage orden de publicidad"
{
    PageType = ListPart;
    SourceTable = "Lin. orden publicidad";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {

                field("Fecha Inicio"; Rec."Fecha inicio")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    BEGIN
                        if (Rec."Fecha inicio" <> 0D) And (Rec."Fecha fin" <> 0D) THEN
                            Rec.Inserciones := Rec."Fecha fin" - Rec."Fecha inicio" + 1
                        ELSE
                            Rec.Inserciones := 0;
                    END;
                }
                field("Fecha Fin"; Rec."Fecha Fin")
                {
                    ApplicationArea = all;
                    Editable = False;
                    trigger OnValidate()
                    BEGIN
                        if (Rec."Fecha fin" <> 0D) And (Rec."Fecha inicio" <> 0D) THEN
                            Rec.Inserciones := Rec."Fecha fin" - Rec."Fecha inicio" + 1
                        ELSE
                            Rec.Inserciones := 0;
                    END;
                }
                field(Inserciones; Rec.Inserciones)
                {
                    ApplicationArea = all;
                    Editable = False;
                    Visible = InsercionesVISIBLE;
                }
                field("Dia Tarifa"; Rec."Dia tarifa")
                {
                    ApplicationArea = all;
                    Editable = False;
                    Visible = DiatarifaVISIBLE;
                }
                field(Precio; Rec.Precio)
                {
                    ApplicationArea = all;
                    Editable = False;
                    Visible = PrecioVISIBLE;
                }
                field("Cuñas"; Rec.Inserciones) { ApplicationArea = all; Editable = CuñasEDITABLE; Visible = CuñasVISIBLE; }
                field("Precio Radio"; Rec.Precio)
                {
                    ApplicationArea = all;
                    Visible = PrecioRadioVISIBLE;
                }
                field("Tiempo extra"; Rec."Tiempo extra") { ApplicationArea = all; }
                field("Precio Extra"; Rec."Precio Extra") { ApplicationArea = all; Visible = False; }
                field(Spots; Rec.Inserciones)
                {
                    ApplicationArea = all;
                    Visible = SpotsVISIBLE;
                    Editable = False;
                }
                field("Precio Spot"; Rec.Precio)
                {
                    ApplicationArea = all;
                    Visible = PreciospotVISIBLE;
                }
                field(Importe; Rec.Importe) { ApplicationArea = all; Editable = False; }
                field(Facturada; Rec.Facturada) { ApplicationArea = all; Editable = False; }
                field(Factura; Rec.Factura) { ApplicationArea = All; Editable = False; }
                field(Observaciones; Rec.Observaciones) { }
            }
        }
    }
    var
        InsercionesVISIBLE: Boolean;
        DiatarifaVISIBLE: Boolean;
        PrecioVISIBLE: Boolean;
        CuñasVISIBLE: Boolean;
        PrecioRadioVISIBLE: Boolean;
        CuñasEDITABLE: Boolean;
        SpotsVISIBLE: Boolean;
        PreciospotVISIBLE: Boolean;

    PROCEDURE Actualizar();
    BEGIN

        CurrPage.UPDATE(FALSE);
    END;

    PROCEDURE ActualizarControles(pTipoOrden: Option Prensa,Radio,Cine);
    BEGIN

        InsercionesVISIBLE := pTipoOrden = pTipoOrden::Prensa;
        DiatarifaVISIBLE := pTipoOrden = pTipoOrden::Prensa;
        PrecioVISIBLE := pTipoOrden = pTipoOrden::Prensa;

        CuñasVISIBLE := pTipoOrden = pTipoOrden::Radio;
        PrecioRadioVISIBLE := pTipoOrden = pTipoOrden::Radio;
        // $002
        CuñasEDITABLE := pTipoOrden = pTipoOrden::Radio;
        //-001
        //+001

        SpotsVISIBLE := pTipoOrden = pTipoOrden::Cine;
        PreciospotVISIBLE := pTipoOrden = pTipoOrden::Cine;
    END;
}