unit UCC_MLS_FindError;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, UForms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, RzTabs;

type
  TMLSFindError = class(TAdvancedForm)
    Label3: TLabel;
    btnOk: TBitBtn;
    btnReplaAll: TBitBtn;
    btnSkip: TButton;
    btnSkipColum: TButton;
    btnExclude: TButton;
    btnCancel: TButton;
    LbComp: TLabel;
    Label1: TLabel;
    lbField: TLabel;
    Label2: TLabel;
    edtCurrentValue: TEdit;
    Label4: TLabel;
    chkSaveMLSResponses: TCheckBox;
    edtReplaceValue: TComboBox;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnReplaAllClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSkipClick(Sender: TObject);
    procedure btnSkipColClick(Sender: TObject);
    procedure btnSkipColumClick(Sender: TObject);
    procedure btnExcludeClick(Sender: TObject);
   
  private
    FReturn: variant;
    procedure AdjustDPISettings;
    procedure ShowHideSaveMLSResponse;
  public
    NewValue : String;
    Page : Integer;
    property Return: variant read FReturn write FReturn;
  end;


var
  MLSFindError: TMLSFindError;
const
  LStatusList = 'active, pending, expired, sold, terminated, withdrawn';    //github #666


implementation
Uses
  UGlobals;

{$R *.dfm}


procedure TMLSFindError.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then
   btnOk.Click;
end;

procedure TMLSFindError.btnOkClick(Sender: TObject);
begin
 NewValue := edtReplaceValue.Text;

 if NewValue = '' then
   begin
     ShowMessage('Please enter a value');
     if edtReplaceValue.CanFocus then  //github 488, force user to enter a value
       edtReplaceValue.SetFocus;
       modalResult := mrNone;
       Return := mrNone;
   end;
 Return := mrOk;
end;

procedure TMLSFindError.AdjustDPISettings;
begin
  self.width := btnCancel.Left + btnCancel.width + 25;
  self.Height := btnCancel.top +btnCancel.Height + 55;
  btnCancel.left := self.Width - btncancel.width - 25;
end;

procedure TMLSFindError.FormShow(Sender: TObject);
begin
 AdjustDPISettings;
 edtReplaceValue.Style := csSimple; //github #666
 edtReplaceValue.SetFocus;
// chkSaveMLSResponses.Checked := appPref_SaveMLSResponses; //github 411
 chkSaveMLSResponses.Checked := False; //should default to FALSE
 ShowHideSaveMLSResponse;
 if pos('LISTING STATUS',upperCase(lbField.Caption)) > 0 then  //github #666
   begin
     edtReplaceValue.Style := csDropDownList; //github #666: make it a drop down list only
     edtReplacevalue.Items.CommaText := LStatusList;
   end;
end;

procedure TMLSFindError.ShowHideSaveMLSResponse;
var
  fldName: String;
  aVisible: Boolean;
begin
  aVisible := False;
  chkSaveMLSResponses.Visible := False;
  fldName := UpperCase(lbField.Caption);
  if fldName = 'GARAGE CARS' then  aVisible := True
  else if fldName = 'FIREPLACES' then aVisible := True
  else if fldName = 'CARPORT CARS' then aVisible := True
  else if fldName = 'PARKING SPACES' then aVisible := True
  else if fldName = 'SPA' then aVisible := True
  else if fldName = 'CITY' then aVisible := True
  else if fldName = 'STATE' then aVisible := True
  else if fldName = 'BEDRMS' then aVisible := True
  else if fldName = 'DESIGN' then aVisible := True
  else if fldName = 'STORIES' then aVisible := True
  else if fldName = 'POOL' then aVisible := True
  else if fldName = 'COUNTY' then aVisible := True
  else if fldName = 'CARPORT DESCRIPTION'  then aVisible := True
  else if fldName = 'GARAGE DESCRIPTION' then aVisible := True
  else if fldName = 'COOLING DESC' then aVisible := True
  else if fldName = 'HEATING DESC' then aVisible := True
  else if fldName = 'DECK DESC' then aVisible := True
  else if fldName = 'PATIO DESC' then aVisible := True
  else if fldName = 'POOL DESC' then aVisible := True
  else if fldName = 'SALE CONCESSIONS' then aVisible := True
  else if fldName = 'FIN CONCESSIONS' then aVisible := True   //Ticket #1394
  else if fldName = 'SITE VIEWS' then aVisible := True;   //Ticket #1394
  chkSaveMLSResponses.Visible := aVisible;
end;

procedure TMLSFindError.btnReplaAllClick(Sender: TObject);
begin
 NewValue := edtReplaceValue.Text;

 if NewValue = '' then
   begin
     ShowMessage('Please enter a value');
     if edtReplaceValue.CanFocus then  //github 488, force user to enter a value
       edtReplaceValue.SetFocus;
       modalResult := mrNone;
       Return := mrNone;
     //abort;
   end;
 Return := mrAll;
end;

procedure TMLSFindError.btnCancelClick(Sender: TObject);
begin
  Return := mrCancel;
end;

procedure TMLSFindError.btnSkipClick(Sender: TObject);
begin
  NewValue := edtReplaceValue.Text;
  Return := mrIgnore;
end;

procedure TMLSFindError.btnSkipColClick(Sender: TObject);
begin
 NewValue := edtReplaceValue.Text;
 Return := mrNoToAll;
end;

procedure TMLSFindError.btnSkipColumClick(Sender: TObject);
begin
 NewValue := edtReplaceValue.Text;
 Return := mrNoToAll;
end;

procedure TMLSFindError.btnExcludeClick(Sender: TObject);
begin
  Return := mrAbort;
end;

end.

