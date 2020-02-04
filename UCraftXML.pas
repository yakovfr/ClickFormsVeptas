{
ToDo
Normalize whitespace in attribute values
Allow whitespace between parts of a tag: "/     >", "/   #13#10 >"
If not CDATE, trim both ends and replace any series of whitespace (even inside quotes) to single #20

Handle nested parameter replacements in ELEMENT definition
ELEMENT % barney "&fred;" would try to find an element "fred"
Percent indicates DTD ENTITY (vs. &..;) aka "parameter entitiy"
No Percent indicates element ENTITY aka "general entity"
Check for entities in the replacement value during document parse, not during DTD parse
Apply element ENTITES to text and to replacement text until no more '&'
skip first replacement character (e.g. &amp;)
Attribute Defaults:
Do not allow parameter entities as part of a DTD element: <!ELEMENT notice (title, %ent1;)> is illegal in internal doc
add space on each side of a parameterized element when replacing
tokens can be %DTDEntities: replace first

DTD's can reference external DTD's inside the [..]

DTD <![IGNORE[...]]> and <![INCLUDE[...]]>
nesting is legal, but outermost IGNORE overrides any contained INCLUDE
Need to create a nesting stack when parsing DTD
Add .Enabled property to all DTD elements and entities

Have a ConvertToCanonical procedure or retrieval (.AsCanonicalString)

The canonical form of an XML document is physical representation of the document produced by the method described in this specification. The changes are summarized in the following list:

The document is encoded in UTF-8
Line breaks normalized to #xA on input, before parsing
Attribute values are normalized, as if by a validating processor
Character and parsed entity references are replaced
CDATA sections are replaced with their character content
The XML declaration and document type declaration (DTD) are removed
Empty elements are converted to start-end tag pairs
Whitespace outside of the document element and within start and end tags is normalized
All whitespace in character content is retained (excluding characters removed during line feed normalization)
Attribute value delimiters are set to quotation marks (double quotes)
Special characters in attribute values and character content are replaced by character references
Superfluous namespace declarations are removed from each element
Default attributes are added to each element
Lexicographic order is imposed on the namespace declarations and attributes of each element

Validation
Check for indirect recursion in Entities

From http://xml.com/axml/target.html#AX-Implied
At user option, an XML processor may issue a warning if attributes are declared for an element type not itself declared, but this is not an error.
When more than one definition is provided for the same attribute of a given element type, the first declaration is binding and later declarations are ignored.
an XML processor may at user option, issue a warning when more than one attribute-list declaration is provided for a given element type, or more than one attribute definition is provided for a given attribute, but this is not an error.

TODO:
Well-formedness constraint: PEs in Internal Subset: In the internal DTD subset, parameter-entity references MUST NOT occur within markup declarations; they MAY occur where markup declarations can occur. (This does not apply to references that occur in external parameter entities or to the external subset.)
Well-formedness constraint: External Subset: The external subset, if any, MUST match the production for extSubset.
Well-formedness constraint: PE Between Declarations: The replacement text of a parameter entity reference in a DeclSep MUST match the production extSubsetDecl.
Well-formedness constraint: Unique Att Spec: An attribute name MUST NOT appear more than once in the same start-tag or empty-element tag.
Validity constraint: No Duplicate Types: The same name MUST NOT appear more than once in a single mixed-content declaration.

Create skeleton DTD from parsed data: all elements and attributes
Secular domains (e.g. ANY, dtMixed)
Strict domains: allow only the data as read in the sequence as read
Create schema from DTD: ID's as keys, IDREF as foreign keys
Create DTD from schema (e.g. without import or with sampling)

Validate
Regular expression engine
Assign to TreeView
Text as Hint?
Validate while streaming
fatal and local errors
ValidateDTD should set standalone value
xml:lang as an attribute. Well, any application can look it up if they want it, but it would be nice to propogate it as a courtesy
}

{      Validity:
attribute enumeration values for a single attribute must be unique
#FIXED must exist and match
Default attribute values must be legal (e.g. one of the enumerated types, an ID, etc.)
The replacement text of any entity referred to directly or indirectly in an attribute value MUST NOT contain a <.
An attribute name MUST NOT appear more than once in the same start-tag or empty-element tag.
Errors as events (-->TXML component to host event handlers?)
It is an error if an attribute value contains a reference to an entity for which no declaration has been read.
}

{      Warnings:
if an attribute enumeration value appears more than once in all the attributes of an element
For compatibility, an attribute of type NOTATION MUST NOT be declared on an element declared EMPTY.
Warn on well-formed check that external reference is present but not read and checked
Quote in parameters entity replacement text will not terminate a quoted value
}

unit uCraftXML;

interface

uses
   Classes, SysUtils, Controls, StdCtrls, uCraftClass;

type
   TRepeatType = (rtUnknown, rtOne, rtOptionalOne, rtMany, rtOptionalMany);
   TStepAxis = (saUnknown, saChild, saParent, saDescendant, saAncestor, saSelf, saAttribute,
       saFollowingSibling, saPrecedingSibling, saNamespace, saFollowing, saPreceding,
       saDescendantOrSelf, saAncestorOrSelf, saChildOrSelf, saParentOrSelf);

const
   REPEAT_OPTIONAL_ONCE = '?';
   REPEAT_OPTIONAL_MANY = '*';
   REPEAT_REQUIRED_MANY = '+';
   REPEAT_SYMBOLS : array[TRepeatType] of string = ('X', '', REPEAT_OPTIONAL_ONCE, REPEAT_REQUIRED_MANY, REPEAT_OPTIONAL_MANY);
   DEFAULT_READ_BUFFER_SIZE = 50000;

   STEP_AXIS_NAMES : array[TStepAxis] of string = ('unknown', 'child', 'parent', 'descendant', 'ancestor', 'self',
       'attribute', 'following-sibling', 'preceding-sibling', 'namespace', 'following', 'preceding',
       'descendant-or-self', 'ancestor-or-self', 'child-or-self', 'parent-or-self');

   DEFAULT_PRESERVE_WHITESPACE = True;
   DEFAULT_NESTED_ENTITY_REPLACEMENT_LIMIT = 100;
   DEFAULT_ENFORCE_NESTED_ELEMENT_REFERENCE_SEQUENCE = False;
   DEFAULT_ALLOW_EXTERNAL_ENTITY_REFERENCES = True;
   DEFAULT_EXPAND_EXTERNAL_ENTITY_REFERENCES = True;

   XLINK_NAMESPACE_URI = 'http://www.w3.org/1999/xlink';
   DEFAULT_XLINK_PREFIX = 'xlink';
   XINCLUDE_NAMESPACE_URI = 'http://www.w3.org/2001/XInclude';
   DEFAULT_XINCLUDE_PREFIX = 'xi';

   XPATH_POSITION_FUNCTION = 'position';
   XPATH_LAST_FUNCTION = 'last';
   XPATH_ID_FUNCTION_NAME = 'id';
   XPATH_TEXT_FUNCTION_NAME = 'text';
   XPATH_NOT_FUNCTION = 'not';

type
   TXLinkType = (ltUnknown, ltSimple, ltExtended, ltLocator, ltArc, ltResource, ltTitle, ltNone);
   TXLinkShow = (lsUnknown, lsNew, lsReplace, lsEmbed, lsOther, lsNone);
   TXLinkActuate = (laUnknown, laOnLoad, laOnRequest, laOther, laNone);

const
   XLINK_TYPE_NAMES : array[TXLinkType] of string = ('unknown', 'simple', 'extended', 'locator', 'arc', 'resource', 'title', 'none');
   XLINK_SHOW_NAMES : array[TXLinkShow] of string = ('unknown', 'new', 'replace', 'embed', 'other', 'none');
   XLINK_ACTUATE_NAMES : array[TXLinkActuate] of string = ('unknown', 'onLoan', 'onRequest', 'other', 'none');

function StrToXLinkType(const AString : string) : TXLinkType;
function StrToXLinkShow(const AString : string) : TXLinkShow;
function StrToXLinkActuate(const AString : string) : TXLinkActuate;

