// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme/secure/ws/awsi/PartnerBuildFaxReportServer.php?wsdl
//  >Import : http://carme/secure/ws/awsi/PartnerBuildFaxReportServer.php?wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (08/12/2011 3:28:19 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit PartnerBuildFaxReportServer;

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
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  clsResults           = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsGetReportResponse = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsGetReportData     = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsUserCredentials   = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsSearchAddress     = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }



  // ************************************************************************ //
  // XML       : clsResults, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
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
  // XML       : clsGetReportResponse, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetReportResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetReportData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults        read FResults write FResults;
    property ResponseData: clsGetReportData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetReportData, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetReportData = class(TRemotable)
  private
    FBuildFaxReport: WideString;
    FData: WideString;
    FBadAddresses: WideString;
  published
    property BuildFaxReport: WideString  read FBuildFaxReport write FBuildFaxReport;
    property Data:           WideString  read FData write FData;
    property BadAddresses:   WideString  read FBadAddresses write FBadAddresses;
  end;



  // ************************************************************************ //
  // XML       : clsUserCredentials, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsUserCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
    FOrderNumberKey: WideString;
    FOrderNumberKey_Specified: boolean;
    FPurchase: Integer;
    FPurchase_Specified: boolean;
    FCustomerOrderNumber: WideString;
    procedure SetOrderNumberKey(Index: Integer; const AWideString: WideString);
    function  OrderNumberKey_Specified(Index: Integer): boolean;
    procedure SetPurchase(Index: Integer; const AInteger: Integer);
    function  Purchase_Specified(Index: Integer): boolean;
  published
    property Username:            WideString  read FUsername write FUsername;
    property Password:            WideString  read FPassword write FPassword;
    property OrderNumberKey:      WideString  Index (IS_OPTN) read FOrderNumberKey write SetOrderNumberKey stored OrderNumberKey_Specified;
    property Purchase:            Integer     Index (IS_OPTN) read FPurchase write SetPurchase stored Purchase_Specified;
    property CustomerOrderNumber: WideString  read FCustomerOrderNumber write FCustomerOrderNumber;
  end;



  // ************************************************************************ //
  // XML       : clsSearchAddress, global, <complexType>
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
    property StreetAddress: WideString  read FStreetAddress write FStreetAddress;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  read FState write FState;
    property Zip:           WideString  read FZip write FZip;
    property AddressId:     Integer     read FAddressId write FAddressId;
    property Title:         WideString  read FTitle write FTitle;
  end;

  clsGetReportSearchAddresses = array of clsSearchAddress;   { "http://carme/secure/ws/WSDL"[GblCplx] }

  // ************************************************************************ //
  // Namespace : PartnerBuildFaxReportServerClass
  // soapAction: PartnerBuildFaxReportServerClass#PartnerBuildFaxReportService.GetReport
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : PartnerBuildFaxReportServerBinding
  // service   : PartnerBuildFaxReportServer
  // port      : PartnerBuildFaxReportServerPort
  // URL       : http://carme/secure/ws/awsi/PartnerBuildFaxReportServer.php
  // ************************************************************************ //
  PartnerBuildFaxReportServerPortType = interface(IInvokable)
  ['{A4F756D0-771D-B224-394B-4A9D3C960FD1}']
    function  PartnerBuildFaxReportService_GetReport(const UserCredentials: clsUserCredentials; const SearchAddresses: clsGetReportSearchAddresses): clsGetReportResponse; stdcall;
  end;

function GetPartnerBuildFaxReportServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): PartnerBuildFaxReportServerPortType;


implementation
  uses SysUtils;

function GetPartnerBuildFaxReportServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): PartnerBuildFaxReportServerPortType;
const
  defWSDL = 'http://carme/secure/ws/awsi/PartnerBuildFaxReportServer.php?wsdl';
  defURL  = 'http://carme/secure/ws/awsi/PartnerBuildFaxReportServer.php';
  defSvc  = 'PartnerBuildFaxReportServer';
  defPrt  = 'PartnerBuildFaxReportServerPort';
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
    Result := (RIO as PartnerBuildFaxReportServerPortType);
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


destructor clsGetReportResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

procedure clsUserCredentials.SetOrderNumberKey(Index: Integer; const AWideString: WideString);
begin
  FOrderNumberKey := AWideString;
  FOrderNumberKey_Specified := True;
end;

function clsUserCredentials.OrderNumberKey_Specified(Index: Integer): boolean;
begin
  Result := FOrderNumberKey_Specified;
end;

procedure clsUserCredentials.SetPurchase(Index: Integer; const AInteger: Integer);
begin
  FPurchase := AInteger;
  FPurchase_Specified := True;
end;

function clsUserCredentials.Purchase_Specified(Index: Integer): boolean;
begin
  Result := FPurchase_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(PartnerBuildFaxReportServerPortType), 'PartnerBuildFaxReportServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(PartnerBuildFaxReportServerPortType), 'PartnerBuildFaxReportServerClass#PartnerBuildFaxReportService.GetReport');
  InvRegistry.RegisterExternalMethName(TypeInfo(PartnerBuildFaxReportServerPortType), 'PartnerBuildFaxReportService_GetReport', 'PartnerBuildFaxReportService.GetReport');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsGetReportResponse, 'http://carme/secure/ws/WSDL', 'clsGetReportResponse');
  RemClassRegistry.RegisterXSClass(clsGetReportData, 'http://carme/secure/ws/WSDL', 'clsGetReportData');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://carme/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsSearchAddress, 'http://carme/secure/ws/WSDL', 'clsSearchAddress');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsGetReportSearchAddresses), 'http://carme/secure/ws/WSDL', 'clsGetReportSearchAddresses');

end.