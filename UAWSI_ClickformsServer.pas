// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme.atbx.net/secure/ws/awsi/ClickformsServer.php?wsdl
//  >Import : http://carme.atbx.net/secure/ws/awsi/ClickformsServer.php?wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (8/5/2014 1:07:06 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit UAWSI_ClickformsServer;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  clsResults           = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetMembershipLevelResponseData = class;    { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetMembershipLevelResponse = class;        { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetUsageAvailabilityData = class;          { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetUsageAvailabilityResponse = class;      { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetUsageAvailabilityItem = class;          { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetUsageAvailabilitySummaryResponse = class;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGetMembershipLevelAccessCredentials = class;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsUsageAccessCredentials = class;            { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsRequestDetails    = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }



  // ************************************************************************ //
  // XML       : clsResults, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsResults = class(TRemotable)
  private
    FCode: Integer;
    FType_: WideString;
    FDescription: WideString;
  published
    property Code:        Integer     read FCode write FCode;
    property Type_:       WideString  read FType_ write FType_;
    property Description: WideString  read FDescription write FDescription;
  end;



  // ************************************************************************ //
  // XML       : clsGetMembershipLevelResponseData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMembershipLevelResponseData = class(TRemotable)
  private
    FMembershipLevelId: Integer;
    FMembershipLevelName: WideString;
  published
    property MembershipLevelId:   Integer     read FMembershipLevelId write FMembershipLevelId;
    property MembershipLevelName: WideString  read FMembershipLevelName write FMembershipLevelName;
  end;



  // ************************************************************************ //
  // XML       : clsGetMembershipLevelResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMembershipLevelResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetMembershipLevelResponseData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                         read FResults write FResults;
    property ResponseData: clsGetMembershipLevelResponseData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetUsageAvailabilityData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilityData = class(TRemotable)
  private
    FServiceName: WideString;
    FWebServiceId: Integer;
    FProductAvailable: WideString;
    FMessage_: WideString;
    FAppraiserExpirationDate: WideString;
    FAppraiserQuantity: Integer;
    FOwnerExpirationDate: WideString;
    FOwnerExpirationDate_Specified: boolean;
    FOwnerQuantity: Integer;
    FOwnerQuantity_Specified: boolean;
    procedure SetOwnerExpirationDate(Index: Integer; const AWideString: WideString);
    function  OwnerExpirationDate_Specified(Index: Integer): boolean;
    procedure SetOwnerQuantity(Index: Integer; const AInteger: Integer);
    function  OwnerQuantity_Specified(Index: Integer): boolean;
  published
    property ServiceName:             WideString  read FServiceName write FServiceName;
    property WebServiceId:            Integer     read FWebServiceId write FWebServiceId;
    property ProductAvailable:        WideString  read FProductAvailable write FProductAvailable;
    property Message_:                WideString  read FMessage_ write FMessage_;
    property AppraiserExpirationDate: WideString  read FAppraiserExpirationDate write FAppraiserExpirationDate;
    property AppraiserQuantity:       Integer     read FAppraiserQuantity write FAppraiserQuantity;
    property OwnerExpirationDate:     WideString  Index (IS_OPTN) read FOwnerExpirationDate write SetOwnerExpirationDate stored OwnerExpirationDate_Specified;
    property OwnerQuantity:           Integer     Index (IS_OPTN) read FOwnerQuantity write SetOwnerQuantity stored OwnerQuantity_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsGetUsageAvailabilityResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilityResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetUsageAvailabilityData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                   read FResults write FResults;
    property ResponseData: clsGetUsageAvailabilityData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetUsageAvailabilityItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilityItem = class(TRemotable)
  private
    FServiceProvider: Integer;
    FUserID: Integer;
    FServiceID: Integer;
    FUserExpirationType: Integer;
    FUserExpDate: WideString;
    FOwnerExpirationType: Integer;
    FOwnerExpDate: WideString;
    FUserUnitsType: Integer;
    FUserUnitsLeft: WideString;
    FOwnerUnitsType: Integer;
    FOwnerUnitsLeft: WideString;
  published
    property ServiceProvider:     Integer     read FServiceProvider write FServiceProvider;
    property UserID:              Integer     read FUserID write FUserID;
    property ServiceID:           Integer     read FServiceID write FServiceID;
    property UserExpirationType:  Integer     read FUserExpirationType write FUserExpirationType;
    property UserExpDate:         WideString  read FUserExpDate write FUserExpDate;
    property OwnerExpirationType: Integer     read FOwnerExpirationType write FOwnerExpirationType;
    property OwnerExpDate:        WideString  read FOwnerExpDate write FOwnerExpDate;
    property UserUnitsType:       Integer     read FUserUnitsType write FUserUnitsType;
    property UserUnitsLeft:       WideString  read FUserUnitsLeft write FUserUnitsLeft;
    property OwnerUnitsType:      Integer     read FOwnerUnitsType write FOwnerUnitsType;
    property OwnerUnitsLeft:      WideString  read FOwnerUnitsLeft write FOwnerUnitsLeft;
  end;

  clsGetUsageAvailabilitySummaryArray = array of clsGetUsageAvailabilityItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsGetUsageAvailabilitySummaryResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilitySummaryResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetUsageAvailabilitySummaryArray;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                           read FResults write FResults;
    property ResponseData: clsGetUsageAvailabilitySummaryArray  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetMembershipLevelAccessCredentials, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMembershipLevelAccessCredentials = class(TRemotable)
  private
    FCustomerId: Integer;
    FCustomerId_Specified: boolean;
    FServiceId: WideString;
    FAppraiserId: Integer;
    FAppraiserId_Specified: boolean;
    procedure SetCustomerId(Index: Integer; const AInteger: Integer);
    function  CustomerId_Specified(Index: Integer): boolean;
    procedure SetAppraiserId(Index: Integer; const AInteger: Integer);
    function  AppraiserId_Specified(Index: Integer): boolean;
  published
    property CustomerId:  Integer     Index (IS_OPTN) read FCustomerId write SetCustomerId stored CustomerId_Specified;
    property ServiceId:   WideString  read FServiceId write FServiceId;
    property AppraiserId: Integer     Index (IS_OPTN) read FAppraiserId write SetAppraiserId stored AppraiserId_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsUsageAccessCredentials, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsUsageAccessCredentials = class(TRemotable)
  private
    FCustomerId: Integer;
    FCustomerId_Specified: boolean;
    FServiceId: WideString;
    FAppraiserId: Integer;
    FAppraiserId_Specified: boolean;
    procedure SetCustomerId(Index: Integer; const AInteger: Integer);
    function  CustomerId_Specified(Index: Integer): boolean;
    procedure SetAppraiserId(Index: Integer; const AInteger: Integer);
    function  AppraiserId_Specified(Index: Integer): boolean;
  published
    property CustomerId:  Integer     Index (IS_OPTN) read FCustomerId write SetCustomerId stored CustomerId_Specified;
    property ServiceId:   WideString  read FServiceId write FServiceId;
    property AppraiserId: Integer     Index (IS_OPTN) read FAppraiserId write SetAppraiserId stored AppraiserId_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsRequestDetails, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsRequestDetails = class(TRemotable)
  private
    FProductServiceId: Integer;
    FProductServiceId_Specified: boolean;
    procedure SetProductServiceId(Index: Integer; const AInteger: Integer);
    function  ProductServiceId_Specified(Index: Integer): boolean;
  published
    property ProductServiceId: Integer  Index (IS_OPTN) read FProductServiceId write SetProductServiceId stored ProductServiceId_Specified;
  end;


  // ************************************************************************ //
  // Namespace : ClickformsServerClass
  // soapAction: ClickformsServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : ClickformsServerBinding
  // service   : ClickformsServer
  // port      : ClickformsServerPort
  // URL       : http://carme.atbx.net/secure/ws/awsi/ClickformsServer.php
  // ************************************************************************ //
  ClickformsServerPortType = interface(IInvokable)
  ['{88B65299-C76E-C201-99D6-FF7FC665B63C}']
    function  ClickformsServices_GetMembershipLevel(const GetMembershipLevelAccessCredentials: clsGetMembershipLevelAccessCredentials): clsGetMembershipLevelResponse; stdcall;
    function  ClickformsServices_GetUsageAvailability(const UsageAccessCredentials: clsUsageAccessCredentials; const RequestDetails: clsRequestDetails): clsGetUsageAvailabilityResponse; stdcall;
    function  ClickformsServices_GetUsageAvailabilitySummary(const UsageAccessCredentials: clsUsageAccessCredentials): clsGetUsageAvailabilitySummaryResponse; stdcall;
  end;

function GetClickformsServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ClickformsServerPortType;


implementation
  uses SysUtils;

function GetClickformsServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ClickformsServerPortType;
const
  defWSDL = 'http://carme.atbx.net/secure/ws/awsi/ClickformsServer.php?wsdl';
  defURL  = 'http://carme.atbx.net/secure/ws/awsi/ClickformsServer.php';
  defSvc  = 'ClickformsServer';
  defPrt  = 'ClickformsServerPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ClickformsServerPortType);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor clsGetMembershipLevelResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

procedure clsGetUsageAvailabilityData.SetOwnerExpirationDate(Index: Integer; const AWideString: WideString);
begin
  FOwnerExpirationDate := AWideString;
  FOwnerExpirationDate_Specified := True;
end;

function clsGetUsageAvailabilityData.OwnerExpirationDate_Specified(Index: Integer): boolean;
begin
  Result := FOwnerExpirationDate_Specified;
end;

procedure clsGetUsageAvailabilityData.SetOwnerQuantity(Index: Integer; const AInteger: Integer);
begin
  FOwnerQuantity := AInteger;
  FOwnerQuantity_Specified := True;
end;

function clsGetUsageAvailabilityData.OwnerQuantity_Specified(Index: Integer): boolean;
begin
  Result := FOwnerQuantity_Specified;
