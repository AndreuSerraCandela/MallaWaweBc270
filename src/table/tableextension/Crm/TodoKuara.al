/// <summary>
/// TableExtension ToDoKuara (ID 80109) extends Record To-Do.
/// </summary>
tableextension 80109 ToDoKuara extends "To-Do"
{
    fields
    {
        field(80001; Kilometraje; decimal)
        {

        }
        field(80000; "Emplazamiento"; Boolean)
        {

        }
        field(80002; "Descripción Visita"; Text[2048])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Description := CopyStr("Descripción Visita", 1, MaxStrLen(Description));

            end;
        }
        field(80003; "Proxima visita"; Date)
        {

        }
        field(80004; "Peticion disponibilidad"; Enum "Peticion Disponibilidad")
        { }
        field(80105; "RichTextVisita"; Blob)
        {
            DataClassification = ToBeClassified;
        }

    }
    /// <summary>
    /// GetContactName.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetContactName(): Text
    var
        Cont: Record Contact;
    begin
        if Cont.GET("Contact No.") THEN
            EXIT(Cont.Name);
        if Cont.GET("Contact Company No.") THEN
            EXIT(Cont.Name);
    end;

    procedure GetRichText(): Text
    var
        InStream: Instream;
        TextValue: Text;
    begin
        Rec.CalcFields("RichTextVisita");
        Rec."RichTextVisita".CreateInStream(InStream, TextEncoding::UTF8);
        InStream.Read(TextValue);
        if TextValue = '' THEN
            exit("Descripción Visita");
        exit(TextValue);
    end;

    // 
    /// <summary>
    /// Saves the text parameter in the RichTextBlob field.
    /// </summary>
    /// <param name="MyRichText">The value to save in blob field.</param>
    procedure SaveRichText(RichText: Text)
    var
        OutStream: OutStream;
    begin
        Rec."RichTextVisita".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.Write(RichText);
        Rec."Descripción Visita" := CopyStr(RichText, 1, MaxStrLen(Rec."Descripción Visita"));
        Rec.Description := CopyStr(RichText, 1, MaxStrLen(Rec.Description));
        Rec.Modify();
    end;

    /// <summary>
    /// CreateTodoFromReminder.
    /// </summary>
    /// <param name="ReminderHeader">VAR Record "Reminder Header".</param>
    procedure CreateTodoFromReminder(var ReminderHeader: Record "Reminder Header")
    var
        Cont: Record Contact;
        SegLine: Record "Segment Line";
        ToDo: Record "To-do";
        Campaign: Record Campaign;
        Opp: Record Opportunity;
        SegHeader: Record "Segment Header";
        Team: Record Team;
    begin

        DELETEALL;
        INIT;
        VALIDATE("Contact No.", ReminderHeader."Contact No.");
        SETRANGE("Contact No.", ReminderHeader."Contact No.");
        Cont.GET(ReminderHeader."Contact No.");
        if Cont."Salesperson Code" <> '' THEN BEGIN
            "Salesperson Code" := Cont."Salesperson Code";
            SETRANGE("Salesperson Code", "Salesperson Code");
        END;

        "Wizard Step" := "Wizard Step"::"1";

        "Wizard Contact Name" := GetContactName;
        if Campaign.GET("Campaign No.") THEN
            "Campaign Description" := Campaign.Description;
        if Opp.GET("Opportunity No.") THEN
            "Opportunity Description" := Opp.Description;
        if SegHeader.GET(GETFILTER("Segment No.")) THEN
            "Segment Description" := SegHeader.Description;
        if Team.GET(GETFILTER("Team Code")) THEN
            "Team To-do" := TRUE;

        Duration := 1440 * 1000 * 60;
        Date := TODAY;
        GetEndDateTime;
        INSERT;
        Page.RUNMODAL(5097, Rec);
        COMMIT;
        RESET;
        ToDo.SETRANGE("Contact No.", ReminderHeader."Contact No.");
        ToDo.FINDLAST;
        ReminderHeader."To-do No." := ToDo."No.";
        ReminderHeader.MODIFY;
        CreateInteractionFromToDo2(ToDo, ReminderHeader);
    end;

    /// <summary>
    /// CreateInteractionFromTodo2.
    /// </summary>
    /// <param name="Var Todo">Record "To-do".</param>
    /// <param name="ReminderHeader">VAR Record "Reminder Header".</param>
    procedure CreateInteractionFromTodo2(Var Todo: Record "To-do"; var ReminderHeader: Record "Reminder Header")
    var
        SegHeader: Record "Segment Line";
        SegLine: Record "Segment Line";
        Cont: Record Contact;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        Campaign: Record Campaign;
        Opp: Record Opportunity;
    begin

        SegHeader.INIT;
        SegHeader."To-do No." := ToDo."No.";
        SegHeader.SETRANGE("To-do No.", Todo."No.");
        if Cont.GET(ToDo."Contact No.") THEN
            SegHeader.VALIDATE("Contact No.", Cont."No.");
        if SalesPurchPerson.GET(ToDo."Salesperson Code") THEN
            SegHeader."Salesperson Code" := SalesPurchPerson.Code;
        if Campaign.GET(ToDo."Campaign No.") THEN
            SegHeader."Campaign No." := Campaign."No.";
        if Campaign.GET("Campaign No.") THEN
            SegHeader."Campaign Description" := Campaign.Description;
        if Opp.GET("Opportunity No.") THEN
            SegHeader."Opportunity Description" := Opp.Description;
        SegHeader."Wizard Contact Name" := GetContactName;
        SegHeader."Wizard Step" := SegHeader."Wizard Step"::"1";
        SegHeader."Interaction Successful" := TRUE;
        SegHeader.VALIDATE(Date, WORKDATE);
        SegHeader.Description := ToDo.Description;
        SegHeader."Document Type" := SegHeader."Document Type"::"Sales Rmdr.";
        SegHeader."Document No." := ReminderHeader."No.";
        SegHeader.INSERT;
        COMMIT;
        Page.RUNMODAL(Page::"Create Interaction", Rec, "Interaction Template Code");
    end;
}