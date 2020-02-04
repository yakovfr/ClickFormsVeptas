unit UPortFloodInsights;

 {  ClickForms Application                }
 {  Bradford Technologies, Inc.           }
 {  All Rights Reserved                   }
 {  Source Code Copyrighted © 1998-2018 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils,
  ComCtrls, ExtCtrls, TMultiP,
  UContainer, UCell, UClientFloodInsights, IdBaseComponent,
  IdAntiFreezeBase, IdAntiFreeze, Jpeg, UForms, UAWSI_Utils,
  AWSI_Server_FloodInsights, UBase64,UCRMServices;

type
  TFloodRec = record
    Street: String;
    City  : String;
    State : String;
    Zip   : String;
    Plus4 : String;
    Lon   : String;
    Lat   : String;
    GeoResult: String;
    CensusBlockID: String;
    MapWidth: String;
    MapHeight: String;
    Zoom: String;
    LocationLabel: String;

    LocPtX: String;
    LocPtY: String;
    ImageURL: String;
    ImageID: String;
    ImageName: String;
    MapNumber: String;
  end;
  TFloodPort = class(TAdvancedForm)
    PageControl:      TPageControl;
    TabAddress:       TTabSheet;
    Label2:           TLabel;
    Label3:           TLabel;
    edtCity:          TEdit;
    edtAddress:       TEdit;
    edtState:         TEdit;
    edtZip:           TEdit;
    edtPlus4:         TEdit;
    Label6:           TLabel;
    Label5:           TLabel;
    TabResults:       TTabSheet;
    Panel1:           TPanel;
    btnLocate:        TButton;
    btnCancel:        TButton;
    StatusBar:        TStatusBar;
    Label8:           TLabel;
    NotebookResults:  TNotebook;
    LabelMsg:         TLabel;
    ListBoxAddresses: TListBox;
    AnimateProgress:  TAnimate;
    rightPanel: TPanel;
    chxPutInClipBrd: TCheckBox;
    chxAppendFloodCert: TCheckBox;
    lblAccuracy: TLabel;
    edtGeoResult: TEdit;
    lblZip4: TLabel;
    edtZip4: TEdit;
    lblSFHA: TLabel;
    edtSFHA: TEdit;
    edtSFHAPhrase: TEdit;
    lblPanel: TLabel;
    edtPanel: TEdit;
    lblPanelDate: TLabel;
    edtPanelDate: TEdit;
    lblZone: TLabel;
    edtZone: TEdit;
    lblCommunity: TLabel;
    edtCommunity: TEdit;
    lblName: TLabel;
    edtCommunityName: TEdit;
    lblLongitude: TLabel;
    edtLong: TEdit;
    lblcensus: TLabel;
    edtCensus: TEdit;
    lblLatitude: TLabel;
    edtLat: TEdit;
    lblFIPS: TLabel;
    edtFIPS: TEdit;
    lblMapNumber: TLabel;
    edtMapNumber: TEdit;
    leftPanel: TPanel;
    MapImage: TImage;
    procedure btnLocateClick(Sender: TObject);
    procedure chxPutInClipBrdClick(Sender: TObject);
    procedure ListBoxAddressesDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FDoc:           TContainer;
    FDestCell:      TBaseCell;
    FFloodClient:   TFloodInsightClient;
    FHasDataResult: boolean;
    FHasMapResult:  boolean;
    FHasAnimateFile: boolean;
    FRequery:       boolean;
    FRequeryString: string;
    FFloodRec: TFloodRec;
    FAWLogin, FAWPsw, FAWCustUID: String;  //variables to hold AWUserlog/password/custuid
    FUseCRM:Boolean;
    FVendorTokenKey:String;

    function BuildRespottingQueryString: string;
    procedure SetReQuery(const Value: boolean);
    procedure SplitFloodData;
    procedure SplitFloodDataCRM;
    function DisplayCRMMaps(FloodMaps:TFloodMaps):Boolean;
    procedure LoadCRMMapData(FloodMaps:TFloodMaps);
    function LoadFloodMapsInfo:TFloodMaps;

  protected
    //procedure CheckServiceExpiration;
    procedure TransferMapDataToCell(ACell: TBaseCell);
  public
    constructor CreateFlood(AOwner: TComponent; cell: TBaseCell);
    destructor Destroy; override;
    procedure ProduceFloodMap(var checkServiceAvail:Boolean);
    procedure ProduceReSpottedMap;
    function VerifyRequest: boolean;
    function GetCFDB_FloodMap: string;
    function GetCFAW_FloodMap: string;
    function GetCFDB_RespotRequest: string;
    function GetCFAW_RespotRequest: string;
//    function GetCFCRM_RespotRequest: String;
    procedure DisplayResults(ResStr: string);
    procedure DisplayCRMResults(FloodMaps:TFloodMaps);
    function TransferResults: boolean;
    procedure CopyMap2Clipboard;
    procedure TransferMap2Report;
    procedure TransferData2Report;
    procedure Transfer2FEMAFlood;
    procedure TransferMapData2Report;   //Ticket #1224
    property RequeryString: string read FRequeryString write FRequeryString;
    property RespotSubject: boolean read FRequery write SetReQuery;
    property UseCRM:Boolean read FUseCRM write FUseCRM;
  end;

procedure RequestFloodMap(doc: TContainer; cell: TBaseCell; RequeryStr: string; ReSpotting: boolean);


var
  FloodPort: TFloodPort;



implementation

uses
  Clipbrd, IdURI,
  UGlobals, UStatus, UMain, UForm, UEditor, UUtil1, UUtil2, ULicUser, UWinUtils,
  {UClientMessaging, UStatusService,} UWebConfig, UMapUtils, uBase,
  UAutoUpdate, UPgAnnotation, UStrings, UCustomerServices, uServices,uLkJSON;
  //UServiceManager;

{$R *.dfm}

const
  fidFloodMapLender     = 4223; //Ticket #1312
  fidFloodMapNonLender  = 4262;
  cidFloodMapImage      = 1158;           //cell id of all map images
//  FloodMapHeightTWIPS   = 9000;           //9000=600 pixels
  FloodMapHeightTWIPS   = 8250;           //Ticket #1264: 8250=550 pixels
  FloodMapWidthTWIPS    = 7960;           //7980=532 pixels;
  fidFloodMapLetter     = 4285;

  Flood_PIN             = 'SN-123';


{ This is the routine that calls the service }
procedure RequestFloodMap(doc: TContainer; cell: TBaseCell; RequeryStr: string; ReSpotting: boolean);
var
  Flood: TFloodPort;
begin
// - check for available units here, allow to purchase
// - UServiceManager.CheckAvailability(stFloodMaps);

  if assigned(doc) then
    doc.SaveCurCell;         //save changes

  Flood := TFloodPort.CreateFlood(Doc, Cell);    //create the flood map maker
  try
    try
      if ReSpotting then
      begin
        if Length(RequeryStr) = 0 then
        begin
          ShowAlert(atStopAlert,
            'ClickFORMS was unable to re-spot the subject. This map was created before the launch of this feature.');
          Exit;
        end;
        Flood.RequeryString := RequeryStr;
        Flood.RespotSubject := true;
      end;

      Flood.ShowModal;
    except
      ShowAlert(atWarnAlert, errOnFloodMap);
    end;
  finally
    Flood.Free;
  end;

  //let user know how many units /time is left
  //UServiceManager.CheckServiceExpiration(stFloodMaps);
end;



{ TFloodPort }

constructor TFloodPort.CreateFlood(AOwner: TComponent; cell: TBaseCell);
var
  GlobePath: string;
begin
  inherited Create(nil);
  SettingsName := CFormSettings_FloodPort;

  PageControl.ActivePage := tabAddress;

  FDoc      := TContainer(AOwner);
  FDestCell := cell;

  FHasDataResult := false;
  FHasMapResult  := false;
  FRequery       := false;

  FFloodClient          := TFloodInsightClient.Create(Self);
  FFloodClient.WantsMap := Flood_UserWantsMap;    //=1 map will be charged to user


  //prefill with report data
  if Assigned(FDoc) then
  begin
    //      edtName.Text := FDoc.GetCellTextByID(2);      //file number
    edtAddress.Text := FDoc.GetCellTextByID(46);
    edtCity.Text    := FDoc.GetCellTextByID(47);
    edtState.Text   := FDoc.GetCellTextByID(48);
    edtZip.Text     := GetZipCodePart(FDoc.GetCellTextByID(49), 1);
    edtPlus4.Text   := GetZipCodePart(FDoc.GetCellTextByID(49), 2);
  end;

  //added by vivek
  GlobePath       := IncludeTrailingPathDelimiter(appPref_DirCommon) + SpinningGlobe;
  FHasAnimateFile := FileExists(GlobePath);
  if FHasAnimateFile then
    AnimateProgress.FileName := GlobePath;
  AnimateProgress.Active    := false;
  Notebookresults.PageIndex := 1;
end;


destructor TFloodPort.Destroy;
begin
  FFloodClient.Free;

  inherited;
end;

procedure TFloodPort.SetReQuery(const Value: boolean);
begin
  FRequery := Value;
  if FRequery then
    btnLocate.Caption := 'Update'
  else
    btnLocate.Caption := 'Locate';
end;

procedure TFloodPort.btnLocateClick(Sender: TObject);
var
  checkServiceAvail:Boolean;
begin
  if FHasDataResult then
    begin
      TransferResults;
      //github # 190: CheckServiceAvailable(stFloodMaps);
    end
  else
    begin
      if FRequery then
        begin
          ProduceReSpottedMap;
          if not FUseCRMRegistration then
            CheckServiceAvailable(stFloodMaps);
        end
      else
        begin
          ProduceFloodMap(checkServiceAvail);
          if not FUseCRMRegistration then
            begin
              if checkServiceAvail then
                CheckServiceAvailable(stFloodMaps);
            end;
        end;
    end;
end;

procedure TFloodPort.LoadCRMMapData(FloodMaps:TFloodMaps);
var
  Panel: String;
begin
  if FloodMaps.FLocation = nil then exit;
   FFloodClient.SubjectStreetAddress := FloodMaps.FLocation.FStreet;
   FFloodClient.SubjectCity   := FloodMaps.FLocation.FCity;
   FFloodClient.SubjectState  := FloodMaps.FLocation.FState;
   FFloodClient.SubjectZip    := FloodMaps.FLocation.FZip;
   FFloodClient.SubjectPlus4  := FloodMaps.FLocation.FPlus4;

   FFloodClient.CensusTract   := Copy(FloodMaps.FTestResult.FCensusTract, 6, 4) + '.' +
                                 Copy(FloodMaps.FTestResult.FCensusTract, 10, 2);
   FFloodClient.Longitude     := FloodMaps.FMapInfo.FLocPtX;
   FFloodClient.Latitude      := FloodMaps.FMapInfo.FLocPtY;
   FFloodClient.CommunityID   := FloodMaps.FFeature.FCommunity;
   FFloodClient.Zone          := FloodMaps.FFeature.FZone;
   FFloodClient.Panel         := FloodMaps.FFeature.FCommunity +' '+ FloodMaps.FFeature.FPanel;
   FFloodClient.PanelDate     := FloodMaps.FFeature.FPanelDate;
   FFloodClient.FIPSCode      := FloodMaps.FFeature.FFIPS;
   FFloodClient.CommunityName := FloodMaps.FFeature.FCommunity_Name;
   FFloodClient.MapNumber     := FloodMaps.FTestResult.FMapNumber;
   FFloodClient.MapHeight := FloodMapHeightTWIPS;
   FFloodClient.MapWidth  := FloodMapWidthTWIPS;

   FFloodClient.SHFAResult := FloodMaps.FTestResult.FSFHA;
   if POS('IN', Uppercase(FFloodClient.SHFAResult)) > 0 then
      FFloodClient.SFHAPhrase  := FloodMaps.FTestResult.FFzDdPhrase
   else if POS('OUT', Uppercase(FFloodClient.SHFAResult)) > 0 then
     FFloodClient.SFHAPhrase := 'Not within 250 feet'
   else
     FFloodClient.SFHAPhrase := 'Unknown';

   FFloodClient.ZipPlus4        := FloodMaps.FLocation.FZip +'-'+FloodMaps.FLocation.FPlus4;
   FFloodClient.GeoResult       := FloodMaps.FTxtGeoResult;
   FFloodClient.SubjectImageID  := FloodMaps.FMapInfo.FImageID;
   FFloodClient.SubjectImageURL := FloodMaps.FMapInfo.FImageURL;
   FFloodClient.SubjectImageName := FloodMaps.FMapInfo.FImageName;
   FHasDataResult := True;
end;

procedure TFloodPort.ProduceFloodMap(var checkServiceAvail:Boolean);
var
  sSubmitResult: string;
  FloodMaps: TFloodMaps;
  showError:Boolean;
  Location:TLocation;
  EvalMode:Boolean;
begin
  sSubmitResult := '';
  Location := TLocation.Create;
  Location.FStreet := edtAddress.Text;
  Location.FCity   := edtCity.Text;
  Location.FState  := edtState.Text;
  Location.FZip    := edtZip.Text;
  try
    checkServiceAvail := True;  //always call check service for AWSI and CustDB but not CRM
    if VerifyRequest then
      try
        PushMouseCursor(crHourglass);   //show wait cursor
        try
          if FHasAnimateFile then
            AnimateProgress.Active := true;
          showError := False;  //keep the old logic
          EvalMode := CurrentUser.LicInfo.FLicType = ltEvaluationLic;
//          if EvalMode and FUseCRMRegistration then
//            useCRM := True
//          else
          if CurrentUser.OK2UseAWProduct(pidOnlineFloodMaps, True, False) then
            sSubmitResult := GetCFAW_FloodMap
          else if CurrentUser.OK2UseCustDBproduct(pidOnlineFloodMaps)  then
            sSubmitResult := GetCFDB_FloodMap
          else useCRM := True;

          if useCRM then
            begin
              showError := True; //turn off show error here since we already turn on error in the GetCRM_FloodMap routine.
              checkServiceAvail := False;  //turn off the check service available routine for CRM
              //if GetCRM_FloodMap(Location,CurrentUser.AWUserInfo, sSubmitResult, FloodMaps) then
              if GetCRM_PersmissionOnly(CRM_FloodMapsProdUID,CRM_FloodMapPermission_ServiceMethod,
                                        CurrentUser.AWUserInfo,False,FVendorTokenKey,False) then
                begin
                  //ShowMessage('Get CRM Permission OK');
                  sSubmitResult := GetCFAW_FloodMap
                end;
            end;

          if {ShowError and} (sSubmitResult <> 'Error') and (length(sSubmitResult) > 0) then
            DisplayResults(sSubmitResult); // both use the same display.
        finally
          if FHasAnimateFile then
            AnimateProgress.Active := false;
        end;
      except
        on E: Exception do
          ShowNotice(msgServiceNotAvaible);
          //ShowNotice(FriendlyErrorMsg(E.Message));
      end
    else
      begin
        ShowNotice('One or more of the address fields is blank or incorrect. Please enter a valid address.');
        edtAddress.SetFocus;
      end;
  finally
    Location.Free;
    PopMousecursor;
  end;
end;

function TFloodPort.LoadFloodMapsInfo:TFloodMaps;
begin
  result.FMapInfo.FImageID := FFloodRec.ImageID;
  result.FMapInfo.FImageURL := FFloodRec.ImageURL;
  result.FMapInfo.FImageName := FFloodRec.ImageName;
  result.FMapInfo.FLocPtX  := FFloodRec.LocPtX;
  result.FMapInfo.FLocPtY  := FFloodRec.LocPtY;
end;




{///////////////////////////////////////////////////////////////////////////////
this procedure respots the map when the labels are moved and the user wishes to
refetch the risk information for the new location.
///////////////////////////////////////////////////////////////////////////////}
procedure TFloodPort.ProduceReSpottedMap;
var
  sSubmitResult: string;
begin
  try
    PushMouseCursor(crHourglass);   //show wait cursor
    try
      if FHasAnimateFile then
        AnimateProgress.Active := true;

      if (Length(RequeryString) = 0) then
      begin
        ShowAlert(atStopAlert,
          'ClickFORMS was unable to requery risk information. This map was created before the launch of this feature.');
        Exit;
      end;
      useCRM := True;
      if CurrentUser.EvalMode then
        useCRM:=True
      else if CurrentUser.OK2UseAWProduct(pidOnlineFloodMaps) then
        begin
          useCRM:=False;
          sSubmitResult := GetCFAW_RespotRequest;
        end
      else if CurrentUser.OK2UseCustDBproduct(pidOnlineFloodMaps) then
        begin
          useCRM:=False;
          sSubmitResult := GetCFDB_RespotRequest;
        end;

      if useCRM then
        begin
//            sSubmitResult := GetCFCRM_RespotRequest;
          sSubmitResult := GetCFAW_RespotRequest;
        end;
      //added by vivek
      if (sSubmitResult <> 'Error') and (length(sSubmitResult) > 0) then
        DisplayResults(sSubmitResult);
    finally
      if FHasAnimateFile then
        AnimateProgress.Active := false;
      PopMouseCursor;
    end;
  except
    on E: Exception do
      FriendlyErrorMsg(E.Message);
  end;
end;

function TFloodPort.VerifyRequest: boolean;
var
  AddrLen, CityLen, StateLen, ZipLen, Plus4Len, Idx: Integer;
begin
  AddrLen := Length(Trim(edtAddress.Text));
  CityLen := Length(Trim(edtCity.Text));
  StateLen := Length(Trim(edtState.Text));
  ZipLen := Length(GetFirstNumInStr(edtZip.Text, True, Idx));
  Plus4Len := Length(GetFirstNumInStr(edtPlus4.Text, True, Idx));
  Result := (AddrLen > 0) and (CityLen > 0) and (StateLen = 2) and (ZipLen = 5) and
            ((Plus4Len = 0) or (Plus4Len = 4));
end;

//changed return type from boolean to string ... vivek
function TFloodPort.GetCFDB_FloodMap: string;
begin
  Result := '';
  case Notebookresults.PageIndex of
    0: //need to call GetCFDB_MapEx to get the map for the selected address form the list
    begin
       //we dont need to re-assign all the properties to FFloodClient
       //as this call will always be a second call and the object will
       //always have these info
      Result := FFloodClient.GetCFDB_MapEx(ListBoxAddresses.ItemIndex);
    end;
    1: //regular action as before
    begin

      FFloodClient.SubjectLabel         := 'SUBJECT';
      FFloodClient.SubjectStreetAddress := edtAddress.Text;
      FFloodClient.SubjectCity          := edtCity.Text;
      FFloodClient.SubjectState         := trim(edtState.Text); //don't want extra space
      FFloodClient.SubjectZip           := edtZip.Text;
      FFloodClient.SubjectPlus4         := edtPlus4.Text;

      FFloodClient.MapHeight := FloodMapHeightTWIPS;
      FFloodClient.MapWidth  := FloodMapWidthTWIPS;

      FFloodClient.AccountID := CurrentUser.AWUserInfo.UserCustUID;
///###PAM: we no longer use UserSerialNo
      FFloodClient.Pin       := Flood_PIN;  //CurrentUser.LicInfo.UserSerialNo;
      FFloodClient.ISAPIURL  := GetURLForFloodInsights;

      //if we could not read the CustID exit from here
      if (StrToIntDef(FFloodClient.AccountID,0) > 0) then
        Result := FFloodClient.GetCFDB_Map()
      else
        ShowAlert(atStopAlert, msgCantUseFlood);  
    end;
  end;
end;

//Insert a data array of bytes that represent an image and put it into a JPEG
procedure LoadJPEGFromByteArray(const dataArray: String; var JPGImg: TJPEGImage);
var
  msByte: TMemoryStream;
  iSize: Integer;
begin
  msByte := TMemoryStream.Create;
  try
    iSize := Length(DataArray);
    msByte.WriteBuffer(PChar(DataArray)^, iSize);
    msByte.Position:=0;

    if not assigned(JPGImg) then
      JPGImg := TJPEGImage.Create;

    JPGImg.LoadFromStream(msByte);
  finally
    msByte.Free;
  end;
end;

function TFloodPort.GetCFAW_FloodMap: string;
var
  Credentials : clsUserCredentials;
  Token,CompanyKey,OrderKey : WideString;
  MapRequest : clsFloodInsightsGetMapRequest;
  MapResponse : clsGetMap3Response;
  geoCodeResponse: clsGetGeocodeResponse;
  Acknowledgement : clsAcknowledgement;
  geoCodeRequest: clsGetGeocodeRequest;
  floodMapData: String;
  JpegImg: TJPEGImage;
  Panel, aZipPlus4, aZip : String;
  aContinue:Boolean;
begin
  Result := '';
  {Get Token,CompanyKey and OrderKey}
  if UseCRM then
    begin
      FAWLogin := CurrentUser.AWUserInfo.UserLoginEmail;
      FAWPsw   := CurrentUser.AWUserInfo.UserPassWord;
      FAWCustUID := CF_Trial_CustID; //pass the trial_custUID to get free token
      aContinue := AWSI_GetCFSecurityToken(FAWLogin, FAWPsw, FAWCustUID,Token, CompanyKey, OrderKey,true);  //true for 1004MC
    end
  else
   begin
     aContinue := AWSI_GetCFSecurityToken(FAWLogin, FAWPsw, FAWCustUID, Token, CompanyKey, OrderKey);
   end;

 if aContinue then
    try
      {User Credentials}
      Credentials := clsUserCredentials.create;
      Credentials.Username := FAWLogin;
      Credentials.Password := Token;
      Credentials.CompanyKey := CompanyKey;
      Credentials.OrderNumberKey := OrderKey;
      Credentials.Purchase := 0;

      {Request GeoCode of Address}
      geoCodeRequest := clsGetGeocodeRequest.Create;
      geoCodeRequest.StreetAddress := edtAddress.Text;
      geoCodeRequest.City := edtCity.Text;
      geoCodeRequest.State := trim(edtState.Text);
      geoCodeRequest.Zip := edtZip.Text;
      geoCodeRequest.Plus4 := edtPlus4.Text;

      try
          case Notebookresults.PageIndex of

            0: //need to call GetCFAW_MapEx to get the map for the selected address form the list
            begin
              //we dont need to re-assign all the properties to FFloodClient
              //as this call will always be a second call and the object will
              //always have these info
              Result := FFloodClient.GetCFAW_MapEx(ListBoxAddresses.ItemIndex);
            end;

            1: //regular action as before
            begin
               Result := '';
               with GetFloodInsightsServerPortType(False,GetAWURLForFloodInsightsService) do
                 begin
                   geoCodeResponse := FloodInsightsService_GetGeocode(Credentials,geoCodeRequest);
                   if geoCodeResponse.Results.Code = 0 then
                     begin
                       MapRequest := clsFloodInsightsGetMapRequest.Create;
                       MapRequest.StreetAddress := geoCodeResponse.ResponseData.CdCandidates[0].Street;
                       MapRequest.City          := geoCodeResponse.ResponseData.CdCandidates[0].City;
                       MapRequest.State         := geoCodeResponse.ResponseData.CdCandidates[0].State;
                       MapRequest.Zip           := geoCodeResponse.ResponseData.CdCandidates[0].Zip;
                       MapRequest.Plus4         := geoCodeResponse.ResponseData.CdCandidates[0].Plus4;
                       MapRequest.Latitude      := geoCodeResponse.ResponseData.CdCandidates[0].Latitude;
                       MapRequest.Longitude     := geoCodeResponse.ResponseData.CdCandidates[0].Longitude;
                       MapRequest.GeoResult     := geoCodeResponse.ResponseData.CdCandidates[0].GeoResult;
                       MapRequest.CensusBlockId := geoCodeResponse.ResponseData.CdCandidates[0].CensusBlockId;
                       MapRequest.MapHeight     := FloodMapHeightTWIPS;  //CC = 8250;
                       MapRequest.MapWidth      := FloodMapWidthTWIPS;   //CC = 5933;
                       MapRequest.LocationLabel := 'Subject';
                       //floodMapRequest.MapZoom := 1;

                       {now get map}
                       MapResponse := FloodInsightsService_GetMap3(Credentials,MapRequest);
                       if MapResponse.Results.Code = 0 then
                         begin
                             //Sucess Call;
                             if useCRM then
                               begin
                                 //showMessage('Send CRM ACK:'+FVendorTokenKey);
                                 SendAckToCRMServiceMgr(CRM_FloodMapsProdUID,CRM_FloodMapPermission_ServiceMethod,FVendorTokenKey);
                               end
                             else
                               begin
                                 try
                                   Acknowledgement := clsAcknowledgement.create;
                                   Acknowledgement.Received := 1;
                                   if Assigned(MapResponse.ResponseData) then
                                      Acknowledgement.ServiceAcknowledgement := MapResponse.ResponseData.ServiceAcknowledgement;
                                   // Send sucess Acknowledgement Back
                                   with GetFloodInsightsServerPortType(false, GetAWURLForFloodInsightsService) do
                                        FloodInsightsService_Acknowledgement(Credentials,Acknowledgement);
                                 finally
                                   Acknowledgement.Free;
                                 end;
                               end;
                         {Loaall info to FFloodClient Object}
                         Result := 'Single';
                         Panel :='';
                         //Ticket #1080
                         FFloodClient.SubjectStreetAddress := geoCodeResponse.ResponseData.CdCandidates[0].Street;
                         FFloodClient.SubjectCity   := geoCodeResponse.ResponseData.CdCandidates[0].City;
                         FFloodClient.SubjectState  := geoCodeResponse.ResponseData.CdCandidates[0].State;
                         FFloodClient.SubjectZip    := geoCodeResponse.ResponseData.CdCandidates[0].Zip;
                         FFloodClient.SubjectPlus4  := geoCodeResponse.ResponseData.CdCandidates[0].Plus4;

                         FFloodClient.CensusTract   := Copy(geoCodeResponse.ResponseData.CdCandidates[0].CensusBlockId, 6, 4) + '.' +
                                                       Copy(geoCodeResponse.ResponseData.CdCandidates[0].CensusBlockId, 10, 2);
                         FFloodClient.Longitude     := FloatToStr(geoCodeResponse.ResponseData.CdCandidates[0].Longitude);
                         FFloodClient.Latitude      := FloatToStr(geoCodeResponse.ResponseData.CdCandidates[0].Latitude);
                         FFloodClient.CommunityID   := MapResponse.ResponseData.Feature[0].Community;
                         FFloodClient.Zone          := MapResponse.ResponseData.Feature[0].Zone;
                         // FFloodClient.Panel         := MapResponse.ResponseData.Feature[0].FIPS+' '+MapResponse.ResponseData.Feature[0].Panel;
                         //wrong! has to be the same as for bradford services: communityID + panel
                         FFloodClient.Panel         := MapResponse.ResponseData.Feature[0].Community +' '+MapResponse.ResponseData.Feature[0].Panel;
                         FFloodClient.PanelDate     := MapResponse.ResponseData.Feature[0].PanelDate;
                         FFloodClient.FIPSCode      := MapResponse.ResponseData.Feature[0].FIPS;
                         FFloodClient.CommunityName := MapResponse.ResponseData.Feature[0].CommunityName;
                         //FFloodClient.MapNumber     := MapResponse.ResponseData.Feature[0].FIPS+MapResponse.ResponseData.Feature[0].Panel;
                         FFloodClient.MapNumber     := MapResponse.ResponseData.TestResult[0].MapNumber;
                         // -----------------------------------------------------------------------------
                         // I followed the same logic coded in UClientFloodInsights by Tood and Yakov.
                         // Jeferson
                         //------------------------------------------------------------------------------
                         if ((Pos('CITY OF', UpperCase(FFloodClient.CommunityName)) = 0) and
                            (Pos('TOWN OF', UpperCase(FFloodClient.CommunityName)) = 0)) then
                         begin
                           Panel := MapResponse.ResponseData.Feature[0].FIPS+'C '+MapResponse.ResponseData.Feature[0].Panel;
                           FFloodClient.Panel  := Panel;
                           //wrong! we do not have to change MapNumber for Uncorporated Are, Bradford service   does not
                           //FFloodClient.MapNumber := MapResponse.ResponseData.Feature[0].FIPS+'C'+MapResponse.ResponseData.Feature[0].Panel;
                         end;


                         //if (MapResponse.ResponseData.TestResult[0].SHFA = 'Out') or (MapResponse.ResponseData.TestResult[0].SHFA = '')  then   //in flood zone
                         //  FFloodClient.SHFAResult    := 'Out';
                         FFloodClient.SHFAResult := MapResponse.ResponseData.TestResult[0].SHFA;

                         //if MapResponse.ResponseData.TestResult[0].Nearby = 'No' then  //within 250 feet
                         //  FFloodClient.SFHAPhrase    :=  'Not within 250 feet'
                         //else
                         //  FFloodClient.SFHAPhrase    :=  'Unknown';
                         //Ticket #1485
                         if POS('IN', Uppercase(FFloodClient.SHFAResult)) > 0 then
                            FFloodClient.SFHAPhrase  := MapResponse.ResponseData.TestResult[0].FzDdPhrase
                         else if POS('OUT', Uppercase(FFloodClient.SHFAResult)) > 0 then
                           FFloodClient.SFHAPhrase := 'Not within 250 feet'
                         else
                           FFloodClient.SFHAPhrase := 'Unknown';

//NEVER use this         FFloodClient.SFHAPhrase := MapResponse.ResponseData.TestResult[0].FzDdPhrase;

                         FFloodClient.ZipPlus4      := geoCodeResponse.ResponseData.CdCandidates[0].Zip+'-'+geoCodeResponse.ResponseData.CdCandidates[0].Plus4;
                         //github #600: get rid of '-' if it's empty
                         //github #753: Flood Insights has brought back the +4 zon the zip code.
                         (*
                         if pos('-', FFloodClient.ZipPlus4) > 0 then  //we found -
                           begin
                             aZipPlus4 := FFloodClient.ZipPlus4;
                             aZip := popStr(aZipPlus4, '-');
                             if aZipPlus4 = '' then      //if nothing after the '-', then get rid of the -
                               FFloodClient.ZipPlus4 := aZip;
                           end;
                         *)
                         FFloodClient.GeoResult     := geoCodeResponse.ResponseData.CdCandidates[0].GeoResult;
                         FHasDataResult             := true;

                         FFloodClient.SubjectImageID := MapResponse.ResponseData.MapInfo[0].ImageID;
                         FFloodClient.SubjectImageURL := MapResponse.ResponseData.MapInfo[0].ImageURL;
                         //get the map image
                         if Length(MapResponse.ResponseData.MapImage) > 0 then
                           begin
                             floodMapData := Base64Decode(MapResponse.ResponseData.MapImage);
                             try
                               JPEGImg := TJPEGImage.Create;
                               try
                                 LoadJPEGFromByteArray(floodMapData,JPEGImg);
                                 JPEGImg.SaveToStream(FFloodClient.FloodMap); // save into FFloodClient
                                // FFloodClient.FinalizeFloodMap; // Ticket #1224: remove this routine for new form:4223
                               finally
                                 FHasDataResult := true;
                                 JPEGImg.Free;
                               end;
                             except
                                raise Exception.Create('There was a problem loading the map image file.');
                                FHasMapResult := false;
                              end;
                           end;
                         end;
                     end;
                 end;
            end;
          end; // The end case
      except
        on e: Exception do
          ShowAlert(atStopAlert, e.Message);
      end;
    finally
      Credentials.Free;
      MapRequest.Free;
      geoCodeRequest.Free;
    end;
end;

function TFloodPort.GetCFDB_RespotRequest: string;
begin
  Result           := '';
  FFloodClient.MapHeight := FloodMapHeightTWIPS;
  FFloodClient.MapWidth  := FloodMapWidthTWIPS;
  FFloodClient.AccountID := CurrentUser.AWUserInfo.UserCustUID;
///PAM_REG
  FFloodClient.Pin      := Flood_Pin;  //CurrentUser.LicInfo.UserSerialNo;
  FFloodClient.ISAPIURL := GetURLForFloodInsights;

  //if we could not read the CustID exit from here
  if (StrToIntDef(FFloodClient.AccountID,0) > 0) then
    Result := FFloodClient.GetCFDB_SpottedMap(RequeryString)
  else
    ShowAlert(atStopAlert,
      'You are not a registered ClickFORMS user so access to Flood Insight has been denied. If you would like to register ClickFORMS or subscribe to the Flood Insights web service please call Bradford Technologies'' sales department at 1-800-622-8727.');
end;

procedure TFloodPort.SplitFloodData;
var
  aItem,aStr: String;
begin
  aStr := RequeryString;

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtStreet=');
  FFloodRec.Street := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtCity=');
  FFloodRec.City := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtState=');
  FFloodRec.State := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtZip=');
  FFloodRec.Zip := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtPlus4=');
  FFloodRec.Plus4 := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtLon=');
  FFloodRec.Lon := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtLat=');
  FFloodRec.Lat := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtGeoResult=');
  FFloodRec.GeoResult := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtCensusBlockID=');
  FFloodRec.CensusBlockID := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtMapWidth=');
  FFloodRec.MapWidth := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtMapHeight=');
  FFloodRec.MapHeight := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtZoom=');
  FFloodRec.Zoom := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'ImageURL=');
  FFloodRec.ImageURL := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtImageID=');
  FFloodRec.ImageID := TIdURI.URLDecode(trim(aItem));

  { MapNumber it is not part of RequeryString
  aItem := popStr(aStr, '&');
  popStr(aItem,'txtMapNumber=');
  FFloodRec.MapNumber := TIdURI.URLDecode(trim(aItem));   }

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtLocPtX=');
  FFloodRec.LocPtX := TIdURI.URLDecode(trim(aItem));

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtLocPtY=');
  FFloodRec.LocPtY := TIdURI.URLDecode(trim(aItem));
end;

function RemoveUnwantedChar(Str:String):String;
begin
  if pos('+',str) > 0 then
    str := StringReplace(str,'+',' ',[rfReplaceAll]);
  if pos('\',str) > 0 then
    str := StringReplace(str,'\','',[rfReplaceAll]);
  result := str;
end;

procedure TFloodPort.SplitFloodDataCRM;
var
  aItem,aStr: String;
begin
  aStr := RequeryString;

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtStreet=');
  FFloodRec.Street := TIdURI.URLDecode(trim(aItem));
  FFloodRec.Street := RemoveUnwantedChar(FFloodRec.Street);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtCity=');
  FFloodRec.City := TIdURI.URLDecode(trim(aItem));
  FFloodRec.City := RemoveUnwantedChar(FFloodRec.City);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtState=');
  FFloodRec.State := TIdURI.URLDecode(trim(aItem));
  FFloodRec.State := RemoveUnwantedChar(FFloodRec.State);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtZip=');
  FFloodRec.Zip := TIdURI.URLDecode(trim(aItem));
  FFloodRec.Zip := RemoveUnwantedChar(FFloodRec.Zip);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtPlus4=');
  FFloodRec.Plus4 := TIdURI.URLDecode(trim(aItem));
  FFloodRec.Plus4 := RemoveUnwantedChar(FFloodRec.Plus4);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtLon=');
  FFloodRec.Lon := TIdURI.URLDecode(trim(aItem));
  FFloodRec.Lon := RemoveUnwantedChar(FFloodRec.Lon);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtLat=');
  FFloodRec.Lat := TIdURI.URLDecode(trim(aItem));
  FFloodRec.Lat := RemoveUnwantedChar(FFloodRec.Lat);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtGeoResult=');
  FFloodRec.GeoResult := TIdURI.URLDecode(trim(aItem));
  FFloodRec.GeoResult := RemoveUnwantedChar(FFloodRec.GeoResult);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtCensusBlockID=');
  FFloodRec.CensusBlockID := TIdURI.URLDecode(trim(aItem));
  FFloodRec.CensusBlockID := RemoveUnwantedChar(FFloodRec.CensusBlockID);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtMapWidth=');
  FFloodRec.MapWidth := TIdURI.URLDecode(trim(aItem));
  FFloodRec.MapWidth := RemoveUnwantedChar(FFloodRec.MapWidth);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtMapHeight=');
  FFloodRec.MapHeight := TIdURI.URLDecode(trim(aItem));
  FFloodRec.MapHeight := RemoveUnwantedChar(FFloodRec.MapHeight);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtZoom=');
  FFloodRec.Zoom := TIdURI.URLDecode(trim(aItem));
  FFloodRec.Zoom := RemoveUnwantedChar(FFloodRec.Zoom);

  aItem := popStr(aStr, '&');
  popStr(aItem,'ImageURL=');
  FFloodRec.ImageURL := TIdURI.URLDecode(trim(aItem));
  FFloodRec.ImageURL := RemoveUnwantedChar(FFloodRec.ImageURL);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtImageID=');
  FFloodRec.ImageID := TIdURI.URLDecode(trim(aItem));
  FFloodRec.ImageID := RemoveUnwantedChar(FFloodRec.ImageID);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtImageName=');
  FFloodRec.ImageName := TidURI.URLDecode(trim(aItem));
  FFloodRec.ImageName := RemoveUnwantedChar(FFloodRec.ImageName);

//  aItem := popStr(aStr, '&');
//  popStr(aItem,'txtMapNumber=');
//  FFloodRec.MapNumber := TIdURI.URLDecode(trim(aItem));

   aItem := popStr(aStr, '&');
  popStr(aItem,'txtLocPtX=');
  FFloodRec.LocPtX := TIdURI.URLDecode(trim(aItem));
  FFloodRec.LocPtX := RemoveUnwantedChar(FFloodRec.LocPtX);

  aItem := popStr(aStr, '&');
  popStr(aItem,'txtLocPtY=');
  FFloodRec.LocPtY := TIdURI.URLDecode(trim(aItem));
  FFloodRec.LocPtY := RemoveUnwantedChar(FFloodRec.LocPtY);

end;



function TFloodPort.GetCFAW_RespotRequest: string;
var
  Credentials: clsUserCredentials;
  RespottedMap: clsGetRespottedMapRequest;
  MapResponse: clsGetRespottedMapResponse;
  Token,CompanyKey,OrderKey : WideString;
  Acknowledgement: clsAcknowledgement;
//  MapRequest: clsMapRequest;
//  MapInfo: clsRmMapInfo;
  floodMapData: String;
  JpegImg: TJPEGImage;
  aContinue:Boolean;
begin
  Result := '';
  SplitFloodData;
  FFloodClient.MapNumber := FFloodRec.MapNumber;
  {Get Token,CompanyKey and OrderKey}
  if UseCRM then
    begin
      FAWLogin := CurrentUser.AWUserInfo.UserLoginEmail;
      FAWPsw   := CurrentUser.AWUserInfo.UserPassWord;
      FAWCustUID := CF_Trial_CustID; //pass the trial_custUID to get free token
      aContinue := AWSI_GetCFSecurityToken(FAWLogin, FAWPsw, FAWCustUID,Token, CompanyKey, OrderKey,true);  //true for 1004MC
    end
  else
    begin
      aContinue := AWSI_GetCFSecurityToken(FAWLogin, FAWPsw, FAWCustUID, Token, CompanyKey, OrderKey);
    end;

 if not aContinue then exit;
 try
      {User Credentials}
      Credentials := clsUserCredentials.create;
      Credentials.Username := FAWLogin;
      Credentials.Password := Token;
      Credentials.CompanyKey := CompanyKey;
      Credentials.OrderNumberKey := OrderKey;
      Credentials.Purchase := 0;

      {Request GeoCode of Address}
      RespottedMap := clsGetRespottedMapRequest.Create;
///      MapRequest   := clsMapRequest.Create;
///      MapInfo      := clsRmMapInfo.Create;

      RespottedMap.MapRequest := clsMapRequest.Create;
      RespottedMap.MapRequest.Street    := FFloodRec.Street;
      RespottedMap.MapRequest.City      := FFloodRec.City;
      RespottedMap.MapRequest.State     := FFloodRec.State;
      RespottedMap.MapRequest.Zip       := FFloodRec.Zip;
      RespottedMap.MapRequest.Plus4     := FFloodRec.Plus4;
      RespottedMap.MapRequest.Longitude := StrToFloatDef(FFloodRec.Lon,0);
      RespottedMap.MapRequest.Latitude  := StrToFloatDef(FFloodRec.Lat,0);
      RespottedMap.MapRequest.GeoResult := FFloodRec.GeoResult;
      RespottedMap.MapRequest.CensusBlockId := FFloodRec.CensusBlockID;
      RespottedMap.MapRequest.MapHeight := FloodMapHeightTWIPS;  //CC = 8250;
      RespottedMap.MapRequest.MapWidth  := FloodMapWidthTWIPS;   //CC = 5933;
      RespottedMap.MapRequest.MapZoom   := 1.5;
      RespottedMap.MapRequest.LocationLabel := 'Subject';

      RespottedMap.MapInfo := clsRmMapInfo.Create;
      RespottedMap.MapInfo.LocPtX   := StrToFloatDef(FFloodRec.LocPtX,0);
      RespottedMap.MapInfo.LocPtY   := StrToFloatDef(FFloodRec.LocPtY,0);
      RespottedMap.MapInfo.ImageID  := FFloodRec.ImageID;
      RespottedMap.MapInfo.ImageURL := FFloodRec.ImageURL;

      try
         with GetFloodInsightsServerPortType(False,GetAWURLForFloodInsightsService) do
           begin
             MapResponse := FloodInsightsService_GetRespottedMap(Credentials,RespottedMap);
             if MapResponse.Results.Code <> 0 then
               begin
                 ShowAlert(atStopAlert,MapResponse.Results.Description);
               end
             else
               begin
                 result := 'Single';

                 FFloodClient.SubjectStreetAddress := MapResponse.ResponseData.Location[0].Street;
                 FFloodClient.SubjectCity   := MapResponse.ResponseData.Location[0].City;
                 FFloodClient.SubjectState  := MapResponse.ResponseData.Location[0].State;
                 FFloodClient.SubjectZip    := MapResponse.ResponseData.Location[0].Zip;
                 FFloodClient.SubjectPlus4  := MapResponse.ResponseData.Location[0].Plus4;

                 FFloodClient.CensusTract   := Copy(MapResponse.ResponseData.Location[0].CensusBlock, 6, 4) + '.' +
                                               Copy(MapResponse.ResponseData.Location[0].CensusBlock, 10, 2);
                 FFloodClient.CommunityID   := MapResponse.ResponseData.Feature[0].Community;
                 FFloodClient.Zone          := MapResponse.ResponseData.Feature[0].Zone;
                 FFloodClient.Panel         := MapResponse.ResponseData.Feature[0].Community +' '+MapResponse.ResponseData.Feature[0].Panel;
                 FFloodClient.PanelDate     := MapResponse.ResponseData.Feature[0].PanelDate;
                 FFloodClient.FIPSCode      := MapResponse.ResponseData.Feature[0].FIPS;
                 FFloodClient.CommunityName := MapResponse.ResponseData.Feature[0].CommunityName;
                  //----------------------------------------------------------------------------------------------------
                  // This is a bit of a hack, but the panel and community numbers are concatenated in the floodmap dll, which
                  // is incorrect when the community is a county or unincorporated area.  After talking with Yakov I was afraid
                  // to change the behavior in the dll.  When the dll is corrected this can be removed.  The offending function
                  // in UFloodMap is :
                  //     procedure SpecialHackfor240_CombineCommunityAndPanel(ResultNode: IXMLNode);  Todd
                  //----------------------------------------------------------------------------------------------------
                 if ((Pos('CITY OF', UpperCase(FFloodClient.CommunityName)) = 0) and
                    (Pos('TOWN OF', UpperCase(FFloodClient.CommunityName)) = 0)) then
                 begin
                   FFloodClient.Panel := AnsiReplaceStr(FFloodClient.Panel, FFloodClient.CommunityID, FFloodClient.FIPSCode + 'C');
                 end;
//                 if (MapResponse.ResponseData.TestResult[0].SHFA = 'Out') or (MapResponse.ResponseData.TestResult[0].SHFA = '')  then   //in flood zone
//                   FFloodClient.SHFAResult    := 'Out';
                 FFloodClient.SHFAResult := MapResponse.ResponseData.TestResult[0].SHFA;
//                 if MapResponse.ResponseData.TestResult[0].Nearby = 'No' then  //within 250 feet
//                   FFloodClient.SFHAPhrase    :=  'Not within 250 feet'
//                 else
//                   FFloodClient.SFHAPhrase    :=  'Unknown';
                 FFloodClient.ZipPlus4      := MapResponse.ResponseData.Location[0].Zip+'-'+ MapResponse.ResponseData.Location[0].Plus4;
                 //FFloodClient.GeoResult     := ResponseData.TestResult[0].;

                 FHasDataResult             := true;

                 FFloodClient.SHFAResult    := MapResponse.ResponseData.TestResult[0].SHFA;
                 FFloodClient.SHFANearBy    := MapResponse.ResponseData.TestResult[0].Nearby;
                 //Ticket #1485
                 if POS('IN', Uppercase(FFloodClient.SHFAResult)) > 0 then
                    FFloodClient.SFHAPhrase  := MapResponse.ResponseData.TestResult[0].FzDdPhrase
                 else if POS('OUT', Uppercase(FFloodClient.SHFAResult)) > 0 then
                   FFloodClient.SFHAPhrase := 'Not within 250 feet'
                 else
                   FFloodClient.SFHAPhrase := 'Unknown';

                 FFloodClient.CensusTract := MapResponse.ResponseData.TestResult[0].CensusTrack;
                 FFloodClient.Longitude   := FloatToStr(MapResponse.ResponseData.MapInfo[0].LocPtX);
                 FFloodClient.Latitude    := FloatToStr(MapResponse.ResponseData.MapInfo[0].LocPtY);
                 FFloodClient.SubjectImageURL := MapResponse.ResponseData.MapInfo[0].ImageURL;
                 FFloodClient.SubjectImageID  := MapResponse.ResponseData.MapInfo[0].ImageID;
                 //FFloodClient.GeoResult   := MapResponse.ResponseData.MapInfo[0]
                 //get the map image
                 if Length(MapResponse.ResponseData.MapImage) > 0 then
                   begin
                     floodMapData := Base64Decode(MapResponse.ResponseData.MapImage);

                     try
                       JPEGImg := TJPEGImage.Create;
                       try
                         LoadJPEGFromByteArray(floodMapData,JPEGImg);
                         JPEGImg.SaveToStream(FFloodClient.FloodMap); // save into FFloodClient
                         // FFloodClient.FinalizeFloodMap; // Ticket #1224: remove this routine for new form:4223
                       finally
                         FHasDataResult := true;
                         JPEGImg.Free;
                       end;
                     except
                        raise Exception.Create('There was a problem loading the map image file.');
                        FHasMapResult := false;
                      end;
                   end;
               end;
           end;
      except
        on e: Exception do
          ShowAlert(atStopAlert, e.Message);
      end;
    finally
      Credentials.Free;
      RespottedMap.Free;
//      MapRequest.Free;
      RespottedMap.MapRequest.Free;
//      MapInfo.Free;
    end;
end;

(*
function TFloodPort.GetCFCRM_RespotRequest: string;
var
  floodMapData: String;
  JpegImg: TJPEGImage;
  RespottedRequest,RespottedResponse: TFloodMaps;
  ResponseTxt:String;
  jsResult:TlkJSONObject;
  jsResponse,jLocation,jTestResult,jFeature,jMapInfo:TlkJSONBase;
  sl:TStringList;
begin
  Result := '';

  SplitFloodDataCRM;
  FFloodClient.MapNumber := FFloodRec.MapNumber;
  RespottedRequest := TFloodMaps.Create;
  RespottedResponse := TFloodMaps.Create;
  try
    RespottedRequest.FLocation.FStreet  := FFloodRec.Street;
    RespottedRequest.FLocation.FCity    := FFloodRec.City;
    RespottedRequest.FLocation.FState   := FFloodRec.State;
    RespottedRequest.FLocation.FZip     := FFloodRec.Zip;
    RespottedRequest.FLocation.FPlus4   := FFloodRec.Plus4;
    RespottedRequest.FLocation.FCensusBlock := FFloodRec.CensusBlockID;
    RespottedRequest.FLocation.FLongitude := FFloodRec.Lon;
    RespottedRequest.FLocation.FLatitude  := FFloodRec.Lat;
    RespottedRequest.FLocation.FGeoResult := FFloodRec.GeoResult;
    RespottedRequest.FLocation.FMapHeight := FloodMapHeightTWIPS;   //CC = 8250;
    RespottedRequest.FLocation.FMapHeight := FloodMapWidthTWIPS;   //CC = 5933;
    RespottedRequest.FLocation.FMapZoom   := 1.5;
    RespottedRequest.FLocation.FMapLabel  := 'Subject';

    RespottedRequest.FMapInfo.FLocPtX   := FFloodRec.LocPtX;
    RespottedRequest.FMapInfo.FLocPtY   := FFloodRec.LocPtY;
    RespottedRequest.FMapInfo.FImageID  :=  FFloodRec.ImageID;
    RespottedRequest.FMapInfo.FImageURL :=  FFloodRec.ImageURL;

//    RespottedRequest.FMapInfo.FCenterX  := FFloodRec.Lon;
//    RespottedRequest.FMapInfo.FCenterY  := FFloodRec.Lat;



    if GetCRM_FloodMapsRespotRequest(RespottedRequest, ResponseTxt) then
      begin
sl:=TStringList.Create;
sl.text := ResponseTxt;
sl.saveToFile('c:\temp\FloodMaps-Respot_OutPut-Cur.txt');
sl.Free;
//   ResponseTxt := StringReplace(ResponseTxt,'"{\','{',[rfReplaceAll]);
//   ResponseTxt := StringReplace(ResponseTxt,'\"','"',[rfReplaceAll]);
//   ResponseTxt := StringReplace(ResponseTxt,'}"}','}}',[rfReplaceAll]);


        jsResult := TlkJSON.ParseText(ResponseTxt) as TlkJSONObject;
        if jsResult <> nil then
          begin
            jsResponse := TlkJsonObject(jsResult).Field['requestFields'];
            if jsResponse <> nil then
             begin
               jLocation := jsResponse.Field['Location'];

               jTestResult := jsResponse.Field['TestResult'];

               RespottedResponse.FTestResult.FSFHA := jTestResult.Field['SFHA'].Value;
               RespottedResponse.FTestResult.FNearby := jTestResult.Field['Nearby'].Value;
               RespottedResponse.FTestResult.FFzDdPhrase :=jTestResult.Field['FzDdPhrase'].Value;
               RespottedResponse.FTestResult.FFzDdPhrase := jTestResult.Field['CensusTract'].Value;

               jFeature := jsResponse.Field['Feature'];
               RespottedResponse.FFeature.FCommunity := jFeature.Field['Community'].Value;
               RespottedResponse.FFeature.FCommunity_Name := jFeature.Field['Community_Name'].Value;
               RespottedResponse.FFeature.FZone := jFeature.Field['Zone'].Value;
               RespottedResponse.FFeature.FPanel := jFeature.Field['Panel'].Value;
               RespottedResponse.FFeature.FPanelDate := jFeature.Field['PanelDate'].Value;
               RespottedResponse.FFeature.FFIPS := jFeature.Field['FIPS'].Value;

               jMapInfo := jsResponse.Field['MapInfo'];
               RespottedResponse.FMapInfo.FImageID := jMapInfo.Field['ImageID'].Value;
               RespottedResponse.FMapInfo.FLocPtX := jMapInfo.Field['LocPtX'].Value;
               RespottedResponse.FMapInfo.FLocPtY := jMapInfo.Field['LocPtY'].Value;
               RespottedResponse.FMapInfo.FLocPtX := jMapInfo.Field['CenterX'].Value;
               RespottedResponse.FMapInfo.FImageURL := jMapInfo.Field['ImageURL'].Value;

               RespottedResponse.FMapImage := jsResponse.Field['MapImage'].Value;
             end;

            RespottedResponse.FLocation.FStreet := RespottedRequest.FLocation.FStreet;
            RespottedResponse.FLocation.FCity := RespottedRequest.FLocation.FCity;
            RespottedResponse.FLocation.FState := RespottedRequest.FLocation.FState;
            RespottedResponse.FLocation.FZip := RespottedRequest.FLocation.FZip;
            RespottedResponse.FLocation.FPlus4 := RespottedRequest.FLocation.FPlus4;
            RespottedResponse.FLocation.FCensusBlock := RespottedRequest.FLocation.FCensusBlock;


            FFloodClient.SubjectStreetAddress := RespottedResponse.FLocation.FStreet;
            FFloodClient.SubjectCity          := RespottedResponse.FLocation.FCity;
            FFloodClient.SubjectState         := RespottedResponse.FLocation.FState;
            FFloodClient.SubjectZip           := RespottedResponse.FLocation.FZip;
            FFloodClient.SubjectPlus4         := RespottedResponse.FLocation.FPlus4;
            FFloodClient.CensusTract          := Copy(RespottedResponse.FLocation.FCensusBlock, 6, 4) + '.' +
                                                 Copy(RespottedResponse.FLocation.FCensusBlock, 10, 2);

            FFloodClient.CommunityID   := RespottedResponse.FFeature.FCommunity;
            FFloodClient.Zone          := RespottedResponse.FFeature.FZone;
            FFloodClient.Panel         := RespottedResponse.FFeature.FCommunity +' '+RespottedResponse.FFeature.FPanel;
            FFloodClient.PanelDate     := RespottedResponse.FFeature.FPanelDate;
            FFloodClient.FIPSCode      := RespottedResponse.FFeature.FFIPS;
            FFloodClient.CommunityName := RespottedResponse.FFeature.FCommunity_Name;


            if ((Pos('CITY OF', UpperCase(FFloodClient.CommunityName)) = 0) and
               (Pos('TOWN OF', UpperCase(FFloodClient.CommunityName)) = 0)) then
            begin
              FFloodClient.Panel := AnsiReplaceStr(FFloodClient.Panel, FFloodClient.CommunityID, FFloodClient.FIPSCode + 'C');
            end;
            FFloodClient.SHFAResult    := RespottedResponse.FTestResult.FSFHA;
            FFloodClient.ZipPlus4      := RespottedResponse.FLocation.FZip+'-'+ RespottedResponse.FLocation.FPlus4;
            FHasDataResult             := true;

            FFloodClient.SHFAResult    := RespottedResponse.FTestResult.FSFHA;
            FFloodClient.SHFANearBy    := RespottedResponse.FTestResult.FNearby;
            if POS('IN', Uppercase(FFloodClient.SHFAResult)) > 0 then
               FFloodClient.SFHAPhrase  := RespottedResponse.FTestResult.FFzDdPhrase
            else if POS('OUT', Uppercase(FFloodClient.SHFAResult)) > 0 then
              FFloodClient.SFHAPhrase := 'Not within 250 feet'
            else
              FFloodClient.SFHAPhrase := 'Unknown';

            FFloodClient.CensusTract := RespottedResponse.FTestResult.FCensusTract;
            FFloodClient.Longitude   := RespottedResponse.FMapInfo.FLocPtX;
            FFloodClient.Latitude    := RespottedResponse.FMapInfo.FLocPtY;
            FFloodClient.SubjectImageURL := RespottedResponse.FMapInfo.FImageURL;
            FFloodClient.SubjectImageID  := RespottedResponse.FMapInfo.FImageID;
            FFloodClient.SubjectImageName := RespottedResponse.FMapInfo.FImageName;
            result := 'Single';

             //get the map image
             if Length(RespottedResponse.FMapImage) > 0 then
               begin
                 floodMapData := Base64Decode(RespottedResponse.FMapImage);

                 try
                   JPEGImg := TJPEGImage.Create;
                   try
                     LoadJPEGFromByteArray(floodMapData,JPEGImg);
                     JPEGImg.SaveToStream(FFloodClient.FloodMap); // save into FFloodClient
                   finally
                     FHasDataResult := true;
                     JPEGImg.Free;
                   end;
                 except
                    raise Exception.Create('There was a problem loading the map image file.');
                    FHasMapResult := false;
                  end;
               end;
          end;
      end;

  finally
    RespottedRequest.Free;
    RespottedResponse.Free;
  end;



  {Get Token,CompanyKey and OrderKey}
  if AWSI_GetCFSecurityToken(FAWLogin, FAWPsw, FAWCustUID, Token, CompanyKey, OrderKey) then
    try
      {User Credentials}
      Credentials := clsUserCredentials.create;
      Credentials.Username := FAWLogin;
      Credentials.Password := Token;
      Credentials.CompanyKey := CompanyKey;
      Credentials.OrderNumberKey := OrderKey;
      Credentials.Purchase := 0;

      {Request GeoCode of Address}
      RespottedMap := clsGetRespottedMapRequest.Create;
      MapRequest   := clsMapRequest.Create;
      MapInfo      := clsRmMapInfo.Create;


      try
         with GetFloodInsightsServerPortType(False,GetAWURLForFloodInsightsService) do
           begin
             MapResponse := FloodInsightsService_GetRespottedMap(Credentials,RespottedMap);
             if MapResponse.Results.Code <> 0 then
               begin
                 ShowAlert(atStopAlert,MapResponse.Results.Description);
               end
             else
               begin
                 result := 'Single';


                  //----------------------------------------------------------------------------------------------------
                  // This is a bit of a hack, but the panel and community numbers are concatenated in the floodmap dll, which
                  // is incorrect when the community is a county or unincorporated area.  After talking with Yakov I was afraid
                  // to change the behavior in the dll.  When the dll is corrected this can be removed.  The offending function
                  // in UFloodMap is :
                  //     procedure SpecialHackfor240_CombineCommunityAndPanel(ResultNode: IXMLNode);  Todd
                  //----------------------------------------------------------------------------------------------------

           end;
      except
        on e: Exception do
          ShowAlert(atStopAlert, e.Message);
      end;
    finally
      Credentials.Free;
      RespottedMap.Free;
      MapRequest.Free;
      RespottedMap.MapRequest.Free;
      MapInfo.Free;
    end;
end;
*)



procedure TFloodPort.DisplayResults(ResStr: string);
var
  JpegImg:      TJPEGImage;
  i:            integer;
  aTemp: String;
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


    edtCensus.Text        := FFloodClient.CensusTract;        //'608551763484940';
    edtLong.Text          := FFloodClient.Longitude;          //'-121.773';
    edtLat.Text           := FFloodClient.Latitude;           //'37.225279';
    edtCommunity.Text     := FFloodClient.CommunityID;        // '060349';
    edtZone.Text          := FFloodClient.Zone;               // 'D';
    edtPanel.Text         := FFloodClient.Panel;              // '0049D';
    edtPanelDate.Text     := FFloodClient.PanelDate;          //'19820902');
    edtFIPS.Text          := FFloodClient.FIPSCode;           //'06085';
    edtCommunityName.Text := FFloodClient.CommunityName;      //'San Jose, City of';
    edtSFHA.Text          := FFloodClient.SHFAResult;         //'out';
    edtSFHAPhrase.Text    := FFloodClient.SFHAPhrase;         //'Within 250 feet';
    edtZip4.Text          := FFloodClient.ZipPlus4;           //'95139-1350';
    (* github #753: put back +4 zip code
    aTemp := edtZip4.text;
    if pos('-', aTemp) > 0 then   //github #633
      edtZip4.Text := popStr(aTemp, '-');
    *)
    edtMapNumber.Text     := FFloodClient.MapNumber;          //'06085C0049D'
    FHasDataResult        := true;

    //display the map
    try
      FFloodClient.FloodMap.Position := 0;
      JPEGImg := TJPEGImage.Create;
      JPEGImg.LoadFromStream(FFloodClient.FloodMap);    //load into jpeg handler
      MapImage.Picture.Assign(JpegImg);                 //display it
      JPEGImg.Free;
      FHasMapResult := true;
    except
      raise Exception.Create('There was a problem loading the map image file.');
      FHasMapResult := false;
    end;

    //get ready to show results & transfer
    chxPutInClipBrd.Enabled := FHasMapResult;
    btnLocate.Caption       := 'Transfer';
    PageControl.ActivePage  := TabResults;       //display the results

    //added by vivek
    Notebookresults.PageIndex := 1; //normal flood map result page
  end
  else
    if ResStr = 'Multiple' then
    begin
      ListBoxAddresses.Items.Clear;
      for i := 0 to FFloodClient.MulAddressList.Count - 1 do
        ListBoxAddresses.Items.Add(FFloodClient.MulAddressList[i]);

      FHasMapResult := false;

      //get ready to show results
      chxPutInClipBrd.Enabled := FHasMapResult;
      btnLocate.Caption       := 'Locate';
      PageControl.ActivePage  := TabResults;       //display the results

      //added by vivek
      Labelmsg.Caption := 'Your search for "' + edtAddress.Text + ',' + edtCity.Text + ', ' +
        edtState.Text + ' ' + edtZip.Text + '-' + edtPlus4.Text + '" has returned the following adresses.' +
        ' Please select the correct address from the list below and click' +
        ' "Locate" button to get the map. To cancel and start again, click "Cancel" button.';

      Notebookresults.PageIndex := 0; //multiple address list page
    end
    else
      raise Exception.Create('There were errors reading the map information');
end;

function TFloodPort.TransferResults: boolean;
begin
  Result := true;
  try
    if chxPutInClipBrd.Checked then   //user wants map in clipboard
      CopyMap2Clipboard
    else
    begin                             //user wants data in report
      if FDoc = nil then            //make sure we have a container
        FDoc := Main.NewEmptyDoc;

      TransferMap2Report;
      TransferMapData2Report;
      TransferData2Report;
      if chxAppendFloodCert.Checked then
        Transfer2FEMAFlood;
    end;
    ModalResult := mrOk;              //transfers done, we're gone
  except
    on E: Exception do
      ShowNotice(E.Message);
  end;
end;

procedure TFloodPort.TransferMapData2Report;   //Ticket #1224
var
  form: TDocForm;
  formID: Integer;
  aLatLon:String;
begin
   //Ticket #1358: For the map data, we can populate data to either Lender form or Non Lender form when form exists in the container.
   //if none of the two forms exist then use the map cell to locate the form
   form := FDoc.GetFormByOccurance(fidFloodMapLender, 0, False); //Look up Lender form
   if not assigned(form) then
     form := FDoc.GetFormByOccurance(fidFloodMapNonLender, 0, False); //Look up Non Lender form
   if not assigned(form) then  //This is almost impossible, but we still need to try to get the form based on the current cell
     begin
       if assigned(FDestCell) then
         begin
           formID := TBaseCell(FDestCell).UID.FormID;
           form := FDoc.GetFormByOccurance(formID, 0, False);
         end;
     end;
   if assigned(form) then  //Again, the cell sequence below are for Lender/Non Lender form.
     begin
       form.SetCellText(1, 14, FFloodClient.SHFAResult);
       //in case we have empty SHFANearby and the phrase says Not within 250 feet
       //if (Length (FFloodClient.SHFANearBy) = 0) and (pos('NO',UpperCase(FFloodClient.SFHAPhrase)) > 0) then
       //   FFloodClient.SHFANearBy := 'No';

       //form.SetCellText(1, 15, FFloodClient.SHFANearBy);
       form.SetCellText(1, 15, FFloodClient.SFHAPhrase);
       form.SetCellText(1, 16, FFloodClient.CommunityID);
       form.SetCellText(1, 17, FFloodClient.CommunityName);
       form.SetCellText(1, 18, FFloodClient.Zone);
       form.SetCellText(1, 19, FFloodClient.Panel);
       form.SetCellText(1, 20, FFloodClient.PanelDate);
       form.SetCellText(1, 21, FFloodClient.FIPSCode);
       form.SetCellText(1, 22, FFloodClient.CensusTract);

       //Set lat/lon to the subject
       if (GetStrValue(FFloodClient.Latitude) <> 0) or (GetStrValue(FFloodClient.Longitude) <> 0) then
         begin
           aLatLon := Format('%s;%s',[ FFloodClient.Latitude, FFloodClient.Longitude]);
           FDoc.SetCellTextByID2(9250, aLatLon,True);
         end;
     end;
end;

procedure TFloodPort.CopyMap2Clipboard;
var
  AFormat:  word;
  AData:    THandle;
  APalette: HPALETTE;   //?? is this memory or does it go away?
begin
  try
    if MapImage.Picture.Graphic <> nil then
    begin
      MapImage.Picture.SaveToClipboardFormat(AFormat, AData, APalette);
      ClipBoard.SetAsHandle(AFormat, AData);
    end;
  except
    raise Exception.Create('There was a problem copying the image to the Windows Clipboard.');
  end;
end;

procedure TFloodPort.TransferData2Report;
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
    FDoc.SetCellTextByID(108, edtMapNumber.Text);       //set the map Number
    FDoc.SetCellTextByID(1392, edtCommunityName.Text);  //set the panel Number

    //property info
    FDoc.SetCellTextByID(599, edtCensus.Text);      //set the Census Tract
    FDoc.SetCellTextByID(49, edtZip4.Text);         //set the zipcode + 4
  end;
end;

function TFloodPort.BuildRespottingQueryString: string;
var
  aImageURL, aImageID: String;
sl:TStringList;
begin
  if (StrToIntDef(FAWCustUID,0) > 0) then
    Result :=
      'txtStreet'         + '=' + URLEncode(FFloodClient.SubjectStreetAddress)  + '&' +
      'txtCity'           + '=' + URLEncode(FFloodClient.SubjectCity)           + '&' +
      'txtState'          + '=' + URLEncode(FFloodClient.SubjectState)          + '&' +
      'txtZip'            + '=' + URLEncode(FFloodClient.SubjectZip)            + '&' +
      'txtPlus4'          + '=' + URLEncode(FFloodClient.SubjectPlus4)          + '&' +
      'txtLon'            + '=' + URLEncode(FFloodClient.Longitude)             + '&' +
      'txtLat'            + '=' + URLEncode(FFloodClient.Latitude)              + '&' +
      'txtGeoResult'      + '=' + 'SPOTTED'                                     + '&' +
      'txtCensusBlockID'  + '=' + URLEncode(FFloodClient.CensusTract)           + '&' +
      'txtMapWidth'       + '=' + URLEncode(IntToStr(FFloodClient.MapWidth))    + '&' +
      'txtMapHeight'      + '=' + URLEncode(IntToStr(FFloodClient.MapHeight))   + '&' +
      'txtZoom'           + '=' + URLEncode(FFloodClient.SubjectZoom)           + '&' +
      'txtImageURL'       + '=' + URLEncode(FFloodClient.SubjectImageURL)       + '&' +
      'txtImageID'        + '=' + URLEncode(FFloodClient.SubjectImageID)
  else
   begin
      if FFloodClient.SubjectImageURL <> '' then
        aImageURL :=  FFloodClient.SubjectImageURL
      else
        aImageURL := FFloodRec.ImageURL;

      if FFloodClient.SubjectImageID <> '' then
        aImageID := FFloodClient.SubjectImageID
      else
        aImageID := FFloodRec.ImageID;


      Result :=
        'txtStreet'         + '=' + (FFloodClient.SubjectStreetAddress)  + '&' +
        'txtCity'           + '=' + (FFloodClient.SubjectCity)           + '&' +
        'txtState'          + '=' + (FFloodClient.SubjectState)          + '&' +
        'txtZip'            + '=' + (FFloodClient.SubjectZip)            + '&' +
        'txtPlus4'          + '=' + (FFloodClient.SubjectPlus4)          + '&' +
        'txtLon'            + '=' + (FFloodClient.Longitude)             + '&' +
        'txtLat'            + '=' + (FFloodClient.Latitude)              + '&' +
        'txtGeoResult'      + '=' + 'SPOTTED'                                     + '&' +
        'txtCensusBlockID'  + '=' + (FFloodClient.CensusTract)           + '&' +
        'txtMapWidth'       + '=' + (IntToStr(FFloodClient.MapWidth))    + '&' +
        'txtMapHeight'      + '=' + (IntToStr(FFloodClient.MapHeight))   + '&' +
        'txtZoom'           + '=' + (FFloodClient.SubjectZoom)           + '&' +
        'txtImageURL'       + '=' + (aImageURL)       + '&' +
        'txtImageID'        + '=' + (aImageID)        + '&' +
        'txtMapNumber'      + '=' + (FFloodClient.MapNumber);
   end;

    if FFloodClient.SubjectImageName <> '' then  //PAM: include imageName  for CRM
      begin
        Result :=
          'txtStreet'         + '=' + URLEncode(FFloodClient.SubjectStreetAddress)  + '&' +
          'txtCity'           + '=' + URLEncode(FFloodClient.SubjectCity)           + '&' +
          'txtState'          + '=' + URLEncode(FFloodClient.SubjectState)          + '&' +
          'txtZip'            + '=' + URLEncode(FFloodClient.SubjectZip)            + '&' +
          'txtPlus4'          + '=' + URLEncode(FFloodClient.SubjectPlus4)          + '&' +
          'txtLon'            + '=' + URLEncode(FFloodClient.Longitude)             + '&' +
          'txtLat'            + '=' + URLEncode(FFloodClient.Latitude)              + '&' +
          'txtGeoResult'      + '=' + 'SPOTTED'                                     + '&' +
          'txtCensusBlockID'  + '=' + URLEncode(FFloodClient.CensusTract)           + '&' +
          'txtMapWidth'       + '=' + URLEncode(IntToStr(FFloodClient.MapWidth))    + '&' +
          'txtMapHeight'      + '=' + URLEncode(IntToStr(FFloodClient.MapHeight))   + '&' +
          'txtZoom'           + '=' + URLEncode(FFloodClient.SubjectZoom)           + '&' +
          'txtImageURL'       + '=' + URLEncode(FFloodClient.SubjectImageURL)       + '&' +
          'txtImageID'        + '=' + URLEncode(FFloodClient.SubjectImageID)        + '&' +
          'txtImageName'      + '=' + URLEncode(FFloodClient.SubjectImageName);
    end;
//sl:=TStringList.Create;
//sl.text := result;
//sl.saveToFile('c:\temp\BuildRespottingQueryString.txt');
//sl.free;
end;

procedure TFloodPort.TransferMapDataToCell(ACell: TBaseCell);
const
//  MAP_HEIGHT = 600;
  MAP_HEIGHT = 550;  //Ticket #1264: since the new form the height is 6.5" while the old form the height is 6.8"
  MAP_WIDTH  = 532;
var
  GeoPt:      TGeoPoint;
  Pt:         TPoint;
  LabelName:  string;
  LabelColor: TColor;
  LabelAngle: integer;
  LabelCat:   integer;
  LabelID:    integer;
  Marker:     TPageItem;
  MapEditor:  TMapFloodEditor;
  aForm,dForm:TDocFOrm;
begin
  if assigned(ACell) then
  begin
    FDoc.MakeCurCell(ACell);                   //make sure cell is active
    FFloodClient.FloodMap.Position := 0;
    TGraphicEditor(FDoc.docEditor).LoadImageStream(FFloodClient.FloodMap);

    //now work with GeoCodes & Auto Map Labeling
    MapEditor := nil;
    if FDoc.docEditor is TMapFloodEditor then
      MapEditor := TMapFloodEditor(FDoc.docEditor);

    if Assigned(MapEditor) then
      MapEditor.ClearGeoData;       //clear previous GeoCoded maps

    if assigned(MapEditor) then
    begin
      //holds the static part of the query string in the editor and cellmetadata
      MapEditor.MapSubjMovable := true;          //tell the editor we have a movable subject
      MapEditor.MapCreatedOn   := Now();                      //remember date map created
      MapEditor.MapQueryStr    := BuildRespottingQueryString;  //remember the orig query

      //eventually we do something with GeoPt.
      GeoPt.Latitude  := StrToFloat(FFloodClient.Latitude);
      GeoPt.Longitude := StrToFloat(FFloodClient.Longitude);

      Pt := Point((MAP_WIDTH div 2), (MAP_HEIGHT div 2));
      Pt := MapEditor.GetMapLabelPlacement(Pt);

      MapEditor.MapSubjPoint := Pt;

      LabelAngle := 0;
      LabelName  := 'SUBJECT';   //name in MapTool Manager
      LabelID    := 0;
      LabelCat   := 0;
      //LabelColor := clYellow;
      //if ParseCompType(LabelName, LabelCat, LabelID) then
      LabelColor := GetMapLabelLibColor(LabelCat, LabelID);

      Marker := TGraphicCell(ACell).AddAnnotation(4, Pt.X, Pt.Y, LabelName, LabelColor, LabelAngle, LabelID, LabelCat);
      TMapPtr1(Marker).FRefID := LabelID;
      TMapPtr1(Marker).FCatID := LabelCat;
      TMapPtr1(Marker).FLatitude := GeoPt.Latitude;
      TMapPtr1(Marker).FLongitude := GeoPt.Longitude;

      MapEditor.ResetView(True,True,False,100);
      MapEditor.DisplayCurCell;
    end;
  end;
end;

procedure TFloodPort.TransferMap2Report;
var
  form:          TDocForm;
  cell:          TBaseCell;
  formID: Integer;
  formDetermination:TDocForm;
begin
  form := nil;
  if FDoc = nil then                //make sure we have a container
    FDoc := Main.NewEmptyDoc;

  if FDestCell <> nil then          //if we have destCell, load it
  begin
    TransferMapDataToCell(FDestCell);
  end
  else  //find or auto load a flood map page
    try
       form := FDoc.GetFormByOccurance(fidFloodMapLender, 0, False);
       if not assigned(form) then
         form := FDoc.GetFormByOccurance(fidFloodMapNonLender, 0, False);
       if not assigned(form) then  //This is almost impossible, but we still need to try to get the form based on the current cell
         begin
           if assigned(FDestCell) then
             begin
               formID := TBaseCell(FDestCell).UID.FormID;
               form := FDoc.GetFormByOccurance(formID, 0, False);
             end;
         end;
       if not assigned(form) then
         form := FDoc.GetFormByOccurance(fidFloodMapLetter, 0, False);
       if not assigned(form) then
         begin
           FormID := fidFloodMapLender;
           form := FDoc.GetFormByOccurance(FormID, 0, True);  //none of the flood map form exists in the container, default Lender form and create one.
         end;
       if (form <> nil) then
         begin
           cell := form.GetCellByID(cidFloodMapImage);
           if assigned(cell) then
             begin
               TransferMapDataToCell(Cell);
             end;
         end
      else
        begin
          ShowNotice('Flood Map form ID# ' + IntToStr(FormID) +
            ' was not found in the Forms Library. The map will cannot be transferred. Instead it will be put in the ClipBoard');
          CopyMap2Clipboard;
        end;
    except
      raise Exception.Create('There was a problem transfering the map to the report.');
    end;
end;

procedure TFloodPort.Transfer2FEMAFlood;
const
  FEMALenderFloodID = 4012;		//used to be 696	used to be 858
  FEMALetterFloodID = 4375;
var
  Form: TDocForm;
begin
  if FDoc = nil then                //make sure we have a container
    FDoc := Main.NewEmptyDoc;

  try
    Form := FDoc.GetFormByOccurance(fidFloodMapLetter, 0, False);
    if form <> nil then
      begin
        if chxAppendFloodCert.Checked then
          begin
            if FDoc.GetFormByOccurance(FEMALetterFloodID,0,False) = nil then
              form := FDoc.GetFormByOccurance(FEMALetterFloodID, 0, true); //True = AutoLoad,0=zero based
          end;
      end
    else
      form := FDoc.GetFormByOccurance(FEMALenderFloodID, 0, true); //True = AutoLoad,0=zero based
    if (form <> nil) then
    begin
      Form.SetCellText(1, 21, edtCommunityName.Text);      //'San Jose, City of';
      Form.SetCellText(1, 27, edtCommunity.Text);          // '060349';
      Form.SetCellText(1, 28, edtPanel.Text);              // '0049D';
      Form.SetCellText(1, 30, edtPanelDate.Text);          //'19820902');
      Form.SetCellText(1, 34, edtZone.Text);               // 'D';

      if ((POS('A', FFloodClient.Zone) > 0) or (POS('V', FFloodClient.Zone) > 0)) then
        Form.SetCellText(1, 44, 'X')
      else
        Form.SetCellText(1, 45, 'X');
(*
        Form.SetCellText(1, 2, FFloodClient.FIPSCode);           //'06085';
        Form.SetCellText(1, 2, FFloodClient.SHFAResult);         //'out';
        Form.SetCellText(1, 2, FFloodClient.SFHAPhrase);         //'Within 250 feet';
        Form.SetCellText(1, 2, FFloodClient.ZipPlus4);           //'95139-1350';
*)
    end
    else
      showNotice('FEMA Flood Map ID# ' + IntToStr(FEMALenderFloodID) + ' was not be found in the Forms Library.');
  except
    raise Exception.Create('There was a problem transfering the map to the report.');
  end;
end;

procedure TFloodPort.chxPutInClipBrdClick(Sender: TObject);
var
  EnableOk: boolean;
begin
  EnableOk := not chxPutInClipBrd.Checked;

  chxAppendFloodCert.Enabled := EnableOk;
  edtZip4.Enabled          := EnableOk;
  edtSFHA.Enabled          := EnableOk;
  edtSFHAPhrase.Enabled    := EnableOk;
  edtSFHA.Enabled          := EnableOk;
  edtSFHAPhrase.Enabled    := EnableOk;
  edtPanel.Enabled         := EnableOk;
  edtPanelDate.Enabled     := EnableOk;
  edtZone.Enabled          := EnableOk;
  edtCommunity.Enabled     := EnableOk;
  edtCommunityName.Enabled := EnableOk;
  edtLong.Enabled          := EnableOk;
  edtLat.Enabled           := EnableOk;
  edtCensus.Enabled        := EnableOk;
  edtFIPS.Enabled          := EnableOk;
end;

procedure TFloodPort.ListBoxAddressesDblClick(Sender: TObject);
begin
  btnLocateClick(Sender);
end;

 ////////////////////////////////////////////////////////////////////////////////
 // this procedure checks for the service expiration status online.
 ////////////////////////////////////////////////////////////////////////////////
{procedure TFloodPort.CheckServiceExpiration;
begin
  UServiceManager.CheckServiceExpiration(stFloodMaps);
end;         }

procedure TFloodPort.FormShow(Sender: TObject);
begin
  CurrentUser.GetUserAWLoginByLicType(pidOnlineFloodMaps, FAWLogin, FAWPsw, FAWCustUID); //base on the license type to return either the Real user or trial user
end;

function TFloodPort.DisplayCRMMaps(FloodMaps:TFloodMaps):Boolean;
var
  floodMapData: String;
  JPEGImg: TJPEGImage;
begin
  FFloodClient.SubjectImageID := FloodMaps.FMapInfo.FImageID;
  FFloodClient.SubjectImageURL := FloodMaps.FMapInfo.FImageURL;
  if length(FloodMaps.FImageB64) > 0 then
    begin
       floodMapData := Base64Decode(FloodMaps.FImageB64);
       try
         JPEGImg := TJPEGImage.Create;
         try
           LoadJPEGFromByteArray(floodMapData,JPEGImg);
           JPEGImg.SaveToStream(FFloodClient.FloodMap); // save into FFloodClient
          // FFloodClient.FinalizeFloodMap; // Ticket #1224: remove this routine for new form:4223
         finally
           FHasDataResult := true;
           JPEGImg.Free;
         end;
       except
          raise Exception.Create('There was a problem loading the map image file.');
          FHasMapResult := false;
        end;
    end;
end;

function GetGeoResultText(GeoResult:String):String;
begin
  result := '';
  GeoResult := UpperCase(GeoResult);
  if Copy(GeoResult, 0, 2) = 'S5' then
    result := 'S5 - Most Accurate Match Possible'
  else
    if Copy(GeoResult, 0, 2) = 'S4' then
      result := 'S4 - Single Close Match, Shape Point Path'
    else
      if Copy(GeoResult, 0, 2) = 'S3' then
        result := 'S3 - Single Close Match, Zip+4 Centroid'
      else
        if Copy(GeoResult, 0, 2) = 'S2' then
          result := 'S2 - Single Close Match, Zip+2 Centroid'
        else
          if Copy(GeoResult, 0, 2) = 'S1' then
            result := 'S1 - Least Accurate Match Possible';
end;

procedure TFloodPort.DisplayCRMResults(FloodMaps:TFloodMaps);
var
  JpegImg:TJPEGImage;
begin
    //display results based on server results
    edtGeoResult.Text := GetGeoResultText(FFloodClient.GeoResult);

    edtCensus.Text        := FFloodClient.CensusTract;        //'608551763484940';
    edtLong.Text          := FFloodClient.Longitude;          //'-121.773';
    edtLat.Text           := FFloodClient.Latitude;           //'37.225279';
    edtCommunity.Text     := FFloodClient.CommunityID;        // '060349';
    edtZone.Text          := FFloodClient.Zone;               // 'D';
    edtPanel.Text         := FFloodClient.Panel;              // '0049D';
    edtPanelDate.Text     := FFloodClient.PanelDate;          //'19820902');
    edtFIPS.Text          := FFloodClient.FIPSCode;           //'06085';
    edtCommunityName.Text := FFloodClient.CommunityName;      //'San Jose, City of';
    edtSFHA.Text          := FFloodClient.SHFAResult;         //'out';
    edtSFHAPhrase.Text    := FFloodClient.SFHAPhrase;         //'Within 250 feet';
    edtZip4.Text          := FFloodClient.ZipPlus4;           //'95139-1350';
    edtMapNumber.Text     := FFloodClient.MapNumber;          //'06085C0049D'
    FHasDataResult        := true;
    DisplayCRMMaps(FloodMaps);

    //display the map
    try
      FFloodClient.FloodMap.Position := 0;
      JPEGImg := TJPEGImage.Create;
      JPEGImg.LoadFromStream(FFloodClient.FloodMap);    //load into jpeg handler
      MapImage.Picture.Assign(JpegImg);                 //display it
      JPEGImg.Free;
      FHasMapResult := true;
    except
      raise Exception.Create('There was a problem loading the map image file.');
      FHasMapResult := false;
    end;
    //get ready to show results & transfer
    chxPutInClipBrd.Enabled := FHasMapResult;
    btnLocate.Caption       := 'Transfer';
    PageControl.ActivePage  := TabResults;       //display the results
    Notebookresults.PageIndex := 1; //normal flood map result page
end;


end.
