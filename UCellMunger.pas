unit UCellMunger;
                                                                                          
{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted 1998 - 2011 by Bradford Technologies, Inc. }

{ This is a special text list that holds munged text strings }
{ These strings include things like City, St Zip, Mr.Jones,  }
{ and other concatentations of the cells in a report. The    }
{ items in the list are based on Global Context IDs.         }
{ Eventually, these should change to cell IDs.               }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Classes,
  UGlobals, UCell;

type
  { Whenever munged text has changed, this will fire off, so someone can do something}
	TTextChangeEvent = procedure(Sender: TObject; ContextID: Integer; NewText: String) of Object;

  { Holds a special list of text that has been munged from multiple cells }
  { They are indexed by the global context ID value.                      }

  { When a cell has changed, it gets post processed (transfers, math, etc), one of the }
  { processes is to pass thru MungeCell. If it has a Context ID it is passed to MungedText}
  { where its text is munged with text from other cells. Then OnChange is called and the}
  { new munged text is broadcast to the report.}

  TCellMunger = class(TObject)
  private
    FOwner: TComponent;
    FOnChange: TTextChangeEvent;
    FMungedText: TStringList;       //list of munged cell text
  protected
    procedure SetMungedValue(Index: Integer; Value: String);
    function GetMungedValue(Index: Integer): String;
    function GetMungedText(Index: Integer): String;
    procedure SetMungedText(Index: Integer; Value: String);
    function ChangeNotify(Index: Integer): Integer;
    function ValidMungeID(mungeID: Integer): Boolean;
    procedure BuildMungeText(Index: Integer);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure SetupMungedValues;
    procedure MungeCell(Cell: TBaseCell);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    property OnChange: TTextChangeEvent read FOnChange write FOnChange;
    //MungedValue is straight set/get of the values into list
    property MungedValue[Index: Integer]:String read GetMungedValue write SetMungedValue;
    //MungedText Setter is the one that munges the values; Get is simple get 
    property MungedText[Index: Integer]:String read GetMungedText write SetMungedText; default;
  end;

implementation

uses
  sysUtils, dxExEdtr,
  UContainer, UFileUtils, UUTil2, UUtil3, UAppraisalIDs, UMessages, UUtil1, UUADUtils;
(*
const
  kAddress = 6;
  kUnitNo = 270;
  kAddressUnit = 103
  kCity = 7;
  kState = 9;
  kZip = 10;
  kCityStZip = 24;
  kFullAddress = 25;

  kAppraisalValue = 22;
  kAppraisalAmtWords = 60;        //new

  kLenderFullAddress = 12;
  kLenderAddress  = 13;
  kLenderCity = 14;
  kLenderState = 15;
  kLenderZip = 16;
  kLenderCityStZip = 17;

  kLenderMr  = 61;               //new
  kLenderFirst = 62;             //new
  kLenderLast = 63;              //new
  kLenderContact = 18;
  kLenderMrLast = 64;            //new

  kAppraiserCoName = 26;
  kAppraiserAddress = 28;
  kAppraiserCity = 29;
  kAppraiserState = 30;
  kAppraiserZip =31;
  kAppraiserCityStZip = 32;
  kAppraiserFullAddress = 27;

  kAppraiserCertNo = 38;
  kAppraiserCertSt = 39;
  kAppraiserCertPlusState = 55;     //new

  kAppraiserLicNo = 40;
  kAppraiserLicSt = 41;
  kAppraiserLicPlusSt = 56;        //new

  kSupervisorCertNo = 45;
  kSupervisorCertSt = 46;
  kSupervisorCertPlusState = 57;   //new

  kSupervisorLicNo = 47;
  kSupervisorLicSt = 48;
  kSupervisorLicNoPlusState = 58;   //new

  kActualAge = 197;
  kYearBuilt =  360;
  kAgeOnGrid = 140;

  kApprCertState = 39;    //the state the appraiser certification is in
  kApprLicState = 41;     //the state the appraiser is licensed is in
  kApprGenState = 314;    //the state where the lic or cert is in (holds either)

  kSuprCertState = 45;    //the state the suprvisor certification is in
  kSuprLicState = 47;     //the state the supervisor license is in
  KSuprGenState = 315;    //the state where supervisor lic or cert is in
*)

{ TCellMunger }

constructor TCellMunger.Create(AOwner: TComponent);
begin
  inherited Create;
  FOwner := AOwner;     //this is doc

  FMungedText := TStringList.Create;

