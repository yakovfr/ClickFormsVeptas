{          This does NOT handle multiple products per request  }

unit UMismoOrderObjects;

interface

uses
   Windows, Classes, uCraftClass, Graphics, uCraftXML, uMISMOImportExport;

type
   TPropertyType = (ptUnknown, ptSingleFamily, ptCondominium, ptCondominiumOverFourStories, ptTownhouse,
       ptCooperative, ptTwoToFourUnitProperty, ptMultifamilyMoreThanFourUnits, ptManufacturedMobileHome,
       ptCommercialNonResidential, ptMixedUseResidential, ptFarm, ptHomeAndBusinessCombined, ptVacantLand,
       ptChurch, ptOther);
   TPropertyTypes = set of TPropertyType;

   TPropertyCompletionType = (pctUnknown, pctProposed, pctIncomplete, pctComplete, pctExisting);
   TPropertyCompletionTypes = set of TPropertyCompletionType;

   TAppraisalType = (atUnknown, atAppraisalInterior, atAppraisalExterior, atInspectionInterior, atInspectionExterior,
       atFieldReview, atDesktopReview, atAppraisalUpdate, atCompletionCertificate, atRentSurvey, atGroundLeaseAnalysis,
       atAutomatedValuation, atOther);
   TAppraisalTypes = set of TAppraisalType;

   TeTracStatus = (etsUnknown, etsAssigned, etsCanceled, etsCompleted, etsInspected, etsOnHold, etsReleased,
       etsScheduled, etsInReview, etsInProgress, etsUnassigned, etsDeleted, etsLeftMsg, etsNoAnswer,
       etsBeingTyped, etsReferToComments, etsReviewed, etsReceivedByAppraiser,
       etsAcceptedByAppraiser, etsDeclinedByAppraiser, etsAcceptedByAppraiserConditionally, etsDelivered,
       etsDraft, etsSent, etsInRevision, etsUpgradeNeeded, etsDelayed, etsResumed);

   TAppraisalOrderStatus = TeTracStatus;

   TeTracStatuses = set of TeTracStatus;
   TAppraisalOrderStatuses = TeTracStatuses;

   TPaymentMethod = (pmUnknown, pmCODCheck, pmCODCreditCard, pmInvoice, pmContract, pmPurchaseOrder, pmOther);
   TPaymentMethods = set of TPaymentMethod;

   TAppraisalCommunicationMode = (acmNone, acmReceive, acmSend, acmBroker);
   TAppraisalCommunicationModes = set of TAppraisalCommunicationMode;

   TEMailFormat = (efUnknown, efPDF, efXML);
   TEMailFormats = set of TEMailFormat;

const
   MAX_ORDER_ID_LENGTH = 20;
   MAX_CLIENT_ID_LENGTH = 50;
   MAX_NAME_LENGTH = 50;
   MAX_STATUS_LENGTH = 20;

   BASE_ELEMENT_NAME = 'APPRAISAL_REQUEST';

   PROPERTY_TYPE_NAMES : array[TPropertyType] of string = ('Unknown', 'Single Family', 'Condominium',
       'Condominium Over Four Stories', 'Townhouse', 'Cooperative', 'Two To Four Unit Property',
       'Multifamily More Than Four Units', 'Manufactured Mobile Home', 'Commercial Non-Residential',
       'Mixed-Use Residential', 'Farm', 'Home And Business Combined', 'Vacant Land', 'Church', 'Other');

   APPRAISAL_TYPE_NAMES : array[TAppraisalType] of string = ('Unknown', 'Appraisal Interior', 'Appraisal Exterior',
       'Inspection Interior', 'Inspection Exterior', 'Field Review', 'Desktop Review', 'Appraisal Update',
       'Completion Certificate', 'Rent Survey', 'Ground Lease Analysis', 'Automated Valuation', 'Other');

   ETRAC_STATUS_CODE_TYPES : array[0..27] of TeTracStatus = (etsUnknown, etsReceivedByAppraiser,
       etsAcceptedByAppraiser, etsDeclinedByAppraiser, etsAcceptedByAppraiserConditionally, etsAssigned, etsScheduled,
       etsInspected, etsInReview, etsDelayed, etsResumed, etsSent, etsInRevision, etsUpgradeNeeded, etsCompleted,
       etsBeingTyped, etsInProgress, etsUnassigned, etsDeleted, etsLeftMsg, etsNoAnswer, etsReferToComments, etsReviewed,
       etsDelivered, etsDraft, etsOnHold, etsCanceled, etsCanceled);

   ETRAC_STATUS_NAMES : array[TeTracStatus] of string = ('Unknown', 'Assigned', 'Canceled', 'Completed', 'Inspected',
       'On Hold', 'Released', 'Scheduled', 'In Review', 'In Progress', 'Unassigned', 'Deleted', 'Left Msg',
       'No Answer', 'Being Typed', 'Refer To Comments', 'Reviewed',
       'Received by Appraiser', 'Accepted by Appraiser', 'Declined by Appraiser', 'Declined Conditionally', 'Delivered',
       'Draft', 'Sent', 'In Revision', 'Upgrade Needed', 'Delayed', 'Resumed');

   ETRAC_STATUS_TYPE_CODES : array[TeTracStatus] of Integer =
   (0, 5, 24, 0, 7, 22, 23, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 0, 0, 11, 12, 20, 9, 10);

   APPRAISAL_RECEIVED_STATUSES = [etsReceivedByAppraiser];
   APPRAISAL_WORKING_STATUSES = [etsAcceptedByAppraiser, etsInProgress, etsScheduled, etsInspected, etsOnHold];
   APPRAISAL_OPEN_STATUSES = APPRAISAL_RECEIVED_STATUSES + APPRAISAL_WORKING_STATUSES;
   APPRAISAL_DONE_STATUSES = [etsCompleted, etsDeclinedByAppraiser, etsCanceled, etsDelivered];

   PAYMENT_METHOD_NAMES : array[TPaymentMethod] of string = ('Unknown', 'COD Check', 'COD Credit Card', 'Invoice',
       'Contract', 'Purchase Order', 'Other');
   EMAIL_FORMAT_NAMES : array[TEMailFormat] of string = ('Unknown', 'PDF', 'XML');

