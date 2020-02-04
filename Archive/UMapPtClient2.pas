unit UMapPtClient2;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2006 by Bradford Technologies, Inc. }

{This unit bypasses the MapTools Mgr and works directly with the}
{container and the map services.                                }



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids_ts, TSGrid, osAdvDbGrid, StdCtrls, ComCtrls, ExtCtrls,
  TMultiP, Grids,
  LocationService,
  UContainer, UAddressMgr, UMapUtils, UMapEditorFrame, RzTrkBar, UForms;

type
  TMapPtClient2 = class(TAdvancedForm)
    PageControl: TPageControl;
    Panel1: TPanel;
    AddressPage: TTabSheet;
    MapPage: TTabSheet;
    DirectionsPage: TTabSheet;
    TabSheet1: TTabSheet;
    rbtnSubOnly: TRadioButton;
    rbtnSubComp: TRadioButton;
    rBtnSubRental: TRadioButton;
    rbtnSubListing: TRadioButton;
    rBtnAll: TRadioButton;
    AddressGrid: TosAdvDbGrid;
    btnCreateMap: TButton;
    StatusBar: TStatusBar;
    btnClose: TButton;
    btntestMap: TButton;
    MapImageXfer: TPMultiImage;
    procedure AddressGroupClick(Sender: TObject);
    procedure btnCreateMapClick(Sender: TObject);
    procedure btntestMapClick(Sender: TObject);
  private
    FDoc: TContainer;
    FAddressMgr: TAddressMgr;
    FCustID: Integer;
    FHasMapService: Boolean;
    FMapWidth: Integer;
    FMapHeight: Integer;
    FMapLLBounds: LatLongRectangle;    //MapPoint coordinates of LatLongRectangle
    FMapGeoRect: TGeoRect;             //ClickForms coordinates of LatLongRectangle
    FMapImageFile: String;
    FMapEditor: TMapEditorFrame;
    procedure LoadSubjectAddress(Subject: TSubAddress);
    procedure LoadCompAddresses(Comps: TCompList; const sLabel: String);
    procedure RecordSubjectGeoCodes(Subject: TSubAddress);
    procedure RecordCompGeoCodes(var rowIndex: Integer; Comps: TCompList);
    function ValidGeoCode(ALonStr, ALatStr: String): Boolean;
    function ValidAddress(const AAddress, ACity, AState, AZip: String): Boolean;
    function GetGeoCodeFromMapPoint(AStreet, ACity, AState, AZip: String; var ALon, ALat, AScore: String): Boolean;
    function GetAddressGeoCode(AStreet, ACity, AState, AZip: String; var ALon, ALat, AScore: String): Boolean;
    function GetGeoCodeList: String;
    procedure SetgeoCodeProximity(i: Integer; ALon,ALat: String);
    procedure SetGeoCodeAccuracy(i: Integer; AScore: String);
    procedure RecordGeoCodes;
    procedure GenerateMap;
    procedure DisplayMap;
    procedure SetMapLLBounds(const Value: LatLongRectangle);
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    function GeoCodeAddresses: Boolean;
    property AddressMgr: TAddressMgr read FAddressMgr write FAddressMgr;
    property HasService: Boolean read FHasMapService write FHasMapService;
    property MapLLBounds: LatLongRectangle read FMapLLBounds write SetMapLLBounds;
  end;

var
  MapPtClient2: TMapPtClient2;


  //used to invoke MapPoint Services
  procedure GetMapPointServices(doc: TContainer);


implementation

{$R *.dfm}

uses
  Types,
  UGlobals, UMapPointSelectAddress, UMapPointClientUtil,
  ULicUser, UStatus, UUtil1, UWebConfig;

type
  TCountry = (cUSA, cCanada);

const
  geocodeSolution = 'Enter the address of a nearby location which can be geocoded. When the map is created, manually move the arrow to the correct position.';
  geocodeProblem  = 'If the address is correct, this may be a rural or newly built area that has not yet been digitally mapped.';

  CountryArray : array[TCountry] of string = ('USA', 'Canada');

  agSubOnly         = 1;
  agSubAndComp      = 2;
  agSubAndRental    = 3;
  agSubAndListing   = 4;
  agAllAddresses    = 5;



