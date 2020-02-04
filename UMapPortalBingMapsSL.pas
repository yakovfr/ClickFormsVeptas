unit UMapPortalBingMapsSL;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2018 by Bradford Technologies, Inc. }

interface

// *** Dependancies **********************************************************
uses
  ActiveX,
  Classes,
  MSXML6_TLB,
  Service_Mapping_Bradford_ClickFORMS_TLB,
  Service_Mapping_Bradford_ClickFORMSEvents,
  UCell,
  UClasses,
  UCompMgr,
  UGraphics,
  UGridMgr,
  UUADUtils,
  //UMapPortalManager,
  UServer_BingAuthorization,
  UAWSI_Utils,
  UMapPortalManagerSL,
  AWSI_Server_BingMaps;

// *** Constants *************************************************************
const
  /// summary: Tool id for bing maps.
  CBingMapsMapPortal = 'Bing Maps';

// *** Type Definitions and Classes ******************************************
type
  /// summary: Attributes of an address label.
  TAddressLabel = record
    ID: WideString;
    LabelType: Integer;
    Caption: WideString;
    Address: WideString;
    City: WideString;
    AdminDistrict: WideString;
    PostalCode: WideString;
    Country: WideString;
    Information: WideString;
    Latitude: Double;
    Longitude: Double;
    Confidence: WideString;
    Image: PSafeArray;
  end;

  /// summary: Map label types.
  TLabelType = (
    ltNone,
    ltSubject,
    ltSales,
    ltListing,
    ltRental);

  /// summary: Alias for TService_Mapping_Bradford_ClickFORMSILocationMapServiceEvents.
  TLocationMapServiceEvents = TService_Mapping_Bradford_ClickFORMSILocationMapServiceEvents;

  /// summary: Map portal for bing maps.
  TBingMapsMapPortalSL = class(TMapPortalSL)
    private
      FMapEventsSink: TLocationMapServiceEvents;
      FMapService: ILocationMapService;
      // FTokenService: GeoMappingServiceSoap;
      FBingAuthorizationService: BingAuthorizationSoap;
    private
      FAWServiceInUse: Boolean;
      FCredentials : clsUserCredentials;
      bingAuthKey: String;
      //function GetCellMapState(const MapCell: TMapLocCell): String;
      function GetInformationText(const CompColumn: TCompColumn; const LabelType: TLabelType): String;
      function GetImageThumbnailAsSafeArray(const Image: TCFImage): PSafeArray;
      function GetLabelTypeText(const LabelType: TLabelType): String;
      procedure HandleOnFormClosed(Sender: TObject);
      procedure HandleOnMapCaptured(Sender: TObject; const mapState: WideString; mapImage: PSafeArray);
      procedure InitializeBingMaps(const SettingsRegistryPath: String; const ApplicationURL: String; const ApplicationID: String; const SecurityToken: String; const MapState: String; MapWidth: Integer; MapHeight: Integer);
      function IsNullAddress(const AddressLabel: TAddressLabel): Boolean;
      procedure LoadAddresses(const LabelType: TLabelType; const GridManager: TGridMgr; xmlMapState: IXMLDOMDocument2);
      procedure LoadAllAddresses;
      procedure LoadSubjectAddress(const CompColumn: TCompColumn; xmlMapState: IXMLDOMDocument2);
      function SelectMapDestination: TMapLocCell;
      procedure UpdateAddresses(const GridManager: TGridMgr);
      procedure UpdateAllAddresses;
      procedure UpdateAllProximities(mapState: WideString);
      procedure UpdateProximities(const XMLDocument: IXMLDOMDocument2; const GridManager: TGridMgr);
      procedure UpdateSubjectAddress(const CompColumn: TCompColumn);
      procedure WriteArrayToStream(const SafeArray: PSafeArray; const Dimension: Integer; const Stream: TStream);
      function WriteStreamToArray(Stream: TStream): PSafeArray;
      //function GetPropertyAddressByAddrLabel(addrLabel: String): String;
      function GetCFAWBingMapsAuthorization(subscriberID, accessID: String; var authKey: String):Boolean;
      function GetMapStateXMLObj: IXMLDOMDocument2;
    public
      procedure BeforeDestruction; override;
      constructor Create(ACell: TBaseCell; ADocument: TAppraisalReport; UseAWOrCustDBService: Boolean=False); override;
      destructor Destroy; override;
      procedure Execute; override;
  end;

function CreateCompAddressLabelID(kindOfGrid: Integer;columnNo: Integer): String;
function  isAddressChanged(newAddrLabel: TAddressLabel; mapStateXMLObj: IXMLDOMDocument2): Boolean;

implementation

// *** Dependancies *********************************************************
uses
  Windows,
  ComObj,
  Controls,
  Dialogs,
  Forms,
  Graphics,
  RIO,
  SoapHTTPClient,
  SysUtils,
  UBase,
  UCellMetaData,
  UContainer,
  UDebugTools,
  UForm,
  UForms,
  UGlobals,
  ULicUser,
  UMessages,
  UPaths,
  UStatus,
  UStrings,
  UUtil1,
  UUtil2,
  UWebConfig,
  Variants,
  UCRMServices;

// *** Constants *************************************************************

const
  //CLocationMapCellID = 1158;   //moved into UMapPortalManagerSL
  CThumbnailWidth = 300;
  subjectPropertyID = 'subject0';

// the new label ID has to replace Cell Instance ID (GUID) used before. Under some
//conditions cell Instance ID happened not be unique. In the result the user
//got the error 'column ID not unique' and the rest comps did not go to the Bing map service.
function CreateCompAddressLabelID(kindOfGrid: Integer;columnNo: Integer): String;
begin
  result := '';
  case kindOfgrid of
    gtSales: if columnNo = 0 then result := subjectPropertyID else result := 'sales' + intToStr(columnNo);
    gtRental: if columnNo = 0 then result := subjectPropertyID else result := 'rental' + intToStr(columnNo);
    gtListing: if columnNo = 0 then result := subjectPropertyID else result := 'listing' + intToStr(columnNo);
  end;
end;

function  isAddressChanged(newAddrLabel: TAddressLabel; mapStateXMLObj: IXMLDOMDocument2): Boolean;
const
  xPathStrAddr = '/SerializableMapState/Labels/SerializableLabelManagerState/FormId[text()="%s"]/following-sibling::Line1Text';
  xPathCityStateZip = '/SerializableMapState/Labels/SerializableLabelManagerState/FormId[text()="%s"]/following-sibling::Line2Text';
