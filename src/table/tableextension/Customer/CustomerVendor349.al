/// <summary>
/// TableExtension CustVendor349 (ID 80349) extends Record Customer/Vendor Warning 349.
/// </summary>
tableextension 80349 "CustVendor349" extends "Customer/Vendor Warning 349"
{
    fields
    {
        field(70000; "Texto Error"; Text[250]) { }
        field(70001; "Clave registro"; Code[2]) { }
        field(70002; "Situación inmueble"; Code[10]) { }
        field(70003; "Ref. catastral"; Text[30]) { }
        field(70004; "Document Type"; Enum "Document Type Kuara") { }
    }
}