//  FMungedText.BeginUpdate;
//  FMungecells.SetText();
//  FMungedText.EndUpdate;
end;

destructor TCellMunger.Destroy;
begin
  FMungedText.Free;

  inherited;
end;


{ These are the only values that are allowed in to be munged with others}
{ The Lenders full address is the weird one. we have to let it in and parse}
{ it and also distribute it out.  }
function TCellMunger.ValidMungeID(mungeID: Integer): Boolean;
begin
  case mungeID of
  {cell types that need munging}
    kAddress,
    kUnitNo,
    kCity,
    kState,
    kZip,
    kAddressUnit,     //"address, #unit"
    kCityStZip,
    kFullAddress,

    kLenderCompany,
    kLenderFullAddress,
    kLenderAddress,
    kLenderCityStZip,
    kLenderCity,
    kLenderState,
    kLenderZip,
    kLenderMr,
    kLenderFirst,
    kLenderLast,
    kLenderID,
    kLenderEMail,

    kAppraiserName,
    kAppraiserCoName,
    kAppraiserAddress,
    kAppraiserCityStZip,
    kAppraiserCity,
    kAppraiserState,
    kAppraiserZip,
    kAppraiserPhone,
    kAppraiserEMail,

    kApprCertNo,
    kApprLicNo,
    kApprExpDate,
    kApprCertState,
    kApprLicState,

    kSuprCertNo,
    kSuprLicNo,
    kSuprCertState,
    kSuprLicState,
    kSupervisorAddress,
    kSupervisorCity,
    kSupervisorState,
    kSupervisorZip,
    kSupervisorCityStZip,
    kSupervisorFullAddress,

    kAppraiserSignDate,
    kEffectiveDate,
    kInvoiceDate,
    kNameOnCover,
    kReviewEffDate,
    kTransmitalDate,
    kPayableContact,
    kAppraiserContact,
    kContactPhone,

    kPhotoCityStateZip,
    kPhotoAddress,

    kYearBuilt,
    kAppraisalValue:

      result := True;
  else
    result := False;
  end;
end;

procedure TCellMunger.MungeCell(Cell: TBaseCell);
begin
  if Assigned(Cell) and (Cell.FContextID > 0) then
    if ValidMungeID(Cell.FContextID) then        //if this is a cell to munge
      MungedText[Cell.FContextID] := Cell.GetText;
end;

function TCellMunger.ChangeNotify(Index: Integer): Integer;
begin
  //see if it needs to be broadcast
  if (Index > 0) and Assigned(OnChange) then
    OnChange(Self, Index, GetMungedValue(Index));

  result := Index;    //see if new guy needs processing
end;

function TCellMunger.GetMungedValue(Index: Integer): String;
begin
  result := FMungedText.Values[IntToStr(Index)];
end;

procedure TCellMunger.SetMungedValue(Index: Integer; Value: String);
begin
  FMungedText.Values[IntToStr(Index)] := Value;
end;

function TCellMunger.GetMungedText(Index: Integer): String;
var
  indexStr: String;
begin
  result := '';
  indexStr := IntToStr(Index);
  if FMungedText.IndexOfName(indexStr) > -1 then
    result := FMungedText.Values[indexStr]
  else
    TContainer(FOwner).FindContextData(index, result);   //GetCellTextByID when we switch to cell IDs
end;

procedure TCellMunger.BuildMungeText(Index: Integer);
var
  Document: TContainer;
  MungeStr, CityStZip: String;
