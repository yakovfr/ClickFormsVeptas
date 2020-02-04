unit UFileGlobals;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
	Windows,
	UGlobals;

  
(*
 File globals is the common place for all the structure/records for the files. Since we are
 having a common file between the mac and windows, we are not using streaming to store or
 read any of the data. It is all done with the records described below.

 UFiles is the unit used to read and write these records. It is also where the conversion between
 the file formats and the application forms takes place.

 The file is composed of sections. The first section is the file identifier and cannot change.
 The sections trailing may chnage in the furure (very likely) so there is a field in the
 preceeding section to indicate the version id of the section. this field is fNextSectionID.

 A form description file is composed of the following sections:
   GenericIDHeader
   FormInfoSection1
   FormSpecSection1
   PageSpecSection
      - iterate on number of pages
      PageTextRec  - read all text recs
      PageCellRec  - read all cell recs
      PageObjectRec- read all obj recs
*)

const
  cFileOwner = '_CLICKFORMS_';
  cFileCPUMAC = '_MAC';
  cFileCPUWin = '_WIN';

	cDATAFile = 1;
//cDATAType = 'DATA';			 //Data file ie report
//cDATACurVers = 1;				 // 5/99 version # of the DATA file

 {New Data Type and Version because we did not track version correctly.}
 {This will avoid crashes in old versions of CLickFORMS}
  cV1DataType = 'DATA';    //Data type in Version 1
	cDATAType = 'DAT2';			 //New Data file type for report to indicate version number change
  cDataCurVers = 2;        // 3/05 version: added map labels, changed Cell R/W

  cNewsFile = 8;
  cNEWSType = 'NEWS';     //What's new report it is slightly different than regular one: no encryption

	cFORMFile = 2;
	cFORMType = 'FORM';      //Form definition
	cFORMCurVers = 1;				 // 5/99 version # of the FORM file

	cOWNRFile = 3;
	cOWNRType = 'OWNR';      //Owner Lic file
	cOWNRCurVers = 1;				 // 3/00 version # of the OWNR file

	cUSERFile = 4;
	cUSERType = 'USER';      //User Lic file
	cUSERCurVers = 1;				 // 3/00 version # of the USER file

	cRSPSFile = 5;
	cRSPSType	= 'RSPS';			 //std Responses file {NOTE: there are 2: Rsp & Cmt each with dif version}
	cRSPSCurVers = 1;				 // 3/00 version # of the RSPS file

	cPRODFile = 6;
	cPRODType = 'PROD';			 //Product identifier
	cPRODCurVers = 1;        // 3/00 version # of the PROD file

	cLISTFile = 7;
	cLISTType = 'LIST';			 //List identifier  (general list files)
	cLISTCurVers = 1;        // 2/03 version # of the List file

  

// version IDs of the Info Section records
  cFormInfoSect1 = 1;         //version of the FormInfoSection

// version IDs of the FormSpec Sections
  cFormSpecSect1 = 1;

	cXtraSpace = 20;
  cMax31Chars = 31;
  cNameMaxChars = 63;    //this is for files created by us, def files have a max of 31

//File Type Extension that we recognize
//	extClickFORMReport			= '.clk';                 //ClickFORM Report extension
//	extClickFORMTemplate		= '.cft';                 //ClickFORM Template extension
  extOriginalUAAR         = '.uad';                 //Original UAAR Report

//ClickForm File types
//These types are recognized when calling POS on rsrc string with Ext's in order of type ID
//Ext's types are stored in UStrings as extClickForms and extOLDClickForms
  cClickFormType    = 1;
	cClkFormTemplate	= 2;

//old file types from 16-bit toolbox
  OldFileTyp    = 2;                //1=new Clickforms; 2=ClickForms Template
  cUAARType     = OldFileTyp +1;    //old file types start at 3
  cUAARTmpType  = OldFileTyp +2;    //each file had a different ext
  cURAR         = OldFileTyp +3;    //so there are many types between 3 and 217
  cURARTmp      = OldFileTyp +4;
  cCondo        = OldFileTyp +5;
  cCondoTmp     = OldFileTyp +6;
  cUSPAPtmp     = OldFileTyp +215;  //last old file type is 217.