type
   TAppraisalOrders = class;

   TAppraisalOrder = class(TCraftingCollectionItem)
   private
       FDueDate : TDateTime;
       FRequestedDate : TDateTime;
       FScheduledDate : TDateTime;
       FInspectedDate : TDateTime;
       FDeliveredDate : TDateTime;
       FAcceptedRejectedDate : TDateTime;
       FAcceptanceDueDate : TDateTime;
       FCompletedDate : TDateTime;
       FPaidDate : TDateTime;
       FLastUpdate : TDateTime;
       FStatus : TAppraisalOrderStatus;
       FStatusDate : TDateTime;
       FPriorStatus : TeTracStatus;
       FAppraisalType : TAppraisalType;
       FOnChange : TNotifyEvent;
       FRequesterName : string;
       FRequesterCompany : string;
       FPropertyAddress : string;
       FRequesterID : string;
       FAppraiserID : string;
       FPropertyType : TPropertyType;
       FText : string;
       FClientTrackingID : string;
       FPriority : string;
       FBorrowerName : string;
       FIsInformalRequested : Boolean;
       FInternalID : string;

       function GetStringProperty(Index : Integer) : string;
       procedure SetStringProperty(Index : Integer; const Value : string);
       function GetDateProperty(Index : Integer) : TDateTime;
       procedure SetDateProperty(Index : Integer; Value : TDateTime);
       procedure SetStatus(Value : TeTracStatus);
       procedure SetAppraisalType(Value : TAppraisalType);
       procedure SetIsInformalRequested(Value : Boolean);

       procedure SetPropertyType(Value : TPropertyType);
   protected
       function GetIndexName : string; override;
       procedure Changed(AllItems : Boolean = False); override;
       function Orders : TAppraisalOrders;
   public
       procedure Clear; override;
       procedure Assign(Source : TPersistent); override;

       property DueDate : TDateTime index 1 read GetDateProperty write SetDateProperty;
       property RequestedDate : TDateTime index 2 read GetDateProperty write SetDateProperty;
       property DeliveredDate : TDateTime index 3 read GetDateProperty write SetDateProperty;
       property CompletedDate : TDateTime index 10 read GetDateProperty write SetDateProperty;
       property PaidDate : TDateTime index 11 read GetDateProperty write SetDateProperty;
       property IsInformalRequested : Boolean read FIsInformalRequested write SetIsInformalRequested default False;
       property AcceptanceDueDate : TDateTime index 5 read GetDateProperty write SetDateProperty;
       property AcceptedRejectedDate : TDateTime index 6 read GetDateProperty write SetDateProperty;
       property ScheduledDate : TDateTime index 7 read GetDateProperty write SetDateProperty;
       property InspectedDate : TDateTime index 8 read GetDateProperty write SetDateProperty;
       property Status : TeTracStatus read FStatus write SetStatus;
       property LastUpdate : TDateTime index 9 read GetDateProperty write SetDateProperty;
       property PriorStatus : TeTracStatus read FPriorStatus;
       property AppraisalType : TAppraisalType read FAppraisalType write SetAppraisalType;

       property RequesterName : string index 1 read GetStringProperty write SetStringProperty;
       property Text : string index 2 read GetStringProperty write SetStringProperty;
       property ClientTrackingID : string index 3 read GetStringProperty write SetStringProperty;
       property Priority : string index 4 read GetStringProperty write SetStringProperty;
       property PropertyAddress : string index 5 read GetStringProperty write SetStringProperty;
       property AppraiserID : string index 6 read GetStringProperty write SetStringProperty;
       property RequesterID : string index 7 read GetStringProperty write SetStringProperty;
       property BorrowerName : string index 8 read GetStringProperty write SetStringProperty;
       property RequesterCompany : string index 9 read GetStringProperty write SetStringProperty;

       property InternalID : string read FInternalID write FInternalID;

       property OnChange : TNotifyEvent read FOnChange write FOnChange;

       property PropertyType : TPropertyType read FPropertyType write SetPropertyType;

       procedure ParseEnvelope(const AFileContent : string); overload;
       procedure ParseEnvelope(ARootElement : TXMLElement; ATranslator : TMISMOTranslator = nil); overload;
       function ComposeEnvelope : string; overload;
       procedure ComposeEnvelope(AnElement : TXMLElement); overload;
       procedure ComposeEnvelope(ATranslator : TMISMOTranslator); overload;
   end;

   TDateRange = class(TPersistent)
   private
       FHigh : TDateTime;
       FLow : TDateTime;
       procedure SetHigh(Value : TDateTime);
       procedure SetLow(Value : TDateTime);
   public
       procedure Clear;
       property High : TDateTime read FHigh write SetHigh;
       property Low : TDateTime read FLow write SetLow;
       function IsDateWithinRange(ADate : TDateTime) : Boolean;
   end;

   TAppraisalOrdersFilter = class(TPersistent)
   private
       FOrderStatuses : TeTracStatuses;
       FAppraisalTypes : TAppraisalTypes;
       FPropertyTypes : TPropertyTypes;
       FRequester : string;
       FDueDate : TDateRange;
       FRequestDate : TDateRange;
   public
       constructor Create;
       destructor Destroy; override;
       procedure Clear;
       property OrderStatuses : TeTracStatuses read FOrderStatuses write FOrderStatuses;
       property AppraisalTypes : TAppraisalTypes read FAppraisalTypes write FAppraisalTypes;
       property PropertyTypes : TPropertyTypes read FPropertyTypes write FPropertyTypes;
       property Requester : string read FRequester write FRequester;
       property DueDate : TDateRange read FDueDate write FDueDate;
       property RequestDate : TDateRange read FRequestDate write FRequestDate;

       function DoesFitCriteria(AnOrder : TAppraisalOrder) : Boolean;
   end;

   TAppraisalOrdersSequence = (aosNone, aosDateDue, aosPriority, aosRequester);

   TAppraisalOrders = class(TCraftingCollection)
   private
       FFilter : TAppraisalOrdersFilter;
       FSequence : TAppraisalOrdersSequence;

       function GetOrder(Index : Integer) : TAppraisalOrder;
       function GetFilter : TAppraisalOrdersFilter;
       procedure SetSequence(Value : TAppraisalOrdersSequence);
   public
       constructor Create(ACollectionItemClass : TCollectionItemClass); overload;
       constructor Create; reintroduce; overload;
       destructor Destroy; override;
       procedure Clear; override;
       property Orders[Index : Integer] : TAppraisalOrder read GetOrder;
       function Add(AnOrder : TAppraisalOrder = nil) : TAppraisalOrder; overload;
       function First(var AnOrder : TAppraisalOrder; AnOrderStatuses : TeTracStatuses = []) : Boolean; reintroduce; overload;
       function First(var AnOrder : TAppraisalOrder; AFilter : TAppraisalOrdersFilter) : Boolean; reintroduce; overload;
       function Next(var AnOrder : TAppraisalOrder; AnOrderStatuses : TeTracStatuses = []) : Boolean; reintroduce; overload;
       function Next(var AnOrder : TAppraisalOrder; AFilter : TAppraisalOrdersFilter) : Boolean; reintroduce; overload;
       property Filter : TAppraisalOrdersFilter read GetFilter;
       property Sequence : TAppraisalOrdersSequence read FSequence write SetSequence;
       function Find(ARequesterID, AClientTrackingID : string) : TAppraisalOrder; overload;
       function Find(ARequesterID, AClientTrackingID : string; var AnOrder : TAppraisalOrder) : Boolean; overload;
       function Find(AnInternalID : string) : TAppraisalOrder; overload;
       function Find(AnInternalID : Integer) : TAppraisalOrder; overload;
       function Find(AnInternalID : string; var AnOrder : TAppraisalOrder) : Boolean; overload;
       function Find(AnInternalID : Integer; var AnOrder : TAppraisalOrder) : Boolean; overload;

       procedure LoadFromText(const AText : string);
       procedure LoadFromFile(const AFileName : string);
       function SaveToText : string;
       procedure SaveToFile(const AFileName : string); override;
   end;

