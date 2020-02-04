unit UGetName;

{  ClickForms Application             }
{  Bradford Technologies, Inc.        }
{  All Rights Reserved                }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, UForms;

type
  TGetCaption = class(TAdvancedForm)
		btnOK: TButton;
		btnCancel: TButton;
		edtName: TEdit;
    procedure edtNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GetCaption: TGetCaption;

implementation

{$R *.DFM}

procedure TGetCaption.edtNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    btnOK.Click;
end;

end.