//new file types
  cApprWorldOrder = 300;            //skip from 217 to 300 - space for SFREP converters
  cRELSOrderNotification = 301;	//RELS *.rxml file. Its contains order info
  cAMCOrderNotification = 303;	//AMC *.cfx file. Its contains order info
  cUniversalXMLOrder = 304;    //Rally orderes .uao

//Macintosh file types
  cMacAppraiser = 999;              //way out id for handing mac files


type

//	FourChars = array[1..4] of char;
	fIDType = FourChars;
	CPUType = FourChars;
	SeedType = FourChars;

// Generic Header used by all files
  PGenericIDHeader = ^GenericIDHeader;
  GenericIDHeader = packed record
      fFileOwner: array[1..12] of char;			  {holds '_CLICKFORMS_'}
      fFileCPUOrigin: array[1..4] of char;		{holds _MAC}
			fFileType: fIDType;				              {holds DATA, FORM}
			fFileVers: Integer;                     {quick check on version of this file}
			fNextSectionID: Integer;								//ID for the version of the section following this rec
      fIsEncrypted: longint;
			ExtraSpace: array[1..cXtraSpace - 1] of longint;		{buffer for expanding the header}
      //ExtraSpace[1] now devote to isEncrypted flag: Default 0 means unencrypted otherwise file encrypted
		end;
  
//Used by Form Definition files
	FormInfoSection1 = packed record
			fFormUID: LongInt;									{unique form identifer, 0 for data and other types}
			fFormPgCount: LongInt;							{number of pages in form includes c-addms}
      fFormVers: LongInt;									{revision no. of this form}
			fFormName: String[31];					    {name of this form}
      fFormIndustry: LongInt;							{Industry: Appraisal, loan etc.}
      fFormIndustryName: String[31];
      fFormCategory: LongInt;							{classification .}
      fFormCategoryName: String[31];
			fFormKind: LongInt;									{main, addendum, custom etc.}
      fFormKindName: String[31];
			fFormIndustryCode1: string[9];
			fFormIndustryCode2: string[9];
			fFormIndustryDate: String[11];
      fCreateDate: String[11];						    {number of pages in form includes c-addms}
      fLastUpdate: String[11];						    {last date created}
			fLockSeed: LongInt;									   	{registration seed}
			fFormFlags: LongInt;									  {32 flags to indiccate what data is in file}
			fNextSectionID: Integer;							  {version of the form spec record }
			ExtraSpace: array[1..20] of longint;		{buffer for expanding the header}
		end;

//Used in Form Definition file
	FormSpecSection1 = packed record
			fFormUID: LongInt;									  {unique form identifer}
			fFormVers: LongInt;									  {revision no. of this form}
			fNumPages: LongInt;									  {number of pages in form includes c-addms}
			fFormFileName: String[31];					  //### never used!! {name of the format file}
			fFormFlags: LongInt;								  {32 flags to indiccate what data is in file}
			fNextSectionID: Integer;						 	{version id of the following page definition structure}
			ExtraSpace: array[1..10] of longint;	{buffer for expanding the header}
		end;

//Used in Form Definition file
  PageSpecSection = packed record
		PgName: String[31];                      //name of this page
    PgID: LongInt;                          //unique ID of this if it has one
    PgType: Integer;                        // typ eof page for quick reference
    PgFlags: LongInt;                       // quick way to tell the page attributes
    PgGoToOffset: LongInt;                  // bookmark offset into the page
		PgGoToName: String[31];                 // name of the bookmark
    PgHeight: LongInt;                      // Height of the page
    PgWidth: LongInt;                       // Width of the page
    fNextSectionID: LongInt;                // section ID incase next section changes
    PgNumTextItems : LongInt;
    PgNumObjItems : LongInt;
    PgNumCellItems : LongInt;
		PgNumInfoItems : LongInt;
    PgSeqCount : LongInt;     //PgSeqSize
    PgNumPicItems : LongInt;
    PgNumGroupItems : LongInt;
		PgNumTableItems : LongInt;
		PgNumUserCntls: LongInt;
		PgExtraItem2: LongInt;                  //for future additions
		PgExtraItem3: LongInt;
		PgExtraItem4: LongInt;
		PgExtraItem5: LongInt;
		PgExtraItem6: LongInt;
		PgExtraItem7: LongInt;
		PgExtraItem8: LongInt;
		PgExtraItem9: LongInt;
		PgExtraItem10: LongInt;
		PgExtraItem11: LongInt;
		PgExtraItem12: LongInt;
		PgExtraItem13: LongInt;
		PgExtraItem14: LongInt;
		PgExtraItem15: LongInt;
		PgExtraItem16: LongInt;
		PgExtraItem17: LongInt;
		PgExtraItem18: LongInt;
		PgExtraItem19: LongInt;
		PgExtraItem20: LongInt;
	 end;