var
  newStrAddress, newCityStateZip, prevStrAddress, prevCityStateZip: String;
  xmlNode: IXMLDOMNode;
begin
  result := true;  //default
  if not assigned(mapStateXMLObj) then
    exit;
  newStrAddress := newAddrLabel.Address;
  xmlNode := mapStateXMLObj.selectSingleNode(Format(xPathStrAddr,[newAddrLabel.ID]));
  if not assigned(xmlNode) then    //nothing to compare with
    exit;
  prevStrAddress := xmlNode.text;
  if CompareText(newStrAddress, prevStrAddress) <> 0 then
    exit;
  newCityStateZip := newAddrLabel.City + ', ' + newAddrLabel.AdminDistrict + ' ' + newAddrLabel.PostalCode;
  xmlNode := mapStateXMLObj.selectSingleNode(Format(xPathCityStateZip,[newAddrLabel.ID]));
  if not assigned(xmlNode) then  //nothing to compare with
    exit;
  prevCityStateZip := xmlNode.text;
  if CompareText(newCityStateZip, prevCityStateZip) = 0 then
    result := false;     //address the same
end;

// *** TBingMapsPort *********************************************************

/// summary: Creates a new instance of TBingMapsMapPortal.
constructor TBingMapsMapPortalSL.Create(ACell: TBaseCell; ADocument: TAppraisalReport; UseAWOrCustDBService: Boolean=False);
const
  CTimeout = 30000;  // 30 seconds
var
  RIO: THTTPRIO;
  useCustDB:Boolean;
begin
  FMapEventsSink := TLocationMapServiceEvents.Create(nil);
  FMapService := CoLocationMapService.Create;
  FAWServiceInUse := UseAWOrCustDBService;
  // Process below only if using bradfordsoftware services
//  if not FAWServiceInUse then
    if FAWServiceInUse and CurrentUser.OK2UseCustDBproduct(pidOnlineLocMaps) then
      begin
        FBingAuthorizationService :=  GetBingAuthorizationSoap(false,GetURLForBingAuthorizationService);
        useCustDB := True;
      end;
  inherited;

  // initialize
  FMapEventsSink.Connect(FMapService);
  FMapEventsSink.OnMapCaptured := HandleOnMapCaptured;
  FMapEventsSink.OnFormClosed := HandleOnFormClosed;

  if UseAWorCustDBService and (FBingAuthorizationService <> nil) then
    begin
      RIO := (FBingAuthorizationService as IRIOAccess).RIO as THTTPRIO;
      RIO.HTTPWebNode.ReceiveTimeout := CTimeout;
      RIO.HTTPWebNode.SendTimeout := CTimeout;
      if debugMode then
        TDebugTools.Debugger.DebugSOAPService(RIO);
    end;
end;

//get the ClickFORMS BingMaps authorization from AppraisalWorld
function TBingMapsMapPortalSL.GetCFAWBingMapsAuthorization(subscriberID, accessID: String; var authKey: String):Boolean;
var
  Token,CompanyKey,OrderKey : WideString;
  aAWLogin, aAWPsw, aAWCustUID: String;
