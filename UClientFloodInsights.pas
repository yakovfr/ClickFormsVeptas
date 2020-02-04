unit UClientFloodInsights;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2009 by Bradford Technologies, Inc. }

{ This unit interfaces to the Flood Insightes webservice unit}


interface

uses Classes, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, ExtCtrls, SysUtils,StdCtrls, Graphics, IdException;

const
  Flood_UserWantsMap      = 1;
  Flood_UserWantsDataOnly = 0;

type
  EHTTPCLientError = class(Exception);

  TFloodInsightClient = class(TComponent)
  private
    //added by vivek, this variable is fisrt used with GetMap() and then in GetMapEx to
    //read the individual candidate info as needed
    ResponseStr: String;
    FidHTTP : TidHTTP;
    FISAPIURL: string;            //server URL
    FAccountID: string;           //users account
    FPin: string;                 //some pin or access code
    FMapHeight: Integer;          //map height
    FMapWidth: Integer;           //map width
    FWantsMap: Integer;           //=1 gets map; =0 no map is charged to user

    FipnXMLData: string;          //markers for data coming back
    FipnMapData: string;
    FipnAccountID: string;       //tag names for request data going to server
    FipnPin: string;
    FipnIconLabel: string;
    FipnCity: string;
    FipnPlus4: string;
    FipnState: string;
    FipnStreetAddress: string;
    FipnZip: string;
    FipnMapHeight: string;
    FipnMapWidth: string;
    FipnOptionalMap: String;   //option to charge for map or not

    //added by Vivek
    FipnGeoResult: String;
    FipnCensusBlockID: String;
    FipnLon: String;
    FipnLat: String;
    //10/19/2005
    FipnZoom: String;
    FipnImageID: String;
    FipnLocPtX: String;
    FipnLocPtY: String;

    //Input values
    FSubjectLabel: string;
    FSubjectStreetAddress: string;
    FSubjectCity: string;
    FSubjectState: string;
    FSubjectZip: string;
    FSubjectPlus4: string;

    //added new by vivek
    FSubjectLon :String;
    FSubjectLat :String;
    FSubjectGeoResult :String;
    FSubjectCensusBlockID :String;
    FSubjectMapHeight :String;
    FSubjectMapWidth :String;

    //VR 10/19/05
    FSubjectImageID :String;
    FSubjectZoom :String;
    FSubjectLocPtX :String;
    FSubjectLocPtY :String;
    FSubjectImageURL: string;
    FSubjectImageName: String;

    //Output values
    FMapJPEG: TMemoryStream;      //jpeg obj of image
    FCensusTract: string;         //result census tract
    FLongitude: string;           //result
    FLatitude: string;            //result
    FCommunityID: string;         //result
    FCommunityName: string;       //result
    FZone: string;                //result
    FPanel: string;               //result
    FPanelDate: string;           //result
    FFIPSCode: string;            //result
    FSHFAResult: string;          //result
    FSHFANearBy: String;          //result
    FSFHAPhrase: string;          //result
    FZipPlus4: string;            //result
    FMapNumber: String;           //result

    //added by vivek
    FMulAddressList: TStringList;
    FGeoResult: String;

    procedure SetPanelDate(const Value: String);
    procedure ParseTheXML(XMLStr: String);
    function BuildMultipleResultList(XMLStr: String): Boolean;
    function BuildMapQueryStr(XMLStr: String; ListBoxIndex: Integer): String;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    //definitions updated by vivek, MultiAddressList  will return the multiple addresses
    //in case more than one results are found. GetMapEx() will be used for getting the
    //map for an address from this list.

    //adds the legends and flood zone text onto the map
    function FinalizeFloodMap(): boolean;

    function GetCFDB_Map(IsFloodMap: Boolean=True):String;
    function GetCFAW_Map():String;
    function GetCFDB_MapEx(ListBoxIndex: Integer):String;
    function GetCFAW_MapEx(ListBoxIndex: Integer):String;
    function GetCFDB_SpottedMap(RequestStr: string): String;
    function GetCFAW_SpottedMap(RequestStr: string): String;
  published
    property AccountID: string read FAccountID write FAccountID;
    property Pin: string read FPin write FPin;
    property ISAPIURL: string read FISAPIURL write FISAPIURL;
    property MapHeight: Integer read FMapHeight write FMapHeight;
    property MapWidth: Integer read FMapWidth write FMapWidth;
    property WantsMap: Integer read FWantsMap write FWantsMap;
    property SubjectLabel: string read FsubjectLabel write FsubjectLabel;
    property SubjectStreetAddress: string read FsubjectStreetAddress write FsubjectStreetAddress;
    property SubjectCity: string read FsubjectCity write FsubjectCity;
    property SubjectState: string read FsubjectState write FsubjectState;
    property SubjectZip: string read FsubjectZip write FsubjectZip;
    property SubjectPlus4: string read FsubjectPlus4 write FsubjectPlus4;

    //added by vivek
    property SubjectLon: string read FSubjectLon write FSubjectLon;
    property SubjectLat: string read FSubjectLat write FSubjectLat;
    property SubjectGeoResult :string read FSubjectGeoResult write FSubjectGeoResult;
    property SubjectCensusBlockID :string read FSubjectCensusBlockID write FSubjectCensusBlockID;
    property SubjectMapHeight :string read FSubjectMapHeight write FSubjectMapHeight;
    property SubjectMapWidth :string read FSubjectMapWidth write FSubjectMapWidth;

    //10/19/2005
    property SubjectImageID :string read FSubjectImageID write FSubjectImageID;
    property SubjectZoom :string read FSubjectZoom write FSubjectZoom;
    property SubjectLocPtX :string read FSubjectLocPtX write FSubjectLocPtX;
    property SubjectLocPtY :string read FSubjectLocPtY write FSubjectLocPtY;
    property SubjectImageURL :string read FSubjectImageURL write FSubjectImageURL;
    property SubjectImageName: String read FSubjectImageName write FSubjectImageName;

    {results coming back from server}
    property FloodMap: TMemoryStream read FMapJpeg write FMapJpeg;
    property CensusTract : string read FCensusTract write FCensusTract;
    property Longitude: String read FLongitude write FLongitude;
    property Latitude: String read FLatitude write FLatitude;
    property CommunityID: String read FCommunityID write FCommunityID;
    property CommunityName: String read FCommunityName write FCommunityName;
    property Zone: String read FZone write FZone;
    property Panel: String read FPanel write FPanel;
    property PanelDate: String read FPanelDate write SetPanelDate;
    property FIPSCode: String read FFIPSCode write FFIPSCode;
    property SHFAResult: String read FSHFAResult write FSHFAResult;
    property SFHAPhrase: String read FSFHAPhrase write FSFHAPhrase;
    property SHFANearBy: String read FSHFANearBy write FSHFANearBy;
    property ZipPlus4: string read FZipPlus4 write FZipPlus4;
    property MapNumber: String read FMapNumber write FMapNumber;

    //added by vivek
    property MulAddressList: TStringList read FMulAddressList write FMulAddressList;
    property GeoResult: String read FGeoResult write FGeoResult;

    {Tag Names for the Request Variables}
    property ipnAccountID : string read FipnAccountID write FipnAccountID;
    property ipnPin: string read FipnPin write FipnPin;
    property ipnIconLabel : string read FipnIconLabel write FipnIconLabel;
    property ipnCity : string read FipnCity write FipnCity;
    property ipnMapHeight : string read FipnMapHeight write FipnMapHeight;
    property ipnMapWidth : string read FipnMapWidth write FipnMapWidth;
    property ipnPlus4 : string read FipnPlus4 write FipnPlus4;
    property ipnState : string read FipnState write FipnState;
    property ipnStreetAddress : string read FipnStreetAddress write FipnStreetAddress;
    property ipnZip : string read FipnZip write FipnZip;
    property ipnOptionalMap: string read FipnOptionalMap write FipnOptionalMap;

    //added by vivek
    property ipnGeoResult: string read FipnGeoResult write FipnGeoResult;
    property ipnCensusBlockID: string read FipnCensusBlockID write FipnCensusBlockID;
    property ipnLon: string read FipnLon write FipnLon;
    property ipnLat: string read FipnLat write FipnLat;

    property ipnZoom: string read FipnZoom write FipnZoom;
    property ipnImageID: string read FipnImageID write FipnImageID;
    property ipnLocPtX: string read FipnLocPtX write FipnLocPtX;
    property ipnLocPtY: string read FipnLocPtY write FipnLocPtY;


    {Name of markers in the response string}
    property ipnMapData : string read FipnMapData write FipnMapData;
    property ipnXMLData : string read FipnXMLData write FipnXMLData;
  end;