type
   TXMLElement = class;
   TXLink = class(TPersistent)
   private
       FElement : TXMLElement;
       FType : TXLinkType;
       FLabel : string;
       FActuate : TXLinkActuate;
       FShow : TXLinkShow;
       FFrom : string;
       FTo : string;
       FArcRole : string;
       FTitle : string;
       FRole : string;
       FHRef : string;
   protected
       property Element : TXMLElement read FElement;
   public
       constructor Create(AnXMLElement : TXMLElement);
       procedure Assign(Source : TPersistent); override;

       property LinkType : TXLinkType read FType write FType nodefault;
       property Show : TXLinkShow read FShow write FShow;
       property Actuate : TXLinkActuate read FActuate write FActuate;
       property LinkLabel : string read FLabel write FLabel;
       property LinkFrom : string read FFrom write FFrom;
       property LinkTo : string read FTo write FTo;
       property Role : string read FRole write FRole;
       property ArcRole : string read FArcRole write FArcRole;
       property Title : string read FTitle write FTitle;
       property HRef : string read FHRef write FHRef;

       procedure Validate;
       function Compose : string;
   end;

   TXMLElementList = class;
   IXMLElementList = interface(IAutoStringList)
       ['{9F9BE37A-02C2-425F-B62A-722FDD79B619}']
       function GetElement(Index : Integer) : TXMLElement;
       function GetElementInDocOrder(Index : Integer) : TXMLElement;
       function Push(AnXMLElement : TXMLElement) : TXMLElement;
       function Pop : TXMLElement;
       function Top : TXMLElement;
       function IsEmpty : Boolean;
       function SeparatedNames(ASeparator : AnsiString; Ascending : Boolean = True) : AnsiString;
       property Elements[Index : Integer] : TXMLElement read GetElement; default;
       function Add(AnElement : TXMLElement) : Integer; overload;
       procedure Add(SomeElements : TXMLElementList); overload;
       function First(var AnElement : TXMLElement) : Boolean;
       function Next(var AnElement : TXMLElement) : Boolean;
       function Find(const AName : string) : TXMLElement; overload;
       function Find(const AName : string; var AnElement : TXMLElement; AStartingIndex : Integer = 0) : Boolean; overload;
       function Find(const AName : string; var AnIndex : Integer; AStartingIndex : Integer = 0) : Boolean; overload;
       function Find(AnElement : TXMLElement; var AnIndex : Integer; AStartingIndex : Integer = 0) : Boolean; overload;
       function IndexOf(AnElement : TXMLElement) : Integer; overload;
       procedure Remove(const AName : string); overload;
       procedure Remove(AnElement : TXMLElement); overload;
       procedure IntersectWith(AList : TXMLElementList);
       procedure UnionWith(AList : TXMLElementList);
       property ElementsInDocOrder[Index : Integer] : TXMLElement read GetElementInDocOrder;
       function DocOrderIndexOf(AnElement : TXMLElement) : Integer;
   end;

   TXMLCollection = class;
   TBaseXMLElementList = class(TAutoStringList, IXMLElementList)
   private
       FNextIndex : Integer;
       FDocOrderCrossReference : TList;
       FOwner : TXMLCollection;
       function GetElement(Index : Integer) : TXMLElement;
       function GetElementInDocOrder(Index : Integer) : TXMLElement;
       function GetDocOrderCrossReference : TList;
   protected
       procedure Changed; override;
       property DocOrderCrossReference : TList read GetDocOrderCrossReference;
       property Owner : TXMLCollection read FOwner;
   public
       constructor Create; override;
       constructor Create(AnOwner : TXMLCollection); reintroduce; overload;
       destructor Destroy; override;
       procedure Clear; override;
       function Push(AnXMLElement : TXMLElement) : TXMLElement;
       function Pop : TXMLElement;
       function Top : TXMLElement;
       function IsEmpty : Boolean;
       function SeparatedNames(ASeparator : AnsiString; Ascending : Boolean = True) : AnsiString;
       property Elements[Index : Integer] : TXMLElement read GetElement; default;
       function Add(AnElement : TXMLElement) : Integer; reintroduce; overload;
       procedure Add(SomeElements : TXMLElementList); reintroduce; overload;
       function First(var AnElement : TXMLElement) : Boolean;
       function Next(var AnElement : TXMLElement) : Boolean;
       function Find(const AName : string) : TXMLElement; reintroduce; overload;
       function Find(const AName : string; var AnElement : TXMLElement; AStartingIndex : Integer = 0) : Boolean; reintroduce; overload;
       function Find(const AName : string; var AnIndex : Integer; AStartingIndex : Integer = 0) : Boolean; reintroduce; overload;
       function Find(AnElement : TXMLElement; var AnIndex : Integer; AStartingIndex : Integer = 0) : Boolean; reintroduce; overload;
       function IndexOf(AnElement : TXMLElement) : Integer; reintroduce; overload;
       procedure Remove(const AName : string); overload;
       procedure Remove(AnElement : TXMLElement); overload;
       procedure IntersectWith(AList : TXMLElementList);
       procedure UnionWith(AList : TXMLElementList);
       property ElementsInDocOrder[Index : Integer] : TXMLElement read GetElementInDocOrder;
       function DocOrderIndexOf(AnElement : TXMLElement) : Integer;
   end;

   TAutoXMLElementList = class(TBaseXMLElementList);

   TXMLElementList = class(TBaseXMLElementList)
   public
       function _AddRef : Integer; override; stdcall;      //  turn off reference counting
       function _Release : Integer; override; stdcall;
   end;

   TBaseXMLCollectionItem = class(TCraftingCollectionItem)
   private
       FLineNumber : Integer;
       FRawText : AnsiString;
       function GetAsString : AnsiString;
   public
       procedure Clear; override;
       procedure Parse(AText : AnsiString); virtual;
       function Compose(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString; virtual;
       property AsString : AnsiString read GetAsString write Parse;
       property LineNumber : Integer read FLineNumber write FLineNumber;
       property RawText : AnsiString read FRawText write FRawText;
   end;

   TBaseXMLCollection = class(TCraftingCollection)
   protected
       function XMLCollection : TXMLCollection; virtual; abstract;
   end;

   TReferenceType = (rtInternal, rtPublic, rtSystem, rtDefault);
   TDocType = class;

   //             DTD Objects
   TBaseDTDItem = class(TBaseXMLCollectionItem);
   TBaseDTDCollection = class(TBaseXMLCollection)
   private
       FDocType : TDocType;
   protected
       property DocType : TDocType read FDocType write FDocType;
   end;

   TDTDNotation = class(TBaseDTDItem)
   private
       FName : AnsiString;
       FExternalOwner : AnsiString;
       FExternalReference : AnsiString;
       FReferenceType : TReferenceType;
   protected
       function GetIndexName : string; override;
   public
       property Name : AnsiString read FName write FName;
       property ExternalOwner : AnsiString read FExternalOwner write FExternalOwner;
       property ExternalReference : AnsiString read FExternalReference write FExternalReference;
       property ReferenceType : TReferenceType read FReferenceType write FReferenceType default rtInternal;
       function Compose(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString; override;
       procedure Parse(AText : AnsiString); override;
   end;

   TDTDNotations = class(TBaseDTDCollection)
   private
       function GetNotation(Index : Integer) : TDTDNotation;
   protected
       function XMLCollection : TXMLCollection; override;
   public
       constructor Create; reintroduce; overload;
       property Items[Index : Integer] : TDTDNotation read GetNotation;
       function Add : TDTDNotation;                        //  replaces TCollection.Add
   end;

   TDTDEntity = class(TBaseDTDItem)
   private
       FName : AnsiString;
       FLiteral : AnsiString;
       FNotation : AnsiString;
       FExternalOwner : AnsiString;
       FReferenceType : TReferenceType;
       FIsParameterEntity : Boolean;
       FReplacementText : AnsiString;

       function GetReplacementText : AnsiString;
   protected
       function GetSystemEntity : AnsiString;
       function GetPublicEntity : AnsiString;
       function GetExternalReference : AnsiString;
       function DocType : TDocType;
       function GetIndexName : string; override;
       function XMLCollection : TXMLCollection;
   public
       constructor Create(ACollection : TCollection); override;
       property Name : AnsiString read FName write FName;
       property Literal : AnsiString read FLiteral write FLiteral;
       property Notation : AnsiString read FNotation write FNotation;
       property ExternalOwner : AnsiString read FExternalOwner write FExternalOwner;
       property ReferenceType : TReferenceType read FReferenceType write FReferenceType default rtInternal;
       property IsParameterEntity : Boolean read FIsParameterEntity write FIsParameterEntity;
       function Compose(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString; override;
       procedure Parse(AText : AnsiString); override;
       property ReplacementText : AnsiString read GetReplacementText;
       property ExternalReference : AnsiString read GetExternalReference;
   end;

   TDTDEntityReference = class(TBaseDTDItem)
   private
       FEntity : TDTDEntity;
   protected
       function XMLCollection : TXMLCollection;
   public
       property Entity : TDTDEntity read FEntity write FEntity;
       function Compose(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString; override;
   end;

   TDTDEntityReferences = class(TBaseDTDCollection)
   private
       function GetReference(Index : Integer) : TDTDEntityReference;
   protected
       function XMLCollection : TXMLCollection; override;
   public
       constructor Create; reintroduce; overload;
       property References[Index : Integer] : TDTDEntityReference read GetReference;
       function Add : TDTDEntityReference;
   end;

   TDTDEntities = class(TBaseDTDCollection)
   private
       function GetEntity(Index : Integer) : TDTDEntity;
   protected
       function XMLCollection : TXMLCollection; override;
   public
       constructor Create; reintroduce; overload;
       function Add : TDTDEntity; overload;                //  replacing TCollection.Add
       function Add(const AName, AReplacementText : string; AType : TReferenceType = rtDefault) : TDTDEntity; overload;
       function Find(AName : AnsiString; ParameterEntitiesOnly : Boolean = False) : TDTDEntity; overload;
       function Find(AName : AnsiString; var AnEntity : TDTDEntity; ParameterEntitiesOnly : Boolean = False) : Boolean; overload;
       function LookupName(AName : AnsiString; var AValue : AnsiString; ParameterEntitiesOnly : Boolean = False) : Boolean;
       function LookupValue(AValue : AnsiString; var AName : AnsiString; ParameterEntitiesOnly : Boolean = False) : Boolean; overload;
       function LookupValue(AValue : AnsiString; AnEntity : TDTDEntity; ParameterEntitiesOnly : Boolean = False) : Boolean; overload;
       property Entities[Index : Integer] : TDTDEntity read GetEntity; default;
   end;

   TDTDElement = class;

   TDefaultType = (dtNone, dtRequired, dtImplied, dtFixed, dtLiteral); //  dtImplied ==> optional
   TAttributeType = (atCData, atID, atIDREF, atIDREFS, atENTITY, atENTITIES, atNMTOKEN, atNMTOKENS, atEnumeration, atImpliedCData);

   TDTDAttribute = class(TBaseXMLCollectionItem)           //  not TBaseDTDItem because it does not exist outside of a DTDElement
   private
       FAttributeName : AnsiString;
       FAttributeEnums : TCraftingStringList;
       FAttributeType : TAttributeType;
       FDefaultValue : AnsiString;
       FDefaultType : TDefaultType;
       FIsNotation : Boolean;
       function GetAttributeEnum(Index : Integer) : AnsiString;
   protected
       procedure SetType(AType : string);
       procedure SetDefault(ADefault : string);
       function GetAttributeEnums : TStrings;
       function GetIndexName : string; override;
   public
       constructor Create(ACollection : TCollection); override;
       destructor Destroy; override;
       function Compose(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString; override;
       property Name : AnsiString read FAttributeName write FAttributeName;
       property AttributeEnum[Index : Integer] : AnsiString read GetAttributeEnum;
       property AttributeEnums : TStrings read GetAttributeEnums;
       function AttributeEnumCount : Integer;
       function FindAttributeEnum(const AValue : string) : Boolean;
       function AttributeEnumText : string;
       property AttributeType : TAttributeType read FAttributeType write FAttributeType;
       property DefaultValue : AnsiString read FDefaultValue write FDefaultValue;
       property DefaultType : TDefaultType read FDefaultType write FDefaultType default dtImplied;
       property IsNotation : Boolean read FIsNotation write FIsNotation default False;
       function Element : TDTDElement;
       function XPaths : IAutoStringList; overload;
       function XPaths(AList : TStrings) : Integer; overload;
   end;

   TDTDAttributes = class(TBaseDTDCollection)
   private
       FElement : TDTDElement;
       function GetAttribute(Index : Integer) : TDTDAttribute;
       function GetDefaultAttributeValue(const AnAttributeName : string) : string;
   protected
       function XMLCollection : TXMLCollection; override;
   public
       property Element : TDTDElement read FElement write FElement;
       procedure Parse(AText : AnsiString);
       function Compose(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString; overload;
       procedure Compose(ResultStrings : TStrings; StartingIndent : Integer = 0; StartingLineNumber : Integer = 0); overload;
       function Find(AName : AnsiString) : TDTDAttribute; overload;
       function Find(AName : AnsiString; var AnAttribute : TDTDAttribute) : Boolean; overload;
       function Find(AType : TAttributeType; var AnAttribute : TDTDAttribute) : Boolean; overload;
       property Attributes[Index : Integer] : TDTDAttribute read GetAttribute; default;
       property DefaultAttributeValues[const AnAttributeName : string] : string read GetDefaultAttributeValue;
       function First(var AnAttribute : TDTDAttribute) : Boolean; reintroduce; overload;
       function Next(var AnAttribute : TDTDAttribute) : Boolean; reintroduce; overload;
       function Add : TDTDAttribute;
   end;

   {
   A(B, C, (D | E | F), (G | (H, I)))

   A.ChildElements = B, C, #1, #2

   #1.ChildElements = D, E, F
   #2.ChildElements = G, #H
   #H.ChildElements = H, I

   }
   TNestedElementReferencesSequence = (rsUnknown, rsOr, rsAnd, rsSole);
   TNestedElementReferences = class;
   TNestedElementReference = class(TBaseXMLCollectionItem)
   private
       FName : AnsiString;
       FRepeatType : TRepeatType;
       FNestedElementReferences : TNestedElementReferences;
       procedure SetName(Value : string);
   protected
       function ParentReferences : TNestedElementReferences;
       function GetIndexName : string; override;
   public
       constructor Create(ACollection : TCollection); override;
       destructor Destroy; override;
       procedure Clear; override;

       //  				Sole name or, if it has nested-elements, the Name is the first only if the sub-elements are sequential
       property Name : AnsiString read FName write SetName;
       property NestedElementReferences : TNestedElementReferences read FNestedElementReferences;
       function NestedElementReferenceCount : Integer;
       property RepeatType : TRepeatType read FRepeatType write FRepeatType;
       function Compose : AnsiString; reintroduce; overload;
       procedure Parse(AText : AnsiString); override;
       function Element : TDTDElement;
       function IsNested : Boolean;
   end;

   TNestedElementReferences = class(TBaseDTDCollection)
   private
       FRepeatType : TRepeatType;
       FElement : TDTDElement;
       FSequence : TNestedElementReferencesSequence;
       FReference : TNestedElementReference;

       function GetReference(Index : Integer) : TNestedElementReference;
   protected
       property Reference : TNestedElementReference read FReference;
       function XMLCollection : TXMLCollection; override;
       procedure Update(AnItem : TCollectionItem); override;
   public
       constructor Create(AnElement : TDTDElement); reintroduce; overload;
       property References[Index : Integer] : TNestedElementReference read GetReference; default;
       property Sequence : TNestedElementReferencesSequence read FSequence;
       property RepeatType : TRepeatType read FRepeatType;
       function Add : TNestedElementReference;
       function FindNext(const AnElementName : AnsiString) : TNestedElementReference; overload;
       function FindNext(const AnElementName : AnsiString; var AReference : TNestedElementReference;
           StartIndex : Integer = 0; EndIndex : Integer = -1) : Boolean; overload;
       function Find(const AnElementName : AnsiString) : TNestedElementReference; overload;
       function Find(const AnElementName : AnsiString; var AReference : TNestedElementReference) : Boolean; overload;
       property Element : TDTDElement read FElement;       //	the owning/parent DTDElement
       function Compose : string;
       procedure LoadReferences(AStrings : TStrings); overload; //	loads the names of all descendent references
       function LoadReferences : string; overload;
       function First(var AReference : TNestedElementReference) : Boolean; reintroduce; overload;
       function Next(var AReference : TNestedElementReference) : Boolean; reintroduce; overload;
   end;

   TDTDElementsEnumerator = class(TCollectionEnumerator)
   public
       function First(var ADTDElement : TDTDElement; IncludeIgnoredElements : Boolean = False) : Boolean; reintroduce; overload;
       function Next(var ADTDElement : TDTDElement; IncludeIgnoredElements : Boolean = False) : Boolean; reintroduce; overload;
   end;

   TElementType = (etUnknown, etAny, etMixed, etElements, etEmpty, etAttributesOnly, etComment);
   TDTDElementEvent = procedure(AnElement : TDTDElement) of object;
   TDTDElements = class(TBaseDTDCollection)
   private
       FElementNameLookup : TCraftingStringList;
       FEnumerator : TDTDElementsEnumerator;
       function GetElement(Index : Integer) : TDTDElement;
   protected
       procedure IndexElementNames;
       procedure ItemChange(AnElement : TDTDElement);
       procedure Notify(AnItem : TCollectionItem; AnAction : TCollectionNotification); override;
       function XMLCollection : TXMLCollection; override;
   public
       constructor Create; reintroduce; overload;
       destructor Destroy; override;
       function Add(AName : string = '') : TDTDElement;
       procedure Clear; override;
       function Find(const AName : AnsiString; IncludeIgnoredElements : Boolean = False) : TDTDElement; overload;
       function Find(const AName : AnsiString; var AnElement : TDTDElement) : Boolean; overload;
       function Find(const AName : AnsiString; IncludeIgnoredElements : Boolean; var AnElement : TDTDElement) : Boolean; overload;
       property Elements[Index : Integer] : TDTDElement read GetElement; default;
       function First(var ADTDElement : TDTDElement; IncludeIgnoredElements : Boolean = False) : Boolean; reintroduce; overload;
       function Next(var ADTDElement : TDTDElement; IncludeIgnoredElements : Boolean = False) : Boolean; reintroduce; overload;
       function FirstComment(var ADTDElement : TDTDElement) : Boolean;
       function NextComment(var ADTDElement : TDTDElement) : Boolean;
   end;

   TDTDElementList = class;
   TDTDElement = class(TBaseDTDItem)
   private
       FName : AnsiString;
       FElementType : TElementType;
       FNestedElements : TNestedElementReferences;
       FAttributes : TDTDAttributes;
       FIgnore : Boolean;
       FNestedEnumerator : TCollectionEnumerator;
       function GetDocType : TDocType;
       function GetElementMask : AnsiString;
       procedure SetElementMask(Value : AnsiString);
       function GetNestedElementRepetition : TRepeatType;
       procedure SetNestedElementRepetition(Value : TRepeatType);
   protected
       function GetIndexName : string; override;
       function XMLCollection : TXMLCollection;
       procedure CheckElementType;
   public
       constructor Create(ACollection : TCollection); override;
       destructor Destroy; override;
       property ElementType : TElementType read FElementType;
       function Compose(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString; override;
       procedure Parse(AText : AnsiString); override;
       property DocType : TDocType read GetDocType;
       property Attributes : TDTDAttributes read FAttributes;
       function AttributeByName(const AName : string) : TDTDAttribute;
       function FindAttribute(const AName : string) : TDTDAttribute;
       function AttributeCount : Integer;

       function LoadUsedByList(ADTDElementList : TDTDElementList = nil) : Integer;

       property Name : AnsiString read FName;

       function FirstChildElement(var AnElement : TDTDElement) : Boolean;
       function NextChildElement(var AnElement : TDTDElement) : Boolean;

       property NestedElements : TNestedElementReferences read FNestedElements;
       property NestedElementsRepetition : TRepeatType
           read GetNestedElementRepetition write SetNestedElementRepetition;
       function FindNextReference(AnElementName : AnsiString;
           var AChildReference : TNestedElementReference; CheckMultiples : Boolean = True) : Boolean;
       function FindNextRequiredReference(var AReference : TNestedElementReference) : Boolean;
       function XPaths : IAutoStringList; overload;
       function XPaths(AList : TStrings) : Integer; overload;

       class function GetRepeatSymbol(ARepeatType : TRepeatType) : AnsiString;
       class function GetRepeatType(AString : AnsiString) : TRepeatType;
       class function StripRepeatType(var AString : AnsiString) : TRepeatType;
   published
       property ElementName : AnsiString read FName write FName;
       property ElementMask : AnsiString read GetElementMask write SetElementMask;
       property Ignore : Boolean read FIgnore write FIgnore default False;
   end;

   TDTDElementList = class(TStringList)
   private
       function GetElement(Index : Integer) : TDTDElement;
   public
       function Add(ADTDElement : TDTDElement) : Integer; reintroduce; overload;
       property Elements[Index : Integer] : TDTDElement read GetElement; default;
   end;

   TLoadXPathsOption = (lxElements, lxAttributes, lxElementText);
   TLoadXPathsOptions = set of TLoadXPathsOption;

   TDocType = class(TObject)
   private
       FName : AnsiString;
       FExternalReference : AnsiString;
       FExternalOwner : AnsiString;
       FElements : TDTDElements;
       FEntities : TDTDEntities;
       FNotations : TDTDNotations;
       FReferenceType : TReferenceType;
       FCollection : TXMLCollection;
       FEnforceNestedElementReferenceSequence : Boolean;
       FNestedEntityReplacementLimit : Integer;
       FAllowExternalEntityReferences : Boolean;
       FExpandExternalEntityReferences : Boolean;
       FEntityBase : string;
       FUniversalBaseAttribute : TDTDAttribute;
       FUniversalNamespaceAttribute : TDTDAttribute;
       FRootElement : TDTDElement;
       FLineNumber : Integer;
       FItems : TList;
       FReferences : TDTDEntityReferences;
       FPleaseAddToItems : Boolean;
       FFileName : string;

       function GetRootElement : TDTDElement;
       procedure SetRootElement(Value : TDTDElement);
       function GetItem(Index : Integer) : TBaseDTDItem;
   protected
       property DTDElements : TDTDElements read FElements;
       function BaseReplaceEntities(AString : string; RecursionLevel : Integer;
           ParameterEntities : Boolean = False; RecursionCheckEntityList : TStrings = nil) : string;
       property UniversalBaseAttribute : TDTDAttribute read FUniversalBaseAttribute;
       property UniversalNamespaceAttribute : TDTDAttribute read FUniversalNamespaceAttribute;
       property Items[Index : Integer] : TBaseDTDItem read GetItem;
       function ItemCount : Integer;
       procedure AddItem(AnItem : TBaseDTDItem);
       property PleaseAddToItems : Boolean read FPleaseAddToItems write FPleaseAddToItems default True;
       property FileName : string read FFileName write FFileName;
   public
       constructor Create(ACollection : TXMLCollection);
       destructor Destroy; override;
       procedure Clear;
       procedure Assign(Source : TObject); virtual;
       function IsEmpty : Boolean;
       property XMLCollection : TXMLCollection read FCollection;
       procedure LoadFromFile(const AFileName : string; AnErrorReport : TStrings = nil);
       procedure SaveToFile(const AFileName : string);
       procedure Parse(AText : AnsiString; AnErrorReport : TStrings = nil);
       procedure ParseDTD(Value : AnsiString; EntityBase : string = ''; EntityRecursionLevel : Integer = 0); overload;
       procedure ParseDTD(Value : AnsiString; AnErrorReport : TStrings;
           AnEntityBase : string = ''; EntityRecursionLevel : Integer = 0); overload;
       function Compose(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString; overload;
       procedure Compose(ResultStrings : TStrings; StartingIndent : Integer = 0; StartingLineNumber : Integer = 0); overload;
       function ComposeCore(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString; overload;
       procedure ComposeCore(ResultStrings : TStrings; StartingIndent : Integer = 0; StartingLineNumber : Integer = 0); overload;
       function Validate(AReport : TStrings = nil) : Boolean; //  check for internal consistency (e.g. all references are present)
       function NotationExists(const AName : AnsiString) : Boolean;
       function ReplaceParameterEntities(AString : string; RecursionLevel : Integer = 0) : string;
       function ReplaceEntities(AString : string; RecursionLevel : Integer = 0) : string;

       property Name : AnsiString read FName write FName;
       property RootElement : TDTDElement read GetRootElement write SetRootElement;
       property ReferenceType : TReferenceType read FReferenceType write FReferenceType default rtInternal;
       property ExternalReference : AnsiString read FExternalReference write FExternalReference;
       property ExternalOwner : AnsiString read FExternalOwner write FExternalOwner;
       property Entities : TDTDEntities read FEntities;
       property Notations : TDTDNotations read FNotations;
       property Elements : TDTDElements read FElements;
       property EntityBase : string read FEntityBase write FEntityBase; //	the base for releative entity locations

       property EnforceNestedElementReferenceSequence : Boolean
           read FEnforceNestedElementReferenceSequence write FEnforceNestedElementReferenceSequence
           default DEFAULT_ENFORCE_NESTED_ELEMENT_REFERENCE_SEQUENCE;
       property NestedEntityReplacementLimit : Integer
           read FNestedEntityReplacementLimit write FNestedEntityReplacementLimit
           default DEFAULT_NESTED_ENTITY_REPLACEMENT_LIMIT;
       property AllowExternalEntityReferences : Boolean
           read FAllowExternalEntityReferences write FAllowExternalEntityReferences
           default DEFAULT_ALLOW_EXTERNAL_ENTITY_REFERENCES;
       property ExpandExternalEntityReferences : Boolean
           read FExpandExternalEntityReferences write FExpandExternalEntityReferences
           default DEFAULT_EXPAND_EXTERNAL_ENTITY_REFERENCES;

       property LineNumber : Integer read FLineNumber write FLineNumber;
       procedure LoadXPaths(AStrings : TStrings; Options : TLoadXPathsOptions = [lxElements, lxAttributes, lxElementText]);
       function TestXPath(AnXPath : string) : Boolean; overload;
       function TestXPath(AnXPath : string; var ASuccessfulPart : string) : Boolean; overload;
   end;

   TRequiredMarkupDeclaration = (rmdNone, rmdInternal, rmdAll);

   EXMLError = class(Exception)
   public
       CharacterOffset : Integer;
       ElementIndex : Integer;
       ElementName : string;
       constructor Create(AMessage : AnsiString; ACharacterOffset : Integer; AnElementIndex : Integer); reintroduce; overload;
       function Location : string;
   end;

   EXMLSpecificationViolationError = class(EXMLError);
   EXMLInvalidSystemAttributeValueError = class(EXMLSpecificationViolationError);

   EXMLFormatError = class(EXMLError);
   EXMLUnsupportedByteOrderError = class(EXMLFormatError);
   EXMLUnsupportedEncodingError = class(EXMLFormatError);
   EXMLRootElementAlreadyExistsError = class(EXMLFormatError);

   EXMLSecuritySettingError = class(EXMLError);
   EXMLExternalEntitiesDisallowedError = class(EXMLSecuritySettingError);
   EXMLNestedEntityLimitError = class(EXMLSecuritySettingError);

   EXPathError = class(EXMLError);
   EXPathNoMatchingElementError = class(EXPathError);
   EXPathMultipleMatchingElementError = class(EXPathError);
   EXPathAttributeNodesUnsupportedError = class(EXPathError);
   EMalformedXPathError = class(EXPathError);

   EXMLWellFormedError = class(EXMLFormatError);
   EXMLEndTagMissingError = class(EXMLWellFormedError);
   EXMLAttListReferencesUnknownElement = class(EXMLWellFormedError);
   EXMLUnknownEntityError = class(EXMLWellFormedError);
   EXMLDuplicateNamespacePrefixError = class(EXMLWellFormedError);
   EXMLNotationDisallowedForParameterEntityReferenceError = class(EXMLWellFormedError);
   EXMLExternalEntityReferenceMissingError = class(EXMLWellFormedError);

   EXMLValidationError = class(EXMLWellFormedError);
   EXMLValidationErrorClass = class of EXMLValidationError;
   EXMLValidationAttributeElementNotDefinedError = class(EXMLValidationError);
   EXMLValidationElementDeclarationReferenceMissingWarning = class(EXMLValidationError);
   EXMLValidationRequiredChildElementMissingError = class(EXMLValidationError);
   EXMLValidationRequiredTextMissingError = class(EXMLValidationError);
   EXMLValidationExtraChildElementError = class(EXMLValidationError);
   EXMLValidationExtraTextError = class(EXMLValidationError);
   EXMLValidationInvalidExternalReferenceError = class(EXMLValidationError);
   EXMLUnknownAttributeError = class(EXMLValidationError);

   EXLinkValidationError = class(EXMLValidationError);

   EAbortAfterParsingRootElement = class(EAbort);

   TOnValidationError = procedure(Sender : TObject; AnError : EXMLValidationError) of object;

   TXMLReadEvent = procedure(Sender : TObject; var NewData : AnsiString; var EndData : Boolean) of object;
   TXMLElementEvent = procedure(Sender : TObject; AnElement : TXMLElement) of object;
   TXMLElementClass = (ecUnknown, ecComment, ecElement, ecMarkedSection, ecProcessInstructions);
   TXMLElementClasses = set of TXMLElementClass;

   TXMLElement = class(TBaseXMLCollectionItem)
   private
       FElementClass : TXMLElementClass;
       FElementName : AnsiString;
       FRawTexts : TCraftingStringList;
       FParentElement : TXMLElement;
       FElementList : TXMLElementList;
       FAttributeList : TStringList;
       FPreserveWhitespace : Boolean;
       FLanguage : AnsiString;
       FOnChange : TNotifyEvent;
       FCurrentNextIndex : Integer;
       FDefaultNamespaceID : Integer;
       FNamespaceID : Integer;
       FDTDElement : TDTDElement;
       FDefinedNamespaceIDs : array of Integer;
       FStartingCharacterOffset : Integer;
       FBase : string;
       FTag : Integer;
       FXLink : TXLink;

       function GetElement(Index : Integer) : TXMLElement;
       function GetAttribute(AIndex : Integer) : AnsiString;
       function GetAttributeValue(const AName : AnsiString) : AnsiString;
       function GetAttributeName(Index : Integer) : AnsiString;
       function GetAttributeIndexValue(Index : Integer) : AnsiString;
       procedure SetAttributeValue(const AName, AValue : AnsiString);
       function GetText : AnsiString;
       procedure SetText(const Value : AnsiString);
       function GetNormalizedText : AnsiString;
       procedure SetParentElement(Value : TXMLElement);
       function GetElementName : AnsiString;
       procedure SetElementClass(Value : TXMLElementClass);
       function DescendentCount : Integer;
       procedure DoElementAdded(AnElement : TXMLElement); virtual;
       procedure DoElementDeleted(AnElement : TXMLElement); virtual;
       function GetXPath : AnsiString;
       function GetNamespaceURI : AnsiString;
       function GetExpandedName : AnsiString;
       function GetDTDElement : TDTDElement;
       function GetNamespacePrefix : AnsiString;
       procedure SetNameSpacePrefix(const Value : AnsiString);
       function GetBase : string;
       function GetXLink : TXLink;
       procedure RawTextsChange(Sender : TObject);
   protected
       function ElementName : AnsiString;                  //         deprecated
       procedure AssignTo(Target : TPersistent); override;
       function AddNamespace(const ANamespacePrefix, ANamespace : string) : Integer;
       property NamespaceID : Integer read FNamespaceID;
       property DefaultNamespaceID : Integer read FDefaultNamespaceID;
       function AddDefinedNamespaceID(AnID : Integer) : Integer;
       function FindDefinedNamespacePrefix(const ANamespacePrefix : string) : Integer; overload;
       function FindDefinedNamespacePrefix(const ANamespacePrefix : string; var Index : Integer) : Boolean; overload;
       property StartingCharacterOffset : Integer read FStartingCharacterOffset;
       procedure UpdateText(AnElement : TXMLElement);
   public
       constructor Create(ACollection : TCollection); override;
       procedure AfterConstruction; override;
       procedure BeforeDestruction; override;
       destructor Destroy; override;
       procedure Clear; override;
       procedure Assign(Source : TPersistent); override;
       property Name : AnsiString read GetElementName write FElementName; //  i.e. local-name
       property NamespacePrefix : AnsiString read GetNamespacePrefix write SetNameSpacePrefix;
       property NamespaceURI : AnsiString read GetNamespaceURI;
       property ExpandedName : AnsiString read GetExpandedName;
       function SameName(AnElementName : string) : Boolean;
       property XPath : AnsiString read GetXPath;
       property Language : AnsiString read FLanguage write FLanguage;
       property Text : AnsiString read GetText write SetText;
       property NormalizedText : AnsiString read GetNormalizedText;
       property ParentElement : TXMLElement read FParentElement write SetParentElement;
       function NextSibling : TXMLElement;
       function PrevSibling : TXMLElement;
       property Elements[Index : Integer] : TXMLElement read GetElement;
       function ElementCount : Integer;
       function FindText(AText : AnsiString) : TXMLElement; overload;
       function FindText(const AText : AnsiString; var AnElement : TXMLElement) : Boolean; overload;
       procedure AddText(Value : AnsiString; AnElement : TXMLElement = nil);
       function FindValue(const AName : AnsiString) : AnsiString; overload;
       function FindValue(const AName : AnsiString; var AValue : AnsiString) : Boolean; overload;
       function FindElement(AnElementName : AnsiString) : TXMLElement; overload;
       function FindElement(AnElementName : AnsiString; var AnElement : TXMLElement) : Boolean; overload;
       function FindXPath(AnXPath : AnsiString) : IXMLElementList; overload;
       function FindXPath(AnXPath : AnsiString; AList : TXMLElementList) : Boolean; overload;
       function FindDescendentElement(const AnElementName : AnsiString; var AnElement : TXMLElement) : Boolean;
       function FindAllDescendentElements : IXMLElementList; overload;
       function FindAllDescendentElements(var AnElementList : TBaseXMLElementList) : Integer; overload;
       function FindAllDescendentElements(var AnElementList : IXMLElementList) : Integer; overload;
       function FirstElement(AnElementClasses : TXMLElementClasses; var AnElement : TXMLElement) : Boolean; overload;
       function FirstElement(const AnElementName : string; var AnElement : TXMLElement) : Boolean; overload;
       function FirstElement(var AnElement : TXMLElement) : Boolean; overload;
       function NextElement(AnElementClasses : TXMLElementClasses; var AnElement : TXMLElement) : Boolean; overload;
       function NextElement(const AnElementName : string; var AnElement : TXMLElement) : Boolean; overload;
       function NextElement(var AnElement : TXMLElement) : Boolean; overload;
       function ElementByName(const AnElementName : AnsiString) : TXMLElement;
       property ElementClass : TXMLElementClass read FElementClass write SetElementClass;
       procedure RemoveElement(AnXMLElement : TXMLElement);
       procedure FreeChildElements;
       procedure AddElement(AnXMLElement : TXMLElement); overload;
       function AddElement(AnElementClass : TXMLElementClass) : TXMLElement; overload;
       function AddElement(AnElementName : AnsiString = EMPTY_STRING; AText : AnsiString = EMPTY_STRING) : TXMLElement; overload;
       function OpenElement(AnElementName : AnsiString; AText : AnsiString = EMPTY_STRING) : TXMLElement; overload;
       function AddElement(AnElementName : AnsiString; const AttributePairs : array of AnsiString) : TXMLElement; overload;
       function OpenElement(AnElementName : AnsiString; const AttributePairs : array of AnsiString) : TXMLElement; overload;
       function AddComment(AText : AnsiString) : TXMLElement;

       function AttributeCount : Integer;
       property Attributes[AIndex : Integer] : AnsiString read GetAttribute;
       property AttributeIndexValues[Index : Integer] : AnsiString read GetAttributeIndexValue;
       property AttributeNames[Index : Integer] : AnsiString read GetAttributeName;
       property AttributeValues[const AName : AnsiString] : AnsiString read GetAttributeValue write SetAttributeValue; default;
       function AttributeExists(const AName : AnsiString) : Boolean;
       function FindAttributeValue(const AName : AnsiString; var AValue : AnsiString) : Boolean;
       procedure AddDefaultAttributes;
       procedure AddAttributeString(AnAttributeString : AnsiString);
       function GetAttributeString(AnIndex : Integer) : AnsiString;
       procedure DeleteAttribute(AnIndex : Integer);
       procedure RemoveAttribute(const AnAttributeName : string);
       function Compose(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString; overload; override;
       procedure Compose(ResultStrings : TStrings; RecursionLevel : Integer = 0; StartingLineNumber : Integer = 0); reintroduce; overload;
       procedure Compose(ResultStream : TStream; RecursionLevel : Integer = 0; StartingLineNumber : Integer = 0); reintroduce; overload;
       procedure Compose(ResultObject : TObject; RecursionLevel : Integer = 0; StartingLineNumber : Integer = 0); reintroduce; overload;
       procedure Parse(AText : AnsiString); override;
       function XMLCollection : TXMLCollection;
       function IsEmpty : Boolean;
       function Clone : TXMLElement;
       property DTDElement : TDTDElement read GetDTDElement;
       function FindScopedNamespacePrefix(const ANamespacePrefix : string) : Integer; overload;
       function FindScopedNamespacePrefix(const ANamespacePrefix : string; APrefixID : Integer) : Boolean; overload;
       function FindScopedNamespace(const ANamespace : string) : string; overload;
       function FindScopedNamespace(const ANamespace : string; var ANamespacePrefix : string) : Boolean; overload;
       property Base : string read GetBase write FBase;

       function IsXLink : Boolean;
       property XLink : TXLink read GetXLink;
   published
       property PreserveWhitespace : Boolean read FPreserveWhitespace write FPreserveWhitespace default DEFAULT_PRESERVE_WHITESPACE;
       property OnChange : TNotifyEvent read FOnChange write FOnChange;
       property Tag : Integer read FTag write FTag;
   end;

   TByteOrder = (boUnknown, boUTF16UCS2, boUCS4, boUTF8, boEBCDIC);
   TXMLParseEvent = procedure(Sender : TObject; AnElement : TXMLElement) of object;

   TXMLDTDParseEvent = procedure(Sender : TObject; ADTD : TDocType) of object;
   TElementIteratorProc = procedure(Sender : TObject; AnElement : TXMLElement) of object;
   TAddingADecendentAxisElementEvent = procedure(Sender : TObject; const AnXPath : string; var AParentElement : TXMLElement) of object;

   TXMLCollection = class(TCraftingCollection)
   private
       FEncoding : AnsiString;
       FXMLVersion : AnsiString;
       FStandAlone : Boolean;
       FRequiredMarkupDeclaration : TRequiredMarkupDeclaration;
       FIncludeDTD : Boolean;
       FTabStops : AnsiString;
       FOnValidationError : TOnValidationError;
       FTabStopList : TList;
       FInternalReadStream : TStream;
       FReadBufferSize : Integer;
       FProcessMessagesDuringParse : Boolean;
       FCharCount : Integer;
       FOnElementParse : TXMLParseEvent;
       FByteOrder : TByteOrder;
       FRootElementList : TXMLElementList;
       FElementStack : TXMLElementList;                    //  must be persistent between calls during asynchronous parsing
       FOnAddElement : TXMLElementEvent;
       FDestroying : Boolean;
       FDocType : TDocType;
       FOnChange : TNotifyEvent;
       LockingFileStream : TFileStream;
       FFileName : string;
       FRootElement : TXMLElement;
       FCurrentNextIndex : Integer;
       FOnDeleteElement : TXMLElementEvent;
       FIDCrossIndex : TXMLElementList;
       FNamespaces : TCraftingStringList;
       FOnAddingADecendentAxisElement : TAddingADecendentAxisElementEvent;
       FValidating : Boolean;
       FElementLists : TList;
       FExternalEntityFileNames : TStringList;

       function GetDocType : TDocType;
       function GetElement(AIndex : Integer) : TXMLElement;
       procedure DoEndElement(AnElement : TXMLElement);    //  do not let descendents override this
       procedure SetTabStops(Value : AnsiString);
       function GetAsString : AnsiString;
       procedure SetAsString(const Value : AnsiString);
       procedure ReadXML(EndOfRead : Boolean; var Buffer : AnsiString; AnErrorReport : TStrings = nil);
       function GetNamespace(const ANamespacePrefix : string) : AnsiString;
       procedure SetNamespace(const ANamespacePrefix : string; AValue : AnsiString);
       function GetRootElement : TXMLElement;
       procedure SetRootElement(AnElement : TXMLElement);
       function AddNamespace(const ANamespacePrefix, AURI : string) : Integer;
       function GetNamespaceList : TStrings;
   protected
       procedure AssignTo(Target : TPersistent); override;
       procedure DoStartElement(AnElement : TXMLElement); virtual;
       procedure DoElement(AnElement : TXMLElement); virtual;
       procedure DoStartDTDParsing(ADocType : TDocType); virtual;
       procedure DoEndDTDParsing(ADocType : TDocType); virtual;
       procedure DoAddingADecendentAxisElement(const AnXPath : string; var AParentElement : TXMLElement); virtual;

       procedure DoValidationError(AnError : EXMLValidationError); virtual;

       property TabStopList : TList read FTabStopList;
       function DoInternalReadStream(var Buffer : AnsiString; AReadCount : Integer = 0) : Boolean; virtual;
       procedure InternalParse(AnErrorReport : TStrings = nil); virtual;
       property InternalReadStream : TStream read FInternalReadStream write FInternalReadStream;
       procedure ResetReadStream; virtual;
       function ElementStack : TXMLElementList;
       function CreateElement(AnElementName : AnsiString) : TXMLElement; overload;
       function CreateElement(AParentElement : TXMLElement; AnElementName : AnsiString) : TXMLElement; overload;
       procedure Change; virtual;
       procedure DoElementAdded(AnElement : TXMLElement); virtual;
       procedure DoElementDeleted(AnElement : TXMLElement); virtual;

       function GetElementListFromAxis(AContextElement : TXMLElement; AStep : string; AnAxis : TStepAxis) : IXMLElementList;
       procedure LoadElementListFromAxis(AContextElement : TXMLElement; AStep : string; AnAxis : TStepAxis; var AnElementList : TXMLElementList); overload;
       procedure LoadElementListFromAxis(AContextElement : TXMLElement;
           AStep : string; AnAxis : TStepAxis; var AnElementList : IXMLElementList); overload;
       function FindXStep(AnXPath : AnsiString;
           AContextElement : TXMLElement; AnElementList : TXMLElementList) : Boolean; overload;
       function FindXStep(AnXPath : AnsiString;
           AContextElement : TXMLElement; AnElementList : IXMLElementList) : Boolean; overload;

       function TestStep(AnElement : TXMLElement; AStep : string) : Boolean;
       function TestPredicate(AnElement : TXMLElement; const APredicate : string; AnAxis : TXMLElementList) : Boolean;
       property NamespaceList : TStrings read GetNamespaceList;

       procedure AddElementList(AnElementList : TBaseXMLElementList);
       procedure RemoveElementList(AnElementList : TBaseXMLElementList);

       function SortElementListByNestingReferences(AnElementList : TXMLElementList;
           ANesting : TNestedElementReferences; ListInsertionIndex : Integer = -1) : Integer;
   public
       constructor CreateFrom(XMLString : AnsiString);
       constructor Create(ItemClass : TCollectionItemClass); overload;
       constructor Create; overload;
       destructor Destroy; override;
       procedure Clear; override;
       procedure ClearData;
       procedure Assign(Source : TPersistent); override;
       procedure Default;
       function IsEmpty : Boolean;

       procedure SortElementsByDTD;

       function AddElement(AnElementClass : TXMLElementClass) : TXMLElement; overload;
       function AddElement(AnElementName : AnsiString = EMPTY_STRING; AText : AnsiString = EMPTY_STRING) : TXMLElement; overload;
       function OpenElement(AnElementName : AnsiString; AText : AnsiString = EMPTY_STRING) : TXMLElement; overload;
       function AddElement(AnElementName : AnsiString; const AttributePairs : array of AnsiString) : TXMLElement; overload;
       function OpenElement(AnElementName : AnsiString; const AttributePairs : array of AnsiString) : TXMLElement; overload;
       function NewComment(AText : AnsiString) : TXMLElement;
       function LoadFromFile(const AFileName : AnsiString; AnErrorReport : TStrings = nil; LeaveLocked : Boolean = False) : Boolean;
       function Parse(AStream : TStream; AnErrorReport : TStrings = nil) : Boolean; overload;
       function Parse(AString : AnsiString; AnErrorReport : TStrings = nil) : Boolean; overload;
       function Parse(AStrings : TStrings; AnErrorReport : TStrings = nil) : Boolean; overload;
       procedure ParseDTD(AString : AnsiString; EntityBase : string = ''; AnErrorReport : TStrings = nil); overload;
       procedure ParseDTD(AString : AnsiString; AnErrorReport : TStrings); overload;
       function ComposeHeader(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString;
       procedure Compose(ResultStream : TStream; StartingIndent : Integer = 0; StartingLineNumber : Integer = 0); overload;
       function Compose(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString; overload;
       procedure Compose(ResultStrings : TStrings; StartingIndent : Integer = 0; StartingLineNumber : Integer = 0); overload;
       procedure SaveToFile(const AFileName : AnsiString; LeaveLocked : Boolean = False); reintroduce; overload;
       function ComposeDTD : AnsiString;
       function FindElement(AnElementName : AnsiString) : TXMLElement; overload;
       function FindElement(AnElementName : AnsiString; var AnElement : TXMLElement) : Boolean; overload;
       function FindElementByAttribute(const NameValuePairs : array of string) : TXMLElement; overload;
       function FindElementByAttribute(const NameValuePairs : array of string; var AnElement : TXMLElement) : Boolean; overload;
       procedure AddElementID(AnElement : TXMLElement; const AnID : string);
       function FindElementByID(const AnID : string) : TXMLElement; overload;
       function FindElementByID(const AnID : string; var AnElement : TXMLElement) : Boolean; overload;
       function FindElementsByIDs(SomeIDs : string; var AnElementList : TXMLElementList) : Boolean;
       property RequiredMarkupDeclaration : TRequiredMarkupDeclaration read FRequiredMarkupDeclaration write FRequiredMarkupDeclaration default rmdAll;
       function Validate(AReport : TStrings = nil) : Boolean;
       procedure InsertTabSpaces(var AString : AnsiString; ATabIndex : Integer);
       function GetTabSpaces(ATabIndex : Integer) : AnsiString;
       property CharCount : Integer read FCharCount;
       property ByteOrder : TByteOrder read FByteOrder write FByteOrder;
       procedure DescribeControls(AControl : TControl; AnElement : TXMLElement = nil);
       function ElementCount : Integer;
       property Elements[Index : Integer] : TXMLElement read GetElement;
       function FirstElement(const AnElementName : string; var AnElement : TXMLElement) : Boolean; overload;
       function FirstElement(var AnElement : TXMLElement) : Boolean; overload;
       function FirstElement(AnElementClasses : TXMLElementClasses; var AnElement : TXMLElement) : Boolean; overload;
       function NextElement(const AnElementName : string; var AnElement : TXMLElement) : Boolean; overload;
       function NextElement(var AnElement : TXMLElement) : Boolean; overload;
       function NextElement(AnElementClasses : TXMLElementClasses; var AnElement : TXMLElement) : Boolean; overload;

       property RootElement : TXMLElement read GetRootElement write SetRootElement;
       property DocType : TDocType read GetDocType;

       property IsDestroying : Boolean read FDestroying;
       property AsString : AnsiString read GetAsString write SetAsString;
       function AsWordWrappedString(MaxLineLength : Integer) : AnsiString;

       property FileName : string read FFileName;
       function FindXPath(AnXPath : AnsiString) : IXMLElementList; overload;
       function FindXPath(AnXPath : AnsiString;
           AContextElement : TXMLElement; AnElementList : TBaseXMLElementList) : Boolean; overload;
       function FindXPath(AnXPath : AnsiString;
           AContextElement : TXMLElement; AnElementList : IXMLElementList) : Boolean; overload;
       function FindXPath(AnXPath : AnsiString;
           AContextElement : TXMLElement; var AnElement : TXMLElement) : Boolean; overload;
       function FindXPath(AnXPath : AnsiString; var AnElementList : TXMLElementList) : Boolean; overload;
       function FindXPath(AnXPath : AnsiString; var AnElementList : IXMLElementList) : Boolean; overload;
       function FindXPath(AnXPath : AnsiString; var AnElement : TXMLElement) : Boolean; overload;
       function FindXPath(AnXPath : AnsiString; var AString : string) : Boolean; overload;

       function XPathAttribute(AnXPath : AnsiString) : AnsiString;

       property Namespaces[const ANamespacePrefix : string] : string read GetNamespace write SetNamespace;
       function FindNamespacePrefix(const ANamespacePrefix : string) : Integer;
       function NamespaceByID(AnID : Integer) : string;
       function NamespacePrefixByID(AnID : Integer) : string;
       function FindNamespace(const ANamespaceURI : string) : string; overload;
       function FindNamespace(const ANamespaceURI : string; var AnID : Integer) : Boolean; overload;
       function FindNamespace(const ANamespaceURI : string; var ANamespacePrefix : string) : Boolean; overload;
       function OpenDefaultNamespaceID(const ANamespace : string) : Integer;

       class function FindByteOrder(FirstFourBytes : string) : TByteOrder;

       procedure AbortAfterRootElement(Sender : TObject; AnElement : TXMLElement); //  offered as a utility to users
       function ExternalEntityFileNames : TStrings;
   published
       property TabStops : AnsiString read FTabStops write SetTabStops;
       property IncludeDTD : Boolean read FIncludeDTD write FIncludeDTD default True;
       property AutoValidate : Boolean read FValidating write FValidating default True;
       property OnValidationError : TOnValidationError read FOnValidationError write FOnValidationError;
       property IsStandAlone : Boolean read FStandAlone write FStandAlone nodefault;
       property Encoding : AnsiString read FEncoding write FEncoding;
       property XMLVersion : AnsiString read FXMLVersion write FXMLVersion;
       property ReadBufferSize : Integer read FReadBufferSize write FReadBufferSize default DEFAULT_READ_BUFFER_SIZE;
       property ProcessMessagesDuringParse : Boolean read FProcessMessagesDuringParse write FProcessMessagesDuringParse;
       property OnElementParse : TXMLParseEvent read FOnElementParse write FOnElementParse;
       property OnAddElement : TXMLElementEvent read FOnAddElement write FOnAddElement;
       property OnDeleteElement : TXMLElementEvent read FOnDeleteElement write FOnDeleteElement;
       property OnChange : TNotifyEvent read FOnChange write FOnChange;
       property OnAddingADecendentAxisElement : TAddingADecendentAxisElementEvent
           read FOnAddingADecendentAxisElement write FOnAddingADecendentAxisElement;
   end;

   TXMLParser = class;
   TXMLParserCollection = class(TXMLCollection)
   private
       FParser : TXMLParser;
   protected
       procedure DoStartElement(AnElement : TXMLElement); override;
       procedure DoElement(AnElement : TXMLElement); override;
       procedure DoStartDTDParsing(ADocType : TDocType); override;
       procedure DoEndDTDParsing(ADocType : TDocType); override;

       function DoInternalReadStream(var Buffer : AnsiString; AReadCount : Integer = 0) : Boolean; override;
       procedure ResetReadStream; override;
   public
       constructor Create(AParser : TXMLParser);
       procedure Parse; overload;
   end;

   EXMLInternalError = class(EXMLError);
   TXMLErrorEvent = procedure(Sender : TObject; AnElement : TXMLElement; AnError : EXMLError) of object;
   TXMLParser = class(TComponent)
   private
       FXMLCollection : TXMLParserCollection;
       FOnStartElement : TXMLParseEvent;
       FOnElement : TXMLParseEvent;
       FOnStartReadXML : TNotifyEvent;
       FOnReadXML : TXMLReadEvent;
       FOnValidationError : TXMLErrorEvent;
       FOnEndDTDParsing : TXMLDTDParseEvent;
       FOnStartDTDParsing : TXMLDTDParseEvent;
       function GetProcessMessagesDuringParse : Boolean;
       procedure SetProcessMessagesDuringParse(AText : Boolean);
   protected
       procedure DoStartElement(AnElement : TXMLElement); virtual;
       procedure DoElement(AnElement : TXMLElement); virtual;
       procedure DoStartDTDParsing(ADocType : TDocType); virtual;
       procedure DoEndDTDParsing(ADocType : TDocType); virtual;
       procedure DoRead(var Buffer : AnsiString; var EndData : Boolean); virtual;
       procedure DoStartRead; virtual;
   public
       constructor Create(AOwner : TComponent); override;
       destructor Destroy; override;
       property XML : TXMLParserCollection read FXMLCollection write FXMLCollection;
       procedure LoadFromFile(const AFileName : string; AnErrorReport : TStrings = nil);
       procedure SaveToFile(const AFileName : string);
   published
       property OnStartElement : TXMLParseEvent read FOnStartElement write FOnStartElement;
       property OnElement : TXMLParseEvent read FOnElement write FOnElement;
       property OnStartReadXML : TNotifyEvent read FOnStartReadXML write FOnStartReadXML;
       property OnReadXML : TXMLReadEvent read FOnReadXML write FOnReadXML;
       property OnValidationError : TXMLErrorEvent read FOnValidationError write FOnValidationError;
       property ProcessMessagesDuringParse : Boolean read GetProcessMessagesDuringParse write SetProcessMessagesDuringParse;
       property OnStartDTDParsing : TXMLDTDParseEvent read FOnStartDTDParsing write FOnStartDTDParsing;
       property OnEndDTDParsing : TXMLDTDParseEvent read FOnEndDTDParsing write FOnEndDTDParsing;
   end;

function StripToDelimiter(var AString : AnsiString;
   const SomeDelimiters : array of string; var Stripped : AnsiString; IgnoreQuotedText : Boolean = True) : AnsiString; overload;
function StripToDelimiter(var AString : AnsiString; var Stripped : AnsiString; IgnoreQuotedText : Boolean = True) : AnsiString; overload;
function ArrayToString(AnArray : array of Byte) : AnsiString;
function IsXPath(const AString : string) : Boolean;
function StripNextStep(var AnXPath : string; AssumeStartAtRoot : Boolean = True) : string;
function ExtractNextStep(AnXPath : string; AssumeStartAtRoot : Boolean = True) : string;
function BreakApartXPath(AString : string; AList : TStrings) : Integer;
function ExtractLastPredicate(AnXPath : string) : string;
function ExtractLastAttribute(AnXPath : string) : string;
function StripStepPredicate(var AnXPath : string) : string;
function StripNextPredicate(var AnXPath : string) : string;
function StripLastAttribute(var AnXPath : string) : string;
function StripLastStep(var AString : string) : string;
function ExtractLastStep(AString : string) : string;
function AttributeTypeToString(AType : TAttributeType) : string;
function IsValidXMLName(const AName : string) : Boolean;
function IsValidNMToken(const AName : string) : Boolean;
function IsValidID(const AnID : string) : Boolean;
function StepAxisToStr(AnAxis : TStepAxis) : string;
function StrToStepAxis(const AString : string) : TStepAxis;

const
   DATE_FORMAT_RFC822 = 'd mmm yy hh:nn:ss';
   DATE_FORMAT_SOAP = 'yyyymmddThh:nn:ssZ';

   START_PROCESS_TOKEN = '<?';
   END_PROCESS_TOKEN = '?>';
   START_COMMENT_TOKEN = '<!--';
   END_COMMENT_TOKEN = '-->';
   START_TOKEN = '<';
   START_CLOSE_TOKEN = '</';
   END_TOKEN = '>';
   END_EMPTY_TOKEN = '/>';
   NAMESPACE_DEFINITION_ATTRIBUTE_NAME = 'xmlns';
   NAMESPACE_DEFINITION_PREFIX = NAMESPACE_DEFINITION_ATTRIBUTE_NAME + ':';
   NAMESPACE_XML_URI = 'http://www.w3.org/XML/1998/namespace';
   NAMESPACE_XMLNS_URI = 'http://www.w3.org/2000/xmlns/';
   BASE_DEFINITION_ATTRIBUTE_NAME = 'xml:base';
   BEGIN_SET = '(';
   END_SET = ')';

   START_MARKED_SECTION_TOKEN = '<![CDATA[';
   END_MARKED_SECTION_TOKEN = ']]>';
   START_XML_TOKEN = '<?xml ';                             //      while the specification allow uppercase, IE likes lower case
   START_ENTITY_TOKEN = '<!ENTITY ';
   START_DOCTYPE_TOKEN = '<!DOCTYPE ';
   START_DOCTYPE_DESCRIPTOR = '[';
   END_DOCTYPE_DESCRIPTOR = ']>';

   START_ELEMENT_TOKEN = '<!ELEMENT ';
   START_ATTLIST_TOKEN = '<!ATTLIST ';
   START_NOTATION_TOKEN = '<!NOTATION ';
   REQUIRED_DEFAULT_TOKEN = '#REQUIRED';
   IMPLIED_DEFAULT_TOKEN = '#IMPLIED';
   FIXED_DEFAULT_TOKEN = '#FIXED';
   ENTITY_TOKEN = '&';
   PARAMETER_ENTITY_TOKEN = '%';
   END_ENTITY_TOKEN = ';';
   OR_TOKEN = '|';
   AND_TOKEN = ',';
   WHITESPACE_CHARS = [' ', #9, #13, #10];
   PCDATA_TOKEN = '#PCDATA';
   EMPTY_TOKEN = 'EMPTY';
   ANY_TOKEN = 'ANY';
   STANDALONE_TOKEN = 'standalone';
   STANDALONE_YES = 'yes';
   STANDALONE_NO = 'no';
   ENCODING_TOKEN = 'encoding';
   REQUIRED_MARKUP_DECLARATION_TOKEN = 'RMD';
   REQUIRED_MARKUP_DECLARATION_NONE = 'NONE';
   REQUIRED_MARKUP_DECLARATION_INTERNAL = 'INTERNAL';
   REQUIRED_MARKUP_DECLARATION_ALL = 'ALL';
   VERSION_TOKEN = 'version';
   PRESERVE_WHITESPACE_ATTRIBUTE_NAME = 'xml:space';
   PRESERVE_WHITESPACE_PRESERVE_TOKEN = 'preserve';
   PRESERVE_WHITESPACE_DEFAULT_TOKEN = 'default';
   LANGUAGE_ATTRIBUTE_NAME = 'xml:lang';
   WINDOWS_END_LINE = #13#10;
   XML_END_LINE = #10;
   BYTE_ORDER_UTF16_LE : array[0..1] of Byte = ($FF, $FE);
   BYTE_ORDER_UTF16_BE : array[0..1] of Byte = ($FE, $FF);
   BYTE_ORDER_UCS4_LE : array[0..4] of Byte = ($3C, $00, $00, $00, $00);
   BYTE_ORDER_UCS4_BE : array[0..4] of Byte = ($00, $00, $00, $3C, $00);
   BYTE_ORDER_UTF8 : array[0..4] of Byte = ($3C, $3F, $78, $6D, $6C); //  <?xml
   BYTE_ORDER_EBCDIC : array[0..4] of Byte = ($4C, $6F, $A7, $94, $93);
   MIN_WORKING_BUFFER_LENGTH = 1000;                       //  the longest piece of content

   DEFAULT_HEADER = START_PROCESS_TOKEN + 'xml version="1.0" encoding="UTF-8"' + END_PROCESS_TOKEN;
   NO_ID = -1;

function StrToCodes(const AString : AnsiString) : AnsiString;
function CodesToStr(const AString : AnsiString) : AnsiString;
function ExtractSOAPElementText(AnElement : TXMLElement) : string;
function FindXPathAttributeEqualityValue(AnXPath, AnAttributeName : string) : string;
function ReplaceXPathAttributeEqualityValue(var AnXPath : string; AnAttributeName, ANewAttributeValue : string) : Boolean;
function DebugLog : TStrings;

implementation

uses
   Forms, TypInfo, ComCtrls, uInternetUtils, uWindowsInfo;

var
   FDebugLog : TStrings = nil;

function DebugLog : TStrings;
begin
   if FDebugLog = nil then
       FDebugLog := TStringList.Create;
   Result := FDebugLog;
end;

function LogDebug(const AMessage : string) : Boolean;
begin
   Result := True;                                         //  always return true for Assert(LogDebug('boo'));
   DebugLog.Add(DateTimeToStr(Now) + '- ' + AMessage);
end;

function StripToDelimiter(var AString : AnsiString;
   const SomeDelimiters : array of AnsiString; var Stripped : AnsiString;
   IgnoreQuotedText : Boolean = True) : AnsiString;
var
   Options : TStripOptions;
begin
   if IgnoreQuotedText then
       Options := [soIgnoreQuotedText]
   else
       Options := [];
   Stripped := uCraftClass.StripTo(AString, SomeDelimiters, Result, Options);
end;

function StripToDelimiter(var AString : AnsiString; var Stripped : AnsiString; IgnoreQuotedText : Boolean) : AnsiString;
var
   Options : TStripOptions;
begin
   Options := [soTrimExtraDelimiters];
   if IgnoreQuotedText then
       Include(Options, soIgnoreQuotedText);

   Include(Options, soTrimExtraDelimiters);
   Stripped := uCraftClass.StripTo(AString, [' ', #9, #13, #10], Result, Options); //  clear all the whitespace
end;

function StripDelimitingQuotes(const AString : AnsiString) : AnsiString;
const
   QUOTE_WIDE_CHARS = [Char('"'), Char('''')];
begin
   Result := Trim(AString);
   if Result <> EMPTY_STRING then
   begin
       if (Result[1] in QUOTE_WIDE_CHARS) and
           (Result[Length(Result)] in QUOTE_WIDE_CHARS) then
       begin
           Result := SubString(Result, 2, 1);
       end;
   end;
end;

function AddDelimitingQuotes(const AString : AnsiString) : AnsiString;
begin
   Result := Trim(AString);
   if AnsiPos('"', Result) = 0 then
       Result := '"' + Result + '"'
   else if AnsiPos('''', Result) = 0 then
       Result := '''' + Result + ''''
   else
       raise EXMLWellFormedError.Create('Cannot delimit string ' + AString + ' because it contains both styles of quote marks');
end;

function PosFrom(const SubString, AString : AnsiString; StartAt : Integer) : Integer;
var
   ThisPos : PAnsiChar;
begin
   ThisPos := AnsiStrPos(PAnsiChar(AString) + (StartAt - 1), PAnsiChar(SubString));
   if ThisPos = nil then
       Result := 0
   else
       Result := (ThisPos - PAnsiChar(AString)) + 1;
end;

function ArrayToString(AnArray : array of Byte) : AnsiString;
var
   Counter : Integer;
begin
   Result := EMPTY_STRING;
   for Counter := Low(AnArray) to High(AnArray) do
       Result := Result + AnsiChar(AnArray[Counter]);
end;

function IsXPath(const AString : string) : Boolean;
begin
   Result := (ExtractChar(AString) = '.') or (Pos('/', AString) > 0);
end;

function BreakApartXPath(AString : string; AList : TStrings) : Integer;
begin
   Result := 0;
   while AString <> EMPTY_STRING do
   begin
       AList.Add(StripNextStep(AString));
       Inc(Result);
   end;
end;

//         beware of steps inside predicates

function StripNextStep(var AnXPath : string; AssumeStartAtRoot : Boolean) : string;
var
   ThisDelimiter : string;
begin
   Result := StripTo(AnXPath, ['//', '/', '['], ThisDelimiter);

   if ThisDelimiter = '[' then
   begin
       Result := Result + ThisDelimiter + StripDelimitedText(AnXPath, '[', ']') + ']'; //  get the whole predicate even if it has generations in it (i.e. '/')
       Result := Result + StripNextStep(AnXPath, False);   //  get the rest of this generation (e.g. //W/X[1][@Y="Fred"])
   end
   else if AssumeStartAtRoot and (Result = EMPTY_STRING) then
   begin
       if ThisDelimiter = '//' then
           Result := ThisDelimiter
       else if AnXPath <> EMPTY_STRING then
           Result := StripNextStep(AnXPath);
   end
end;

function ExtractNextStep(AnXPath : string; AssumeStartAtRoot : Boolean) : string;
begin
   Result := StripNextStep(AnXPath, AssumeStartAtRoot);    //  private copy of AnXPath
end;

function StripLastAttribute(var AnXPath : string) : string;
begin
   Result := StripLastStep(AnXPath);
   if ExtractChar(Result) <> '@' then
   begin
       AnXPath := AnXPath + '/' + Result;                  //  put the last step back on
       Result := EMPTY_STRING                              //  the last step is not an attribute reference
   end
   else
       Delete(Result, 1, 1);
end;

function StripStepPredicate(var AnXPath : string) : string;
var
   ThisPredicate : string;
begin
   Result := EMPTY_STRING;

   repeat
       ThisPredicate := StripNextPredicate(AnXPath);
       if ThisPredicate <> EMPTY_STRING then
           Result := Result + '[' + ThisPredicate + ']';
   until ThisPredicate = EMPTY_STRING;
end;

function StripNextPredicate(var AnXPath : string) : string;
var
   ThisDelimiter, ThisText, ThisLeader : string;
begin
   Result := '';

   ThisText := AnXPath;                                    //  local copy

   ThisLeader := StripIf(ThisText, ['[', '/'], ThisDelimiter, []);

   if ThisDelimiter = '[' then                             //      did we find an open brace before we found a step
   begin
       Result := StripDelimitedText(ThisText, '[', ']', []); //        strips to the closing "]"
       AnXPath := ThisLeader + ThisText;
   end;
end;

function ExtractLastPredicate(AnXPath : string) : string;
begin
   Result := StripLastStep(AnXPath);                       //  this is a local copy of AnXPath
   Result := StripStepPredicate(Result);
end;

function ExtractLastStep(AString : string) : string;
begin
   Result := StripLastStep(AString);                       //  AString is a local copy
end;

function StripLastStep(var AString : string) : string;
var
   Counter, LastStepStartIndex, DepthCounter : Integer;
begin
   LastStepStartIndex := MaxInt;
   DepthCounter := 0;
   for Counter := Length(AString) downto 1 do
   begin
       case ExtractChar(AString, Counter) of
           '[' : Inc(DepthCounter);
           ']' : Dec(DepthCounter);
       end;
       if (DepthCounter = 0) and (ExtractChar(AString, Counter) = '/') then
       begin
           LastStepStartIndex := Counter + 1;
           Break;
       end;
   end;

   Result := Copy(AString, LastStepStartIndex, MaxInt);
   if (LastStepStartIndex <> 3) or (Copy(AString, 1, 2) <> '//') then
       Dec(LastStepStartIndex);                            //  remove the separator '/'
   Delete(AString, LastStepStartIndex, MaxInt);
end;

function ExtractLastAttribute(AnXPath : string) : string;
begin
   Result := StripLastAttribute(AnXPath);                  //  local copy of the string
end;

function FindXPathAttributeEqualityValue(AnXPath, AnAttributeName : string) : string;
begin
   Result := '';

   if Copy(AnAttributeName, 1, 1) <> '@' then
       AnAttributeName := '@' + AnAttributeName;

   if StripIf(AnXPath, AnAttributeName + '="', [soIgnoreQuotedText]) <> '' then
       Result := StripTo(AnXPath, '"', []);
end;

function ReplaceXPathAttributeEqualityValue(var AnXPath : string; AnAttributeName, ANewAttributeValue : string) : Boolean;
var
   Prefix, ThisXPath : string;
begin
   Result := False;
   ThisXPath := AnXPath;

   if ExtractChar(AnAttributeName) <> '@' then
       AnAttributeName := '@' + AnAttributeName;

   Prefix := StripIf(ThisXPath, AnAttributeName + '="', [soIgnoreQuotedText]);
   if Prefix <> '' then
   begin
       StripTo(ThisXPath, '"', []);   //  strip the rest of the quoted text (the attribute value)
       AnXPath := Prefix + AnAttributeName + '="' + ANewAttributeValue + '"' + ThisXPath;

       Result := True;
   end;
end;

function StrToCodes(const AString : AnsiString) : AnsiString;
var
   Pointer, OrdNum : Integer;
   ThisCode : AnsiString;
begin
   Result := AString;
   Pointer := 1;
   while Pointer <= Length(Result) do
   begin
     // get the character's ordinal number
     OrdNum := Ord(Result[Pointer]);

     // check for ISO8859-1 symbols and characters
     if (OrdNum = 9) then
       ThisCode := '&#x9;'
     else if (OrdNum = 10) then
       ThisCode := '&#xA;'
     else if (OrdNum = 13) then
       ThisCode := '&#xD;'
     else if (OrdNum < 32) then
       ThisCode := ' '
    // else if ((OrdNum > 159) and (OrdNum < 256)) then    //UTF8 does not allow any extended characters OrdNum > 127   YF
     //  ThisCode := '&#' + IntToStr(OrdNum) + ';'
     else // not a ISO8859-1 symbol or character so check for special characters
       case Result[Pointer] of
         '"' : ThisCode := '&quot;';
         '''' : ThisCode := '&apos;';
         '&' : ThisCode := '&amp;';
         '<' : ThisCode := '&lt;';
         '>' : ThisCode := '&gt;';
        { '‘' : ThisCode := '&#8216;';  // this is the equivalent for a curly single open quote (Alt+0145)     //UTF8 does not allow any extended characters OrdNum > 127   YF
         '’' : ThisCode := '&#8217;';  // this is the equivalent for a curly single close quote (Alt+0146)
         '“' : ThisCode := '&#8220;';  // this is the equivalent for a curly double open quote (Alt+0147)
         '”' : ThisCode := '&#8221;';  // this is the equivalent for a curly double close quote (Alt+0148) }
       else // not a ISO8859-1 symbol or character or a special character so assume an OK character
         ThisCode := EMPTY_STRING;
       end;

     // make a final check of an assumed OK character and, if it's not ASCII, change to blank
     //  a blank is required so that the following code replaces the unknown character
     if (ThisCode = EMPTY_STRING) and ((OrdNum > 127) {and (OrdNum < 160)}) then     //UTF8 does not allow any extended characters OrdNum > 127   YF
       ThisCode := ' ';

     if ThisCode <> EMPTY_STRING then
     begin
         Result := Copy(Result, 1, Pointer - 1) + ThisCode + Copy(Result, Pointer + 1, MaxInt);
         Inc(Pointer, Length(ThisCode));
     end
     else
         Inc(Pointer);
   end;
end;

function CodesToStr(const AString : AnsiString) : AnsiString;
var
   StartPointer, CurrentPointer, Counter : Integer;
   ThisCode : AnsiString;
begin
   Result := '';

   StartPointer := 1;
   CurrentPointer := 1;
   while CurrentPointer < Length(AString) do
   begin
       if ExtractChar(AString, CurrentPointer) = AnsiChar(ENTITY_TOKEN) then
       begin
           Result := Result + Copy(AString, StartPointer, CurrentPointer - StartPointer); //  copy up to this point

           Inc(CurrentPointer);
           ThisCode := EMPTY_STRING;
           Counter := 1;
           while ((CurrentPointer + Counter) <= Length(Result)) and
               (ExtractChar(AString, CurrentPointer + Counter) <> AnsiChar(ENTITY_TOKEN)) do
           begin
               Inc(Counter);                               //  we could copy each character, but copying once is a little more efficient
           end;
           ThisCode := Copy(Result, CurrentPointer, Counter);

           Inc(CurrentPointer, Counter - 1);
           StartPointer := CurrentPointer + 1;             //  set for next time

           if ThisCode = 'quot' then
               Result := Result + '"'
           else if (ThisCode = 'sq') or (ThisCode = 'apos') then
               Result := Result + ''''
           else if ThisCode = 'amp' then
               Result := Result + '&'
           else if ThisCode = 'lt' then
               Result := Result + '<'
           else if ThisCode = 'gt' then
               Result := Result + '>'
           else if Copy(ThisCode, 1, 1) = '#' then
               Result := Result + Chr(HexToInt(ThisCode));

           //             else it is not a code we recognize: ignore it

       end;
       Inc(CurrentPointer);
   end;
   Result := Result + Copy(AString, StartPointer, MaxInt); //  copy the rest of the original
end;

function StrToXLinkType(const AString : string) : TXLinkType;
begin
   Result := High(TXLinkType);
   while Result > Low(TXLinkType) do                       //  ltUnknown
   begin
       if XLINK_TYPE_NAMES[Result] = AString then
           Break;
   end;
end;

function StrToXLinkShow(const AString : string) : TXLinkShow;
begin
   Result := High(TXLinkShow);
   while Result > Low(TXLinkShow) do                       //  ltUnknown
   begin
       if XLINK_SHOW_NAMES[Result] = AString then
           Break;
   end;
end;

function StrToXLinkActuate(const AString : string) : TXLinkActuate;
begin
   Result := High(TXLinkActuate);
   while Result > Low(TXLinkActuate) do                    //  ltUnknown
   begin
       if XLINK_ACTUATE_NAMES[Result] = AString then
           Break;
   end;
end;

function ExtractSOAPElementText(AnElement : TXMLElement) : string;

   function GetArguments(AnOtherElement : TXMLElement) : string;
   var
       Counter : Integer;
   begin
       if AnOtherElement.ElementCount = 0 then
           Result := AnOtherElement.ElementName + '=' + AnOtherElement.Text
       else
       begin
           for Counter := 0 to AnOtherElement.ElementCount - 1 do
               Result := Result + '; ' + GetArguments(AnOtherElement.Elements[Counter]);
           Delete(Result, 1, 2);
       end;
   end;

begin
   Assert(AnElement.ElementName = 'SOAP-ENV:Body');
   Assert(AnElement.ElementCount > 0);
   Result := GetArguments(AnElement.Elements[0]);
end;

{
Name start characters must have one of the categories Ll, Lu, Lo, Lt, Nl.
Name characters other than Name-start characters must have one of the categories Mc, Me, Mn, Lm, or Nd.
Characters in the compatibility area (i.e. with character code greater than #xF900 and less than #xFFFE) are not allowed in XML names.
Characters which have a font or compatibility decomposition (i.e. those with a "compatibility formatting tag" in field 5 of the database -- marked by field 5 beginning with a "<") are not allowed.
The following characters are treated as name-start characters rather than name characters, because the property file classifies them as Alphabetic: [#x02BB-#x02C1], #x0559, #x06E5, #x06E6.
Characters #x20DD-#x20E0 are excluded (in accordance with Unicode 2.0, section 5.14).
Character #x00B7 is classified as an extender, because the property list so identifies it.
Character #x0387 is added as a name character, because #x00B7 is its canonical equivalent.
Characters ':' and '_' are allowed as name-start characters.
Characters '-' and '.' are allowed as name characters.
}

const
   XML_NAME_FIRST_VALID_LETTER = ALPHA_CHARS + ['_', ':'];
   XML_NTOKEN_VALID_LETTER = XML_NAME_FIRST_VALID_LETTER + NUMERIC_CHARS + ['-', '.', '!'];

function IsValidXMLName(const AName : string) : Boolean;
begin
   Result := IsValidNMToken(AName);
   if Result then
       Result := ExtractChar(AName) in XML_NAME_FIRST_VALID_LETTER;
end;

function IsValidNMToken(const AName : string) : Boolean;
var
   Counter : Integer;
begin
   Result := False;
   for Counter := 1 to Length(AName) do
   begin
       if AName[Counter] in XML_NTOKEN_VALID_LETTER then
           Result := True
       else
           Break;
   end;
end;

function IsValidID(const AnID : string) : Boolean;
begin
   Result := IsValidXMLName(AnID);                         //  e.g. it cannot be all numbers
end;

{  TBaseXMLCollectionItem  }

function TBaseXMLCollectionItem.GetAsString : AnsiString;
begin
   Result := Compose;
end;

procedure TBaseXMLCollectionItem.Parse(AText : AnsiString);
begin
   raise EXMLInternalError.Create('No ancestor implementation for TBaseXMLCollectionItem.Parse');
end;

function TBaseXMLCollectionItem.Compose(StartingIndent : Integer = 0; StartingLineNumber : Integer = 0) : AnsiString;
begin
   raise EXMLInternalError.Create('No ancestor implementation for TBaseXMLCollectionItem.Compose');
end;

procedure TBaseXMLCollectionItem.Clear;
begin
   inherited;
   FLineNumber := 0;
   FRawText := '';
end;

{  TDTDNotations   }

constructor TDTDNotations.Create;
begin
   Create(TDTDNotation);
end;

function TDTDNotations.Add : TDTDNotation;
begin
   Result := inherited Add as TDTDNotation;
end;

function TDTDNotations.GetNotation(Index : Integer) : TDTDNotation;
begin
   Result := TDTDNotation(Items[Index]);
end;

function TDTDNotations.XMLCollection : TXMLCollection;
begin
   Result := DocType.XMLCollection;
end;

{  TDTDNotation    }

function TDTDNotation.GetIndexName : string;
begin
   Result := Self.Name;
end;

procedure TDTDNotation.Parse(AText : AnsiString);
var
   ThisTag, ThisDelim : AnsiString;
begin
   ThisDelim := StripToDelimiter(AText, ['SYSTEM', 'PUBLIC'], ThisTag);
   Self.Name := Trim(ThisTag);
   if ThisDelim = 'PUBLIC' then
   begin
       ReferenceType := rtPublic;
       StripToDelimiter(AText, ThisTag);
       ExternalOwner := StripDelimitingQuotes(ThisTag);
       ExternalReference := StripDelimitingQuotes(AText);  //  URL
   end
   else
   begin
       if ThisDelim = 'SYSTEM' then
       begin
           ReferenceType := rtSystem;
           ExternalReference := StripDelimitingQuotes(AText); //  File
       end
       else
           ReferenceType := rtInternal;
   end;
end;

function TDTDNotation.Compose(StartingIndent : Integer; StartingLineNumber : Integer) : AnsiString;
begin
   Self.LineNumber := StartingLineNumber;

   Result := Trim(START_NOTATION_TOKEN) + ' ' + Name;
   case ReferenceType of
       rtPublic :
           begin
               Result := Result + ' PUBLIC ' +
                   AddDelimitingQuotes(ExternalOwner) + ' ' + AddDelimitingQuotes(ExternalReference);
               Self.LineNumber := StartingLineNumber;
           end;

       rtSystem :
           begin
               Result := Result + ' SYSTEM ' + AddDelimitingQuotes(ExternalReference);
               Self.LineNumber := StartingLineNumber;
           end;
   end;
end;

{  TDTDEntity  }

constructor TDTDEntity.Create(ACollection : TCollection);
begin
   inherited;
   FReferenceType := rtInternal;
end;

function TDTDEntity.GetIndexName : string;
begin
   Result := Self.Name;
end;

procedure TDTDEntity.Parse(AText : AnsiString);
var
   ThisTag, ThisDelim : AnsiString;
begin
   StripToDelimiter(AText, ThisTag);
   if ThisTag = PARAMETER_ENTITY_TOKEN then
   begin
       IsParameterEntity := True;
       StripToDelimiter(AText, ThisTag);
   end
   else
       IsParameterEntity := False;

   Self.Name := ThisTag;

   ThisTag := StripIf(AText, 'NDATA');
   if ThisTag <> '' then
   begin
       if IsParameterEntity then
       begin
           raise EXMLNotationDisallowedForParameterEntityReferenceError.Create(Self.Name +
               ' is a parameter entity and cannot have a notation as well');
       end;

       Notation := Trim(AText);                            //  the word following NDATA
       AText := ThisTag;                                   //  restore the words preceding NDATA
   end;

   ThisDelim := StripToDelimiter(AText, ['SYSTEM', 'PUBLIC'], ThisTag);
   if ThisDelim = 'PUBLIC' then
   begin
       ReferenceType := rtPublic;
       StripToDelimiter(AText, ThisTag);
       ExternalOwner := StripDelimitingQuotes(ThisTag);
       Literal := StripDelimitingQuotes(AText);            //  URL
   end
   else if ThisDelim = 'SYSTEM' then
   begin
       ReferenceType := rtSystem;
       Literal := StripDelimitingQuotes(AText);            //  file name
   end
   else
   begin
       ReferenceType := rtInternal;
       Literal := StripDelimitingQuotes(ThisTag);          //  if no delimiters, Values --> ThisTag
   end;
end;

function TDTDEntity.Compose(StartingIndent : Integer; StartingLineNumber : Integer) : AnsiString;
begin
   if Self.ReferenceType = rtDefault then
       Result := ''
   else
   begin
       Self.LineNumber := StartingLineNumber;

       if IsParameterEntity then
       begin
           Result := XMLCollection.GetTabSpaces(StartingIndent) +
               Trim(START_ENTITY_TOKEN) + ' ' + PARAMETER_ENTITY_TOKEN + ' ' + Name;
       end
       else
           Result := XMLCollection.GetTabSpaces(StartingIndent) + Trim(START_ENTITY_TOKEN) + ' ' + Name;

       case ReferenceType of
           rtPublic : Result := Result + ' PUBLIC ' + AddDelimitingQuotes(ExternalOwner) + ' ' + AddDelimitingQuotes(Literal) + END_TOKEN;
           rtSystem : Result := Result + ' SYSTEM ' + AddDelimitingQuotes(Literal) + END_TOKEN;
           rtInternal : Result := Result + ' ' + AddDelimitingQuotes(Literal) + END_TOKEN;
       end;
   end;
end;

function TDTDEntity.GetReplacementText : AnsiString;
begin
   if FReplacementText = '' then
   begin
       case ReferenceType of
           rtInternal, rtDefault : FReplacementText := Literal;
           rtSystem : FReplacementText := GetSystemEntity;
           rtPublic : FReplacementText := GetPublicEntity;
       end;
   end;
   Result := FReplacementText;
end;

function TDTDEntity.GetExternalReference : AnsiString;
begin
   case ReferenceType of
       rtInternal : Result := '';
       rtSystem :
           begin
               Result := Self.Literal;
               if DocType.EntityBase <> '' then
                   Result := ExpandFileName(IncludeTrailingPathDelimiter(DocType.EntityBase) + Result);
           end;
       rtPublic : Result := Self.Literal;
   end;
end;

function TDTDEntity.GetSystemEntity : AnsiString;           //  .Literal is the reference to an external file
var
   ThisFileName : string;
begin
   ThisFileName := Self.ExternalReference;

   if (ExtractFilePath(ThisFileName) = '') and (ExtractFilePath(Self.XMLCollection.FileName) <> '') then
       ThisFileName := ExtractFilePath(Self.XMLCollection.FileName) + ThisFileName;

   if (ExtractFilePath(ThisFileName) = '') and (ExtractFilePath(Self.DocType.FileName) <> '') then
       ThisFileName := ExtractFilePath(Self.DocType.FileName) + ThisFileName;

   if not FileExists(ThisFileName) then
   begin
       raise EXMLExternalEntityReferenceMissingError.Create('Cannot open entity "' +
           Self.Name + '" SYSTEM file ' + ThisFileName);
   end;

   XMLCollection.ExternalEntityFileNames.Add(ThisFileName);

   Result := uWindowsInfo.FileText(ThisFileName);
end;

function TDTDEntity.GetPublicEntity : AnsiString;
begin
   Result := uInternetUtils.GetURL(ExternalReference);
end;

function TDTDEntity.DocType : TDocType;
begin
   Result := TDTDEntities(Collection).DocType;
end;

function TDTDEntity.XMLCollection : TXMLCollection;
begin
   Result := Self.DocType.XMLCollection;
end;

{  TDTDEntities    }

constructor TDTDEntities.Create;
begin
   Create(TDTDEntity);

   Add('apos', '''');
   Add('amp', '&');
   Add('lt', '<');
   Add('gt', '>');
   Add('quot', '"');
end;

function TDTDEntities.Add : TDTDEntity;
begin
   Result := inherited Add as TDTDEntity;
end;

function TDTDEntities.Add(const AName, AReplacementText : string; AType : TReferenceType) : TDTDEntity;
begin
   Result := Add;
   Result.ReferenceType := AType;
   Result.Name := AName;
   Result.Literal := AReplacementText;
end;

function TDTDEntities.GetEntity(Index : Integer) : TDTDEntity;
begin
   Result := Items[Index] as TDTDEntity;
end;

function TDTDEntities.LookupName(AName : AnsiString; var AValue : AnsiString; ParameterEntitiesOnly : Boolean) : Boolean;
var
   ThisEntity : TDTDEntity;
begin
   ThisEntity := Find(AName, ParameterEntitiesOnly);
   if ThisEntity = nil then
   begin
       AValue := EMPTY_STRING;
       Result := False;
   end
   else
   begin
       AValue := ThisEntity.ReplacementText;
       Result := True;
   end;
end;

function TDTDEntities.Find(AName : AnsiString; ParameterEntitiesOnly : Boolean) : TDTDEntity;
begin
   if not Find(AName, Result, ParameterEntitiesOnly) then
       Result := nil;
end;

function TDTDEntities.Find(AName : AnsiString; var AnEntity : TDTDEntity; ParameterEntitiesOnly : Boolean) : Boolean;
var
   Counter : Integer;
begin
   Result := False;
   if (ParameterEntitiesOnly and (Copy(AName, 1, 1) = ENTITY_TOKEN)) or
       ((not ParameterEntitiesOnly) and (Copy(AName, 1, 1) = PARAMETER_ENTITY_TOKEN)) then
   begin
       System.Delete(AName, 1, 1);
   end;

   if Copy(AName, Length(AName), 1) = ENTITY_TOKEN then
       System.Delete(AName, Length(AName), 1);

   for Counter := 0 to Count - 1 do
   begin
       if (Entities[Counter].Name = AName) and (Entities[Counter].IsParameterEntity = ParameterEntitiesOnly) then
       begin
           AnEntity := Entities[Counter];
           Result := True;
           Break;
       end;
   end;
end;

function TDTDEntities.LookupValue(AValue : AnsiString; AnEntity : TDTDEntity; ParameterEntitiesOnly : Boolean) : Boolean;
var
   Counter : Integer;
begin
   Result := False;
   for Counter := 0 to Count - 1 do
   begin
       AnEntity := Entities[Counter];
       if AnEntity.ReplacementText = AValue then
       begin
           Result := True;
           Break;
       end;
   end;
end;

function TDTDEntities.LookupValue(AValue : AnsiString; var AName : AnsiString; ParameterEntitiesOnly : Boolean) : Boolean;
var
   ThisEntity : TDTDEntity;
begin
   ThisEntity := nil;
   Result := LookupValue(AValue, ThisEntity);
   if Result then
       AName := ThisEntity.Name;
end;

function TDTDEntities.XMLCollection : TXMLCollection;
begin
   Result := DocType.XMLCollection;
end;

{  TDTDAttribute   }

constructor TDTDAttribute.Create(ACollection : TCollection);
begin
   inherited;
   FDefaultType := dtImplied;
   FIsNotation := False;
end;

destructor TDTDAttribute.Destroy;
begin
   FAttributeEnums.Free;
   FAttributeEnums := nil;
   inherited;
end;

function TDTDAttribute.Element : TDTDElement;
begin
   Result := TDTDAttributes(Collection).Element;
end;

function TDTDAttribute.GetIndexName : string;
begin
   Result := Self.Name;
end;

function TDTDAttribute.GetAttributeEnum(Index : Integer) : AnsiString;
begin
   Result := FAttributeEnums.Strings[Index];
end;

function TDTDAttribute.AttributeEnumCount : Integer;
begin
   if FAttributeEnums = nil then
       Result := 0
   else
       Result := FAttributeEnums.Count;
end;

function TDTDAttribute.FindAttributeEnum(const AValue : string) : Boolean;
begin
   Result := False;
   if FAttributeEnums <> nil then
       Result := (FAttributeEnums.IndexOf(AValue) <> -1);
end;

function TDTDAttribute.AttributeEnumText : string;
begin
   Result := EMPTY_STRING;
   if (FAttributeEnums <> nil) then
       Result := FAttributeEnums.SeparatedText[', '];
end;

function TDTDAttributes.Add : TDTDAttribute;
begin
   Result := (inherited Add) as TDTDAttribute;
end;

function AttributeTypeToString(AType : TAttributeType) : string;
begin
   case AType of
       atCData : Result := 'CDATA';
       atID : Result := 'ID';
       atIDREF : Result := 'IDREF';
       atIDREFS : Result := 'IDREFS';
       atENTITY : Result := 'ENTITY';
       atENTITIES : Result := 'ENTITIES';
       atNMTOKEN : Result := 'NMTOKEN';
       atNMTOKENS : Result := 'NMTOKENS';
   else
       raise EXMLWellFormedError.Create('Unknown attribute type');
   end;
end;

function StringToAttributeType(AType : string) : TAttributeType;
begin
   if AType = 'CDATA' then
       Result := atCData
   else if AType = 'ID' then
       Result := atID
   else if AType = 'IDREF' then
       Result := atIDREF
   else if AType = 'IDREFS' then
       Result := atIDREFS
   else if AType = 'ENTITY' then
       Result := atENTITY
   else if AType = 'ENTITIES' then
       Result := atENTITIES
   else if AType = 'NMTOKEN' then
       Result := atNMTOKEN
   else if AType = 'NMTOKENS' then
       Result := atNMTOKENS
   else
       raise EXMLWellFormedError.Create('Unknown attribute type ' + AType);
end;

function TDTDAttribute.GetAttributeEnums : TStrings;
begin
   if FAttributeEnums = nil then
   begin
       FAttributeEnums := TCraftingStringList.Create;
       FAttributeEnums.CaseSensitive := True;
   end;
   Result := FAttributeEnums;
end;

procedure TDTDAttribute.SetType(AType : string);
begin
   FAttributeEnums.Free;
   FAttributeEnums := nil;

   IsNotation := StripNextWord(AType, 'NOTATION') <> EMPTY_STRING;

   if (Copy(AType, 1, 1) = BEGIN_SET) then
   begin
       AType := SubString(AType, 2, -1);
       while AType <> EMPTY_STRING do
           AttributeEnums.Add(Trim(StripTo(AType, OR_TOKEN)));

       AttributeType := atEnumeration;
   end
   else
   try
       AttributeType := StringToAttributeType(AType);
   except
       on E : EXMLWellFormedError do
       begin
           E.ElementName := Element.Name;
           raise;
       end;
   end;
end;

procedure TDTDAttribute.SetDefault(ADefault : string);
var
   ThisPiece : string;
begin
   FDefaultValue := EMPTY_STRING;
   ThisPiece := StripTo(ADefault);

   if ThisPiece = REQUIRED_DEFAULT_TOKEN then
       DefaultType := dtRequired
   else if ThisPiece = IMPLIED_DEFAULT_TOKEN then
       DefaultType := dtImplied
   else if ThisPiece = EMPTY_STRING then
       DefaultType := dtNone
   else if ThisPiece = FIXED_DEFAULT_TOKEN then
   begin
       DefaultType := dtFixed;
       FDefaultValue := StripDelimitingQuotes(ADefault);
   end
   else
   begin
       DefaultType := dtLiteral;
       FDefaultValue := StripDelimitingQuotes(ThisPiece);
   end;
end;

function TDTDAttribute.Compose(StartingIndent : Integer; StartingLineNumber : Integer) : AnsiString; //  StartingIndent ignored: Emerson
var
   Counter : Integer;
begin
   Self.LineNumber := StartingLineNumber;

   Result := TDTDElements(TDTDAttributes(Collection).Element.Collection).DocType.XMLCollection.GetTabSpaces(StartingIndent) + Self.Name;

   if IsNotation then
       Result := Result + ' NOTATION';

   case AttributeType of
       atCData : Result := Result + ' CDATA';
       atID : Result := Result + ' ID';
       atIDREF : Result := Result + ' IDREF';
       atIDREFS : Result := Result + ' IDREFS';
       atENTITY : Result := Result + ' ENTITY';
       atENTITIES : Result := Result + ' ENTITIES';
       atNMTOKEN : Result := Result + ' NMTOKEN';
       atNMTOKENS : Result := Result + ' NMTOKENS';
       atEnumeration :
           //  note that (AttributeEnumCount > 0) and #FIXED should cause a warning
           begin
               Result := Result + ' ' + BEGIN_SET + AttributeEnum[0];
               for Counter := 1 to AttributeEnumCount - 1 do
                   Result := Result + ' | ' + AttributeEnum[Counter];
               Result := Result + END_SET;
           end;
   end;

   case DefaultType of
       dtRequired : Result := Result + ' #REQUIRED';
       dtImplied : Result := Result + ' #IMPLIED';
       dtFixed : Result := Result + ' #FIXED ' + AddDelimitingQuotes(DefaultValue);
       dtLiteral : Result := Result + ' ' + AddDelimitingQuotes(DefaultValue);
   end;
end;

///////////////////////////////////////////////////////////////////////

function TDTDAttributes.GetAttribute(Index : Integer) : TDTDAttribute;
begin
   Result := TDTDAttribute(inherited Items[Index]);
end;

function TDTDAttributes.Find(AName : AnsiString) : TDTDAttribute;
begin
   if not Find(AName, Result) then
       Result := nil;
end;

function TDTDAttributes.Find(AName : AnsiString; var AnAttribute : TDTDAttribute) : Boolean;
var
   Counter : Integer;
begin
   Result := False;
   for Counter := 0 to Self.Count - 1 do
   begin
       if Attributes[Counter].Name = AName then
       begin
           AnAttribute := TDTDAttribute(Items[Counter]);
           Result := True;
           Break;
       end;
   end;
end;

function TDTDAttributes.Find(AType : TAttributeType; var AnAttribute : TDTDAttribute) : Boolean;
var
   Counter : Integer;
begin
   Result := False;
   for Counter := 0 to Self.Count - 1 do
   begin
       if Attributes[Counter].AttributeType = AType then
       begin
           AnAttribute := TDTDAttribute(Items[Counter]);
           Result := True;
           Break;
       end;
   end;
end;

function TDTDAttributes.GetDefaultAttributeValue(const AnAttributeName : string) : string;
var
   ThisAttribute : TDTDAttribute;
begin
   if Find(AnAttributeName, ThisAttribute) then
       Result := ThisAttribute.DefaultValue
   else
       Result := EMPTY_STRING;
end;

function TDTDAttributes.First(var AnAttribute : TDTDAttribute) : Boolean;
begin
   Result := First(TCollectionItem(AnAttribute));
end;

function TDTDAttributes.Next(var AnAttribute : TDTDAttribute) : Boolean;
begin
   Result := Next(TCollectionItem(AnAttribute));
end;

procedure TDTDAttributes.Parse(AText : AnsiString);         //  never listed as DocType.Items because their DTDElement will pull them out
var
   ThisString, ThisAttributeName, ThisDefault, ThisDelim, ThisType : AnsiString;
begin

   {
           Value is a block of attribute definitions. We have to separate each "line"
           While I dislike pushing text back onto the Value "stack", these will be very small Strings
           Do not clear Items because the DTD can have several ATTLISTs for the same element
   Trust that the DocType.Parse will clear all DTDElements and, implicitly, all DTDAttributes
   Format may be: Name Type "Default"
   Name Type #IMPLIED
   Name (Enum) #FIXED "Default"
   }
   while AText <> EMPTY_STRING do
   begin
       StripToDelimiter(AText, ThisAttributeName);

       //             an enumerated list might have embedded spaces, so we have to list all the possible values
       ThisType :=
           StripToDelimiter(AText, ['CDATA', BEGIN_SET, END_SET,
           'ID', 'IDREF', 'IDREFS', 'ENTITY', 'ENTITIES', 'NMTOKEN', 'NMTOKENS'], ThisString);

       if ThisType = BEGIN_SET then
       begin
           if StripToDelimiter(AText, [END_SET], ThisType) = END_SET then //  strip out the enumeration
               ThisType := BEGIN_SET + ThisType + END_SET
           else
           begin
               raise EXMLWellFormedError.Create('Attribute ' + ThisAttributeName + ' of element ' + Self.Element.Name +
                   ' has the start of an enumeration, but not the end');
           end;
       end;

       AText := TrimLeft(AText);
       //             determine if the next word is part of this attribute (i.e. the default)
       StripToDelimiter(AText, ThisDefault);
       if ThisDefault = FIXED_DEFAULT_TOKEN then
       begin
           ThisDelim := StripToDelimiter(AText, ['"', ''''], ThisString, False); //  opening quote
           StripToDelimiter(AText, ThisDelim, ThisString, False); //  closing quote
           ThisDefault := FIXED_DEFAULT_TOKEN + ' ' + ThisDelim + ThisString + ThisDelim;
           StripIf(AText);                                 //  skip over any whitespace between the closing quote and the next attribute
       end;

       with TDTDAttribute(Add) do
       begin
           Name := ThisAttributeName;
           SetType(ThisType);                              {TODO: when this fails due to bad syntax, do better than just tossing: keep going? }
           SetDefault(ThisDefault);
       end;
   end;
end;

function TDTDAttributes.Compose(StartingIndent : Integer; StartingLineNumber : Integer) : AnsiString;
var
   ResultStrings : TStringList;
begin
   ResultStrings := TStringList.Create;
   try
       Compose(ResultStrings, StartingIndent, StartingLineNumber);
       Result := ResultStrings.Text
   finally
       ResultStrings.Free
   end;
end;

procedure TDTDAttributes.Compose(ResultStrings : TStrings; StartingIndent : Integer; StartingLineNumber : Integer);
var
   Counter : Integer;
begin
   if Self.Count > 0 then
   begin
       ResultStrings.Add(XMLCollection.GetTabSpaces(StartingIndent) +
           Trim(START_ATTLIST_TOKEN) + ' ' + Element.ElementName);

       for Counter := 0 to Count - 1 do
       begin
           Inc(StartingLineNumber);
           ResultStrings.Add(Attributes[Counter].Compose((StartingIndent + 1), StartingLineNumber));
       end;

       ResultStrings.Add(XMLCollection.GetTabSpaces(StartingIndent) + END_TOKEN);
   end;
end;

function TDTDAttribute.XPaths : IAutoStringList;
begin
   Result := TAutoStringList.Create;
   XPaths(Result.StringsObject);
end;

function TDTDAttribute.XPaths(AList : TStrings) : Integer;
var
   Counter : Integer;
begin
   Self.Element.XPaths(AList);
   for Counter := 0 to AList.Count - 1 do
       AList[Counter] := AList[Counter] + '/@' + Self.Name;

   Result := AList.Count;
end;

{  TNestedElementReference   }

constructor TNestedElementReference.Create(ACollection : TCollection);
begin
   inherited;
   FNestedElementReferences := TNestedElementReferences.Create(TNestedElementReferences(Collection).Element);
   FNestedElementReferences.FReference := Self;
   FRepeatType := rtOne;
end;

destructor TNestedElementReference.Destroy;
begin
   FNestedElementReferences.Free;
   inherited;
end;

function TNestedElementReference.IsNested : Boolean;
begin
   Result := NestedElementReferenceCount > 0;
end;

function TNestedElementReference.NestedElementReferenceCount : Integer;
begin
   Result := FNestedElementReferences.Count;
end;

procedure TNestedElementReference.Parse(AText : AnsiString);
begin
   raise Exception.Create('Not yet implimented');
end;

function TNestedElementReference.Compose : AnsiString;
begin
   if Self.IsNested then
       Result := Self.NestedElementReferences.Compose
   else
       Result := Self.Name + REPEAT_SYMBOLS[Self.RepeatType];
end;

procedure TNestedElementReference.SetName(Value : string);
var
   NewType : TRepeatType;
begin
   if FName <> Value then
   begin
       NewType := TDTDElement.StripRepeatType(Value);
       if NewType <> rtOne then
           Self.RepeatType := NewType;
       FName := Value;
   end;
end;

function TNestedElementReference.Element : TDTDElement;
begin
   Result := TNestedElementReferences(Collection).Element.DocType.Elements.Find(Self.Name);
   if Result = nil then
       raise EXMLExternalEntityReferenceMissingError.Create(Self.ParentReferences.Element.Name + '''s nested element ' + Self.Name + ' is not available');
end;

function TNestedElementReference.ParentReferences : TNestedElementReferences;
begin
   Result := Collection as TNestedElementReferences;
end;

{  TNestedElementReferences  }

constructor TNestedElementReferences.Create(AnElement : TDTDElement);
begin
   Create(TNestedElementReference);
   FElement := AnElement;
   FSequence := rsUnknown;
end;

function TNestedElementReferences.Add : TNestedElementReference;
begin
   Result := (inherited Add) as TNestedElementReference;
end;

procedure TNestedElementReferences.Update(AnItem : TCollectionItem);
begin
   Element.CheckElementType;

   if Self.Count = 1 then
       FSequence := rsSole

   else if (Self.Count > 1) and (Sequence in [rsUnknown, rsSole]) then
       FSequence := rsAnd;
end;

function TNestedElementReferences.GetReference(Index : Integer) : TNestedElementReference;
begin
   Result := Items[Index] as TNestedElementReference;
end;

function TNestedElementReferences.FindNext(const AnElementName : AnsiString) : TNestedElementReference;
begin
   if not Find(AnElementName, Result) then
       Result := nil;
end;

function TNestedElementReferences.FindNext(const AnElementName : AnsiString; var AReference : TNestedElementReference;
   StartIndex : Integer = 0; EndIndex : Integer = -1) : Boolean;
begin
   Result := False;

   if (EndIndex = -1) or (EndIndex >= Self.Count) then
       EndIndex := Self.Count - 1;

   if StartIndex <= EndIndex then
   begin
       if (AnElementName = '') or (References[StartIndex].Name = AnElementName) then
       begin
           Assert(LogDebug('TNestedElementReferences.FindNext: found "' + AnElementName + '" as the first item Checked'));
           AReference := References[StartIndex];
           Result := True;
       end
       else if References[StartIndex].IsNested then
       begin
           Assert(LogDebug('TNestedElementReferences.FindNext: checking the child item''s items'));
           Result := References[StartIndex].NestedElementReferences.FindNext(AnElementName, AReference); //  sort of recursive
       end;

       if (not Result) then
       begin
           if (Self.Sequence = rsOr) then
           begin
               Assert(LogDebug('TNestedElementReferences.FindNext: checking the next item of an OR list'));
               Result := Self.FindNext(AnElementName, AReference, StartIndex + 1, EndIndex); //  recursive
           end
           else if References[StartIndex].RepeatType in [rtOptionalOne, rtOptionalMany] then
           begin
               Assert(LogDebug('TNestedElementReferences.FindNext: checking the next item after an optional item on a Sequence list'));
               Result := Self.FindNext(AnElementName, AReference, StartIndex + 1, EndIndex); //  recursive
           end;
       end;
   end
   else
       Assert(LogDebug('TNestedElementReferences.FindNext: starting past the last element'));
end;

function TNestedElementReferences.Find(const AnElementName : string) : TNestedElementReference;
begin
   if not Find(AnElementName, Result) then
       Result := nil;
end;

function TNestedElementReferences.Find(const AnElementName : string; var AReference : TNestedElementReference) : Boolean;
var
   Counter : Integer;
begin
   Result := False;
   AReference := nil;

   for Counter := 0 to Self.Count - 1 do
   begin
       if References[Counter].IsNested then
       begin
           Result := References[Counter].NestedElementReferences.Find(AnElementName, AReference); //	recursive
           if Result then
               Break;
       end
       else if References[Counter].Name = AnElementName then
       begin
           AReference := References[Counter];
           Result := True;
           Break;
       end;
   end;
end;

function TNestedElementReferences.LoadReferences : string;
var
   ThisStrings : TCraftingStringList;
begin
   ThisStrings := TCraftingStringList.Create;
   try
       LoadReferences(ThisStrings);
       Result := ThisStrings.SeparatedText[', '];
   finally
       Free;
   end;
end;

procedure TNestedElementReferences.LoadReferences(AStrings : TStrings);
var
   Counter, Index : Integer;
begin
   for Counter := 0 to Self.Count - 1 do
   begin
       if References[Counter].IsNested then
           References[Counter].NestedElementReferences.LoadReferences(AStrings) //	recursive

       else if References[Counter].Name <> PCDATA_TOKEN then
       begin
           Index := AStrings.IndexOf(References[Counter].Name);
           if Index = -1 then
               Index := AStrings.Add(References[Counter].Name);
           AStrings.Objects[Index] := TObject(Integer(AStrings.Objects[Index]) + 1);
       end;
   end;
end;

function TNestedElementReferences.Compose : string;
const
   OR_SEPARATOR = ' ' + OR_TOKEN + ' ';
   AND_SEPARATOR = AND_TOKEN + ' ';
var
   Counter : Integer;
begin
   Result := EMPTY_STRING;

   for Counter := 0 to Self.Count - 1 do
   begin
       case Sequence of
           rsSole : Result := References[0].Compose;
           rsOr : Result := Result + OR_SEPARATOR + References[Counter].Compose;
           rsAnd : Result := Result + AND_SEPARATOR + References[Counter].Compose;
       end;
   end;
   case Sequence of
       rsOr : System.Delete(Result, 1, Length(OR_SEPARATOR));
       rsAnd : System.Delete(Result, 1, Length(AND_SEPARATOR));
   end;

   Result := BEGIN_SET + Result + END_SET + REPEAT_SYMBOLS[Self.RepeatType];
end;

function TNestedElementReferences.XMLCollection : TXMLCollection;
begin
   Result := Element.DocType.XMLCollection;
end;

function TNestedElementReferences.First(var AReference : TNestedElementReference) : Boolean;
begin
   ResetIterator;
   Result := Next(AReference);
end;

function TNestedElementReferences.Next(var AReference : TNestedElementReference) : Boolean;
begin
   Result := inherited Next(TCollectionItem(AReference));
end;

{  TNestedElementReference  }

constructor TDTDElement.Create(ACollection : TCollection);
begin
   inherited;
   FNestedElements := TNestedElementReferences.Create(TNestedElementReference);
   FNestedElements.FElement := Self;
   FAttributes := TDTDAttributes.Create(TDTDAttribute);
   FAttributes.Element := Self;
end;

destructor TDTDElement.Destroy;
begin
   FNestedElements.Free;
   FAttributes.Free;
   inherited;
end;

function TDTDElement.GetIndexName : string;
begin
   Result := Self.Name;
end;

function TDTDElement.AttributeCount : Integer;
begin
   Result := FAttributes.Count;
end;

function TDTDElement.FindAttribute(const AName : string) : TDTDAttribute;
begin
   Result := nil;
   if not Attributes.Find(AName, Result) then
   begin
       if AName = BASE_DEFINITION_ATTRIBUTE_NAME then
           Result := DocType.UniversalBaseAttribute

       else if (AName = NAMESPACE_DEFINITION_ATTRIBUTE_NAME) or
           (Copy(AName, 1, Length(NAMESPACE_DEFINITION_PREFIX)) = NAMESPACE_DEFINITION_PREFIX) then
       begin
           Result := DocType.UniversalNamespaceAttribute;
       end;
   end;
end;

function TDTDElement.AttributeByName(const AName : string) : TDTDAttribute;
begin
   if not Attributes.Find(AName, Result) then
   begin
       if AName = BASE_DEFINITION_ATTRIBUTE_NAME then
           Result := DocType.UniversalBaseAttribute
       else if (AName = NAMESPACE_DEFINITION_ATTRIBUTE_NAME) or
           (Copy(AName, 1, Length(NAMESPACE_DEFINITION_PREFIX)) = NAMESPACE_DEFINITION_PREFIX) then
       begin
           Result := DocType.UniversalNamespaceAttribute
       end
       else
           raise EXMLUnknownAttributeError.Create('Undefined attribute "' + AName + '"');
   end;
end;

function TDTDElement.GetDocType : TDocType;
begin
   Result := TDTDElements(Collection).DocType;
end;

class function TDTDElement.GetRepeatSymbol(ARepeatType : TRepeatType) : AnsiString;
begin
   Result := REPEAT_SYMBOLS[ARepeatType];
end;

class function TDTDElement.StripRepeatType(var AString : AnsiString) : TRepeatType;
begin
   Result := GetRepeatType(AString);
   if Result in [rtOptionalOne, rtMany, rtOptionalMany] then
       Delete(AString, Length(AString), 1);
end;

class function TDTDElement.GetRepeatType(AString : AnsiString) : TRepeatType;
var
   Counter : Integer;
   ThisChar : Char;
begin
   Result := rtOne;                                        //  default
   if AString <> EMPTY_STRING then
   begin
       ThisChar := ExtractChar(AString, -1);
       for Counter := Integer(Low(REPEAT_SYMBOLS)) to Integer(High(REPEAT_SYMBOLS)) do
       begin
           if ThisChar = REPEAT_SYMBOLS[TRepeatType(Counter)] then
           begin
               Result := TRepeatType(Counter);
               Break;
           end;
       end;
   end;
end;

function TDTDElement.GetNestedElementRepetition : TRepeatType;
begin
   Result := FNestedElements.RepeatType;
end;

procedure TDTDElement.SetNestedElementRepetition(Value : TRepeatType);
begin
   FNestedElements.FRepeatType := Value;
end;

procedure TDTDElement.Parse(AText : AnsiString);
begin
   FNestedElements.Clear;
   ElementMask := AText;                                   //      parses the child element references
end;

function TDTDElement.GetElementMask : AnsiString;
begin
   case Self.ElementType of
       etEmpty : Result := EMPTY_TOKEN;
       etAny : Result := ANY_TOKEN;
       etComment : Result := EMPTY_STRING;
       etElements : Result := NestedElements.Compose;
       etMixed :
           begin
               if NestedElements.Count = 0 then
                   Result := '(' + PCDATA_TOKEN + ')'
               else
                   Result := '(' + PCDATA_TOKEN + ' | ' + SubString(NestedElements.Compose, 2); //  skip the first paraentheses
           end;
   else
       raise Exception.Create('DTD element ' + Self.Name + ' is of type ' +
           uCraftClass.FormatEnumName(TypeInfo(TElementType), Integer(ElementType)) +
           ', and does not have a content declaration');
   end;
end;

procedure TDTDElement.CheckElementType;
begin
   if (NestedElements.Count = 0) and (ElementType in [etUnknown, etElements]) then
       FElementType := etEmpty

   else if (NestedElements.Count > 0) and (ElementType in [etUnknown, etEmpty]) then
       FElementType := etElements;
end;

procedure TDTDElement.SetElementMask(Value : AnsiString);

   procedure SetNestedElementReferences(AString : AnsiString; ANestedElements : TNestedElementReferences);
   var
       ThisName, ThisDelimiter : AnsiString;
       NewReference : TNestedElementReference;
   begin
       NewReference := nil;

       ANestedElements.FRepeatType := StripRepeatType(AString); //    defaults to rtOne if no symbol
       AString := Trim(AString);
       while (ExtractChar(AString, 1) = BEGIN_SET) and (ExtractChar(AString, -1) = END_SET) do //	strip off delimiting parentheses symetrically
           AString := Trim(SubString(AString, 2, -1));

       while AString <> EMPTY_STRING do
       begin
           AString := Trim(AString);
           if ExtractChar(AString) = BEGIN_SET then
           begin
               ThisName := StripDelimitedText(AString, BEGIN_SET, END_SET);
               if ExtractChar(AString) in [REPEAT_OPTIONAL_ONCE, REPEAT_OPTIONAL_MANY, REPEAT_REQUIRED_MANY] then
               begin
                   ThisName := ThisName + ExtractChar(AString);
                   Delete(AString, 1, 1);
               end;

               AString := TrimLeft(AString);
               if ExtractChar(AString) in [OR_TOKEN, AND_TOKEN] then
               begin
                   ThisDelimiter := ExtractChar(AString);
                   Delete(AString, 1, 1);
               end
               else
                   ThisDelimiter := '';

               NewReference := ANestedElements.Add;        ////		<--------		new reference here
               Assert(NewReference <> nil);
               SetNestedElementReferences(ThisName, NewReference.NestedElementReferences); //  recursive

               {
               3.2.2 Mixed Content

               [Definition: An element type has mixed content when elements of that type MAY contain character data, optionally interspersed with child elements.] In this case, the types of the child elements MAY be constrained, but not their order or their number of occurrences:
               }

               if (NewReference.NestedElementReferences.Sequence = rsAnd) and (Self.ElementType <> etMixed) then
                   NewReference.FName := NewReference.NestedElementReferences.References[0].Name;
           end
           else
           begin
               ThisDelimiter := StripToDelimiter(AString, [OR_TOKEN, AND_TOKEN], ThisName); //  if one item, then no delimiter
               ThisName := Trim(ThisName);

               if ThisName = PCDATA_TOKEN then
                   FElementType := etMixed                 //  don't actually save the PCDATA_TOKEN as a reference
               else
               begin
                   NewReference := ANestedElements.Add;    ////		<--------		new reference here
                   Assert(NewReference <> nil);
                   NewReference.Name := ThisName;          //  this will detect, set, and strip the RepeatType
               end;
           end;

           if ThisDelimiter = OR_TOKEN then
           begin
               if not (ANestedElements.Sequence in [rsUnknown, rsSole, rsOr]) then
               begin
                   raise EXMLWellFormedError.Create('The nested elements in ' +
                       Self.Name + ' have two different content styles');
               end;
               ANestedElements.FSequence := rsOr;
           end
           else if ThisDelimiter = AND_TOKEN then
           begin
               if not (ANestedElements.Sequence in [rsUnknown, rsSole, rsAnd]) then
               begin
                   raise EXMLWellFormedError.Create('The nested elements in ' +
                       Self.Name + ' have two different content styles');
               end;
               ANestedElements.FSequence := rsAnd;
           end;
       end;

       if ANestedElements.Sequence = rsUnknown then        //  if we have only one item
       begin
           ANestedElements.FSequence := rsSole;
           if (ANestedElements.FRepeatType = rtOne) and (NewReference <> nil) and (NewReference.RepeatType <> rtOne) then
           begin
               ANestedElements.FRepeatType := NewReference.RepeatType;
               NewReference.RepeatType := rtOne;           //	make the parent control the repetition
           end;
       end;
   end;

begin
   Value := DocType.ReplaceParameterEntities(Value);

   if SameText(Value, EMPTY_TOKEN) then
       FElementType := etEmpty

   else if SameText(Value, ANY_TOKEN) then
       FElementType := etAny

   else if SameText(Value, PCDATA_TOKEN) or SameText(Value, '(' + PCDATA_TOKEN + ')') then
       FElementType := etMixed

   else
   begin
       FElementType := etElements;
       try
           SetNestedElementReferences(Value, FNestedElements);
       except
           on E : EXMLWellFormedError do
           begin
               E.Message := E.Message + ' in ' + Value;
               raise;
           end;
       end;

       CheckElementType;
   end;

   Self.Changed(False);
end;

function TDTDElement.Compose(StartingIndent : Integer; StartingLineNumber : Integer) : AnsiString;
begin
   Self.LineNumber := StartingLineNumber;

   case Self.ElementType of
       etComment : Result := START_COMMENT_TOKEN + Self.Name + END_COMMENT_TOKEN;
       etAny, etMixed, etElements, etEmpty :
           begin
               Result := XMLCollection.GetTabSpaces(StartingIndent) +
                   START_ELEMENT_TOKEN + ElementName + TrimRight(' ' + ElementMask) + END_TOKEN;
           end;
       etAttributesOnly :
           // this element appears only in an <!ATTLIST so it cannot compose itself because it does not have any idea what sub-elements it might contain
           Result := EMPTY_STRING;
   else
       raise EXMLError.Create('DTD Element ' + Self.Name +
           ' cannot compose itself because it does not have a valid ElementType');
   end;
end;

function TDTDElement.LoadUsedByList(ADTDElementList : TDTDElementList) : Integer;
var
   ThisElement : TDTDElement;
begin
   Result := 0;
   with TDTDElementsEnumerator.Create(Self.DocType.Elements) do //	do not use the collection's own enumerator
   begin
       if First(ThisElement) then
       begin
           repeat
               if ThisElement.NestedElements.Find(Self.Name) <> nil then
               begin
                   if ADTDElementList <> nil then
                       ADTDElementList.Add(ThisElement);
                   Inc(Result);
               end;
           until not Next(ThisElement);
       end;
   end;
end;

function TDTDElement.FindNextReference(AnElementName : AnsiString;
   var AChildReference : TNestedElementReference; CheckMultiples : Boolean = True) : Boolean;
var
   ThisParentReferences : TNestedElementReferences;
   ThisIndex : Integer;
begin
   Result := False;

   if AChildReference = nil then
   begin
       Assert(LogDebug('Searching the whole reference tree'));
       Result := Self.NestedElements.Find(AnElementName, AChildReference); //  find the first matching reference
   end
   else
   begin
       //			check if we are already on the appropriate repeating element
       if (AChildReference.Name = AnElementName) and (AChildReference.RepeatType in [rtMany, rtOptionalMany]) then
           Result := True
       else
       begin
           ThisParentReferences := AChildReference.ParentReferences;
           ThisIndex := AChildReference.Index;
           if (ThisIndex >= ThisParentReferences.Count) and
               (ThisParentReferences.RepeatType in [rtMany, rtOptionalMany]) then
           begin
               ThisIndex := -1;                            //	loop back to the beginning of this set of references
           end;

           while True do
           begin
               Result := ThisParentReferences.FindNext(AnElementName, AChildReference, ThisIndex + 1);
               if Result then
                   Break;

               if CheckMultiples and (ThisParentReferences.RepeatType in [rtMany, rtOptionalMany]) and
                   (ThisParentReferences.Sequence in [rsOr, rsSole]) then
               begin
                   Assert(LogDebug('TDTDElement.FindNextReference: Searching from the beginning of an OR-Many list'));
                   Result := ThisParentReferences.FindNext(AnElementName, AChildReference, 0, ThisIndex); //  search previous items in the OR list
                   if Result then
                       Break;
               end;

               if (ThisParentReferences.Reference <> nil) then //  go up the node tree and look for an ancestor OR list
               begin
                   ThisIndex := ThisParentReferences.Reference.Index;
                   ThisParentReferences := ThisParentReferences.Reference.ParentReferences;
               end

               else                                        //  we have no where else to look: fail now
                   Break;
           end;
       end;
   end;
end;

function TDTDElement.FindNextRequiredReference(var AReference : TNestedElementReference) : Boolean;
var
   ThisParentReferences : TNestedElementReferences;
begin
   Result := False;
   while Self.FindNextReference('', AReference, False) do
   begin
       if AReference.RepeatType in [rtOne, rtMany] then
       begin
           Result := True;
           ThisParentReferences := AReference.ParentReferences;
           while ThisParentReferences <> nil do
           begin
               if ThisParentReferences.RepeatType in [rtOptionalOne, rtOptionalMany] then
               begin
                   Result := False;                        //  not required because an ancestor is not required
                   Break;
               end;
               if ThisParentReferences.Reference <> nil then
                   ThisParentReferences := ThisParentReferences.Reference.ParentReferences
               else
                   ThisParentReferences := nil;
           end;
           if Result then
               Break;
       end;
   end;
end;

function TDTDElement.FirstChildElement(var AnElement : TDTDElement) : Boolean;
var
   ThisObject : TCollectionItem;
begin
   if FNestedEnumerator = nil then
       FNestedEnumerator := TCollectionEnumerator.Create(FNestedElements);

   Result := FNestedEnumerator.First(ThisObject);
   if Result then
       AnElement := (ThisObject as TNestedElementReference).Element;
end;

function TDTDElement.NextChildElement(var AnElement : TDTDElement) : Boolean;
var
   ThisObject : TCollectionItem;
begin
   if FNestedEnumerator = nil then
       FNestedEnumerator := TCollectionEnumerator.Create(FNestedElements);

   Result := FNestedEnumerator.Next(ThisObject);
   if Result then
       AnElement := (ThisObject as TNestedElementReference).Element;
end;

procedure TNestedElementReference.Clear;
begin
   inherited;
   FName := '';
   FRepeatType := rtUnknown;
   FNestedElementReferences.Free;
   FNestedElementReferences := nil;
end;

function TNestedElementReference.GetIndexName : string;
begin
   Result := Self.Name;
end;

{  TDTDElementList }

function TDTDElementList.Add(ADTDElement : TDTDElement) : Integer;
begin
   Result := AddObject(ADTDElement.Name, ADTDElement);
end;

function TDTDElementList.GetElement(Index : Integer) : TDTDElement;
begin
   Result := Self.Objects[Index] as TDTDElement;
end;

{  TDTDElements    }

constructor TDTDElements.Create;
begin
   Create(TDTDElement);
end;

destructor TDTDElements.Destroy;
begin
   FElementNameLookup.Free;
   FElementNameLookup := nil;                              //  yes, something does try and use this while shuttng down
   FEnumerator := nil;
   inherited;
end;

procedure TDTDElements.ItemChange(AnElement : TDTDElement);
begin
   if FElementNameLookup <> nil then
       FElementNameLookup.Clear;
end;

procedure TDTDElements.Notify(AnItem : TCollectionItem; AnAction : TCollectionNotification);
begin
   ItemChange(AnItem as TDTDElement);

   if (DocType.FRootElement = AnItem) and (AnAction in [cnExtracting, cnDeleting]) then
       DocType.FRootElement := nil;
end;

procedure TDTDElements.Clear;
begin
   inherited;
   if FElementNameLookup <> nil then
       FElementNameLookup.Clear;
end;

function TDTDElements.Add(AName : string) : TDTDElement;
begin
   Result := TDTDElement(inherited Add);
   Result.FName := AName;

   if FElementNameLookup <> nil then
       FElementNameLookup.Clear;
end;

function TDTDElements.Find(const AName : AnsiString; IncludeIgnoredElements : Boolean = False) : TDTDElement;
begin
   Find(AName, IncludeIgnoredElements, Result);
end;

function TDTDElements.Find(const AName : AnsiString; var AnElement : TDTDElement) : Boolean;
begin
   Result := Find(AName, False, AnElement);
end;

function TDTDElements.Find(const AName : AnsiString;
   IncludeIgnoredElements : Boolean; var AnElement : TDTDElement) : Boolean;
var
   FoundObject : TObject;
begin
   Result := False;
   AnElement := nil;
   if (FElementNameLookup = nil) or (FElementNameLookup.Count <> Self.Count) then
       IndexElementNames;

   if FElementNameLookup.Find(AName, FoundObject) then
   begin
       if IncludeIgnoredElements or (not TDTDElement(FoundObject).Ignore) then
       begin
           AnElement := TDTDElement(FoundObject);
           Result := True;
       end;
   end;
end;

function TDTDElements.GetElement(Index : Integer) : TDTDElement;
begin
   Result := TDTDElement(Items[Index]);
end;

procedure TDTDElements.IndexElementNames;
var
   Counter : Integer;
begin
   if FElementNameLookup = nil then
   begin
       FElementNameLookup := TCraftingStringList.Create;
       FElementNameLookup.CaseSensitive := True;
       FElementNameLookup.Duplicates := dupAccept;         //  not a great idea, but duplicates are a validation error, not a well-formed error
   end
   else
       FElementNameLookup.Clear;

   FElementNameLookup.Sorted := False;
   FElementNameLookup.BeginUpdate;

   for Counter := 0 to Self.Count - 1 do
       FElementNameLookup.AddObject(Elements[Counter].ElementName, Elements[Counter]);

   FElementNameLookup.EndUpdate;
   FElementNameLookup.Sorted := True;
end;

function TDTDElements.First(var ADTDElement : TDTDElement; IncludeIgnoredElements : Boolean) : Boolean;
begin
   if FEnumerator = nil then
       FEnumerator := TDTDElementsEnumerator.Create(Self); //	interface-counted

   Result := FEnumerator.First(ADTDElement, IncludeIgnoredElements);
end;

function TDTDElements.Next(var ADTDElement : TDTDElement; IncludeIgnoredElements : Boolean) : Boolean;
begin
   Result := FEnumerator.Next(ADTDElement, IncludeIgnoredElements);
end;

function TDTDElements.FirstComment(var ADTDElement : TDTDElement) : Boolean;
begin
   Result := inherited First(TCollectionItem(ADTDElement));
   if Result and (ADTDElement.ElementType <> etComment) then
       Result := NextComment(ADTDElement);
end;

function TDTDElements.NextComment(var ADTDElement : TDTDElement) : Boolean;
begin
   repeat
       Result := inherited Next(TCollectionItem(ADTDElement));
   until (not Result) or (ADTDElement.ElementType = etComment);
end;

{   TDTDElementsEnumerator 	}

function TDTDElementsEnumerator.First(var ADTDElement : TDTDElement; IncludeIgnoredElements : Boolean = False) : Boolean;
begin
   Result := inherited First(TCollectionItem(ADTDElement));
   if Result and ((ADTDElement.ElementType = etComment) or ((not IncludeIgnoredElements) and ADTDElement.Ignore)) then
       Result := Next(ADTDElement, IncludeIgnoredElements);
end;

function TDTDElementsEnumerator.Next(var ADTDElement : TDTDElement; IncludeIgnoredElements : Boolean = False) : Boolean;
begin
   repeat
       Result := inherited Next(TCollectionItem(ADTDElement));
   until (not Result) or
       ((ADTDElement.ElementType <> etComment) and (IncludeIgnoredElements or (not ADTDElement.Ignore)));
end;

function TDTDElements.XMLCollection : TXMLCollection;
begin
   Result := DocType.XMLCollection;
end;

{  TDocType    }

constructor TDocType.Create(ACollection : TXMLCollection);
begin
   inherited Create;
   FCollection := ACollection;

   FReferenceType := rtInternal;
   FElements := TDTDElements.Create;
   FElements.DocType := Self;
   FEntities := TDTDEntities.Create;
   FEntities.DocType := Self;
   FNotations := TDTDNotations.Create;
   FItems := TList.Create;
   FReferences := TDTDEntityReferences.Create;
   FReferences.DocType := Self;

   FNestedEntityReplacementLimit := DEFAULT_NESTED_ENTITY_REPLACEMENT_LIMIT;
   FEnforceNestedElementReferenceSequence := DEFAULT_ENFORCE_NESTED_ELEMENT_REFERENCE_SEQUENCE;
   FAllowExternalEntityReferences := DEFAULT_ALLOW_EXTERNAL_ENTITY_REFERENCES;
   FExpandExternalEntityReferences := DEFAULT_EXPAND_EXTERNAL_ENTITY_REFERENCES;

   FUniversalBaseAttribute := TDTDAttribute.Create(nil);
   FUniversalBaseAttribute.Name := 'xml:base';
   FUniversalBaseAttribute.AttributeType := atCData;

   FUniversalNamespaceAttribute := TDTDAttribute.Create(nil);
   FUniversalNamespaceAttribute.Name := 'xmlns';
   FUniversalNamespaceAttribute.AttributeType := atCData;

   FPleaseAddToItems := True;
end;

destructor TDocType.Destroy;
begin
   FElements.Free;
   FEntities.Free;
   FNotations.Free;
   FUniversalBaseAttribute.Free;
   FUniversalNamespaceAttribute.Free;
   FItems.Free;
   FReferences.Free;
   inherited;
end;

procedure TDocType.Clear;
begin
   FElements.Clear;

   FEntities.Clear;
   FNotations.Clear;
   FRootElement := nil;
   FItems.Clear;
   FReferences.Clear;
end;

function TDocType.IsEmpty : Boolean;
begin
   Result := (ItemCount = 0);
end;

function TDocType.NotationExists(const AName : AnsiString) : Boolean;
var
   Counter : Integer;
begin
   Result := False;
   for Counter := 0 to Notations.Count - 1 do
   begin
       if Notations.Items[Counter].Name = AName then
       begin
           Result := True;
           Break;
       end;
   end;
end;

function TDocType.GetRootElement : TDTDElement;
begin
   if FRootElement = nil then
   begin
       if Elements.First(Result) then
       begin
           repeat
               if Result.LoadUsedByList = 0 then
               begin
                   FRootElement := Result;
                   Break;
               end;
           until not Elements.Next(Result);
       end;
   end;
   Result := FRootElement;
end;

procedure TDocType.SetRootElement(Value : TDTDElement);
begin
   if (Self.Name <> EMPTY_STRING) and ((Value = nil) or (Value.Name <> Self.Name)) then
       raise Exception.Create('You cannot set the root element to be other than the name of the Doc Type (' + Self.Name + ')')
   else
       FRootElement := Value;
end;

procedure TDocType.Parse(AText : AnsiString; AnErrorReport : TStrings);
var
   ThisContent, ThisTag, StartDelim, EndDelim : AnsiString;
   ThisFileName : string;
begin
   Self.Clear;

   StripIf(AText, [START_DOCTYPE_TOKEN], ThisTag);
   if ThisTag <> START_DOCTYPE_TOKEN then
   begin
       Self.PleaseAddToItems := True;
       ParseDTD(AText, AnErrorReport);
   end
   else
   begin
       EndDelim := StripToDelimiter(AText, [START_DOCTYPE_DESCRIPTOR, END_TOKEN], ThisContent, False);
       Assert(ThisTag = START_DOCTYPE_TOKEN);

       StripToDelimiter(ThisContent, ThisTag);
       Self.Name := Trim(ThisTag);
       StartDelim := StripToDelimiter(ThisContent, ['SYSTEM', 'PUBLIC'], ThisTag); //  ThisTag is just a placeholder here
       if StartDelim = 'PUBLIC' then
       begin
           ReferenceType := rtPublic;
           StripToDelimiter(ThisContent, ThisTag);
           ExternalReference := StripDelimitingQuotes(Trim(ThisContent)); //  URL
           ExternalOwner := StripDelimitingQuotes(Trim(ThisTag));
       end
       else if StartDelim = 'SYSTEM' then
       begin
           ReferenceType := rtSystem;
           ExternalReference := StripDelimitingQuotes(Trim(ThisContent)); //  file name
       end
       else
           ReferenceType := rtInternal;

       if EndDelim = START_DOCTYPE_DESCRIPTOR then         //      load the internal DTD first
       begin
           StripToDelimiter(AText, [END_DOCTYPE_DESCRIPTOR], ThisContent, False);
           Self.PleaseAddToItems := True;
           ParseDTD(Trim(ThisContent), AnErrorReport);     //      <=====      sort of recursive
       end;

       case ReferenceType of
           rtSystem :
               begin
                   if XMLCollection.IsStandalone then
                       raise EXMLWellFormedError.Create('This document is marked as standalone, yet it has an external DTD');

                   ThisFileName := Self.ExternalReference;
                   if ExpandFileName(ThisFileName) <> ThisFileName then
                       ThisFileName := ExpandFileName(IncludeTrailingPathDelimiter(EntityBase) + ThisFileName);

                   if not FileExists(ThisFileName) and (XMLCollection.FileName <> '') then
                       ThisFileName := ExtractFilePath(XMLCollection.FileName + ThisFileName);

                   if not FileExists(ThisFileName) then
                   begin
                       raise EXMLValidationInvalidExternalReferenceError.Create('The external DTD file ' +
                           ThisFileName + ' is not available');
                   end;

                   ThisContent := TrimLeft(FileText(ThisFileName));
                   if Copy(ThisContent, 1, Length(START_XML_TOKEN)) = START_XML_TOKEN then
                       StripTo(ThisContent, END_TOKEN);

                   if StripIf(ThisContent, START_DOCTYPE_TOKEN) <> '' then
                       StripTo(ThisContent, END_DOCTYPE_DESCRIPTOR);

                   Self.PleaseAddToItems := False;         //  we won't be composing the external references
                   try
                       ParseDTD(ThisContent, AnErrorReport);
                   finally
                       Self.PleaseAddToItems := True;
                   end;

               end;
           rtPublic :
               raise ENotYetImplemented.Create;
       end;

       if Self.Name <> EMPTY_STRING then
           Self.RootElement := Elements.Find(Self.Name);
   end;
end;

procedure TDocType.ParseDTD(Value : AnsiString; EntityBase : string; EntityRecursionLevel : Integer);
begin
   ParseDTD(Value, nil, EntityBase, EntityRecursionLevel);
end;

procedure TDocType.ParseDTD(Value : AnsiString; AnErrorReport : TStrings;
   AnEntityBase : string; EntityRecursionLevel : Integer);
var
   ThisContent, ThisTag, StartDelim, DTDElementName : AnsiString;
   ThisDTDElement : TDTDElement;
   DTDLength, StartBlockOffset : Integer;
   ThisEntity : TDTDEntity;
   PrevAddToItems : Boolean;
   ThisItem : TBaseDTDItem;
begin
   Self.EntityBase := AnEntityBase;

   XMLCollection.DoStartDTDParsing(Self);
   DTDLength := Length(Value);
   StartBlockOffset := 0;
   while Value <> EMPTY_STRING do
   begin
       try
           StartDelim := StripToDelimiter(Value,
               [START_ELEMENT_TOKEN, START_ATTLIST_TOKEN, START_ENTITY_TOKEN, START_NOTATION_TOKEN,
               START_COMMENT_TOKEN, PARAMETER_ENTITY_TOKEN],
                   ThisTag, False);

           StartBlockOffset := DTDLength - Length(Value);

           if StartDelim = START_ELEMENT_TOKEN then
           begin
               //                 these tokens might be without parentheses
               //                     legally, PCDATA must have parens and EMPTY and ANY must not
               StartDelim := StripToDelimiter(Value, [END_TOKEN], ThisContent);
               ThisContent := ReplaceParameterEntities(ThisContent);

               DTDElementName := StripTo(ThisContent);     //  get the first word
               if Elements.Find(DTDElementName, ThisDTDElement) then
               begin
                   if ThisDTDElement.ElementType = etAttributesOnly then
                       ThisDTDElement.Parse(Trim(ThisContent)) //  resets ElementType
                   else
                       Assert(False, 'Duplicate DTDElement found: ' + ThisDTDElement.ElementName);
               end
               else
               begin
                   ThisDTDElement := DTDElements.Add;      //  creates FElements if necessary
                   ThisDTDElement.ElementName := DTDElementName;
                   if PleaseAddToItems then
                       AddItem(ThisDTDElement);

                   ThisDTDElement.Parse(Trim(ThisContent)); //  sets ElementType
               end;
           end
           else if StartDelim = START_ATTLIST_TOKEN then
           begin
               StripToDelimiter(Value, [END_TOKEN], ThisContent, True);
               ThisContent := ReplaceParameterEntities(Trim(ThisContent));
               StripToDelimiter(ThisContent, DTDElementName, True);
               if not Self.Elements.Find(DTDElementName, ThisDTDElement) then //  find the previously created DTD element
               begin
                   ThisDTDElement := DTDElements.Add;      //  creates FElement if necessary
                   ThisDTDElement.ElementName := DTDElementName;
                   ThisDTDElement.FElementType := etAttributesOnly;
               end;
               ThisDTDElement.Attributes.Parse(ThisContent);
           end
           else if StartDelim = START_ENTITY_TOKEN then
           begin
               StripToDelimiter(Value, [END_TOKEN], ThisTag, False);
               ThisItem := TDTDEntity.Create(Entities);
               ThisItem.Parse(ThisTag);

               if (not AllowExternalEntityReferences) and
                   (TDTDEntity(ThisItem).ReferenceType in [rtPublic, rtSystem]) then
               begin
                   raise EXMLExternalEntitiesDisallowedError.Create('External Entity references disallowed: ' + Compose);
               end;

               if PleaseAddToItems then
                   AddItem(ThisItem);
           end
           else if StartDelim = START_NOTATION_TOKEN then
           begin
               StripToDelimiter(Value, [END_TOKEN], ThisTag, False);
               ThisItem := TDTDNotation.Create(Notations);
               begin
                   TDTDNotation(ThisItem).Parse(ThisTag);

                   if (not AllowExternalEntityReferences) and
                       (TDTDNotation(ThisItem).ReferenceType in [rtPublic, rtSystem]) then
                   begin
                       raise EXMLExternalEntitiesDisallowedError.Create('External Entity references disallowed: ' + Compose);
                   end;
               end;
               if PleaseAddToItems then
                   AddItem(ThisItem);
           end
           else if StartDelim = START_COMMENT_TOKEN then
           begin
               StripToDelimiter(Value, [END_COMMENT_TOKEN], ThisTag, False);
               ThisDTDElement := DTDElements.Add;          //  creates FElements if necessary
               ThisDTDElement.FElementType := etComment;
               ThisDTDElement.ElementName := ThisTag;      //  Parameter entity references MUST NOT be recognized within comments.
               if PleaseAddToItems then
                   AddItem(ThisDTDElement);
           end
           else if StartDelim = PARAMETER_ENTITY_TOKEN then
           begin
               StripToDelimiter(Value, [END_ENTITY_TOKEN], ThisTag, False);

               ThisItem := FReferences.Add;
               ThisItem.RawText := ThisTag;
               if PleaseAddToItems then
                   AddItem(ThisItem);

               if Entities.Find(ThisTag, ThisEntity, True) then
               begin
                   TDTDEntityReference(ThisItem).Entity := ThisEntity;

                   if ExpandExternalEntityReferences then
                   begin
                       PrevAddToItems := Self.PleaseAddToItems;
                       Self.PleaseAddToItems := False;
                       try
                           ParseDTD(ThisEntity.ReplacementText, AnEntityBase, EntityRecursionLevel + 1);
                       finally
                           Self.PleaseAddToItems := PrevAddToItems;
                       end;
                   end;
               end;
           end;
       except
           on E : EXMLWellFormedError do
           begin
               E.CharacterOffset := StartBlockOffset;
               E.ElementIndex := DTDElements.Count;
               E.ElementName := DTDElementName;

               if AnErrorReport <> nil then
                   AnErrorReport.Add(E.Message + E.Location)
               else
                   raise;
           end;
       end;
   end;
   XMLCollection.DoEndDTDParsing(Self);
end;

{ TODO : this should use the TDTDEntities and selectively translate for re-parse ('%') or not Entities are allowed in DTD declarations }

function TDocType.Compose(StartingIndent : Integer; StartingLineNumber : Integer) : AnsiString;
var
   ResultStrings : TStringList;
begin
   ResultStrings := TStringList.Create;
   try
       Compose(ResultStrings, StartingIndent, StartingLineNumber);
       Result := ResultStrings.Text
   finally
       ResultStrings.Free
   end;
end;

procedure TDocType.Compose(ResultStrings : TStrings; StartingIndent : Integer; StartingLineNumber : Integer);
var
   ThisString : string;
   Counter : Integer;
begin
   ResultStrings.BeginUpdate;
   try
       if ItemCount > 0 then
       begin
           Self.LineNumber := StartingLineNumber;

           for Counter := 0 to ItemCount - 1 do
           begin
               if Items[Counter] is TDTDElement then
               begin
                   if TDTDElement(Items[Counter]).ElementType = etComment then
                   begin
                       ResultStrings.AddObject(Items[Counter].Compose(StartingIndent), TObject(StartingIndent)); {TODO: use parameter entities when values match }
                       Items[Counter].LineNumber := StartingLineNumber;
                       Inc(StartingLineNumber);
                   end
                   else
                       Break;                              //  stop at the first non-comment
               end;
           end;

           //         DTD: '<!DOCTYPE' S Name ExtID? S? ('[' (Elements | Attributes | Entities | Notations | S | Comment)* ']' S?)? '>'
           ThisString := START_DOCTYPE_TOKEN + ' ' + Name;
           case ReferenceType of
               rtSystem : ThisString := ThisString + ' SYSTEM ' + AddDelimitingQuotes(ExternalReference);
               rtPublic : ThisString := ThisString + ' PUBLIC ' + AddDelimitingQuotes(ExternalOwner) + ' ' + AddDelimitingQuotes(ExternalReference);
           end;

           ResultStrings.AddObject(XMLCollection.GetTabSpaces(StartingIndent) +
               ThisString + ' ' + START_DOCTYPE_DESCRIPTOR, TObject(StartingIndent));

           ComposeCore(ResultStrings, StartingIndent + 1, StartingLineNumber + 1);

           ResultStrings.AddObject(XMLCollection.GetTabSpaces(StartingIndent) +
               END_DOCTYPE_DESCRIPTOR, TObject(StartingIndent));
       end;
   finally
       ResultStrings.EndUpdate;
   end;
end;

function TDocType.ComposeCore(StartingIndent : Integer; StartingLineNumber : Integer) : AnsiString;
var
   ResultStrings : TStringList;
begin
   ResultStrings := TStringList.Create;
   try
       ComposeCore(ResultStrings, StartingIndent, StartingLineNumber);
       Result := ResultStrings.Text
   finally
       ResultStrings.Free
   end;
end;

procedure TDocType.ComposeCore(ResultStrings : TStrings; StartingIndent : Integer; StartingLineNumber : Integer);
var
   Counter : Integer;
   PrevStringCount : Integer;
   IsPastLeadingComments : Boolean;
begin
   ResultStrings.BeginUpdate;
   try
       IsPastLeadingComments := False;

       for Counter := 0 to ItemCount - 1 do
       begin
           if (not IsPastLeadingComments) and (Items[Counter] is TDTDElement) then
           begin
               if TDTDElement(Items[Counter]).ElementType = etComment then
                   Continue                                //  we have written them before the DOCTYPE [ above
               else
                   IsPastLeadingComments := True;
           end;

           ResultStrings.AddObject(Items[Counter].Compose(StartingIndent), TObject(StartingIndent)); {TODO: use parameter entities when values match }
           Items[Counter].LineNumber := StartingLineNumber;
           Inc(StartingLineNumber);
           if Items[Counter] is TDTDElement then
           begin
               //  put attributes right after element
               PrevStringCount := ResultStrings.Count;

               TDTDElement(Items[Counter]).Attributes.Compose(ResultStrings, StartingIndent, Items[Counter].LineNumber);

               Inc(StartingLineNumber, ResultStrings.Count - PrevStringCount);
           end;
       end;
   finally
       ResultStrings.EndUpdate;
   end;
end;

function TDocType.Validate(AReport : TStrings) : Boolean;

   procedure ReportError(const AMessage : string);
   begin
       Result := False;                                    //  set the method result
       if AReport <> nil then
           AReport.AddObject('Fatal error: ' + AMessage, TObject(True));
   end;

   procedure ReportWarning(const AMessage : string);
   begin
       if AReport <> nil then
           AReport.AddObject('Warning: ' + AMessage, TObject(False));
   end;

var
   ThisElement : TDTDElement;
   ThisAttribute : TDTDAttribute;
   ThisEnum : string;
   IDAttributeIndex, NotationAttributeIndex : Integer;
   Counter, EnumCount, PrevCounterValue : Integer;
   UniqueEnumerationList, ElementReferenceList : TStringList;
   PrevElementName : string;
begin
   Result := True;

   if AReport <> nil then
       AReport.BeginUpdate;
   try
       if Self.Name <> EMPTY_STRING then
       begin
           if not IsValidXMLName(Self.Name) then
               ReportError('DTD name "' + Self.Name + '" is not a valid XML name');

           if Elements.Find(Self.Name) = nil then
               ReportError('DTD name "' + Self.Name + '" is not an element name');
       end;

       ElementReferenceList := TStringList.Create;
       UniqueEnumerationList := TStringList.Create;
       try
           ElementReferenceList.CaseSensitive := True;
           ElementReferenceList.Sorted := True;
           UniqueEnumerationList.CaseSensitive := True;
           UniqueEnumerationList.Sorted := True;

           PrevElementName := '';
           if Elements.First(ThisElement) then
           begin
               repeat
                   if ThisElement.Name = PrevElementName then
                       raise EXMLValidationError.Create('DTD Element ' + PrevElementName + ' appears more than once')
                   else
                       PrevElementName := ThisElement.Name;

                   if ThisElement.ElementType = etAttributesOnly then
                   begin
                       ReportWarning('Element "' + ThisElement.Name +
                           '" has attributes defined but no <!ELEMENT ' + ThisElement.Name + ' (...)> definition');
                   end;

                   ThisElement.NestedElements.LoadReferences(ElementReferenceList);

                   if ThisElement.Attributes.First(ThisAttribute) then
                   begin
                       IDAttributeIndex := -1;
                       NotationAttributeIndex := -1;
                       repeat
                           for Counter := ThisAttribute.Index + 1 to ThisElement.Attributes.Count - 1 do
                           begin
                               if ThisElement.Attributes[Counter].Name = ThisAttribute.Name then
                               begin
                                   ReportError('Element ' + ThisElement.Name +
                                       ' has the attribute name "' + ThisAttribute.Name + '" more than once');
                               end;
                           end;

                           if (ThisAttribute.DefaultType = dtFixed) and (ThisAttribute.DefaultValue = EMPTY_STRING) then
                           begin
                               ReportError('Element ' + ThisElement.Name +
                                   ' has a FIXED attribute "' + ThisAttribute.Name + '" without a default value');
                           end;

                           if ThisAttribute.AttributeType = atID then
                           begin
                               if IDAttributeIndex <> -1 then
                               begin
                                   ReportError('Element ' + ThisElement.Name +
                                       ' has more than one attribute marked as ID (' +
                                       ThisElement.Attributes[IDAttributeIndex].Name + ' and ' +
                                       ThisAttribute.Name + ')' +
                                       '; only one allowed per element');
                               end
                               else
                                   IDAttributeIndex := ThisAttribute.Index;

                               if not (ThisAttribute.DefaultType in [dtImplied, dtRequired]) then
                               begin
                                   ReportError('Element ' + ThisElement.Name +
                                       ' has an attribute "' + ThisElement.Attributes[IDAttributeIndex].Name +
                                       '" marked as an ID, but the default is not #IMPLIED or #REQUIRED');
                               end;
                           end;
                           if ThisAttribute.IsNotation then
                           begin
                               if NotationAttributeIndex <> -1 then
                               begin
                                   ReportError('Element ' + ThisElement.Name +
                                       ' has more than one attribute marked as a notation (' +
                                       ThisElement.Attributes[NotationAttributeIndex].Name + ' and ' + ThisAttribute.Name + ')' +
                                       '; only one allowed per element');
                               end
                               else
                                   NotationAttributeIndex := ThisElement.Index;

                               if ThisElement.ElementType = etEmpty then
                               begin
                                   ReportError('Element ' + ThisElement.Name +
                                       ' has an attribute "' + ThisAttribute.Name +
                                       ' marked as a notation but the element is marked as EMPTY');
                               end;
                           end;

                           if (ThisAttribute.AttributeType = atEnumeration) and
                               (ThisAttribute.DefaultValue <> EMPTY_STRING) and
                               (not ThisAttribute.FindAttributeEnum(ThisAttribute.DefaultValue)) then
                           begin
                               ReportError('Element ' + ThisElement.Name + ' has an attribute "' + ThisAttribute.Name +
                                   '" with the default value "' + ThisAttribute.DefaultValue +
                                   '" that is not one of the enumerated values');
                           end;

                           UniqueEnumerationList.Clear;
                           EnumCount := ThisAttribute.AttributeEnumCount;
                           for Counter := 0 to EnumCount - 1 do
                           begin
                               PrevCounterValue := Counter;
                               ThisEnum := ThisAttribute.AttributeEnums[Counter];
                               if (Counter = PrevCounterValue) then;
                               Assert(Counter = PrevCounterValue);
                               if not IsValidNMToken(ThisEnum) then
                               begin
                                   ReportError('Element ' + ThisElement.Name +
                                       ' has an attribute named ' + ThisAttribute.Name + ' with a value "' +
                                       ThisEnum + '" that is not a valid NMTOKEN');
                               end;

                               if ThisAttribute.AttributeType = atEnumeration then
                               begin
                                   if UniqueEnumerationList.IndexOf(ThisEnum) <> -1 then
                                   begin
                                       ReportError('Element ' + ThisElement.Name +
                                           ' has an attribute named ' + ThisAttribute.Name +
                                           ' that has duplicate enumeration: "' + ThisEnum + '"');
                                   end
                                   else
                                       UniqueEnumerationList.Add(ThisEnum);
                               end;
                           end;
                       until not ThisElement.Attributes.Next(ThisAttribute);
                   end;
               until not Elements.Next(ThisElement);
           end;

           if Elements.First(ThisElement) then
           begin
               repeat
                   if ElementReferenceList.IndexOf(ThisElement.Name) = -1 then
                   begin
                       if ThisElement <> Self.RootElement then
                       begin
                           ReportWarning('Element ' + ThisElement.Name + ' is never referenced by any other element and ' +
                               RootElement.Name + ' is already assumed to be the root element');
                       end;
                   end;
               until not Elements.Next(ThisElement);
           end;

           for Counter := 0 to ElementReferenceList.Count - 1 do
           begin
               if Elements.Find(ElementReferenceList.Strings[Counter]) = nil then
               begin
                   if Integer(ElementReferenceList.Objects[Counter]) = 1 then
                       ReportWarning('Element ' + ElementReferenceList.Strings[Counter] + ' is referenced, but not declared')
                   else
                   begin
                       ReportWarning('Element ' + ElementReferenceList.Strings[Counter] + ' is referenced ' +
                           IntToStr(Integer(ElementReferenceList.Objects[Counter])) + ' times, but not declared');
                   end;
               end;
           end;
       finally
           ElementReferenceList.Free;
           UniqueEnumerationList.Free;
       end;

   finally
       if AReport <> nil then
           AReport.EndUpdate;
   end;

   {TODO: check every ATTLIST for an Element. Check for orphan elements (other than the root)  }
   {3.2 Element Type Declarations At user option, an XML processor MAY issue a warning when a declaration mentions an element type for which no declaration is provided, but this is not an error.}
   { An element type MUST NOT be declared more than once. }
end;

function TDocType.ReplaceEntities(AString : string; RecursionLevel : Integer) : string;
begin
   Result := BaseReplaceEntities(AString, RecursionLevel);
end;

function TDocType.ReplaceParameterEntities(AString : string; RecursionLevel : Integer) : string;
begin
   Result := BaseReplaceEntities(AString, RecursionLevel, True);
end;

function TDocType.BaseReplaceEntities(AString : string; RecursionLevel : Integer;
   ParameterEntities : Boolean; RecursionCheckEntityList : TStrings) : string;
var
   ThisCode, NewValue, StartEntityDelimiter : string;
   EntityCounter : Integer;
   LocalList : TStringList;
begin
   if ParameterEntities then
       StartEntityDelimiter := PARAMETER_ENTITY_TOKEN
   else
       StartEntityDelimiter := ENTITY_TOKEN;

   if RecursionCheckEntityList = nil then
   begin
       LocalList := TStringList.Create;
       LocalList.CaseSensitive := True;
       RecursionCheckEntityList := LocalList;
   end
   else
       LocalList := nil;

   try
       if RecursionLevel > NestedEntityReplacementLimit then
       begin
           raise EXMLNestedEntityLimitError.Create('Entity references nested too deeply (' +
               IntToStr(RecursionLevel) + '): ' + AString);
       end
       else
       begin
           Result := EMPTY_STRING;
           EntityCounter := 0;
           repeat
               Result := Result + StripTo(AString, StartEntityDelimiter); //  find the next "&" or "%"
               if AString <> EMPTY_STRING then
               begin
                   if (not ParameterEntities) and (Copy(AString, 1, 1) = '#') then //  don't convert &#nn; (i.e. character encoding)
                       AString := AString + StartEntityDelimiter //  put the delimiter back
                   else
                   begin
                       ThisCode := StripIf(AString, END_ENTITY_TOKEN); //  find the ending ";"

                       if RecursionCheckEntityList.IndexOf(ThisCode) <> -1 then
                           raise EXMLWellFormedError.Create('Cannot have recursion in nested entity references (e.g. ' + ThisCode + ')');

                       if Entities.LookupName(ThisCode, NewValue, ParameterEntities) then
                       begin
                           Inc(EntityCounter);
                           if NestedEntityReplacementLimit < EntityCounter then
                               raise EXMLNestedEntityLimitError.Create('Too many nested entity references: ' + AString); //  prevent run-away loops

                           RecursionCheckEntityList.Add(ThisCode); //  push it on the list (we know it is not there already)

                           if Length(NewValue) <= 2 then
                               Result := Result + NewValue //  optimize for short replacement strings (e.g. "&", "<")
                           else
                           begin
                               Result := Result + BaseReplaceEntities(NewValue, RecursionLevel + 1,
                                   ParameterEntities, RecursionCheckEntityList); //  recursive: replace any embedded codes
                           end;

                           RecursionCheckEntityList.Delete(RecursionCheckEntityList.Count - 1); //  pop it off the list
                       end
                       else
                           raise EXMLUnknownEntityError.Create('Unrecognized entity ' + ThisCode);
                   end;
               end;
           until AString = EMPTY_STRING;
       end;
   finally
       LocalList.Free;
   end;
end;

procedure TDocType.LoadXPaths(AStrings : TStrings; Options : TLoadXPathsOptions);

   procedure AddLine(const ALine : string);
   begin
       if AStrings.IndexOf(ALine) = -1 then                //  enforce no duplicates
           AStrings.Add(ALine);
   end;

   procedure LoadElement(const AnElementName : string; ARepeat : TRepeatType = rtOne; APrefix : string = '');
   var
       Counter : Integer;
       ThisElement : TDTDElement;
       ThisAttribute : TDTDAttribute;
       ThisLine : string;
       FoundFirstType : Boolean;
   begin
       Assert(AnElementName <> '');
       APrefix := APrefix + '/' + AnElementName;

       if lxElements in Options then
           AddLine(APrefix);

       ThisElement := Elements.Find(AnElementName);
       if ThisElement <> nil then
       begin
           if (lxElementText in Options) and (ThisElement.ElementType = etMixed) then
               AddLine(APrefix + '/' + XPATH_TEXT_FUNCTION_NAME + '()');

           if lxAttributes in Options then
           begin
               if ThisElement.Attributes.First(ThisAttribute) then
               begin
                   FoundFirstType := False;
                   repeat
                       case ThisAttribute.AttributeType of
                           atEnumeration :
                               begin
                                   for Counter := 0 to ThisAttribute.AttributeEnumCount - 1 do
                                   begin
                                       ThisLine := '[@ ' + ThisAttribute.Name + ' = "' +
                                           ThisAttribute.AttributeEnum[Counter] + '"]';

                                       if (not FoundFirstType) and (ARepeat in [rtMany, rtOptionalMany]) then
                                           AddLine(APrefix + ThisLine)
                                       else
                                           AddLine(APrefix + '/.' + ThisLine);
                                   end;
                                   FoundFirstType := True;
                               end;
                       else
                           AddLine(APrefix + '/@' + ThisAttribute.Name);
                       end;
                   until not ThisElement.Attributes.Next(ThisAttribute);
               end;
           end;

           for Counter := 0 to ThisElement.NestedElements.Count - 1 do
           begin
               with ThisElement.NestedElements[Counter] do
               begin
                   //  prevent self-reference loops
                   if (Name <> AnElementName) and (Name <> PCDATA_TOKEN) then
                       LoadElement(Name, RepeatType, APrefix); //  recursive
               end;
           end;
       end;
   end;
begin
   LoadElement(Self.RootElement.Name);
end;

function TDocType.TestXPath(AnXPath : string) : Boolean;
var
   Dummy : string;
begin
   Result := TestXPath(AnXPath, Dummy);
end;

function TDocType.TestXPath(AnXPath : string; var ASuccessfulPart : string) : Boolean;

   function TestStep(AStep : string; AnElement : TDTDElement) : Boolean;
   var
       StepPredicate, ThisPredicate, ThisAttributeName, ThisTestClause : string;
       ThisAttribute : TDTDAttribute;
   begin
       Assert(AnElement <> nil);
       StepPredicate := StripStepPredicate(AStep);

       case ExtractChar(AStep, 1) of
           '@' : Result := AnElement.Attributes.Find(SubString(AStep, 2)) <> nil; //  does the attribute exist ?
           '.' : Result := (AStep = '.');
           '*' : Result := (AStep = '*');
       else
           Result := (AStep = AnElement.Name) or (AStep = 'node()');
       end;

       while Result and (StepPredicate <> EMPTY_STRING) do
       begin
           ThisPredicate := StripNextPredicate(StepPredicate); //        test all the predicates at once
           while Result and (ThisPredicate <> EMPTY_STRING) do
           begin
               ThisTestClause := Trim(StripTo(ThisPredicate, [' and ', ' or ']));
               case ExtractChar(ThisTestClause, 1) of
                   '@' :                                   //  [@attributename="value"]
                       begin
                           ThisAttributeName := StripTo(ThisTestClause, ['=', '>', '<'], []); //       do not strip superfluous ='s
                           Delete(ThisAttributeName, 1, 1); //  remove the leading @
                           Result := AnElement.Attributes.Find(ThisAttributeName, ThisAttribute);
                           if Result then
                           begin
                               ThisTestClause := StripQuotedText(ThisTestClause);
                               if (ThisAttribute.AttributeType = atEnumeration) and (ThisTestClause <> '') then
                                   Result := ThisAttribute.AttributeEnums.IndexOf(ThisTestClause) <> NOT_FOUND_INDEX;
                           end;
                           Exit;
                       end;
                   'l' :                                   //  the letter el
                       if ThisTestClause = 'last()' then
                       begin
                           Result := True;
                           Exit;
                       end;
                   '0'..'9' :
                       if StrToIntDef(ThisTestClause, -1) >= 1 then //  e.g. [1]
                       begin
                           Result := True;
                           Exit;
                       end;

               else                                        //  the name in the clause must be the name of another node
                   { TODO : navigate to the other clause and test it }
               end;
           end;
       end;
   end;

   procedure LoadMatchingElements(ThisStep : string; AParentElement : TDTDElement;
       ChildElementList : TDTDElementList; IsAnyDecendant : Boolean);
   var
       ThisChildElement : TDTDElement;
   begin
       if AParentElement.FirstChildElement(ThisChildElement) then
       begin
           repeat
               Assert(ThisChildElement <> nil, 'nil child reference of ' + AParentElement.Name);

               if TestStep(ThisStep, ThisChildElement) then
                   ChildElementList.Add(ThisChildElement);

               if IsAnyDecendant then
                   LoadMatchingElements(ThisStep, ThisChildElement, ChildElementList, IsAnyDecendant); //  recursive

           until not AParentElement.NextChildElement(ThisChildElement);
       end;
   end;

var
   ThisParentElement : TDTDElement;
   ChildElementList : TDTDElementList;
   ParentElementList : TDTDElementList;
   ThisStep, ThisAxis : string;
   IsAnyDecendant : Boolean;
   Counter : Integer;
begin
   ASuccessfulPart := '';

   ParentElementList := TDTDElementList.Create;
   ChildElementList := TDTDElementList.Create;
   try
       ThisAxis := StepAxisToStr(saDescendantOrSelf) + '::';

       if Copy(AnXPath, 1, 2) = '//' then
       begin
           IsAnyDecendant := True;
           ASuccessfulPart := '//';
           Delete(AnXPath, 1, 2);
       end
       else if Copy(AnXPath, 1, Length(ThisAxis)) = ThisAxis then
       begin
           IsAnyDecendant := True;
           ASuccessfulPart := ThisAxis;
           Delete(AnXPath, 1, Length(ThisAxis));
       end
       else
           IsAnyDecendant := False;

       repeat
           ThisStep := StripNextStep(AnXPath);
           if ThisStep = '//' then                         //      not just at the beginning
           begin
               IsAnyDecendant := True;
               ASuccessfulPart := ASuccessfulPart + '//';
           end
           else if ThisStep = 'text()' then
           begin
               ASuccessfulPart := ASuccessfulPart + ThisStep + '/'; //  exit code is expecting a trailing separator
               if AnXPath <> '' then                       //      << ===========      cannot process below this
                   ParentElementList.Clear;                //  we do not match because it is illegal syntax
               Break;
           end
           else
           begin
               if ParentElementList.Count = 0 then         //  first time through
               begin
                   if TestStep(ThisStep, Self.RootElement) then
                       ChildElementList.Add(Self.RootElement);

                   if IsAnyDecendant then
                       LoadMatchingElements(ThisStep, Self.RootElement, ChildElementList, IsAnyDecendant);
               end
               else
               begin
                   for Counter := 0 to ParentElementList.Count - 1 do
                   begin
                       ThisParentElement := ParentElementList.Elements[Counter];

                       if (ThisStep = '.') or (Copy(ThisStep, 1, 2) = '.[') or (ExtractChar(ThisStep) = '@') then
                       begin
                           if TestStep(ThisStep, ThisParentElement) then
                               ChildElementList.Add(ThisParentElement);
                       end
                       else
                           LoadMatchingElements(ThisStep, ThisParentElement, ChildElementList, IsAnyDecendant);
                   end;
               end;
               IsAnyDecendant := False;
           end;

           if ChildElementList.Count > 0 then
               ASuccessfulPart := ASuccessfulPart + ThisStep + '/';

           ParentElementList.Assign(ChildElementList);     //  assign will set ParentElementCount to 0 if nothing matched in this generation
           ChildElementList.Clear;
       until (AnXPath = '') or (ParentElementList.Count = 0);

       if ASuccessfulPart <> '//' then
           Delete(ASuccessfulPart, Length(ASuccessfulPart), 1); //  remove trailing child separator

       Result := ParentElementList.Count > 0;
   finally
       ParentElementList.Free;
       ChildElementList.Free;
   end;
end;

procedure TDocType.Assign(Source : TObject);
begin
   if Source is TXMLCollection then
       Self.Assign(TXMLCollection(Source).DocType)         //  recursive

   else if Source is TDocType then
   begin
       Self.Clear;
       with TDocType(Source) do
       begin
           Self.Elements.Assign(Elements);
           Self.Entities.Assign(Entities);
           Self.Notations.Assign(Notations);
       end;
   end
   else
       raise Exception.Create('You cannot assign a ' + Source.ClassName + ' to a ' + Self.ClassName);
end;

procedure TDocType.AddItem(AnItem : TBaseDTDItem);
begin
   FItems.Add(AnItem);
end;

function TDocType.GetItem(Index : Integer) : TBaseDTDItem;
begin
   Result := TBaseDTDItem(FItems[Index]);
end;

function TDocType.ItemCount : Integer;
begin
   Result := FItems.Count;
end;

procedure TDocType.LoadFromFile(const AFileName : string; AnErrorReport : TStrings);
begin
   Self.FileName := AFileName;                             //  this has to go before the Parse because external entity file names might need it
   Parse(uWindowsInfo.FileText(AFileName), AnErrorReport);
end;

procedure TDocType.SaveToFile(const AFileName : string);
begin
   uWindowsInfo.WriteFile(AFileName, Self.Compose);
   Self.FileName := AFileName;
end;

{  TXMLElement }

constructor TXMLElement.Create(ACollection : TCollection);
begin
   inherited;
   FElementList := TXMLElementList.Create;
   FAttributeList := TStringList.Create;
   FAttributeList.CaseSensitive := True;
   FNamespaceID := NO_ID;
   FDefaultNamespaceID := NO_ID;
end;

procedure TXMLElement.AfterConstruction;
begin
   inherited;
   Clear;
end;

procedure TXMLElement.BeforeDestruction;
begin
   inherited;
   if (Collection <> nil) and (not XMLCollection.IsDestroying) then
   begin
       ParentElement := nil;                               //  remove from owner's list of Elements
       Self.DoElementDeleted(Self);
   end;
end;

destructor TXMLElement.Destroy;
begin
   Clear;
   FAttributeList.Free;
   FElementList.Free;
   FElementList := nil;
   FXLink.Free;
   FRawTexts.Free;
   inherited;
end;

procedure TXMLElement.Clear;
var
   Counter : Integer;
begin
   if (Collection <> nil) and (not XMLCollection.IsDestroying) then //  if it is, then it will Free all Elements
   begin
       for Counter := Self.ElementCount - 1 downto 0 do
           Elements[Counter].Free;
   end;
   FElementList.Clear;
   FAttributeList.Clear;
   FCurrentNextIndex := -1;
   FPreserveWhitespace := DEFAULT_PRESERVE_WHITESPACE;
   FRawText := EMPTY_STRING;

   inherited;
end;

function TXMLElement.IsEmpty : Boolean;
begin
   Result := (ElementCount = 0) and (AttributeCount = 0) and (RawText = EMPTY_STRING);
end;

function TXMLElement.XMLCollection : TXMLCollection;
begin
   Result := TXMLCollection(Self.Collection);
end;

function TXMLElement.AttributeCount : Integer;
begin
   Result := FAttributeList.Count;
end;

function TXMLElement.GetAttribute(AIndex : Integer) : AnsiString;
begin
   Result := FAttributeList.Strings[AIndex];
end;

function TXMLElement.GetAttributeValue(const AName : AnsiString) : AnsiString;
begin
   if AName = XPATH_TEXT_FUNCTION_NAME + '()' then
       Result := Self.RawText
   else
       Result := FAttributeList.Values[AName];
end;

function TXMLElement.GetAttributeName(Index : Integer) : AnsiString;
begin
   Result := FAttributeList.Names[Index];
end;

procedure TXMLElement.DeleteAttribute(AnIndex : Integer);
begin
   FAttributeList.Delete(AnIndex);
   Self.Changed(False);
end;

procedure TXMLElement.RemoveAttribute(const AnAttributeName : string);
var
   Index : Integer;
begin
   Index := FAttributeList.IndexOfName(AnAttributeName);
   if Index <> -1 then
       DeleteAttribute(Index);
end;

procedure TXMLElement.AddAttributeString(AnAttributeString : AnsiString);
var
   Index : Integer;
begin
   Index := AnsiPos('=', AnAttributeString);
   AttributeValues[Copy(AnAttributeString, 1, Index - 1)] :=
       StripDelimitingQuotes(Copy(AnAttributeString, Index + 1, MaxInt));
end;

function TXMLElement.GetAttributeIndexValue(Index : Integer) : AnsiString;
begin
   Result := FAttributeList.Values[AttributeNames[Index]];
end;

procedure TXMLElement.SetAttributeValue(const AName, AValue : AnsiString);
begin
   if AName = XPATH_TEXT_FUNCTION_NAME + '()' then
       Self.RawText := AValue
   else
   begin
       FAttributeList.Values[AName] := AValue;
       Self.Changed(False);
   end;
end;

function TXMLElement.AttributeExists(const AName : AnsiString) : Boolean;
begin
   Result := FAttributeList.IndexOfName(AName) <> -1;
end;

function TXMLElement.FindAttributeValue(const AName : AnsiString; var AValue : AnsiString) : Boolean;
var
   Index : Integer;
begin
   Index := FAttributeList.IndexOfName(AName);
   Result := Index <> -1;
   if Result then
       AValue := Copy(FAttributeList.Strings[Index], Length(AName) + 2, MaxInt);
end;

function TXMLElement.GetAttributeString(AnIndex : Integer) : AnsiString;
begin
   Result := FAttributeList.Names[AnIndex] + '=' +
       AddDelimitingQuotes(StrToCodes(FAttributeList.Values[FAttributeList.Names[AnIndex]]));
end;

procedure TXMLElement.SetParentElement(Value : TXMLElement);
var
   PrevParentElement : TXMLElement;
begin
   Assert(Value <> Self);
   if (ParentElement <> Value) then
   begin
       PrevParentElement := FParentElement;
       FParentElement := Value;

       if PrevParentElement <> nil then
           PrevParentElement.RemoveElement(Self)

       else if XMLCollection <> nil then
           XMLCollection.FRootElementList.Remove(Self);

       if Value <> nil then
       begin
           Value.AddElement(Self);                         //      calls Self.DoElementAdded, which calls Collection.DoElementAdded
           //                 propagate these values to child elements
           if Value.PreserveWhitespace or
               (Self.AttributeValues[PRESERVE_WHITESPACE_ATTRIBUTE_NAME] = PRESERVE_WHITESPACE_PRESERVE_TOKEN) then
           begin
               Self.PreserveWhitespace := True;
           end;

           if (Value.Language <> EMPTY_STRING) and (Self.Language = EMPTY_STRING) then
               Self.Language := Value.Language;
       end
       else if Collection <> nil then
           XMLCollection.FRootElementList.Add(Self);

       Self.Changed(False);
   end;
end;

function TXMLElement.OpenElement(AnElementName : AnsiString; const AttributePairs : array of AnsiString) : TXMLElement;
var
   Counter : Integer;
begin
   if FindElement(AnElementName, Result) then
   begin
       Counter := Low(AttributePairs);
       while Counter < High(AttributePairs) do
       begin
           Result.AttributeValues[AttributePairs[Counter]] := AttributePairs[Counter + 1];
           Inc(Counter, 2);
       end;
   end
   else
       Result := AddElement(AnElementName, AttributePairs);
end;

function TXMLElement.AddElement(AnElementClass : TXMLElementClass) : TXMLElement;
begin
   Result := AddElement;
   Result.ElementClass := AnElementClass;
end;

function TXMLElement.AddElement(AnElementName : AnsiString; const AttributePairs : array of AnsiString) : TXMLElement;
var
   Counter : Integer;
begin
   Result := AddElement(AnElementName);
   Counter := Low(AttributePairs);
   while Counter < High(AttributePairs) do
   begin
       Result.AttributeValues[AttributePairs[Counter]] := AttributePairs[Counter + 1];
       Inc(Counter, 2);
   end;
end;

function TXMLElement.OpenElement(AnElementName, AText : AnsiString) : TXMLElement;
begin
   if not FindElement(AnElementName, Result) then
       Result := AddElement(AnElementName, AText)

   else if AText <> '' then
       Result.Text := AText;
end;

function TXMLElement.AddComment(AText : AnsiString) : TXMLElement;
begin
   Result := AddElement;
   with Result do
   begin
       Text := AText;
       ElementClass := ecComment;
   end;
end;

function TXMLElement.AddElement(AnElementName : AnsiString; AText : AnsiString) : TXMLElement;
begin
   Result := XMLCollection.CreateElement(Self, AnElementName);
   Result.RawText := AText;
   Result.FDefaultNamespaceID := Self.DefaultNamespaceID;  //  attribute can change this
end;

procedure TXMLElement.FreeChildElements;
var
   Counter : Integer;
begin
   for Counter := Self.FElementList.Count - 1 downto 0 do
       TXMLElement(Self.FElementList[Counter]).Free;       //  this removes then from the ElementList
end;

procedure TXMLElement.AddElement(AnXMLElement : TXMLElement);
var
   FoundIndex : Integer;
begin
   if not FElementList.Find(AnXMLElement, FoundIndex) then
   begin
       FoundIndex := FElementList.Add(AnXMLElement);

       AnXMLElement.ParentElement := Self;                 //      optimization prevevnts run-away recursion

       if Self.ElementClass = ecUnknown then               //  if we thought we did not have sub-elements, we were wrong
           Self.ElementClass := ecElement;

       if AnXMLElement.ElementClass = ecMarkedSection then
           Self.AddText(AnXMLElement.Text, AnXMLElement);

       Self.DoElementAdded(AnXMLElement);

       Self.Changed(False);
   end;
end;

procedure TXMLElement.Assign(Source : TPersistent);
var
   ThisSource, ThisElement : TXMLElement;
begin
   if Source is TXMLElement then
   begin
       Self.Clear;                                         //  delete all children as well as properties and attributes

       ThisSource := TXMLElement(Source);
       Self.Name := ThisSource.Name;
       Self.FAttributeList.Assign(ThisSource.FAttributeList);
       Self.FRawText := ThisSource.RawText;
       Self.FPreserveWhitespace := ThisSource.PreserveWhitespace;
       Self.ElementClass := ThisSource.ElementClass;
       Self.Language := ThisSource.Language;
       Self.XLink.Assign(ThisSource.XLink);

       if ThisSource.FirstElement(ThisElement) then
       begin
           repeat
               Self.AddElement.Assign(ThisElement);        //  recursive through all generations: fills the ElementList
           until not ThisSource.NextElement(ThisElement);
       end;
   end

   else if Source is TStrings then
       Self.Parse(TStrings(Source).Text)

   else
       inherited Assign(Source);
end;

procedure TXMLElement.AssignTo(Target : TPersistent);
begin
   if Target is TStrings then
       Self.Compose(TStrings(Target))

   else
       inherited AssignTo(Target);
end;

procedure TXMLElement.RemoveElement(AnXMLElement : TXMLElement);
begin
   if (FElementList <> nil) and (FElementList.IndexOf(AnXMLElement) <> -1) then
   begin
       if AnXMLElement <> nil then
       begin
           FElementList.Remove(AnXMLElement);
           AnXMLElement.ParentElement := nil;
       end;

       if FRawTexts <> nil then
       begin
           Index := FRawTexts.IndexOfObject(AnXMLElement);
           if Index <> NOT_FOUND_INDEX then
               FRawTexts.Delete(Index);                    //      it's OnChange handler will Free and set it to nil if it is empty
       end;
   end;
end;

function TXMLElement.ElementCount : Integer;
begin
   Assert(FElementList <> nil);
   Result := FElementList.Count;
end;

function TXMLElement.DescendentCount : Integer;
var
   ThisElement : TXMLElement;
begin
   Result := Self.ElementCount;
   if FirstElement(ThisElement) then
   begin
       repeat
           Inc(Result, ThisElement.DescendentCount);       //  recursive
       until not NextElement(ThisElement);
   end;
end;

function TXMLElement.FindDescendentElement(const AnElementName : AnsiString; var AnElement : TXMLElement) : Boolean;
begin
   Result := False;
   if FirstElement(AnElement) then
   begin
       repeat
           if (AnElement.Name = AnElementName) or
               AnElement.FindDescendentElement(AnElementName, AnElement) then
           begin
               Result := True;
               Break;
           end;
       until not NextElement(AnElement);
   end;
end;

function TXMLElement.FindAllDescendentElements : IXMLElementList;
begin
   //   if Supports(TAutoXMLElementList.Create, IXMLElementList, Result) then
   Result := TAutoXMLElementList.Create;
   FindAllDescendentElements(Result);
   //   else
 //     raise Exception.Create('Interface not supported');
end;

function TXMLElement.FindAllDescendentElements(var AnElementList : TBaseXMLElementList) : Integer;
var
   ThisElementList : IXMLElementList;
begin
   if Supports(AnElementList, IXMLElementList, ThisElementList) then
       Result := FindAllDescendentElements(ThisElementList)
   else
       raise Exception.Create('Interface is not supported');
end;

function TXMLElement.FindAllDescendentElements(var AnElementList : IXMLElementList) : Integer;
var
   ThisElement : TXMLElement;
begin
   Result := 0;
   if ElementCount > 0 then
   begin
       if AnElementList = nil then
           AnElementList := TXMLElementList.Create;

       if FirstElement(ThisElement) then
       begin
           repeat
               AnElementList.Add(ThisElement);
               ThisElement.FindAllDescendentElements(AnElementList); //  recursive
           until not NextElement(ThisElement);
       end;
       Result := AnElementList.Count;
   end;
end;

function TXMLElement.GetElement(Index : Integer) : TXMLElement;
begin
   Assert(Index < ElementCount);
   Result := TXMLElement(FElementList[Index]);
end;

function TXMLElement.FindText(AText : AnsiString) : TXMLElement;
var
   Counter : Integer;
begin
   Result := nil;

   AText := uCraftClass.NormalizeWhitespace(AText);
   for Counter := 0 to Self.ElementCount - 1 do
   begin
       if Elements[Counter].NormalizedText = AText then
       begin
           Result := Elements[Counter];
           Break;
       end;
   end;
end;

function TXMLElement.FindText(const AText : AnsiString; var AnElement : TXMLElement) : Boolean;
begin
   AnElement := FindText(AText);
   Result := AnElement <> nil;
end;

function TXMLElement.FindElement(AnElementName : AnsiString) : TXMLElement;
begin
   with Self.FindXPath(AnElementName) do                   //  returns a IXMLElementList
   begin
       case Count of
           0 : Result := Self.AddElement(AnElementName);
           1 : Result := Elements[0];
       else
           raise EXPathMultipleMatchingElementError.Create('More than one element matches the XPath ' +
               Self.XPath + '/' + AnElementName);
       end;
   end;
end;

function TXMLElement.FindElement(AnElementName : AnsiString; var AnElement : TXMLElement) : Boolean;
begin
   AnElement := FindElement(AnElementName);
   Result := AnElement <> nil;
end;

function TXMLElement.ElementByName(const AnElementName : AnsiString) : TXMLElement;
begin
   Result := FindElement(AnElementName);
   if Result = nil then
       raise Exception.Create('Cannot find the "' + AnElementName + '" sub-element.');
end;

function TXMLElement.FindXPath(AnXPath : AnsiString) : IXMLElementList;
begin
   Result := TAutoXMLElementList.Create;
   XMLCollection.FindXPath(AnXPath, Self, Result);
end;

function TXMLElement.FindXPath(AnXPath : AnsiString; AList : TXMLElementList) : Boolean;
begin
   Result := XMLCollection.FindXPath(AnXPath, Self, AList);
end;

function TXMLElement.GetText : AnsiString;
var
   TextCounter : Integer;
begin
   if ElementClass = ecMarkedSection then
       Result := RawText
   else if ElementClass = ecElement then
   begin
       if FRawTexts = nil then
           Result := RawText
       else
       begin
           Result := EMPTY_STRING;
           for TextCounter := 0 to FRawTexts.Count - 1 do
               Result := Result + FRawTexts.Strings[TextCounter]; //  no delimiters, no separators
       end;
   end;
   if not PreserveWhitespace then
       Result := Trim(Result);                             //      {TODO: this seems wrong: I thought Preserve Strings was only for Attribute values }
end;

procedure TXMLElement.RawTextsChange(Sender : TObject);
begin
   with (Sender as TStrings) do
   begin
       if (Count = 0) or ((Count = 1) and (Objects[0] = nil)) then //  not a CDATA reference
       begin
           if Count = 1 then
               FRawText := Strings[0];

           FRawTexts.Free;
           FRawTexts := nil;
       end;
   end;
end;

procedure TXMLElement.SetText(const Value : AnsiString);
begin
   AddText(Value);
   if (Self.ElementClass = ecMarkedSection) and (ParentElement <> nil) then
       ParentElement.UpdateText(Self);
end;

procedure TXMLElement.AddText(Value : AnsiString; AnElement : TXMLElement);
begin
   //                 2.11 End-of-Line Handling : ...translating both the two-character sequence #xD #xA and any #xD that is not followed by #xA to a single #xA character.
   Value := StringReplace(Value, #13#10, #10, [rfReplaceAll]);
   Value := StringReplace(Value, #13, #10, [rfReplaceAll]);

   if (FRawTexts = nil) and (AnElement = nil) then
       RawText := RawText + Value
   else
   begin
       if FRawTexts = nil then
       begin
           FRawTexts := TCraftingStringList.Create;
           FRawTexts.OnChange := RawTextsChange;
           if RawText <> EMPTY_STRING then
               FRawTexts.Add(RawText);
       end;
       FRawTexts.AddObject(Value, AnElement);
   end;
end;

procedure TXMLElement.UpdateText(AnElement : TXMLElement);
var
   Index : Integer;
begin
   if FRawTexts = nil then
       {TODO: this gets called when FRawTexts  }
    ///   raise EXMLError.Create('Cannot update element text because element was not registered')
   else
   begin
       Index := FRawTexts.IndexOfObject(AnElement);
       if Index <> NOT_FOUND_INDEX then
           raise EXMLError.Create('Cannot update element text because element was not found');

       FRawTexts.Strings[Index] := AnElement.Text;
   end;
end;

function TXMLElement.FindValue(const AName : AnsiString) : AnsiString;
begin
   Result := EMPTY_STRING;
   FindValue(AName, Result);
end;

function TXMLElement.FindValue(const AName : AnsiString; var AValue : AnsiString) : Boolean;
var
   ThisElement : TXMLElement;
begin
   Result := False;
   if FindElement(AName, ThisElement) then
   begin
       AValue := ThisElement.Text;
       Result := True;
   end
   else if AttributeExists(AName) then
   begin
       AValue := AttributeValues[AName];
       Result := True;
   end;
end;

function TXMLElement.ElementName : AnsiString;              //  deprecated
begin
   Result := Self.Name;
end;

function TXMLElement.GetElementName : AnsiString;
begin
   if FElementName = EMPTY_STRING then
   begin
       case ElementClass of
           ecComment : Result := '{comment}';
           ecElement : Result := '{element}';
           ecMarkedSection : Result := '{CDATA}';
           ecProcessInstructions : Result := '{?}';
       else
           Result := '{unknown type}'
       end;
   end
   else
       Result := FElementName;
end;

function TXMLElement.GetXPath : AnsiString;
begin
   case ElementClass of
       ecElement :
           begin
               if ParentElement = nil then
                   Result := '/' + Self.ElementName
               else
                   Result := ParentElement.XPath + '/' + Self.ElementName;
           end;
   else
       (*
                 ecComment : Result := '';
                 ecEmpty : Result := '{empty}';
                 ecMarkedSection : Result := '{CDATA}';
                 ecProcessInstructions : Result := '{?}';
       *)
       raise Exception.Create('Unable to create an unambiguous X-Path');
   end;
end;

function TXMLElement.AddNamespace(const ANamespacePrefix, ANamespace : string) : Integer;
begin
   if FindDefinedNamespacePrefix(ANamespacePrefix) <> NOT_FOUND_INDEX then
       raise EXMLDuplicateNamespacePrefixError.Create('Namespace prefix ' + ANamespacePrefix + ' is already defined for this element');

   Result := XMLCollection.AddNamespace(ANamespacePrefix, ANamespace);
   AddDefinedNamespaceID(Result);
end;

function TXMLElement.AddDefinedNamespaceID(AnID : Integer) : Integer;
begin
   Result := Length(FDefinedNamespaceIDs);
   SetLength(FDefinedNamespaceIDs, Result + 1);
   FDefinedNamespaceIDs[Result] := AnID;
end;

function TXMLElement.FindDefinedNamespacePrefix(const ANamespacePrefix : string) : Integer;
var
   Counter : Integer;
begin
   Result := NOT_FOUND_INDEX;
   for Counter := 0 to Length(FDefinedNamespaceIDs) - 1 do
   begin
       if XMLCollection.NamespacePrefixByID(FDefinedNamespaceIDs[Counter]) = ANamespacePrefix then
       begin
           Result := Counter;
           Break;
       end;
   end;
end;

function TXMLElement.FindDefinedNamespacePrefix(const ANamespacePrefix : string; var Index : Integer) : Boolean;
begin
   Index := FindDefinedNamespacePrefix(ANamespacePrefix);
   Result := (Index <> NOT_FOUND_INDEX);
end;

function TXMLElement.GetNamespaceURI : AnsiString;
begin
   if Self.NamespaceID <> NO_ID then
       Result := XMLCollection.NamespacePrefixByID(Self.NamespaceID)

   else if Self.DefaultNamespaceID <> NO_ID then
       Result := XMLCollection.NamespacePrefixByID(Self.DefaultNamespaceID)
   else
       Result := EMPTY_STRING;
end;

function TXMLElement.GetNamespacePrefix : AnsiString;
begin
   if Self.NamespaceID <> NO_ID then
       Result := XMLCollection.NamespacePrefixByID(Self.DefaultNamespaceID)
   else
       Result := EMPTY_STRING;
end;

function TXMLElement.GetBase : string;
begin
   if (FBase = '') and (ParentElement <> nil) then
       Result := ParentElement.Base
   else
       Result := FBase;
end;

procedure TXMLElement.SetNameSpacePrefix(const Value : AnsiString);
begin
   FNamespaceID := NO_ID;
   if Value <> EMPTY_STRING then
   begin
       if not FindScopedNamespacePrefix(Value, FNamespaceID) then
           raise Exception.Create('Cannot find the namespace prefix "' + Value + '" in scope');
   end;
end;

function TXMLElement.FindScopedNamespacePrefix(const ANamespacePrefix : string) : Integer;
var
   Counter : Integer;
begin
   for Counter := 0 to Length(FDefinedNamespaceIDs) - 1 do
   begin
       if XMLCollection.NamespacePrefixByID(FDefinedNamespaceIDs[Counter]) = ANamespacePrefix then
       begin
           Result := FDefinedNamespaceIDs[Counter];
           Exit;
       end;
   end;

   if Self.ParentElement <> nil then
       Result := Self.ParentElement.FindScopedNamespacePrefix(ANamespacePrefix) //  sort of recursive
   else
       Result := NO_ID;
end;

function TXMLElement.FindScopedNamespacePrefix(const ANamespacePrefix : string; APrefixID : Integer) : Boolean;
begin
   APrefixID := FindScopedNamespacePrefix(ANamespacePrefix);
   Result := APrefixID <> NO_ID;
end;

function TXMLElement.FindScopedNamespace(const ANamespace : string) : string;
var
   Counter : Integer;
begin
   for Counter := 0 to Length(FDefinedNamespaceIDs) - 1 do
   begin
       if XMLCollection.NamespaceByID(FDefinedNamespaceIDs[Counter]) = ANamespace then
       begin
           Result := XMLCollection.NamespacePrefixByID(FDefinedNamespaceIDs[Counter]);
           Exit;
       end;
   end;

   if Self.ParentElement <> nil then
       Result := Self.ParentElement.FindScopedNamespace(ANamespace) //  sort of recursive
   else
       Result := EMPTY_STRING;
end;

function TXMLElement.FindScopedNamespace(const ANamespace : string; var ANamespacePrefix : string) : Boolean;
begin
   ANamespacePrefix := FindScopedNamespace(ANamespace);
   Result := ANamespacePrefix <> EMPTY_STRING;
end;

function TXMLElement.GetExpandedName : AnsiString;
begin
   Result := Self.Name;
   if NamespaceURI <> EMPTY_STRING then
       Result := NamespaceURI + ':' + Result;
end;

function TXMLElement.SameName(AnElementName : string) : Boolean;
var
   OtherNamespacePrefix : string;
begin
   OtherNamespacePrefix := StripIf(AnElementName, ':');

   //     we want to use Collection.Namespaces[Self.NamespacePrefix] instead of Self.NamespaceURI because we don't want to use the default namespace
   Result := (XMLCollection.Namespaces[OtherNamespacePrefix] = XMLCollection.Namespaces[Self.NamespacePrefix]) and
       (AnElementName = Self.ElementName);
end;

function TXMLElement.GetDTDElement : TDTDElement;
begin
   if FDTDElement = nil then
       FDTDElement := XMLCollection.DocType.Elements.Find(Self.Name);
   Result := FDTDElement;
end;

procedure TXMLElement.SetElementClass(Value : TXMLElementClass);
begin
   if Value <> FElementClass then
   begin
       FElementClass := Value;
       if (Value = ecElement) and (ParentElement = nil) then
           XMLCollection.SetRootElement(Self);
   end;
end;

function TXMLElement.Compose(StartingIndent : Integer; StartingLineNumber : Integer) : AnsiString;
var
   ResultStrings : TStringList;
begin
   ResultStrings := TStringList.Create;
   try
       Compose(ResultStrings, StartingIndent, StartingLineNumber);
       Result := ResultStrings.Text
   finally
       ResultStrings.Free
   end;
end;

procedure TXMLElement.Compose(ResultStrings : TStrings; RecursionLevel : Integer; StartingLineNumber : Integer);
begin
   Compose(TObject(ResultStrings), RecursionLevel, StartingLineNumber);
end;

procedure TXMLElement.Compose(ResultStream : TStream; RecursionLevel : Integer; StartingLineNumber : Integer);
begin
   Compose(TObject(ResultStream), RecursionLevel, StartingLineNumber);
end;

procedure TXMLElement.Compose(ResultObject : TObject; RecursionLevel : Integer; StartingLineNumber : Integer);

   procedure AddLine(ALine : AnsiString);
   begin
       if (Collection <> nil) then
           XMLCollection.InsertTabSpaces(ALine, RecursionLevel);

       if ResultObject is TStrings then
           TStrings(ResultObject).AddObject(ALine, TObject(RecursionLevel))

       else if ResultObject is TStream then
       begin
           ALine := ALine + XML_END_LINE;
           TStream(ResultObject).Write(PAnsiChar(ALine)^, Length(ALine));
       end;
   end;

var
   ThisLine : AnsiString;
   Counter : Integer;
begin
   Self.LineNumber := StartingLineNumber;

   case ElementClass of
       ecComment : AddLine(START_COMMENT_TOKEN + RawText + END_COMMENT_TOKEN);
       ecElement :
           begin
               Assert(ElementName <> '{comment}');
               ThisLine := START_TOKEN + ElementName;
               for Counter := 0 to AttributeCount - 1 do
                   ThisLine := ThisLine + ' ' + GetAttributeString(Counter);

               if IsXLink then
                   ThisLine := ThisLine + ' ' + XLink.Compose;

               if (ElementCount = 0) and (RawText = EMPTY_STRING) then
                   AddLine(ThisLine + END_EMPTY_TOKEN)
               else
               begin
                   ThisLine := ThisLine + END_TOKEN + StrToCodes(RawText);
                   if ElementCount = 0 then
                       AddLine(ThisLine + START_CLOSE_TOKEN + ElementName + END_TOKEN)
                   else
                   begin
                       AddLine(ThisLine);
                       for Counter := 0 to Self.ElementCount - 1 do
                           Elements[Counter].Compose(ResultObject, RecursionLevel + 1, StartingLineNumber + 1);
                       AddLine(START_CLOSE_TOKEN + ElementName + END_TOKEN);
                   end;
               end;
           end;

       ecMarkedSection : AddLine(START_MARKED_SECTION_TOKEN + RawText + END_MARKED_SECTION_TOKEN);
       //  ElementName = PI Target
       ecProcessInstructions : AddLine(START_PROCESS_TOKEN + ElementName + ' ' + RawText + END_PROCESS_TOKEN);
   end;
end;

procedure TXMLElement.Parse(AText : AnsiString);
var
   ThisTag, ThisName, ThisValue, ElementNamespacePrefix, ThisNamespacePrefix : AnsiString;
begin
   Self.Clear;

   case ElementClass of
       ecMarkedSection : RawText := AText;
       ecComment : RawText := AText;
       ecProcessInstructions, ecElement :
           begin
               StripToDelimiter(AText, ThisTag, True);
               ThisName := Trim(ThisTag);                  //  first word is the name
               ElementNamespacePrefix := StripIf(ThisName, ':'); //      the refernce might depend on an attribute; don't set Self.NamespacePrefix until after parsing the attributes
               Self.Name := XMLCollection.DocType.ReplaceEntities(ThisName);

               ////////////////////////////       parse attributes    //////////////////////////////////////
               while StripToDelimiter(AText, ['='], ThisName) <> EMPTY_STRING do
               begin
                   ThisName := Trim(CodesToStr(ThisName));
                   AText := Trim(AText);

                   ThisValue := StripTo(AText, EMPTY_STRING, [soIgnoreQuotedText]); //      strip to next whitespace ignoring
                   if Pos('<', ThisValue) > 0 then
                       raise EXMLWellFormedError.Create('Well-formedness constraint: No < in Attribute Values');
                   ThisValue := XMLCollection.DocType.ReplaceEntities(ThisValue);
                   ThisValue := TrimTokens(ThisValue);     //  TrimTokens defaults to trimming quotes

                   {
                   Four types of data:
                   Actual characters
                   Whitespace characters
                   Encoded characters (character references)
                   Entity references
                   }

                   if XMLCollection.AutoValidate and (Self.DTDElement <> nil) and (Self.DTDElement <> nil) then
                   begin
                       if Self.DTDElement.AttributeByName(ThisName).AttributeType <> atCData then
                           ThisValue := uCraftClass.NormalizeWhitespace(Trim(ThisValue))
                       else
                           ThisValue := ReplaceStrings(ThisValue, [#13, #10, #9], ' ');
                   end
                   else
                       ThisValue := ReplaceStrings(ThisValue, [#13, #10, #9], ' ');

                   ThisValue := CodesToStr(ThisValue);     //  replace &#n; character references, but only after whitespace normalization

                   ///////////////////     store any namespace reference   ///////////////////////

                   if ThisName = NAMESPACE_DEFINITION_ATTRIBUTE_NAME then
                       Self.FDefaultNamespaceID := XMLCollection.OpenDefaultNamespaceID(ThisValue)

                   else if Copy(ThisName, 1, Length(NAMESPACE_DEFINITION_PREFIX)) = NAMESPACE_DEFINITION_PREFIX then
                   begin
                       ThisNamespacePrefix := Copy(ThisName, Length(NAMESPACE_DEFINITION_PREFIX) + 1, MaxInt);
                       XMLCollection.AddNamespace(ThisNamespacePrefix, ThisValue);
                   end

                   else if ThisName = BASE_DEFINITION_ATTRIBUTE_NAME then
                       Self.Base := ThisValue

                   else if ThisName = PRESERVE_WHITESPACE_ATTRIBUTE_NAME then
                   begin
                       if ThisValue = PRESERVE_WHITESPACE_PRESERVE_TOKEN then
                           Self.PreserveWhitespace := True
                       else if ThisValue = PRESERVE_WHITESPACE_DEFAULT_TOKEN then
                           Self.PreserveWhitespace := False
                       else
                       begin
                           raise EXMLInvalidSystemAttributeValueError.Create('Invalid system attribute value for ' +
                               PRESERVE_WHITESPACE_ATTRIBUTE_NAME + ': "' + ThisValue + '"');
                       end;
                   end;

                   ThisNamespacePrefix := Self.FindScopedNamespace(XLINK_NAMESPACE_URI); //  e.g. "xlink"
                   if (ThisNamespacePrefix <> EMPTY_STRING) and //  if the URI is not referenced, then we know we have no xlink attributes
                   uCraftClass.SameShortestText(ThisName, ThisNamespacePrefix + ':') then
                   begin
                       if ThisName = ThisNamespacePrefix + ':type' then
                           XLink.LinkType := StrToXLinkType(ThisValue)
                       else if ThisName = ThisNamespacePrefix + ':href' then
                           XLink.HRef := ThisValue
                       else if ThisName = ThisNamespacePrefix + ':role' then
                           XLink.Role := ThisValue
                       else if ThisName = ThisNamespacePrefix + ':arcrole' then
                           XLink.ArcRole := ThisValue
                       else if ThisName = ThisNamespacePrefix + ':title' then
                           XLink.Title := ThisValue
                       else if ThisName = ThisNamespacePrefix + ':show' then
                           XLink.Show := StrToXLinkShow(ThisValue)
                       else if ThisName = ThisNamespacePrefix + ':actuate' then
                           XLink.Actuate := StrToXLinkActuate(ThisValue)
                       else if ThisName = ThisNamespacePrefix + ':label' then
                           XLink.LinkLabel := ThisValue
                       else if ThisName = ThisNamespacePrefix + ':label' then
                           XLink.LinkLabel := ThisValue
                       else if ThisName = ThisNamespacePrefix + ':from' then
                           XLink.LinkFrom := ThisValue
                       else if ThisName = ThisNamespacePrefix + ':to' then
                           XLink.LinkTo := ThisValue
                       else
                           AttributeValues[ThisName] := ThisValue;
                   end
                   else
                   begin
                       ThisNamespacePrefix := Self.FindScopedNamespace(XINCLUDE_NAMESPACE_URI); //  e.g. "xi"
                       //  if the URI is not referenced, then we know we have no xlink attributes
                       if (ThisNamespacePrefix <> EMPTY_STRING) and
                           uCraftClass.SameShortestText(ThisName, ThisNamespacePrefix + ':') then
                       begin
                           raise Exception.Create('Name space prefix not yet implemented.');
                       end
                       else
                           AttributeValues[ThisName] := ThisValue;
                   end;
               end;

               Self.NamespacePrefix := ElementNamespacePrefix; //      the refernce might depend on an attribute
           end;
   end;

   if XMLCollection.AutoValidate then
       AddDefaultAttributes;

   Self.PreserveWhitespace := (AttributeValues[PRESERVE_WHITESPACE_ATTRIBUTE_NAME] = PRESERVE_WHITESPACE_PRESERVE_TOKEN);
   Self.Language := AttributeValues[LANGUAGE_ATTRIBUTE_NAME];
end;

procedure TXMLElement.AddDefaultAttributes;
var
   Counter : Integer;
   ThisName : string;
begin
   if Self.DTDElement <> nil then
   begin
       for Counter := 0 to DTDElement.AttributeCount - 1 do
       begin
           ThisName := DTDElement.Attributes[Counter].Name;

           if (DTDElement.Attributes[Counter].DefaultType in [dtFixed, dtLiteral]) and
               (not Self.AttributeExists(ThisName)) and
               (DTDElement.Attributes[Counter].DefaultValue <> EMPTY_STRING) then //  find all the possible attributes with default values that are not already present
           begin
               Self.AttributeValues[ThisName] := DTDElement.Attributes[Counter].DefaultValue;
           end;
       end;
   end;
end;

procedure TXMLElement.DoElementAdded(AnElement : TXMLElement);
begin
   XMLCollection.DoElementAdded(AnElement);
end;

procedure TXMLElement.DoElementDeleted(AnElement : TXMLElement);
begin
   XMLCollection.DoElementDeleted(AnElement);
end;

function TXMLElement.NextSibling : TXMLElement;
var
   Index : Integer;
begin
   Result := nil;
   Index := ParentElement.FElementList.IndexOf(Self);
   if Index < ParentElement.ElementCount - 1 then
       Result := ParentElement.Elements[Index + 1];
end;

function TXMLElement.PrevSibling : TXMLElement;
var
   Index : Integer;
begin
   Result := nil;
   Index := ParentElement.FElementList.IndexOf(Self);
   if Index > 0 then
       Result := ParentElement.Elements[Index - 1];
end;

function TXMLElement.Clone : TXMLElement;
begin
   Result := Self.Create(nil);
   AssignTo(Result);
end;

function TXMLElement.FirstElement(AnElementClasses : TXMLElementClasses; var AnElement : TXMLElement) : Boolean;
begin
   FCurrentNextIndex := -1;
   Result := NextElement(AnElementClasses, AnElement);
end;

function TXMLElement.FirstElement(const AnElementName : string; var AnElement : TXMLElement) : Boolean;
begin
   FCurrentNextIndex := -1;
   Result := NextElement(AnElementName, AnElement);
end;

function TXMLElement.FirstElement(var AnElement : TXMLElement) : Boolean;
begin
   FCurrentNextIndex := -1;
   Result := NextElement(AnElement);
end;

function TXMLElement.NextElement(AnElementClasses : TXMLElementClasses; var AnElement : TXMLElement) : Boolean;
begin
   Result := False;

   while NextElement(AnElement) do
   begin
       if AnElement.ElementClass in AnElementClasses then
       begin
           Result := True;
           Break;
       end;
   end;
end;

function TXMLElement.NextElement(const AnElementName : string; var AnElement : TXMLElement) : Boolean;
begin
   Result := False;

   while NextElement(AnElement) do
   begin
       if AnElement.ElementName = AnElementName then
       begin
           Result := True;
           Break;
       end;
   end;
end;

function TXMLElement.NextElement(var AnElement : TXMLElement) : Boolean;
begin
   Result := (FCurrentNextIndex < (Self.ElementCount - 1));
   if Result then
   begin
       Inc(FCurrentNextIndex);
       AnElement := Elements[FCurrentNextIndex];
   end
   else
       FCurrentNextIndex := -1;                            //  reset for next time
end;

function TXMLElement.GetXLink : TXLink;
begin
   if FXLink = nil then
       FXLink := TXLink.Create(Self);
   Result := FXLink;
end;

function TXMLElement.IsXLink : Boolean;
begin
   Result := False;
   if FXLink <> nil then
   begin
       if FXLink.LinkType <> ltUnknown then
           Result := True;
   end;
end;

function TXMLElement.GetNormalizedText : AnsiString;
begin
   Result := uCraftClass.NormalizeWhitespace(Self.Text);
end;

{  EXMLError    }

constructor EXMLError.Create(AMessage : AnsiString; ACharacterOffset : Integer; AnElementIndex : Integer);
begin
   Create(AMessage);
   CharacterOffset := ACharacterOffset;
   ElementIndex := AnElementIndex;
end;

function EXMLError.Location : string;
begin
   Result := EMPTY_STRING;
   if ElementIndex <> 0 then
       Result := Result + ' Element ' + IntToStr(ElementIndex);

   if ElementName <> EMPTY_STRING then
   begin
       if ElementIndex <> 0 then
           Result := Result + ' (' + ElementName + ')'
       else
           Result := Result + ' Element ' + ElementName;
   end;

   if CharacterOffset <> 0 then
       Result := Result + ' offset ' + IntToStr(CharacterOffset);
end;

{  TXMLCollection  }

constructor TXMLCollection.Create;
begin
   Create(TXMLElement);
end;

constructor TXMLCollection.CreateFrom(XMLString : AnsiString);
begin
   Create;
   Parse(XMLString);
end;

constructor TXMLCollection.Create(ItemClass : TCollectionItemClass);
begin
   inherited Create(ItemClass);
   FTabStopList := TList.Create;
   FRootElementList := TXMLElementList.Create;
   TabStops := '4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64'; //  let the mutator work
   FReadBufferSize := DEFAULT_READ_BUFFER_SIZE;
   FCurrentNextIndex := -1;
   FElementLists := TList.Create;

   Default;
end;

destructor TXMLCollection.Destroy;
begin
   FExternalEntityFileNames.Free;
   FDestroying := True;
   FTabStopList.Free;
   FElementStack.Free;
   FRootElementList.Free;
   LockingFileStream.Free;
   FIDCrossIndex.Free;
   FNamespaces.Free;
   FDocType.Free;
   while FElementLists.Count > 0 do
       TBaseXMLElementList(FElementLists.Last).Free;       //  this will remove itself from the list

   FElementLists.Free;

   inherited;                                              //  all the elements are members of this Collection
end;

procedure TXMLCollection.Clear;
begin
   BeginUpdate;
   inherited;                                              //  TCollection clears all its members

   ClearData;
   FFileName := EMPTY_STRING;
   EndUpdate;
end;

procedure TXMLCollection.ClearData;
begin
   inherited;
   FRootElement := nil;
   if FDocType <> nil then
       DocType.Clear;

   FCurrentNextIndex := -1;
end;

procedure TXMLCollection.Default;
begin
   Self.ClearData;

   FRequiredMarkupDeclaration := rmdAll;
   FEncoding := 'UTF-8';
   FByteOrder := boUTF8;
   FXMLVersion := '1.0';
   FValidating := True;
   FIncludeDTD := True;
end;

procedure TXMLCollection.Change;
begin
   if Assigned(FOnChange) then
       FOnChange(Self);
end;

procedure TXMLCollection.SetTabStops(Value : AnsiString);
var
   ThisTab : AnsiString;
begin
   if TabStops <> Value then
   begin
       FTabStops := Value;

       FTabStopList.Clear;
       while Value <> EMPTY_STRING do
       begin
           ThisTab := uCraftClass.StripTo(Value, [' ', #9, #13, #10, ',', ';'], [soTrimExtraDelimiters]);
           FTabStopList.Add(Pointer(StrToIntDef(Trim(ThisTab), 0)));
       end;
   end;
end;

procedure TXMLCollection.DoElementDeleted(AnElement : TXMLElement);
begin
   if Assigned(FOnDeleteElement) then
       FOnDeleteElement(Self, AnElement);

   if RootElement = AnElement then
       FRootElement := nil;

   FRootElementList.Remove(AnElement);

   if FIDCrossIndex <> nil then
       FIDCrossIndex.Remove(AnElement);
end;

procedure TXMLCollection.DoElementAdded(AnElement : TXMLElement);
begin
   if Assigned(FOnAddElement) then
       FOnAddElement(Self, AnElement);
end;

function TXMLCollection.OpenElement(AnElementName : AnsiString; const AttributePairs : array of AnsiString) : TXMLElement;
var
   Counter : Integer;
begin
   if FindElement(AnElementName, Result) then
   begin
       for Counter := Result.AttributeCount - 1 downto 0 do
           Result.DeleteAttribute(Counter);

       Counter := Low(AttributePairs);
       while Counter < High(AttributePairs) do
       begin
           Result.AttributeValues[AttributePairs[Counter]] := AttributePairs[Counter + 1];
           Inc(Counter, 2);
       end;
   end
   else
       Result := AddElement(AnElementName, AttributePairs);
end;

function TXMLCollection.GetRootElement : TXMLElement;
begin
   if FRootElement = nil then
       FRootElement := Self.AddElement;

   Result := FRootElement;
end;

procedure TXMLCollection.SetRootElement(AnElement : TXMLElement);
begin
   if FRootElement <> AnElement then
   begin
       if FRootElement = nil then
           FRootElement := AnElement

       else if FRootElement.IsEmpty then
       begin
           FRootElement.Free;
           FRootElement := AnElement;
       end
       else if (AnElement <> FRootElement) then
       begin
           raise EXMLRootElementAlreadyExistsError.Create('The root element (' + FRootElement.Name +
               ') already exists! You cannot make ' + AnElement.Name + ' the root as well');
       end;
   end;
end;

function TXMLCollection.AddElement(AnElementName : AnsiString; const AttributePairs : array of AnsiString) : TXMLElement;
var
   Counter : Integer;
begin
   Result := AddElement(AnElementName);                    //	this sets the RootElement

   Counter := Low(AttributePairs);
   while Counter < High(AttributePairs) do
   begin
       Result.AttributeValues[AttributePairs[Counter]] := AttributePairs[Counter + 1];
       Inc(Counter, 2);
   end;
end;

function TXMLCollection.OpenElement(AnElementName, AText : AnsiString) : TXMLElement;
begin
   if FindElement(AnElementName, Result) then
   begin
       if AText <> EMPTY_STRING then
           Result.Text := AText;
   end
   else
       Result := AddElement(AnElementName, AText);
end;

function TXMLCollection.AddElement(AnElementClass : TXMLElementClass) : TXMLElement;
begin
   Result := AddElement;
   Result.ElementClass := AnElementClass;
end;

function TXMLCollection.AddElement(AnElementName : AnsiString; AText : AnsiString) : TXMLElement;
begin
   Result := CreateElement(nil, AnElementName);            //  CreateElemement calls DoAddElement
   Result.RawText := AText;
end;

function TXMLCollection.CreateElement(AnElementName : AnsiString) : TXMLElement;
begin
   Result := CreateElement(nil, AnElementName);
end;

function TXMLCollection.CreateElement(AParentElement : TXMLElement; AnElementName : AnsiString) : TXMLElement;

   procedure ApplyPredicateToElement(AnElement : TXMLElement; APredicate : string);
   var
       ThisAttribute, ThisAttributeName, ThisAttributeValue : string;
   begin
       while APredicate <> EMPTY_STRING do
       begin
           ThisAttribute := StripNextPredicate(APredicate);
           while ThisAttribute <> EMPTY_STRING do
           begin
               ThisAttributeName := StripTo(ThisAttribute, '='); //  initialization value is embedded in the XPath
               if Copy(ThisAttributeName, 1, 1) = '@' then
               begin
                   System.Delete(ThisAttributeName, 1, 1);
                   ThisAttributeValue := TrimTokens(Trim(StripTo(ThisAttribute, ' and '))); //  From "Other" to Other

                   AnElement.AttributeValues[ThisAttributeName] := ThisAttributeValue; //  SetAttributeValues will convert CodesToStr
               end
               else
                   StripTo(ThisAttribute, ' and ');
           end;
       end;
   end;

var
   ThisStep, LastStep, StrippedStep, StepPredicate : string;
   StepList : TCraftingStringList;
   StepCounter : Integer;
   IsElementCreated : Boolean;
begin
   if not IsXPath(AnElementName) then                      //  if there is no path information, but it still might have a single predicate
   begin
       ThisStep := AnElementName;
       StepPredicate := StripStepPredicate(ThisStep);

       Result := TXMLElement(inherited Add);               //  root element
       Result.Name := ThisStep;
   end
   else
   begin
       StepList := TCraftingStringList.Create;
       try
           ThisStep := AnElementName;
           LastStep := StripLastStep(ThisStep);
           IsElementCreated := False;

           BreakApartXPath(ThisStep, StepList);            //  each slot is a generation

           {TODO: what about a single-step "/Root" ?}

           StepCounter := 0;                               //  we need the value after the loop is done: no "for"
           while StepCounter < StepList.Count do           //   make sure all the ancestors are present
           begin
               ThisStep := StepList.Strings[StepCounter];
               StrippedStep := ThisStep;
               StepPredicate := StripStepPredicate(StrippedStep);
               if StrippedStep = '//' then
               begin
                   Inc(StepCounter);

                   if StepCounter = StepList.Count then
                   begin
                       ThisStep := LastStep;
                       IsElementCreated := True;
                   end
                   else
                       ThisStep := StepList.Strings[StepCounter];

                   StrippedStep := ThisStep;
                   StepPredicate := StripStepPredicate(StrippedStep);

                   if not FindXPath('//' + ThisStep, nil, AParentElement) then
                   begin
                       AParentElement := nil;              //  default to making it THE root element
                       DoAddingADecendentAxisElement(ThisStep, AParentElement); //  let the user's event set the parent

                       if AParentElement <> nil then
                       begin
                           if not FindXPath(ThisStep, AParentElement, AParentElement) then
                               AParentElement := CreateElement(AParentElement, ThisStep); //  recursive; create ancestors
                       end
                       else
                           AParentElement := CreateElement(AParentElement, ThisStep); //  recursive; create ancestors
                   end;
               end
               else if (Copy(ThisStep, 1, 1) = '.') then
               begin
                   if AParentElement = nil then
                       raise EMalformedXPathError.Create('".[]" found without a "self" to reference');

                   ApplyPredicateToElement(AParentElement, StepPredicate); //     update the parent: //Fred/.[A="1"]/@Boo
               end

               else if FindXPath(ThisStep, AParentElement, Result) then
                   AParentElement := Result

               else
                   AParentElement := CreateElement(AParentElement, ThisStep); //  recursive; create ancestors

               Inc(StepCounter);
           end;

           StepPredicate := StripStepPredicate(LastStep);  //  e.g.  @Style
       finally
           StepList.Free;
       end;

       if (not IsElementCreated) and (LastStep <> '.') then
           Result := CreateElement(AParentElement, LastStep + StepPredicate) //  recurseive, but this call is not IsXpath(); create the element without any attribute
       else
       begin
           if AParentElement = nil then
               raise EMalformedXPathError.Create('".[]" found without a parent to reference');

           Result := AParentElement;                       //  we have created it above in the // section
           AParentElement := Result.ParentElement;
       end;
   end;

   ApplyPredicateToElement(Result, StepPredicate);
   //                 only ' and ' works in creation attribute expressions: ' or ' and ' not(' are non-sensical

   if AParentElement <> nil then
   begin
       if Result.ParentElement <> AParentElement then
           Result.ParentElement := AParentElement          //  calls ParentElement.AddElement, which calls ParentElement.DoElementAdded, which calls Collection.DoElementAdded
   end
   else
   begin
       FRootElementList.Add(Result);
       Self.DoElementAdded(Result);
   end;

   if Result.Name <> EMPTY_STRING then
       Result.ElementClass := ecElement;                   // a must for a top-level element with no sub-elements

   Change;
end;

procedure TXMLCollection.DoAddingADecendentAxisElement(const AnXPath : string; var AParentElement : TXMLElement);
begin
   if Assigned(FOnAddingADecendentAxisElement) then
       FOnAddingADecendentAxisElement(Self, AnXPath, AParentElement);
end;

function TXMLCollection.NewComment(AText : AnsiString) : TXMLElement;
begin
   Result := AddElement;
   Result.ElementClass := ecComment;
   Result.Text := AText;
end;

function TXMLCollection.GetElement(AIndex : Integer) : TXMLElement;
begin
   Result := TXMLElement(inherited Items[AIndex]);
end;

procedure TXMLCollection.AddElementID(AnElement : TXMLElement; const AnID : string);
begin
   if FIDCrossIndex = nil then
   begin
       FIDCrossIndex := TXMLElementList.Create;
       FIDCrossIndex.Sorted := True;
       FIDCrossIndex.CaseSensitive := True;
       FIDCrossIndex.Duplicates := dupError;               //  ID's must be unique
   end;
   FIDCrossIndex.AddObject(AnID, AnElement);
end;

function TXMLCollection.FindElementByID(const AnID : string) : TXMLElement;
begin
   if not FindElementByID(AnID, Result) then
       Result := nil;
end;

function TXMLCollection.FindElementByID(const AnID : string; var AnElement : TXMLElement) : Boolean;
begin
   Result := False;
   if FIDCrossIndex <> nil then
       Result := FIDCrossIndex.Find(AnID, AnElement)
end;

function TXMLCollection.FindElementsByIDs(SomeIDs : string; var AnElementList : TXMLElementList) : Boolean;
var
   ThisElement : TXMLElement;
begin
   Result := False;

   if AnElementList = nil then
       AnElementList := TXMLElementList.Create;

   while SomeIDs <> EMPTY_STRING do
   begin
       if FindElementByID(Trim(StripTo(SomeIDs)), ThisElement) then
       begin
           Result := True;
           AnElementList.Add(ThisElement);
       end;
   end;
end;

function TXMLCollection.FindElementByAttribute(const NameValuePairs : array of string) : TXMLElement;
begin
   if not FindElementByAttribute(NameValuePairs, Result) then
       Result := nil;
end;

function TXMLCollection.FindElementByAttribute(const NameValuePairs : array of string; var AnElement : TXMLElement) : Boolean;
var
   Counter : Integer;
begin
   Result := False;
   if FirstElement(AnElement) then
   begin
       repeat
           Result := True;
           Counter := 0;
           while Counter < High(NameValuePairs) do
           begin
               if (not AnElement.AttributeExists(NameValuePairs[Counter])) or
                   (AnElement.AttributeValues[NameValuePairs[Counter]] <> NameValuePairs[Counter + 1]) then
               begin
                   Result := False;
                   Break;
               end;
               Inc(Counter, 2);
           end;
           if Result then                                  //  all attributes match
               Break;
       until not NextElement(AnElement);
   end;
end;

function TXMLCollection.FindElement(AnElementName : AnsiString) : TXMLElement;
var
   Counter : Integer;
   ThisNamespace : string;
   ThisList : IXMLElementList;
begin
   Result := nil;

   if IsXPath(AnElementName) then
   begin
       ThisList := FindXPath(AnElementName);
       if ThisList.Count > 0 then
           Result := ThisList.Elements[0];
   end
   else
   begin
       ThisNamespace := uCraftClass.StripIf(AnElementName, ':');
       for Counter := 0 to Self.ElementCount - 1 do
       begin
           if (Elements[Counter].ElementName = AnElementName) and
               ((ThisNamespace = EMPTY_STRING) or (Namespaces[ThisNamespace] = Elements[Counter].NamespaceURI)) then
           begin
               Result := Elements[Counter];
               Break;
           end;
       end;
   end;
end;

function TXMLCollection.TestStep(AnElement : TXMLElement; AStep : string) : Boolean;
begin
   Result := False;

   if AnElement <> nil then
   begin
       case ExtractChar(AStep, 1) of
           '@' :
               if AnElement.AttributeExists(SubString(AStep, -1)) then
                   Result := True;

           '*', 'n', '.' :
               if (AStep = '*') or (AStep = 'node()') or (AStep = '.') then
               begin
                   Result := True;
                   Exit;
               end;
       end;

       if AnElement.Name = AStep then
           Result := True;
   end;
end;

{
Predicates are:
==============
an element name                                                    [fred]
an element index number                                            [2]
an element name and text value                                     [fred="this is the time"]
an attribute name                                                  [@barney]
an attribute name and a value                                      [@barney="lead"]
a function resolving to an element's position IN THE AXIS          [last()]; [last()>3]
position() returns the numeric position of the element in its parent's set     [position() = 4]
count(<element set>) returns the number of elements in the element set         [count(.//annotations)>2]; [count(id('am i here')) !=0]

they can filter in series:                                         [@betty="here"][@wilma="there"]
or have multiple criteria in a single axis                         [(@betty="here") and @wilma = "there"]

they can reference other attributes from other elements            PLANET[/PLANETS/@UNITS = @REFERENCE]
they can test equivelancies to other nodes                         /root/data[not(. < /root/data)]
}

function TXMLCollection.TestPredicate(AnElement : TXMLElement; const APredicate : string; AnAxis : TXMLElementList) : Boolean;

   procedure PerformMathimaticalOperation(var Target : Integer; Source : Integer; ThisOperator : string);
   begin
       if ThisOperator <> '' then
       begin
           case ThisOperator[1] of
               '+' : Inc(Target, Source);
               '-' : Dec(Target, Source);
               '*' : Target := Target * Source;
           else
               if ThisOperator = 'div' then
                   Target := Target div Source
               else if ThisOperator = 'mod' then
                   Target := Target mod Source;
           end;
       end;
   end;

var
   ThisElementList : IXMLElementList;
   ThisElement : TXMLElement;
   ThisElementName, ThisPredicate, ThisDelimiter, PrevDelimiter, ThisPiece, ThatPiece, TheseDigits : string;
   ThisIndex, ThisNumber : Integer;
   IsFound : Boolean;
begin
   Result := False;
   ThisPredicate := Trim(TrimTokens(APredicate, ['[', ']']));

   ThisElementList := TAutoXMLElementList.Create;

   while ThisPredicate <> EMPTY_STRING do
   begin
       ThisPredicate := Trim(TrimTokens(Trim(ThisPredicate), ['(', ')']));

       ThisPiece := StripIf(ThisPredicate, ['not('], ThisDelimiter);
       if ThisDelimiter <> '' then
       begin
           ThatPiece := StripTo(ThisPredicate, ')');
           Result := TestPredicate(AnElement, ThisPiece, AnAxis) and
               (not TestPredicate(AnElement, ThatPiece, AnAxis)) and
               TestPredicate(AnElement, ThisPredicate, AnAxis); //  recursive
           Exit;
       end;

       ThisPiece := StripIf(ThisPredicate, [' and ', ' or '], ThisDelimiter, [soIgnoreQuotedText]);
       if (ThisDelimiter = ' or ') then
       begin
           Result := TestPredicate(AnElement, ThisPiece, AnAxis) or TestPredicate(AnElement, ThisPredicate, AnAxis);
           Exit;
       end
       else if (ThisDelimiter = ' and ') then
       begin
           Result := TestPredicate(AnElement, ThisPiece, AnAxis) and TestPredicate(AnElement, ThisPredicate, AnAxis);
           Exit;
       end;

       ThisPiece := StripTo(ThisPredicate, ['[', ']', '@', '[@', 'attribute::'], ThisDelimiter);

       //                                     an attribute or attribute value
       if (ThisDelimiter = '@') or (ThisDelimiter = '[@') or (ThisDelimiter = 'attribute::') then
       begin
           ThisPiece := Trim(StripTo(ThisPredicate, ['=', ']', ' or ', ' and '], ThisDelimiter));
           if (ThisDelimiter = ']') then
           begin
               if AnElement.AttributeExists(ThisPiece) then
                   Result := True;
           end

           else if ThisDelimiter = '=' then
           begin
               if AnElement.AttributeValues[ThisPiece] = StripQuotedText(ThisPredicate) then //  TrimTokens defaults to trimming quotes
                   Result := True;
           end
       end
       else                                                //  the predicate expression might be a whole new XPath expression
       begin
           ThisPiece := ReplaceString(ThisPiece, XPATH_POSITION_FUNCTION + '()=', EMPTY_STRING);

           ThisPiece := ReplaceString(ThisPiece, XPATH_LAST_FUNCTION + '()', IntToStr(AnAxis.Count));

           ThisNumber := StrToIntDef(ThisPiece, MaxInt);
           if ThisNumber <> MaxInt then                    //  the entire piece is numeric
               Result := ThisNumber = AnAxis.IndexOf(AnElement) + 1 //  indexes are one-based, not zero-based

           else if (ThisPiece + ' ')[1] in NUMERIC_CHARS then //  assume it is an index operation
           begin
               ThisIndex := 0;
               PrevDelimiter := '+';
               repeat
                   TheseDigits := Trim(StripTo(ThisPiece, ['+', '-', '*', '/'], ThisDelimiter));
                   ThisNumber := StrToIntDef(TheseDigits, 0);
                   PerformMathimaticalOperation(ThisIndex, ThisNumber, Copy(PrevDelimiter, 1, 1));
                   PrevDelimiter := ThisDelimiter;
               until ThisPiece = EMPTY_STRING;
               PerformMathimaticalOperation(ThisIndex, ThisNumber, Copy(PrevDelimiter, 1, 1));

               if (AnAxis.DocOrderIndexOf(AnElement) <> ThisIndex) then
                   Exit;                                   //  return False
           end

           else                                            //  element reference
           begin
               ThisElementName := StripTo(ThisPiece, '=');
               FindXPath(ThisElementName, AnElement, ThisElementList);
               if ThisElementList.Count = 0 then
                   Exit;                                   //  return False

               if ThisPiece <> EMPTY_STRING then           //  test the text value of the element
               begin
                   IsFound := False;
                   ThisElementList.First(ThisElement);
                   repeat
                       if ThisElement.Text = ThisPiece then
                       begin
                           IsFound := True;
                           Break;
                       end;
                   until not ThisElementList.Next(ThisElement);
                   if not IsFound then
                       Exit;                               //  return False
               end;
           end;
       end;
   end;
end;

function StrToStepAxis(const AString : string) : TStepAxis;
begin
   Result := Low(TStepAxis);
   repeat
       if STEP_AXIS_NAMES[Result] = AString then
           Exit;
       Inc(Result);
   until Result > High(TStepAxis);

   raise Exception.Create('Unknown X-Path step axis name "' + AString + '"');
end;

function StepAxisToStr(AnAxis : TStepAxis) : string;
begin
   Result := STEP_AXIS_NAMES[AnAxis];
end;

function TXMLCollection.XPathAttribute(AnXPath : AnsiString) : AnsiString;
var
   LastStep : string;
   ThisElement : TXMLElement;
begin
   Result := '';

   LastStep := StripLastStep(AnXPath);

   if ExtractChar(LastStep) <> '@' then
       raise EMalformedXPathError.Create('The last step must be an attribute name.');

   if FindXPath(AnXPath, ThisElement) then
       Result := ThisElement.AttributeValues[Copy(LastStep, 2, MaxInt)];
end;

function TXMLCollection.FindXPath(AnXPath : AnsiString; AContextElement : TXMLElement; var AnElement : TXMLElement) : Boolean;
var
   ThisList : IXMLElementList;
   FullXPath : string;
begin
   Result := False;
   if Self.Count > 0 then                                  //    optimize for empty trees
   begin
       ThisList := TAutoXMLElementList.Create;
       if FindXPath(AnXPath, AContextElement, ThisList) then
       begin
           if ThisList.Count > 1 then
           begin
               if AContextElement <> nil then
                   FullXPath := AContextElement.XPath + '/' + AnXPath
               else
                   FullXPath := AnXPath;
//Julia - Do you really want to comment this out???
              // raise EXPathMultipleMatchingElementError.Create('More than one element matches the XPath ' + FullXPath);
           end;

           AnElement := ThisList.Elements[0];
           Result := True;
       end;
   end;
end;

function TXMLCollection.FindXPath(AnXPath : AnsiString; var AString : string) : Boolean;
var
   ThisElementList : TXMLElementList;
   ThisAttributeName : string;
   ThisList : TCraftingStringList;
begin
   ThisList := TCraftingStringList.Create;
   try
       if BreakApartXPath(AnXPath, ThisList) > 0 then
       begin
           if Copy(ThisList.Last, 1, 1) = '@' then
           begin
               ThisAttributeName := CopyTo(Copy(ThisList.Last, 2, MaxInt), '['); //  predicates inside attribute selection? possible.. (we don't support it)
               ThisList.Delete(ThisList.Count - 1);
               AnXPath := StickTogether(ThisList, '/');
           end
           else
               ThisAttributeName := EMPTY_STRING;
       end;
   finally
       ThisList.Free;
   end;

   ThisElementList := TXMLElementList.Create;
   try
       Result := FindXPath(AnXPath, ThisElementList);
       if Result then
       begin
           if ThisAttributeName = EMPTY_STRING then
               AString := ThisElementList[0].Text
           else
               AString := ThisElementList[0].AttributeValues[ThisAttributeName];
       end;
   finally
       ThisElementList.Free;
   end;
end;

function TXMLCollection.FindXPath(AnXPath : AnsiString; var AnElementList : TXMLElementList) : Boolean;
var
   ThisElementList : IXMLElementList;
begin
   if Supports(AnElementList, IXMLElementList, ThisElementList) then
       Result := FindXPath(AnXPath, nil, ThisElementList)
   else
       raise Exception.Create('Interface is not supported.');
end;

function TXMLCollection.FindXPath(AnXPath : AnsiString; var AnElementList : IXMLElementList) : Boolean;
begin
   Result := FindXPath(AnXPath, nil, AnElementList);
end;

function TXMLCollection.FindXPath(AnXPath : AnsiString; var AnElement : TXMLElement) : Boolean;
var
   ThisList : TXMLElementList;
begin
   ThisList := TXMLElementList.Create;
   try
       Result := FindXPath(AnXPath, ThisList);
       if Result then
       begin
           if ThisList.Count > 1 then
               raise EXPathMultipleMatchingElementError.Create('More than one element matches the XPath ' + AnXPath);
           AnElement := ThisList.Elements[0];
       end;
   finally
       ThisList.Free;
   end;
end;

function TXMLCollection.FindXPath(AnXPath : AnsiString) : IXMLElementList;
begin
   Result := TAutoXMLElementList.Create;
   FindXPath(AnXPath, Result);
end;

function TXMLCollection.FindXPath(AnXPath : AnsiString;
   AContextElement : TXMLElement; AnElementList : TBaseXMLElementList) : Boolean;
var
   ThisElementList : IXMLElementList;
begin
   if Supports(AnElementList, IXMLElementList, ThisElementList) then
       Result := FindXPath(AnXPath, AContextElement, ThisElementList)
   else
       raise Exception.Create('Interface is not supported.');
end;

function TXMLCollection.FindXPath(AnXPath : AnsiString;
   AContextElement : TXMLElement; AnElementList : IXMLElementList) : Boolean;
begin
   Result := FindXStep(AnXPath, AContextElement, AnElementList);
end;

//     Called with the leading delimiter: / or //

function TXMLCollection.FindXStep(AnXPath : AnsiString;
   AContextElement : TXMLElement; AnElementList : TXMLElementList) : Boolean;
var
   ThisElementList : IXMLElementList;
begin
   if Supports(AnElementList, IXMLElementList, ThisElementList) then
       Result := FindXStep(AnXPath, AContextElement, ThisElementList)
   else
       raise Exception.Create('IXMLElementList interface is not supported by "' + AnElementList.ClassName + '".');
end;

function TXMLCollection.FindXStep(AnXPath : AnsiString;
   AContextElement : TXMLElement; AnElementList : IXMLElementList) : Boolean;
var
   NextStep, ThisStep, AxisName : string;
   StepPredicate, ThisPredicate : string;
   ThisAxis : TStepAxis;
   Counter : Integer;
   ThisElementList : TXMLElementList;
   IsRootReference : Boolean;
begin
   Result := False;

   if not Self.IsEmpty then
   begin
       IsRootReference := (Copy(AnXPath, 1, 1) = '/') and (Copy(AnXPath, 2, 1) <> '/');
       NextStep := AnXPath;
       ThisStep := StripNextStep(NextStep);
       StepPredicate := StripStepPredicate(ThisStep);

       ///////////////////////////////////////////////////////////////////////////////////
       ///////////    Expand abbreviations        ////////////////////////////////////////
       ///////////////////////////////////////////////////////////////////////////////////

       ThisAxis := saUnknown;

       if ThisStep = '//' then
       begin
           ThisAxis := saDescendantOrSelf;
           if (NextStep = '') or (ThisPredicate <> '') then
               ThisStep := 'node()'
           else
           begin
               ThisStep := StripNextStep(NextStep);
               StepPredicate := StripNextPredicate(ThisStep);
           end;
       end;

       //             translate the shortcut axis names: @, ., and .. as well as the id() function
       case ExtractChar(ThisStep, 1) of
           '@' :
               begin
                   ThisAxis := saAttribute;
                   System.Delete(ThisStep, 1, 1);
               end;

           '.' :
               if ThisStep = '..' then
               begin
                   ThisAxis := saParent;
                   ThisStep := 'node()';
               end
               else if ThisStep = '.' then
               begin
                   ThisAxis := saSelf;
                   ThisStep := 'node()';
               end
               else
                   raise Exception.Create('An XPath step "' + ThisStep + '" has leading periods, which is illegal.');

           'i' :
               if Copy(ThisStep, 1, Length(XPATH_ID_FUNCTION_NAME) + 1) = XPATH_ID_FUNCTION_NAME + '(' then
               begin
                   ThisStep := StripTo(ThisStep, ')');
                   Assert(ThisStep = EMPTY_STRING);
                   AContextElement := FindElementByID(ThisStep);
                   if AContextElement = nil then
                       Exit;                               //  return False
                   ThisAxis := saSelf;
                   ThisStep := 'node()';
               end;
       end;

       //////////////////////////////////////////////////////////////////////////////////////
       //////     Figure out the axis for this step       ///////////////////////////////////

       if ThisAxis = saUnknown then
       begin
           AxisName := StripIf(ThisStep, '::');
           if AxisName <> EMPTY_STRING then
               ThisAxis := StrToStepAxis(AxisName)
           else
               ThisAxis := saChild;                        //  the expected default
       end;

       //////////////////////////////////////////////////////////////////////////////////////
       //////     Load the entire axis before testing     ///////////////////////////////////

       if IsRootReference or (AContextElement = nil) then
       begin
           case ThisAxis of                                //      the Axis root is above the RootElement, so we have to test the RootElement too
               saChild : ThisAxis := saChildOrSelf;
               saDescendant : ThisAxis := saDescendantOrSelf;
           end;

           if AContextElement = nil then
               AContextElement := Self.RootElement;
       end;

       ThisElementList := TXMLElementList.Create;
       try
           LoadElementListFromAxis(AContextElement, ThisStep, ThisAxis, ThisElementList);

           //////////////////////////////////////////////////////////////////////////////////////
           //////     Test each element against the predicate    ////////////////////////////////
           //////////////////////////////////////////////////////////////////////////////////////

           while StepPredicate <> EMPTY_STRING do          //  [_Type="Other"][3]  => we have to filter the first before we can test ordinality
           begin
               ThisPredicate := StripNextPredicate(StepPredicate);

               for Counter := ThisElementList.Count - 1 downto 0 do
               begin
                   if not TestPredicate(ThisElementList.Elements[Counter], ThisPredicate, ThisElementList) then
                       ThisElementList.Delete(Counter);
               end;
           end;

           ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           //////     Recursively check each surviving element's children (most likely) against the rest of the XPath ////////
           ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

           if NextStep <> EMPTY_STRING then
           begin
               for Counter := 0 to ThisElementList.Count - 1 do
               begin
                   if FindXStep(NextStep, ThisElementList.Elements[Counter], AnElementList) then //  recursive
                       Result := True;                     //  if any leaf node returns True, then we have found at least one match
               end;
           end
           else                                            //  ThisStep was the last step
           begin
               if AnElementList <> nil then
                   AnElementList.Add(ThisElementList);     //  only fill the final list at the end leaf

               Result := ThisElementList.Count > 0;
           end;
       finally
           ThisElementList.Free;
       end;
   end;
end;

function TXMLCollection.GetElementListFromAxis(AContextElement : TXMLElement;
   AStep : string; AnAxis : TStepAxis) : IXMLElementList;
begin
   Result := TAutoXMLElementList.Create;
   LoadElementListFromAxis(AContextElement, AStep, AnAxis, Result);
end;

procedure TXMLCollection.LoadElementListFromAxis(AContextElement : TXMLElement;
   AStep : string; AnAxis : TStepAxis; var AnElementList : TXMLElementList);
var
   ThisElementList : IXMLElementList;
begin
   if Supports(AnElementList, IXMLElementList, ThisElementList) then
       LoadElementListFromAxis(AContextElement, AStep, AnAxis, ThisElementList)
   else
       raise Exception.Create('Interface is not supported');
end;

procedure TXMLCollection.LoadElementListFromAxis(AContextElement : TXMLElement;
   AStep : string; AnAxis : TStepAxis; var AnElementList : IXMLElementList);

   procedure CheckAndAddToResult(AnElement : TXMLElement);
   begin
       if AnElementList = nil then
           AnElementList := TXMLElementList.Create;

       if AnAxis = saAttribute then
       begin
           if AnElement.AttributeExists(AStep) then
               AnElementList.Add(AnElement);
       end
       else if TestStep(AnElement, AStep) then
           AnElementList.Add(AnElement);
   end;

var
   ThisElement : TXMLElement;
   Counter : Integer;

begin
   //////////////////////////////////////////////////////////////////////////////////////
   /////////////////////      test the Context Element     //////////////////////////////
   //////////////////////////////////////////////////////////////////////////////////////

   if AnAxis in [saSelf, saChildOrSelf, saDescendantOrSelf, saAncestorOrSelf] then
       CheckAndAddToResult(AContextElement);               //        this is Self

   //////////////////////////////////////////////////////////////////////////////////////
   /////////////////////      continue on the (non self) axis   /////////////////////////
   //////////////////////////////////////////////////////////////////////////////////////

   case AnAxis of
       saChild, saChildOrSelf, saDescendantOrSelf, saDescendant :
           begin
               if AContextElement.FirstElement(ThisElement) then
               begin
                   repeat
                       CheckAndAddToResult(ThisElement);

                       if AnAxis in [saDescendantOrSelf, saDescendant] then
                           LoadElementListFromAxis(ThisElement, AStep, saDescendant, AnElementList); //  recursive

                   until not AContextElement.NextElement(ThisElement);
               end;
           end;

       saParent, saParentOrSelf :
           CheckAndAddToResult(AContextElement.ParentElement);

       saAncestorOrSelf, saAncestor :
           begin
               while AContextElement.ParentElement <> nil do
               begin
                   CheckAndAddToResult(AContextElement.ParentElement);
                   AContextElement := AContextElement.ParentElement;
               end;
           end;

       saFollowing : raise Exception.Create('"saFollowing" is not yet implemented.');

       saPreceding : raise Exception.Create('"saPreceding" is not yet implemented.');

       saFollowingSibling :
           if AContextElement.ParentElement <> nil then
           begin
               for Counter := AContextElement.Index to AContextElement.ParentElement.ElementCount - 1 do
                   CheckAndAddToResult(AContextElement.ParentElement.Elements[Counter]);
           end;

       saPrecedingSibling :
           if AContextElement.ParentElement <> nil then
           begin
               for Counter := AContextElement.Index - 1 downto 0 do
                   CheckAndAddToResult(AContextElement.ParentElement.Elements[Counter]);
           end;

       saAttribute :                                       //  this is not criteria; this is membership
           CheckAndAddToResult(AContextElement);
   end;
end;

function TXMLCollection.FindElement(AnElementName : AnsiString; var AnElement : TXMLElement) : Boolean;
begin
   AnElement := FindElement(AnElementName);
   Result := AnElement <> nil;
end;

procedure TXMLCollection.Assign(Source : TPersistent);
begin
   if Source is TStrings then
       Self.Parse(TStrings(Source))

   else if Source is TXMLElement then
   begin
       Self.Clear;                                         //  RootElement will = nil
       AddElement.Assign(Source);                          //  copy all child elements too
   end
   else if Source is TXMLCollection then
   begin
       with TXMLCollection(Source) do
       begin
           Self.Clear;
           Self.DocType.Assign(DocType);
           Self.Encoding := Encoding;
           Self.XMLVersion := XMLVersion;
           Self.IsStandAlone := IsStandAlone;
           Self.ByteOrder := ByteOrder;
           Self.FNamespaces.Assign(FNamespaces);

           Self.RootElement.Assign(RootElement);           //  recursively copy all children
       end;
   end
   else
       inherited Assign(Source);
end;

procedure TXMLCollection.AssignTo(Target : TPersistent);
var
   OwningTreeNodes : TTreeNodes;

   procedure LoadTreeBranch(BaseNode : TTreeNode; BaseXMLElement : TXMLElement);
   var
       Counter : Integer;
       NewNode : TTreeNode;
   begin
       NewNode := OwningTreeNodes.AddChildObject(BaseNode, BaseXMLElement.ElementName, BaseXMLElement);
       for Counter := 0 to BaseXMLElement.ElementCount - 1 do
           LoadTreeBranch(NewNode, BaseXMLElement.Elements[Counter]); //  recursive
   end;

var
   Counter : Integer;
begin
   if Target is TStrings then
       Self.Compose(TStrings(Target))

   else if Target is TCustomTreeView then
   begin
       OwningTreeNodes := TTreeView(Target).Items;
       with OwningTreeNodes do
       begin
           BeginUpdate;
           try
               Clear;
               { TODO : load DTD with validation element branches. use + or | to show Sequence and Or groups }
               for Counter := 0 to Self.Count - 1 do
               begin
                   if Self.Elements[Counter].ParentElement = nil then
                   begin
                       LoadTreeBranch(nil, Self.Elements[Counter]);
                       Exit;
                   end;
               end
           finally
               EndUpdate;
           end;
       end;
   end
   else
       inherited AssignTo(Target);
end;

procedure TXMLCollection.ParseDTD(AString : AnsiString; AnErrorReport : TStrings);
begin
   ParseDTD(AString, '', AnErrorReport);
end;

procedure TXMLCollection.ParseDTD(AString : AnsiString; EntityBase : string; AnErrorReport : TStrings);
begin
   DocType.ParseDTD(AString, AnErrorReport, EntityBase);
end;

function TXMLCollection.Parse(AStrings : TStrings; AnErrorReport : TStrings) : Boolean;
begin
   Result := Parse(AStrings.Text);
end;

function TXMLCollection.Parse(AString : AnsiString; AnErrorReport : TStrings) : Boolean;
var
   ThisStream : TStringStream;
begin
   ThisStream := TStringStream.Create(AString);
   try
       Result := Parse(ThisStream, AnErrorReport)
   finally
       ThisStream.Free;
   end;
end;

function TXMLCollection.LoadFromFile(const AFileName : AnsiString; AnErrorReport : TStrings; LeaveLocked : Boolean) : Boolean;
begin
   LockingFileStream.Free;
   LockingFileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
   try
       FFileName := AFileName;
       Result := Parse(LockingFileStream);
   finally
       if not LeaveLocked then
       begin
           LockingFileStream.Free;
           LockingFileStream := nil;
       end;
   end;
end;

function TXMLCollection.Parse(AStream : TStream; AnErrorReport : TStrings) : Boolean;
var
   StartingErrorReportCount : Integer;
begin
   if AnErrorReport <> nil then
       StartingErrorReportCount := AnErrorReport.Count
   else
       StartingErrorReportCount := 0;                      //  quiet the compiler

   InternalReadStream := AStream;
   InternalParse(AnErrorReport);
   InternalReadStream := nil;
   Change;

   if (AnErrorReport <> nil) then
       Result := (StartingErrorReportCount = AnErrorReport.Count)
   else
       Result := True;
end;

function TXMLCollection.DoInternalReadStream(var Buffer : AnsiString; AReadCount : Integer = 0) : Boolean;
var
   NewText : AnsiString;
   ThisCountRead : Integer;
begin
   if (Self.InternalReadStream <> nil) and
       (Self.InternalReadStream.Position < Self.InternalReadStream.Size) then
   begin
       if AReadCount = 0 then
           AReadCount := Self.ReadBufferSize;
       SetLength(NewText, AReadCount);

       ThisCountRead := InternalReadStream.Read(PAnsiChar(NewText)^, AReadCount);

       SetLength(NewText, ThisCountRead);

       Buffer := Buffer + NewText;
       Result := (ThisCountRead < AReadCount);
   end
   else
       Result := True;
end;

class function TXMLCollection.FindByteOrder(FirstFourBytes : string) : TByteOrder;
type
   TCheckBytes = array[0..3] of Byte;
   PCheckBytes = ^TCheckBytes;

   function CompareBytes(Array1, Array2 : array of Byte) : Boolean;
   var
       MinLength, Counter : Integer;
   begin
       if High(Array1) > High(Array2) then
           MinLength := High(Array2)
       else
           MinLength := High(Array1);

       for Counter := 0 to MinLength do
       begin
           if Array1[Counter] <> Array2[Counter] then
           begin
               Result := False;
               Exit;
           end;
       end;
       Result := True;
   end;

var
   CheckBytes : PCheckBytes;
begin
   CheckBytes := Pointer(FirstFourBytes);
   if CompareBytes(CheckBytes^, BYTE_ORDER_UTF8) then
       Result := boUTF8

   else if CompareBytes(CheckBytes^, BYTE_ORDER_UTF16_LE) or CompareBytes(CheckBytes^, BYTE_ORDER_UTF16_BE) then
       Result := boUTF16UCS2

   else if CompareBytes(CheckBytes^, BYTE_ORDER_UCS4_LE) or CompareBytes(CheckBytes^, BYTE_ORDER_UCS4_BE) then
       Result := boUCS4

   else if CompareBytes(CheckBytes^, BYTE_ORDER_EBCDIC) then
       Result := boEBCDIC
   else
       Result := boUnknown;
end;

procedure TXMLCollection.InternalParse(AnErrorReport : TStrings);
var
   Buffer, ThisLine : AnsiString;
   EndOfRead : Boolean;                                    //  allow system to wait for input
   ByteOrderName : string;
begin
   Self.Default;
   Buffer := EMPTY_STRING;
   FCharCount := 0;
   try
       {   catch exceptions    }
       ResetReadStream;
       //  signal that we are starting
       if DoInternalReadStream(ThisLine, 4) then
           raise EXMLFormatError.Create('Cannot read four bytes for Byte Order Mark');

       ByteOrder := FindByteOrder(ThisLine);
       ByteOrderName := TypInfo.GetEnumName(TypeInfo(TByteOrder), Integer(ByteOrder));

       case ByteOrder of
           boUTF8 : ;
           boUTF16UCS2, boUCS4, boEBCDIC :
               raise EXMLUnsupportedByteOrderError.Create(Self.ClassName + ' does not support ' + ByteOrderName + ' byte order');
           boUnknown :
               if Copy(ThisLine, 1, 4) = START_COMMENT_TOKEN then
                   raise EXMLFormatError.Create('Comments cannot come before the XML file header')
               else
                   raise EXMLFormatError.Create('Cannot find the expected byte order in the first ' +
                       'four (4) bytes of the data: "' + Copy(ThisLine, 1, 4) + '"');
       else
           raise EXMLUnsupportedByteOrderError.Create('Cannot find the expected byte order in ' +
               'the first four (4) bytes of the data ' + ByteOrderName + ' byte order');
       end;

       ResetReadStream;
       EndOfRead := DoInternalReadStream(Buffer);
       Inc(FCharCount, Length(Buffer));

       ReadXML(EndOfRead, Buffer, AnErrorReport);

       if ElementStack.Top <> nil then
       begin
           if ElementStack.Count = 1 then
               raise EXMLWellFormedError.Create('Unbalanced element upon end of processing: ' + ElementStack.Strings[0])
           else
               raise EXMLWellFormedError.Create('Unbalanced elements upon end of processing: ' + ElementStack.SeparatedNames(',', False));
       end;
   except
       on E : EXMLWellFormedError do
       begin
           if E.CharacterOffset = 0 then
               E.CharacterOffset := CharCount;
           if E.ElementIndex = 0 then
               E.ElementIndex := ElementCount;             //      this is how many elements we have created so far

           if AnErrorReport <> nil then
               AnErrorReport.Add(E.Message + E.Location)
           else
               raise;
       end;

       on E : Exception do
       begin
           E.Message := E.Message + ' at element ' + IntToStr(ElementCount) + ' at offset ' + IntToStr(CharCount);
           if FileName <> EMPTY_STRING then
               E.Message := E.Message + ' in ' + FileName;

           if AnErrorReport <> nil then
               AnErrorReport.Add(E.Message)
           else
               raise;
       end;
   end;
end;

procedure TXMLCollection.ResetReadStream;
begin
   if InternalReadStream <> nil then
       InternalReadStream.Position := 0;
end;

function TXMLCollection.ElementStack : TXMLElementList;
begin
   if FElementStack = nil then
       FElementStack := TXMLElementList.Create;

   Result := FElementStack;
end;

////////////////////////       Namespaces      ////////////////////////////////////////////////////

function TXMLCollection.GetNamespaceList : TStrings;
begin
   if FNamespaces = nil then
   begin
       FNamespaces := TCraftingStringList.Create;
       FNamespaces.Sorted := True;
       FNamespaces.CaseSensitive := True;
       FNamespaces.Add('xml=' + NAMESPACE_XML_URI, 0);
       FNamespaces.Add('xmlns=' + NAMESPACE_XMLNS_URI, 1);
   end;
   Result := FNamespaces;
end;

function TXMLCollection.AddNamespace(const ANamespacePrefix, AURI : string) : Integer;
begin
   if (FNamespaces <> nil) and FNamespaces.Find(ANamespacePrefix + '=' + AURI, Result) then
       Result := FNamespaces.Integers[Result]
   else
   begin
       Result := NamespaceList.Count;                      //  the list is sorted so the value is just a unique ID
       FNamespaces.Add(ANamespacePrefix + '=' + AURI, Result);
   end;
end;

function TXMLCollection.GetNamespace(const ANamespacePrefix : string) : AnsiString;
begin
   if FNamespaces <> nil then
       Result := FNamespaces.Values[ANamespacePrefix]
   else
       Result := EMPTY_STRING;
end;

procedure TXMLCollection.SetNamespace(const ANamespacePrefix : string; AValue : AnsiString);
begin
   NamespaceList.Values[ANamespacePrefix] := AValue;
end;

function TXMLCollection.OpenDefaultNamespaceID(const ANamespace : string) : Integer;
var
   Index : Integer;
begin
   if (FNamespaces = nil) or (not FNamespaces.FindValue(ANamespace, Index)) then
       Result := AddNamespace('<default>', ANamespace)
   else
       Result := FNamespaces.Integers[Index];
end;

function TXMLCollection.FindNamespacePrefix(const ANamespacePrefix : string) : Integer;
var
   Index : Integer;
begin
   if (FNamespaces = nil) or (not FNamespaces.FindName(ANamespacePrefix, Index)) then
       Result := NO_ID
   else
       Result := FNamespaces.Integers[Index];
end;

function TXMLCollection.NamespacePrefixByID(AnID : Integer) : string;
var
   Index : Integer;
begin
   if (FNamespaces = nil) or (not FNamespaces.Find(AnID, Index)) then
       Result := EMPTY_STRING
   else
       Result := FNamespaces.Names[Index];
end;

function TXMLCollection.FindNamespace(const ANamespaceURI : string) : string;
var
   Index : Integer;
begin
   if (FNamespaces = nil) or (not FNamespaces.FindValue(ANamespaceURI, Index)) then
       Result := EMPTY_STRING
   else
       Result := FNamespaces.Names[Index];
end;

function TXMLCollection.NamespaceByID(AnID : Integer) : string;
var
   Index : Integer;
begin
   if (FNamespaces = nil) or (not FNamespaces.Find(AnID, Index)) then
       raise Exception.Create('Namespace ID# ' + IntToStr(AnID) + ' not found')
   else
       Result := FNamespaces.ValueStrings[Index];
end;

function TXMLCollection.FindNamespace(const ANamespaceURI : string; var ANamespacePrefix : string) : Boolean;
var
   Index : Integer;
begin
   Result := FNamespaces.FindValue(ANamespaceURI, Index);
   if Result then
       ANamespacePrefix := FNamespaces.Names[Index];
end;

function TXMLCollection.FindNamespace(const ANamespaceURI : string; var AnID : Integer) : Boolean;
begin
   Result := FNamespaces.FindValue(ANamespaceURI, AnID);
   if Result then
       AnID := Integer(FNamespaces.Objects[AnID]);
end;

/////////////////////////////////////////////////////////////////////

procedure TXMLCollection.ReadXML(EndOfRead : Boolean; var Buffer : AnsiString; AnErrorReport : TStrings);
var
   ThisNewElement : TXMLElement;
   StartDelim, EndDelim, ThisAttribute, ThisContent : AnsiString;
   ThisTag : AnsiString;
begin
   while (not EndOfRead) or (TrimLeft(Buffer) <> EMPTY_STRING) do
   begin
       if (not EndOfRead) and (Length(Buffer) < MIN_WORKING_BUFFER_LENGTH) then
       begin
           Dec(FCharCount, Length(Buffer));
           EndOfRead := DoInternalReadStream(Buffer);
           Inc(FCharCount, Length(Buffer));
       end;

       try
           StartDelim := StripToDelimiter(Buffer,
               [START_DOCTYPE_TOKEN, START_XML_TOKEN, START_MARKED_SECTION_TOKEN,
               START_PROCESS_TOKEN, START_COMMENT_TOKEN, START_CLOSE_TOKEN, START_TOKEN], ThisContent, False); //  do not ignore "quoted" text: apostroph

           if (StartDelim = EMPTY_STRING) and ((Buffer <> EMPTY_STRING) or (ThisContent <> EMPTY_STRING)) then
           begin
               if not EndOfRead then
               begin
                   Buffer := ThisContent + Buffer;
                   EndOfRead := DoInternalReadStream(Buffer);
                   Continue;
               end
               else
                   raise EXMLEndTagMissingError.Create('Cannot find closing tag at the end of the document. The left-over text is "' + ThisContent + '"');
           end;

           {
           Add any text (content) found between the end of the previous tag and the start of this one
           }
           if Trim(ThisContent) <> EMPTY_STRING then
           begin
               if ElementStack.Top = nil then
               begin
                   if Trim(ThisContent) <> EMPTY_STRING then
                       raise EXMLWellFormedError.Create('Content found outside of elements: ''' + ThisContent + '''')
               end
               else
               begin
                   if (ElementStack.Top.Text <> EMPTY_STRING) or (Trim(ThisContent) <> EMPTY_STRING) then //       ignore inter-element whitespace
                       ElementStack.Top.AddText(CodesToStr(ThisContent));
               end;
           end;

           if Self.ProcessMessagesDuringParse then
               Application.ProcessMessages;

           if StartDelim = START_TOKEN then
           begin
               EndDelim := StripToDelimiter(Buffer, [END_EMPTY_TOKEN, END_TOKEN], ThisTag, True); //  True = ignore quoted text

               if EndDelim = END_EMPTY_TOKEN then          //  empty
               begin

                   if ElementStack.Top <> nil then
                       ThisNewElement := ElementStack.Top.AddElement //  this is a sub-element of the current element
                   else
                       ThisNewElement := Self.AddElement;

                   ThisNewElement.ElementClass := ecElement;
                   ThisNewElement.Parse(ThisTag);

                   { TODO: find matching DTDElement and call AddElementID if appropriate   }

                   DoStartElement(ThisNewElement);
                   DoEndElement(ThisNewElement);
               end
               else                                        //  element with sub-elements
               begin
                   if ElementStack.Top <> nil then
                       ThisNewElement := ElementStack.Top.AddElement(ecElement) //  this is a sub-element of the current element
                   else
                       ThisNewElement := Self.AddElement(ecElement);

                   ThisNewElement.Parse(ThisTag);          //      all the attributes

                   ElementStack.Push(ThisNewElement);      //  it is now the new Top for any embedded elements

                   DoStartElement(ThisNewElement);
               end;
           end
           else if StartDelim = START_CLOSE_TOKEN then     //  end element
           begin
               EndDelim := StripToDelimiter(Buffer, [END_TOKEN], ThisTag);
               if ElementStack.IsEmpty then
                   raise EXMLWellFormedError.Create('End tag /' + ThisTag + ' does not have any open tag to match')

               else if (ElementStack.Top <> nil) and not ElementStack.Top.SameName(ThisTag) then //  case-sensitive
                   raise EXMLWellFormedError.Create('End tag /' + ThisTag + ' does not match last starting tag ' + ElementStack.Top.ElementName);

               DoEndElement(TXMLElement(ElementStack.Objects[ElementStack.Count - 1]));
               ElementStack.Pop;
           end
           else if StartDelim = START_MARKED_SECTION_TOKEN then
           begin
               EndDelim := StripToDelimiter(Buffer, [END_MARKED_SECTION_TOKEN], ThisTag, False);

               if ElementStack.Top <> nil then
                   ThisNewElement := ElementStack.Top.AddElement //  this is a sub-element of the current element
               else
                   ThisNewElement := Self.AddElement;

               ThisNewElement.ElementClass := ecMarkedSection;
               ThisNewElement.Parse(ThisTag);

               DoStartElement(ThisNewElement);
               DoEndElement(ThisNewElement);
           end

           else if StartDelim = START_XML_TOKEN then       //  filter out these process tags before START_PROCESS_TOKEN
           begin
               ThisAttribute := EMPTY_STRING;
               StripToDelimiter(Buffer, [END_PROCESS_TOKEN], ThisContent, True); //   e.g.    ThisContent = 'version="1.0" encoding="UTF-8"'
               ThisContent := TrimLeft(ThisContent);
               while (StripToDelimiter(ThisContent, ThisAttribute) <> EMPTY_STRING) or (ThisAttribute <> EMPTY_STRING) do
               begin
                   if AnsiPos(ENCODING_TOKEN + '=', ThisAttribute) = 1 then
                   begin
                       System.Delete(ThisAttribute, Length(ThisAttribute), 1); //  trailing quote
                       Self.Encoding := Copy(ThisAttribute, Length(ENCODING_TOKEN + '=') + 2, 99); //  skip leading quote
                   end
                   else if AnsiPos(VERSION_TOKEN + '=', AnsiLowerCase(ThisAttribute)) = 1 then
                   begin
                       System.Delete(ThisAttribute, Length(ThisAttribute), 1); //  trailing quote
                       Self.XMLVersion := Copy(ThisAttribute, Length(VERSION_TOKEN + '=') + 2, 99); //  skip leading quote
                   end
                   else if SameShortestText(ThisAttribute, STANDALONE_TOKEN) and
                       (ExtractChar(ThisAttribute, Length(STANDALONE_TOKEN) + 1) = '=') then
                   begin
                       System.Delete(ThisAttribute, 1, Length(STANDALONE_TOKEN) + 1);
                       ThisAttribute := uCraftClass.TrimTokens(ThisAttribute, ['''', '"']);

                       if ThisAttribute = STANDALONE_NO then
                           Self.IsStandAlone := False
                       else if ThisAttribute = STANDALONE_YES then
                           Self.IsStandAlone := True
                       else
                           raise EXMLWellFormedError.Create('Unknown value of document attribute standalone: ' + ThisAttribute);
                   end
                       //      checking specific process tag values
                   else if AnsiPos(REQUIRED_MARKUP_DECLARATION_TOKEN + '=', AnsiUpperCase(ThisAttribute)) = 1 then
                   begin
                       System.Delete(ThisAttribute, Length(ThisAttribute), 1); //  trailing quote
                       System.Delete(ThisAttribute, 1, Length(REQUIRED_MARKUP_DECLARATION_TOKEN + '=') + 1); //  leading quote

                       if ThisAttribute = REQUIRED_MARKUP_DECLARATION_NONE then
                           Self.RequiredMarkupDeclaration := rmdNone

                       else if ThisAttribute = REQUIRED_MARKUP_DECLARATION_INTERNAL then
                           Self.RequiredMarkupDeclaration := rmdInternal

                       else if ThisAttribute = REQUIRED_MARKUP_DECLARATION_ALL then
                           Self.RequiredMarkupDeclaration := rmdAll
                   end
                   else
                       raise EXMLWellFormedError.Create('Unknown XML attribute: ''' + ThisAttribute + '''');
               end;
           end

           else if StartDelim = START_PROCESS_TOKEN then
           begin
               EndDelim := StripToDelimiter(Buffer, [END_PROCESS_TOKEN], ThisContent);
               ThisNewElement := Self.AddElement(ecProcessInstructions);
               ThisNewElement.Parse(ThisContent);

               DoStartElement(ThisNewElement);
               DoEndElement(ThisNewElement);
           end

           else if StartDelim = START_COMMENT_TOKEN then
           begin
               EndDelim := StripToDelimiter(Buffer, [END_COMMENT_TOKEN], ThisContent, False);

               if ElementStack.Top <> nil then
                   ThisNewElement := ElementStack.Top.AddElement //  this is a sub-element of the current element
               else
                   ThisNewElement := Self.AddElement;

               ThisNewElement.ElementClass := ecComment;
               ThisNewElement.Parse(ThisContent);

               DoStartElement(ThisNewElement);
               DoEndElement(ThisNewElement);
           end

           else if StartDelim = START_DOCTYPE_TOKEN then
           begin
               EndDelim := StripToDelimiter(Buffer, [START_DOCTYPE_DESCRIPTOR, END_TOKEN], ThisContent);
               if EndDelim <> END_TOKEN then               //      not only external DTD
               begin
                   Buffer := ThisContent + START_DOCTYPE_DESCRIPTOR + Buffer;
                   StripToDelimiter(Buffer, [END_DOCTYPE_DESCRIPTOR], ThisContent, True);
               end;
               DocType.Parse(ThisContent, AnErrorReport);  //  this is the implicit DocType
           end

           else if SameText(ExtractFileExt(Self.FileName), '.DTD') and
               ((StartDelim = START_ELEMENT_TOKEN) or (StartDelim = START_ATTLIST_TOKEN) or
               (StartDelim = START_ENTITY_TOKEN) or (StartDelim = START_NOTATION_TOKEN)) then
           begin
               StripToDelimiter(Buffer, [END_TOKEN], ThisContent);
               Self.DocType.PleaseAddToItems := True;
               Self.DocType.ParseDTD(StartDelim + ' ' + ThisContent);
           end
           else
               raise EXMLWellFormedError.Create('Unexpected delimiter ' + StartDelim);
       except
           on E : Exception do
           begin
               if AnErrorReport <> nil then
                   AnErrorReport.Add(E.Message)
               else
                   raise;
           end;
       end;
   end;
end;

procedure TXMLCollection.DoStartElement(AnElement : TXMLElement);
begin
   //        stub
end;

procedure TXMLCollection.DoEndElement(AnElement : TXMLElement); //  do not let descendents override this
begin
   DoElement(AnElement);
end;

procedure TXMLCollection.DoStartDTDParsing(ADocType : TDocType);
begin
   //     stub
end;

procedure TXMLCollection.DoEndDTDParsing(ADocType : TDocType);
begin
   //     stub
end;

procedure TXMLCollection.DoElement(AnElement : TXMLElement); //  let descendents override this
begin
   if Assigned(FOnElementParse) then
       FOnElementParse(Self, AnElement);
end;

procedure TXMLCollection.AbortAfterRootElement(Sender : TObject; AnElement : TXMLElement);
begin
   if AnElement = Self.RootElement then
       raise EAbortAfterParsingRootElement.Create('RootElement name is ' + AnElement.Name);
end;

function TXMLCollection.ComposeHeader(StartingIndent : Integer; StartingLineNumber : Integer) : AnsiString;
begin
   case ByteOrder of
       boUTF16UCS2 : Result := ArrayToString(BYTE_ORDER_UTF16_LE);
       boUCS4 : Result := ArrayToString(BYTE_ORDER_UCS4_LE);
       boUTF8 : Result := ArrayToString(BYTE_ORDER_UTF8);
       boEBCDIC : Result := ArrayToString(BYTE_ORDER_EBCDIC);
   else
       Result := START_XML_TOKEN;
   end;
   Result := Result + ' ' + VERSION_TOKEN + '=' + AddDelimitingQuotes(Self.XMLVersion);
   if Encoding <> EMPTY_STRING then
       Result := Result + ' ' + ENCODING_TOKEN + '=' + AddDelimitingQuotes(Self.Encoding);

   if IsStandAlone then
       Result := Result + ' ' + STANDALONE_TOKEN + '=' + AddDelimitingQuotes('yes'); //  implied "no"

   case RequiredMarkupDeclaration of
       rmdNone : Result := Result + ' ' + REQUIRED_MARKUP_DECLARATION_TOKEN + '=' + AddDelimitingQuotes('NONE');
       rmdInternal : Result := Result + ' ' + REQUIRED_MARKUP_DECLARATION_TOKEN + '=' + AddDelimitingQuotes('INTERNAL');
       rmdAll : ;                                          //      implied default is ALL
   end;

   Result := GetTabSpaces(StartingIndent) + Result + END_PROCESS_TOKEN;
end;

function TXMLCollection.ComposeDTD : AnsiString;
begin
   Result := DocType.ComposeCore;
end;

function TXMLCollection.Compose(StartingIndent : Integer; StartingLineNumber : Integer) : AnsiString;
var
   ResultStrings : TStringList;
begin
   ResultStrings := TStringList.Create;
   try
       Compose(ResultStrings, StartingIndent, StartingLineNumber);
       Result := ResultStrings.Text
   finally
       ResultStrings.Free
   end;
end;

procedure TXMLCollection.Compose(ResultStrings : TStrings; StartingIndent : Integer; StartingLineNumber : Integer);
var
   ThisStringStream : TStringStream;
begin
   ThisStringStream := TStringStream.Create(EMPTY_STRING);
   try
       Compose(ThisStringStream, StartingIndent, StartingLineNumber);
       ResultStrings.Text := ThisStringStream.DataString;
   finally
       ThisStringStream.Free;
   end;
end;

procedure TXMLCollection.Compose(ResultStream : TStream; StartingIndent : Integer; StartingLineNumber : Integer);
var
   OutputString : AnsiString;
   Counter : Integer;
begin
   OutputString := ComposeHeader(StartingIndent) + XML_END_LINE;
   ResultStream.Write(PAnsiChar(OutputString)^, Length(OutputString));

   if IncludeDTD and (FDocType <> nil) then
   begin
       OutputString := DocType.Compose(StartingIndent, StartingLineNumber); //  this will be '' if no DTD elements
       ResultStream.Write(PAnsiChar(OutputString)^, Length(OutputString));
       Inc(StartingLineNumber, CountOf(#10, OutputString));
   end;

   for Counter := 0 to FRootElementList.Count - 1 do
   begin
       OutputString := FRootElementList[Counter].Compose(StartingIndent, StartingLineNumber);
       ResultStream.Write(PAnsiChar(OutputString)^, Length(OutputString));
       Inc(StartingLineNumber, CountOf(#10, OutputString));
   end;
end;

procedure TXMLCollection.SaveToFile(const AFileName : AnsiString; LeaveLocked : Boolean);
var
   BackupFileName : string;
begin
   LockingFileStream.Free;

   if FileExists(AFileName) then
   begin
       BackupFileName := uWindowsInfo.GetUnusedFileName(ExtractFileDir(AFileName), ChangeFileExt(ExtractFileName(AFileName), '.BACKUP'));
       RenameFile(AFileName, BackupFileName);
   end
   else
       BackupFileName := EMPTY_STRING;

   try
       LockingFileStream := TFileStream.Create(AFileName, fmCreate);
       try
           Compose(LockingFileStream);
           FFileName := AFileName;
       finally
           if not LeaveLocked then
           begin
               LockingFileStream.Free;
               LockingFileStream := nil;
           end;
       end;
   except
       LockingFileStream.Free;
       LockingFileStream := nil;

       if BackupFileName <> EMPTY_STRING then
           RenameFile(BackupFileName, AFileName);

       raise;
   end;
   if BackupFileName <> EMPTY_STRING then
       DeleteFile(BackupFileName);                         //  only if no exceptions
end;

function TXMLCollection.GetTabSpaces(ATabIndex : Integer) : AnsiString;
begin
   Result := EMPTY_STRING;
   InsertTabSpaces(Result, ATabIndex);
end;

procedure TXMLCollection.InsertTabSpaces(var AString : AnsiString; ATabIndex : Integer);
begin
   Dec(ATabIndex);
   if ATabIndex >= TabStopList.Count then
       ATabIndex := TabStopList.Count - 1;

   if ATabIndex >= 0 then
       AString := StringOfChar(' ', Integer(TabStopList[ATabIndex]) - 1) + AString;
end;

function TXMLCollection.Validate(AReport : TStrings) : Boolean;
var
   ErrorsReportedList : TStringList;

   procedure ReportError(AnElement : TXMLElement; const AMessage : string; AnExceptionClass : EXMLValidationErrorClass = nil);
   var
       ThisException : EXMLValidationError;
   begin
       if AnExceptionClass = nil then
           AnExceptionClass := EXMLValidationError;

       ThisException := AnExceptionClass.Create(AMessage);
       try
           Result := False;                                //  set method return value
           DoValidationError(ThisException);

           if AnElement <> nil then
           begin
               if ErrorsReportedList.Values[AnElement.Name] <> AnExceptionClass.ClassName then
               begin
                   ErrorsReportedList.Values[AnElement.Name] := AnExceptionClass.ClassName; //  only report the error once
                   if (AReport <> nil) then
                       AReport.AddObject(AMessage, TObject(True));
               end;
           end
           else if (AReport <> nil) then
               AReport.AddObject(AMessage, TObject(True));
       finally
           ThisException.Free;                             //  we never actually raise an exception
       end;
   end;

   procedure ReportWarning(const AMessage : string);
   begin
       if (AReport <> nil) then
           AReport.AddObject(AMessage, TObject(False));
   end;

   procedure CheckElementAttributes(AnElement : TXMLElement);
   var
       Counter : Integer;
       ThisDTDAttribute : TDTDAttribute;
       FoundAttributeList : TList;
       TheseValues, ThisValue : string;
   begin
       if AnElement.DTDElement <> nil then
       begin
           FoundAttributeList := TList.Create;
           try
               for Counter := 0 to AnElement.AttributeCount - 1 do
               begin
                   if not AnElement.DTDElement.Attributes.Find(AnElement.AttributeNames[Counter], ThisDTDAttribute) then
                   begin
                       ReportWarning('Warning: Element "' + AnElement.Name + '" has an attribute "' +
                           AnElement.AttributeNames[Counter] + '" that is not part of the definition');
                   end
                   else
                   begin
                       FoundAttributeList.Add(ThisDTDAttribute);

                       if (ThisDTDAttribute.DefaultType = dtFixed) and
                           (AnElement.AttributeIndexValues[Counter] <> ThisDTDAttribute.DefaultValue) then
                       begin
                           ReportError(AnElement, 'Element "' + AnElement.Name + '" has a FIXED attribute "' +
                               AnElement.AttributeNames[Counter] + '" with a value "' +
                               AnElement.AttributeIndexValues[Counter] + '" that does not match the default value "' +
                               ThisDTDAttribute.DefaultValue + '"');
                       end;

                       case ThisDTDAttribute.AttributeType of
                           atID, atIDRef, atIDREFS :
                               begin
                                   TheseValues := AnElement.AttributeIndexValues[Counter];
                                   while TheseValues <> EMPTY_STRING do
                                   begin
                                       ThisValue := StripTo(TheseValues);
                                       if not IsValidID(ThisValue) then
                                       begin
                                           ReportError(AnElement, 'Element "' + AnElement.Name + '" has an ' +
                                               FormatEnumName(TypeInfo(TAttributeType), Integer(ThisDTDAttribute.AttributeType)) +
                                               ' attribute "' + AnElement.AttributeNames[Counter] +
                                               '" with a value "' + ThisValue + '" that is not a valid XML Name');
                                       end;
                                       if ThisDTDAttribute.AttributeType in [atIDRef, atIDREFS] then
                                       begin
                                           if (FIDCrossIndex.IndexOf(ThisValue) = -1) then
                                           begin
                                               ReportError(AnElement, 'Element "' + AnElement.Name + '" has an ' +
                                                   FormatEnumName(TypeInfo(TAttributeType), Integer(ThisDTDAttribute.AttributeType)) +
                                                   ' attribute "' + AnElement.AttributeNames[Counter] +
                                                   '" with a value "' + ThisValue + '" that is not an ID value');
                                           end;
                                       end;
                                   end;
                               end;
                           atENTITY, atENTITIES :
                               begin
                                   TheseValues := AnElement.AttributeIndexValues[Counter];
                                   while TheseValues <> EMPTY_STRING do
                                   begin
                                       ThisValue := StripTo(TheseValues);
                                       if not IsValidXMLName(ThisValue) then
                                       begin
                                           ReportError(AnElement, 'Element "' + AnElement.Name + '" has an ' +
                                               FormatEnumName(TypeInfo(TAttributeType), Integer(ThisDTDAttribute.AttributeType)) +
                                               ' attribute "' + AnElement.AttributeNames[Counter] +
                                               '" with a value "' + ThisValue + '" that is not a valid XML Name');
                                       end;
                                       if DocType.Entities.Find(ThisValue) = nil then
                                       begin
                                           ReportError(AnElement, 'Element "' + AnElement.Name + '" has an ' +
                                               FormatEnumName(TypeInfo(TAttributeType), Integer(ThisDTDAttribute.AttributeType)) +
                                               ' attribute "' + AnElement.AttributeNames[Counter] +
                                               '" with a value "' + ThisValue + '" that is not an existing ENTITY name');
                                       end;
                                   end;
                               end;
                           atNMTOKEN, atNMTOKENS :
                               begin
                                   TheseValues := AnElement.AttributeIndexValues[Counter];
                                   while TheseValues <> EMPTY_STRING do
                                   begin
                                       ThisValue := StripTo(TheseValues);
                                       if not IsValidNMToken(ThisValue) then
                                       begin
                                           ReportError(AnElement, 'Element "' + AnElement.Name + '" has an ' +
                                               FormatEnumName(TypeInfo(TAttributeType), Integer(ThisDTDAttribute.AttributeType)) +
                                               ' attribute "' + AnElement.AttributeNames[Counter] +
                                               '" with a value "' + ThisValue + '" that is not a NMTOKEN value');
                                       end;
                                   end;
                               end;
                           atEnumeration :
                               begin
                                   if (not ThisDTDAttribute.FindAttributeEnum(AnElement.AttributeIndexValues[Counter])) then
                                   begin
                                       ReportError(AnElement, 'Element "' + AnElement.Name + '" has an attribute "' +
                                           AnElement.AttributeNames[Counter] + '" with a value "' +
                                           AnElement.AttributeIndexValues[Counter] +
                                           '" that is not not one of the defined enumerated values');
                                   end;
                               end;
                           atImpliedCData :
                               begin
                                   ReportWarning('Warning: Element "' + AnElement.Name + '" has an attribute "' +
                                       AnElement.AttributeNames[Counter] + '" that is not part of the definition');
                               end;

                       end;
                   end;
               end;

               for Counter := 0 to AnElement.DTDElement.AttributeCount - 1 do
               begin
                   ThisDTDAttribute := AnElement.DTDElement.Attributes[Counter];

                   if (ThisDTDAttribute.DefaultType = dtRequired) and
                       (FoundAttributeList.IndexOf(ThisDTDAttribute) = -1) then
                   begin
                       ReportError(AnElement, 'Element "' + AnElement.Name + '" requires the attribute "' +
                           ThisDTDAttribute.Name + '"');
                   end;
               end;
           finally
               FoundAttributeList.Free;
           end;
       end;
   end;

var
   ThisDTDElement : TDTDElement;
   ThisElement : TXMLElement;
   Counter, CommentCounter : Integer;
   ThisChildReference : TNestedElementReference;
begin
   if (FDocType = nil) or DocType.IsEmpty then
   begin
       ReportError(ThisElement, 'No DOCTYPE to validate against');
       Exit;
   end;

   Result := DocType.Validate(AReport);

   ErrorsReportedList := TStringList.Create;

   if RootElement.IsEmpty then
   begin
       ReportError(ThisElement, 'No elements to validate');
       Exit;
   end;

   try
       if (DocType.Name <> '') and (RootElement.Name <> DocType.Name) then
       begin
           ReportError(RootElement, 'The root element "' + RootElement.Name +
               '" is not the same as the DocType name "' + DocType.Name + '"');
       end;

       if Self.FirstElement([ecComment], ThisElement) then
       begin
           CommentCounter := 0;
           repeat
               Inc(CommentCounter);
               if AnsiPos('--', ThisElement.Text) > 0 then
               begin
                   ReportWarning('Warning: Comment ' + IntToStr(CommentCounter) +
                       ' violates XML 2.5: For compatibility, the string "--" (double-hyphen) ' +
                       'MUST NOT occur within comments.');
               end;
           until not Self.NextElement([ecElement], ThisElement);
       end;

       if Self.FirstElement([ecElement], ThisElement) then
       begin
           repeat
               ThisDTDElement := ThisElement.DTDElement;
               if ThisDTDElement = nil then
               begin
                   ReportError(ThisElement, 'Element ' + ThisElement.Name +
                       ' does not have any definition in the DocType');
               end
               else
               begin
                   if ThisDTDElement.ElementType <> etAny then
                   begin
                       ThisChildReference := nil;

                       for Counter := 0 to ThisElement.ElementCount - 1 do
                       begin
                           if ThisDTDElement.ElementType = etEmpty then
                           begin
                               ReportError(ThisElement.Elements[Counter],
                                   'Child element ' + ThisElement.Elements[Counter].Name +
                                   ' is not allowed because the sub-element defintion of ' +
                                   ThisElement.Name + ' is marked as EMPTY', EXMLValidationExtraChildElementError);
                           end
                           else if not ThisDTDElement.FindNextReference(ThisElement.Elements[Counter].Name,
                               ThisChildReference) then
                           begin
                               ReportError(ThisElement.Elements[Counter],
                                   'Child element ' + ThisElement.Elements[Counter].Name +
                                   ' is not allowed in this position [' + IntToStr(Counter + 1) +
                                   '] by the sub-element definition of ' +
                                   ThisElement.Name + ': ' + ThisDTDElement.ElementMask,
                                   EXMLValidationExtraChildElementError);
                           end;
                       end;

                       if (ThisDTDElement.ElementType = etEmpty) and (ThisElement.Text <> EMPTY_STRING) then
                       begin
                           ReportError(ThisElement,
                               'Text content is not allowed because the sub-element defintion of ' +
                               ThisElement.Name + ' is marked as EMPTY', EXMLValidationExtraTextError);
                       end;

                       while ThisDTDElement.FindNextRequiredReference(ThisChildReference) do
                       begin
                           if ThisChildReference.Name = PCDATA_TOKEN then
                           begin
                               if ThisElement.Text = EMPTY_STRING then
                               begin
                                   ReportError(ThisElement, 'Required text content is missing from ' +
                                       ThisElement.Name, EXMLValidationRequiredTextMissingError);
                               end;
                           end
                           else
                           begin
                               ReportError(ThisElement,
                                   'Required child element ' + ThisChildReference.Name +
                                   ' is missing from ' + ThisElement.Name, EXMLValidationRequiredChildElementMissingError);
                           end;
                       end;
                   end;

                   CheckElementAttributes(ThisElement);
               end;
           until not Self.NextElement([ecElement], ThisElement);
       end;
   finally
       ErrorsReportedList.Free;
   end;
end;

procedure TXMLCollection.DoValidationError(AnError : EXMLValidationError);
begin
   if Assigned(FOnValidationError) then
       FOnValidationError(Self, AnError);
end;

function TXMLCollection.GetDocType : TDocType;
begin
   if FDocType = nil then
       FDocType := TDocType.Create(Self);
   Result := FDocType;
end;

procedure TXMLCollection.DescribeControls(AControl : TControl; AnElement : TXMLElement);
var
   Counter : Integer;
begin
   if AnElement = nil then
       AnElement := Self.AddElement;
   AnElement.AttributeValues['Name'] := AControl.Name;
   if AControl is TCheckBox then
   begin
       AnElement.Name := 'CheckBox';
       if TCheckBox(AControl).Checked then
           AnElement.AttributeValues['Value'] := 'True'
       else
           AnElement.AttributeValues['Value'] := 'False';
   end
   else if AControl is TRadioButton then
   begin
       AnElement.Name := 'RadioButton';
       if TRadioButton(AControl).Checked then
           AnElement.AttributeValues['Value'] := 'True'
       else
           AnElement.AttributeValues['Value'] := 'False';
   end
   else if (AControl is TListBox) and (TListBox(AControl).ItemIndex <> -1) then
   begin
       AnElement.Name := 'ListBox';
       with TListBox(AControl) do
           AnElement.AttributeValues['Selected'] := Items[ItemIndex];
   end
   else if (AControl is TComboBox) and (TComboBox(AControl).ItemIndex <> -1) then
   begin
       AnElement.Name := 'ComboBox';
       with TComboBox(AControl) do
           AnElement.AttributeValues['Selected'] := Items[ItemIndex];
   end
   else if AControl is TCustomMemo then
   begin
       AnElement.Name := 'Memo';
       AnElement.AttributeValues['Text'] := TCustomMemo(AControl).Lines.Text;
   end
   else if AControl is TCustomEdit then
   begin
       AnElement.Name := 'Edit';
       AnElement.AttributeValues['Text'] := TCustomEdit(AControl).Text;
   end
   else if AControl is TCustomLabel then
   begin
       AnElement.Name := 'Label';
       AnElement.AttributeValues['Caption'] := TLabel(AControl).Caption;
   end
   else
       AnElement.Name := Copy(AControl.ClassName, 2, MaxInt);

   if AControl is TWinControl then
   begin
       for Counter := 0 to TWinControl(AControl).ControlCount - 1 do
           DescribeControls(TWinControl(AControl).Controls[Counter], AnElement.AddElement);
   end;
end;

function TXMLCollection.ElementCount : Integer;
begin
   if RootElement = nil then
       Result := 0
   else
       Result := RootElement.DescendentCount + 1;          //  the root counts as one (1)
end;

function TXMLCollection.GetAsString : AnsiString;
begin
   Result := Compose;
end;

function TXMLCollection.AsWordWrappedString(MaxLineLength : Integer) : AnsiString;
var
   Counter, CharCounter, LastBreakChar : Integer;
   NewLine : AnsiString;
   CurrentQuoteChar : AnsiChar;
begin
   with TStringList.Create do
   try
       Text := AsString;
       Counter := -1;
       while Counter < Count do
       begin
           Inc(Counter);
           if Length(Strings[Counter]) > MaxLineLength then
           begin
               CurrentQuoteChar := #0;
               LastBreakChar := 0;
               for CharCounter := 0 to MaxLineLength do
               begin
                   if (CurrentQuoteChar = #0) and (Strings[Counter][CharCounter] in ['''', '"']) then
                       CurrentQuoteChar := Strings[Counter][CharCounter]

                   else if CurrentQuoteChar = Strings[Counter][CharCounter] then
                       CurrentQuoteChar := #0

                   else if (CurrentQuoteChar = #0) and (Strings[Counter][CharCounter] in WHITESPACE_CHARS) then
                       LastBreakChar := CharCounter;
               end;
               if LastBreakChar > 0 then
               begin
                   NewLine := StringOfChar(' ', MaxLineLength div 10) + Copy(Strings[Counter], LastBreakChar + 1, MaxInt);
                   Strings[Counter] := Copy(Strings[Counter], 1, LastBreakChar);
                   Insert(Counter + 1, NewLine);
               end;
           end;
       end;
   finally
       Free;
   end;
end;

procedure TXMLCollection.SetAsString(const Value : AnsiString);
begin
   Parse(Value);
end;

function TXMLCollection.IsEmpty : Boolean;
begin
   Result := ((ElementCount = 0) or (RootElement.IsEmpty)) and (DocType.IsEmpty);
end;

function TXMLCollection.FirstElement(AnElementClasses : TXMLElementClasses; var AnElement : TXMLElement) : Boolean;
begin
   FCurrentNextIndex := -1;
   Result := NextElement(AnElementClasses, AnElement);
end;

function TXMLCollection.FirstElement(const AnElementName : string; var AnElement : TXMLElement) : Boolean;
begin
   FCurrentNextIndex := -1;
   Result := NextElement(AnElementName, AnElement);
end;

function TXMLCollection.FirstElement(var AnElement : TXMLElement) : Boolean;
begin
   Result := (Count > 0);
   if Result then
   begin
       AnElement := Elements[0];
       FCurrentNextIndex := 0;
   end;
end;

function TXMLCollection.NextElement(const AnElementName : string; var AnElement : TXMLElement) : Boolean;
begin
   Result := False;

   while NextElement(AnElement) do
   begin
       if AnElement.ElementName = AnElementName then
       begin
           Result := True;
           Break;
       end;
   end;
end;

function TXMLCollection.NextElement(AnElementClasses : TXMLElementClasses; var AnElement : TXMLElement) : Boolean;
begin
   Result := False;

   while NextElement(AnElement) do
   begin
       if AnElement.ElementClass in AnElementClasses then
       begin
           Result := True;
           Break;
       end;
   end;
end;

function TXMLCollection.NextElement(var AnElement : TXMLElement) : Boolean;
begin
   Result := (FCurrentNextIndex < (Self.Count - 1));
   if Result then
   begin
       Inc(FCurrentNextIndex);
       AnElement := Elements[FCurrentNextIndex];
   end
   else
       FCurrentNextIndex := -1;                            //  reset for next time
end;

procedure TXMLCollection.AddElementList(AnElementList : TBaseXMLElementList);
begin
   FElementLists.Add(AnElementList);
end;

procedure TXMLCollection.RemoveElementList(AnElementList : TBaseXMLElementList);
begin
   FElementLists.Remove(AnElementList);
end;

procedure TXMLCollection.SortElementsByDTD;                 //  for each element, sort child elements according to the DTDElement.NestedElements
var
   ThisElement : TXMLElement;
   ThisDTDElement : TDTDElement;
begin
   if Self.DocType = nil then
       raise Exception.Create('This document has no DTD for sorting.');

   if Self.FirstElement(ThisElement) then
   begin
       repeat
           ThisDTDElement := ThisElement.DTDElement;
           if (ThisDTDElement <> nil) and (ThisElement.ElementCount > 1) then
           begin
               if (ThisDTDElement.NestedElements.Count > 1) then
               begin
                   if ThisDTDElement.ElementType = etElements then //  if etMixed, then no sequence is enforced
                       SortElementListByNestingReferences(ThisElement.FElementList, ThisDTDElement.NestedElements);
               end;
           end;
       until not Self.NextElement(ThisElement);
   end;
end;

function TXMLCollection.SortElementListByNestingReferences(AnElementList : TXMLElementList;
   ANesting : TNestedElementReferences; ListInsertionIndex : Integer = -1) : Integer;
var
   NestedElementCounter : Integer;
   ThisChildReference : TNestedElementReference;
   ThisChildIndex, StartingCycleInsertionIndex : Integer;
begin
   Result := ListInsertionIndex;

   repeat                                                  //  for repeating (rtMany and rtOptionalMany) nested groups, keep sorting until nothing else matches
       StartingCycleInsertionIndex := Result;
       for NestedElementCounter := 0 to ANesting.Count - 1 do //  walk through the list of child elements
       begin
           ThisChildReference := ANesting[NestedElementCounter];

           if ThisChildReference.IsNested then
           begin
               Result := SortElementListByNestingReferences(AnElementList,
                   ThisChildReference.NestedElementReferences, Result) //  recursive
           end
           else if AnElementList.Find(ThisChildReference.Name, ThisChildIndex, Result + 1) then
           begin
               Inc(Result);
               AnElementList.Move(ThisChildIndex, Result);

               if ThisChildReference.RepeatType in [rtMany, rtOptionalMany] then //  collect all the instances of this element we can
               begin
                   while AnElementList.Find(ThisChildReference.Name, ThisChildIndex, Result + 1) do
                   begin
                       Inc(Result);
                       AnElementList.Move(ThisChildIndex, Result);
                   end;
               end;

               if ANesting.Sequence = rsOr then
                   Break;                                  //  matched one of an "or" series: that's enough
           end;
       end;
   until (not (ANesting.RepeatType in [rtMany, rtOptionalMany])) or (Result >= AnElementList.Count) or
       (Result = StartingCycleInsertionIndex);
end;

function TXMLCollection.ExternalEntityFileNames : TStrings;
begin
   if FExternalEntityFileNames = nil then
   begin
       FExternalEntityFileNames := TStringList.Create;
       FExternalEntityFileNames.Sorted := True;
       FExternalEntityFileNames.Duplicates := dupIgnore;
   end;
   Result := FExternalEntityFileNames;
end;

{  TXMLParserCollection }

constructor TXMLParserCollection.Create(AParser : TXMLParser);
begin
   inherited Create;                                       //  it does not call TXMLCollection.Create without "inherited". I don't know why
   FParser := AParser;
end;

procedure TXMLParserCollection.DoStartElement(AnElement : TXMLElement);
begin
   inherited;
   if FParser <> nil then
       FParser.DoStartElement(AnElement);
end;

procedure TXMLParserCollection.DoElement(AnElement : TXMLElement);
begin
   inherited;
   if FParser <> nil then
       FParser.DoElement(AnElement);
end;

function TXMLParserCollection.DoInternalReadStream(var Buffer : AnsiString; AReadCount : Integer = 0) : Boolean;
begin
   Result := inherited DoInternalReadStream(Buffer, AReadCount); //  EndRead will be True if ReadStream = nil
   if FParser <> nil then
       FParser.DoRead(Buffer, Result);
end;

procedure TXMLParserCollection.Parse;
begin
   InternalReadStream := nil;
   InternalParse;                                          //  if the OnRead event does not do anything, this will abort
end;

procedure TXMLParserCollection.ResetReadStream;
begin
   inherited;
   if FParser <> nil then
       FParser.DoStartRead;
end;

procedure TXMLParserCollection.DoStartDTDParsing(ADocType : TDocType);
begin
   inherited;
   if FParser <> nil then
       FParser.DoStartDTDParsing(ADocType);
end;

procedure TXMLParserCollection.DoEndDTDParsing(ADocType : TDocType);
begin
   inherited;
   if FParser <> nil then
       FParser.DoEndDTDParsing(ADocType);
end;

{  TXMLParser  }

constructor TXMLParser.Create(AOwner : TComponent);
begin
   inherited;
   FXMLCollection := TXMLParserCollection.Create(Self);
end;

destructor TXMLParser.Destroy;
begin
   FXMLCollection.Free;
   inherited;
end;

procedure TXMLParser.DoStartElement(AnElement : TXMLElement);
begin
   if Assigned(FOnStartElement) then
       FOnStartElement(Self, AnElement);
end;

procedure TXMLParser.DoElement(AnElement : TXMLElement);
begin
   if Assigned(FOnElement) then
       FOnElement(Self, AnElement);
end;

procedure TXMLParser.DoRead(var Buffer : AnsiString; var EndData : Boolean);
begin
   if Assigned(FOnReadXML) then
       FOnReadXML(Self, Buffer, EndData);
end;

procedure TXMLParser.DoStartRead;
begin
   if Assigned(FOnStartReadXML) then
       FOnStartReadXML(Self);
end;

//     from Capitola Computing

function UCS2ToUTF8(UCS2 : WideString) : AnsiString;
const
   DOUBLE_CHAR_FLAG = $007F;
   TRIPLE_CHAR_FLAG = $000007FF;
   QUINTUPLE_CHAR_FLAG = $0000FFFF;
   BYTE_MASK = $000000FF;
var
   Counter : Integer;
   ThisChar : WideChar;
   ThisCharInteger : Integer;
begin
   Result := EMPTY_STRING;
   SetLength(Result, Length(UCS2) * 2);
   for Counter := 1 to Length(UCS2) do
   begin
       ThisChar := UCS2[Counter];
       ThisCharInteger := Ord(ThisChar);
       if ThisCharInteger < DOUBLE_CHAR_FLAG then
           Result := Result + Char(ThisCharInteger and BYTE_MASK)

       else if (ThisCharInteger > DOUBLE_CHAR_FLAG) and
           (ThisCharInteger < TRIPLE_CHAR_FLAG) then
       begin
           Result := Result + Char((((ThisCharInteger shr 6) and $0000001F) or $000000C0) and BYTE_MASK) +
               Char((ThisCharInteger and $000000BF) and BYTE_MASK);
       end
       else if (ThisCharInteger > TRIPLE_CHAR_FLAG) and (ThisCharInteger < QUINTUPLE_CHAR_FLAG) then
       begin
           Result := Result + Char((((ThisCharInteger shr 12) and $0000000F) or $000000E0) and BYTE_MASK) +
               Char((((ThisCharInteger shr 6) and $0000003F) or $00000080) and BYTE_MASK) +
               Char(((ThisCharInteger and $0000003F) or $00000080) and BYTE_MASK);
       end;
   end;
end;

function UTF8ToShiftJIS(AString : AnsiString) : AnsiString;
begin
   { TODO : Expected from Capitola Computing }
end;

function TXMLParser.GetProcessMessagesDuringParse : Boolean;
begin
   Result := XML.ProcessMessagesDuringParse;
end;

procedure TXMLParser.SetProcessMessagesDuringParse(AText : Boolean);
begin
   XML.ProcessMessagesDuringParse := AText;
end;

procedure TXMLParser.DoEndDTDParsing(ADocType : TDocType);
begin
   if Assigned(FOnEndDTDParsing) then
       FOnEndDTDParsing(Self, ADocType);
end;

procedure TXMLParser.DoStartDTDParsing(ADocType : TDocType);
begin
   if Assigned(FOnStartDTDParsing) then
       FOnStartDTDParsing(Self, ADocType);
end;

procedure TXMLParser.LoadFromFile(const AFileName : string; AnErrorReport : TStrings);
begin
   XML.LoadFromFile(AFileName);
end;

procedure TXMLParser.SaveToFile(const AFileName : string);
begin
   XML.SaveToFile(AFileName);
end;

{ TBaseXMLElementList }

constructor TBaseXMLElementList.Create;
begin
   Duplicates := dupAccept;
   CaseSensitive := True;
end;

constructor TBaseXMLElementList.Create(AnOwner : TXMLCollection);
begin
   Create;
   FOwner := AnOwner;
   if AnOwner <> nil then
       AnOwner.AddElementList(Self);
end;

destructor TBaseXMLElementList.Destroy;
begin
   if Owner <> nil then
       Owner.RemoveElementList(Self);

   FDocOrderCrossReference.Free;
   inherited;
end;

procedure TBaseXMLElementList.Clear;
begin
   inherited;
   FNextIndex := -1;
end;

function TBaseXMLElementList.First(var AnElement : TXMLElement) : Boolean;
begin
   Result := (Count > 0);
   if Result then
   begin
       AnElement := Elements[0];
       FNextIndex := 0;
   end;
end;

function TBaseXMLElementList.Next(var AnElement : TXMLElement) : Boolean;
begin
   Result := (FNextIndex < (Self.Count - 1));
   if Result then
   begin
       Inc(FNextIndex);
       AnElement := Elements[FNextIndex];
   end
   else
       FNextIndex := -1;                                   //  reset for next time
end;

function TBaseXMLElementList.GetElement(Index : Integer) : TXMLElement;
begin
   Assert(Index < Count, 'Trying to access an element past the end of the Element List');
   Result := Objects[Index] as TXMLElement;
end;

function TBaseXMLElementList.IndexOf(AnElement : TXMLElement) : Integer;
var
   Counter : Integer;
begin
   Result := -1;
   for Counter := 0 to Count - 1 do
   begin
       if Elements[Result] = AnElement then
       begin
           Result := Counter;
           Break;
       end;
   end;
end;

function TBaseXMLElementList.Find(const AName : string) : TXMLElement;
begin
   if not Find(AName, Result) then
       Result := nil;
end;

function TBaseXMLElementList.Find(const AName : string; var AnElement : TXMLElement; AStartingIndex : Integer) : Boolean;
var
   ThisIndex : Integer;
begin
   Result := Find(AName, ThisIndex, AStartingIndex);
   if Result then
       AnElement := Elements[ThisIndex];
end;

function TBaseXMLElementList.Find(const AName : string; var AnIndex : Integer; AStartingIndex : Integer) : Boolean;
var
   Counter : Integer;
begin
   Result := False;

   for Counter := AStartingIndex to Count - 1 do
   begin
       if Elements[Counter].Name = AName then
       begin
           AnIndex := Counter;
           Result := True;
           Break;
       end;
   end;
end;

function TBaseXMLElementList.Find(AnElement : TXMLElement; var AnIndex : Integer; AStartingIndex : Integer) : Boolean;
var
   Counter : Integer;
begin
   Result := False;

   for Counter := AStartingIndex to Count - 1 do
   begin
       if Elements[Counter] = AnElement then
       begin
           AnIndex := Counter;
           Result := True;
           Break;
       end;
   end;
end;

procedure TBaseXMLElementList.Remove(const AName : string);
begin
   Remove(Find(AName));
end;

procedure TBaseXMLElementList.Remove(AnElement : TXMLElement);
var
   Index : Integer;
begin
   Index := Self.IndexOfObject(AnElement);
   if Index <> -1 then
       Self.Delete(Index);
end;

function TBaseXMLElementList.Add(AnElement : TXMLElement) : Integer;
begin
   Result := IndexOfObject(AnElement);
   if Result = -1 then
       Result := inherited AddObject(AnElement.Name, AnElement);
end;

procedure TBaseXMLElementList.Add(SomeElements : TXMLElementList);
var
   Counter : Integer;
begin
   for Counter := 0 to SomeElements.Count - 1 do
       Self.Add(SomeElements.Elements[Counter]);
end;

function TBaseXMLElementList.IsEmpty : Boolean;
begin
   Result := (Count = 0);
end;

function TBaseXMLElementList.Pop : TXMLElement;
begin
   Result := Top;
   if Count > 0 then
       Self.Delete(Self.Count - 1);
end;

function TBaseXMLElementList.Push(AnXMLElement : TXMLElement) : TXMLElement;
begin
   Result := Top;
   Self.AddObject(AnXMLElement.ElementName, AnXMLElement);
end;

function TBaseXMLElementList.Top : TXMLElement;
begin
   if Count > 0 then
       Result := Self.Elements[Self.Count - 1]
   else
       Result := nil;
end;

function TBaseXMLElementList.SeparatedNames(ASeparator : AnsiString; Ascending : Boolean) : AnsiString;
var
   Counter : Integer;
begin
   Result := EMPTY_STRING;
   if Ascending then
   begin
       for Counter := 0 to Self.Count - 1 do
           Result := Result + ASeparator + Strings[Counter];
   end
   else
   begin
       for Counter := Self.Count - 1 downto 0 do
           Result := Result + ASeparator + Strings[Counter];
   end;
   System.Delete(Result, 1, Length(ASeparator));
end;

procedure TBaseXMLElementList.IntersectWith(AList : TXMLElementList);
var
   Counter : Integer;
begin
   for Counter := Self.Count - 1 downto 0 do
   begin
       if AList.IndexOfObject(Self.Elements[Counter]) = -1 then
           Self.Delete(Counter);
   end;
end;

procedure TBaseXMLElementList.UnionWith(AList : TXMLElementList);
var
   Counter : Integer;
begin
   for Counter := 0 to AList.Count - 1 do
   begin
       if Self.IndexOfObject(AList.Elements[Counter]) = -1 then
           Self.Add(AList.Elements[Counter]);
   end;
end;

function SortByIndex(Item1, Item2 : Pointer) : Integer;
begin
   Result := TXMLElement(Item2).Index - TXMLElement(Item1).Index;
end;

function TBaseXMLElementList.GetDocOrderCrossReference : TList;
var
   Counter : Integer;
begin
   if FDocOrderCrossReference = nil then
   begin
       FDocOrderCrossReference := TList.Create;
       for Counter := 0 to Self.Count - 1 do
           FDocOrderCrossReference.Add(Self.Elements[Counter]);

       FDocOrderCrossReference.Sort(SortByIndex);
   end;
   Result := FDocOrderCrossReference;
end;

function TBaseXMLElementList.GetElementInDocOrder(Index : Integer) : TXMLElement;
begin
   Result := TXMLElement(DocOrderCrossReference.Items[Index]);
end;

function TBaseXMLElementList.DocOrderIndexOf(AnElement : TXMLElement) : Integer;
begin
   Result := Count - 1;
   while Result >= 0 do
   begin
       if ElementsInDocOrder[Result] = AnElement then
           Exit;
       Dec(Result);
   end;
end;

procedure TBaseXMLElementList.Changed;
begin
   inherited;
   FDocOrderCrossReference.Free;
   FDocOrderCrossReference := nil;
end;

{ TXMLElementList }

function TXMLElementList._AddRef : Integer;
begin
   Result := 0;
end;

function TXMLElementList._Release : Integer;
begin
   Result := 0;
end;

{ TXLink }

constructor TXLink.Create(AnXMLElement : TXMLElement);
begin
   FElement := AnXMLElement;
end;

function TXLink.Compose : string;
var
   ThisPrefix : string;
begin
   ThisPrefix := Element.FindScopedNamespace(XLINK_NAMESPACE_URI);
   if ThisPrefix = EMPTY_STRING then
   begin
       ThisPrefix := DEFAULT_XLINK_PREFIX;
       Element.AddNamespace(XLINK_NAMESPACE_URI, ThisPrefix);
   end;
   ThisPrefix := ThisPrefix;

   Result := ThisPrefix + ':type="' + XLINK_TYPE_NAMES[LinkType] + '"';
   if Self.Show <> lsUnknown then
       Result := Result + ' ' + ThisPrefix + ':show="' + XLINK_SHOW_NAMES[Self.Show] + '"';

   if Self.Actuate <> laUnknown then
       Result := Result + ' ' + ThisPrefix + ':actuate="' + XLINK_ACTUATE_NAMES[Self.Actuate] + '"';

   if Self.LinkLabel <> EMPTY_STRING then
       Result := Result + ' ' + ThisPrefix + ':label="' + Self.LinkLabel + '"';

   if Self.LinkFrom <> EMPTY_STRING then
       Result := Result + ' ' + ThisPrefix + ':from="' + Self.LinkFrom + '"';

   if Self.LinkTo <> EMPTY_STRING then
       Result := Result + ' ' + ThisPrefix + ':to="' + Self.LinkTo + '"';

   if Self.Role <> EMPTY_STRING then
       Result := Result + ' ' + ThisPrefix + ':role="' + Self.Role + '"';

   if Self.ArcRole <> EMPTY_STRING then
       Result := Result + ' ' + ThisPrefix + ':arcrole="' + Self.ArcRole + '"';

   if Self.Title <> EMPTY_STRING then
       Result := Result + ' ' + ThisPrefix + ':title="' + Self.Title + '"';

   if Self.HRef <> EMPTY_STRING then
       Result := Result + ' ' + ThisPrefix + ':href="' + StrToCodes(Self.HRef) + '"';
end;

procedure TXLink.Validate;

   procedure CheckForForbiddenValue(const AValueName, AValue : string);
   begin
       if (AValue <> EMPTY_STRING) and (AValue <> 'Unknown') then
       begin
           raise EXLinkValidationError.Create(Element.XPath + ' is maked as XLink:Type = "' +
               XLINK_TYPE_NAMES[Self.LinkType] + '" and has a "' + AValueName + '" value of "' + AValue +
               '" where it should not any value there at all');
       end;
   end;

begin
   case LinkType of
       ltLocator :
           begin
               if HRef = EMPTY_STRING then
                   raise EXLinkValidationError.Create(Element.XPath + ' is maked as XLink:Type = "locator", but does not have the required HRef value');
               CheckForForbiddenValue('arcrole', ArcRole);
               CheckForForbiddenValue('show', XLINK_SHOW_NAMES[Show]);
               CheckForForbiddenValue('actuate', XLINK_ACTUATE_NAMES[Actuate]);
               CheckForForbiddenValue('from', LinkFrom);
               CheckForForbiddenValue('to', LinkTo);
               if not IsValidNMToken(LinkLabel) then
                   raise EXLinkValidationError.Create(Element.XPath + '/@label is not a valid NMTOKEN: "' + LinkLabel + '"');
           end;
       ltExtended :
           begin
               CheckForForbiddenValue('href', HRef);
               CheckForForbiddenValue('arcrole', ArcRole);
               CheckForForbiddenValue('show', XLINK_SHOW_NAMES[Show]);
               CheckForForbiddenValue('actuate', XLINK_ACTUATE_NAMES[Actuate]);
               CheckForForbiddenValue('label', LinkLabel);
               CheckForForbiddenValue('from', LinkFrom);
               CheckForForbiddenValue('to', LinkTo);
           end;
       ltSimple :
           begin
               CheckForForbiddenValue('label', LinkLabel);
               CheckForForbiddenValue('from', LinkFrom);
               CheckForForbiddenValue('to', LinkTo);
           end;
       ltArc :
           begin
               CheckForForbiddenValue('href', HRef);
               CheckForForbiddenValue('role', Role);
               CheckForForbiddenValue('label', LinkLabel);
               if not IsValidNMToken(LinkFrom) then
                   raise EXLinkValidationError.Create(Element.XPath + '/@from is not a valid NMTOKEN: "' + LinkFrom + '"');
               if not IsValidNMToken(LinkTo) then
                   raise EXLinkValidationError.Create(Element.XPath + '/@to is not a valid NMTOKEN: "' + LinkTo + '"');
           end;
       ltResource :
           begin
               CheckForForbiddenValue('href', HRef);
               CheckForForbiddenValue('arcrole', ArcRole);
               CheckForForbiddenValue('show', XLINK_SHOW_NAMES[Show]);
               CheckForForbiddenValue('actuate', XLINK_ACTUATE_NAMES[Actuate]);
               CheckForForbiddenValue('from', LinkFrom);
               CheckForForbiddenValue('to', LinkTo);
               if not IsValidNMToken(LinkLabel) then
                   raise EXLinkValidationError.Create(Element.XPath + '/@label is not a valid NMTOKEN: "' + LinkLabel + '"');
           end;
       ltTitle :
           begin
               CheckForForbiddenValue('href', HRef);
               CheckForForbiddenValue('role', Role);
               CheckForForbiddenValue('arcrole', ArcRole);
               CheckForForbiddenValue('title', Title);
               CheckForForbiddenValue('show', XLINK_SHOW_NAMES[Show]);
               CheckForForbiddenValue('actuate', XLINK_ACTUATE_NAMES[Actuate]);
               CheckForForbiddenValue('label', LinkLabel);
               CheckForForbiddenValue('from', LinkFrom);
               CheckForForbiddenValue('to', LinkTo);
           end;
   end;
end;

function TDTDElement.XPaths : IAutoStringList;
begin
   Result := TAutoStringList.Create;
   XPaths(Result.StringsObject);                           //  pass the object
end;

function TDTDElement.XPaths(AList : TStrings) : Integer;
var
   UsedByList : TDTDElementList;
   ParentXPaths : TStringList;
   UsedByCounter, ParentXPathCounter : Integer;
begin
   UsedByList := TDTDElementList.Create;
   ParentXPaths := TStringList.Create;
   try
       if LoadUsedByList(UsedByList) = 0 then
           AList.Add('/' + Self.Name)                      //  if we are no-one's child, we must be the root
       else
       begin
           for UsedByCounter := 0 to UsedByList.Count - 1 do
           begin
               ParentXPaths.Clear;
               UsedByList[UsedByCounter].XPaths(ParentXPaths);
               for ParentXPathCounter := 0 to ParentXPaths.Count - 1 do
                   AList.Add(ParentXPaths[ParentXPathCounter] + '/' + Self.Name);
           end;
       end;
   finally
       UsedByList.Free;
   end;

   Result := AList.Count;
end;

procedure TXLink.Assign(Source : TPersistent);
begin
   if Source is TXLink then
   begin
       with TXLink(Source) do
       begin
           Self.FElement := FElement;
           Self.FType := FType;
           Self.FLabel := FLabel;
           Self.FActuate := FActuate;
           Self.FShow := FShow;
           Self.FFrom := FFrom;
           Self.FTo := FTo;
           Self.FArcRole := FArcRole;
           Self.FTitle := FTitle;
           Self.FRole := FRole;
           Self.FHRef := FHRef;
       end;
   end
   else
       inherited;
end;

{ TDTDEntityReferences }

constructor TDTDEntityReferences.Create;
begin
   Create(TDTDEntityReference);
end;

function TDTDEntityReferences.GetReference(Index : Integer) : TDTDEntityReference;
begin
   Result := TDTDEntityReference(Items[Index]);
end;

function TDTDEntityReferences.Add : TDTDEntityReference;
begin
   Result := TDTDEntityReference(inherited Add);
end;

function TDTDEntityReferences.XMLCollection : TXMLCollection;
begin
   Result := DocType.XMLCollection;
end;

{ TDTDEntityReference }

function TDTDEntityReference.Compose(StartingIndent, StartingLineNumber : Integer) : AnsiString;
begin
   Self.LineNumber := StartingLineNumber;
   Result := XMLCollection.GetTabSpaces(StartingIndent) + PARAMETER_ENTITY_TOKEN + Self.Entity.Name + END_ENTITY_TOKEN;
end;

function TDTDEntityReference.XMLCollection : TXMLCollection;
begin
   Result := TDTDEntityReferences(Self.Collection).XMLCollection;
end;

function TDTDAttributes.XMLCollection : TXMLCollection;
begin
   Result := Element.DocType.XMLCollection;
end;

function TDTDElement.XMLCollection : TXMLCollection;
begin
   Result := DocType.XMLCollection;
end;

initialization
finalization
   FDebugLog.Free;

end.

