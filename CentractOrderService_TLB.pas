// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://www.appraiserworx.ca/webservice/OrderServices.asmx
// Encoding : utf-8
// Version  : 1.0
// (2/14/2011 9:52:36 AM - 1.33.2.5)
// ************************************************************************ //

unit CentractOrderService_TLB;

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
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"

  OrderHeader          = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  OrderFooter          = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  Requester            = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  Appraiser            = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  ArrayOfString        = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05"[A] }
  Order                = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  Broker               = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  Client               = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  Address              = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  Property_            = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  Applicant            = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  ListingAgent         = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  Builder              = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  CondoStrata          = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  Contact              = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  OrderContent         = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  ArrayOfString1       = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05"[A] }
  InspectionToDoList   = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  OrderDetailsPackage  = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  QualityValidationComment = class;             { "http://www.centract.com/OrderServicesContracts/2009/05" }
  FormData             = class;                 { "http://www.centract.com/OrderServicesContracts/2009/05" }
  QualityValidationMessageLocation = class;     { "http://www.centract.com/OrderServicesContracts/2009/05" }
  ArrayOfQualityValidationMessageLocation = class;   { "http://www.centract.com/OrderServicesContracts/2009/05"[A] }
  QualityValidationMessage = class;             { "http://www.centract.com/OrderServicesContracts/2009/05" }
  QualityControlPackage = class;                { "http://www.centract.com/OrderServicesContracts/2009/05" }

  { "http://www.centract.com/OrderServicesContracts/2009/05" }
  QualityValidationMessageType = (Warning, Error, WarningRequiresYesNo);



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  OrderHeader = class(TRemotable)
  private
    FCompany: WideString;
    FAddressLine1: WideString;
    FAddressLine2: WideString;
    FAddressLine3: WideString;
    FPhone: WideString;
    FFax: WideString;
  published
    property Company: WideString read FCompany write FCompany;
    property AddressLine1: WideString read FAddressLine1 write FAddressLine1;
    property AddressLine2: WideString read FAddressLine2 write FAddressLine2;
    property AddressLine3: WideString read FAddressLine3 write FAddressLine3;
    property Phone: WideString read FPhone write FPhone;
    property Fax: WideString read FFax write FFax;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  OrderFooter = class(TRemotable)
  private
    FTermsOfReference: WideString;
    FTermsOfReferenceURL: WideString;
  published
    property TermsOfReference: WideString read FTermsOfReference write FTermsOfReference;
    property TermsOfReferenceURL: WideString read FTermsOfReferenceURL write FTermsOfReferenceURL;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  Requester = class(TRemotable)
  private
    FName: WideString;
    FTransit: WideString;
    FEmailAddress: WideString;
    FPrimaryPhone: WideString;
    FAdditionalPhone: WideString;
    FFaxNumber: WideString;
    FAddressLine1: WideString;
    FAddressLine2: WideString;
  published
    property Name: WideString read FName write FName;
    property Transit: WideString read FTransit write FTransit;
    property EmailAddress: WideString read FEmailAddress write FEmailAddress;
    property PrimaryPhone: WideString read FPrimaryPhone write FPrimaryPhone;
    property AdditionalPhone: WideString read FAdditionalPhone write FAdditionalPhone;
    property FaxNumber: WideString read FFaxNumber write FFaxNumber;
    property AddressLine1: WideString read FAddressLine1 write FAddressLine1;
    property AddressLine2: WideString read FAddressLine2 write FAddressLine2;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  Appraiser = class(TRemotable)
  private
    FAppraisalFirm: WideString;
    FAppraiserName: WideString;
    FAppraiserEmail: WideString;
    FAppraiserPhone: WideString;
    FReviewerName: WideString;
    FReviewerEmail: WideString;
    FReviewerPhone: WideString;
  published
    property AppraisalFirm: WideString read FAppraisalFirm write FAppraisalFirm;
    property AppraiserName: WideString read FAppraiserName write FAppraiserName;
    property AppraiserEmail: WideString read FAppraiserEmail write FAppraiserEmail;
    property AppraiserPhone: WideString read FAppraiserPhone write FAppraiserPhone;
    property ReviewerName: WideString read FReviewerName write FReviewerName;
    property ReviewerEmail: WideString read FReviewerEmail write FReviewerEmail;
    property ReviewerPhone: WideString read FReviewerPhone write FReviewerPhone;
  end;

  AncillaryService = array of WideString;       { "http://www.centract.com/OrderServicesContracts/2009/05" }


  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  ArrayOfString = class(TRemotable)
  private
    FAncillaryService: AncillaryService;
  public
    constructor Create; override;
    function   GetWideStringArray(Index: Integer): WideString;
    function   GetWideStringArrayLength: Integer;
    property   WideStringArray[Index: Integer]: WideString read GetWideStringArray; default;
    property   Len: Integer read GetWideStringArrayLength;
  published
    property AncillaryService: AncillaryService read FAncillaryService write FAncillaryService;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  Order = class(TRemotable)
  private
    FOrderID: WideString;
    FAppraisalFirmRefNo: WideString;
    FAppraisalType: WideString;
    FRush: Boolean;
    FRushReason: WideString;
    FAncillaryServices: ArrayOfString;
    FReportLanguagePreference: WideString;
    FMortgagePurpose: WideString;
    FAssignmentDate: TXSDateTime;
    FAppointmentDate: TXSDateTime;
    FRequiredByDate: TXSDateTime;
    FEstimatedMarketValue: WideString;
  public
    destructor Destroy; override;
  published
    property OrderID: WideString read FOrderID write FOrderID;
    property AppraisalFirmRefNo: WideString read FAppraisalFirmRefNo write FAppraisalFirmRefNo;
    property AppraisalType: WideString read FAppraisalType write FAppraisalType;
    property Rush: Boolean read FRush write FRush;
    property RushReason: WideString read FRushReason write FRushReason;
    property AncillaryServices: ArrayOfString read FAncillaryServices write FAncillaryServices;
    property ReportLanguagePreference: WideString read FReportLanguagePreference write FReportLanguagePreference;
    property MortgagePurpose: WideString read FMortgagePurpose write FMortgagePurpose;
    property AssignmentDate: TXSDateTime read FAssignmentDate write FAssignmentDate;
    property AppointmentDate: TXSDateTime read FAppointmentDate write FAppointmentDate;
    property RequiredByDate: TXSDateTime read FRequiredByDate write FRequiredByDate;
    property EstimatedMarketValue: WideString read FEstimatedMarketValue write FEstimatedMarketValue;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  Broker = class(TRemotable)
  private
    FBrokerage: WideString;
  published
    property Brokerage: WideString read FBrokerage write FBrokerage;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  Client = class(TRemotable)
  private
    FAddressReportTo: WideString;
    FLender: WideString;
    FBroker: Broker;
  public
    destructor Destroy; override;
  published
    property AddressReportTo: WideString read FAddressReportTo write FAddressReportTo;
    property Lender: WideString read FLender write FLender;
    property Broker: Broker read FBroker write FBroker;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  Address = class(TRemotable)
  private
    FUnitNumber: WideString;
    FStreetNumber: WideString;
    FStreetName: WideString;
    FCity: WideString;
    FProvince: WideString;
    FPostalCode: WideString;
  published
    property UnitNumber: WideString read FUnitNumber write FUnitNumber;
    property StreetNumber: WideString read FStreetNumber write FStreetNumber;
    property StreetName: WideString read FStreetName write FStreetName;
    property City: WideString read FCity write FCity;
    property Province: WideString read FProvince write FProvince;
    property PostalCode: WideString read FPostalCode write FPostalCode;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  Property_ = class(TRemotable)
  private
    FPropertyAddress: Address;
    FLegalDescription: WideString;
    FPropertyType: WideString;
  public
    destructor Destroy; override;
  published
    property PropertyAddress: Address read FPropertyAddress write FPropertyAddress;
    property LegalDescription: WideString read FLegalDescription write FLegalDescription;
    property PropertyType: WideString read FPropertyType write FPropertyType;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  Applicant = class(TRemotable)
  private
    FApplicantName: WideString;
    FContact1Name: WideString;
    FContact1Phone1: WideString;
    FContact1Phone2: WideString;
    FContact1Phone3: WideString;
    FContact2Name: WideString;
    FContact2Phone1: WideString;
    FContact2Phone2: WideString;
    FContact2Phone3: WideString;
  published
    property ApplicantName: WideString read FApplicantName write FApplicantName;
    property Contact1Name: WideString read FContact1Name write FContact1Name;
    property Contact1Phone1: WideString read FContact1Phone1 write FContact1Phone1;
    property Contact1Phone2: WideString read FContact1Phone2 write FContact1Phone2;
    property Contact1Phone3: WideString read FContact1Phone3 write FContact1Phone3;
    property Contact2Name: WideString read FContact2Name write FContact2Name;
    property Contact2Phone1: WideString read FContact2Phone1 write FContact2Phone1;
    property Contact2Phone2: WideString read FContact2Phone2 write FContact2Phone2;
    property Contact2Phone3: WideString read FContact2Phone3 write FContact2Phone3;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  ListingAgent = class(TRemotable)
  private
    FName: WideString;
    FCompany: WideString;
    FEmailAddress: WideString;
    FHomePhone: WideString;
    FWorkPhone: WideString;
    FMobilePhone: WideString;
  published
    property Name: WideString read FName write FName;
    property Company: WideString read FCompany write FCompany;
    property EmailAddress: WideString read FEmailAddress write FEmailAddress;
    property HomePhone: WideString read FHomePhone write FHomePhone;
    property WorkPhone: WideString read FWorkPhone write FWorkPhone;
    property MobilePhone: WideString read FMobilePhone write FMobilePhone;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  Builder = class(TRemotable)
  private
    FName: WideString;
    FPrimaryPhone: WideString;
  published
    property Name: WideString read FName write FName;
    property PrimaryPhone: WideString read FPrimaryPhone write FPrimaryPhone;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  CondoStrata = class(TRemotable)
  private
    FPropertyMgmtCompany: WideString;
    FManagerSuperintendent: WideString;
    FOfficePhone: WideString;
    FMobilePhone: WideString;
    FAdditionalPhone: WideString;
  published
    property PropertyMgmtCompany: WideString read FPropertyMgmtCompany write FPropertyMgmtCompany;
    property ManagerSuperintendent: WideString read FManagerSuperintendent write FManagerSuperintendent;
    property OfficePhone: WideString read FOfficePhone write FOfficePhone;
    property MobilePhone: WideString read FMobilePhone write FMobilePhone;
    property AdditionalPhone: WideString read FAdditionalPhone write FAdditionalPhone;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  Contact = class(TRemotable)
  private
    FApplicant: Applicant;
    FListingAgent: ListingAgent;
    FBuilder: Builder;
    FCondoStrata: CondoStrata;
  public
    destructor Destroy; override;
  published
    property Applicant: Applicant read FApplicant write FApplicant;
    property ListingAgent: ListingAgent read FListingAgent write FListingAgent;
    property Builder: Builder read FBuilder write FBuilder;
    property CondoStrata: CondoStrata read FCondoStrata write FCondoStrata;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  OrderContent = class(TRemotable)
  private
    FOrder: Order;
    FClient: Client;
    FRequester: Requester;
    FProperty_: Property_;
    FContact: Contact;
    FAppraiser: Appraiser;
    FSpecialInstructions: WideString;
  public
    destructor Destroy; override;
  published
    property Order: Order read FOrder write FOrder;
    property Client: Client read FClient write FClient;
    property Requester: Requester read FRequester write FRequester;
    property Property_: Property_ read FProperty_ write FProperty_;
    property Contact: Contact read FContact write FContact;
    property Appraiser: Appraiser read FAppraiser write FAppraiser;
    property SpecialInstructions: WideString read FSpecialInstructions write FSpecialInstructions;
  end;

  LenderRequirementItem = array of WideString;   { "http://www.centract.com/OrderServicesContracts/2009/05" }


  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  ArrayOfString1 = class(TRemotable)
  private
    FLenderRequirementItem: LenderRequirementItem;
  public
    constructor Create; override;
    function   GetWideStringArray(Index: Integer): WideString;
    function   GetWideStringArrayLength: Integer;
    property   WideStringArray[Index: Integer]: WideString read GetWideStringArray; default;
    property   Len: Integer read GetWideStringArrayLength;
  published
    property LenderRequirementItem: LenderRequirementItem read FLenderRequirementItem write FLenderRequirementItem;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  InspectionToDoList = class(TRemotable)
  private
    FLenderRequirements: ArrayOfString1;
  public
    destructor Destroy; override;
  published
    property LenderRequirements: ArrayOfString1 read FLenderRequirements write FLenderRequirements;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  OrderDetailsPackage = class(TRemotable)
  private
    FOrderHeader: OrderHeader;
    FOrderContent: OrderContent;
    FInspectionToDoList: InspectionToDoList;
    FOrderFooter: OrderFooter;
  public
    destructor Destroy; override;
  published
    property OrderHeader: OrderHeader read FOrderHeader write FOrderHeader;
    property OrderContent: OrderContent read FOrderContent write FOrderContent;
    property InspectionToDoList: InspectionToDoList read FInspectionToDoList write FInspectionToDoList;
    property OrderFooter: OrderFooter read FOrderFooter write FOrderFooter;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  QualityValidationComment = class(TRemotable)
  private
    FMessageID: WideString;
    FText: WideString;
  published
    property MessageID: WideString read FMessageID write FMessageID;
    property Text: WideString read FText write FText;
  end;

  ArrayOfQualityValidationComment = array of QualityValidationComment;   { "http://www.centract.com/OrderServicesContracts/2009/05" }


  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  FormData = class(TRemotable)
  private
    FXmlSignature: WideString;
    FOrderID: WideString;
    FFormXml: WideString;
    FComments: ArrayOfQualityValidationComment;
  public
    destructor Destroy; override;
  published
    property XmlSignature: WideString read FXmlSignature write FXmlSignature;
    property OrderID: WideString read FOrderID write FOrderID;
    property FormXml: WideString read FFormXml write FFormXml;
    property Comments: ArrayOfQualityValidationComment read FComments write FComments;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  QualityValidationMessageLocation = class(TRemotable)
  private
    FFormSeqID: WideString;
    FCellID: WideString;
  published
    property FormSeqID: WideString read FFormSeqID write FFormSeqID;
    property CellID: WideString read FCellID write FCellID;
  end;

  Location   = array of QualityValidationMessageLocation;   { "http://www.centract.com/OrderServicesContracts/2009/05" }


  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  ArrayOfQualityValidationMessageLocation = class(TRemotable)
  private
    FLocation: Location;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetQualityValidationMessageLocationArray(Index: Integer): QualityValidationMessageLocation;
    function   GetQualityValidationMessageLocationArrayLength: Integer;
    property   QualityValidationMessageLocationArray[Index: Integer]: QualityValidationMessageLocation read GetQualityValidationMessageLocationArray; default;
    property   Len: Integer read GetQualityValidationMessageLocationArrayLength;
  published
    property Location: Location read FLocation write FLocation;
  end;



  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  QualityValidationMessage = class(TRemotable)
  private
    FType_: QualityValidationMessageType;
    FBitWiseOptions: Integer;
    FMessageID: WideString;
    FText: WideString;
    FLocations: ArrayOfQualityValidationMessageLocation;
    FIsOverriddenByComment: Boolean;
    FOverridable: Boolean;
    FErrorMessageID: WideString;
  public
    destructor Destroy; override;
  published
    property Type_: QualityValidationMessageType read FType_ write FType_;
    property BitWiseOptions: Integer read FBitWiseOptions write FBitWiseOptions;
    property MessageID: WideString read FMessageID write FMessageID;
    property Text: WideString read FText write FText;
    property Locations: ArrayOfQualityValidationMessageLocation read FLocations write FLocations;
    property IsOverriddenByComment: Boolean read FIsOverriddenByComment write FIsOverriddenByComment;
    property Overridable: Boolean read FOverridable write FOverridable;
    property ErrorMessageID: WideString read FErrorMessageID write FErrorMessageID;
  end;

  ArrayOfQualityValidationMessage = array of QualityValidationMessage;   { "http://www.centract.com/OrderServicesContracts/2009/05" }


  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // ************************************************************************ //
  QualityControlPackage = class(TRemotable)
  private
    FXmlSignature: WideString;
    FQualityValidationMessages: ArrayOfQualityValidationMessage;
  public
    destructor Destroy; override;
  published
    property XmlSignature: WideString read FXmlSignature write FXmlSignature;
    property QualityValidationMessages: ArrayOfQualityValidationMessage read FQualityValidationMessages write FQualityValidationMessages;
  end;


  // ************************************************************************ //
  // Namespace : http://www.centract.com/OrderServicesContracts/2009/05
  // soapAction: http://www.centract.com/OrderServicesContracts/2009/05/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // binding   : OrderServicesSoap
  // service   : OrderServices
  // port      : OrderServicesSoap
  // URL       : https://www.appraiserworx.ca/webservice/OrderServices.asmx
  // ************************************************************************ //
  OrderServicesSoap = interface(IInvokable)
  ['{96B3FE77-5CF0-6354-037A-72E607A448AA}']
    function  GetOrderDetails(const orderId: WideString): OrderDetailsPackage; stdcall;
    function  SubmitForm(const data: FormData): QualityControlPackage; stdcall;
    function  SubmitFormAndReport(const data: FormData): WideString; stdcall;
  end;

function GetOrderServicesSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): OrderServicesSoap;


implementation

function GetOrderServicesSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): OrderServicesSoap;
const
  defWSDL = 'https://www.appraiserworx.ca/webservice/OrderServices.asmx?wsdl';
  defURL  = 'https://www.appraiserworx.ca/webservice/OrderServices.asmx';
  defSvc  = 'OrderServices';
  defPrt  = 'OrderServicesSoap';
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
    Result := (RIO as OrderServicesSoap);
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


constructor ArrayOfString.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

function ArrayOfString.GetWideStringArray(Index: Integer): WideString;
begin
  Result := FAncillaryService[Index];
end;

function ArrayOfString.GetWideStringArrayLength: Integer;
begin
  if Assigned(FAncillaryService) then
    Result := Length(FAncillaryService)
  else
  Result := 0;
end;

destructor Order.Destroy;
begin
  if Assigned(FAncillaryServices) then
    FAncillaryServices.Free;
  if Assigned(FAssignmentDate) then
    FAssignmentDate.Free;
  if Assigned(FAppointmentDate) then
    FAppointmentDate.Free;
  if Assigned(FRequiredByDate) then
    FRequiredByDate.Free;
  inherited Destroy;
end;

destructor Client.Destroy;
begin
  if Assigned(FBroker) then
    FBroker.Free;
  inherited Destroy;
