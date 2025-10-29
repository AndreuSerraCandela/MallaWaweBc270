
/// <summary>
/// TableExtension Resource CostKuara (ID 80185) extends Record Resource Cost.
/// </summary>
#pragma warning disable AL0432
tableextension 80185 "Resource CostKuara" extends "Resource Cost"
#pragma warning restore AL0432

{
    fields
    {
        modify("Work Type Code")
        {

            Caption = 'Dia tarifa';
            trigger OnAfterValidate()
            begin
                Rec."Dia tarifa" := Rec."Work Type Code";
            end;

            trigger OnBeforeValidate()
            var
                wType: Record "Work Type";
            begin
                if not wType.Get("Work Type Code") then begin
                    wType.Init();
                    wType.Code := "Work Type Code";
                    wType.Insert();
                end;
            end;

        }
        field(50000; "Dia tarifa"; CODE[10])
        {

        }
        field(50001; "Seccion"; CODE[20]) { }
        field(50002; "Vendor No."; CODE[20]) { TableRelation = Vendor; }
        field(50003; "Currency Code"; CODE[10]) { TableRelation = Currency; }
        field(50004; "Starting Date"; Date) { }
        field(50015; "Ending Date"; Date) { }
        field(54016; "Dest. Type"; Enum "Dest. Type") { }
        field(54017; "Dest. Code"; CODE[20])
        {
            ValidateTableRelation = false;
            TableRelation = if ("Dest. Type" = CONST(Resource)) Resource
            ELSE
            if ("Dest. Type" = CONST("Group(Resource)")) "Resource Group";
        }
    }
}