begin
  Document := FOwner as TContainer;
  case Index of
    kAddressUnit: begin
      MungeStr := MungedText[kAddress];
      if (length(MungedText[kUnitNo]) > 0) and (GetUADUnitCell(Document) <> nil) then  //add unit # if we have one
        MungeStr := MungeStr + ', #' + MungedText[kUnitNo];
      FMungedText.Values[IntToStr(kAddressUnit)] := MungeStr;
    end;
    kPhotoAddress: begin
      MungeStr := MungedText[kAddress];
      FMungedText.Values[IntToStr(kPhotoAddress)] := MungeStr;
    end;
    kCityStZip: begin
      MungeStr := MungedText[kCity] + ', ' + MungedText[kState] + ' ' + MungedText[kZip];
      if Trim(MungeStr) = ',' then MungeStr := '';
      FMungedText.Values[IntToStr(kCityStZip)] := MungeStr;
    end;
    kFullAddress: begin
      MungeStr := MungedText[kAddress] + ', ' + MungedText[kCityStZip];
      if Trim(MungeStr) = ',' then MungeStr := '';
      FMungedText.Values[IntToStr(kFullAddress)] := MungeStr;
    end;
    kLenderContact: begin
      //only combine if we have value in lenderFirst and LenderLast
      MungeStr := MungedText[kLenderFirst] + ' ' + MungedText[kLenderLast];
      FMungedText.Values[IntToStr(kLenderContact)] := MungeStr;
    end;
    kLenderMrLast: begin
      MungeStr := MungedText[kLenderMr] + ' ' + MungedText[kLenderLast];
      FMungedText.Values[IntToStr(kLenderMrLast)] := MungeStr;
    end;
    kLenderCityStZip: begin
      MungeStr := MungedText[kLenderCity] + ', ' + MungedText[kLenderState] + ' ' + MungedText[kLenderZip];
      if Trim(MungeStr) = ',' then MungeStr := '';
      FMungedText.Values[IntToStr(kLenderCityStZip)] := MungeStr;
    end;
    kLenderFullAddress: begin
      MungeStr := MungedText[kLenderAddress] + ', ' + MungedText[kLenderCityStZip];
      if Trim(MungeStr) = ',' then MungeStr := '';
      FMungedText.Values[IntToStr(kLenderFullAddress)] := MungeStr;
    end;
    kLenderComplete: begin
      MungeStr := MungedText[kLenderCompany] + ' ' + MungedText[kLenderFullAddress];
      FMungedText.Values[IntToStr(kLenderComplete)] := MungeStr;
    end;
(*
    kLenderCity: begin
      MungeStr := MungedText[kLenderCityStZip];            //this is wrong -
      MungeStr := ParseCityStateZip3(MungeStr,cmdGetCity);
      FMungedText.Values[IntToStr(kLenderCity)] := MungeStr;
    end;
    kLenderState: begin
      MungeStr := MungedText[kLenderCityStZip];
      MungeStr := ParseCityStateZip3(MungeStr,cmdGetState);
      FMungedText.Values[IntToStr(kLenderState)] := MungeStr;
    end;
    kLenderZip: begin
      MungeStr := MungedText[kLenderCityStZip];
      MungeStr := ParseCityStateZip3(MungeStr,cmdGetZip);
      FMungedText.Values[IntToStr(kLenderZip)] := MungeStr;
    end;
*)
    kAppraiserCityStZip: begin
      MungeStr := MungedText[kAppraiserCity] + ', ' + MungedText[kAppraiserState] + ' ' + MungedText[kAppraiserZip];
      if Trim(MungeStr) = ',' then MungeStr := '';
      FMungedText.Values[IntToStr(kAppraiserCityStZip)] := MungeStr;
    end;
    kAppraiserFullAddress: begin
      MungeStr := MungedText[kAppraiserAddress] + ', ' + MungedText[kAppraiserCityStZip];
      if Trim(MungeStr) = ',' then MungeStr := '';
      FMungedText.Values[IntToStr(kAppraiserFullAddress)] := MungeStr;
    end;
    kAppraisalAmtWords: begin
      MungeStr := NumberToDollarText(MungedText[kAppraisalValue]);
      FMungedText.Values[IntToStr(kAppraisalAmtWords)] := MungeStr;
    end;
    kGridAddress1: begin
      if not Document.UADEnabled and (MungedText[kUnitNo] <> '') then  //add unit # if we have one
        MungeStr := Format('%s, #%s', [MungedText[kAddress], MungedText[kUnitNo]])
      else
        MungeStr := MungedText[kAddress];
      FMungedText.Values[IntToStr(kGridAddress1)] := MungeStr;
    end;
    kGridAddress2: begin
      if Document.UADEnabled and (GetUADUnitCell(Document) <> nil) and (Trim(MungedText[kUnitNo]) <> '') then
        MungeStr := Format('%s, %s', [MungedText[kUnitNo], MungedText[kCityStZip]])
      else
        MungeStr := MungedText[kCityStZip];
      FMungedText.Values[IntToStr(kGridAddress2)] := MungeStr;
    end;
    kPhotoCityStateZip: begin
      MungeStr := MungedText[kCityStZip];
      FMungedText.Values[IntToStr(kPhotoCityStateZip)] := MungeStr;
    end;
    kActualAge: begin
      mungeStr := YearBuiltToAge(MungedText[kYearBuilt], appPref_AppraiserAddYrSuffix and not Document.UADEnabled);
      if SameText(MungedText[kYearBuiltEstimated], 'Y') then
        mungeStr := '~' + mungeStr;
      FMungedText.Values[IntToStr(kActualAge)] := MungeStr;
    end;
   kAgeOnGrid: begin
      mungeStr := YearBuiltToAge(MungedText[kYearBuilt], appPref_AppraiserAddYrSuffix and not Document.UADEnabled);
      if SameText(MungedText[kYearBuiltEstimated], 'Y') then
        mungeStr := '~' + mungeStr;
      FMungedText.Values[IntToStr(kAgeOnGrid)] := MungeStr;
    end;
    kCity: begin
      MungeStr := MungedText[kCityStZip];
      MungeStr := ParseCityStateZip3(MungeStr,cmdGetCity);
      FMungedText.Values[IntToStr(kCity)] := MungeStr;
    end;
    kState: begin
      MungeStr := MungedText[kCityStZip];
      MungeStr := ParseCityStateZip3(MungeStr,cmdGetState);
      FMungedText.Values[IntToStr(kState)] := MungeStr;
    end;
    kZip: begin
      MungeStr := MungedText[kCityStZip];
      MungeStr := ParseCityStateZip3(MungeStr,cmdGetZip);
      FMungedText.Values[IntToStr(kZip)] := MungeStr;
    end;
    kApprGenState: begin
      MungeStr := MungedText[kApprCertState];
      if length(mungeStr) = 0 then
        MungeStr := MungedText[kApprLicState];
      FMungedText.Values[IntToStr(kApprGenState)] := MungeStr;
    end;
    kApprCertLicNo: begin
      MungeStr := MungedText[kApprCertNo];
      if length(mungeStr) = 0 then
        MungeStr := MungedText[kApprLicNo];
      FMungedText.Values[IntToStr(kApprCertLicNo)] := MungeStr;
    end;
    kSuprCertLicNo: begin
      MungeStr := MungedText[kSuprCertNo];
      if length(mungeStr) = 0 then
        MungeStr := MungedText[kSuprLicNo];
      FMungedText.Values[IntToStr(kSuprCertLicNo)] := MungeStr;
    end;
    kSupervisorCityStZip: begin
      MungeStr := MungedText[kSupervisorCity] + ', ' + MungedText[kSupervisorState] + ' ' + MungedText[kSupervisorZip];
      if Trim(MungeStr) = ',' then MungeStr := '';
      FMungedText.Values[IntToStr(kSupervisorCityStZip)] := MungeStr;
    end;
    //Munge Supervisor full address
    kSupervisorFullAddress: begin
      CityStZip := MungedText[kSupervisorCityStZip];
      MungeStr := MungedText[kSupervisorAddress] + ', ' + CityStZip;
      if Trim(MungeStr) = ',' then MungeStr := '';
      FMungedText.Values[IntToStr(kSupervisorFullAddress)] := MungeStr;
    end;
  end;
  ChangeNotify(Index);
