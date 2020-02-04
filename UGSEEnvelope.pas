unit UGSEEnvelope;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
   Classes, uCraftXML, uCraftClass, UMismoOrderObjects;

const
   REQUEST_ROOT_ELEMENT_NAME = 'REQUEST_GROUP';
   REQUEST_PARENT_ELEMENT_XPATH = REQUEST_ROOT_ELEMENT_NAME + '/REQUEST/REQUEST/DATA';

   RESPONSE_ROOT_ELEMENT_NAME = 'RESPONSE_GROUP';
   RESPONSE_PARENT_ELEMENT_XPATH = RESPONSE_ROOT_ELEMENT_NAME + '/RESPONSE/RESPONSE_DATA';

   APPRAISAL_REPORT_FILE_EXTENSION = 'AppraisalReport';
   APPRAISAL_ORDER_FILE_EXTENSION = 'AppraisalOrder';
   APPRAISAL_STATUS_FILE_EXTENSION = 'AppraisalStatus';

   APPRAISAL_RESPONSE_ELEMENT = 'APPRAISAL_RESPONSE';
   APPRAISAL_REQUEST_ELEMENT = 'APPRAISAL_REQUEST';
   DEFAULT_MISMO_VERSION = '2.5.1';

type
   TContactPointRole = (cprUnknown, cprHome, cprWork, cprMobile);
   TContactPointType = (cptUnknown, cptEMail, cptFax, cptPhone, cptPager, cptAutomationEMail, cptOther);

   TAppraisalPurposeType = (aptUnknown, aptPurchase, aptRefinance, aptEquity, aptEstate,
       aptDivorce, aptTaxAppeal, aptInspection, aptConstruction, aptSecondMortgage, aptOther);

const
   CONTACT_POINT_ROLE_NAMES : array[TContactPointRole] of string = ('Unknown', 'Home', 'Work', 'Mobile');
   CONTACT_POINT_TYPE_NAMES : array[TContactPointType] of string = ('Unknown', 'EMail', 'Fax', 'Phone', 'Pager', 'Automation EMail', 'Other');
   APPRAISAL_PURPOSE_TYPE_NAMES : array[TAppraisalPurposeType] of string = ('Unknown', 'Purchase', 'Refinance', 'Equity',
       'Estate', 'Divorce', 'TaxAppeal', 'Inspection', 'Construction', 'SecondMortgage', 'Other');

function ContactPointRoleToStr(ARole : TContactPointRole) : string;
function StrToContactPointRole(const AString : string) : TContactPointRole;
function ContactPointTypeToStr(AType : TContactPointType) : string;
function StrToContactPointType(const AString : string) : TContactPointType;

type
   TContactDetail = class;
   TContactPoint = class(TCollectionItem)
   private
       FRole : TContactPointRole;
       FContactType : TContactPointType;
       FDescription : string;
       FValue : string;
   public
       procedure Clear;
       property Role : TContactPointRole read FRole write FRole;
       property ContactType : TContactPointType read FContactType write FContactType;
       property Description : string read FDescription write FDescription;
       property Value : string read FValue write FValue;

       procedure Parse(AnElement : TXMLElement; ADetail : TContactDetail = nil);
       procedure Compose(AnElement : TXMLElement; ADetail : TContactDetail = nil);
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; virtual;
   end;

   TContactDetail = class(TCollectionItem)
   private
       FName : string;
       FContactPoints : TCraftingCollection;
       FPreferredContactPoint : TContactPoint;
       function GetContactPoints : TCraftingCollection;
       function GetContactPoint(Index : Integer) : TContactPoint;
   protected
       property ContactPoints : TCraftingCollection read GetContactPoints;
   public
       destructor Destroy; override;
       procedure Clear;

       property Name : string read FName write FName;      //  person name
       property PreferredContactPoint : TContactPoint read FPreferredContactPoint write FPreferredContactPoint;
       property ContactPoint[Index : Integer] : TContactPoint read GetContactPoint;
       function AddContactPoint : TContactPoint;
       function ContactPointCount : Integer;

       procedure Parse(AnElement : TXMLElement);
       procedure Compose(AnElement : TXMLElement);
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; virtual;
   end;

   TContact = class(TCraftingCollectionItem)
   private
       FDetails : TCraftingCollection;
       FName : string;
       FStreetAddress : string;
       FStreetAddress2 : string;
       FCity : string;
       FState : string;
       FPostalCode : string;
       FCountry : string;
       FIdentifier : string;

       function GetContactDetail(Index : Integer) : TContactDetail;
   public
       constructor Create; reintroduce; overload; virtual;
       destructor Destroy; override;
       procedure Clear; override;
       function QuickName : string;

       property CompanyName : string read FName write FName;
       property StreetAddress : string read FStreetAddress write FStreetAddress;
       property StreetAddress2 : string read FStreetAddress2 write FStreetAddress2;
       property City : string read FCity write FCity;
       property State : string read FState write FState;
       property PostalCode : string read FPostalCode write FPostalCode;
       property Country : string read FCountry write FCountry;
       property Identifier : string read FIdentifier write FIdentifier;
       property Details[Index : Integer] : TContactDetail read GetContactDetail;
       function AddDetail : TContactDetail;
       function DetailCount : Integer;

       procedure Parse(AnElement : TXMLElement); virtual;
       procedure Compose(AnElement : TXMLElement); virtual;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; virtual;
   end;

   TContacts = class(TCraftingCollection)
   public
       constructor Create; reintroduce; overload;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; virtual;

       function First(var AContact : TContact) : Boolean; reintroduce; overload;
       function Next(var AContact : TContact) : Boolean; reintroduce; overload;
   end;

   TPreferredFormat = (pfUnknown, pfXML, pfText, pfPDF, pfPCL, pfOther);
   TDeliveryMethod = (dmUnknown, dmSMTP, dmHTTP, dmHTTPS, dmVAN, dmMessageQueue, dmMail, dmFax, dmFile, dmFTP, dmOther);
   TInspectionType = (itUnknown, itNone, itExteriorOnly, itExteriorAndInterior);
   TGraphicFormat = (gfUnknown, gfGIF, gfJPEG, gfBitmap, gfPNG);
   TComparable = (cUnknown, cSubject, cComp1, cComp2, cComp3, cComp4, cComp5, cComp6, cComp7, cComp8, cComp9, cCompOther);
   TComparableType = (ctSales, ctRentals, ctListings);
   TImageType = (imtUnknown, imtSketch, imtMap, imtPhoto, imtExhibit);

const
   GRAPHIC_FORMAT_NAMES : array[TGraphicFormat] of string = ('Unknown', 'GIF', 'JPG', 'BMP', 'PNG');
   GRAPHIC_FORMAT_MIME_TYPES : array[TGraphicFormat] of string = ('Unknown', 'image/gif', 'image/jpeg', 'Unknown', 'image/png');
   PREFERRED_FORMAT_NAMES : array[TPreferredFormat] of string = ('Unknown', 'XML', 'Text', 'PDF', 'PCL', 'Other');
   PREFERRED_DELIVERY_NAMES : array[TDeliveryMethod] of string = ('Unknown', 'SMTP', 'HTTP', 'HTTPS', 'VAN',
       'MessageQueue', 'Mail', 'Fax', 'File', 'FTP', 'Other');
   INSPECTION_TYPE_NAMES : array[TInspectionType] of string = ('Unknown', 'None', 'Exterior Only', 'Exterior And Interior');
   COMPARABLE_NAMES : array[TComparable] of string = ('Unknown', 'Subject', 'ComparableOne', 'ComparableTwo',
       'ComparableThree', 'ComparableFour', 'ComparableFive', 'ComparableSix', 'ComparableSeven',
       'ComparableEight', 'ComparableNine', 'Other');
   COMPARABLE_INDEX_NAMES : array[0..11] of string = ('Unknown', 'Subject', 'ComparableOne', 'ComparableTwo',
       'ComparableThree', 'ComparableFour', 'ComparableFive', 'ComparableSix', 'ComparableSeven',
       'ComparableEight', 'ComparableNine', 'Other');
   COMPARABLE_TITLES : array[TComparableType, TComparable] of string = (('Unknown', 'Subject', 'Comparable Sale 1',
       'Comparable Sale 2', 'Comparable Sale 3', 'Comparable Sale 4', 'Comparable Sale 5', 'Comparable Sale 6',
       'Comparable Sale 7', 'Comparable Sale 8', 'Comparable Sale 9', 'Other'),
       ('Unknown', 'Subject', 'Comparable Rental 1', 'Comparable Rental 2', 'Comparable Rental 3',
       'Comparable Rental 4', 'Comparable Rental 5', 'Comparable Rental 6', 'Comparable Rental 7',
       'Comparable Rental 8', 'Comparable Rental 9', 'Other'),
       ('Unknown', 'Subject', 'Comparable Listing 1', 'Comparable Listing 2', 'Comparable Listing 3',
       'Comparable Listing 4', 'Comparable Listing 5', 'Comparable Listing 6', 'Comparable Listing 7',
       'Comparable Listing 8', 'Comparable Listing 9', 'Other'));
   COMPARABLE_TYPE_NAMES : array[TComparableType] of string = ('Sales', 'Rentals', 'Listings');
   COMPARABLE_TYPE_INDEX : array[TComparableType] of Integer = (1, 2, 3);
   IMAGE_TYPE_NAMES : array[TImageType] of string = ('Unknown', 'Sketch', 'Map', 'Photo', 'Exhibit');

   BASE64_ENCODING_TAG = 'base64';