//Used in Form Definition for Page Text
	 PageTextRec = packed record          // this is the record used by each page text object
    FBox: TRect;                       // it is followed by the objects text string
    FontID: LongInt;
    PrFSize: LongInt;
    ScrFSize: LongInt;
    FJust: LongInt;
    FDescent: LongInt;
    FType: LongInt;
    FStyle: LongInt;
    FStrLen: LongInt;
   end;

//Used in Form Definition file for Page Cells
//This record is not used anywhere - here for reference
   PageCellRec1 = packed record
		CRect: TRect;
		CTypes: LongInt;              //Type and subType  (hi/lo word
		CFormat: LongInt;
		CPref: Longint;
		CSize: Longint;
		CTxLines: LongInt;           //hi= TxMaxLines; lo = TxIndent
		CGroups: LongInt;            //hi=group1; lo= group2 (hi/lo word)
		CTables: Longint;            //hi=table1; lo= table2 (hi/lo word)
		CMathID: LongInt;
    CContextID: LongInt;
		CResponseID: LongInt;
		CCellID: LongInt;
		CLengths: Longint;
   end;

//Used in Form Definition file for Page Cells
   PageCellRec = packed record
		CRect: TRect;
		CTypes: LongInt;              //hi= Typel lo= SubType  (hi/lo word
		CFormat: LongInt;
		CPref: Longint;
		CSize: Longint;              //font size
		CTxLines: LongInt;           //hi= TxMaxLines; lo = TxIndent
		CGroups: LongInt;            //hi=group1; lo= group2 (hi/lo word)
		CTables: Longint;            //hi=table1; lo= table2 (hi/lo word)
		CMathID: LongInt;
    CContextID: LongInt;
    CLocalConTxID: LongInt;
		CResponseID: LongInt;
    CRspTable: Longint;
		CCellID: LongInt;            //unique ID for cell types
    CCellXID: Longint;           //unique identifier for MISMO XML Xpaths
		CLengths: Longint;           //hi=len of cell name; lo=len of default text
   end;                          //CName & CDefault Text follow rec

//Used in Form Definition for Page Objects
   PageObjectRec = packed Record
    ORect: TRect;
    OBounds: TRect;
    OType: LongInt;
    OStyle: LongInt;
    OWidth: LongInt;
    OFill: LongInt;
   end;

//Used in Form Definition for Page Info Items
	PageInfoItemRec = packed record
		IType: LongInt;
		IRect: TRect;
		IText: String[15];
		IFill: LongInt;
		IJust: LongInt;
		IHasPercent: LongInt;
		IIndex: LongInt;
	end;

//Used in Form definition file for graphic items
//This record is followed by the actual graphic item
	PageGraphicItem = record
		GType: LongInt;
		GBounds: TRect;
		GSize: LongInt;
	end;

//Used in Form Definition for Page Tab Sequence
	CellSeqRec = packed record
    SCellID: LongInt;
    SUp: LongInt;
		SDown: LongInt;
		SLeft: LongInt;
    SRight: LongInt;
    SNext: LongInt;
	end;

//Used in Form Definition to describe the User Controls
//These can be Buttons, Scroll Lists and Popdown Lists
	UserCntlItem = packed record
		ucType: LongInt;
		ucRect: TRect;
		ucOnClick: LongInt;
		ucOnLoad: LongInt;
		ucCaption: string[31];
	end;



