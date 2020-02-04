unit UAMC_UserID_MercuryNetwork;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2018 by Bradford Technologies, Inc. }

{ This is the unit that takes the userID and password and queries the MercuryNetwork }
{ GatorNet system to verify the login credentials.                         }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MSXML6_TLB, WinHTTP_TLB, ComCtrls, comObj,
  UBase64, Grids, HTTPApp, Grids_ts, TSGrid, osAdvDbGrid,
  UWindowsInfo, UContainer, UAMC_Globals, UAMC_Base, UAMC_Login, UAMC_ODP,
  UAMC_Port, UAMC_WorkflowBaseFrame, UGlobals, pngimage, ExtCtrls, Buttons;

type
  TAMC_UserID_MercuryNetwork = class(TWorkflowBaseFrame)
    sTxTitle: TStaticText;
    StaticText2: TStaticText;
    stxAddress: TStaticText;
    stxOrderID: TStaticText;
    edtTrackingID: TEdit;
  private
    FAppraiserHash: String;       //Base64 encoded login & password for the appraiser
    FTrackingID: String;
    FAMCOrder: AMCOrderInfo;
    FOrderSelected: Boolean;
  public
    procedure InitPackageData; override;
    procedure DoProcessData; override;
    procedure SetPackageContents;              //sets the package contents
  end;

implementation

{$R *.dfm}

Uses
  UWebConfig, UStatus, UAMC_Utils, UAMC_Util_ISGN, UFileUtils, UUtil1;

const
  cOrderInvalid   = 'The Mercury Tracking # is EMPTY.  Please click the New Orders under the Order file menu to select an order.';
  cValidateOrder  = 'Click the New Orders under the Order file menu to validate this order.';
  cOrderValid     = 'Order is valid - click the Next button to proceed.';
{ TAMC_PackageDef }

procedure TAMC_UserID_MercuryNetwork.InitPackageData;
var
  UserInfo: AMCUserUID;
  Cntr: Integer;
begin
  inherited;
  //init vars
  FAMCOrder := FDoc.ReadAMCOrderInfoFromReport;   //has all info about order/user
  if FAMCOrder.OrderID = '' then
    FAMCOrder.OrderID := FDoc.GetCellTextByID(8019);

  if FDoc.FAMCOrderInfo.OrderID = '' then
    FDoc.FAMCOrderInfo.OrderID := FDoc.GetCellTextByID(8019);;

  FOrderSelected := False;
  FAppraiserHash := '';       //session ID for appraiser
  FTrackingID := '';             //orderID

  edtTrackingID.Text := Format('%d',[FDoc.FAMCOrderInfo.TrackingID]);
  if GetValidInteger(edtTrackingID.Text) = 0  then //in case we just open the report w/o open the order manager
    begin
      if FAMCOrder.OrderID <> '' then  //if we found order id or tracking id on the form use it.
        begin
          edtTrackingID.Text := FAMCOrder.OrderID;
          if FDoc.FAMCOrderInfo.TrackingID = 0 then
            FDoc.FAMCOrderInfo.TrackingID := GetValidInteger(edtTrackingID.Text);
        end
      else if FDoc.FAMCOrderInfo.OrderID <> '' then
        begin
          edtTrackingID.Text := FDoc.FAMCOrderInfo.OrderID;
          if FDoc.FAMCOrderInfo.TrackingID = 0 then
            FDoc.FAMCOrderInfo.TrackingID := GetValidInteger(edtTrackingID.Text);
        end;
    end;

  if getValidInteger(edtTrackingID.Text) > 0 then
    begin
      edtTrackingID.Enabled := False;
      FTrackingID := edtTrackingId.Text;
    end
  else
    begin
      edtTrackingID.Enabled := True;
    end;




  stxAddress.Caption := PackageData.SubjectAddress;  //display the subject address to user

  //defaults for MercuryNetwork
  PackageData.FForceContents := True;     //user cannot change package contents
  PackageData.FNeedPDF := True;           //MercuryNetwork always needs PDF as a separate file
  PackageData.FEmbbedPDF := True;         //PDF is embedded only in the 2.6GSE XML
end;


procedure TAMC_UserID_MercuryNetwork.SetPackageContents;
var
  dataFile: TDataFile;
  AMCData: TAMCData_MercuryNetwork;
begin
  PackageData.FDataFiles.Clear;     //delete all previous DataObjs

  if PackageData.IsUAD and (PackageData.FXMLVersion = cMISMO26GSE) then
    begin
      dataFile := TDataFile.Create(fTypXML26GSE);
      PackageData.FDataFiles.add(dataFile);
    end;

  if PackageData.FNeedXML26 then
    begin
      dataFile := TDataFile.Create(fTypXML26);
      PackageData.FDataFiles.add(dataFile);
    end;

  if PackageData.FNeedENV then
    begin
      dataFile := TDataFile.Create(fTypENV);
      PackageData.FDataFiles.add(dataFile);
    end;

  //we always require the PDF
  dataFile := TDataFile.Create(fTypPDF);
  PackageData.FDataFiles.add(dataFile);


  if Assigned(PackageData.FAMCData) then        //Init the AMC Specific data object
    PackageData.FAMCData.free;

  AMCData := TAMCData_MercuryNetwork.Create;       //Create a new StreetLinks Data Object
//  AMCData.FAppraiserHash := FAppraiserHash;     //set the appraiser Hash (session identifier)
  AMCData.FOrderID := FTrackingID;                 //set the order identifier
  PackageData.FAMCData := AMCData;
end;

procedure TAMC_UserID_MercuryNetwork.DoProcessData;
begin
  inherited;

  FOrderSelected := GetValidInteger(edtTrackingID.Text) > 0;
  PackageData.NeedENV := (Uppercase(AMCENV_Req) = 'Y');
  SetPackageContents;


  PackageData.FGoToNextOk := FOrderSelected;
  PackageData.FHardStop := not FOrderSelected;

  PackageData.FAlertMsg := '';
  if not FOrderSelected then
    begin
      if Length(FTrackingID) = 0 then
        PackageData.FAlertMsg := cOrderInvalid
      else
        PackageData.FAlertMsg := 'Your user name and/or password was not validated by GatorNet.';
    end;
end;





end.
