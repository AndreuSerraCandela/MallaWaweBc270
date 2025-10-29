/// <summary>
/// TableExtension Dimension ValueKuara (ID 80223) extends Record Dimension Value.
/// </summary>
tableextension 80224 "Dimension Kuara" extends "Dimension"
{
    fields
    {
        field(50001; "Agrupacion"; CODE[10]) { TableRelation = Dimension; }
        field(50002; "Permite"; Boolean) { }
    }
    trigger OnAfterInsert()
    var
        Company: Record Company;
        DimVal: Record "Dimension";

    begin
        if Company.FindFirst() Then begin
            if Company.Name <> CompanyName Then
                repeat
                    If Control.Permiso_Empresas(Company.Name) Then begin
                        DimVal.ChangeCompany(Company.Name);
                        if DimVal.get(Rec."Code") Then DimVal.Delete();
                        DimVal := Rec;
                        if DimVal.Insert Then;
                    end;
                Until Company.Next() = 0;
        end;
    end;

    trigger OnAfterModify()
    var
        Company: Record Company;
        DimVal: Record "Dimension";
    begin
        if Company.FindFirst() Then begin
            if Company.Name <> CompanyName Then
                repeat
                    If Control.Permiso_Empresas(Company.Name) Then begin
                        DimVal.ChangeCompany(Company.Name);
                        if DimVal.get(Rec.Code) Then DimVal.Delete();
                        DimVal := Rec;
                        if DimVal.Insert Then;
                    end;
                Until Company.Next() = 0;
        end;
    end;

    trigger OnAfterDelete()
    var
        Company: Record Company;
        DimVal: Record "Dimension";
    begin
        if Company.FindFirst() Then begin
            if Company.Name <> CompanyName Then
                repeat
                    If Control.Permiso_Empresas(Company.Name) Then begin
                        DimVal.ChangeCompany(Company.Name);
                        if DimVal.get(Rec.Code) Then DimVal.Delete();
                    end;
                Until Company.Next() = 0;
        end;
    end;

    var
        Control: Codeunit ControlProcesos;
}
