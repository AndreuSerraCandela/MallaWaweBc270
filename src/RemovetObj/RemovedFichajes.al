/// <summary>
/// Table Fichajes (ID 7001152).
/// </summary>
table 80152 Fichajes
{
    ObsoleteState = Removed;

    DataClassification = ToBeClassified;

    fields
    {
        field(1; Empleado; Code[50])
        {
            Caption = 'Empleado';
            DataClassification = ToBeClassified;
        }
        field(2; Fecha; DateTime)
        {
            Caption = 'Fecha';
            DataClassification = ToBeClassified;
        }
        field(3; Entrada; Option)
        {
            Caption = 'Entrada';
            DataClassification = ToBeClassified;
            OptionMembers = Entrada,Salida;
        }
        field(4; evento; Text[20])
        {

        }
        field(5; device; Text[20])
        {

        }
        field(6; utc; Text[20])
        {

        }
        field(7; latitude; Text[20])
        {

        }
        field(8; longitude; Text[20])
        {

        }
        field(9; closed; Boolean)
        {

        }
    }
    keys
    {
        key(PK; Empleado, Fecha)
        {
            Clustered = true;
        }
    }
}
table 7001153 Punches
{
    DataPerCompany = false;
    Caption = 'Fichajes';
    LookupPageId = Fichajes;
    DrillDownPageId = Fichajes;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Empleado; Code[50])
        {
            Caption = 'Empleado';
            DataClassification = ToBeClassified;
        }
        field(2; Fecha; DateTime)
        {
            Caption = 'Fecha';
            DataClassification = ToBeClassified;
        }
        field(3; Entrada; Option)
        {
            Caption = 'Entrada';
            DataClassification = ToBeClassified;
            OptionMembers = Entrada,Salida;
        }
        field(4; evento; Text[30])
        {

        }
        field(5; device; Text[20])
        {

        }
        field(6; utc; Text[20])
        {

        }
        field(7; latitude; Text[20])
        {

        }
        field(8; longitude; Text[20])
        {

        }
        field(9; closed; Boolean)
        {

        }
        field(10; Ventas; Decimal)
        {

        }
    }
    keys
    {
        key(PK; Empleado, Fecha)
        {
            Clustered = true;
        }
    }
}
