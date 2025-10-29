/// <summary>
/// TableExtension SalesCue (ID 80117) extends Record Sales Cue.
/// </summary>
tableextension 80117 SalesCue extends "Sales Cue"
{
    fields
    {
        field(50000; "Contratos Pendientes Firma"; Integer)
        {
            Caption = 'Contratos Pendientes Firma';

            CalcFormula = Count("Sales Header" WHERE("Document Type" = const(Order),
                                                      Estado = const("Pendiente de Firma"),
                                                      "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                      ));
            Editable = false;

            FieldClass = FlowField;
        }
        field(50001; "Contratos Firmados"; Integer)
        {
            Caption = 'Contratos Firmados';
            CalcFormula = Count("Sales Header" WHERE("Document Type" = const(Order),
                                                      Estado = const("Firmado"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                      ));

            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Contratos Sin Montar"; Integer)
        {
            Caption = 'Contratos Sin Montar';
            CalcFormula = Count("Sales Header" WHERE("Document Type" = const(Order),
                                                      Estado = const("Sin Montar"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                      ));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Contratos Cancelados"; Integer)
        {
            Caption = 'Contratos Cancelados';
            CalcFormula = Count("Sales Header" WHERE("Document Type" = const(Order),
                                                      Estado = const("Cancelado"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                      ));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Contratos Anulados"; Integer)
        {
            Caption = 'Contratos Anulados';
            CalcFormula = Count("Sales Header" WHERE("Document Type" = const(Order),
                                                      Estado = const("Anulado"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                      ));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Facturas Pendientes"; Integer)
        {
            Caption = 'Facturas Pendientes';
            CalcFormula = Count("Sales Header" WHERE("Document Type" = const(Invoice)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Abonos Pendientes"; Integer)
        {
            Caption = 'Abonos Pendientes';
            CalcFormula = Count("Sales Header" WHERE("Document Type" = const("Credit Memo")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Sin Facturar"; Integer)
        {
            Caption = 'Contratos Firmados';
            CalcFormula = Count("Sales Header" WHERE("Document Type" = const(Order),
                                                      Estado = filter(Firmado | "Sin Montar"),
                                                      "Facturacion Iniciada" = const(false), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                      ));

            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Contratos Modificados"; Integer)
        {
            Caption = 'Contratos Modificados';
            CalcFormula = Count("Sales Header" WHERE("Document Type" = const(Order),
                                                      Estado = const("Modificado"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                      ));

            Editable = false;
            FieldClass = FlowField;
        }
        field(51001; "Pending"; Integer)
        {
            Caption = 'Pendiente Gerencia';
            CalcFormula = Count("Sales Header" WHERE("Document Type" = const(Order),
                                                      "Estado Firma Electrónica" = const("Pending"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter"),
                                                      "Enviado a Dirección" = const(true)
                                                      ));

            Editable = false;
            FieldClass = FlowField;
        }
        field(51002; "Own Signed"; Integer)
        {
            Caption = 'Firmado Malla';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" WHERE("Document Type" = const(Order),
                                                      "Estado Firma Electrónica" = const("Own Signed"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter"),
                                                      "Enviado a Dirección" = const(true)
                                                      ));
        }
        field(51003; "Own Rejected"; Integer)
        {
            Caption = 'Rechazado Malla';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" WHERE("Document Type" = const(Order),
                                                      "Estado Firma Electrónica" = const("Own Rejected"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                      ));
        }
        field(51004; "Customer Signed"; Integer)
        {
            Caption = 'Firmado Contrato';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                    "Estado Firma Electrónica" = const("Customer Signed"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                    ));
        }
        field(51005; "Customer Rejected"; Integer)
        {
            Caption = 'Rechazado Cliente';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                    "Estado Firma Electrónica" = const("Customer Rejected"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                    ));
        }
        //El resatno de estados no se muestran en el cuadro de mando
        field(51006; "Sepa Signed"; Integer)
        {
            Caption = 'Firmado Sepa';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                    "Estado Firma Electrónica" = const("Sepa Rejected"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")

                                                    ));
        }
        //Rechazado Sepa
        field(51007; "Sepa Rejected"; Integer)
        {
            Caption = 'Rechazado Sepa';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                    "Estado Firma Electrónica" = const("Sepa Rejected"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter"),
                                                    "Enviado a Dirección" = const(true)
                                                    ));
        }
        //Sepa & Contract Signed
        field(51008; "Sepa & Contract Signed"; Integer)
        {
            Caption = 'Firmado Sepa y Contrato';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                    "Estado Firma Electrónica" = const("Sepa & Contract Signed"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                    ));
        }
        //Sepa Pending & Contract Signed
        field(51009; "Sepa Pending & Contrat Signed"; Integer)
        {
            Caption = 'Firmado Contrato y Sepa Pendiente';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                    "Estado Firma Electrónica" = const("Sepa Pending & Contract Signed"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                    ));
        }
        //Sepa Pending
        field(51010; "Sepa Pending"; Integer)
        {
            Caption = 'Sepa Pendiente';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                    "Estado Firma Electrónica" = const("Sepa Pending"), "Posting Date" = field("Date Filter"), "SalesPerson Code" = field("SalesPerson Filter")
                                                    ));
        }
        field(52000; "SalesPerson Filter"; Code[20])
        {
            Caption = 'Filtro Vendedor';
            Editable = false;
            FieldClass = FlowFilter;

        }
    }
    /// <summary>
    /// ShowContratos.
    /// </summary>
    /// <param name="FieldNumber">Integer.</param>
    procedure ShowContratos(FieldNumber: Integer)
    var
        SalesHeader: Record "Sales Header";
    begin
        FilterOrders(SalesHeader, FieldNumber);
        PAGE.Run(PAGE::"Lista Contratos Venta", SalesHeader);
    end;

    procedure FilterOrders(var SalesHeader: Record "Sales Header"; FieldNumber: Integer)
    var
        UserSetup: Record "User Setup";
    begin
        If not UserSetup.Get("UserID") then
            UserSetup.Init();
        If UserSetup."Salespers./Purch. Code" <> ' ' then
            Rec.SetRange("SalesPerson Filter", UserSetup."Salespers./Purch. Code");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        Rec.CopyFilter("Date Filter", SalesHeader."Posting Date");

        case FieldNumber of
            FieldNo("Contratos Firmados"):
                begin
                    SalesHeader.SetRange(Estado, SalesHeader.Estado::Firmado);

                end;
            FieldNo("Contratos Sin Montar"):
                begin
                    SalesHeader.SetRange(Estado, SalesHeader.Estado::"Sin Montar");

                end;
            FieldNo("Contratos Cancelados"):
                begin
                    SalesHeader.SetRange(Estado, SalesHeader.Estado::Cancelado);

                end;
            FieldNo("Contratos Anulados"):
                begin
                    SalesHeader.SetRange(Estado, SalesHeader.Estado::Anulado);

                end;
            FieldNo("Contratos Pendientes Firma"):
                begin
                    SalesHeader.SetRange(Estado, SalesHeader.Estado::"Pendiente de Firma");

                end;
            FieldNo(Pending):
                begin
                    SalesHeader.SetRange("Estado Firma Electrónica", SalesHeader."Estado Firma Electrónica"::Pending);
                    SalesHeader.SetRange("Enviado a Dirección", true);
                end;
            FieldNo("Own Signed"):
                begin
                    SalesHeader.SetRange("Estado Firma Electrónica", SalesHeader."Estado Firma Electrónica"::"Own Signed");
                    SalesHeader.SetRange("Enviado a Dirección", true);
                end;
            FieldNo("Own Rejected"):
                begin
                    SalesHeader.SetRange("Estado Firma Electrónica", SalesHeader."Estado Firma Electrónica"::"Own Rejected");
                end;
            FieldNo("Customer Signed"):
                begin
                    SalesHeader.SetRange("Estado Firma Electrónica", SalesHeader."Estado Firma Electrónica"::"Customer Signed");
                end;
            FieldNo("Customer Rejected"):
                begin
                    SalesHeader.SetRange("Estado Firma Electrónica", SalesHeader."Estado Firma Electrónica"::"Customer Rejected");
                end;
            FieldNo("Sepa Signed"):
                begin
                    SalesHeader.SetRange("Estado Firma Electrónica", SalesHeader."Estado Firma Electrónica"::"Sepa Signed");
                end;
            FieldNo("Sepa Rejected"):
                begin
                    SalesHeader.SetRange("Estado Firma Electrónica", SalesHeader."Estado Firma Electrónica"::"Sepa Rejected");
                end;
            FieldNo("Sepa & Contract Signed"):
                begin
                    SalesHeader.SetRange("Estado Firma Electrónica", SalesHeader."Estado Firma Electrónica"::"Sepa & Contract Signed");
                end;
            FieldNo("Sepa Pending & Contrat Signed"):
                begin
                    SalesHeader.SetRange("Estado Firma Electrónica", SalesHeader."Estado Firma Electrónica"::"Sepa Pending & Contract Signed");
                end;
        end;

        FilterGroup(2);
        Rec.CopyFilter("SalesPerson Filter", SalesHeader."Salesperson Code");
        if UserSetup.Get("UserID") Then begin
            SalesHeader.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
        end;
        SalesHeader.SetFilter("Responsibility Center", GetFilter("Responsibility Center Filter"));
        FilterGroup(0);
    end;
}
