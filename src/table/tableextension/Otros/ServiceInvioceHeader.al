/// <summary>
/// TableExtension Service Invoice HeaderKuara (ID 80300) extends Record Service Invoice Header.
/// </summary>
tableextension 80300 "Service Invoice HeaderKuara" extends "Service Invoice Header"
{
    fields
    {
        field(80000; "Tipo factura SII"; CODE[2]) { }
        field(80001; "Clave registro SII expedidas"; CODE[2]) { }
        field(80006; "Descripción operación"; TEXT[250]) { }
        field(80007; "Tipo factura rectificativa"; CODE[1]) { }
        field(80008; "Reportado SII"; Boolean) { }
        field(80009; "Nombre fichero SII"; TEXT[250]) { }
        field(80010; "Fecha/hora subida fichero SII"; DateTime) { }
        field(80012; "Reportado SII primer semestre"; Boolean) { }
        field(60019; "Nombre Comercial"; Text[250])
        {
            Caption = 'Anunciante';
            TableRelation = "Nombre Comercial".Nombre;
        }

    }
}
