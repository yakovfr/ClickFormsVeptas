unit UCC_OrderConfirmation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  UForms{, UCC_Appraisal};

type
  TCC_OrderConfirm = class(TAdvancedForm)
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblPropertyAddress: TLabel;
    lblPropertyCity: TLabel;
    lblPropertyState: TLabel;
    lblPropertyZip: TLabel;
    Label7: TLabel;
    lblEffDate: TLabel;
    imgSubject: TImage;
    Label8: TLabel;
    lblReportType: TLabel;
    procedure btnOkClick(Sender: TObject);
  private
//    FAppraisal: TAppraisal;
//    procedure SetAppraisal(const Value: TAppraisal);
  public
//    property Appraisal: TAppraisal read FAppraisal write SetAppraisal;
  end;


implementation

uses
  UStatus;
//  UCC_ProcessMgr, UCC_ReportsBase;


{$R *.dfm}

{ TCC_OrderConfirm }
(*
procedure TCC_OrderConfirm.SetAppraisal(const Value: TAppraisal);
begin
  FAppraisal := Value;

  lblPropertyAddress.caption  := Appraisal.Subject.Location.AddressWUnit;
  lblPropertyCity.caption     := Appraisal.Subject.Location.City;
  lblPropertyState.caption    := Appraisal.Subject.Location.State;
  lblPropertyZip.caption      := Appraisal.Subject.Location.Zip;
  lblEffDate.caption          := Appraisal.Recon.EffectiveDate;
  lblReportType.caption       := CompCruncherReportsLibrary.GetReportNameByUID(Appraisal.Control.ReportUID);

  if assigned(Appraisal.Subject.VerifiedAddressImage) then
    imgSubject.Picture.Bitmap.Assign(Appraisal.Subject.VerifiedAddressImage);
end;
*)

procedure TCC_OrderConfirm.btnOkClick(Sender: TObject);
begin
  //double check for a blank effective date
(*
  if Trim(Appraisal.Recon.EffectiveDate) = '' then
    begin
      ShowAlert(atWarnAlert, 'The effective date has not be set. Please set the effective date of the appraisal before proceeding.');
      modalResult := mrCancel;
    end
  else
    ModalResult := mrOk;
*)
  ModalResult := mrOK;
end;

end.
