// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme/secure/ws/awsi/BuildFaxReportServer.php?wsdl
// Encoding : ISO-8859-1
// Version  : 1.0
// (9/5/2013 2:33:18 PM - 1.33.2.5)
// ************************************************************************ //

unit AWSI_Server_BuildFax;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:string          - "http://www.w3.org/2001/XMLSchema"

  clsResults           = class;                 { "http://carme/secure/ws/WSDL" }
  clsAcknowledgementResponseData = class;       { "http://carme/secure/ws/WSDL" }
  clsAcknowledgementResponse = class;           { "http://carme/secure/ws/WSDL" }
  clsBatchAddressesData = class;                { "http://carme/secure/ws/WSDL" }
  clsGetBatchAddressesResponse = class;         { "http://carme/secure/ws/WSDL" }
  clsUserCredentials   = class;                 { "http://carme/secure/ws/WSDL" }
  clsAcknowledgement   = class;                 { "http://carme/secure/ws/WSDL" }
  clsSearchAddress     = class;                 { "http://carme/secure/ws/WSDL" }



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsResults = class(TRemotable)
  private
    FCode: Integer;
    FType_: WideString;
    FDescription: WideString;
  published
    property Code: Integer read FCode write FCode;
    property Type_: WideString read FType_ write FType_;
    property Description: WideString read FDescription write FDescription;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponseData = class(TRemotable)
  private
    FReceived: Integer;
  published
    property Received: Integer read FReceived write FReceived;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsAcknowledgementResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsAcknowledgementResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsBatchAddressesData = class(TRemotable)
  private
    FBuildFaxReport: WideString;
    FData: WideString;
    FBadAddresses: WideString;
    FServiceAcknowledgement: WideString;
  published
    property BuildFaxReport: WideString read FBuildFaxReport write FBuildFaxReport;
    property Data: WideString read FData write FData;
    property BadAddresses: WideString read FBadAddresses write FBadAddresses;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetBatchAddressesResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsBatchAddressesData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsBatchAddressesData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsUserCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
    FCompanyKey: WideString;
    FOrderNumberKey: WideString;
    FPurchase: Integer;
    FCustomerOrderNumber: WideString;
  published
    property Username: WideString read FUsername write FUsername;
    property Password: WideString read FPassword write FPassword;
    property CompanyKey: WideString read FCompanyKey write FCompanyKey;
    property OrderNumberKey: WideString read FOrderNumberKey write FOrderNumberKey;
    property Purchase: Integer read FPurchase write FPurchase;
    property CustomerOrderNumber: WideString read FCustomerOrderNumber write FCustomerOrderNumber;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgement = class(TRemotable)
  private
    FReceived: Integer;
    FServiceAcknowledgement: WideString;
  published
    property Received: Integer read FReceived write FReceived;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsSearchAddress = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FAddressId: Integer;
    FTitle: WideString;
  published
    property StreetAddress: WideString read FStreetAddress write FStreetAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property AddressId: Integer read FAddressId write FAddressId;
    property Title: WideString read FTitle write FTitle;
  end;

  clsSubmitBatchAddressesRequest = array of clsSearchAddress;   { "http://carme/secure/ws/WSDL" }

  // ************************************************************************ //
  // Namespace : BuildFaxReportServerClass
  // soapAction: BuildFaxReportServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : BuildFaxReportServerBinding
  // service   : BuildFaxReportServer
  // port      : BuildFaxReportServerPort
  // URL       : http://carme/secure/ws/awsi/BuildFaxReportServer.php
  // ************************************************************************ //
  BuildFaxReportServerPortType = interface(IInvokable)
  ['{3B1FABBF-4FC1-D5BB-6C8D-BAE19EA5C675}']
    function  BuildFaxReportService_Acknowledgement(const UserCredentials: clsUserCredentials; const Acknowledgement: clsAcknowledgement): clsAcknowledgementResponse; stdcall;
    function  BuildFaxReportService_GetReport(const UserCredentials: clsUserCredentials; const SearchAddresses: clsSubmitBatchAddressesRequest): clsGetBatchAddressesResponse; stdcall;
  end;

function GetBuildFaxReportServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): BuildFaxReportServerPortType;


implementation

function GetBuildFaxReportServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): BuildFaxReportServerPortType;
const
  defWSDL = 'http://carme/secure/ws/awsi/BuildFaxReportServer.php?wsdl';
  defURL  = 'http://carme/secure/ws/awsi/BuildFaxReportServer.php';
  defSvc  = 'BuildFaxReportServer';
  defPrt  = 'BuildFaxReportServerPort';
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
    Result := (RIO as BuildFaxReportServerPortType);
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


destructor clsAcknowledgementResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsGetBatchAddressesResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(BuildFaxReportServerPortType), 'BuildFaxReportServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(BuildFaxReportServerPortType), 'BuildFaxReportServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(BuildFaxReportServerPortType), 'BuildFaxReportService_Acknowledgement', 'BuildFaxReportService.Acknowledgement');
  InvRegistry.RegisterExternalMethName(TypeInfo(BuildFaxReportServerPortType), 'BuildFaxReportService_GetReport', 'BuildFaxReportService.GetReport');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponseData, 'http://carme/secure/ws/WSDL', 'clsAcknowledgementResponseData');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponse, 'http://carme/secure/ws/WSDL', 'clsAcknowledgementResponse');
  RemClassRegistry.RegisterXSClass(clsBatchAddressesData, 'http://carme/secure/ws/WSDL', 'clsBatchAddressesData');
  RemClassRegistry.RegisterXSClass(clsGetBatchAddressesResponse, 'http://carme/secure/ws/WSDL', 'clsGetBatchAddressesResponse');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://carme/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsAcknowledgement, 'http://carme/secure/ws/WSDL', 'clsAcknowledgement');
  RemClassRegistry.RegisterXSClass(clsSearchAddress, 'http://carme/secure/ws/WSDL', 'clsSearchAddress');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsSubmitBatchAddressesRequest), 'http://carme/secure/ws/WSDL', 'clsSubmitBatchAddressesRequest');

end.