function StrToStatus(const AString : string) : TeTracStatus;
function StatusToStr(AStatus : TeTracStatus) : string;
function CodeToStatus(ACode : Integer) : TeTracStatus;
function StatusToCode(AStatus : TeTracStatus) : Integer;
function PropertyTypeToStr(AType : TPropertyType) : string;
function StrToPropertyType(const AString : string) : TPropertyType;
function AppraisalTypeToStr(AType : TAppraisalType) : string;
function StrToAppraisalType(const AString : string) : TAppraisalType;
function PaymentMethodToStr(AMethod : TPaymentMethod) : string;
function StrToPaymentMethod(const AString : string) : TPaymentMethod;
function EMailFormatToStr(AFormat : TEMailFormat) : string;
function StrToEMailFormat(const AString : string) : TEMailFormat;

implementation

uses
   SysUtils, uInternetUtils, UWindowsInfo;

const
   NO_ID = -1;

function StatusToStr(AStatus : TeTracStatus) : string;
begin
   Result := ETRAC_STATUS_NAMES[AStatus];
end;

function StatusToCode(AStatus : TeTracStatus) : Integer;
begin
   Result := ETRAC_STATUS_TYPE_CODES[AStatus];
end;

function CodeToStatus(ACode : Integer) : TeTracStatus;
begin
   if (ACode >= 0) and (ACode <= High(ETRAC_STATUS_CODE_TYPES)) then
       Result := ETRAC_STATUS_CODE_TYPES[ACode]
   else
       Result := etsUnknown;