implementation

uses
  Jpeg, XMLIntf, XMLDoc, StrUtils, UWebUtils,
  UGlobals, UStatus, UUtil3;

const
  FloodMapLegendJPG = 'FloodInsightsLegend.jpg';
  SErrorNoAccess    = 'Could not access the server.';
  SErrorNoISAPIURL  = 'ISAPIURL property is blank, assign a valid URL and try again';


{ TFloodInsightClient }

constructor TFloodInsightClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FloodMap := TMemoryStream.Create;

  MulAddressList := TStringList.Create;

  // Defaults
  FISAPIURL         := 'http://localhost/scripts/FloodServer.dll/GetFloodInfo';
  FMapWidth         := 7150;
  FMapHeight        := 11000;
  ipnXMLData        := 'XMLData';       //marker in response
  ipnMapData        := 'MapData';       //marker in response
//  ipnAccountID := 'AccountID';   //var names in request
//  ipnPin := 'Pin';

  //changed by vivek
  ipnAccountID      := 'CustomerID';   //var names in request
  ipnPin            := 'CustomerPin';

  ipnIconLabel      := 'txtText';
  ipnStreetAddress  := 'txtStreet';
  ipnCity           := 'txtCity';
  ipnState          := 'txtState';
  ipnZip            := 'txtZip';
  ipnPlus4          := 'txtPlus4';
  ipnMapWidth       := 'txtMapWidth';
  ipnMapHeight      := 'txtMapHeight';
  ipnOptionalMap    := 'txtReturnMap';

  //added by Vivek
  ipnGeoResult      := 'txtGeoResult';
  ipnCensusBlockID  := 'txtCensusBlockID';
  ipnLon            := 'txtLon';
  ipnLat            := 'txtLat';
  //10/19/2005
  ipnZoom           := 'txtZoom';
  ipnImageID        := 'txtImageID';
  ipnLocPtX         := 'txtLocPtX';
  ipnLocPtY         := 'txtLocPtY';
end;

destructor TFloodInsightClient.Destroy;
begin
  FloodMap.Free;       //image memory stream
  MulAddressList.Free;
  inherited Destroy;
end;


function TFloodInsightClient.GetCFDB_Map(IsFloodMap: Boolean=True):String;
var
  XMLStr: String;
  RequestStr: string;
  XMLDataStartPos : Integer;
begin
  if ISAPIURL = '' then
    raise EHTTPCLientError.Create(SErrorNoISAPIURL);

  // The base location of the ISAPI dll on the IIS server.
  RequestStr := ISAPIURL;

  // Now start adding the parameters to the QueryStr, separate them with '&'s
  RequestStr := RequestStr + 'GetFloodInfo?' +
    ipnAccountID      + '=' + URLEncode(AccountID)            + '&' +
    ipnPin            + '=' + URLEncode(Pin)                  + '&' +
    ipnMapWidth       + '=' + IntToStr(MapWidth)              + '&' +
    ipnMapHeight      + '=' + IntToStr(MapHeight)             + '&' +
    ipnZoom           + '=' + URLEncode(SubjectZoom)          + '&' +
    ipnIconLabel      + '=' + URLEncode(SubjectLabel)         + '&' +
    ipnStreetAddress  + '=' + URLEncode(SubjectStreetAddress) + '&' +
    ipnCity           + '=' + URLEncode(SubjectCity)          + '&' +
    ipnState          + '=' + URLEncode(SubjectState)         + '&' +
    ipnZip            + '=' + URLEncode(SubjectZip)           + '&' +
    ipnPlus4          + '=' + URLEncode(SubjectPlus4)         + '&' +
    ipnOptionalMap    + '=' + IntToStr(WantsMap);
(*
txtReturnMap = '1' if we want the map
txtReturnMap = '0' if we don't want the map
*)

