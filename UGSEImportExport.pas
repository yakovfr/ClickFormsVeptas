unit UGSEImportExport;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{

The format for the mapping XPath is:

/ROOT/NEXT/@Attribute
/ROOT/NEXT[@Criteria="Value"]/@Attribute
/ROOT/NEXT[@Criteria="Value"]/NEXT[@Criteria="Value"]/@Attribute
/ROOT/NEXT[@Attribute="Default"]

//MIDPOINT/NEXT/@Attribute
//MIDPOINT/NEXT[@Criteria="Value"]/@Attribute
//MIDPOINT/NEXT[@Criteria="Value"]/NEXT[@Criteria="Value"]/@Attribute
//MIDPOINT/NEXT[@Attribute="Default"]

}

interface

uses
   Classes, uCraftClass, uCraftXML, Controls, SysUtils,Variants;

const
  OTHER_TAG = 'Other';
  TAG_DUMMY_VALUE = 'AE449COMCON';
  UNUSED_CELLID_TEXT = '* * * not used';
  NOT_EXPORTED_CELLID_TEXT = '* * * not exported';

  DEFAULT_MISMO_VERSION = '2.5.1';

  APPRAISAL_REPORT_FILE_EXTENSION = 'AppraisalReport';
  APPRAISAL_ORDER_FILE_EXTENSION = 'AppraisalOrder';
  APPRAISAL_STATUS_FILE_EXTENSION = 'AppraisalStatus';

  APPRAISAL_RESPONSE_ELEMENT_NAME = 'APPRAISAL';
  APPRAISAL_REQUEST_ELEMENT_NAME = 'APPRAISAL_REQUEST';
  PROPERTY_ELEMENT_NAME = 'PROPERTY';

  REQUEST_ROOT_ELEMENT_NAME = 'REQUEST_GROUP';
  REQUEST_PARENT_ELEMENT_XPATH = '/' + REQUEST_ROOT_ELEMENT_NAME + '/REQUEST/REQUEST_DATA';

  RESPONSE_ROOT_ELEMENT_NAME = 'RESPONSE_GROUP';
  RESPONSE_PARENT_ELEMENT_XPATH = '/' + RESPONSE_ROOT_ELEMENT_NAME + '/RESPONSE/RESPONSE_DATA';

  IDENTIFICATION_TYPE_ATTRIBUTE_NAMES : array[0..1] of string = ('_IdentificationType', 'ComparableIdentificationType');
  //NOTE - Hack: Keep in this order, so _SequenceIdentifier is not replaced - this is bug in code
  SEQUENCE_IDENTIFIER_ATTRIBUTE_NAMES : array[0..3] of string = ('PropertySequenceIdentifier', 'ListingSequenceIdentifier', '_SequenceIdentifier', 'AppraisalReportContentSequenceIdentifier');
  // V6.8.0
  CENT_SEQ_IDENTIFIER_ATTRIBUTE_NAMES : array[0..2] of string = ('PropertySeqID', 'ListingSeqID', '_SeqID');

type
   TResourceID = Word;
   TTranslatorState = (tsReady, tsImporting, tsExporting);
   TStructureType = (stUnknown, stRequestEnvelope, stResponseEnvelope,
       stAppraisalRequest, stAppraisalResponse, stAppraisal, stProperty);

const
   STATE_TYPE_NAMES : array[TTranslatorState] of string = ('Ready', 'Importing', 'Exporting');
   STRUCTURE_TYPE_NAMES : array[TStructureType] of string = ('Unknown', 'Request Envelope', 'Response Envelope',
       'AppraisalRequest', 'AppraisalReport', 'Appraisal', 'Property');