function PreferredFormatToStr(AFormat : TPreferredFormat) : string;
function PreferredDeliveryMethodToStr(ADeliveryMethod : TDeliveryMethod) : string;

type
   TPreferredResponse = class(TObject)
   private
       FFormat : TPreferredFormat;
       FMethod : TDeliveryMethod;
       FFormatOther : string;
       FMethodOther : string;
       FDestination : string;
   public
       property Format : TPreferredFormat read FFormat write FFormat;
       property FormatOther : string read FFormatOther write FFormatOther;
       property Method : TDeliveryMethod read FMethod write FMethod;
       property MethodOther : string read FMethodOther write FMethodOther;
       property Destination : string read FDestination write FDestination;

       procedure Clear;
       procedure Parse(AnElement : TXMLElement);
       procedure Compose(AnElement : TXMLElement);
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; virtual;
   end;

   TRequestingParty = class(TContact)
   private
       FPreferredResponse : TPreferredResponse;
   public
       constructor Create; override;
       destructor Destroy; override;
       procedure Clear; override;

       property PreferredResponse : TPreferredResponse read FPreferredResponse;
       procedure Parse(AnElement : TXMLElement); override;
       procedure Compose(AnElement : TXMLElement); override;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; override;
   end;

   TSubmittingParty = class(TRequestingParty)
   private
       FLoginAccountIdentifier : string;
       FLoginAccountPassword : string;
       FSequenceIdentifier : string;
   public
       procedure Clear; override;

       procedure Parse(AnElement : TXMLElement); override;
       procedure Compose(AnElement : TXMLElement); override;
       property LoginAccountIdentifier : string read FLoginAccountIdentifier write FLoginAccountIdentifier;
       property LoginAccountPassword : string read FLoginAccountPassword write FLoginAccountPassword;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; override;
       property SequenceIdentifier : string read FSequenceIdentifier write FSequenceIdentifier;
   end;

   TMISMOEnvelope = class;

   TPayload = class(TCraftingCollectionItem)
   private
       FXML : TXMLCollection;
       FKeyData : TCraftingStringList;
       FInternalAccount : string;
       FLoginAccountName : string;
       FLoginAccountPassword : string;
       FEnvelope : TMISMOEnvelope;

       function GetKeyData : TStrings;
       function GetData : TXMLElement;
       procedure SetData(AnElement : TXMLElement);
       function GetXML : TXMLCollection;
   protected
       property Envelope : TMISMOEnvelope read FEnvelope;
       property XML : TXMLCollection read GetXML;
   public
       constructor Create(ACollection : TCollection); override;
       destructor Destroy; override;
       procedure Clear; override;

       property Keys : TStrings read GetKeyData;
       property InternalAccount : string read FInternalAccount write FInternalAccount;
       property LoginAccountName : string read FLoginAccountName write FLoginAccountName;
       property LoginAccountPassword : string read FLoginAccountPassword write FLoginAccountPassword;
       property Data : TXMLElement read GetData write SetData; //      this is the root of the payload XML

       procedure Compose(AnElement : TXMLElement); virtual;
       procedure Parse(AnElement : TXMLElement); virtual;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; virtual;
   end;

   TPayloads = class(TCraftingCollection)
   public
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; virtual;
       function First(var APayload : TPayload) : Boolean; reintroduce; overload;
       function Next(var APayload : TPayload) : Boolean; reintroduce; overload;
   end;

   TValuation = class(TCraftingCollectionItem)
   public
       ValuationType : TAppraisalType;
       ValuationForm : string;
       FeeAmount : Currency;
       IsTaxable : Boolean;
   end;

   TValuations = class(TCraftingCollection)
   private
       function GetValuation(Index : Integer) : TValuation;
   public
       constructor Create; reintroduce; overload;
       function Add : TValuation;
       function First(var AValuation : TValuation) : Boolean; reintroduce; overload;
       function Next(var AValuation : TValuation) : Boolean; reintroduce; overload;
       property Valuations[Index : Integer] : TValuation read GetValuation; default;
   end;

   TOrder = class(TCraftingCollectionItem)
   private
       FDueDate : TDateTime;
       FAcceptanceDueDate : TDateTime;
       FInformalDueDate : TDateTime;
       FIsInformalRequested : Boolean;
       FValuations : TValuations;
       FOrderID : string;
       FPleaseConfirmBeforeAssignment : Boolean;
       FSpecialInstructions : string;
       FFormName : string;
       FInspectionType : TInspectionType;
       FAppraisalPurposeType : TAppraisalPurposeType;
   public
       constructor Create(ACollection : TCollection); override;
       destructor Destroy; override;
       function GetDescription(const LinePrefix : string) : string;
       property DueDate : TDateTime read FDueDate write FDueDate;
       property AcceptanceDueDate : TDateTime read FAcceptanceDueDate write FAcceptanceDueDate;
       property IsInformalRequested : Boolean read FIsInformalRequested write FIsInformalRequested;
       property InformalDueDate : TDateTime read FInformalDueDate write FInformalDueDate;
       property Valuations : TValuations read FValuations;
       property OrderID : string read FOrderID write FOrderID;
       property PleaseConfirmBeforeAssignment : Boolean
           read FPleaseConfirmBeforeAssignment write FPleaseConfirmBeforeAssignment;
       property SpecialInstructions : string read FSpecialInstructions write FSpecialInstructions;
       property FormName : string read FFormName write FFormName;
       property InspectionType : TInspectionType read FInspectionType write FInspectionType;
       property AppraisalPurposeType : TAppraisalPurposeType read FAppraisalPurposeType write FAppraisalPurposeType;

       procedure Parse(AnElement : TXMLElement); virtual;
       procedure Compose(AnElement : TXMLElement); virtual;
   end;

   TOrders = class(TCraftingCollection)
   private
       function GetOrder(Index : Integer) : TOrder;
   public
       constructor Create; reintroduce; overload;
       function Add : TOrder;
       function First(var AOrder : TOrder) : Boolean; reintroduce; overload;
       function Next(var AOrder : TOrder) : Boolean; reintroduce; overload;
       property Orders[Index : Integer] : TOrder read GetOrder; default;
   end;

   TRequest = class(TPayload)
   private
       FRequestDate : TDateTime;
       FPriority : string;
       FOrders : TOrders;
       FInternalAccountIdentifier : string;
       FLoginAccountIdentifier : string;
       FLoginAccountPassword : string;
       FRequestingPartyBranchIdentifier : string;
       function GetClientName : string;
       function GetAppraiserName : string;
   public
       constructor Create(ACollection : TCollection); override;
       destructor Destroy; override;

       procedure Compose(AnElement : TXMLElement); override;
       procedure Parse(AnElement : TXMLElement); override;

       property ClientName : string read GetClientName;
       property AppraiserName : string read GetAppraiserName;
       property Priority : string read FPriority write FPriority;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; override;
       property RequestDate : TDateTime read FRequestDate write FRequestDate;
       property InternalAccountIdentifier : string read FInternalAccountIdentifier write FInternalAccountIdentifier;
       property LoginAccountIdentifier : string read FLoginAccountIdentifier write FLoginAccountIdentifier;
       property LoginAccountPassword : string read FLoginAccountPassword write FLoginAccountPassword;
       property RequestingPartyBranchIdentifier : string
           read FRequestingPartyBranchIdentifier write FRequestingPartyBranchIdentifier;

       property Orders : TOrders read FOrders;
   end;

   TMISMOEnvelope = class(TPersistent)
   private
       FMismoVersion : string;
       function GetAsXML : string;
       procedure SetAsXML(Value : string);
   protected
       procedure AssignTo(Target : TPersistent); override;
       function GetOrderID : string; virtual;
       procedure SetOrderID(Value : string); virtual;
   public
       procedure AfterConstruction; override;
       procedure Clear; virtual;

       property MismoVersion : string read FMismoVersion write FMismoVersion;
       procedure Assign(Source : TPersistent); override;
       property AsXML : string read GetAsXML write SetAsXML;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; virtual;

       procedure Compose(AnXML : TXMLCollection); overload;
       procedure Compose(AnXMLElement : TXMLElement); overload; virtual; abstract;
       function Compose : string; overload;
       procedure Parse(const AText : string); overload;
       procedure Parse(AnXML : TXMLCollection); overload;
       procedure Parse(AnXMLElement : TXMLElement); overload; virtual; abstract;
       property OrderID : string read GetOrderID write SetOrderID;
   end;

   TMISMORequestEnvelope = class(TMISMOEnvelope)
   private
       FReceivingParty : TContact;
       FSubmittingParty : TSubmittingParty;
       FRequestingParties : TContacts;
       FRequests : TPayloads;
       function GetRequestingParty(Index : Integer) : TRequestingParty;
       function GetRequest(Index : Integer) : TRequest;
   protected
       function GetOrderID : string; override;
   public
       constructor Create;
       destructor Destroy; override;
       procedure Clear; override;

       property ReceivingParty : TContact read FReceivingParty write FReceivingParty;
       property SubmittingParty : TSubmittingParty read FSubmittingParty write FSubmittingParty;
       property RequestingParties[Index : Integer] : TRequestingParty read GetRequestingParty;
       function AddRequestingParty : TRequestingParty;
       function RequestingPartyCount : Integer;

       property Requests[Index : Integer] : TRequest read GetRequest; default;
       function AddRequest : TRequest;
       function RequestCount : Integer;

       procedure Parse(AnXMLElement : TXMLElement); override;
       procedure Compose(AnXMLElement : TXMLElement); override;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; override;
   end;

   TResponseStatus = class(TCraftingCollectionItem)
   private
       FCondition : string;
       FCode : Integer;
       FName : string;
       FDescription : string;
       function GetStatus : TeTracStatus;
       procedure SetStatus(Value : TeTracStatus);
       procedure SetCode(const Value : Integer);
       procedure SetName(const Value : string);
   public
       procedure Clear; override;

       property Name : string read FName write SetName;
       property Code : Integer read FCode write SetCode;
       property Condition : string read FCondition write FCondition;
       property Description : string read FDescription write FDescription;
       property Status : TeTracStatus read GetStatus write SetStatus;

       procedure Compose(AnElement : TXMLElement); overload;
       function Compose : string; overload;
       procedure Parse(AnElement : TXMLElement); overload;
       procedure Parse(const AText : string); overload;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; virtual;
   end;

   TStatuses = class(TCraftingCollection)
   public
       constructor Create; reintroduce; overload;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; virtual;
       function First(var AStatus : TResponseStatus) : Boolean; reintroduce; overload;
       function Next(var AStatus : TResponseStatus) : Boolean; reintroduce; overload;
   end;

   TResponse = class(TPayload)
   private
       FOrderID : string;
       FClientID : string;
       FStatuses : TStatuses;
       FReports : TStringList;
       FResponseDate : TDateTime;
       function GetStatus(Index : Integer) : TResponseStatus;
       function GetReport(Index : Integer) : string;
   public
       constructor Create(ACollection : TCollection); override;
       destructor Destroy; override;
       procedure Compose(AnElement : TXMLElement); override;
       procedure Parse(AnElement : TXMLElement); override;
       property Statuses[Index : Integer] : TResponseStatus read GetStatus;
       function AddStatus : TResponseStatus;
       function StatusCount : Integer;
       property Reports[Index : Integer] : string read GetReport;
       procedure AddReport(const AText : string);
       function ReportCount : Integer;
       property ClientID : string read FClientID write FClientID;
       property OrderID : string read FOrderID write FOrderID;
       property ResponseDate : TDateTime read FResponseDate write FResponseDate;

       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; override;
   end;

   TResponses = class(TCraftingCollection)
   public
       constructor Create; reintroduce; overload;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; virtual;
       function First(var AResponse : TResponse) : Boolean; reintroduce; overload;
       function Next(var AResponse : TResponse) : Boolean; reintroduce; overload;
       function Add : TResponse;
   end;

