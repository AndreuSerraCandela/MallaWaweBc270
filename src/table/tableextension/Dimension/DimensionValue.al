/// <summary>
/// TableExtension Dimension ValueKuara (ID 80223) extends Record Dimension Value.
/// </summary>
tableextension 80223 "Dimension ValueKuara" extends "Dimension Value"
{
    fields
    {
        field(50001; "Gen. Prod. Posting Group"; CODE[10]) { TableRelation = "Gen. Product Posting Group"; }
        field(50002; "Permite"; Boolean) { }
        field(50003; Agrupacion; Code[20])
        {
            TableRelation = "Dimension Value";
            ValidateTableRelation=false;
            trigger OnLookup()
            var
                DimVal: Record "Dimension Value";
                Dim: Record "Dimension";
            begin
                Dim.Get(Rec."Dimension Code");
                DimVal.SETRANGE("Dimension Code", dim.Agrupacion);
                If Page.RunModal(0, DimVal) = ACTION::LookupOK Then
                    Rec.Agrupacion := DimVal.Code;
            end;
        }
    }
    trigger OnAfterInsert()
    var
        Company: Record Company;
        DimVal: Record "Dimension Value";

    begin
        if Company.FindFirst() Then begin
            if Company.Name <> CompanyName Then
                repeat
                    If Control.Permiso_Empresas(Company.Name) Then begin
                        DimVal.ChangeCompany(Company.Name);
                        if DimVal.get(Rec."Dimension Code", Rec.Code) Then DimVal.Delete();
                        DimVal := Rec;
                        if DimVal.Insert Then;
                    end;
                Until Company.Next() = 0;
        end;
    end;

    trigger OnAfterModify()
    var
        Company: Record Company;
        DimVal: Record "Dimension Value";
    begin
        if Company.FindFirst() Then begin
            if Company.Name <> CompanyName Then
                repeat
                    If Control.Permiso_Empresas(Company.Name) Then begin
                        DimVal.ChangeCompany(Company.Name);
                        if DimVal.get(Rec."Dimension Code", Rec.Code) Then DimVal.Delete();
                        DimVal := Rec;
                        if DimVal.Insert Then;
                    end;
                Until Company.Next() = 0;
        end;
    end;

    trigger OnAfterDelete()
    var
        Company: Record Company;
        DimVal: Record "Dimension Value";
    begin
        if Company.FindFirst() Then begin
            if Company.Name <> CompanyName Then
                repeat
                    If Control.Permiso_Empresas(Company.Name) Then begin
                        DimVal.ChangeCompany(Company.Name);
                        if DimVal.get(Rec."Dimension Code", Rec.Code) Then DimVal.Delete();
                    end;
                Until Company.Next() = 0;
        end;
    end;

    var
        Control: Codeunit ControlProcesos;
}