{**************************************************}
{                                                  }
{          Used in Data Files                      }
{                                                  }
{**************************************************}

//Used in Data Files for Document Specs
//Version 3:
// Three unused longs, 2 are converted to int64 to hold docUID
//The version IDs were not changed
	DocSpecRec = packed record
		fNumForms: LongInt;                  //number of forms in this file
    fNumLocks: LongInt;                  //number of locks on the form
    ffDocUID: int64;                     //unique ID for this file, used for tracking (ff to avoid conflict)
    {fExtraC: LongInt;}
    fDispPgNums: LongInt;                //loWrd = AutoPgNumbering, hiWrd=DisplayPgNumbers
		fFontName: String[cMax31Chars];      //data entry font used in this report
		fFontSize: Integer;                  //data entry font size
		fFontColor: Integer;                 //###cannot change color for now
		fPrefFlags: Integer;                 //32 flags for doc prefs
		fScale: Integer;                     //the scale to display the doc
		fHScrollPos: LongInt;                //(NOT USED)overridden by active cell position
		fVScrollPos: LongInt;                //(NOT USED)ditto
		fActiveCell: OldCellUID;             //this is the active cell in report
		FPageMgrWidth: LongInt;               //width of PageMgr List Width
		fNextSectionID: Integer;						 //version ID for form section following the header}
    fPgNumbers: LongInt;                 //loWrd = Manual Start PgNum; hiWrd = Manual Total Pages
    {fExtra1: LongInt;}                   // Extra 32-bit flags
    FExtra2: LongInt;                   // Extra 32-bit flags
end;
(*
//Used in Data Files for Document Specs
//Version 2:
// The extra longs were converted to read/write of objects
// The winPos was changed to 4 longs, 3 are unused
//The version IDs were not changed
	DocSpecRec = packed record
		fNumForms: LongInt;                  //number of forms in this file
    fNumLocks: LongInt;                  //number of locks on the form
    fExtraA: LongInt;
    fExtraB: LongInt;
    fExtraC: LongInt;
		fFontName: String[cMax31Chars];      //data entry font used in this report
		fFontSize: Integer;                  //data entry font size
		fFontColor: Integer;                 //###cannot change color for now
		fPrefFlags: Integer;                 //32 flags for doc prefs
		fScale: Integer;                     //the scale to display the doc
		fHScrollPos: LongInt;                //(NOT USED)overridden by active cell position
		fVScrollPos: LongInt;                //(NOT USED)ditto
		fActiveCell: OldCellUID;             //this is the active cell in report
		FPageMgrWidth: LongInt;               //width of PageMgr List Width
		fNextSectionID: Integer;						 //version ID for form section following the header}
    fExtra1: LongInt;                   // Extra 32-bit flags
    FExtra2: LongInt;
end;
*)
(*
//Used in Data Files for Document Specs
//Original Version1: This is the Doc Spec version used in ClickFORMS 195
	DocSpecRec = packed record
		fNumForms: LongInt;                  //number of forms in this file
		fWinPos: TRect;                      //last coordinates of this doc's window
		fFontName: String[cMax31Chars];      //data entry font used in this report
		fFontSize: Integer;                  //data entry font size
		fFontColor: Integer;                 //###cannot change color for now
		fPrefFlags: Integer;                 //32 flags for doc prefs
		fScale: Integer;                     //the scale to display the doc
		fHScrollPos: LongInt;                //overridden by active cell position
		fVScrollPos: LongInt;                // ditto
		fActiveCell: OldCellUID;             //this is the active cell in report
		FPageMgrWidth: LongInt;               //width of PageMgr List Width
    fHasDataFlag: Integer;               // 32-bit flags
//    fHasDigSign: array[1..4] of LongInt; // >0 means there is a digSign. could be size; up to 4 signatures;

    fPublicTablSiz: LongInt;

    fExtra1: LongInt;     //    fPublicTablSiz: LongInt;
    fExtra2: LongInt;
		fExtra3: LongInt;
		fExtra4: LongInt;
		fExtra5: LongInt;
		fExtra6: LongInt;
		fExtra7: LongInt;
		fExtra8: LongInt;
		fExtra9: LongInt;
		fExtra10: LongInt;
		fExtra11: LongInt;
		fExtra12: LongInt;
		fExtra13: LongInt;
		fExtra14: LongInt;
		fExtra15: LongInt;
		fExtra16: LongInt;
		fExtra17: LongInt;
		fExtra18: LongInt;
		fExtra19: LongInt;
		fExtra20: LongInt;
		fExtra21: LongInt;
		fExtra22: LongInt;
		fExtra23: LongInt;
		fExtra24: LongInt;
		fExtra25: LongInt;
		fExtra26: LongInt;
		fExtra27: LongInt;
		fExtra28: LongInt;
		fExtra29: LongInt;
		fExtra30: LongInt;
		fNextSectionID: Integer;								{version ID for form section following the header}
	end;
*)