type
   TMISMOResponseEnvelope = class(TMISMOEnvelope)
   private
       FRespondingParty : TContact;
       FRespondToParty : TContact;
       FResponses : TResponses;
       function GetResponse(Index : Integer) : TResponse;
   protected
       function GetOrderID : string; override;
   public
       constructor Create; virtual;
       destructor Destroy; override;
       procedure Clear; override;

       property RespondingParty : TContact read FRespondingParty;
       property RespondToParty : TContact read FRespondToParty;

       property Responses[Index : Integer] : TResponse read GetResponse; default;
       function AddResponse : TResponse;
       function ResponseCount : Integer;

       procedure Parse(AnXMLElement : TXMLElement); override;
       procedure Compose(AnXMLElement : TXMLElement); override;
       function GetDescription(const LinePrefix : string = EMPTY_STRING) : string; override;
   end;

   TMessageEnvelope = class(TMISMOResponseEnvelope)
   private
       FReplyRequested : Boolean;
       FOrderID : string;
       FPriority : string;
       FMessage : string;
       FDate : TDateTime;
   protected
       function GetOrderID : string; override;
       procedure SetOrderID(Value : string); override;
   public
       property Date : TDateTime read FDate write FDate;
       property OrderID : string read FOrderID write FOrderID;
       property ReplyRequested : Boolean read FReplyRequested write FReplyRequested;
       property Priority : string read FPriority write FPriority;
       property Message : string read FMessage write FMessage;
       procedure Compose(AnXMLElement : TXMLElement); override;
       procedure Parse(AnXMLElement : TXMLElement); override;
   end;

   TStatusEnvelope = class(TMISMOResponseEnvelope)
   private
       FMessage : string;
       FOrderID : string;
       FStatus : TAppraisalOrderStatus;
       FDate : TDateTime;
       FInspectionDate : TDateTime;
   protected
       function GetOrderID : string; override;
       procedure SetOrderID(Value : string); override;
   public
       property Status : TAppraisalOrderStatus read FStatus write FStatus;
       property Date : TDateTime read FDate write FDate;
       property Message : string read FMessage write FMessage;
       property InspectionDate : TDateTime read FInspectionDate write FInspectionDate;
       property OrderID : string read FOrderID write FOrderID;
       procedure Compose(AnXMLElement : TXMLElement); override;
       procedure Parse(AnXMLElement : TXMLElement); override;
   end;

function ComposeStatusEnvelope(FromID, ToID, AnOrderID : string;
   NewStatus : TeTracStatus; AComment : string = ''; ADate : TDateTime = 0.0) : string;

implementation

uses
   SysUtils, uInternetUtils, UWindowsInfo, uMISMOImportExport;

function MISMOBoolToStr(AnExpression : Boolean) : string;
begin
   if AnExpression then
       Result := 'Y'
   else
       Result := 'N';
end;

function ContactPointRoleToStr(ARole : TContactPointRole) : string;
begin
   Result := CONTACT_POINT_ROLE_NAMES[ARole];
end;

function StrToContactPointRole(const AString : string) : TContactPointRole;
begin
   Result := High(TContactPointRole);
   repeat
       if CONTACT_POINT_ROLE_NAMES[Result] = AString then
           Exit;
       Dec(Result);
   until Result = Low(TContactPointRole);                  //  cprUnknown
end;

function ContactPointTypeToStr(AType : TContactPointType) : string;
begin
   Result := CONTACT_POINT_TYPE_NAMES[AType];
end;

function StrToContactPointType(const AString : string) : TContactPointType;
begin
   Result := High(TContactPointType);
   repeat
       if CONTACT_POINT_TYPE_NAMES[Result] = AString then
           Exit;
       Dec(Result);
   until Result = Low(TContactPointType);                  //   cptUnknown
end;

function StrToResponseFormat(const AString : string) : TPreferredFormat;
begin
   Result := High(TPreferredFormat);
   repeat
       if PREFERRED_FORMAT_NAMES[Result] = AString then
           Exit;
       Dec(Result);
   until Result = Low(TPreferredFormat);                   //pfUnknown
end;

function StrToResponseMethod(const AString : string) : TDeliveryMethod;
begin
   Result := High(TDeliveryMethod);
   repeat
       if PREFERRED_DELIVERY_NAMES[Result] = AString then
           Exit;
       Dec(Result);
   until Result = Low(TDeliveryMethod);                    //  dmUnknown
end;

function PreferredFormatToStr(AFormat : TPreferredFormat) : string;
begin
   Result := PREFERRED_FORMAT_NAMES[AFormat];
end;

function PreferredDeliveryMethodToStr(ADeliveryMethod : TDeliveryMethod) : string;
begin
   Result := PREFERRED_DELIVERY_NAMES[ADeliveryMethod];
end;

{  TMISMOEnvelope  }

procedure TMISMOEnvelope.AfterConstruction;
begin
   inherited;
   Clear;
end;

procedure TMISMOEnvelope.Clear;
begin
   inherited;
   FMISMOVersion := DEFAULT_MISMO_VERSION;
end;

procedure TMISMOEnvelope.AssignTo(Target : TPersistent);
begin
   if Target is TXMLCollection then
       Compose(TXMLCollection(Target))

   else if Target is TStrings then
       TStrings(Target).Text := Self.AsXML

   else
       inherited AssignTo(Target);
end;

function TMISMOEnvelope.GetDescription(const LinePrefix : string) : string;
begin
   Result := #13#10 + LinePrefix + 'MISMOVersion=' + Self.MismoVersion;
end;

procedure TMISMOEnvelope.Compose(AnXML : TXMLCollection);
begin
   Compose(AnXML.RootElement);
end;

procedure TMISMOEnvelope.Parse(const AText : string);
begin
   with TXMLCollection.Create do
   try
       AsString := AText;                                  //  load the collection

       Self.Parse(RootElement);                            //  load the envelope from the collection
   finally
       Free;
   end;
end;

procedure TMISMOEnvelope.Parse(AnXML : TXMLCollection);
begin
   Parse(AnXML.RootElement);
end;

