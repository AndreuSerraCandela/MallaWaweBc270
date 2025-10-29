/// <summary>
/// Table Lineas Auxiliares (ID 7001194).
/// </summary>
table 7001194 "Lineas Auxiliares"
{

    fields
    {
        field(1; "Nº Linea"; Integer)
        {
            Caption = 'Nº Linea';
            Description = 'PK';
            Editable = false;
        }
        field(5; "Proveedor"; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Proveedor';
            Description = 'FK Proveedores';
        }
        field(10; "Nombre diario"; Code[10])
        {
            TableRelation = "Gen. Journal Template";
            Caption = 'falsembre diario';
            Description = 'FK Libro del diario general';
        }
        field(15; "Nombre sección"; Code[10])
        {
            TableRelation = "Gen. Journal Batch";
            Caption = 'falsembre sección';
            Description = 'FK Seccion diario general';
        }
        field(20; "Fecha Vto."; Date)
        {
            Caption = 'Fecha Vto.';
        }
        field(25; "Importe"; Decimal)
        {
            Caption = 'Importe';
            AutoFormatType = 1;
            AutoFormatExpression = "Cod. Divisa";
        }
        field(30; "Cod. Divisa"; Code[10])
        {
            TableRelation = Currency;
            Caption = 'Cod. Divisa';
            Description = 'FK Divisa';
        }
        field(35; "Banco"; Code[20])
        {
            TableRelation = "Bank Account";
            Caption = 'Banco';
            Description = 'FK Banco';
        }
        field(36; "Nº Pagaré"; Code[20])
        {
            Caption = 'Nº Pagaré';
        }
        field(37; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Cód. dim. acceso dir. 1';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            END;

            trigger OnLookup()
            BEGIN
                // PLB 16/08/2004 Limitador cuentas
                LookupShortcutDimCode(1, "Shortcut Dimension 1 Code");
            END;

        }
        field(38; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Cód. dim. acceso dir. 2';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            END;

            trigger OnLookup()
            BEGIN
                // PLB 16/08/2004 Limitador cuentas
                LookupShortcutDimCode(2, "Shortcut Dimension 2 Code");
            END;

        }
        field(40; "Cod. tesoreria"; Code[10])
        {
            TableRelation = "Standard Text";
            Caption = 'Cod. tesoreria';
            Description = 'FK Concepto estándar';
        }
        field(42; "Cod. auditoria"; Code[10])
        {
            TableRelation = "Standard Text";
            Caption = 'Cod. auditoria';
            Description = 'FK Cód. auditoría';
        }
        field(43; "Nº mov. dimension"; Integer) { Caption = 'Nº mov. dimensión'; }
    }
    KEYS
    {
        key(P; "Nº Linea") { Clustered = true; }
        key(V; Proveedor) { }
    }
    VAR
        DimMgt: Codeunit DimensionManagement;
        GLSetupShortcutDimCode: ARRAY[8] OF Code[20];
        HasGotGLSetup: Boolean;

    PROCEDURE ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]);
    VAR
        wCode: Code[20];
    BEGIN
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        UpdateLedEntryDim(DATABASE::"Lineas Auxiliares", "Nº Linea", FieldNumber, wCode, ShortcutDimCode);
    END;

    PROCEDURE LookupShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]);
    VAR
        wLookUpPersonalizado: Boolean;
        wCuenta: Code[20];
        wCode: Code[20];
    BEGIN
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        UpdateLedEntryDim(DATABASE::"Lineas Auxiliares", "Nº Linea", FieldNumber, wCode, ShortcutDimCode);
    END;

    PROCEDURE UpdateLedEntryDim(TableID: Integer; EntryNo: Integer; GlobalDim: Integer; VAR DimCode: Code[20]; VAR DimValue: Code[20]);
    VAR
        LedgEntryDim: Record 355;
        RecRef: RecordRef;
        xRecRef: RecordRef;
        ChangeLogMgt: Codeunit "Change Log Management";
    BEGIN
        ///  REVISAR
        // GetGLSetup;

        // if DimCode = '' THEN
        //     DimCode := GLSetupShortcutDimCode[GlobalDim];

        // if DimValue = '' THEN BEGIN
        //     if LedgEntryDim.GET(TableID, EntryNo, DimCode) THEN BEGIN
        //         RecRef.GETTABLE(LedgEntryDim);
        //         LedgEntryDim.DELETE;
        //         ChangeLogMgt.LogDeletion(RecRef);
        //     END;
        // END
        // ELSE
        //     if LedgEntryDim.GET(TableID, EntryNo, DimCode) THEN BEGIN
        //         xRecRef.GETTABLE(LedgEntryDim);

        //         LedgEntryDim."Dimension Value Code" := DimValue;
        //         LedgEntryDim.MODIFY;

        //         RecRef.GETTABLE(LedgEntryDim);
        //         ChangeLogMgt.LogModification(RecRef, xRecRef);
        //     END
        //     ELSE BEGIN
        //         LedgEntryDim."Table ID" := TableID;
        //         LedgEntryDim."Entry No." := EntryNo;
        //         LedgEntryDim."Dimension Code" := DimCode;
        //         LedgEntryDim."Dimension Value Code" := DimValue;
        //         LedgEntryDim.INSERT;

        //         // log de cambios
        //         RecRef.GETTABLE(LedgEntryDim);
        //         ChangeLogMgt.LogInsertion(RecRef);
        //     END;
    END;

    LOCAL PROCEDURE GetGLSetup();
    VAR
        GLSetup: Record "General Ledger Setup";
    BEGIN
        if NOT HasGotGLSetup THEN BEGIN
            GLSetup.GET;
            GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup := TRUE;
        END;
    END;


}

