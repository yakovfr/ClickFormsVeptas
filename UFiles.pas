unit UFiles;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc.}


interface

Uses
	SysUtils,ComCtrls,Classes,Dialogs,Windows,Graphics,JPEG,
	UGlobals, UBase, UFileGlobals;



	Function ReadFormDefinition(filePath: String): TFormDesc;
	Procedure WriteFormDefinition(Stream: TFileStream; theForm: TFormDesc);
  function WriteGenericMacDefinitionHeader(Stream: TFileStream): Boolean; //Yakov special, eventaully remove

  //used to get formID info when building Forms Lib tree
	Function GetFileInfo(dirPath: String; theFile: TSearchRec): TFormIDInfo;

	
implementation

Uses
	UPage, UCell, UMacUtils, UFileUtils, UUtil1, UStatus, UStrings;


	// this routine reads the formInfoSection, vers 1
	function ReadFormInfoSection1(hFile: Integer; isMac: Boolean; var nextSectID: LongInt): TFormIDInfo;
	var
		amt: Integer;
		FormInfoRec: FormInfoSection1;
		FormInfoObj: TFormIDInfo;
	begin
		amt := SizeOf(FormInfoSection1);
		FileRead(hFile, FormInfoRec, amt);           // read

		if isMac then
			FormInfoRec := Mac2WinFORMInfo(FormInfoRec);      // convert mac to Win

		FormInfoObj := TFormIDInfo.create;            //create the tree object

		FormInfoObj.fFormIsMac :=  isMac;
		FormInfoObj.fFormUID := FormInfoRec.fFormUID;
		FormInfoObj.fFormVers := FormInfoRec.fFormVers;
		FormInfoObj.fFormPgCount := FormInfoRec.fFormPgCount;
		FormInfoObj.fFormFilePath := '';     //filePath gets set at run time
		FormInfoObj.fFormName := FormInfoRec.fFormName;
    FormInfoObj.fFormIndustryID := FormInfoRec.fFormIndustry;
		FormInfoObj.fFormIndustryName := FormInfoRec.fFormIndustryName;
    FormInfoObj.fFormCategoryID := FormInfoRec.fFormCategory;
		FormInfoObj.fFormCategoryName := FormInfoRec.fFormCategoryName;
    FormInfoObj.fFormKindID := FormInfoRec.fFormKind;
		FormInfoObj.fFormKindName := FormInfoRec.fFormKindName;
		FormInfoObj.fCreateDate := FormInfoRec.fCreateDate;
		FormInfoObj.fLastUpdate := FormInfoRec.fLastUpdate;
		FormInfoObj.fLockSeed := FormInfoRec.fLockSeed;
		FormInfoObj.fFormAtts := FormInfoRec.fFormFlags;
		FormInfoObj.fFormIndustryCode[1] := FormInfoRec.fFormIndustryCode1;
		FormInfoObj.fFormIndustryCode[2] := FormInfoRec.fFormIndustryCode2;

		result := FormInfoObj;                          //set the result

		nextSectID := FormInfoRec.fNextSectionID;       //tell them whats next
	end;

// Reads the forms spec section vers 1
	function ReadFormSpecSect1(hFile: Integer; isMac: Boolean; var nextSectID: LongInt): TFormSpec;
	var
		amt: Integer;
		FormSpecRec: FormSpecSection1;
		FormSpec: TFormSpec;
	begin
		amt := SizeOf(FormSpecSection1);
		FileRead(hFile, FormSpecRec, amt);           // read

		FormSpec := TFormSpec.create;                        // create the SpecObject

		FormSpec.fFormUID := ConvertLong(FormSpecRec.fFormUID, isMac);								 {unique form identifer}
		FormSpec.fFormVers := ConvertLong(FormSpecRec.fFormVers, isMac);							 {revision no. of this form}
    FormSpec.fFormName := FormSpecRec.fFormFileName;
		FormSpec.fFormWidth := cPageWidthLetter;			//### fix this, should be coming form def file
		FormSpec.fNumPages := ConvertLong(FormSpecRec.fNumPages, isMac);							 {number of pages in form includes c-addms}
		FormSpec.fFormFlags := ConvertBits(FormSpecRec.fFormFlags, isMac);						 {32 flags to indiccate what data is in file}

		nextSectID := ConvertLong(FormSpecRec.fNextSectionID, isMac);		 {version id of the page definition structure}
		result := FormSpec;                          //set the result
	end;

// routine to read multi version of the Form Info Section record of the file
	function ReadFormInfoSection(hFile: Integer; SectionID: Integer; var nextSectID: Integer; isMac: Boolean):TFormIDInfo;
	begin
		result := nil;
		case SectionID of
			cFormInfoSect1:
				begin
					result := ReadFormInfoSection1(hFile, isMac, nextSectID);
				end;
		end;
	end;

