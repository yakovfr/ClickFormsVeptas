unit UInsertSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UForms;

type
  TSelectImageSource = class(TAdvancedForm)
    btnSelectFile: TButton;
    btnSelectDevice: TButton;
    btnCancel: TButton;
    btnSetup: TButton;
    procedure btnSetupClick(Sender: TObject);
    procedure btnSelectDeviceClick(Sender: TObject);
    procedure btnSelectFileClick(Sender: TObject);
  private
  public
  end;

var
  SelectImageSource: TSelectImageSource;

implementation

{$R *.dfm}

Uses
  UEditor;

procedure TSelectImageSource.btnSelectFileClick(Sender: TObject);
begin
  Tag := 1;
end;

procedure TSelectImageSource.btnSelectDeviceClick(Sender: TObject);
begin
  Tag := 2;
end;

procedure TSelectImageSource.btnSetupClick(Sender: TObject);
begin
  Tag := 3;
end;



end.