end;

procedure TCellMunger.SetMungedText(Index: Integer; Value: String);
var
  Address, CityStZip: String;
  DateValue: TDateTime;
  Document: TContainer;
begin
  Document := FOwner as TContainer;
  case Index of
//Appraiser
    kAppraiserSignDate: begin
      FMungedText.Values[IntToStr(kInvoiceDate)] := Value;
      ChangeNotify(kInvoiceDate);
      FMungedText.Values[IntToStr(kReviewEffDate)] := Value;
      ChangeNotify(kReviewEffDate);
      FMungedText.Values[IntToStr(kTransmitalDate)] := Value;
      ChangeNotify(kTransmitalDate);
    end;
    kEffectiveDate: begin
      FMungedText.Values[IntToStr(kOrigEffDate)] := Value;
      ChangeNotify(kOrigEffDate);
    end;
    kAppraiserName: begin
      FMungedText.Values[IntToStr(kNameOnCover)] := Value;
      ChangeNotify(kNameOnCover);
      FMungedText.Values[IntToStr(kAppraiserContact)] := Value;
      ChangeNotify(kAppraiserContact);
      FMungedText.Values[IntToStr(kPayableContact)] := Value;
      ChangeNotify(kPayableContact);
    end;
    kAppraiserCoName: begin
      FMungedText.Values[IntToStr(kPayableCoName)] := Value;
      ChangeNotify(kPayableCoName);
    end;
    kAppraiserAddress: begin
      FMungedText.Values[IntToStr(kAppraiserAddress)] := value;
      BuildMungeText(kAppraiserFullAddress);
    end;
    kAppraiserCity: begin
      FMungedText.Values[IntToStr(kAppraiserCity)] := Value;
      BuildMungeText(kAppraiserCityStZip);
      BuildMungeText(kAppraiserFullAddress);
    end;
    kAppraiserState: begin
      FMungedText.Values[IntToStr(kAppraiserState)] := Value;
      BuildMungeText(kAppraiserCityStZip);
      BuildMungeText(kAppraiserFullAddress);
    end;
    kAppraiserZip: begin
      FMungedText.Values[IntToStr(kAppraiserZip)] := Value;
      BuildMungeText(kAppraiserCityStZip);
      BuildMungeText(kAppraiserFullAddress);
    end;
    kAppraiserCityStZip: begin
      FMungedText.Values[IntToStr(kAppraiserCityStZip)] := Value;
      BuildMungeText(kAppraiserFullAddress);
    end;
    kAppraiserPhone: begin
      FMungedText.values[IntToStr(kAppraiserPhone)] := Value;
      FMungedText.Values[IntToStr(kContactPhone)] := Value;
      ChangeNotify(kContactPhone);
    end;
    kAppraiserEmail: begin
      FMungedText.Values[IntToStr(kAppraiserEmail)] := value;
    end;
    kApprCertNo: begin
      FMungedText.Values[IntToStr(kApprCertNo)] := value;
      BuildMungeText(kApprCertLicNo);
    end;
    kApprLicNo: begin
      FMungedText.Values[IntToStr(kApprLicNo)] := value;
      BuildMungeText(kApprCertLicNo);
    end;
    kApprExpDate: begin
      // Was: if TextToDateEx(Value, DateValue) then
      if IsValidDate(Value, DateValue, True) then
        FMungedText.Values[IntToStr(kApprExpDate)] := FormatDateTime(CUADDateFormat, DateValue)
      else
        FMungedText.Values[IntToStr(kApprExpDate)] := Value;
    end;
    kApprCertState: begin
      FMungedText.Values[IntToStr(kApprCertState)] := value;
      BuildMungeText(kApprGenState);
    end;
    kApprLicState: begin
      FMungedText.Values[IntToStr(kApprLicState)] := value;
      BuildMungeText(kApprGenState);
    end;
