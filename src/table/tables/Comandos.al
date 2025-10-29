/// <summary>
/// Table Comandos (ID 50004).
/// </summary>
table 50004 Comandos
{
    Caption = 'Comandos';
    DataClassification = ToBeClassified;
    DataPerCompany = false;
    fields
    {
        field(1; Id; Guid)
        {
            Caption = 'Id';
            DataClassification = ToBeClassified;
        }
        field(2; Empresa; Text[30])
        {
            Caption = 'Empresa';
            DataClassification = ToBeClassified;
        }
        field(3; Comando; Text[30])
        {
            Caption = 'Comando';
            DataClassification = ToBeClassified;
        }
        field(4; Procesado; Boolean)
        {

        }
        field(5; Fecha; DateTime)
        { }
        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }

    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }
}