end;

destructor clsGetUsageAvailabilityResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetUsageAvailabilitySummaryResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FResponseData)-1 do
    FreeAndNil(FResponseData[I]);
  SetLength(FResponseData, 0);
  FreeAndNil(FResults);
  inherited Destroy;
end;

procedure clsGetMembershipLevelAccessCredentials.SetCustomerId(Index: Integer; const AInteger: Integer);
begin
  FCustomerId := AInteger;
  FCustomerId_Specified := True;
end;

function clsGetMembershipLevelAccessCredentials.CustomerId_Specified(Index: Integer): boolean;
begin
  Result := FCustomerId_Specified;
end;

procedure clsGetMembershipLevelAccessCredentials.SetAppraiserId(Index: Integer; const AInteger: Integer);
begin
  FAppraiserId := AInteger;
  FAppraiserId_Specified := True;
end;

function clsGetMembershipLevelAccessCredentials.AppraiserId_Specified(Index: Integer): boolean;
begin
  Result := FAppraiserId_Specified;
end;

procedure clsUsageAccessCredentials.SetCustomerId(Index: Integer; const AInteger: Integer);
begin
  FCustomerId := AInteger;
  FCustomerId_Specified := True;
end;

function clsUsageAccessCredentials.CustomerId_Specified(Index: Integer): boolean;
begin
  Result := FCustomerId_Specified;
end;

procedure clsUsageAccessCredentials.SetAppraiserId(Index: Integer; const AInteger: Integer);
begin
  FAppraiserId := AInteger;
  FAppraiserId_Specified := True;
end;

function clsUsageAccessCredentials.AppraiserId_Specified(Index: Integer): boolean;
begin
  Result := FAppraiserId_Specified;
end;

procedure clsRequestDetails.SetProductServiceId(Index: Integer; const AInteger: Integer);
begin
  FProductServiceId := AInteger;
  FProductServiceId_Specified := True;
end;

function clsRequestDetails.ProductServiceId_Specified(Index: Integer): boolean;
begin
  Result := FProductServiceId_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(ClickformsServerPortType), 'ClickformsServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ClickformsServerPortType), 'ClickformsServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(ClickformsServerPortType), 'ClickformsServices_GetMembershipLevel', 'ClickformsServices.GetMembershipLevel');
  InvRegistry.RegisterExternalMethName(TypeInfo(ClickformsServerPortType), 'ClickformsServices_GetUsageAvailability', 'ClickformsServices.GetUsageAvailability');
  InvRegistry.RegisterExternalMethName(TypeInfo(ClickformsServerPortType), 'ClickformsServices_GetUsageAvailabilitySummary', 'ClickformsServices.GetUsageAvailabilitySummary');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme.atbx.net/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsGetMembershipLevelResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetMembershipLevelResponseData');
  RemClassRegistry.RegisterXSClass(clsGetMembershipLevelResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetMembershipLevelResponse');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilityData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetUsageAvailabilityData');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsGetUsageAvailabilityData), 'Message_', 'Message');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilityResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetUsageAvailabilityResponse');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilityItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetUsageAvailabilityItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsGetUsageAvailabilitySummaryArray), 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetUsageAvailabilitySummaryArray');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilitySummaryResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetUsageAvailabilitySummaryResponse');
  RemClassRegistry.RegisterXSClass(clsGetMembershipLevelAccessCredentials, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetMembershipLevelAccessCredentials');
  RemClassRegistry.RegisterXSClass(clsUsageAccessCredentials, 'http://carme.atbx.net/secure/ws/WSDL', 'clsUsageAccessCredentials');
  RemClassRegistry.RegisterXSClass(clsRequestDetails, 'http://carme.atbx.net/secure/ws/WSDL', 'clsRequestDetails');

end.