type
   EMISMOTranslationError = class(Exception);
   EMISMOFormatError = class(EMISMOTranslationError);
   EMISMOTranslationMissingMappingError = class(EMISMOTranslationError);
   EMISMOTranslationNoColumnIdentificationTypeError = class(EMISMOTranslationError);
   EMISMOTranslationUnusedCellIDError = class(EMISMOTranslationError);

   TMISMOMappingItem = class(TCollectionItem)
   private
       FCellID : TResourceID;
       FXPath : string;
       FControl : TControl;
       FOtherIdentificationType : string;

       function GetAsString : string;
       procedure SetAsString(Value : string);
       procedure SetCellID(Value : TResourceID);
       function GetValue : string;
       procedure SetValue(const Value : string);
       function GetIdentificationType : string;
       procedure SetIdentificationType(const Value : string);
       function GetSequenceIdentifier : string;
       procedure SetSequenceIdentifier(const Value : string);
       function GetOtherIdentificationType : string;
       procedure SetOtherIdentificationType(const Value : string);
       function GetControlValue : string;
       procedure SetControlValue(const Value : string);
   protected
       procedure Change; virtual;
   public
       property CellID : TResourceID read FCellID write SetCellID;
       property XPath : string read FXPath write FXPath;
       property AsString : string read GetAsString write SetAsString;
       property Control : TControl read FControl write FControl;
       property ControlValue : string read GetControlValue write SetControlValue;
       property Value : string read GetValue write SetValue;
       function SetMappedValue(const Value : string) : TXMLElement;
       property IdentificationType : string read GetIdentificationType write SetIdentificationType;
       property OtherIdentificationType : string read GetOtherIdentificationType write SetOtherIdentificationType;
       property SequenceIdentifier : string read GetSequenceIdentifier write SetSequenceIdentifier;
       class function AddTypeOtherDescription(AnXPath, AnOtherValue : string) : string;
   end;

   TMISMOTranslator = class;
   TMISMOMappingItems = class(TCollection)
   private
       FCellIndex : TCraftingStringList;
       FCurrentIndex : Integer;
       FTranslator : TMISMOTranslator;
       function GetMapping(Index : Integer) : TMISMOMappingItem;
   protected
       procedure Notify(Item : TCollectionItem; Action : TCollectionNotification); override;
       procedure ItemChange(AnItem : TMISMOMappingItem); virtual;
   public
       constructor Create; reintroduce; overload;
       procedure AfterConstruction; override;
       destructor Destroy; override;
       property Mappings[Index : Integer] : TMISMOMappingItem read GetMapping; default;
       function First(var AMapping : TMISMOMappingItem) : Boolean;
       function Next(var AMapping : TMISMOMappingItem) : Boolean;
       function Find(ACellID : TResourceID) : TMISMOMappingItem; overload;
       function Find(ACellID : TResourceID; var AMapping : TMISMOMappingItem) : Boolean; overload;
       function Find(const ACellID : string) : TMISMOMappingItem; overload;
       function Find(const ACellID : string; var AMapping : TMISMOMappingItem) : Boolean; overload;
       function Add(const AValue : string = EMPTY_STRING) : TMISMOMappingItem; overload;
       function Add(ACellID : Integer; AnXPath : string) : TMISMOMappingItem; overload;
       function Add(ACellID : string; AnXPath : string) : TMISMOMappingItem; overload;

       procedure LoadFromFile(const AFileName : string);
       procedure LoadFromResources;
   end;

   TMISMOImportEvent = procedure(Sender : TObject; ACellID : TResourceID; const AText : string) of object;
   TMISMOExportEvent = procedure(Sender : TObject; ACellID : TResourceID; var AText : string) of object;
   TMISMOTranslator = class(TObject)
   private
       FMappings : TMISMOMappingItems;
       FOnImport : TMISMOImportEvent;
       FOnExport : TMISMOExportEvent;
       FXMLCollection : TXMLCollection;
       FLocalXML : TXMLCollection;
       FState : TTranslatorState;
       FStructureType : TStructureType;
       FIsDebug : Boolean;
       FRootElement : TXMLElement;
       FShowDebugMessage : Boolean;
       FRaiseComplianceError: Boolean;
       FUseTimeZoneReferences : Boolean;

       function GetAsMISMOText : string;
       procedure SetAsMISMOText(const Value : string);
       procedure CheckXMLStructure(Sender : TObject; const AnXPath : string; var AParentElement : TXMLElement);
       function GetXML : TXMLCollection;
       procedure SetRootElement(Value : TXMLElement);
       procedure SetXML(Value : TXMLCollection);
   protected
       procedure DoImport(ACellID : TResourceID; const AText : string); virtual;
       procedure DoExport(ACellID : TResourceID; var AText : string); virtual;
       function AddMappedAttributeValue(AnXML : TXMLCollection; AnXPath, AValue : string) : TXMLElement; virtual;
       function GetMappedAttributeValue(AnXML : TXMLCollection; AnXPath : string) : string; virtual;
       property State : TTranslatorState read FState write FState;
       property IsDebug : Boolean read FIsDebug;
   public
       constructor Create; overload;
       destructor Destroy; override;
       procedure Clear;
       procedure ClearXML;
       function AddMapping(AValue : string) : Integer; overload;
       function AddMapping(ACellID : Integer; AnXPath : string) : Integer; overload;
       property Mappings : TMISMOMappingItems read FMappings;

       property AsMISMOText : string read GetAsMISMOText write SetAsMISMOText;
       property XML : TXMLCollection read GetXML write SetXML;
       property RootElement : TXMLElement read FRootElement write SetRootElement;

       function ExportToMISMOText(AStrings : TStrings) : string; overload;
       procedure ExportToMISMOText(AStrings : TStrings; const AFileName : string); overload;

       function BeginExport(AStructureType : TStructureType = stUnknown; AnXMLText : string = '') : TXMLCollection;
       function EndExport : string; overload;
       procedure EndExport(const AFileName : string); overload;
       procedure CancelExport;

       function ExportTag(ACellID : TResourceID; const AnIdentificationType: string = ''; const ASequenceIdentifier : string = '') : TXMLElement;

       property StructureType : TStructureType read FStructureType write FStructureType;
       property RaiseDebugMessages: Boolean read FShowDebugMessage write FShowDebugMessage;
       property RaiseComplianceError: Boolean read FRaiseComplianceError write FRaiseComplianceError;

       function FindMapping(ACellID : TResourceID; var AnXPath : string) : Boolean;
       function ExportValue(ACellID : TResourceID; AValue : string = '') : TXMLElement; overload;
       function ExportValue(ACellID : TResourceID; AValue : Boolean) : TXMLElement; overload;
       function ExportValue(ACellID : TResourceID; AValue : Integer) : TXMLElement; overload;
       function ExportValue(ACellID : TResourceID; AValue : Double) : TXMLElement; overload;
       function ExportValue(ATrueCellID, AFalseCellID : TResourceID; AValue : Boolean) : TXMLElement; overload;
       function ExportValue(ACellID : TResourceID; AnIdentificationType : string; AValue : string) : TXMLElement; overload;
       function ExportValue(ACellID : TResourceID; AnIdentificationType : string; AValue : Double) : TXMLElement; overload;
       function ExportValue(ACellID : TResourceID; AnIdentificationType, ASequenceIdentifier : string; AValue : string) : TXMLElement; overload;
       function ExportValue(ACellID : TResourceID; AnIdentificationType, ASequenceIdentifier : string; AValue : Double) : TXMLElement; overload;
       function ExportValueIfTrue(ACellID : TResourceID; AValue : Boolean) : TXMLElement;
       function ExportDateValue(ACellID : TResourceID; AValue : TDateTime) : TXMLElement; overload; //  TDateTime = Double
       function ExportValueIfNonZero(ACellID : TResourceID; AValue : Integer) : TXMLElement; overload;
       function ExportValueIfNonZero(ACellID : TResourceID; AValue : Double) : TXMLElement; overload;
       function ExportValue(AnXPath : string; AValue : string) : TXMLElement; overload;

       procedure ExportDebugMessage(const AMessage : string);

       procedure BeginImport(const AnXMLText : string); overload;
       procedure BeginImport(AnXML : TXMLCollection); overload;
       procedure BeginImport(ABaseElement : TXMLElement); overload;
       procedure BeginImport; overload;
       procedure LoadImportFromFile(const AFileName : string);
       procedure ImportValuesToStrings(AStrings : TStrings; ADelimiter : string = '=');
       function ImportValue(ACellID : TResourceID; const AnIdentificationType : string = ''; ASequenceIdentifier : string=''; const AnOtherIdentificationType : string = '') : string; overload;
       function ImportBooleanValue(ACellID : TResourceID) : Boolean;
       function ImportDateValue(ACellID : TResourceID) : TDateTime;
       function ImportValue(ACellID : TResourceID; var AValue : Boolean) : Boolean; overload;
       function ImportValue(ACellID : TResourceID; var AValue : TDateTime) : Boolean; overload;
       function ImportValue(ACellID : TResourceID; var AValue : Integer) : Boolean; overload;
       function ImportValue(ACellID : TResourceID; var AValue : Extended) : Boolean; overload;
       procedure EndImport;
       function FindElement(ACellID : TResourceID; TypeOtherDescription : string = '') : TXMLElement;
   published
       property OnImport : TMISMOImportEvent read FOnImport write FOnImport;
       property OnExport : TMISMOExportEvent read FOnExport write FOnExport;
       property UseTimeZoneReferences : Boolean read FUseTimeZoneReferences write FUseTimeZoneReferences default False;
   end;

   TMISMODataType =
       (mdtUnknown, mdtString, mdtNumeric, mdtEnumerated, mdtBoolean, mdtMoney, mdtDate, mdtTime, mdtDatetime, mdtYear);

   TMISMODataTypes = set of TMISMODataType;


const
  BOOLEAN_TRUE_VALUE = 'Y';
  BOOLEAN_FALSE_VALUE = 'N';
  MISMO_DATATYPE_NAMES : array[TMISMODataType] of string =
  ('Unknown', 'String', 'Numeric', 'Enumerated', 'Boolean', 'Money', 'Date', 'Time', 'Datetime', 'Year');



function GetTagXPath(ATag : string) : string; overload;
function GetTagXPath(ATag : Integer) : string; overload;




implementation

uses
   Dialogs, uInternetUtils, Windows, Forms, StdCtrls, ExtCtrls, ComCtrls,
{$IFNDEF NOCRAFTCONTROLS}
//   uCraftControls,
{$ENDIF}
   UGlobals, UStatus, uWindowsInfo, UAMC_XMLUtils, UUtil1;


var
  FGlobalMappings: TMISMOMappingItems = nil;     //all the XPaths are stored in this object
  FFormTagIDList: TStringList = nil;             //the form list is stored in this object


function GlobalMappings: TMISMOMappingItems;
begin
  //021511 Add check of mappings and, if they exist, clear them so they reload
  if FGlobalMappings = nil then
    FGlobalMappings := TMISMOMappingItems.Create
  else
    FGlobalMappings.Clear;

  if FGlobalMappings.Count = 0 then
    begin
      if FileExists(XML_XPaths) then
        FGlobalMappings.LoadFromFile(XML_XPaths)
      else
        begin
          ShowAlert(atWarnAlert, 'The MISMO Conversion file: '+ XML_XPaths + ' could not be found. Please ensure it has been installed properly.');
          FreeAndNil(FGlobalMappings);
        end;
      // additional option is to include in Resources
      // FGlobalMappings.LoadFromResources;
    end;

  Result := FGlobalMappings;
end;

(*
function FormTagIDList: TStringList;
var
   Counter : Integer;
begin
  if FFormTagIDList = nil then
    begin
      FFormTagIDList := TStringList.Create;
      if FileExists(appPref_AppraisalXMLMapPath) then
        begin
          with TXMLCollection.Create do
            try
              LoadFromFile(appPref_AppraisalXMLMapPath);
              with FindXPath('//FORM') do                 //  returns a IXMLElementList
                begin
                  for Counter := 0 to Count - 1 do
                    begin
                      with Elements[Counter] do
                        begin
                          FFormTagIDList.AddObject(AttributeValues['Tag'] + '=' + AttributeValues['Version'],
                               TObject(StrToInt(AttributeValues['ID'])));
                        end;
                    end;
                end;
            finally
              Free;
            end;
        end
      else
        LoadFormTagIDIndexFromResource(FFormTagIDList); //  loading from FormMapping.rc:  51000 + FormID = "Form Name"
  end;

  Result := FFormTagIDList;
end;

function TExportRelsReport.FindFormSectionNode(formID : integer): IXMLNode;
var
  rootNode, child: IXMLNode;
  formList: IXMLElementList;
  index   : integer;
  formIDStr: string;
begin
  if assigned(FXPathMap) then
  begin
    formIDStr := IntToStr(formID);
    rootNode := FXPathMap.DocumentElement;

    formList := FXPathMap.FindXPath('//FORM');
    with formList do
      for index := 0 to Count -1 do
        with Elements[index] do
          if (HasAttribute(attrFormID) and (Attributes[attrFormID] = formIDStr)) then
            begin
              result := child;
              break;
            end;
  end;
end;

*)

