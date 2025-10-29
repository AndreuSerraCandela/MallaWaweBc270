/// <summary>
/// TableExtension Ship-to AddressKuara (ID 80191) extends Record Ship-to Address.
/// </summary>
tableextension 80191 "Ship-to AddressKuara" extends "Ship-to Address"
{

    fields
    {
        field(52051; "Oficina Contable"; TEXT[30]) { ObsoleteState = Removed; }
        field(52052; "Organo Gestor"; TEXT[30]) { ObsoleteState = Removed; }
        field(52053; "Unidad tramitadora"; TEXT[30]) { ObsoleteState = Removed; }
        field(60016; "E-Mail Efactura"; Text[80]) { ObsoleteState = Removed; }
        field(60018; "E-Mail-Facturación"; Text[200])
        {

            Caption = 'Correo Facturación';

        }
    }
}