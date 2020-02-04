unit UAMC_UserValidationComment;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Mask, UForms, RzButton, RzRadChk;

type
  TAMCUserValidationCmnt = class(TAdvancedForm)
    Panel1: TPanel;
    lblCharsRemaining: TLabel;
    meCharBal: TMaskEdit;
    lblMandatory: TLabel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    Panel2: TPanel;
    lblCommentDesc: TLabel;
    mmDescr: TMemo;
    lblAppraiserComment: TLabel;
    rbRespYes: TRzRadioButton;
    rbRespNo: TRzRadioButton;
    mmComment: TMemo;
    procedure bbtnOKClick(Sender: TObject);
    procedure mmCommentChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKBtnChk;
    procedure SetRspCategory;
    procedure rbRespYesClick(Sender: TObject);
    procedure rbRespNoClick(Sender: TObject);
  private
    { Private declarations }
    procedure AdjustDPISettings;
  public
  { Public declarations }
    ServiceName, Question, Response, RspReqYN, RspCmntReqd: String;
  end;

var
  AMCUserValidationCmnt: TAMCUserValidationCmnt;
  RspCategory: Integer;

implementation

{$R *.dfm}

uses
  UStatus;

procedure TAMCUserValidationCmnt.bbtnOKClick(Sender: TObject);
begin
  modalResult := mrOK;
end;

procedure TAMCUserValidationCmnt.mmCommentChange(Sender: TObject);
begin
  meCharBal.Text := IntToStr(mmComment.MaxLength - Length(mmComment.Text));
  OKBtnChk;
end;

procedure TAMCUserValidationCmnt.FormShow(Sender: TObject);

  function BuildRspCategory(ReqYN, CmntReqd: String): Integer;
  begin
    if ReqYN = 'Y' then
      Result := 0
    else
      Result := 5;
    if CmntReqd = 'Y' then
      Result := Result + 1
    else if CmntReqd = 'N' then
      Result := Result + 2
    else if CmntReqd = 'Always' then
      Result := Result + 3
    else if CmntReqd = 'Never' then
      Result := Result + 4
    else
      Result := Result + 5;
  end;

begin
  Caption := ServiceName + ' Question or Message Response';
  mmDescr.Lines.Text := Question;
  meCharBal.Text := IntToStr(mmComment.MaxLength);

  rbRespYes.Checked := False;
  rbRespYes.Font.Color := clRed;
  rbRespNo.Checked := False;
  rbRespNo.Font.Color := clRed;
  if RspReqYN = 'N' then
    begin
      rbRespYes.Visible := False;
      rbRespNo.Visible := False;
    end
  else if Length(Response) >= 2 then
    if Copy(Response, 1, 2) = 'Y;' then
      begin
        Response := Copy(Response, 3, Length(Response));
        rbRespYes.Checked := True;
      end
    else if Copy(Response, 1, 2) = 'N;' then
      begin
        Response := Copy(Response, 3, Length(Response));
        rbRespNo.Checked := True;
      end;
  if Length(Response) > mmComment.MaxLength then
    mmComment.Text := Copy(Response, 1, mmComment.MaxLength)
  else
    mmComment.Text := Response;
  RspCategory := BuildRspCategory(RspReqYN, RspCmntReqd);
  SetRspCategory;

  AdjustDPISettings;

  OKBtnChk;
  Refresh;
  mmComment.SetFocus;
end;

procedure TAMCUserValidationCmnt.AdjustDPISettings;
begin
  Panel1.Align := alBottom;
  Panel1.Width := self.Width;
  bbtnCancel.Left := Panel1.Width  - bbtnCancel.width - 50;
  bbtnOK.Left := bbtnCancel.Left - bbtnOK.Width - 60;
end;

procedure TAMCUserValidationCmnt.OKBtnChk;
begin
  case RspCategory of
    1:
      begin
        bbtnOK.Enabled := (rbRespYes.Checked or rbRespNo.Checked);
        if rbRespYes.Checked and (Length(mmComment.Text) = 0) then
          bbtnOK.Enabled := False;
      end;
    2:
      begin
        bbtnOK.Enabled := (rbRespYes.Checked or rbRespNo.Checked);
        if rbRespNo.Checked and (Length(mmComment.Text) = 0) then
          bbtnOK.Enabled := False;
      end;
    3: bbtnOK.Enabled := (Length(mmComment.Text) > 0) and (rbRespYes.Checked or rbRespNo.Checked);
    4,5: bbtnOK.Enabled := (rbRespYes.Checked or rbRespNo.Checked);
    8: bbtnOK.Enabled := (Length(mmComment.Text) > 0);
  else
    bbtnOK.Enabled := True;
  end;  
end;

procedure TAMCUserValidationCmnt.SetRspCategory;
begin
  mmComment.Visible := True;
  case RspCategory of
    1:
      if rbRespYes.Checked then
        lblAppraiserComment.Font.Color := clRed
      else
        lblAppraiserComment.Font.Color := clWindowText;
    2:
      if rbRespNo.Checked then
        lblAppraiserComment.Font.Color := clRed
      else
        lblAppraiserComment.Font.Color := clWindowText;
    3,6,8:
        lblAppraiserComment.Font.Color := clRed;
  else
    lblAppraiserComment.Font.Color := clWindowText;
  end;
end;

procedure TAMCUserValidationCmnt.rbRespYesClick(Sender: TObject);
begin
  SetRspCategory;
  OKBtnChk;
end;

procedure TAMCUserValidationCmnt.rbRespNoClick(Sender: TObject);
begin
  SetRspCategory;
  OKBtnChk;
end;

end.
