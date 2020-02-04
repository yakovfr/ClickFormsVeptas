// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme/secure/ws/awsi/TechSupportServer.php?wsdl
//  >Import : http://carme/secure/ws/awsi/TechSupportServer.php?wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (2/26/2013 8:34:21 AM - - $Rev: 10138 $)
// ************************************************************************ //

unit AWSI_Server_TechSupport;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns,UWebConfig;

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

  clsUserCredentials   = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsResults           = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsSecondaryArrayItem = class;                { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsGetTopTenLists    = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsGetTopTenListsResponse = class;            { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsSendEventResponse = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsGetTopTenDetails  = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsSendEventDetails  = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }



  // ************************************************************************ //
  // XML       : clsUserCredentials, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsUserCredentials = class(TRemotable)
  private
    Fusername: WideString;
    Fpassword: WideString;
    Fsecurity_code: WideString;
  published
    property username:      WideString  read Fusername write Fusername;
    property password:      WideString  read Fpassword write Fpassword;
    property security_code: WideString  read Fsecurity_code write Fsecurity_code;
  end;



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

  clsArrayOfStrings = array of WideString;      { "http://carme/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsSecondaryArrayItem, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsSecondaryArrayItem = class(TRemotable)
  private
    Ftopten_key: WideString;
    Fsecondary_list: clsArrayOfStrings;
  published
    property topten_key:     WideString         read Ftopten_key write Ftopten_key;
    property secondary_list: clsArrayOfStrings  read Fsecondary_list write Fsecondary_list;
  end;

  clsSecondaryArray = array of clsSecondaryArrayItem;   { "http://carme/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsGetTopTenLists, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetTopTenLists = class(TRemotable)
  private
    Ftopten: clsArrayOfStrings;
    Ftopten_Specified: boolean;
    Fsecondary: clsSecondaryArray;
    Fsecondary_Specified: boolean;
    procedure Settopten(Index: Integer; const AclsArrayOfStrings: clsArrayOfStrings);
    function  topten_Specified(Index: Integer): boolean;
    procedure Setsecondary(Index: Integer; const AclsSecondaryArray: clsSecondaryArray);
    function  secondary_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property topten:    clsArrayOfStrings  Index (IS_OPTN) read Ftopten write Settopten stored topten_Specified;
    property secondary: clsSecondaryArray  Index (IS_OPTN) read Fsecondary write Setsecondary stored secondary_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsGetTopTenListsResponse, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetTopTenListsResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetTopTenLists;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults         read FResults write FResults;
    property ResponseData: clsGetTopTenLists  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsSendEventResponse, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsSendEventResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: WideString;
    FResponseData_Specified: boolean;
    procedure SetResponseData(Index: Integer; const AWideString: WideString);
    function  ResponseData_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults  read FResults write FResults;
    property ResponseData: WideString  Index (IS_OPTN) read FResponseData write SetResponseData stored ResponseData_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsGetTopTenDetails, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetTopTenDetails = class(TRemotable)
  private
    Fsource: WideString;
    Ftitle: WideString;
  published
    property source: WideString  read Fsource write Fsource;
    property title:  WideString  read Ftitle write Ftitle;
  end;



  // ************************************************************************ //
  // XML       : clsSendEventDetails, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsSendEventDetails = class(TRemotable)
  private
    Fsource: WideString;
    Ftitle: WideString;
    Farea: WideString;
    Fblob: WideString;
    Fsubject: WideString;
  published
    property source: WideString  read Fsource write Fsource;
    property title:  WideString  read Ftitle write Ftitle;
    property area:   WideString  read Farea write Farea;
    property blob:   WideString  read Fblob write Fblob;
    property subject: WideString read Fsubject write Fsubject;
  end;


  // ************************************************************************ //
  // Namespace : TechSupportServerClass
  // soapAction: TechSupportServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : TechSupportServerBinding
  // service   : TechSupportServer
  // port      : TechSupportServerPort
  // URL       : http://carme/secure/ws/awsi/TechSupportServer.php
  // ************************************************************************ //
  TechSupportServerPortType = interface(IInvokable)
  ['{3A5A5E6D-80C8-5D86-BA19-55AF1E6616C3}']
    function  TechSupportServices_SendEvent(const UserCredentials: clsUserCredentials; const TechSupportData: clsSendEventDetails): clsSendEventResponse; stdcall;
    function  TechSupportServices_GetTopTenLists(const UserCredentials: clsUserCredentials; const TopTenDetails: clsGetTopTenDetails): clsGetTopTenListsResponse; stdcall;
  end;

function GetTechSupportServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): TechSupportServerPortType;


implementation
  uses SysUtils;

function GetTechSupportServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): TechSupportServerPortType;
const
  defSvc  = 'TechSupportServer';
  defPrt  = 'TechSupportServerPort';
var
  RIO: THTTPRIO;
  defWSDL,defURL: String;
begin
  Result := nil;
// NOTE: For production the live one
  defWSDL := Live_awsi_TechSupport_WSDL;
  defURL  := Live_awsi_TechSupport;
///FOR TESTING
//  defWSDL := Test_awsi_TechSupport_WSDL;
//  defURL  := Test_awsi_TechSupport;
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
    Result := (RIO as TechSupportServerPortType);
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


destructor clsGetTopTenLists.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fsecondary)-1 do
    FreeAndNil(Fsecondary[I]);
  SetLength(Fsecondary, 0);
  inherited Destroy;