(*
  if demoMode then
    begin
      FloodMap.LoadFromFile(ApplicationFolder + 'Samples\SampleFloodMap.jpg');
      FloodMap.Position := 0;
      Result := 'Single';
      Exit;
    end;
*)

  FIdHTTP := TIdHTTP.Create(self);
  try
    try
      if DemoMode then
        ResponseStr := LoadDemoStringFromFile('DemoFloodMap.txt')
      else
        ResponseStr := FidHTTP.Get(RequestStr);               //make query, get response

//      SaveDemoStringToFile(RequestStr,'RequestFloodMap.txt');   //DEMO
//      SaveDemoStringToFile(ResponseStr,'ResponseFloodMap.txt');   //DEMO
//      SaveDemoStringToFile(ResponseStr,'DemoFloodMap.txt');   //DEMO

      if IsFloodMap then
        begin
          //check if responsestr is empty return a ERROR msg
          if Length(ResponseStr) = 0 then
          begin
            Result := 'Error';
            raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
          end;

            if pos('Notice Code:',ResponseStr) > 0 then //Error Messages from CustDB subscription service are starting with 'Notice Code:'
            begin
              Result := srCustDBRspNotAvailable;
              exit;
            end;

          //check if we need to display a message
          if compareText(ResponseStr, 'SeeMsg') = 0 then     //? bradford flood server never return this
            begin
              result := '';
              exit;
            end;

          //check if the response from server is an error
          if pos('Error: ', ResponseStr) = 1 then      //some othe error
          begin
            Result := 'Error';
            Delete(ResponseStr, 1, length('Error: '));       //get rid of error word
            if pos('You are not presently recognized as a Flood Maps User', ResponseStr) > 0 then
              begin
                result := srCustDBRspNotAvailable;
                exit;
              end
            else
              raise Exception.Create(ResponseStr);      //raise the exception to be shown to user
          end;     
        end;

      if (not ((Result = srCustDBRspIsEmpty) or (Result = srCustDBRspIsError) or (Result = srCustDBRspNotAvailable))) then
        begin
          //check if the response from server contains multiple result
          if pos('<?xml', ResponseStr) = 1 then
          begin
            Result := 'Multiple';
            //parse and show it in the listbox
            if not BuildMultipleResultList(ResponseStr) then
            begin
              Result := 'Error';
              raise Exception.Create('Error creating the multiple address result list.');
            end;
          end;

          //check if the response from server contains the map
          if pos(ipnXMLData, ResponseStr) = 1 then
          begin
            //the response has two parts: XML Data and Jpeg Image, the tags indicate the dividers
            XMLDataStartPos := Pos(ipnXMLData, ResponseStr) + Length(ipnXMLData) + 1;
            XMLStr := Copy(ResponseStr, XMLDataStartPos, Pos(ipnMapData, ResponseStr) - XMLDataStartPos - 1);

            try
              ParseTheXML(XMLStr);    //extract the xml values
              Result := 'Single';
            except
              begin
                Result := 'Error';
                ShowNotice('There is a problem geo-coding the address. The results may be invalid. Please recheck the address.');
              end;
            end;

            //find the start of the Image Data and delete everything before it
            Delete(ResponseStr, 1, Pos(ipnMapData, ResponseStr) + Length(ipnMapData));

            if length(ResponseStr) > 0 then   //extract the image
              begin
                FloodMap.WriteBuffer(ResponseStr[1], Length(ResponseStr));
                FloodMap.Position := 0;

                //add legends and text to the map
                if not FinalizeFloodMap() then
                begin
                  result := 'Error';
                  raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
                end else result := 'Single';
              end
            else
            begin
              Result := 'Error';
              raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
            end;
          end;
          if pos('Error', ResponseStr) > 0 then
            begin
              Result := 'Error';
              raise Exception.Create(ResponseStr);
            end;
        end;
    except
      on E: Exception do
      begin
        Result := 'Error';
        raise Exception.Create(E.message);
      end;
    end;
  finally
    FIdHTTP.Free;
  end;
end;

function TFloodInsightClient.GetCFAW_Map():String;
var
  XMLStr: String;
  RequestStr: string;
  XMLDataStartPos : Integer;
begin
  if ISAPIURL = '' then
    raise EHTTPCLientError.Create(SErrorNoISAPIURL);

  // The base location of the ISAPI dll on the IIS server.
  RequestStr := ISAPIURL;

  // Now start adding the parameters to the QueryStr, separate them with '&'s
  RequestStr := RequestStr + 'GetFloodInfo?' +
    ipnAccountID      + '=' + URLEncode(AccountID)            + '&' +
    ipnPin            + '=' + URLEncode(Pin)                  + '&' +
    ipnMapWidth       + '=' + IntToStr(MapWidth)              + '&' +
    ipnMapHeight      + '=' + IntToStr(MapHeight)             + '&' +
    ipnZoom           + '=' + URLEncode(SubjectZoom)          + '&' +
    ipnIconLabel      + '=' + URLEncode(SubjectLabel)         + '&' +
    ipnStreetAddress  + '=' + URLEncode(SubjectStreetAddress) + '&' +
    ipnCity           + '=' + URLEncode(SubjectCity)          + '&' +
    ipnState          + '=' + URLEncode(SubjectState)         + '&' +
    ipnZip            + '=' + URLEncode(SubjectZip)           + '&' +
    ipnPlus4          + '=' + URLEncode(SubjectPlus4)         + '&' +
    ipnOptionalMap    + '=' + IntToStr(WantsMap);
(*
txtReturnMap = '1' if we want the map
txtReturnMap = '0' if we don't want the map
*)

(*
  if demoMode then
    begin
      FloodMap.LoadFromFile(ApplicationFolder + 'Samples\SampleFloodMap.jpg');
      FloodMap.Position := 0;
      Result := 'Single';
      Exit;
    end;
*)

  FIdHTTP := TIdHTTP.Create(self);
  try
    try
      if DemoMode then
        ResponseStr := LoadDemoStringFromFile('DemoFloodMap.txt')
      else
        ResponseStr := FidHTTP.Get(RequestStr);               //make query, get response