function GetTagXPath(ATag : Integer): string;
begin
  Result := GetTagXPath(IntToStr(ATag));
end;

function GetTagXPath(ATag : string): string;
var
  ThisMapping : TMISMOMappingItem;
begin
  if GlobalMappings.Find(ATag, ThisMapping) then
    Result := ThisMapping.XPath
  else
    Result := 'Mapping tag ' + ATag + ' Not Found';
    //raise Exception.Create('Mapping tag ' + ATag + ' not found');
end;

function StrToMISMOType(const AString : string): TMISMODataType;
begin
  Result := High(TMISMODataType);
  while Result > Low(TMISMODataType) do
  begin
    if SameAlpha(MISMO_DATATYPE_NAMES[Result], AString) then
      Break;
    Dec(Result);
  end;
end;

function SuffixToType(AName : string): TMISMODataType;

   function SameSuffix(const AString1 : string; const ASuffices : array of string) : Boolean;
   var
      Counter : Integer;
   begin
       Result := False;
       for Counter := Low(ASuffices) to High(ASuffices) do
       begin
         if SameText(uCraftClass.SubString(AString1, 0 - Length(ASuffices[Counter])), ASuffices[Counter]) then
         begin
             Result := True;
             Break;
         end;
       end;
   end;

begin
   if SameSuffix(AName, ['Name', 'Description', 'Text', 'Comment', 'Identifier', 'Code',
       'Address', 'Address 2', 'City', 'Postal Code', 'State', 'Country']) then
   begin
      Result := mdtString;
   end

   else if SameSuffix(AName, ['Count', 'Percent', 'Number', {'Year',} 'Month', 'Day', 'Rate', 'Period',
       'Term', 'Limit', 'Factor']) then        //  'Value' used in /REQUEST/KEY/@_Value: not always numeric
   begin
       Result := mdtNumeric;
   end

   else if SameSuffix(AName, ['Type']) then
       Result := mdtEnumerated

   else if SameSuffix(AName, ['Date']) then
       Result := mdtDate

   else if SameSuffix(AName, ['Datetime']) then
       Result := mdtDatetime

   else if SameSuffix(AName, ['Time']) then
       Result := mdtTime

   else if SameSuffix(AName, ['Amount']) then
       Result := mdtMoney

   else if SameSuffix(AName, ['Indicator']) then
       Result := mdtBoolean

   else if SameSuffix(AName, ['Year']) then
       Result := mdtYear

   else
       Result := mdtUnknown;
end;



{  TMISMOTranslator    }

constructor TMISMOTranslator.Create;
begin
  inherited;

  FMappings := GlobalMappings;
  if Assigned(FMappings) then
    begin
      FMappings.FTranslator := Self;
  //  FXML created dynamically

      FIsDebug := TRUE;
      FShowDebugMessage := FIsDebug;

    end;
end;

destructor TMISMOTranslator.Destroy;
begin
   FMappings := nil;
   FLocalXML.Free;

   inherited;
end;

procedure TMISMOTranslator.Clear;
begin
   FMappings.Clear;
   ClearXML;
end;

procedure TMISMOTranslator.ClearXML;
begin
   FLocalXML.Free;
   FLocalXML := nil;
   FXMLCollection := nil;
end;

function TMISMOTranslator.AddMapping(ACellID : Integer; AnXPath : string) : Integer;
begin
   Result := FMappings.Add(ACellID, AnXPath).Index;
   State := tsReady;
end;

function TMISMOTranslator.AddMapping(AValue : string) : Integer;
begin
   Result := FMappings.Add(AValue).Index;
   State := tsReady;
end;

//////////////////////////////////////////////////////////////////////////

function TMISMOTranslator.GetAsMISMOText : string;
var
   ThisMapping : TMISMOMappingItem;
   ThisAttributeValue : string;
begin
   case State of
       tsExporting : raise Exception.Create('Finish or Cancel the current import before starting another');
       tsImporting : raise Exception.Create('Finish the current import before starting an export');
   end;

   ClearXML;
   if FMappings.First(ThisMapping) then
   begin
       repeat
           ///////////////////////    Create the XML Element to hold the data     ///////////////////////////////

           ThisAttributeValue := ThisMapping.ControlValue;

           DoExport(ThisMapping.CellID, ThisAttributeValue);

           if ThisAttributeValue <> EMPTY_STRING then
               ThisMapping.Value := ThisAttributeValue;

       until not FMappings.Next(ThisMapping);

       Result := XML.AsString;
   end;
end;

procedure TMISMOTranslator.DoExport(ACellID : TResourceID; var AText : string);
begin
   if Assigned(FOnExport) then
       FOnExport(Self, ACellID, AText);
end;

function TMISMOTranslator.ExportToMISMOText(AStrings : TStrings) : string;
var
   Counter : Integer;
   ThisMapping : TMISMOMappingItem;
begin
   for Counter := 0 to AStrings.Count - 1 do
   begin
       if FMappings.Find(AStrings.Names[Counter], ThisMapping) then
           ThisMapping.Value := AStrings.Values[AStrings.Names[Counter]]
       else
           raise EMISMOTranslationMissingMappingError.Create('No mapping present for CellID ' + AStrings.Names[Counter]);
   end;

   Result := XML.AsString;
end;

//////////////////////////////////////////////////////////////////////////

procedure TMISMOTranslator.ExportToMISMOText(AStrings : TStrings; const AFileName : string);
begin
   WriteFile(AFileName, ExportToMISMOText(AStrings));
end;

//this allows the mapping to use the "//xxx" style: it supplies the qualification for a descendant element

procedure TMISMOTranslator.CheckXMLStructure(Sender : TObject; const AnXPath : string; var AParentElement : TXMLElement);
var
   ThisXPath : string;
begin
   ThisXPath := ExtractNextStep(AnXPath);
   StripNextPredicate(ThisXPath);

   if (StructureType <> stUnknown) and (ThisXPath = PROPERTY_ELEMENT_NAME) then
   begin
       case StructureType of
           stResponseEnvelope, stAppraisalResponse :
               begin
                   CheckXMLStructure(Sender, APPRAISAL_RESPONSE_ELEMENT_NAME, AParentElement); //  recursive
                   AParentElement := AParentElement.OpenElement(APPRAISAL_RESPONSE_ELEMENT_NAME);
               end;

           stProperty: AParentElement := nil;
       else
           raise Exception.Create('A PROPERTY element unexpectedly found in this ' +
               STRUCTURE_TYPE_NAMES[StructureType] + ' structure');
       end;
   end

   else if ThisXPath = APPRAISAL_RESPONSE_ELEMENT_NAME then
   begin
       case StructureType of
