/// <summary>
/// Enum Tipo fijacion (ID 50006).
/// </summary>
enum 50006 "Tipo fijacion"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Escalera)
    {
        Caption = 'Escalera';
    }
    value(2; Grua)
    {
        Caption = 'Grua';
    }

}
enum 50017 "Tipo de Movimiento"
{
    Extensible = true;

    value(0; "Primera Fijacion")
    {
        Caption = 'Primera Fijación';
    }
    value(1; Fijacion)
    {
        Caption = 'Ficación';
    }
    value(2; "Cambio Emplazamiento")
    {
        Caption = 'Cambio Emplazamiento';
    }
    value(3; Otros)
    { }

}
enum 50011 "Job Status Kuara"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Planning)
    {
        Caption = 'Presupuesto';
    }
    value(1; Quote)
    {
        Caption = 'Oferta';
    }
    value(2; Open)
    {
        Caption = 'Contrato';
    }
    value(3; Completed)
    {
        Caption = 'Terminado';
    }
}

enum 50012 "Estado Movimientos"
{
    Extensible = true;
    AssignmentCompatibility = true;
    // ,Devuelto,Entregado,Pagado,Pendiente
    value(0; "")
    {
        Caption = '';
    }
    value(1; Devuelto)
    {
        Caption = 'Devuelto';
    }
    value(2; Entregado)
    {
        Caption = 'Entregado';
    }
    value(3; Pagado)
    {
        Caption = 'Pagado';
    }
    value(4; Pendiente)
    {
        Caption = 'Pendiente';
    }
    value(5; Regularizado)
    {
        Caption = 'Regularizado';
    }

}
enum 50013 "Reclamado"
{
    Extensible = true;
    AssignmentCompatibility = true;
    // ,Intocable,No Reclamado,Reclamado
    value(0; "")
    {
        Caption = '';
    }
    value(1; Intocable)
    {
        Caption = 'Intocable';
    }
    value(2; "No Reclamado")
    {
        Caption = 'No Reclamado';
    }
    value(3; Reclamado)
    {
        Caption = 'Reclamado';

    }
}
enum 50014 "Pagador"
{
    // ,Malla,Grepsa
    Extensible = true;
    AssignmentCompatibility = true;
    value(0; "")
    {
        Caption = '';
    }
    value(1; Malla)
    {
        Caption = 'Malla';
    }
    value(2; Grepsa)
    {
        Caption = 'Grepsa';
    }
}

enum 50015 "Intocable Emplazamiento"
{
    // [ ,0,1,3
    Extensible = true;
    AssignmentCompatibility = true;
    value(0; "")
    {
        Caption = '';
    }
    value(1; "0")
    {
        Caption = '1';
    }
    value(2; "1")
    {
        Caption = '1';
    }
    value(3; "3")
    {
        Caption = '3';
    }
}


enum 50016 "Estado Emplazamiento"
{
    //Alta,Baja
    Extensible = true;
    AssignmentCompatibility = true;
    value(0; "Alta")
    {
        Caption = 'Alta';
    }
    value(1; "Baja")
    {
        Caption = 'Baja';
    }

}
enum 50019 "Principal\Componente"
{
    value(0; "Principal") { }
    value(1; "Componente") { }
}
enum 50009 "Tipo conciliación"
{
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Automática)
    {
        Caption = 'Automática';
    }
    value(2; Manual)
    {
        Caption = 'Manual';
    }
}
enum 7001147 "Tipo mov."
{
    //'G/L Account,Customer,Vendor,Bank Account',
    value(0; "G/L Account")
    {
        Caption = 'Cuenta';
    }
    value(1; "Customer")
    {
        Caption = 'Cliente';
    }
    value(2; "Vendor")
    {
        Caption = 'Proveedor';
    }
    value(3; "Bank Account")
    {
        Caption = 'Banco';
    }
}
enum 7001110 "Control stock maximo"
{
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Error")
    {
        Caption = 'Error';
    }
    value(2; "Aviso")
    {
        Caption = 'Aviso';
    }

}

enum 7001111 "Soporte de"
{
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Fijación")
    {
        Caption = 'Fijación';
    }
    value(2; "Vinilo")
    {
        Caption = 'Vinilo';
    }
    value(3; "Pintura")
    {
        Caption = 'Pintura';
    }
    value(4; "Lona")
    {
        Caption = 'Lona';
    }
}

enum 7001112 "Tipo"
{
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Food")
    {
        Caption = 'Comida';
    }
    value(2; "Beverage")
    {
        Caption = 'Bebida';
    }

}