// this function reads the form specification and returns it
	function ReadFormSpecSection(hFile: Integer; SectionID: Integer; var nextSectID: Integer; isMac: Boolean):TFormSpec;
	begin
		result := nil;
		case SectionID of
			cFormSpecSect1:
				begin
					result := ReadFormSpecSect1(hFile, isMac, nextSectID);
				end;
		end;
	end;

	function ReadPageSpec(hFile: Integer; sectionID: Integer; isMac: Boolean): PageSpecSection;
	var
		amt: Integer;
		PgSpec: PageSpecSection;
	begin
		amt := SizeOf(PageSpecSection);
		FileRead(hFile, PgSpec, amt);           // read

		with PgSpec do
		begin
			PgID := ConvertLong(PgID, isMac);
			PgType := ConvertLong(PgType, isMac);
			PgFlags := ConvertBits(PgFlags, isMac);
			PgGoToOffset := ConvertLong(PgGoToOffset, isMac);
			PgHeight := ConvertLong(PgHeight, isMac);
			PgWidth := ConvertLong(PgWidth, isMac);
			fNextSectionID := ConvertLong(fNextSectionID, isMac);
			PgNumTextItems  := ConvertLong(PgNumTextItems, isMac);
			PgNumObjItems  := ConvertLong(PgNumObjItems, isMac);
			PgNumCellItems  := ConvertLong(PgNumCellItems, isMac);
			PgNumInfoItems  := ConvertLong(PgNumInfoItems, isMac);
			PgSeqCount  := ConvertLong(PgSeqCount, isMac);
			PgNumPicItems := ConvertLong(PgNumPicItems, isMac);
			PgNumGroupItems  := ConvertLong(PgNumGroupItems, isMac);
			PgNumTableItems := ConvertLong(PgNumTableItems, isMac);
			PgNumUserCntls := ConvertLong(PgNumUserCntls, isMac);
		end;

		result := PgSpec;
	end;

	procedure ReadPageText(hFile, ItemCount, sectionID: Integer; isMac: Boolean; const TextList: TList);
	var
		i, amt: Integer;
		fPgTxItem: PageTextRec;
		Str255: String[255];
		TextItem: TPgFormTextItem;
	begin
		if ItemCount > 0 then
		begin
			for i := 1 to ItemCount do
			begin
				amt := SizeOf(PageTextRec);
				FileRead(hFile, fPgTxItem, amt);           // read the item

				with fPgTxItem do
				begin
					FBox.Top := ConvertLong(FBox.Top, isMac);
					FBox.Left := ConvertLong(FBox.Left ,isMac);
					FBox.Right := ConvertLong(FBox.Right,isMac);
					FBox.Bottom := ConvertLong(FBox.Bottom,isMac);
					FontID:= ConvertLong(FontID,isMac);
					PrFSize:= ConvertLong(PrFSize,isMac);
					ScrFSize:= ConvertLong(ScrFSize,isMac);
					FJust:= ConvertLong(FJust,isMac);
					FDescent:= ConvertLong(FDescent,isMac);
					FType:= ConvertLong(FType,isMac);
					FStyle:= ConvertLong(FStyle,isMac);
					FStrLen:= ConvertLong(FStrLen,isMac);

          amt := FStrLen;
					FileRead(hFile, Str255, amt);           // read the text
        end;
        
				TextItem := TPgFormTextItem.Create;               // create the text item object
				with TextItem do                                 // load the info into the object
				begin
					StrBox := fPgTxItem.FBox;                        // it is followed by the objects text string
					StrFontID := fPgTxItem.FontID;
					StrPrFSize := fPgTxItem.PrFSize;
					StrScrFSize := fPgTxItem.ScrFSize;
					StrJust := fPgTxItem.FJust;
					StrDescent := fPgTxItem.FDescent;
					StrType := fPgTxItem.FType;
					StrStyle := fPgTxItem.FStyle;
					StrText := Str255;
				end;

				TextList.Add(TextItem); // add the item to the list
			end;
		end; //if count > 0
	end;

	procedure ReadPageCells(hFile, ItemCount, sectionID: Integer; isMac: Boolean; const cellList: TCellDescList);
	var
		i, amt: Integer;
		cellNameLen, defaultTxLen: integer;
		Str1, Str2: String[8];
		PgCell: PageCellRec;
		cellItem: TCellDesc;
	begin
		if ItemCount > 0 then
		begin
			for i := 1 to ItemCount do
			begin
				// 1. Read the record
				amt := SizeOf(PageCellRec);
				FileRead(hFile, PgCell, amt);           // read

				// 2. Convert to Windows
				with PgCell do                                  // first read the files cell record
				begin
					CRect.Top 		:= ConvertLong(CRect.Top, isMac);   //convert to PC format if necessary
					CRect.Left 		:= ConvertLong(CRect.Left ,isMac);
					CRect.Right 	:= ConvertLong(CRect.Right,isMac);
					CRect.Bottom 	:= ConvertLong(CRect.Bottom,isMac);

					CTypes		:= ConvertLong(CTypes,isMac);
					CFormat		:= ConvertBits(CFormat,isMac);
					CPref 		:= ConvertBits(CPref, isMac);
					CSize 		:= ConvertLong(CSize,isMac);
					CTxLines 	:= ConvertLong(CTxLines, isMac);
					CGroups 	:= ConvertLong(CGroups,isMac);
					CTables 	:= ConvertLong(CTables,isMac);
					CMathID		:= ConvertLong(CMathID,isMac);
					CContextID:= ConvertLong(CContextID,isMac);
          CLocalConTxID := ConvertLong(CLocalConTxID, isMac);
					CResponseID:= ConvertLong(CResponseID,isMac);
          CRspTable := ConvertLong(CRspTable, isMac);
					CCellID	:= ConvertLong(CCellID,isMac);
          CCellXID := ConvertLong(CCellXID, isMac);
					CLengths  := ConvertLong(CLengths, isMac);

					cellNameLen := HiWord(CLengths);        //lengths of strs for cell name & default text
					defaultTxLen := LoWord(CLengths);
				end;

				Str1 := '';
				Str2 := '';
				If cellNameLen > 0 then begin
					amt := cellNameLen+1;
					FileRead(hFile, Str1, amt);           // read the cell name
				end;
				If defaultTxLen > 0 then begin
					amt := defaultTxLen+1;
					FileRead(hFile, Str2, amt);           // read the default text
				end;

				// 3. Put it into an object
				CellItem := TCellDesc.Create;           // next put the info into an object
				with CellItem do
				begin
					CRect 		:= PgCell.CRect;
					CTypes 		:= PgCell.CTypes;
					CFormat 	:= PgCell.CFormat;
					CPref 		:= PgCell.CPref;
					CSize 		:= PgCell.CSize;
					CTxLines 	:= PgCell.CTxLines;
					CGroups 	:= PgCell.CGroups;
					CTables 	:= PgCell.CTables;
					CMathID 	:= PgCell.CMathID;
					CContextID := PgCell.CContextID;
          CLocalConTxID := PgCell.CLocalConTxID;
					CResponseID := PgCell.CResponseID;
          CRspTable := PgCell.CRspTable;
					CCellID 	:= PgCell.CCellID;
          CCellXID  := PgCell.CCellXID;
					CName			:= Str1;
					CDefaultTx:= Str2;
				end;
				CellList.Add(CellItem);          // add the cellItem to the List
      end;
    end;  //if count > 0
 end;

  procedure ReadPageObjs(hFile, ItemCount, sectionID: Integer; isMac: Boolean; const ObjList: TList);
	var
		i, amt: Integer;
		PgObj: PageObjectRec;
		ObjItem: TPgFormObjItem;
	begin
		if ItemCount > 0 then
		begin
			for i := 1 to ItemCount do
			begin
				amt := SizeOf(PageObjectRec);
				FileRead(hFile, PgObj, amt);           // read

				with PgObj do
				begin
					ORect.Top := ConvertLong(ORect.Top, isMac);
					ORect.Left := ConvertLong(ORect.Left ,isMac);
					ORect.Right := ConvertLong(ORect.Right,isMac);
					ORect.Bottom := ConvertLong(ORect.Bottom,isMac);

					OBounds.Top := ConvertLong(OBounds.Top, isMac);
					OBounds.Left := ConvertLong(OBounds.Left ,isMac);
					OBounds.Right := ConvertLong(OBounds.Right,isMac);
					OBounds.Bottom := ConvertLong(OBounds.Bottom,isMac);

					OType:= ConvertLong(OType,isMac);
					OStyle := ConvertLong(OStyle, isMac);
					OWidth:= ConvertLong(OWidth,isMac);
					OFill:= ConvertLong(OFill,isMac);
				end;

				ObjItem := TPgFormObjItem.Create;
        With ObjItem do
				begin
					ORect := PgObj.ORect;
					OBounds := PgObj.OBounds;
					OType := PgObj.OType;
					OStyle := PgObj.OStyle;
					OWidth := PgObj.OWidth;
					OFill := PgObj.OFill;
				end;

				ObjList.Add(ObjItem);       // add the item to the list
			end;
    end;  //if count > 0
  end;

  procedure ReadPageInfoItems(hFile, ItemCount, sectionID: Integer; isMac: Boolean; const InfoList: TList);
	var
		i, amt: Integer;
		InfoRec: PageInfoItemRec;     //structure in file
		InfoObj: TPgFormInfoItem;     //object in program (just a rec)
	begin
		if ItemCount > 0 then
		begin
			for i := 1 to ItemCount do
			begin
				amt := SizeOf(PageInfoItemRec);
				FileRead(hFile, InfoRec, amt);           // read the record

				with InfoRec do
				begin
					IType:= ConvertLong(IType,isMac);
					IRect.Top := ConvertLong(IRect.Top, isMac);
					IRect.Left := ConvertLong(IRect.Left ,isMac);
					IRect.Right := ConvertLong(IRect.Right,isMac);
					IRect.Bottom := ConvertLong(IRect.Bottom,isMac);
					IFill := ConvertLong(IFill, isMac);
					IJust:= ConvertLong(IJust,isMac);
					IHasPercent:= ConvertLong(IHasPercent,isMac);
					IIndex:= ConvertLong(IIndex,isMac);
				end;

				InfoObj := TPgFormInfoItem.Create;            	//put it into an object
				With InfoObj do
				begin
					IType := InfoRec.IType;
					IRect := InfoRec.IRect;
					IText := InfoRec.IText;
					IFill := InfoRec.IFill;
					IJust := InfoRec.IJust;
					IHasPercent := InfoRec.IHasPercent;
					IIndex := InfoRec.IIndex;
					IValue := 0;
				end;

				InfoList.Add(InfoObj);       // add the item to the list
			end;
		end;
  end;

	function ReadPageSeqs(hFile, ItemCount, sectionID: Integer; isMac: Boolean): pCellSeqList;
  var
    amt, i: Integer;
		SeqItem: TCellSeqRec;
    pSeqList: pCellSeqList;
  begin
		pSeqList := nil;
		if ItemCount > 0 then
		begin
			pSeqList := AllocMem(SizeOf(TCellSeqRec)* ItemCount);

			for i := 1 to ItemCount do
			begin
				amt := SizeOf(TCellSeqRec);
				FileRead(hFile, SeqItem, amt);           // read

				with SeqItem do
				begin
					SUp := ConvertLong(SUp ,isMac);
					SDown := ConvertLong(SDown,isMac);
					SLeft := ConvertLong(SLeft,isMac);
					SRight := ConvertLong(SRight, isMac);
					SNext := ConvertLong(SNext ,isMac);
					SPrev := ConvertLong(SPrev, isMac)
				end;

				pSeqList^[i-1] := SeqItem;      //index from zero
			end;
		end;  //if count > 0

		result := pSeqList;
  end;

	procedure ReadPageTables(hFile, ItemCount, sectionID: Integer; isMac: Boolean; const result: TTableList);
  var
		i,r,c,amt: Integer;
		numTables,TableSize: LongInt;
    pTable: pTableRec;
    CTable: TCellTable;
  begin
    //ItemCount is the same as numTables, just use numTables
		amt := SizeOf(LongInt);
		FileRead(hFile, numTables, amt);             //read number of tables
    numTables := ConvertLong(numTables ,isMac);

    if numTables > 0 then
      begin
        for i := 1 to numTables do
          begin
            amt := SizeOf(LongInt);                    //how big is the table
            FileRead(hFile, TableSize, amt);
            TableSize := ConvertLong(TableSize ,isMac);

				    pTable := AllocMem(TableSize);						 //get some memory
            try
              FileRead(hFile, pTable^, TableSize);     //read it

              CTable := TCellTable.Create;               //create Table Object
              with pTable^ do
                begin
                  CTable.FTyp := ConvertLong(Typ ,isMac);
                  CTable.FColID[1] := ConvertLong(ColID[1] ,isMac);
                  CTable.FColID[2] := ConvertLong(ColID[2] ,isMac);
                  CTable.FColID[3] := ConvertLong(ColID[3] ,isMac);
                  CTable.FNAdj[1] := ConvertLong(NetAdj[1] ,isMac);
                  CTable.FNAdj[2] := ConvertLong(NetAdj[2] ,isMac);
                  CTable.FNAdj[3] := ConvertLong(NetAdj[3] ,isMac);
                  CTable.FTAdj[1] := ConvertLong(TotAdj[1] ,isMac);
                  CTable.FTAdj[2] := ConvertLong(TotAdj[2] ,isMac);
                  CTable.FTAdj[3] := ConvertLong(TotAdj[3] ,isMac);

                  NRows := ConvertLong(NRows ,isMac);
                  NCols := ConvertLong(NCols ,isMac);
                  CTable.InitGrid(NRows, NCols);         //alloc space for grid
                  for r := 1 to NRows do
                    for c := 1 to NCols do
                      begin
                        CTable.Grid[r-1,c-1] := ConvertLong(Table[r,c] ,isMac);
                      end;
                end;
              result.Add(CTable);
            finally
              Freemem(pTable);
            end;
          end;
      end;
  end;

	//this reads a list of integer that make up group of cells. the groups are in table format
	//starting with column, row, and the items in the array. This repeats for every group.
	//the very first integer is the group count (ie number of groups).
	procedure ReadPageGroups(hFile, ItemCount, sectionID: Integer; isMac: Boolean; const PgGroup: TPageGroupList);
	type
		IntList = record
			Int : array[1..50] of Longint;
		end;
		pIntList = ^IntList;
	var
		i, count, numGps, amt: Integer;
		pInts: pIntList;
	begin
		if ItemCount > 0 then
			begin
				amt := SizeOf(Integer)* ItemCount;                //set the size
				pInts := AllocMem(amt);														//get some memory
				count:= FileRead(hFile, pInts^, amt);             //read it

				count := count div sizeOf(Integer);								//how many items are there
				with pInts^ do
					for i := 1 to count do
						Int[i] := ConvertLong(Int[i] ,isMac);         //convert to windows

				numGps := pInts^.Int[1];                         //first item has numGps
				PgGroup.FnumGps := numGps;
				SetLength(PgGroup.FItems, Count-1);              //create storage
				for i := 0 to count-2 do
					PgGroup.FItems[i] := pInts^.Int[i+2];          //move memory into dynamic array

				FreeMem(pInts);                                  // free the memory
			end
		else
	end;

	procedure ReadPagePics(hFile, ItemCount, sectionID: Integer; isMac: Boolean; const Glist: TList);
	var
		i, amt: Integer;
		PgGItem: PageGraphicItem;
		frmGrafic: TPgFormGraphic;
		imgPtr: PByte;
		memStream: TmemoryStream;
    LogoImage: TGraphic;
