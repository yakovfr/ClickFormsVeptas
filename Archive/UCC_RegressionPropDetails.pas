unit UCC_RegressionPropDetails;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc.}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, UForms,
  Dialogs, ExtCtrls, RzButton, StdCtrls, Buttons, jpeg;

type
  TFProperty = class(TAdvancedForm)
    Panel1: TPanel;
    Label12: TLabel;
    salepricelbl: TLabel;
    Label14: TLabel;
    saledatelbl: TLabel;
    Label20: TLabel;
    predvallbl: TLabel;
    Label16: TLabel;
    predratiolbl: TLabel;
    Label17: TLabel;
    glalbl: TLabel;
    Label19: TLabel;
    sitearealbl: TLabel;
    Label26: TLabel;
    yblbl: TLabel;
    Label24: TLabel;
    brlbl: TLabel;
    Label22: TLabel;
    balbl: TLabel;
    Label21: TLabel;
    poollbl: TLabel;
    lblFirePl: TLabel;
    fplbl: TLabel;
    Label30: TLabel;
    basementlbl: TLabel;
    Label28: TLabel;
    cslbl: TLabel;
    btnClose: TBitBtn;
    btnExcluded: TRzBitBtn;
    Panel2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    lblRank: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure AdjustDPISettings;
  public
    { Public declarations }
  end;

var
  FProperty: TFProperty;

implementation

{$R *.dfm}

procedure TFProperty.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TFproperty.AdjustDPISettings;
begin
    btnExcluded.left := lblFirePl.left + lblFirePl.width + 80;
    btnExcluded.top  := fplbl.top;
    btnClose.top     := btnExcluded.top;

    self.width := btnClose.left + btnClose.width + 30;
    self.height := btnExcluded.top + btnExcluded.height + 80;
    self.Constraints.minWidth := self.width;
    self.Constraints.minHeight := self.height;
end;

procedure TFProperty.FormShow(Sender: TObject);
begin
    AdjustDPISettings;
end;

end.