enum 7001113 "Interc./Compens."
{
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Intercambio")
    {
        Caption = 'Intercambio';
    }
    value(2; "Compensacion")
    {
        Caption = 'Compensación';
    }
    value(3; "Donacion")
    {
        Caption = 'Donación';
    }

}
enum 7001114 "Periodo cierre automático"
{
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Mensual")
    {
        Caption = 'Mensual';
    }
    value(2; "Decenal")
    {
        Caption = 'Decenal';
    }

}
enum 7001115 "Periodo cierre manual"
{
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Mensual")
    {
        Caption = 'Mensual';
    }
    value(2; "Decenal")
    {
        Caption = 'Decenal';
    }
    value(3; "Quincenal")
    {
        Caption = 'Quincenal';
    }
}
enum 7001116 "Document Type Kuara"
{
    value(0; " ") { }
    value(1; "Payment")
    {
        Caption = 'Pago';
    }
    value(2; "Invoice")
    {
        Caption = 'Factura';
    }
    value(3; "Credit Memo")
    {
        Caption = 'Abono';
    }
    value(4; "Finance Charge Memo")
    {
        Caption = 'Doc. Interés';
    }
    value(5; "Reminder")
    {
        Caption = 'Recordatorio';
    }
    value(6; "Refund")
    {
        Caption = 'Reenbolso';
    }
    value(21; "Bill")
    {
        Caption = 'Efecto';
    }
    value(22; "Albaran")
    {
        Caption = 'Alabrán';

    }
}
enum 7001118 "Situación Efactura"
{
    value(0; " ")
    { }
    value(1; "Pendiente")
    {
        Caption = 'Pendiente';
    }
    value(2; "Enviada")
    {
        Caption = 'Enviada';
    }
    value(3; "Enviada-Firmada")
    {
        Caption = 'Enviada-Firmada';
    }
}
enum 7001119 "Facturación resaltada"
{
    value(0; " ")
    { }
    value(1; "Por Términos")
    {
        Caption = 'Por Términos';
    }
    value(2; "Enviada")
    {
        Caption = 'Por Fechas';
    }
    value(3; "Por Lineas")
    {
        Caption = 'Por Lineas';
    }
}

enum 7001120 "Pago Confirming"
{
    value(0; " ")
    { }
    value(1; "T")
    {
        Caption = 'T';
    }
    value(2; "C")
    {
        Caption = 'C';
    }

}
enum 7001121 "Subtipo"
{
    value(0; " ")
    { }
    value(1; "Vallas")
    {
        Caption = 'Vallas';
    }
    value(2; "Opis")
    {
        Caption = 'Opis';
    }
    value(3; "Combinado")
    {
        Caption = 'Combinado';
    }
}
enum 50008 "Estado Confirming"
{
    Value(0; Abierto)
    {

    }
    Value(1; Registrado)
    {

    }
}
enum 7001122 "Cobro/Pagos/Ambos"
{
    Value(0; Ambos) { }
    Value(1; Cobro) { }
    Value(2; Pago) { }
}
enum 7001123 "Debe/Haber"
{
    Value(0; Ambos) { }
    Value(1; Debe) { }
    Value(2; Haber) { }
}
//enum 51200"Partner Type"Company){}Person
enum 7001124 "Tipo Cuenta Importe"
{
    Value(0; Cuenta) { }
    Value(1; Tercero) { }
}
enum 7001125 "Filtro Subtipo"
{
    Value(0; Economato) { }
    Value(1; Traspaso) { }
    Value(2; Hotel) { }
    Value(3; Consumo) { }
    Value(4; Retroceso) { }
    Value(5; Mermas) { }
    Value(6; Roturas) { }
    Value(7; "Consumo TPV") { }
    Value(8; Regularizacion) { }
    Value(9; Elaborado) { }
    Value(10; "Invitacion TPV") { }
}
enum 7001126 "Devengo SII"
{ Value(0; "Fecha registro") { } Value(1; "Fecha vencimiento") { } Value(2; "Fecha emisión") { } }
enum 7001127 "Tipo reasignacion solicitud"
{ Value(0; Ninguno) { } Value(1; "Nro Orden") { } Value(2; "Precio x Kilo & Fecha trabajo") { } Value(3; "Nro Orden & Fecha trabajo") { } Value(4; "Precio Compra & Fecha trabajo") { } }
enum 7001128 "Firmado"
{ Value(0; "No Firmado") { } Value(1; Firmado) { } }
enum 7001129 "¿Esta Impreso?"
{ Value(0; No) { } Value(1; Si) { } }
enum 7001130 "Tipo Economato"
{ Value(0; Otros) { } Value(1; Bar) { } Value(2; Cocina) { } }
enum 7001131 "Tipo Pagarés"
{ Value(0; "Pagaré Continuo") { } Value(1; "Carta con Pagaré") { } }
//enum 50032 "Tipo Venta" { Value(0; "Por Campaña") { } Value(1; "Por Temporada") { } Value(2; Anual) { } Value(3; Otros) { } }
enum 7001133 "Imprimir orden al validar"
{ Value(0; Preguntar) { } Value(1; Siempre) { } Value(2; Nunca) { } }
enum 7001134 "Dest. Type"
{ Value(0; Resource) { } Value(1; "Group(Resource)") { } Value(2; All) { } }
enum 7001135 "Control regularización cierres"
{ Value(0; "Sí") { } Value(1; No) { } }
enum 7001136 "Tipo Saldo"
{ Value(0; "Saldo a la fecha") { } Value(1; "Saldo periodo") { } }
enum 7001137 "Tipo impreso pagaré"
{ Value(0; Santander) { } Value(1; BanCaja) { } Value(2; "La Caixa") { } Value(3; "Sa Nostra") { } }
enum 7001138 "Tipo pagare"
{ Value(0; Tipo1) { } Value(1; Tipo2) { } }