//		JPEGimage: TJPEGImage;
	begin
		if ItemCount > 0 then
		begin
			for i := 1 to ItemCount do
				begin
					//1. read the fixed record
					amt := SizeOf(PageGraphicItem);
					FileRead(hFile, PgGItem, amt);             //read graphic rec

					//2. convert to windows
					with PgGItem do
					begin
						GType := ConvertLong(GType ,isMac);
						GBounds.top := ConvertLong(GBounds.top ,isMac);
						GBounds.Left := ConvertLong(GBounds.left ,isMac);
						GBounds.right := ConvertLong(GBounds.right ,isMac);
						GBounds.bottom := ConvertLong(GBounds.bottom ,isMac);
						GSize := ConvertLong(GSize ,isMac);

					//3. convert to an object
						frmGrafic := TPgFormGraphic.Create;
						frmGrafic.GType := GType;
						frmGrafic.GBounds := GBounds;
						frmGrafic.GSize := GSize;
						frmGrafic.GImage := nil;

					//4. read the file image into the object
						if GSize > 0 then begin
							imgPtr := AllocMem(GSize);
							FileRead(hFile, imgPtr^, GSize);      //read graphic into memory

							memStream := TmemoryStream.Create;            //kludge so we can use ReadFromStream
              if GType = cJPEGLogo then
                LogoImage := TJPEGImage.create
              else
                LogoImage := TBitmap.Create;
							memStream.SetSize(GSize);
							memStream.WriteBuffer(imgPtr^, GSize);        //put JPEG into stream
							FreeMem(imgPtr);															//free the first memory alloc

							memStream.seek(0,0);			 										//start at beginning
              LogoImage.LoadFromStream(memStream);
							memStream.Free;																//free the memory stream;

              frmGrafic.GImage := LogoImage;
            end;

          //5. Add the image to the image list
						Glist.Add(frmGrafic);                           //add graphic to the list
					end; //with
				end; //for i
		end;
	end;

