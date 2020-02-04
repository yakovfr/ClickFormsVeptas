unit UValidationUserComment;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Mask, UForms;

type
  TUserValidationCmnt = class(TAdvancedForm)
    edtDescr: TEdit;
    lblCommentDesc: TLabel;
    lblAppraiserResp: TLabel;
    mmComment: TMemo;
    bbtnCancel: TBitBtn;
    bbtnOK: TBitBtn;
    bbtnStdCmnt: TBitBtn;
    meCharBal: TMaskEdit;
    lblCharsRemaining: TLabel;
    lblMandatory: TLabel;
    lblAppraiserComment: TLabel;
    rbRespYes: TRadioButton;
    rbRespNo: TRadioButton;
    procedure bbtnOKClick(Sender: TObject);
    procedure bbtnStdCmntClick(Sender: TObject);
    procedure mmCommentChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKBtnChk;
    procedure rbRespYesClick(Sender: TObject);
    procedure rbRespNoClick(Sender: TObject);
  private
    { Private declarations }
  public
  { Public declarations }
    WarningRequiresYesNo: Boolean;
    ServiceName: String;
  end;

var
  UserValidationCmnt: TUserValidationCmnt;

implementation

{$R *.dfm}

uses
  UStatus;

procedure TUserValidationCmnt.bbtnOKClick(Sender: TObject);
begin
  modalResult := mrOK;
end;

procedure TUserValidationCmnt.bbtnStdCmntClick(Sender: TObject);
begin
  mmComment.Text := 'The warning as identified is addressed in the appraisal report.';
end;

procedure TUserValidationCmnt.mmCommentChange(Sender: TObject);
begin
  meCharBal.Text := IntToStr(mmComment.MaxLength - Length(mmComment.Text));
  OKBtnChk;
end;

procedure TUserValidationCmnt.FormShow(Sender: TObject);
const
  DlgWarnHeight = 309;
  DlgYesNoHeight = 340;
var
  SizeOffset: Integer;
begin
  Caption := ServiceName + ' Comment';
  lblAppraiserResp.Visible := WarningRequiresYesNo;
  rbRespYes.Visible := WarningRequiresYesNo;
  rbRespNo.Visible := WarningRequiresYesNo;
  if not WarningRequiresYesNo then
    begin
      SizeOffset := DlgWarnHeight - DlgYesNoHeight;
      lblAppraiserComment.Top := lblAppraiserComment.Top + SizeOffset;
      lblAppraiserComment.Caption := '* ' + lblAppraiserComment.Caption;
      lblAppraiserComment.Font.Color := clRed;
      mmComment.Top := mmComment.Top + SizeOffset;
      lblCharsRemaining.Top := lblCharsRemaining.Top + SizeOffset;
      meCharBal.Top := meCharBal.Top + SizeOffset;
      bbtnStdCmnt.Top := bbtnStdCmnt.Top + SizeOffset;
      bbtnOK.Top := bbtnOK.Top + SizeOffset;
      bbtnCancel.Top := bbtnCancel.Top + SizeOffset;
      lblMandatory.Top := lblMandatory.Top + SizeOffset;
      Height := DlgWarnHeight;
    end
  else
    lblAppraiserComment.Font.Color := clWindowText;
  OKBtnChk;
  Refresh;
end;

procedure TUserValidationCmnt.OKBtnChk;
begin
  if WarningRequiresYesNo then
    bbtnOK.Enabled := (rbRespYes.Checked or rbRespNo.Checked)
  else
    bbtnOK.Enabled := (StrToInt(meCharBal.Text) < mmComment.MaxLength);
end;

procedure TUserValidationCmnt.rbRespYesClick(Sender: TObject);
begin
  OKBtnChk;
end;

procedure TUserValidationCmnt.rbRespNoClick(Sender: TObject);
begin
  OKBtnChk;
end;

end.
