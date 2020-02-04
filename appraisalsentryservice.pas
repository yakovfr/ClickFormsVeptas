// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://www.appraisalsentry.com/appraisalsentryservice.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (9/12/2007 10:59:30 PM - 1.33.2.5)
// ************************************************************************ //

unit appraisalsentryservice;

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
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:short           - "http://www.w3.org/2001/XMLSchema"
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"

  PropertyInfo         = class;                 { "http://www.appraisalsentry.com/" }
  IdentityInfo         = class;                 { "http://www.appraisalsentry.com/" }
  ASDataRec            = class;                 { "http://www.appraisalsentry.com/" }
  Customer             = class;                 { "http://www.appraisalsentry.com/" }
  CustomerSubscription = class;                 { "http://www.appraisalsentry.com/" }



  // ************************************************************************ //
  // Namespace : http://www.appraisalsentry.com/
  // ************************************************************************ //
  PropertyInfo = class(TRemotable)
  private
    FAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FTotalBedBathRooms: WideString;
    FGrossLivingArea: WideString;
    FEstimatedMarketValue: WideString;
    FEffectiveAppraisalDate: WideString;
    FLenderName: WideString;
    FBorrowerName: WideString;
    FReportSignedOn: WideString;
    FReportPages: WideString;
  published
    property Address: WideString read FAddress write FAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property TotalBedBathRooms: WideString read FTotalBedBathRooms write FTotalBedBathRooms;
    property GrossLivingArea: WideString read FGrossLivingArea write FGrossLivingArea;
    property EstimatedMarketValue: WideString read FEstimatedMarketValue write FEstimatedMarketValue;
    property EffectiveAppraisalDate: WideString read FEffectiveAppraisalDate write FEffectiveAppraisalDate;
    property LenderName: WideString read FLenderName write FLenderName;
    property BorrowerName: WideString read FBorrowerName write FBorrowerName;
    property ReportSignedOn: WideString read FReportSignedOn write FReportSignedOn;
    property ReportPages: WideString read FReportPages write FReportPages;
  end;



  // ************************************************************************ //
  // Namespace : http://www.appraisalsentry.com/
  // ************************************************************************ //
  IdentityInfo = class(TRemotable)
  private
    FAppraiserName: WideString;
    FCompanyName: WideString;
    FAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FAppraiserLicNo: WideString;
    FAppraiserCertNo: WideString;
    FLicCertExpirationDate: WideString;
    FLicCertIssuingState: WideString;
  published
    property AppraiserName: WideString read FAppraiserName write FAppraiserName;
    property CompanyName: WideString read FCompanyName write FCompanyName;
    property Address: WideString read FAddress write FAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property AppraiserLicNo: WideString read FAppraiserLicNo write FAppraiserLicNo;
    property AppraiserCertNo: WideString read FAppraiserCertNo write FAppraiserCertNo;
    property LicCertExpirationDate: WideString read FLicCertExpirationDate write FLicCertExpirationDate;
    property LicCertIssuingState: WideString read FLicCertIssuingState write FLicCertIssuingState;
  end;



  // ************************************************************************ //
  // Namespace : http://www.appraisalsentry.com/
  // ************************************************************************ //
  ASDataRec = class(TRemotable)
  private
    FFileNo: WideString;
    FPropertyFacts: PropertyInfo;
    FAppraiserIdentity: IdentityInfo;
    FEmailTo: WideString;
  public
    destructor Destroy; override;
  published
    property FileNo: WideString read FFileNo write FFileNo;
    property PropertyFacts: PropertyInfo read FPropertyFacts write FPropertyFacts;
    property AppraiserIdentity: IdentityInfo read FAppraiserIdentity write FAppraiserIdentity;
    property EmailTo: WideString read FEmailTo write FEmailTo;
  end;



  // ************************************************************************ //
  // Namespace : http://www.appraisalsentry.com/
  // ************************************************************************ //
  Customer = class(TRemotable)
  private
    FCustomerID: Integer;
    FRefCustomerID: WideString;
    FCustomerTypeID: Smallint;
    FPartnerID: Integer;
    FUserID: WideString;
    FPassword: WideString;
    FFirstName: WideString;
    FLastName: WideString;
    FMI: WideString;
    FCompany: WideString;
    FAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FPhone: WideString;
    FFax: WideString;
    FEmail: WideString;
    FSecretQuestion: WideString;
    FSecretAnswer: WideString;
  published
    property CustomerID: Integer read FCustomerID write FCustomerID;
    property RefCustomerID: WideString read FRefCustomerID write FRefCustomerID;
    property CustomerTypeID: Smallint read FCustomerTypeID write FCustomerTypeID;
    property PartnerID: Integer read FPartnerID write FPartnerID;
    property UserID: WideString read FUserID write FUserID;
    property Password: WideString read FPassword write FPassword;
    property FirstName: WideString read FFirstName write FFirstName;
    property LastName: WideString read FLastName write FLastName;
    property MI: WideString read FMI write FMI;
    property Company: WideString read FCompany write FCompany;
    property Address: WideString read FAddress write FAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property Phone: WideString read FPhone write FPhone;
    property Fax: WideString read FFax write FFax;
    property Email: WideString read FEmail write FEmail;
    property SecretQuestion: WideString read FSecretQuestion write FSecretQuestion;
    property SecretAnswer: WideString read FSecretAnswer write FSecretAnswer;
  end;



  // ************************************************************************ //
  // Namespace : http://www.appraisalsentry.com/
  // ************************************************************************ //
  CustomerSubscription = class(TRemotable)
  private
    FRefCustomerID: WideString;
    FPartnerID: Integer;
    FProductID: WideString;
    FInvoiceID: WideString;
    FSubsStartsOn: TXSDateTime;
    FSubsExpiresOn: TXSDateTime;
    FSubsUnits: Integer;
    FCreatedOn: TXSDateTime;
    FCreatedBy: Integer;
    FisActive: Boolean;
  public
    destructor Destroy; override;
  published
    property RefCustomerID: WideString read FRefCustomerID write FRefCustomerID;
    property PartnerID: Integer read FPartnerID write FPartnerID;
    property ProductID: WideString read FProductID write FProductID;
    property InvoiceID: WideString read FInvoiceID write FInvoiceID;
    property SubsStartsOn: TXSDateTime read FSubsStartsOn write FSubsStartsOn;
    property SubsExpiresOn: TXSDateTime read FSubsExpiresOn write FSubsExpiresOn;
    property SubsUnits: Integer read FSubsUnits write FSubsUnits;
    property CreatedOn: TXSDateTime read FCreatedOn write FCreatedOn;
    property CreatedBy: Integer read FCreatedBy write FCreatedBy;
    property isActive: Boolean read FisActive write FisActive;
  end;


  // ************************************************************************ //
  // Namespace : http://www.appraisalsentry.com/
  // soapAction: http://www.appraisalsentry.com/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // binding   : AppraisalSentryServiceSoap
  // service   : AppraisalSentryService
  // port      : AppraisalSentryServiceSoap
  // URL       : http://www.appraisalsentry.com/appraisalsentryservice.asmx
  // ************************************************************************ //
  AppraisalSentryServiceSoap = interface(IInvokable)
  ['{BB87B7A4-49EB-CE47-9174-6B8B896687CC}']
    procedure GetSecurityToken(const ipUserName: WideString; const ipPassword: WideString; out GetSecurityTokenResult: WideString; out opOverageFee: TXSDecimal; out opMessage: WideString); stdcall;
    procedure RegisterReport(const ipSecurityToken: WideString; const ipUserName: WideString; const ipPassword: WideString; const strFileName: WideString; const ipReportFile: TByteDynArray; const ipLicFile: TByteDynArray; const ASData: ASDataRec; out RegisterReportResult: TByteDynArray; out opMessage: WideString
                             ); stdcall;
    procedure ValidateReport(const ipUserName: WideString; const ipPassword: WideString; const ipReportFile: TByteDynArray; out ValidateReportResult: ASDataRec; out opMessage: WideString); stdcall;
    procedure CreateCustomer(const customerRec: Customer; out CreateCustomerResult: Boolean; out opMessage: WideString); stdcall;
    procedure CreateNewSubscriptionForCustomer(const customerSubscription: CustomerSubscription; out CreateNewSubscriptionForCustomerResult: Boolean; out opMessage: WideString); stdcall;
    procedure ResetSubscriptionUsedUnitsForCustomer(const refCustomerID: WideString; const partnerID: Integer; const productID: WideString; const resetToUnits: Integer; const rollOver: Boolean; out ResetSubscriptionUsedUnitsForCustomerResult: Boolean; out opMessage: WideString); stdcall;
    procedure ResetAuthenticationForCustomer(const refCustomerID: WideString; const partnerID: Integer; out ResetAuthenticationForCustomerResult: Boolean; out opMessage: WideString); stdcall;
  end;

function GetAppraisalSentryServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): AppraisalSentryServiceSoap;


implementation

function GetAppraisalSentryServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): AppraisalSentryServiceSoap;
const
  defWSDL = 'http://www.appraisalsentry.com/appraisalsentryservice.asmx?wsdl';
  defURL  = 'http://www.appraisalsentry.com/appraisalsentryservice.asmx';
  defSvc  = 'AppraisalSentryService';
  defPrt  = 'AppraisalSentryServiceSoap';
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
    Result := (RIO as AppraisalSentryServiceSoap);
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


destructor ASDataRec.Destroy;
begin
  if Assigned(FPropertyFacts) then
    FPropertyFacts.Free;
  if Assigned(FAppraiserIdentity) then
    FAppraiserIdentity.Free;
  inherited Destroy;
end;

destructor CustomerSubscription.Destroy;
begin
  if Assigned(FSubsStartsOn) then
    FSubsStartsOn.Free;
  if Assigned(FSubsExpiresOn) then
    FSubsExpiresOn.Free;
  if Assigned(FCreatedOn) then
    FCreatedOn.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(AppraisalSentryServiceSoap), 'http://www.appraisalsentry.com/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(AppraisalSentryServiceSoap), 'http://www.appraisalsentry.com/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(AppraisalSentryServiceSoap), ioDocument); //Dr Bobs solution
  RemClassRegistry.RegisterXSClass(PropertyInfo, 'http://www.appraisalsentry.com/', 'PropertyInfo');
  RemClassRegistry.RegisterXSClass(IdentityInfo, 'http://www.appraisalsentry.com/', 'IdentityInfo');
  RemClassRegistry.RegisterXSClass(ASDataRec, 'http://www.appraisalsentry.com/', 'ASDataRec');
  RemClassRegistry.RegisterXSClass(Customer, 'http://www.appraisalsentry.com/', 'Customer');
  RemClassRegistry.RegisterXSClass(CustomerSubscription, 'http://www.appraisalsentry.com/', 'CustomerSubscription');

end. 