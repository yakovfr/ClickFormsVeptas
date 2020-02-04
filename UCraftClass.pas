unit uCraftClass;

interface

uses
   Windows, Classes, Controls, ClipBrd, INIFiles, Graphics, TypInfo, SysUtils, Types;

const
   EMPTY_STRING = '';
   NOT_FOUND_INDEX = -1;
   NOT_FOUND_POSITION = 0;
   EMPTY_DATE = 0.0;

type
   TReplaceStringOption = (rsoIgnoreCase, rsoReplaceAll, rsoIgnoreQuoted);
   TReplaceStringOptions = set of TReplaceStringOption;

   TDynamicArrayOfStrings = array of string;

   ENotYetImplemented = class(Exception)
   public
       constructor Create; reintroduce; overload;
   end;
   EStringsIteratorError = class(Exception);
   EIllegalStateError = class(EStringsIteratorError);
   ENoSuchElementError = class(EStringsIteratorError);

   IAutoStringList = interface(IUnknown)
       function GetTextStr : string;
       procedure SetTextStr(const Value : string);
       function GetCapacity : Integer;
       procedure SetCapacity(Value : Integer);
       function GetCommaText : string;
       procedure SetCommaText(const Value : string);
       function GetCount : Integer;
       function GetName(Index : Integer) : string;
       function GetObject(Index : Integer) : TObject;
       procedure PutObject(Index : Integer; Value : TObject);
       function GetValue(const Name : string) : string;
       procedure SetValue(const Name, Value : string);
       function Get(Index : Integer) : string;
       procedure Put(Index : Integer; const Value : string);
       function GetValueString(Index : Integer) : string;
       procedure SetValueString(Index : Integer; const Value : string);

       function Add(const AString : string) : Integer;
       function AddObject(const AString : string; AnObject : TObject) : Integer;
       procedure Append(const AString : string);
       procedure AddStrings(Strings : TStrings);
       procedure Assign(Source : TPersistent);
       procedure BeginUpdate;
       procedure Clear;
       procedure Delete(Index : Integer);
       procedure EndUpdate;
       function Equals(Strings : TStrings) : Boolean;
       procedure Exchange(Index1, Index2 : Integer);
       function GetText : PChar;
       function IndexOfName(const Name : string) : Integer;
       function IndexOfObject(AnObject : TObject) : Integer;
       procedure Insert(Index : Integer; const AString : string);
       procedure InsertObject(Index : Integer; const AString : string; AnObject : TObject);
       procedure LoadFromFile(const FileName : string);
       procedure LoadFromStream(Stream : TStream);
       procedure Move(CurIndex, NewIndex : Integer);
       procedure SaveToFile(const FileName : string);
       procedure SaveToStream(Stream : TStream);
       procedure SetText(Text : PChar);
       property Capacity : Integer read GetCapacity write SetCapacity;
       property CommaText : string read GetCommaText write SetCommaText;
       property Count : Integer read GetCount;
       property Names[Index : Integer] : string read GetName;
       property Objects[Index : Integer] : TObject read GetObject write PutObject;
       property Values[const Name : string] : string read GetValue write SetValue;
       property Strings[Index : Integer] : string read Get write Put; default;
       property ValueStrings[Index : Integer] : string read GetValueString write SetValueString;
       property Text : string read GetTextStr write SetTextStr;
       function StringsObject : TStrings;
   end;

function FindAnsiPos(const ASubString, AString : string; var Index : Integer) : Boolean;
function AnsiPosI(const ASubString, AString : string) : Integer;
function Pos(const SubString : string; AString : string) : Integer; overload; //  no reintroduce
function Pos(const SubStrings : array of string; AString : string) : Integer; overload;
function Pos(const AString : string; AnArray : TStringDynArray) : Integer; overload;
function Pos(const AnInteger : Integer; AnArray : TIntegerDynArray) : Integer; overload;
function PosOfWord(const AWord : string; AString : string) : Integer;
function StripNonAlpha(const AString : string) : string;
function SameAlpha(const String1, String2 : string) : Boolean;
function SameLeadingText(const String1, String2 : string) : Boolean;
function IndexOf(const AnArray : array of string; const AString : string) : Integer; overload;
function IndexOf(const AnArray : array of Word; const AWord : Word) : Integer; overload;
function IndexOf(const AnArray : array of Integer; const AnInteger : Integer) : Integer; overload;

{
Tokens can be:
String
Array of String or an open array of strings

Target can be:
TStrings
Array of String
nothing (return an IStringList)
}

type
   TStripOption = (soIgnoreQuotedText, soTrimExtraDelimiters, soSkipToFirstDelimiter, soCaseInsensitive);
   TStripOptions = set of TStripOption;

function BreakApart(AString : string; AToken : string; TargetList : TStrings; Options : TStripOptions = []) : Integer; overload;
function BreakApart(AString : string; AToken : string; var TargetArray : TDynamicArrayOfStrings; Options : TStripOptions = []) : Integer; overload;
function BreakApart(AString : string; AToken : string = EMPTY_STRING; Options : TStripOptions = []) : IAutoStringList; overload;

function BreakApart(AString : string; const Tokens : array of string; var TargetArray : TDynamicArrayOfStrings; Options : TStripOptions = []) : Integer; overload;
function BreakApart(AString : string; const Tokens : array of string; TargetList : TStrings; Options : TStripOptions = []) : Integer; overload;
function BreakApart(AString : string; const Tokens : array of string; Options : TStripOptions = []) : IAutoStringList; overload;

function StickTogether(AStrings : TStrings; const AToken : string) : string;
function NormalizeText(const AString : string) : string;
function NormalizeWhitespace(const AString : string) : string;
function FastPos(const ASubString, AString : string) : Integer;

//                         strips characters from AString until first of Delimiters and returns in Result (whole string if not found)
function StripTo(var AString : string; const ADelimiter : string = EMPTY_STRING; Options : TStripOptions = []) : string; overload;
function StripTo(var AString : string; const Delimiters : array of string; Options : TStripOptions = []) : string; overload;
function StripTo(var AString : string; const Delimiters : array of string;
   var ADelimiter : string; Options : TStripOptions = []) : string; overload;
//                         strips characters from AString until first character not of Delimiters and returns in Result (whole string if all within Delimiters)
function StripNot(var AString : string; const ADelimiter : string = EMPTY_STRING; Options : TStripOptions = []) : string; overload;
function StripNot(var AString : string; const Delimiters : array of string; Options : TStripOptions = []) : string; overload;
function StripNot(var AString : string; const Delimiters : array of string; var ADelimiter : string; Options : TStripOptions = []) : string; overload;
//                         copies characters from AString until first of Delimiters and returns in Result
function CopyTo(AString : string; const ADelimiter : string = EMPTY_STRING; Options : TStripOptions = []) : string; overload;
function CopyTo(AString : string; const Delimiters : array of string; Options : TStripOptions = []) : string; overload;
function CopyTo(AString : string; const Delimiters : array of string;
   var ADelimiter : string; Options : TStripOptions) : string; overload;
//                         strips characters from AString until first of Delimiters, if any, and resturns in Result
function StripIf(var AString : string; ADelimiter : string = EMPTY_STRING; Options : TStripOptions = []) : string; overload;
function StripIf(var AString : string; const Delimiters : array of string; Options : TStripOptions = []) : string; overload;
function StripIf(var AString : string; const Delimiters : array of string;
   var ADelimiter : string; Options : TStripOptions = []) : string; overload;
//                         copies characters from AString until first of Delimiters and returns in Result
function CopyIf(AString : string; const ADelimiter : string = EMPTY_STRING; Options : TStripOptions = []) : string; overload;
function CopyIf(AString : string; const Delimiters : array of string; Options : TStripOptions = []) : string; overload;
function CopyIf(AString : string; const Delimiters : array of string;
   var ADelimiter : string; Options : TStripOptions = []) : string; overload;

function StripFrom(var AString : string; const ADelimiter : string = EMPTY_STRING; Options : TStripOptions = []) : string;
function StripFromIf(var AString : string; const ADelimiter : string = EMPTY_STRING; Options : TStripOptions = []) : string;
function CopyFrom(AString : string; const ADelimiter : string = EMPTY_STRING; Options : TStripOptions = []) : string;

function StripLast(var AString : string; const ADelimiter : string = EMPTY_STRING; Options : TStripOptions = []) : string;
function StripQuotedText(var AString : string) : string; overload;
function StripQuotedText(var AString : string; Options : TStripOptions) : string; overload;
function StripDelimitedText(var AString : string;
   StartDelimiter : string; EndDelimiter : string = EMPTY_STRING; Options : TStripOptions = []) : string;
function ExtractQuotedText(const AString : string) : string;
function ExtractDelimitedText(const AString : string;
   StartDelimiter : string; EndDelimiter : string = EMPTY_STRING; Options : TStripOptions = []) : string;
function IsDelimitedText(const AString : string; const StartDelimiter, EndDelimiter : string) : Boolean; overload;
function IsDelimitedText(const AString : string; const StartDelimiter : string; const EndDelimiters : array of string) : Boolean; overload;
function IsDelimitedText(const AString : string; const StartDelimiters : array of string; const EndDelimiter : string) : Boolean; overload;
function IsDelimitedText(const AString : string; const StartDelimiters, EndDelimiters : array of string) : Boolean; overload;

function ExtractNextWord(AString : string; const OnlyThisWord : string = EMPTY_STRING) : string;
function StripNextWord(var AString : string; const OnlyThisWord : string = EMPTY_STRING; Options : TStripOptions = []) : string; overload;
function StripNextWord(var AString : string; const OnlyTheseWords : array of string; Options : TStripOptions = []) : string; overload;

function CommaTrimRight(const AString : string) : string;
procedure StripToken(var AString : string; const ADelimiter : string);
procedure StripTokens(var AString : string; const Delimiters : array of string);
function TrimToken(const AString : string; const ADelimiter : string) : string;
function TrimTokens(const AString : string) : string; overload; //  default to trim quotes
function TrimTokens(const AString : string; const Delimiters : array of string) : string; overload;
function StripComments(AString : string) : string;          //  not const argument
function ExtractAlpha(const AString : string; IgnoreQuotedText : Boolean = False) : string;
function ExtractNumber(const AString : string) : string;
function FindNumber(AString : string; var ANumber : Integer) : Boolean; overload;
function FindNumber(AString : string; var ANumber : Extended) : Boolean; overload;
function FindNumber(AString : string; var ANumber : string) : Boolean; overload; //  returns False if any non-numeric digits found

function IncrementString(const AString : string) : string;
function SubString(const AString : string; AStartIndex : Integer; ACount : Integer = MaxInt) : string;
function ExtractChar(const AString : string; APosition : Integer = 1) : Char;
function CountOf(const AProfile : string; AString : string) : Integer;
function ReplaceString(const AString, FindThis : string; const ReplaceWith : string = ''; Options : TReplaceStringOptions = [rsoIgnoreCase, rsoReplaceAll]) : string;
function ReplaceStrings(const AString : string; const FindThisReplaceWith : array of string; Options : TReplaceStringOptions = [rsoIgnoreCase, rsoReplaceAll]) : string; overload;
function ReplaceStrings(const AString : string; const FindThis : array of string; const ReplaceWith : string; Options : TReplaceStringOptions = [rsoIgnoreCase, rsoReplaceAll]) : string; overload;
function ReplaceStrings(AString : string; FindThisReplaceWith : TStrings; Options : TReplaceStringOptions = [rsoIgnoreCase, rsoReplaceAll]) : string; overload;

procedure ArrayToStrings(const AnArray : array of string; AStrings : TStrings); overload;
function ArrayToStrings(const AnArray : array of string) : TStrings; overload;
procedure ArrayToStringValues(const AnArray : array of string; AStrings : TStrings); overload;
function ArrayToStringValues(const AnArray : array of string) : TStrings; overload;

function ShiftStateToKeys(AShift : TShiftState) : Word;

function FormatCamelCap(const AString : string) : string;
function SameFont(Font1, Font2 : TFont) : Boolean;
//                     iterate and record name in Strings and object in Objects
function GetComponents(AHost : TComponent; AList : TStrings = nil) : Integer; overload;
function GetComponents(AHost : TComponent; const Classes : array of TClass; AList : TStrings = nil) : Integer; overload;
function GetControls(AParent : TWinControl; AList : TStrings = nil) : Integer; overload;
function GetControls(AParent : TWinControl; const Classes : array of TClass; AList : TStrings = nil) : Integer; overload;
function FocusOnFirstChild(AParent : TWinControl) : Boolean;

function StrToBool(const AString : string) : Boolean;
function BoolToStr(ABool : Boolean) : string;

function StrToGUID(AString : string) : TGUID;
function CreateGUID : string;
function GUIDToStr(AGUID : TGUID) : string;

function ExpressionToPolish(const AString : string; const ASeparator : string = ' ') : string; overload;
function ExpressionToPolish(const AString : string;
   const ASeparator : string; const OperatorPrecedence : array of string) : string; overload;
function PolishToInt(AString : string; const ASeparator : string = ' ') : Integer;
function PolishToFloat(AString : string; const ASeparator : string = ' ') : Extended;
function GeekStrToFloat(AString : string) : Extended;
function FloatToGeekStr(ANumber : Extended; DecimalPlaces : Integer = 0) : string;
function DescribeElapsedTime(ATime : TDateTime) : string;
function DescribeElapsedTicks(ATickCount : Integer) : string;
function DescribeCount(ACount : Integer; const ATerm : string = EMPTY_STRING; APluralTerm : string = EMPTY_STRING) : string;

function ComplimentryColor(AColor : TColor) : TColor;

{$IFDEF VER120}
function AnsiSameStr(const String1, String2 : string) : Boolean;
function SameText(const String1, String2 : string) : Boolean;
function AnsiSameText(const String1, String2 : string) : Boolean;
function IncludeTrailingBackslash(const AString : string) : string;
{$ENDIF}
function SameShortestText(const String1, String2 : string) : Boolean;
function SameShortestStr(const String1, String2 : string) : Boolean;
function SameWildcardText(String1, String2 : string) : Boolean;

function WideStrToString(AWideString : WideString) : string;
function StringToWideStr(const Source : string) : WideString;

procedure ClonePersistent(Source : TPersistent; var Target : TPersistent);
procedure AssignAllProperties(Source, Target : TPersistent);
procedure LoadPropertyValues(Source : TPersistent; AStrings : TStrings; PropertyPrefix : string = '');
procedure SetPropertyValues(Source : TPersistent; AStrings : TStrings);
function SameProperties(AnAncestor, ADescendent : TPersistent;
   CheckAncestorPropertiesOnly : Boolean = False; CheckMethods : Boolean = False; CheckRecursively : Boolean = True) : Boolean;
function IsAnyPropertyStored(Source : TPersistent) : Boolean;

function SetToStr(ATypeInfo : PTypeInfo; const ASetValue; FormatNames : Boolean = True) : string;
function StrToSet(ATypeInfo : PTypeInfo; AString : string) : Integer;
function GetEnumName(ATypeInfo : PTypeInfo; AValue : Integer) : string;
function FormatEnumName(const AName : string) : string; overload;
function FormatEnumName(ATypeInfo : PTypeInfo; AValue : Integer) : string; overload;
function LoadAllEnums(ATypeInfo : PTypeInfo; AStrings : TStrings = nil; FormatNames : Boolean = True) : Integer;
function LoadFromStrings(AItems, AStrings : TStrings; IsSet : Boolean) : Integer;
function IndexOfEnum(ATypeInfo : PTypeInfo; const AValue : string) : Integer;

function EnCode(SourceText : string; Key : Integer) : string;
function DeCode(SourceText : string; Key : Integer) : string;

function StrToSoundex(AString : string) : string;
function HexToInt(const AString : string) : System.Integer;

function EncodeDateExtended(AYear, AMonth, ADay : Integer) : TDateTime;
function StrToDateEx(AString : string; AShortDateFormat : string = EMPTY_STRING) : TDateTime;
function DaysInMonth(AMonth, AYear : Integer) : Integer;
function DateToStrDef(ADate : TDateTime; ADef : string = EMPTY_STRING) : string;
function DateTimeToStrDef(ADate : TDateTime; ADef : string = EMPTY_STRING) : string;
function AddWorkingDays(ADateTime : TDateTime; DayCount : Integer) : TDateTime;
function IncDate(ADate : TDateTime; YearCount : Integer; MonthCount : Integer = 0; DayCount : Integer = 0) : TDateTime;

function Compare(Date1, Date2 : TDateTime) : Integer; overload; //  note: these do not easily overload System.Compare
function Compare(Float1, Float2 : Extended) : Integer; overload;
function Compare(Integer1, Integer2 : Integer) : Integer; overload;

procedure WriteFile(const AFileName : string; AText : string);
procedure AppendToFile(const AFileName : string; AText : string);

type
   TCraftingStringList = class(TStringList)
   private
       FFreeObjects : Boolean;
       IsLocked : Boolean;
       IsLockInitialized : Boolean;
       FLock : TRTLCriticalSection;
       FSortDirty : Boolean;
       FRemoveBlankStrings : Boolean;
       FCurrentNextNameIndex : Integer;                    //  used with NextName
       FCurrentNextIndex : Integer;                        //  used with Next
       FIsLockedOnUpdate : Boolean;
       FReadWriteLock : TMultiReadExclusiveWriteSynchronizer;
       FReadCounter : Integer;

       function GetValue(Index : Integer) : string;        //	needed for interface
       function GetValueString(AIndex : Integer) : string; //	needed for interface
       procedure SetValueString(AIndex : Integer; const Value : string); //	needed for interface
       function GetLast : string;
       procedure SetLast(const Value : string);
       function GetLastObject : TObject;
       procedure SetLastObject(Value : TObject);
       function GetName(Index : Integer) : string;
       procedure SetName(Index : Integer; const Value : string);
       function GetSeparatedText(const ASeparator : string) : string;
       procedure SetSeparatedText(const ASeparator : string; Value : string);
       function GetInteger(Index : Integer) : Integer;
       procedure SetInteger(Index, Value : Integer);
       procedure SetRemoveBlankStrings(Value : Boolean);
       function GetString(Index : Integer) : string;
       procedure SetString(Index : Integer; const Value : string);
       procedure SetIsLockedOnUpdate(Value : Boolean);
       function GetReadWriteLock : TMultiReadExclusiveWriteSynchronizer;
   protected
       procedure AssignTo(Target : TPersistent); override;
       function Get(Index : Integer) : string; override;
       procedure Put(Index : Integer; const Value : string); override;
       function GetObject(Index : Integer) : TObject; override;
       procedure PutObject(Index : Integer; Value : TObject); override;
       procedure Changed; override;
       property SortDirty : Boolean read FSortDirty;
       property ReadWriteLock : TMultiReadExclusiveWriteSynchronizer read GetReadWriteLock;
       procedure SetUpdateState(Updating : Boolean); override;
   public
       constructor Create; overload; virtual;
       constructor Create(const ArrayOfStrings : array of string); overload;
       constructor Create(const AText : string); overload;
       destructor Destroy; override;
       procedure Clear; override;
       procedure Assign(Source : TPersistent); override;
       procedure Delete(AIndex : Integer); override;
       function Remove(AString : string) : Boolean; overload;
       function Remove(AnObject : TObject) : Boolean; overload;
       function RemoveName(AName : string) : Boolean;
       function Rename(const OldName, NewName : string) : Boolean;
       procedure FreeObjects;
       function SeparatedNames(const ASeparator : string; const ADelimiter : string = '') : string;
       class function ExtractName(const AString : string) : string;
       class function ExtractValue(const AString : string) : string;
       function BreakApart(AString : string; const Token : string = ''; Options : TStripOptions = [soTrimExtraDelimiters]) : Integer; overload;
       function BreakApart(AString : string; const Tokens : array of string; Options : TStripOptions = [soTrimExtraDelimiters]) : Integer; overload;

       //             TINIFile is not descended from TPersistent, so Assign won't work
       function ReadINISection(ASectionName : string; AINIFile : TINIFile) : Boolean; overload;
       procedure WriteINISection(ASectionName : string; AINIFile : TINIFile); //  does not EraseSection
       procedure Fill(const AString : string = EMPTY_STRING);
       property ValueStrings[Index : Integer] : string read GetValueString write SetValueString;
       property Integers[Index : Integer] : Integer read GetInteger write SetInteger;
       function FirstName(var AName : string) : Boolean;
       function NextName(var AName : string) : Boolean;    //  iterator
       function First(var AString : string) : Boolean;
       function Next(var AString : string) : Boolean;      //  iterator
       property Last : string read GetLast write SetLast;
       property LastObject : TObject read GetLastObject write SetLastObject;
       procedure InsertObject(Index : Integer; const AString : string; AnObject : TObject); override;
       function AddObject(const AString : string; AnObject : TObject) : Integer; override;
       function Add(const AString : string; AnInteger : Integer) : Integer; reintroduce; overload;
       function Open(const AString : string; AnObject : TObject = nil) : Integer;
       procedure OpenFirst(const AString : string; AnObject : TObject = nil);
       property Names[Index : Integer] : string read GetName write SetName;
       function IndexOfLeadingText(const AValue : string) : Integer;
       function IndexOf(const AString : string) : Integer; reintroduce; overload; override;
       function IndexOf(AnInt : Integer) : Integer; reintroduce; overload;
       function IndexOfName(const AName : string) : System.Integer; override;
       function IndexOfValue(const AValue : string) : System.Integer;
       function Find(const AString : string) : Boolean; reintroduce; overload;
       function Find(const AString : string; var Index : Integer) : Boolean; reintroduce; overload; override;
       function Find(const AString : string; var FoundObject : TObject) : Boolean; reintroduce; overload;
       function Find(AnObject : TObject; var Index : System.Integer) : Boolean; reintroduce; overload;
       function Find(AnObject : TObject; var FoundObject : TObject) : Boolean; reintroduce; overload;
       function Find(AnObject : TObject; var FoundString : string) : Boolean; reintroduce; overload;
       function Find(AInteger : Integer; var Index : System.Integer) : Boolean; reintroduce; overload;
       function Find(AInteger : Integer; var FoundObject : TObject) : Boolean; reintroduce; overload;
       function Find(AInteger : Integer; var FoundString : string) : Boolean; reintroduce; overload;
       function FindName(const AName : string) : Boolean; overload;
       function FindName(const AName : string; var Index : Integer) : Boolean; overload;
       function FindName(const AName : string; var AValue : string) : Boolean; overload;
       function FindValue(const AValue : string; var Index : Integer) : Boolean; reintroduce; overload;
       function FindValue(const AValue : string; var AFoundObject : TObject) : Boolean; reintroduce; overload;
       property SeparatedText[const ASeparator : string] : string read GetSeparatedText write SetSeparatedText;
       procedure LoadFromClipboard(AFormat : Word);
       procedure ReadSections(AStrings : TStrings);
       procedure ReadSection(const SectionName : string; AStrings : TStrings);
       procedure SaveToClipboard(AFormat : Word);
       function LockList : TCraftingStringList;
       procedure UnlockList;
       procedure CustomSort(Compare : TStringListSortCompare); override;
       property Strings[Index : Integer] : string read GetString write SetString; //  cannot override a property, but will work if not polymorphed
       function CommaSubText(AStartingIndex : Integer; ACount : Integer = MaxInt) : string;

       function Top : string; overload;
       function Top(var AnObject : TObject) : string; overload;
       function Push(const AString : string; AnObject : TObject = nil) : Integer; overload;
       function PushInt(AnInteger : Integer) : Integer;
       function Pop : string; overload;
       function Pop(var AnObject : TObject) : string; overload;
       function PopInt : Integer;

       procedure BeginRead;
       procedure EndRead;
   published
       property AutoFreeObjects : Boolean read FFreeObjects write FFreeObjects default False;
       property RemoveBlankStrings : Boolean read FRemoveBlankStrings write SetRemoveBlankStrings default False;
       property LockOnUpdate : Boolean read FIsLockedOnUpdate write SetIsLockedOnUpdate default False;
   end;

   {

   var
       ThisStrings : IAutoStringList;
   begin
       ThisStrings := TAutoStringList.Create;
       ...
    //  no need to explicitly free it
    end;
    }

   TAutoStringList = class(TCraftingStringList, IAutoStringList)
   private
       FRefCount : Integer;
   protected
       function GetCommaText : string;
       procedure SetCommaText(const Value : string);
       function GetName(Index : Integer) : string;
       function GetValueString(Index : Integer) : string;
       procedure SetValueString(Index : Integer; const Value : string);
       function GetValue(const Name : string) : string;
       procedure SetValue(const Name, Value : string);
       function _AddRef : Integer; virtual; stdcall;
       function _Release : Integer; virtual; stdcall;
       function QueryInterface(const IID : TGUID; out Obj) : HResult; stdcall;
   public
       procedure AfterConstruction; override;
       class function NewInstance : TObject; override;
       function StringsObject : TStrings;
   end;

   TRecursiveStringList = class(TCraftingStringList)
   private
       FParent : TRecursiveStringList;
       function GetParent(const AParentName : string) : TRecursiveStringList;
       function GetChildList(Index : Integer) : TRecursiveStringList;
   public
       constructor Create; override;
       property Parents[const AParentName : string] : TRecursiveStringList read GetParent;
       property Parent : TRecursiveStringList read FParent write FParent;
       property ChildLists[Index : Integer] : TRecursiveStringList read GetChildList;
       function DescendantCount : Integer;
       function IndentedText : string;
       procedure AssignTo(Target : TPersistent); override; //  TStrings.Assign(TRecursiveStringList) will not call this, so allow the user to
   end;
   TNoReferenceComponent = class(TComponent)               //  (TComponent) makes it unnecessary for TComponents to free this
   protected
       function _AddRef : Integer; stdcall;
       function _Release : Integer; stdcall;
   end;

   TNoReferenceCollection = class(TCollection)
   protected
       function QueryInterface(const IID : TGUID; out Obj) : HResult; stdcall;
       function _AddRef : Integer; stdcall;
       function _Release : Integer; stdcall;
   end;

   TNoReferenceCollectionItem = class(TCollectionItem)
   protected
       function QueryInterface(const IID : TGUID; out Obj) : HResult; stdcall;
       function _AddRef : Integer; stdcall;
       function _Release : Integer; stdcall;
   end;

   TNoReferenceList = class(TList)
   protected
       function QueryInterface(const IID : TGUID; out Obj) : HResult; stdcall;
       function _AddRef : Integer; stdcall;
       function _Release : Integer; stdcall;
   end;

   TNoReferenceObject = class(TObject)
   protected
       function QueryInterface(const IID : TGUID; out Obj) : HResult; stdcall;
       function _AddRef : Integer; stdcall;
       function _Release : Integer; stdcall;
   end;

   TCraftingFileStream = class(TFileStream)
   private
       FCreateFlags : Word;
       FText : string;
       IsBufferedTextCurrent : Boolean;
       FFileName : string;
       FBufferReads : Boolean;
       FReadBufferSize : Integer;
       FReadBuffer : string;
       function GetText : string;
       procedure SetText(const Value : string);
   protected
       property CreateFlags : Word read FCreateFlags;
   public
       constructor Create(const AFileName : string; Flags : Word = 0);
       constructor CreateNew(const AFileName : string; Flags : Word = 0);
       constructor Open(const AFileName : string; Flags : Word = 0);
       constructor Append(const AFileName : string; Flags : Word = 0);
       constructor ReadOnly(const AFileName : string; Flags : Word = 0);
       function Write(const Buffer; ACount : LongInt; APosition : LongInt) : LongInt; reintroduce; overload;
       function Write(const Buffer; ACount : LongInt) : LongInt; reintroduce; overload; override;
       function Write(const AString : string) : LongInt; reintroduce; overload;
       function WriteLine(AString : string) : LongInt;
       function Read(var Buffer; ACount : LongInt) : LongInt; reintroduce; overload; override;
       function Read(var Buffer; ACount : LongInt; APosition : LongInt) : LongInt; reintroduce; overload;
       function ReadLine : string;
       function ReadString(ACount : LongInt) : string;
       property Text : string read GetText write SetText;
       property FileName : string read FFileName;
       property ReadsBuffered : Boolean read FBufferReads write FBufferReads;
       property ReadBufferSize : Integer read FReadBufferSize write FReadBufferSize;
       function Seek(const Offset : Int64; Origin : TSeekOrigin) : Int64; override;
   end;

   TStringLists = class(TCraftingStringList)
   private
       function GetStringLists(Index : Integer) : TStringList;
       function GetValues(const AListName, AKeyName : string) : string;
       procedure SetStringLists(Index : Integer; const Value : TStringList);
       procedure SetValues(const AListName, AKeyName, Value : string);
   public
       procedure Clear(AnIndex : Integer = 0); reintroduce; overload;
       property Lists[Index : Integer] : TStringList read GetStringLists write SetStringLists;
       function ListByName(const AListName : string) : TStringList;
       function Find(const AListName : string; var AStrings : TStringList) : Boolean; reintroduce; overload;
       function StringOf(const AName : string; Index : Integer) : string;
       property Values[const AListName, AKeyName : string] : string read GetValues write SetValues;
       function OpenList(const AListName : string) : TStringList;
   end;

   TIndexMode = (imAutomatic, imAlways, imNever);
