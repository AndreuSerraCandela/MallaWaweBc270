/// <summary>
/// Page Sincroniza. Setup (ID 50042).
/// </summary>
page 50042 "Sincroniza. Setup"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Configuración sincronización';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Nuevo,Proceso,Informes,Configuracion';
    SourceTable = "Company Information";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                grid(GeneralGrid)
                {
                    group(GeneralColumn)
                    {
                        ShowCaption = false;
                        field("Empresa para mestros"; Rec."Empresa para mestros")
                        {
                            ApplicationArea = Basic, Suite;
                            ToolTip = 'Specifies that the change log is active.';
                            Caption = 'Empresa para maestros';

                            trigger OnValidate()
                            begin
                                ConfirmActivationOfChangeLog;
                                ChangeLogSettingsUpdated := true;
                            end;
                        }
                        // label(ChangeLogWarning)
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'IMPORTANT';
                        //     Style = Strong;
                        // }
                        // label(ChangeLogWarningDescription)
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Tracking changes can impact performance, which can cost you time, and increase the size of your database, which might cost you money. To reduce those costs, consider the following:';
                        // }
                        // label(ChangeLogWarningDescPt1)
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = '- Use caution when choosing the tables and operations.';
                        // }
                        // label(ChangeLogWarningDescPt2)
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = '- Do not add ledger entries and posted documents. Instead, prioritize system fields such as Created By and Created Date.';
                        // }
                        // label(ChangeLogWarningDescPt3)
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = '- Do not use the All Fields tracking type. Instead, choose Some Fields and track only the most important fields.';
                        // }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Caption = 'Notas';
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Setup")
            {
                Caption = '&Configuración Tablas';
                Image = Setup;
                action(Tables)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tablas';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View what must be logged for each table.';

                    trigger OnAction()
                    var
                        ChangeLogSetupList: Page "Sincr. Log Setup (Table) List";
                    begin
                        ChangeLogSetupList.SetSource;
                        ChangeLogSetupList.RunModal;
                        ChangeLogSettingsUpdated := ChangeLogSetupList.IsChangeLogSettingsUpdated();
                    end;
                }
                // action(RetentionPolicy)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Retention Policy';
                //     Tooltip = 'View or Edit the retention policy.';
                //     Image = Delete;
                //     RunObject = Page "Retention Policy Setup Card";
                //     RunPageLink = "Table Id" = Filter(405); // Database::"Change Log Entry";
                //     AccessByPermission = tabledata "Retention Policy Setup" = R;
                //     RunPageMode = View;
                //     Ellipsis = true;
                // }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;

    trigger OnClosePage()
    begin
        if ChangeLogSettingsUpdated then
            if Confirm(RestartSessionQst) then
                RestartSession();
    end;

    var
        ActivateChangeLogQst: Label 'Turning on the Change Log might slow things down, especially if you are monitoring entities that often change. Do you want to log changes?';
        RestartSessionQst: Label 'Changes are displayed on the Change Log Entries page after the user''s session has restarted. Do you want to restart the session now?';
        ChangeLogSettingsUpdated: Boolean;

    local procedure ConfirmActivationOfChangeLog()
    var
        EnvironmentInfo: Codeunit "Environment Information";
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        if not Rec."Empresa para mestros" then
            exit;
        if not EnvironmentInfo.IsSaaS then
            exit;
        if not ConfirmManagement.GetResponseOrDefault(ActivateChangeLogQst, true) then
            Error('');
    end;

    local procedure RestartSession()
    var
        SessionSetting: SessionSettings;
    begin
        SessionSetting.Init();
        SessionSetting.RequestSessionUpdate(false);
    end;

}
page 50045 "Sincr. Log Setup (Table) List"
{
    Caption = 'Lista tablas sincronización';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = true;
    PageType = List;
    SourceTable = AllObjWithCaption;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ID';
                    Editable = false;
                    ToolTip = 'Specifies the ID of the table. ';
                }
                field("Object Caption"; Rec."Object Caption")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nombre';
                    Editable = false;
                    ToolTip = 'Specifies the name of the table.';
                }
                // field(LogInsertion; ChangeLogSetupTable."Log Insertion")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Log Insertion';
                //     Editable = PageIsEditable;
                //     Enabled = PageIsEditable;
                //     OptionCaption = ' ,Some Fields,All Fields';
                //     ToolTip = 'Specifies where insertions of new data are logged. Blank: No insertions in any fields are logged. Some fields: Insertions are logged for selected fields. All fields: Insertions are logged for all fields.';

                //     trigger OnAssistEdit()
                //     begin
                //         with ChangeLogSetupTable do
                //             TestField("Log Insertion", "Log Insertion"::"Some Fields");
                //         AssistEdit;
                //     end;

                //     trigger OnValidate()
                //     var
                //         ConfirmManagement: Codeunit "Confirm Management";
                //         NewValue: Option;
                //     begin
                //         if ChangeLogSetupTable."Table No." <> "Object ID" then begin
                //             NewValue := ChangeLogSetupTable."Log Insertion";
                //             GetRec;
                //             ChangeLogSetupTable."Log Insertion" := NewValue;
                //         end;

                //         if xChangeLogSetupTable.Get(ChangeLogSetupTable."Table No.") then begin
                //             if (xChangeLogSetupTable."Log Insertion" = xChangeLogSetupTable."Log Insertion"::"Some Fields") and
                //                (xChangeLogSetupTable."Log Insertion" <> ChangeLogSetupTable."Log Insertion")
                //             then
                //                 if ConfirmManagement.GetResponseOrDefault(
                //                      StrSubstNo(Text002, xChangeLogSetupTable.FieldCaption("Log Insertion"), xChangeLogSetupTable."Log Insertion"), true)
                //                 then
                //                     ChangeLogSetupTable.DelChangeLogFields(0);
                //         end;
                //         ChangeLogSetupTableLogInsertio;
                //     end;
                // }
                field(LogModification; ChangeLogSetupTable."Log Modification")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Log Modification';
                    Editable = PageIsEditable;
                    Enabled = PageIsEditable;
                    ToolTip = 'Specifies that any modification of data is logged.';

                    trigger OnAssistEdit()
                    begin
                        AssistEdit;
                    end;

                    trigger OnValidate()
                    var
                        ConfirmManagement: Codeunit "Confirm Management";
                        NewValue: Boolean;
                    begin
                        if ChangeLogSetupTable."Table No." <> Rec."Object ID" then begin
                            NewValue := ChangeLogSetupTable."Log Modification";
                            GetRec;
                            ChangeLogSetupTable."Log Modification" := NewValue;
                        end;

                        if xChangeLogSetupTable.Get(ChangeLogSetupTable."Table No.") then begin
                            ChangeLogSetupTable.DelChangeLogFields(1);
                        end;
                        ChangeLogSetupTableLogModifica;
                    end;
                }
                // field(LogDeletion; ChangeLogSetupTable."Log Deletion")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Log Deletion';
                //     Editable = PageIsEditable;
                //     Enabled = PageIsEditable;
                //     OptionCaption = ' ,Some Fields,All Fields';
                //     ToolTip = 'Specifies that any deletion of data is logged.';

                //     trigger OnAssistEdit()
                //     begin
                //         with ChangeLogSetupTable do
                //             TestField("Log Deletion", "Log Deletion"::"Some Fields");
                //         AssistEdit;
                //     end;

                //     trigger OnValidate()
                //     var
                //         ConfirmManagement: Codeunit "Confirm Management";
                //         NewValue: Option;
                //     begin
                //         if ChangeLogSetupTable."Table No." <> "Object ID" then begin
                //             NewValue := ChangeLogSetupTable."Log Deletion";
                //             GetRec;
                //             ChangeLogSetupTable."Log Deletion" := NewValue;
                //         end;

                //         if xChangeLogSetupTable.Get(ChangeLogSetupTable."Table No.") then begin
                //             if (xChangeLogSetupTable."Log Deletion" = xChangeLogSetupTable."Log Deletion"::"Some Fields") and
                //                (xChangeLogSetupTable."Log Deletion" <> ChangeLogSetupTable."Log Deletion")
                //             then
                //                 if ConfirmManagement.GetResponseOrDefault(
                //                      StrSubstNo(Text002, xChangeLogSetupTable.FieldCaption("Log Deletion"), xChangeLogSetupTable."Log Deletion"), true)
                //                 then
                //                     ChangeLogSetupTable.DelChangeLogFields(2);
                //         end;
                //         ChangeLogSetupTableLogDeletion;
                //     end;
                // }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        GetRec;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        PageIsEditable := CurrPage.Editable();
    end;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("Object Type", Rec."Object Type"::Table);
        Rec.SetRange("Object ID", 0, 2000000000);
        //MonitorSensitiveField.ExcludeMonitorTablesFromChangeLog(Rec);
        Rec.FilterGroup(0);
    end;

    var
        ChangeLogSetupTable: Record "Sincronization Setup (Table)";
        xChangeLogSetupTable: Record "Sincronization Setup (Table)";
        //MonitorSensitiveField: Codeunit "Monitor Sensitive Field";
        Text002: Label 'You have changed the %1 field to no longer be %2. Do you want to remove the field selections?';
        PageIsEditable: Boolean;
        ChangeLogSettingsUpdated: Boolean;

    local procedure AssistEdit()
    var
        "Field": Record "Field";
        ChangeLogSetupFieldList: Page "Sincr Log Setup (Field) List";
    begin
        Field.FilterGroup(2);
        Field.SetRange(TableNo, Rec."Object ID");
        Field.SetFilter(ObsoleteState, '<>%1', Field.ObsoleteState::Removed);
        Field.FilterGroup(0);
        //with ChangeLogSetupTable do
        ChangeLogSetupFieldList.SelectColumn(
          false,
          false,
          false);
        ChangeLogSetupFieldList.SetTableView(Field);
        ChangeLogSetupFieldList.Run;
    end;

    local procedure UpdateRec()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;

        //with ChangeLogSetupTable do
        // if ("Log Insertion" = "Log Insertion"::" ") and ("Log Modification" = "Log Modification"::" ") and
        //    ("Log Deletion" = "Log Deletion"::" ")
        // then begin
        //     if Delete then;
        // end else
        if not ChangeLogSetupTable.Modify then
            ChangeLogSetupTable.Insert;

        ChangeLogSettingsUpdated := true;
    end;

    local procedure GetRec()
    begin
        if not ChangeLogSetupTable.Get(Rec."Object ID") then begin
            ChangeLogSetupTable.Init();
            ChangeLogSetupTable."Table No." := Rec."Object ID";
        end;
    end;


    /// <summary>
    /// SetSource.
    /// </summary>
    procedure SetSource()
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        Rec.DeleteAll();

        AllObjWithCaption.SetCurrentKey("Object Type", "Object ID");
        AllObjWithCaption.SetRange("Object Type", Rec."Object Type"::Table);
        AllObjWithCaption.SetRange("Object ID", 0, 2000000006);

        if AllObjWithCaption.Find('-') then
            repeat
                Rec := AllObjWithCaption;
                Rec.Insert;
            until AllObjWithCaption.Next() = 0;
    end;

    /// <summary>
    /// IsChangeLogSettingsUpdated.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsChangeLogSettingsUpdated(): Boolean
    begin
        exit(ChangeLogSettingsUpdated);
    end;

    local procedure ChangeLogSetupTableLogInsertio()
    begin
        UpdateRec;
    end;

    local procedure ChangeLogSetupTableLogModifica()
    begin
        UpdateRec;
    end;

    local procedure ChangeLogSetupTableLogDeletion()
    begin
        UpdateRec;
    end;


}
page 50047 "Sincr Log Setup (Field) List"
{
    Caption = 'Lista Campos Sincronización';
    DataCaptionExpression = LogPageCaption;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Field";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nº';
                    Editable = false;
                    Lookup = false;
                    ToolTip = 'Specifies the number of the field.';
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nombre Campo';
                    DrillDown = false;
                    Editable = false;
                    ToolTip = 'Specifies the caption of the field, that is, the name that will be shown in the user interface.';
                }
                field(Excluir; Excluir)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Excluir';
                    ToolTip = 'Specifies whether to log the insertion for the selected line on the change log.';
                    Editable = true;
                    Enabled = true;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        // if not InsVisible then begin
                        //     LogInsertionVisible := false;
                        //     Error(CannotChangeColumnErr);
                        // end;
                        UpdateRec;
                    end;
                }
                // field("Log Modification"; LogMod)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Log Modification';
                //     ToolTip = 'Specifies whether to log the modification for the selected line on the change log.';
                //     Editable = PageIsEditable;
                //     Enabled = PageIsEditable;
                //     Visible = LogModificationVisible;

                //     trigger OnValidate()
                //     begin
                //         if not ModVisible then begin
                //             LogModificationVisible := false;
                //             Error(CannotChangeColumnErr);
                //         end;
                //         UpdateRec;
                //     end;
                // }
                // field("Log Deletion"; LogDel)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Log Deletion';
                //     ToolTip = 'Specifies whether to log the deletion for the selected line on the change log.';
                //     Editable = PageIsEditable;
                //     Enabled = PageIsEditable;
                //     Visible = LogDeletionVisible;

                //     trigger OnValidate()
                //     begin
                //         if not DelVisible then begin
                //             LogDeletionVisible := false;
                //             Error(CannotChangeColumnErr);
                //         end;
                //         UpdateRec;
                //     end;
                // }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Caption = 'Notas';
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        PageIsEditable := CurrPage.Editable();
        GetRec;
        TransFromRec;
    end;

    trigger OnAfterGetRecord()
    begin
        GetRec;
        TransFromRec;
    end;

    trigger OnInit()
    begin
        LogDeletionVisible := true;
        LogModificationVisible := true;
        LogInsertionVisible := true;
    end;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange(Class, Rec.Class::Normal);
        Rec.FilterGroup(0);
        LogPageCaption := Format(Rec.TableNo) + ' ' + Rec.TableName;
    end;

    var
        ChangeLogSetupField: Record "Sincronization Setup (Field)";
        CannotChangeColumnErr: Label 'You cannot change this column.';
        LogIns: Boolean;
        LogMod: Boolean;
        LogDel: Boolean;
        Excluir: Boolean;
        InsVisible: Boolean;
        ModVisible: Boolean;
        DelVisible: Boolean;

        LogInsertionVisible: Boolean;

        LogModificationVisible: Boolean;

        LogDeletionVisible: Boolean;
        LogPageCaption: Text[250];
        PageIsEditable: Boolean;

    /// <summary>
    /// SelectColumn.
    /// </summary>
    /// <param name="NewInsVisible">Boolean.</param>
    /// <param name="NewModVisible">Boolean.</param>
    /// <param name="NewDelVisible">Boolean.</param>
    procedure SelectColumn(NewInsVisible: Boolean; NewModVisible: Boolean; NewDelVisible: Boolean)
    begin
        InsVisible := NewInsVisible;
        ModVisible := NewModVisible;
        DelVisible := NewDelVisible;

        LogInsertionVisible := InsVisible;
        LogModificationVisible := ModVisible;
        LogDeletionVisible := DelVisible;
    end;

    local procedure UpdateRec()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;

        GetRec;
        TransToRec;
        //with ChangeLogSetupField do
        if not (Excluir) then begin
            if ChangeLogSetupField.Delete then;
        end else
            if not ChangeLogSetupField.Modify then
                ChangeLogSetupField.Insert;
    end;

    local procedure GetRec()
    begin
        if not ChangeLogSetupField.Get(Rec.TableNo, Rec."No.") then begin
            ChangeLogSetupField.Init();
            ChangeLogSetupField."Table No." := Rec.TableNo;
            ChangeLogSetupField."Field No." := Rec."No.";
        end;
    end;

    local procedure TransFromRec()
    begin
        // LogIns := ChangeLogSetupField."Log Insertion";
        // LogMod := ChangeLogSetupField."Log Modification";
        // LogDel := ChangeLogSetupField."Log Deletion";
        Excluir := ChangeLogSetupField.Excluir;
    end;

    local procedure TransToRec()
    begin
        // ChangeLogSetupField."Log Insertion" := LogIns;
        // ChangeLogSetupField."Log Modification" := LogMod;
        // ChangeLogSetupField."Log Deletion" := LogDel;
        ChangeLogSetupField.Excluir := Excluir;
    end;


}