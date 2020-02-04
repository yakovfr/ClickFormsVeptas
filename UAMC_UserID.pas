unit UAMC_UserID;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzLine, UContainer, UAMC_Base, UAMC_WorkFlowBaseFrame,
  UGlobals;

type
  TAMC_UserID = class(TWorkflowBaseFrame)
    edtOrderID: TEdit;
    edtVendorID: TEdit;
    edtUserID: TEdit;
    edtUserPSW: TEdit;
    stOrderNo: TStaticText;
    stOrder: TStaticText;
    stAddress: TStaticText;
    stCityStZip: TStaticText;
    stProperty: TStaticText;
    stRecDate: TStaticText;
    stReceived: TStaticText;
    stDueDate: TStaticText;
    stDue: TStaticText;
    stConfirmOrderNo: TStaticText;
    stVendorID: TStaticText;
    stUserID: TStaticText;
    stUserPassword: TStaticText;
  private
//    FDoc: TContainer;
//    FData: TDataPackage;
    FAMCOrder: AMCOrderInfo;      //holds key order info
  public
    procedure InitPackageData; override;
    procedure DoProcessData; override;
//    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
//    property PackageData: TDataPackage read FData write FData;
  end;

implementation

{$R *.dfm}
uses
  UAMC_Login;
  
{ TAMC_UserID }
(*
constructor TAMC_UserID.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited Create(AOwner);

  FDoc := ADoc;
  FData := AData;
end;
*)
{ TAMC_PackageDef }

procedure TAMC_UserID.InitPackageData;
var
  UserInfo: AMCUserUID;
begin
  inherited;

  FAMCOrder := FDoc.ReadAMCOrderInfoFromReport;   //has all info about order/user
  PackageData.OrderID := FAMCOrder.OrderID;
  PackageData.FAddress := FAMCOrder.Address;
  PackageData.FCity := FAMCOrder.City;
  PackageData.FState := FAMCOrder.Province;
  PackageData.FZip := FAMCOrder.PostalCode;

  stOrder.Caption := PackageData.OrderID;
  stAddress.Caption := PackageData.FAddress;
  stCityStZip.Caption := PackageData.FCity + ', ' + PackageData.FState + ' ' + PackageData.FZip;
  stRecDate.Caption := DateToStr(FAMCOrder.RecDate);
  stDueDate.Caption := DateToStr(FAMCOrder.DueDate);

  edtOrderID.Text := FAMCOrder.OrderID;
  if Trim(edtOrderID.Text) <> '' then
    edtOrderID.Enabled := False
  else
    edtOrderID.Enabled := True;
  edtVendorID.Text := FAMCOrder.ProviderID;
  if Trim(edtVendorID.Text) <> '' then
    edtVendorID.Enabled := False
  else
    edtVendorID.Enabled := True;

  //defaults for AMCs
  PackageData.FForceContents := False;     //user can change package contents
  PackageData.FNeedXML241 := (FAMCOrder.XMLVer = '2.4.1');
  PackageData.FNeedXML26 := (FAMCOrder.XMLVer = '2.6');
  PackageData.FNeedXML26GSE := (FAMCOrder.XMLVer = '2.6GSE');
  PackageData.FNeedPDF := True;            //always needs PDF as a separate file
  PackageData.FEmbbedPDF := True;          //PDF is always embedded
  PackageData.FGoToNextOk := False;
  if length(trim(edtOrderID.Text)) > 0 then
    begin
      if AMCStdInfo[FAMCOrder.ProviderIdx].SessionPW then
        begin
          if UserInfo.UserId = AMCUserID then
            UserInfo.UserPSW := AMCUserPassword
          else
            UserInfo.UserPSW := '';
          edtUserID.Text := UserInfo.UserId;
          edtUserPSW.Text := UserInfo.UserPSW;
        end
      else
        begin
          if GetAMCUserRegistryInfo(FAMCOrder.ProviderID, UserInfo) then
            begin
              edtUserID.Text := UserInfo.UserId;
              edtUserPSW.Text := UserInfo.UserPSW;
            end
          else
            begin
              edtUserID.Text := '';
              edtUserPSW.Text := '';
            end;
        end;
    end;
end;

procedure TAMC_UserID.DoProcessData;
begin
  inherited;
  AMCUserID := Trim(edtUserID.Text);
  AMCUserPassword := Trim(edtUserPSW.Text);
  PackageData.FGoToNextOk := ((AMCUserID <> '') and (AMCUserPassword <> ''));

  PackageData.FAlertMsg := '';
  if not PackageData.FGoToNextOk then
    begin
      PackageData.FAlertMsg := 'You need to enter your User ID and Password to proceed.';
      if Trim(edtUserID.Text) = '' then
        edtUserID.SetFocus
      else
        edtUserPSW.SetFocus;
    end;
end;

end.