(*
	UserCntlItem = packed record
		ucType: LongInt;
		ucRect: TRect;
		ucOnClick: LongInt;
		ucOnLoad: LongInt;
		ucTitle: String[31];
	end;
*)
	procedure ReadPageUserCntls(hFile, ItemCount, sectionID: Integer; isMac: Boolean; const result: TList);
	var
		i, amt: Integer;
		ucItem: UserCntlItem;
		ucCntl: TPgFormUserCntl;
	begin
		if ItemCount > 0 then
			begin
				for i := 1 to ItemCount do
					begin
						//1. read the fixed record
						amt := SizeOf(UserCntlItem);
						FileRead(hFile, ucItem, amt);      //read user cntl

						//2. convert to windows
						with ucItem do
						begin
							ucType := ConvertLong(ucType ,isMac);
							ucRect.top := ConvertLong(ucRect.top ,isMac);
							ucRect.Left := ConvertLong(ucRect.left ,isMac);
							ucRect.right := ConvertLong(ucRect.right ,isMac);
							ucRect.bottom := ConvertLong(ucRect.bottom ,isMac);
							ucOnClick := ConvertLong(ucOnClick ,isMac);
							ucOnLoad := ConvertLong(ucOnLoad ,isMac);

						//3. convert to an object
							ucCntl := TPgFormUserCntl.Create;
							ucCntl.UType := ucType;
							ucCntl.UBounds := ucRect;
							ucCntl.UClickCmd := ucOnClick;
							ucCntl.ULoadCmd := ucOnLoad;
							ucCntl.UCaption := ucCaption;

							result.Add(ucCntl);            //add user Cntl to the list
						end;
					end;
			end;
	end;

//  This is a temp fix to create grid cells until the form designer can do it
  procedure CreateGridCells(const Cells: TCellDescList; Tables: TTableList);
  var
    i,c,t: Integer;
  begin
    if (Cells <> nil) and (Tables <> nil) then
      for i := 0 to Cells.Count-1 do    //list is zero based
        begin
          c := i+1;         //the cell number in the table is 1 based
          for t := 0 to Tables.count-1 do
            if Tables[t].CellInTable(c) then
              if NumXChg(Cells[i].CTypes).HiWrd = cSingleLn then   //disregard others
                begin
                  NumXChg(Cells[i].CTypes).HiWrd := cGridCell;
                  {NumXChg(Cells[i].CTypes).LoWrd := 0; DOT NOT SET, needs to remain as originally designed}
                  break;
                end;
        end;
  end;