end;

destructor Property_.Destroy;
begin
  if Assigned(FPropertyAddress) then
    FPropertyAddress.Free;
  inherited Destroy;
end;

destructor Contact.Destroy;
begin
  if Assigned(FApplicant) then
    FApplicant.Free;
  if Assigned(FListingAgent) then
    FListingAgent.Free;
  if Assigned(FBuilder) then
    FBuilder.Free;
  if Assigned(FCondoStrata) then
    FCondoStrata.Free;
  inherited Destroy;
end;

destructor OrderContent.Destroy;
begin
  if Assigned(FOrder) then
    FOrder.Free;
  if Assigned(FClient) then
    FClient.Free;
  if Assigned(FRequester) then
    FRequester.Free;
  if Assigned(FProperty_) then
    FProperty_.Free;
  if Assigned(FContact) then
    FContact.Free;
  if Assigned(FAppraiser) then
    FAppraiser.Free;
  inherited Destroy;
end;

constructor ArrayOfString1.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

function ArrayOfString1.GetWideStringArray(Index: Integer): WideString;
begin
  Result := FLenderRequirementItem[Index];
end;

function ArrayOfString1.GetWideStringArrayLength: Integer;
begin
  if Assigned(FLenderRequirementItem) then
    Result := Length(FLenderRequirementItem)
  else
  Result := 0;
