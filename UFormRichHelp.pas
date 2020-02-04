unit UFormRichHelp;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit is for displaying the help text for each of the UAD data points}

interface

uses
  ActnList,
  Classes,
  ComCtrls,
  Controls,
  ExtCtrls,
  StdCtrls,
  UForms;

type
  /// summary: A form to display rich text help.
  TRichHelpForm = class(TAdvancedForm)
    ActionList: TActionList;
    ActionOK: TAction;
    ButtonOK: TButton;
    LabelCaption: TLabel;
    PanelButtons: TPanel;
    PanelCaption: TPanel;
    PanelHelp: TPanel;
    RichEditHelp: TRichEdit;
    LabelDescription: TLabel;
    procedure ActionOKExecute(Sender: TObject);
    procedure ActionOKUpdate(Sender: TObject);
  protected
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure LoadFormData(const HelpName: String; const HelpDescription: String);
    procedure LoadHelpFile(const HelpFileName: String);
    procedure Resize; override;
  end;

implementation

{$R *.dfm}

uses
  Windows,
  Forms,
  SysUtils,
  UFonts,
  UGlobals;

/// summary: Initializes a new instance of TRichHelpForm.
constructor TRichHelpForm.Create(AOwner: TComponent);
begin
  inherited;

  SettingsName := CFormSettings_RichHelpForm;
  Left := (Screen.Width div 2) - (Width div 2);
  Top := (Screen.Height div 2) - (Height div 2);
end;

/// summary: Saves the user response to the license agreement and closes the form.
procedure TRichHelpForm.ActionOKExecute(Sender: TObject);
begin
  ModalResult := mrOK;
end;

/// summary: Updates the OK action.
procedure TRichHelpForm.ActionOKUpdate(Sender: TObject);
var
  Action: TAction;
begin
  if (Sender is TAction) then
    begin
      Action := Sender as TAction;
      Action.Enabled := True;
    end;
end;

/// summary: Sets the form font to the Windows user interface font when the form is shown.
/// remarks: Does not set the font on the TRichEdit control or any of its parents.
procedure TRichHelpForm.DoShow;
begin
  TAdvancedFont.UIFont.AssignToControls(PanelCaption, False);
  TAdvancedFont.UIFont.AssignToControls(PanelButtons, False);
  inherited;
end;

/// summary: Repositions the OK button after the form is resized.
procedure TRichHelpForm.Resize;
begin
  ButtonOK.Left := RichEditHelp.Left + RichEditHelp.Width - ButtonOK.Width;
  RichEditHelp.Refresh;
end;

/// summary: Loads data into the form.
procedure TRichHelpForm.LoadFormData(const HelpName: String; const HelpDescription: String);
const
  CCaption = '%s Help';
  CDescription = '%s';
var
  Text: String;
begin
  Caption := Format(CCaption, [HelpName]);

  Text := Format(CCaption, [HelpName]);
  Text := StringReplace(Text, '&', '&&', [rfReplaceAll]);
  LabelCaption.Caption := Text;

  Text := Format(CDescription, [HelpDescription]);
  Text := StringReplace(Text, '&', '&&', [rfReplaceAll]);
  LabelDescription.Caption := Text;
end;

/// summary: Loads the help text from a resource stream.
procedure TRichHelpForm.LoadHelpFile(const HelpFileName: String);
var
  HelpFile: String;
begin
  RichEditHelp.Clear;
  HelpFile := IncludeTrailingPathDelimiter(AppPref_DirHelp) + HelpFileName + '.rtf';
  if FileExists(HelpFile) then
    try
      RichEditHelp.Lines.LoadFromFile(HelpFile);
    except
      RichEditHelp.Lines.Add('The Help file, ' + HelpFileName + ', could not be loaded. UAD Help is unavailable.');
    end
  else
    RichEditHelp.Lines.Add('The Help file, ' + HelpFileName + ', could not be found. UAD Help is unavailable.');
end;

end.