(*
//does not work
          stAppraisalResponse:
              begin
                CheckXMLStructure(Sender, APPRAISAL_RESPONSE_ELEMENT_NAME, AParentElement); //  recursive
                AParentElement := Self.XML.OpenElement('/' + APPRAISAL_RESPONSE_ELEMENT_NAME);
              end;
*)
           stResponseEnvelope,stAppraisalResponse:
               begin
                   CheckXMLStructure(Sender, RESPONSE_ROOT_ELEMENT_NAME, AParentElement); //  recursive
                   AParentElement := Self.XML.OpenElement(RESPONSE_PARENT_ELEMENT_XPATH);
               end;
           stRequestEnvelope, stAppraisalRequest:
               begin
                   CheckXMLStructure(Sender, REQUEST_ROOT_ELEMENT_NAME, AParentElement); //  recursive
                   AParentElement := Self.XML.OpenElement(REQUEST_PARENT_ELEMENT_XPATH);
               end;
           stAppraisal:
              AParentElement := nil;
           stUnknown :
               begin
                   StructureType := stAppraisal;
                   AParentElement := nil;
               end;
       else
           raise Exception.Create('An ' + APPRAISAL_RESPONSE_ELEMENT_NAME + ' element unexpectedly found in this ' +
               STRUCTURE_TYPE_NAMES[StructureType] + ' structure');
       end;
   end

   else if ThisXPath = APPRAISAL_RESPONSE_ELEMENT_NAME then
   begin
       case StructureType of
           stResponseEnvelope: AParentElement := XML.OpenElement(RESPONSE_PARENT_ELEMENT_XPATH);
           stAppraisalResponse: AParentElement := nil;
       else
           raise Exception.Create('A ' + APPRAISAL_RESPONSE_ELEMENT_NAME + ' element unexpectedly found in this ' +
               STRUCTURE_TYPE_NAMES[StructureType] + ' structure');
       end;
   end

   else if ThisXPath = APPRAISAL_REQUEST_ELEMENT_NAME then
   begin
       case StructureType of
           stRequestEnvelope : AParentElement := XML.OpenElement(REQUEST_PARENT_ELEMENT_XPATH);
           stAppraisalRequest : AParentElement := nil;
       else
           raise Exception.Create('A ' + APPRAISAL_REQUEST_ELEMENT_NAME + ' element should only be in a ' +
               STRUCTURE_TYPE_NAMES[StructureType] + ' structure');
       end;
   end

   else if ThisXPath = 'DebugMessages' then
   begin
       AParentElement := XML.RootElement;
   end;
end;

//////////////////////////////////////////////////////////////////////////////////////////

function TMISMOTranslator.BeginExport(AStructureType : TStructureType; AnXMLText : string) : TXMLCollection;
var
   ThisAttributeValue : string;
   ThisMapping : TMISMOMappingItem;
begin
   case State of
       tsExporting : raise Exception.Create('Please finish or Cancel the current export before starting another');
       tsImporting : raise Exception.Create('Please finish the current import before starting an export');
   end;

   ClearXML;
   Self.StructureType := AStructureType;    //  this creates the framework elements (e.g. the root)

   if AnXMLText <> EMPTY_STRING then
       Self.XML.Parse(AnXMLText);

   Result := Self.XML;
   Self.XML.OnAddingADecendentAxisElement := CheckXMLStructure;

   //set default values from the Controls mapped to the elements (if any)
   if FMappings.First(ThisMapping) then
   begin
       repeat
           ThisAttributeValue := ThisMapping.ControlValue;
           if ThisAttributeValue <> EMPTY_STRING then
               ThisMapping.Value := ThisAttributeValue;

       until not FMappings.Next(ThisMapping);
   end;
end;

function TMISMOTranslator.ExportDateValue(ACellID : TResourceID; AValue : TDateTime) : TXMLElement;
begin
   if AValue > 0.0 then
       Result := ExportValue(ACellID, uInternetUtils.DateTimeToISO8601(AValue, Self.UseTimeZoneReferences))
   else
       Result := nil;
end;

function TMISMOTranslator.ExportValueIfTrue(ACellID : TResourceID; AValue : Boolean) : TXMLElement;
begin
   if AValue then
       Result := ExportValue(ACellID, AValue)
   else
       Result := nil;
end;

function TMISMOTranslator.ExportValue(ACellID : TResourceID; AValue : Boolean) : TXMLElement;
begin
   if AValue then
       Result := ExportValue(ACellID, BOOLEAN_TRUE_VALUE)
   else
       Result := ExportValue(ACellID, BOOLEAN_FALSE_VALUE);
end;

function TMISMOTranslator.ExportValue(ATrueCellID, AFalseCellID : TResourceID; AValue : Boolean) : TXMLElement;
begin
   if AValue then
       Result := ExportValue(ATrueCellID, BOOLEAN_TRUE_VALUE)
   else
       Result := ExportValue(AFalseCellID, BOOLEAN_FALSE_VALUE);
end;

function TMISMOTranslator.ExportValueIfNonZero(ACellID : TResourceID; AValue : Integer) : TXMLElement;
begin
   if AValue <> 0 then
       Result := ExportValue(ACellID, AValue)
   else
       Result := nil;
end;

function TMISMOTranslator.ExportValue(ACellID : TResourceID; AValue : Integer) : TXMLElement;
begin
   Result := ExportValue(ACellID, IntToStr(AValue));
end;

function TMISMOTranslator.ExportValueIfNonZero(ACellID : TResourceID; AValue : Double) : TXMLElement;
begin
   if AValue <> 0 then
       Result := ExportValue(ACellID, AValue)
   else
       Result := nil;
end;

function TMISMOTranslator.ExportValue(ACellID : TResourceID; AValue : Double) : TXMLElement;
begin
   Result := ExportValue(ACellID, EMPTY_STRING, AValue);
end;

function TMISMOTranslator.ExportValue(ACellID : TResourceID; AValue : string) : TXMLElement;
begin
   Result := ExportValue(ACellID, EMPTY_STRING, AValue);
end;

function TMISMOTranslator.ExportValue(ACellID : TResourceID; AnIdentificationType : string; AValue : Double) : TXMLElement;
begin
   Result := ExportValue(ACellID, AnIdentificationType, FloatToStr(AValue));
end;

function TMISMOTranslator.ExportValue(ACellID : TResourceID;
   AnIdentificationType, ASequenceIdentifier : string; AValue : Double) : TXMLElement;
begin
   Result := ExportValue(ACellID, AnIdentificationType, ASequenceIdentifier, FloatToStr(AValue));
end;

function TMISMOTranslator.ExportTag(ACellID : TResourceID; const AnIdentificationType, ASequenceIdentifier : string) : TXMLElement;
begin
   Result := ExportValue(ACellID, AnIdentificationType, ASequenceIdentifier, TAG_DUMMY_VALUE);
end;

function TMISMOTranslator.ExportValue(ACellID : TResourceID; AnIdentificationType : string; AValue : string) : TXMLElement;
begin
    Result := ExportValue(ACellID, AnIdentificationType, '', AValue);
end;

//this is the main export routine
function TMISMOTranslator.ExportValue(ACellID : TResourceID;
   AnIdentificationType, ASequenceIdentifier : string; AValue: string): TXMLElement;
var
   ThisMapping: TMISMOMappingItem;
   AYear: Integer;
   ADate: TDateTime;
   Counter: Integer;
   AStrNum: String;
   DateType: Integer;
begin
  Result := nil;

  AValue := Trim(AValue);
  if AValue <> '' then
    begin
      if FMappings.Find(ACellID, ThisMapping) then
        begin
          if (ThisMapping.XPath <> NOT_EXPORTED_CELLID_TEXT) and (AValue <> '') then
            begin

              if Copy(ThisMapping.XPath, 1, Length(UNUSED_CELLID_TEXT)) = UNUSED_CELLID_TEXT then
                raise EMISMOTranslationUnusedCellIDError.Create('CellID ' + IntToStr(ACellID) + ' is marked as unused: ' + ThisMapping.XPath);

              if AnIdentificationType <> EMPTY_STRING then
                ThisMapping.IdentificationType := AnIdentificationType; //  e.g. "Comparable2"   {NOT USED ANYMORE}

              // 031711 JWyatt Add the check to see if a sequence identifier exists
              //  in the current mapping. This check is required because some grid
              //  subject cells (column 0) do NOT have sequence identifiers.
              if (ASequenceIdentifier <> EMPTY_STRING) and
                 (ThisMapping.GetSequenceIdentifier <> '') then
                ThisMapping.SequenceIdentifier := ASequenceIdentifier; //  e.g. "1"

               //convert data into the correct text format for the type
              case SuffixToType(ThisMapping.XPath) of
                mdtNumeric, mdtMoney:
                  begin
                    AStrNum := GetFirstNumInStr(AValue, False, Counter);
                    if length(AStrNum)>0 then                        //we have a numeric string
                      AValue := uCraftClass.ExtractNumber(AStrNum)   //remove commas, leading $, etc

                    else if (CompareText(AValue, 'new')= 0) then    //for age on newly built homes
                      AValue := '0';
