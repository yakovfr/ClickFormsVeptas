unit UPortFloodZoning;

 {  ClickForms Application                }
 {  Bradford Technologies, Inc.           }
 {  All Rights Reserved                   }
 {  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  ComCtrls, ExtCtrls, TMultiP,
  UContainer, UCell, UClientFloodInsights, IdBaseComponent,
  IdAntiFreezeBase, IdAntiFreeze, Jpeg, RzLine, UForms;

type
  TFloodZonePort = class(TAdvancedForm)
    Panel2:          TPanel;
    Label2:          TLabel;
    edtAddress:      TEdit;
    Label3:          TLabel;
    edtCity:         TEdit;
    Label8:          TLabel;
    edtState:        TEdit;
    Label6:          TLabel;
    edtZip:          TEdit;
    Label5:          TLabel;
    edtPlus4:        TEdit;
    RzLine1:         TRzLine;
    btnLocate:       TButton;
    btnCancel:       TButton;
    Label9:          TLabel;
    edtGeoResult:    TEdit;
    RzLine2:         TRzLine;
    lblSFHA:         TLabel;
    edtSFHA:         TEdit;
    edtSFHAPhrase:   TEdit;
    edtPanel:        TEdit;
    Label10:         TLabel;
    edtPanelDate:    TEdit;
    Label11:         TLabel;
    edtZone:         TEdit;
    Label1:          TLabel;
    edtLong:         TEdit;
    Label4:          TLabel;
    edtCensus:       TEdit;
    edtZip4:         TEdit;
    lblZip4:         TLabel;
    edtLat:          TEdit;
    Label7:          TLabel;
    Label12:         TLabel;
    AnimateProgress: TAnimate;
    Label13: TLabel;
    edtMapNumber: TEdit;
    procedure btnLocateClick(Sender: TObject);
  private
    FDoc:           TContainer;
    FDestCell:      TBaseCell;
    FFloodClient:   TFloodInsightClient;
    FHasDataResult: boolean;
    FHasAnimateFile: boolean;
    FRequery:       boolean;
  protected
    //procedure CheckServiceExpiration;
  public
    constructor CreateFlood(AOwner: TComponent; cell: TBaseCell);
    destructor Destroy; override;
    function VerifyRequest: boolean;
    procedure GetFloodZoneInfo;
    function GetCFDB_FloodZoneInfo(Resubmit: boolean; AddressIndex: integer): string;
    function GetCFAW_FloodZoneInfo(Resubmit: boolean; AddressIndex: integer): string;
    procedure DisplayResults(ResStr: string);
    function TransferResults: boolean;
    procedure TransferData2Report;
  end;

procedure RequestFloodZone(doc: TContainer; cell: TBaseCell; RequeryStr: string; ReSpotting: boolean);


var
  FloodZonePort: TFloodZonePort;



implementation

uses
  Clipbrd,
  UGlobals, UStatus, UMain, UForm, UEditor, UUtil1, UUtil2, ULicUser, UWinUtils,
  {UClientMessaging, UStatusService,} UWebConfig, UMapUtils, uBase,
  UAutoUpdate, UPgAnnotation, UPortFloodAddresses, UStrings;
  //UServiceManager;

{$R *.dfm}

const
  fidFloodMapLetterSize = 102;            //form ID of the map pages
  fidFloodMapLegalSize  = 102;
  cidFloodMapImage      = 1158;           //cell id of all map images

  FloodMapHeightTWIPS   = 9000;           //9000=600 pixels
  FloodMapWidthTWIPS    = 7960;           //7980=532 pixels;

  Flood_PIN = 'SN-123';      //PAM: per Yakov, we can put in a dummy constant here



{ This is main routine for getting Flood Zone data}  
procedure RequestFloodZone(doc: TContainer; cell: TBaseCell; RequeryStr: string; ReSpotting: boolean);
var
  Flood: TFloodZonePort;
begin
// - check for available units here, allow to purchase
// - UServiceManager.CheckAvailability(stFloodData);

  if assigned(doc) then
    doc.SaveCurCell;         //save changes
  Flood := TFloodZonePort.CreateFlood(Doc, Cell);    //create the flood map maker
  try
    try
      Flood.ShowModal;
    except on E:Exception do
      ShowAlert(atWarnAlert, errOnFloodData+' | '+E.Message);
    end;
  finally
    Flood.Free;
  end;

  //let user know how many units /time is left
  //UServiceManager.CheckServiceExpiration(stFloodData);
end;



{ TFloodPort }

constructor TFloodZonePort.CreateFlood(AOwner: TComponent; cell: TBaseCell);
var
  GlobePath: string;
begin
  inherited Create(nil);

  FDoc      := TContainer(AOwner);
  FDestCell := cell;

  FHasDataResult := false;
  FRequery       := false;

  FFloodClient          := TFloodInsightClient.Create(Self);
  FFloodClient.WantsMap := Flood_UserWantsDataOnly;    //=1 map will NOT be charged to user

  //prefill with report data
  if Assigned(FDoc) then
  begin
    edtAddress.Text := FDoc.GetCellTextByID(46);
    edtCity.Text    := FDoc.GetCellTextByID(47);
    edtState.Text   := FDoc.GetCellTextByID(48);
    edtZip.Text     := GetZipCodePart(FDoc.GetCellTextByID(49), 1);
    edtPlus4.Text   := GetZipCodePart(FDoc.GetCellTextByID(49), 2);
  end;

  GlobePath       := IncludeTrailingPathDelimiter(appPref_DirCommon) + SpinningGlobe;
  FHasAnimateFile := FileExists(GlobePath);
  if FHasAnimateFile then
    AnimateProgress.FileName := GlobePath;
  AnimateProgress.Active := false;
end;


destructor TFloodZonePort.Destroy;
begin
  FFloodClient.Free;

  inherited;
end;

function TFloodZonePort.VerifyRequest: boolean;
var
  AddrLen, CityLen, StateLen, ZipLen, Plus4Len, Idx: Integer;
begin
//  Result := (length(edtAddress.Text) > 0) and (length(edtCity.Text) > 0) and
//    (length(edtCity.Text) > 0) and (length(edtState.Text) > 0);
  { and (length(edtZip.Text) > 0);}
  AddrLen := Length(Trim(edtAddress.Text));
  CityLen := Length(Trim(edtCity.Text));
  StateLen := Length(Trim(edtState.Text));
  ZipLen := Length(GetFirstNumInStr(edtZip.Text, True, Idx));
  Plus4Len := Length(GetFirstNumInStr(edtPlus4.Text, True, Idx));
  Result := (AddrLen > 0) and (CityLen > 0) and (StateLen = 2) and (ZipLen = 5) and
            ((Plus4Len = 0) or (Plus4Len = 4));

  if not Result then
    ShowNotice('Not all the address fields were filled in. Please enter a valid address.');
end;

procedure TFloodZonePort.btnLocateClick(Sender: TObject);
begin
  if FHasDataResult then
    TransferResults
  else
    GetFloodZoneInfo;
end;

procedure TFloodZonePort.GetFloodZoneInfo;
var
  sSubmitResult: string;
  Resubmit:      boolean;
  AddressIndex:  integer;
begin
  if VerifyRequest then
    try
      PushMouseCursor(crHourglass);   //show wait cursor
      try
        if FHasAnimateFile then
          AnimateProgress.Active := true;

        //first submittal
        Resubmit     := false;
        AddressIndex := -1;
        repeat
          sSubmitResult := GetCFDB_FloodZoneInfo(Resubmit, AddressIndex);
          if sSubmitResult = 'Multiple' then
          begin
            AddressIndex := SelectFloodPropertyIndex(FFloodClient.MulAddressList);
            Resubmit     := true;
          end;
          // repeat until we get good results or user canceled property selection
        until (sSubmitResult <> 'Multiple') or (Resubmit and (AddressIndex < 0));

  // 101813 Following commented - the CF Flood Zone service is not implemented on AWSI at this time
{        // if the CustDB response is blank or an error (not authorized, no credits, etc.) then try AppraisalWorld
        if (sSubmitResult = srCustDBRspIsEmpty) or (sSubmitResult = srCustDBRspIsError)
          or (sSubmitResult = '')then
          begin
            if CurrentUser.OK2UseAWProduct(pidOnlineFloodMaps) then
              begin
                //first AW submittal
                Resubmit     := false;
                AddressIndex := -1;
                repeat
                  sSubmitResult := GetCFAW_FloodZoneInfo(Resubmit, AddressIndex);
                  if sSubmitResult = 'Multiple' then
                  begin
                    AddressIndex := SelectFloodPropertyIndex(FFloodClient.MulAddressList);
                    Resubmit     := true;
                  end;
                  // repeat until we get good results or user canceled property selection
                until (sSubmitResult <> 'Multiple') or (Resubmit and (AddressIndex < 0));
              end
            else
              sSubmitResult := 'Error';
          end;
}
        //added by vivek
        if (length(sSubmitResult) > 0) and (sSubmitResult = 'Single') and (sSubmitResult <> 'Error') then
        begin
          DisplayResults(sSubmitResult);
        end;

      finally
        if FHasAnimateFile then
          AnimateProgress.Active := false;
        PopMouseCursor;
      end;
    except
      on E: Exception do
        ShowNotice(FriendlyErrorMsg(E.Message));
    end
  else
    begin
      ShowNotice('One or more of the address fields is blank or incorrect. Please enter a valid address.');
      edtAddress.SetFocus;
    end;
end;

//changed return type from boolean to string ... vivek
function TFloodZonePort.GetCFDB_FloodZoneInfo(Resubmit: boolean; AddressIndex: integer): string;
begin
  Result := '';
  try
      if resubmit then //need to call GetCFDB_MapEx to get the map for the selected address form the list
      begin
           //we dont need to re-assign all the properties to FFloodClient
           //as this call will always be a second call and the object will
           //always have these info
        Result := FFloodClient.GetCFDB_MapEx(AddressIndex);
      end
      else //regular action as before
      begin
        FFloodClient.SubjectLabel         := 'SUBJECT';
        FFloodClient.SubjectStreetAddress := edtAddress.Text;
        FFloodClient.SubjectCity          := edtCity.Text;
        FFloodClient.SubjectState         := edtState.Text;
        FFloodClient.SubjectZip           := edtZip.Text;
        FFloodClient.SubjectPlus4         := edtPlus4.Text;

        FFloodClient.MapHeight := FloodMapHeightTWIPS;
        FFloodClient.MapWidth  := FloodMapWidthTWIPS;

        FFloodClient.AccountID := CurrentUser.AWUserInfo.UserCustUID;
///     FFloodClient.Pin       := CurrentUser.LicInfo.UserSerialNo;
        FFloodClient.Pin       := Flood_PIN;;
        FFloodClient.ISAPIURL  := GetURLForFloodInsights;

        //if we could not read the CustID exit from here
        if (StrToIntDef(FFloodClient.AccountID,0) > 0) then
          Result := FFloodClient.GetCFDB_Map(False)
        else
          ShowAlert(atStopAlert, msgCantUseFlood);
      end;
  except on E:Exception do
     ShowAlert(atWarnAlert,errOnFloodData+' | '+E.Message);
  end;
end;

function TFloodZonePort.GetCFAW_FloodZoneInfo(Resubmit: boolean; AddressIndex: integer): string;
begin
  Result := '';
  try
    if resubmit then //need to call GetCFAW_MapEx to get the map for the selected address form the list
    begin
         //we dont need to re-assign all the properties to FFloodClient
         //as this call will always be a second call and the object will
         //always have these info
      Result := FFloodClient.GetCFAW_MapEx(AddressIndex);
    end;
  except on E:Exception do
    ShowAlert(atWarnAlert,errOnFloodData+' | '+E.Message);
  end;
end;

procedure TFloodZonePort.DisplayResults(ResStr: string);
begin
  //added by vivek
  //display results based on server results
  if ResStr = 'Single' then
  begin
    //accuracy
    if UpperCase(Copy(FFloodClient.GeoResult, 0, 2)) = 'S5' then
      edtGeoResult.Text         := 'S5 - Most Accurate Match Possible'
    else
      if UpperCase(Copy(FFloodClient.GeoResult, 0, 2)) = 'S4' then
        edtGeoResult.Text       := 'S4 - Single Close Match, Shape Point Path'
      else
        if UpperCase(Copy(FFloodClient.GeoResult, 0, 2)) = 'S3' then
          edtGeoResult.Text     := 'S3 - Single Close Match, Zip+4 Centroid'
        else
          if UpperCase(Copy(FFloodClient.GeoResult, 0, 2)) = 'S2' then
            edtGeoResult.Text   := 'S2 - Single Close Match, Zip+2 Centroid'
          else
            if UpperCase(Copy(FFloodClient.GeoResult, 0, 2)) = 'S1' then
              edtGeoResult.Text := 'S1 - Least Accurate Match Possible';


    edtCensus.Text     := FFloodClient.CensusTract;        //'608551763484940';
    edtLong.Text       := FFloodClient.Longitude;          //'-121.773';
    edtLat.Text        := FFloodClient.Latitude;           //'37.225279';
    edtZone.Text       := FFloodClient.Zone;               // 'D';
    edtPanel.Text      := FFloodClient.Panel;              // '0049D';
    edtPanelDate.Text  := FFloodClient.PanelDate;          //'19820902');
    edtMapNumber.Text  := FFloodClient.MapNumber; 
    edtSFHA.Text       := FFloodClient.SHFAResult;         //'out';
    edtSFHAPhrase.Text := FFloodClient.SFHAPhrase;         //'Within 250 feet';
    edtZip4.Text       := FFloodClient.ZipPlus4;           //'95139-1350';

    FHasDataResult    := true;
    btnLocate.Caption := 'Transfer';

    //      edtFIPS.text          := FFloodClient.FIPSCode;           //'06085';
    //      edtCommunityName.Text := FFloodClient.CommunityName;      //'San Jose, City of';
    //      edtCommunity.Text     := FFloodClient.CommunityID;        // '060349';
  end
  else
    raise Exception.Create('There were errors reading the flood zone information');
end;

function TFloodZonePort.TransferResults: boolean;
begin
  Result := true;
  try
    if FDoc = nil then            //make sure we have a container
      FDoc := Main.NewEmptyDoc;

    TransferData2Report;

    ModalResult := mrOk;              //transfers done, we're gone
  except
    on E: Exception do
      ShowNotice(E.Message);
  end;
end;

procedure TFloodZonePort.TransferData2Report;
begin
  if assigned(FDoc) then
  begin
    //flood hazzard info
    if (compareText('In', edtSFHA.Text) = 0) then
      FDoc.SetCellTextByID(104, 'X')               //set the flood hazzard area
    else
      FDoc.SetCellTextByID(105, 'X');
    FDoc.SetCellTextByID(106, edtZone.Text);            //set the Zone
    FDoc.SetCellTextByID(107, edtPanelDate.Text);       //set the Panel Date
    FDoc.SetCellTextByID(108, edtMapNumber.Text);           //set the panel Number
    //      FDoc.SetCellTextByID(1392, edtCommunityName.Text);  //set the panel Number

    //property info
    FDoc.SetCellTextByID(599, edtCensus.Text);      //set the Census Tract
    FDoc.SetCellTextByID(49, edtZip4.Text);         //set the zipcode + 4
  end;
end;

 ////////////////////////////////////////////////////////////////////////////////
 // this procedure checks for the service expiration status online.
 ////////////////////////////////////////////////////////////////////////////////
{procedure TFloodZonePort.CheckServiceExpiration;
begin
  UServiceManager.CheckServiceExpiration(stFloodData);
end;    }

(*
var
  MsgClient: TClientMessaging;
  sFlood: string;
  IsExpired: Boolean;
begin
  if (Not DemoMode) and (Length(CurrentUser.LicInfo.UserCustID) > 0) then
    begin
      PushMouseCursor(crHourglass);   //show wait cursor
      MsgClient := TClientMessaging.Create(self);
      try
        try
          //check floodmap web service status
          sFlood := MsgClient.GetLiveServiceStatus(StrToInt(CurrentUser.LicInfo.UserCustID), stFloodData, IsExpired);
          if (Length(sFlood) > 0) and (IsExpired = True) then
            UStatusService.ShowExpiredMsg(sFlood)
          else if (Length(sFlood) > 0) and (IsExpired = False) then
            UStatusService.ShowExpiringMsg(sFlood);
        except
          //show no messages, just move on
        end;
      finally
        MsgClient.Free;
        PopMouseCursor;
      end;
    end;
end;
*)


end.