(*
    kApprCertState, kApprLicState: begin   //put cert or lic state into ApprGenState
      FMungedText.Values[IntToStr(kApprGenState)] := value;
      ChangeNotify(kApprGenState);
    end;
*)
    kSuprCertNo: begin
      FMungedText.Values[IntToStr(kSuprCertNo)] := value;
      BuildMungeText(kSuprCertLicNo);
    end;
    kSuprLicNo: begin
      FMungedText.Values[IntToStr(kSuprLicNo)] := value;
      BuildMungeText(kSuprCertLicNo);
    end;
    kSuprCertState,kSuprLicState: begin   //put cert or lic state into SuprGenState
      FMungedText.Values[IntToStr(KSuprGenState)] := value;
      ChangeNotify(KSuprGenState);
    end;
    kSupervisorAddress: begin
      FMungedText.Values[IntToStr(kSupervisorAddress)] := value;
      BuildMungeText(kSupervisorFullAddress);
    end;

    kSupervisorCity: begin
      FMungedText.Values[IntToStr(kSupervisorCity)] := Value;
      BuildMungeText(kSupervisorCityStZip);
      BuildMungeText(kSupervisorFullAddress);
    end;
    kSupervisorState: begin
      FMungedText.Values[IntToStr(kSupervisorState)] := Value;
      BuildMungeText(kSupervisorCityStZip);
      BuildMungeText(kSupervisorFullAddress);
    end;
    kSupervisorZip: begin
      FMungedText.Values[IntToStr(kSupervisorZip)] := Value;
      BuildMungeText(kSupervisorCityStZip);
      BuildMungeText(kSupervisorFullAddress);
    end;
    //Add Supervisor City/State/Zip munge text to build Supervisor Full Address
    kSupervisorCityStZip: begin
      FMungedText.Values[IntToStr(kSupervisorCityStZip)] := Value;
      BuildMungeText(kSupervisorFullAddress);
    end;
 //Property Address  - relies on new way of building munged text
    kAddress: begin
      FMungedText.Values[IntToStr(kAddress)] := Value;       //update stored value
      BuildMungetext(kAddressUnit);
      BuildMungetext(kGridAddress1);
      BuildMungeText(kFullAddress);
      BuildMungeText(kPhotoAddress);
    end;
    kUnitNo: begin
      if GetUADUnitCell(Document) <> nil then
        FMungedText.Values[IntToStr(kUnitNo)] := Value       //update stored value
      else
        FMungedText.Values[IntToStr(kUnitNo)] := '';         //clear value - no unit cell in report
      BuildMungetext(kAddressUnit);
      BuildMungetext(kGridAddress1);
      BuildMungetext(kGridAddress2);
      BuildMungeText(kFullAddress);
    end;
    kCity: begin
      FMungedText.Values[IntToStr(kCity)] := Value;         //update stored value
      BuildMungeText(kCityStZip);
      BuildMungeText(kGridAddress2);
      BuildMungeText(kPhotoCityStateZip);
      BuildMungeText(kFullAddress);
    end;
    kState: begin
      FMungedText.Values[IntToStr(kState)] := Value;         //update stored value
      BuildMungeText(kCityStZip);
      BuildMungeText(kGridAddress2);
      BuildMungeText(kPhotoCityStateZip);
      BuildMungeText(kFullAddress);
    end;
    kZip: begin
      FMungedText.Values[IntToStr(kZip)] := Value;          //update stored value
      BuildMungeText(kCityStZip);
      BuildMungeText(kGridAddress2);
      BuildMungeText(kPhotoCityStateZip);
      BuildMungeText(kFullAddress);
    end;
    kCityStZip: begin
      FMungedText.Values[IntToStr(kCityStZip)] := value;
      BuildMungeText(kFullAddress);
      BuildMungeText(kGridAddress2);
      BuildMungeText(kPhotoCityStateZip);
      BuildMungeText(kCity);
      BuildMungeText(kState);
      BuildMungeText(kZip);
    end;
    kFullAddress: begin
      FMungedText.Values[IntToStr(kFullAddress)] := value;
    end;