begin
  {Get Token,CompanyKey and OrderKey}
  CurrentUser.GetUserAWLoginByLicType(pidOnlineLocMaps, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
  if AWSI_GetCFSecurityToken(aAWLogin,aAWPsw, aAWCustUID, Token, CompanyKey, OrderKey) then
    try
      {User Credentials}
      FCredentials := clsUserCredentials.create;
      FCredentials.Username := aAWLogin;
      FCredentials.Password := Token;
      FCredentials.CompanyKey := CompanyKey;
      FCredentials.OrderNumberKey := OrderKey;
      FCredentials.Purchase := 0;
      FCredentials.AccessId := awsi_CFBingMapsID;
      FCredentials.SubscriberId := awsi_CFBingMapSubscriberID;

      authKey := '';
      try
        try
          with GetBingAuthorizationServerPortType(false, GetAWURLForBingAuthorizationService) do
            with BingAuthorizationServices_GetBingAuthorizationKey(FCredentials) do
              if Results.Code = 0 then
                authKey := ResponseData
              else
                ShowAlert(atWarnAlert, Results.Description);
        except
          on e: Exception do
            ShowAlert(atStopAlert, e.Message);
        end;
      finally
        result := length(authKey) > 0;    //do we have an authorization key
      end;
    finally
    end
  else
    result := False;  // cannot get an authorization
end;

/// summary: Frees memory and releases resources.
destructor TBingMapsMapPortalSL.Destroy;
begin
  // free objects
  FreeAndNil(FMapEventsSink);
  FreeAndNil(FCredentials);

  // free interfaces
  try
    //FTokenService := nil;
    FBingAuthorizationService := nil;
  except
    Pointer(FBingAuthorizationService) := nil;
  end;

  try
    FMapService := nil;
  except
    Pointer(FMapService) := nil;
  end;

  // free resources
  CoFreeUnusedLibraries;
  inherited;
end;

/// summary: Closes the portal window before destruction.
procedure TBingMapsMapPortalSL.BeforeDestruction;
begin
  if Assigned(FMapService) then
    try
      FMapService.Close;
    except
    end;

  inherited;
end;

/// summary: Gets the map state saved within the cell.  Prompts the user to
///          create a new map when the addresses in the map state no longer
///          match the addresses in their appraisal report.
{function TBingMapsMapPortalSL.GetCellMapState(const MapCell: TMapLocCell): String;
const
  CDialog_PromptNewMap = 'The original map addresses do not match the current addresses in your report.  Click OK to create a new map.';
  CXPath_Address = 'Line1Text';
  CXPath_FormID = 'FormId';
  CXPath_Labels = '/SerializableMapState/Labels/SerializableLabelManagerState';
var
  AddressNode: IXMLDOMNode;
  IDNode: IXMLDOMNode;
  Index: Integer;
  LabelNode: IXMLDOMNode;
  LabelsNodeList: IXMLDOMNodeList;
  bRedoMap: Boolean;
  XML: String;
  XMLDocument: IXMLDOMDocument2;
  propertyAddress, prevAddress: String;
  commaIndex: integer;
  guid: TGUID;
begin
  result := '';
  XML := MapCell.BingMapsData;
  if (XML <> '') then
    begin
      XMLDocument := CoDomDocument.Create;
      XMLDocument.loadXML(XML);

      bRedoMap := False;
      LabelsNodeList := XMLDocument.selectNodes(CXPath_Labels);
      for Index := 0 to LabelsNodeList.length - 1 do
        begin
          LabelNode := LabelsNodeList.item[Index];
          IDNode := LabelNode.selectSingleNode(CXPath_FormID);
          AddressNode := LabelNode.selectSingleNode(CXPath_Address);
          if Assigned(IDNode) and Assigned(AddressNode) then         //old way to define cell with GUID
            begin
              if CLSIDFromString(PWideChar(IDNode.Text),guid) = S_OK then
                begin
                  result := '';  // do not use old map state with GUID as property ID
                  exit;         //force user to update map and mapstate   }
                  {AddressCell := Document.FindCellInstance(StringToGuid(IDNode.text));
                  if Assigned(AddressCell) then
                    ShowPrompt := ShowPrompt or (AddressCell.Text <> AddressNode.text); }
        {        end
              else       //the new way to define propertyID like 'subject0', 'sales2', 'rental1' and so on
                begin
                  propertyAddress := GetPropertyAddressByAddrLabel(IDNode.text);
                  //propertyAddress is coming from address Cell on the form (cellid 46 or 925) and does not include
                  // unit No. Address from cell XML does include it. We need to put both addresses to the same format
                  //before comparison
                  prevAddress := AddressNode.text;
                  commaIndex := Pos(',', prevAddress);
                  if commaIndex > 0 then
                    prevAddress := Copy(prevAddress,1, commaIndex - 1);
                  //showPrompt := ShowPrompt or (propertyAddress <> AddressNode.text);
                  bRedoMap := bRedoMap or (CompareText(propertyAddress,prevAddress) <> 0);
                  if bRedoMap then
                    break;
                end;
            end;
        end;

        if bRedoMap then
          begin
            bRedoMap := (WhichOption12('OK', 'Cancel', CDialog_PromptNewMap) = mrYes);
            //if (WhichOption12('OK', 'Cancel', CDialog_PromptNewMap) = mrYes) then
            if bRedoMap then
              result := ''
            else
              result := XML;
            //else
            //  Abort;
          end;
    end;
  //Result := XML;
end;         }

/// summary: Gets the information text for a comp.
function TBingMapsMapPortalSL.GetInformationText(const CompColumn: TCompColumn; const LabelType: TLabelType): String;
var
  Junk: Double;
  ListPrcCellID: Integer;
begin
  case LabelType of
    ltNone:
      Result := '';

    ltSubject:
      Result := 'APN: ' + (Document as TContainer).GetCellTextByID(60);

    ltSales:
      if IsValidNumber(CompColumn.GetCellTextByID(947), Junk) then
        Result := 'Sale: $' + CompColumn.GetCellTextByID(947)
      else
        Result := 'Sale: ' + CompColumn.GetCellTextByID(947);

    ltListing:
      begin
        case CompColumn.FCX.FormID of
          683, 794, 834: ListPrcCellID := 1104;
        else
          ListPrcCellID := 947;
        end;
        if IsValidNumber(CompColumn.GetCellTextByID(ListPrcCellID), Junk) then
          Result := 'List: $' + CompColumn.GetCellTextByID(ListPrcCellID)
        else
          Result := 'List: ' + CompColumn.GetCellTextByID(ListPrcCellID);
      end;

    ltRental:
      Result := '';
  else
    Result := '';
  end;
end;

/// summary: Gets a thumbnail of an image as a safe array.
/// remarks: We are not using UUtil3.CreateThumbnail because it requires a full-sized
//           bitmap to create the thumbnail.  Not enough memory for some images.
function TBingMapsMapPortalSL.GetImageThumbnailAsSafeArray(const Image: TCFImage): PSafeArray;
var
  ImageStream: TMemoryStream;
  ImageThumbnail: TBitmap;
begin
  //Result := nil;
  ImageStream := nil;
  ImageThumbnail := nil;
  try
    ImageStream := TMemoryStream.Create;
    ImageThumbnail := Image.CreateThumbnail(CThumbnailWidth, 0);
    ImageThumbnail.SaveToStream(ImageStream);
    Result := WriteStreamToArray(ImageStream);
  finally
    FreeAndNil(ImageThumbnail);
    FreeAndNil(ImageStream);
  end;
end;

/// summary: Gets the text for a label type.
function TBingMapsMapPortalSL.GetLabelTypeText(const LabelType: TLabelType): String;
begin
  case LabelType of
    ltNone:
      Result := 'None';
    ltSubject:
      Result := 'Subject';
    ltSales:
      Result := 'Sales';
    ltListing:
      Result := 'Listing';
    ltRental:
      Result := 'Rental';
  else
    Result := '';
  end;
end;

/// summary: Handles the OnFormClosed event of the map service.
procedure TBingMapsMapPortalSL.HandleOnFormClosed(Sender: TObject);
begin
  DoClosed;  // notify map portal manager
end;

/// summary: Handles the OnMapCaptured event of the map service.
procedure TBingMapsMapPortalSL.HandleOnMapCaptured(Sender: TObject; const mapState: WideString; mapImage: PSafeArray);
var
  Cell: TMapLocCell;
  GeoData: TGeoData;
  Stream: TMemoryStream;
  Acknowledgement: clsAcknowledgement;
  aCellUID:CellUID;
  //form: TDocForm;
begin
  if Document.Locked then
    MessageDlg('ClickFORMS was unable to transfer the map to your report because the report is locked.', mtError, [mbOK], 0)
  else
    begin
      try
        Cell := SelectMapDestination;

        // transfer map image
        Stream := TMemoryStream.Create;
        try
          WriteArrayToStream(mapImage, 1, Stream);
          Stream.Seek(0, soFromBeginning);
          Cell.LoadStreamData(Stream, Stream.Size, True);
          Cell.Dispatch(DM_RELOAD_EDITOR, DMS_CELL, nil);
          Document.Invalidate;
        finally
          FreeAndNil(Stream);
        end;

        // transfer map state
        Cell.BingMapsData := mapState;

        // backwards compatability with "a la mode" software
        GeoData := TGeoData.Create;
        try
          GeoData.FGeoBounds.LeftLong := 0;
          GeoData.FGeoBounds.TopLat := 0;
          GeoData.FGeoBounds.RightLong := 0;
          GeoData.FGeoBounds.BotLat := 0;
          FreeAndNil(Cell.FMetaData);
          Cell.FMetaData := GeoData;
        except
          FreeAndNil(GeoData);
          raise;
        end;

        // clear old-style map labels
        if Assigned(Cell.FLabels) then
          Cell.FLabels.Clear;

        // transfer data to report
        UpdateAllAddresses;
        UpdateAllProximities(mapState);
        aCellUID := Cell.UID;
        // if we're using AppraisalWorld services then acknowledge so the count is decremented
        Acknowledgement := nil;
        if FAWServiceInUse then
          try
            Acknowledgement := clsAcknowledgement.Create;
            Acknowledgement.Received := 1;
            Acknowledgement.ServiceAcknowledgement := bingAuthKey;
            with GetBingAuthorizationServerPortType(false, GetAWURLForBingAuthorizationService) do
              BingAuthorizationServices_Acknowledgement(FCredentials, Acknowledgement);
          finally
            if assigned(Acknowledgement) then
              Acknowledgement.Free;
          end;
   except on E:Exception do
       ShowAlert(atWarnAlert,'The Location Map Service is temporarily unavailable. No data is transferred back. | '+E.Message);
    end;
  end;
end;

/// summary: Initializes the mapping application.
/// remarks: Handles the initialization splash screen like a modal window.
procedure TBingMapsMapPortalSL.InitializeBingMaps(const SettingsRegistryPath: String; const ApplicationURL: String; const ApplicationID: String; const SecurityToken: String; const MapState: String; MapWidth: Integer; MapHeight: Integer);
var
  ActiveWindow: HWnd;
  MainForm: TMainAdvancedForm;
  SaveCursor: TCursor;
  country: String;
begin
  CancelDrag;
  Application.ModalStarted;
  if isCanadianVersion then
    country := 'Canada'
  else
    country := 'USA';
  try
   try
    ActiveWindow := GetActiveWindow;
    MainForm := Application.MainForm as TMainAdvancedForm;
    SaveCursor := Screen.Cursor;
    Screen.Cursor := crDefault;
    try
      MainForm.NormalizeTopMosts;
      FMapService.Initialize(SettingsRegistryPath, ApplicationURL, ApplicationID, country, MapState, MapWidth, MapHeight);
    finally
      Screen.Cursor := SaveCursor;
      MainForm.RestoreTopMosts;
      if (ActiveWindow <> 0) then
        SetActiveWindow(ActiveWindow);
    end;
   except on E:Exception do
       ShowAlert(atWarnAlert,errOnLocationMap+' | '+E.Message);
   end;
  finally
    Application.ModalFinished;
  end;
end;

/// summary: Indicates whether an address label represents a null address.
function TBingMapsMapPortalSL.IsNullAddress(const AddressLabel: TAddressLabel): Boolean;
var
  IsNull: Boolean;
begin
  IsNull := (AddressLabel.Address = '');
  IsNull := IsNull and (AddressLabel.City = '');
  IsNull := IsNull and (AddressLabel.AdminDistrict = '');
  IsNull := IsNull and (AddressLabel.PostalCode = '');
  Result := IsNull;
end;

/// summary: Loads comps into the address label collection of the map service.
procedure TBingMapsMapPortalSL.LoadAddresses(const LabelType: TLabelType; const GridManager: TGridMgr; xmlMapState: IXMLDOMDocument2);
var
  AddressLabel: TAddressLabel;
  CompColumn: TCompColumn;
  GeocodedCell: TGeocodedGridCell;
  Index: Integer;
  PosCom1, PosCom2: Integer;
  Addr2: String;
begin
  for Index := 1 to GridManager.Count - 1 do
    begin
      CompColumn := GridManager.Comp[Index];
      AddressLabel.Image := nil;
      if (CompColumn.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
          GeocodedCell := CompColumn.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell
      else
          GeocodedCell := nil;
       try
          // aggregate and format label data

          Addr2 := CompColumn.GetCellTextByID(926);
          PosCom1 := Pos(',', Addr2);
          if PosCom1 > 0 then
            begin
              PosCom2 := Pos(',', Copy(Addr2, Succ(PosCom1), Length(Addr2)));
              if PosCom2 > 0 then
                Addr2 := Copy(Addr2, Succ(PosCom1), Length(Addr2));
            end;

          AddressLabel.Image := nil;
          AddressLabel.Latitude := 0;
          AddressLabel.Longitude := 0;
          //AddressLabel.ID := GuidToString(GeocodedCell.InstanceID);
          AddressLabel.ID := CreateCompAddressLabelID(GridManager.Kind,index);
          AddressLabel.LabelType := Integer(LabelType);
// Fix the issue of a form with multiple pages that includes comp1, 2, 3 in page 1 and comp 4, 5, 6 in page 2
// The location map always shows 1, 2, 3, 1, 2, 3 instead of 1, 2, 3, 4, 5, 6
// What happens is when index is 4, FCompID = -1 the GetCompNumber will return 1
//          AddressLabel.Caption := GetLabelTypeText(LabelType) + ' ' + IntToStr(CompColumn.CompNumber);
          AddressLabel.Caption := GetLabelTypeText(LabelType) + ' ' + IntToStr(index);
          AddressLabel.Address := CompColumn.GetCellTextByID(925);
          AddressLabel.City := ParseCityStateZip(Addr2, cmdGetCity);
          AddressLabel.AdminDistrict := ParseCityStateZip(Addr2, cmdGetState);
          AddressLabel.PostalCode := ParseCityStateZip(Addr2, cmdGetZip);
          AddressLabel.Country := 'United States';
          if length(trim(AddressLabel.Address)) = 0 then  //empty comp
            continue;
          //###PAM(09/19/2019): Per Jorge
          //We should always bring in lat/lon from the report.
          if not isAddressChanged(AddressLabel, xmlMapState) and assigned(GeocodedCell) then
            begin
              AddressLabel.Latitude := GeocodedCell.Latitude;
              AddressLabel.Longitude := GeocodedCell.Longitude;
            end;
          AddressLabel.Confidence := '';
          AddressLabel.Information := GetInformationText(CompColumn, LabelType);

          // get image
          if Assigned(CompColumn.Photo.Cell) and Assigned(CompColumn.Photo.Cell.FImage) then
            AddressLabel.Image := GetImageThumbnailAsSafeArray(CompColumn.Photo.Cell.FImage);

          //if not IsNullAddress(AddressLabel) then
            FMapService.AddAddressLabel(AddressLabel.ID, AddressLabel.LabelType,
              AddressLabel.Caption, AddressLabel.Address, AddressLabel.City,
              AddressLabel.AdminDistrict, AddressLabel.PostalCode, AddressLabel.Country,
              AddressLabel.Information, AddressLabel.Latitude, AddressLabel.Longitude,
              AddressLabel.Confidence, AddressLabel.Image);
        except
        end;

      if Assigned(AddressLabel.Image) then
        SafeArrayDestroy(AddressLabel.Image);
    end;
end;

/// summary: Loads all addresses into the address collection of the map service.
procedure TBingMapsMapPortalSL.LoadAllAddresses;
var
  CompColumn: TCompColumn;
  Grid: TGridMgr;
  xmlMapStateDoc: IXMLDOMDocument2;
begin
  xmlMapStateDoc := GetMapStateXMLObj;

  Grid := TGridMgr.Create(True);
  try
    // subject
    Grid.BuildGrid(Document, gtSales);
    if (Grid.Count > 0) then
      CompColumn := Grid.Comp[0]
    else
      CompColumn := nil;
    LoadSubjectAddress(CompColumn, xmlMapStateDoc);

    // sales
    Grid.BuildGrid(Document, gtSales);
    LoadAddresses(ltSales, Grid, xmlMapStateDoc);

    // listings
    Grid.BuildGrid(Document, gtListing);
    LoadAddresses(ltListing, Grid, xmlMapStateDoc);

    // rentals
    Grid.BuildGrid(Document, gtRental);
    LoadAddresses(ltRental, Grid, xmlMapStateDoc);
  finally
    FreeAndNil(Grid);
  end;
end;

/// summary: Loads the subject address into the address label collection of the map service.
procedure TBingMapsMapPortalSL.LoadSubjectAddress(const CompColumn: TCompColumn; xmlMapState: IXMLDOMDocument2);
var
  AddressCell: TBaseCell;
  AddressLabel: TAddressLabel;
  Container: TContainer;
  GeocodeCell: TGeocodedGridCell;
  Cntr: Integer;
  AddrForm: TDocForm;
  AddrFound: Boolean;
begin
  Container := Document as TContainer;
  AddressLabel.Image := nil;

  // 091411 JWyatt Changed address retrieval from the container to the form level
  //  to bypass forms where the subject address is blank, such as the UAD Subject
  //  Detail worksheet.
  if Container.FormCount > 0 then
    begin
      Cntr := -1;
      AddrFound := False;
      repeat
        Cntr := Succ(Cntr);
        AddrForm := Container.docForm[Cntr];
        AddressCell := AddrForm.GetCellByID(CSubjectAddressCellID);
        if Assigned(AddressCell) and (Trim(AddressCell.Text) <> '') then
          try
            AddrFound := True;
            // aggregate and format label data
            //AddressLabel.ID := GuidToString(AddressCell.InstanceID);
            AddressLabel.Image := nil;
            AddressLabel.Latitude := 0;
            AddressLabel.Longitude := 0;
            
            AddressLabel.ID := 'subject0';
            AddressLabel.LabelType := Integer(ltSubject);
            AddressLabel.Caption := GetLabelTypeText(ltSubject);
            AddressLabel.Address := AddrForm.GetCellTextByID(CSubjectAddressCellID);
            AddressLabel.City := AddrForm.GetCellTextByID(47);
            AddressLabel.AdminDistrict := AddrForm.GetCellTextByID(48);
            AddressLabel.PostalCode := AddrForm.GetCellTextByID(49);
            AddressLabel.Country := 'United States';
            AddressLabel.Information := '';
            //PAM(09/19/2019): Per Jorge, we should always bring in lat/lon from the report.
            //AddressLabel.Latitude := 0;
            //AddressLabel.Longitude := 0;

            AddressLabel.Confidence := '';
            if Assigned(CompColumn) then
              begin
                // get geocodes
                if not isAddressChanged(AddressLabel, xmlMapState) and (CompColumn.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
                begin
                  GeocodeCell := CompColumn.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                  AddressLabel.Latitude  := GeocodeCell.Latitude;
                  AddressLabel.Longitude := GeocodeCell.Longitude;
                end;
                // get assessor's parcel number (APN)
                AddressLabel.Information := GetInformationText(CompColumn, ltSubject);

                // get image
                if Assigned(CompColumn.Photo.Cell) and Assigned(CompColumn.Photo.Cell.FImage) then
                  AddressLabel.Image := GetImageThumbnailAsSafeArray(CompColumn.Photo.Cell.FImage);
              end;

            if not IsNullAddress(AddressLabel) then
              FMapService.AddAddressLabel(AddressLabel.ID, AddressLabel.LabelType,
                AddressLabel.Caption, AddressLabel.Address, AddressLabel.City,
                AddressLabel.AdminDistrict, AddressLabel.PostalCode, AddressLabel.Country,
                AddressLabel.Information, AddressLabel.Latitude, AddressLabel.Longitude,
                AddressLabel.Confidence, AddressLabel.Image);
          except
          end;
      until AddrFound or (Cntr = Pred(Container.FormCount));
    end;
  if Assigned(AddressLabel.Image) then
    SafeArrayDestroy(AddressLabel.Image);
end;

/// summary: Selects a destination for transfering the map.
{function TBingMapsMapPortalSL.SelectMapDestination: TMapLocCell;
var
  Cell: TMapLocCell;
  CreateForm: Boolean;
  Form,LetterForm: TDocForm;
  FormUID: TFormUID;
  UseLetterForm: Boolean;
begin
  Cell := MapCell;

  if not Assigned(Cell) then
    begin
      LetterForm := (Document as TContainer).GetFormByOccurance(cFormLetterMapUID, 0, False);
      if assigned(LetterForm) then
        begin
          Cell := LetterForm.GetCellByID(CLocationMapCellID) as TMapLocCell;
          if Cell.FImage.HasGraphic then
            begin
              CreateForm := (mrYes = WhichOption12('Add', 'Insert', msgSelectForm));
              useLetterForm := True;
            end
          else
            begin
              Result := Cell;
              exit;
            end;
        end
      else
        begin
          UseLetterForm := False;
          Form := (Document as TContainer).GetFormByOccurance(cFormLegalMapUID, 0, False);
          if Assigned(Form) then
            begin
              Cell := Form.GetCellByID(CLocationMapCellID) as TMapLocCell;
              CreateForm := (mrYes = WhichOption12('Add', 'Insert', msgSelectForm))
            end
          else
            CreateForm := True;
        end;
    end
  else
    begin
      CreateForm := (mrNo = WhichOption12('Replace', 'Add', msgMapConfirmReplace));
      LetterForm := (Document as TContainer).GetFormByOccurance(cFormLetterMapUID, 0, False);
      if assigned(LetterForm) then
        UseLetterForm := True;
    end;

  if CreateForm then
    begin
      FormUID := TFormUID.Create;
      try
        if UseLetterForm then
          FormUID.ID := cFormLetterMapUID
        else
          FormUID.ID := cFormLegalMapUID;
        FormUID.Vers := 1;
        Form := (Document as TContainer).InsertFormUID(FormUID, True, -1);
        Cell := Form.GetCellByID(CLocationMapCellID) as TMapLocCell;
      finally
        FreeAndNil(FormUID);
      end;
    end;

  Result := Cell;
end;     }

function TBingMapsMapPortalSL.SelectMapDestination: TMapLocCell;
var
  CreateForm: boolean;
  cellToReplace: TBaseCell;
  formID: integer;
  form: TDocForm;
begin
  cellToReplace := mapCell;
  CreateForm := True;
  if assigned(mapCell) then
    if mapCell.FEmptyCell then
      begin
        result := mapCell;
        exit;
      end
    else
      begin
        CreateForm := (mrNo = WhichOption12('Replace', 'Add', msgMapConfirmReplace));
        formID := mapCell.UID.FormID;
        cellToReplace := mapCell;
      end
  else
    begin
      formID := cFormLegalMapUID; //101 -default
      form := TContainer(document).GetFormByOccurance(formID,0,false);
      if assigned(form) then
        begin
          CreateForm := (mrNo = WhichOption12('Replace', 'Add', msgMapConfirmReplace));
          cellToReplace := form.GetCellByCellClass('TMapLocCell');
        end;
    end;
  if createForm then
    begin
      form := TContainer(Document).GetFormByOccurance(formID, -1, true);
      cellToReplace := form.GetCellByCellClass('TMapLocCell') as TMapLocCell;
    end;
  result := TMapLocCell(cellToReplace);

  {cell := TContainer(Document).GetCellByID(CLocationMapCellID);
  if assigned(cell) and (cell is TMapLocCell) then
    CreateForm := (mrNo = WhichOption12('Replace', 'Add', msgMapConfirmReplace))
  else
    createForm := true; //no maps in thr report; have to create
  if createForm then
    begin
      if assigned(mapCell) then
        formID := MapCell.UID.FormID  //the same form the rport already has
      else
        formID := cFormLegalMapUID; //101 -default
      form := TContainer(Document).GetFormByOccurance(formID, -1, true);
      result := form.GetCellByID(CLocationMapCellID) as TMapLocCell;
    end
  else
    if assigned(mapCell) then
      result := mapCell
    else
      result := TMapLocCell(cell);    }
  {if assigned(MapCell) then
    begin
      CreateForm := (mrNo = WhichOption12('Replace', 'Add', msgMapConfirmReplace));
      formID := MapCell.UID.FormID;  //the same form the rport already has
    end
  else
    begin
      CreateForm := true;
      formID := cFormLegalMapUID; //101 -default
    end;
  if CreateForm then
    begin
      form := TContainer(Document).GetFormByOccurance(formID, -1, true);
      cell := form.GetCellByID(CLocationMapCellID) as TMapLocCell;
    end
  else
    cell := MapCell;
  result := cell;      }
end;

/// summary: Updates all addresses with the results of the map service.
procedure TBingMapsMapPortalSL.UpdateAllAddresses;
var
  CompColumn: TCompColumn;
  Grid: TGridMgr;
begin
  Grid := TGridMgr.Create(True);
  try
    // subject
    Grid.BuildGrid(Document, gtSales);
    if (Grid.Count > 0) then
      CompColumn := Grid.Comp[0]
    else
      CompColumn := nil;
    UpdateSubjectAddress(CompColumn);

    // listings
    Grid.BuildGrid(Document, gtSales);
    UpdateAddresses(Grid);

    // listings
    Grid.BuildGrid(Document, gtListing);
    UpdateAddresses(Grid);

    // rentals
    Grid.BuildGrid(Document, gtRental);
    UpdateAddresses(Grid);
  finally
    FreeAndNil(Grid);
  end;
end;

/// summary: Updates comp addresses with the results of the map service.
procedure TBingMapsMapPortalSL.UpdateAddresses(const GridManager: TGridMgr);
var
  AddressLabel: TAddressLabel;
  CompColumn: TCompColumn;
  GeocodedCell: TGeocodedGridCell;
  HResult: Integer;
  Index: Integer;
  UnitNum, UnitSep: String;
  addressLabelID: String;
  PosCom1, PosCom2: Integer;
  Addr2: String;
begin
  for Index := 0 to GridManager.Count - 1 do
    begin
      addressLabelId := CreateCompAddressLabelID(GridManager.Kind,index);
      CompColumn := GridManager.Comp[Index];
      if (CompColumn.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
        try
          GeocodedCell := CompColumn.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
          // HResult := FMapService.GetAddressLabel(GuidToString(GeocodedCell.InstanceID),
          HResult := FMapService.GetAddressLabel((addressLabelID),
                                                  AddressLabel.LabelType, AddressLabel.Caption,
                                                  AddressLabel.Address, AddressLabel.City,
                                                  AddressLabel.AdminDistrict, AddressLabel.PostalCode,
                                                  AddressLabel.Country, AddressLabel.Information,
                                                  AddressLabel.Latitude, AddressLabel.Longitude,
                                                  AddressLabel.Confidence);

          if (HResult = Integer(True)) then
            begin
              CompColumn.SetCellTextByID(925, AddressLabel.Address);

              Addr2 := CompColumn.GetCellTextByID(926);
              UnitNum := '';
              PosCom1 := Pos(',', Addr2);
              if PosCom1 > 0 then
                begin
                  PosCom2 := Pos(',', Copy(Addr2, Succ(PosCom1), Length(Addr2)));
                  if PosCom2 > 0 then
                    UnitNum := Trim(Copy(Addr2, 1, Pred(PosCom1)));
                end;
              if UnitNum <> '' then
                UnitSep := ', '
              else
                UnitSep := '';
              CompColumn.SetCellTextByID(926, UnitNum + UnitSep + AddressLabel.City + ', ' + AddressLabel.AdminDistrict + ' ' + AddressLabel.PostalCode);

              // 061411 JWyatt If we're dealing with a UAD container we need to set
              //  the comp address GSEData so that it matches the text.
              if (CompColumn.FDoc As TContainer).UADEnabled then
                SetCompMapAddr(GeocodedCell, AddressLabel.Address, UnitNum, AddressLabel.City,
                   AddressLabel.AdminDistrict, AddressLabel.PostalCode);
              GeocodedCell.Latitude := AddressLabel.Latitude;
              GeocodedCell.Longitude := AddressLabel.Longitude;
              // Call PostProcess so latitude & longitude are propogated to context-linked cells
              GeocodedCell.PostProcess;
            end;
        except
        end;
    end;
end;

/// summary: Updates all proximities with the results of the map service.
procedure TBingMapsMapPortalSL.UpdateAllProximities(mapState: WideString);
var
  Grid: TGridMgr;
  XMLDocument: IXMLDOMDocument2;
begin
  Grid := nil;
  XMLDocument := nil;
  try
    Grid := TGridMgr.Create(True);
    XMLDocument := CoDomDocument.Create;
    XMLDocument.loadXML(mapState);

    // subject and sales
    Grid.BuildGrid(Document, gtSales);
    UpdateProximities(XMLDocument, Grid);

    // listings
    Grid.BuildGrid(Document, gtListing);
    UpdateProximities(XMLDocument, Grid);

    // rentals
    Grid.BuildGrid(Document, gtRental);
    UpdateProximities(XMLDocument, Grid);
  finally
    FreeAndNil(Grid);
  end;
end;

/// summary: Updates comp proximities with the results of the map service.
procedure TBingMapsMapPortalSL.UpdateProximities(const XMLDocument: IXMLDOMDocument2; const GridManager: TGridMgr);
const
  CXPath_FormID = 'FormId';
  CXPath_Labels = '/SerializableMapState/Labels/SerializableLabelManagerState';
  CXPath_Proximity = 'Proximity';
var
  CompColumn: TCompColumn;
  CompIndex: Integer;
//  GeocodedCell: TGeocodedGridCell;
  IDNode: IXMLDOMNode;
  //InstanceID: String;
  compID: String;
  LabelIndex: Integer;
  LabelNode: IXMLDOMNode;
  LabelsNodeList: IXMLDOMNodeList;
  ProximityNode: IXMLDOMNode;
  strProximity: string;
  proximity: double;
  delim: integer;
begin
  LabelsNodeList := XMLDocument.selectNodes(CXPath_Labels);
  for CompIndex := 0 to GridManager.Count - 1 do
    begin
      CompColumn := GridManager.Comp[CompIndex];
      if (CompColumn.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
        begin
          //GeocodedCell := CompColumn.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
          //InstanceID := GuidToString(GeocodedCell.InstanceID);
          //we do not use anymore GUID as property ID in Bing map handling
          compID := CreateCompAddressLabelID(gridManager.Kind,CompIndex);
          for LabelIndex := 0 to LabelsNodeList.length - 1 do
            begin
              LabelNode := LabelsNodeList.item[LabelIndex];
              IDNode := LabelNode.selectSingleNode(CXPath_FormID);
              ProximityNode := LabelNode.selectSingleNode(CXPath_Proximity);
              //if Assigned(IDNode) and Assigned(ProximityNode) and (IDNode.text = InstanceID) then
              //be sure proximity has 2 decimal: UAD reqirement
              if Assigned(IDNode) and Assigned(ProximityNode) and (IDNode.text = compID) then
                begin
                  strProximity := ProximityNode.text;
                  delim := Pos(' ',strProximity);
                  if delim > 0 then
                    if TryStrToFloat(trim(Copy(strProximity,1,delim - 1)),proximity) then
                      strProximity :=  FormatFloat('0.00',proximity) + Copy(strProximity,delim, length(strProximity));
                  CompColumn.SetCellTextByID(929, strProximity);
                end;
            end;
        end;
    end;
end;

/// summary: Updates the subject addresses with the results of the map service.
procedure TBingMapsMapPortalSL.UpdateSubjectAddress(const CompColumn: TCompColumn);
var
  AddressCell: TBaseCell;
  AddressLabel: TAddressLabel;
  Container: TContainer;
  GeocodedCell: TGeocodedGridCell;
  HResult: Integer;
begin
  AddressCell := (Document as TContainer).GetCellByID(CSubjectAddressCellID);
  Container := Document as TContainer;

  if Assigned(AddressCell) then
    try
      HResult := FMapService.GetAddressLabel(('subject0'),
                                             AddressLabel.LabelType, AddressLabel.Caption,
                                             AddressLabel.Address, AddressLabel.City,
                                             AddressLabel.AdminDistrict, AddressLabel.PostalCode,
                                             AddressLabel.Country, AddressLabel.Information,
                                             AddressLabel.Latitude, AddressLabel.Longitude,
                                             AddressLabel.Confidence);

      if (HResult = Integer(True)) then
        begin
          // update address
          Container.SetCellTextByID(CSubjectAddressCellID, AddressLabel.Address);
          Container.SetCellTextByID(47, AddressLabel.City);
          Container.SetCellTextByID(48, AddressLabel.AdminDistrict);
          Container.SetCellTextByID(49, AddressLabel.PostalCode);

          if Assigned(CompColumn) then
            begin
              // update geocodes
              if (CompColumn.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
              begin
                GeocodedCell := CompColumn.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
                GeocodedCell.Latitude := AddressLabel.Latitude;
                GeocodedCell.Longitude := AddressLabel.Longitude;
                // Call PostProcess so latitude & longitude are propogated to context-linked cells
                GeocodedCell.PostProcess;
              end;
            end;
        end;
    except
    end;
end;

/// summary: Writes the contents of a safe array to a stream.
procedure TBingMapsMapPortalSL.WriteArrayToStream(const SafeArray: PSafeArray; const Dimension: Integer; const Stream: TStream);
var
  ArrayData: Pointer;
  LowerBound: Integer;
  UpperBound: Integer;
  Size: Int64;
begin
  if (SafeArrayGetDim(SafeArray) >= Dimension) then
    begin
      OleCheck(SafeArrayAccessData(SafeArray, ArrayData));
      try
        OleCheck(SafeArrayGetLBound(SafeArray, Dimension, LowerBound));
        OleCheck(SafeArrayGetUBound(SafeArray, Dimension, UpperBound));
        Size := (UpperBound - LowerBound) * SafeArrayGetElemsize(SafeArray) - 1;
        Stream.Write(ArrayData^, Size);
      finally
        ArrayData := nil;
        OleCheck(SafeArrayUnaccessData(SafeArray));
      end;
    end;
end;

/// summary: Writes the contents of a stream to a safe array.
function TBingMapsMapPortalSL.WriteStreamToArray(Stream: TStream): PSafeArray;
var
  ArrayData: Pointer;
  Bounds: array[0..0] of TSafeArrayBound;
  SafeArray: PSafeArray;
  StreamData: TMemoryStream;
begin
  result := nil;
  StreamData := TMemoryStream.Create;
  try
    StreamData.LoadFromStream(Stream);
    Bounds[0].lLbound := 0;
    Bounds[0].cElements := StreamData.Size;

    SafeArray := SafeArrayCreate(VT_UI1, 1, Bounds);
    try
      OleCheck(SafeArrayAccessData(SafeArray, ArrayData));
        try
          Move(StreamData.Memory^, ArrayData^, StreamData.Size);
        finally
          ArrayData := nil;
          OleCheck(SafeArrayUnaccessData(SafeArray));
        end;
    except
      SafeArrayDestroy(SafeArray);
      raise;
    end;

    Result := SafeArray;
  finally
    FreeAndNil(StreamData);
  end;
end;

/// summary: Launches the location map ActiveX control allowing users to create location maps.
procedure TBingMapsMapPortalSL.Execute;
const
  CApplicationID = 'e3>"w@35o77)f68^LW31n';
//  CApplicationURL = 'http://www.appraisalworld.com/AW/myoffice_home/jacob_location_map/locationmap/index.htm';
  CApplicationURL = 'http://www.appraisalworld.com/AW/myoffice_home/jacob_location_map/v1/locationmap/index.htm';  //Ticket #1048
var
  //ApplicationURL: String;
  Cell: TMapLocCell;
  ImageSize: TSize;
  MapState: String;
  PreviousCursor: TCursor;
  //Token: String;
  aAWLogin, aAWPsw, aAWCustUID: String;
begin
  PreviousCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourglass;
    CurrentUser.GetUserAWLoginByLicType(pidOnlineLocMaps, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
    try
      if CurrentUser.OK2UseCustDBproduct(pidOnlineLocMaps) then   //This is calling CustDB service
        begin
          CurrentUser.GetUserAWLoginByLicType(pidOnlineLocMaps, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
          bingAuthKey := FBingAuthorizationservice.GetBingAuthorizationKey(CApplicationID, aAWCustUID) //call AWSI to get the bingmapskey
        end
      else if CurrentUser.OK2UseAWProduct(pidOnlineLocMaps, True, True)  then  //This is calling AWSI service
        begin
          CurrentUser.GetUserAWLoginByLicType(pidOnlineLocMaps, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
          if not GetCFAWBingMapsAuthorization(awsi_CFBingMapSubscriberID, awsi_CFBingMapsID, bingAuthKey) then
            Exit;
        end
      else  //this is calling CRM service
         begin
           if not GetCRM_LocationMapsAuthenticationKey(CurrentUser.AWUserInfo,bingAuthKey) then
             exit;
         end;

      //TDebugTools.WriteLine('AuthKey: ' + bingAuthKey);
      Cell := MapCell;
      mapState := ''; //do not need pass mapState to DLL. ClF uses mapState to check if addresses changed
      if Assigned(Cell) then
        begin
          ImageSize := Cell.CalculateImageSizeFromCellFrame(Cell.FFrame);
  //        MapState := cell.BingMapsData;// GetCellMapState(Cell);
        end
      else
        begin
          ImageSize.cx := 720;    // default map cell size for legal forms
          ImageSize.cy := 1102;
 //         MapState := '';
        end;

      // initialize map service
        InitializeBingMaps(TRegPaths.LocationMaps, CApplicationURL, bingAuthKey, '', Mapstate, ImageSize.cx, ImageSize.cy);
        LoadAllAddresses;

      // show modeless
      FMapService.Show;
    except on E:Exception do
      ShowAlert(atWarnAlert,errOnLocationMap+' | '+E.Message);
    end;
  finally
    Screen.Cursor := PreviousCursor;
  end;
end;

//reverse the  CreateCompAddressLabelID
{function TBingMapsMapPortalSL.GetPropertyAddressByAddrLabel(addrLabel: String): String;
const
  strSubject = 'subject';
  strSales = 'sales';
  strRental = 'rental';
  strListing = 'listing';
var
  colNum: Integer;
  doc: TContainer;
  lbl: String;
  Grid: TGridMgr;
  CompColumn: TCompColumn;
begin
  result := '';
  lbl := trim(addrLabel);
  doc := Document as TContainer;
  //subject
  if Pos(strSubject,lbl) = 1 then
    result := doc.GetCellTextByID(cSubjectAddressCellID);
  //sales
  Grid := TGridMgr.Create(True);
  try
    if Pos(strSales,lbl) = 1 then
      begin
        colNum := StrtoIntDef(Copy(lbl, length(strSales) + 1, length(lbl) - length(strsales)),0);
        if (colNum > 0) then
          begin
            Grid.BuildGrid(doc, gtSales);
            // 120811 JWyatt Make sure the column is still valid so exceptions are not posted
            if (colNum <= Pred(Grid.Count)) then
              begin
                CompColumn := Grid.Comp[colNum];
                result := CompColumn.GetCellTextByID(925);
              end;
          end;
      end;
    //rental
    if Pos(strRental,lbl) = 1 then
      begin
        colNum := StrtoIntDef(Copy(lbl, length(strrental) + 1, length(lbl) - length(strRental)),0);
        if colNum > 0 then
          begin
            Grid.BuildGrid(doc, gtrental);
            // 120811 JWyatt Make sure the column is still valid so exceptions are not posted
            if (colNum <= Pred(Grid.Count)) then
              begin
                CompColumn := Grid.Comp[colNum];
                result := CompColumn.GetCellTextByID(925);
              end;
          end;
      end;
    //listing
    if Pos(strListing,lbl) = 1 then
      begin
        colNum := StrtoIntDef(Copy(lbl, length(strListing) + 1, length(lbl) - length(strListing)),0);
        if colNum > 0 then
          begin
            Grid.BuildGrid(doc, gtListing);
            // 120811 JWyatt Make sure the column is still valid so exceptions are not posted
            if (colNum <= Pred(Grid.Count)) then
              begin
                CompColumn := Grid.Comp[colNum];
                result := CompColumn.GetCellTextByID(925);
              end;
          end;
      end;
    finally
      grid.Free;
    end;
end;     }

function TBingMapsMapPortalSL.GetMapStateXMLObj: IXMLDOMDocument2;
var
  mapState: String;
  xmlMapstate: IXMLDOMDocument2;
begin
  result := nil;
  if assigned(MapCell) then
    begin
      mapState := MapCell.BingMapsData;
      if length(mapState) > 0 then
      begin
        xmlMapState := CoDomDocument60.Create;
        xmlMapState.async := false;
        xmlMapstate.setProperty('SelectionLanguage', 'XPath');
        xmlMapState.loadXML(mapState);
        if xmlMapState.parseError.errorCode = 0 then  //valid mapState
          result := xmlMapState;
      end;
    end;
end;

// *** Unit *****************************************************************

initialization
  RegisterMapPortalSL(CBingMapsMapPortal, TBingMapsMapPortalSL);

end.