//      SaveDemoStringToFile(ResponseStr,'DemoFloodMap.txt');   //DEMO

      //check if responsestr is empty return a ERROR msg
      if Length(ResponseStr) = 0 then
        Result := srCustDBRspIsEmpty
      else if pos('Error: ', ResponseStr) = 1 then //check if the response from server is an error
        Result := srCustDBRspIsError
      else
        begin
          //check if the response from server contains multiple result
          if pos('<?xml', ResponseStr) = 1 then
          begin
            Result := 'Multiple';
            //parse and show it in the listbox
            if not BuildMultipleResultList(ResponseStr) then
            begin
              Result := 'Error';
              raise Exception.Create('Error creating the multiple address result list.');
            end;
          end;

          //check if the response from server contains the map
          if pos(ipnXMLData, ResponseStr) = 1 then
          begin
            //the response has two parts: XML Data and Jpeg Image, the tags indicate the dividers
            XMLDataStartPos := Pos(ipnXMLData, ResponseStr) + Length(ipnXMLData) + 1;
            XMLStr := Copy(ResponseStr, XMLDataStartPos, Pos(ipnMapData, ResponseStr) - XMLDataStartPos - 1);

            try
              ParseTheXML(XMLStr);    //extract the xml values
              Result := 'Single';
            except
              begin
                Result := 'Error';
                ShowNotice('There is a problem geo-coding the address. The results may be invalid. Please recheck the address.');
              end;
            end;

            //find the start of the Image Data and delete everything before it
            Delete(ResponseStr, 1, Pos(ipnMapData, ResponseStr) + Length(ipnMapData));

            if length(ResponseStr) > 0 then   //extract the image
              begin
                FloodMap.WriteBuffer(ResponseStr[1], Length(ResponseStr));
                FloodMap.Position := 0;

                //add legends and text to the map
                if not FinalizeFloodMap() then
                begin
                  result := 'Error';
                  raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
                end else result := 'Single';
              end
            else
            begin
              Result := 'Error';
              raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
            end;
          end;
        end;
    except
      on E: Exception do
      begin
        Result := 'Error';
        raise Exception.Create(E.message);
      end;
    end;
  finally
    FIdHTTP.Free;
  end;
end;

function TFloodInsightClient.BuildMultipleResultList(XMLStr: String): Boolean;
var
  XMLDOM: IXMLDocument;

  CdGeoResultsNode: IXMLNode;
  CdCandidatesNode: IXMLNode;
  CdCandidateNode: IXMLNode;

  //local variables to hold the values of Candidate Nodes
  lvtxtStreet, lvtxtCity, lvtxtState, lvtxtZip, lvtxtPlus4, lvtxtLon,
  lvtxtLat, lvtxtGeoResult, lvtxtFirm, lvtxtCensusId, lvtxtPrecision: String;

  I: Integer;
begin
  Result := True;
  XMLDOM := LoadXMLData(XMLStr);

  //clear the property MulAddressList
  MulAddressList.Clear;

  if not XMLDOM.IsEmptyDoc then
  begin
      //read the top most CdGeoResults node
      CdGeoResultsNode := XMLDOM.ChildNodes.FindNode('CdGeoResults');
      if CdGeoResultsNode <> nil then
      begin
        //read CdCandidates
        CdCandidatesNode := CdGeoResultsNode.ChildNodes.FindNode('CdCandidates');
        if CdCandidatesNode <> nil then
        begin
          //check how many child nodes are there
          if CdCandidatesNode.ChildNodes.Count > 1 then
          begin
              for I := 0 to CdCandidatesNode.ChildNodes.Count - 1 do
              begin
                //read CdCandidates
                CdCandidateNode := CdCandidatesNode.ChildNodes[I];

                lvtxtStreet     := CdCandidateNode.ChildNodes['txtStreet'].Text;
                lvtxtCity       := CdCandidateNode.ChildNodes['txtCity'].Text;
                lvtxtState      := CdCandidateNode.ChildNodes['txtState'].Text;
                lvtxtZip        := CdCandidateNode.ChildNodes['txtZip'].Text;
                lvtxtPlus4      := CdCandidateNode.ChildNodes['txtPlus4'].Text;
                lvtxtLon        := CdCandidateNode.ChildNodes['txtLon'].Text;
                lvtxtLat        := CdCandidateNode.ChildNodes['txtLat'].Text;
                lvtxtGeoResult  := CdCandidateNode.ChildNodes['txtGeoResult'].Text;
                lvtxtFirm       := CdCandidateNode.ChildNodes['txtFirm'].Text;
                lvtxtCensusId   := CdCandidateNode.ChildNodes['txtCensusBlockId'].Text;
                lvtxtPrecision  := CdCandidateNode.ChildNodes['txtPrecision'].Text;

                MulAddressList.Add(lvtxtStreet + ', ' + lvtxtCity + ', ' + lvtxtState + ', ' + lvtxtZip + ', ' + lvtxtPlus4);
              end;
          end;
        end else Result := False;
      end else Result := False;
  end else Result := False;
end;

function TFloodInsightClient.GetCFDB_MapEx(ListBoxIndex: Integer): String;
var
  XMLStr: String;
  RequestStr: string;
  XMLDataStartPos : Integer;
  FIdHTTP : TidHTTP;
begin
  Result := '';
  FIdHTTP := TIdHTTP.Create(self);
  try
    // The base location of the ISAPI dll on the IIS server.
    RequestStr := ISAPIURL;

    RequestStr := RequestStr + 'GetMapInfo?' + BuildMapQueryStr(ResponseStr, ListBoxIndex);

    ResponseStr := FidHTTP.Get(RequestStr);
    if Length(ResponseStr) = 0 then
    begin
      result := 'Error';
      raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
    end;

    //check if response is map result
    if pos(ipnXMLData, ResponseStr) = 1 then
    begin
      //parse the result XML and get the map
      //the response has two parts: XML Data and Jpeg Image, the tags indicate the dividers
      XMLDataStartPos := Pos(ipnXMLData, ResponseStr) + Length(ipnXMLData) + 1;
      XMLStr := Copy(ResponseStr, XMLDataStartPos, Pos(ipnMapData, ResponseStr) - XMLDataStartPos - 1);
      try
        ParseTheXML(XMLStr);    //extract the xml values
        result := 'Single';
      except
        begin
          result := 'Error';
          raise Exception.Create('There is a problem geo-coding the address. The results may be invalid. Please recheck the address.');
        end;
      end;

      //find the start of the Image Data and delete everything before it
      Delete(ResponseStr, 1, Pos(ipnMapData, ResponseStr) + Length(ipnMapData));

      if length(ResponseStr) > 0 then   //extract the image
      begin
        FloodMap.WriteBuffer(ResponseStr[1], Length(ResponseStr));
        FloodMap.Position := 0;
        if not FinalizeFloodMap() then
        begin
          result := 'Error';
          raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
        end else result := 'Single';
      end
      else
      begin
        result := 'Error';
        raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
      end;
    end
    else
    begin
      result := 'Error';
      raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
    end;
  finally
    FIdHTTP.Free;
  end;