//Lender - relies on new way of building munged text
    kLenderCompany: begin
      FMungedText.Values[IntToStr(kLenderCompany)] := Value;
      BuildMungeText(kLenderComplete);
    end;
    kLenderAddress: begin
      FMungedText.Values[IntToStr(kLenderAddress)] := Value;
      BuildMungeText(kLenderFullAddress);
    end;
    kLenderCity: begin
      FMungedText.Values[IntToStr(kLenderCity)] := Value;
      BuildMungeText(kLenderCityStZip);
      BuildMungeText(kLenderFullAddress);
    end;
    kLenderState: begin
      FMungedText.Values[IntToStr(kLenderState)] := Value;
      BuildMungeText(kLenderCityStZip);
      BuildMungeText(kLenderFullAddress);
    end;
    kLenderZip: begin
      FMungedText.Values[IntToStr(kLenderZip)] := Value;
      BuildMungeText(kLenderCityStZip);
      BuildMungeText(kLenderFullAddress);
    end;
    kLenderCityStZip: begin
      FMungedText.Values[IntToStr(kLenderCityStZip)] := Value;
      BuildMungeText(kLenderFullAddress);
      FMungedText.Values[IntToStr(kLenderCity)] := ParseCityStateZip3(Value,cmdGetCity);
      ChangeNotify(kLenderCity);
      FMungedText.Values[IntToStr(kLenderState)] := ParseCityStateZip3(Value,cmdGetState);
      ChangeNotify(kLenderState);
      FMungedText.Values[IntToStr(kLenderZip)] := ParseCityStateZip3(Value,cmdGetZip);
      ChangeNotify(kLenderZip);

//      BuildMungeText(kLenderCity);
//      BuildMungeText(kLenderState);
//      BuildMungeText(kLenderZip);
    end;
    kLenderFullAddress: begin
      FMungedText.Values[IntToStr(kLenderFullAddress)] := Value;        //was kLenderCityStZip
      BuildMungeText(kLenderComplete);
      ParseFullAddress(value, Address, CityStZip);                      //see what we have
      if (CompareText(Address, MungedValue[kLenderAddress])<>0) then     //if different re-notify
        begin
          FMungedText.Values[IntToStr(kLenderAddress)] := Address;
          ChangeNotify(kLenderAddress);
        end;
      if (CompareText(CityStZip, MungedValue[kLenderCityStZip])<>0) then
        begin
          FMungedText.Values[IntToStr(kLenderCityStZip)] := CityStZip;
          ChangeNotify(kLenderCityStZip);
          FMungedText.Values[IntToStr(kLenderCity)] := ParseCityStateZip3(Value,cmdGetCity);
          ChangeNotify(kLenderCity);
          FMungedText.Values[IntToStr(kLenderState)] := ParseCityStateZip3(Value,cmdGetState);
          ChangeNotify(kLenderState);
          FMungedText.Values[IntToStr(kLenderZip)] := ParseCityStateZip3(Value,cmdGetZip);
          ChangeNotify(kLenderZip);
