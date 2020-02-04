unit UPortCensusNew;
// On March 2018 after goverment web site change the server to get census block from
// http://data.fcc.gov/api/block/find?format=xml&latitude=[latitude]&longitude=[longitude]&showall=true
//to https://geo.fcc.gov/api/census/block/find?latitude=[latitude]&longitude=[longitude]&showall=true&format=xml
//AW census server https://webservices.appraisalworld.com/ws/CensusTract stops working.
//SO I put the call to goverment site directly to this unit.  YF 03/23/18

interface
uses
   UContainer, UGridMgr, UCell, UAWSI_GeoDataServer, WinHTTP_TLB, MSXML6_TLB,uLkJSON,
   ActiveX,Controls,UWebUtils, USendHelp;

const
 UScode = 'US';
 CensusCellID = 599;

procedure GetCensusTract(doc: TContainer);

implementation
uses
  SysUtils, UGlobals, UBase, ULicUser, UWebConfig, UStatus, UAMC_Globals,
  UWindowsInfo, UStrings,UCRMServices;

function GetGeoCodeByAddress(doc: TContainer; var subjLong: double; var subjLat: double): Boolean;
var
  cred: clsUserCredentials;
  addr: clsGetGeocodeRequest;
  awResp: clsGetGeocodeResponse;
  userID: String;
  cellText: String;
begin
  result := false;

  cred := clsUserCredentials.Create;
    //user name, password cannot be empty
  userID := 'ClickForms, ';
  if length(currentUser.AWUserInfo.UserAWUID) > 0 then
    userID := userID + 'awID=' + currentUser.AWUserInfo.UserAWUID
  else
    userID := userID + 'custID=' + CurrentUser.UserCustUID;
  cred.Username := userID;
  cred.Password := 'Bradford';  //can be anything, just not empty

  //street address, city, state, zip cannot be empty
  addr := clsGetGeocodeRequest.Create;
  cellText := doc.GetCellTextByID(cSubjectAddressCellID);
  if length(cellText) = 0 then
    exit
  else
    addr.StreetAddress := cellText;
  cellText := doc.GetCellTextByID(cSubjectCityCellID);
  if length(cellText) = 0 then
    exit
  else
    addr.City := cellText;
  cellText := doc.GetCellTextByID(cSubjectStateCellID);
  if length(cellText) = 0 then
    exit
  else
    addr.State := cellText;
  cellText := doc.GetCellTextByID(cSubjectZipCellID);
  if length(cellText) = 0 then
    exit
  else
    addr.Zip := cellText;
  addr.Country := UScode;    //it is USA ClickForms

  with GetGeoDataServerPortType(True, GetAWURLForGeoData) do
    begin
      try
        awResp := GeoDataService_GetGeocode(cred, addr);
      except
        exit;
      end;
      if awResp.Results.Code = 0 then
        begin
          subjLong := awResp.ResponseData.Longitude;
          subjLat := awResp.ResponseData.Latitude;
          result := true;
       end;
    end;
end;

function GetReportGeocode(doc: TContainer;var subjLong: double; var subjLat: double): Boolean;
var
  grid: TCompMgr2;
  geoCell: TBaseCell;
begin
  result := false;
  grid := TCompMgr2.Create;
    try
      grid.BuildGrid(doc, gtSales);
      if grid.Count = 0 then
        grid.BuildGrid(doc, gtListing);
      if grid.Count = 0 then
        exit;
      geoCell := grid.Comp[0].GetCellByID(cGeocodedGridCellID);
      if assigned(geoCell) and (geoCell is TGeocodedGridCell) then
        begin
          subjLong := TGeocodedGridCell(geoCell).Longitude;
          subjLat := TGeocodedGridCell(geoCell).Latitude;
          if (subjLong > 0) and (subjLat > 0) then
            result := true;
        end;
    finally
      grid.Free;
    end;
end;

//uses AW Census tract Server to get free  FCC service http://www.fcc.gov/developer/census-block-conversions-api-v1.0.1
//default response format: XML
//for FIPS format see: http://www.census.gov/geo/maps-data/data/baf_description.html
function GetPropertyFIPS(latitude, longitude: double): String;
const
  //awCensusServiceURL = 'https://webservices.appraisalworld.com/ws/CensusTract/GetCensusTract.php?longitude=%s&latitude=%s';
  govCensusURL = 'https://geo.fcc.gov/api/census/block/find?latitude=%s&longitude=%s&showall=true&format=xml';
  xPathFips = '//Response/Block/@FIPS';
  fipsLength = 15;
  censusBlockStarts = 6;
  censusBlock1Length = 4;
  censusBlock2Length = 2;
var
  errMsg: String;
  urlStr: String;
  httpRequest: IWinHTTPRequest;
  respStr: String;
  xmlCensus: IXMLDOMDocument3;
  node: IXMLDOMNode;
  fips: String;
begin
  result := '';
  errMsg := '';
  //urlStr := format(awCensusServiceURL,[FloatToStr(longitude), FloatTostr(latitude)]);
  urlStr := Format(govCensusURL,[FloatToStr(latitude), FloatTostr(longitude)]);
  //FIPS := RGet(urlStr, errMsg);
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('GET',urlStr,False);
      SetTimeouts(60000,60000,60000,60000);
      try
        send('');
      except
        on e:Exception do
          ShowAlert(atWarnAlert,e.Message);
      end;
      if status <> httpRespOK then
        ShowAlert(atWarnAlert, 'The server returned error code '+ IntToStr(status))
      else
        respStr := ResponseText;
      end;
  if length(errMSg) > 0 then
    begin
      ShowNotice('Cannot get Census Bloc Number: '#13#10 + errMsg);
      exit;
    end;
    xmlCensus := CoDomDocument60.Create;
    with xmlCensus do
    begin
      async := false;
      SetProperty('SelectionLanguage', 'XPath');
      xmlCensus.loadXML(respStr);

      if parseError.errorCode <> 0 then
        begin
          ShowNotice('There is a problem retrieving Census Tract.');
          exit;
        end;
      node := SelectSingleNode(xPathFips);
      if not Assigned(node) then
        begin
          ShowNotice('There is a problem retrieving Census Tract.');
          exit;
        end;
      fips := node.text;
    end;
   if length(FIPS) <> fipsLength then
    exit;
  result := Copy(Fips,censusBlockStarts,censusBlock1Length) + '.' + Copy(Fips,censusBlockStarts + censusBlock1Length,censusBlock2Length);
end;


procedure GetCensusTract(doc: TContainer);
var
  subjLongitude, subjLatitude: Double;
  censusTract: String;
begin
  if not GetReportGeocode(doc, subjLongitude, subjLatitude) then
    if not GetGeoCodeByAddress(doc, subjLongitude, subjLatitude) then
      begin
        ShowNotice('Cannot geocode the subject address');
        exit;
      end;
//###PAM
  censusTract := GetPropertyFIPS(subjLatitude, subjLongitude);   //call custDB service first
  if length(censusTract) = 0 then  //if nothing return, call CRM service
    censusTract := GetCRM_CensusTract(doc,CurrentUser.AWUserInfo,subjLatitude, subjLongitude,False); //mute error pop up when true
  if length(censusTract) > 0 then
    doc.SetCellTextByID(CensusCellID,censusTract);
end;

end.