end;

destructor InspectionToDoList.Destroy;
begin
  if Assigned(FLenderRequirements) then
    FLenderRequirements.Free;
  inherited Destroy;
end;

destructor OrderDetailsPackage.Destroy;
begin
  if Assigned(FOrderHeader) then
    FOrderHeader.Free;
  if Assigned(FOrderContent) then
    FOrderContent.Free;
  if Assigned(FInspectionToDoList) then
    FInspectionToDoList.Free;
  if Assigned(FOrderFooter) then
    FOrderFooter.Free;
  inherited Destroy;
end;

destructor FormData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FComments)-1 do
    if Assigned(FComments[I]) then
      FComments[I].Free;
  SetLength(FComments, 0);
  inherited Destroy;
end;

constructor ArrayOfQualityValidationMessageLocation.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor ArrayOfQualityValidationMessageLocation.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FLocation)-1 do
    if Assigned(FLocation[I]) then
      FLocation[I].Free;
  SetLength(FLocation, 0);
  inherited Destroy;
end;

function ArrayOfQualityValidationMessageLocation.GetQualityValidationMessageLocationArray(Index: Integer): QualityValidationMessageLocation;
begin
  Result := FLocation[Index];
end;

function ArrayOfQualityValidationMessageLocation.GetQualityValidationMessageLocationArrayLength: Integer;
begin
  if Assigned(FLocation) then
    Result := Length(FLocation)
  else
  Result := 0;