//          BuildMungeText(kLenderCity);
//          BuildMungeText(kLenderState);
//          BuildMungeText(kLenderZip);
        end;
    end;
    kLenderMr: begin
      FMungedText.Values[IntToStr(kLenderMr)] := Value;
      BuildMungeText(kLenderMrLast);
    end;
    kLenderFirst: begin
      FMungedText.Values[IntToStr(kLenderFirst)] := Value;
      BuildMungeText(kLenderContact);
    end;
    kLenderLast: begin
      FMungedText.Values[IntToStr(kLenderLast)] := Value;
      BuildMungeText(kLenderContact);
      BuildMungeText(kLenderMrLast);
    end;
    kLenderContact: begin
      FMungedText.Values[IntToStr(kLenderContact)] := Value;
    end;
    kLenderMrLast: begin
      FMungedText.Values[IntToStr(kLenderMrLast)] := Value;
    end;
    kLenderEmail: begin
      FMungedText.Values[IntToStr(kLenderEmail)] := value;
    end;
    kAppraisalValue: begin
      FMungedText.Values[IntToStr(kAppraisalValue)] := value;
      BuildMungeText(kAppraisalAmtWords);
    end;

    kYearBuiltEstimated: begin
      FMungedText.Values[IntToStr(kYearBuiltEstimated)] := value;
    end;

    kYearBuilt: begin
      FMungedText.Values[IntToStr(kYearBuilt)] := value;
      BuildMungeText(kActualAge);
      BuildMungeText(kAgeOnGrid);
    end;
    kActualAge: begin
      FMungedText.Values[IntToStr(kActualAge)] := value;
      ChangeNotify(kActualAge);
    end;
    kAgeOnGrid: if Document.UADEnabled then begin
      FMungedText.Values[IntToStr(kAgeOnGrid)] := value;
    end;
  end;
end;

procedure TCellMunger.SetupMungedValues;
var
  doc: TContainer;
  Str: String;

  procedure SetSingleValue(kIndex, kSubstitute: Integer);
  var cStr: String;
  begin
//    cStr := MungedValue[kIndex];
    if MungedValue[kIndex] = '' then                        //we don't have it
      if doc.FindContextData(kIndex, cStr) then             //find it in doc
        MungedValue[kIndex] := cStr                         //save it
      else if (kIndex <> kSubstitute) and doc.FindContextData(kSubstitute, cStr) then   //if not in doc, get substitute
        MungedValue[kIndex] := cStr;                         //save it
  end;

  procedure SetDoubleValue(kIndex, kFirst, FSecond: Integer);
  begin
    if MungedValue[kIndex] = '' then         //we don't have it
      MungedValue[kIndex] := MungedValue[kFirst] +' '+MungedValue[FSecond];
  end;

  //hack to clean up old reports
  procedure CleanMungeValue(kIndex: Integer);
  begin
    if MungedValue[kIndex] = ', ,  ' then      //bug left ', ,  ' as full address
      MungedValue[kIndex] := '';
  end;