end;

procedure clsGetTopTenLists.Settopten(Index: Integer; const AclsArrayOfStrings: clsArrayOfStrings);
begin
  Ftopten := AclsArrayOfStrings;
  Ftopten_Specified := True;
end;

function clsGetTopTenLists.topten_Specified(Index: Integer): boolean;
begin
  Result := Ftopten_Specified;
end;

procedure clsGetTopTenLists.Setsecondary(Index: Integer; const AclsSecondaryArray: clsSecondaryArray);
begin
  Fsecondary := AclsSecondaryArray;
  Fsecondary_Specified := True;
end;

function clsGetTopTenLists.secondary_Specified(Index: Integer): boolean;
begin
  Result := Fsecondary_Specified;
end;

destructor clsGetTopTenListsResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsSendEventResponse.Destroy;
begin
  FreeAndNil(FResults);
  inherited Destroy;
end;

procedure clsSendEventResponse.SetResponseData(Index: Integer; const AWideString: WideString);
begin
  FResponseData := AWideString;
  FResponseData_Specified := True;
end;

function clsSendEventResponse.ResponseData_Specified(Index: Integer): boolean;
begin
  Result := FResponseData_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(TechSupportServerPortType), 'TechSupportServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(TechSupportServerPortType), 'TechSupportServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(TechSupportServerPortType), 'TechSupportServices_SendEvent', 'TechSupportServices.SendEvent');
  InvRegistry.RegisterExternalMethName(TypeInfo(TechSupportServerPortType), 'TechSupportServices_GetTopTenLists', 'TechSupportServices.GetTopTenLists');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://carme/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsArrayOfStrings), 'http://carme/secure/ws/WSDL', 'clsArrayOfStrings');
  RemClassRegistry.RegisterXSClass(clsSecondaryArrayItem, 'http://carme/secure/ws/WSDL', 'clsSecondaryArrayItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsSecondaryArray), 'http://carme/secure/ws/WSDL', 'clsSecondaryArray');
  RemClassRegistry.RegisterXSClass(clsGetTopTenLists, 'http://carme/secure/ws/WSDL', 'clsGetTopTenLists');
  RemClassRegistry.RegisterXSClass(clsGetTopTenListsResponse, 'http://carme/secure/ws/WSDL', 'clsGetTopTenListsResponse');
  RemClassRegistry.RegisterXSClass(clsSendEventResponse, 'http://carme/secure/ws/WSDL', 'clsSendEventResponse');
  RemClassRegistry.RegisterXSClass(clsGetTopTenDetails, 'http://carme/secure/ws/WSDL', 'clsGetTopTenDetails');
  RemClassRegistry.RegisterXSClass(clsSendEventDetails, 'http://carme/secure/ws/WSDL', 'clsSendEventDetails');

end.