procedure TMISMOEnvelope.Assign(Source : TPersistent);
begin
   if Source is TXMLCollection then
       Parse(TXMLCollection(Source))

   else if Source is TStrings then
       Self.AsXML := TStrings(Source).Text

   else
       inherited Assign(Source);
end;

function TMISMOEnvelope.GetAsXML : string;
var
   ThisXML : TXMLCollection;
begin
   ThisXML := TXMLCollection.Create;
   try
       Compose(ThisXML);
       Result := ThisXML.AsString;
   finally
       ThisXML.Free;
   end;
end;

procedure TMISMOEnvelope.SetAsXML(Value : string);
var
   ThisXML : TXMLCollection;
begin
   ThisXML := TXMLCollection.Create;
   try
       ThisXML.AsString := Value;
       Parse(ThisXML);
   finally
       ThisXML.Free;
   end;
end;

function TMISMOEnvelope.Compose : string;
var
   ThisXML : TXMLCollection;
begin
   ThisXML := TXMLCollection.Create;
   try
       Compose(ThisXML);
       Result := ThisXML.AsString;
   finally
       ThisXML.Free;
   end;
end;

function TMISMOEnvelope.GetOrderID : string;
begin
   raise Exception.Create('No OrderID available');
end;

procedure TMISMOEnvelope.SetOrderID(Value : string);
begin
   raise Exception.Create('No OrderID available');
end;

{  TMISMORequestEnvelope   }

constructor TMISMORequestEnvelope.Create;
begin
   inherited;

   FReceivingParty := TContact.Create;
   FSubmittingParty := TSubmittingParty.Create;
   FRequestingParties := TContacts.Create(TRequestingParty);
   FRequests := TPayloads.Create(TRequest);
end;

destructor TMISMORequestEnvelope.Destroy;
begin
   FRequestingParties.Free;
   FRequests.Free;

   inherited;
end;

procedure TMISMORequestEnvelope.Clear;
begin
   inherited;
   FReceivingParty.Clear;
   FSubmittingParty.Clear;
   FRequestingParties.Clear;
   FRequests.Clear;
end;

function TMISMORequestEnvelope.GetDescription(const LinePrefix : string) : string;
begin
   Result := inherited GetDescription(LinePrefix);

   Result := TrimRight(Result + #13#10 + FReceivingParty.GetDescription(LinePrefix + 'ReceivingParty') +
       FSubmittingParty.GetDescription(LinePrefix + 'SubmittingParty') +
       FRequestingParties.GetDescription(LinePrefix + 'RequestingParties') +
       FRequests.GetDescription(LinePrefix + 'Requests'));
end;

function TMISMORequestEnvelope.AddRequestingParty : TRequestingParty;
begin
   Result := FRequestingParties.Add as TRequestingParty;
   Assert(Result.PreferredResponse <> nil);
end;

function TMISMORequestEnvelope.GetRequestingParty(Index : Integer) : TRequestingParty;
begin
   Result := FRequestingParties.Items[Index] as TRequestingParty;
end;

function TMISMORequestEnvelope.RequestingPartyCount : Integer;
begin
   Result := FRequestingParties.Count;
end;

function TMISMORequestEnvelope.GetRequest(Index : Integer) : TRequest;
begin
   Result := FRequests.Items[Index] as TRequest;
end;

function TMISMORequestEnvelope.AddRequest : TRequest;
begin
   Result := FRequests.Add as TRequest;
   Result.FEnvelope := Self;
end;

function TMISMORequestEnvelope.RequestCount : Integer;
begin
   Result := FRequests.Count;
end;

procedure TMISMORequestEnvelope.Parse(AnXMLElement : TXMLElement);
var
   ThisElement : TXMLElement;
begin
   Self.Clear;

   if AnXMLElement.Name <> REQUEST_ROOT_ELEMENT_NAME then
       AnXMLElement := AnXMLElement.FindElement(REQUEST_ROOT_ELEMENT_NAME);

   with AnXMLElement do
   begin
       if AttributeExists('MISMOVersionID') then
           Self.MismoVersion := AttributeValues['MISMOVersionID'];

       SubmittingParty.Parse(FindElement('REQUESTING_PARTY'));

       ReceivingParty.Parse(FindElement('RECEIVING_PARTY'));

       if FirstElement('REQUESTING_PARTY', ThisElement) then
       begin
           repeat
               AddRequestingParty.Parse(ThisElement);
           until not NextElement('REQUESTING_PARTY', ThisElement);
       end;

       if FirstElement('REQUEST', ThisElement) then
       begin
           repeat
               AddRequest.Parse(ThisElement);
           until not NextElement('REQUEST', ThisElement);
       end;
   end;
end;

procedure TMISMORequestEnvelope.Compose(AnXMLElement : TXMLElement);
var
   Counter : Integer;
begin
   AnXMLElement.Name := REQUEST_ROOT_ELEMENT_NAME;
   AnXMLElement.AttributeValues['MISMOVersionID'] := Self.MismoVersion;
   with AnXMLElement do
   begin
       for Counter := 0 to RequestingPartyCount - 1 do
           RequestingParties[Counter].Compose(AddElement('REQUESTING_PARTY'));

       SubmittingParty.Compose(AddElement('SUBMITTING_PARTY'));

       ReceivingParty.Compose(AddElement('RECEIVING_PARTY'));

       for Counter := 0 to RequestCount - 1 do
           Requests[Counter].Compose(AddElement('REQUEST'));
   end;
end;

function ComposeResponse(FromID, ToID, OrderID : string; NewStatus : TeTracStatus) : string;
begin
   with TMISMOResponseEnvelope.Create do
   try
       RespondingParty.Identifier := FromID;
       RespondToParty.Identifier := ToID;

       FResponses.Add.AddStatus.Status := NewStatus;

       Result := Compose;
   finally
       Free;
   end;
end;

function TMISMORequestEnvelope.GetOrderID : string;
begin
   case RequestCount of
       0 : raise Exception.Create('No requests in this envelope');
       1 :
           begin
               case Requests[0].Orders.Count of
                   0 : raise Exception.Create('No orders in this envelope');

                   1 : Result := Requests[0].Orders[0].OrderID;
               else
                   raise Exception.Create('More than one order in this envelope');
               end;
           end;
   else
       raise Exception.Create('More than one request in this envelope');
   end;
end;

{  TMISMOResponseEnvelope  }

constructor TMISMOResponseEnvelope.Create;
begin
   inherited;

   FRespondingParty := TContact.Create;
   FRespondToParty := TContact.Create;
   FResponses := TResponses.Create;
end;

destructor TMISMOResponseEnvelope.Destroy;
begin
   FRespondingParty.Free;
   FRespondToParty.Free;
   FResponses.Free;

   inherited;
end;

procedure TMISMOResponseEnvelope.Clear;
begin
   inherited;
   FRespondingParty.Clear;
   FRespondToParty.Clear;
   FResponses.Clear;
end;

function TMISMOResponseEnvelope.GetDescription(const LinePrefix : string) : string;
begin
   Result := inherited GetDescription(LinePrefix);

   Result := TrimRight(Result + #13#10 +
       RespondingParty.GetDescription(LinePrefix + 'RespondingParty') +
       RespondToParty.GetDescription(LinePrefix + 'RespondToParty') +
       FResponses.GetDescription(LinePrefix + 'Responses'));
end;

function TMISMOResponseEnvelope.GetResponse(Index : Integer) : TResponse;
begin
   Result := FResponses.Items[Index] as TResponse;
end;

function TMISMOResponseEnvelope.AddResponse : TResponse;
begin
   Result := FResponses.Add as TResponse;
   Result.FEnvelope := Self;
end;

function TMISMOResponseEnvelope.ResponseCount : Integer;
begin
   Result := FResponses.Count;
end;

procedure TMISMOResponseEnvelope.Parse(AnXMLElement : TXMLElement);
var
   ThisElement, RootElement : TXMLElement;
begin
   Self.Clear;

   if AnXMLElement.Name = RESPONSE_ROOT_ELEMENT_NAME then
       RootElement := AnXMLElement
   else
       RootElement := AnXMLElement.FindElement(RESPONSE_ROOT_ELEMENT_NAME);

   if RootElement <> nil then
   begin
       with RootElement do
       begin
           if AttributeExists('MISMOVersionID') then
               MismoVersion := AttributeValues['MISMOVersionID'];
           RespondingParty.Parse(FindElement('RESPONDING_PARTY'));
           RespondToParty.Parse(FindElement('RESPOND_TO_PARTY'));

           if FirstElement('RESPONSE', ThisElement) then
           begin
               repeat
                   AddResponse.Parse(ThisElement);
               until not NextElement('RESPONSE', ThisElement);
           end;
       end;
   end
   else
end;

procedure TMISMOResponseEnvelope.Compose(AnXMLElement : TXMLElement);
var
   Counter : Integer;
begin
   AnXMLElement.Name := RESPONSE_ROOT_ELEMENT_NAME;
   AnXMLElement.AttributeValues['MISMOVersionID'] := Self.MismoVersion;
   with AnXMLElement do
   begin
       RespondingParty.Compose(AddElement('RESPONDING_PARTY'));

       RespondToParty.Compose(AddElement('RESPOND_TO_PARTY'));

       for Counter := 0 to ResponseCount - 1 do
           Responses[Counter].Compose(AddElement('RESPONSE'));
   end;