//This is the call that invokes the Map Service
procedure GetMapPointServices(doc: TContainer);
var
  MapClient: TMapPtClient2;
begin
  MapClient := TMapPtClient2.Create(doc);
  try
    MapClient.ShowModal;
  finally
    MapClient.Free;
  end;
end;


{ TMapPointClient2 }

constructor TMapPtClient2.Create(AOwner: TComponent);
begin
  inherited Create (nil);
  SettingsName := CFormSettings_MapPtClient2;

  FDoc := TContainer(AOwner);
  FCustID := StrToIntDef(CurrentUser.LicInfo.UserCustID, 0);

  //### later check actual service
  HasService := FCustID > 0;  //they have a customer ID

  //create/insert the MapEditor Frame
  FMapEditor := TMapEditorFrame.Create(MapPage);
  FMapEditor.Parent := MapPage;
  FMapEditor.Visible := True;
  FMapEditor.Align := AlClient;

  PageControl.ActivePage := AddressPage;   //always start here

  if assigned(FDoc) then
    begin
      AddressMgr := TAddressMgr.Create(FDoc);

      rbtnSubOnly.Enabled := AddressMgr.HasSubjectAddress and HasService;
      rbtnSubComp.Enabled := (AddressMgr.Sales.Count > 0) and HasService;
      rbtnSubRental.Enabled := (AddressMgr.Rentals.count > 0) and HasService;
      rbtnSubListing.Enabled := (AddressMgr.Listings.count > 0) and HasService;
      rbtnAll.Enabled := AddressMgr.HasSomeComparables and HasService;

      //default to subject and Comps
      LoadSubjectAddress(AddressMgr.Subject);
      LoadCompAddresses(AddressMgr.Sales, 'COMP');

      btnCreateMap.Enabled := HasService;
    end
  else
    begin
      rbtnSubOnly.Enabled := False;
      rbtnSubComp.Enabled := False;
      rbtnSubRental.Enabled := False;
      rbtnSubListing.Enabled := False;
      rbtnAll.Enabled := False;
    end;
end;

Destructor TMapPtClient2.Destroy;
begin
  if assigned(AddressMgr) then
    AddressMgr.Free;

  inherited;
end;

procedure TMapPtClient2.btnCreateMapClick(Sender: TObject);
begin
  if HasService then               //make sure we can use service
    begin
      if GeoCodeAddresses then     //make sure we have good addresses/geocodes
        begin
          RecordGeoCodes;
          try
            GenerateMap;
            DisplayMap;
          except
            On E: Exception do ShowNotice(E.Message);
          end;
        end;
    end
  else begin
    ShowAlert(atWarnAlert, 'To use the location map services, you need to first register ClickFORMS.');
  end;
end;

//just testing
procedure TMapPtClient2.btnTestMapClick(Sender: TObject);
begin
  GenerateMap;
  DisplayMap;
end;

procedure TMapPtClient2.AddressGroupClick(Sender: TObject);
begin
  //always load subject
  LoadSubjectAddress(AddressMgr.Subject);

  //load in the others
  case TRadioButton(Sender).Tag of
    agSubAndComp:
      begin
        LoadCompAddresses(AddressMgr.Sales, 'COMP');
      end;
    agSubAndRental:
      begin
        LoadCompAddresses(AddressMgr.Rentals, 'RENTAL');
      end;
    agSubAndListing:
      begin
        LoadCompAddresses(AddressMgr.Listings, 'LISTING');
      end;
    agAllAddresses:
      begin
        LoadCompAddresses(AddressMgr.Sales, 'COMP');
        LoadCompAddresses(AddressMgr.Rentals, 'RENTAL');
        LoadCompAddresses(AddressMgr.Listings, 'LISTING');
      end;
  end;

  //everytime they click do this.
  GeoCodeAddresses;
  RecordGeoCodes;
end;