const
   DEFAULT_INDEX_MODE = imAutomatic;

type
   ICraftingCollectionItem = interface(IUnknown)           //  implementations should descend from TNoReferenceCollectionItem
       ['{CFADF01F-BF9F-4B92-BA02-73AD785F098F}']
       function GetIndexName : string;
       //              also agree to call Self.Changed;
   end;

   TCraftingCollection = class;
   TCraftingCollectionItem = class(TNoReferenceCollectionItem, ICraftingCollectionItem)
   private
       FInternalChange : Integer;
       function GetInternalChange: Boolean;
       procedure SetInternalChange(Value: Boolean);
   protected
       function GetIndexName : string; virtual;
       procedure Changed(AllItems : Boolean = False); virtual;     //  copied from Classes.pas because IT WAS NOT VIRTUAL
       function Collection : TCraftingCollection;
       property InternalChange : Boolean read GetInternalChange write SetInternalChange;
   public
       procedure Clear; virtual;
       function IsEqual(AnOther : TObject) : Boolean; virtual;
   end;

   IEnumerableCollection = interface(IUnknown)
       ['{DCE83353-0AE3-4DA5-AEE7-0B98E095B6A8}']
       function First(var AnItem : TCollectionItem) : Boolean;
       function Next(var AnItem : TCollectionItem; var AnIndex : Integer) : Boolean;
   end;

   TCollectionEnumerator = class(TInterfacedObject)
   private
       FCurrentIndex : Integer;
       FCollection : IEnumerableCollection;
   public
       constructor Create(ACollection : IEnumerableCollection);
       function First(var AnItem : TCollectionItem) : Boolean;
       function Next(var AnItem : TCollectionItem) : Boolean;
       procedure Reset;
   end;

   TItemChangeEvent = procedure(Sender : TObject; AnItem : TCollectionItem) of object;
   TCraftingCollection = class(TNoReferenceCollection, IEnumerableCollection)
   private
       FIndexStrings : TCraftingStringList;
       FIndexMode : TIndexMode;
       FOnItemChange : TItemChangeEvent;
       FOnAdd : TItemChangeEvent;
       FEnumerator : TCollectionEnumerator;
       FIsLockedOnUpdate : Boolean;
       FReadWriteLock : TMultiReadExclusiveWriteSynchronizer;
       FReadCounter : Integer;

       procedure SetIndexMode(Value : TIndexMode);
       function GetIndexStrings : TCraftingStringList;
       function GetIndexName(Index : Integer) : string;
       function GetIndexItem(Index : Integer) : ICraftingCollectionItem;
       procedure LoadAllIndex;
       procedure SetIsLockedOnUpdate(Value : Boolean);
       function GetItem(AnIndex : Integer) : TCollectionItem;
   protected
       property IndexStrings : TCraftingStringList read GetIndexStrings;
       procedure Notify(Item : TCollectionItem; Action : TCollectionNotification); override;
       property IndexItems[Index : Integer] : ICraftingCollectionItem read GetIndexItem;
       procedure Update(AnItem : TCollectionItem); override; //  this is called if FUpdate = 0
       procedure ClearIndex;
       procedure DoAdd(AnItem : TCollectionItem); virtual;
       procedure DoRemove(AnItem : TCollectionItem); virtual;
       procedure ResetIterator; virtual;
   public
       constructor Create(ACollectionItemClass : TCollectionItemClass); reintroduce; overload;
       destructor Destroy; override;
       procedure Clear; virtual;
       function Find(const AName : string) : TCollectionItem; overload;
       function Find(const AName : string; var AnItem : TCollectionItem) : Boolean; overload;
       function Find(const AName : string; var AnIndex : Integer) : Boolean; overload; virtual;
       function First(var AnItem : TCollectionItem) : Boolean; virtual;
       function Next(var AnItem : TCollectionItem) : Boolean; overload; virtual;
       function Next(var AnItem : TCollectionItem; var AnIndex : Integer) : Boolean; overload;
       property IndexNames[Index : Integer] : string read GetIndexName;
       procedure SaveToFile(const AFileName : string); virtual;
       procedure BeginUpdate; override;
       procedure EndUpdate; override;
       function IsUpdating : Boolean;
       procedure BeginRead;
       procedure EndRead;
       property Items[AnIndex : Integer] : TCollectionItem read GetItem;
   published
       property IndexMode : TIndexMode read FIndexMode write SetIndexMode default DEFAULT_INDEX_MODE;
       property LockOnUpdate : Boolean read FIsLockedOnUpdate write SetIsLockedOnUpdate default False;
       property OnItemChange : TItemChangeEvent read FOnItemChange write FOnItemChange;
       property OnAdd : TItemChangeEvent read FOnAdd write FOnAdd;
   end;

