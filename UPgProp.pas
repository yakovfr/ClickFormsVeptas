unit UPgProp;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UForms;

type
  TPgProperty = class(TAdvancedForm)
    btnOK: TButton;
    btnCancel: TButton;
    edtTitle: TEdit;
    Label1: TLabel;
    chkBxIncludePgNum: TCheckBox;
    chkBxIncludeTC: TCheckBox;
    pnlProperties: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure AdjustDPISettings;
  public
    { Public declarations }
    procedure SetProperty(const Title: string; IncludePgNum, IncludeTC: Boolean);
    procedure GetProperty(var Title: String; var IncludePgNum, IncludeTC: Boolean);
  end;

var
  PgProperty: TPgProperty;

implementation

{$R *.DFM}

{ TPgProperty }

procedure TPgProperty.AdjustDPISettings;
begin
  btnOK.Left := edtTitle.Left + edtTitle.Width + 30;
  btnOK.top := edtTitle.Top;
  btnCancel.Left := btnOK.Left;
  btnCancel.Top := btnOK.Top + btnOK.Height + 20;

  self.Width := btnCancel.Left + btnCancel.Width + 50;
  self.Height := btnCancel.Top + btnCancel.Height + 80;

  self.Constraints.MaxWidth := 0;
  self.Constraints.MinWidth := 0;
  self.Constraints.MaxHeight := 0;
  self.Constraints.MinHeight := 0;

end;

procedure TPgProperty.GetProperty(var Title: String; var IncludePgNum,
  IncludeTC: Boolean);
begin
  Title := edtTitle.Text;
  IncludePgNum := chkBxIncludePgNum.checked;
  IncludeTC := chkBxIncludeTC.checked;
end;

procedure TPgProperty.SetProperty(const Title: string; IncludePgNum,
  IncludeTC: Boolean);
begin
  edtTitle.Text := Title;
  chkBxIncludePgNum.checked := IncludePgNum;
  chkBxIncludeTC.checked := IncludeTC;
end;

procedure TPgProperty.FormShow(Sender: TObject);
begin
  AdjustDPISettings;
end;

end.