procedure TMapPtClient2.LoadSubjectAddress(Subject: TSubAddress);
begin
  AddressGrid.Rows := 0; // always reset in case grouping is on...
  AddressGrid.Rows := 1;
  AddressGrid.BeginUpdate;
  try
    if Subject <> nil then
      begin
        AddressGrid.Cell[1,1] := 'SUBJECT';
        AddressGrid.Cell[2,1] := Subject.Address;        //Address
        AddressGrid.Cell[3,1] := Subject.City;           //City
        AddressGrid.Cell[4,1] := Subject.State;          //state
        AddressGrid.Cell[5,1] := Subject.Zip;            //zip
        AddressGrid.Cell[6,1] := Subject.GPSLong;        //longitude
        AddressGrid.Cell[7,1] := Subject.GPSLat;         //latitude
        AddressGrid.Cell[8,1] := '';                     //proximity
//        AddressGrid.Cell[9,1] := Subject.GPSScore;       //accuracy
        SetGeoCodeAccuracy(1, Subject.GPSScore);
      end;
  finally
    AddressGrid.EndUpdate;
  end;
end;

procedure TMapPtClient2.LoadCompAddresses(Comps: TCompList; const sLabel: String);
var
  i: Integer;
begin
  if Comps.Count > 0 then
    begin
      AddressGrid.BeginUpdate;
      try
        for i := 0 to Comps.Count-1 do
          with TCompAddress(Comps.Items[i]) do
            with AddressGrid do
              begin
                Rows := Rows + 1;
                Cell[1,Rows] := sLabel + ' ' + IntToStr(i+1);  //i starts at zero
                Cell[2,Rows] := Address;        //Address
                Cell[3,Rows] := City;           //City
                Cell[4,Rows] := State;          //state
                Cell[5,Rows] := Zip;            //zip
                Cell[6,Rows] := GPSLong;        //longitude
                Cell[7,Rows] := GPSLat;         //latitude
                Cell[8,Rows] := Proximity;      //proximity
//                cell[9,Rows] := GPSScore;       //accuracy
                SetGeoCodeAccuracy(Rows, GPSScore);//accuracy
              end;
      finally
        AddressGrid.EndUpdate;
      end;
    end;
end;

//routine to check if address already has a valid geocode
function TMapPtClient2.ValidGeoCode(ALonStr, ALatStr: String): Boolean;
var
  DNC: Double; //DoNotCare
begin
  result := (length(ALonStr)>0) and (length(ALatStr)>0) and
            IsValidNumber(ALonStr, DNC) and
            IsValidNumber(ALatStr, DNC);
end;

function TMapPtClient2.ValidAddress(const AAddress, ACity, AState, AZip: String): Boolean;
begin
  result := Not((length(AAddress)= 0) or
                (length(ACity)=0) or
                (length(AState)=0) or
                (length(AZip)=0));
end;

//routine for getting geocode from MS MapPoint service
function TMapPtClient2.GetGeoCodeFromMapPoint(AStreet, ACity, AState, AZip: String; var ALon, ALat, AScore: String): Boolean;
var
  theAddress, retMsg: WideString;
  GeoCodeResults: FindResults;
  resultCounter: Integer;
  ThisLongitude, ThisLatitude, ThisScore: Double;