end;

function TFloodInsightClient.GetCFAW_MapEx(ListBoxIndex: Integer): String;
{var
  XMLStr: String;
  RequestStr: string;
  XMLDataStartPos : Integer;
  FIdHTTP : TidHTTP;}
begin
  Result := '';
end;

function TFloodInsightClient.GetCFDB_SpottedMap(RequestStr: string): String;
var
  XMLStr: String;
  XMLDataStartPos : Integer;
  FIdHTTP : TidHTTP;
begin
  Result := '';
  if Length(RequestStr) = 0 then
    begin
      result := 'Error';
      raise Exception.Create('The re-spotting information was not saved with this report or it has been expired.');
    end;

  FIdHTTP := TIdHTTP.Create(self);
  try
    // The base location of the ISAPI dll on the IIS server.

    RequestStr := ISAPIURL + 'GetSpottedMap?' + RequestStr + '&CustomerId=' + URLEncode(AccountID)
    + '&CustomerPin=' + URLEncode(Pin);

    ResponseStr := FidHTTP.Get(RequestStr);   //do the work

    if Length(ResponseStr) = 0 then
      begin
        result := 'Error';
        raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
      end;

    if POS('Error', ResponseStr) > 0 then
      begin
        result := 'Error';
        raise Exception.Create('The subject cannot be repositioned. The original flood map and session expired. Please redo the flood certification.');
      end;

    //check if response is map result
    if pos(ipnXMLData, ResponseStr) = 1 then
      begin
        //parse the result XML and get the map
        //the response has two parts: XML Data and Jpeg Image, the tags indicate the dividers
        XMLDataStartPos := Pos(ipnXMLData, ResponseStr) + Length(ipnXMLData) + 1;
        XMLStr := Copy(ResponseStr, XMLDataStartPos, Pos(ipnMapData, ResponseStr) - XMLDataStartPos - 1);
        try
          ParseTheXML(XMLStr);    //extract the xml values
          result := 'Single';
        except
          begin
            result := 'Error';
            raise Exception.Create('There is a problem geo-coding the address. The results may be invalid. Please recheck the address.');
          end;
        end;

        //find the start of the Image Data and delete everything before it
        Delete(ResponseStr, 1, Pos(ipnMapData, ResponseStr) + Length(ipnMapData));

        if length(ResponseStr) > 0 then   //extract the image
          begin
            FloodMap.WriteBuffer(ResponseStr[1], Length(ResponseStr));
            FloodMap.Position := 0;
            if not FinalizeFloodMap() then
            begin
              result := 'Error';
              raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
            end else result := 'Single';
          end
        else
          begin
            result := 'Error';
            raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
          end;
      end
    else
      begin
        result := 'Error';
        raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
      end;
  finally
    FIdHTTP.Free;
  end;
end;

function TFloodInsightClient.GetCFAW_SpottedMap(RequestStr: string): String;
{var
  XMLStr: String;
  XMLDataStartPos : Integer;
  FIdHTTP : TidHTTP;}
begin
  Result := '';
  {if Length(RequestStr) = 0 then
    begin
      result := 'Error';
      raise Exception.Create('The re-spotting information was not saved with this report or it has been expired.');
    end;

  FIdHTTP := TIdHTTP.Create(self);
  try
    // The base location of the ISAPI dll on the IIS server.

    RequestStr := ISAPIURL + 'GetSpottedMap?' + RequestStr + '&CustomerId=' + URLEncode(AccountID)
    + '&CustomerPin=' + URLEncode(Pin);

    ResponseStr := FidHTTP.Get(RequestStr);   //do the work

    if Length(ResponseStr) = 0 then
      begin
        result := 'Error';
        raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
      end;

    if POS('Error', ResponseStr) > 0 then
      begin
        result := 'Error';
        raise Exception.Create('The subject cannot be repositioned. The original flood map and session expired. Please redo the flood certification.');
      end;

    //check if response is map result
    if pos(ipnXMLData, ResponseStr) = 1 then
      begin
        //parse the result XML and get the map
        //the response has two parts: XML Data and Jpeg Image, the tags indicate the dividers
        XMLDataStartPos := Pos(ipnXMLData, ResponseStr) + Length(ipnXMLData) + 1;
        XMLStr := Copy(ResponseStr, XMLDataStartPos, Pos(ipnMapData, ResponseStr) - XMLDataStartPos - 1);

        try
          ParseTheXML(XMLStr);    //extract the xml values
          result := 'Single';
        except
          begin
            result := 'Error';
            raise Exception.Create('There is a problem geo-coding the address. The results may be invalid. Please recheck the address.');
          end;
        end;

        //find the start of the Image Data and delete everything before it
        Delete(ResponseStr, 1, Pos(ipnMapData, ResponseStr) + Length(ipnMapData));

        if length(ResponseStr) > 0 then   //extract the image
          begin
            FloodMap.WriteBuffer(ResponseStr[1], Length(ResponseStr));
            FloodMap.Position := 0;
            if not FinalizeFloodMap() then
            begin
              result := 'Error';
              raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
            end else result := 'Single';
          end
        else
          begin
            result := 'Error';
            raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
          end;
      end
    else
      begin
        result := 'Error';
        raise Exception.Create('The flood map was not received. Please check that the correct address was given.');
      end;
  finally
    FIdHTTP.Free;
  end;}
end;