end;

function TMISMOResponseEnvelope.GetOrderID : string;
begin
   case ResponseCount of
       0 : raise Exception.Create('No Responses in this envelope');

       1 : Result := Responses[0].OrderID;

   else
       raise Exception.Create('More than one Response in this envelope');
   end;
end;

{   TResponseStatus    }

procedure TResponseStatus.Clear;
begin
   FCondition := EMPTY_STRING;
   FCode := -1;
   FName := EMPTY_STRING;
   FDescription := EMPTY_STRING;
end;

function TResponseStatus.GetDescription(const LinePrefix : string) : string;
begin
   Result := #13#10 + LinePrefix + 'Name=' + Name + #13#10 +
       LinePrefix + 'Code=' + IntToStr(Code) + #13#10 +
       LinePrefix + 'Condition=' + Condition + #13#10 +
       LinePrefix + 'Description=' + Description;
end;

function TResponseStatus.Compose : string;
begin
   with TXMLCollection.Create do
   try
       RootElement.Name := 'STATUS';
       Self.Compose(RootElement);

       Result := AsString;
   finally
       Free;
   end;
end;

procedure TResponseStatus.Compose(AnElement : TXMLElement);
begin
   with AnElement do
   begin
       AttributeValues['_Name'] := Self.Name;              //  e.g. Accepted
       AttributeValues['_Code'] := IntToStr(Self.Code);    //  e.g. etsAccepted
       AttributeValues['_Condition'] := Self.Condition;    //  e.g. <date>
       AttributeValues['_Description'] := Self.Description;
   end;
end;

procedure TResponseStatus.Parse(const AText : string);
begin
   with TXMLCollection.Create do
   try
       try
           AsString := AText;
       except
           on EXMLUnsupportedByteOrderError do
               AsString := ComposeHeader + AText;          //  add an XML header to the string
       end;
   finally
       Free;
   end;
end;

procedure TResponseStatus.Parse(AnElement : TXMLElement);
begin
   if AnElement <> nil then
   begin
       Self.FCode := StrToIntDef(AnElement.AttributeValues['_Code'], -1);
       Self.FName := AnElement.AttributeValues['_Name'];
       Self.FCondition := AnElement.AttributeValues['_Condition'];
       Self.FDescription := AnElement.AttributeValues['_Description'];
   end;
end;

function TResponseStatus.GetStatus : TeTracStatus;
begin
   Result := CodeToStatus(Self.Code);
   if Result = etsUnknown then
       Result := UMismoOrderObjects.StrToStatus(Self.Name);
end;

procedure TResponseStatus.SetStatus(Value : TeTracStatus);
begin
   FName := UMismoOrderObjects.StatusToStr(Value);
   FCode := UMismoOrderObjects.StatusToCode(Value);
end;

procedure TResponseStatus.SetCode(const Value : Integer);
begin
   if FCode <> Value then
       Status := UMismoOrderObjects.CodeToStatus(Value);
end;

procedure TResponseStatus.SetName(const Value : string);
begin
   if FName <> Value then
       Status := UMismoOrderObjects.StrToStatus(Value);
end;

{   TPayloads  }

function TPayloads.GetDescription(const LinePrefix : string) : string;
var
   ThisPayload : TPayload;
begin
   Result := EMPTY_STRING;
   if First(ThisPayload) then
       repeat
           Result := Result + #13#10 + ThisPayload.GetDescription(LinePrefix);
       until not Next(ThisPayload);
end;

function TPayloads.First(var APayload : TPayload) : Boolean;
begin
   Result := inherited First(TCollectionItem(APayload));
end;

function TPayloads.Next(var APayload : TPayload) : Boolean;
begin
   Result := inherited Next(TCollectionItem(APayload));
end;

{  TPayload    }

constructor TPayload.Create(ACollection : TCollection);
begin
   inherited;
   FKeyData := nil;                                        //  create on demand
   FXML := nil;
end;

destructor TPayload.Destroy;
begin
   FKeyData.Free;
   FXML.Free;

   inherited;
end;

procedure TPayload.Clear;
begin
   FInternalAccount := EMPTY_STRING;

   if FKeyData <> nil then
       FKeyData.Clear;

   if FXML <> nil then
       FXML.Clear;
end;

function TPayload.GetDescription(const LinePrefix : string) : string;
var
   Counter : Integer;
begin
   Result := EMPTY_STRING;

   if InternalAccount <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'InternalAccount=' + InternalAccount;
   if LoginAccountName <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'LoginAccountName=' + LoginAccountName;
   if LoginAccountPassword <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'LoginAccountPassword=' + LoginAccountPassword;

   if FKeyData <> nil then
   begin
       for Counter := 0 to FKeyData.Count - 1 do
       begin
           Result := Result + #13#10 + LinePrefix + 'Key' + FKeyData.Names[Counter] + '=' +
               FKeyData.ValueStrings[Counter];
       end;
   end;
end;

function TPayload.GetKeyData : TStrings;
begin
   if FKeyData = nil then
       FKeyData := TCraftingStringList.Create;

   Result := FKeyData;
end;

function TPayload.GetData : TXMLElement;
begin
   Result := XML.RootElement;                              //  creates FXML if necessary
end;

procedure TPayload.SetData(AnElement : TXMLElement);
begin
   if (Self.Data <> AnElement) then
       XML.Assign(AnElement);
end;

procedure TPayload.Compose(AnElement : TXMLElement);
var
   Counter : Integer;
begin
   with AnElement do
   begin
       AttributeValues['InternalAccountIdentifier'] := Self.InternalAccount;
       AttributeValues['LoginAccountIdentifier'] := Self.LoginAccountName;
       AttributeValues['LoginAccountPassword'] := Self.LoginAccountPassword;

       for Counter := 0 to Keys.Count - 1 do
           AddElement('KEY', ['_Name', Keys.Names[Counter], '_Value', Keys.Values[Keys.Names[Counter]]]);
   end;
end;

procedure TPayload.Parse(AnElement : TXMLElement);
var
   KeyElement : TXMLElement;
begin
   Self.Clear;

   if AnElement <> nil then
   begin
       with AnElement do
       begin
           Self.InternalAccount := AttributeValues['InternalAccountIdentifier'];
           Self.LoginAccountName := AttributeValues['LoginAccountIdentifier'];
           Self.LoginAccountPassword := AttributeValues['LoginAccountpassword'];

           if FirstElement('KEY', KeyElement) then
           begin
               repeat
                   Keys.Add(KeyElement.AttributeValues['_Name'] + '=' + KeyElement.AttributeValues['_Value']);
               until not NextElement('KEY', KeyElement);
           end;
       end;
   end;
end;

function TPayload.GetXML : TXMLCollection;
begin
   if FXML = nil then
       FXML := TXMLCollection.Create;
   Result := FXML;
end;

{   TValuations    }

constructor TValuations.Create;
begin
   Create(TValuation);
end;

function TValuations.Add : TValuation;
begin
   Result := inherited Add as TValuation;
end;

function TValuations.First(var AValuation : TValuation) : Boolean;
begin
   Result := First(TCollectionItem(AValuation));
end;

function TValuations.Next(var AValuation : TValuation) : Boolean;
begin
   Result := Next(TCollectionItem(AValuation));
end;

function TValuations.GetValuation(Index : Integer) : TValuation;
begin
   Result := Items[Index] as TValuation;
end;

{  TOrder      }

constructor TOrder.Create(ACollection : TCollection);
begin
   inherited;
   FValuations := TValuations.Create;
end;

destructor TOrder.Destroy;
begin
   FValuations.Free;
   inherited;
end;

function TOrder.GetDescription(const LinePrefix : string) : string;
begin
   Result := '';

   if AcceptanceDueDate <> EMPTY_DATE then
   begin
       Result := Result + #13#10 + LinePrefix + 'AcceptanceDueDate=' +
           uInternetUtils.DateTimeToISO8601(AcceptanceDueDate);
   end;

   if DueDate <> EMPTY_DATE then
       Result := Result + #13#10 + LinePrefix + 'RequestDate=' + uInternetUtils.DateTimeToISO8601(DueDate);

   if IsInformalRequested then
       Result := Result + #13#10 + LinePrefix + 'InformalReportRequested=True';

   if InformalDueDate <> EMPTY_DATE then
       Result := Result + #13#10 + LinePrefix + 'InformalDueDate=' + uInternetUtils.DateTimeToISO8601(InformalDueDate);

   Result := Result + #13#10 + LinePrefix + 'PleaseConfirmBeforeAssignment=' +
       uCraftClass.BoolToStr(PleaseConfirmBeforeAssignment);
end;

procedure TOrder.Parse(AnElement : TXMLElement);            //      The VALUATION_REQUEST element
var
   ThisElement : TXMLElement;
