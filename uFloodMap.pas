unit uFloodMap;

interface

uses
  Windows, UContainer, Classes, Jpeg, Graphics, UCell, UAWSI_Utils,UClientFloodInsights,
  UStrings,UMapUtils, UBase, uEditor,UPgAnnotation, uGlobals;


  function LoadFloodMap(doc: TContainer; AddrInfo: AddrInfoRec; var Abort: Boolean; var sl: TStringList): Boolean;


implementation


uses
  SysUtils, UWinUtils, Controls,
  AWSI_Server_FloodInsights, UForm, UStatus, UBase64, ExtCtrls,
  UUtil1,UUtil2, ULicUser,UWebConfig, UCRMServices;

const
  FloodMapLegendJPG     = 'FloodInsightsLegend.jpg';
  fidFloodMapLender     = 4223; //Ticket #1312
  fidFloodMapNonLender  = 4262;
  cidFloodMapImage      = 1158;           //cell id of all map images
//  FloodMapHeightTWIPS   = 9000;           //9000=600 pixels
  FloodMapHeightTWIPS   = 8250;           //Ticket #1264: 8250=550 pixels
  FloodMapWidthTWIPS    = 7960;           //7980=532 pixels;
  fidFloodMapLetter     = 4285;

  Flood_PIN             = 'SN-123';

var
  FFloodClient:   TFloodInsightClient;
  FHasDataResult: boolean;
  FHasMapResult:  boolean;
//  FDoc:TContainer;
//  FDestCell:  TBaseCell;


  function GetCFAW_FloodMap(doc: TContainer; AddrInfo:AddrInfoRec; UseCRM:Boolean; var Abort: Boolean): string;  Forward;
  function GetCFDB_FloodMap(AddrInfo:AddrInfoRec): string;  Forward;





function VerifyRequest(AddrInfo:AddrInfoRec): boolean;
var
  AddrLen, CityLen, StateLen, ZipLen, Plus4Len, Idx: Integer;
begin
  AddrLen := Length(Trim(AddrInfo.StreetAddr));
  CityLen := Length(Trim(AddrInfo.City));
  StateLen := Length(Trim(AddrInfo.State));
  ZipLen := Length(GetFirstNumInStr(AddrInfo.Zip, True, Idx));
  Result := (AddrLen > 0) and (CityLen > 0) and (StateLen = 2) and (ZipLen = 5);
end;

function BuildRespottingQueryString: string;
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
    'txtImageID'        + '=' + URLEncode(FFloodClient.SubjectImageID);
end;

procedure TransferMapDataToCell(FDoc: TContainer;ACell: TBaseCell);
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



procedure TransferMap2Report(FDoc: TContainer; var form:TDocForm);
const
  fidFloodMapLender     = 4223; //Ticket #1312
  fidFloodMapNonLender  = 4262;

  cidFloodMapImage      = 1158;           //cell id of all map images
var
  specifiedForm: integer;
  cell:          TBaseCell;
begin
  if FDoc = nil then exit;               //make sure we have a container
  try
    form := FDoc.GetFormByOccurance(fidFloodMapLender, 0, True); //Look up Lender form
    if not assigned(form) then
      form := FDoc.GetFormByOccurance(fidFloodMapNonLender, 0, True); //Look up Non Lender form
    if (form <> nil) then
      begin
        cell := form.GetCellByID(cidFloodMapImage);
        if assigned(cell) then
        begin
          TransferMapDataToCell(FDoc,Cell);
        end;
      end;
    except
      raise Exception.Create('There was a problem transfering the map to the report.');
    end;
end;


procedure TransferData2Report(FDoc: TContainer;form: TDocForm;FFloodClient:TFloodInsightClient);
begin
  if assigned(FDoc) and (FFloodClient <> nil) then
  begin
    //flood hazzard info
       form.SetCellText(1, 14, FFloodClient.SHFAResult);
       form.SetCellText(1, 15, FFloodClient.SFHAPhrase);
       form.SetCellText(1, 16, FFloodClient.CommunityID);
       form.SetCellText(1, 17, FFloodClient.CommunityName);
       form.SetCellText(1, 18, FFloodClient.Zone);
       form.SetCellText(1, 19, FFloodClient.Panel);
       form.SetCellText(1, 20, FFloodClient.PanelDate);
       form.SetCellText(1, 21, FFloodClient.FIPSCode);
       form.SetCellText(1, 22, FFloodClient.CensusTract);


    if (compareText('In', FFloodClient.SHFAResult) = 0) then
      FDoc.SetCellTextByID(104, 'X')               //set the flood hazzard area
    else
      FDoc.SetCellTextByID(105, 'X');
    FDoc.SetCellTextByID(106, FFloodClient.Zone);            //set the Zone
    FDoc.SetCellTextByID(107, FFloodClient.PanelDate);       //set the Panel Date
    FDoc.SetCellTextByID(108, FFloodClient.MapNumber);       //set the map Number
    FDoc.SetCellTextByID(1392, FFloodClient.CommunityName);  //set the panel Number

    //property info
    FDoc.SetCellTextByID(599, FFloodClient.CensusTract);      //set the Census Tract
    FDoc.SetCellTextByID(49, FFloodClient.ZipPlus4);         //set the zipcode + 4
  end;