end;

function StrToStatus(const AString : string) : TeTracStatus;
begin
   Result := High(TeTracStatus);
   while Result > Low(TeTracStatus) do                     //  Low(TeTractStatus) = aosUnknown
   begin
       if SameAlpha(StatusToStr(Result), AString) then
           Break;
       Dec(Result);
   end;
end;

function PropertyTypeToStr(AType : TPropertyType) : string;
begin
   Result := PROPERTY_TYPE_NAMES[AType];
end;

function StrToPropertyType(const AString : string) : TPropertyType;
begin
   Result := High(TPropertyType);
   while Result > Low(TPropertyType) do                    //  Low(TPropertyType) = ptUnknown
   begin
       if SameAlpha(PropertyTypeToStr(Result), AString) then //  ignore case and spaces
           Break;
       Dec(Result);
   end;
end;

function AppraisalTypeToStr(AType : TAppraisalType) : string;
begin
   Result := APPRAISAL_TYPE_NAMES[AType];
end;

function StrToAppraisalType(const AString : string) : TAppraisalType;
begin
   Result := High(TAppraisalType);
   while Result > Low(TAppraisalType) do                   //  Low(TAppraisalType) = atUnknown
   begin
       if SameAlpha(AppraisalTypeToStr(Result), AString) then //  ignore spaces
           Break;
       Dec(Result);
   end;
end;

function PaymentMethodToStr(AMethod : TPaymentMethod) : string;
begin
   Result := PAYMENT_METHOD_NAMES[AMethod];
end;

function StrToPaymentMethod(const AString : string) : TPaymentMethod;
begin
   Result := High(TPaymentMethod);
   while Result > Low(TPaymentMethod) do                   //  Low(TPaymentMethod) = pmUnknown
   begin
       if SameText(PaymentMethodToStr(Result), AString) then
           Break;
       Dec(Result);
   end;
end;

function EMailFormatToStr(AFormat : TEMailFormat) : string;
begin
   Result := EMAIL_FORMAT_NAMES[AFormat];
end;

function StrToEMailFormat(const AString : string) : TEMailFormat;
begin
   Result := High(TEMailFormat);
   while Result > Low(TEMailFormat) do                     //  Low(TEMailFormat) = efUnknown
   begin
       if SameText(EMailFormatToStr(Result), AString) then
           Break;
       Dec(Result);
   end;
end;

{  TAppraisalOrders    }

constructor TAppraisalOrders.Create;
begin
   Create(TAppraisalOrder);
end;

constructor TAppraisalOrders.Create(ACollectionItemClass : TCollectionItemClass);
begin
   inherited;
   Self.Clear;
   Self.LockOnUpdate := True;
end;

destructor TAppraisalOrders.Destroy;
begin
   FFilter.Free;
   inherited;
end;

procedure TAppraisalOrders.Clear;
begin
   inherited;

   if FFilter <> nil then
       FFilter.Clear;
end;

function TAppraisalOrders.GetOrder(Index : Integer) : TAppraisalOrder;
begin
   Result := TAppraisalOrder(Items[Index]);
end;

function TAppraisalOrders.GetFilter : TAppraisalOrdersFilter;
begin
   if FFilter = nil then
       FFilter := TAppraisalOrdersFilter.Create;
   Result := FFilter;
end;

function TAppraisalOrders.Add(AnOrder : TAppraisalOrder) : TAppraisalOrder;
begin
   if AnOrder <> nil then
   begin
       if (AnOrder.Collection = Self) then
       begin
           Result := AnOrder;
           Exit;
       end;
   end;

   Result := TAppraisalOrder(inherited Add);

   if AnOrder <> nil then
       Result.Assign(AnOrder);

   DoAdd(Result);
end;

function TAppraisalOrders.Find(AnInternalID : Integer; var AnOrder : TAppraisalOrder) : Boolean;
begin
   Result := Find(IntToStr(AnInternalID), AnOrder);
end;

function TAppraisalOrders.Find(AnInternalID : string; var AnOrder : TAppraisalOrder) : Boolean;
begin
   AnOrder := Find(AnInternalID);
   Result := AnOrder <> nil;
end;

function TAppraisalOrders.Find(AnInternalID : Integer) : TAppraisalOrder;
begin
   Result := Find(IntToStr(AnInternalID));
end;

function TAppraisalOrders.Find(AnInternalID : string) : TAppraisalOrder;
begin
   if Self.First(Result) then
   begin
       repeat
           if (Result.InternalID = AnInternalID) then
               Exit;
       until not Self.Next(Result);
   end;

   Result := nil;
end;