begin
   PleaseConfirmBeforeAssignment :=
       uCraftClass.StrToBool(AnElement.AttributeValues['ConfirmAppraiserBeforeAssignmentIndicator']);
   SpecialInstructions := AnElement.AttributeValues['SpecialInstructionsDescription'];
   IsInformalRequested := uCraftClass.StrToBool(AnElement.AttributeValues['AppraisalEstimateVarianceAdvisoryIndicator']);
   OrderID := AnElement.AttributeValues['RequestorOrderReferenceIdentifier'];

   if AnElement.FindElement('_PRODUCT', ThisElement) then
   begin
       DueDate := uInternetUtils.ISO8601ToDateTime(ThisElement.AttributeValues['RequestedCompletionDueDate']);
       AcceptanceDueDate := uInternetUtils.ISO8601ToDateTime(ThisElement.AttributeValues['RequestedAcceptaceDueDate']);
   end;
end;

procedure TOrder.Compose(AnElement : TXMLElement);
begin
   if AnElement <> nil then
   begin
       AnElement.AttributeValues['RequestorOrderReferenceIdentifier'] := OrderID;
       AnElement.AttributeValues['AppraisalEstimateVarianceAdvisoryIndicator'] := uCraftClass.BoolToStr(IsInformalRequested);
       AnElement.AttributeValues['InformalReportDueDate'] := uInternetUtils.DateTimeToISO8601(InformalDueDate);

       AnElement.AttributeValues['ConfirmOrderProviderBeforeAssignmentIndicator'] :=
           uCraftClass.BoolToStr(PleaseConfirmBeforeAssignment);
       AnElement.AttributeValues['SpecialInstructionsDescription'] := SpecialInstructions;

       with AnElement.OpenElement('_PRODUCT') do
       begin
           AttributeValues['RequestedCompletionDueDate'] := uInternetUtils.DateTimeToISO8601(DueDate);
           AttributeValues['RequestedAcceptaceDueDate'] := uInternetUtils.DateTimeToISO8601(AcceptanceDueDate);
       end;
   end;
end;

{   TOrders    }

constructor TOrders.Create;
begin
   Create(TOrder);
end;

function TOrders.First(var AOrder : TOrder) : Boolean;
begin
   Result := First(TCollectionItem(AOrder));
end;

function TOrders.Next(var AOrder : TOrder) : Boolean;
begin
   Result := Next(TCollectionItem(AOrder));
end;

function TOrders.GetOrder(Index : Integer) : TOrder;
begin
   Result := Items[Index] as TOrder;
end;

function TOrders.Add : TOrder;
begin
   Result := inherited Add as TOrder;
end;

{  TRequest    }

constructor TRequest.Create(ACollection : TCollection);
begin
   inherited;
   FOrders := TOrders.Create;
end;

destructor TRequest.Destroy;
begin
   FOrders.Free;
   inherited;
end;

function TRequest.GetClientName : string;
begin
   Result := (Envelope as TMISMORequestEnvelope).SubmittingParty.CompanyName;
end;

function TRequest.GetAppraiserName : string;
begin
   Result := (Envelope as TMISMORequestEnvelope).ReceivingParty.CompanyName;
end;

function TRequest.GetDescription(const LinePrefix : string) : string;
var
   ThisOrder : TOrder;
begin
   Result := inherited GetDescription(LinePrefix);

   if RequestDate <> EMPTY_DATE then
       Result := Result + #13#10 + LinePrefix + 'RequestDate=' + uInternetUtils.DateTimeToISO8601(RequestDate);

   if Priority <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'RequestDate=' + Priority;

   if FOrders.First(ThisOrder) then
   begin
       repeat
           Result := Result + ThisOrder.GetDescription(LinePrefix);
       until not FOrders.Next(ThisOrder);
   end;
end;

procedure TRequest.Parse(AnElement : TXMLElement);
var
   DataElement, RequestElement : TXMLElement;
begin
   inherited Parse(AnElement);

   if AnElement <> nil then
   begin
       RequestDate := uInternetUtils.ISO8601ToDateTime(AnElement.AttributeValues['RequestDatetime']);
       InternalAccountIdentifier := AnElement.AttributeValues['InternalAccountIdentifier'];
       LoginAccountIdentifier := AnElement.AttributeValues['LoginAccountIdentifier'];
       LoginAccountPassword := AnElement.AttributeValues['LoginAccountPassword'];
       RequestingPartyBranchIdentifier := AnElement.AttributeValues['RequestingPartyBranchIdentifier'];

       if AnElement.FindElement('REQUEST_DATA', DataElement) then
       begin
           if DataElement.FindElement('VALUATION_REQUEST', RequestElement) then
           begin
               Priority := RequestElement.AttributeValues['PriorityDescription'];

               FOrders.Add.Parse(RequestElement);
           end;

           Self.XML.Assign(DataElement);                   //  the root of the nested FXML will be VALUATION_REQUEST
       end;
   end;
end;

procedure TRequest.Compose(AnElement : TXMLElement);
begin
   inherited Compose(AnElement);

   AnElement.AttributeValues['RequestDatetime'] := uInternetUtils.DateTimeToISO8601(Self.RequestDate);
   AnElement.AttributeValues['InternalAccountIdentifier'] := InternalAccountIdentifier;
   AnElement.AttributeValues['LoginAccountIdentifier'] := LoginAccountIdentifier;
   AnElement.AttributeValues['LoginAccountPassword'] := LoginAccountPassword;
   AnElement.AttributeValues['RequestingPartyBranchIdentifier'] := RequestingPartyBranchIdentifier;

   if Self.FXML <> nil then
   begin
       AnElement.OpenElement('REQUEST_DATA').
           OpenElement(uMISMOImportExport.APPRAISAL_RESPONSE_ELEMENT_NAME).Assign(Self.Data);
   end;
end;

{  TResponses  }

constructor TResponses.Create;
begin
   Create(TResponse);
end;

function TResponses.GetDescription(const LinePrefix : string) : string;
var
   ThisResponse : TResponse;
begin
   Result := EMPTY_STRING;

   if First(ThisResponse) then
       repeat
           Result := Result + ThisResponse.GetDescription(LinePrefix + 'Response');
       until not Next(ThisResponse);
end;

function TResponses.First(var AResponse : TResponse) : Boolean;
begin
   Result := inherited First(TCollectionItem(AResponse));
end;

function TResponses.Next(var AResponse : TResponse) : Boolean;
begin
   Result := inherited Next(TCollectionItem(AResponse));
end;

function TResponses.Add : TResponse;
begin
   Result := inherited Add as TResponse;
end;

{  TStatuses }

constructor TStatuses.Create;
begin
   Create(TResponseStatus);
end;

function TStatuses.GetDescription(const LinePrefix : string) : string;
var
   ThisStatus : TResponseStatus;
begin
   Result := EMPTY_STRING;

   if First(ThisStatus) then
       repeat
           Result := Result + ThisStatus.GetDescription(LinePrefix + 'Status');
       until not Next(ThisStatus);
end;

function TStatuses.First(var AStatus : TResponseStatus) : Boolean;
begin
   Result := inherited First(TCollectionItem(AStatus));
end;

function TStatuses.Next(var AStatus : TResponseStatus) : Boolean;
begin
   Result := inherited Next(TCollectionItem(AStatus));
end;

{  TResponse    }

constructor TResponse.Create(ACollection : TCollection);
begin
   inherited;
   FStatuses := TStatuses.Create;
   FReports := TCraftingStringList.Create;
   FResponseDate := SysUtils.Now;
end;

destructor TResponse.Destroy;
begin
   FStatuses.Free;
   FReports.Free;
   inherited;
end;

function TResponse.GetDescription(const LinePrefix : string) : string;
begin
   Result := inherited GetDescription(LinePrefix) + FStatuses.GetDescription(LinePrefix + 'Status');

   if ResponseDate <> EMPTY_DATE then
       Result := Result + #13#10 + LinePrefix + 'ResponseDate=' + uInternetUtils.DateTimeToISO8601(Self.ResponseDate);
end;

procedure TResponse.Parse(AnElement : TXMLElement);
var
   ThisElement : TXMLElement;
begin
   inherited Parse(AnElement);

   OrderID := Keys.Values['OrderID'];
   ClientID := Keys.Values['ClientID'];

   if AnElement <> nil then
   begin
       if AnElement.FirstElement('STATUS', ThisElement) then
       begin
           repeat
               AddStatus.Parse(ThisElement);
           until not AnElement.NextElement('STATUS', ThisElement);
       end;

       if AnElement.AttributeValues['ResponseDateTime'] <> EMPTY_STRING then
           Self.ResponseDate := uInternetUtils.ISO8601ToDateTime(AnElement.AttributeValues['ResponseDateTime']);

       if AnElement.FirstElement('RESPONSE_DATA', ThisElement) then
       begin
           Self.Data.Assign(ThisElement);
           repeat
               if ThisElement.ElementCount > 0 then
                   FReports.Add(ThisElement.Elements[0].Compose);

           until not AnElement.NextElement('RESPONSE_DATA', ThisElement);
       end;
   end;
end;

procedure TResponse.Compose(AnElement : TXMLElement);
var
   Counter : Integer;
begin
   inherited Compose(AnElement);

   with AnElement do
   begin
       AttributeValues['ResponseDateTime'] := uInternetUtils.DateTimeToISO8601(Self.ResponseDate);

       if Self.FXML <> nil then
       begin
           if not Self.Data.IsEmpty then
               AddElement('RESPONSE_DATA').Assign(Self.Data);
       end;

       for Counter := 0 to StatusCount - 1 do
           Statuses[Counter].Compose(AddElement('STATUS'));
   end;