begin
  doc := TContainer(FOwner);

  CleanMungeValue(kAppraiserFullAddress);            //hack to clean up bug in old reports
  CleanMungeValue(kLenderFullAddress);

  SetSingleValue(kAppraiserAddress, 0);
  SetSingleValue(kAppraiserCity, 0);
  SetSingleValue(kAppraiserState, 0);
  SetSingleValue(kAppraiserZip, 0);
  SetSingleValue(kAppraiserCityStZip, 0);
  SetSingleValue(kAppraiserFullAddress, 0);
  SetSingleValue(kContactPhone, kAppraiserPhone);

  if MungedValue[kAppraiserCityStZip] = '' then begin
    Str := MungedValue[kAppraiserCity] + ', ' + MungedValue[kAppraiserState] + ' ' + MungedValue[kAppraiserZip];
    if Trim(Str) = ',' then Str := '';       //get rid of the commas in blank string
    MungedValue[kAppraiserCityStZip] := Str;
  end;
  if MungedValue[kAppraiserFullAddress] = '' then begin
    Str := MungedValue[kAppraiserAddress] + ', ' + MungedValue[kAppraiserCityStZip];
    if Trim(Str) = ',' then Str := '';       //get rid of the commas in blank string
    MungedValue[kAppraiserFullAddress] := Str;
  end;

  SetSingleValue(kInvoiceDate, kAppraiserSignDate);
  SetSingleValue(kReviewEffDate, kAppraiserSignDate);
  SetSingleValue(kTransmitalDate, kAppraiserSignDate);

  SetSingleValue(kNameOnCover, kAppraiserName);
  SetSingleValue(kAppraiserContact, kAppraiserName);
  SetSingleValue(kPayableContact, kAppraiserName);
  SetSingleValue(kPayableCoName, kAppraiserCoName);

  SetSingleValue(kLenderCompany, 0);
  SetSingleValue(kLenderAddress, 0);
  SetSingleValue(kLenderCity, 0);
  SetSingleValue(kLenderState, 0);
  SetSingleValue(kLenderZip, 0);
  SetSingleValue(kLenderCityStZip, 0);
  SetSingleValue(kLenderFullAddress, 0);

  if (MungedValue[kLenderCityStZip] = '') or (MungedValue[kLenderCityStZip] = ',, ') then begin
    Str := MungedValue[kLenderCity] + ', ' + MungedValue[kLenderState] + ' ' + MungedValue[kLenderZip];
    if Trim(Str) = ',' then Str := '';    //get rid of the commas in blank string
    MungedValue[kLenderCityStZip] := Str;
  end;
  if (MungedValue[kLenderFullAddress] = '') or (MungedValue[kLenderFullAddress] = ',, ') then begin
    Str := MungedValue[kLenderAddress] + ', ' + MungedValue[kLenderCityStZip];
    if Trim(Str) = ',' then Str := '';    //get rid of the commas in blank string
    MungedValue[kLenderFullAddress] := Str;
  end;

  SetSingleValue(kLenderMr, kLenderMr);
  SetSingleValue(kLenderFirst, kLenderFirst);
  SetSingleValue(kLenderLast, kLenderLast);
  SetSingleValue(kLenderZip, kLenderZip);
  SetDoubleValue(kLenderMrLast, kLenderMr, kLenderLast);
  SetDoubleValue(kLenderContact, kLenderFirst, kLenderLast);

  SetSingleValue(kLenderPhone, 0);
  SetSingleValue(kLenderFax, 0);
  SetSingleValue(kLenderEmail, 0);
  SetSingleValue(kLenderCell, 0);
  SetSingleValue(kLenderPager, 0);

  SetSingleValue(kAddress, 0);
  SetSingleValue(kCity, 0);
  SetSingleValue(kState, 0);
  SetSingleValue(kZip, 0);
  SetSingleValue(kCityStZip, 0);
  SetSingleValue(kFullAddress, 0);

  if MungedValue[kCityStZip] = '' then
    MungedValue[kCityStZip] := MungedValue[kCity] + ', ' + MungedValue[kState] + ' ' + MungedValue[kZip];
  if MungedValue[kFullAddress] = '' then
    MungedValue[kFullAddress] := MungedValue[kAddress] + ', ' + MungedValue[kCityStZip];

  SetSingleValue(kAppraisalValue, 0);
  if MungedValue[kAppraisalAmtWords] = '' then
    MungedValue[kAppraisalAmtWords] := NumberToDollarText(MungedValue[kAppraisalValue]);
end;

procedure TCellMunger.LoadFromStream(Stream: TStream);
var
  MemStream: TMemoryStream;
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);      //whats there to read
  if dataSize > 0 then                         //if something to read
    begin
      MemStream := TMemoryStream.Create;
      try
        memStream.CopyFrom(Stream, dataSize);  //get data out of file stream
        memStream.Position := 0;
        FMungedText.LoadFromStream(memStream); //loads StringList
      finally
        MemStream.Free;
      end;
    end;
end;

// Saves TStringList to a stream
procedure TCellMunger.SaveToStream(Stream: TStream);
var
  MemStream: TMemoryStream;
  dataSize: LongInt;
begin
  MemStream := TMemoryStream.Create;
  try
    FMungedText.SaveToStream(memStream);
    dataSize := memStream.Size;
    WriteLongToStream(dataSize, Stream);   //set the size
    memStream.SaveToStream(Stream);        //save data
  finally
    MemStream.Free;
  end;
end;

end.
