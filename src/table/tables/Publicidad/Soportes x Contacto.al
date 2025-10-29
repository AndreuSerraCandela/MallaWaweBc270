/// <summary>
/// Table Soportes x Contacto (ID 50005).
/// </summary>
table 50005 "Soportes x Contacto"
{
    Caption = 'Soportes x Contrato';

    fields
    {
        field(1; Contacto; Code[20])
        {
            TableRelation = Contact;
            DataClassification = ToBeClassified;
        }
        field(2; Soporte; Code[20])
        {
            TableRelation = Resource;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        Key(PrimaryKey; Contacto, Soporte)
        {
            Clustered = true;
        }
    }

}