function TFloodInsightClient.BuildMapQueryStr(XMLStr: String; ListBoxIndex: Integer): String;
var
  XMLDOM: IXMLDocument;
  CdGeoResultsNode: IXMLNode;
  CdCandidatesNode: IXMLNode;
  CdCandidateNode: IXMLNode;
  //local variables to hold the values of Candidate Nodes
  lvtxtStreet, lvtxtCity, lvtxtState, lvtxtZip, lvtxtPlus4, lvtxtLon,
  lvtxtLat, lvtxtGeoResult, lvtxtFirm, lvtxtCensusId, lvtxtPrecision: String;
  RequestStr: String;
begin
  XMLDOM := LoadXMLData(XMLStr);
  if not XMLDOM.IsEmptyDoc then
  begin
    //read the top most CdGeoResults node
    CdGeoResultsNode := XMLDOM.ChildNodes.FindNode('CdGeoResults');
    if CdGeoResultsNode <> nil then
    begin
      //read CdCandidates
      CdCandidatesNode := CdGeoResultsNode.ChildNodes.FindNode('CdCandidates');
      if CdCandidatesNode <> nil then
      begin
        //read CdCandidates for specified node
        CdCandidateNode := CdCandidatesNode.ChildNodes[ListBoxIndex];

        lvtxtStreet     := CdCandidateNode.ChildNodes['txtStreet'].Text;
        lvtxtCity       := CdCandidateNode.ChildNodes['txtCity'].Text;
        lvtxtState      := CdCandidateNode.ChildNodes['txtState'].Text;
        lvtxtZip        := CdCandidateNode.ChildNodes['txtZip'].Text;
        lvtxtPlus4      := CdCandidateNode.ChildNodes['txtPlus4'].Text;
        lvtxtLon        := CdCandidateNode.ChildNodes['txtLon'].Text;
        lvtxtLat        := CdCandidateNode.ChildNodes['txtLat'].Text;
        lvtxtGeoResult  := CdCandidateNode.ChildNodes['txtGeoResult'].Text;
        lvtxtFirm       := CdCandidateNode.ChildNodes['txtFirm'].Text;
        lvtxtCensusId   := CdCandidateNode.ChildNodes['txtCensusBlockId'].Text;
        lvtxtPrecision  := CdCandidateNode.ChildNodes['txtPrecision'].Text;

        //build and return the RequestStr
        RequestStr :=
          ipnAccountID      + '=' + URLEncode(AccountID) + '&' +
          ipnPin            + '=' + URLEncode(Pin)                    + '&' +
          ipnMapWidth       + '=' + URLEncode(IntToStr(MapWidth))     + '&' +
          ipnMapHeight      + '=' + URLEncode(IntToStr(MapHeight))    + '&' +
          ipnZoom           + '=' + URLEncode(SubjectZoom)            + '&' +
          ipnIconLabel      + '=' + URLEncode(SubjectLabel)           + '&' +
          ipnStreetAddress  + '=' + URLEncode(lvtxtStreet)            + '&' +
          ipnCity           + '=' + URLEncode(lvtxtCity)              + '&' +
          ipnState          + '=' + URLEncode(lvtxtState)             + '&' +
          ipnZip            + '=' + URLEncode(lvtxtZip)               + '&' +
          ipnPlus4          + '=' + URLEncode(lvtxtPlus4)             + '&' +
          ipnLon            + '=' + URLEncode(lvtxtLon)               + '&' +
          ipnLat            + '=' + URLEncode(lvtxtLat)               + '&' +
          ipnGeoResult      + '=' + URLEncode(lvtxtGeoResult)         + '&' +
          ipnCensusBlockID  + '=' + URLEncode(lvtxtCensusId);

        Result := RequestStr;
      end else result := 'Error';
    end else result := 'Error';
  end else result := 'Error';
end;

procedure TFloodInsightClient.SetPanelDate(const Value: String);
var
  yr,mo,dy: String;
begin
  FPanelDate := Value;
  if length(Value) = 8 then
    begin
      yr := copy(Value, 1, 4);
      mo := copy(Value, 5, 2);
      dy := copy(Value, 7, 2);
      FPanelDate := mo+'/'+dy+'/'+yr;
    end;
end;

procedure TFloodInsightClient.ParseTheXML(XMLStr: String);
var
  errText, s: String;
  p: integer;
  XMLDOM : IXMLDocument;
  ResultNode, LocNode, TestNode, FloodNode,
  FloodResultNode,FloodFeatureNode, MapNode: IXMLNode;
begin
  XMLDOM := LoadXMLData(XMLStr);
  //XMLDOM.SaveToFile('C:\Projects\FloodMap.XML');
  if not XMLDOM.IsEmptyDoc then
    try
      //start loading in the result values into property holders
      ResultNode        := XMLDom.ChildNodes.FindNode('CdRmResult');
      LocNode           := ResultNode.ChildNodes.FindNode('Location');

      MapNode           := ResultNode.ChildNodes.FindNode('Map');

      if assigned(MapNode) then
      begin
        SubjectImageID  := MapNode.ChildNodes['ImageID'].Text;
        SubjectZoom     := MapNode.ChildNodes['Zoom'].Text;
        SubjectZip      := LocNode.ChildNodes['Zip'].Text;
        SubjectPlus4    := LocNode.ChildNodes['Plus4'].Text;

        s := MapNode.ChildNodes['ImageURL'].Text;
        p := POS('/',s);

        SubjectImageURL := Copy(s,0,p-1);
      end;
      //for geocoding accuracy
      GeoResult         := LocNode.ChildNodes['GeocodeResult'].Text;

      //Location info
      ZipPlus4          := SubjectZip + '-' + LocNode.ChildNodes['Plus4'].Text;
      CensusTract       := LocNode.ChildNodes['CensusBlock'].Text;
      Longitude         := LocNode.ChildNodes['Longitude'].Text;
      Latitude          := LocNode.ChildNodes['Latitude'].Text;

      TestNode          := ResultNode.ChildNodes.FindNode('Tests');
      FloodNode         := TestNode.ChildNodes.FindNode('Flood');
      FloodResultNode   := FloodNode.ChildNodes.FindNode('Result');

      //Flood Test Results
      MapNumber         := FloodResultNode.ChildNodes['MapNumber'].Text;
      SHFAResult        := FloodResultNode.ChildNodes['SFHA'].Text;
      SHFANearBy        := FloodResultNode.ChildNodes['Nearby'].Text;