enum 7001139 "Document Situacion"
{
    // ,Posted BG/PO,Closed BG/PO,BG/PO,Cartera,Closed Documents
    value(0; " ") { }
    value(1; "Posted BG/PO")
    {
        Caption = 'Rem./Ord. pago registrada';
    }
    value(2; "Closed BG/PO")
    {
        Caption = 'Rem./Ord. pago cerradaa';
    }
    value(3; "BG/PO")
    {
        Caption = 'Rem./Ord. pago';
    }
    value(4; "Cartera")
    {
        Caption = 'Cartera';
    }
    value(5; "Closed Documents")
    {
        Caption = 'Docs. Cerrados';
    }
}
enum 7001140 Suelo
{
    //Rústico,Urbano,SUP-AU,SG,SUNP
    value(0; Rústico) { }
    value(1; Urbano) { }
    Value(2; "SUP-AU") { }
    Value(3; SG) { }
    Value(4; SUNP) { }
}
enum 7001141 "Tipo Inmueble"
{
    //Proveedor,Direccion,Emplazamiento;
    value(0; Proveedor) { }
    value(1; Direccion) { }
    Value(2; Emplazamiento) { }
    value(3; Empresa) { }
}
enum 7001142 "Periodo declaración Iva Efact."
{
    value(0; Mensual) { }
    value(1; Trimestral) { }
}
enum 7001143 "Versión efactura"
{
    // ,XML 3.1,XML 3.2
    value(0; " ") { }
    value(1; "XML 3.1") { }
    value(2; "XML 3.2") { }
}
enum 7001145 Categoria
{
    // ,1,2,Especial,T1,T2,Pueblo
    value(0; " ") { }
    value(1; "1") { }
    value(2; "2") { }
    value(3; "Especial") { }
    value(4; "T1") { }
    value(5; "T2") { }
    value(6; "Pueblo") { }

}
enum 7001146 "Estado Reserva"
{
    //Reservado,Reservado fijo,Ocupado,Ocupado fijo,Libre
    value(0; "Reservado") { }
    value(1; "Reservado fijo") { }
    value(2; "Ocupado") { }
    value(3; "Ocupado fijo") { }
    value(4; "Libre") { }
    value(5; "Anulado") { }


}
enum 7001157 "Material de Fijación"
{
    //Sin especificar,Solo Vinilo,Vinilo y Papel,Vinilo y lona
    value(0; "Sin Especificar") { }
    value(1; "Vinilo") { }
    value(2; "Vinilo y Papel") { }
    value(3; "Vinilo y lona") { }
    value(4; "Papel") { }
    value(5; "Lona") { }



}

enum 7001158 "Tipo (presupuesto)"
{
    Extensible = true;
    ////Recurso0,Producto1,Cuenta2,Texto3,4,5,6,7,Familia8;
    value(0; "Recurso") { }
    value(1; "Producto") { }
    value(2; Cuenta) { }
    value(3; Texto) { }
    value(4; "Activo Fijo") { }
    value(8; Familia) { }

}