(*
// NOTE: Just send string - whatever it might be
                    else if (CompareText(AValue, 'NA')= 0) or       //no relevant value,pass back NA
                            (CompareText(AValue, 'Unknown')= 0) or
                            (CompareText(AValue, 'N/A') = 0) then
                      AValue := 'NA'
                    else if (ACellID <> 935) then                   //no processing on this cell
                      begin
                        if FRaiseComplianceError then
                          raise EMISMOFormatError.Create('"' + AValue + '" needs to be a numeric value or "N/A" or "Unknown".');
                      end;
*)
                  end;

                mdtBoolean:
                     if (AValue = 'X') or (AValue = 'Y') {or StrToBool(AValue)} then
                         AValue := BOOLEAN_TRUE_VALUE
                     else
                         AValue := BOOLEAN_FALSE_VALUE;
                mdtDate:
                  begin
                    //030111 The DateType variable and checks are implemented to
                    // handle yyyy and mm-yyyy dates as well as mm-dd-yyyy dates.
                    // The original code exports the year-only date of '2008' as
                    // '1905-06-30' and the month+year-only date of '1-2008' as
                    // '2008-01-01'. The revised code exports these as '2008' and
                    // '2008-01', respectively.
                    if Length(AValue) < 6 then
                      DateType := 2  // yyyy
                    else if Length(AValue) < 8 then
                      DateType := 1  // yyyy-mm
                    else
                      DateType := 0; // yyyy-mm-dd

                    if (DateType < 2) and IsValidDateTimeWithDiffSeparator(AValue, ADate) then
                    begin
                      AValue := FormatDateTime('yyyy-mm-dd', ADate);
                      if DateType = 1 then
                        AValue := Copy(AValue, 1, 7);
                    end;
(*
// NOTE: Just send string - whatever it might be
                    else if (ACellID <> 934) and (ACellID <> 2074) then     //no processing on these cells
                      begin
                        if (CompareText(AValue, 'NA')= 0) or                //handle exceptions to date
                           (CompareText(AValue, 'Unknown')= 0) or
                           (CompareText(AValue, 'N/A') = 0) then
                          AValue := 'NA'

                        else if FRaiseComplianceError then
                          raise EMISMOFormatError.Create('"' + AValue + '" needs to be a valid date (mm/dd/yy) or "N/A" or "Unknown".');
                      end;
*)
                   end;

                mdtYear:
                  begin
                    if IsValidYear(AValue, AYear) then
                      AValue := IntToStr(AYear);
(*
// NOTE: Just send string - whatever it might be
                    else
                      begin
                        if (CompareText(AValue, 'NA')= 0) or                //handle exceptions to date
                           (CompareText(AValue, 'Unknown')= 0) or
                           (CompareText(AValue, 'N/A') = 0) then
                          AValue := 'NA'

                        else if FRaiseComplianceError then
                            raise EMISMOFormatError.Create('"' + AValue + '" needs to be a valid year (YYYY) or "N/A" or "Unknown".');
                      end;
*)
                  end;
              end;

              if AValue = TAG_DUMMY_VALUE then
                Result := ThisMapping.SetMappedValue('')
              else
                Result := ThisMapping.SetMappedValue(AValue);

              DoExport(ACellID, AValue);    //execute the OnExport Event

            end;
        end
      else
        ;//raise EMISMOTranslationMissingMappingError.Create('No mapping present for CellID ' + IntToStr(ACellID));
    end;
end;

function TMISMOTranslator.ExportValue(AnXPath, AValue : string) : TXMLElement;
begin
   Result := AddMappedAttributeValue(Self.XML, AnXPath, AValue)
end;

function TMISMOTranslator.EndExport: string;
begin
  if not Self.XML.RootElement.AttributeExists('MISMOVersionID') then
    Self.XML.RootElement.AttributeValues['MISMOVersionID'] := DEFAULT_MISMO_VERSION;

  Self.XML.SortElementsByDTD;

  Result := Self.XML.AsString;
  CancelExport;
end;

procedure TMISMOTranslator.EndExport(const AFileName : string);
begin
   WriteFile(AFileName, EndExport);
end;

procedure TMISMOTranslator.CancelExport;
begin
   ClearXML;

   Self.State := tsReady;
end;

function TMISMOTranslator.AddMappedAttributeValue(AnXML : TXMLCollection; AnXPath, AValue : string) : TXMLElement;
var
   ThisAttribute : string;
begin
   ThisAttribute := StripLastAttribute(AnXPath);

   if Self.RootElement <> nil then
       Result := Self.RootElement.OpenElement(AnXPath)
   else
       Result := AnXML.OpenElement(AnXPath);

   if ThisAttribute <> '' then
       Result.AttributeValues[ThisAttribute] := AValue;    //  even if AValue = ''

{$IFDEF TRANSLATOR_DEBUG}
   begin
       AnXML.SaveToFile(uWindowsInfo.GetUnusedFileName(IncludeTrailingPathDelimiter(uWindowsInfo.GetWindowsTempDirectory) +
           'MISMO Translator Debug 000.xml'));
   end;
{$ENDIF}
end;

procedure TMISMOTranslator.ExportDebugMessage(const AMessage : string);
begin
   Self.XML.AddElement('//DebugMessages/DebugMessage', ['LogTime', DateTimeToXML(SysUtils.Now)]).Text := Trim(AMessage);
end;

//////////////////////////////////////////////////////////////////////////////////////////

procedure TMISMOTranslator.SetAsMISMOText(const Value : string);
var
   ThisMapping : TMISMOMappingItem;
   ThisAttributeName, ThisXPath : string;
   ThisElement : TXMLElement;
begin
   case State of
       tsImporting : raise Exception.Create('Finish or Cancel the current import before starting another');
       tsExporting : raise Exception.Create('Finish the current import before starting an import');
   end;


   if FMappings.First(ThisMapping) then
   begin
       repeat
           ThisXPath := ThisMapping.XPath;
           ThisAttributeName := StripLastAttribute(ThisXPath);

           if Self.XML.FindXPath(ThisXPath, Self.RootElement, ThisElement) then
           begin
               if ThisAttributeName = EMPTY_STRING then
                   DoImport(ThisMapping.CellID, BOOLEAN_TRUE_VALUE)
               else
                   DoImport(ThisMapping.CellID, ThisElement.AttributeValues[ThisAttributeName]);
           end;
       until not FMappings.Next(ThisMapping);
   end;
end;

procedure TMISMOTranslator.DoImport(ACellID : TResourceID; const AText : string);
begin
    if Assigned(FOnImport) then
       FOnImport(Self, ACellID, AText);
end;

procedure TMISMOTranslator.LoadImportFromFile(const AFileName : string);
begin
   BeginImport(uWindowsInfo.FileText(AFileName));
end;

procedure TMISMOTranslator.BeginImport(const AnXMLText : string);
begin
   ClearXML;

   if AnXMLText <> EMPTY_STRING then
       Self.XML.Parse(AnXMLText);

   BeginImport;
end;

procedure TMISMOTranslator.BeginImport(ABaseElement : TXMLElement);
begin
   Self.RootElement := ABaseElement;

   BeginImport;
end;

procedure TMISMOTranslator.BeginImport(AnXML : TXMLCollection);
begin
   Self.XML := AnXML;                                      //  this can be external; we never free FXMLCollection

   BeginImport;
end;

procedure TMISMOTranslator.BeginImport;
var
   ThisMapping : TMISMOMappingItem;
begin
   case State of
       tsImporting : raise Exception.Create('Finish or Cancel the current import before starting another');
       tsExporting : raise Exception.Create('Finish the current import before starting an import');
   end;

   //             set default values of the Controls mapped from the elements (if any)
   if FMappings.First(ThisMapping) then
   begin
       repeat
           ThisMapping.ControlValue := ThisMapping.Value;
       until not FMappings.Next(ThisMapping);
   end;
end;

procedure TMISMOTranslator.ImportValuesToStrings(AStrings : TStrings; ADelimiter : string);
var
   ThisMapping : TMISMOMappingItem;
begin
   with FMappings do
   begin
       if First(ThisMapping) then
       begin
           repeat
               AStrings.Add(IntToStr(ThisMapping.CellID) + ADelimiter + ThisMapping.Value);
           until not Next(ThisMapping);
       end;
   end;
