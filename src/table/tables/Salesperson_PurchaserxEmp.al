/// <summary>
/// Table Salesperson/PurchaserxEmp (ID 7001113).
/// </summary>
table 7001113 "Salesperson/PurchaserxEmp"
{
    DataPerCompany = false;
    ;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Código';
            NotBlank = true;
        }
        field(2; "Name"; Text[50]) { Caption = 'Nommbre'; }
        field(50002; "Nº Común"; Code[10]) { }
        field(50003; Empresa; Text[30]) { }
        field(50004; Eliminar; Text[30]) { }
    }
    KEYS
    {
        Key(P; Code, "Nº Común", Empresa) { Clustered = true; }
        Key(N; "Nº Común") { }
    }
    VAR
        DimMgt: Codeunit 408;

    trigger OnDelete()
    VAR
        TeamSalesperson: Record 5084;
    BEGIN
    END;

    PROCEDURE CreateInteraction();
    VAR
        SegmentLine: Record 5077 temporary;
    BEGIN
    END;

    PROCEDURE ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]);
    BEGIN
    END;


}
