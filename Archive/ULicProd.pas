unit ULicProd;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{This is the unit handles the read/writing of ProductID files }
{It is used by LicUser and the Registration program.          }
{Each product that is installed will have a Product File. This}
{file will have a PID (Product ID) that is unique to this     }
{product and identifies it. Also there will be a ProductSeed  }
{which changes with each new version of the product. The comb-}
{bination of the UserReg number, the ProductSeed and the Users}
{Unloocking Code will determine if the user has a valid license}
{to use the product.}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Classes, SysUtils,Contnrs;
  
const
{Version IDs}
  cProductVers1  = 1;

type
  TProduct = class(TObject)
//  private
    FModified: Boolean;
    FFileVers: Integer;           //version number of this record
    FProdID: Integer;             //unique ID for this product
    FProductName: String;         //name of the product
    FProdUserVers: String;        //(ie: 1.1.215)
    FProdRelease: Integer;        //product release number, 1, 2, 3, 4
    FProdVersSeed: Longint;       //the unique product seed for this version
    FValidCode: Boolean;          //reg & unlock code match
    FRegKey: LongInt;             //NOTE: This will come from USER
    FUnlockCode: LongInt;
    FFirstRunTime: TDateTime;     //Stores the first time the program is run
  	FLastRunTime: TDateTime;      //Stores the last time the program was run

  private
    function CompareKeys(RegKey, UserUnlockKey: LongInt): Boolean;
    function GetRegKeyStr: String;
    function GetUnlockCodeStr: String;
    procedure SetUnlockCode(const Value: LongInt);
  public
    constructor Create;
    Procedure LoadFromFile(const fileName: String);
    Procedure SaveToFile(const fileName: String);
    procedure LoadFromStream(Stream: TFileStream);
    procedure SaveToStream(Stream: TFileStream);
    //registration utility functions
    function SumStr(S: String): LongInt;
    function BitInvert (LongBits: LongInt): LongInt;
    function CalcUnlockKey (RegNum: LongInt): LongInt;
    procedure GenerateRegKey(const UserName, CoName: String; CoLocked: Boolean);
    //user friendly names
    property Modified: Boolean read FModified write FModified;
    property ProductID: Integer read FProdID write FProdID;
    property Name: String read FProductName write FProductName;
    property Version: String read FProdUserVers write FProdUserVers;
    property Release: Integer read FProdRelease write FProdRelease;
    property ReleaseSeed: LongInt read FProdVersSeed write FProdVersSeed;
    property ValidCode: Boolean read FValidCode write FValidCode;

    property RegKeyStr: String read GetRegKeyStr;
    property UnlockCode: LongInt write SetUnlockCode;
    property UnlockCodeStr: String read GetUnlockCodeStr;
  end;

  {TProductMgr manages the list of products}
  TProductMgr = class(TObjectList)
    constructor Create;
    procedure ProcessProductFile(Sender: TObject; FileName: string);
    procedure GatherProductFiles;
  public
    function IsProductInstalled(PID: Integer): Boolean;
    function GetProductByName(name: string): TProduct;
  end;

var
  InstalledProducts: TProductMgr;     //initialized by UInit at startup


implementation

uses
  UGlobals, UFileGlobals, UFileUtils, UStatus, UFileFinder;



{Utility Functions}
{These functions are so we do not have to link in     }
{UUtil1 cause it uses UContainer and WPPDF which the  }
{Registration program cannot find.                    }

function IsBitSet(Store, bit: Integer): Boolean;
begin
	result := LongBool(Store and (1 shl bit));       //is bit = 1
end;

function SetBit(const Store: Integer; bit: Integer): Integer;
begin
	Result := Store or (1 shl bit);                  //set bit to 1
end;




  
{ TProduct }

constructor TProduct.Create;
begin
  inherited;
  
  FFileVers := cProductVers1;
  FModified := False;
  FValidCode := False;       //assume user cannot use this product
  FRegKey := 0;
  FUnLockCode := 0;
  FFirstRunTime := 0;        //Stores the first time the program is run
  FLastRunTime := 0;         //Stores the last time the program was run
end;

function TProduct.SumStr(S: String): LongInt;
var
  Sum: LongInt;
  i: Integer;
begin
  Sum := 0;
  S := UpperCase(S);
  for i := 1 to length(S) do
    if S[i] in ['0'..'9', 'A'..'Z'] then
      Sum := Sum + Ord(S[i]);
  result := Sum;
end;

function TProduct.BitInvert (LongBits: LongInt): LongInt;
var
  Inverted: LongInt;
  i: Integer;
begin
  Inverted := 0;
  for i := 0 to 31 do
    begin
      if not IsBitSet(LongBits, i) then
        Inverted := SetBit(Inverted, 31 - i);
    end;
  result := Inverted;
end;

