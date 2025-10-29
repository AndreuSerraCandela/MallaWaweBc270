/// <summary>
/// EnumExtension GlEntryDoc (ID 80131) extends Record Gen. Journal Document Type.
/// </summary>
enumextension 80131 GlEntryDoc extends "Gen. Journal Document Type"
{

    value(22; "Receipt") { Caption = 'Albarán'; }
    value(23; "Advance") { Caption = 'Anticipo'; }
    value(24; Shipment) { Caption = 'Albarán Venta'; }

}
enumextension 80101 ToalingKuara extends "Acc. Schedule Line Totaling Type"
{
    //Vendor,Customer
    value(50010; "Vendor")
    {
        Caption = 'Proveedor';
    }
    value(50011; "Customer")
    {
        Caption = 'Cliente';
    }
    value(50012; Linea) { }
}
enumextension 80100 TipoDocumentoComentario extends "Sales Comment Document Type"
{
    //,Detalle Contrato,Detalle Factura,Detalle Abono,Detalle Fac. Reg,Detalle Abo. Reg

    value(10; "Detalle Contrato") { Caption = 'Detalle Contrato'; }
    value(11; "Detalle Factura") { Caption = 'Detalle Factura'; }
    value(12; "Detalle Abono") { Caption = 'Detalle Abono'; }
    value(13; "Detalle Fac. Reg") { Caption = 'Detalle Fac. Reg'; }
    value(14; "Detalle Abo. Reg") { Caption = 'Detalle Abo. Reg'; }
}


enumextension 80141 "IncomingDocKuara" extends "Incoming Document Type"
{
    value(6; "Sales Order") { Caption = 'Pedido venta'; }
    value(7; "Purchase Receipt") { Caption = 'Albarán Compra'; }
    value(8; "Sales Shipment") { Caption = 'Albarán Venta'; }
    value(9; "Sales Invoice") { Caption = 'Factura Venta'; }
    value(10; "Sales Cr. Memo") { Caption = 'Abono venta'; }

}
enumextension 80142 JobPlEx extends "Job Planning Line Type"
{
    value(4; "Activo fijo") { }
    value(5; Familia) { }
}
enumextension 80143 DocTypePurch extends "Purchase Document Status"
{
    value(4; Canceled)
    {
        Caption = 'Cancelado';
    }
}
enumextension 80144 EnumEscenario extends "Email Scenario"
{
    value(90000; Employee)
    {
        Caption = 'Personal';
    }
    value(90001; Comercial)
    {
        Caption = 'Comercial';
    }
    value(90002; Emplazamientos)
    {
        Caption = 'Emplazamientos';
    }
    value(90003; Informes)
    {
        Caption = 'Informes';
    }
    value(90004; Gtasks)
    {
        Caption = 'Tareas';
    }
    value(90005; "Medios")
    {
        Caption = 'Medios';
    }

}
enumextension 80145 EmailAdress extends "Email Address Entity"
{

    value(50000; "Salesperson/Purchaser")
    {
        Caption = 'Vendedores';
    }
    value(50001; "Emplazamiento")
    {
        Caption = 'Emplazamientos';
    }
}
enumextension 80125 CashFlow extends "Cash Flow Source Type"
{
    value(17; "Detalle Préstamos") { Caption = 'Detalle prestamos'; }
    value(18; "Movimientos emplazamientos") { Caption = 'Movimientos emplazamientos'; }
    value(19; "Cartera Clientes") { Caption = 'Cartera Clientes'; }
    value(20; "Cartera Proveedores") { Caption = 'Cartera Proveedores'; }
    value(21; "Cartera Clientes Registrada") { Caption = 'Cartera Clientes Registrada'; }
    value(22; "Cartera Proveedores Registrada") { Caption = 'Cartera Proveedores Registrada'; }
    value(23; "Rentings") { Caption = 'Rentings'; }
}
enumextension 80126 ColummTipe extends "Column Layout Type"
{
    value(8; "Date")
    {
        Caption = 'Fecha';
    }

}
enumextension 80200 ComentLine extends "Comment Line Table Name"
{
    value(25; Anotaciones) { }

}
enumextension 80300 AmountType extends "Price Amount Type"
{
    value(50000; "% Extra") { }
}