unit UFormLicense;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ Purpose: A form to display a user license agreement. }

interface

uses
  ActnList,
  Classes,
  ComCtrls,
  Controls,
  Dialogs,
  ExtCtrls,
  Menus,
  Registry,
  StdCtrls,
  UForms;

type
  /// summary: A form to display a user license agreement.
  TLicenseForm = class(TAdvancedForm)
    PanelCaption: TPanel;
    PanelButtons: TPanel;
    PanelLicense: TPanel;
    RichEditLicense: TRichEdit;
    LabelCaption: TLabel;
    LabelDescription: TLabel;
    ButtonPrint: TButton;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    ActionList: TActionList;
    ActionPrint: TAction;
    ActionOK: TAction;
    ActionCancel: TAction;
    PanelAcceptance: TPanel;
    RadioButtonAccept: TRadioButton;
    RadioButtonDecline: TRadioButton;
    ActionSelectAll: TAction;
    ActionCopy: TAction;
    PopupMenuLicense: TPopupMenu;
    MenuItemSelectAll: TMenuItem;
    MenuItemCopy: TMenuItem;
    MenuItemSeparatorBar2: TMenuItem;
    MenuItemSeparatorBar1: TMenuItem;
    MenuItemPrint: TMenuItem;
    PrintDialog: TPrintDialog;
    procedure ActionCancelExecute(Sender: TObject);
    procedure ActionCancelUpdate(Sender: TObject);
    procedure ActionCopyExecute(Sender: TObject);
    procedure ActionCopyUpdate(Sender: TObject);
    procedure ActionOKExecute(Sender: TObject);
    procedure ActionOKUpdate(Sender: TObject);
    procedure ActionPrintExecute(Sender: TObject);
    procedure ActionPrintUpdate(Sender: TObject);
    procedure ActionSelectAllExecute(Sender: TObject);
    procedure ActionSelectAllUpdate(Sender: TObject);
  private
    FLicenseDate: TDate;
    FLicenseName: String;
    FRegistry: TRegistry;
    function GetLicenseAccepted: Boolean;
  protected
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property LicenseAccepted: Boolean read GetLicenseAccepted;
    procedure LoadFormData(const LicenseName: String; const LicenseDate: TDate);
    procedure LoadLicesneRes(const ResourceName: String);
  end;

implementation

{$R *.dfm}

uses
  Windows,
  Graphics,
  Printers,
  SysUtils,
  UFonts,
  ULicUser;

/// summary: Initializes a new instance of TLicenseForm.
constructor TLicenseForm.Create(AOwner: TComponent);
begin
  FRegistry := TRegistry.Create(KEY_ALL_ACCESS);
  inherited;

  // initialize
  SettingsName := 'LicenseForm';
  FRegistry.RootKey := HKEY_CURRENT_USER;
  FRegistry.OpenKey(FormSettingsRegistryKey, True);
end;

/// summary: Frees memory and releases resources.
destructor TLicenseForm.Destroy;
begin
  FreeAndNil(FRegistry);
  inherited;
end;

/// summary: Closes the form.
procedure TLicenseForm.ActionCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

/// summary: Updates the cancel action.
procedure TLicenseForm.ActionCancelUpdate(Sender: TObject);
var
  Action: TAction;
begin
  if (Sender is TAction) then
    begin
      Action := Sender as TAction;
      Action.Enabled := True;
    end;
end;

/// summary: Copies the current selection in the license agreement to the clipboard.
procedure TLicenseForm.ActionCopyExecute(Sender: TObject);
begin
  RichEditLicense.CopyToClipboard;
end;

/// summary: Updates the copy action.
procedure TLicenseForm.ActionCopyUpdate(Sender: TObject);
var
  Action: TAction;
begin
  if (Sender is TAction) then
    begin
      Action := Sender as TAction;
      Action.Enabled := (RichEditLicense.SelLength > 0);
    end;
end;

/// summary: Saves the user response to the license agreement and closes the form.
procedure TLicenseForm.ActionOKExecute(Sender: TObject);
begin
  if RadioButtonAccept.Checked then
    FRegistry.WriteInteger(FLicenseName, Trunc(Date));
  ModalResult := mrOK;
end;

/// summary: Updates the OK action.
procedure TLicenseForm.ActionOKUpdate(Sender: TObject);
var
  Action: TAction;
begin
  if (Sender is TAction) then
    begin
      Action := Sender as TAction;
      Action.Enabled := (RadioButtonAccept.Checked or RadioButtonDecline.Checked);
    end;
end;

/// summary: Prints the license agreement.
procedure TLicenseForm.ActionPrintExecute(Sender: TObject);
begin
  if PrintDialog.Execute then
    RichEditLicense.Print(LabelCaption.Caption);
end;

/// summary: Updates the print action.
procedure TLicenseForm.ActionPrintUpdate(Sender: TObject);
var
  Action: TAction;
begin
  if (Sender is TAction) then
    begin
      Action := Sender as TAction;
      Action.Enabled := (Printer.Printers.Count > 0);
    end;
end;

/// summary: Selects all text in the license agreement.
procedure TLicenseForm.ActionSelectAllExecute(Sender: TObject);
begin
  RichEditLicense.SelectAll;
end;

/// summary: Updates the select all action.
procedure TLicenseForm.ActionSelectAllUpdate(Sender: TObject);
var
  Action: TAction;
begin
  if (Sender is TAction) then
    begin
      Action := Sender as TAction;
      Action.Enabled := True;
    end;
end;

/// summary: Indicates whether the license agreement has been accepted.
function TLicenseForm.GetLicenseAccepted: Boolean;
begin
  if FRegistry.ValueExists(FLicenseName) and (FRegistry.GetDataType(FLicenseName) = rdInteger) then
    Result := (FRegistry.ReadInteger(FLicenseName) >= FLicenseDate)
  else
    Result := False;
end;

/// summary: Sets the form font to the Windows user interface font when the form is shown.
/// remarks: Does not set the font on the TRichEdit control or any of its parents.
procedure TLicenseForm.DoShow;
begin
  TAdvancedFont.UIFont.AssignToControls(PanelCaption, False);
  TAdvancedFont.UIFont.AssignToControls(PanelAcceptance, False);
  TAdvancedFont.UIFont.AssignToControls(PanelButtons, False);
  inherited;
end;

/// summary: Loads data into the form.
procedure TLicenseForm.LoadFormData(const LicenseName: String; const LicenseDate: TDate);
const
  CCaption = '%s License Agreement';
begin
  FLicenseName := CurrentUser.UserInfo.Name + ':' + LicenseName;
  FLicenseDate := LicenseDate;

  Caption := Format(CCaption, [LicenseName]);
  LabelCaption.Caption := Format(CCaption, [LicenseName]);

  if FRegistry.ValueExists(FLicenseName) and (FRegistry.GetDataType(FLicenseName) = rdInteger) then
    RadioButtonAccept.Checked := (FRegistry.ReadInteger(FLicenseName) >= FLicenseDate)
  else
    RadioButtonAccept.Checked := False;
end;

/// summary: Loads the license agreement from a resource stream.
procedure TLicenseForm.LoadLicesneRes(const ResourceName: String);
var
  Stream: TResourceStream;
begin
  Stream := TResourceStream.Create(MainInstance, ResourceName, RT_RCDATA);
  try
    RichEditLicense.Clear;
    RichEditLicense.Lines.LoadFromStream(Stream);
  finally
    FreeAndNil(Stream);
  end;
end;

end.
