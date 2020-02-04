unit UFormInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  UForm, UForms;

type
  TFormInfo = class(TAdvancedForm)
    btnOK: TButton;
    Label1: TLabel;
    Label2: TLabel;
    lblFormID: TLabel;
    Label4: TLabel;
    lblFormName: TLabel;
    lblVersion: TLabel;
    Label7: TLabel;
    lblCreated: TLabel;
    Label9: TLabel;
    lblModified: TLabel;
    Label14: TLabel;
    lblPages: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure AdjustDPISettings;
  public
    { Public declarations }
    procedure SetFormProperties(form: TDocForm);
  end;

var
  FormInfo: TFormInfo;

implementation
(*
uses
  SysUtils;
*)
  
{$R *.dfm}

{ TFormInfo }

procedure TFormInfo.SetFormProperties(form: TDocForm);
begin
  with Form.frmInfo do
    begin
      lblFormName.Caption := ExtractFileName(fFormFilePath);
      lblFormID.Caption   := IntToStr(fFormUID);
      lblVersion.Caption  := IntToStr(fFormVers);
      lblCreated.Caption  := fCreateDate;
      lblModified.Caption := fLastUpdate;
      lblPages.Caption    := IntToStr(fFormPgCount);
    end;
end;

procedure TFormInfo.AdjustDPISettings;
begin
  btnOK.Left := Label9.Left;
  btnOK.top := lblModified.Top + lblModified.Height + 20;

  self.Width := lblModified.Left + lblModified.Width + 100;
  self.Height := btnOK.Top + btnOK.Height + 50;

  self.Constraints.MaxWidth := 0;
  self.Constraints.MinWidth := 0;
  self.Constraints.MaxHeight := 0;
  self.Constraints.MinHeight := 0;

end;

procedure TFormInfo.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
end;
end.