begin
  result := False;
  theAddress := AStreet + ',' + ACity +', '+AState + ' ' + AZip;
  GetGeoCodeEx(theAddress, FCustId, GeoCodeResults, retMsg);

  if retMsg <> 'Success' then
    raise Exception.Create('A server error occured while geocoding address "'+ theAddress + '". ' + retMsg)
  else
    begin
      case GeoCodeResults.NumberFound of
        //nothing found
        0 : raise Exception.Create('The address "' + theAddress + '" could not be geocoded. ' + retMsg);

        //single match geocode on address
        1 :
          begin
            ThisLongitude:= GeoCodeResults.Results[0].FoundLocation.LatLong.Longitude;
            ThisLatitude := GeoCodeResults.Results[0].FoundLocation.LatLong.Latitude;
            ThisScore := GeoCodeResults.Results[0].Score * 100;

            ALon := FloatToStrF(ThisLongitude,ffGeneral, 12,10);
            ALat := FloatToStrF(ThisLatitude,ffGeneral, 12,10);
            AScore := FloatToStr(ThisScore);
            result := True;
          end;
      else //many were found
        //Show the User the Address Selector Dialog
        with TMapPointSelectAddress.Create(nil) do
          try
            UnkownAddress.Caption := theAddress;
            ListBoxAddresses.Items.Clear;

            for ResultCounter := 0 to GeoCodeResults.NumberFound -1 do
              ListBoxAddresses.Items.Add(GeoCodeResults.Results[ResultCounter].FoundLocation.Entity.DisplayName);

            ListBoxAddresses.ItemIndex := 0;      //default to the first one
            CustID := FCustID;                    //assign custID so we can do geocodes when user picks new address

            MultipleFindResults := GeoCodeResults;  //Show the available addresses

            if ShowModal = mrOk then
              begin
                ThisLatitude := Latitude;
                ThisLongitude:= Longitude;
                ThisScore := 0;   //#### - add in to return the score

                ALon := FloatToStrF(ThisLongitude,ffGeneral, 12,10);
                ALat := FloatToStrF(ThisLatitude,ffGeneral, 12,10);
                AScore := FloatToStr(ThisScore);
                result := True;
              end
            else
              raise Exception.Create('An error occured while selecting an address from the list.');
          finally
            Free;
          end;
      end;//case
    end; //if
end;

function TMapPtClient2.GetAddressGeoCode(AStreet, ACity, AState, AZip: String; var ALon, ALat, AScore: String): Boolean;
begin
  //this extra routine is here if we use multiple services for getting codes.

  result := GetGeoCodeFromMapPoint(AStreet, ACity, AState, AZip, ALon, ALat, AScore);
end;

procedure TMapPtClient2.SetGeoCodeAccuracy(i: Integer; AScore: String);
var
  Score: Integer;
begin
  if Length(AScore) > 0 then
    begin
      Score := GetValidInteger(AScore);
      AddressGrid.Cell[9,i] := IntToStr(Score) + ' %';

      if Score >= 95 then
        AddressGrid.CellColor[9,i] := colorLiteGreen
      else if Score >= 90 then
        AddressGrid.CellColor[9,i] := clYellow
      else if Score < 90 then
        AddressGrid.CellColor[9,i] := clRed;
    end;
end;

procedure TMapPtClient2.SetGeoCodeProximity(i: Integer; ALon,ALat: String);
var
  SubjPt, CompPt: TGeoPoint;
  Distance: Double;
begin
  if (i>1) and (i<=AddressGrid.Rows) then
    begin
      //get subject Geocode position
      SubjPt.Latitude := AddressGrid.Cell[7,1];
      SubjPt.Longitude := AddressGrid.Cell[6,1];

      //get Comps Geocode postion
      CompPt.Latitude := GetValidNumber(ALat);
      CompPt.Longitude := GetValidNumber(ALon);

      //get Distance
      Distance := GetGreatCircleDistance(SubjPt, CompPt);

      //Show user
      AddressGrid.Cell[8,i] := Trim(Format('%8.1f Mi', [Distance]));
    end;
end;
(*
//TESTING
//multiple properties
function TMapPtClient2.GeoCodeAddresses: Boolean;
begin
  with AddressGrid do
    begin
      BeginUpdate;
      Cell[6,1] := -121.922887;
      Cell[7,1] := 37.260558;
      Cell[6,2] := -121.931398;
      Cell[7,2] := 37.261802;
      Cell[6,3] := -121.93063827;
      Cell[7,3] := 37.2512882426;
      Cell[6,4] := -121.939599;
      Cell[7,4] := 37.267899;
      EndUpdate;
    end;
end;
*)
(*
//Subject Only
procedure TMapPtClient2.Set1GeoCodeAddresses;
begin
  with AddressGrid do
    begin
      BeginUpdate;
      Cell[6,1] := -121.922887;
      Cell[7,1] := 37.260558;
      EndUpdate;
    end;
end;
*)

