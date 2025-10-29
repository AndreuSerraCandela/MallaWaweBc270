/// <summary>
/// Table Temp Job (ID 7001141).
/// </summary>
table 7001141 "Temp Job"
{
    DataCaptionfields = "No.", Description;

    Caption = 'Temporal Proyecto';

    fields
    {
        field(1; "No."; Code[20])
        {        //;AltSearchField=Search Description;
            trigger OnLookup()
            BEGIN

                if rProyecto.GET("No.") THEN BEGIN
                    Page.RUN(88, rProyecto);
                END;
            END;
        }
        field(2; "Search Description"; Code[50]) { }
        field(3; "Description"; Text[50]) { }
        field(4; "Description 2"; Text[50]) { }
        field(5; "Bill-to Customer No."; Code[20]) { TableRelation = Customer; }
        field(12; "Creation Date"; Date) { }
        field(13; "Starting Date"; Date) { }
        field(14; "Ending Date"; Date) { }
        field(19; "Status"; Enum "Job Status Kuara")
        {

            trigger OnValidate()
            VAR
                JobPlanningLine: Record 1003;
            BEGIN
            END;

        }
        field(20; "Person Responsible"; Code[20]) { TableRelation = Resource; }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            CaptionClass = '1,1,1';
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            CaptionClass = '1,1,2';
        }
        field(23; "Job Posting Group"; Code[10]) { TableRelation = "Job Posting Group"; }
        field(24; "Blocked"; Enum "Job Blocked")
        {

        }
        field(29; "Last Date Modified"; Date) {; Editable = false; }
        field(30; "Comment"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Job),
                                                                                           "No." = FIELD("No.")));
            Editable = false;
        }
        field(31; "Customer Disc. Group"; Code[10]) { TableRelation = "Customer Discount Group"; }
        field(32; "Customer Price Group"; Code[10]) { TableRelation = "Customer Price Group"; }
        field(41; "Language Code"; Code[10]) { TableRelation = Language; }
        field(49; "Scheduled Res. Qty."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job Planning Line"."Quantity (Base)" WHERE("Job No." = FIELD("No."),
                                                                                                                "Schedule Line" = CONST(true),
                                                                                                                Type = CONST(Resource),
                                                                                                                "No." = FIELD("Resource Filter"),
                                                                                                                "Planning Date" = FIELD("Planning Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50; "Resource Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(51; "Posting Date Filter"; Date) { FieldClass = FlowFilter; }
        field(55; "Resource Gr. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
        field(56; "Scheduled Res. Gr. Qty."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job Planning Line"."Quantity (Base)" WHERE("Job No." = FIELD("No."),
                                                                                                                "Schedule Line" = CONST(true),
                                                                                                                Type = CONST(Resource),
                                                                                                                "Resource Group No." = FIELD("Resource Gr. Filter"),
                                                                                                                "Planning Date" = FIELD("Planning Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(57; "Picture"; BLOB) {; SubType = Bitmap; }
        field(58; "Bill-to Name"; Text[50]) { }
        field(59; "Bill-to Address"; Text[50]) { }
        field(60; "Bill-to Address 2"; Text[50]) { }
        field(61; "Bill-to City"; Text[50]) { }
        field(63; "County"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.County WHERE("No." = FIELD("Bill-to Customer No.")));
            Editable = false;
        }
        field(64; "Bill-to Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            ValidateTableRelation = false;

        }
        field(66; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Editable = false;
        }
        field(67; "Bill-to Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Editable = true;
        }
        field(68; "Bill-to Name 2"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer."Name 2" WHERE("No." = FIELD("Bill-to Customer No.")));
            Editable = false;
        }
        field(1000; "WIP Method"; Code[20])
        {
            Caption = 'WIP Method';
            TableRelation = "Job WIP Method".Code WHERE(Valid = CONST(true));


        }
        field(1001; "Currency Code"; Code[10]) { TableRelation = Currency; }
        field(1002; "Bill-to Contact No."; Code[20]) { }
        field(1003; "Bill-to Contact"; Text[50]) { }
        field(1004; "Planning Date Filter"; Date) { FieldClass = FlowFilter; }
        field(1005; "Total WIP Cost Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job WIP Entry"."WIP Entry Amount" WHERE("Job No." = FIELD("No."),
                                                                                                             "Job Complete" = CONST(false),
                                                                                                             Type = FILTER('Accrued Costs|WIP Costs|Recognized Costs')));
            Editable = false;
            AutoFormatType = 1;
        }
        field(1006; "Total WIP Cost G/L Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job WIP G/L Entry"."WIP Entry Amount" WHERE("Job No." = FIELD("No."),
                                                                                                                 Reversed = CONST(false),
                                                                                                                 "Job Complete" = CONST(false),
                                                                                                                 Type = FILTER('Accrued Costs|WIP Costs|Recognized Costs')));
            Editable = false;
            AutoFormatType = 1;
        }
        field(1007; "WIP Posted To G/L"; Boolean) {; Editable = false; }
        field(1008; "WIP Posting Date"; Date) {; Editable = false; }
        field(1009; "WIP G/L Posting Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Min("Job WIP G/L Entry"."WIP Posting Date" WHERE(Reversed = CONST(false),
                                                                                                                 "Job No." = FIELD("No.")));
            Editable = false;
        }
        // field(1010; "Posted WIP Method Used"; Option)
        // {
        //     ; OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract',
        //                                                             ESP = ' ,Valor coste,Valor venta,Coste ventas,Porcentaje completado,Contrato consumado';
        //     OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        //     Editable = false;
        // }
        field(1011; "Invoice Currency Code"; Code[10]) { TableRelation = Currency; }
        field(1012; "Exch. Calculation (Cost)"; Option)
        {
            OptionCaption = 'DL fijada,Otra divisa fijada';
            OptionMembers = "Fixed LCY","Fixed FCY";
        }
        field(1013; "Exch. Calculation (Price)"; Option)
        {
            OptionCaption = 'DL fijada,Otra divisa fijada';
            OptionMembers = "Fixed FCY","Fixed LCY";
        }
        field(1014; "Allow Schedule/Contract Lines"; Boolean) { }
        field(1015; "Complete"; Boolean) { }
        field(1016; "Calc. WIP Method Used"; Option)
        {
            OptionCaption = ' ,Valor coste,Valor venta,Coste ventas,Porcentaje completado,Contrato consumado';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
            Editable = false;
        }
        field(1017; "Recog. Sales Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job WIP Entry"."WIP Entry Amount" WHERE("Job No." = FIELD("No."),
                                                                                                             Type = FILTER("Recognized Sales")));
            Editable = false;
            AutoFormatType = 1;
        }
        field(1018; "Recog. Sales G/L Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job WIP G/L Entry"."WIP Entry Amount" WHERE("Job No." = FIELD("No."),
                                                                                                                 Type = FILTER("Recognized Sales"),
                                                                                                                 Reversed = CONST(false)));
            Editable = false;
            AutoFormatType = 1;
        }
        field(1019; "Recog. Costs Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("Job WIP Entry"."WIP Entry Amount" WHERE("Job No." = FIELD("No."),
                                                                                                              Type = FILTER("Recognized Costs")));
            Editable = false;
            AutoFormatType = 1;
        }
        field(1020; "Recog. Costs G/L Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("Job WIP G/L Entry"."WIP Entry Amount" WHERE("Job No." = FIELD("No."),
                                                                                                                  Type = FILTER("Recognized Costs"),
                                                                                                                  Reversed = CONST(false)));
            Editable = false;
            AutoFormatType = 1;
        }
        field(1021; "Total WIP Sales Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job WIP Entry"."WIP Entry Amount" WHERE("Job No." = FIELD("No."),
                                                                                                             "Job Complete" = CONST(false),
                                                                                                             Type = FILTER('Accrued Sales|WIP Sales|Recognized Sales')));
            Editable = false;
            AutoFormatType = 1;
        }
        field(1022; "Total WIP Sales G/L Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Job WIP G/L Entry"."WIP Entry Amount" WHERE("Job No." = FIELD("No."),
                                                                                                                 Reversed = CONST(false),
                                                                                                                 "Job Complete" = CONST(false),
                                                                                                                 Type = FILTER('Accrued Sales|WIP Sales|Recognized Sales')));
            Editable = false;
            AutoFormatType = 1;
        }
        field(1023; "Completion Calculated"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Job WIP Entry" WHERE("Job No." = FIELD("No."),
                                                                                            "Job Complete" = FILTER(= true)));
        }
        field(1024; "Next Invoice Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Min("Job Planning Line"."Planning Date" WHERE("Job No." = FIELD("No."),
                                                                                                              "Contract Line" = FILTER(= true)));
        }
        //Invoiced=FILTER(=false)));}
        field(50000; "Tipo"; Enum "Tipo Venta Job") { }
        field(50001; "Cód. vendedor"; Code[10]) { TableRelation = "Salesperson/Purchaser"; }
        field(50005; "Firmado"; Enum "Firmado") { }
        field(50006; "Fecha Firma"; Date) { }
        field(50010; "Nº lineas"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Job Planning Line" WHERE("Job No." = FIELD("No."),
                                                                                                "Line Type" = CONST(Budget)));
        }
        field(50015; "Esperar Orden Cliente"; Boolean) {; InitValue = false; }
        field(50018; "Subtipo"; Enum "Subtipo") { }
        field(50020; "Cód. divisa"; Code[10]) { TableRelation = Currency; }
        field(50025; "Renovado"; Boolean) { }
        field(50041; "Soporte de"; Enum "Soporte de") { }
        field(50042; "Interc./Compens."; Enum "Interc./Compens.")
        {

            Description = 'FCL-18/05/04';
        }
        field(50043; "Proyecto original"; Code[20])
        {
            TableRelation = Job;
            Description = 'Es el proyecto inicial';
        }
        field(50045; "Fija/Papel"; Enum "Fija/Papel")
        {
            Description = '$003';
        }
        field(50087; "Estado Contrato"; Enum "Estado Contrato")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header".Estado WHERE("Document Type" = FILTER(Order),
                                                                                                   "Nº Proyecto" = FIELD("No.")));
            Description = '$002';
            Editable = false;
        }
        field(50088; "Fecha Estado Contrato"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Fecha Estado" WHERE("Document Type" = FILTER(Order),
                                                                                                           "Nº Proyecto" = FIELD("No.")));
            Description = '$002';
            Editable = false;
        }
        field(50089; "Proyecto Antiguo"; Code[10]) {; Description = 'FCL- Campo añadido por ASC'; }
        field(50090; "Proyecto origen"; Code[20])
        {
            TableRelation = Job;
            Description = 'Es el proyecto a partir de el que se ha creado el actual';
        }
        field(50091; "No Documento externo"; Code[20]) { }
        field(50200; "Procesado"; Boolean) {; Description = '$011-Creado para proceso temporal'; }
        field(50201; "Antiguo proyecto original"; Code[20])
        {
            TableRelation = Job;
            Description = '$011-Creado para proceso temporal';
        }
    }
    KEYS
    {
        key(P; "No.") { Clustered = true; }
    }
    VAR
        Text000: Label 'No puede cambiar el %1 porque hay uno o más movimientos asociados con este %2.';
        rProyecto: Record 167;
        Text003: Label 'Debe ejecutar las funciones %1 y %2 para crear y registrar los movimientos completados para este proyecto.';
        Text004: Label 'De esta manera eliminará cualquier movimiento WIP no registrado para este proyecto y podrá revertir los registros completados para este proyecto.\\¿Desea continuar?';
        Text005: Label 'Contacto %1 %2 está relacionado con una empresa diferente al cliente %3.';
        Text006: Label 'Contacto %1 %2 no está relacionado con el cliente %3.';
        Text007: Label 'Contacto %1 %2 no está relacionado con un cliente.';
        Text008: Label 'El %1 %2 no debe estar bloqueado con el tipo %3.';
        Text009: Label 'Debe ejecutar la función %1 para revertir los movimientos completados registrados para este proyecto.';
        Text100: Label 'Ha modificado la fecha inicial del proyecto.\Se van a modificar las fechas del contrato %1.';
        Text101: Label 'Ha modificado la fecha final del proyecto.\Se van a modificar las fechas del contrato %1.';
        Text105: Label 'No se puede pasar a Contrato un Proyecto con importe de Venta a 0.';
        Text110: Label 'Para empezar a trabajar con proyectos debe hacer lo siguiente:\  - Tiene que crear un proyecto genérico.\  - Tiene que asignarlo en la configuración de Proyectos.';
        Text50001: Label 'No se puede eliminar un proyecto en estado pedido.';
        Text50002: Label 'No se puede cambiar un proyecto a un estado anterior.';
        Text50005: Label 'Ya han pasado mas de %1 desde la creación del proyecto. No puede pasarse a Contrato.';

    trigger OnDelete()
    VAR
        CommentLine: Record 97;
        JobTask: Record 1001;
    // JobResPrice: Record 1012;
    // JobItemPrice: Record 1013;
    // JobGLAccPrice: Record 1014;
    BEGIN
    END;


}