end;

function TMISMOTranslator.ImportValue(ACellID : TResourceID;
   const AnIdentificationType : string; ASequenceIdentifier : string; const AnOtherIdentificationType : string) : string;
var
   ThisMapping : TMISMOMappingItem;

   function ValueIsNumeric(S: Variant;MismoDataType: TMISMODataType ): boolean;
    begin
     result := False;
     case MismoDataType of
       mdtNumeric : begin
                     if VarType(s) = varInteger then result := True;
                    end;
       mdtMoney  :  begin
                     if VarType(s) = varDouble then result := True;
                    end;
      end;
    end;
    
begin
   Result := '';
   if not FMappings.Find(ACellID,ThisMapping) then     //ThisMapping
   begin
{$IFDEF DEBUG}
       if FShowDebugMessage then
       begin
           if MessageTopDialog('No mapping present for CellID ' + IntToStr(ACellID),
               mtInformation, [mbOk, mbIgnore], 0) = mrIgnore then
           begin
               FShowDebugMessage := False;
           end;
       end;
{$ELSE}
       raise EMISMOTranslationMissingMappingError.Create('No mapping present for CellID ' + IntToStr(ACellID));
{$ENDIF}
   end
   else
   begin
       if ThisMapping.XPath = NOT_EXPORTED_CELLID_TEXT then
           Result := ''                                    //  if we don't export it, than we don't import it

       else if Copy(ThisMapping.XPath, 1, Length(UNUSED_CELLID_TEXT)) = UNUSED_CELLID_TEXT then
       begin
           raise EMISMOTranslationUnusedCellIDError.Create('CellID ' + IntToStr(ACellID) +
               ' is marked as unused: ' + ThisMapping.XPath);
       end
       else if (ThisMapping.XPath <> NOT_EXPORTED_CELLID_TEXT) then
       begin
           if AnIdentificationType <> EMPTY_STRING then
           begin
               ThisMapping.IdentificationType := AnIdentificationType; //  e.g. "ComparableTwo"

               if AnOtherIdentificationType <> EMPTY_STRING then
                   ThisMapping.OtherIdentificationType := AnOtherIdentificationType;
           end;

           if ASequenceIdentifier <> EMPTY_STRING then
                ThisMapping.SequenceIdentifier := ASequenceIdentifier; //  Add by Jeferson to keep current Sequence.

         
           Result := ThisMapping.Value;
           if Result <> '' then
           begin
               //                     convert data into the correct text format for the type
               case SuffixToType(ThisMapping.XPath) of
                   mdtNumeric :
                         if ValueIsNumeric(Result,mdtNumeric) then
                          Result := FloatToStr(StrToFloat(Result));
                   mdtMoney :
                         if ValueIsNumeric(Result,mdtMoney) then
                            Result := CurrToStr(StrToCurr(Result));
                   mdtBoolean :
                       if Result = BOOLEAN_TRUE_VALUE then
                           Result := 'X'
                       else
                           Result := '';
                   mdtDate :
                        try
                          Result := DateToStr(uInternetUtils.ISO8601ToDateTime(Result));
                        except
                          Result := ThisMapping.Value;
                        end;
                   mdtDateTime :
                        try
                          Result := DateTimeToStr(uInternetUtils.ISO8601ToDateTime(Result));
                        except
                          Result := ThisMapping.Value;
                        end;
               end;
           end;
       end;
   end;
end;

function TMISMOTranslator.GetMappedAttributeValue(AnXML : TXMLCollection; AnXPath : string) : string;
var
   ThisAttributeName : string;
   FoundElement : TXMLElement;
begin
   Result := EMPTY_STRING;
   ThisAttributeName := StripLastAttribute(AnXPath);
   if AnXML.FindXPath(AnXPath, Self.RootElement, FoundElement) then
   begin
       if ThisAttributeName = EMPTY_STRING then
           Result := BOOLEAN_TRUE_VALUE                    //  report that the XPath was found (e.g. //.../.[@X="3"])
       else
           Result := FoundElement.AttributeValues[ThisAttributeName];
   end;
end;

function TMISMOTranslator.ImportValue(ACellID : TResourceID; var AValue : Boolean) : Boolean;
var
   ThisString : string;
begin
   ThisString := ImportValue(ACellID);
   Result := ThisString <> EMPTY_STRING;
   if Result then
       AValue := (ThisString = BOOLEAN_TRUE_VALUE);        //  or CraftClass.StrToBool
end;

function TMISMOTranslator.ImportBooleanValue(ACellID : TResourceID) : Boolean;
begin
   if not ImportValue(ACellID, Result) then
       Result := False;
end;

function TMISMOTranslator.ImportDateValue(ACellID : TResourceID) : TDateTime;
begin
   if not ImportValue(ACellID, Result) then
       Result := EMPTY_DATE;
end;

function TMISMOTranslator.ImportValue(ACellID : TResourceID; var AValue : TDateTime) : Boolean;
var
   ThisString : string;
begin
   ThisString := ImportValue(ACellID);     //  this should convert from ISO8601
   Result := ThisString <> EMPTY_STRING;
   if Result then
       AValue := StrToDateTime(ThisString);
end;

function TMISMOTranslator.ImportValue(ACellID : TResourceID; var AValue : Integer) : Boolean;
var
   ThisString : string;
begin
   ThisString := ImportValue(ACellID);
   Result := ThisString <> EMPTY_STRING;
   if Result then
       AValue := StrToInt(ThisString);
end;

function TMISMOTranslator.ImportValue(ACellID : TResourceID; var AValue : Extended) : Boolean;
var
   ThisString : string;
begin
   ThisString := ImportValue(ACellID);
   Result := ThisString <> EMPTY_STRING;
   if Result then
       AValue := StrToFloat(ThisString);
end;

procedure TMISMOTranslator.EndImport;
begin
   ClearXML;
   Self.State := tsReady;
end;

function TMISMOTranslator.FindElement(ACellID : TResourceID; TypeOtherDescription : string) : TXMLElement;
var
   ThisMapping : TMISMOMappingItem;
   ThisXPath : string;
begin
   Result := nil;
   if FMappings.Find(ACellID, ThisMapping) then
   begin
       ThisXPath := ThisMapping.XPath;
       while ExtractChar(ExtractLastStep(ThisXPath)) = '.' do
           StripLastStep(ThisXPath);

       if TypeOtherDescription <> '' then
           ThisXPath := TMISMOMappingItem.AddTypeOtherDescription(ThisXPath, TypeOtherDescription);

       if not Self.XML.FindXPath(ThisXPath, Self.RootElement, Result) then
           Result := nil;
   end;
end;

function TMISMOTranslator.FindMapping(ACellID : TResourceID; var AnXPath : string) : Boolean;
var
   ThisMapping : TMISMOMappingItem;
begin
  Result := FMappings.Find(ACellID, ThisMapping);
  if Result then
    AnXPath := ThisMapping.XPath;
end;

function TMISMOTranslator.GetXML : TXMLCollection;
begin
   if FXMLCollection = nil then
   begin
       if FLocalXML = nil then
           FLocalXML := TXMLCollection.Create;
       FXMLCollection := FLocalXML;
   end;
   Result := FXMLCollection;
end;

procedure TMISMOTranslator.SetXML(Value : TXMLCollection);
begin
   if FXMLCollection <> Value then
   begin
       ClearXML;
       FXMLCollection := Value;

       FRootElement := nil
   end;
end;

procedure TMISMOTranslator.SetRootElement(Value : TXMLElement);
begin
   if FRootElement <> Value then
   begin
       if Value = nil then
           ClearXML
       else
           Self.XML := Value.XMLCollection;

       FRootElement := Value;
   end;
end;

{  TMISMOMappingItem   }

function TMISMOMappingItem.GetAsString : string;
begin
   Result := Format('%d,"%s"', [CellID, XPath]);
end;

procedure TMISMOMappingItem.SetAsString(Value : string);
begin
   CellID := StrToIntDef(StripIf(Value, ','), High(TResourceID));
   if CellID = High(TResourceID) then
       CellID := StrToInt(StripTo(Value, '='));
   XPath := TrimTokens(Value, ['"']);