function TMapPtClient2.GeoCodeAddresses: Boolean;
var
  i: Integer;
  RowName,Address,City,State,Zip: String;
  ALon,ALat,AScore: String;
begin
  result := True;
  with AddressGrid do
    for i := 1 to AddressGrid.rows do
      begin
        ALon := Cell[6,i];
        ALat := Cell[7,i];
        if not ValidGeoCode(ALon,ALat) then
          begin
            RowName := Cell[1,i];        //name of row
            Address := Cell[2,i];        //Address
            City := Cell[3,i];           //City
            State := Cell[4,i];          //state
            Zip := Cell[5,i];            //zip

            if not ValidAddress(Address, City, State, Zip) then
              begin
                ShowAlert(atWarnAlert, RowName + ' is missing part of the address. Please make sure the address, city, state and postal/zip code are entered correctly.');
                result := False;
                break;
              end
            else if GetAddressGeoCode(Address,City,State,Zip, ALon,ALat,AScore) then
              begin
                AddressGrid.BeginUpdate;
                Cell[6,i] := ALon;
                Cell[7,i] := ALat;

                SetGeoCodeAccuracy(i, AScore);      //Set accuracy score
                if i > 1 then
                  SetGeoCodeProximity(i, ALon,ALat);  //calc the proximity
                AddressGrid.EndUpdate;
              end
            else begin
                ShowAlert(atWarnAlert, RowName + ' ' + geocodeProblem + ' ' + geocodeSolution);
                result := False;
                break;
              end;
          end;
      end;
end;

//compile list of points for generating the map
function TMapPtClient2.GetGeoCodeList: String;
var
  i: Integer;
begin
  result := '';
  with AddressGrid do
    for i := 1 to Rows do
      begin
        result := Cell[7,i] + ',' + Cell[6,i] + ';';
      end;
end;

procedure TMapPtClient2.RecordSubjectGeoCodes(Subject: TSubAddress);
begin
  Subject.GPSLabel := AddressGrid.Cell[1,1];       //Label
  Subject.Address := AddressGrid.Cell[2,1];        //Address
  Subject.City := AddressGrid.Cell[3,1];           //City
  Subject.State := AddressGrid.Cell[4,1];          //state
  Subject.Zip := AddressGrid.Cell[5,1];            //zip
  Subject.GPSLong := AddressGrid.Cell[6,1];        //longitude
  Subject.GPSLat := AddressGrid.Cell[7,1];         //latitude
  Subject.GPSScore := AddressGrid.Cell[9,1];       //accuracy
end;

procedure TMapPtClient2.RecordCompGeoCodes(var rowIndex: Integer; Comps: TCompList);
var
  i: Integer;
begin
  for i := 0 to Comps.Count-1 do
    with TCompAddress(Comps.Items[i]) do
      with AddressGrid do
        begin
          GPSLabel := Cell[1,rowIndex];       //Label
          Address := Cell[2,rowIndex];        //Address
          City := Cell[3,rowIndex];           //City
          State := Cell[4,rowIndex];          //state
          Zip := Cell[5,rowIndex];            //zip
          GPSLong := Cell[6,rowIndex];        //longitude
          GPSLat := Cell[7,rowIndex];         //latitude
          Proximity := Cell[8,rowIndex];      //proximity
          GPSScore := Cell[9,rowIndex];       //accuracy
          rowIndex := rowIndex + 1;
        end;
end;

procedure TMapPtClient2.RecordGeoCodes;
var
  rowStart: Integer;
begin
  //always record subject
  RecordSubjectgeoCodes(AddressMgr.Subject);

  //record others
  rowStart := 2;
  if rbtnSubComp.checked then
    begin
      RecordCompGeoCodes(rowStart, AddressMgr.Sales);
    end
  else if rBtnSubRental.checked then
    begin
      RecordCompGeoCodes(rowStart, AddressMgr.Rentals);
    end
  else if rbtnSubListing.checked then
    begin
      RecordCompGeoCodes(rowStart, AddressMgr.Listings);
    end
  else if rBtnAll.Checked then
    begin
      RecordCompGeoCodes(rowStart, AddressMgr.Sales);
      RecordCompGeoCodes(rowStart, AddressMgr.Rentals);
      RecordCompGeoCodes(rowStart, AddressMgr.Listings);
    end;