(*
//FIX for ED Dillman

//Used in Data Files for Document Specs
	DocSpecRec2 = packed record
		fNumForms: LongInt;                  //number of forms in this file
		fWinPos: TRect;                      //last coordinates of this doc's window
		fFontName: String[cMax31Chars];    //data entry font used in this report
		fFontSize: Integer;                  //data entry font size
		fFontColor: Integer;                 //###cannot change color for now
		fPrefFlags: Integer;                 //32 flags for doc prefs
		fScale: Integer;                     //the scale to display the doc
		fHScrollPos: LongInt;                //overridden by active cell position
		fVScrollPos: LongInt;                // ditto
		fActiveCell: oldCellUID;                //this is the active cell in report
		FPageMgrWidth: LongInt;               //width of PageMgr List Width
    fHasDataFlag: Integer;               // 32-bit flags
//    fHasDigSign: array[1..4] of LongInt; // >0 means there is a digSign. could be size; up to 4 signatures;

    fExtra1: LongInt;     //    fPublicTablSiz: LongInt;
    fExtra2: LongInt;
		fExtra3: LongInt;
		fExtra4: LongInt;
		fExtra5: LongInt;
		fExtra6: LongInt;
		fExtra7: LongInt;
		fExtra8: LongInt;
		fExtra9: LongInt;
		fExtra10: LongInt;
		fExtra11: LongInt;
		fExtra12: LongInt;
		fExtra13: LongInt;
		fExtra14: LongInt;
		fExtra15: LongInt;
		fExtra16: LongInt;
		fExtra17: LongInt;
		fExtra18: LongInt;
		fExtra19: LongInt;
		fExtra20: LongInt;
		fExtra21: LongInt;
		fExtra22: LongInt;
		fExtra23: LongInt;
		fExtra24: LongInt;
		fExtra25: LongInt;
		fExtra26: LongInt;
		fExtra27: LongInt;
		fExtra28: LongInt;
		fExtra29: LongInt;
		fExtra30: LongInt;
		fNextSectionID: Integer;								{version ID for form section following the header}

//		fDisplayPref: DisplayPrefRec;

		fSignSiz: array[1..4] of LongInt;
		fLenderSiz: LongInt;						{lender info}
		fInvoiceSiz: LongInt;						{invoice info}
		fSkPrefSiz: LongInt;						{sketcher info}
		fAdjSiz: LongInt;							{adjustment info}
		fPublicSiz: LongInt;						{public info}

	end;
*)