enum 7001159 "Opcion Diarios"
{
    Extensible = true;
    ////Diario General, Registro Venta, Registro Compra,Diario Compras
    value(0; "Diario General") { }
    value(1; "Registro Venta") { }
    value(2; "Registro compra") { }
    value(3; "Diario Compras") { }


}
enum 7001160 "Tipo Documento Timon"
{
    Extensible = true;
    //// ,Factura,Abono,Cobro;
    value(0; " ") { }
    value(1; "Factura") { }
    value(2; "Abono") { }
    value(3; "Cobro") { }


}
enum 7001161 "Tipo Debe/Haber"
{

    //Donante,Cuenta,Socio,"Debe Origen","Haber Origen",Receptor;
    value(0; "Donante") { }
    value(1; "Cuenta") { }
    value(2; "Socio") { }
    value(3; "Debe Origen") { }
    value(4; "Haber Origen") { }
    value(5; "Receptor") { }
}
enum 7001132 "Tipo Cuenta Debe"
{

    //Donante,Cuenta,Socio,"Debe Origen","Haber Origen",Receptor;
    value(0; "Debe") { }
    value(1; "Cliente") { }

}
enum 7001149 "Tipo Cuenta Haber"
{

    //Donante,Cuenta,Socio,"Debe Origen","Haber Origen",Receptor;
    value(0; "Haber") { }
    value(1; "Proveedor") { }

}
enum 7001153 "Bal. Account type"
{
    //G/L Account","Bank Account
    value(0; Cuenta) { }
    value(1; Banco) { }
}
enum 7001154 "Tipo Documento Envios"
{
    value(0; "Invoice")
    {
        Caption = 'Factura';
    }
    value(1; "Credit Memo")
    {
        Caption = 'Abono';
    }

}
enum 7001155 "TipoLinea"
{
    Value(0; Ambos) { }
    Value(1; Venta) { }
    Value(2; Compra) { }
}
enum 7001156 "Fija/Papel"
{
    //Sin especificar,Solo Vinilo,Vinilo y Papel,Vinilo y lona
    value(0; " ") { }
    value(1; "Fija") { }
    value(2; "Papel") { }

}
enum 7001101 "Tipo orden"
{
    value(0; Prensa) { }
    value(1; Radio) { }
    value(2; Audiovisuales) { }
    value(3; Otros) { }
}
enum 7001102 "Dia Semana"
{
    value(0; "Lunes") { Caption = 'Lunes'; }
    value(1; "Martes") { Caption = 'Martes'; }
    value(2; "Miercoles") { Caption = 'Miercoles'; }
    value(3; "Jueves") { Caption = 'Jueves'; }
    value(4; "Viernes") { Caption = 'Viernes'; }
    value(5; "Sabado") { Caption = 'Sabado'; }
    value(6; "Domingo") { Caption = 'Domingo'; }
}
enum 7001103
 "Estado Orden Publicidad"
{
    value(0; Abierta) { }
    value(1; Validada) { }
}

enum 7001104 "Estado Contrato"
{
    //"Pendiente de Firma",Firmado,Anulado,Cancelado,"Sin Montar",Modificado
    value(0; "Pendiente de Firma") { }
    value(1; Firmado) { }
    value(2; Anulado) { }
    value(3; Cancelado) { }
    value(4; "Sin Montar") { }
    value(6; Modificado) { }
}
Enum 7001105 "Filtro Estado Contrato"
{
    //"Pendiente de Firma",Firmado,Anulado,Cancelado,"Sin Montar",modificado
    value(0; "Pendiente de Firma") { }
    value(1; Firmado) { }
    value(2; Anulado) { }
    value(3; Cancelado) { }
    value(4; "Modificado") { }
    value(5; "Sin Montar") { }
    value(6; "Sin Contrato") { }
    value(7; "Con Contrato") { }
    value(8; "Todos") { }
}
enum 7001106 "Tipo Venta Job"
{
    Value(0; "Por Campaña") { }
    Value(1; "Por Temporada") { }
    Value(2; Anual) { }
    Value(3; Otros) { }
    Value(4; Reserva) { }
    Value(5; Propuesta) { }
}
enum 7001107 "Crear Pedidos"
{
    //OptionMembers = "De Venta","De Compra Y De Venta","De Compra";
    value(0; "De venta") { }
    value(1; "De Compra Y De Venta") { }
    value(2; "De Compra") { }
    value(3; "No crear pedido") { }
}
enum 7001108 Medio
{
    value(0; Prensa) { }
    value(1; Radio) { }
    value(2; Audiovisuales) { }
    value(3; Otros) { }
}
enum 7001109 Reparto
{
    value(0; Proporcional) { }
    value(1; "1ª Fra") { }
    value(2; "1ª Fra+proporc.") { }
    value(3; "Fra prepago") { }
}
enum 7001162 "Esperar Orden Cliente"
{
    //=No,Sí,Covid-19,Covid-19 Aceptado
    value(0; No) { }
    value(1; "Sí") { }
    value(2; "Covid-19") { }
    value(3; "Covid-19 Aceptado") { }
}
enum 7001163 "Ampliación Covid"
{
    value(0; " ") { }
    value(1; "Ampliación") { }
}
enum 7001117 "Peticion Disponibilidad"
{
    value(0; " ") { }
    value(1; "Peticion Enviada") { }
    value(2; "Respuesta Enviada") { }
}
enum 7001150 "Tipo Cliente"
{
    value(0; Directo) { }
    Value(1; "Agencia") { }
}

