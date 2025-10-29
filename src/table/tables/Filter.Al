/// <summary>
/// Table Table Filter User (ID 7001198).
/// </summary>
table 7001198 "Table Filter User"
{
    Caption = 'Table Filter';

    fields
    {
        field(1; "User Id"; Text[50])
        { }
        field(2; "Table Number"; Integer)
        {
            Caption = 'Table Number';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
        }
        field(5; "Field Number"; Integer)
        {
            Caption = 'Field Number';
            TableRelation = Field."No." WHERE(TableNo = FIELD("Table Number"));

            trigger OnValidate()
            var
                "Field": Record "Field";
                TypeHelper: Codeunit "Type Helper";
            begin
                if xRec."Field Number" = "Field Number" then
                    exit;

                Field.Get("Table Number", "Field Number");
                TypeHelper.TestFieldIsNotObsolete(Field);
                CheckDuplicateField(Field);

                "Field Caption" := Field."Field Caption";
                "Field Filter" := '';
            end;
        }
        field(6; "Field Name"; Text[30])
        {
            Caption = 'Field Name';
        }
        field(7; "Field Caption"; Text[80])
        {
            Caption = 'Field Caption';
        }
        field(8; "Field Filter"; Text[250])
        {
            Caption = 'Field Filter';
        }
    }

    keys
    {
        key(Key1; "User Id", "Table Number", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'The filter for the field %1 %2 already exists.', Comment = 'The filter for the field <Field Number> <Field Name> already exists. Example: The filter for the field 15 Base Unit of Measure already exists.';
        Text000: Label 'The filters are too large to be copied to the type "TableFilter".';
        SourceTableNumber: Integer;
        SourceTableName: Text;
        SourceTableCaption: Text;
    /// <summary>
    /// CheckDuplicateField.
    /// </summary>
    /// <param name="Field">Record "Field".</param>
    procedure CheckDuplicateField("Field": Record "Field")
    var
        TableFilter: Record "Table Filter User";
    begin
        TableFilter.Copy(Rec);
        Reset();
        SetRange("User Id", Rec."User Id");
        SetRange("Table Number", Field.TableNo);
        SetRange("Field Number", Field."No.");
        SetFilter("Line No.", '<>%1', "Line No.");
        if not IsEmpty() then
            Error(Text001, Field."No.", Field."Field Caption");
        Copy(TableFilter);
    end;


    local procedure FillSourceRecord("Field": Record "Field")
    begin
        SetRange("Field Number");
        Init();
        "User Id" := UserId;
        "Table Number" := Field.TableNo;
        "Table Name" := Field.TableName;
        "Field Number" := Field."No.";
        "Field Name" := Field.FieldName;
        "Field Caption" := Field."Field Caption";
    end;

    /// <summary>
    /// SetSourceTable.
    /// </summary>
    /// <param name="TableFilterText">Text.</param>
    /// <param name="NewTableNumber">Integer.</param>
    /// <param name="NewTableCaption">Text.</param>
    procedure SetSourceTable(TableFilterText: Text; NewTableNumber: Integer; NewTableCaption: Text)
    var
        AllObj: Record AllObj;
    begin
        SourceTableNumber := NewTableNumber;
        AllObj.SetRange("Object Type", AllObj."Object Type"::Table);
        AllObj.SetRange("Object ID", NewTableNumber);
        if AllObj.FindFirst() then
            SourceTableName := AllObj."Object Name";
        SourceTableCaption := NewTableCaption;
        InitSourceTable();
        if StrLen(TableFilterText) > 0 then
            ParseTableFilter(TableFilterText);
    end;

    local procedure InitSourceTable()
    begin
        Init();
        "User Id" := UserId;
        "Table Number" := SourceTableNumber;
        "Table Name" := SourceTableName;
        "Line No." := 0;
    end;

    local procedure ParseTableFilter(TableFilterText: Text)
    begin
        // Parsing a TableFilter text representation into the TableName and Field filters.
        // TableFilter text format:
        // <table name>: <field name>=<field filter>,<field name 2>=<field filter 2>...
        // Table name can be wrapped into double quotes if it contains a colon;
        // field names can be wrapped into double quotes if they contain the equal sign;
        // field filters can be wrapped into double quotes if they contain a comma.
        // if a value is wrapped into the double quotes,the double quote characters possibly contained in the value are escaped by another double quote.

        // if not TableNameMatches(TableFilterText) then
        //   exit;

        // Read field names and field filters:
        while StrLen(TableFilterText) > 0 do begin
            ExtractFieldName(TableFilterText);
            ExtractFieldFilter(TableFilterText);
        end;
    end;

    local procedure GetValue(var TextString: Text; Delimiter: Text) PartOfText: Text
    var
        DelimiterPosition: Integer;
    begin
        DelimiterPosition := StrPos(TextString, Delimiter);
        if DelimiterPosition = 0 then begin
            // if delimiter wasn't found read everything until the end of the string:
            PartOfText := CopyStr(TextString, 1, StrLen(TextString));
            TextString := '';
        end else begin
            PartOfText := CopyStr(TextString, 1, DelimiterPosition - 1);
            TextString := CopyStr(TextString, DelimiterPosition + 1, StrLen(TextString) - DelimiterPosition);
        end;

        exit(PartOfText);
    end;

    local procedure GetQuotedValue(var TextString: Text; Delimiter: Text) PartOfText: Text
    var
        Position: Integer;
        Length: Integer;
        OneCharString: Text;
        IsQuote: Boolean;
        IsDelimiter: Boolean;
        EvenQuote: Boolean;
    begin
        // Remove the first quote:
        TextString := CopyStr(TextString, 2, StrLen(TextString) - 1);
        Length := StrLen(TextString);

        EvenQuote := false;
        Position := 1;
        while Position <= Length do begin
            OneCharString := CopyStr(TextString, Position, 1);

            IsDelimiter := OneCharString = Delimiter;
            if IsDelimiter and EvenQuote then begin
                PartOfText := CopyStr(TextString, 1, Position - 2);
                PartOfText := UnescapeQuotedValue(PartOfText);
                TextString := CopyStr(TextString, Position + 1, StrLen(TextString) - Position);
                exit(PartOfText);
            end;

            IsQuote := StrPos(OneCharString, '"') = 1;
            if IsQuote then
                EvenQuote := not EvenQuote;

            Position += 1;
        end;

        // if delimiter wasn't found read everything until the end of the string,excluding the closing quote:
        PartOfText := CopyStr(TextString, 1, Position - 2);
        PartOfText := UnescapeQuotedValue(PartOfText);
        TextString := '';
        exit(PartOfText);
    end;

    local procedure UnescapeQuotedValue(TextValue: Text): Text
    var
        InnerQuotePosition: Integer;
        TextValue2: Text;
    begin
        InnerQuotePosition := StrPos(TextValue, '""');
        if InnerQuotePosition = 0 then
            exit(TextValue);

        while InnerQuotePosition > 0 do begin
            TextValue2 += CopyStr(TextValue, 1, InnerQuotePosition);
            TextValue := CopyStr(TextValue, InnerQuotePosition + 2, StrLen(TextValue) - InnerQuotePosition - 1);
            InnerQuotePosition := StrPos(TextValue, '""')
        end;

        TextValue2 += TextValue;
        exit(TextValue2);
    end;

    /// <summary>
    /// CreateTextTableFilter.
    /// </summary>
    /// <param name="CurrentLineOnly">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure CreateTextTableFilter(CurrentLineOnly: Boolean): Text
    var
        TextTableFilter: Text;
        TextFieldFilter: Text;
    begin
        TextFieldFilter := CreateTextTableFilterWithoutTableName(CurrentLineOnly);
        if StrLen(TextFieldFilter) > 0 then
            TextTableFilter := QuoteValue("Table Name", ':') + ': ' + TextFieldFilter;
        exit(TextTableFilter);
    end;

    /// <summary>
    /// CreateTextTableFilterWithoutTableName.
    /// </summary>
    /// <param name="CurrentLineOnly">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure CreateTextTableFilterWithoutTableName(CurrentLineOnly: Boolean): Text
    var
        TextTableFilter: Text;
        TextFieldFilter: Text;
        FirstField: Boolean;
    begin
        FirstField := true;
        if CurrentLineOnly then
            AppendFieldFilter(TextTableFilter, CreateTextFieldFilter())
        else
            if Find('-') then
                repeat
                    TextFieldFilter := CreateTextFieldFilter();
                    if StrLen(TextFieldFilter) > 0 then begin
                        if not FirstField then
                            TextTableFilter += ',';
                        FirstField := false;
                        AppendFieldFilter(TextTableFilter, TextFieldFilter);
                    end;
                until Next() = 0;

        exit(TextTableFilter);
    end;

    local procedure CreateTextFieldFilter(): Text
    begin
        if ("Field Number" > 0) and (StrLen("Field Filter") > 0) then
            exit(QuoteValue("Field Caption", '=') + '=' + QuoteValue("Field Filter", ','));

        exit('');
    end;

    local procedure AppendFieldFilter(var TextTableFilter: Text; TextFieldFilter: Text)
    begin
        if (StrLen(TextTableFilter) + StrLen(TextFieldFilter)) > 200 then
            Error(Text000);

        TextTableFilter += TextFieldFilter;
    end;

    local procedure QuoteValue(TextValue: Text[250]; TextCausingQuotes: Text): Text
    var
        InnerQuotePosition: Integer;
        TextValue2: Text;
    begin
        // if quotes are not needed return initial value:
        if StrPos(TextValue, TextCausingQuotes) <= 0 then
            exit(TextValue);

        // Escape possible double quote characters:
        InnerQuotePosition := StrPos(TextValue, '"');
        while InnerQuotePosition > 0 do begin
            TextValue2 += CopyStr(TextValue, 1, InnerQuotePosition) + '"';
            TextValue := CopyStr(TextValue, InnerQuotePosition + 1, StrLen(TextValue));
            InnerQuotePosition := StrPos(TextValue, '"');
        end;

        // Surround by double quotes:
        TextValue2 += TextValue;
        TextValue2 := '"' + TextValue2 + '"';

        exit(TextValue2);
    end;

    local procedure TableNameMatches(var TableFilterText: Text): Boolean
    var
        TableName2: Text;
        TableNamesEqual: Boolean;
    begin
        // Extract TableName from TableFilterText.
        // if the first character in TableFilterText is a double quote,get the table name from the quotes,
        // otherwise read it from TableFilterText until the colon:
        if StrPos(CopyStr(TableFilterText, 1, 1), '"') = 1 then
            TableName2 := GetQuotedValue(TableFilterText, ':')
        else
            TableName2 := GetValue(TableFilterText, ':');

        TableNamesEqual := TableName2 = "Table Name";

        if TableNamesEqual then
            // Remove the first blank space:
            TableFilterText := CopyStr(TableFilterText, 2, StrLen(TableFilterText) - 1);

        exit(TableNamesEqual);
    end;

    local procedure ExtractFieldName(var TableFilterText: Text)
    var
        FieldTable: Record "Field";
        FieldName2: Text;
    begin
        // if the first character s a double quote, extract the field name from the quotes,
        // otherwise read it from the string until the equal sign:
        if StrPos(CopyStr(TableFilterText, 1, 1), '"') = 1 then
            FieldName2 := GetQuotedValue(TableFilterText, '=')
        else
            FieldName2 := GetValue(TableFilterText, '=');

        FieldTable.Reset();
        FieldTable.SetRange(TableNo, "Table Number");
        FieldTable.SetRange("Field Caption", FieldName2);
        FieldTable.FindFirst();
        FillSourceRecord(FieldTable);
        "Line No." := 0;
    end;

    local procedure ExtractFieldFilter(var TableFilterText: Text)
    var
        FieldFilter2: Text;
    begin
        // if the first character is a double quote, extract the field filter from the quotes,
        // otherwise read it from the string until the comma:
        if StrPos(CopyStr(TableFilterText, 1, 1), '"') = 1 then
            FieldFilter2 := GetQuotedValue(TableFilterText, ',')
        else
            FieldFilter2 := GetValue(TableFilterText, ',');

        "Field Filter" := FieldFilter2;

    end;

    local procedure CheckFieldFilter()
    var
        RecordRef: RecordRef;
        FieldRef: FieldRef;
    begin
        RecordRef.Open("Table Number");
        FieldRef := RecordRef.Field("Field Number");
        FieldRef.SetFilter("Field Filter");
        "Field Filter" := FieldRef.GetFilter;
        RecordRef.Close();
    end;


    /// <summary>
    /// GetViewFilter.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetViewFilter(): Text
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        RecRef.Open("Table Number");
        if FindSet() then
            repeat
                FldRef := RecRef.Field("Field Number");
                FldRef.SetFilter("Field Filter");
            until Next() = 0;
        exit(RecRef.GetView());
    end;


}