// Read FormDef is called by everyone who wants the actual file data
// THis is the guy that does the actula reading of the file
  Function ReadFormDefinition(filePath: String): TFormDesc;
  var
    hFile : Integer;
    amt, Pg, numPgs: LongInt;
    InfoSectID, nextSectID: Integer;
    isMac: Boolean;
    FileInfo: GenericIDHeader;
    FilePgSpec: PageSpecSection;

    FormInfo: TFormIDInfo;
    FormSpec: TFormSpec;
		FormDesc: TFormDesc;          //this is what ActFormsMgr wants

		PageDesc:  TPageDesc;         // this is each page
  begin
    FormDesc := nil;                                    // this is what we want

    hFile := FileOpen(filePath, fmOpenRead);
    if hFile > 0 then
    try
      try
			Amt := Sizeof(GenericIDHeader);
			FileRead(hFile, FileInfo, amt);           // read it

      with FileInfo do
        if (fFileOwner = cFileOwner) and (fFileType = cFORMType) then   // its ours and a form
        begin
          isMac := (fFileCPUOrigin = cFileCPUMAC);     // are we coming form mac

          InfoSectID := ConvertLong(fNextSectionID, isMac);

          FormInfo := ReadFormInfoSection(hFile, InfoSectID, nextSectID, isMac);        //new formInfo Obj
          FormSpec := ReadFormSpecSection(hFile, nextSectID, nextSectID, isMac);        //new FormSpec obj

          FormDesc :=  TFormDesc.Create;                    //create the Form Description obj
          With FormDesc do
          begin
						Info := FormInfo;                              // this is its info
            Info.fFormFilePath := filePath;                //remember where we are
						Specs := FormSpec;                             // this is its specs, dups some of info
						PgDefs := TPageDescList.Create;                // this is its list of pages
						PgDefs.Capacity := FormSpec.fNumPages;         // make some room to all the pages
					end;

          numPgs := FormSpec.fNumPages;
          for pg := 1 to numPgs do
          begin
						FilePgSpec := ReadPageSpec(hFile, nextSectID, isMac);              //get parameters for reading stuff

						PageDesc := TPageDesc.Create;
						With PageDesc do
            begin
              PgName:= FilePgSpec.PgName;                 //name of this page
              PgID := FilePgSpec.PgID;                    //unique ID of this if it has one
              PgType := FilePgSpec.PgType;                // typ eof page for quick reference
              PgFlags := FilePgSpec.PgFlags;              // quick way to tell the page attributes
              PgGoToOffset := FilePgSpec.PgGoToOffset;    // bookmark offset into the page
              PgGoToName := FilePgSpec.PgGoToName;        // name of the bookmark
              PgHeight := FilePgSpec.PgHeight;            // Height of the page
              PgWidth := FilePgSpec.PgWidth;              // Width of the page
              PgNumCells := FilePgSpec.PgNumCellItems;    // Number of data cells on this page

							ReadPageCells(hFile, FilePgSpec.PgNumCellItems, nextSectID, isMac, PgFormCells);
							ReadPageInfoItems(hFile, FilePgSpec.PgNumInfoItems, nextSectID, isMac, PgInfoItems);
							ReadPageText(hFile, FilePgSpec.PgNumTextItems, nextSectID, isMac, PgFormText);
							ReadPageObjs(hFile, FilePgSpec.PgNumObjItems, nextSectID, isMac, PgFormObjs);
							ReadPagePics(hFile, FilePgSpec.PgNumPicItems, nextSectID, isMac, PgFormPics);
              PgCellSeqCount := FilePgSpec.PgSeqCount;   //hack until we know mem size
							PgCellSeq := ReadPageSeqs(hFile, FilePgSpec.PgSeqCount ,nextSectID, isMac);
							ReadPageTables(hFile, FilePgSpec.PgNumTableItems, nextSectID, isMac, PgCellTables);
							ReadPageGroups(hFile, FilePgSpec.PgNumGroupItems, nextSectID, isMac, PgCellGroups);
							ReadPageUserCntls(hFile, FilePgSpec.PgNumUserCntls, nextSectID, isMac, PgFormCntls);

              //PreProcess PgTables to convert PgCells so we have TGridCells
              //Do this until the designer handles this for us.
              //These are just the cell definitions so we are changing the def
              //so when we create a cell, we create a TGridCell if its in a table.
              //TGridCells handle =,=1,=2 and even pre-process simple math

              CreateGridCells(PgFormCells, PgCellTables);
						end;

						FormDesc.PgDefs.Add(PageDesc);      //add page to forms page list
          end;
        end;
      except
        FreeAndNil(FormDesc);
      end;
    finally
      FileClose(hFile);
    end;

    result := FormDesc;     // pass form description back to caller
  end;


//****************************************************
//   Start of section for writing the Form Definition
//****************************************************

procedure WriteFormInfoSection(fStream: TFileStream; formInfo: TFormIDInfo; bMac: Boolean);
var
  fileSect: FormInfoSection1;
begin
  FillChar(fileSect,sizeof(fileSect),0);
  with fileSect do
    begin
      fFormUID := ConvertLong(formInfo.fFormUID,bMac);
      fFormPgCount := ConvertLong(formInfo.fFormPgCount,bMac);
      fFormVers := ConvertLong(formInfo.fFormVers, bMac);
      fFormName := Copy(formInfo.fFormName,1,sizeof(fFormName) - 1);
      fFormIndustry := ConvertLong(formInfo.fFormIndustryID, bMac);
      fFormCategory := ConvertLong(formInfo.fFormCategoryID, bMac);
      fFormKind := ConvertLong(formInfo.fFormKindID, bMac);
      fFormIndustryName := Copy(formInfo.fFormIndustryName,1,sizeof(fFormIndustryName) - 1);
      fFormCategoryName := Copy(formInfo.fFormCategoryName,1,sizeof(fFormCategoryName) - 1);
      fFormKindName := Copy(formInfo.fFormKindName,1,sizeof(fFormKindName) - 1);
      fFormIndustryCode1 := Copy(formInfo.fFormIndustryCode[1],1,sizeof(fFormIndustryCode1) - 1);
      fFormIndustryCode2 := Copy(formInfo.fFormIndustryCode[2],1,sizeof(fFormIndustryCode2) - 1);
      fCreateDate := Copy(formInfo.fCreateDate,1,sizeof(fCreateDate) - 1);
      fLastUpdate :=  Copy(formInfo.fLastUpdate,1,sizeof(fLastUpdate) - 1); //only designer chges date
      fLockSeed := ConvertLong(formInfo.fLockSeed,bMac);
      fFormFlags := ConvertBits(formInfo.fFormAtts,bMac);
      fNextSectionID := ConvertLong(cFormSpecSect1,bMac);
    end;

  fStream.WriteBuffer(fileSect, sizeof(fileSect));
end;

//YF05.16.01
procedure WriteFormSpecsSection(fStream: TFileStream; formSpec: TFormSpec; bMac: Boolean);
var
  fileSect: FormSpecSection1;
begin
  FillChar(fileSect,sizeof(fileSect),0);
  with fileSect do
    begin
      fFormUID := ConvertLong(formSpec.fFormUID,bMac);
      fFormVers := ConvertLong(formSpec.fFormVers,bMac);
      fNumPages := ConvertLong(formSpec.fNumPages,bMac);
      fFormFileName := Copy(formSpec.fFormName,1,sizeof(fFormfileName) - 1);
      fFormFlags := ConvertBits(formSpec.fFormFlags,bMac);
      fNextSectionID := ConvertLong(1,bMac);  //always 1
    end;
  fStream.WriteBuffer(fileSect,sizeof(fileSect));
end;

procedure WritePageSpec(fStream: TFileStream; pgDescr: TPageDesc; bMac: Boolean);
var
  fileSect: PageSpecSection;
