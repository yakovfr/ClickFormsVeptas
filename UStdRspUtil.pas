unit UStdRspUtil;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the unit that handles the reponses. It works in conjunction }
{ with UEditor to display and update reponses. It also loads/saves    }
{ the response files for each form.                                   }
{ There are two types of standard responses: Responses which are single}
{ words and multi sentence responses which we call standard comments. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

Uses
	Windows, Classes, Messages, Menus, Math, Stdctrls, forms, Contnrs,
	UGlobals, UBase, UCell;

Type


	TRspListBox = class(TListBox)
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  end;

//Class used for the global responses
	TResponse = class(TObject)
		RspID: Integer;
		FRsps: String;
		procedure SetRsps(Rsps:String);
		function GetRsps: String;
		procedure LoadResponses(stream: TFileStream);
		procedure SaveResponses(stream: TFileStream);
		property RspItems: string read GetRsps write SetRsps;
	end;

//Class used by editor for handling a single response list
//This is the middle guy for handing global and form specific rsps
	TRspHelper = class(TObject)
		FRspID: Integer;            //globalID
		FRspCUID: CellUID;          //or specific to a form
		FRsps: String;
		FRspOwner: TObject;
		FRspChged: Boolean;
    FRspCount: Integer;
    FRspIndex: Integer;        //when cycling, keeps track of last index
		constructor Create;
		procedure SetRsps(Rsps:String);
		procedure SetUpdatedRsps(Rsps:String);
		function GetRsps: String;
    function GetRspCount: Integer;
		function GetRspItem(index: Integer):String;
		procedure SaveItems;
		procedure AddRspItem(Rsp: String);
    procedure AddRspItems(srcHelper: TRspHelper);
    function HasResponses: Boolean;
    function CycleResponses: Integer;
    function FindFirstMatch(matchStr: String): Integer;
		procedure BuildPopupRspMenu(const Menu: TPopupMenu);
		function BuildStdRspListBox(AOwner: TComponent): TListBox;
 		property Modified: Boolean read FRspChged write FRspChged;
		property Owner: TObject read FRspOwner write FRspOwner;
		property Items: string read GetRsps write SetRsps;
    property ItemCount: Integer read FRspCount write FRspCount;
		property UpdateItems: string write SetUpdatedRsps;
	end;

//Class used to hold list of all Global RESPONSES
	TRspList = class(TObject)
	private
		FRspList: Array of TResponse;
		FModified: Boolean;
	public
		destructor Destroy; override;
		procedure LoadFromStream(stream: TFileStream);
		procedure SaveToStream(stream: TFileStream);
		procedure LoadRspHelper(RspID: Integer; RspHelper: TRspHelper);
    function GetResponse(RspID: Integer): TResponse;
    procedure AddResponse(RspID: Integer; RspItems: String);
		procedure UpdateRspItems(RspID: Integer; RspItems: String);
		procedure UpdateRspItems2(RspID: Integer; var RspItems: String);
    function GetCount: Integer;
    procedure Clear;
		property Modified: Boolean read FModified write FModified;
	end;


//object used to hold one comment, plus read/write to file
	TComment = class(TObject)
		FText: String;
		procedure LoadComment(stream: TFileStream);     //not used anymore
		procedure SaveComment(stream: TFileStream);     //not used anymore
	end;

{ Class used to hold list of global COMMENTS           }
{ This the original object used to hold the comments   }
	TCommentList = class(TObject)
		FCmtList: TStringList;
		FModified: Boolean;
		constructor Create;
		destructor Destroy; override;
		procedure LoadFromStream(stream: TFileStream); virtual;
		procedure SaveToStream(stream: TFileStream); virtual;
		procedure BulidPopupCommentMenu(Menu: TPopupMenu);
    function BuildCommenmtListBox(AOwner: TComponent): TListBox;
		function GetFirstLine(index: Integer): String;
		function GetComment(Index: Integer): String;
		property Modified: Boolean read FModified write FModified;
	end;

{ Refine the TCommentList object so we can group comments by an ID}
  TCommentGroup = class(TCommentList)
    FRspGroupID: Integer;
//    constructor Create; overload;
    constructor Create(GroupID: Integer); overload;
		procedure LoadFromStream(stream: TFileStream);  override;
		procedure SaveToStream(stream: TFileStream); override;
  end;

{ Holds a list of comments groups. This is a global like the Global Responses}
  TCommentGroups = class(TObjectList)
  private
    FModified: Boolean;
  protected
    function GetGroup(Index: Integer): TCommentGroup;
    procedure SetGroup(Index: Integer; const Value: TCommentGroup);
  public
    constructor Create;
		procedure LoadFromStream(stream: TFileStream);
		procedure SaveToStream(stream: TFileStream);
    procedure LoadAndConvertFromVersion1(Stream: TFileStream);
    property Group[Index: Integer]: TCommentGroup read GetGroup write SetGroup; default;
    property Modified: Boolean read FModified write FModified;
  end;


//General Purpose Response Routines
	procedure CheckForResponseFiles;
	procedure CreateGlobalResponseFile(fPath: String);
	procedure LoadGlobalResponses;
	procedure SaveGlobalResponses;

	procedure CreateGlobalCommentFile(fPath: String);
	procedure LoadGlobalComments;
	procedure SaveGlobalComments;

	procedure CreateFormResponseFile(formDesc: TFormDesc);
	procedure LoadFormResponses(formDesc: TFormDesc);         //called from ActiveFormsMgr.
	procedure SaveFormResponses(formDesc: TFormDesc);         //''


	function CreateRspHelper(RspID: Integer; cUID: CellUID): TRspHelper;
	function CountRspItems(S: String): Integer;

//	procedure BuildTestComments;


Var
	AppResponses: TRspList;
  AppComments: TCommentGroups;


implementation

uses
	SysUtils,FileCtrl,
	UFileGlobals, UFileUtils, UUtil1, UActiveForms, UStrings, UStatus,
  UFileFinder, UContainer;


const
  cStdRspFileVersion = 1;
  cStdCmtFileVersion = 2;
	cStdRspfName = 'CommonRsps.rsp';
	cStdCmtfName = 'CommonCmts.rsp';

	cTypeRsp 		= 1;         //global responses identified by an ID
	cTypeCmt 		= 2;         //global comment group identified by an ID
	cTypeFmRsp 	= 3;         //form specific response identified by cell numnber in form

type
	fRspRec = record            //used to store responses in a file
		RspID: Integer;
		RspsLen: Integer;
	end;

//make sure files are there, if not create empty ones
procedure CheckForResponseFiles;
var
	fPath: String;
begin
	fPath := IncludeTrailingPathDelimiter(appPref_DirResponses) + cStdRspfName;    //std responses
	if not FileIsValid(fPath) then                  //is the file there?
		CreateGlobalResponseFile(fPath);              //if not create empty one

	fPath := IncludeTrailingPathDelimiter(appPref_DirResponses) + cStdCmtfName;    //std comments
	if not FileIsValid(fPath) then                  //is the file there?
		CreateGlobalCommentFile(fPath);               //if not create empty one

//Form Specific Responses folder - OK to create an empty one
	if not VerifyFolder(appPref_DirFormRsps) then
		begin
			fPath := IncludeTrailingPathDelimiter(appPref_DirResponses) + dirFormRsps;
			ForceDirectories(fPath);                  //do it
			if VerifyFolder(fPath) then               //is it really there?
				appPref_DirFormRsps := fPath            //make sure to save it
			else
				appPref_DirFormRsps := '';
		end;
end;

procedure CreateGlobalResponseFile(fPath: String);
var
	stream: TFileStream;
	RSRec: RspSpecRec;
	amt: Integer;
begin
	if CreateNewFile(fPath, stream)then begin       //create file, open stream
		WriteGenericIDHeader(stream, cRSPSFile);

		RSRec.RecVers := 1;
		RsRec.RspType := cTypeRsp;
		RSRec.PgCount := 0;
		RSRec.Xtra1 := 0;
		RSRec.Xtra2 := 0;
		amt := SizeOf(RspSpecRec);
		stream.WriteBuffer(RSRec, amt);

		stream.Free;     //we are done writing, close & free
	end;
end;

//standardize the name of form Specific response files
function GetFormRspFName(N: LongInt): string;
begin
	result := 'F'+ SixDigitName(N) + '.rsp';
end;

//initializes a form specific response file
procedure InitPgRsps(var rspList: TStringList; N: Integer);
var
	i: integer;
begin
	rspList.Capacity := N;   //set the capcaity
	for i := 0 to N-1 do
		rspList.append('');    //set the empty value
//###		rspList.add('one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thriteen|');
end;

//based on FormDescription create an empty FormRspFile
procedure CreateFormResponseFile(formDesc: TFormDesc);
var
	fPath: String;
	stream: TFileStream;
	RSRec: RspSpecRec;
	rspList: TPageRspList;
	i,j, amt: Integer;
begin
	if formDesc <> nil then                          //make sure we have a form
		if VerifyFolder(appPref_DirFormRsps) then
			With formDesc do
				begin
					fPath := appPref_DirFormRsps + '\' + GetFormRspFName(Specs.fFormUID);
					if CreateNewFile(fPath, stream)then       			//create file, open stream
						begin
							WriteGenericIDHeader(stream, cRSPSFile);            //let everyone its a RSPS file

							RSRec.RecVers := 1;
							RsRec.RspType := cTypeFmRsp;
							RSRec.PgCount := Specs.fNumPages;       //formSpecific hold the num of pages here
							RSRec.Xtra1 := 0;
							RSRec.Xtra2 := 0;
							amt := SizeOf(RspSpecRec);
							stream.WriteBuffer(RSRec, amt);

							for i := 0 to Specs.fNumPages-1 do
								begin
									j := PgDefs[i].PgNumCells;          //do this even if zero

									rspList := TPageRspList.Create;
                  rspList.InitCapacity(J);
							//		InitPgRsps(rspList, j);            //create empty pg rsp list
									rspList.SaveToStream(stream);      //write out an empty string list of j size
									rspList.Free;
								end;

							stream.Free;                            //close the stream
						end;
				end;
end;

procedure LoadFormResponses(formDesc: TFormDesc);
var
	fPath: String;
	stream: TFileStream;
	RSRec: RspSpecRec;
	i,j, amt: Integer;
  version: Integer;
begin
	if formDesc <> nil then
		with formDesc do
		begin
			fPath := IncludeTrailingPathDelimiter(appPref_DirFormRsps) + GetFormRspFName(Specs.fFormUID);

			if FileIsValid(fPath) then                  				//is the file there now?
        begin //we have a response file, use it
          if OpenFileStream(fPath, stream) then           //open it
            begin
              if VerifyFileType3(stream, cRSPSType, version) then      // its our kind of file
                begin
                  amt := SizeOf(RspSpecRec);
                  Stream.Read(RSRec, amt);
                  if RSRec.RspType = cTypeFmRsp then					//its really a FORM Rsp file
                    if RSRec.PgCount > 0 then                 //make sure we have pages to read
                      for i := 0 to RSRec.PgCount-1 do        //count = numPages in this rec
                        PgDefs[i].PgRsps.LoadFromStream(stream);     //and one string per cell
                end;
              Stream.Free;			//close the stream
            end;
        end
      else  //no response file, create one in memory
        begin
          for i := 0 to Specs.fNumPages-1 do
            begin
              j := PgDefs[i].PgNumCells;          //do this even if zero
              PgDefs[i].PgRsps.InitCapacity(j);           //create empty pg rsp list
            end;
        end;
		end;
end;

procedure SaveFormResponses(formDesc: TFormDesc);
var
	fPath : String;
	stream: TFileStream;
	RSRec: RspSpecRec;
	i, amt: Integer;
begin
	if formDesc <> nil then
		with formDesc do
		begin
			fPath := IncludeTrailingPathDelimiter(appPref_DirFormRsps) + GetFormRspFName(Specs.fFormUID);

			if not FileIsValid(fPath) then                  //is the file there?
        CreateNewFile(fPath, stream)
      else
        OpenFileStream(fPath, stream);                //else open it

      try
        WriteGenericIDHeader(stream, cRSPSFile);      //let everyone know its a RSPS file

        RSRec.RecVers := 1;
        RsRec.RspType := cTypeFmRsp;
        RSRec.PgCount := Specs.fNumPages;       //formSpecific hold the num of pages here
        RSRec.Xtra1 := 0;
        RSRec.Xtra2 := 0;
        amt := SizeOf(RspSpecRec);
        stream.WriteBuffer(RSRec, amt);

        for i := 0 to Specs.fNumPages-1 do
          PgDefs[i].PgRsps.SaveToStream(stream);
      finally
        stream.Free;                            //close the stream
      end;
		end;
end;
(*
procedure BuildTestComments;
var
	cmtObj: TComment;
  cmtGroup: TCommentGroup;
	strList: TstringList;
  n: Integer;
begin
  for n := 1002 to 1005 do
    begin
      strList := TstringList.create;
      strList.Capacity := 3;

      cmtObj := TComment.Create;
      cmtObj.FText := 'This is one comment entry: '+ IntToStr(n);
      strList.AddObject('oneName', cmtObj);

      cmtObj := TComment.Create;
      cmtObj.FText := 'This the second comment entry.';
      strList.AddObject('twoName', cmtObj);

      cmtObj := TComment.Create;
      cmtObj.FText := 'This is the third comment entry.';
      strList.AddObject('threeName', cmtObj);

      cmtGroup := TCommentGroup.Create;
      cmtGroup.FRspGroupID := N;
      cmtGroup.FCmtList.Assign(strList);

      AppComments.Add(cmtGroup);
    end;
  AppComments.Modified := True;
end;
*)

procedure LoadGlobalResponses;
var
	fPath: String;
	stream: TFileStream;
  version: Integer;
begin
	AppResponses := TRspList.Create;

	fPath := IncludeTrailingPathDelimiter(appPref_DirResponses) + cStdRspfName;
	if FileIsValid(fPath) then                  				//is the file there?
		if OpenFileStream(fPath, stream) then             //open it
			begin
				if VerifyFileType3(stream, cRSPSType, version) then    //is it really a RSPS
					AppResponses.LoadFromStream(stream);        //read it

				stream.Free;                                  //close
			end;
end;

procedure SaveGlobalResponses;
var
	fPath, tmpfPath: String;
	stream: TFileStream;
  writeOK: Boolean;
begin
	if AppResponses.Modified then                    //we have something to save
		begin
			fPath := IncludeTrailingPathDelimiter(appPref_DirResponses) + cStdRspfName;
			if not FileIsValid(fPath) then                  //is the file still there?
				CreateGlobalResponseFile(fPath);              //if not create new empty one

      writeOK := True;
			tmpfPath := IncludeTrailingPathDelimiter(appPref_DirResponses) + GetFileTempName(cStdRspfName);
			if CreateNewFile(tmpfPath, stream)then			        //create tmp file, open stream
				try
          try
					  WriteGenericIDHeader(stream, cRSPSFile);
					  AppResponses.SaveToStream(stream);            //write new comments
            FreeAndNil(Stream);                           //close it
          except
            on e: Exception do
              begin
                ShowNotice('Could not save the changes to the Common Responses file. '+ E.Message);
                writeOk := False;
                if assigned(Stream) then FreeAndNil(Stream);    //close it
                DeleteFile(tmpfPath);                           //delete it
              end;
          end;
        finally
          if assigned(Stream) then FreeAndNil(Stream);    //close it
          if writeOK then begin
            DeleteFile(fPath);								       //delete the original file
            RenameFile(tmpfPath ,fPath);             //rename the tmp with old name
          end;
        end;
		end;
end;

procedure CreateGlobalCommentFile(fPath: String);
var
	stream: TFileStream;
	RSRec: RspSpecRec;
	amt: Integer;
begin
	if CreateNewFile(fPath, stream)then        //create file, open stream
    try
      WriteGenericIDHeader2(stream, cRSPSFile, cStdCmtFileVersion);

      RSRec.RecVers := 1;
      RsRec.RspType := cTypeCmt;
      RSRec.PgCount := 0;
      RSRec.Xtra1 := 0;
      RSRec.Xtra2 := 0;
      amt := SizeOf(RspSpecRec);
      stream.WriteBuffer(RSRec, amt);

      WriteLongToStream(0, Stream);           //number of comments = 0;
    finally
      stream.Free;     //we are done writing, close & free
    end;
end;

procedure LoadGlobalComments;
var
	fPath: String;
	stream: TFileStream;
  version: Integer;
begin
  AppComments := TCommentGroups.Create;
//  BuildTestComments;

	fPath := IncludeTrailingPathDelimiter(appPref_DirResponses) + cStdCmtfName;    //std responses
	if FileIsValid(fPath) then                  					//is the file there?
		if OpenFileStream(fPath, stream) then               //can we open it
			try
        if VerifyFileType(stream, cRSPSType, version) then
        case version of
          1:
            AppComments.LoadAndConvertFromVersion1(Stream);
          2:
            AppComments.LoadFromStream(stream);
        end;
      finally
				Stream.Free;
			end;
end;

procedure SaveGlobalComments;
var
	fPath, tmpfPath: String;
	stream: TFileStream;
  WriteOK: Boolean;
begin
	if AppComments.Modified then                    //we have something to save
		begin
			fPath := IncludeTrailingpathDelimiter(appPref_DirResponses) + cStdCmtfName;
			if not FileIsValid(fPath) then                 //is the file still there?
				CreateGlobalCommentFile(fPath);              //if not create new empty one

      WriteOK := True;
      tmpfPath := IncludeTrailingpathDelimiter(appPref_DirResponses) + GetFileTempName(cStdCmtfName);
			if CreateNewFile(tmpfPath, stream)then			   //create tmp file, open stream
        try
          try
            WriteGenericIDHeader2(stream, cRSPSFile, cStdCmtFileVersion);
            AppComments.SaveToStream(stream);
            FreeAndNil(Stream);
          except
            if assigned(Stream) then FreeAndNil(Stream);  //close file
            DeleteFile(tmpfPath);                         //delete it
            ShowNotice('There was a error saving the standard comments file.');
            WriteOK := False;
          end;
        finally
          if assigned(Stream) then FreeAndNil(Stream); //close the file
          if WriteOK then begin
            DeleteFile(fPath);								         //delete the old file
            RenameFile(tmpfPath ,fPath);      //rename the tmp with old name
          end;
        end;  //if we created a tmp file
		end;
end;

function CreateRspHelper(RspID: Integer; CUID: CellUID): TRspHelper;
var
	strList: TStringList;
begin
	result := TRspHelper.Create;            //always send something

  //Global response list
	if RspID > 0 then
		begin
			AppResponses.LoadRspHelper(rspID, result);  //now load it
		end
	else
  //Form specific response list
		begin
			strList := ActiveFormsMgr.GetFormPgRsps(cUID);   //list of rsps for this page (TStringList)
			if strList <> nil then
      begin
				result.Owner := TObject(strList);         //save list ref (owner) so we save new rsps back

				if CUID.Num < strList.count then          //each cell has a string in the list
					result.Items := strList[CUID.Num]       //the list for this cell to display
				else
					result.Items := '';                     //no items
				result.FRspCUID := cUID;                  //UID of the list
			end;
		end;
end;

function CountRspItems(S: String): Integer;
var
	i: Integer;
begin
	result := 0;
	for i := 1 to length(S) do
		if S[i] = '|' then inc(result);
end;



{ TResponse }

procedure TResponse.SetRsps(Rsps:String);
begin
	FRsps := Rsps;
end;

function TResponse.GetRsps: String;
begin
	result := FRsps;
end;

procedure TResponse.LoadResponses(stream: TFileStream);
var
	rspText: String;
	amt: LongInt;
	fRRec: fRspRec;
begin
	amt := SizeOf(fRspRec);
	stream.Read(fRRec, amt);       //rwead the our header

	RspID := fRRec.RspID;          //set our ID

	amt :=   fRRec.RspsLen;
	SetString(rspText, nil, amt);
	Stream.Read(Pointer(rspText)^, amt);     //read the text

	FRsps := rspText;               //set our responses
end;

procedure TResponse.SaveResponses(stream: TFileStream);
var
	rspText: String;
	amt: LongInt;
	fRRec: fRspRec;
begin
	fRRec.RspID := RspID;
	fRRec.RspsLen := length(FRsps);
	amt := SizeOf(fRspRec);
	stream.WriteBuffer(fRRec, amt);   //write the header ourselves

	amt := length(FRsps);
	rspText := FRsps;                //set in local so its a constant ???
	stream.WriteBuffer(Pointer(rspText)^, amt);    //write the response list
end;

{ TComment }

procedure TComment.LoadComment(stream: TFileStream);
var
	cmtText: String;
	amt: LongInt;
	CmtLength: Integer;
begin
	amt := SizeOf(Integer);
	stream.Read(CmtLength, amt);       //read the length of the comment text

	amt := CmtLength;
	SetString(cmtText, nil, amt);
	Stream.Read(Pointer(cmtText)^, amt);     //read the text

	FText := cmtText;               //set our comment
end;

procedure TComment.SaveComment(stream: TFileStream);
var
	cmtText: String;
	amt: LongInt;
	CmtLength: Integer;
begin
	CmtLength := Length(FText);
	amt := SizeOf(Integer);
	stream.WriteBuffer(CmtLength, amt);  //write the length of the comment text

	cmtText := FText;                   //set in local so its a constant ???
	stream.WriteBuffer(Pointer(cmtText)^, CmtLength);    //write the comment text
end;


{ TRspHelper }

constructor TRspHelper.Create;
begin
	FRsps := '';
	FRspID := 0;
	FRspCUID := NullUID;            //cell UID
	FRspChged := False;
  FRspOwner := nil;
  FRspCount := 0;
  FRspIndex := -1;
end;

procedure TRspHelper.BuildPopupRspMenu(const Menu: TPopupMenu);
var
	i: Integer;
	MI: TMenuItem;
begin
  Menu.AutoHotkeys := maManual;
	if length(FRsps) = 0 then
		begin
			MI := TMenuItem.Create(Menu);
			MI.caption := msgNoRspForCell;
			MI.tag := -1;
			Menu.items.add(MI);
		end
	else begin
		for i := 0 to FRspCount-1 do
			begin
				MI := TMenuItem.Create(Menu);
				MI.caption := GetRspItem(i);
				Menu.items.add(MI);
			end;
	end;
end;

function TRspHelper.BuildStdRspListBox(AOwner: TComponent): TListBox;
var
	i: Integer;
  doc: TContainer;
  width: Integer;
begin
  doc := TContainer(AOwner);
  try
    result := TRspListBox.Create(doc.docView);    //owner is DocView
    result.Visible := False;
    result.Parent := TScrollBox(doc.docView);
    result.Color := colorRespList;               //not changeable color
    result.AutoComplete := True;

    // load in the responses for this cell
    if length(FRsps) > 0 then
      begin
        for i := 0 to FRspCount-1 do
          result.items.add(GetRspItem(i));
        result.ItemIndex := 0;   //pre-select the first one
        result.IntegralHeight := True;
      end;

    // calculate listbox width
    result.Canvas.Font.Assign(result.Font);
    width := Screen.PixelsPerInch;
    for i := 0 to result.Items.Count - 1 do
      width := Max(width, result.Canvas.TextWidth(result.Items[i]));
    Result.Width := width + GetSystemMetrics(SM_CXVSCROLL) + 10;
  except
    result := nil;   //think this through
  end;
end;

function TRspHelper.CycleResponses: Integer;
begin
  FRspIndex := CycleForward(FRspIndex, 0, FRspCount-1);
  result := FRspIndex;
end;

function TRspHelper.FindFirstMatch(matchStr: String): Integer;
var
  n,i: Integer;
begin
  result := -1;
//  Z := CountRspItems(FRsps);
  n := 0;
  while (n < FRspCount) and (result = -1) do
    begin
      i := POS(UpperCase(TrimLeft(matchStr)), UpperCase(GetRspItem(n)));
      if (i = 1) then result := n;
      inc(n);
    end;
end;

function TRspHelper.HasResponses: Boolean;
begin
  result := Length(FRsps) > 0;
end;

function TRspHelper.GetRsps: String;
begin
	result := FRsps;
end;

function TRspHelper.GetRspCount: Integer;
begin
  FRspCount := CountRspItems(FRsps);
  Result := FRspCount;
end;

//index is zero based
function TRspHelper.GetRspItem(index: Integer): String;
var
	i, j, k, z, N: Integer;
	foundIt:Boolean;
begin
	result := '';
//	N := CountRspItems(FRsps);     //### this should be a FRspCount
  N := FRspCount;
	z := length(FRsps);
	if index < N then              //request is in range
		begin
			i := 0;     //match index
			j := 1;     //start char
			k := 1;     //end char
			foundIt := False;
			repeat
				while ((FRsps[k] <> '|') and (k < z)) do inc(k);     //count but no run away
				if i <> index then
					begin
						inc(k);    //skip to start of next word
						j := k;    //"
						inc(i);
					end
				else FoundIt := true;
			until FoundIt or (i = N);

			if FoundIt then
				result := TrimLeft(Copy(FRsps, j, k-j));
		end;
end;

// Transfers a cell response list from editor to
// page list of responses in memory
procedure TRspHelper.SaveItems;
begin
	if FRspID > 0 then
		begin
			AppResponses.UpdateRspItems(FRspID, Items);
		end
	else
		begin
//			TStringList(Owner)[FRspCUID.Num] := FRsps;
      TPageRspList(Owner).UpdateCellRspList(FRspCUID.Num, FRsps);
		end;
  FRspChged := False;
end;

procedure TRspHelper.AddRspItem(Rsp: String);
begin
	if length(Rsp) > 0 then
		begin
      if (length(FRsps) > 0) and (FRsps[length(FRsps)] <> '|') then   //sometimes FRSPS does not have a terminal pipe
        FRsps := FRsps + '|';
			FRsps := FRsps + Rsp + '|';
			FRspChged := True;
      Inc(FRspCount);
		end;
end;

procedure TRspHelper.AddRspItems(srcHelper: TRspHelper);
var
  itm,nItms: Integer;
begin
  if not srcHelper.HasResponses then
    exit;
  if  not HasResponses then
    SetRsps(srcHelper.GetRsps)
  else
    begin
      nItms := srcHelper.GetRspCount;
      for itm := 0 to nItms -1 do
        if FindFirstMatch(srcHelper.GetRspItem(itm)) < 0 then
          AddRspItem(srcHelper.GetRspItem(itm));
    end;
end;

procedure TRspHelper.SetRsps(Rsps: String);
begin
	FRsps := Rsps;
  FRspCount := CountRspItems(Rsps);
end;

procedure TRspHelper.SetUpdatedRsps(Rsps: String);
begin
	FRspChged := True;
	SetRsps(Rsps);
end;


{ TRspList }

destructor TRspList.Destroy;
var
	i, N: Integer;
begin
	N := Length(FRspList);
	for i := 0 to N-1 do                  //for all the responses
		if Assigned(FRspList[i]) then       //if its not nil
			FRspList[i].Free;                 //free TResponse

	inherited Destroy;
end;

procedure TRspList.LoadFromStream(stream: TFileStream);
var
	RSRec: RspSpecRec;
	i, amt: Integer;
begin
	amt := SizeOf(RspSpecRec);
	Stream.Read(RSRec, amt);
	if RSRec.RspType = cTypeRsp then			//its really a Rsp file
		if RSRec.PgCount > 0 then             //and there is something to read
			begin
				SetLength(FRspList,RSRec.PgCount);       //get ready to receive responses
				for i := 0 to RSRec.PgCount-1 do
					begin
						FRspList[i] := TResponse.Create;
						FRspList[i].LoadResponses(stream);
					end;

				FModified := False;
			end;
end;

procedure TRspList.LoadRspHelper(RspID: Integer; RspHelper: TRspHelper);
var
	i, count: Integer;
	foundIt: Boolean;
begin
	if (RspID > 0) and (RspHelper <> nil) then      //no bogus data
		begin
			RspHelper.Owner := nil;                     //in case we don't find anything
			RspHelper.Items := '';
			RspHelper.FRspID := RspID;

			count := Length(FRspList);
			if count > 0 then                           //make sure we have stuff
				begin
					foundIt := False;
					i := 0;
					while not FoundIt and (i < count) do begin
						foundIt := FRspList[i].RspID = RspID;
						inc(i);
					end;
					if foundIt then
						begin
							RspHelper.Owner := TObject(FRspList[i-1]);         	//set list owner so we put things back
							RspHelper.Items := FRspList[i-1].RspItems;        	//the list to display
							RspHelper.FRspID := RspID;                  				//UID of the list
						end;
				end;
		end;
end;

//used to see if the RspID is in the global list
function TRspList.GetResponse(RspID: Integer): TResponse;
var
	i, count: Integer;
	foundIt: Boolean;
begin
  result := nil;
  count := Length(FRspList);
  if count > 0 then                           //make sure we have stuff
    begin
      foundIt := False;
      i := 0;
      while not FoundIt and (i < count) do begin
        foundIt := FRspList[i].RspID = RspID;
        inc(i);
      end;

      if foundIt then
        result := TResponse(FRspList[i-1]);
    end;
end;

procedure TRspList.AddResponse(RspID: Integer; RspItems: String);
var
  count: Integer;
begin
  count := length(FRspList);
  SetLength(FRspList, count+1);           //increase capacity by 1

  FRspList[count] := TResponse.Create;    //new rsp object
  FRspList[count].RspID := RspID;
  FRspList[count].RspItems := RspItems;

  FModified := True;			                //we've changed
end;

procedure TRspList.SaveToStream(stream: TFileStream);
var
	i, numRsps: Integer;
	RSRec: RspSpecRec;
	amt: LongInt;
begin
	numRsps := Length(FRspList);   //how many objects do we have

	RSRec.RecVers := 1;
	RsRec.RspType := cTypeRsp;
	RSRec.PgCount := numRsps;
	RSRec.Xtra1 := 0;
	RSRec.Xtra2 := 0;
	amt := SizeOf(RspSpecRec);
	stream.WriteBuffer(RSRec, amt);         //write the rspList header

	for i := 0 to numRsps-1 do
		FRspList[i].SaveResponses(stream);    //write out each list

	FModified := False;                 //reset the flag
end;

procedure TRspList.UpdateRspItems(RspID: Integer; RspItems: String);
var
	i, count: Integer;
	foundIt, isModified: Boolean;
begin
	count := Length(FRspList);
	foundIt := False;
	isModified := False;
	if count > 0 then                           //make sure we have stuff
		begin
			i := 0;
			while not FoundIt and (i < count) do begin
				foundIt := FRspList[i].RspID = RspID;
				inc(i);
			end;
			if foundIt then
        begin
          isModified := (FRspList[i-1].RspItems <> RspItems);
          if isModified then
            FRspList[i-1].RspItems := RspItems;     //just update items
        end;
		end;

	if not foundIt then
		begin
    	isModified := True;
			SetLength(FRspList, count+1);       //increase capacity by 1

			FRspList[count] := TResponse.Create;       //new rsp object
			FRspList[count].RspID := RspID;
			FRspList[count].RspItems := RspItems;
		end;

	FModified := isModified;			//we've changed
end;


procedure TRspList.UpdateRspItems2(RspID: Integer; var RspItems: String);
var
	i, count: Integer;
	foundIt, isModified: Boolean;
begin
	count := Length(FRspList);
	foundIt := False;
	isModified := False;
	if count > 0 then                           //make sure we have stuff
		begin
			i := 0;
			while not FoundIt and (i < count) do begin
				foundIt := FRspList[i].RspID = RspID;
				inc(i);
			end;
			if foundIt then
        begin
          if RspItems <> '' then //only update if response item is not EMPTY
            begin
              isModified := (trim(FRspList[i-1].RspItems) <> trim(RspItems));
              if isModified then
                FRspList[i-1].RspItems := trim(RspItems);     //just update items
            end
          else
            RspItems := FRspList[i-1].RspItems;
        end;
		end;

	if not foundIt then
		begin
    	isModified := True;
			SetLength(FRspList, count+1);       //increase capacity by 1

			FRspList[count] := TResponse.Create;       //new rsp object
			FRspList[count].RspID := RspID;
			FRspList[count].RspItems := RspItems;
		end;

	FModified := isModified;			//we've changed
end;

function TRspList.GetCount: Integer;
begin
  result := length(FRspList);
end;

procedure TRspList.Clear;
begin
  SetLength(FRspList,0);
end;

{ TCommentList }

constructor TCommentList.Create;
begin
	inherited Create;

	FCmtList := TStringList.Create;
end;

destructor TCommentList.Destroy;
var
	i, c: Integer;
begin
	c := FCmtList.Count;
	for i := 0 to c-1 do
    if Assigned(FCmtList.Objects[i]) then
		    FCmtList.Objects[i].Free;         //free the comment objects

	FCmtList.Free;

	inherited destroy;
end;

function TCommentList.BuildCommenmtListBox(AOwner: TComponent): TListBox;
var
	i: Integer;
  doc: TContainer;
  width: Integer;
begin
  doc := TContainer(AOwner);
  try
    result := TRspListBox.Create(doc.docView);    //owner is DocView
    result.Visible := False;
    result.Parent := TScrollBox(doc.docView);
    result.Color := colorRespList;               //not changeable color
    result.AutoComplete := True;

    if FCmtList.Count > 0 then
      begin
        for i := 0 to FCmtList.Count-1 do
          result.items.add(UpperCase(FCmtList[i]) + ':  ' + GetFirstLine(i));
        result.ItemIndex := 0;   //pre-select the first one
        result.IntegralHeight := True;
      end;

    // calculate listbox width
    result.Canvas.Font.Assign(result.Font);
    width := Screen.PixelsPerInch;
    for i := 0 to result.Items.Count - 1 do
      width := Max(width, result.Canvas.TextWidth(result.Items[i]));
    Result.Width := width + GetSystemMetrics(SM_CXVSCROLL) + 10;
  except
    result := nil;   //think this through
  end;
end;

procedure TCommentList.BulidPopupCommentMenu(Menu: TPopupMenu);
var
	i, N: Integer;
	MI: TMenuItem;
begin
  Menu.AutoHotkeys := maManual;
	N := FCmtList.Count;
  if N = 0 then
		begin
			MI := TMenuItem.Create(Menu);
			MI.caption := msgNoRspForCell;
			MI.tag := -1;
			Menu.items.add(MI);
		end
  else if N > 0 then        //we can build one
    for i := 0 to N-1 do
      begin
        MI := TMenuItem.Create(Menu);   //create main item
        MI.caption := UpperCase(FCmtList[i]) + ':  ' + GetFirstLine(i);
        MI.tag := i;
        Menu.items.add(MI);
      end;
end;

function TCommentList.GetComment(Index: Integer): String;
begin
  result := '';
  if (Index > -1) and (index < FCmtList.count) then
    result := TComment(FCmtList.Objects[index]).FText;
end;

function TCommentList.GetFirstLine(index: Integer): String;
var
	S: String;
	L,N: Integer;
begin
	S := '';
	if (index > -1) and (index < FCmtList.count) then
		begin
			S := TComment(FCmtList.Objects[index]).FText;
			L := length(S);
			N := Pos(char(#13), S);    		//up to first return

			if (N = 0) then               //no return, then set min at 50
        N := 50
      else if (N > 0) then          //has return, len not more than 50
        N := Min(50, N-1);          //don't include return

			S := Copy(S, 1, min(L, N));
      if L > min(L, N) then
        S := S + '...';
		end;
	result := S;
end;

procedure TCommentList.LoadFromStream(stream: TFileStream);
var
	CmtObj: TComment;
	CMRec: CmtSpecRec;
	i, amt: Integer;
	cmtLen: Integer;
	cmtName, cmtText: String;
begin
	amt := SizeOf(CmtSpecRec);            //read the rspSpec header
	Stream.Read(CMRec, amt);

	if CMRec.RspType = cTypeCmt then			//its really a Rsp file
		if CMRec.Count > 0 then             //and there is something to read
			begin
				FCmtList.Capacity := CMRec.Count;    //need this amount of space

				for i := 0 to CMRec.Count-1 do
				begin
					amt := SizeOf(Integer);
					stream.Read(cmtLen, amt);       //read the length of the comment name

					SetString(cmtName, nil, cmtLen);
					Stream.Read(Pointer(cmtName)^, cmtLen);     //read the Name


					amt := SizeOf(Integer);
					stream.Read(cmtLen, amt);       //read the length of the comment text

					SetString(cmtText, nil, cmtLen);
					Stream.Read(Pointer(cmtText)^, cmtLen);     //read the text

					CmtObj := TComment.Create;         //create the obj to hold the text
					CmtObj.FText := cmtText;
					FCmtList.AddObject(cmtName, CmtObj);
				end;

			FModified := False;
		end;
end;

procedure TCommentList.SaveToStream(stream: TFileStream);
var
	i, numCmts: Integer;
	CMRec: CmtSpecRec;
	amt: LongInt;
	cmtName, cmtText: String;
	cmtLen: Integer;
begin
	numCmts := FCmtList.count;   //how many objects do we have

	CMRec.RecVers := 1;
	CMRec.RspType := cTypeCmt;
	CMRec.Count := numCmts;
	CMRec.Xtra1 := 0;
	CMRec.Xtra2 := 0;

	amt := SizeOf(CmtSpecRec);
	stream.WriteBuffer(CMRec, amt);      //write the rspList header

	for i := 0 to numCmts-1 do
		begin
			cmtName := FCmtList[i];          //the name of the comment
			cmtLen := Length(cmtName);
			amt := SizeOf(Integer);
			stream.WriteBuffer(cmtLen, amt); //write the length of the comment name

			stream.WriteBuffer(Pointer(cmtName)^, cmtLen);    //write the comment Name

			cmtText := TComment(FCmtList.Objects[i]).FText;   //the comment text
			cmtLen := Length(cmtText);
			amt := SizeOf(Integer);
			stream.WriteBuffer(cmtLen, amt);    //write the length of the comment text

			stream.WriteBuffer(Pointer(cmtText)^, cmtLen);    //write the comment text
	 end;

	FModified := False;                 //reset the flag
end;

{ TRspListBox }

procedure TRspListBox.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
//  Message.Result := Message.Result or DLGC_WANTALLKEYS;
  Message.Result := DLGC_WANTALLKEYS + DLGC_WANTARROWS + DLGC_WANTCHARS + DLGC_WANTTAB;
end;


{ TCommentGroup }

constructor TCommentGroup.Create(GroupID: Integer);
begin
  inherited Create;

  FRspGroupID := GroupID;
end;

procedure TCommentGroup.LoadFromStream(stream: TFileStream);
begin
  FRspGroupID := ReadLongFromStream(Stream);

  inherited;
end;

procedure TCommentGroup.SaveToStream(stream: TFileStream);
begin
  WriteLongToStream(FRspGroupID, Stream);

  inherited;
end;


{ TCommentGroups }

constructor TCommentGroups.Create;
begin
  inherited;

  OwnsObjects := True;
end;

function TCommentGroups.GetGroup(Index: Integer): TCommentGroup;
var
  n: Integer;
begin
  result := nil;
  n := 0;
  if Count > 0 then
    while (n < count) do
      if TCommentGroup(Items[n]).FRspGroupID = Index then
        begin
          result := TCommentGroup(Items[n]);
          break;
        end
      else
        inc(n);
        
  //if no group found, add one w/that group ID and return it
  if (result = nil) and (Index > -1) then
    begin
      result := TCommentGroup.Create(Index);
      Add(result);
      { Do not set Modified = True, in case user did not save edits}
      { This way we don't save empty TCommentGroups                }
    end;
end;

procedure TCommentGroups.SetGroup(Index: Integer; const Value: TCommentGroup);
var
  n: Integer;
begin
  n := 0;
  if Count > 0 then
    while (n < count) do
      if TCommentGroup(Items[n]).FRspGroupID = Index then
        begin
          TCommentGroup(Items[n]).FCmtList.Assign(Value.FCmtList);
          break;
        end
      else
        inc(n);
end;

procedure TCommentGroups.LoadAndConvertFromVersion1(Stream: TFileStream);
var
  CmtGroup: TCommentGroup;
  CmtList: TCommentList;
begin
  CmtGroup := TCommentGroup.Create;
  CmtList := TCommentList.Create;
  try
    try
      CmtGroup.FRspGroupID := 0;              //this is generic group
      CmtList.LoadFromStream(stream);         //read old way
      CmtGroup.FCmtList.Assign(CmtList.FCmtList);      //assign to new group object
    except
      FreeAndNil(CmtGroup);
    end;
  finally
    CmtList.FCmtList.Clear;  //empty str list & clears ref to objects,  obj not deleted
    CmtList.Free;     //now free everything, leave objects that have been assigned
    if CmtGroup <> nil then
      Add(CmtGroup);
  end;
end;

procedure TCommentGroups.LoadFromStream(stream: TFileStream);
var
  i, n: Integer;
  CmtGroup: TCommentGroup;
begin
  n := ReadLongFromStream(Stream);

  if n > 0 then
    for i := 1 to n do
      try
        CmtGroup := TCommentGroup.Create;
        try
          CmtGroup.LoadFromStream(Stream);
        except
          FreeAndNil(CmtGroup);
        end;
      finally
        if CmtGroup <> nil then Add(CmtGroup);
      end;
end;

procedure TCommentGroups.SaveToStream(stream: TFileStream);
var
  n: Integer;
begin
  WriteLongToStream(Count, Stream);       //write how many groups we have

  if count > 0 then
    for n := 0 to count-1 do              //write each group
      TCommentGroup(Items[n]).SaveToStream(Stream);
end;

end.
