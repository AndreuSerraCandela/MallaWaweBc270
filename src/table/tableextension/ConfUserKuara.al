/// <summary>
/// TableExtension ConfUserKuara (ID 80133) extends Record User Setup.
/// </summary>
tableextension 80133 ConfUserKuara extends "User Setup"
{
    fields
    {
        // // Add changes to table fields here
        // field(80100; URL; Text[250])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(80101; UserKuara; Text[250])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(80102; PassKuara; Text[250])
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(50000; "Autoriz. modif. prohibiciones"; Boolean) { }//		FCL-17/05/04
        field(50001; "Filtro vendedor"; Text[100]) { TableRelation = "Salesperson/Purchaser"; ValidateTableRelation = false; }//	$001
        field(50002; "Filtro departamento"; Text[100])
        {
            TableRelation = "Dimension Value"."Code" WHERE("Dimension Code" = CONST('DEPARTAMENTO'));
        }
        field(50003; "Nombre certif. firma Efactura"; Text[250]) { }
        field(50007; "Certificado firma Efactura"; Blob)
        { }
        field(50006; "Password certificado digital"; Text[30]) { }
        field(50004; "Documento"; Code[20]) { }
        field(50005; Code20; Code[20]) { }
        field(50008; "TM Certificado firma Efactura"; MediaSet)
        { }
        field(50009; EsquemaCuentas; Text[30]) { }
        field(50010; FiltroFechas; Text[50]) { }
        field(50011; "Cliente"; Text[100]) { TableRelation = "Customer"; ValidateTableRelation = false; }
        field(50012; "Tipo Informe"; Option) { OptionMembers = Disponibilidad,Presentación; }
        field(50013; "Precios"; Boolean) { }
        field(50014; "Prohibiciones"; Boolean) { }
        field(50015; "Tipo Cliente"; Option) { OptionMembers = Agencia,Local; }

        field(50017; "Tipo Precios"; Option) { OptionMembers = "anual y Temporada","solo anual"; }
        field(50018; "Calidad"; Option) { OptionMembers = Alta,Baja; }
        field(50019; "Comercial"; Text[100]) { TableRelation = "Salesperson/Purchaser"; ValidateTableRelation = false; }//	$001
        field(80013; "username gotimecloud"; text[250])
        {
            ObsoleteState = Removed;
            Description = '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918';
        }
        field(80014; "password gotimecloud"; text[250])
        {
            ObsoleteState = Removed;
            Description = '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918malla';
            ExtendedDatatype = Masked;
        }
        field(80015; "employee gotimecloud"; Text[30])
        {
            ObsoleteState = Removed;
            Description = '000000050';
        }
        field(80016; "Mostrar Ibiza Publicidad"; Boolean)
        {

        }
        field(80017; "Mostrar Malla Publicidad"; Boolean)
        {

        }
        field(80018; "Mostrar Menorca Publicidad"; Boolean)
        {

        }
        field(80019; "Mostrar Grepsa"; Boolean)
        {

        }
        field(80020; "ShowDialog"; Boolean)
        {

        }
        field(80021; "Empresa Facturas"; Text[30]) { }
        // field(92100; "URL Ocr"; Text[250])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(92101; "User Ocr"; Text[250])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(92102; "Pass Ocr"; Text[250])
        // {
        //     DataClassification = ToBeClassified;
        // }



    }

    var
        myInt: Integer;
}