end;

procedure Transfer2FEMAFlood(FDoc:TContainer);
const
  FEMAFloodID = 4012;		//used to be 696	used to be 858
var
  Form: TDocForm;
begin
  if FDoc = nil then                //make sure we have a container
    exit;
  if FFloodClient = nil then
    exit;
  try
    form := FDoc.GetFormByOccurance(FEMAFloodID, 0, true); //True = AutoLoad,0=zero based
    if (form <> nil) then
    begin
      Form.SetCellText(1, 21, FFloodClient.CommunityName);      //'San Jose, City of';
      Form.SetCellText(1, 27, FFloodClient.CommunityID);          // '060349';
      Form.SetCellText(1, 28, FFloodClient.Panel);              // '0049D';
      Form.SetCellText(1, 30, FFloodClient.PanelDate);          //'19820902');
      Form.SetCellText(1, 34, FFloodClient.Zone);               // 'D';

      if ((POS('A', FFloodClient.Zone) > 0) or (POS('V', FFloodClient.Zone) > 0)) then
        Form.SetCellText(1, 44, 'X')
      else
        Form.SetCellText(1, 45, 'X');
    end
    else
      showNotice('FEMA Flood Map ID# ' + IntToStr(FEMAFloodID) + ' was not be found in the Forms Library.');
  except
    raise Exception.Create('There was a problem transfering the map to the report.');
  end;
end;


function LoadFloodMap(doc: TContainer; AddrInfo: AddrInfoRec; var Abort: Boolean; var sl: TStringList): Boolean;
var
  sSubmitResult, msg,FVendorTokenKey: string;
  form:TDocForm;
  useCRM:Boolean;
begin
  result := False;
  Abort  := False;
  useCRM := False;
  if VerifyRequest(AddrInfo) then
    try
      PushMouseCursor(crHourglass);   //show wait cursor

      FFloodClient          := TFloodInsightClient.Create(nil);
      FFloodClient.WantsMap := Flood_UserWantsMap;    //=1 map will be charged to user
      try
        if CurrentUser.OK2UseCustDBproduct(pidOnlineFloodMaps) then
        begin
          sSubmitResult := GetCFDB_FloodMap(AddrInfo);   //do not call custDB servvice if user does not have custID
          sl.Add(sSubmitResult);
        end
        else
        begin
          sSubmitResult := srCustDBRspNotAvailable;
          sl.Add(sSubmitResult);
        end;
        // if the CustDB response is blank or an error (not authorized, no credits, etc.) then try AppraisalWorld
        //if (sSubmitResult = srCustDBRspIsEmpty) or (sSubmitResult = srCustDBRspIsError) then
        if sSubmitResult = srCustDBRspNotAvailable  then
          if CurrentUser.OK2UseAWProduct(pidOnlineFloodMaps, True, False) then
          begin
            sSubmitResult := GetCFAW_FloodMap(doc, AddrInfo,False, Abort);
            sl.Add(sSubmitResult);
            if Abort then exit;
          end
          else
          begin
            sSubmitResult := srAWSIRspNotAvailable;
            sl.Add(sSubmitResult);
          end;

        if sSubmitResult = srAWSIRspNotAvailable then
          begin
            useCRM := True;
            if GetCRM_PersmissionOnly(CRM_FloodMapsProdUID,CRM_FloodMapPermission_ServiceMethod,
                                      CurrentUser.AWUserInfo,False,FVendorTokenKey,False) then
              begin
                //ShowMessage('Get CRM Permission OK');
                sSubmitResult := GetCFAW_FloodMap(doc, AddrInfo, useCRM, Abort);
                sl.Add(sSubmitResult);
                if Abort then exit;
              end;
          end;

        if POS('You are not a registered ClickFORMS user',sSubmitResult) > 0 then
        begin
          result := False;
          sl.Add(sSubmitResult);
          Abort := not OK2Continue(sSubmitResult + ' Continue?');
          if Abort then exit;
        end
        else if (sSubmitResult <> 'Error') and (length(sSubmitResult) > 0) then
        begin
          sl.Add('Get Flood Map successfully...');
          TransferMap2Report(Doc,form);
          sl.Add('Transfer Flood Map image to report.');
          TransferData2Report(doc,form,FFloodClient);
          sl.Add('Transfer Flood Map data to report.');
          Transfer2FEMAFlood(doc);

          result := True;
        end;
      finally
        FFloodClient.Free;
        PopMouseCursor;
      end;
    except
      on E: Exception do
        begin
          msg := msgServiceNotAvaible;
          Abort := Ok2Continue(msg+ '. Continue?');
        end;
    end
  else
    begin
      msg := 'One or more of the address fields is blank or incorrect. Please enter a valid address.';
      Abort := Ok2Continue(msg+ '. Continue?');
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





