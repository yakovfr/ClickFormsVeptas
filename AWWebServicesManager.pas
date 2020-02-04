// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://devlinux1/secure/ws/AWWebServicesManager.php?wsdl
// Encoding : ISO-8859-1
// Version  : 1.0
// (1/18/2008 11:03:31 AM - 1.33.2.5)
// ************************************************************************ //

unit AWWebServicesManager;

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
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"

  ServiceDetailRequest = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  LicenseDetailRequest = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  UserDetailRequest    = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  MyServiceRequest     = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  SFRegisterRequest    = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  SFRegisterResponse   = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  SFLoginResponse      = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  SFLoginRequest       = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  SFAuthenticateRequest = class;                { "http://devlinux1/soap/AppraisalWorldWsdl" }
  SFAuthenticateResponse = class;               { "http://devlinux1/soap/AppraisalWorldWsdl" }
  AuthenticateRequest  = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  AuthenticateResponse = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  UnitsUsedRequest     = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  UnitsUsedResponse    = class;                 { "http://devlinux1/soap/AppraisalWorldWsdl" }
  UnitsPurchasedRequest = class;                { "http://devlinux1/soap/AppraisalWorldWsdl" }
  UnitsPurchasedResponse = class;               { "http://devlinux1/soap/AppraisalWorldWsdl" }



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  ServiceDetailRequest = class(TRemotable)
  private
    Faccess_id: WideString;
    Fuser_detail_id: Integer;
  published
    property access_id: WideString read Faccess_id write Faccess_id;
    property user_detail_id: Integer read Fuser_detail_id write Fuser_detail_id;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  LicenseDetailRequest = class(TRemotable)
  private
    Faccess_id: WideString;
    Fuser_detail_id: Integer;
  published
    property access_id: WideString read Faccess_id write Faccess_id;
    property user_detail_id: Integer read Fuser_detail_id write Fuser_detail_id;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  UserDetailRequest = class(TRemotable)
  private
    Faccess_id: WideString;
    Fcustomer_id: Integer;
    Fuser_detail_id: Integer;
    Ffirst_name: WideString;
    Flast_name: WideString;
    Fcity: WideString;
    Fstate: WideString;
    Fselect_list: WideString;
  published
    property access_id: WideString read Faccess_id write Faccess_id;
    property customer_id: Integer read Fcustomer_id write Fcustomer_id;
    property user_detail_id: Integer read Fuser_detail_id write Fuser_detail_id;
    property first_name: WideString read Ffirst_name write Ffirst_name;
    property last_name: WideString read Flast_name write Flast_name;
    property city: WideString read Fcity write Fcity;
    property state: WideString read Fstate write Fstate;
    property select_list: WideString read Fselect_list write Fselect_list;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  MyServiceRequest = class(TRemotable)
  private
    Faccess_id: WideString;
    Fecho_str: WideString;
  published
    property access_id: WideString read Faccess_id write Faccess_id;
    property echo_str: WideString read Fecho_str write Fecho_str;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  SFRegisterRequest = class(TRemotable)
  private
    Faccess_id: WideString;
    Ffirstname: WideString;
    Flastname: WideString;
    Fcompanyname: WideString;
    Ftax_number: WideString;
    Fb_address: WideString;
    Fb_address_2: WideString;
    Fb_city: WideString;
    Fb_state: WideString;
    Fb_country: WideString;
    Fb_zipcode: WideString;
    Fs_address: WideString;
    Fs_address_2: WideString;
    Fs_city: WideString;
    Fs_state: WideString;
    Fs_country: WideString;
    Fs_zipcode: WideString;
    Fphone: WideString;
    Femail: WideString;
    Ffax: WideString;
    Furl: WideString;
    Fpending_membershipid: Integer;
    Funame: WideString;
    Fpasswd1: WideString;
    Fpasswd2: WideString;
    Fanonymous: WideString;
    Fusertype: WideString;
    Fparam1: WideString;
    Fawsession: Integer;
    Fmode: WideString;
    Fval_1: Integer;
    Fval_2: Integer;
    Fsync: Integer;
  published
    property access_id: WideString read Faccess_id write Faccess_id;
    property firstname: WideString read Ffirstname write Ffirstname;
    property lastname: WideString read Flastname write Flastname;
    property companyname: WideString read Fcompanyname write Fcompanyname;
    property tax_number: WideString read Ftax_number write Ftax_number;
    property b_address: WideString read Fb_address write Fb_address;
    property b_address_2: WideString read Fb_address_2 write Fb_address_2;
    property b_city: WideString read Fb_city write Fb_city;
    property b_state: WideString read Fb_state write Fb_state;
    property b_country: WideString read Fb_country write Fb_country;
    property b_zipcode: WideString read Fb_zipcode write Fb_zipcode;
    property s_address: WideString read Fs_address write Fs_address;
    property s_address_2: WideString read Fs_address_2 write Fs_address_2;
    property s_city: WideString read Fs_city write Fs_city;
    property s_state: WideString read Fs_state write Fs_state;
    property s_country: WideString read Fs_country write Fs_country;
    property s_zipcode: WideString read Fs_zipcode write Fs_zipcode;
    property phone: WideString read Fphone write Fphone;
    property email: WideString read Femail write Femail;
    property fax: WideString read Ffax write Ffax;
    property url: WideString read Furl write Furl;
    property pending_membershipid: Integer read Fpending_membershipid write Fpending_membershipid;
    property uname: WideString read Funame write Funame;
    property passwd1: WideString read Fpasswd1 write Fpasswd1;
    property passwd2: WideString read Fpasswd2 write Fpasswd2;
    property anonymous: WideString read Fanonymous write Fanonymous;
    property usertype: WideString read Fusertype write Fusertype;
    property param1: WideString read Fparam1 write Fparam1;
    property awsession: Integer read Fawsession write Fawsession;
    property mode: WideString read Fmode write Fmode;
    property val_1: Integer read Fval_1 write Fval_1;
    property val_2: Integer read Fval_2 write Fval_2;
    property sync: Integer read Fsync write Fsync;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  SFRegisterResponse = class(TRemotable)
  private
    Fstatus: Integer;
    Fmessages: WideString;
  published
    property status: Integer read Fstatus write Fstatus;
    property messages: WideString read Fmessages write Fmessages;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  SFLoginResponse = class(TRemotable)
  private
    Fstatus: Integer;
    Fdata: WideString;
    Fmessages: WideString;
  published
    property status: Integer read Fstatus write Fstatus;
    property data: WideString read Fdata write Fdata;
    property messages: WideString read Fmessages write Fmessages;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  SFLoginRequest = class(TRemotable)
  private
    Faccess_id: WideString;
    Fcustomerid: WideString;
    Fpage: WideString;
  published
    property access_id: WideString read Faccess_id write Faccess_id;
    property customerid: WideString read Fcustomerid write Fcustomerid;
    property page: WideString read Fpage write Fpage;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  SFAuthenticateRequest = class(TRemotable)
  private
    Faccess_id: WideString;
    Fcustomerid: WideString;
    Ffirstname: WideString;
    Flastname: WideString;
  published
    property access_id: WideString read Faccess_id write Faccess_id;
    property customerid: WideString read Fcustomerid write Fcustomerid;
    property firstname: WideString read Ffirstname write Ffirstname;
    property lastname: WideString read Flastname write Flastname;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  SFAuthenticateResponse = class(TRemotable)
  private
    Fstatus: Integer;
    Floginid: WideString;
    Fpasswd: WideString;
    Fmessage: WideString;
  published
    property status: Integer read Fstatus write Fstatus;
    property loginid: WideString read Floginid write Floginid;
    property passwd: WideString read Fpasswd write Fpasswd;
    property message: WideString read Fmessage write Fmessage;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  AuthenticateRequest = class(TRemotable)
  private
    Faccess_id: WideString;
    Fcustomer_id: Integer;
    Fservice_id: Integer;
  published
    property access_id: WideString read Faccess_id write Faccess_id;
    property customer_id: Integer read Fcustomer_id write Fcustomer_id;
    property service_id: Integer read Fservice_id write Fservice_id;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  AuthenticateResponse = class(TRemotable)
  private
    Fresults: Integer;
    Fmessage: WideString;
  published
    property results: Integer read Fresults write Fresults;
    property message: WideString read Fmessage write Fmessage;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  UnitsUsedRequest = class(TRemotable)
  private
    Faccess_id: WideString;
    Fcustomer_id: Integer;
    Fservice_id: Integer;
    Funits_used: Integer;
  published
    property access_id: WideString read Faccess_id write Faccess_id;
    property customer_id: Integer read Fcustomer_id write Fcustomer_id;
    property service_id: Integer read Fservice_id write Fservice_id;
    property units_used: Integer read Funits_used write Funits_used;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  UnitsUsedResponse = class(TRemotable)
  private
    Fresults: Integer;
    Fmessage: WideString;
  published
    property results: Integer read Fresults write Fresults;
    property message: WideString read Fmessage write Fmessage;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  UnitsPurchasedRequest = class(TRemotable)
  private
    Faccess_id: WideString;
    Fcustomer_id: Integer;
    Fservice_id: Integer;
    Funits_purchased: Integer;
  published
    property access_id: WideString read Faccess_id write Faccess_id;
    property customer_id: Integer read Fcustomer_id write Fcustomer_id;
    property service_id: Integer read Fservice_id write Fservice_id;
    property units_purchased: Integer read Funits_purchased write Funits_purchased;
  end;



  // ************************************************************************ //
  // Namespace : http://devlinux1/soap/AppraisalWorldWsdl
  // ************************************************************************ //
  UnitsPurchasedResponse = class(TRemotable)
  private
    Fresults: Integer;
    Fmessage: WideString;
  published
    property results: Integer read Fresults write Fresults;
    property message: WideString read Fmessage write Fmessage;
  end;


  // ************************************************************************ //
  // Namespace : AWServicesClass
  // soapAction: |AWServicesClass#GetLicenseDetail|AWServicesClass#GetServiceDetail|AWServicesClass#GetUserDetail|TestWebServiceClass#MyService|StoreWebServiceClass#RegisterInStore|StoreWebServiceClass#SendCustomerToPage|StoreWebServiceClass#AuthenticateCustomer|WSTransactionsClass#AddServiceUsage|WSTransactionsClass#AuthenticateCustomer|WSTransactionsClass#UpdateUnitsPurchased
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : AppraisalWorldWsdlBinding
  // service   : AppraisalWorldWsdl
  // port      : AppraisalWorldWsdlPort
  // URL       : http://devlinux1/secure/ws/AWWebServicesManager.php
  // ************************************************************************ //
  AppraisalWorldWsdlPortType = interface(IInvokable)
  ['{731E9F48-4961-04E7-38D4-F4A7556C9242}']
    function  AWServices_GetLicenseDetail1(const LicenseDetailRequest: LicenseDetailRequest): WideString; stdcall;
    function  AWServices_GetServiceDetail1(const ServiceDetailRequest: ServiceDetailRequest): WideString; stdcall;
    function  AWServices_GetUserDetail1(const UserDetailRequest: UserDetailRequest): WideString; stdcall;
    function  TestWebService_MyService1(const MyServiceRequest: MyServiceRequest): WideString; stdcall;
    function  StoreWebService_RegisterInStore1(const SFRegisterRequest: SFRegisterRequest): SFRegisterResponse; stdcall;
    function  StoreWebService_SendCustomerToPage1(const SFLoginRequest: SFLoginRequest): SFLoginResponse; stdcall;
    function  StoreWebService_AuthenticateCustomer1(const SFAuthenticateRequest: SFAuthenticateRequest): SFAuthenticateResponse; stdcall;
    function  WSTransactions_AddServiceUsage1(const UnitsUsedRequest: UnitsUsedRequest): UnitsUsedResponse; stdcall;
    function  WSTransactions_AuthenticateCustomer1(const AuthenticateRequest: AuthenticateRequest): AuthenticateResponse; stdcall;
    function  WSTransactions_UpdateUnitsPurchased1(const UnitsPurchasedRequest: UnitsPurchasedRequest): UnitsPurchasedResponse; stdcall;
  end;

function GetAppraisalWorldWsdlPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): AppraisalWorldWsdlPortType;


implementation

function GetAppraisalWorldWsdlPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): AppraisalWorldWsdlPortType;
const
  defWSDL = 'http://devlinux1/secure/ws/AWWebServicesManager.php?wsdl';
  defURL  = 'http://devlinux1/secure/ws/AWWebServicesManager.php';
  defSvc  = 'AppraisalWorldWsdl';
  defPrt  = 'AppraisalWorldWsdlPort';
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
    Result := (RIO as AppraisalWorldWsdlPortType);
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


initialization
  InvRegistry.RegisterInterface(TypeInfo(AppraisalWorldWsdlPortType), 'AWServicesClass', 'ISO-8859-1');
  InvRegistry.RegisterAllSOAPActions(TypeInfo(AppraisalWorldWsdlPortType), '|AWServicesClass#GetLicenseDetail'
                                                                          +'|AWServicesClass#GetServiceDetail'
                                                                          +'|AWServicesClass#GetUserDetail'
                                                                          +'|TestWebServiceClass#MyService'
                                                                          +'|StoreWebServiceClass#RegisterInStore'
                                                                          +'|StoreWebServiceClass#SendCustomerToPage'
                                                                          +'|StoreWebServiceClass#AuthenticateCustomer'
                                                                          +'|WSTransactionsClass#AddServiceUsage'
                                                                          +'|WSTransactionsClass#AuthenticateCustomer'
                                                                          +'|WSTransactionsClass#UpdateUnitsPurchased'
                                                                          );
  InvRegistry.RegisterExternalMethName(TypeInfo(AppraisalWorldWsdlPortType), 'AWServices_GetLicenseDetail1', 'AWServices.GetLicenseDetail');
  InvRegistry.RegisterExternalMethName(TypeInfo(AppraisalWorldWsdlPortType), 'AWServices_GetServiceDetail1', 'AWServices.GetServiceDetail');
  InvRegistry.RegisterExternalMethName(TypeInfo(AppraisalWorldWsdlPortType), 'AWServices_GetUserDetail1', 'AWServices.GetUserDetail');
  InvRegistry.RegisterExternalMethName(TypeInfo(AppraisalWorldWsdlPortType), 'TestWebService_MyService1', 'TestWebService.MyService');
  InvRegistry.RegisterExternalMethName(TypeInfo(AppraisalWorldWsdlPortType), 'StoreWebService_RegisterInStore1', 'StoreWebService.RegisterInStore');
  InvRegistry.RegisterExternalMethName(TypeInfo(AppraisalWorldWsdlPortType), 'StoreWebService_SendCustomerToPage1', 'StoreWebService.SendCustomerToPage');
  InvRegistry.RegisterExternalMethName(TypeInfo(AppraisalWorldWsdlPortType), 'StoreWebService_AuthenticateCustomer1', 'StoreWebService.AuthenticateCustomer');
  InvRegistry.RegisterExternalMethName(TypeInfo(AppraisalWorldWsdlPortType), 'WSTransactions_AddServiceUsage1', 'WSTransactions.AddServiceUsage');
  InvRegistry.RegisterExternalMethName(TypeInfo(AppraisalWorldWsdlPortType), 'WSTransactions_AuthenticateCustomer1', 'WSTransactions.AuthenticateCustomer');
  InvRegistry.RegisterExternalMethName(TypeInfo(AppraisalWorldWsdlPortType), 'WSTransactions_UpdateUnitsPurchased1', 'WSTransactions.UpdateUnitsPurchased');
  RemClassRegistry.RegisterXSClass(ServiceDetailRequest, 'http://devlinux1/soap/AppraisalWorldWsdl', 'ServiceDetailRequest');
  RemClassRegistry.RegisterXSClass(LicenseDetailRequest, 'http://devlinux1/soap/AppraisalWorldWsdl', 'LicenseDetailRequest');
  RemClassRegistry.RegisterXSClass(UserDetailRequest, 'http://devlinux1/soap/AppraisalWorldWsdl', 'UserDetailRequest');
  RemClassRegistry.RegisterXSClass(MyServiceRequest, 'http://devlinux1/soap/AppraisalWorldWsdl', 'MyServiceRequest');
  RemClassRegistry.RegisterXSClass(SFRegisterRequest, 'http://devlinux1/soap/AppraisalWorldWsdl', 'SFRegisterRequest');
  RemClassRegistry.RegisterXSClass(SFRegisterResponse, 'http://devlinux1/soap/AppraisalWorldWsdl', 'SFRegisterResponse');
  RemClassRegistry.RegisterXSClass(SFLoginResponse, 'http://devlinux1/soap/AppraisalWorldWsdl', 'SFLoginResponse');
  RemClassRegistry.RegisterXSClass(SFLoginRequest, 'http://devlinux1/soap/AppraisalWorldWsdl', 'SFLoginRequest');
  RemClassRegistry.RegisterXSClass(SFAuthenticateRequest, 'http://devlinux1/soap/AppraisalWorldWsdl', 'SFAuthenticateRequest');
  RemClassRegistry.RegisterXSClass(SFAuthenticateResponse, 'http://devlinux1/soap/AppraisalWorldWsdl', 'SFAuthenticateResponse');
  RemClassRegistry.RegisterXSClass(AuthenticateRequest, 'http://devlinux1/soap/AppraisalWorldWsdl', 'AuthenticateRequest');
  RemClassRegistry.RegisterXSClass(AuthenticateResponse, 'http://devlinux1/soap/AppraisalWorldWsdl', 'AuthenticateResponse');
  RemClassRegistry.RegisterXSClass(UnitsUsedRequest, 'http://devlinux1/soap/AppraisalWorldWsdl', 'UnitsUsedRequest');
  RemClassRegistry.RegisterXSClass(UnitsUsedResponse, 'http://devlinux1/soap/AppraisalWorldWsdl', 'UnitsUsedResponse');
  RemClassRegistry.RegisterXSClass(UnitsPurchasedRequest, 'http://devlinux1/soap/AppraisalWorldWsdl', 'UnitsPurchasedRequest');
  RemClassRegistry.RegisterXSClass(UnitsPurchasedResponse, 'http://devlinux1/soap/AppraisalWorldWsdl', 'UnitsPurchasedResponse');

end. 