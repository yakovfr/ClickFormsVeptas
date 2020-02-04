unit UStatusService;

 {  ClickForms Application                }
 {  Bradford Technologies, Inc.           }
 {  All Rights Reserved                   }
 {  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, RzLabel, UForms;

const
  serviceAppraisalPort   = 'appraisalport';
  serviceFloodmaps       = 'floodmaps';
  serviceLocationMaps    = 'locationmaps';
  serviceFidelity        = 'propertydata';
  serviceVeros           = 'veros';
  serviceRenewal         = 'renewal';
  serviceMarshalAndSwift = 'swift';
  serviceImportData      = 'importdata';
  serviceLighthouse      = 'lighthouse';

type
  TWSStatus = class(TAdvancedForm)
    ImageExpired:     TImage;
    ImageIcon:        TImage;
    Shape1:           TShape;
    btnCancel:        TButton;
    btnRenew:         TButton;
    LabelMsg:         TLabel;
    LabelRenewMsg:    TLabel;
    BevelLine:        TBevel;
    ImageExpiring:    TImage;
    RzURLOrderOnline: TRzURLLabel;
    ImageException:   TImage;
    LabelMsgCaption:  TLabel;
    AAImage:          TImage;
    Label1:           TLabel;
    LabelPurchaseMsg: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnRenewClick(Sender: TObject);

  private
    fServiceName:     string;
   { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowExpiredMsg(const msg: string; const serviceName: string = '');
procedure ShowExpiringMsg(const msg: string; const serviceName: string = '');
//procedure ShowExceptionMsg(const msg: string; const serviceName: string = '');
//procedure ShowNotPurchasedMsg(const msg: string; const serviceName: string = '');


var
  WSStatus: TWSStatus;

implementation

Uses
  UNewsDesk;

{$R *.dfm}

procedure ShowExpiredMsg(const msg: string; const serviceName: string);
var
  WSStatus: TWSStatus;
begin
  WSStatus := TWSStatus.Create(nil);
  try
    WSStatus.fServiceName := serviceName;
    WSStatus.ImageExpiring.Visible := false;
    WSStatus.ImageException.Visible := false;
    WSStatus.ImageExpired.Visible    := true;
    WSStatus.LabelMsgCaption.Caption := 'Subscription Expired';

    WSStatus.LabelMsg.Caption      := msg;
    WSStatus.BevelLine.Visible     := true;
    WSStatus.LabelRenewMsg.Visible   := false;
    WSStatus.LabelPurchaseMsg.Visible:= true;
    //    WSStatus.ShapeBot.Brush.Color := RGB(254,112,66);

    WSStatus.ShowModal;
  finally
    WSStatus.Free;
  end;
end;

procedure ShowExpiringMsg(const msg: string; const serviceName: string);
var
  WSStatus: TWSStatus;
begin
  WSStatus := TWSStatus.Create(nil);
  try
    WSStatus.fServiceName := serviceName;
    WSStatus.ImageExpiring.Visible := true;
    WSStatus.ImageException.Visible := false;
    WSStatus.ImageExpired.Visible    := false;
    WSStatus.LabelMsgCaption.Caption := 'Subscription Expiring';

    WSStatus.LabelMsg.Caption      := msg;
    WSStatus.BevelLine.Visible     := true;
    WSStatus.LabelRenewMsg.Visible := true;
    WSStatus.LabelPurchaseMsg.Visible:= false;
    WSStatus.btnCancel.Caption     := '&Continue';

    WSStatus.ShowModal;
  finally
    WSStatus.Free;
  end;
end;

procedure ShowExceptionMsg(const msg: string; const serviceName: string);
var
  WSStatus: TWSStatus;
begin
  WSStatus := TWSStatus.Create(nil);
  try
    WSStatus.fServiceName := serviceName;
    WSStatus.ImageExpiring.Visible := false;
    WSStatus.ImageException.Visible := true;
    WSStatus.ImageExpired.Visible    := false;
    WSStatus.LabelMsgCaption.Caption := 'Error';

    WSStatus.LabelMsg.Caption      := msg;
    WSStatus.BevelLine.Visible     := false;
    WSStatus.LabelRenewMsg.Visible := false;

    WSStatus.btnRenew.Visible  := false;
    WSStatus.btnCancel.Caption := '&Ok';

    WSStatus.ShowModal;
  finally
    WSStatus.Free;
  end;
end;

procedure ShowNotPurchasedMsg(const msg: string; const serviceName: string);
var
  WSStatus: TWSStatus;
begin
  WSStatus := TWSStatus.Create(nil);
  try
    WSStatus.fServiceName := serviceName;
    WSStatus.ImageExpiring.Visible := false;
    WSStatus.ImageException.Visible := false;
    WSStatus.ImageExpired.Visible    := true;
    WSStatus.LabelMsgCaption.Caption := 'Subscription Not Purchased';

    WSStatus.LabelMsg.Caption      := msg;
    WSStatus.BevelLine.Visible     := true;
    WSStatus.LabelRenewMsg.Visible := true;
    WSStatus.btnRenew.Caption      := 'Purchase';
    WSStatus.btnCancel.Caption     := 'Later Gator';
    WSStatus.LabelRenewMsg.Caption :=
      'To purchase this service online please click the "Purchase" button. If you would like to speak to a sales representative call 1-800-622-8727.';

    WSStatus.ShowModal;
  finally
    WSStatus.Free;
  end;
end;

procedure TWSStatus.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TWSStatus.btnRenewClick(Sender: TObject);
begin
  Close;
  UNewsDesk.LaunchAWStoreInBrowser(fServiceName);
end;

end.