function GetCFDB_FloodMap(AddrInfo: AddrInfoRec): string;
var
  msg: String;
begin
  Result := '';
//  Result := srCustDBRspNotAvailable;
  FFloodClient.SubjectLabel         := 'SUBJECT';
  FFloodClient.SubjectStreetAddress := AddrInfo.StreetAddr;
  FFloodClient.SubjectCity          := AddrInfo.City;
  FFloodClient.SubjectState         := trim(AddrInfo.State); //don't want extra space
  FFloodClient.SubjectZip           := AddrInfo.Zip;

  FFloodClient.MapHeight := FloodMapHeightTWIPS;
  FFloodClient.MapWidth  := FloodMapWidthTWIPS;

  FFloodClient.AccountID := CurrentUser.UserCustUID;
///PAM_REG  FFloodClient.Pin       := CurrentUser.LicInfo.UserSerialNo;
  FFloodClient.Pin       := Flood_PIN;
  FFloodClient.ISAPIURL  := GetURLForFloodInsights;

  //if we could not read the CustID exit from here
///PAM
//FFloodClient.AccountID := '';
  if (StrToIntDef(FFloodClient.AccountID,0) > 0) then
    Result := FFloodClient.GetCFDB_Map()
  else
  begin
//    ShowAlert(atStopAlert, msgCantUseFlood);
    Result := msgCantUseFlood;
  end;
end;

{
function GetCFAW_FloodMap(doc: TContainer; AddrInfo:AddrInfoRec; UseCRM:Boolean; var Abort: Boolean): string;
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
  FAWLogin,FAWPsw,FAWCustUID,FVendorTokenKey:String;
begin
  Result := '';
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
      Credentials := clsUserCredentials.create;
      Credentials.Username := FAWLogin;
      Credentials.Password := Token;
      Credentials.CompanyKey := CompanyKey;
      Credentials.OrderNumberKey := OrderKey;
      Credentials.Purchase := 0;

      geoCodeRequest := clsGetGeocodeRequest.Create;
      geoCodeRequest.StreetAddress := trim(AddrInfo.StreetAddr);
      geoCodeRequest.City := trim(AddrInfo.City);
      geoCodeRequest.State := trim(AddrInfo.State);
      geoCodeRequest.Zip := trim(AddrInfo.Zip);
      geoCodeRequest.Plus4 := '';

      try
//        Result := FFloodClient.GetCFAW_MapEx(ListBoxAddresses.ItemIndex);

//            1: //regular action as before
//            begin
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
  //          end;
  //        end; // The end case
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
 }


function GetCFAW_FloodMap(doc: TContainer; AddrInfo:AddrInfoRec; useCRM:Boolean; var Abort: Boolean): string;
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
  Panel : String;
  msg: String;
  aAWLogin, aAWPsw, aAWCustUID,FVendorTokenKey: String;
  aContinue:Boolean;
  aMsg:String;