end;

function TResponse.GetStatus(Index : Integer) : TResponseStatus;
begin
   Result := FStatuses.Items[Index] as TResponseStatus;
end;

function TResponse.AddStatus : TResponseStatus;
begin
   Result := FStatuses.Add as TResponseStatus;
end;

function TResponse.StatusCount : Integer;
begin
   Result := FStatuses.Count;
end;

function TResponse.GetReport(Index : Integer) : string;
begin
   Result := FReports.Strings[Index];
end;

procedure TResponse.AddReport(const AText : string);
begin
   FReports.Add(AText);
end;

function TResponse.ReportCount : Integer;
begin
   Result := FReports.Count;
end;

{  TContacts   }

constructor TContacts.Create;
begin
   Create(TContact);
end;

function TContacts.GetDescription(const LinePrefix : string) : string;
var
   ThisContact : TContact;
begin
   Result := EMPTY_STRING;

   if First(ThisContact) then
   begin
       repeat
           Result := Result + ThisContact.GetDescription(LinePrefix + 'Contact');
       until not Next(ThisContact);
   end;
end;

function TContacts.First(var AContact : TContact) : Boolean;
begin
   Result := inherited First(TCollectionItem(AContact));
end;

function TContacts.Next(var AContact : TContact) : Boolean;
begin
   Result := inherited Next(TCollectionItem(AContact));
end;

{  TContact    }

constructor TContact.Create;
begin
   FDetails := TCraftingCollection.Create(TContactDetail);
end;

destructor TContact.Destroy;
begin
   FDetails.Free;
   inherited;
end;

procedure TContact.Clear;
begin
   FDetails.Clear;
   FName := EMPTY_STRING;
   FStreetAddress := EMPTY_STRING;
   FStreetAddress2 := EMPTY_STRING;
   FCity := EMPTY_STRING;
   FState := EMPTY_STRING;
   FPostalCode := EMPTY_STRING;
   FCountry := EMPTY_STRING;
end;

function TContact.QuickName : string;
begin
   if DetailCount > 0 then
       Result := Details[0].Name + ' (' + Self.CompanyName + ')'
   else
       Result := Self.CompanyName;
end;

function TContact.GetDescription(const LinePrefix : string) : string;
var
   DetailCounter : Integer;