function TAppraisalOrders.Find(ARequesterID, AClientTrackingID : string; var AnOrder : TAppraisalOrder) : Boolean;
begin
   AnOrder := Find(ARequesterID, AClientTrackingID);
   Result := AnOrder <> nil;
end;

function TAppraisalOrders.Find(ARequesterID, AClientTrackingID : string) : TAppraisalOrder;
begin
   if First(Result) then
   begin
       repeat
           if (AClientTrackingID = Result.ClientTrackingID) and (ARequesterID = Result.RequesterID) then
               Exit;
       until not Next(Result);
   end;

   Result := nil;
end;

function TAppraisalOrders.First(var AnOrder : TAppraisalOrder; AnOrderStatuses : TeTracStatuses) : Boolean;
begin
   ResetIterator;
   Result := Next(AnOrder, AnOrderStatuses);
end;

function TAppraisalOrders.Next(var AnOrder : TAppraisalOrder; AnOrderStatuses : TeTracStatuses) : Boolean;
begin
   Result := inherited Next(TCollectionItem(AnOrder));

   while Result and (AnOrderStatuses <> []) and (not (AnOrder.Status in AnOrderStatuses)) do
       Result := inherited Next(TCollectionItem(AnOrder));
end;

function TAppraisalOrders.First(var AnOrder : TAppraisalOrder; AFilter : TAppraisalOrdersFilter) : Boolean;
begin
   ResetIterator;
   Result := Next(AnOrder, AFilter);
end;

function TAppraisalOrders.Next(var AnOrder : TAppraisalOrder; AFilter : TAppraisalOrdersFilter) : Boolean;
begin
   Result := inherited Next(TCollectionItem(AnOrder));

   while Result and (not AFilter.DoesFitCriteria(AnOrder)) do
       Result := inherited Next(TCollectionItem(AnOrder));
end;

procedure TAppraisalOrders.SetSequence(Value : TAppraisalOrdersSequence);
begin
   if Sequence <> Value then
   begin
       FSequence := Value;
       ClearIndex;
   end;
end;

procedure TAppraisalOrders.LoadFromFile(const AFileName : string);
begin
   LoadFromText(uWindowsInfo.FileText(AFileName));
end;

//         Allows multiple REQUEST_GROUPs and multiple REQUESTs within any REQUEST_GROUP

procedure TAppraisalOrders.LoadFromText(const AText : string);
var
   GroupElementList, RequestElementList : TXMLElementList;
   ThisElement, GroupElement, RequestElement : TXMLElement;
   DenormalizedXML : TXMLCollection;
   Counter : Integer;
begin
   Self.BeginUpdate;
   try
       Self.Clear;

       with TXMLCollection.Create do
       try
           GroupElementList := TXMLElementList.Create;
           RequestElementList := TXMLElementList.Create;
           try
               AsString := AText;

               if FindXPath('//' + REQUEST_ROOT_ELEMENT_NAME, GroupElementList) then //  find all of them
               begin
                   GroupElementList.First(GroupElement);
                   repeat
                       RequestElementList.Clear;

                       if GroupElement.FindXPath('/REQUEST', RequestElementList) then
                       begin
                           DenormalizedXML := TXMLCollection.Create; //     create a single-REQUEST group
                           try
                               DenormalizedXML.RootElement.Name := GroupElement.Name;
                               if GroupElement.FirstElement(ThisElement) then //      iterate over just the child elements of REQUEST_GROUP
                               begin
                                   repeat
                                       if ThisElement.Name <> 'REQUEST' then //  copy all the other envelope elements
                                           DenormalizedXML.RootElement.AddElement.Assign(ThisElement);
                                   until not GroupElement.NextElement(ThisElement);
                               end;

                               RequestElement :=
                                   DenormalizedXML.OpenElement('/' + REQUEST_ROOT_ELEMENT_NAME + '/REQUEST');

                               for Counter := 0 to RequestElementList.Count - 1 do
                               begin
                                   RequestElement.Assign(RequestElementList.Elements[Counter]); //  overwrites the previous //REQUEST
{$IFDEF DEBUG_DENORMALIZED_XML}
                                   DenormalizedXML.SaveToFile(uWindowsInfo.GetUnusedFileName('Denormalized Order Load.XML'));
{$ENDIF}
                                   Self.Add.ParseEnvelope(DenormalizedXML.RootElement) //      we have to load from the element because we don't know how many or where in the document the REQUEST_ROOT_ELEMENT_NAME element will be
                               end;
                           finally
                               DenormalizedXML.Free;
                           end;
                       end;
                   until not GroupElementList.Next(GroupElement);
               end;
           finally
               GroupElementList.Free;
               RequestElementList.Free;
           end;
       finally
           Free;
       end;
   finally
       Self.EndUpdate;
   end;
end;

function TAppraisalOrders.SaveToText : string;
var
   ThisOrder : TAppraisalOrder;
   ThisXML, ThatXML : TXMLCollection;