end;

procedure TMISMOMappingItem.SetCellID(Value : TResourceID);
begin
   if Value <> FCellID then
   begin
       FCellID := Value;
       Change;
   end;
end;

procedure TMISMOMappingItem.Change;
begin
   TMISMOMappingItems(Collection).ItemChange(Self);
end;

function TMISMOMappingItem.GetControlValue : string;
begin
   Result := EMPTY_STRING;
   if Control <> nil then
   begin
       //  get value from the mapped control
       if Control is TCheckBox then
       begin
           if TCheckBox(Control).Checked then
               Result := BOOLEAN_TRUE_VALUE
           else
               Result := BOOLEAN_FALSE_VALUE
       end
       else if Control is TDateTimePicker then
       begin
           if TDateTimePicker(Control).Date > 0 then
           begin
               Result := uInternetUtils.DateTimeToISO8601(TDateTimePicker(Control).Date,
                   TMISMOMappingItems(Self.Collection).FTranslator.UseTimeZoneReferences);
           end;
       end
(*
{$IFNDEF NOCRAFTCONTROLS}
       else if Control is TCraftingDateEdit then
       begin
           if not TCraftingDateEdit(Control).IsEmpty then
           begin
               Result := uInternetUtils.DateTimeToISO8601(TCraftingDateEdit(Control).AsDateTime,
                   TMISMOMappingItems(Self.Collection).FTranslator.UseTimeZoneReferences);
           end;
       end
       else if Control is TCraftingNumberEdit then
       begin
           if not TCraftingNumberEdit(Control).IsEmpty then
               Result := FloatToStr(TCraftingNumberEdit(Control).Value);
       end
{$ENDIF}
*)
           //  put this after the more specialized TCustomEdit descendants or it will match them all
       else if Control is TCustomEdit then
           Result := TCustomEdit(Control).Text

       else if Control is TRadioGroup then
       begin
           with TRadioGroup(Control) do
               Result := uCraftClass.ExtractAlpha(Items[ItemIndex]);
       end
       else if Control is TCustomComboBox then
       begin
           with TComboBox(Control) do                      //  yes, but I need access to the .Text property
           begin
               if ItemIndex = -1 then
                   Result := Text
               else
                   Result := Items[ItemIndex];
           end;
       end
       else
           raise Exception.Create('Unrecognized control: ' + Control.Name + ' [' + Control.ClassName + ']');
   end;
end;

procedure TMISMOMappingItem.SetControlValue(const Value : string);
var
   Counter : Integer;
begin
   if (Control <> nil) and (Value <> '') then
   begin
       //  get value from the mapped control
       if Control is TCheckBox then
           TCheckBox(Control).Checked := SameText(Value, BOOLEAN_TRUE_VALUE)

       else if Control is TDateTimePicker then
           TDateTimePicker(Control).Date := uInternetUtils.ISO8601ToDateTime(Value)
(*
{$IFNDEF NOCRAFTCONTROLS}
       else if Control is TCraftingDateEdit then
           TCraftingDateEdit(Control).AsDateTime := uInternetUtils.ISO8601ToDateTime(Value)

       else if Control is TCraftingNumberEdit then
           TCraftingNumberEdit(Control).Value := StrToFloat(Value)
{$ENDIF}
*)
           //  put this after the more specialized TCustomEdit descendants or it will match them all
       else if Control is TCustomEdit then
           TCustomEdit(Control).Text := Value

       else if Control is TCustomComboBox then
       begin
           with TComboBox(Control) do                      //  yes, but I need to get to the protected .Style
           begin
               ItemIndex := Items.IndexOf(Value);
               if ItemIndex = -1 then
               begin
                   for Counter := 0 to Items.Count - 1 do
                   begin
                       if uCraftClass.SameAlpha(Items[Counter], Value) then
                       begin
                           ItemIndex := Counter;
                           Break;
                       end;
                   end;
               end;
               if (ItemIndex = -1) then
               begin
                   if Style in [csDropDown, csSimple] then
                       Text := Value
                   else
                       raise Exception.Create('Combo ' + Control.Name + ' cannot accept a value of ' + Value);
               end;
           end;
       end
       else if Control is TRadioGroup then
       begin
           with TRadioGroup(Control) do
               ItemIndex := Items.IndexOf(Value);
       end
       else
           raise Exception.Create('Unrecognized control: ' + Control.Name + ' [' + Control.ClassName + ']');
   end;
end;

function TMISMOMappingItem.GetValue : string;
begin
   if Self.XPath = '' then
       raise Exception.Create('Mapping Item ' + IntToStr(CellID) + ' has no XPath defined for it');

   with TMISMOMappingItems(Collection).FTranslator do
   begin
       if XML.IsEmpty then
           raise Exception.Create('You cannot get the value for ' + Self.XPath + ' as no XML is loaded')
       else
           Result := GetMappedAttributeValue(XML, Self.XPath);
   end;
end;

procedure TMISMOMappingItem.SetValue(const Value : string);
begin
   SetMappedValue(Value);
end;

function TMISMOMappingItem.SetMappedValue(const Value : string) : TXMLElement;
begin
   Result := nil;
   if Self.XPath = '' then
       raise EMISMOTranslationMissingMappingError.Create('Mapping Item ' + IntToStr(CellID) + ' has no XPath defined for it');

   with TMISMOMappingItems(Collection).FTranslator do
   begin
       if XML = nil then
           raise Exception.Create('You cannot set the value for ' + Self.XPath + ' as no XML is loaded')

       else if Copy(TrimLeft(Self.XPath), 1, 5) = '* * *' then
           begin
            if FALSE then   //only when we want to know - XPath validation
              raise EMISMOTranslationUnusedCellIDError.Create('CellID ' + IntToStr(Self.CellID) + ' is marked as unused or not exported');
           end

       else
           Result := AddMappedAttributeValue(XML, Self.XPath, Value);
   end;
end;

function TMISMOMappingItem.GetIdentificationType : string;
var
   Counter : Integer;
begin
   Result := '';

   for Counter := Low(IDENTIFICATION_TYPE_ATTRIBUTE_NAMES) to High(IDENTIFICATION_TYPE_ATTRIBUTE_NAMES) do
   begin
       Result := FindXPathAttributeEqualityValue(Self.XPath, IDENTIFICATION_TYPE_ATTRIBUTE_NAMES[Counter]);
       if Result <> '' then
           Break;
   end;
end;

procedure TMISMOMappingItem.SetIdentificationType(const Value : string);
var
   Counter : Integer;
   ThisXPath : string;
begin
   for Counter := High(IDENTIFICATION_TYPE_ATTRIBUTE_NAMES) downto Low(IDENTIFICATION_TYPE_ATTRIBUTE_NAMES) do
   begin
       ThisXPath := Self.XPath;
       if ReplaceXPathAttributeEqualityValue(ThisXPath, IDENTIFICATION_TYPE_ATTRIBUTE_NAMES[Counter], Value) then
       begin
           Self.XPath := ThisXPath;
           Exit;
       end;
   end;

  { raise EMISMOTranslationNoColumnIdentificationTypeError.Create(
       'No Identification Type in CellID ' + IntToStr(CellID) + ' XPath: ' + Self.XPath);}
end;

function TMISMOMappingItem.GetSequenceIdentifier : string;
var
   Counter : Integer;
begin
   Result := '';

   for Counter := Low(SEQUENCE_IDENTIFIER_ATTRIBUTE_NAMES) to High(SEQUENCE_IDENTIFIER_ATTRIBUTE_NAMES) do
   begin
       Result := FindXPathAttributeEqualityValue(Self.XPath, SEQUENCE_IDENTIFIER_ATTRIBUTE_NAMES[Counter]);
       if Result <> '' then
           Break;
   end;
end;

procedure TMISMOMappingItem.SetSequenceIdentifier(const Value : string);
var
   ThisXPath : string;
   Counter : Integer;
