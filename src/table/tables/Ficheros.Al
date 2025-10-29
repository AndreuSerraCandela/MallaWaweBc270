/// <summary>
/// Table Ficheros (ID 50002).
/// </summary>
table 50002 Ficheros
{
    fields
    {
        field(1; Secuencia; Integer)
        {

        }
        field(2; "Nombre fichero"; Text[1024])
        {

        }
        field(3; Proceso; Text[250])
        {

        }
        field(4; Procesado; Boolean)
        { }
        field(5; Fichero; Blob)
        { }
        field(6; Factura; Code[20])
        { }
        field(7; Nueva; Boolean)
        {
            InitValue = false;
        }
        field(8; Id; BigInteger)
        {

        }
        field(9; "Fecha Caducidad"; Date)
        {

        }
        field(10; Id_Url; Integer)
        { }

    }
    keys
    {
        key(PK; Secuencia)
        {
            Clustered = true;
        }
    }
}