begin
   case Self.Count of
       0 : raise Exception.Create('No orders to save');
       1 : Result := Orders[0].ComposeEnvelope;
   else
       ThisXML := TXMLCollection.Create;
       ThatXML := TXMLCollection.Create;
       try
           ThisXML.RootElement.Name := 'APPRAISAL_ORDERS';

           Self.First(ThisOrder);
           repeat
               ThatXML.Clear;
               ThisOrder.ComposeEnvelope(ThatXML.RootElement);
               ThisXML.RootElement.AddElement.Assign(ThatXML.RootElement);
           until not Self.Next(ThisOrder);

           Result := ThisXML.AsString;
       finally
           ThisXML.Free;
           ThatXML.Free;
       end;
   end;
end;

procedure TAppraisalOrders.SaveToFile(const AFileName : string);
begin
   uWindowsInfo.WriteFile(AFileName, SaveToText);
end;

{  TAppraisalOrder }

procedure TAppraisalOrder.Clear;
begin
   FRequesterName := EMPTY_STRING;
   FRequesterCompany := EMPTY_STRING;
   FDueDate := EMPTY_DATE;
   FRequestedDate := EMPTY_DATE;
   FScheduledDate := EMPTY_DATE;
   FInspectedDate := EMPTY_DATE;
   FDeliveredDate := EMPTY_DATE;
   FAcceptedRejectedDate := EMPTY_DATE;
   FAcceptanceDueDate := EMPTY_DATE;
   FCompletedDate := EMPTY_DATE;
   FIsInformalRequested := False;
   FPaidDate := EMPTY_DATE;
   FStatus := etsUnknown;
   FPriorStatus := etsUnknown;
   FAppraisalType := atUnknown;
   FPropertyType := ptUnknown;
   FText := EMPTY_STRING;
   FClientTrackingID := EMPTY_STRING;
   FAppraiserID := EMPTY_STRING;
   FRequesterID := EMPTY_STRING;
end;

function TAppraisalOrder.GetIndexName : string;
begin
   case TAppraisalOrders(Collection).Sequence of
       aosNone : Result := InternalID;
       aosDateDue : Result := FormatDateTime('yyyymmddhhnnss', DueDate);
       aosPriority : Result := Priority;
       aosRequester : Result := RequesterCompany + RequesterName;
   end;
end;

function TAppraisalOrder.GetStringProperty(Index : Integer) : string;
begin
   case Index of
       1 : Result := FRequesterName;
       2 : Result := FText;
       3 : Result := FClientTrackingID;
       4 : Result := FPriority;
       5 : Result := FPropertyAddress;
       6 : Result := FAppraiserID;
       7 : Result := FRequesterID;
       8 : Result := FBorrowerName;
       9 : Result := FRequesterCompany;
   else
       raise Exception.Create('Internal error: TAppraisalOrder.GetStringProperty with index ' + IntToStr(Index));
   end;
end;

procedure TAppraisalOrder.SetStringProperty(Index : Integer; const Value : string);
begin
   if GetStringProperty(Index) <> Value then               //  this will throw an exception if the index is out of bounds
   begin
       case Index of
           1 : FRequesterName := Value;
           2 :
               begin
                   FText := Value;
                   ParseEnvelope(Value);
               end;
           3 : FClientTrackingID := Value;
           4 : FPriority := Value;
           5 : FPropertyAddress := Value;
           6 : FAppraiserID := Value;
           7 : FRequesterID := Value;
           8 : FBorrowerName := Value;
           9 : FRequesterCompany := Value;
       end;
       Self.Changed(False);                                //  calls Collection.Updated
   end;
end;

function TAppraisalOrder.GetDateProperty(Index : Integer) : TDateTime;
begin
   case Index of
       1 : Result := FDueDate;
       2 : Result := FRequestedDate;
       3 : Result := FDeliveredDate;
       5 : Result := FAcceptanceDueDate;
       6 : Result := FAcceptedRejectedDate;
       7 : Result := FInspectedDate;
       8 : Result := FScheduledDate;
       9 : Result := FLastUpdate;
       10 : Result := FCompletedDate;
       11 : Result := FPaidDate;
   else
       raise Exception.Create('Internal error:  TAppraisalOrder.GetDateProperty with index ' + IntToStr(Index));
   end;
end;

procedure TAppraisalOrder.SetDateProperty(Index : Integer; Value : TDateTime);
begin
   if GetDateProperty(Index) <> Value then                 //  this will throw an exception if the index is out of bounds
   begin
       case Index of
           1 : FDueDate := Value;
           2 : FRequestedDate := Value;
           3 : FDeliveredDate := Value;
           5 : FAcceptanceDueDate := Value;
           6 : FAcceptedRejectedDate := Value;
           7 : FInspectedDate := Value;
           8 : FScheduledDate := Value;
           9 : FLastUpdate := Value;
           10 : FCompletedDate := Value;
           11 : FPaidDate := Value;
       end;
       Self.Changed(False);
   end;
end;

procedure TAppraisalOrder.SetStatus(Value : TeTracStatus);
begin
   if FStatus <> Value then
   begin
       FPriorStatus := FStatus;
       FStatus := Value;
       if FStatusDate = EMPTY_DATE then
           FStatusDate := Now;
       Self.Changed(False);
   end;
end;

