/// <summary>
/// Table Sii Mensages (ID 7001176).
/// </summary>
table 7001176 "Sii Mensages"
{
    fields
    {
        field(1; "Tipo"; Text[2]) { }
        field(2; "Documento"; Text[30]) { }
        field(3; "Estado"; Text[3]) { }
        field(4; "Cif"; Text[30]) { }
        field(5; "TextoError"; Text[250]) { }
        field(6; "Procesado"; Boolean) { }
        field(7; "Num Doc"; Code[20]) { }
        field(8; "Contador"; Integer) { }
        field(9; "Mensaje"; Text[250])
        {
            trigger OnLookup()
            VAR
                r98: Record "General Ledger Setup";
                nombre: Text[1024];
                C: Label '''';
            BEGIN
                r98.GET();
                nombre := r98."Ruta fichero SII" + '\sended' + COPYSTR(Mensaje, STRLEN(r98."Ruta fichero SII IN") + 1, 250);
                nombre := C + COPYSTR(nombre, 1, STRLEN(nombre) - 9) + '.txt' + C;
                // SHELL('C:\windows\system32\notepad.exe ', nombre);
            END;
        }
    }
    KEYS
    {
        key(P; Contador, Tipo, Documento, Cif) { Clustered = true; }
    }
}