Enum 7001151 "Estado Firma Electrónica"
{
    value(0; Pending) { Caption = 'Pendiente'; }
    value(1; "Own Signed") { Caption = 'Firmado Dirección'; }
    value(2; "Own Rejected") { Caption = 'Rechazado Dirección'; }
    value(3; "Customer Signed") { Caption = 'Firmado Contrato'; }
    value(4; "Customer Rejected") { Caption = 'Rechazado Cliente'; }
    value(5; "Sepa Signed") { Caption = 'Firmado Sepa'; }
    value(6; "Sepa Rejected") { Caption = 'Rechazado Sepa'; }
    value(7; "Sepa & Contract Signed") { Caption = 'Firmado Sepa y Contrato'; }
    value(8; "Sepa Pending & Contract Signed") { Caption = 'Firmado Contrato y Sepa Pendiente'; }
    value(9; "Sepa Pending") { Caption = 'Firmado dirección enviado Sepa'; }
}
Enum 7001152 "Extensiones Malla"
{
    value(0; "Malla Wave 2.0") { }
    value(1; "Ocr Malla") { }
    value(2; "Emplazamientos") { }
    value(3; Personal) { }
    value(4; Irpf) { }
    value(5; "CRM Malla") { }
    value(6; "PowerBiMalla") { }
    value(7; "FirmaContratos") { }
    value(8; "Utilidades") { }
    value(9; "EDI by Malla") { }
    value(10; "B2Bconnector") { }
    value(11; "Task Malla") { }
    value(12; Informes) { }
    value(13; DropBox) { }
}
Enum 7001165 "Id Extensiones Malla"
{
    value(0; "7A7D3479-E693-4F3D-8336-AAC424523182") { }//	Malla Wave 2.0
    value(1; "7A7D3479-E693-4F3D-8336-AAC424523186") { }//	Ocr Malla
    value(2; "4C3E28B8-7FE9-4A33-AD5D-D26CBF8F7765") { }//	Emplazamientos
    value(3; "1E9AD503-229C-4ABA-9116-E55E8281985A") { }//	Personal
    value(4; "D1238390-627C-43D0-A2D7-7840A53D773C") { }//	Irpf
    value(5; "7A7D3479-E693-4F3D-8336-AAC424523187") { }//	CRM Malla
    value(6; "D9CB442A-BE20-49A4-A6D6-9AD6A9FBD205") { }//	PowerBiMalla
    value(7; "D9CB442A-BE20-49A4-A6D6-9AD6A9FBD206") { }//	FirmaContratos
    value(8; "FB32F289-3F2B-41D1-B6D9-B6A8BF93A8AB") { }//	Utilidades
    value(9; "9E1385B2-035E-4118-88DE-92E043109461") { }//	EDI by Malla
    value(10; "23BF6EB4-CBE5-49F6-8B41-0B18502F9D48") { }//	B2Bconnector
    value(11; "366AC4B9-199A-4725-A5F2-9BEAD2FE08B5") { }	//Task Malla
    value(12; "80666C65-3038-42BD-932A-AF8BA6E6F216") { }//	Informes
    value(13; "97DCB0C2-10E0-4848-A938-474D3183D943") { }//	DropBox

}
Enum 7001164 Duracion
{
    value(0; "Meses") { }
    value(1; "Quincenas") { }
    value(2; Semanas) { }
    value(3; Catorzenas) { Caption = 'Catorcenas'; }
    value(4; "Días") { }
    value(5; " ") { Caption = '--'; }

}
