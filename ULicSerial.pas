unit ULicSerial;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{ This unit will take a number (integer) and return a 20 character }
{ string composed of digits and alpha characters. This will become }
{ a customers serial number and will be used to identify them.     }


{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

procedure GenerateSerialNumber(CustID: Integer; GroupFlag: Boolean; var SerialA, SerialB, SerialC, SerialD: String);
function ExtractCustomerID(SerialA, SerialB, SerialC, SerialD: String): Integer;
function IsPartOfUserGroup(SerialA: String): Boolean;
function ValidSerialNumbers(const SerialA, SerialB, SerialC, SerialD: String): Boolean;

function LeadingZeroDigitStr(Str: String; digits: Integer): String;
function GetUniqueID: Int64;
function EncodeDigit(N: Integer): Char;
function DecodeChar(C: Char): Integer;


implementation

uses
  SysUtils,DateUtils,Math,Dialogs,
  UStatus;

  

function AllowedDigits(ASCVal: Integer): char;
begin
  case ASCVal of
    58: result := 'J';
    59: result := 'E';
    60: result := 'F';
    61: result := 'F';
    62: result := 'E';
    63: result := 'R';
    64: result := 'Y';
    73: result := 'M';    //73 = I
    76: result := 'A';    //76 = L
    79: result := 'R';    //79 = O
    81: result := 'K';    //81 = Q
  else
    result := Char(ASCVal);
  end;
end;

function Random5Digits: String;
var
  Digits: ShortString;
begin
  Digits[0] := char(5);
  Digits[1] :=  AllowedDigits(RandomRange(50,90));
  Digits[2] :=  AllowedDigits(RandomRange(50,90));
  Digits[3] :=  AllowedDigits(RandomRange(50,90));
  Digits[4] :=  AllowedDigits(RandomRange(50,90));
  Digits[5] :=  AllowedDigits(RandomRange(50,90));
  result := digits;
end;

function EncodeDigit(N: Integer): Char;
begin
  result := '?';
  case N of
    0: result := 'A';
    1: result := '2';
    2: result := '5';
    3: result := 'Z';
    4: result := 'T';
    5: result := '7';
    6: result := 'C';
    7: result := '4';
    8: result := 'K';
    9: result := 'B';
  else
    showNotice('Non-valid value passed to encoder.');
  end;
end;

function DecodeChar(C: Char): Integer;
begin
  case C of
    'A': result := 0;
    '2': result := 1;
    '5': result := 2;
    'Z': result := 3;
    'T': result := 4;
    '7': result := 5;
    'C': result := 6;
    '4': result := 7;
    'K': result := 8;
    'B': result := 9;
  else
    result := -1;
 //   ShowNotice('Non-valid char passed to decoder.');
  end;
end;

{ To identify if a person belong to a group SerialA[3] is used }
{ to conveny this status. if Serial[3] = 'A' then the user is  }
{ NOT a part of a group, if the value in SerialA[3] is anything}
{ else, the user is part of a group and we will lock the Co Name}
function GroupingIdentifier(groupFlag: Boolean): Char;
begin
  if groupFlag then
    begin
      result := AllowedDigits(RandomRange(50,90));
      if result = 'A' then result := 'B';
    end
  else
    result := 'A';
end;

{ This grnerator can handle up to 999,999 customer serial numbers }
{ SerialA represents the customer ID number}
{ SerialB is a random sequence of chars }
procedure GenerateSerialNumber(CustID: Integer; GroupFlag: Boolean; var SerialA, SerialB, SerialC,SerialD: String);
var
  X, D6,D5,D4,D3,D2,D1, K1,K2, XS,X1,X2: Integer;
begin
  If not (CustID > 0) then
    begin
      ShowNotice('The customer ID was not a valid number.');
    end;

  SerialA := Random5Digits;
  SerialB := Random5Digits;
  SerialC := Random5Digits;
  SerialD := Random5Digits;

  //get the individual digits of the Customer ID
  //can handle up to 999,999 customers
  X := CustID;
  D6 := X div 100000;              //6th digit
  X := X - (D6 * 100000);
  D5 := X div 10000;               //5th place
  X := X - (D5 * 10000);
  D4 := X div 1000;               //4th place
  X := X - (D4 * 1000);
  D3 := X div 100;                //3th place
  X := X - (D3 * 100);
  D2 := X div 10;                 //2th place
  D1 := X - (D2 * 10);            //1st place

  SerialA[4] := EncodeDigit(D1);       //digit 1 of CustID
  SerialB[2] := EncodeDigit(D2);       //digit 2 of CustID
  SerialC[2] := EncodeDigit(D3);       //digit 3 of CustID
  SerialD[2] := EncodeDigit(D4);       //digit 4 of CustID
  SerialC[4] := EncodeDigit(D5);       //digit 5 of CustID
  SerialD[4] := EncodeDigit(D6);       //digit 6 of CustID

  //install verification keys
  K1 := D1 + D2;
  if K1 > 9 then K1 := K1 - 10;
  K2 := D3 + D4;
  if K2 > 9 then K2 := K2 - 10;
  SerialD[3] := EncodeDigit(K1);     //SA4 + SB2 -> SD3
  SerialB[4] := EncodeDigit(K2);     //SC2 + SD2 -> SB4

  //install random key
  XS := RandomRange(2,9);
  SerialC[1] := EncodeDigit(XS);
  X1 := XS div 2;
  SerialA[1] := EncodeDigit(X1);
  X2 := XS - X1;
  SerialB[1] := EncodeDigit(X2);

  //grouping identifier
  SerialA[3] := GroupingIdentifier(groupFlag);
end;

function ExtractCustomerID(SerialA, SerialB, SerialC, SerialD: String): Integer;
var
  X, D6,D5,D4,D3,D2,D1: Integer;
begin
  D1 := DecodeChar(SerialA[4]);      //digit 1 of CustID
  D2 := DecodeChar(SerialB[2]);      //digit 2 of CustID
  D3 := DecodeChar(SerialC[2]);      //digit 3 of CustID
  D4 := DecodeChar(SerialD[2]);      //digit 4 of CustID
  D5 := DecodeChar(SerialC[4]);      //digit 5 of CustID
  D6 := DecodeChar(SerialD[4]);      //digit 6 of CustID

  X := D6 * 100000;
  X := X + D5 * 10000;
  X := X + D4 * 1000;
  X := X + D3 * 100;
  X := X + D2 * 10;
  X := X + D1;
  result := X;
end;

function IsPartOfUserGroup(SerialA: String): Boolean;
begin
  result := false;
  if length(SerialA) >= 3 then
    result := SerialA[3] = 'A';
end;

function ValidSerialNumbers(const SerialA, SerialB, SerialC, SerialD: String): Boolean;
var
  K1,K2, D1,D2,D3,D4, D5,D6, X1,X2, KR, R1,R2: Integer;

  function Has5Ch(const S: String): Boolean;
  begin
    result := length(S)=5;
  end;
begin
  result := False;
  if Has5Ch(SerialA) and Has5Ch(SerialB) and Has5Ch(SerialC) and Has5Ch(SerialD) then
    begin
      //verification of customer ID
      K1 := DecodeChar(SerialD[3]);      //verification key 1
      K2 := DecodeChar(SerialB[4]);      //verification key 2

      D1 := DecodeChar(SerialA[4]);      //digit 1 of CustID
      D2 := DecodeChar(SerialB[2]);      //digit 2 of CustID
      D3 := DecodeChar(SerialC[2]);      //digit 3 of CustID
      D4 := DecodeChar(SerialD[2]);      //digit 4 of CustID
      D5 := DecodeChar(SerialC[4]);      //digit 5 of CustID
      D6 := DecodeChar(SerialD[4]);      //digit 6 of CustID

      X1 := D1 + D2;
      if X1 > 9 then X1 := X1 - 10;
      X2 := D3 + D4;
      if X2 > 9 then X2 := X2 - 10;

      //verification of random key
      KR := DecodeChar(SerialC[1]);
      R1 := DecodeChar(SerialA[1]);
      R2 := DecodeChar(SerialB[1]);

      result := (K1 >= 0) and (K2 >= 0) and
                (D1 >= 0) and (D2 >= 0) and (D3 >= 0) and (D4 >= 0) and (D5 >= 0) and (D6 >= 0) and
                (KR >= 0) and (R1 >= 0) and (R2 >= 0) and
                (K1 = X1) and (K2 = X2) and (KR = (R1+R2));
    end;
end;


function GetUniqueID: Int64;
begin
//  result := MinutesBetween(Now,0);
  result := SecondOfTheMonth(Date);
  result := result shl 32;
  result := result or RandomRange(0, High(Integer));
end;

function LeadingZeroDigitStr(Str: String; digits: Integer): String;
var
  i,j: Integer;
begin
  //this is a short string
  SetString(result, PChar('00000000000'), digits);
  j := digits;
  for i := length(Str) downto 1 do
    begin
      result[j] := Str[i];
      dec(j);
    end;
end;


end.