begin
  FillChar(fileSect,sizeof(fileSect),0);
  with pgDescr do
    begin
      if PgFormCells <> nil then
          fileSect.PgNumCellItems := ConvertLong(PgFormCells.Count,bMac);
      if PgInfoItems <> nil then
        fileSect.PgNumInfoItems := ConvertLong(PgInfoItems.Count,bMac);
      if PgFormText <> nil then
        fileSect.PgNumTextItems := ConvertLong(PgFormText.Count,bMac);
      if PgFormObjs <> nil then
        fileSect.PgNumObjItems := ConvertLong(PgFormObjs.Count,bMac);
      if PgFormPics <> nil then
        fileSect.PgNumPicItems := ConvertLong(PgFormPics.Count,bMac);

      fileSect.PgSeqCount := ConvertLong(PgCellSeqCount, bMac);    //fileSect.PgNumCellItems; //the same as number of cells

      if PgCellTables <> nil then
        fileSect.PgNumTableItems := ConvertLong(PgCellTables.Count,bMac);
      if PgCellGroups <> nil then
        fileSect.PgNumGroupItems := ConvertLong(Length(PgCellGroups.FItems)
                                           + 1,bMac); //+ number of groups
      if PgFormCntls <> nil then
        fileSect.PgNumUserCntls := ConvertLong(PgFormCntls.Count,bMac);

      fileSect.PgName := Copy(PgName,1,sizeof(fileSect.PgName) - 1);
      fileSect.PgID := ConvertLong(PgID,bMac);
      fileSect.PgType := ConvertLong(PgType,bMac);
      fileSect.PgFlags := ConvertBits(PgFlags,bMac);
      fileSect.PgGoToOffset := ConvertLong(PgGoToOffset,bMac);
      fileSect.PgGoToName := Copy(PgGoToName,1, sizeof(fileSect.PgGoToName) - 1);
      fileSect.PgHeight := ConvertLong(PgHeight,bMac);
      fileSect.PgWidth := ConvertLong(PgWidth,bMac);
      filesect.fNextSectionID := 1;
    end;
  fStream.WriteBuffer(fileSect,sizeof(fileSect));
end;

procedure WritePageCells(fStream: TFileStream; pgDef: TPageDesc; bMac: BooleaN);
var
  clRec: PageCellRec;
  cell,nCells: Integer;
  nameLen,dfltTxtLen: Integer;
  nameStr,dfltTxtStr: String[8];
begin
  if pgDef.PgFormCells = nil then exit;

  nCells := pgDef.PgFormCells.Count;
  for cell := 0 to nCells - 1 do
  begin
    FillChar(clRec,sizeof(clRec),0);
    with pgDef.PgFormCells[cell] do
    begin
      clRec.CRect.Left := ConvertLong(CRect.Left,bMac);
      clRec.CRect.Top := ConvertLong(CRect.Top,bMac);
      clRec.CRect.Right := ConvertLong(CRect.Right,bMac);
      clRec.CRect.Bottom := ConvertLong(CRect.Bottom,bMac);
      clRec.CTypes := ConvertLong(CTypes,bMac);
      clRec.CFormat := ConvertBits(CFormat,bMac);
      clRec.CPref := ConvertBits(CPref,bMac);
      clRec.CSize := ConvertLong(CSize,bMac);
      clRec.CTxLines := ConvertLong(CTxLines,bMac);
      clRec.CGroups := ConvertLong(CGroups,bMac);
      clRec.CTables := ConvertLong(CTables,bMac);
      clRec.CMathID := ConvertLong(cMathID,bMac);
      clRec.CContextID := ConvertLong(CContextID,bMac);
      clRec.CLocalConTxID := ConvertLong(CLocalConTxID,bMac);
      clRec.CResponseID := ConvertLong(CResponseID,bMac);
      clRec.CRspTable :=  ConvertLong(CRspTable,bMac);
      clRec.CCellID := ConvertLong(CCellID,bMac);
      clRec.CCellXID := ConvertLong(CCellXID, bMac);
      nameLen := Length(CName);
      dfltTxtLen := Length(CDefaultTX);
      clRec.CLengths := ConvertLong(MAKELONG(dfltTxtLen,nameLen),bMac);
      fStream.WriteBuffer(clRec, sizeof(clRec));
      if nameLen > 0 then
        begin
          nameStr := Copy(CName,1,sizeof(nameStr) - 1);
          fStream.WriteBuffer(nameStr, Length(nameStr) +1);
        end;
      if dfltTxtLen > 0 then
        begin
          dfltTxtStr:= Copy(CDefaultTx,1,sizeof(dfltTxtStr) - 1);
          fStream.WriteBuffer(dfltTxtStr,Length(dfltTxtStr) + 1);
        end;
    end
  end;
end;

procedure  WritePageInfoItems(fStream: TFileStream; pgDef: TPageDesc; bMac: Boolean);
var
  infoRec: PageInfoItemRec;
  info, nInfos: Integer;
begin
  if pgDef.PgInfoItems = nil then exit;

  nInfos := pgDef.PgInfoItems.Count;
  for info := 0 to nInfos - 1 do
    with TPgFormInfoItem(pgDef.PgInfoItems[info]) do
    begin
      FillChar(infoRec,sizeof(infoRec),0);
      infoRec.IType := ConvertLong(IType,bMac);
      infoRec.IRect.Left := ConvertLong(IRect.Left,bMac);
      infoRec.IRect.Top := ConvertLong(IRect.Top,bMac);
      infoRec.IRect.Right := ConvertLong(IRect.Right,bMac);
      infoRec.IRect.Bottom := ConvertLong(IRect.Bottom,bMac);
      infoRec.IText := Copy(IText,1,sizeof(infoRec.IText) - 1);
      infoRec.IFill := ConvertLong(IFill,bMac);
      infoRec.IJust := ConvertLong(IJust,bMac);
      infoRec.IHasPercent := ConvertLong(IHasPercent,bMac);
      infoRec.IIndex := ConvertLong(IIndex,bMac);

      fStream.WriteBuffer(infoRec,sizeof(infoRec));
    end;
end;

procedure WritePageFormText(fStream: TFileStream; pgDef: TPageDesc; bMac: Boolean);
var
  txtRec: PageTextRec;
  rec, nRecs: Integer;
  txtLen: Integer;
  txtStr: String[255];
begin
  if pgDef.PgFormText = nil then exit;

  nRecs := pgDef.PgFormText.Count;
  for rec := 0 to nRecs - 1 do
    with TPgFormTextItem(PgDef.PgFormText[rec]) do
      begin
        FillChar(txtRec,sizeof(txtRec),0);
        txtRec.FBox.Left := ConvertLong(StrBox.Left,bMac);
        txtRec.FBox.Top := ConvertLong(StrBox.Top,bMac);
        txtRec.FBox.Right := ConvertLong(StrBox.Right,bMac);
        txtRec.FBox.Bottom := ConvertLong(StrBox.Bottom,bMac);
        txtRec.FontID := ConvertLong(StrFontID,bMac);
        txtRec.PrFSize := ConvertLong(StrPrFSize,bMac);
        txtRec.ScrFSize := ConvertLong(StrScrFSize,bMac);
        txtRec.FJust := ConvertLong(StrJust,bMac);
        txtRec.FDescent := ConvertLong(StrDescent,bMac);
        txtRec.FType := ConvertLong(StrType,bMac);
        txtRec.FStyle := ConvertLong(StrStyle,bMac);

        txtLen := Length(StrText);
        txtRec.FStrLen := ConvertLong(txtLen + 1,bMac); //This is how it works now YF
        fStream.WriteBuffer(txtRec, sizeof(txtRec));

        if txtLen > 0 then
          begin
            txtStr := Copy(StrText,1,sizeof(txtStr) - 1);
            fStream.WriteBuffer(txtStr,Length(txtStr) + 1);
          end;
      end;