function TProduct.CalcUnlockKey (RegNum: LongInt): LongInt;
var
  RegCopy, UnlockKey{, SeedNum}: LongInt;
begin
//  Move(AppProgSeed, SeedNum, 4);          {go from char to long}
//  RegCopy := RegNum + SeedNum;            {add seed here, not in reg as before}
  RegCopy := RegNum + ReleaseSeed;          {add seed here, not in reg as before}
  RegCopy := BitInvert(RegCopy);				    {invert}
  UnLockKey := RegCopy XOR RegNum;          {XOR the numbers}

  CalcUnlockKey := Abs(UnlockKey);				  {absolute}
end;

function TProduct.CompareKeys(RegKey, UserUnlockKey: LongInt): Boolean;
var
  GenUnlockKey: LongInt;
begin
  result := False;
  if (RegKey > 0) and (UserUnlockKey > 0) then
    begin
      GenUnlockKey := CalcUnlockKey(RegKey);		  {Garys stuff}
      result := (GenUnlockKey = UserUnlockKey);		{are they equal}
    end;
end;

procedure TProduct.GenerateRegKey(const UserName, CoName: String; CoLocked: Boolean);
begin
  FRegKey := SumStr(UserName) * 4713;        //4713 & 3219 are just random numbers
  if CoLocked then
    FRegKey := FRegKey + SumStr(CoName) * 3219;
end;

procedure TProduct.LoadFromFile(const fileName: String);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

procedure TProduct.LoadFromStream(Stream: TFileStream);
var
  GH: GenericIDHeader;
begin
  ReadGenericIDHeader(Stream, GH);        //### check for user type & version

  FFileVers := ReadLongFromStream(Stream);
  FProdID := ReadLongFromStream(Stream);
  FProductName := ReadStringFromStream(Stream);
  FProdUserVers := ReadStringFromStream(Stream);
  FProdRelease := ReadLongFromStream(Stream);
  FProdVersSeed := ReadLongFromStream(Stream);
end;

procedure TProduct.SaveToFile(const fileName: String);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TProduct.SaveToStream(Stream: TFileStream);
begin
  WriteGenericIDHeader2(Stream, cPRODFile, 1);

  WriteLongToStream(FFileVers, Stream);
  WriteLongToStream(FProdID, Stream);
  WriteStringToStream(FProductName, Stream);
  WriteStringToStream(FProdUserVers, Stream);
  WriteLongToStream(FProdRelease, Stream);
  WriteLongToStream(FProdVersSeed, Stream);
end;


function TProduct.GetRegKeyStr: String;
begin
  try
    if FRegKey=0 then
      result := ''
    else
      result := IntToStr(FRegKey);
  except
    result := '';
  end;
end;

function TProduct.GetUnlockCodeStr: String;
begin
  try
   if FUnlockCode=0 then
      result := ''
    else
      result := IntToStr(FUnlockCode);
  except
    result := '';
  end;
end;

procedure TProduct.SetUnlockCode(const Value: LongInt);
begin
  FUnlockCode := Value;
  if (FRegKey > 0) and (FUnlockCode > 0) then
    FValidCode := CompareKeys(FRegKey, FUnlockCode);
end;




{ TProductMgr }

constructor TProductMgr.Create;
begin
  inherited;

  OwnsObjects := True;
  GatherProductFiles;
end;

procedure TProductMgr.ProcessProductFile(Sender: TObject; FileName: string);
var
  Product: TProduct;
begin
  Product := TProduct.Create;
  try
    Product.LoadFromFile(fileName);
    Add(Product);
  except
    ShowNotice('Could not read the Product file: '+ extractFilename(FileName));
  end
end;

function CompareProdIDs(Item1, Item2: Pointer): Integer;
begin
  result := TProduct(Item1).FProdID - TProduct(Item2).FProdID;
end;

procedure TProductMgr.GatherProductFiles;
var
  startDir: String;
begin
  startDir := appPref_DirProducts;
	if DirectoryExists(startDir) then
    begin
      FileFinder.OnFileFound := ProcessProductFile;
      FileFinder.Find(startDir, False, '*.pid');     //find all product files
      Sort(@CompareProdIDs);
    end;
end;

function TProductMgr.IsProductInstalled(PID: Integer): Boolean;
var
  i: Integer;
begin
  result := False;
  i:= 0;
  while (not result) and (i < Count) do
    begin
      if TProduct(Items[i]).ProductID = PID then
        result := true;
      inc(i);
    end;
end;

function TProductMgr.GetProductByName(name: String): TProduct;
var
  prodNo: Integer;
begin
  result := nil;
  for prodNo := 0 to count - 1 do
    if compareText(TProduct(Items[prodNo]).Name,name) = 0 then
    begin
      result := TProduct(Items[prodNo]);
      break;
    end;
end;


end.
