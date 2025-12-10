// /// <summary>
// /// TableExtension Invoice Post. BufferKuara (ID 80155) extends Record Invoice Post. Buffer.
// /// </summary>

// #pragma warning disable AL0432
// tableextension 80155 "Invoice Post. BufferKuara" extends "Invoice Post. Buffer"
// #pragma warning restore AL0432

// {
//     fields
//     {
//         field(50000; "Texto"; TEXT[50]) { }
//         field(50001; "Fecha"; Date) { }
//         field(50002; "Filtro Fecha"; Date)
//         {
//             FieldClass = FlowFilter;
//         }
//         field(50004; "Global Dimension 3 Code"; CODE[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
//             DataClassification = ToBeClassified;
//             CaptionClass = '1,2,3';

//         }
//         field(50005; "Global Dimension 4 Code"; CODE[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
//             DataClassification = ToBeClassified;
//             CaptionClass = '1,2,4';

//         }
//         field(50006; "Global Dimension 5 Code"; CODE[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
//             DataClassification = ToBeClassified;
//             CaptionClass = '1,2,5';

//         }
//         field(50011; "Periodo de Pago"; TEXT[30]) { }
//         field(80000; "Tipo factura SII"; CODE[2]) { }
//         field(80001; "Clave registro SII expedidas"; CODE[2]) { }
//         field(80002; "Clave registro SII recibidas"; CODE[2]) { }
//         field(80003; "Tipo desglose emitidas"; CODE[3]) { }
//         field(80004; "Sujeta exenta"; CODE[3]) { }
//         field(80005; "Tipo de operación"; CODE[2]) { }
//         field(80006; "Descripción operación"; TEXT[250]) { }
//         field(80007; "Tipo factura rectificativa"; CODE[1]) { }
//         field(80009; "Tipo desglose recibidas"; CODE[3]) { }
//         field(80010; "Line Discount Amount"; Decimal) { }
//         field(80011; "Inv. Discount Amount"; Decimal) { }
//         field(80012; "Pmt. Discount Amount"; Decimal) { }
//         field(80013; "Line Discount Amt. (ACY)"; Decimal) { }
//         field(80014; "Inv. Discount Amt. (ACY)"; Decimal) { }
//         field(80015; "Src. Curr. Pmt. Discount Amt."; Decimal) { }
//         //Line Discount Account
//         //Inv. Discount Account
//         //Pmt. Discount Account
//         field(80016; "Line Discount Account"; Code[20]) { }
//         field(80017; "Dimension Entry No."; Integer) { }
//         field(80018; "Inv. Discount Account"; Code[20]) { }
//         field(80019; "Pmt. Discount Account"; Code[20]) { }
//         field(80020; "Nº Contrato"; Code[20]) { }
//         field(80021; Agrupado; Boolean) { }
//     }

// }
tableextension 80156 "Invoice Posting BufferKuara" extends "Invoice Posting Buffer"
{
    fields
    {
        field(80020; "Nº Contrato"; Code[20]) { }
        field(80021; Agrupado; Boolean) { }


        field(50000; "Texto"; TEXT[50]) { }
        field(50001; "Fecha"; Date) { }
        field(50002; "Filtro Fecha"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50004; "Global Dimension 3 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';

        }
        field(50005; "Global Dimension 4 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';

        }
        field(50006; "Global Dimension 5 Code"; CODE[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';

        }
        field(50011; "Periodo de Pago"; TEXT[30]) { }
        field(80000; "Tipo factura SII"; CODE[2]) { }
        field(80001; "Clave registro SII expedidas"; CODE[2]) { }
        field(80002; "Clave registro SII recibidas"; CODE[2]) { }
        field(80003; "Tipo desglose emitidas"; CODE[3]) { }
        field(80004; "Sujeta exenta"; CODE[3]) { }
        field(80005; "Tipo de operación"; CODE[2]) { }
        field(80006; "Descripción operación"; TEXT[250]) { }
        field(80007; "Tipo factura rectificativa"; CODE[1]) { }
        field(80009; "Tipo desglose recibidas"; CODE[3]) { }
        field(80010; "Line Discount Amount"; Decimal) { }
        field(80011; "Inv. Discount Amount"; Decimal) { }
        field(80012; "Pmt. Discount Amount"; Decimal) { }
        field(80013; "Line Discount Amt. (ACY)"; Decimal) { }
        field(80014; "Inv. Discount Amt. (ACY)"; Decimal) { }
        field(80015; "Src. Curr. Pmt. Discount Amt."; Decimal) { }
        //Line Discount Account
        //Inv. Discount Account
        //Pmt. Discount Account
        field(80016; "Line Discount Account"; Code[20]) { }
        field(80017; "Dimension Entry No."; Integer) { }
        field(80018; "Inv. Discount Account"; Code[20]) { }
        field(80019; "Pmt. Discount Account"; Code[20]) { }
    }

}