//      if Uppercase(SHFANearBy) = 'YES' then
//        SFHAPhrase       := FloodResultNode.ChildNodes['FzDdPhrase'].Text
//      else if Uppercase(SHFANearBy) = 'NO' then
//        SFHAPhrase       := 'Not within 250 feet'
//      else
//        SFHAPhrase       := 'Unknown';
       if POS('IN', Uppercase(SHFAResult)) > 0 then
         SFHAPhrase  := 'Within 250 feet'
       else if POS('OUT', Uppercase(SHFAResult)) > 0 then
         SFHAPhrase := 'Not within 250 feet'
       else
         SFHAPhrase := 'Unknown';



      //Flood Test Features
      FloodFeatureNode  := FloodNode.ChildNodes.FindNode('Features');
      FloodFeatureNode  := FloodFeatureNode.ChildNodes.FindNode('Feature1');

      CommunityID       := FloodFeatureNode.ChildNodes['Community'].Text;
      CommunityName     := FloodFeatureNode.ChildNodes['Community_Name'].Text;
      Zone              := FloodFeatureNode.ChildNodes['Zone'].Text;
      Panel             := FloodFeatureNode.ChildNodes['Panel'].Text;
      PanelDate         := FloodFeatureNode.ChildNodes['Panel_Dte'].Text;
      FIPSCode          := FloodFeatureNode.ChildNodes['FIPS'].Text;

      //----------------------------------------------------------------------------------------------------
      // This is a bit of a hack, but the panel and community numbers are concatenated in the floodmap dll, which
      // is incorrect when the community is a county or unincorporated area.  After talking with Yakov I was afraid
      // to change the behavior in the dll.  When the dll is corrected this can be removed.  The offending function
      // in UFloodMap is :
      //     procedure SpecialHackfor240_CombineCommunityAndPanel(ResultNode: IXMLNode);  Todd
      //----------------------------------------------------------------------------------------------------
      if ((Pos('CITY OF', UpperCase(CommunityName)) = 0) and
          (Pos('TOWN OF', UpperCase(CommunityName)) = 0)) then
      begin
        Panel := AnsiReplaceStr(Panel, CommunityID, FIPSCode + 'C');
      end;

    except
      if assigned(FloodNode) then
        begin
          errText := FloodNode.ChildNodes['CdErrors'].text;
          raise Exception.create(errText);
        end
      else
        raise;
    end;
end;

function TFloodInsightClient.FinalizeFloodMap(): Boolean;
var
  LegendImage, MapImage, TempImage: TJPEGImage;
  TempDisplayImage: TImage;
  x,y,z: integer;
  sLegendPath, vSFHA, v250, vComm, vCommName, vZone, vPanel, vPanelDt, vFIPS, vCensus: String;
  hasLegend: Boolean;
begin
  Result := True;