procedure TAppraisalOrder.SetAppraisalType(Value : TAppraisalType);
begin
   if FAppraisalType <> Value then
   begin
       FAppraisalType := Value;
       Self.Changed(False);
   end;
end;

procedure TAppraisalOrder.SetIsInformalRequested(Value : Boolean);
begin
   if FIsInformalRequested <> Value then
   begin
       FIsInformalRequested := Value;
       Self.Changed(False);
   end;
end;

procedure TAppraisalOrder.SetPropertyType(Value : TPropertyType);
begin
   if FPropertyType <> Value then
   begin
       FPropertyType := Value;
       Self.Changed(False);
   end;
end;

procedure TAppraisalOrder.Changed(AllItems : Boolean);
begin
   inherited;

   if not (Collection as TCraftingCollection).IsUpdating then
   begin
       Collection.BeginUpdate;
       Self.LastUpdate := SysUtils.Now;
       Collection.EndUpdate;
   end;
end;

procedure TAppraisalOrder.ParseEnvelope(const AFileContent : string);
var
   ThisTranslator : TMISMOTranslator;
begin
   Self.Collection.BeginUpdate;

   ThisTranslator := TMISMOTranslator.Create;
   try
       ThisTranslator.AsMISMOText := AFileContent;

       ParseEnvelope(ThisTranslator.XML.RootElement, ThisTranslator);
   finally
       ThisTranslator.Free;
       Self.Collection.EndUpdate;
   end;
end;

procedure TAppraisalOrder.ParseEnvelope(ARootElement : TXMLElement; ATranslator : TMISMOTranslator);
var
   ThisTranslator : TMISMOTranslator;
begin
   Self.Collection.BeginUpdate;

   //  private field access avoids recursion
   Self.FText := (ARootElement.Collection as TXMLCollection).ComposeHeader + #13#10 + ARootElement.Compose; //  don't import DTD

   ThisTranslator := nil;
   try
       if ATranslator = nil then
       begin
           ThisTranslator := TMISMOTranslator.Create;
           ATranslator := ThisTranslator;
       end;

       with ATranslator do
       begin
           BeginImport(ARootElement);

           RequestedDate := ISO8601ToDateTime(ImportValue(53102));
           RequesterCompany := ImportValue(50035);
           RequesterName := ImportValue(50034);
           InternalID := ImportValue(53500);

           if ImportValue(53506) <> '' then
               Status := CodeToStatus(StrToIntDef(ImportValue(53506), 0)); //  0 => etsUnknown
           if Status = etsUnknown then
               Status := StrToStatus(ImportValue(53507));

           if ImportValue(53508) <> '' then
               FStatusDate := ImportDateValue(53508);

           LastUpdate := ImportDateValue(53508);

           RequesterID := ImportValue(53411);              //      /REQUEST_GROUP/REQUESTING_PARTY/@_Identifier
           if RequesterID = '' then
               RequesterID := ImportValue(50102);          //      /REQUEST_GROUP/REQUEST/KEY[@_Name="RequestorID"]/@_Value

           AppraiserID := ImportValue(50103);
           ClientTrackingID := ImportValue(53100);
           IsInformalRequested := ImportBooleanValue(50118);
           DueDate := ImportDateValue(53104);
           AcceptanceDueDate := ImportDateValue(53103);
           AppraisalType := StrToAppraisalType(ImportValue(53350));
           PropertyType := StrToPropertyType(ImportValue(53429));
           PropertyAddress := Trim(NormalizeWhitespace(ImportValue(50046) + ' ' + ImportValue(50047) + ' ' +
               ImportValue(50048) + ' ' + ImportValue(50049) + ' ' + ImportValue(50050)));
           BorrowerName := ImportValue(50045);
       end;
   finally
       ThisTranslator.Free;                                //  locally created instance only
       Self.Collection.EndUpdate;
   end;
end;

function TAppraisalOrder.ComposeEnvelope : string;
var
   ThisTranslator : TMISMOTranslator;
begin
   ThisTranslator := TMISMOTranslator.Create;
   try
       ComposeEnvelope(ThisTranslator);

       Result := ThisTranslator.XML.AsString;
   finally
       ThisTranslator.Free;
   end;
end;

procedure TAppraisalOrder.ComposeEnvelope(AnElement : TXMLElement);
var
   ThisTranslator : TMISMOTranslator;
begin
   ThisTranslator := TMISMOTranslator.Create;
   try
       ComposeEnvelope(ThisTranslator);

       AnElement.Assign(ThisTranslator.XML.RootElement);   //      copy the translator XML to the element
   finally
       ThisTranslator.Free;
   end;
end;