begin
   ThisXPath := Self.XPath;
   for Counter := Low(SEQUENCE_IDENTIFIER_ATTRIBUTE_NAMES) to High(SEQUENCE_IDENTIFIER_ATTRIBUTE_NAMES) do
   begin
       if ReplaceXPathAttributeEqualityValue(ThisXPath, SEQUENCE_IDENTIFIER_ATTRIBUTE_NAMES[Counter], Value) then
       begin
           Self.XPath := ThisXPath;
           Exit;
       end;
   end;

   raise EMISMOTranslationNoColumnIdentificationTypeError.Create('No Sequence Identifier in this item''s XPath (' + Self.XPath + ')');
end;

function TMISMOMappingItem.GetOtherIdentificationType : string;
begin
   Result := FOtherIdentificationType;
end;

procedure TMISMOMappingItem.SetOtherIdentificationType(const Value : string);
begin
   if FOtherIdentificationType <> Value then
   begin
       FOtherIdentificationType := Value;
       Self.XPath := TMISMOMappingItem.AddTypeOtherDescription(Self.XPath, Value);
   end;
end;

class function TMISMOMappingItem.AddTypeOtherDescription(AnXPath, AnOtherValue : string) : string;
var
   OtherAttributeName, ThisXPath : string;
   Counter : Integer;
begin
   Result := AnXPath;

   ThisXPath := AnXPath;
   for Counter := Low(IDENTIFICATION_TYPE_ATTRIBUTE_NAMES) to High(IDENTIFICATION_TYPE_ATTRIBUTE_NAMES) do
   begin
       if StripIf(AnXPath, IDENTIFICATION_TYPE_ATTRIBUTE_NAMES[Counter] + '=') <> '' then
       begin
           OtherAttributeName := IDENTIFICATION_TYPE_ATTRIBUTE_NAMES[Counter] + 'OtherDescription';

           if not ReplaceXPathAttributeEqualityValue(Result, OtherAttributeName, AnOtherValue) then
           begin
               StripQuotedText(ThisXPath);                 //  skip over the attribute value
               Result := Copy(Result, 1, Length(Result) - Length(ThisXPath)) + ' and ' +
                   OtherAttributeName + '="' + AnOtherValue + '"' + ThisXPath;
           end;
       end;
   end;
end;


{  TMISMOMappingItems  }

constructor TMISMOMappingItems.Create;
begin
   Create(TMISMOMappingItem);
end;

procedure TMISMOMappingItems.AfterConstruction;
begin
   inherited;
   FCurrentIndex := -1;
   FCellIndex := TCraftingStringList.Create;
   FCellIndex.Sorted := True;
end;

destructor TMISMOMappingItems.Destroy;
begin
   FCellIndex.Free;
   FCellIndex := nil;
   inherited;
end;

procedure TMISMOMappingItems.Notify(Item : TCollectionItem; Action : TCollectionNotification);
begin
   inherited;

   if FCellIndex <> nil then
   begin
       with Item as TMISMOMappingItem do
       begin
           if CellID <> 0 then
           begin
               case Action of
                   cnAdded : FCellIndex.AddObject(IntToStr(CellID), Item);
                   cnExtracting, cnDeleting : FCellIndex.Remove(IntToStr(CellID));
               end;
           end;
       end;
   end;
end;

procedure TMISMOMappingItems.ItemChange(AnItem : TMISMOMappingItem);
var
   Index : Integer;
begin
   Index := FCellIndex.IndexOfObject(AnItem);
   if Index = -1 then
       FCellIndex.AddObject(IntToStr(AnItem.CellID), AnItem)
   else
       FCellIndex.Strings[Index] := IntToStr(AnItem.CellID);
end;

procedure TMISMOMappingItems.LoadFromFile(const AFileName : string);
var
   Counter : Integer;
   ElementList : IXMLElementList;
   ThisElement : TXMLElement;
begin
   uWindowsInfo.PushMouseCursor;
   try
       if SameText(ExtractFileExt(AFileName), '.xml') then
       begin
           with TXMLCollection.Create do
           try
               LoadFromFile(AFileName);

               ElementList := FindXPath('//FIELD');
               for Counter := 0 to ElementList.Count - 1 do
               begin
                   ThisElement := ElementList[Counter];

                   Self.Add(ThisElement.AttributeValues['ID'], ThisElement.AttributeValues['XPath']);
               end;
           finally
               Free;
           end;
       end
       else
       begin
           with TStringList.Create do
           try
               LoadFromFile(AFileName);

               for Counter := 0 to Count - 1 do
                   Add(Strings[Counter]);
           finally
               Free;
           end;
       end;
   finally
       uWindowsInfo.PopMouseCursor;
   end;
end;

const
   MAX_RESOURCE_ID_GAP = 1000;
   SECOND_TIER_ID_START = 5000;                            //        Composite fields
   THIRD_TIER_ID_START = 10000;                            //        Form ID
   FOURTH_TIER_ID_START = 50000;                           //        Appraisal Order items

procedure TMISMOMappingItems.LoadFromResources;
var
   Counter, LastFoundResourceID : Integer;
   ThisResourceString : string;
begin
   LastFoundResourceID := 0;
   Counter := 0;
   while True do
   begin
       ThisResourceString := SysUtils.LoadStr(Counter);
       if ThisResourceString <> EMPTY_STRING then
       begin
           Add(Counter, ThisResourceString);
           LastFoundResourceID := Counter;
           Inc(Counter);
       end
       else if (Counter - LastFoundResourceID) > MAX_RESOURCE_ID_GAP then
       begin
           if Counter < SECOND_TIER_ID_START then
               Counter := SECOND_TIER_ID_START
           else if Counter < THIRD_TIER_ID_START then
               Counter := THIRD_TIER_ID_START
           else if Counter < FOURTH_TIER_ID_START then
               Counter := FOURTH_TIER_ID_START
           else
               Break;

           LastFoundResourceID := Counter;                 //      allow the starting ID itself to be missing
       end
       else
           Inc(Counter);
   end;
end;

function TMISMOMappingItems.GetMapping(Index : Integer) : TMISMOMappingItem;
begin
   Result := Self.Items[Index] as TMISMOMappingItem;
end;

function TMISMOMappingItems.Find(ACellID : TResourceID) : TMISMOMappingItem;
begin
   Result := Find(IntToStr(ACellID));
end;

function TMISMOMappingItems.Find(ACellID : TResourceID; var AMapping : TMISMOMappingItem) : Boolean;
begin
   Result := Find(IntToStr(ACellID), AMapping);
end;

function TMISMOMappingItems.Find(const ACellID : string) : TMISMOMappingItem;
var
   ThisObject : TObject;
begin
   if FCellIndex.Find(ACellID, ThisObject) then
       Result := TMISMOMappingItem(ThisObject)
   else
       Result := nil;
end;

function TMISMOMappingItems.Find(const ACellID : string; var AMapping : TMISMOMappingItem) : Boolean;
begin
   AMapping := Find(ACellID);
   Result := AMapping <> nil;
end;

function TMISMOMappingItems.First(var AMapping : TMISMOMappingItem) : Boolean;
begin
   Result := Self.Count > 0;
   if Result then
   begin
       FCurrentIndex := -1;
       Result := Next(AMapping);
   end;
end;

function TMISMOMappingItems.Next(var AMapping : TMISMOMappingItem) : Boolean;
begin
   Result := FCurrentIndex < (Self.Count - 1);
   if Result then
   begin
       Inc(FCurrentIndex);
       AMapping := Self.Mappings[FCurrentIndex];
   end
   else
       FCurrentIndex := -1;
end;

function TMISMOMappingItems.Add(ACellID, AnXPath : string) : TMISMOMappingItem;
begin
   Result := Add(StrToInt(ACellID), AnXPath);
end;

function TMISMOMappingItems.Add(ACellID : Integer; AnXPath : string) : TMISMOMappingItem;
begin
   Result := (inherited Add) as TMISMOMappingItem;
   Result.CellID := ACellID;
   Result.XPath := AnXPath;
end;

function TMISMOMappingItems.Add(const AValue : string) : TMISMOMappingItem;
begin
   Result := (inherited Add) as TMISMOMappingItem;
   if AValue <> EMPTY_STRING then
       Result.AsString := AValue;
end;


initialization
finalization
  if assigned(FGlobalMappings) then
    FGlobalMappings.Free;

//  if assigned(FFormTagIDList) then
//    FFormTagIDList.Free;
end.

