unit UMacUtils;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

Uses
  SysUtils,ComCtrls,
	UGlobals, UFileGlobals;

//generic mac to win transposers
	function Mac2WinLong(macLong: LongInt): LongInt;
  function ConvertLong(theLong: LongInt; isMac: Boolean): LongInt;
	function ConvertBits(theLong: LongInt; isMac: Boolean): LongInt;
  function Mac2WinShort(macShort: SmallInt): SmallInt;  //YF 05.29.03

//specif mac to win transposers
  function Mac2WinFORMInfo(macFileInfo : FormInfoSection1): FormInfoSection1;

implementation

Uses
	UUtil1;

	
type
// use this structure for typecasting to transpose bytes
  XNum = packed record
		case Integer of
    0: (
      B1: Byte;
      B2: Byte;
      B3: Byte;
      B4: Byte);
    1: (
			LW: Word;
      HW: Word; );
    2: (
      Long: Longint);
  end;

//transpose the bits.
	function Mac2WinByte(macByte:Byte) : Byte;
	var
		winTmp, macTmp: XNum;
	begin
	//operate on the last byte, but use long to pass to routines
		winTmp.Long := 0;
		macTmp.Long := 0;
		macTmp.B1:= macByte;

		winTmp.Long := SetBit2Flag(winTmp.Long, 0, IsBitSet(macTmp.long, 7));
		winTmp.Long := SetBit2Flag(winTmp.Long, 1, IsBitSet(macTmp.Long, 6));
		winTmp.Long := SetBit2Flag(winTmp.Long, 2, IsBitSet(macTmp.Long, 5));
		winTmp.Long := SetBit2Flag(winTmp.Long, 3, IsBitSet(macTmp.Long, 4));
		winTmp.Long := SetBit2Flag(winTmp.Long, 4, IsBitSet(macTmp.Long, 3));
		winTmp.Long := SetBit2Flag(winTmp.Long, 5, IsBitSet(macTmp.Long, 2));
		winTmp.Long := SetBit2Flag(winTmp.Long, 6, IsBitSet(macTmp.Long, 1));
		winTmp.Long := SetBit2Flag(winTmp.Long, 7, IsBitSet(macTmp.Long, 0));

		result := winTmp.B1
	end;

  // generic routine for transposing mac LongInt to the win side
  //Mac Long is 4 bytes and each word is hibyte,lobyte
  function Mac2WinLong(macLong: LongInt): LongInt;
  var
    mL, wL: Xnum;
  begin
		mL.long := macLong;

		wL.B1 := mL.B4;      // transpose
		wL.B2 := mL.B3;
		wL.B3 := mL.B2;
		wL.B4 := mL.B1;

		result := wl.Long;
  end;

function Mac2WinShort(macShort: SmallInt): SmallInt;  //YF 05.29.03
var
   mL, wL: Xnum;
begin
  mL.LW := macShort;
  wL.B1 := ml.B2;
  wL.B2 := ml.B1;

  result := wl.LW;
end;

// rotate the bits, 32=1, 31=2, etc
// bits on mac and PC are oppositly indexed,
// so just transpose bits in each byte;
// this allows bit 1 on mac to equal bit 1 on PC;
// THis does not work for numbers, just bit flags!!
	Function Mac2Win32Bits(macLong: LongInt): LongInt;
  var
    mL, wl: Xnum;
	begin
		mL.Long := macLong;
		
		wL.B1 := Mac2WinByte(mL.B1);   //do not transpose bytes, just the bits in each byte
		wL.B2 := Mac2WinByte(mL.B2);
		wL.B3 := Mac2WinByte(mL.B3);
		wL.B4 := Mac2WinByte(mL.B4);

		result := wl.long;
	end;

// another routine to convert mac longs and ints 
  function ConvertLong(theLong: LongInt; isMac: Boolean): LongInt;
  begin
    if isMac then
      result := Mac2WinLong(theLong)
    else
      result := theLong;
	end;

// Use this ONLY for transferring Bits between mac and win
	function ConvertBits(theLong: LongInt; isMac: Boolean): LongInt;
	begin
		if isMac then
			result := Mac2Win32Bits(theLong)
    else
			result := theLong;
  end;

// special for converting the FileInfo Headers coming from mac side
//Needs to change if headers change
  function Mac2WinFORMInfo(macFileInfo : FormInfoSection1): FormInfoSection1;
  var
    winFileInfo: FormInfoSection1;
  begin
    winFileInfo := macFileInfo;     // transfer what we can;

    winFileInfo.fFormUID := Mac2WinLong(macFileInfo.fFormUID);           //transpose the numbers
    winFileInfo.fFormPgCount:= Mac2WinLong(macFileInfo.fFormPgCount);
    winFileInfo.fFormVers := Mac2WinLong(macFileInfo.fFormVers);
    winFileInfo.fFormIndustry := Mac2WinLong(macFileInfo.fFormIndustry);
    winFileInfo.fFormCategory := Mac2WinLong(macFileInfo.fFormCategory);
    winFileInfo.fFormKind := Mac2WinLong(macFileInfo.fFormKind);
		winFileInfo.fLockSeed := Mac2WinLong(macFileInfo.fLockSeed);
		winFileInfo.fFormFlags := Mac2Win32Bits(macFileInfo.fFormFlags);
    winFileInfo.fNextSectionID := Mac2WinLong(macFileInfo.fNextSectionID);

    result := winFileinfo;
	end;

end.