procedure TAppraisalOrder.ComposeEnvelope(ATranslator : TMISMOTranslator);
begin
   with ATranslator do
   begin
       BeginExport(stRequestEnvelope, Self.Text);          //  load the stored XML text

       //             overwrite any changed values

       ExportDateValue(53102, RequestedDate);
       ExportValue(53411, RequesterID);
       ExportValue(50102, RequesterID);
       ExportValue(50103, AppraiserID);
       ExportValue(53100, ClientTrackingID);
       ExportValue(50118, 50119, IsInformalRequested);
       ExportDateValue(53104, DueDate);
       ExportDateValue(53103, AcceptanceDueDate);
       ExportValue(53350, AppraisalTypeToStr(AppraisalType));
       ExportValue(53429, PropertyTypeToStr(PropertyType));
       ExportValue(50045, BorrowerName);
       ExportValue(53500, InternalID);

       { TODO : Parse and distribute Property Address }//  50046..50050

       ExportValue(50035, RequesterCompany);
       ExportValue(50034, RequesterName);

       ExportValue(53506, StatusToCode(Self.Status));
       ExportValue(53507, StatusToStr(Self.Status));
       ExportDateValue(53508, LastUpdate);
   end;
end;

function TAppraisalOrder.Orders : TAppraisalOrders;
begin
   Result := Collection as TAppraisalOrders;
end;

procedure TAppraisalOrder.Assign(Source : TPersistent);
begin
   if Source is TAppraisalOrder then
   begin
       Self.Clear;

       with TAppraisalOrder(Source) do
       begin                                               //  assign to private properties because we don't want to flag this as changed (e.g. set LastUpdate to Now)
           Self.FDueDate := DueDate;
           Self.FRequestedDate := RequestedDate;
           Self.FScheduledDate := ScheduledDate;
           Self.FInspectedDate := InspectedDate;
           Self.FDeliveredDate := DeliveredDate;
           Self.FAcceptedRejectedDate := AcceptedRejectedDate;
           Self.FAcceptanceDueDate := AcceptanceDueDate;
           Self.FCompletedDate := CompletedDate;
           Self.FPaidDate := PaidDate;
           Self.FLastUpdate := LastUpdate;
           Self.FStatus := Status;
           Self.FPriorStatus := PriorStatus;               //  no mutator for this one
           Self.FAppraisalType := AppraisalType;
           Self.FRequesterName := RequesterName;
           Self.FRequesterCompany := RequesterCompany;
           Self.FPropertyAddress := PropertyAddress;
           Self.FRequesterID := RequesterID;
           Self.FAppraiserID := AppraiserID;
           Self.FPropertyType := PropertyType;
           Self.FText := Text;                             //  this is the raw XML
           Self.FClientTrackingID := ClientTrackingID;
           Self.FPriority := Priority;
           Self.FBorrowerName := BorrowerName;
           Self.FIsInformalRequested := IsInformalRequested;
           Self.FInternalID := InternalID;
       end;
   end
   else
       inherited Assign(Source);
end;

{  TAppraisalOrdersFilter  }

constructor TAppraisalOrdersFilter.Create;
begin
   inherited;
   FDueDate := TDateRange.Create;
   FRequestDate := TDateRange.Create;
   Self.Clear;
end;

destructor TAppraisalOrdersFilter.Destroy;
begin
   FDueDate.Free;
   FRequestDate.Free;
   inherited;
end;

procedure TAppraisalOrdersFilter.Clear;
begin
   FOrderStatuses := [];
   FAppraisalTypes := [];
   FPropertyTypes := [];
   FRequester := EMPTY_STRING;
   FDueDate.Clear;
   FRequestDate.Clear;
end;

function TAppraisalOrdersFilter.DoesFitCriteria(AnOrder : TAppraisalOrder) : Boolean;
begin
   if ((OrderStatuses = []) or (AnOrder.Status in OrderStatuses)) and
       ((AppraisalTypes = []) or (AnOrder.AppraisalType in AppraisalTypes)) and
       ((PropertyTypes = []) or (AnOrder.PropertyType in PropertyTypes)) and
       ((Requester = EMPTY_STRING) or uCraftClass.SameWildcardText(Requester, AnOrder.RequesterName)) and
       DueDate.IsDateWithinRange(AnOrder.DueDate) and
       RequestDate.IsDateWithinRange(AnOrder.DueDate) then
   begin
       Result := True;
   end
   else
       Result := False;
end;

{  TDateRange  }

procedure TDateRange.Clear;
begin
   FHigh := EMPTY_DATE;
   FLow := EMPTY_DATE;
end;

procedure TDateRange.SetHigh(Value : TDateTime);
begin
   if FHigh <> Value then
   begin
       if (Low <> EMPTY_DATE) and (Low > Value) then
           raise Exception.Create('The High date must be greater than the Low date');
       FHigh := Value;
   end;
end;

procedure TDateRange.SetLow(Value : TDateTime);
begin
   if FLow <> Value then
   begin
       if (High <> EMPTY_DATE) and (High < Value) then
           raise Exception.Create('The Low date must be less than the High date');
       FLow := Value;
   end;
end;

function TDateRange.IsDateWithinRange(ADate : TDateTime) : Boolean;
begin
   Result := False;

   if ((Self.Low = EMPTY_DATE) or (ADate >= Self.Low)) then
   begin
       if (Self.High = EMPTY_DATE) or ((ADate <> EMPTY_DATE) and (ADate <= Self.High)) then
           Result := True

           //                 ignore the time portion of ADate if Self.High has no time portion
       else if (Frac(Self.High) = 0) and (Trunc(ADate) = Trunc(Self.High)) then
           Result := True
   end;
end;

end.