end;

  procedure WritePageObjs(fStream: TFileStream; pgDef: TPageDesc; bMac: Boolean);
var
  objRec: PageObjectRec;
  obj, nObjs: Integer;
begin
  if pgDef.PgFormObjs = nil then exit;
  
  nObjs := pgDef.PgFormObjs.Count;
  for obj := 0 to nObjs - 1 do
    with TPgFormObjItem(pgDef.PgFormObjs[obj]) do
      begin
        FillChar(objRec,sizeof(objRec),0);
        objRec.ORect.Left := ConvertLong(ORect.Left,bMac);
        objRec.ORect.Top := ConvertLong(ORect.Top,bMac);
        objRec.ORect.Right := ConvertLong(ORect.Right,bMac);
        objRec.ORect.Bottom := ConvertLong(ORect.Bottom,bMac);
        objRec.OBounds.Left := ConvertLong(OBounds.Left,bMac);
        objRec.OBounds.Top := ConvertLong(OBounds.Top,bMac);
        objRec.OBounds.Right := ConvertLong(OBounds.Right,bMac);
        objRec.OBounds.Bottom := ConvertLong(OBounds.Bottom,bMac);
        objRec.OType := ConvertLong(OType,bMac);
        objRec.OStyle := ConvertLong(OStyle,bMac);
        objRec.OWidth := ConvertLong(OWidth,bMac);
        objRec.OFill := ConvertLong(OFill,bMac);

        fStream.WriteBuffer(objRec, sizeof(objRec));
      end;
end;

procedure WritePagePics(fStream: TFileStream; pgDef: TPageDesc; bMac: Boolean);
var
  picRec: PageGraphicItem;
  pic, nPics: Integer;
  memStream: TMemoryStream;
  picSize: LongInt;
begin
  if pgDef.PgFormPics = nil then exit;
  
  nPics := pgDef.PgFormPics.Count;
  for pic := 0 to nPics - 1 do
    with TPgFormGraphic(pgDef.PgFormPics[pic]) do
      begin
    //1. Setup the rec to write the data
        FillChar(picRec,sizeof(picrec),0);
        picRec.GType := ConvertLong(GType,bMac);
        picRec.GBounds.Left := ConvertLong(GBounds.Left, bMac);
        picRec.GBounds.Top := ConvertLong(GBounds.Top, bMac);
        picRec.GBounds.Right := ConvertLong(GBounds.Right, bMac);
        picRec.GBounds.Bottom := ConvertLong(GBounds.Bottom, bMac);

    //2. write the image to a stream, so we get its size
    //   The size can change by 2 bytes due to 4-byte boundry on Win and 2-byte boundry on Mac
        memStream := TMemoryStream.Create;
    //quick fix ####
        try
          if picRec.GSize > 0 then
            if GType = cJPEGLogo then
              TJPEGImage(GImage).SaveToStream(memStream)
            else
              TBitmap(GImage).SaveToStream(memStream);
            
     //1.b finish with header fields
          picSize := memStream.Size;
          picRec.GSize := ConvertLong(picSize, bMac);

     //3. Write the graphic rec header
          fStream.WriteBuffer(picRec,sizeof(picRec));

     //4. Write the image data to the file stream
          memStream.SaveToStream(fStream);

        finally
          memStream.Free;
        end;
      end;
end;

procedure WritePageSeqs(fStream: TFileStream; pgDef: TPageDesc; bMac: Boolean);
var
  seqRec: TCellSeqRec;
  seq: Integer;
begin
  //CellSeqList is array of 500 items. We do not know how many of them
  //are really allocated. We have to use the number of cells

  for seq := 0 to pgDef.PgCellSeqCount - 1 do
    with pgDef.PgCellSeq[seq] do
      begin
        FillChar(seqRec,sizeof(seqRec),0);
        seqRec.SUp := ConvertLong(SUp,bMac);
        seqRec.SDown := ConvertLong(SDown,bMac);
        seqRec.SLeft := ConvertLong(SLeft,bMac);
        seqRec.SRight := ConvertLong(SRight,bMac);
        seqRec.SNext := ConvertLong(SNext,bMac);
        seqRec.SPrev := ConvertLong(SPrev,bMac);
        fStream.WriteBuffer(seqRec, sizeof(seqRec));
      end;
end;

procedure WritePageTables(fStream: TFileStream; pgDef: TPageDesc; bMac: Boolean);
var
  i,r,c,N: Integer;
  Value, numTables,TableSize: LongInt;
  memStream: TMemoryStream;
  TableHead: TableHeadRec;
begin
  if pgDef.PgCellTables = nil then
    begin
      numTables := 0;
      fStream.WriteBuffer(numTables,sizeof(numTables));
    end
  else //we have some tables to save
    begin
      numTables := ConvertLong(pgDef.PgCellTables.Count, bMac);
      fStream.WriteBuffer(numTables,sizeof(LongInt));

      N := pgDef.PgCellTables.Count-1;
      for i := 0 to N do
        with TCellTable(pgDef.PgCellTables[i]) do
          begin
            //Write the table size
            TableSize := (SizeOf(LongInt) * (FRows * FCols)) + SizeOf(TableHeadRec);
            TableSize := ConvertLong(TableSize, bMac);
            fStream.WriteBuffer(TableSize, sizeof(LongInt));

            //setup a table header for easy write
            TableHead.Typ       := ConvertLong(FTyp, bMac);
            TableHead.ColID[1]  := ConvertLong(FColID[1], bMac);
            TableHead.ColID[2]  := ConvertLong(FColID[2], bMac);
            TableHead.ColID[3]  := ConvertLong(FColID[3], bMac);
            TableHead.NetAdj[1] := ConvertLong(FNAdj[1], bMac);
            TableHead.NetAdj[2] := ConvertLong(FNAdj[2], bMac);
            TableHead.NetAdj[3] := ConvertLong(FNAdj[3], bMac);
            TableHead.TotAdj[1] := ConvertLong(FTAdj[1], bMac);
            TableHead.TotAdj[2] := ConvertLong(FTAdj[2], bMac);
            TableHead.TotAdj[3] := ConvertLong(FTAdj[3], bMac);
            TableHead.NRows     := ConvertLong(FRows, bMac);
            TableHead.NCols     := ConvertLong(FCols, bMac);

            //put into memStream for easy write to file
            memStream := TMemoryStream.Create;
            try
              memStream.WriteBuffer(TableHead, SizeOf(TableHeadRec));
              //write the table elements
              for r := 0 to FRows-1 do
                for c := 0 to FCols-1 do
                  begin
                    value := ConvertLong(Grid[r,c], bMac);
                    memStream.WriteBuffer(value, SizeOf(LongInt));
                  end;
              memStream.SaveToStream(fStream);
            finally
              memStream.Free;
            end;
          end;
    end;