//original File property Fixed length record
//it was part of the file structure version 1
//but was never populated with actual file data
//IT IS NO LONGER USED, Now have UDocProperty Object
  DocPropertySpec = packed record
    RecSize: LongInt;                 //size of this record
    RecVers: Integer;                 //version of this record
    SWVersion: Integer;               //version of the software
    FSVersion: Integer;               //version of the file structure
    Category: String[15];
    KeyWords: String[63];
    FileType: String[15];
    FileNo: String[15];
    PropType: String[15];
    AddressNo: string[15];
    AddressSt: string[25];
    TotalRms: string[3];
    TotalBaths: string[3];
    TotalBRms: string[3];
    SqFeet: string[9];
    City: String[31];
    State: String[3];
    Zip: String[15];
    County: String[31];
    Parcel: String[25];
    Census: String[25];
    Owner: String[31];
    AppraisalDate: String[15];
    AppraisedValue: String[15];
    AppraiserCo: String[63];
    Appraiser: String[31];
    Borrower: String[31];
    Client: String[31];
    Acres: String[11];
    Extra1: String[9];
    Extra2: String[9];
    Extra3: String[9];
    Extra4: String[9];
    Extra5: String[9];
    Extra6: String[9];
    Extra7: String[9];
    Extra8: String[9];
    Extra9: String[9];
    Extra10: String[9];
    CreatedDate: TDateTime;
    ModifiedDate: TDateTime;
  end;

	FormSpecRec = packed record
		fFormUID: LongInt;									  {unique form identifer}
		fFormVers: LongInt;									  {revision no. of this form}
    fFormName: String[cNameMaxChars];     //NEW save name of form in file
		fNumPages: LongInt;									  {number of pages in form includes c-addms}
		fFormFlags: LongInt;								  {32 flags to indiccate what data is in file}
		fNextSectionID: Integer;						 	{version id of the following page definition structure}
    fLockCount: LongInt;                  //added 1/11/03
		ExtraSpace: array[1..19] of longint;	{buffer for expanding the header}
	end;

	PageSpecRec = packed record
		fNumCells: Integer;                   //num of cells on this page
		fNumBookmarks: Integer;								//num of bookmarks for this page
    fPgTitle: String[cNameMaxChars];      //NEW Title of this page
		fPgPrefs: LongInt;								    //32 flags to indiccate prefs of page
		fExtra0: Integer;							        //NOT USED
		fNumInfoCells: LongInt;               //number of Info Cells on this page
		fNextSectionID: Integer;						 	//version id of the following page definition structure}
		fExtra1: LongInt;                     //extra space since we forget
		fExtra2: LongInt;
		fExtra3: LongInt;
		fExtra4: LongInt;
(*
		fExtra6: LongInt;
		fExtra7: LongInt;
		fExtra8: LongInt;
		fExtra9: LongInt;
		fExtra10: LongInt;
		fExtra11: LongInt;
		fExtra12: LongInt;
		fExtra13: LongInt;
		fExtra14: LongInt;
		fExtra15: LongInt;
		fExtra16: LongInt;
		fExtra17: LongInt;
		fExtra18: LongInt;
		fExtra19: LongInt;
		fExtra20: LongInt;
		fExtra21: LongInt;
		fExtra22: LongInt;
		fExtra23: LongInt;
		fExtra24: LongInt;
		fExtra25: LongInt;
		fExtra26: LongInt;
		fExtra27: LongInt;
		fExtra28: LongInt;
		fExtra29: LongInt;
		fExtra30: LongInt;
*)
	end;

// record struct that is used to save info about cell in data file
	CellSpecRec = record
		fWhoIsCell: Longint;		//hiWord is CellType, loWord = cellSubType for reconstructing cell if form def is lost
		fPref: Integer;         //holds the cell's prefs
		fFormat: Integer;       //holds the formatting bits
		fStatus: Integer;       //holds the current status info
		fSize: Integer;					//tx size and could be sued for scale value
		fBkGrdColor: Longint;		//what was the background, lets make this flexible
	end;


{**************************************************}
{                                                  }
{          Used in Response Files                  }
{                                                  }
{**************************************************}

	RspSpecRec = record
		RecVers: Integer;
		RspType: Integer;       //= 1 for std responses, = 2 for std comments
		PgCount: Integer;       //number of response page lists to read. One list per page
		Xtra1: Integer;         //the actual rsponses are read by TPageRspList.LoadFromStream
		Xtra2: Integer;
	end;

  //same structure as reponses
	CmtSpecRec = record
		RecVers: Integer;
		RspType: Integer;
		Count: Integer;                //number of comments strings in this file
		Xtra1: Integer;
		Xtra2: Integer;
	end;

Implementation

end.