const
   DAYS_PER_HOUR = 1 / 24;
   DAYS_PER_MINUTE = DAYS_PER_HOUR / 60;
   DAYS_PER_SECOND = DAYS_PER_MINUTE / 60;
   DAYS_PER_MILISECOND = DAYS_PER_SECOND / 1000;
   MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
   SECONDS_PER_DAY = 60 * 60 * 24;

   UPPER_ALPHA_CHAR_ARRAY : array[0..25] of Char = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
       'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
   UPPER_ALPHA_CHARS = ['A'..'Z'];
   LOWER_ALPHA_CHARS = ['a'..'z'];
   ALPHA_CHARS = UPPER_ALPHA_CHARS + LOWER_ALPHA_CHARS;
   NUMERIC_CHARS = ['0'..'9'];
   ALPHA_NUMERIC_CHARS = ALPHA_CHARS + NUMERIC_CHARS;
   NON_ALPHA_NUMERIC_CHARS = [#0..#255] - ALPHA_NUMERIC_CHARS;

   WHITESPACE_CHARS : array[0..3] of Char = (' ', #9, #13, #10);

implementation

uses
   Forms, ActiveX, Variants,
{$IFDEF FOCUS_ON_CTRLGRID}
   dbcgrids,
{$ENDIF}
   ComCtrls, Math, uWindowsInfo, RTLConsts;

const
   MAX_ASTEXT_LENGTH = 255;
   MAX_CLIPBOARD_STRING_LENGTH = 10000;

constructor ENotYetImplemented.Create;
begin
   Create('Not yet implemented');
end;

{  TCraftingStringList }

constructor TCraftingStringList.Create;
begin
   FFreeObjects := False;
   FSortDirty := True;
   FRemoveBlankStrings := False;
   FCurrentNextNameIndex := NOT_FOUND_INDEX;
   FCurrentNextIndex := NOT_FOUND_INDEX;
end;

constructor TCraftingStringList.Create(const ArrayOfStrings : array of string);
var
   Counter : System.Integer;
begin
   Create;
   for Counter := Low(ArrayOfStrings) to High(ArrayOfStrings) do
       Add(ArrayOfStrings[Counter]);
end;

constructor TCraftingStringList.Create(const AText : string);
begin
   Create;
   Self.Text := AText;
end;

destructor TCraftingStringList.Destroy;
begin
   Clear;
   UnlockList;
   FReadWriteLock.Free;
   inherited;
end;

procedure TCraftingStringList.Clear;
begin
   if AutoFreeObjects then
       FreeObjects;
   FCurrentNextIndex := NOT_FOUND_INDEX;
   FCurrentNextNameIndex := NOT_FOUND_INDEX;
   inherited;
end;

procedure TCraftingStringList.Assign(Source : TPersistent);
var
   ThisString : string;
begin
   if Source is TClipboard then
   begin
       with TClipboard(Source) do
       begin
           ThisString := AsText;
           if Length(ThisString) = MAX_ASTEXT_LENGTH then
           begin
               SetLength(ThisString, MAX_CLIPBOARD_STRING_LENGTH);
               SetLength(ThisString,
                   GetTextBuf(PChar(ThisString), MAX_CLIPBOARD_STRING_LENGTH));
           end;
           Self.Text := ThisString;
       end;
   end
   else
       inherited Assign(Source);
end;

procedure TCraftingStringList.AssignTo(Target : TPersistent);
begin
   if Target is TClipboard then
   begin
       TClipboard(Target).SetTextBuf(PChar(Self.Text));
   end
   else
       inherited AssignTo(Target);
end;

function TCraftingStringList.ReadINISection(ASectionName : string; AINIFile : TINIFile) : Boolean;
var
   SectionNames : TStringList;
begin
   BeginRead;
   try
       Self.Clear;
       AINIFile.ReadSection(ASectionName, Self);
       if Self.Count = 0 then
       begin
           SectionNames := TStringList.Create;
           try
               AINIFile.ReadSections(SectionNames);
               SectionNames.Sorted := True;
               Result := SectionNames.IndexOf(ASectionName) <> NOT_FOUND_INDEX; //  section there but empty
           finally
               SectionNames.Free;
           end;
       end
       else
           Result := True;
   finally
       EndRead;
   end;
end;

procedure TCraftingStringList.WriteINISection(ASectionName : string; AINIFile : TINIFile);
var
   Counter : System.Integer;
begin
   for Counter := 0 to Self.Count - 1 do
       AINIFile.WriteString(ASectionName, Names[Counter], ValueStrings[Counter]);
end;

function TCraftingStringList.SeparatedNames(const ASeparator, ADelimiter : string) : string;
var
   Counter : System.Integer;
begin
   Result := EMPTY_STRING;
   if Count > 0 then
   begin
       SetLength(Result,                                   //  give it enough room
           ((Length(Self.Names[0]) + (Length(ADelimiter) * 2) + Length(ASeparator)) * Self.Count));
       Result := ADelimiter + Self.Names[0] + ADelimiter;
       for Counter := 1 to Self.Count - 1 do
           Result := Result + ASeparator + ADelimiter + Self.Names[Counter] + ADelimiter;
   end;
end;

procedure TCraftingStringList.Delete(AIndex : Integer);
begin
   BeginUpdate;
   try
       if AutoFreeObjects then
           Objects[AIndex].Free;

       Objects[AIndex] := nil;                             // Let's avoid any potential Delphi gotchas with Counts not keeping up with Deletes

       if AIndex < FCurrentNextIndex then
           Dec(FCurrentNextIndex);

       if AIndex < FCurrentNextNameIndex then
           Dec(FCurrentNextNameIndex);

       inherited;
   finally
       EndUpdate;
   end;
end;

function TCraftingStringList.Remove(AString : string) : Boolean;
var
   Index : System.Integer;
begin
   BeginUpdate;
   try
       Result := Find(AString, Index);
       if Result then
           Delete(Index);
   finally
       EndUpdate;
   end;
end;

function TCraftingStringList.Remove(AnObject : TObject) : Boolean;
var
   Index : System.Integer;
begin
   BeginUpdate;
   try
       Result := Self.Find(AnObject, Index);
       if Result then
           Delete(Index);
   finally
       EndUpdate;
   end;
end;

function TCraftingStringList.RemoveName(AName : string) : Boolean;
var
   Index : System.Integer;
begin
   Result := False;

   BeginUpdate;
   try
       while FindName(AName, Index) do                     //  might be multiple instances of the AName
       begin
           Delete(Index);
           Result := True;
       end;
   finally
       EndUpdate;
   end;
end;

function TCraftingStringList.Rename(const OldName, NewName : string) : Boolean;
var
   Index : System.Integer;
begin
   Result := False;

   BeginUpdate;
   try
       while FindName(OldName, Index) do                   //  might be multiple instances of the OldName
       begin
           Strings[Index] := NewName + '=' + ValueStrings[Index];
           Result := True;
       end;
   finally
       EndUpdate;
   end;
end;

function TCraftingStringList.IndexOfName(const AName : string) : System.Integer; //  inherited IndexOfName requires a '='
var
   Counter : System.Integer;
begin
   BeginRead;
   try
       if Self.Sorted or (not SortDirty) then
       begin
           Result := IndexOfLeadingText(AName);            //  Boolean search might return in the middle of matches
           if Result <> NOT_FOUND_INDEX then
           begin
               for Counter := Result downto 0 do           //  check the found item and the items above it
               begin
                   if SameText(AName, Strings[Counter]) or
                       SameText(AName + '=', SubString(Strings[Counter], 1, Length(AName) + 1)) then
                   begin
                       Result := Counter;
                       Exit;
                   end
                   else if not SameText(AName, SubString(Strings[Counter], 1, Length(AName))) then
                       Break;
               end;
               for Counter := Result + 1 to Count - 1 do   //  check the items below it
               begin
                   if SameText(AName, Strings[Counter]) or
                       SameText(AName + '=', SubString(Strings[Counter], 1, Length(AName) + 1)) then
                   begin
                       Result := Counter;
                       Exit;
                   end
                   else if not SameText(AName, SubString(Strings[Counter], 1, Length(AName))) then
                       Break;
               end;
           end;
       end
       else                                                //  not sorted: look at every item
       begin
           Result := NOT_FOUND_INDEX;
           for Counter := 0 to Count - 1 do
           begin
               if SameText(AName, Strings[Counter]) or
                   SameText(AName + '=', SubString(Strings[Counter], 1, Length(AName) + 1)) then
               begin
                   Result := Counter;
                   Break;
               end;
           end;
       end;
   finally
       EndRead;
   end;
end;

function TCraftingStringList.IndexOfValue(const AValue : string) : System.Integer;
var
   Counter : Integer;
begin
   BeginRead;
   try
       Result := NOT_FOUND_INDEX;
       for Counter := 0 to Self.Count - 1 do
       begin
           if ValueStrings[Counter] = AValue then
           begin
               Result := Counter;
               Break;
           end;
       end;
   finally
       EndRead;
   end;
end;

function TCraftingStringList.IndexOfLeadingText(const AValue : string) : System.Integer;

   function BinarySearchLeadingText(AStart, AEnd : System.Integer) : System.Integer;
   var
       ThisString : string;
       ThisComparison : System.Integer;
   begin
       if AStart <= AEnd then
       begin
           Result := AStart + ((AEnd - AStart) div 2);
           ThisString := Copy(Strings[Result], 1, Length(AValue));
           ThisComparison := CompareText(AValue, ThisString);
           if ThisComparison <> 0 then
           begin
               if AStart = AEnd then                       //  one element
                   Result := NOT_FOUND_INDEX
               else if AStart + 1 = AEnd then              //    only two elements and AStart does not match
               begin
                   if ThisComparison < 0 then
                       Result := NOT_FOUND_INDEX
                   else
                       Result := BinarySearchLeadingText(AEnd, AEnd);
               end
               else if ThisComparison < 0 then
                   Result := BinarySearchLeadingText(AStart, Result)
               else if ThisComparison > 0 then
                   Result := BinarySearchLeadingText(Result, AEnd);
           end;
       end
       else
           Result := NOT_FOUND_INDEX;
   end;

var
   Counter : System.Integer;
begin
   Result := NOT_FOUND_INDEX;
   if Self.Sorted or (not SortDirty) then
       Result := BinarySearchLeadingText(0, Self.Count - 1)
   else
   begin
       for Counter := 0 to Self.Count - 1 do
       begin
           if SameText(AValue, Copy(Strings[Counter], 1, Length(AValue))) then
           begin
               Result := Counter;
               Exit;
           end;
       end;
   end;
end;

function TCraftingStringList.IndexOf(const AString : string) : Integer;
begin
   if (not Sorted) and SortDirty then
       Result := inherited IndexOf(AString)
   else if not Find(AString, Result) then
       Result := NOT_FOUND_INDEX;
end;

function TCraftingStringList.IndexOf(AnInt : Integer) : Integer;
begin
   Result := IndexOfObject(TObject(AnInt));
end;

function TCraftingStringList.Find(const AString : string) : Boolean;
var
   DummyIndex : System.Integer;
begin
   Result := Find(AString, DummyIndex);
end;

function TCraftingStringList.Find(const AString : string; var Index : Integer) : Boolean;
begin
   if (not Self.Sorted) and SortDirty then
   begin
       Index := Self.IndexOf(AString);
       Result := Index <> NOT_FOUND_INDEX;
   end
   else
       Result := inherited Find(AString, Index);
end;

function TCraftingStringList.Find(const AString : string; var FoundObject : TObject) : Boolean;
var
   ThisIndex : Integer;
begin
   Result := Find(AString, ThisIndex);
   if Result then
       FoundObject := Self.Objects[ThisIndex];
end;

function TCraftingStringList.Find(AInteger : System.Integer; var Index : Integer) : Boolean;
begin
   Result := Find(TObject(AInteger), Index);
end;

function TCraftingStringList.Find(AInteger : System.Integer; var FoundObject : TObject) : Boolean;
begin
   Result := Find(TObject(AInteger), FoundObject);
end;

function TCraftingStringList.Find(AnObject : TObject; var Index : Integer) : Boolean;
begin
   Index := Self.IndexOfObject(AnObject);
   Result := Index <> NOT_FOUND_INDEX;
end;

function TCraftingStringList.Find(AnObject : TObject; var FoundObject : TObject) : Boolean;
var
   Index : System.Integer;
begin
   Index := Self.IndexOfObject(AnObject);
   if Index <> NOT_FOUND_INDEX then
   begin
       Result := True;
       FoundObject := Objects[Index];
   end
   else
       Result := False;
end;

function TCraftingStringList.Open(const AString : string; AnObject : TObject) : System.Integer;
begin
   if not Find(AString, Result) then
       Result := AddObject(AString, AnObject);
end;

procedure TCraftingStringList.OpenFirst(const AString : string; AnObject : TObject = nil);
var
   Index : Integer;
begin
   if Find(AString, Index) then
       Delete(Index);
   InsertObject(0, AString, AnObject);
end;

procedure TCraftingStringList.ReadSections(AStrings : TStrings);
var
   Counter : System.Integer;
begin
   AStrings.Clear;
   for Counter := 0 to Count - 1 do
   begin
       if (Length(Strings[Counter]) > 2) and
           (Strings[Counter][1] = '[') and
           (Strings[Counter][Length(Strings[Counter])] = ']') then
       begin
           AStrings.AddObject(Copy(Strings[Counter], 2, Length(Strings[Counter]) - 2), TObject(Counter));
       end;
   end;
end;

procedure TCraftingStringList.ReadSection(const SectionName : string; AStrings : TStrings);
var
   Counter : System.Integer;
begin
   AStrings.Clear;
   Counter := IndexOf('[' + SectionName + ']');
   if Counter <> NOT_FOUND_INDEX then
   begin
       Inc(Counter);
       while (Counter < Count) and (Copy(Strings[Counter], 1, 1) <> '[') do
       begin
           if Trim(Strings[Counter]) <> EMPTY_STRING then
               AStrings.Add(Strings[Counter]);
       end;
   end;
end;

function TCraftingStringList.Get(Index : Integer) : string;
begin
   if Index < 0 then
       Inc(Index, Count);
   Result := inherited Get(Index);
end;

procedure TCraftingStringList.Put(Index : System.Integer; const Value : string);
var
   ThisObject : TObject;
begin
   if (not RemoveBlankStrings) or (Length(TrimLeft(Value)) > 0) then
   begin
       BeginUpdate;
       try
           if Index < 0 then
               Inc(Index, Count);                          //  negative indexes count from the last: -1 = (Count - 1)

           ThisObject := Objects[Index];
           if Sorted then                                  //  inherited Put will throw an exception
           begin
               Delete(Index);
               AddObject(Value, ThisObject);
           end
           else if Duplicates = dupIgnore then             //  and we're not sorted
           begin
               if not Find(Value) then
                   inherited Put(Index, Value);
           end
           else
               inherited Put(Index, Value);
       finally
           EndUpdate;
       end;
   end;
end;

procedure TCraftingStringList.InsertObject(Index : Integer; const AString : string; AnObject : TObject);
begin
   BeginUpdate;
   try
       if Sorted then
           AddObject(AString, AnObject)
       else if (Duplicates <> dupAccept) and Find(AString) then
       begin
           case Duplicates of
               dupIgnore : Exit;
               dupError : raise Exception.Create('Duplicate string: "' + AString + '"');
           end;
       end
       else
           inherited InsertObject(Index, AString, AnObject);
   finally
       EndUpdate;
   end;
end;

function TCraftingStringList.Add(const AString : string; AnInteger : Integer) : Integer;
begin
   Result := AddObject(AString, TObject(AnInteger));
end;

function TCraftingStringList.AddObject(const AString : string; AnObject : TObject) : Integer;
begin
   BeginUpdate;
   try
       if AString = EMPTY_STRING then
       begin
           if RemoveBlankStrings then
               Exit;
       end
       else if (not Sorted) and (Duplicates <> dupAccept) and Find(AString, Result) then
       begin
           case Duplicates of
               dupIgnore : Exit;
               dupError : raise Exception.Create('Duplicate string: "' + AString + '"');
           end;
       end;

       Result := inherited AddObject(AString, AnObject);
   finally
       EndUpdate;
   end;
end;

function TCraftingStringList.GetObject(Index : Integer) : TObject;
begin
   if Index < 0 then
       Inc(Index, Count);

   BeginRead;
   try
       Result := inherited GetObject(Index);
   finally
       EndRead;
   end;
end;

procedure TCraftingStringList.PutObject(Index : System.Integer; Value : TObject);
begin
   BeginUpdate;
   try
       if Index < 0 then
           Inc(Index, Count);

       inherited PutObject(Index, Value);
   finally
       EndUpdate;
   end;
end;

function TCraftingStringList.GetValueString(AIndex : Integer) : string;
begin
   Result := ExtractValue(Strings[AIndex]);
end;

procedure TCraftingStringList.SetValueString(AIndex : System.Integer; const Value : string);
var
   PosIndex : System.Integer;
begin
   PosIndex := Pos('=', Strings[AIndex]);
   if PosIndex = 0 then
       Strings[AIndex] := Strings[AIndex] + '=' + Value
   else
       Strings[AIndex] := Copy(Strings[AIndex], 1, PosIndex) + Value;
end;

function TCraftingStringList.GetLast : string;
begin
   Result := Strings[Count - 1];
end;

procedure TCraftingStringList.SetLast(const Value : string);
begin
   Strings[Count - 1] := Value;
end;

function TCraftingStringList.GetLastObject : TObject;
begin
   Result := Objects[Count - 1];
end;

procedure TCraftingStringList.SetLastObject(Value : TObject);
begin
   Objects[Count - 1] := Value;
end;

function TCraftingStringList.GetName(Index : Integer) : string;
begin
   Result := ExtractName(Strings[Index]);                  //  ancestor returns EMPTY_STRING if no '='
end;

procedure TCraftingStringList.SetName(Index : System.Integer; const Value : string);
begin
   Strings[Index] := Value + '=' + GetValue(Index);
end;

function TCraftingStringList.GetValue(Index : Integer) : string;
begin
   Result := ExtractValue(Strings[Index]);
end;

function TCraftingStringList.GetSeparatedText(const ASeparator : string) : string;
var
   ThisString : string;
begin
   Result := EMPTY_STRING;

   if First(ThisString) then
       repeat
           Result := Result + ASeparator + ThisString;
       until not Next(ThisString);

   System.Delete(Result, 1, Length(ASeparator));
end;

procedure TCraftingStringList.SetSeparatedText(const ASeparator : string; Value : string);
var
   Pointer : System.Integer;
begin
   Self.Clear;
   repeat
       Pointer := AnsiPos(ASeparator, Value);
       if Pointer = 0 then
           Add(Value)
       else
       begin
           Add(Copy(Value, 1, Pointer - 1));
           System.Delete(Value, 1, Pointer);
       end;
   until Pointer = 0;
end;

procedure TCraftingStringList.Fill(const AString : string);
var
   Counter : System.Integer;
begin
   BeginUpdate;
   try
       for Counter := 0 to Self.Count - 1 do
           Strings[Counter] := AString;
   finally
       EndUpdate;
   end;
end;

class function TCraftingStringList.ExtractName(const AString : string) : string;
begin
   Result := CopyTo(AString, '=', [soIgnoreQuotedText]);   //  copy the whole time if '=' not there
end;

class function TCraftingStringList.ExtractValue(const AString : string) : string;
begin
   Result := AString;
   StripTo(Result, '=', [soIgnoreQuotedText]);             //  strips the whole line away if '=' not there
end;

procedure TCraftingStringList.FreeObjects;
var
   Counter : System.Integer;
begin
   BeginUpdate;
   try
       for Counter := 0 to Count - 1 do
       begin
           Self.Objects[Counter].Free;
           Self.Objects[Counter] := nil;
       end;
   finally
       EndUpdate;
   end;
end;

procedure TCraftingStringList.LoadFromClipboard(AFormat : Word);
var
   Data : THandle;
   Buffer : PChar;
begin
   if AFormat = CF_TEXT then
       Self.Text := Clipboard.AsText
   else
   begin
       Clipboard.Open;
       Data := GetClipboardData(AFormat);
       try
           if Data <> 0 then
           begin
               Buffer := PChar(GlobalLock(Data));
               Self.Text := string(Buffer);
           end
           else
               Self.Clear;
       finally
           if Data <> 0 then
               GlobalUnlock(Data);
           Clipboard.Close;
       end;
   end;
end;

procedure TCraftingStringList.SaveToClipboard(AFormat : Word);
var
   Buffer : string;
   Data : THandle;
   DataPtr : Pointer;
begin
   Buffer := Self.Text;
   UniqueString(Buffer);
   if AFormat = CF_TEXT then
       Clipboard.AsText := Buffer
   else
   begin
       Clipboard.Open;
       try
           Data := Windows.GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, Length(Buffer));
           try
               DataPtr := GlobalLock(Data);
               try
                   System.Move(PChar(Buffer)^, DataPtr^, Length(Buffer));
                   Windows.EmptyClipboard;
                   Windows.SetClipboardData(AFormat, Data);
               finally
                   Windows.GlobalUnlock(Data);
               end;
           except
               GlobalFree(Data);
               raise;
           end;
       finally
           Clipboard.Close;
       end;
   end;
end;

function TCraftingStringList.FindName(const AName : string) : Boolean;
var
   DummyIndex : System.Integer;
begin
   Result := FindName(AName, DummyIndex);
end;

function TCraftingStringList.FindName(const AName : string; var Index : System.Integer) : Boolean;
begin
   Index := IndexOfName(AName);
   Result := Index <> NOT_FOUND_INDEX;
end;

function TCraftingStringList.FindName(const AName : string; var AValue : string) : Boolean;
var
   Index : System.Integer;
begin
   Result := FindName(AName, Index);
   if Result then
       AValue := ValueStrings[Index]
   else
       AValue := EMPTY_STRING;
end;

function TCraftingStringList.Find(AnObject : TObject; var FoundString : string) : Boolean; //  overloaded version of Find
var
   Index : System.Integer;
begin
   Result := Find(AnObject, Index);
   if Result then
       FoundString := Strings[Index]
   else
       FoundString := EMPTY_STRING;
end;

function TCraftingStringList.Find(AInteger : System.Integer; var FoundString : string) : Boolean; //  overloaded version of Find
var
   Index : System.Integer;
begin
   Result := Find(AInteger, Index);
   if Result then
       FoundString := Strings[Index]
   else
       FoundString := EMPTY_STRING;
end;

function TCraftingStringList.FindValue(const AValue : string; var Index : Integer) : Boolean;
begin
   Index := IndexOfValue(AValue);
   Result := Index <> NOT_FOUND_INDEX;
end;

function TCraftingStringList.FindValue(const AValue : string; var AFoundObject : TObject) : Boolean;
var
   Index : System.Integer;
begin
   Result := FindValue(AValue, Index);
   if Result then
       AFoundObject := Objects[Index]
   else
       AFoundObject := nil;
end;

function TCraftingStringList.LockList : TCraftingStringList;
begin
   if not IsLocked then
   begin
       if not IsLockInitialized then
           Windows.InitializeCriticalSection(FLock);
       Windows.EnterCriticalSection(FLock);
       IsLocked := True;
   end;
   Result := Self;
end;

procedure TCraftingStringList.UnlockList;
begin
   if IsLocked then
       Windows.LeaveCriticalSection(FLock);
end;

function TCraftingStringList.GetReadWriteLock : TMultiReadExclusiveWriteSynchronizer;
begin
   if FReadWriteLock = nil then
       FReadWriteLock := TMultiReadExclusiveWriteSynchronizer.Create;
   Result := FReadWriteLock;
end;

procedure TCraftingStringList.SetIsLockedOnUpdate(Value : Boolean);
begin
   if FIsLockedOnUpdate <> Value then
   begin
       FIsLockedOnUpdate := Value;
       if Value then
       begin
           if UpdateCount > 0 then
               ReadWriteLock.BeginWrite

           else if FReadCounter > 0 then
               ReadWriteLock.BeginRead;
       end
       else
       begin
           FReadWriteLock.Free;
           FReadWriteLock := nil;
       end;
   end;
end;

//     TStringList.BeginUpdate and EndUpdate call this

procedure TCraftingStringList.SetUpdateState(Updating : Boolean);
begin
   {TODO: this really won't work because Thread1 can call BeginUpdate and Thread2.BeginUpdate should wait for it  }
   {TODO: need a lock on Updating here    }

   inherited;

   if LockOnUpdate then
   begin
       if Updating then
           ReadWriteLock.BeginWrite
       else
           ReadWriteLock.EndWrite;
   end;
end;

procedure TCraftingStringList.BeginRead;
begin
   {TODO: need a lock on FReadCounter here    }
   Inc(FReadCounter);
   if (FReadCounter = 1) and LockOnUpdate then
       ReadWriteLock.BeginRead;
end;

procedure TCraftingStringList.EndRead;
begin
   {TODO: need a lock on FReadCounter here    }
   if (FReadCounter = 1) and LockOnUpdate then
       ReadWriteLock.EndRead;

   if FReadCounter > 0 then
       Dec(FReadCounter);
end;

function TCraftingStringList.GetInteger(Index : Integer) : Integer;
begin
   Result := System.Integer(Objects[Index]);
end;

procedure TCraftingStringList.SetInteger(Index, Value : Integer);
begin
   Objects[Index] := TObject(Value);
end;

procedure TCraftingStringList.CustomSort(Compare : TStringListSortCompare);
begin
   inherited;
   FSortDirty := False;
end;

procedure TCraftingStringList.Changed;
begin
   inherited;
   FSortDirty := True;
end;

function TCraftingStringList.BreakApart(AString : string; const Token : string; Options : TStripOptions) : Integer;
begin
   if Token = '' then
       Result := Self.BreakApart(AString, [#9, #10, #13, ' '], Options)
   else
       Result := Self.BreakApart(AString, [Token], Options);
end;

function TCraftingStringList.BreakApart(AString : string; const Tokens : array of string; Options : TStripOptions) : Integer;
begin
   Result := uCraftClass.BreakApart(AString, Tokens, Self, Options);
end;

procedure TCraftingStringList.SetRemoveBlankStrings(Value : Boolean);
var
   Counter : System.Integer;
begin
   if RemoveBlankStrings <> Value then
   begin
       FRemoveBlankStrings := Value;
       if Value then
       begin
           for Counter := Count - 1 downto 0 do
           begin
               if Length(TrimLeft(Strings[Counter])) = 0 then
                   Delete(Counter);
           end;
       end;
   end;
end;

function TCraftingStringList.GetString(Index : Integer) : string;
begin
   BeginRead;
   try
       if Count > Index then
           Result := inherited Strings[Index]
       else
           Result := EMPTY_STRING;
   finally
       EndRead;
   end;
end;

procedure TCraftingStringList.SetString(Index : Integer; const Value : string);
begin
   while Count <= Index do
       Add(EMPTY_STRING);
   inherited Strings[Index] := Value;
end;

function TCraftingStringList.CommaSubText(AStartingIndex, ACount : Integer) : string;
var
   SubList : TCraftingStringList;
   Counter : System.Integer;
begin
   if (AStartingIndex > 0) or (ACount < Self.Count) then
   begin
       if ACount < 0 then                                  //  -1 => one from the right
           ACount := Self.Count - AStartingIndex + ACount

       else if ACount > (Self.Count - AStartingIndex) then
           ACount := Self.Count - AStartingIndex;

       SubList := TCraftingStringList.Create;
       try
           for Counter := AStartingIndex to AStartingIndex + ACount - 1 do
               SubList.Add(Self.Strings[Counter]);

           Result := SubList.CommaText;
       finally
           SubList.Free;
       end;
   end
   else
       Result := Self.CommaText;
end;

function TCraftingStringList.Pop : string;
var
   Dummy : TObject;
begin
   Result := Pop(Dummy);
end;

function TCraftingStringList.Pop(var AnObject : TObject) : string;
begin
   Result := Top(AnObject);
   if Count > 0 then
       Self.Delete(Self.Count - 1);
end;

function TCraftingStringList.PopInt : Integer;
var
   ThisObject : TObject;
begin
   Pop(ThisObject);
   Result := Integer(ThisObject);
end;

function TCraftingStringList.Push(const AString : string; AnObject : TObject = nil) : Integer;
begin
   Result := Self.AddObject(AString, AnObject);
end;

function TCraftingStringList.PushInt(AnInteger : Integer) : Integer;
begin
   Result := Self.AddObject(IntToStr(AnInteger), TObject(AnInteger));
end;

function TCraftingStringList.Top : string;
var
   Dummy : TObject;
begin
   Result := Top(Dummy);
end;

function TCraftingStringList.Top(var AnObject : TObject) : string;
begin
   if Count > 0 then
   begin
       Result := Self.Last;
       AnObject := Self.LastObject;
   end
   else
   begin
       Result := EMPTY_STRING;
       AnObject := nil;
   end;
end;

{                              //  code like this
if First(ThisString) then
repeat
Process(ThisString);
until not Next(ThisString);
}

function TCraftingStringList.First(var AString : string) : Boolean;
begin
   FCurrentNextIndex := NOT_FOUND_INDEX;
   Result := Next(AString);
end;

function TCraftingStringList.Next(var AString : string) : Boolean;
begin
   Result := (FCurrentNextIndex < (Self.Count - 1));
   if Result then
   begin
       Inc(FCurrentNextIndex);
       AString := Strings[FCurrentNextIndex];
   end;
end;

function TCraftingStringList.FirstName(var AName : string) : Boolean;
begin
   FCurrentNextNameIndex := NOT_FOUND_INDEX;
   Result := NextName(AName);
end;

function TCraftingStringList.NextName(var AName : string) : Boolean;
begin
   Result := (FCurrentNextNameIndex < (Self.Count - 1));
   if Result then
   begin
       Inc(FCurrentNextNameIndex);
       AName := Names[FCurrentNextNameIndex];
   end;
end;

{ TAutoStringList }

class function TAutoStringList.NewInstance : TObject;
begin
   Result := inherited NewInstance;
   TAutoStringList(Result).FRefCount := 1;                 //  prevent accidental release
end;

procedure TAutoStringList.AfterConstruction;
begin
   inherited;
   FRefCount := 0;
end;

function TAutoStringList.GetCommaText : string;
begin
   Result := inherited CommaText;
end;

procedure TAutoStringList.SetCommaText(const Value : string);
begin
   inherited CommaText := Value;
end;

function TAutoStringList.GetValue(const Name : string) : string;
begin
   Result := inherited Values[Name];
end;

procedure TAutoStringList.SetValue(const Name, Value : string);
begin
   inherited Values[Name] := Value;
end;

function TAutoStringList.StringsObject : TStrings;
begin
   Result := Self;
end;

function TAutoStringList.QueryInterface(const IID : TGUID; out Obj) : HResult;
begin
   Result := 0;                                            //  don't support anything
end;

function TAutoStringList._AddRef : System.Integer;
begin
   Inc(FRefCount);
   Result := FRefCount;
end;

function TAutoStringList._Release : System.Integer;
begin
   Dec(FRefCount);
   Result := FRefCount;
   if Result <= 0 then
       Self.Free;
end;

function TAutoStringList.GetName(Index : Integer) : string;
begin
   Result := inherited Names[Index];
end;

function TAutoStringList.GetValueString(Index : Integer) : string;
begin
   Result := inherited GetValueString(Index);
end;

procedure TAutoStringList.SetValueString(Index : Integer; const Value : string);
begin
   inherited SetValueString(Index, Value);
end;

{  TCraftingFileStream }

constructor TCraftingFileStream.Create(const AFileName : string; Flags : Word);
begin
   inherited Create(AFileName, Flags);
   FCreateFlags := Flags;
   FFileName := AFileName;
end;

constructor TCraftingFileStream.Open(const AFileName : string; Flags : Word);
begin
   Append(AFileName, Flags);
end;

constructor TCraftingFileStream.CreateNew(const AFileName : string; Flags : Word);
begin
   Create(AFileName, fmCreate or Flags);
end;

constructor TCraftingFileStream.Append(const AFileName : string; Flags : Word);
begin
   if FileExists(AFileName) then
   try
       Create(AFileName, fmOpenReadWrite or Flags);
       Position := Size;
       Exit;
   except
   end;
   CreateNew(AFileName);
end;

constructor TCraftingFileStream.ReadOnly(const AFileName : string; Flags : Word);
begin
   Create(AFileName, fmOpenRead or Flags);
end;

function TCraftingFileStream.Write(const AString : string) : LongInt; //  this should be in TStream dammit
begin
   Result := Write(PAnsiChar(AString)^, Length(AString));
end;

function TCraftingFileStream.WriteLine(AString : string) : LongInt;
begin
   if Copy(AString, Length(AString) - 1, 2) <> #13#10 then
       AString := AString + #13#10;
   Result := Write(AString);
end;

function TCraftingFileStream.Write(const Buffer; ACount : LongInt; APosition : LongInt) : LongInt;
begin
   Self.Position := APosition;
   Result := Write(Buffer, ACount);
end;

function TCraftingFileStream.Write(const Buffer; ACount : LongInt) : LongInt;
begin
   if IsBufferedTextCurrent then
       Seek(0, soCurrent);                                 //  put the file position to where the caller thinks it is

   Result := inherited Write(Buffer, ACount);

   IsBufferedTextCurrent := False;
end;

function TCraftingFileStream.ReadLine : string;
var
   ThisChar : Char;
begin
   Result := EMPTY_STRING;
   while (Position < Size) and (Read(ThisChar, SizeOf(Char)) = SizeOf(Char)) and (not (ThisChar in [#13, #10, #0])) do
       Result := Result + ThisChar;

   if (Position < Size) and (ThisChar = #13) then
   begin
       if (Read(ThisChar, SizeOf(Char)) = SizeOf(Char)) and (ThisChar <> #10) then
           Position := Position - 1;
   end;
end;

function TCraftingFileStream.GetText : string;
begin
   if not IsBufferedTextCurrent then
   begin
       Self.Position := 0;
       SetLength(FText, Self.Size);
       SetLength(FText, Read(PAnsiChar(FText)^, Self.Size)); //  set to the actual length
       IsBufferedTextCurrent := True;
   end;
   Result := FText;
end;

procedure TCraftingFileStream.SetText(const Value : string);
begin
   if (Self.CreateFlags and (fmOpenWrite or fmOpenReadWrite)) <> 0 then
   begin
       Position := 0;
       Write(Value);
   end
   else
       raise Exception.Create('Cannot set text on a read-only file');
end;

function TCraftingFileStream.ReadString(ACount : LongInt) : string;
var
   ReadCount : Integer;
begin
   SetLength(Result, ACount);
   ReadCount := Read(PChar(Result)^, ACount);
   if ReadCount <> ACount then
       SetLength(Result, ReadCount);
end;

function TCraftingFileStream.Read(var Buffer; ACount : LongInt; APosition : LongInt) : LongInt;
begin
   Self.Position := APosition;
   Result := Read(Buffer, ACount);
end;

function TCraftingFileStream.Read(var Buffer; ACount : LongInt) : LongInt;
var
   OldLength : Integer;
begin
   if ReadsBuffered and (ReadBufferSize > 0) and (Length(FReadBuffer) > 0) then
   begin
       if ACount <= Length(FReadBuffer) then
       begin
           Move(PChar(FReadBuffer)^, Buffer, ACount);
           Delete(FReadBuffer, 1, ACount);
           Result := ACount;
       end
       else
       begin
           OldLength := Length(FReadBuffer);
           SetLength(FReadBuffer, ACount);
           Result := OldLength + inherited Read((PChar(FReadBuffer) + OldLength)^, ACount - OldLength);
           Move(PChar(FReadBuffer)^, Buffer, Result);

           FReadBuffer := EMPTY_STRING;
           SetLength(FReadBuffer, ReadBufferSize);
           OldLength := inherited Read(PChar(FReadBuffer)^, ReadBufferSize);
           if OldLength <> ReadBufferSize then
               SetLength(FReadBuffer, OldLength);
       end;
   end
   else
       Result := inherited Read(Buffer, ACount);
end;

function TCraftingFileStream.Seek(const Offset : Int64; Origin : TSeekOrigin) : Int64;
begin
   if ReadsBuffered and (Length(FReadBuffer) > 0) then
   begin
       case Origin of
           soBeginning : Result := inherited Seek(Offset, Origin);
           soCurrent : Result := inherited Seek(Offset - Length(FReadBuffer), Origin);
       else
           {soEnd : }Result := inherited Seek(Offset, Origin);
       end;
       FReadBuffer := EMPTY_STRING;                        //  clear the read buffer
   end
   else
       Result := inherited Seek(Offset, Origin);
end;

{   TRecursiveStringList	}

constructor TRecursiveStringList.Create;
begin
   inherited;
   AutoFreeObjects := True;
end;

function TRecursiveStringList.GetParent(const AParentName : string) : TRecursiveStringList;
var
   Index : Integer;
begin
   Index := IndexOf(AParentName);
   if (Index = -1) then
       Index := Add(AParentName);

   if Objects[Index] = nil then
   begin
       Result := TRecursiveStringList.Create;
       Objects[Index] := Result;
       Result.Parent := Self;
       Result.Sorted := Self.Sorted;
   end
   else
       Result := ChildLists[Index];
end;

function TRecursiveStringList.GetChildList(Index : Integer) : TRecursiveStringList;
begin
   Result := Objects[Index] as TRecursiveStringList;
end;

function TRecursiveStringList.DescendantCount : Integer;
var
   Counter : Integer;
begin
   Result := Self.Count;
   for Counter := 0 to Self.Count - 1 do
   begin
       if Objects[Counter] is TRecursiveStringList then
           Inc(Result, ChildLists[Counter].DescendantCount); //	recursive
   end;
end;

const
   CHILD_INDENTATION = 4;

procedure TRecursiveStringList.AssignTo(Target : TPersistent);

   procedure AddChildStrings(AList : TRecursiveStringList; AnIndentation : Integer);
   var
       Counter : Integer;
       ThisIndentation : string;
   begin
       ThisIndentation := StringOfChar(' ', AnIndentation);
       for Counter := 0 to AList.Count - 1 do
       begin
           TStrings(Target).Add(ThisIndentation + AList.Strings[Counter]);
           if AList.Objects[Counter] is TRecursiveStringList then
               AddChildStrings(AList.ChildLists[Counter], AnIndentation + CHILD_INDENTATION); //	recursive
       end;
   end;

begin
   if Target is TStrings then
   begin
       TStrings(Target).Clear;
       AddChildStrings(Self, 0);
   end
   else
       inherited AssignTo(Target);
end;

function TRecursiveStringList.IndentedText : string;
var
   ThisList : TStringList;
begin
   ThisList := TStringList.Create;
   try
       Self.AssignTo(ThisList);
       Result := ThisList.Text;
   finally
       ThisList.Free;
   end;
end;

const
   NO_QUOTE = #0;

function CopyTo(AString : string; const ADelimiter : string; Options : TStripOptions) : string;
begin
   if ADelimiter = EMPTY_STRING then
   begin
       Include(Options, soTrimExtraDelimiters);
       Result := CopyTo(AString, [' ', #9, #13, #10], Options); //  default to whitespace
   end
   else
       Result := CopyTo(AString, [ADelimiter], Options);
end;

function CopyTo(AString : string; const Delimiters : array of string; Options : TStripOptions) : string;
var
   DummyString : string;
begin
   Result := CopyTo(AString, Delimiters, DummyString, Options);
end;

function CopyTo(AString : string; const Delimiters : array of string;
   var ADelimiter : string; Options : TStripOptions) : string;
begin
   //         AString is not var, so any changes to it are lost to the caller
   Result := StripTo(AString, Delimiters, ADelimiter, Options);
end;

function StripTo(var AString : string; const ADelimiter : string; Options : TStripOptions) : string;
begin
   if ADelimiter = EMPTY_STRING then
   begin
       Include(Options, soTrimExtraDelimiters);
       Result := StripTo(AString, [' ', #9, #13, #10], Options); //  default to whitespace
   end
   else
       Result := StripTo(AString, [ADelimiter], []);
end;

function StripTo(var AString : string; const Delimiters : array of string; Options : TStripOptions) : string;
var
   DummyString : string;
begin
   Result := StripTo(AString, Delimiters, DummyString, Options);
end;

function StripTo(var AString : string; const Delimiters : array of string;
   var ADelimiter : string; Options : TStripOptions) : string;
var
   FirstCharOptimization : string;
   AreAllFirstCharactersTheSame : Boolean;
   AreAnyFirstLettersDuplicated : Boolean;
   IsAllOneCharacterDelimiters : Boolean;

   function StripAt(StringIndex : System.Integer; var ReturnValue : string) : Boolean;
   var
       DelimiterCounter, DelimiterIndex, MaxMatchingDelimiterLength, MaxMatchingDelimiterIndex : System.Integer;
       DummyResult : string;
       ThisChar : AnsiChar;
   begin
       Result := False;

       Assert(StringIndex <= Length(AString));
       if soCaseInsensitive in Options then
           ThisChar := AnsiUpperCase(AString[StringIndex])[1]
       else
           ThisChar := AString[StringIndex];

       if FindAnsiPos(ThisChar, FirstCharOptimization, DelimiterIndex) then
       begin
           Dec(DelimiterIndex, 1 - Low(Delimiters));       //  correct the 1-based index to an array offset
           if IsAllOneCharacterDelimiters then
           begin
               ReturnValue := Copy(AString, 1, StringIndex - 1);
               Delete(AString, 1, StringIndex + (Length(Delimiters[DelimiterIndex]) - 1));
               ADelimiter := Delimiters[DelimiterIndex];
               Result := True;
           end
           else
           begin
               MaxMatchingDelimiterLength := 0;
               MaxMatchingDelimiterIndex := NOT_FOUND_INDEX;

               //  if there are duplicate first letters, DelimiterIndex will point to the first one
               for DelimiterCounter := DelimiterIndex to High(Delimiters) do
               begin
                   ADelimiter := Delimiters[DelimiterCounter];
                   if (Length(ADelimiter) > MaxMatchingDelimiterLength) and
                       (((soCaseInsensitive in Options) and
                       AnsiSameText(Copy(AString, StringIndex, Length(ADelimiter)), ADelimiter)) or
                       ((not (soCaseInsensitive in Options)) and
                       AnsiSameStr(Copy(AString, StringIndex, Length(ADelimiter)), ADelimiter))) then
                   begin
                       MaxMatchingDelimiterLength := Length(ADelimiter);
                       MaxMatchingDelimiterIndex := DelimiterCounter;
                       Result := True;
                       if not AreAnyFirstLettersDuplicated then //        keep looking for a better (longer) match
                           Break;
                   end;
               end;
               if Result then
               begin
                   ADelimiter := Delimiters[MaxMatchingDelimiterIndex];
                   ReturnValue := Copy(AString, 1, StringIndex - 1);
                   Delete(AString, 1, StringIndex + (Length(ADelimiter) - 1));
               end;
           end;
       end;
       if Result and (soTrimExtraDelimiters in Options) then
       begin
           while (Length(AString) > 0) and StripAt(1, DummyResult) do //        remove multiple delimiters following the first matching delimiter
               ;
       end;
   end;
var
   StringCounter, DelimiterCounter, DelimiterIndex, DuplicateFirstLetterIndex : System.Integer;
   MinDelimiterLength : System.Integer;
   PreviousQuote, ThisDelimiter : string;
   ThisChar : AnsiChar;
begin
   if (Low(Delimiters) = High(Delimiters)) and (not (soIgnoreQuotedText in Options)) then //   one delimiter
   begin
       if soCaseInsensitive in Options then
           DelimiterIndex := AnsiPos(AnsiUpperCase(Delimiters[Low(Delimiters)]), AnsiUpperCase(AString))
       else
           DelimiterIndex := AnsiPos(Delimiters[Low(Delimiters)], AString);

       if DelimiterIndex > 0 then                          //  found the first letter of the sole delimiter
       begin
           ADelimiter := Delimiters[Low(Delimiters)];
           Result := Copy(AString, 1, DelimiterIndex - 1);
           Delete(AString, 1, DelimiterIndex + (Length(ADelimiter) - 1));

           if soTrimExtraDelimiters in Options then
           begin
               if soCaseInsensitive in Options then
               begin
                   while AnsiSameText(ADelimiter, Copy(AString, 1, Length(ADelimiter))) do
                       Delete(AString, 1, Length(ADelimiter));
               end
               else
               begin
                   while AnsiSameStr(ADelimiter, Copy(AString, 1, Length(ADelimiter))) do
                       Delete(AString, 1, Length(ADelimiter));
               end;
           end;

           Exit;                                           //  ================>>> found a delimiter
       end;
   end
   else
   begin
       PreviousQuote := EMPTY_STRING;
       SetLength(FirstCharOptimization, (High(Delimiters) - Low(Delimiters) + 1));
       AreAllFirstCharactersTheSame := True;
       AreAnyFirstLettersDuplicated := False;

       ThisDelimiter := Delimiters[Low(Delimiters)];
       MinDelimiterLength := Length(ThisDelimiter);
       IsAllOneCharacterDelimiters := (Length(ThisDelimiter) = 1);

       if soCaseInsensitive in Options then
           FirstCharOptimization := AnsiUpperCase(ThisDelimiter[1])
       else
           FirstCharOptimization := ThisDelimiter[1];

       for DelimiterCounter := Low(Delimiters) + 1 to High(Delimiters) do
       begin
           ThisDelimiter := Delimiters[DelimiterCounter];

           if soCaseInsensitive in Options then
               ThisChar := AnsiUpperCase(ThisDelimiter[1])[1]
           else
               ThisChar := ThisDelimiter[1];

           DuplicateFirstLetterIndex := AnsiPos(ThisChar, FirstCharOptimization);
           if DuplicateFirstLetterIndex <> 1 then          //  not already on the list or not matching the first delimiter's first character
               AreAllFirstCharactersTheSame := False;

           if DuplicateFirstLetterIndex <> 0 then          //  found on the list, therefore it duplicates someone
               AreAnyFirstLettersDuplicated := True;

           FirstCharOptimization := FirstCharOptimization + ThisChar;

           if Length(ThisDelimiter) < MinDelimiterLength then
               MinDelimiterLength := Length(ThisDelimiter)

           else if Length(ThisDelimiter) > 1 then
               IsAllOneCharacterDelimiters := False;
       end;

       for StringCounter := 1 to (Length(AString) - (MinDelimiterLength - 1)) do
       begin
           ThisChar := AString[StringCounter];
           if (soIgnoreQuotedText in Options) and (ThisChar in ['''', '"']) then
           begin
               if PreviousQuote = AString[StringCounter] then
                   PreviousQuote := EMPTY_STRING
               else if PreviousQuote = EMPTY_STRING then
                   PreviousQuote := AString[StringCounter];
           end
           else if (PreviousQuote = EMPTY_STRING) then
           begin
               //                         test the character
               if ((not AreAllFirstCharactersTheSame) or (ThisChar = FirstCharOptimization[1])) then
               begin
                   if StripAt(StringCounter, Result) then
                       Exit;                               //  ================>>> found a delimiter
               end;
           end;
       end;
   end;

   //         failed to find any matches: return the entire source string
   ADelimiter := EMPTY_STRING;
   Result := AString;
   AString := EMPTY_STRING;
end;

function StripNot(var AString : string; const ADelimiter : string; Options : TStripOptions) : string;
begin
   Result := StripNot(AString, [ADelimiter], Options);
end;

function StripNot(var AString : string; const Delimiters : array of string; Options : TStripOptions) : string;
var
   Dummy : string;
begin
   Result := StripNot(AString, Delimiters, Dummy, Options);
end;

function StripNot(var AString : string; const Delimiters : array of string;
   var ADelimiter : string; Options : TStripOptions) : string;
var
   StringCounter, DelimiterIndex, DelimiterCounter : System.Integer;
   PreviousQuote, FirstCharOptimization : string;
   IsAllOneCharacterDelimiters, Found : Boolean;
begin
   IsAllOneCharacterDelimiters := True;
   for DelimiterCounter := Low(Delimiters) to High(Delimiters) do
   begin
       FirstCharOptimization := FirstCharOptimization + Delimiters[DelimiterCounter][1];
       if Length(Delimiters[DelimiterCounter]) > 1 then    //  if there are duplicate first letters, then the delimiters will be multi-letter
           IsAllOneCharacterDelimiters := False;
   end;
   PreviousQuote := EMPTY_STRING;
   for StringCounter := 1 to Length(AString) do
   begin
       if (soIgnoreQuotedText in Options) and (AString[StringCounter] in ['''', '"']) then
       begin
           if PreviousQuote = AString[StringCounter] then
               PreviousQuote := EMPTY_STRING
           else if PreviousQuote = EMPTY_STRING then
               PreviousQuote := AString[StringCounter];
       end;
       if (PreviousQuote = EMPTY_STRING) then
       begin
           DelimiterIndex := Pos(AString[StringCounter], FirstCharOptimization);
           Found := DelimiterIndex > 0;
           if Found and (not IsAllOneCharacterDelimiters) then
           begin
               Found := False;
               for DelimiterCounter := (DelimiterIndex - 1) to High(Delimiters) do //  delimiter array starts at zero (0)
               begin
                   if AnsiSameStr(Copy(AString, StringCounter, Length(Delimiters[DelimiterCounter])), Delimiters[DelimiterCounter]) then
                   begin
                       Found := True;
                       Break;
                   end;
               end;
           end;
           if not Found then
           begin
               Result := Copy(AString, 1, StringCounter - 1);
               Delete(AString, 1, StringCounter - 1);
               Exit;
           end;
       end;
   end;
   Result := AString;
   AString := EMPTY_STRING;
end;

function StripIf(var AString : string; ADelimiter : string; Options : TStripOptions) : string;
var
   ThisStringArray : array[0..0] of string;
begin
   if ADelimiter = EMPTY_STRING then
   begin
       Include(Options, soTrimExtraDelimiters);
       Result := StripIf(AString, [' ', #9, #13, #10], Options);
   end
   else
   begin
       ThisStringArray[0] := ADelimiter;
       Result := StripIf(AString, ThisStringArray, Options);
   end;
end;

function StripIf(var AString : string; const Delimiters : array of string; Options : TStripOptions) : string;
var
   DummyString : string;
begin
   Result := StripIf(AString, Delimiters, DummyString, Options);
end;

function StripIf(var AString : string; const Delimiters : array of string;
   var ADelimiter : string; Options : TStripOptions) : string;
begin
   Result := StripTo(AString, Delimiters, ADelimiter, Options);
   if ADelimiter = EMPTY_STRING then
   begin
       AString := Result;
       Result := EMPTY_STRING;
   end;
end;

function CopyIf(AString : string; const ADelimiter : string; Options : TStripOptions) : string;
begin
   if ADelimiter = EMPTY_STRING then
   begin
       Include(Options, soTrimExtraDelimiters);
       Result := CopyIf(AString, [' ', #9, #13, #10], Options);
   end
   else
       Result := CopyIf(AString, [ADelimiter], Options);
end;

function CopyIf(AString : string; const Delimiters : array of string; Options : TStripOptions) : string;
var
   DummyString : string;
begin
   Result := CopyIf(AString, Delimiters, DummyString, Options);
end;

function CopyIf(AString : string; const Delimiters : array of string;
   var ADelimiter : string; Options : TStripOptions) : string;
begin
   Result := CopyTo(AString, Delimiters, ADelimiter, Options);
   if ADelimiter = EMPTY_STRING then
   begin
       AString := Result;
       Result := EMPTY_STRING;
   end;
end;

function StripFrom(var AString : string; const ADelimiter : string; Options : TStripOptions) : string;
var
   Counter : System.Integer;
begin
   if ADelimiter <> EMPTY_STRING then
   begin
       Counter := Length(AString);
       while Counter >= 1 do
       begin
           if (AString[Counter] = ADelimiter[1]) then
           begin
               if (Length(ADelimiter) = 1) or (Copy(AString, Counter, Length(ADelimiter)) = ADelimiter) then
               begin
                   Result := Copy(AString, Counter + 1, MaxInt);

                   if soTrimExtraDelimiters in Options then
                       repeat
                           Dec(Counter, Length(ADelimiter));
                       until (Counter = 0) or (Copy(AString, Counter, Length(ADelimiter)) <> ADelimiter);

                   Delete(AString, Counter + 1, MaxInt);
                   Exit;
               end
               else
                   Dec(Counter, Length(ADelimiter));
           end
           else
               Dec(Counter);
       end;
   end;
   Result := AString;
   AString := EMPTY_STRING;
end;

function StripFromIf(var AString : string; const ADelimiter : string; Options : TStripOptions) : string;
begin
   Result := StripFrom(AString, ADelimiter, Options);
   if AString = EMPTY_STRING then
   begin
       AString := Result;
       Result := EMPTY_STRING;
   end;
end;

function StripQuotedText(var AString : string) : string;
begin
   Result := StripDelimitedText(AString, '"', '"', [soSkipToFirstDelimiter]);
end;

function StripQuotedText(var AString : string; Options : TStripOptions) : string;
begin
   Result := StripDelimitedText(AString, '"', '"', Options);
end;

function StripDelimitedText(var AString : string; StartDelimiter, EndDelimiter : string; Options : TStripOptions) : string;
var
   DepthCounter : Integer;
   ThisText, ThisPiece, ThisDelimiter, Prefix : string;
begin
   Result := EMPTY_STRING;

   Prefix := EMPTY_STRING;
   ThisText := AString;
   if EndDelimiter = EMPTY_STRING then
       EndDelimiter := StartDelimiter;

   if Copy(ThisText, 1, Length(StartDelimiter)) = StartDelimiter then
       Delete(ThisText, 1, Length(StartDelimiter))

   else if (soSkipToFirstDelimiter in Options) then
   begin
       Prefix := StripIf(ThisText, StartDelimiter, Options - [soTrimExtraDelimiters]); //  we will only trim symmetrical delimiters
       if Prefix = EMPTY_STRING then                       //  if the first character is StartDelimiter, we would have found it above
           Exit;                                           //  no delimited text at all
   end;

   //                  else assume we are already inside the first delimiter
   DepthCounter := 1;

   while (ThisText <> EMPTY_STRING) and (DepthCounter >= 1) do
   begin
       ThisPiece := StripIf(ThisText, [StartDelimiter, EndDelimiter], ThisDelimiter, Options - [soTrimExtraDelimiters]); //  we will only trim symmetrical delimiters

       if (ThisDelimiter = EndDelimiter) and (DepthCounter >= 1) then //  if the delimiters are the same, assume we exit the previous state
           Dec(DepthCounter)
       else if ThisDelimiter = StartDelimiter then
           Inc(DepthCounter)
       else
           Break;                                          //  no more delimiters at all; ThisPiece is empty

       if DepthCounter >= 1 then                           //      remove the closing delimiter
           ThisPiece := ThisPiece + ThisDelimiter;         //  but preserve nested delimiters

       Result := Result + ThisPiece;
   end;

   if DepthCounter > 0 then                                //  unbalanced: we did not find matching delimiters
       Result := EMPTY_STRING
   else
   begin
       AString := Prefix + ThisText;                       //  restore the leading text before the first delimiter

       if soTrimExtraDelimiters in Options then
       begin

           while (SubString(Result, 1, Length(StartDelimiter)) = StartDelimiter) and
               (SubString(Result, 0 - Length(EndDelimiter)) = EndDelimiter) do
           begin
               Result := SubString(Result, Length(StartDelimiter) + 1, 0 - Length(EndDelimiter)); //  trim the outermost delimiters
           end;
       end;

   end;
end;

function ExtractQuotedText(const AString : string) : string;
var
   SingleIndex, DoubleIndex : Integer;
begin
   Result := EMPTY_STRING;

   SingleIndex := Pos('''', AString);
   DoubleIndex := Pos('"', AString);

   if SingleIndex + DoubleIndex > 0 then
   begin
       if (SingleIndex = 0) then
           Result := ExtractDelimitedText(AString, '"', '"', [soSkipToFirstDelimiter])

       else if (DoubleIndex = 0) or (SingleIndex < DoubleIndex) then
           Result := ExtractDelimitedText(AString, '''', '''', [soSkipToFirstDelimiter])

       else
           Result := ExtractDelimitedText(AString, '"', '"', [soSkipToFirstDelimiter]);
   end;
end;

function ExtractDelimitedText(const AString : string; StartDelimiter, EndDelimiter : string; Options : TStripOptions) : string;
var
   ThisString : string;
begin
   ThisString := AString;                                  //  don't change the original string
   Result := StripDelimitedText(ThisString, StartDelimiter, EndDelimiter, Options);
end;

function IsDelimitedText(const AString : string; const StartDelimiter, EndDelimiter : string) : Boolean;
begin
   Result := IsDelimitedText(AString, [StartDelimiter], [EndDelimiter]);
end;

function IsDelimitedText(const AString : string; const StartDelimiter : string; const EndDelimiters : array of string) : Boolean;
begin
   Result := IsDelimitedText(AString, [StartDelimiter], EndDelimiters);
end;

function IsDelimitedText(const AString : string; const StartDelimiters : array of string; const EndDelimiter : string) : Boolean;
begin
   Result := IsDelimitedText(AString, StartDelimiters, [EndDelimiter]);
end;

function IsDelimitedText(const AString : string; const StartDelimiters, EndDelimiters : array of string) : Boolean;
var
   Counter : Integer;
begin
   Result := False;
   for Counter := Low(StartDelimiters) to High(StartDelimiters) do
   begin
       if StartDelimiters[Counter] = Copy(AString, 1, Length(StartDelimiters[Counter])) then
       begin
           Result := True;
           Break;
       end;
   end;

   if Result then
   begin
       Result := False;
       for Counter := Low(EndDelimiters) to High(EndDelimiters) do
       begin
           if EndDelimiters[Counter] = SubString(AString, 0 - Length(EndDelimiters[Counter])) then
           begin
               Result := True;
               Break;
           end;
       end;
   end;
end;

function StripLast(var AString : string; const ADelimiter : string; Options : TStripOptions) : string;
var
   Counter, DelimiterLength : System.Integer;
   ThisChar, PreviousQuote : Char;

begin
   PreviousQuote := #0;
   DelimiterLength := Length(ADelimiter);
   Counter := Length(AString);
   while Counter > 1 do
   begin
       ThisChar := AString[Counter];
       if (soIgnoreQuotedText in Options) and (ThisChar in ['''', '"']) then
       begin
           if PreviousQuote = ThisChar then
               PreviousQuote := #0
           else if PreviousQuote = #0 then
               PreviousQuote := ThisChar;
       end
       else if (PreviousQuote = #0) then
       begin
           if (AString[Counter] = ADelimiter[DelimiterLength]) then
           begin
               if (DelimiterLength = 1) or
                   (Copy(AString, Counter - (DelimiterLength - 1), DelimiterLength) = ADelimiter) then
               begin
                   Result := Copy(AString, Counter + 1, MaxInt); //  excluding the delimiter
                   System.Delete(AString, Counter - (DelimiterLength - 1), MaxInt);
                   Exit;
               end
           end;
       end;

       Dec(Counter);
   end;
   Result := AString;
   AString := EMPTY_STRING;
   if Copy(Result, 1, DelimiterLength) = ADelimiter then
       System.Delete(Result, 1, DelimiterLength);          //  strip initial delimiter
end;

function ExtractNextWord(AString : string; const OnlyThisWord : string) : string;
begin
   Result := StripNextWord(AString, OnlyThisWord);         //	local copy of AString
end;

function StripNextWord(var AString : string; const OnlyThisWord : string; Options : TStripOptions) : string;
begin
   if OnlyThisWord = EMPTY_STRING then
       Result := StripNextWord(AString, [], Options)
   else
       Result := StripNextWord(AString, [OnlyThisWord], Options);
end;

function StripNextWord(var AString : string; const OnlyTheseWords : array of string; Options : TStripOptions) : string; overload;
var
   TestString : string;
begin
   TestString := TrimLeft(AString);
   Include(Options, soTrimExtraDelimiters);
   Result := StripTo(TestString, [' ', #9, #13, #10, ',', '.'], Options); //  strip to next whitespace, if there is one; don't ignore
   if Result <> EMPTY_STRING then
   begin
       if (Length(OnlyTheseWords) = 0) or
           (OnlyTheseWords[0] = EMPTY_STRING) or (IndexOf(OnlyTheseWords, Result) <> NOT_FOUND_INDEX) then
       begin
           AString := TestString;
       end
       else
           Result := EMPTY_STRING;
   end;
end;

function CopyFrom(AString : string; const ADelimiter : string; Options : TStripOptions) : string;
begin
   Result := StripFrom(AString, ADelimiter, Options);
end;

function TrimToken(const AString : string; const ADelimiter : string) : string;
begin
   Result := TrimTokens(AString, [ADelimiter]);
end;

function TrimTokens(const AString : string) : string;
begin
   Result := TrimTokens(AString, ['''', '"']);
end;

function TrimTokens(const AString : string; const Delimiters : array of string) : string;
var
   Counter, Index : System.Integer;
   StillSearching : Boolean;
begin
   Result := AString;
   StillSearching := True;
   while StillSearching do
   begin
       StillSearching := False;
       for Counter := Low(Delimiters) to High(Delimiters) do
       begin
           if Copy(Result, 1, Length(Delimiters[Counter])) = Delimiters[Counter] then
           begin
               Delete(Result, 1, Length(Delimiters[Counter]));
               StillSearching := True;
               Break;
           end;
       end;
   end;
   StillSearching := True;
   while StillSearching do
   begin
       StillSearching := False;
       for Counter := Low(Delimiters) to High(Delimiters) do
       begin
           Index := (Length(Result) - Length(Delimiters[Counter])) + 1;
           if Copy(Result, Index, Length(Delimiters[Counter])) = Delimiters[Counter] then
           begin
               Delete(Result, Index, Length(Delimiters[Counter]));
               StillSearching := True;
               Break;
           end;
       end;
   end;
end;

function CommaTrimRight(const AString : string) : string;
begin
   Result := TrimRight(AString);
   if Result = ',' then
       Result := EMPTY_STRING;
end;

procedure StripToken(var AString : string; const ADelimiter : string);
begin
   StripTokens(AString, [ADelimiter]);
end;

procedure StripTokens(var AString : string; const Delimiters : array of string);
var
   FirstCharOptimization, ThisDelimiter : string;
   IsAllOneCharacterDelimiters : Boolean;
   StringCounter, DelimiterCounter, DelimiterIndex, MinDelimiterLength : System.Integer;
begin
   IsAllOneCharacterDelimiters := True;
   SetLength(FirstCharOptimization, (High(Delimiters) - Low(Delimiters) + 1));
   FirstCharOptimization := EMPTY_STRING;
   MinDelimiterLength := MaxInt;
   for DelimiterCounter := Low(Delimiters) to High(Delimiters) do
   begin
       FirstCharOptimization := FirstCharOptimization + Delimiters[DelimiterCounter][1];
       MinDelimiterLength := Min(MinDelimiterLength, Length(Delimiters[DelimiterCounter]));
       if Length(Delimiters[DelimiterCounter]) > 1 then
           IsAllOneCharacterDelimiters := False;
   end;
   StringCounter := 0;
   while StringCounter < (Length(AString) - (MinDelimiterLength - 1)) do
   begin
       Inc(StringCounter);
       if FindAnsiPos(AString[StringCounter], FirstCharOptimization, DelimiterIndex) then
       begin
           Dec(DelimiterIndex, 1 - Low(Delimiters));       //  correct the 1-based index to an array offset
           if IsAllOneCharacterDelimiters then
           begin
               Delete(AString, StringCounter, 1);
               Dec(StringCounter);
               Continue;
           end
           else
           begin
               for DelimiterCounter := DelimiterIndex to High(Delimiters) do
               begin
                   ThisDelimiter := Delimiters[DelimiterCounter];
                   if AnsiSameStr(Copy(AString, StringCounter, Length(ThisDelimiter)), ThisDelimiter) then
                   begin
                       Delete(AString, 1, Length(ThisDelimiter));
                       StringCounter := 0;
                       Continue;
                   end;
               end;
           end;
           Break;
       end;
   end;
end;

function IncrementString(const AString : string) : string;
var
   Counter : System.Integer;
begin
   if AString = EMPTY_STRING then
       Result := '0'
   else
   begin
       Result := AString;
       for Counter := Length(AString) downto 1 do
       begin
           case AString[Counter] of
               'z' : Result[Counter] := 'A';
               '9' : Result[Counter] := '0';
               '0'..'8', 'A'..'Y', 'a'..'y' :
                   begin
                       Result[Counter] := Chr(Ord(Result[Counter]) + 1);
                       Break;
                   end;
               'Z' :
                   begin
                       Result[Counter] := 'a';
                       Break;
                   end;
           end;
       end;
   end;
end;

function SubString(const AString : string; AStartIndex : Integer; ACount : Integer = MaxInt) : string;
begin
   if AStartIndex < 0 then
       AStartIndex := Length(AString) + AStartIndex + 1;   //  right-most starting at 'n'

   if ACount < 0 then                                      //  all except the last 'n' characters
       ACount := (Length(AString) + ACount) - (AStartIndex - 1);

   Result := System.Copy(AString, AStartIndex, ACount);
end;

function ExtractChar(const AString : string; APosition : Integer) : Char;
begin
   if Length(AString) > 0 then
       Result := SubString(AString, APosition, 1)[1]
   else
       Result := #0;
end;

function CountOf(const AProfile : string; AString : string) : Integer;
begin
   Result := 0;
   while StripIf(AString, AProfile) <> EMPTY_STRING do
       Inc(Result);
end;

function ReplaceString(const AString, FindThis, ReplaceWith : string; Options : TReplaceStringOptions) : string;
var
   ThisStrings : TStringList;
begin
   ThisStrings := TStringList.Create;
   try
       ThisStrings.Add(FindThis + '=' + ReplaceWith);
       Result := ReplaceStrings(AString, ThisStrings, Options);
   finally
       ThisStrings.Free;
   end;
end;

function ReplaceStrings(const AString : string; const FindThisReplaceWith : array of string; Options : TReplaceStringOptions = [rsoIgnoreCase, rsoReplaceAll]) : string; overload;
var
   ThisStrings : TStringList;
   Counter : Integer;
begin
   ThisStrings := TStringList.Create;
   try
       for Counter := 0 to High(FindThisReplaceWith) do
           ThisStrings.Add(FindThisReplaceWith[Counter]);
       Result := ReplaceStrings(AString, ThisStrings, Options);
   finally
       ThisStrings.Free;
   end;
end;

function ReplaceStrings(const AString : string; const FindThis : array of string; const ReplaceWith : string; Options : TReplaceStringOptions = [rsoIgnoreCase, rsoReplaceAll]) : string; overload;
var
   ThisStrings : TStringList;
   Counter : Integer;
begin
   ThisStrings := TStringList.Create;
   try
       for Counter := 0 to High(FindThis) do
           ThisStrings.Add(FindThis[Counter] + '=' + ReplaceWith);

       Result := ReplaceStrings(AString, ThisStrings, Options);
   finally
       ThisStrings.Free;
   end;
end;

function ReplaceStrings(AString : string; FindThisReplaceWith : TStrings; Options : TReplaceStringOptions = [rsoIgnoreCase, rsoReplaceAll]) : string; overload;

   procedure MaskQuotedText(var AString : string);
   var
       ThisQuote : Char;
       Counter : System.Integer;
   begin
       ThisQuote := #0;
       for Counter := 1 to Length(AString) do
       begin
           if AString[Counter] = ThisQuote then
           begin
               AString := #0;
               AString[Counter] := #1;
           end
           else if AString[Counter] in ['''', '"'] then
           begin
               ThisQuote := AString[Counter];
               AString[Counter] := #1;
           end
           else if ThisQuote <> #0 then
               AString[Counter] := #1;
       end;

   end;

var
   Index, Counter, DeletedCharacterCount : System.Integer;
   FindString, BaseString, ReplaceWith : string;
begin
   Result := EMPTY_STRING;

   for Counter := 0 to FindThisReplaceWith.Count - 1 do
   begin
       if rsoIgnoreCase in Options then
       begin
           FindString := UpperCase(FindThisReplaceWith.Names[Counter]);
           BaseString := UpperCase(AString);
       end
       else
       begin
           FindString := FindThisReplaceWith.Names[Counter];
           BaseString := AString;
       end;
       ReplaceWith := FindThisReplaceWith.Values[FindThisReplaceWith.Names[Counter]];

       if rsoIgnoreQuoted in Options then
           MaskQuotedText(BaseString);

       DeletedCharacterCount := 0;
       Result := EMPTY_STRING;
       Index := Pos(FindString, BaseString);
       while Index > 0 do
       begin
           Result := Result + Copy(AString, DeletedCharacterCount + 1, Index - 1) + ReplaceWith;
           Inc(DeletedCharacterCount, Index + Length(FindString) - 1);
           if rsoReplaceAll in Options then
           begin
               Delete(BaseString, 1, Index + (Length(FindString) - 1)); //  faster than Copy(...) for the next Pos(...)
               Index := Pos(FindString, BaseString);
           end
           else
               Break;
       end;
       Result := Result + Copy(AString, DeletedCharacterCount + 1, MaxInt);
       AString := Result;                                  //  for the next iteration
   end;
end;

procedure ArrayToStrings(const AnArray : array of string; AStrings : TStrings);
var
   Counter : Integer;
begin
   for Counter := 0 to High(AnArray) do
       AStrings.Add(AnArray[Counter]);
end;

function ArrayToStrings(const AnArray : array of string) : TStrings; overload;
begin
   Result := TStringList.Create;
   try
       ArrayToStrings(AnArray, Result);
   except
       Result.Free;
       raise;
   end;
end;

procedure ArrayToStringValues(const AnArray : array of string; AStrings : TStrings); overload;
var
   Counter : Integer;
begin
   for Counter := 0 to ((High(AnArray) + 1) div 2) - 1 do
   begin
       if AnArray[(Counter * 2) + 1] <> EMPTY_STRING then
           AStrings.Values[AnArray[(Counter * 2)]] := AnArray[(Counter * 2) + 1];
   end;
end;

function ArrayToStringValues(const AnArray : array of string) : TStrings; overload;
begin
   Result := TStringList.Create;
   try
       ArrayToStringValues(AnArray, Result);
   except
       Result.Free;
       raise;
   end;
end;

function StripComments(AString : string) : string;
var
   ThisDelimiter : string;
begin
   Result := EMPTY_STRING;
   while AString <> EMPTY_STRING do
   begin
       Result := Result + StripTo(AString, ['{', '//', '(*'], ThisDelimiter, [soIgnoreQuotedText]);
       if ThisDelimiter = '{' then
           StripTo(AString, '}', [soIgnoreQuotedText])
       else if ThisDelimiter = '//' then
           StripTo(AString, #13#10, [soIgnoreQuotedText])
       else if ThisDelimiter = '(*' then
           StripTo(AString, '*)', [soIgnoreQuotedText]);
   end;
end;

function ExtractAlpha(const AString : string; IgnoreQuotedText : Boolean) : string;
var
   PreviousQuote : string;
   Counter : System.Integer;
begin
   PreviousQuote := EMPTY_STRING;
   Result := AString;
   for Counter := Length(Result) downto 1 do
   begin
       if Result[Counter] = PreviousQuote then
           PreviousQuote := EMPTY_STRING
       else if IgnoreQuotedText and (PreviousQuote = EMPTY_STRING) and (Result[Counter] in ['''', '"']) then
           PreviousQuote := Result[Counter]
       else if not (Result[Counter] in ALPHA_NUMERIC_CHARS) then
           Delete(Result, Counter, 1);
   end;
end;

function ExtractNumber(const AString : string) : string;
begin
   FindNumber(AString, Result);                            //  don't care what we have to remove
end;

function FindNumber(AString : string; var ANumber : Extended) : Boolean;
var
   ThisNumberString : string;
begin
   Result := FindNumber(AString, ThisNumberString);
   if Result then
       ANumber := StrToFloat(ThisNumberString);
end;

function FindNumber(AString : string; var ANumber : Integer) : Boolean; 
var
   ThisNumberString : string;
begin
   Result := FindNumber(AString, ThisNumberString);
   if Result then
       ANumber := StrToInt(ThisNumberString);
end;

function FindNumber(AString : string; var ANumber : string) : Boolean;
var
   Counter : Integer;
   HasFoundDecimal : Boolean;
begin
   Result := False;

   ANumber := Trim(AString);
   HasFoundDecimal := False;
   for Counter := Length(ANumber) downto 1 do
   begin
       if not (ANumber[Counter] in NUMERIC_CHARS) then
       begin
           if (not HasFoundDecimal) and (ANumber[Counter] = SysUtils.DecimalSeparator) then
               HasFoundDecimal := True                     //  do not delete the last decimal

           else if (ANumber[Counter] <> '-') or (Counter > 1) then //  do not delete a leading sign character
               Delete(ANumber, Counter, 1);
       end
       else
           Result := True;                                 //  we found at least one digit
   end;
end;

function StripNonAlpha(const AString : string) : string;
var
   Pointer : System.Integer;
begin
   Result := AString;
   Pointer := Length(Result);
   while (Pointer >= 1) do
   begin
       if not (Result[Pointer] in ALPHA_NUMERIC_CHARS) then
           Delete(Result, Pointer, 1);
       Dec(Pointer);
   end;
end;

function FindAnsiPos(const ASubString, AString : string; var Index : Integer) : Boolean;
begin
   Index := AnsiPos(ASubString, AString);
   Result := Index <> 0;
end;

function AnsiPosI(const ASubString, AString : string) : System.Integer;
begin
   Result := AnsiPos(AnsiUpperCase(ASubString), AnsiUpperCase(AString));
end;

function Pos(const SubString : string; AString : string) : Integer; //  no reintroduce
begin
   Result := System.Pos(SubString, AString);
end;

function Pos(const SubStrings : array of string; AString : string) : Integer;
begin
   Result := Length(StripIf(AString, SubStrings));
end;

function Pos(const AString : string; AnArray : TStringDynArray) : Integer;
var
   Counter : Integer;
begin
   Result := -1;
   for Counter := 0 to Length(AnArray) - 1 do
   begin
       if AnArray[Counter] = AString then
       begin
           Result := Counter;
           Break;
       end;
   end;
end;

function Pos(const AnInteger : Integer; AnArray : TIntegerDynArray) : Integer;
var
   Counter : Integer;
begin
   Result := -1;
   for Counter := 0 to Length(AnArray) - 1 do
   begin
       if AnArray[Counter] = AnInteger then
       begin
           Result := Counter;
           Break;
       end;
   end;
end;

function PosOfWord(const AWord : string; AString : string) : Integer;
begin
   Result := 1;
   while AString <> EMPTY_STRING do
   begin
       if StripNextWord(AString) = AWord then
           Exit;
       Inc(Result)
   end;
   Result := NOT_FOUND_POSITION;
end;

function FastPos(const ASubString, AString : string) : System.Integer;
const
   MAXCHAR = 255;
var
   TextPointer, SubPointer, Counter : System.Integer;
   SkipArray : array[0..MAXCHAR] of Integer;
begin
   if Length(ASubString) = 0 then
       Result := 1
   else
   begin
       Result := 0;
       for Counter := 0 to MAXCHAR do
           SkipArray[Counter] := Length(ASubString);
       for Counter := 1 to Length(ASubString) - 1 do
           SkipArray[Ord(ASubString[Counter])] := Length(ASubString) - Counter;

       Counter := Length(ASubString);
       while (Counter <= Length(AString)) do
       begin
           TextPointer := Counter;
           SubPointer := Length(ASubString);
           while (SubPointer >= 1) do
           begin
               if AString[TextPointer] <> ASubString[SubPointer] then
                   SubPointer := NOT_FOUND_INDEX
               else
               begin
                   Dec(SubPointer);
                   Dec(TextPointer);
               end;
           end;
           if SubPointer = 0 then                          //     we have matches all the charaters in ASubString
           begin
               Result := TextPointer + 1;
               Break;
           end;
           Inc(Counter, SkipArray[Ord(AString[Counter])]); //  skip the maximum number of characters based on the mismatching character position in APattern
       end;
   end;
end;

function FormatCamelCap(const AString : string) : string;
var
   CharCounter : System.Integer;
begin
   Result := UpperCase(Copy(AString, 1, 1)) + Copy(AString, 2, MaxInt);
   //                         insert a space before each capital letter (except if it is the first letter)
   CharCounter := 2;
   while CharCounter <= Length(Result) do
   begin
       if (Result[CharCounter] in ['A'..'Z', '0'..'9']) and (Result[CharCounter - 1] in ['a'..'z']) then
       begin                                               //      abC  =>   ab C
           Result := Copy(Result, 1, (CharCounter - 1)) + ' ' + Copy(Result, CharCounter, MaxInt);
           Inc(CharCounter);
       end
       else if (CharCounter > 2) and
           (Result[CharCounter] in ['a'..'z']) and
           (Result[CharCounter - 1] in ['A'..'Z']) and
           (Result[CharCounter - 2] in ['A'..'Z', '0'..'9']) then //  ABc  => A Bc;  123Abc  =>  123 Abc
       begin
           Result := Copy(Result, 1, (CharCounter - 2)) + ' ' + Copy(Result, CharCounter - 1, MaxInt);
           Inc(CharCounter);
       end
       else if Result[CharCounter] = '_' then              //  this will not affect a leading underbar
           Result[CharCounter] := ' ';

       if (Result[CharCounter - 1] in [#9, #10, #13, ' ', '_']) then
           Result[CharCounter] := UpCase(Result[CharCounter]);

       Inc(CharCounter);
   end;
end;

function StrToBool(const AString : string) : Boolean;
begin
   Result := (AString <> EMPTY_STRING) and ((UpCase(AString[1]) in ['Y', 'T', '1']) or (AString = '-1'));
end;

function BoolToStr(ABool : Boolean) : string;
begin
   if ABool then
       Result := 'True'
   else
       Result := 'False';
end;

function ShiftStateToKeys(AShift : TShiftState) : Word;
begin
   Result := 0;
   if ssShift in AShift then
       Result := Result or MK_SHIFT;
   if ssCtrl in AShift then
       Result := Result or MK_CONTROL;
   if ssLeft in AShift then
       Result := Result or MK_LBUTTON;
   if ssRight in AShift then
       Result := Result or MK_RBUTTON;
   if ssMiddle in AShift then
       Result := Result or MK_MBUTTON;
   //         we hope that the Alt key is still down
end;

{            989C6E5C-2CC1-11CA-A044-08002B1BB4F5
TGUID = packed record
D1: LongWord;
D2: Word;
D3: Word;
D4: array[0..7] of Byte;
end;

D1:    Specifies the first 8 hexadecimal digits of the UUID.
D2:    Specifies the first group of 4 hexadecimal digits of the UUID.
D3:    Specifies the second group of 4 hexadecimal digits of the UUID.
D4:    Specifies an array of eight elements. The first two elements contain the third group of 4 hexadecimal digits of the UUID.
The remaining six elements contain the final 12 hexadecimal digits of the UUID
}

const
   HEXADECIMAL_DIGITS = ['0'..'9', 'A'..'F'];
   HEXADECIMAL_DIGIT_VALUES = '0123456789ABCDEF';

function HexToInt(const AString : string) : System.Integer;
var
   Counter : System.Integer;
begin
   Result := 0;
   for Counter := 1 to Length(AString) do
       if AString[Counter] in HEXADECIMAL_DIGITS then
           Result := (Result * 16) + (Pos(AString[Counter], HEXADECIMAL_DIGIT_VALUES) - 1);
end;

function StrToGUID(AString : string) : TGUID;
var
   D4Counter : System.Integer;
begin
   AString := UpperCase(StringReplace(AString, '-', EMPTY_STRING, [rfReplaceAll]));
   Result.D1 := HexToInt(Copy(AString, 1, 8));
   Result.D2 := HexToInt(Copy(AString, 9, 4));
   Result.D3 := HexToInt(Copy(AString, 13, 4));
   for D4Counter := 0 to 7 do
       Result.D4[D4Counter] := HexToInt(Copy(AString, 17 + (D4Counter * 2), 2));
end;

function GUIDToStr(AGUID : TGUID) : string;
begin
   Result := IntToHex(AGUID.D1, 8) + '-' +
       IntToHex(AGUID.D2, 4) + '-' +
       IntToHex(AGUID.D3, 4) + '-' +
       IntToHex(AGUID.D4[0], 2) + IntToHex(AGUID.D4[1], 2) + '-' +
       IntToHex(AGUID.D4[2], 2) + IntToHex(AGUID.D4[3], 2) + IntToHex(AGUID.D4[4], 2) +
       IntToHex(AGUID.D4[5], 2) + IntToHex(AGUID.D4[6], 2) + IntToHex(AGUID.D4[7], 2);
end;

function CreateGUID : string;
var
   ThisGuid : TGUID;
begin
   if ActiveX.CoCreateGUID(ThisGuid) = S_OK then
       Result := GUIDToStr(ThisGuid)
   else
       raise Exception.Create('Cannot create a new GUID.');
end;

function ExpressionToPolish(const AString : string; const ASeparator : string) : string;
begin
   Result := ExpressionToPolish(AString, ASeparator, ['+', '-', '*', 'mul', '/', 'div', '%', 'mod', '^']);
end;

function ExpressionToPolish(const AString : string;
   const ASeparator : string; const OperatorPrecedence : array of string) : string;

   function GetOperatorPrecedence(const AnOperator : string) : Integer;
   begin
       if AnOperator = '(' then
           Result := 0
       else
       begin
           Result := Low(OperatorPrecedence);
           while Result <= High(OperatorPrecedence) do
           begin
               if SameText(AnOperator, OperatorPrecedence[Result]) then
                   Break;
               Inc(Result);
           end;
       end;
   end;
var
   Counter : Integer;
   CurrentWord : string;
   CurrentWordIsNumber : Boolean;
   ThisStack : TCraftingStringList;
begin
   Result := EMPTY_STRING;
   ThisStack := TCraftingStringList.Create;
   try
       CurrentWord := EMPTY_STRING;
       CurrentWordIsNumber := False;
       for Counter := 1 to Length(AString) do
       begin
           if (AString[Counter] in NUMERIC_CHARS) <> CurrentWordIsNumber then
           begin
               if CurrentWordIsNumber then
                   Result := Result + ASeparator + CurrentWord
               else
               begin
                   CurrentWord := Trim(CurrentWord);

                   if (ThisStack.Count = 0) or
                       (GetOperatorPrecedence(ThisStack.Top) < GetOperatorPrecedence(CurrentWord)) then
                   begin
                       ThisStack.Push(CurrentWord);
                   end
                   else
                   begin
                       while (ThisStack.Count > 0) and
                           (GetOperatorPrecedence(ThisStack.Top) > GetOperatorPrecedence(CurrentWord)) do
                       begin
                           Result := Result + ASeparator + ThisStack.Pop;
                       end;
                   end;
               end;

               if AString[Counter] = ')' then
               begin
                   while (ThisStack.Count > 0) and (ThisStack.Top <> '(') do
                       Result := Result + ASeparator + ThisStack.Pop;

                   CurrentWordIsNumber := False;
               end
               else if AString[Counter] = '(' then
               begin
                   ThisStack.Push(AString[Counter]);
                   CurrentWordIsNumber := False;
               end
               else
               begin
                   CurrentWord := AString[Counter];        //  start of new word
                   CurrentWordIsNumber := not CurrentWordIsNumber;
               end;
           end
           else
               CurrentWord := CurrentWord + AString[Counter];
       end;

       while ThisStack.Count > 0 do
           Result := Result + ASeparator + ThisStack.Pop;

       Delete(Result, 1, Length(ASeparator));              //  delete leading separator
   finally
       ThisStack.Free;
   end;
end;

function PolishToInt(AString : string; const ASeparator : string) : Integer;
var
   ThisOperand : string;
   ThisStack : TCraftingStringList;
   LeftInt, RightInt : Integer;
begin
   ThisStack := TCraftingStringList.Create;
   try
       while AString <> EMPTY_STRING do
       begin
           ThisOperand := StripTo(AString, ASeparator);
           if (ThisOperand = 'div') or (ThisOperand = '/') then
           begin
               RightInt := ThisStack.PopInt;
               LeftInt := ThisStack.PopInt;
               ThisStack.PushInt(LeftInt div RightInt);
           end
           else if (ThisOperand = 'mul') or (ThisOperand = '*') then
               ThisStack.PushInt(ThisStack.PopInt * ThisStack.PopInt)

           else if (ThisOperand = 'mod') or (ThisOperand = '%') then
           begin
               RightInt := ThisStack.PopInt;
               LeftInt := ThisStack.PopInt;
               ThisStack.PushInt(LeftInt mod RightInt);
           end
           else
           begin
               case ThisOperand[1] of
                   '+' : ThisStack.PushInt(ThisStack.PopInt + ThisStack.PopInt);
                   '-' :
                       begin
                           RightInt := ThisStack.PopInt;
                           LeftInt := ThisStack.PopInt;
                           ThisStack.PushInt(LeftInt - RightInt);
                       end;
                   '^' :
                       begin
                           RightInt := ThisStack.PopInt;
                           LeftInt := ThisStack.PopInt;
                           ThisStack.PushInt(Trunc(Power(LeftInt, RightInt)));
                       end;
               else
                   ThisStack.PushInt(StrToInt(ThisOperand));
               end;
           end;
       end;
   finally
       ThisStack.Free;
   end;
   Result := ThisStack.PopInt;
end;

function PolishToFloat(AString : string; const ASeparator : string) : Extended;
var
   ThisOperand : string;
   LeftFloat, RightFloat : Extended;
   ThisStack : array of Extended;

   procedure PushFloat(AFloat : Extended);
   begin
       SetLength(ThisStack, Length(ThisStack) + 1);
       ThisStack[Length(ThisStack) - 1] := AFloat;
   end;

   function PopFloat : Extended;
   begin
       Result := ThisStack[Length(ThisStack) - 1];
       SetLength(ThisStack, Length(ThisStack) - 1);        //  remove the last number
   end;

begin
   while AString <> EMPTY_STRING do
   begin
       ThisOperand := StripTo(AString, ASeparator);
       if (ThisOperand = 'div') or (ThisOperand = '/') then
       begin
           RightFloat := PopFloat;
           LeftFloat := PopFloat;
           PushFloat(LeftFloat / RightFloat);
       end
       else if (ThisOperand = 'mul') or (ThisOperand = '*') then
           PushFloat(PopFloat * PopFloat)

       else
       begin
           case ThisOperand[1] of
               '+' : PushFloat(PopFloat + PopFloat);
               '-' :
                   begin
                       RightFloat := PopFloat;
                       LeftFloat := PopFloat;
                       PushFloat(LeftFloat - RightFloat);
                   end;
               '^' :
                   begin
                       RightFloat := PopFloat;
                       LeftFloat := PopFloat;
                       PushFloat(Power(LeftFloat, RightFloat));
                   end;
           else
               PushFloat(StrToFloat(ThisOperand));
           end;
       end;
   end;
   Result := PopFloat;
end;

function GeekStrToFloat(AString : string) : Extended;
var
   Counter : System.Integer;
begin
   Result := 0.0;
   AString := UpperCase(StringReplace(Trim(AString), SysUtils.ThousandSeparator, EMPTY_STRING, [rfReplaceAll]));
   for Counter := Length(AString) downto 1 do
   begin
       if AString[Counter] in ['0'..'9', SysUtils.DecimalSeparator] then
       begin
           Result := StrToFloat(Copy(AString, 1, Counter));
           Delete(AString, 1, Counter);
           Break;
       end;
   end;
   if AString <> EMPTY_STRING then
   begin
       if (AString = 'G') or (AString = 'GIG') or (AString = 'GB') then
           Result := Result * (1024 * 1024 * 1024)
       else if (AString = 'M') or (AString = 'MEG') or (AString = 'MB') then
           Result := Result * (1024 * 1024)
       else if (AString = 'K') or (AString = 'KB') then
           Result := Result * 1024
   end;
end;

const
   A_K = 1024;
   A_MEG = A_K * 1024;
   A_GIG = A_MEG * 1024;

function FloatToGeekStr(ANumber : Extended; DecimalPlaces : Integer) : string;
var
   FormatPicture : String;
begin
   if DecimalPlaces <= 0 then
   begin
       FormatPicture := '#,###';
       ANumber := Trunc(ANumber);
   end
   else
       FormatPicture := '#,###.' + StringOfChar('#', DecimalPlaces);

   if ANumber >= A_GIG then
       Result := FormatFloat(FormatPicture, ANumber  / A_GIG) + ' G'
   else if ANumber >= A_MEG then
       Result := FormatFloat(FormatPicture, ANumber / A_MEG) + ' M'      
   else if ANumber >= A_K then
       Result := FormatFloat(FormatPicture, ANumber / A_K) + ' K'
   else
       Result := FormatFloat(FormatPicture, ANumber);
end;

function DescribeCount(ACount : System.Integer; const ATerm : string; APluralTerm : string) : string;
const
   TCardinalWords : array[1..19] of string = ('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten',
       'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen');
   TCardinalTens : array[2..9] of string = ('twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety');
   CONJUNCTION = ' and ';
begin
   Result := EMPTY_STRING;

   if ACount >= 1000000 then
   begin
       if (ACount mod 1000000) > 1000 then
           Result := Result + ' ' + DescribeCount(ACount div 1000000, 'million', 'million')
       else
           Result := Result + CONJUNCTION + DescribeCount(ACount div 1000000, 'million', 'million');
       ACount := ACount mod 1000000;
   end;
   if ACount >= 10000 then
   begin
       Result := Result + CONJUNCTION + DescribeCount(ACount div 1000, 'thousand', 'thousand');
       ACount := ACount mod 1000;
   end
   else if (ACount >= 1100) and ((ACount mod 100) = 0) then
   begin
       Result := Result + CONJUNCTION + DescribeCount(ACount div 100, 'hundred', 'hundred');
       ACount := ACount mod 100;
   end
   else if ACount >= 1000 then
   begin
       Result := Result + CONJUNCTION + DescribeCount(ACount div 1000, 'thousand', 'thousand');
       ACount := ACount mod 1000;
   end;
   if ACount >= 100 then
   begin
       if (ACount mod 100) = 0 then
           Result := Result + CONJUNCTION + DescribeCount(ACount div 100, 'hundred', 'hundred')
       else
           Result := Result + ' ' + DescribeCount(ACount div 100, 'hundred', 'hundred');
       ACount := ACount mod 100;
   end;

   if ACount > 19 then
   begin
       Result := Result + CONJUNCTION + TCardinalTens[ACount div 10];
       if (ACount mod 10) <> 0 then
           Result := Result + ' ' + TCardinalWords[ACount mod 10];
   end
   else if ACount > 0 then
       Result := Result + CONJUNCTION + TCardinalWords[ACount];

   if Copy(Result, 1, Length(CONJUNCTION)) = CONJUNCTION then
       Delete(Result, 1, Length(CONJUNCTION));
   Result := Trim(Result);

   if (Result <> EMPTY_STRING) and (ATerm <> EMPTY_STRING) then
   begin
       if ACount > 1 then
       begin
           if (APluralTerm = EMPTY_STRING) then
           begin
               if (Length(ATerm) > 6) and SameText(SubString(ATerm, -3), 'ion') then
                   APluralTerm := SubString(ATerm, 1, -3) + 'ia'
               else if (Length(ATerm) > 6) and (SubString(ATerm, -1) = 'y') then
                   Result := Result + ' ' + SubString(ATerm, 1, -1) + 'ies'
               else
                   APluralTerm := ATerm + 's';
           end;
           Result := Result + ' ' + APluralTerm;
       end
       else
           Result := Result + ' ' + ATerm
   end;
end;

function DescribeElapsedTicks(ATickCount : Integer) : string;
begin
   Result := DescribeElapsedTime(ATickCount / (1000 * 60 * 60 * 24));
end;

function DescribeElapsedTime(ATime : TDateTime) : string;
var
   ThisEon, ThisCentury, ThisYear, ThisMonth, ThisDay, ThisHour, ThisMinute, ThisSecond, ThisMillisecond : Word;
begin
   Result := EMPTY_STRING;

   ATime := Abs(ATime);
   ThisDay := Trunc(ATime);

   if ThisDay > 0 then
   begin
       ThisYear := ThisDay div 364;                        //  almost regular time periods
       ThisDay := ThisDay mod 364;
       ThisMonth := 0;                                     //  no regular time periods

       if ThisYear > 5000 then
       begin
           ThisEon := ThisYear div 1000;
           ThisYear := ThisYear mod 1000;
           Result := Result + CommaTrimRight(', ' + DescribeCount(ThisEon, 'eon'));
       end;
       if ThisYear > 500 then
       begin
           ThisCentury := ThisYear div 100;
           ThisYear := ThisYear mod 100;
           Result := Result + CommaTrimRight(', ' + DescribeCount(ThisCentury, 'century'));
       end;
       Result := Result + CommaTrimRight(', ' + DescribeCount(ThisYear, 'year'));
       Result := Result + CommaTrimRight(', ' + DescribeCount(ThisMonth, 'month'));
       if ThisDay > 21 then
       begin
           Result := Result + CommaTrimRight(', ' + DescribeCount(ThisDay div 7, 'week'));
           ThisDay := ThisDay mod 7;
       end;
       Result := Result + CommaTrimRight(', ' + DescribeCount(ThisDay, 'day'));
   end;
   DecodeTime(ATime, ThisHour, ThisMinute, ThisSecond, ThisMillisecond);
   Result := Result + CommaTrimRight(', ' + DescribeCount(ThisHour, 'hour'));
   Result := Result + CommaTrimRight(', ' + DescribeCount(ThisMinute, 'minute'));
   Result := Result + CommaTrimRight(', ' + DescribeCount(ThisSecond, 'second'));

   Delete(Result, 1, 2);                                   //  remove the leading comma + space

   if Result = EMPTY_STRING then
       Result := DescribeCount(ThisMillisecond, 'millisecond');
end;

procedure GetYearsAndDays(ADate1, ADate2 : TDateTime; var YearsDifference, DaysDifference : Integer);
var
   DateInYear2 : TDateTime;
   ThisYear1, ThisYear2, ThisMonth1, ThisMonth2, ThisDay1, ThisDay2 : Word;
   DaysLeftInYear1, DaysIntoYear2 : Integer;
begin
   Assert(ADate1 < ADate2);

   DecodeDate(ADate1, ThisYear1, ThisMonth1, ThisDay1);
   DecodeDate(ADate2, ThisYear2, ThisMonth2, ThisDay2);

   YearsDifference := ThisYear2 - ThisYear1;
   if (ThisMonth1 > ThisMonth2) or ((ThisMonth1 = ThisMonth2) and (ThisDay1 > ThisDay2)) then
   begin
       Dec(YearsDifference);
       DaysLeftInYear1 := Trunc(EncodeDate(ThisYear1 + 1, 1, 1) - ADate1);
       DaysIntoYear2 := Trunc(ADate2 - EncodeDate(ThisYear2 - 1, 12, 31));
       DaysDifference := DaysLeftInYear1 + DaysIntoYear2;
   end
   else
   begin
       DateInYear2 := EncodeDate(ThisYear2, ThisMonth1, ThisDay1);
       DaysDifference := Trunc(ADate2 - DateInYear2);
   end;
end;

function SameFont(Font1, Font2 : TFont) : Boolean;
begin
   Result := (Font1.Name = Font2.Name) and (Font1.Height = Font2.Height) and
       (Font1.Color = Font2.Color) and (Font1.Style = Font2.Style);
end;

function BreakApart(AString : string; AToken : string; Options : TStripOptions) : IAutoStringList;
begin
   Result := TAutoStringList.Create;
   BreakApart(AString, AToken, Result.StringsObject, Options);
end;

function BreakApart(AString : string; const Tokens : array of string; Options : TStripOptions) : IAutoStringList;
begin
   Result := TAutoStringList.Create;
   BreakApart(AString, Tokens, Result.StringsObject, Options);
end;

function BreakApart(AString : string; AToken : string; TargetList : TStrings; Options : TStripOptions) : System.Integer;
begin
   Result := BreakApart(AString, [AToken], TargetList, Options);
end;

function BreakApart(AString : string; const Tokens : array of string; TargetList : TStrings; Options : TStripOptions) : Integer;
var
   ThisString : string;
begin
   Result := 0;
   if TargetList <> nil then
       TargetList.Clear;

   while AString <> EMPTY_STRING do
   begin
       ThisString := StripTo(AString, Tokens, Options);
       if TargetList <> nil then
           TargetList.Add(ThisString);
       Inc(Result);
   end;
end;

function BreakApart(AString : string; AToken : string; var TargetArray : TDynamicArrayOfStrings; Options : TStripOptions) : System.Integer;
begin
   Result := BreakApart(AString, [AToken], TargetArray, Options);
end;

function BreakApart(AString : string; const Tokens : array of string; var TargetArray : TDynamicArrayOfStrings; Options : TStripOptions) : Integer;
var
   ThisString : string;
begin
   Result := 0;
   SetLength(TargetArray, 0);

   while AString <> EMPTY_STRING do
   begin
       ThisString := StripTo(AString, Tokens, Options);
       Inc(Result);
       SetLength(TargetArray, Result);
       TargetArray[Result - 1] := ThisString;
   end;
end;

function StickTogether(AStrings : TStrings; const AToken : string) : string;
var
   Counter : System.Integer;
begin
   Result := AStrings[0];
   for Counter := 1 to AStrings.Count - 1 do
       Result := Result + AToken + AStrings[Counter];
end;

function NormalizeText(const AString : string) : string;
var
   Counter : System.Integer;
begin
   if AnsiUpperCase(AString) = AString then
       Result := AnsiLowerCase(AString)
   else
       Result := AString;

   Result := Trim(StringReplace(Result, '_', ' ', [rfReplaceAll]));

   Result := AnsiUpperCase(Copy(Result, 1, 1)) + Copy(Result, 2, MaxInt); //  capitalize the first letter

   Counter := 2;
   while Counter < Length(Result) do
   begin
       if (Result[Counter] in ['A'..'Z']) and (Result[Counter + 1] in ['a'..'z']) then
       begin
           Result := Copy(Result, 1, Counter - 1) + ' ' + Copy(Result, Counter, MaxInt);
           Inc(Counter);
       end
       else if (Result[Counter] in ['a'..'z']) and (Result[Counter - 1] = ' ') then
           Result[Counter] := UpCase(Result[Counter]);

       Inc(Counter);
   end;
end;

function NormalizeWhitespace(const AString : string) : string;
var
   Counter : System.Integer;
begin
   Result := Trim(AString);

   Counter := 2;
   while Counter < Length(Result) do
   begin
       if Result[Counter] in [' ', #9, #10, #13] then
       begin
           if Result[Counter - 1] <> ' ' then
               Result[Counter] := ' '
           else
           begin
               Delete(Result, Counter, 1);
               Continue;                                   //  don't Inc(Counter)
           end;
       end;
       Inc(Counter);
   end;
end;

function IndexOfEnum(ATypeInfo : PTypeInfo; const AValue : string) : Integer;
var
   Counter : Integer;
begin
   Result := NOT_FOUND_INDEX;
   for Counter := TypInfo.GetTypeData(ATypeInfo).MinValue to TypInfo.GetTypeData(ATypeInfo).MaxValue do
   begin
       if SameText(AValue, FormatEnumName(TypeInfo(TSpecialFolder), Counter)) then
       begin
           Result := Counter;
           Break;
       end;
   end;
end;

function GetEnumName(ATypeInfo : PTypeInfo; AValue : Integer) : string;
begin
   if ATypeInfo.Kind = tkSet then
       ATypeInfo := TypInfo.GetTypeData(ATypeInfo).CompType^;

   if (AValue < TypInfo.GetTypeData(ATypeInfo).MinValue) or (AValue > TypInfo.GetTypeData(ATypeInfo).MaxValue) then
   begin
       raise Exception.Create(Format('AValue must be between %d and %d.',
           [TypInfo.GetTypeData(ATypeInfo).MinValue, TypInfo.GetTypeData(ATypeInfo).MaxValue]));
   end;

   Result := TypInfo.GetEnumName(ATypeInfo, AValue);
end;

function FormatEnumName(const AName : string) : string;
var
   Counter : System.Integer;
begin
   Result := EMPTY_STRING;
   for Counter := 1 to Length(AName) do
   begin
       if AName[Counter] = UpCase(AName[Counter]) then     //  find the first capital letter
       begin
           Result := FormatCamelCap(Copy(AName, Counter, MaxInt));
           Break;
       end;
   end;
end;

function FormatEnumName(ATypeInfo : PTypeInfo; AValue : Integer) : string;
begin
   Result := FormatEnumName(GetEnumName(ATypeInfo, AValue));
end;

function LoadAllEnums(ATypeInfo : PTypeInfo; AStrings : TStrings = nil; FormatNames : Boolean = True) : System.Integer;
var
   Counter : System.Integer;
begin
   if ATypeInfo.Kind = tkSet then
       ATypeInfo := TypInfo.GetTypeData(ATypeInfo).CompType^;

   Result := 0;
   for Counter := TypInfo.GetTypeData(ATypeInfo).MinValue to TypInfo.GetTypeData(ATypeInfo).MaxValue do
   begin
       Inc(Result);
       if AStrings <> nil then
       begin
           if FormatNames then
               AStrings.AddObject(FormatEnumName(TypInfo.GetEnumName(ATypeInfo, Counter)), TObject(Counter))
           else
               AStrings.AddObject(TypInfo.GetEnumName(ATypeInfo, Counter), TObject(Counter));
       end;
   end;
end;

type
   TIntegerSet = set of 0..SizeOf(Integer) * 8 - 1;

function LoadFromStrings(AItems, AStrings : TStrings; IsSet : Boolean) : Integer;
var
   Counter, Pointer : Integer;
   ThisValue : string;
   NewValue : TIntegerSet;
begin
   NewValue := [];
   for Counter := 0 to AStrings.Count - 1 do
   begin
       ThisValue := AStrings.Strings[Counter];
       Pointer := AItems.IndexOf(ThisValue);
       if Pointer <> NOT_FOUND_INDEX then
       begin
           if AStrings.Values[ThisValue] = '1' then
           begin
               if IsSet then
                   Include(NewValue, Pointer)
               else
               begin
                   NewValue := TIntegerSet(Pointer);
                   Break;
               end;
           end;
       end;
   end;
   Result := Integer(NewValue);
end;

function GetComponents(AHost : TComponent; AList : TStrings) : System.Integer;
begin
   Result := GetComponents(AHost, [], AList);
end;

function GetComponents(AHost : TComponent; const Classes : array of TClass; AList : TStrings) : System.Integer;
var
   AllClasses, ClassAccepted : Boolean;
   Counter, ClassCounter : System.Integer;
   ThisClass : TClass;
begin
   Result := 0;
   AllClasses := Length(Classes) = 0;

   for Counter := 0 to AHost.ComponentCount - 1 do
   begin
       if AllClasses then
           ClassAccepted := True
       else
       begin
           ClassAccepted := False;
           ThisClass := AHost.Components[Counter].ClassType;
           for ClassCounter := Low(Classes) to High(Classes) do
           begin
               if ThisClass.InheritsFrom(Classes[ClassCounter]) then
               begin
                   ClassAccepted := True;
                   Break;
               end;
           end;
       end;
       if ClassAccepted then
       begin
           Inc(Result);
           if AList <> nil then
               AList.AddObject(AHost.Components[Counter].Name, AHost.Components[Counter]);
       end;
{$IFNDEF VER120}
       if AHost.Components[Counter] is TFrame then
           Inc(Result, GetComponents(AHost.Components[Counter], Classes, AList)); //  recursive
{$ENDIF}
   end;
end;

function GetControls(AParent : TWinControl; AList : TStrings = nil) : System.Integer;
begin
   Result := GetControls(AParent, [], AList);
end;

function GetControls(AParent : TWinControl; const Classes : array of TClass; AList : TStrings) : System.Integer;
var
   AllClasses, ClassAccepted : Boolean;
   Counter, ClassCounter : System.Integer;
   ThisClass : TClass;
begin
   Result := 0;
   AllClasses := Length(Classes) = 0;

   for Counter := 0 to AParent.ControlCount - 1 do
   begin
       if AllClasses then
           ClassAccepted := True
       else
       begin
           ClassAccepted := False;
           ThisClass := AParent.Controls[Counter].ClassType;
           for ClassCounter := Low(Classes) to High(Classes) do
           begin
               if ThisClass.InheritsFrom(Classes[ClassCounter]) then
               begin
                   ClassAccepted := True;
                   Break;
               end;
           end;
       end;
       if ClassAccepted then
       begin
           Inc(Result);
           if AList <> nil then
               AList.AddObject(AParent.Controls[Counter].Name, AParent.Controls[Counter]);
       end;
       if AParent.Controls[Counter] is TWinControl then
           Inc(Result, GetControls(TWinControl(AParent.Controls[Counter]), Classes, AList)); //  recursive
   end;
end;

function FocusOnFirstChild(AParent : TWinControl) : Boolean;
var
   ControlList : TList;
   Counter : System.Integer;
   ThisControl : TWinControl;
begin
   Result := False;
   ControlList := TList.Create;
   try
{$IFDEF FOCUS_ON_CTRLGRID}
       if AParent is TDBCtrlGrid then                      //  this control defeats GetTabOrderList
       begin
           for Counter := 0 to AParent.ControlCount - 1 do
           begin
               if AParent.Controls[Counter] is TWinControl then
                   ControlList.Add(AParent.Controls[Counter]);
           end;
           { TODO: sort by TabOrder }
       end
       else
{$ENDIF}
           AParent.GetTabOrderList(ControlList);

       for Counter := 0 to ControlList.Count - 1 do
       begin
           ThisControl := TWinControl(ControlList.Items[Counter]);
           if ThisControl.TabStop and ThisControl.CanFocus then
           begin
               ThisControl.SetFocus;
               if (ThisControl is TPageControl) or
{$IFDEF FOCUS_ON_CTRLGRID}
               (ThisControl.ClassName is TDBCtrlGrid) or
{$ENDIF}
               (ThisControl is TTabSheet) then
               begin
                   FocusOnFirstChild(ThisControl);
               end;
               Result := True;
               Break;
           end;
       end;
   finally
       ControlList.Free;
   end;
end;

function ComplimentryColor(AColor : TColor) : TColor;
begin
   Result := (not AColor) and $00FFFFFF;                   //  reverse the colors
end;

{$IFDEF VER120}

function AnsiSameStr(const String1, String2 : string) : Boolean;
begin
   Result := (AnsiCompareStr(String1, String2) = 0);
end;

function AnsiSameText(const String1, String2 : string) : Boolean;
begin
   Result := (AnsiCompareStr(AnsiUpperCase(String1), AnsiUpperCase(String2)) = 0);
end;

function SameText(const String1, String2 : string) : Boolean;
begin
   Result := CompareText(String1, String2) = 0;
end;

function IncludeTrailingBackslash(const AString : string) : string;
begin
   Result := AString;
   if (Length(Result) > 0) and (Result[Length(Result)] <> '\') then
       Result := Result + '\';
end;

{$ENDIF}

function IndexOf(const AnArray : array of string; const AString : string) : Integer;
var
   Counter : Integer;
begin
   Result := NOT_FOUND_INDEX;
   for Counter := Low(AnArray) to High(AnArray) do
   begin
       if AnArray[Counter] = AString then
       begin
           Result := Counter;
           Break;
       end;
   end;
end;

function IndexOf(const AnArray : array of Word; const AWord : Word) : Integer; overload;
var
   Counter : Integer;
begin
   Result := NOT_FOUND_INDEX;
   for Counter := Low(AnArray) to High(AnArray) do
   begin
       if AnArray[Counter] = AWord then
       begin
           Result := Counter;
           Break;
       end;
   end;
end;

function IndexOf(const AnArray : array of Integer; const AnInteger : Integer) : Integer; overload;
var
   Counter : Integer;
begin
   Result := NOT_FOUND_INDEX;
   for Counter := Low(AnArray) to High(AnArray) do
   begin
       if AnArray[Counter] = AnInteger then
       begin
           Result := Counter;
           Break;
       end;
   end;
end;

function SameShortestStr(const String1, String2 : string) : Boolean;
var
   ShortestLength : Integer;
begin
   ShortestLength := Length(String1);
   if Length(String2) < ShortestLength then
   begin
       ShortestLength := Length(String2);
       Result := CompareStr(Copy(String1, 1, ShortestLength), String2) = 0;
   end
   else
       Result := CompareStr(Copy(String2, 1, ShortestLength), String1) = 0;
end;

function SameShortestText(const String1, String2 : string) : Boolean;
var
   ShortestLength : Integer;
begin
   ShortestLength := Length(String1);
   if Length(String2) < ShortestLength then
   begin
       ShortestLength := Length(String2);
       Result := SameText(Copy(String1, 1, ShortestLength), String2);
   end
   else
       Result := SameText(Copy(String2, 1, ShortestLength), String1);
end;

function SameAlpha(const String1, String2 : string) : Boolean;
var
   Pointer1, Pointer2 : System.Integer;
begin
   Result := False;
   Pointer1 := 1;
   Pointer2 := 1;
   while (Pointer1 <= Length(String1)) and (Pointer2 <= Length(String2)) do
   begin
       while (Pointer1 <= Length(String1)) and (not (String1[Pointer1] in ALPHA_NUMERIC_CHARS)) do
           Inc(Pointer1);
       while (Pointer2 <= Length(String2)) and (not (String2[Pointer2] in ALPHA_NUMERIC_CHARS)) do
           Inc(Pointer2);
       if UpCase(String1[Pointer1]) <> UpCase(String2[Pointer2]) then
           Exit;
       Inc(Pointer1);
       Inc(Pointer2);
   end;
   Result := (Pointer1 = (Length(String1) + 1)) and ((Pointer2 = Length(String2) + 1));
end;

function SameLeadingText(const String1, String2 : string) : Boolean;
begin
   if Length(String1) < Length(String2) then
       Result := SameText(String1, Copy(String2, 1, Length(String1)))
   else
       Result := SameText(String2, Copy(String1, 1, Length(String2)));
end;
{
Cases
str                    no wldcards
*str                   leading
str*                   trailing
s*r                    middle
*str*                  both
s?r                    single character placeholder
??s*?B                 embedded multi next to a single placeholder
s*?*B                  pathological case
}

function SameWildcardText(String1, String2 : string) : Boolean;

   function StripToNextWildcard(var AString : string; var AWildcard : Char) : string;
   var
       Counter : System.Integer;
   begin
       for Counter := 1 to Length(AString) do
       begin
           if AString[Counter] in ['?', '*'] then
           begin
               Result := Copy(AString, 1, Counter - 1);
               AWildcard := AString[Counter];
               Delete(AString, 1, Counter);
               Exit;
           end;
       end;
       Result := AString;
       AString := EMPTY_STRING;
       AWildcard := #0;
   end;

var
   ThisPortion : string;
   ThisWildcard : Char;
   Index, SingleWildcardCount : System.Integer;
begin
   Result := False;
   ThisPortion := StripToNextWildcard(String1, ThisWildcard);
   while (ThisPortion <> EMPTY_STRING) or (ThisWildcard <> #0) do
   begin
       if ThisPortion <> EMPTY_STRING then
       begin
           if SameText(ThisPortion, Copy(String2, 1, Length(ThisPortion))) then
               Delete(String2, 1, Length(ThisPortion))
           else
               Exit;                                       //  return False
       end;

       case ThisWildcard of
           '?' :                                           // matches any single character
               begin
                   if Length(String2) = 0 then
                       Break                               //  return false
                   else
                   begin
                       Delete(String2, 1, 1);
                       ThisPortion := StripToNextWildcard(String1, ThisWildcard);
                   end;
               end;
           '*' :
               begin
                   SingleWildcardCount := 0;
                   while (ThisPortion = EMPTY_STRING) and (String1 <> EMPTY_STRING) do //   aggragate wildcards
                   begin
                       ThisPortion := StripToNextWildcard(String1, ThisWildcard);

                       if ThisWildcard = '?' then
                           Inc(SingleWildcardCount);
                   end;

                   if ThisPortion <> EMPTY_STRING then     //  *??ABC   it really should be <>
                   begin
                       while True do
                       begin
                           Index := Pos(UpperCase(ThisPortion), UpperCase(String2));
                           if (Index = 0) then
                               Break                       //  return False
                           else if Index > SingleWildcardCount then
                           begin
                               Delete(String2, 1, Index + Length(ThisPortion) - 1);
                               ThisPortion := EMPTY_STRING; //  we matched
                               Break;
                           end
                           else
                           begin
                               Delete(String2, 1, Index + Length(ThisPortion) - 1);
                               Dec(SingleWildcardCount, Index + Length(ThisPortion) - 1);
                           end;
                       end;
                   end

                   else if String1 = EMPTY_STRING then     //   trailing wildcard: abc*
                   begin
                       if Length(String2) >= SingleWildcardCount then
                           String2 := EMPTY_STRING;
                       Break;
                   end;
               end;

           #0 :
               ThisPortion := StripToNextWildcard(String1, ThisWildcard);
       end;
   end;

   Result := (String2 = EMPTY_STRING);
end;

function WideStrToString(AWideString : WideString) : string;
begin
   Result := WideCharToString(PWideChar(AWideString));
end;

function StringToWideStr(const Source : string) : WideString;
begin
   SetLength(Result, Length(Source));
   StringToWideChar(Source, PWideChar(Result), Length(Source));
end;

procedure LoadPropertyValues(Source : TPersistent; AStrings : TStrings; PropertyPrefix : string);
var
   ThisProp : PPropInfo;
   PropInfos : TPropList;
   ThisKind : TypInfo.TTypeKind;
   Counter : System.Integer;
begin
   TypInfo.GetPropInfos(Source.ClassInfo, @PropInfos);
   for Counter := 0 to GetTypeData(Source.ClassInfo)^.PropCount - 1 do
   begin
       ThisProp := PropInfos[Counter];
       ThisKind := ThisProp.PropType^.Kind;
       case ThisKind of
           tkEnumeration :
               begin
                   AStrings.AddObject(PropertyPrefix + ThisProp.Name + '=' +
                       TypInfo.GetEnumName(ThisProp.PropType^, GetOrdProp(Source, ThisProp)), TObject(ThisKind));
               end;
           tkSet :
               begin
                   AStrings.AddObject(PropertyPrefix + ThisProp.Name + '=' +
                       TypInfo.SetToString(@ThisProp.PropType, GetOrdProp(Source, ThisProp), True), TObject(ThisKind));
               end;
           tkInteger, tkChar, tkWChar :
               begin
                   AStrings.AddObject(PropertyPrefix + ThisProp.Name + '=' +
                       IntToStr(GetOrdProp(Source, ThisProp)), TObject(ThisKind));
               end;
           tkFloat :
               begin
                   AStrings.AddObject(PropertyPrefix + ThisProp.Name + '=' +
                       FloatToStr(GetFloatProp(Source, ThisProp)), TObject(ThisKind));
               end;
           tkString, tkLString, tkWString :
               begin
                   AStrings.AddObject(PropertyPrefix + ThisProp.Name + '=' +
                       GetStrProp(Source, ThisProp), TObject(ThisKind));
               end;
           tkVariant :
               begin
                   AStrings.AddObject(PropertyPrefix + ThisProp.Name + '=' +
                       GetVariantProp(Source, ThisProp), TObject(ThisKind));
               end;
           tkInt64 :
               begin
                   AStrings.AddObject(PropertyPrefix + ThisProp.Name + '=' +
                       IntToStr(GetInt64Prop(Source, ThisProp)), TObject(ThisKind));
               end;
           tkClass :
               if (TObject(GetOrdProp(Source, ThisProp)) is TPersistent) and
                   (not (TObject(GetOrdProp(Source, ThisProp)) is TComponent)) then
               begin                                       //       recursive
                   LoadPropertyValues(Source, AStrings, ThisProp.Name + '.');
               end;
       else
           AStrings.Add(ThisProp.Name + '=<unknown type>');
       end;
   end;
end;

procedure SetPropertyValues(Source : TPersistent; AStrings : TStrings);
var
   ThisProp : PPropInfo;
   PropInfos : TPropList;
   Counter, Index, ThisIntegerValue : System.Integer;
   ThisValue, RootObjectName : string;
begin
   RootObjectName := Copy(Source.ClassName, 2, MaxInt);
   Counter := 0;
   while (Counter < Length(RootObjectName)) and (Counter < Length(Source.ClassParent.ClassName)) do
   begin
       if Source.ClassName[Length(RootObjectName) - Counter] <> Source.ClassParent.ClassName[Length(Source.ClassParent.ClassName) - Counter] then
           Break
       else
           Inc(Counter);
   end;
   Delete(RootObjectName, 1, Length(RootObjectName) - Counter);

   TypInfo.GetPropInfos(Source.ClassInfo, @PropInfos);
   for Counter := 0 to GetTypeData(Source.ClassInfo)^.PropCount - 1 do
   begin
       ThisProp := PropInfos[Counter];
       ThisIntegerValue := NOT_FOUND_INDEX;
       ThisValue := EMPTY_STRING;
       Index := AStrings.IndexOfName(ThisProp.Name);
       if Index <> NOT_FOUND_INDEX then
           ThisValue := AStrings.Values[AStrings.Names[Index]]
       else
       begin
           Index := AStrings.IndexOf(ThisProp.Name);
           if Index <> NOT_FOUND_INDEX then
               ThisIntegerValue := Integer(AStrings.Objects[Index]);
       end;

       if Index <> NOT_FOUND_INDEX then
       begin
           ThisValue := AStrings.Values[AStrings.Names[Index]];
           if ThisValue <> EMPTY_STRING then
           begin
               case ThisProp.PropType^.Kind of
                   tkEnumeration :
                       if ThisIntegerValue <> NOT_FOUND_INDEX then
                           SetOrdProp(Source, ThisProp, ThisIntegerValue)
                       else
                           SetOrdProp(Source, ThisProp, StrToInt(ThisValue));
                   tkSet :
                       if ThisIntegerValue <> NOT_FOUND_INDEX then
                           SetOrdProp(Source, ThisProp, ThisIntegerValue)
                       else
                           SetOrdProp(Source, ThisProp, StringToSet(@ThisProp.PropType, ThisValue));

                   tkInteger, tkChar, tkWChar : SetOrdProp(Source, ThisProp, StrToInt(ThisValue));
                   tkFloat : SetFloatProp(Source, ThisProp, StrToFloat(ThisValue));
                   tkString, tkLString, tkWString, tkVariant : SetStrProp(Source, ThisProp, ThisValue);
                   tkInt64 : SetInt64Prop(Source, ThisProp, StrToInt(ThisValue));
                   tkClass : ;                             {TODO: owner:RCH recursively assign}
               end;
           end;
       end;
   end;
end;

function IsAnyPropertyStored(Source : TPersistent) : Boolean;
var
   ThisProp : PPropInfo;
   PropertyCount, Counter : System.Integer;
   PropertyList : PPropList;
begin
   Result := False;

   PropertyCount := GetTypeData(Source.ClassInfo)^.PropCount;
   if PropertyCount > 0 then
   begin
       GetMem(PropertyList, PropertyCount * SizeOf(Pointer));
       try
           Result := True;
           GetPropInfos(Source.ClassInfo, PropertyList);
           for Counter := 0 to PropertyCount - 1 do
           begin
               ThisProp := PropertyList^[Counter];

               case ThisProp.PropType^.Kind of
                   tkEnumeration, tkSet, tkInteger, tkChar, tkWChar :
                       if IsStoredProp(Source, ThisProp) and (GetOrdProp(Source, ThisProp) <> ThisProp.Default) then
                           Exit;
                   tkFloat :
                       if IsStoredProp(Source, ThisProp) and (GetFloatProp(Source, ThisProp) <> 0.0) then
                           Exit;
                   tkString, tkLString, tkWString :
                       if IsStoredProp(Source, ThisProp) and (GetStrProp(Source, ThisProp) <> '') then
                           Exit;
                   tkVariant :
                       if IsStoredProp(Source, ThisProp) and (GetVariantProp(Source, ThisProp) <> varNull) and
                           (not VarIsEmpty(GetVariantProp(Source, ThisProp))) then
                       begin
                           Exit;
                       end;
                   tkInt64 :
                       if IsStoredProp(Source, ThisProp) and (GetInt64Prop(Source, ThisProp) <> ThisProp.Default) then
                           Exit;
                   tkClass :
                       if IsStoredProp(Source, ThisProp) and (TObject(GetOrdProp(Source, ThisProp)) is TPersistent) and
                           (not (TObject(GetOrdProp(Source, ThisProp)) is TComponent)) then
                       begin                               //       recursive
                           if IsAnyPropertyStored(TPersistent(GetOrdProp(Source, ThisProp))) then
                               Exit;
                       end;
               end;
           end;
           Result := False;
       finally
           FreeMem(PropertyList, PropertyCount * SizeOf(Pointer));
       end;
   end;
end;

procedure AssignAllProperties(Source, Target : TPersistent);
var
   ThisProp : PPropInfo;
   PropInfos : TPropList;
   Counter : System.Integer;
begin
   TypInfo.GetPropInfos(Source.ClassInfo, @PropInfos);
   for Counter := 0 to GetTypeData(Source.ClassInfo)^.PropCount - 1 do
   begin
       ThisProp := PropInfos[Counter];
       if (ThisProp.Name = 'Name') and (ThisProp.PropType^.Kind in [tkString, tkLString]) then
           SetStrProp(Target, ThisProp, GetStrProp(Source, ThisProp) + 'Clone')
       else
       begin
           case ThisProp.PropType^.Kind of
               tkInteger, tkChar, tkEnumeration, tkSet, tkClass, tkWChar :
                   SetOrdProp(Target, ThisProp, GetOrdProp(Source, ThisProp));
               tkFloat : SetFloatProp(Target, ThisProp, GetFloatProp(Source, ThisProp));
               tkString, tkLString, tkWString :
                   SetStrProp(Target, ThisProp, GetStrProp(Source, ThisProp));

               tkVariant : SetVariantProp(Target, ThisProp, GetVariantProp(Source, ThisProp));
               tkMethod : SetMethodProp(Target, ThisProp, GetMethodProp(Source, ThisProp));
               tkInt64 : SetInt64Prop(Target, ThisProp, GetInt64Prop(Source, ThisProp));
           end;
       end;
   end;
end;

procedure ClonePersistent(Source : TPersistent; var Target : TPersistent);
var
   ComponentClass : TComponentClass;
begin
   if Target = nil then
   begin
       if Source is TComponent then
       begin
           ComponentClass := TComponentClass(Source.ClassType);
           Target := ComponentClass.Create(TComponent(Source).Owner);
           TComponent(Target).Name := TComponent(Source).Name + 'Clone';
       end
       else
           Target := Source.Create;
   end;

   if Source is TControl then
       TControl(Target).Parent := TControl(Source).Parent;

   AssignAllProperties(Source, Target);                    {TODO: owner:RCH  recursive }
end;

function SameProperties(AnAncestor, ADescendent : TPersistent;
   CheckAncestorPropertiesOnly, CheckMethods, CheckRecursively : Boolean) : Boolean;
var
   ThisProp1, ThisProp2 : PPropInfo;
   PropInfos : TPropList;
   Counter : System.Integer;
begin
   Result := False;

   TypInfo.GetPropInfos(ADescendent.ClassInfo, @PropInfos);
   for Counter := 0 to GetTypeData(ADescendent.ClassInfo)^.PropCount - 1 do
   begin
       ThisProp1 := PropInfos[Counter];
       ThisProp2 := TypInfo.GetPropInfo(AnAncestor.ClassInfo, ThisProp1.Name);
       if ThisProp2 = nil then
       begin
           if not CheckAncestorPropertiesOnly then
           begin
               case ThisProp1.PropType^.Kind of
                   tkInteger, tkChar, tkEnumeration, tkSet, tkClass, tkWChar :
                       if GetOrdProp(ADescendent, ThisProp1) <> ThisProp1.Default then
                           Exit;                           //  <-------        not the default value
                   tkFloat :
                       if GetFloatProp(ADescendent, ThisProp1) <> 0.0 then
                           Exit;                           //  <-------        not the "empty" value

                   tkString, tkLString, tkWString :
                       if GetStrProp(ADescendent, ThisProp1) <> EMPTY_STRING then
                           Exit;                           //  <-------        not the "empty" value

                   tkVariant :
                       if GetVariantProp(ADescendent, ThisProp1) <> varNull then
                           Exit;                           //  <-------        not the "empty" value

                   tkMethod :
                       if CheckMethods and (GetMethodProp(ADescendent, ThisProp1).Code <> nil) then
                           Exit;                           //  <-------        not the "empty" value

                   tkInt64 :
                       if GetInt64Prop(ADescendent, ThisProp1) <> 0 then
                           Exit;                           //  <-------        not the "empty" value
               end;
           end;
       end
       else
       begin
           if (ThisProp1.Name <> 'Name') then
           begin
               case ThisProp1.PropType^.Kind of
                   tkInteger, tkChar, tkEnumeration, tkSet, tkWChar :
                       if (not (ThisProp2.PropType^.Kind in [tkInteger, tkChar, tkEnumeration, tkSet, tkWChar])) or
                           (GetOrdProp(ADescendent, ThisProp1) <> GetOrdProp(AnAncestor, ThisProp2)) then
                       begin
                           Exit;                           //  <-------        not the same value
                       end;
                   tkFloat :
                       if (ThisProp2.PropType^.Kind <> tkFloat) or
                           (GetFloatProp(ADescendent, ThisProp1) <> GetFloatProp(AnAncestor, ThisProp2)) then
                       begin
                           Exit;                           //  <-------        not the same value
                       end;

                   tkString, tkLString, tkWString :
                       if (not (ThisProp2.PropType^.Kind in [tkString, tkLString, tkWString])) or
                           (GetStrProp(ADescendent, ThisProp1) <> GetStrProp(AnAncestor, ThisProp2)) then
                       begin
                           Exit;                           //  <-------        not the same value
                       end;

                   tkVariant :
                       if (ThisProp2.PropType^.Kind <> tkVariant) or
                           (GetVariantProp(ADescendent, ThisProp1) <> GetVariantProp(AnAncestor, ThisProp2)) then
                       begin
                           Exit;                           //  <-------        not the same value
                       end;

                   tkMethod :
                       if CheckMethods and
                           ((ThisProp2.PropType^.Kind <> tkMethod) or
                           (GetMethodProp(ADescendent, ThisProp1).Code <> GetMethodProp(AnAncestor, ThisProp2).Code) or
                           (GetMethodProp(ADescendent, ThisProp1).Data <> GetMethodProp(AnAncestor, ThisProp2).Data)) then
                       begin
                           Exit;                           //  <-------        not the same value
                       end;

                   tkInt64 :
                       if (ThisProp2.PropType^.Kind <> tkInt64) or
                           (GetInt64Prop(ADescendent, ThisProp1) <> GetInt64Prop(AnAncestor, ThisProp2)) then
                       begin
                           Exit;                           //  <-------        not the same value
                       end;

                   tkClass :
                       if (ThisProp2.PropType^.Kind <> tkClass) or
                           (GetOrdProp(ADescendent, ThisProp1) <> GetOrdProp(ADescendent, ThisProp2)) then
                       begin
                           Exit                            //  <-------        not the default value
                       end

                       else if CheckRecursively and (TObject(GetOrdProp(ADescendent, ThisProp1)) is TPersistent) and
                           (not (TObject(GetOrdProp(ADescendent, ThisProp1)) is TComponent)) then
                       begin                               //       recursive
                           if not SameProperties(TPersistent(GetOrdProp(ADescendent, ThisProp1)),
                               TPersistent(GetOrdProp(ADescendent, ThisProp1)), CheckAncestorPropertiesOnly, CheckMethods, CheckRecursively) then
                           begin
                               Exit;
                           end;
                       end;
               end;
           end;
       end;
   end;
   Result := True;
end;

type
   TByteSet = set of 0..SizeOf(Byte) * 8 - 1;
   TWordSet = set of 0..SizeOf(Word) * 8 - 1;
   TDWordSet = set of 0..SizeOf(DWord) * 8 - 1;

function SetToStr(ATypeInfo : PTypeInfo; const ASetValue; FormatNames : Boolean) : string;

   procedure AddName(const AName : string);
   begin
       if FormatNames then
           Result := Result + ',' + FormatEnumName(AName)
       else
           Result := Result + ',' + AName;
   end;

var
   Counter : System.Integer;
begin
   Result := EMPTY_STRING;
   if ATypeInfo.Kind = tkSet then
       ATypeInfo := GetTypeData(ATypeInfo).CompType^;

   case GetTypeData(ATypeInfo).MaxValue of
       0..7 :
           begin
               for Counter := 0 to SizeOf(TByteSet) * 8 - 1 do //  taken from Classes.PAS
               begin
                   if Counter in TByteSet(ASetValue) then
                       AddName(GetEnumName(ATypeInfo, Counter));
               end;
           end;
       8..64 :
           begin
               for Counter := 0 to SizeOf(TWordSet) * 8 - 1 do //  taken from Classes.PAS
               begin
                   if Counter in TWordSet(ASetValue) then
                       AddName(GetEnumName(ATypeInfo, Counter));
               end;
           end;
   else
       begin
           for Counter := 0 to SizeOf(TDWordSet) * 8 - 1 do //  taken from Classes.PAS
           begin
               if Counter in TDWordSet(ASetValue) then
                   AddName(GetEnumName(ATypeInfo, Counter));
           end;
       end;
   end;
   Delete(Result, 1, 1);
end;

function StrToSet(ATypeInfo : PTypeInfo; AString : string) : System.Integer;
var
   ThisString : string;
begin
   Result := 0;
   if ATypeInfo.Kind = tkSet then
       ATypeInfo := GetTypeData(ATypeInfo).CompType^;
   while AString <> EMPTY_STRING do
   begin
       ThisString := StripTo(AString, [',', ' '], []);
       Include(TIntegerSet(Result), GetEnumValue(ATypeInfo, ThisString));
   end;
end;

{///////////////////////////////////////////////////////////////////////}
{Adapted from a TI }

const
   C1 : Int64 = 54525;
   C2 : Int64 = 22716;

function EnCode(SourceText : string; Key : Integer) : string;
var
   Counter : System.Integer;
begin
   Result := EMPTY_STRING;
   for Counter := 1 to Length(SourceText) do
   begin
       Result := Result + Char(Byte(SourceText[Counter]) xor (Key shr 3));
       Key := (((Byte(Result[Counter]) + Key) * C1) + C2) mod 121;
   end;
end;

function DeCode(SourceText : string; Key : Integer) : string;
var
   Counter : System.Integer;
begin
   Result := EMPTY_STRING;
   Counter := 1;
   while Counter <= Length(SourceText) do
   begin
       Result := Result + Char(Byte(SourceText[Counter]) xor (Key shr 3));
       Key := (((Byte(SourceText[Counter]) + Key) * C1) + C2) mod 121;
       Inc(Counter);
   end;
end;

function StrToSoundex(AString : string) : string;
const
   THREE_LETTER_CODES = ';SCH;ING;';
   THREE_LETTER_CHARS = '+N';
   TWO_LETTER_CODES = ';GH;LD;PH;DT;PF;SH;QU;KN;GN;CH;EY;AY;EE;IA;00;0W;EI;IE;UE;EN;ON;AN;OA;';
   TWO_LETTER_CHARS = 'FDFTF+KNN-YYYAOOI!WNNO';
   MAX_CODE_LENGTH = 6;

var
   Index, Offset : System.Integer;
   ThisChar : Char;
begin
   Result := EMPTY_STRING;

   AString := UpperCase(Trim(AString));
   AString := Copy(AString, 1, 1) + StringReplace(StringReplace(Copy(AString, 2, MaxInt),
       'H', EMPTY_STRING, [rfReplaceAll]), 'X', EMPTY_STRING, [rfReplaceAll]);
   Index := 0;
   while Index < Length(AString) do
   begin
       Inc(Index);
       ThisChar := AString[Index];

       if Index < Length(AString) then
       begin
           Offset := Pos(';' + Copy(AString, Index, 3) + ';', THREE_LETTER_CODES);
           if Offset <> 0 then
           begin
               ThisChar := THREE_LETTER_CHARS[(Offset div 4) + 1];
               Inc(Index, 2);                              //  we've already translated the second and third characters
           end
           else
           begin
               Offset := Pos(';' + Copy(AString, Index, 2) + ';', TWO_LETTER_CODES);
               if Offset <> 0 then
               begin
                   ThisChar := TWO_LETTER_CHARS[(Offset div 3) + 1];
                   Inc(Index);                             //  we've already translated the second character
               end;
           end;
       end;

       if Result = EMPTY_STRING then
       begin
           case ThisChar of
               'B', 'P', 'V' : ThisChar := 'B';
               'C', 'K', 'Q' : ThisChar := 'K';
               'S', 'X', 'Z', '+' : ThisChar := 'S';
               'D', 'T' : ThisChar := 'D';
               'L' : ThisChar := 'L';
               'F' : ThisChar := 'F';
               'M', 'N' : ThisChar := 'M';
               'R' : ThisChar := 'R';
               'G', 'J' : ThisChar := 'G';
               'W', 'U', 'O' : ThisChar := 'W';
               'A', 'E' : ThisChar := 'A';
               'I', 'Y' : ThisChar := 'Y';
               '-' : ThisChar := 'C';
           else                                            {                  'H' : }
               ThisChar := '0';
           end
       end
       else
       begin
           case ThisChar of
               'B', 'P' : ThisChar := 'B';
               'C', 'K', 'Q' : ThisChar := 'K';
               'S', 'Z', '+' : ThisChar := 'S';
               'D', 'T' : ThisChar := 'D';
               'L' : ThisChar := 'L';
               'M', 'N' : ThisChar := 'M';
               'R' : ThisChar := 'R';
               'G', 'J' : ThisChar := 'G';
               'V' : ThisChar := 'V';
               '-' : ThisChar := 'C';
               'W', 'U', 'O' : ThisChar := 'W';
               'A', 'E' : ThisChar := 'A';
               'I', 'Y' : ThisChar := 'Y';
               'F' : ThisChar := 'F';
           else                                            {       not H, X        }
               ThisChar := '0';
           end;
       end;

       {
                  Duprey = DWBRA; Taber = DYBAR
                  Sedoria = SADWRA; Stohr = SDWR

       }

       if (ThisChar <> '0') and
           ((Length(Result) <= 1) or (Result[Length(Result)] <> ThisChar)) then //  no code twice in a row
       begin
           Result := Result + ThisChar;
           if Length(Result) = MAX_CODE_LENGTH then
               Break;
       end;
   end;
end;

function EncodeDateExtended(AYear, AMonth, ADay : Integer) : TDateTime;
var
   BYear, BMonth, BDay : Word;
begin
   while AMonth > 12 do
   begin
       Dec(AMonth, 12);
       Inc(AYear);
   end;
   while AMonth < 1 do
   begin
       Inc(AMonth, 12);
       Dec(AYear);
   end;

   if ADay >= 28 then
   begin
       {//            get this month's day-count, subtract it from ADay, and try again    }
       DecodeDate((EncodeDateExtended(AYear, AMonth + 1, 1) - 1), BYear, BMonth, BDay);
       if ADay > BDay then
       begin
           Result := EncodeDateExtended(AYear, (AMonth + 1), (ADay - BDay)); //  recursive
           Exit;
       end;
   end;

   if ADay < 1 then
   begin
       {//                get last month's day-count, add it to ADay, and try again   }
       DecodeDate((EncodeDateExtended(AYear, (AMonth - 1), 1) - 1), BYear, BMonth, BDay); //  recursive
       Result := EncodeDateExtended(AYear, (AMonth - 1), (ADay + BDay)); //  recursive
       Exit;
   end;

   Result := EncodeDate(AYear, AMonth, ADay);
end;

{
This function checks AString for:
Legal date (accepted by StrToDate based on current SysUtils.ShortDateFormat
All numeric digits (Year assumed to be two digits)
Six-digits
Four-digits
Five-digits
Unambiguous digits consistent with the DateFormat: 13297, 23689, 72390
Ambiguous digits: 12295
Month Name
}

function StrToDateEx(AString : string; AShortDateFormat : string = EMPTY_STRING) : TDateTime;
var
   DatePartSequence : array[0..2] of string[4];
   MonthIndex, DayIndex, YearIndex : System.Integer;
   RawMask : string;
   Month, Day, Year : System.Integer;

   function IsLegalDay(ADay, AMonth, AYear : Integer) : Boolean;
   begin
       if (ADay >= 1) and (ADay <= DaysInMonth(AMonth, AYear)) then
           Result := True
       else
           Result := False;
   end;

   function IsLegalMonth(AMonth, AYear : Integer) : Boolean;
   begin
       if (AMonth >= 1) and (AMonth <= 12) then
           Result := True
       else
           Result := False;
   end;

   procedure LoadAndStrip(var Target : System.Integer; Start, Len : Integer);
   begin
       Target := StrToIntDef(Copy(AString, Start, Len), 0);
       Delete(AString, Start, Len);
   end;

   procedure Parse5Digits;
       {       Month, Day, Year : Integer are global to the containing proc  }

       function GrabBeginning(var Target : System.Integer; Code : string) : Boolean;
       begin
           if DatePartSequence[0] = Code then
           begin
               LoadAndStrip(Target, 1, 2);
               Result := True;
           end
           else
               Result := False;
       end;

       function GrabEnd(var Target : System.Integer; Code : string) : Boolean;
       begin
           if DatePartSequence[2] = Code then
           begin
               LoadAndStrip(Target, 4, 2);
               Result := True;
           end
           else
               Result := False;
       end;

   begin
       Month := 0;
       Day := 0;
       Year := 0;

       if not (GrabEnd(Year, 'YY') or GrabEnd(Month, 'MM') or GrabEnd(Day, 'DD')) then
           ;
       if not (GrabBeginning(Year, 'YY') or GrabBeginning(Month, 'MM') or GrabBeginning(Day, 'DD')) then
           ;
       if Length(AString) = 1 then
       begin
           if MonthIndex = 2 then
               LoadAndStrip(Month, 1, 1)
           else if DayIndex = 2 then
               LoadAndStrip(Day, 1, 1);
       end
       else if Year = 0 then
           (* *)
       else if (DatePartSequence[0] = 'D') and (DatePartSequence[1] = 'M') then
       begin
           if IsLegalDay(StrToIntDef(Copy(AString, 1, 2), 0), StrToIntDef(Copy(AString, 3, 1), 0), Year) and
               IsLegalMonth(StrToIntDef(Copy(AString, 3, 1), 0), Year) then
           begin
               LoadAndStrip(Day, 1, 2);
               LoadAndStrip(Month, 3, 1);
           end
           else if IsLegalDay(StrToIntDef(Copy(AString, 1, 1), 0), StrToIntDef(Copy(AString, 2, 2), 0), Year) and
               IsLegalMonth(StrToIntDef(Copy(AString, 2, 2), 0), Year) then
           begin
               LoadAndStrip(Day, 1, 1);
               LoadAndStrip(Month, 2, 2);
           end;
       end
       else if (DatePartSequence[1] = 'D') and (DatePartSequence[0] = 'M') then
       begin
           if IsLegalDay(StrToIntDef(Copy(AString, 3, 1), 0), StrToIntDef(Copy(AString, 1, 2), 0), Year) and
               IsLegalMonth(StrToIntDef(Copy(AString, 1, 2), 0), Year) then
           begin
               Day := StrToIntDef(Copy(AString, 3, 1), 0);
               Month := StrToIntDef(Copy(AString, 1, 2), 0);
           end
           else if IsLegalDay(StrToIntDef(Copy(AString, 2, 2), 0), StrToIntDef(Copy(AString, 1, 1), 0), Year) and
               IsLegalMonth(StrToIntDef(Copy(AString, 1, 1), 0), Year) then
           begin
               Day := StrToIntDef(Copy(AString, 2, 2), 0);
               Month := StrToIntDef(Copy(AString, 1, 1), 0);
           end
       end;
   end;

   procedure SetIndex(var Index : System.Integer; Code : string);
   var
       Counter : System.Integer;
   begin
       for Counter := 0 to 2 do
       begin
           if DatePartSequence[Counter][1] = Code then
           begin
               Index := Counter;
               Break;
           end;
       end;
   end;

var
   Pointer, Counter : System.Integer;
   ThisString : string;
   BreakArray : TStringList;
   ThisCentury : System.Integer;
begin
   if AShortDateFormat = EMPTY_STRING then
   try
       Result := StrToDate(AString);
       Exit;
   except
       on EConvertError do
           ;
   end;

   Result := EMPTY_DATE;

   Month := 0;
   Day := 0;
   Year := 0;

   if AShortDateFormat = EMPTY_STRING then
       RawMask := SysUtils.ShortDateFormat                 //  from Windows LOCALE_SSHORTDATE
   else
       RawMask := AShortDateFormat;                        //  e.g. mm/dd/yy

   while Pos(DateSeparator, RawMask) > 0 do
       Delete(RawMask, Pos(SysUtils.DateSeparator, RawMask), 1);

   Pointer := 2;
   Counter := 0;
   DatePartSequence[0] := UpCase(RawMask[1]);
   while Pointer <= Length(RawMask) do
   begin
       if RawMask[Pointer] = RawMask[Pointer - 1] then
           DatePartSequence[Counter] := DatePartSequence[Counter] + UpCase(RawMask[Pointer])
       else
       begin
           Inc(Counter);
           DatePartSequence[Counter] := UpCase(RawMask[Pointer]);
       end;
       Inc(Pointer);
   end;

   SetIndex(DayIndex, 'D');
   SetIndex(MonthIndex, 'M');
   SetIndex(YearIndex, 'Y');

   BreakArray := TStringList.Create;
   try
       BreakApart(AString, SysUtils.DateSeparator + ':/-., ', BreakArray);
       if BreakArray.Count = 3 then
       begin
           for Counter := 0 to 2 do
           begin
               if StrToIntDef(BreakArray[Counter], -1) = -1 then
               begin
                   MonthIndex := Counter;
                   if Counter = 1 then
                   begin
                       if (BreakArray[0][1] = '0') then
                       begin
                           YearIndex := 0;
                           DayIndex := 2;
                       end
                       else
                       begin
                           YearIndex := 2;
                           DayIndex := 0;
                       end
                   end
                   else if Counter = 0 then
                   begin
                       DayIndex := 1;
                       YearIndex := 2;
                   end
                   else
                   begin
                       DayIndex := 1;
                       YearIndex := 0;
                   end;
                   Break;
               end;
           end;

           for Counter := 0 to 2 do
           begin
               if Counter = YearIndex then
               begin
                   Year := StrToIntDef(BreakArray[Counter], 0);
                   if Year < 50 then
                   begin
                       ThisCentury := StrToInt(FormatDateTime('yyyy', Date));
                       Inc(Year, ((ThisCentury div 100) + 1) * 100);
                   end
                   else if Year < 100 then
                   begin
                       ThisCentury := StrToInt(FormatDateTime('yyyy', Date));
                       Inc(Year, (ThisCentury div 100) * 100);
                   end;
               end

               else if Counter = MonthIndex then
               begin
                   Month := StrToIntDef(BreakArray[Counter], 0);
                   if Month = 0 then
                   begin
                       for Pointer := 1 to 12 do
                       begin
                           if SameText(BreakArray[Counter], FormatDateTime('mmm', EncodeDate(1000, Pointer, 1))) then
                           begin
                               Month := Pointer;
                               Break;
                           end;
                           if SameText(BreakArray[Counter], FormatDateTime('mmmm', EncodeDate(1000, Pointer, 1))) then
                           begin
                               Month := Pointer;
                               Break;
                           end;
                       end;
                   end;
               end

               else if Counter = DayIndex then
                   Day := StrToIntDef(BreakArray[Counter], 0);
           end;
       end;
       AString := StickTogether(BreakArray, EMPTY_STRING);
   finally
       BreakArray.Free;
   end;

   if (Year <> 0) and (Month <> 0) and (Day <> 0) then

       //      jump to the bottom

   else if StrToIntDef(AString, 0) = 0 then
       Exit

   else if (Length(AString) = 4) then
   begin
       for Counter := 0 to 2 do
           if Counter = YearIndex then
               LoadAndStrip(Year, 1, 2)
           else if Counter = MonthIndex then
               LoadAndStrip(Month, 1, 1)
           else if Counter = DayIndex then
               LoadAndStrip(Day, 1, 1);
   end
   else if (Length(AString) = 6) then
   begin
       ThisString := AString;
       for Counter := 0 to 2 do
       begin
           if Counter = YearIndex then
               LoadAndStrip(Year, 1, 2)
           else if Counter = MonthIndex then
               LoadAndStrip(Month, 1, 2)
           else if Counter = DayIndex then
               LoadAndStrip(Day, 1, 2);
       end;

       if (not IsLegalMonth(Month, Year)) or
           (not IsLegalDay(Day, Month, Year)) or
           (DatePartSequence[YearIndex] = 'YYYY') then
       begin
           AString := ThisString;
           for Counter := 0 to 2 do
           begin
               if Counter = YearIndex then
                   LoadAndStrip(Year, 1, 4)
               else if Counter = MonthIndex then
                   LoadAndStrip(Month, 1, 1)
               else if Counter = DayIndex then
                   LoadAndStrip(Day, 1, 1);
           end
       end;
   end
   else if (Length(AString) = 8) then
   begin
       for Counter := 0 to 2 do
       begin
           if Counter = YearIndex then
               LoadAndStrip(Year, 1, 4)
           else if Counter = MonthIndex then
               LoadAndStrip(Month, 1, 2)
           else if Counter = DayIndex then
               LoadAndStrip(Day, 1, 2);
       end;
   end
   else if (Length(AString) = 5) then
       Parse5Digits;

   if (Year > 0) and (Month > 0) and (Day > 0) then
       Result := EncodeDate(Year, Month, Day)
   else
       raise EConvertError.Create(AString + ' is not a valid date');
end;

function DaysInMonth(AMonth, AYear : Integer) : System.Integer;
var
   Year, Month, Day : Word;
begin
   DecodeDate(EncodeDateExtended(AYear, AMonth + 1, 1) - 1, Year, Month, Day);
   Result := Day;                                          //  automatically casts
end;

function DateTimeToStrDef(ADate : TDateTime; ADef : string = EMPTY_STRING) : string;
begin
   if ADate >= 1 then
       Result := DateTimeToStr(ADate)
   else
       Result := ADef;
end;

function DateToStrDef(ADate : TDateTime; ADef : string) : string;
begin
   Result := ADef;
   if ADate >= 1 then
   begin
       try
           Result := DateToStr(ADate);
       except
       end;
   end;
end;

function IncDate(ADate : TDateTime; YearCount, MonthCount, DayCount : Integer) : TDateTime;
var
   ThisYear, ThisMonth, ThisDay : Word;
begin
   DecodeDate(ADate, ThisYear, ThisMonth, ThisDay);
   Result := EncodeDateExtended(ThisYear + YearCount, ThisMonth + MonthCount, ThisDay + DayCount);
end;

function AddWorkingDays(ADateTime : TDateTime; DayCount : Integer) : TDateTime;
begin
   Result := ADateTime + DayCount;
   case DayOfWeek(ADateTime) of
       1 : Result := Result + 1;                           //  Sunday
       7 : Result := Result + 2;                           //  Saturday
   end;
end;

procedure WriteFile(const AFileName : string; AText : string);
var
   TempFileName : string;
begin
   TempFileName := uWindowsInfo.GetUnusedFileName;
   try
       with TCraftingFileStream.CreateNew(TempFileName) do
       try
           Write(AText);
       finally
           Free;
       end;
       try
           SysUtils.DeleteFile(AFileName);
           if not FileExists(AFileName) then
               SysUtils.RenameFile(TempFileName, AFileName)
           else
               Abort;
       except
           on E : Exception do
               raise Exception.Create('Cannot overwrite file "' + AFileName + '": ' + E.Message);
       end;
   finally
       SysUtils.DeleteFile(TempFileName);
   end;
end;

procedure AppendToFile(const AFileName : string; AText : string);
begin
   with TCraftingFileStream.Append(AFileName) do
   try
       AText := Trim(AText) + #13#10;
       Write(AText);
   finally
       Free;
   end;
end;

{ TStringLists }

procedure TStringLists.Clear(AnIndex : Integer);
var
   Counter : System.Integer;
begin
   for Counter := AnIndex to Self.Count - 1 do
       Objects[Counter].Free;
   if AnIndex = 0 then
       inherited Clear
   else
       Capacity := AnIndex;
end;

function TStringLists.GetStringLists(Index : Integer) : TStringList;
begin
   Result := TStringList(Objects[Index]);
end;

function TStringLists.GetValues(const AListName, AKeyName : string) : string;
var
   Index : System.Integer;
begin
   Index := IndexOf(AListName);
   if Index <> NOT_FOUND_INDEX then
       Result := Lists[Index].Values[AKeyName]
   else
       Result := EMPTY_STRING;
end;

procedure TStringLists.SetValues(const AListName, AKeyName, Value : string);
var
   Index : System.Integer;
begin
   Index := IndexOf(AListName);
   if Index = NOT_FOUND_INDEX then
       Index := AddObject(AListName, TStringList.Create);
   Lists[Index].Values[AKeyName] := Value;
end;

procedure TStringLists.SetStringLists(Index : System.Integer; const Value : TStringList);
var
   Counter : System.Integer;
begin
   for Counter := Self.Count to Index do
       AddObject(EMPTY_STRING, TStringList.Create);
   Lists[Index].Assign(Value);
end;

function TStringLists.ListByName(const AListName : string) : TStringList;
var
   Index : System.Integer;
begin
   Index := IndexOf(AListName);
   if Index <> NOT_FOUND_INDEX then
       Result := TStringList(Objects[Index])
   else
       Result := nil;
end;

function TStringLists.Find(const AListName : string; var AStrings : TStringList) : Boolean;
begin
   AStrings := ListByName(AListName);
   Result := AStrings <> nil;
end;

function TStringLists.StringOf(const AName : string; Index : Integer) : string;
begin
   Result := ListByName(AName).Strings[Index]
end;

function TStringLists.OpenList(const AListName : string) : TStringList;
begin
   if not Find(AListName, Result) then
   begin
       Result := TStringList.Create;
       AddObject(AListName, Result);
   end;
end;

function Compare(Integer1, Integer2 : Integer) : System.Integer;
begin
   if Integer1 < Integer2 then
       Result := -1
   else if Integer1 = Integer2 then
       Result := 0
   else
       Result := 1;
end;

function Compare(Date1, Date2 : TDateTime) : System.Integer;
begin
   if Date1 < Date2 then
       Result := -1
   else if Date1 = Date2 then
       Result := 0
   else
       Result := 1;
end;

function Compare(Float1, Float2 : Extended) : System.Integer;
begin
   if Float1 < Float2 then
       Result := -1
   else if Float1 = Float2 then
       Result := 0
   else
       Result := 1;
end;

{  TNoReferenceCounting    }

function TNoReferenceComponent._AddRef : Integer;
begin
   Result := -1;
end;

function TNoReferenceComponent._Release : Integer;
begin
   Result := -1;
end;

{ TNoReferenceCollection }

function TNoReferenceCollection.QueryInterface(const IID : TGUID; out Obj) : HResult;
begin
   if GetInterface(IID, Obj) then
       Result := 0
   else
       Result := E_NOINTERFACE;
end;

function TNoReferenceCollection._AddRef : Integer;
begin
   Result := -1;
end;

function TNoReferenceCollection._Release : Integer;
begin
   Result := -1;
end;

{ TNoReferenceCollectionItem }

function TNoReferenceCollectionItem._AddRef : Integer;
begin
   Result := -1;
end;

function TNoReferenceCollectionItem._Release : Integer;
begin
   Result := -1;
end;

function TNoReferenceCollectionItem.QueryInterface(const IID : TGUID; out Obj) : HResult;
begin
   if GetInterface(IID, Obj) then
       Result := 0
   else
       Result := E_NOINTERFACE;
end;

{ TNoReferenceList }

function TNoReferenceList._AddRef : Integer;
begin
   Result := -1;
end;

function TNoReferenceList._Release : Integer;
begin
   Result := -1;
end;

function TNoReferenceList.QueryInterface(const IID : TGUID; out Obj) : HResult;
begin
   if GetInterface(IID, Obj) then
       Result := 0
   else
       Result := E_NOINTERFACE;
end;

{ TNoReferenceObject }

function TNoReferenceObject._AddRef : Integer;
begin
   Result := -1;
end;

function TNoReferenceObject._Release : Integer;
begin
   Result := -1;
end;

function TNoReferenceObject.QueryInterface(const IID : TGUID; out Obj) : HResult;
begin
   if GetInterface(IID, Obj) then
       Result := 0
   else
       Result := E_NOINTERFACE;
end;

{  TCraftingCollectionItem }

procedure TCraftingCollectionItem.Changed(AllItems : Boolean); //  copied from Classes.pas because IT WAS NOT VIRTUAL
var
   Item : TCollectionItem;
begin
   if (Collection <> nil) and (not Collection.IsUpdating) then
   begin
       if AllItems then
           Item := nil
       else
           Item := Self;

       Collection.Update(Item);
   end;
end;

procedure TCraftingCollectionItem.Clear;
begin
   // stub
end;

function TCraftingCollectionItem.Collection: TCraftingCollection;
begin
   Result := inherited Collection as TCraftingCollection;
end;

function TCraftingCollectionItem.GetIndexName : string;
begin
   Result := Self.ClassName + Format('%5.5d', [Index + 1]); //  default value
end;

function TCraftingCollectionItem.GetInternalChange: Boolean;
begin
   Result := FInternalChange > 0;
end;

procedure TCraftingCollectionItem.SetInternalChange(Value: Boolean);
begin
   if Value then
       Inc(FInternalChange)
   else if FInternalChange > 0 then
       Dec(FInternalChange);
end;

function TCraftingCollectionItem.IsEqual(AnOther : TObject) : Boolean;
begin
   Result := False;
end;

{   TCollectionEnumerator	}

constructor TCollectionEnumerator.Create(ACollection : IEnumerableCollection);
begin
   FCollection := ACollection;
   Self.Reset;
end;

function TCollectionEnumerator.First(var AnItem : TCollectionItem) : Boolean;
begin
   Self.Reset;
   Result := Self.Next(AnItem);
end;

function TCollectionEnumerator.Next(var AnItem : TCollectionItem) : Boolean;
begin
   Result := FCollection.Next(AnItem, FCurrentIndex);
end;

procedure TCollectionEnumerator.Reset;
begin
   FCurrentIndex := -1;
end;

{ TCraftingCollection }

constructor TCraftingCollection.Create(ACollectionItemClass : TCollectionItemClass);
begin
   {
   if not Supports(ACollectionItemClass, ICraftingCollectionItem) then
   raise Exception.Create('The items for this class must implement ICraftingCollectionItemClass');
   }
   inherited;

   FIndexMode := DEFAULT_INDEX_MODE;
end;

destructor TCraftingCollection.Destroy;
begin
   FIndexStrings.Free;
   FIndexStrings := nil;                                   //  inherited Destroy calls Notify, which will reference FIndexStrings
   FEnumerator := nil;
   inherited;
end;

procedure TCraftingCollection.Clear;
begin
   BeginUpdate;
   ClearIndex;
   inherited;
   EndUpdate;
end;

procedure TCraftingCollection.ClearIndex;
begin
   BeginUpdate;
   FIndexStrings.Free;
   FIndexStrings := nil;
   EndUpdate;
end;

procedure TCraftingCollection.Notify(Item : TCollectionItem; Action : TCollectionNotification);
var
   ThisIndexItem : ICraftingCollectionItem;
begin
   inherited;

   case Action of
       cnAdded :
           begin
               if (IndexMode = imAlways) or ((IndexMode = imAutomatic) and (FIndexStrings <> nil)) then
               begin
                   if Item is TCraftingCollectionItem then
                       IndexStrings.AddObject(TCraftingCollectionItem(Item).GetIndexName, Item)

                   else if Item.GetInterface(ICraftingCollectionItem, ThisIndexItem) then
                       IndexStrings.AddObject(ThisIndexItem.GetIndexName, Item);
               end;
               DoAdd(Item);
           end;

       cnExtracting, cnDeleting :
           begin
               if FIndexStrings <> nil then
                   FIndexStrings.Remove(Item);             //    no harm if it does not find the item

               if FEnumerator <> nil then
               begin
                   if FEnumerator.FCurrentIndex > Item.Index then //       removing the Item will shift all Index back by one
                       Dec(FEnumerator.FCurrentIndex);
               end;

               DoRemove(Item);
           end;
   end;
end;

function TCraftingCollection.Find(const AName : string) : TCollectionItem;
begin
   BeginRead;
   if not Find(AName, Result) then
       Result := nil;
   EndRead;
end;

function TCraftingCollection.Find(const AName : string; var AnItem : TCollectionItem) : Boolean;
var
   ThisIndex : Integer;
begin
   BeginRead;
   Result := Find(AName, ThisIndex);
   if Result then
       AnItem := Items[ThisIndex];
   EndRead;
end;

function TCraftingCollection.Find(const AName : string; var AnIndex : Integer) : Boolean;
var
   Counter : Integer;
{$IFOPT C+}
   ThisName : string;
{$ENDIF}
begin
   if IndexMode = imNever then
   begin
       Result := False;
       BeginRead;
       for Counter := 0 to Self.Count - 1 do
       begin
           if GetIndexName(Counter) = AName then
           begin
               Result := True;
               AnIndex := Counter;
               Break;
           end;
       end;
       EndRead;
   end
   else
   begin
       { TODO : Creating or re-filling the IndexStrings would require BeginUpdate. How can we ask for a BeginRead ? }
       Result := IndexStrings.Find(AName, AnIndex);        //  creates and fills IndexStrings if necessary
       if Result then
       begin
           AnIndex := TCollectionItem(IndexStrings.Objects[AnIndex]).Index;
{$IFOPT C+}
           ThisName := GetIndexName(AnIndex);
           if not SameText(ThisName, AName) then
           begin
               raise Exception.Create(Format('Index item %d name is "%s", but we were looking for "%s".',
                   [AnIndex, ThisName, AName]));
           end;
{$ENDIF}
       end;
   end;
end;

function TCraftingCollection.GetIndexItem(Index : Integer) : ICraftingCollectionItem;
begin
   if not Items[Index].GetInterface(ICraftingCollectionItem, Result) then
       raise Exception.Create(Self.ItemClass.ClassName + ' does not support ICraftingCollectionItem');
end;

function TCraftingCollection.GetIndexName(Index : Integer) : string;
begin
   if ItemClass.InheritsFrom(TCraftingCollectionItem) then
       Result := TCraftingCollectionItem(Items[Index]).GetIndexName
   else
       Result := IndexItems[Index].GetIndexName;
end;

procedure TCraftingCollection.SaveToFile(const AFileName : string);
begin
   BeginRead;
   IndexStrings.SaveToFile(AFileName);
   EndRead;
end;

procedure TCraftingCollection.ResetIterator;
begin
   if FEnumerator <> nil then
       FEnumerator.Reset;
end;

function TCraftingCollection.First(var AnItem : TCollectionItem) : Boolean;
begin
   if IndexMode = imNever then
       raise Exception.Create('IndexMode is imNever: no ordered traversing');

   if FEnumerator = nil then
       FEnumerator := TCollectionEnumerator.Create(Self);

   Result := FEnumerator.First(AnItem);
end;

function TCraftingCollection.Next(var AnItem : TCollectionItem) : Boolean;
begin
   if FEnumerator = nil then
       FEnumerator := TCollectionEnumerator.Create(Self);

   Result := FEnumerator.Next(AnItem);
end;

function TCraftingCollection.Next(var AnItem : TCollectionItem; var AnIndex : Integer) : Boolean;
begin
   if IndexMode = imNever then
       raise Exception.Create('IndexMode is imNever: no ordered traversing');

   BeginRead;
   Result := (AnIndex < (Self.Count - 1));
   if Result then
   begin
       Inc(AnIndex);
       Assert(IndexStrings.Objects[AnIndex] <> nil);       //  accessor will create and load if necessary
       AnItem := IndexStrings.Objects[AnIndex] as TCollectionItem;
   end;
   EndRead;
end;

function TCraftingCollection.GetIndexStrings : TCraftingStringList;
begin
   if IndexMode = imNever then
       raise Exception.Create('IndexMode is imNever: no ordered traversing');

   if (FIndexStrings = nil) or (FIndexStrings.Count <> Self.Count) then
   begin
       BeginRead;
       try
           LoadAllIndex;                                   //  this will create the strings if needed
       finally
           EndRead;
       end;
   end;

   Result := FIndexStrings;
end;

{      TCraftingCollection descendants would implement something like this:

...
function First(var AnOrder : TAppraisalOrder; AnOrderStatuses : TeTracStatuses = []) : Boolean; reintroduce; overload;
function Next(var AnOrder : TAppraisalOrder; AnOrderStatuses : TeTracStatuses = []) : Boolean; reintroduce; overload;
...
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

}

procedure TCraftingCollection.SetIndexMode(Value : TIndexMode);
begin
   if IndexMode <> Value then
   begin
       FIndexMode := Value;
       case Value of
           imNever : ClearIndex;

           imAlways :
               begin                                       //     changing from imAutomatic (where the index is clean) and imAlways will unnecessarily rebuild. Ah well.
                   BeginUpdate;
                   try
                       LoadAllIndex;                       //  this will create the strings if needed
                   finally
                       EndUpdate;
                   end;
               end;

           //             imAutomatic will load on first use
       end;
   end;
end;

procedure TCraftingCollection.DoAdd(AnItem : TCollectionItem);
begin
   if Assigned(FOnAdd) then
       FOnAdd(Self, AnItem);
end;

procedure TCraftingCollection.DoRemove(AnItem : TCollectionItem);
begin
   //         stub
end;

procedure TCraftingCollection.Update(AnItem : TCollectionItem);
var
   ThisIndex : Integer;
   ThisIndexName : string;
   ThisIndexItem : ICraftingCollectionItem;
begin
   inherited;

   Assert(not IsUpdating);                                 //      BeginRead will fail if IsUpdating

   if (IndexMode = imAlways) or ((IndexMode = imAutomatic) and (FIndexStrings <> nil)) then
   begin
       if (AnItem = nil) or (FIndexStrings = nil) then
       begin
           BeginRead;
           try
               LoadAllIndex;                               //  this will create the strings if needed
           finally
               EndRead;
           end;
       end
       else
       begin
           if AnItem is TCraftingCollectionItem then
               ThisIndexName := TCraftingCollectionItem(AnItem).GetIndexName

           else if AnItem.GetInterface(ICraftingCollectionItem, ThisIndexItem) then
               ThisIndexName := ThisIndexItem.GetIndexName

           else
               Exit;

           BeginRead;

           if FIndexStrings.Find(AnItem, ThisIndex) then
           begin
               if FIndexStrings.Strings[ThisIndex] <> ThisIndexName then //  prevent EndUpdate recursion
                   FIndexStrings.Strings[ThisIndex] := ThisIndexName;
           end
           else
               FIndexStrings.AddObject(ThisIndexName, AnItem);

           EndRead;
       end;
   end;

   //      TCollectionItem.Changed won't call Update unless UpdateCount = 0
   if Assigned(OnItemChange) then
       OnItemChange(Self, AnItem);
end;

procedure TCraftingCollection.LoadAllIndex;
var
   Counter : Integer;
begin
   if FIndexStrings = nil then
   begin
       FIndexStrings := TCraftingStringList.Create;
       FIndexStrings.Duplicates := dupAccept;
   end
   else
       FIndexStrings.Clear;

   FIndexStrings.Sorted := False;
   try
       for Counter := 0 to Self.Count - 1 do
       begin
           FIndexStrings.AddObject(IndexNames[Counter], Items[Counter]);

           Assert(FIndexStrings.Strings[FIndexStrings.Count - 1] = IndexNames[Counter]);
           Assert(Copy(FIndexStrings.Text, Length(FIndexStrings.Text) - (Length(IndexNames[Counter]) + 1), MaxInt) = IndexNames[Counter] + #13#10);
       end;
   finally
       FIndexStrings.Sorted := True;
   end;
end;

function TCraftingCollection.IsUpdating : Boolean;
begin
   Result := UpdateCount > 0;
end;

procedure TCraftingCollection.SetIsLockedOnUpdate(Value : Boolean);
begin
   if FIsLockedOnUpdate <> Value then
   begin
       FIsLockedOnUpdate := Value;
       if Value then
       begin
           FReadWriteLock := TMultiReadExclusiveWriteSynchronizer.Create;

           if UpdateCount > 0 then
               FReadWriteLock.BeginWrite

           else if FReadCounter > 0 then
               FReadWriteLock.BeginRead;
       end
       else
       begin
           FReadWriteLock.Free;
           FReadWriteLock := nil;
       end;
   end;
end;

procedure TCraftingCollection.BeginUpdate;
begin
   if LockOnUpdate then
       FReadWriteLock.BeginWrite;
   inherited;
end;

procedure TCraftingCollection.EndUpdate;
begin
   if LockOnUpdate then
       FReadWriteLock.EndWrite;
   inherited;
end;

procedure TCraftingCollection.BeginRead;
begin
   {TODO: need a lock on FReadCounter here    }
   Inc(FReadCounter);
   if (FReadCounter = 1) and LockOnUpdate then
       FReadWriteLock.BeginRead;
end;

procedure TCraftingCollection.EndRead;
begin
   {TODO: need a lock on FReadCounter here    }
   if (FReadCounter = 1) and LockOnUpdate then
       FReadWriteLock.EndRead;

   if FReadCounter > 0 then
       Dec(FReadCounter);
end;

function TCraftingCollection.GetItem(AnIndex : Integer) : TCollectionItem;
begin
   BeginRead;
   Result := inherited Items[AnIndex];
   EndRead;
end;

end.