begin
   Result := '';
   if CompanyName <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'CompanyName=' + CompanyName;
   if StreetAddress <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'StreetAddress=' + StreetAddress;
   if StreetAddress2 <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'StreetAddress2=' + StreetAddress2;
   if City <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'City=' + City;
   if State <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'State=' + State;
   if PostalCode <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'PostalCode=' + PostalCode;
   if Country <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'Country=' + Country;
   if Identifier <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'Identifier=' + Identifier;

   for DetailCounter := 0 to DetailCount - 1 do
   begin
       Result := TrimLeft(Result + #13#10) +
           Details[DetailCounter].GetDescription(LinePrefix + 'Detail' + IntToStr(DetailCounter));
   end;
end;

function TContact.AddDetail : TContactDetail;
begin
   Result := FDetails.Add as TContactDetail;
end;

function TContact.GetContactDetail(Index : Integer) : TContactDetail;
begin
   Result := FDetails.Items[Index] as TContactDetail;
end;

function TContact.DetailCount : Integer;
begin
   Result := FDetails.Count;
end;

procedure TContact.Parse(AnElement : TXMLElement);
var
   ThisElement : TXMLElement;
begin
   if AnElement <> nil then
   begin
       with AnElement do
       begin
           Self.CompanyName := AttributeValues['_Name'];
           Self.StreetAddress := AttributeValues['_StreetAddress'];
           Self.StreetAddress2 := AttributeValues['_StreetAddress2'];
           Self.City := AttributeValues['_City'];
           Self.State := AttributeValues['_State'];
           Self.PostalCode := AttributeValues['_PostalCode'];
           Self.Country := AttributeValues['_Country'];
           Self.Identifier := AttributeValues['_Identifier'];

           if FirstElement('CONTACT_DETAIL', ThisElement) then
           begin
               repeat
                   AddDetail.Parse(ThisElement);
               until not NextElement('CONTACT_DETAIL', ThisElement);
           end;
       end;
   end;
end;

procedure TContact.Compose(AnElement : TXMLElement);
var
   Counter : Integer;
begin
   with AnElement do
   begin
       AttributeValues['_Name'] := Self.CompanyName;
       AttributeValues['_StreetAddress'] := StreetAddress;
       AttributeValues['_StreetAddress2'] := StreetAddress2;
       AttributeValues['_City'] := City;
       AttributeValues['_State'] := State;
       AttributeValues['_PostalCode'] := PostalCode;
       AttributeValues['_Country'] := Country;
       AttributeValues['_Identifier'] := Self.Identifier;

       for Counter := 0 to DetailCount - 1 do
           Details[Counter].Compose(AddElement('CONTACT_DETAIL'));
   end;
end;

{  TContactDetail  }

destructor TContactDetail.Destroy;
begin
   FContactPoints.Free;
   inherited;
end;

procedure TContactDetail.Clear;
begin
   FName := EMPTY_STRING;
   if FContactPoints <> nil then
       FContactPoints.Clear;
end;

function TContactDetail.GetDescription(const LinePrefix : string) : string;
var
   Counter : Integer;
begin
   if Name <> EMPTY_STRING then
       Result := #13#10 + LinePrefix + 'Name=' + Self.Name
   else
       Result := EMPTY_STRING;

   for Counter := 0 to ContactPointCount - 1 do
   begin
       Result := TrimLeft(Result + #13#10) +
           ContactPoint[Counter].GetDescription(LinePrefix + 'Point' + IntToStr(Counter));
   end;
end;

function TContactDetail.GetContactPoints : TCraftingCollection;
begin
   if FContactPoints = nil then
       FContactPoints := TCraftingCollection.Create(TContactPoint);
   Result := FContactPoints;
end;

function TContactDetail.AddContactPoint : TContactPoint;
begin
   Result := ContactPoints.Add as TContactPoint;
end;

function TContactDetail.GetContactPoint(Index : Integer) : TContactPoint;
begin
   Result := ContactPoints.Items[Index] as TContactPoint;
end;

function TContactDetail.ContactPointCount : Integer;
begin
   if FContactPoints = nil then
       Result := 0
   else
       Result := FContactPoints.Count;
end;

procedure TContactDetail.Parse(AnElement : TXMLElement);
var
   ThisElement : TXMLElement;
begin
   Clear;

   if AnElement <> nil then
   begin
       Self.Name := AnElement.AttributeValues['_Name'];

       if AnElement.FirstElement('CONTACT_POINT', ThisElement) then
       begin
           repeat
               AddContactPoint.Parse(ThisElement);
           until not AnElement.NextElement('CONTACT_POINT', ThisElement);
       end;
   end;
end;

procedure TContactDetail.Compose(AnElement : TXMLElement);
var
   Counter : Integer;
begin
   AnElement.AttributeValues['_Name'] := Self.Name;
   for Counter := 0 to ContactPointCount - 1 do
       ContactPoint[Counter].Compose(AnElement.AddElement('CONTACT_POINT'), Self);
end;

{  TRequestingParty    }

constructor TRequestingParty.Create;
begin
   inherited;
   FPreferredResponse := TPreferredResponse.Create;
end;

destructor TRequestingParty.Destroy;
begin
   FPreferredResponse.Free;
   inherited;
end;

procedure TRequestingParty.Clear;
begin
   inherited;
   FPreferredResponse.Clear;
end;

function TRequestingParty.GetDescription(const LinePrefix : string) : string;
begin
   Result := inherited GetDescription(LinePrefix) +
       TrimRight(#13#10 + FPreferredResponse.GetDescription(LinePrefix + 'PreferredResponse'));
end;

procedure TRequestingParty.Parse(AnElement : TXMLElement);
begin
   inherited Parse(AnElement);
   if AnElement <> nil then
       PreferredResponse.Parse(AnElement);
end;

procedure TRequestingParty.Compose(AnElement : TXMLElement);
begin
   inherited Compose(AnElement);
   PreferredResponse.Compose(AnElement);
end;

{  TSubmittingParty    }

procedure TSubmittingParty.Clear;
begin
   inherited;
   FLoginAccountIdentifier := EMPTY_STRING;
   FLoginAccountPassword := EMPTY_STRING;
end;

function TSubmittingParty.GetDescription(const LinePrefix : string) : string;
begin
   Result := inherited GetDescription(LinePrefix);
   if LoginAccountIdentifier <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'LoginAccountIdentifier=' + LoginAccountIdentifier;
   if LoginAccountPassword <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'LoginAccountPassword=' + LoginAccountPassword;
   if SequenceIdentifier <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'SequenceIdentifier=' + SequenceIdentifier;
end;

procedure TSubmittingParty.Parse(AnElement : TXMLElement);
begin
   inherited Parse(AnElement);

   if AnElement <> nil then
   begin
       LoginAccountIdentifier := AnElement.AttributeValues['LoginAccountIdentifier'];
       LoginAccountPassword := AnElement.AttributeValues['LoginAccountPassword'];
       SequenceIdentifier := AnElement.AttributeValues['SequenceIdentifier'];
   end;
end;

procedure TSubmittingParty.Compose(AnElement : TXMLElement);
begin
   inherited Compose(AnElement);

   AnElement.AttributeValues['LoginAccountIdentifier'] := LoginAccountIdentifier;
   AnElement.AttributeValues['LoginAccountPassword'] := LoginAccountPassword;
   AnElement.AttributeValues['SequenceIdentifier'] := SequenceIdentifier;
end;

{  TPreferredResponse  }

procedure TPreferredResponse.Clear;
begin
   FFormat := pfUnknown;
   FMethod := dmUnknown;
   FFormatOther := EMPTY_STRING;
   FMethodOther := EMPTY_STRING;
   FDestination := EMPTY_STRING;
end;

function TPreferredResponse.GetDescription(const LinePrefix : string) : string;
begin
   Result := EMPTY_STRING;
   if FFormat <> pfUnknown then
       Result := Result + #13#10 + LinePrefix + 'Format=' + PreferredFormatToStr(FFormat);
   if FMethod <> dmUnknown then
       Result := Result + #13#10 + LinePrefix + 'Method=' + PreferredDeliveryMethodToStr(FMethod);
   if FFormatOther <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'FormatOther=' + FFormatOther;
   if FMethodOther <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'MethodOther=' + FMethodOther;
   if FDestination <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'Destination=' + FDestination;
end;

procedure TPreferredResponse.Parse(AnElement : TXMLElement);
begin
   if AnElement <> nil then
   begin
       Self.Format := StrToResponseFormat(AnElement.AttributeValues['_Format']);
       Self.Method := StrToResponseMethod(AnElement.AttributeValues['_Method']);
       Self.FormatOther := AnElement.AttributeValues['_FormatOtherDescription'];
       Self.MethodOther := AnElement.AttributeValues['_MethodOther'];
       Self.Destination := AnElement.AttributeValues['_Destination'];
   end;
end;

procedure TPreferredResponse.Compose(AnElement : TXMLElement);
begin
   with AnElement do
   begin
       AttributeValues['_Format'] := PREFERRED_FORMAT_NAMES[Self.Format];
       AttributeValues['_Method'] := PREFERRED_DELIVERY_NAMES[Self.Method];
       AttributeValues['_FormatOtherDescription'] := Self.FormatOther;
       AttributeValues['_MethodOther'] := Self.MethodOther;
       AttributeValues['_Destination'] := Self.Destination;
   end;
end;

{  TContactPoint   }

procedure TContactPoint.Clear;
begin
   FRole := cprUnknown;
   FContactType := cptUnknown;
   FDescription := EMPTY_STRING;
   FValue := EMPTY_STRING;
end;

function TContactPoint.GetDescription(const LinePrefix : string) : string;
begin
   Result := EMPTY_STRING;

   if Value <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'Value=' + Value;
   if Role <> cprUnknown then
       Result := Result + #13#10 + LinePrefix + 'Role=' + ContactPointRoleToStr(Role);
   if ContactType <> cptUnknown then
       Result := Result + #13#10 + LinePrefix + 'Type=' + ContactPointTypeToStr(ContactType);
   if Description <> EMPTY_STRING then
       Result := Result + #13#10 + LinePrefix + 'Description=' + Description;
end;

procedure TContactPoint.Parse(AnElement : TXMLElement; ADetail : TContactDetail = nil);
begin
   if AnElement <> nil then
   begin
       with AnElement do
       begin
           Self.Role := StrToContactPointRole(AttributeValues['_RoleType']);
           Self.ContactType := StrToContactPointType(AttributeValues['_Type']);
           Self.Description := AttributeValues['_TypeOtherDescription'];
           Self.Value := AttributeValues['_Value'];
           if (ADetail <> nil) and uCraftClass.StrToBool(AttributeValues['_PreferenceIndicator']) then
               ADetail.PreferredContactPoint := Self
       end;
   end;
end;

procedure TContactPoint.Compose(AnElement : TXMLElement; ADetail : TContactDetail = nil);
begin
   with AnElement do
   begin
       AttributeValues['_RoleType'] := CONTACT_POINT_ROLE_NAMES[Self.Role];
       AttributeValues['_Type'] := CONTACT_POINT_TYPE_NAMES[Self.ContactType];
       AttributeValues['_TypeOtherDescription'] := Self.Description;
       AttributeValues['_Value'] := Self.Value;
       if ADetail <> nil then
           AttributeValues['_PreferenceIndicator'] := MISMOBoolToStr(ADetail.PreferredContactPoint = Self);
   end;
end;

{ TStatusEnvelope }

function ComposeStatusEnvelope(FromID, ToID, AnOrderID : string;
   NewStatus : TeTracStatus; AComment : string; ADate : TDateTime) : string;
var
   ThisEnvelope : TStatusEnvelope;
begin
   ThisEnvelope := TStatusEnvelope.Create;
   with ThisEnvelope do
   try
       RespondingParty.Identifier := FromID;
       RespondToParty.Identifier := ToID;
       OrderID := AnOrderID;
       InspectionDate := ADate;
       Date := SysUtils.Now;

       Status := NewStatus;
       Message := AComment;

       Result := Compose;
   finally
       Free;
   end;
end;

function TStatusEnvelope.GetOrderID : string;
begin
   Result := FOrderID;
end;

procedure TStatusEnvelope.SetOrderID(Value : string);
begin
   inherited;
   FOrderID := Value;
end;

procedure TStatusEnvelope.Parse(AnXMLElement : TXMLElement);
var
   ThisElement : TXMLElement;
begin
   inherited;
   if AnXMLElement.FindElement('/RESPONSE_GROUP/RESPONSE/APPRAISAL_STATUS', ThisElement) then
   begin
       Self.Status := CodeToStatus(StrToIntDef(ThisElement.AttributeValues['_Code'], -1));
       if Self.Status = etsUnknown then
           Self.Status := StrToStatus(ThisElement.AttributeValues['_Name']);

       Self.Date := uInternetUtils.ISO8601ToDateTime(ThisElement.AttributeValues['_Date']);
       Self.Message := ThisElement.AttributeValues['_Message'];
       Self.InspectionDate := uInternetUtils.ISO8601ToDateTime(ThisElement.AttributeValues['InspectionDate']);
       Self.OrderID := ThisElement.AttributeValues['VenderOrderIdentifier'];
   end;
end;

procedure TStatusEnvelope.Compose(AnXMLElement : TXMLElement);
begin
   if Self.Status = etsUnknown then
       raise Exception.Create('This status envelope does not have any status set');

   inherited Compose(AnXMLElement);

   with AnXMLElement.OpenElement('/RESPONSE_GROUP/RESPONSE/APPRAISAL_STATUS') do
   begin
       AttributeValues['_Code'] := IntToStr(StatusToCode(Self.Status));
       AttributeValues['_Name'] := StatusToStr(Self.Status);

       AttributeValues['_Date'] := uInternetUtils.DateTimeToISO8601(Self.Date);
       AttributeValues['_Message'] := Self.Message;
       AttributeValues['InspectionDate'] := uInternetUtils.DateTimeToISO8601(Self.InspectionDate);
       AttributeValues['VenderOrderIdentifier'] := Self.OrderID;
   end;
end;

{ TMessageEnvelope }

function TMessageEnvelope.GetOrderID : string;
begin
   Result := FOrderID;
end;

procedure TMessageEnvelope.SetOrderID(Value : string);
begin
   FOrderID := Value;
end;

procedure TMessageEnvelope.Compose(AnXMLElement: TXMLElement);
begin
   inherited Compose(AnXMLElement);

   with AnXMLElement.OpenElement('/RESPONSE_GROUP/RESPONSE/APPRAISAL_MESSAGE') do
   begin
       AttributeValues['_Date'] := uInternetUtils.DateTimeToISO8601(Self.Date);
       AttributeValues['_Message'] := Self.Message;
       AttributeValues['_ReplyRequestedIndicator'] := MISMOBoolToStr(Self.ReplyRequested);
       AttributeValues['_PriorityDescription'] := Self.Priority;
       AttributeValues['_VenderOrderIdentifier'] := Self.OrderID;
   end;
end;

procedure TMessageEnvelope.Parse(AnXMLElement: TXMLElement);
var
   ThisElement : TXMLElement;
begin
   inherited;
   if AnXMLElement.FindElement('/RESPONSE_GROUP/RESPONSE/APPRAISAL_MESSAGE', ThisElement) then
   begin
       Self.Date := uInternetUtils.ISO8601ToDateTime(ThisElement.AttributeValues['_Date']);
       Self.Message := ThisElement.AttributeValues['_Message'];
       Self.ReplyRequested := StrToBool(ThisElement.AttributeValues['_ReplyRequestedIndicator']);
       Self.Priority := ThisElement.AttributeValues['_PriorityDescription'];
       Self.OrderID := ThisElement.AttributeValues['_VenderOrderIdentifier'];
   end;
end;

end.