end;

procedure WritePageGroups(fStream: TFileStream; pgDef: TPageDesc; bMac:Boolean);
var
  memStream: TMemoryStream;
  dataLen: Integer;
  item: Integer;
  curNumber: Integer;
begin
  if pgDef.PgCellGroups = nil then exit;              //if none exit

  dataLen := Length(pgDef.PgCellGroups.FItems);
  if dataLen = 0 then exit;

  memStream := TMemoryStream.Create;
  try
    curNumber := ConvertLong(pgDef.PgCellGroups.FNumGps,bMac);
    memStream.Write(curNumber,sizeof(curNumber));

    for item := 0 to dataLen - 1 do
    begin
      curNumber := ConvertLong(pgDef.PgCellGroups.FItems[item],bMac);
      memStream.Write(curNumber,sizeof(curNumber));
    end;
    memStream.SaveToStream(fStream);
  finally
    memStream.Free;
  end;
end;

procedure WritePageUserCntls(fStream: TFileStream; pgDef: TPageDesc; bMac: Boolean);
var
  cntlRec: UserCntlItem;
  cntl,nCntls: Integer;
begin
  if pgDef.PgFormCntls = nil then exit;    //opt out early

  nCntls := pgDef.PgFormCntls.Count;
  for cntl := 0 to nCntls -1 do
  with TPgFormUserCntl(pgDef.PgFormCntls[cntl]) do
  begin
    FillChar(cntlRec,sizeof(cntlRec),0);
    cntlRec.ucType := ConvertLong(UType,bMac);
    cntlRec.ucRect.Left := ConvertLong(UBounds.Left,bMac);
    cntlRec.ucRect.Top := ConvertLong(UBounds.Top,bMac);
    cntlRec.ucRect.Right := ConvertLong(UBounds.Right,bMac);
    cntlRec.ucRect.Bottom := ConvertLong(UBounds.Bottom,bMac);
    cntlRec.ucOnClick := ConvertLong(UClickCmd,bMac);
    cntlRec.ucOnLoad := ConvertLong(ULoadCmd,bMac);
    cntlRec.ucCaption := Copy(UCaption,1,sizeof(cntlRec.ucCaption) - 1);
  end;
  fStream.Write(cntlRec,sizeof(cntlRec));
end;


Procedure WriteFormDefinition(Stream: TFileStream; theForm: TFormDesc);
var
  page, nPgs: Integer;
  isMac: Boolean;
begin
  isMac := True; //### for now

//  WriteGenericIDHeader(Stream, cFORMFile);    //writing a Form definition file
  WriteGenericMacDefinitionHeader(Stream);
  WriteFormInfoSection(Stream,theForm.Info,isMac);
  WriteFormSpecsSection(Stream,theForm.Specs,isMac);

  //write pages
  nPgs := theForm.Specs.fNumPages;
  for page := 0 to nPgs - 1 do
    with theForm.PgDefs[page] do
      begin
        WritePageSpec(Stream,theForm.PgDefs[page],isMac);
        WritePageCells(Stream,theForm.PgDefs[page],isMac);
        WritePageInfoItems(Stream,theForm.PgDefs[page],isMac);
        WritePageFormText(Stream,theForm.PgDefs[page],isMac);
        WritePageObjs(Stream,theForm.PgDefs[page],isMac);
        WritePagePics(Stream,theForm.Pgdefs[page],isMac);
        WritePageSeqs(Stream,theForm.PgDefs[page],isMac);
        WritePageTables(Stream,theForm.PgDefs[page],isMac);
        WritePageGroups(Stream,theForm.PgDefs[page],isMac);
        WritePageUserCntls(Stream,theForm.PgDefs[page],isMac);
      end;
end;



//GetFileInfo is used to get the info on a form. It is called when building the Library Tree
Function GetFileInfo(dirPath: String; theFile: TSearchRec): TFormIDInfo;
var
  hFile : Integer;
  theFilePath: String;
  count, nextSectID, InfoSectID: Integer;
  FileID: GenericIDHeader;
  NodeInfo: TFormIDInfo;
  isMac: Boolean;
begin
//if (theFile.Attr and Not (faDirectory or faHidden or faSysFile or faVolumeID or faArchive) > 0) then
  result := nil;        // init the result;
  InfoSectID := 0;
  if not (theFile.attr and faDirectory > 0) then        // no directories here, ### hande the other file types
    begin
      theFilePath := dirPath + '\' + theFile.Name;
      hFile := FileOpen(theFilePath, fmOpenRead);
      if hFile > 0 then
      begin
        count := Sizeof(GenericIDHeader);
        FileRead(hFile, FileID, count);      // read the generic header

        with FileID do
          if(fFileOwner = cFileOwner) then
          begin
            isMac := (fFileCPUOrigin = cFileCPUMAC);     // are we coming form mac

            if isMac then
              InfoSectID := Mac2WinLong(fNextSectionID);

            if fFileType = cFORMType then          // this is a standard FORM
              begin
                NodeInfo := ReadFormInfoSection(hFile, InfoSectID, nextSectID, isMac);   // read the info from rec version 1
                NodeInfo.fFormFilePath := theFilePath;          // remember where it is
                result := NodeInfo;
              end
            else if FileID.fFileType = cDATAType then      // this is a User created DATA file
              begin
              end;
          end;  //its one of ours

        FileClose(hFile);
      end;   // file was opened ok, we're done
    end;
end;

//Special since Yakov wrote def file for isMac=true
function WriteGenericMacDefinitionHeader(Stream: TFileStream):Boolean;
var
	GH: GenericIDHeader;
	i, amt: LongInt;
begin
	GH.fFileOwner := cFileOwner;
	GH.fFileCPUOrigin := cFileCPUMac;
  GH.fFileType := cFORMType;
  GH.fFileVers := cFORMCurVers;
	GH.fNextSectionID := ConvertLong(cFormInfoSect1,true);

	for i := 1 to 20 do
		GH.ExtraSpace[i] := 0;

	amt := SizeOf(GenericIDHeader);
	stream.WriteBuffer(GH, amt);

	result := true;
end;


end.