(*    Ticket #1265: no longer need to fill in the legend
  sLegendPath := IncludeTrailingPathDelimiter(appPref_DirMapping) + 'FloodInsights\' + FloodMapLegendJPG;
  hasLegend := FileExists(sLegendPath);

  //create the jpg image instances
  LegendImage       := TJPEGImage.create;
  TempImage         := TJPEGImage.create;
  TempDisplayImage  := TImage.Create(Self);
  MapImage          := TJPEGImage.create;
  try
   try
    FloodMap.Position := 0;
    MapImage.LoadFromStream(FloodMap);    //load into jpeg handler

    TempDisplayImage.Height   := 807;
    TempDisplayImage.Width    := 532;
    TempDisplayImage.Visible  := False;

    vSFHA      := SHFAResult;
    v250       := SHFANearBy;     //WAS SFHAPhrase;
    vComm      := CommunityID;
    vCommName  := CommunityName;
    vZone      := Zone;
    vPanel     := Panel;
    vPanelDt   := PanelDate;
    vFIPS      := FIPSCode;
    vCensus    := CensusTract;

    //legend image
    if hasLegend then
      LegendImage.LoadFromFile(sLegendPath)
    else
      ShowNotice('The legend for the map was not found. The map will be created anyway.');

    //draws both of these images on the cavas
    TempDisplayImage.Canvas.Draw(0,0,MapImage);
    TempDisplayImage.Canvas.Draw(7,640,LegendImage);

    //draws the bottm white box
    TempDisplayImage.Canvas.Brush.Color := clwhite;
    TempDisplayImage.Canvas.FillRect(Rect(222,600,600,807));

    //draws the title backgroud
    TempDisplayImage.Canvas.Brush.Color := clgray;
    TempDisplayImage.Canvas.FillRect(Rect(0,604,532,620));

    //draws the titles
    TempDisplayImage.Canvas.Font.Color := clWhite;
    TempDisplayImage.Canvas.Font.Size := 8;
    TempDisplayImage.Canvas.Font.Name := 'Arial';
    TempDisplayImage.Canvas.Font.Style := [fsBold];
    TempDisplayImage.Canvas.TextOut(5,606,'Flood Map Legends');
    TempDisplayImage.Canvas.TextOut(208,606,'Flood Zone Determination');

    //draws the vertile lines for border and divider of bottom box
    TempDisplayImage.Canvas.Brush.Color := clblack;

    //verticle line Left
    TempDisplayImage.Canvas.FillRect(Rect(0,620,1,807));
    //verticle line middle
//    TempDisplayImage.Canvas.FillRect(Rect(202,620,203,807));
    TempDisplayImage.Canvas.FillRect(Rect(193,620,194,807));
    //verticle line right
    TempDisplayImage.Canvas.FillRect(Rect(531,620,532,807));

    //draws horizontal lines
    //top line
    TempDisplayImage.Canvas.FillRect(Rect(0,604,540,605));
    //top second line
    TempDisplayImage.Canvas.FillRect(Rect(0,620,540,621));
    //bottom line
    TempDisplayImage.Canvas.FillRect(Rect(0,814,540,815));

    //draws the legend title
    TempDisplayImage.Canvas.Brush.Color := clwhite;
    TempDisplayImage.Canvas.Font.Color := clBlack;
    TempDisplayImage.Canvas.Font.Style := [];
    TempDisplayImage.Canvas.TextOut(7,625,'Flood Zones');

    //draws the legend descriptions
    TempDisplayImage.Canvas.Font.Size := 7;
    TempDisplayImage.Canvas.Font.Style := [fsbold];
    TempDisplayImage.Canvas.Font.Name := 'arial narrow';
    x:=27; //left
    y:=640; //top
    z:=19; // line spacing
    TempDisplayImage.Canvas.TextOut(x,y,'Areas inundated by 500-year flooding'); Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y-4,'Areas outside of the 100 and 500 year flood');

    TempDisplayImage.Canvas.TextOut(x,y+6,'plains'); Inc(y,z);

    TempDisplayImage.Canvas.TextOut(x,y,'Areas inundated by 100-year flooding'); Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y-4,'Areas inundated by 100-year flooding with');

    TempDisplayImage.Canvas.TextOut(x,y+6,'velocity hazard'); Inc(y,z);

    TempDisplayImage.Canvas.TextOut(x,y,'Floodway areas'); Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y-5,'Floodway areas with velocity hazard'); Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y-7,'Areas of undetermined but possible flood');

    TempDisplayImage.Canvas.TextOut(x,y+4,'hazard'); Inc(y,z);

    TempDisplayImage.Canvas.TextOut(x,y-4,'Areas not mapped on any published FIRM');

    //draws the dynamic text specfic to the map image
    TempDisplayImage.Canvas.Font.Size := 8;
    TempDisplayImage.Canvas.Font.Style := [];
    TempDisplayImage.Canvas.Brush.Color := clwhite;
    TempDisplayImage.Canvas.Font.Name := 'tahoma';
    x:=200; //left
    y:=622; //top
    z:=13; // line spacing

    TempDisplayImage.Canvas.TextOut(x,y,'SFHA (Flood Zone): ');
    TempDisplayImage.Canvas.Font.Style := [fsBold];
    TempDisplayImage.Canvas.TextOut(x+100,y,vSFHA);
    Inc(y,z);

    TempDisplayImage.Canvas.Font.Style := [];
    TempDisplayImage.Canvas.TextOut(x,y,'Within 250 ft. of multiple flood zones? ');
    TempDisplayImage.Canvas.Font.Style := [fsBold];
    TempDisplayImage.Canvas.TextOut(x+188,y,v250); Inc(y,z);

    TempDisplayImage.Canvas.Font.Style := [];
    TempDisplayImage.Canvas.TextOut(x,y,'Community: ');
    TempDisplayImage.Canvas.Font.Style := [fsBold];
    TempDisplayImage.Canvas.TextOut(x+63,y,vComm); Inc(y,z);

    TempDisplayImage.Canvas.Font.Style := [];
    TempDisplayImage.Canvas.TextOut(x,y,'Community Name: ');
    TempDisplayImage.Canvas.Font.Style := [fsBold];
    TempDisplayImage.Canvas.TextOut(x+95,y,vCommName); Inc(y,z);

    TempDisplayImage.Canvas.Font.Style := [];
    TempDisplayImage.Canvas.TextOut(x,y,'Zone: ');
    Inc(x,30);
    TempDisplayImage.Canvas.Font.Style := [fsBold];
    TempDisplayImage.Canvas.TextOut(x,y,vZone);
    Inc(x,20);

    TempDisplayImage.Canvas.Font.Style := [];
    TempDisplayImage.Canvas.TextOut(x,y,' Panel: ');
    Inc(x,35);
    TempDisplayImage.Canvas.Font.Style := [fsBold];
    TempDisplayImage.Canvas.TextOut(x,y,vPanel);
    Inc(x,100);

    TempDisplayImage.Canvas.Font.Style := [];
    TempDisplayImage.Canvas.TextOut(x,y,' Panel Date: ');
    Inc(x,63);
    TempDisplayImage.Canvas.Font.Style := [fsBold];
    TempDisplayImage.Canvas.TextOut(x,y,vPanelDt); Inc(y,z);

    x:=208;
    TempDisplayImage.Canvas.Font.Style := [];
    TempDisplayImage.Canvas.TextOut(x,y,'FIPS Code: ');
    Inc(x,57);
    TempDisplayImage.Canvas.Font.Style := [fsBold];
    TempDisplayImage.Canvas.TextOut(x,y,vFIPS);
    Inc(x,45);

    TempDisplayImage.Canvas.Font.Style := [];
    TempDisplayImage.Canvas.TextOut(x,y,'  Census Tract: ');
    Inc(x,77);
    TempDisplayImage.Canvas.Font.Style := [fsBold];
    TempDisplayImage.Canvas.TextOut(x,y,vCensus);

    //draws the disclaimer
    TempDisplayImage.Canvas.Font.Size := 7;
    TempDisplayImage.Canvas.Font.Style := [];
    TempDisplayImage.Canvas.Font.Name := 'tahoma';

    x:=200; //left
    y:=711; //top
    z:=9; // line spacing

    TempDisplayImage.Canvas.TextOut(x,y,'This Report is for the sole benefit of the Customer that ordered and paid for the'); Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y,'Report and is based on the property information provided by that Customer.' ); Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y,'That Customer''s use of this Report is subject to the terms agreed to by that'); Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y,'Customer when accessing this product. No third party is authorized to use or');  Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y,'rely on this Report for any purpose. THE SELLER OF THIS REPORT MAKES'); Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y,'NO REPRESENTATIONS OR WARRANTIES TO ANY PARTY'); Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y,'CONCERNING THE CONTENT,ACCURACY OR COMPLETENESS OF');  Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y,'THIS REPORT INCLUDING ANY WARRANTY OF MERCHANTABILITY OR'); Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y,'FITNESS FOR A PARTICULAR PURPOSE. The seller of this Report shall'); Inc(y,z);
    TempDisplayImage.Canvas.TextOut(x,y,'not have any liability to any third party for any use or misuse of this Report.'); Inc(y,z);

    //save the final image in jpg format now for compression
    TempImage.Assign(TempDisplayImage.Picture.Graphic);
    TempImage.CompressionQuality := 100;
    TempImage.Compress;

    //save the flood map with legends and text back to the memory stream
    FloodMap.Clear;
    TempImage.SaveToStream(FloodMap);
    FloodMap.Position := 0;
   except
     on E: Exception do result := False;
   end
  finally
    LegendImage.Free;
    TempImage.Free;
    MapImage.Free;
    TempDisplayImage.Free;
  end;
*)
end;


end.