begin
  Result := '';
  Abort := False;
  aContinue := False;
  {Get Token,CompanyKey and OrderKey}
  if UseCRM then
    begin
      aAWLogin := CurrentUser.AWUserInfo.UserLoginEmail;
      aAWPsw   := CurrentUser.AWUserInfo.UserPassWord;
      aAWCustUID := CF_Trial_CustID; //pass the trial_custUID to get free token
      aContinue := AWSI_GetCFSecurityToken(aAWLogin, aAWPsw, aAWCustUID,Token, CompanyKey, OrderKey,true);  //true for 1004MC
    end
  else
   begin
     CurrentUser.GetUserAWLoginByLicType(pidOnlineLocMaps, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
     aContinue := AWSI_GetCFSecurityToken(aAWLogin, aAWPsw, aAWCustUID, Token, CompanyKey, OrderKey);
   end;


//  CurrentUser.GetUserAWLoginByLicType(pidOnlineLocMaps, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
//  if AWSI_GetCFSecurityToken(aAWLogin, aAWPsw, aAWCustUID, Token, CompanyKey, OrderKey) then
   if not aContinue then  exit;
    try
      {User Credentials}
      Credentials := clsUserCredentials.create;
      Credentials.Username := aAWLogin;

      Credentials.Password := Token;
      Credentials.CompanyKey := CompanyKey;
      Credentials.OrderNumberKey := OrderKey;
      Credentials.Purchase := 0;

      {Request GeoCode of Address}
      geoCodeRequest := clsGetGeocodeRequest.Create;
      geoCodeRequest.StreetAddress := AddrInfo.StreetAddr;
      geoCodeRequest.City := AddrInfo.City;
      geoCodeRequest.State := trim(AddrInfo.State);
      geoCodeRequest.Zip := AddrInfo.Zip;

   try
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
           MapRequest.MapHeight     := FloodMapHeightTWIPS;  //CC = 9000;
           MapRequest.MapWidth      := FloodMapWidthTWIPS;   //CC = 5933;
           MapRequest.LocationLabel := 'Subject';
           //floodMapRequest.MapZoom := 1;

           {now get map}
           MapResponse := FloodInsightsService_GetMap3(Credentials,MapRequest);
           if MapResponse.Results.Code = 0 then
             begin
               if useCRM then
                  begin
                    //showMessage('Send CRM ACK:'+FVendorTokenKey);
                    SendAckToCRMServiceMgr(CRM_FloodMapsProdUID,CRM_FloodMapPermission_ServiceMethod,FVendorTokenKey);
                  end
                else
                  begin
                     //Sucess Call;
                     Acknowledgement := clsAcknowledgement.create;
                     try
                       Acknowledgement.Received := 1;
                       if Assigned(MapResponse.ResponseData) then
                         Acknowledgement.ServiceAcknowledgement := MapResponse.ResponseData.ServiceAcknowledgement;
                       with GetFloodInsightsServerPortType(false, GetAWURLForFloodInsightsService) do
                          FloodInsightsService_Acknowledgement(Credentials,Acknowledgement);
                     finally
                       Acknowledgement.Free;
                     end;
                  end;
             {Loaall info to FFloodClient Object}
             Result := 'Single';
             Panel :='';
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


             if (MapResponse.ResponseData.TestResult[0].SHFA = 'Out') or (MapResponse.ResponseData.TestResult[0].SHFA = '')  then   //in flood zone
               FFloodClient.SHFAResult    := 'Out';
             if MapResponse.ResponseData.TestResult[0].Nearby = 'No' then  //within 250 feet
               FFloodClient.SFHAPhrase    :=  'Not within 250 feet'
             else
               FFloodClient.SFHAPhrase    :=  'Unknown';
             FFloodClient.ZipPlus4      := geoCodeResponse.ResponseData.CdCandidates[0].Zip+'-'+geoCodeResponse.ResponseData.CdCandidates[0].Plus4;
             FFloodClient.GeoResult     := geoCodeResponse.ResponseData.CdCandidates[0].GeoResult;
             FHasDataResult             := true;

             //get the map image
             if Length(MapResponse.ResponseData.MapImage) > 0 then
               begin
                 floodMapData := Base64Decode(MapResponse.ResponseData.MapImage);
                 try
                   JPEGImg := TJPEGImage.Create;
                   try
                     LoadJPEGFromByteArray(floodMapData,JPEGImg);
                     JPEGImg.SaveToStream(FFloodClient.FloodMap); // save into FFloodClient
                     FFloodClient.FinalizeFloodMap; // add legend info to flood image.
                   finally
                     FHasDataResult := true;
                     JPEGImg.Free;
                   end;
                 except
                   begin
                     msg := 'There was a problem loading the map image file.';
                     result := msg;
                     raise Exception.Create(msg);
                     FHasMapResult := false;
                     Abort := not Ok2Continue(msg+ '  Continue?');
                   end;
                 end;
               end;
           end; //mapresponse = 0
       end //georesponse = 0
       else
         Abort := not Ok2Continue(geoCodeResponse.Results.Description+'. Continue?');
     end; //with
     except
        on e: Exception do
        begin
          //ShowAlert(atStopAlert, e.Message);
          aMsg := msgServiceNotAvaible;
          result :=aMsg;
          Abort := not Ok2Continue(aMsg+ '. Continue?');
        end;
      end;
    finally
      Credentials.Free;
      MapRequest.Free;
      geoCodeRequest.Free;
    end;
end;




end.
