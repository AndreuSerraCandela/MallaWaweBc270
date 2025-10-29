/// <summary>
/// TableExtension Service Cr.Memo HeaderKuara (ID 80301) extends Record Service Cr.Memo Header.
/// </summary>
tableextension 80301 "Service Cr.Memo HeaderKuara" extends "Service Cr.Memo Header"
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
