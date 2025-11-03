/// <summary>
/// TableExtension EmpresaKuara (ID 80108) extends Record Company Information.
/// </summary>
tableextension 80108 EmpresaKuara extends "Company Information"
{
    fields
    {
        // Add changes to table fields here

        field(80000; "Traspasado"; boolean)
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;

        }
        field(50003; "Cuenta"; Integer) { }
        field(50004; "InterEmpresas"; Boolean) { }
        field(50005; "Filtro Fecha"; Date)
        {
            Caption = 'Filtro fecha obsoleto';
            ObsoleteState = Removed;
            // Enabled = false;
        }
        field(50006; "Cuenta2"; Integer) { }
        field(50007; "Nombre Ficheros"; Text[30]) { }
        field(50008; "Date Filter"; Date)
        { FieldClass = FlowFilter; Caption = 'Filtro Fecha'; }
        field(80010; "Empresa para mestros"; Boolean)
        { }
        field(80011; Calcular; Text[100])
        { }

        #region E-Factura
        field(60012; "Cód. estandar aditional Efact."; Code[20]) { }
        field(60014; "Cód. idioma Efactura"; Code[20]) { }
        field(60016; "Periodo declaración Iva Efact."; Enum "Periodo declaración Iva Efact.") { }
        field(60017; "Versión efactura"; Enum "Versión efactura") { }
        field(60018; "E-Mail efactura"; Text[80]) { }
        field(60010; "Direc. carpeta Efactura"; Text[250]) { }
        #endregion E-Factura
        #region Correo
        field(60019; "Cabecra Correo"; Text[30]) { }
        field(80016; "Pie de Correo"; Media)
        {
            ObsoleteState = Removed;
        }
        field(80017; "Email-Foot"; Blob)
        {

        }
        field(80019; "Desctivar SendBCC Defaul"; Boolean)
        {

        }
        #endregion correo
        #region Recursos
        field(50000; "Nombre para recursos"; Text[30]) { }
        field(50001; "Fecha Inicio FPR"; Date) { }
        field(50002; "Clave Recursos"; Text[2]) { }
        #ENDregion Recursos

        #region timecloud
        field(80012; "company gotimecloud"; text[30])
        {
            ObsoleteState = Removed;

        }
        field(80013; "username gotimecloud"; text[250])
        {
            ObsoleteState = Removed;
            Description = '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918';
        }
        field(80014; "password gotimecloud"; text[250])
        {
            ObsoleteState = Removed;
            Description = '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918malla';
            ExtendedDatatype = Masked;
        }
        field(80015; "Url gotimecloud"; text[250])
        {
            ObsoleteState = Removed;
            Description = 'https://company.yourtimecheck.com/api/v1/';

        }
        field(80018; "Url gotimecloud2"; text[250])
        {

            ObsoleteState = Removed;

        }
        #endregion timecloud

        #region alfresco
        field(90013; "Servidor Alfresco"; text[250])
        {

        }
        field(90016; "Url Alfresco"; text[250])
        {
            ObsoleteState = Removed;
        }
        field(90014; "password Alfresco"; text[250])
        {
            ExtendedDatatype = Masked;
        }
        field(90015; "Usuario Alfresco"; text[250])
        {


        }

        field(90012; "Site Alfresco"; text[250])
        { }
        field(90017; "Url Task"; text[250])
        {

        }
        field(90018; "password Task"; text[250])
        {
            ExtendedDatatype = Masked;
        }
        field(90019; "Usuario Task"; text[250])
        {


        }
        field(90020; "Token Task"; text[250])
        {
        }
        // field(90018; "Url gotimecloud2"; text[250])
        // {


        // }
        #endregion alfresco
        field(92000; "Traspasado Ocr"; boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(92001; "ID Ocr"; Text[250])
        {

        }
        field(92003; "ID Qwark"; Text[250])
        {

        }
        field(92004; "Instalación En Curso"; boolean)
        {


        }
        field(92005; "Mensaje General"; Text[250])
        {



        }
        field(92006; "Mensaje Empresa"; Text[250])
        {
        }
    }

    var
        myInt: Integer;

    PROCEDURE BuildCCCC();
    VAR
        CompanyInfo: Record 79;
    BEGIN
        "CCC No." := "CCC Bank No." + "CCC Bank Branch No." + "CCC Control Digits" + "CCC Bank Account No.";
        if "CCC Bank Account No." <> '' THEN BEGIN
            //TESTFIELD("Bank Account No.", '');
            CompruebaDigito("CCC Bank No.", "CCC Bank Branch No.", "CCC Bank Account No.", "CCC Control Digits");
            IBAN := DevolverIBAN("Country/Region Code", "CCC Bank No.",
            "CCC Bank Branch No.", "CCC No.");
            "SWIFT Code" := DevolverSWIFT("Country/Region Code", "CCC Bank No.");
            CompanyInfo.CheckIBAN(IBAN);
        END;
    END;

    PROCEDURE BuildCCCC(var CCCNo: Text; CCCBankNo: Text; CCCControlDigits: Text; CCCBankBranchNo: Text; CCCBankAccountNo: Text; Var SwiftCode: Code[20]; Var tIBAN: code[50]; CountryRegionCode: Text; var Name: Text);
    VAR
        CompanyInfo: Record 79;
        Iban: Text;
    BEGIN
        If tIBAN <> '' THEN begin
            //ES3900810592880001062014
            if CCCBankNo = '' then
                CCCBankNo := CopyStr(tIBAN, 5, 4);
            if CCCBankBranchNo = '' then
                CCCBankBranchNo := CopyStr(tIBAN, 9, 4);
            if CCCControlDigits = '' then
                CCCControlDigits := CopyStr(tIBAN, 13, 2);
            if CCCBankAccountNo = '' then
                CCCBankAccountNo := CopyStr(tIBAN, 15, 10);


        end;
        CCCNo := CCCBankNo + CCCBankBranchNo + CCCControlDigits + CCCBankAccountNo;
        if CCCBankBranchNo <> '' THEN BEGIN
            CompruebaDigito(CCCBankNo, CCCBankBranchNo, CCCBankAccountNo, CCCControlDigits);
            tIBAN := DevolverIBAN(CountryRegionCode, CCCBankNo,
            CCCBankBranchNo, CCCNo);
            SwiftCode := DevolverSWIFT(CountryRegionCode, CCCBankNo);
            CompanyInfo.CheckIBAN(tIBAN);
        END;
        Name := NombreBanco(CCCBankNo);
    END;

    procedure NombreBanco(codebanc: Code[20]): Text
    begin
        case codebanc of
            '0241':
                Exit('A&G BANCO, S.A.');
            '2080':
                Exit('Abanca Corporacion Bancaria, S.A.');
            '8620':
                Exit('Abanca Servicios Financieros E.F.C., S.A.');
            '1535':
                Exit('AKF Bank GmbH & Co Kg, Sucursal en España');
            '0011':
                Exit('Allfunds Bank, S.A.');
            '0200':
                Exit('ANDBANK ESPAÑA BANCA PRIVADA, S.A.');
            '0136':
                Exit('Aresbank, S.A.');
            '3183':
                Exit('Arquia Bank, S.A.');
            '1541':
                Exit('Attijariwafa Bank Europe, Sucursal en España');
            '0061':
                Exit('Banca March, S.A.');
            '1550':
                Exit('Banca Popolare Etica Società Cooperativa per Azioni, Sucursal en España');
            '0078':
                Exit('Banca Pueyo, S.A.');
            '0188':
                Exit('Banco Alcalá, S.A.');
            '0182':
                Exit('Banco Bilbao Vizcaya Argentaria, S.A.');
            '0225':
                Exit('Banco Cetelem, S.A.');
            '0198':
                Exit('Banco Cooperativo Español, S.A.');
            '0091':
                Exit('Banco de Albacete, S.A.');
            '0240':
                Exit('Banco de Crédito Social Cooperativo');
            '0003':
                Exit('Banco de Depósitos, S.A.');
            '9000':
                Exit('BANCO DE ESPAÑA');
            '1569':
                Exit('Banco de Investimento Global SA, Sucursal en España');
            '0169':
                Exit('Banco de la Nación Argentina, Sucursal en España');
            '0081':
                Exit('Banco de Sabadell, S.A.');
            '0184':
                Exit('Banco Europeo de Finanzas, S.A.');
            '0220':
                Exit('BANCO FINANTIA, S.A., SUCURSAL EN ESPAÑA');
            '0232':
                Exit('Banco Inversis, S.A.');
            '0186':
                Exit('Banco Mediolanum, S.A.');
            '0121':
                Exit('Banco Occidental, S.A.');
            '0235':
                Exit('Banco Pichincha España, S.A..');
            '1509':
                Exit('Banco Primus, S.A., Sucursal en España');
            '0049':
                Exit('Banco Santander, S.A.');
            '8843':
                Exit('BANGE CREDIT E.F.C. SA');
            '1574':
                Exit('Bank Julius Baer Europe, S.A, Sucursal en España');
            '0219':
                Exit('Bank of Africa Europe, S.A.');
            '1485':
                Exit('Bank of America Europe DAC, Sucursal en España');
            '1488':
                Exit('BANK PICTET & CIE (EUROPE) AG SUCURSAL EN ESPAÑA');
            '8832':
                Exit('Bankinter Consumer Finance, E.F.C., S.A.');
            '0128':
                Exit('Bankinter, S.A.');
            '1525':
                Exit('Banque Chaabi du Maroc, Sucursal en España');
            '1580':
                Exit('BANQUE J. SAFRA SARASIN (LUXEMBOURG) SA, SUCURSAL EN ESPAÑA');
            '0152':
                Exit('Barclays Bank Ireland PLC, Sucursal en España');
            '1554':
                Exit('BFF Bank, S.P.A. Sucursal en España');
            '6712':
                Exit('BIP&Drive EDE, S.A');
            '1533':
                Exit('BMW Bank GmbH, Sucursal en España');
            '6717':
                Exit('Bnext Electronic Issuer, E.D.E. S.L.');
            '1532':
                Exit('BNP Paribas Factor, Sucursal en España');
            '0167':
                Exit('BNP Paribas Fortis, S.A., N.V., Sucursal en España');
            '1492':
                Exit('BNP Paribas Lease Group S.A. Sucursal en España');
            '0149':
                Exit('BNP Paribas S.A., Sucursal en España');
            '1500':
                Exit('BPCE Lease, Sucursal en España');
            '1576':
                Exit('Bunq B.V., Sucursal en España');
            '8640':
                Exit('CA AUTO BANK, SPA, SUCURSAL EN ESPAÑA');
            '1545':
                Exit('CA Indosuez Wealth (Europe), Sucursal en España');
            '0038':
                Exit('CACEIS Bank Spain, S.A.');
            '1451':
                Exit('Caisse Régionale de Crédit Agricole Mutuel Sud-Méditerranée (Ariège et Pyrénées-Orientales)');
            '1493':
                Exit('Caixa Banco de Investimento, S.A. Sucursal en España');
            '3025':
                Exit('Caixa de Crédit dels Enginyers- Caja de Crédito de los Ingenieros, S. Coop. de Crédito');
            '3159':
                Exit('Caixa Popular-Caixa Rural, S. Coop. de Crédito V.');
            '3045':
                Exit('Caixa Rural Altea, Cooperativa de Crédito Valenciana');
            '3162':
                Exit('Caixa Rural Benicarló, S. Coop. de Credit V.');
            '3117':
                Exit('Caixa Rural D''Algemesí, S. Coop. V. de Crédit');
            '3105':
                Exit('Caixa Rural de Callosa d''en Sarrià, Cooperativa de Crédito Valenciana');
            '3096':
                Exit('Caixa Rural de L''Alcudia, Sociedad Cooperativa Valenciana de  Crédito');
            '3123':
                Exit('Caixa Rural de Turís, Cooperativa de Crédito Valenciana');
            '3070':
                Exit('Caixa Rural Galega, Sociedad Cooperativa de Crédito Limitada Gallega');
            '3111':
                Exit('Caixa Rural La Vall ''San Isidro'', Sociedad Cooperativa de Crédito Valenciana');
            '3166':
                Exit('Caixa Rural Les Coves de Vinromá, S. Coop. de Crédit V.');
            '3160':
                Exit('Caixa Rural Sant Josep de Vilavella, S. Coop. de Crédito V.');
            '3102':
                Exit('Caixa Rural Sant Vicent Ferrer de La Vall D''Uixó, Coop. de Credit V.');
            '3118':
                Exit('Caixa Rural Torrent Cooperativa de Credit Valenciana');
            '3174':
                Exit('Caixa Rural Vinarós, S. Coop. de Credit. V.');
            '8776':
                Exit('Caixabank Payments & Consumer, E.F.C., E.P., S.A.');
            '2100':
                Exit('Caixabank, S.A.');
            '2045':
                Exit('Caja de Ahorros y Monte de Piedad de Ontinyent');
            '3029':
                Exit('Caja de Crédito de Petrel, Caja Rural, Cooperativa de Crédito Valenciana');
            '3035':
                Exit('Caja Laboral Popular Coop. de Crédito');
            '3115':
                Exit('Caja Rural ''Nuestra Madre del Sol'', S. Coop. Andaluza de Crédito');
            '3110':
                Exit('Caja Rural Católico Agraria, S. Coop. de Crédito V.');
            '3005':
                Exit('Caja Rural Central, Sociedad Cooperativa de Crédito');
            '3190':
                Exit('Caja Rural de Albacete, Ciudad Real y Cuenca, Sociedad Cooperativa de Crédito');
            '3150':
                Exit('Caja Rural de Albal, Coop. de Crédito V.');
            '3179':
                Exit('Caja Rural de Alginet, Sociedad Cooperativa Crédito Valenciana');
            '3001':
                Exit('Caja Rural de Almendralejo, Sociedad Cooperativa de Crédito');
            '3191':
                Exit('Caja Rural de Aragón, Sociedad Cooperativa de Crédito');
            '3059':
                Exit('Caja Rural de Asturias, Sociedad Cooperativa de Crédito');
            '3089':
                Exit('Caja Rural de Baena Ntra. Sra. de Guadalupe Sociedad Cooperativa de Crédito Andaluza');
            '3060':
                Exit('Caja Rural de Burgos, Fuentepelayo, Segovia y Castelldans, Sociedad Cooperativa de Crédito');
            '3104':
                Exit('Caja Rural de Cañete de Las Torres Ntra. Sra. del Campo Sociedad Cooperativa Andaluza de Crédito');
            '3127':
                Exit('Caja Rural de Casas Ibáñez, S. Coop. de Crédito de Castilla-La Mancha');
            '3121':
                Exit('Caja Rural de Cheste, Sociedad Cooperativa de Crédito Valenciana');
            '3009':
                Exit('Caja Rural de Extremadura, Sociedad Cooperativa de Crédito');
            '3007':
                Exit('Caja Rural de Gijón, Sociedad Cooperativa Asturiana de Crédito');
            '3023':
                Exit('Caja Rural de Granada, Sociedad Cooperativa de Crédito');
            '3140':
                Exit('Caja Rural de Guissona, Sociedad Cooperativa de Crédito');
            '3067':
                Exit('Caja Rural de Jaén, Barcelona y Madrid, Sociedad Cooperativa de Crédito');
            '3008':
                Exit('Caja Rural de Navarra, S. Coop. de Crédito');
            '3098':
                Exit('Caja Rural de Nueva Carteya,  Sociedad Cooperativa Andaluza de Crédito');
            '3016':
                Exit('Caja Rural de Salamanca, Sociedad Cooperativa de Crédito');
            '3017':
                Exit('Caja Rural de Soria, Sociedad Cooperativa de Crédito');
            '3080':
                Exit('Caja Rural de Teruel, Sociedad Cooperativa de Crédito');
            '3020':
                Exit('Caja Rural de Utrera, Sociedad Cooperativa Andaluza de Crédito');
            '3144':
                Exit('Caja Rural de Villamalea, S. Coop. de Crédito Agrario de Castilla-La Mancha');
            '3152':
                Exit('Caja Rural de Villar, Coop. de Crédito V.');
            '3085':
                Exit('Caja Rural de Zamora, Cooperativa de Crédito');
            '3187':
                Exit('Caja Rural del Sur, S. Coop. de Crédito');
            '3157':
                Exit('Caja Rural La Junquera de Chilches, S. Coop. de Crédito V.');
            '3134':
                Exit('Caja Rural Nuestra Señora de la Esperanza de Onda, S. Coop. de Crédito V.');
            '3018':
                Exit('Caja Rural Regional San Agustín Fuente Álamo Murcia, Sociedad Cooperativa de Crédito');
            '3165':
                Exit('Caja Rural San Isidro de Vilafames S. Coop. de Crédito V.');
            '3119':
                Exit('Caja Rural San Jaime de Alquerías Niño Perdido S. Coop. de Crédito V.');
            '3113':
                Exit('Caja Rural San José de Alcora S. Coop. de Crédito V.');
            '3130':
                Exit('Caja Rural San José de Almassora, S. Coop. de Crédito V.');
            '3112':
                Exit('Caja Rural San José de Burriana, S. Coop. de Crédito V.');
            '3135':
                Exit('Caja Rural San José de Nules S. Coop. de Crédito V.');
            '3095':
                Exit('Caja Rural San Roque de Almenara S. Coop. de Crédito  V.');
            '3058':
                Exit('Cajamar Caja Rural, Sociedad Cooperativa de Crédito');
            '3076':
                Exit('Cajasiete, Caja Rural, Sociedad Cooperativa de Crédito');
            '0237':
                Exit('Cajasur Banco, S.A.');
            '8844':
                Exit('CASTELO CAPITAL EFC SA');
            '4706':
                Exit('Caterpillar Financial Corporación Financiera, S.A., E.F.C.');
            '0234':
                Exit('CBNK BANCO DE COLECTIVOS, S.A.');
            '2000':
                Exit('Cecabank, S.A.');
            '1553':
                Exit('China Construction Bank (Europe), S.A., Sucursal en España');
            '1474':
                Exit('Citibank Europe Plc, Sucursal en España');
            '1499':
                Exit('Claas Financial Services, S.A.S., Sucursal en España');
            '1546':
                Exit('CNH Industrial Capital Europe, S.A.S., Sucursal en España');
            '1543':
                Exit('Cofidis, S.A. Sucursal en España');
            '2056':
                Exit('Colonya - Caixa D''estalvis de Pollensa');
            '0159':
                Exit('Commerzbank Aktiengesellschaft, Sucursal en España');
            '1459':
                Exit('Cooperatieve Rabobank U.A., Sucursal en España');
            '8221':
                Exit('Corporación Hipotecaria Mutual, S.A., E.F.C.');
            '8841':
                Exit('CREDIT AGRICOLE CONSUMER FINANCE SPAIN, EFC, S.A.');
            '0154':
                Exit('Crédit Agricole Corporate and Investment Bank, Sucursal en España');
            '1472':
                Exit('Crédit Agricole Leasing & Factoring, Sucursal en España');
            '1555':
                Exit('Crédit Mutuel Leasing, Sucursal en España');
            '1460':
                Exit('Crédit Suisse Ag, Sucursal en España');
            '0243':
                Exit('Credit Suisse Bank (Europe), S.A.');
            '6716':
                Exit('Currencies Direct Spain, EDE, SL');
            '8842':
                Exit('DAIMLER TRUCK FINANCIAL SERVICES ESPAÑA E.F.C., S.A.U.');
            '1457':
                Exit('De Lage Landen International B.V., Sucursal en España');
            '1548':
                Exit('Dell Bank International Designated Activity Company, Sucursal en España');
            '0145':
                Exit('Deutsche Bank, A.G., Sucursal en España');
            '0019':
                Exit('Deutsche Bank, Sociedad Anónima Española');
            '8826':
                Exit('Deutsche Leasing Iberica, E.F.C.,  S.A.');
            '1501':
                Exit('Deutsche Pfandbriefbank AG, Sucursal en España');
            '0211':
                Exit('EBN Banco de Negocios, S.A.');
            '1473':
                Exit('Edmond de Rothschild (Europe), Sucursal en España');
            '3081':
                Exit('Eurocaja Rural, Sociedad Cooperativa de Crédito');
            '0239':
                Exit('Evo Banco S.A.');
            '0218':
                Exit('FCE Bank Plc Sucursal en España');
            '8308':
                Exit('Financiera Carrión, S.A., E.F.C.');
            '8805':
                Exit('Financiera El Corte Inglés E.F.C., S.A.');
            '8823':
                Exit('Financiera española de crédito a distancia, E.F.C., S.A.');
            '6718':
                Exit('FINPAY Entidad de Dineero Electrónico, S.A');
            //#¡VALOR!	Exit('FONDO NARANJA MONETARIO, FI');
            '8839':
                Exit('GCC Consumo, EFC, S.A');
            '1496':
                Exit('Genefim, Sucursal en España');
            '6702':
                Exit('Global Payment Moneytopay, EDE, SL');
            '1564':
                Exit('Goldman Sachs Bank Europe SE, Sucursal en España');
            '1497':
                Exit('Haitong Bank, S.A., Sucursal en España');
            '1504':
                Exit('Honda Bank GmbH, Sucursal en España');
            '0162':
                Exit('HSBC Continental Europe, Sucursal en España');
            '2085':
                Exit('Ibercaja Banco, S.A.');
            '4832':
                Exit('IBERCAJA SERVICIOS DE FINANCIACIÓN, ESTABLECIMIENTO FINANCIERO DE CRÉDITO, S.A.');
            '1514':
                Exit('IC FINANCIAL SERVICES, SUCURSAL EN ESPAÑA');
            '1538':
                Exit('Industrial and Commercial Bank of China (Europe) S.A., Sucursal en España');
            '1465':
                Exit('Ing Bank, N.V. Sucursal en España');
            '1000':
                Exit('Instituto de Crédito Oficial');
            '1494':
                Exit('Intesa Sanpaolo S.p.A., Sucursal en España');
            '1567':
                Exit('J.P. MORGAN SE, SUCURSAL EN ESPAÑA');
            '1482':
                Exit('John Deere Bank, S.A., Sucursal en España');
            '0151':
                Exit('JPMorgan Chase Bank National Association, Sucursal en España');
            // #¡VALOR!	Exit('KUTXABANK MONETARIO AHORRO, FI');
            '2095':
                Exit('Kutxabank, S.A.');
            '1547':
                Exit('Lombard Odier (Europe), S.A., Sucursal en España');
            '8342':
                Exit('Luzaro E.F.C. S.A');
            '6725':
                Exit('MANGOPAY SA SUCURSAL EN ESPAÑA');
            '1520':
                Exit('Mediobanca, Sucursal en España');
            '4799':
                Exit('Mercedes-Benz Financial Services España E.F.C., S.A.');
            '1552':
                Exit('Mirabaud & Cie (Europe) S.A., Sucursal en España');
            '0244':
                Exit('MIRALTA FINANCE BANK, S.A.');
            '1559':
                Exit('Mizuho Bank Europe N.V., Sucursal en España');
            '6723':
                Exit('MODULR FINANCE B.V., SUCURSAL EN ESPAÑA');
            '6720':
                Exit('Moneycorp Technologies Limited, S.E');
            '0160':
                Exit('MUFG Bank (Europe) N.V., Sucursal en España');
            // #¡VALOR!	Exit('Mutuafondo Dinero, FI');
            '1544':
                Exit('MYINVESTOR BANCO, S.A.');
            '1563':
                Exit('N26 BANK AG, SUCURSAL EN ESPAÑA');
            '1479':
                Exit('Natixis, S.A., Sucursal en España');
            '0133':
                Exit('Nuevo Micro Bank, S.A.');
            '8235':
                Exit('OCCIDENT HIPOTECARIA, EFC S.A');
            '1577':
                Exit('Oddo BHF SCA, Sucursal en España');
            '8814':
                Exit('Oney Servicios Financieros, E.F.C., S.A.');
            '0073':
                Exit('Open Bank, S.A.');
            '1568':
                Exit('Orange Bank, S.A., Sucursal en España');
            '6722':
                Exit('PAGONXT EMONEY EDE, S.L.');
            '6707':
                Exit('Pecunia Cards E.D.E. S.L');
            '6713':
                Exit('PFS Card Services Ireland Limited, S.E');
            '1508':
                Exit('RCI Banque, S.A., Sucursal en España');
            '0083':
                Exit('Renta 4 Banco, S.A.');
            '1583':
                Exit('REVOLUT BANK UAB SUCURSAL EN ESPAÑA');
            '3138':
                Exit('Ruralnostra, Sociedad Cooperativa de Crédito Valenciana');
            '0242':
                Exit('Sabadell Consumer Finance, S.A.');
            '0224':
                Exit('Santander Consumer Finance, S.A.');
            '8906':
                Exit('Santander Factoring y Confirming, S.A., E.F.C.');
            '0036':
                Exit('Santander Investment, S.A.');
            '4797':
                Exit('Santander Lease, S.A. EFC');
            '8845':
                Exit('SANTANDER MAPFRE HIPOTECA INVERSA, E.F.C., SA');
            '8813':
                Exit('Scania Finance Hispania, E.F.C., S.A.');
            '6705':
                Exit('Sefide, E.D.E. S.L.');
            '8795':
                Exit('Servicios Financieros Carrefour, E.F.C., S.A.');
            '8833':
                Exit('SG Equipment Finance Iberia, E.F.C., S.A.');
            '1490':
                Exit('Singular Bank, S.A.');
            '1551':
                Exit('SMBC Bank EU AG, Sucursal en España');
            '8816':
                Exit('Sociedad Conjunta para la Emisión y Gestión de Medios de Pago, E.F.C., S.A');
            '0108':
                Exit('Société Genérale, Sucursal en España');
            '1578':
                Exit('SOLARIS SE, SUCURSAL EN ESPAÑA');
            '8838':
                Exit('STELLANTIS FINANCIAL SERVICES ESPAÑA, E.F.C.,');
            '6724':
                Exit('SWAN IO SUCURSAL EN ESPAÑA');
            '0216':
                Exit('Targobank, S.A.');
            '8836':
                Exit('Telefonica Consumer Finance, EFC, S.A.');
            '1573':
                Exit('The Bank of New York Mellon SA/SV, S.E');
            '1570':
                Exit('The Governor and Company of the Bank of Ireland, Sucursal en España');
            '1487':
                Exit('Toyota Kreditbank GmbH, Sucursal en España');
            '4784':
                Exit('Transolver Finance, E.F.C., S.A.');
            '6721':
                Exit('TREEZOR S.A.S., SUCURSAL EN ESPAÑA');
            '1491':
                Exit('Triodos Bank, N.V., S.E.');
            '0226':
                Exit('UBS Europe SE, Sucursal en España');
            '2103':
                Exit('Unicaja Banco, S.A.');
            '1557':
                Exit('Unicredit, S.p.A., Sucursal en España');
            '8596':
                Exit('Unión Cto. Fin. Mob. e Inm., Credifimo, E.F.C., S.A.');
            '8512':
                Exit('Unión de Créditos Inmobiliarios, S.A., E.F.C.');
            '8769':
                Exit('Unión Financiera Asturiana, S.A., E.F.C.');
            '6719':
                Exit('Unnax Regulatory Services, EDE, SL');
            '6709':
                Exit('Up Aganea EDE, SA');
            '8806':
                Exit('VFS Financial Services Spain E.F.C., S.A.');
            '6715':
                Exit('Viva Payment Services, S.A. S.E.');
            '1480':
                Exit('Volkswagen Bank GmbH, Sucursal en España');
            '1575':
                Exit('Western Union International Bank GMBH, Sucursal en España');
            '0229':
                Exit('Wizink Bank, S.A.');
            '8840':
                Exit('Xfera Consumer Finance, E.F.C. S.A.');
            '1560':
                Exit('Younited, Sucursal en España');
        end;

    end;
    // PROCEDURE PrePadString(InString : Text[250];MaxLen: Integer) : Text[250];
    // BEGIN
    //   EXIT(PADSTR('', MaxLen - STRLEN(InString),'0') + InString);
    // END;

    PROCEDURE DevolverIBAN(codePrmPais: Code[10]; codePrmEntidad: Code[10]; codePrmSucursal: Code[10]; codePrmCCC: Code[20]): Code[30];
    VAR
        recPais: Record 9;
        intNumero: Integer;
        decResto: Decimal;
        decDigito: Decimal;
        codeDigito: Code[2];
        txtNumeroPrevio: Text[40];
        txtNumero: Text[40];
        intContador: Integer;
        decFactor: Decimal;
    BEGIN
        // Devolver IBAN.

        if codePrmPais <> '' THEN BEGIN
            if NOT recPais.GET(codePrmPais) THEN
                Error('El código de país no existe.');
            if recPais."EU Country/Region Code" = '' THEN
                recPais."EU Country/Region Code" := 'ES';
        END ELSE BEGIN
            recPais."EU Country/Region Code" := 'ES';
        END;

        if STRLEN(codePrmEntidad) <> 4 THEN
            Error('El código de entidad no tinen 4 caracteres.');

        if NOT EVALUATE(intNumero, codePrmEntidad) THEN
            Error('El código de entidad no es numérico.');

        if STRLEN(codePrmSucursal) <> 4 THEN
            Error('El código de sucursal no tinen 4 caracteres.');

        if NOT EVALUATE(intNumero, codePrmSucursal) THEN
            Error('El código de sucursal no es numérico.');

        if STRLEN(codePrmCCC) <> 20 THEN
            Error('El código de cuenta no tiene 20 caracteres.');

        txtNumeroPrevio := STRSUBSTNO('%1%2%3', codePrmCCC, recPais."EU Country/Region Code", '00');

        FOR intContador := 1 TO STRLEN(txtNumeroPrevio) DO BEGIN
            CASE txtNumeroPrevio[intContador] OF
                'A':
                    txtNumero += '10';
                'B':
                    txtNumero += '11';
                'C':
                    txtNumero += '12';
                'D':
                    txtNumero += '13';
                'E':
                    txtNumero += '14';
                'F':
                    txtNumero += '15';
                'G':
                    txtNumero += '16';
                'H':
                    txtNumero += '17';
                'I':
                    txtNumero += '18';
                'J':
                    txtNumero += '19';
                'K':
                    txtNumero += '20';
                'L':
                    txtNumero += '21';
                'M':
                    txtNumero += '22';
                'N':
                    txtNumero += '23';
                'O':
                    txtNumero += '24';
                'P':
                    txtNumero += '25';
                'Q':
                    txtNumero += '26';
                'R':
                    txtNumero += '27';
                'S':
                    txtNumero += '28';
                'T':
                    txtNumero += '29';
                'U':
                    txtNumero += '30';
                'V':
                    txtNumero += '31';
                'W':
                    txtNumero += '32';
                'X':
                    txtNumero += '33';
                'Y':
                    txtNumero += '34';
                'Z':
                    txtNumero += '35';
                ELSE
                    txtNumero += FORMAT(txtNumeroPrevio[intContador])
            END;
        END;

        if NOT EVALUATE(decResto, Mod_Text(txtNumero, 97)) THEN
            Error('El dígito de control no es correcto.');

        decDigito := 98 - decResto;

        codeDigito := FORMAT(decDigito);

        if STRLEN(codeDigito) = 1 THEN
            codeDigito := '0' + codeDigito;

        EXIT(STRSUBSTNO('%1%2%3', recPais."EU Country/Region Code", codeDigito, codePrmCCC));
    END;

    PROCEDURE DevolverSWIFT(codePrmPais: Code[10]; codePrmEntidad: Code[10]): Code[20];
    VAR
        recPais: Record 9;
        intNumero: Integer;
        decResto: Decimal;
        decDigito: Decimal;
        codeDigito: Code[2];
        txtNumeroPrevio: Text[40];
        txtNumero: Text[40];
        intContador: Integer;
        decFactor: Decimal;
    BEGIN

        // -SW
        // Devolver SWIFT
        if codePrmPais = '' THEN codePrmPais := 'ES';
        if codePrmPais <> '' THEN BEGIN
            if NOT recPais.GET(codePrmPais) THEN
                codePrmPais := 'ES';
            if recPais."EU Country/Region Code" = '' THEN
                recPais."EU Country/Region Code" := 'ES';
        END ELSE BEGIN
            recPais."EU Country/Region Code" := 'ES';
        END;

        if recPais."EU Country/Region Code" <> 'ES' THEN
            EXIT('');

        CASE codePrmEntidad OF
            '0003':
                EXIT('BDEPESM1XXX');
            '0004':
                EXIT('BANDESSSXXX');
            '0008':
                EXIT('BSABESBBXXX');
            '0010':
                EXIT('BBVAESMMXXX');
            '0011':
                EXIT('ALLFESMMXXX');
            '0013':
                EXIT('SLBKESBBXXX');
            '0015':
                EXIT('CATAESBBXXX');
            '0016':
                EXIT('CENTESMM');
            '0019':
                EXIT('DEUTESBBXXX');
            '0020':
                EXIT('BCIOESMMXXX');
            '0021':
                EXIT('BCNDESM1XXX');
            '0024':
                EXIT('BALEES22XXX');
            '0029':
                EXIT('CRLEESMMXXX');
            '0030':
                EXIT('ESPCESMMXXX');
            '0031':
                EXIT('ETCHES2GXXX');
            '0036':
                EXIT('SABNESMMXXX');
            '0041':
                EXIT('CAIXESBBXXX');
            '0042':
                EXIT('BGUIES22XXX');
            '0046':
                EXIT('GALEES2GXXX');
            '0049':
                EXIT('BSCHESMMXXX');
            '0057':
                EXIT('BVADESMMXXX');
            '0058':
                EXIT('BNPAESMMXXX');
            '0059':
                EXIT('MADRESMMXXX');
            '0061':
                EXIT('BMARES2MXXX');
            '0065':
                EXIT('BARCESMMXXX');
            '0072':
                EXIT('PSTRESMMXXX');
            '0073':
                EXIT('OPENESMMXXX');
            '0075':
                EXIT('POPUESMMXXX');
            '0078':
                EXIT('BAPUES22XXX');
            '0081':
                EXIT('BSABESBBXXX');
            '0083':
                EXIT('RENBESMMXXX');
            '0086':
                EXIT('NORTESMMXXX');
            '0093':
                EXIT('VALEESVVXXX');
            '0094':
                EXIT('BVALESMMXXX');
            '0099':
                EXIT('AHCRESVVXXX');
            '0106':
                EXIT('LOYDESMMXXX');
            '0107':
                EXIT('BNLIESM1XXX');
            '0108':
                EXIT('SOGEESMMXXX');
            '0113':
                EXIT('INBBESM1XXX');
            '0121':
                EXIT('OCBAESM1XXX');
            '0122':
                EXIT('CITIES2XXXX');
            '0125':
                EXIT('BAOFESM1XXX');
            '0128':
                EXIT('BKBKESMMXXX');
            '0129':
                EXIT('INALESM1XXX');
            '0130':
                EXIT('CGDIESMMXXX');
            '0131':
                EXIT('BESMESMMXXX');
            '0132':
                EXIT('PRNEESM1XXX');
            '0133':
                EXIT('MIKBESB1XXX');
            '0136':
                EXIT('AREBESMMXXX');
            '0138':
                EXIT('BKOAES22XXX');
            '0144':
                EXIT('PARBESMXXXX');
            '0145':
                EXIT('DEUTESM1XXX');
            '0149':
                EXIT('BNPAESMSXXX');
            '0151':
                EXIT('CHASESM3XXX');
            '0152':
                EXIT('BPLCESMMXXX');
            '0154':
                EXIT('BSUIESMMXXX');
            '0155':
                EXIT('BRASESMMXXX');
            '0156':
                EXIT('ABNAESMMXXX');
            '0159':
                EXIT('COBAESMXXXX');
            '0160':
                EXIT('BOTKESMXXXX');
            '0161':
                EXIT('BKTRESM1XXX');
            '0162':
                EXIT('MIDLESMMXXX');
            '0167':
                EXIT('GEBAESMMXXX');
            '0168':
                EXIT('BBRUESMXXXX');
            '0169':
                EXIT('NACNESMMXXX');
            '0182':
                EXIT('BBVAESMMXXX');
            '0184':
                EXIT('BEDFESM1XXX');
            '0186':
                EXIT('BFIVESBBXXX');
            '0188':
                EXIT('ALCLESMMXXX');
            '0190':
                EXIT('BBPIESMMXXX');
            '0196':
                EXIT('WELAESMMXXX');
            '0198':
                EXIT('BCOEESMMXXX');
            '0200':
                EXIT('PRVBESB1XXX');
            '0205':
                EXIT('DECRESM1XXX');
            '0211':
                EXIT('PROAESMMXXX');
            '0216':
                EXIT('POHIESMMXXX');
            '0217':
                EXIT('HLFXESMMXXX');
            '0218':
                EXIT('FCEFESM1XXX');
            '0219':
                EXIT('BMCEESMMXXX');
            '0220':
                EXIT('FIOFESM1XXX');
            '0223':
                EXIT('GEECESB1XXX');
            '0224':
                EXIT('SCFBESMMXXX');
            '0225':
                EXIT('FIEIESM1XXX');
            '0226':
                EXIT('UBSWESMMXXX');
            '0227':
                EXIT('UNOEESM1XXX');
            '0228':
                EXIT('IXIUESM1XXX');
            '0229':
                EXIT('POPLESMMXXX');
            '0231':
                EXIT('DSBLESMMXXX');
            '0232':
                EXIT('INVLESMMXXX');
            '0233':
                EXIT('POPIESMMXXX');
            '0234':
                EXIT('CCOCESMMXXX');
            '0235':
                EXIT('PIESESM1XXX');
            '0236':
                EXIT('LOYIESMMXXX');
            '0237':
                EXIT('CSURES2CXXX');
            '0238':
                EXIT('PSTRESMMXXX');
            '0239':
                EXIT('CAGLESMMXXX');
            '0486':
                EXIT('TRESES2BXXX');
            '0487':
                EXIT('GBMNESMMXXX');
            '0488':
                EXIT('BFASESMMXXX');
            '0490':
                EXIT('GBCCESMMXXX');
            '1000':
                EXIT('ICROESMMXXX');
            '1113':
                EXIT('BSUDESM1XXX');
            '1116':
                EXIT('SCSIESM1XXX');
            '1127':
                EXIT('SCBLESM1XXX');
            '1156':
                EXIT('IRVTESM1XXX');
            '1164':
                EXIT('ESBFESM1XXX');
            '1168':
                EXIT('BNACESM1XXX');
            '1173':
                EXIT('COURESB1XXX');
            '1182':
                EXIT('HYVEESM1XXX');
            '1191':
                EXIT('HANDES21XXX');
            '1193':
                EXIT('PKBSES21XXX');
            '1196':
                EXIT('AEEVESM1XXX');
            '1197':
                EXIT('BILLESB1XXX');
            '1199':
                EXIT('CRGEESM1XXX');
            '1209':
                EXIT('ABCMESM1XXX');
            '1210':
                EXIT('REDEESM1XXX');
            '1221':
                EXIT('PNBMESM1XXX');
            '1224':
                EXIT('RHRHESM1XXX');
            '1227':
                EXIT('BSSAESB1XXX');
            '1231':
                EXIT('BOCAES21XXX');
            '1233':
                EXIT('BCMAESM1XXX');
            '1234':
                EXIT('PRBAESM1XXX');
            '1236':
                EXIT('HELAESM1XXX');
            '1238':
                EXIT('BIMEESM1XXX');
            '1240':
                EXIT('LOFPESB1XXX');
            '1241':
                EXIT('STOLESM1XXX');
            '1242':
                EXIT('SOLAESB1XXX');
            '1245':
                EXIT('BEIVESM1XXX');
            '1248':
                EXIT('WAFAESM1XXX');
            '1249':
                EXIT('NPBSES21XXX');
            '1251':
                EXIT('IHZUES21XXX');
            '1255':
                EXIT('AARBESM1XXX');
            '1302':
                EXIT('BBVAESMMXXX');
            '1451':
                EXIT('CRCGESB1XXX');
            '1454':
                EXIT('NEWGESM1XXX');
            '1457':
                EXIT('LLISESM1XXX');
            '1459':
                EXIT('PRABESMMXXX');
            '1460':
                EXIT('CRESESMMXXX');
            '1462':
                EXIT('ASSCESM1XXX');
            '1463':
                EXIT('PSABESM1XXX');
            '1464':
                EXIT('NFFSESM1XXX');
            '1465':
                EXIT('INGDESMMXXX');
            '1466':
                EXIT('FRANESM1XXX');
            '1467':
                EXIT('EHYPESMXXXX');
            '1469':
                EXIT('SHSAESM1XXX');
            '1470':
                EXIT('BPIPESM1XXX');
            '1472':
                EXIT('UCSSESM1XXX');
            '1473':
                EXIT('PRIBESMXXXX');
            '1474':
                EXIT('CITIESMXXXX');
            '1475':
                EXIT('CCSEESM1XXX');
            '1478':
                EXIT('MLIBESM1XXX');
            '1479':
                EXIT('NATXESMMXXX');
            '1480':
                EXIT('VOWAES21XXX');
            '1485':
                EXIT('BOFAES2XXXX');
            '1488':
                EXIT('PICTESMMXXX');
            '1490':
                EXIT('SELFESMMXXX');
            '1491':
                EXIT('TRIOESMMXXX');
            '1494':
                EXIT('BCITESMMXXX');
            '1497':
                EXIT('ESSIESMMXXX');
            '1501':
                EXIT('DPBBESM1XXX');
            '1502':
                EXIT('IKBDESM1XXX');
            '1505':
                EXIT('ARABESMMXXX');
            '1506':
                EXIT('MLCBESM1XXX');
            '1522':
                EXIT('EFGBESMMXXX');
            '1524':
                EXIT('UBIBESMMXXX');
            '1525':
                EXIT('BCDMESMMXXX');
            '1534':
                EXIT('KBLXESMMXXX');
            '1538':
                EXIT('ICBKESMMXXX');
            '1544':
                EXIT('BACAESMMXXX');
            '2000':
                EXIT('CECAESMMXXX');
            '2010':
                EXIT('CECAESMM1');
            '2013':
                EXIT('CESCESBBXXX');
            '2017':
                EXIT('CECAESMM17');
            '2018':
                EXIT('CECAESMM18');
            '2031':
                EXIT('CECAESMM31');
            '2038':
                EXIT('CAHMESMMXXX');
            '2043':
                EXIT('CECAESMM43');
            '2045':
                EXIT('CECAESMM45');
            '2048':
                EXIT('CECAESMM48');
            '2051':
                EXIT('CECAESMM51');
            '2052':
                EXIT('CECAESMM52');
            '2056':
                EXIT('CECAESMM56');
            '2059':
                EXIT('CECAESMM59');
            '2066':
                EXIT('CECAESMM66');
            '2080':
                EXIT('CAGLESMMVIG');
            '2081':
                EXIT('CECAESMM81');
            '2085':
                EXIT('CAZRES2ZXXX');
            '2086':
                EXIT('CECAESMM86');
            '2095':
                EXIT('BASKES2BXXX');
            '2096':
                EXIT('CSPAES2LXXX');
            '2099':
                EXIT('CECAESMM99');
            '2100':
                EXIT('CAIXESBBXXX');
            '2101':
                EXIT('CGGKES22XXX');
            '2103':
                EXIT('UCJAES2MXXX');
            '2104':
                EXIT('CSSOES2SXXX');
            '2105':
                EXIT('CECAESMM15');
            '2107':
                EXIT('BBVAESMM17');
            '2108':
                EXIT('CSPAES2L18');
            '2404':
                EXIT('CECAESMM52');
            '2405':
                EXIT('CECAESMM42');
            '2406':
                EXIT('CECAESMM37');
            '2408':
                EXIT('CECAESMM69');
            '2410':
                EXIT('CANVES2PXXX');
            '2411':
                EXIT('CECAESMM16');
            '2412':
                EXIT('CECAESMM65');
            '2413':
                EXIT('CECAESMM18');
            '2415':
                EXIT('CECAESMM99');
            '2416':
                EXIT('CECAESMM66');
            '2421':
                EXIT('CECAESMM31');
            '2422':
                EXIT('CECAESMM43');
            '2423':
                EXIT('CECAESMM81');
            '2424':
                EXIT('CECAESMM51');
            '3001':
                EXIT('BCOEESMM1');
            '3005':
                EXIT('BCOEESMM5');
            '3007':
                EXIT('BCOEESMM7');
            '3008':
                EXIT('BCOEESMM8');
            '3009':
                EXIT('BCOEESMM9');
            '3016':
                EXIT('BCOEESMM16');
            '3017':
                EXIT('BCOEESMM17');
            '3018':
                EXIT('BCOEESMM18');
            '3020':
                EXIT('BCOEESMM2');
            '3023':
                EXIT('BCOEESMM23');
            '3025':
                EXIT('CDENESBBXXX');
            '3029':
                EXIT('CCRIES2A29');
            '3035':
                EXIT('CLPEES2MXXX');
            '3045':
                EXIT('CCRIES2A45');
            '3058':
                EXIT('CCRIES2AXXX');
            '3059':
                EXIT('BCOEESMM59');
            '3060':
                EXIT('BCOEESMM6');
            '3063':
                EXIT('BCOEESMM63');
            '3067':
                EXIT('BCOEESMM67');
            '3070':
                EXIT('BCOEESMM7');
            '3076':
                EXIT('BCOEESMM76');
            '3080':
                EXIT('BCOEESMM8');
            '3081':
                EXIT('BCOEESMM81');
            '3082':
                EXIT('CCRIES2A82');
            '3084':
                EXIT('CVRVES2BXXX');
            '3085':
                EXIT('BCOEESMM85');
            '3089':
                EXIT('BCOEESMM89');
            '3095':
                EXIT('CCRIES2A95');
            '3096':
                EXIT('BCOEESMM96');
            '3098':
                EXIT('BCOEESMM98');
            '3102':
                EXIT('BCOEESMM12');
            '3104':
                EXIT('BCOEESMM14');
            '3105':
                EXIT('CCRIES2A15');
            '3110':
                EXIT('BCOEESMM11');
            '3111':
                EXIT('BCOEESMM111');
            '3112':
                EXIT('CCRIES2A112');
            '3113':
                EXIT('BCOEESMM113');
            '3114':
                EXIT('CCRIES2A114');
            '3115':
                EXIT('BCOEESMM115');
            '3116':
                EXIT('BCOEESMM116');
            '3117':
                EXIT('BCOEESMM117');
            '3118':
                EXIT('CCRIES2A118');
            '3119':
                EXIT('CCRIES2A119');
            '3121':
                EXIT('CCRIES2A121');
            '3123':
                EXIT('CCRIES2A123');
            '3127':
                EXIT('BCOEESMM127');
            '3130':
                EXIT('BCOEESMM13');
            '3134':
                EXIT('BCOEESMM134');
            '3135':
                EXIT('CCRIES2A135');
            '3137':
                EXIT('CCRIES2A137');
            '3138':
                EXIT('BCOEESMM138');
            '3140':
                EXIT('BCOEESMM14');
            '3144':
                EXIT('BCOEESMM144');
            '3146':
                EXIT('CCCVESM1XXX');
            '3150':
                EXIT('BCOEESMM15');
            '3152':
                EXIT('CCRIES2A152');
            '3157':
                EXIT('CCRIES2A157');
            '3159':
                EXIT('BCOEESMM159');
            '3160':
                EXIT('CCRIES2A16');
            '3162':
                EXIT('BCOEESMM162');
            '3165':
                EXIT('CCRIES2A165');
            '3166':
                EXIT('BCOEESMM166');
            '3171':
                EXIT('CXAVESB1XXX');
            '3172':
                EXIT('CCOCESMMXXX');
            '3174':
                EXIT('BCOEESMM174');
            '3177':
                EXIT('BCOEESMM177');
            '3179':
                EXIT('CCRIES2A179');
            '3183':
                EXIT('CASDESBBXXX');
            '3186':
                EXIT('CCRIES2A186');
            '3187':
                EXIT('BCOEESMM187');
            '3188':
                EXIT('CCRIES2A188');
            '3190':
                EXIT('BCOEESMM19');
            '3191':
                EXIT('BCOEESMM191');
            '6814':
                EXIT('MNTYESMMXXX');
            '8233':
                EXIT('CSFAESM1XXX');
            '8512':
                EXIT('UCINESMMXXX');
            '9000':
                EXIT('ESPBESMMXXX');

            '3524':
                EXIT('AHCFESMMXXX');
            '3604':
                EXIT('CAPIESMMXXX');
            'BXXX':
                EXIT('CDENESBBXXX');
            '3656':
                EXIT('CSSOES2SFIN');
            '3682':
                EXIT('GVCBESBBETB');
            '9096':
                EXIT('IBRCESMMXXX');
            '3575':
                EXIT('INSGESMMXXX');
            '9020':
                EXIT('IPAYESMMXXX');
            '3669':
                EXIT('IVALESMMXXX');
            '3641':
                EXIT('LISEESMMXXX');
            '9094':
                EXIT('MEFFESBBXXX');
            '3563':
                EXIT('MISVESMMXXX');
            '3661':
                EXIT('MLCEESMMXXX');
            '3501':
                EXIT('RENTESMMXXX');
            '9091':
                EXIT('XBCNESBBXXX');
            '9092':
                EXIT('XRBVES2BXXX');
            '9093':
                EXIT('XRVVESVVXXX');
        END;

        EXIT('');

        // +SW
    END;

    PROCEDURE Mod_Text(sModulus: Code[30]; iTeiler: Integer): Code[2];
    VAR
        sRest: Code[30];
        sErg: Code[30];
        iStart: Integer;
        iEnd: Integer;
        iResult: Integer;
        iRestTmp: Integer;
        iBuffer: Integer;
    BEGIN
        iStart := 1;
        iEnd := 1;
        WHILE (iEnd <= STRLEN(sModulus)) DO BEGIN
            EVALUATE(iBuffer, sRest + COPYSTR(sModulus, iStart, iEnd - iStart + 1));

            if (iBuffer >= iTeiler) THEN BEGIN
                iResult := ROUND(iBuffer / iTeiler, 1, '<');
                iRestTmp := iBuffer - (iResult * iTeiler);
                sRest := FORMAT(iRestTmp);

                sErg := sErg + FORMAT(iResult);

                iStart := iEnd + 1;
                iEnd := iStart;
            END ELSE BEGIN
                if (sErg <> '') THEN
                    sErg := sErg + '0';

                iEnd := iEnd + 1;
            END;
        END;

        if (iStart <= STRLEN(sModulus)) THEN
            sRest := sRest + COPYSTR(sModulus, iStart);

        if sRest = '000' THEN
            sRest := '00';

        EXIT(sRest);
    END;

    PROCEDURE CompruebaDigito(CCCBankNo: Text; CCCBankBranchNo: Text; CCCBankAccountNo: Text; CCCControlDigits: Text): Boolean;
    VAR
        A: ARRAY[19] OF Integer;
        t: Integer;
        DG1: Integer;
        DG2: Integer;
        C: Decimal;
        D: Integer;
        DC: Text[30];
        B: ARRAY[19] OF Integer;
    BEGIN
        B[1] := 4;
        B[2] := 8;
        B[3] := 5;
        B[4] := 10;
        B[5] := 9;
        B[6] := 7;
        B[7] := 3;
        B[8] := 6;
        B[9] := 1;
        B[10] := 2;
        B[11] := 4;
        B[12] := 8;
        B[13] := 5;
        B[14] := 10;
        B[15] := 9;
        B[16] := 7;
        B[17] := 3;
        B[18] := 6;
        FOR t := 1 TO 18 DO BEGIN
            if not Evaluate(A[t], CopyStr(CCCBankNo + CCCBankBranchNo + CCCBankAccountNo, t, 1)) then
                exit;

        END;
        FOR t := 1 TO 8 DO BEGIN
            DG1 := DG1 + (A[t] * B[t]);
        END;
        FOR t := 9 TO 18 DO BEGIN
            DG2 := DG2 + (A[t] * B[t]);
        END;
        C := DG1 / 11;
        D := ROUND(C, 1, '<');
        if (D * 11) > DG1 THEN
            DG1 := (D * 11) - DG1
        ELSE
            DG1 := DG1 - (D * 11);
        DG1 := 11 - DG1;
        if DG1 = 10 THEN DG1 := 1;
        if DG1 = 11 THEN DG1 := 0;
        C := DG2 / 11;
        D := ROUND(C, 1, '<');
        if (D * 11) > DG2 THEN
            DG2 := (D * 11) - DG2
        ELSE
            DG2 := DG2 - (D * 11);
        DG2 := 11 - DG2;
        if DG2 = 10 THEN DG2 := 1;
        if DG2 = 11 THEN DG2 := 0;
        DC := STRSUBSTNO('%1%2', DG1, DG2);
        if DC <> CCCControlDigits THEN ERROR('El dígito de control es %1 ', DC);
        EXIT(TRUE);
    END;

}