end;

procedure TMapPtClient2.GenerateMap;
const
  ShowPushPins = 1;    //set to 1 to Show PushPins
var
  theAddress: WideString;
  retMsg: WideString;
  LabelsStr: String;
  LatLonList: String;
  iZoomPercent: Integer;
  dViewScale: Double;
  theMap: TByteDynArray;
  LLBounds: LatLongRectangle;
begin
  //this is the address that will be recorded in transaction server
  with AddressMgr.Subject do
    theAddress := Address + ',' + City +', '+State + ' ' + Zip;

  //This is info needed to produce map
  LatLonList := GetGeoCodeList;
  LabelsStr := '';
  FMapHeight := 816;
  FMapWidth := 532;
  FMapLLBounds := nil;
  iZoomPercent := 0;
  dViewScale := 0;
  GetGifMapEx(LabelsStr, LatLonList, FCustID, theAddress,
            FMapHeight, FMapWidth, iZoomPercent, ShowPushPins, dViewScale, LLBounds, retMsg, theMap);

  if retMsg = 'Success' then
    begin
      MapLLBounds := LLBounds;     //starting GeoCoordinates; property also sets MapGeoRect

      //put it into a file so it can be read.
      FMapImageFile := CreateTempFilePath('Map.gif');
      ByteArrayToFile(theMap, FMapImageFile);
    end
  else
    raise Exception.Create('The location map was not received from the server.');
end;

//Switching to Map Editor to display & edit
procedure TMapPtClient2.DisplayMap;
begin
  MapPage.Visible := True;                 //no results yet
  PageControl.ActivePage := MapPage;
  FMapEditor.MapBox.Invalidate;
  FMapEditor.ScrollBox.Invalidate;

  //setup MapEditor and display the map
  try
    if FileExists(FMapImageFile) then
      begin
        //#### need to figure out how to get rid of this step
        //     and  read in Gif BMP directly into editor bitmap
        MapImageXfer.ImageName := FMapImageFile;
        FMapEditor.MapBmp := MapImageXfer.Picture.BitMap;

        FMapEditor.MapLLRect := MapLLBounds;
        FMapEditor.MapHeight := FMapHeight;
        FMapEditor.MapWidth := FMapWidth;
        FMapEditor.Customer := FCustID;
      end;
  except
    raise Exception.Create('There was a problem loading the map image file.');
  end;
end;

procedure TMapPtClient2.SetMapLLBounds(const Value: LatLongRectangle);
begin
  FMapLLBounds := Value;

  FMapGeoRect.TopLat := FMapLLBounds.Northeast.Latitude;
  FMapGeoRect.BotLat := FMapLLBounds.Southwest.Latitude;
  FMapGeoRect.LeftLong := FMapLLBounds.Southwest.Longitude;
  FMapGeoRect.RightLong := FMapLLBounds.Northeast.Longitude;
end;








(*
//TESTING
//multiple points
procedure TMapPtClient2.GenerateMap;
begin
  FMapGeoRect.TopLat := 37.283077195;
  FMapGeoRect.BotLat := 37.236111603;
  FMapGeoRect.LeftLong := -121.9504729;
  FMapGeoRect.RightLong := -121.9120131;

  FMapImageFile := 'C:\ClickForms7\Temp\Tmp_MultiGPS_Map.gif';
end;


//Subject Only
procedure TMapPtClient2.GenerateMap;
begin
  FMapGeoRect.TopLat := 37.273835977;
  FMapGeoRect.BotLat := 37.24728052;
  FMapGeoRect.LeftLong := -121.93376165;
  FMapGeoRect.RightLong := -121.91201235;

  FMapImageFile := 'C:\ClickForms7\Temp\Tmp_Subject_Map.gif';
end;
*)

end.