end;

destructor QualityValidationMessage.Destroy;
begin
  if Assigned(FLocations) then
    FLocations.Free;
  inherited Destroy;
end;

destructor QualityControlPackage.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FQualityValidationMessages)-1 do
    if Assigned(FQualityValidationMessages[I]) then
      FQualityValidationMessages[I].Free;
  SetLength(FQualityValidationMessages, 0);
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(OrderServicesSoap), 'http://www.centract.com/OrderServicesContracts/2009/05', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(OrderServicesSoap), 'http://www.centract.com/OrderServicesContracts/2009/05/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(OrderServicesSoap), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(QualityValidationMessageType), 'http://www.centract.com/OrderServicesContracts/2009/05', 'QualityValidationMessageType');
  RemClassRegistry.RegisterXSClass(OrderHeader, 'http://www.centract.com/OrderServicesContracts/2009/05', 'OrderHeader');
  RemClassRegistry.RegisterXSClass(OrderFooter, 'http://www.centract.com/OrderServicesContracts/2009/05', 'OrderFooter');
  RemClassRegistry.RegisterXSClass(Requester, 'http://www.centract.com/OrderServicesContracts/2009/05', 'Requester');
  RemClassRegistry.RegisterXSClass(Appraiser, 'http://www.centract.com/OrderServicesContracts/2009/05', 'Appraiser');
  RemClassRegistry.RegisterXSInfo(TypeInfo(AncillaryService), 'http://www.centract.com/OrderServicesContracts/2009/05', 'AncillaryService');
  RemClassRegistry.RegisterXSClass(ArrayOfString, 'http://www.centract.com/OrderServicesContracts/2009/05', 'ArrayOfString');
  RemClassRegistry.RegisterSerializeOptions(ArrayOfString, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(Order, 'http://www.centract.com/OrderServicesContracts/2009/05', 'Order');
  RemClassRegistry.RegisterXSClass(Broker, 'http://www.centract.com/OrderServicesContracts/2009/05', 'Broker');
  RemClassRegistry.RegisterXSClass(Client, 'http://www.centract.com/OrderServicesContracts/2009/05', 'Client');
  RemClassRegistry.RegisterXSClass(Address, 'http://www.centract.com/OrderServicesContracts/2009/05', 'Address');
  RemClassRegistry.RegisterXSClass(Property_, 'http://www.centract.com/OrderServicesContracts/2009/05', 'Property_', 'Property');
  RemClassRegistry.RegisterXSClass(Applicant, 'http://www.centract.com/OrderServicesContracts/2009/05', 'Applicant');
  RemClassRegistry.RegisterXSClass(ListingAgent, 'http://www.centract.com/OrderServicesContracts/2009/05', 'ListingAgent');
  RemClassRegistry.RegisterXSClass(Builder, 'http://www.centract.com/OrderServicesContracts/2009/05', 'Builder');
  RemClassRegistry.RegisterXSClass(CondoStrata, 'http://www.centract.com/OrderServicesContracts/2009/05', 'CondoStrata');
  RemClassRegistry.RegisterXSClass(Contact, 'http://www.centract.com/OrderServicesContracts/2009/05', 'Contact');
  RemClassRegistry.RegisterXSClass(OrderContent, 'http://www.centract.com/OrderServicesContracts/2009/05', 'OrderContent');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(OrderContent), 'Property_', 'Property');
  RemClassRegistry.RegisterXSInfo(TypeInfo(LenderRequirementItem), 'http://www.centract.com/OrderServicesContracts/2009/05', 'LenderRequirementItem');
  RemClassRegistry.RegisterXSClass(ArrayOfString1, 'http://www.centract.com/OrderServicesContracts/2009/05', 'ArrayOfString1');
  RemClassRegistry.RegisterSerializeOptions(ArrayOfString1, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(InspectionToDoList, 'http://www.centract.com/OrderServicesContracts/2009/05', 'InspectionToDoList');
  RemClassRegistry.RegisterXSClass(OrderDetailsPackage, 'http://www.centract.com/OrderServicesContracts/2009/05', 'OrderDetailsPackage');
  RemClassRegistry.RegisterXSClass(QualityValidationComment, 'http://www.centract.com/OrderServicesContracts/2009/05', 'QualityValidationComment');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfQualityValidationComment), 'http://www.centract.com/OrderServicesContracts/2009/05', 'ArrayOfQualityValidationComment');
  RemClassRegistry.RegisterXSClass(FormData, 'http://www.centract.com/OrderServicesContracts/2009/05', 'FormData');
  RemClassRegistry.RegisterXSClass(QualityValidationMessageLocation, 'http://www.centract.com/OrderServicesContracts/2009/05', 'QualityValidationMessageLocation');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Location), 'http://www.centract.com/OrderServicesContracts/2009/05', 'Location');
  RemClassRegistry.RegisterXSClass(ArrayOfQualityValidationMessageLocation, 'http://www.centract.com/OrderServicesContracts/2009/05', 'ArrayOfQualityValidationMessageLocation');
  RemClassRegistry.RegisterSerializeOptions(ArrayOfQualityValidationMessageLocation, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(QualityValidationMessage, 'http://www.centract.com/OrderServicesContracts/2009/05', 'QualityValidationMessage');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(QualityValidationMessage), 'Type_', 'Type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfQualityValidationMessage), 'http://www.centract.com/OrderServicesContracts/2009/05', 'ArrayOfQualityValidationMessage');
  RemClassRegistry.RegisterXSClass(QualityControlPackage, 'http://www.centract.com/OrderServicesContracts/2009/05', 'QualityControlPackage');

end.