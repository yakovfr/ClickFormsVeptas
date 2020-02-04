unit UForm;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc.}


interface

uses
	Windows, Classes, Graphics, Jpeg, UBase64,
	UClasses, UGlobals, UBase, UPage, UCell, UMessages, Forms;


Const
  fkMain      = 1;       //form kind is Main
  fkMainExt   = 2;       //form kind is Extension of Main like CompsXXX (requires Main to exist)
  fkMap       = 3;
  fkPhoto     = 4;
  fkSketch    = 5;
  fkTransmit  = 6;       //letter of transmittal
  fkInvoice   = 7;
  fkCover     = 8;
  fkExhibit   = 9;
  fkComment   = 10;
  fkCertPage  = 11;     //Certification
  fkAddenda   = 12;     //### need to be more specific
  fkMisc      = 13;     //### need to be more specific
  fkOrder     = 14;     //these are order forms
  fkWorksheetUAD = 15;     //UAD Worksheets
  fkWorksheetCVR = 16;     //CVR Worksheets
  fkWorkflow     = 17;     //workflow forms
//  fkCFWorksheet = 15;     //ClickFORMS UAD Worksheets
//  fkCCWorksheet = 16;     //CompCruncher UAD Worksheets


type

	// TDocForm is a class for encapuslating the form
	// It hold the list of pages that belong to the form
	TDocForm = class(TAppraisalForm)
  private                                  //start putting Gets and Sets up here
    FActiveLayer: Integer;                 //0=Reg; 1=Annotation; 2=Tablet Inking
    FActiveTool: Integer;                  //0=ToolSelect; 1=ToolText; 2=ToolLabel
    FPageList: TDocPageList;               //form desc belongs to ActiveFrmMgr,pgView belongs to TContainer
    function GetFormID: Integer;
    function GetMainType: Boolean;        //is the form a 'main' form
    function GetMainExtType: Boolean;
    procedure SetActiveLayer(const Value: Integer);
    procedure SetActiveTool(const value: Integer);
    procedure FixLegacyCellLocking;

  protected
    procedure SetDisabled(const Value: Boolean); override;
    procedure Loaded; virtual;
  public
    frmOwner: TObject;                    //ref to AcitveFormsMgr Item that owns this form
		frmInfo:  TFormIDInfo;                //ref to ActiveFormsMgr/Item/FormDetails/TFormIDInfo
		frmSpecs: TFormSpec;                  //ref to ActiveFormsMgr/Item/FormDetails/TFormSpec
		frmDefs: TPageDescList;               //ref to ActiveFormsMgr/Item/FormDetails/TPageDescList (nothing is doen with it)


    FInstance: Integer;                   //occurance count of this form in FormsList (zero based)
		FModified: Boolean;                   //has the form been modified
		FImportPgIdx: Integer;
		FImportCellIdx: Integer;              //counter for importing (so we go in sequence and not past end}

		constructor Create(docParent: TComponent); override;
		destructor Destroy; override;
		procedure Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer); override;
		procedure Notify(const Msg: TDocumentMessageID; const Data: Pointer); override;
		function HasData: Boolean;
		function HasContext: Boolean;
		function GetNumPages: Integer;
    procedure ResetImportIndexes;
		procedure SetModifiedFlag;
    procedure SetDataModified(Value: Boolean);
    procedure SetFormatModified(Value: Boolean);
    procedure UpdateSignature(const SigKind: String; SignIt, Setup: Boolean);
    procedure UpdateInfoCell(icKind, icIndex: Integer; Value:Double; Caption: String);
    function SaveFormatChanges: Boolean;
    procedure SetImportText(str: String; MergeData: Boolean; Broadcast: Boolean);
    function SetImportText2(str: String; MergeData: Boolean; Broadcast: Boolean;Overwrite: Boolean = False):String;
    Procedure SetImportImage(str: String; MergeData: Boolean; Broadcast: Boolean);
    procedure SetImportTextUnSystem(str: String; MergeData: Boolean; flName: String;Broadcast: Boolean);
    procedure BroadcastLocalCellContext(LocalCTxID: Integer; Str: String); overload;
    procedure BroadcastLocalCellContext(LocalCTxID: Integer; const Source: TBaseCell); overload;

    function FindSimilarForm(Container: TComponent): TDocForm;
    function FindSimilarUniqueForm(Container: TComponent; matchComps: Boolean): TDocForm;
    function HasSimilarTables(similarForm: TDocForm; matchComps: Boolean): Boolean;
    procedure PopulateFromSimilarForm(similarForm: TDocForm);
    procedure PopulateFromSimilarMain(Container: TComponent);
    procedure PopulateFromSimilarMainExt(Container: TComponent);
    procedure SetAllCellsTextSize(value: Integer);
    procedure SetAllCellsFontStyle(fStyle: TFontStyles);
    procedure SetGlobalCellFormating(doIt: Boolean);
    procedure LoadUserLogo;

    procedure InstallBookMarkMenuItems;
    procedure RemoveBookMarkMenuItems;

    procedure ShowFormProperties;
    procedure ClearFormText;
    procedure ConvertFormData(oldVersion: Integer; Stream: TStream; Version: Integer);
    function ConvertFormData2(oldVersion: Integer; Stream: TStream; Version: Integer; bShowMessage:Boolean=True):Boolean;
    Function GetCell(P,C: Integer): TBaseCell;
    Function GetCellByID(ID: Integer): TBaseCell;
    Function GetCellByCellClass(clName: String): TBaseCell;
    Function GetCellValueByID(ID: Integer): Double;
    Function GetCellTextByID(ID: Integer): String;
		Function GetCellValue(P,C: Integer): Double;          //shortcuts to cells on pages in this form
    Function GetCellUADError(P,C: Integer): Boolean;
		Function GetCellText(P,C: Integer): String;
    function GetCellByXID(const XID: integer): TBaseCell;
    function GetCellByXID_MISMO(ID: Integer): TBaseCell;        //get by XML ID
    Function GetCellTextByXID_MISMO(ID: Integer): String;
    function CellImageEmpty(P,C:Integer): Boolean;

		Procedure SetCellValue(P,C: Integer; V: Double);
		Procedure SetCellText(P,C: Integer; S: String);
    procedure SetCellData(P,C: Integer; S: String);
    procedure SetCellDataNP(P,C: Integer; S: String);
    procedure SetCellBitmap(P,C: Integer; ABitMap: TBitMap);
    procedure SetCellJPEG(P,C: Integer; AJpeg: TJPEGImage);
    procedure SetCellDataEx(P,C: Integer; S: String; ForceData: Boolean = False);
    procedure SetCellComment(P,C: Integer; AComment: String);

    procedure ClearCellJPEG(P,C: Integer);

    procedure SetCellImageFromCell(P,C: Integer; imageCell: TBaseCell);

    function GetSignatureTypes: TStringList;
    procedure ProcessMathCmd(CmdID: Integer);
    procedure WriteFormData(Stream: TStream); virtual;
    procedure ReadFormData(Stream: TStream); virtual;

    property DataModified: Boolean write SetDataModified;
    property FormatModified: Boolean read FModified write SetFormatModified;
    property FormID: Integer read GetFormID;
    property MainForm: Boolean read GetMainType;
    property MainExtForm: Boolean read GetMainExtType;
    property ActiveLayer: Integer read FActiveLayer write SetActiveLayer;
    property ActiveTool: Integer read FActiveTool write SetActiveTool;
		property frmPage: TDocPageList read FPageList;

    function ReadFutureData1(Stream: TStream): Boolean;
    function ReadFutureData2(Stream: TStream): Boolean;
    function ReadFutureData3(Stream: TStream): Boolean;
    function ReadFutureData4(Stream: TStream): Boolean;
    function ReadFutureData5(Stream: TStream): Boolean;
    function ReadFutureData6(Stream: TStream): Boolean;
    function ReadFutureData7(Stream: TStream): Boolean;
    function ReadFutureData8(Stream: TStream): Boolean;
    function ReadFutureData9(Stream: TStream): Boolean;
    function ReadFutureData10(Stream: TStream): Boolean;
    function ReadFutureData11(Stream: TStream): Boolean;
    function ReadFutureData12(Stream: TStream): Boolean;
    function ReadFutureData13(Stream: TStream): Boolean;
    function ReadFutureData14(Stream: TStream): Boolean;
    function ReadFutureData15(Stream: TStream): Boolean;

    function WriteFutureData1(Stream: TStream): Boolean;
    function WriteFutureData2(Stream: TStream): Boolean;
    function WriteFutureData3(Stream: TStream): Boolean;
    function WriteFutureData4(Stream: TStream): Boolean;
    function WriteFutureData5(Stream: TStream): Boolean;
    function WriteFutureData6(Stream: TStream): Boolean;
    function WriteFutureData7(Stream: TStream): Boolean;
    function WriteFutureData8(Stream: TStream): Boolean;
    function WriteFutureData9(Stream: TStream): Boolean;
    function WriteFutureData10(Stream: TStream): Boolean;
    function WriteFutureData11(Stream: TStream): Boolean;
    function WriteFutureData12(Stream: TStream): Boolean;
    function WriteFutureData13(Stream: TStream): Boolean;
    function WriteFutureData14(Stream: TStream): Boolean;
    function WriteFutureData15(Stream: TStream): Boolean;
	end;

{ TDocFormList }

	TDocFormList = class(TList)             //wrap around TList
	protected
    FDoc: TComponent;                     //the doc owner
    FStartPg: Integer;                    //manual page numbering - start page
    FTotalPg: Integer;                    //manual page numbering - of total pages
		FReportPgTotal: Integer;              //page counter for report (not all pages are counted)
		FPageTotal: Integer;									//total pages in this forms list
    FOnChangedEvent: TNotifyEvent;        //event raised after changes are made to the list
		function GetForm(Index: Integer): TDocForm;
		procedure PutForm(Index: Integer; Item: TDocForm);
    procedure SetAutoPgNumbering(const Value: Boolean);
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
	public
    FDisplayPgNums: Boolean;              //display the pages numbers
    FAutoPgNum: Boolean;                  //auto number the pages
		constructor Create(AOwner: TComponent);
    procedure FreeContents;
		function FirstForm: TDocForm;
		function IndexOf(Item: TDocForm): Integer;
    function AddForm(Item: TDocForm): Integer;
		procedure InsertForm(Item: TDocForm; Index: Integer);
		function LastForm: TDocForm;
		function RemoveForm(Item: TDocForm): Integer;
		property Forms[Index: Integer]: TDocForm read GetForm write PutForm; default;

    function GetFormIndexByOccurance(formID, Occur: Integer): Integer;   //occur is zero based
    function GetFormIndexByOccurance2(formID, Occur, CID: Integer; AName: string): Integer;
    function GetFormCountIndexByOccurance2(formID, CID: Integer; AName: string): Integer;
    function GetFormByOccurance(formID, Occur: Integer): TDocForm;
    function GetFormTypeByOccurance(fCatID, fKindID, Occur: Integer): TDocForm;
    procedure ConfigInstance(nForm: TDocForm);
    procedure ReConfigMultiInstances;
		procedure ReNumberPages;
    Procedure SetupTableContentPages;
		function GetFirstInputCell: TBaseCell;
		function GetFirstInputCell2: CellUID;
		function PageIsOpen(Cell: CellUID): Boolean;
		function PageHasCells(cell: CellUID): Boolean;
		function NextValidForm (var StartCell: CellUID; direction: Integer): Boolean;
		function NextValidPage (var StartCell: CellUID; direction: Integer): Boolean;
		function GoToNextCell(CurCell: CellUID; direction: Integer; Var NextCell: CellUID): Boolean;
    function ReportMainType: Integer;
		property TotalReportPages: Integer read FReportPgTotal write FReportPgTotal;   //pages in report
		property TotalPages: Integer read FPageTotal write FPageTotal;                 //pages in document
    property DisplayPgNumbers: Boolean read FDisplayPgNums write FDisplayPgNums;
    property AutoNumberPages: Boolean read FAutoPgNum write SetAutoPgNumbering;
    property StartPageNumber: Integer read FStartPg write FStartPg;
    property TotalPageNumber: Integer read FTotalPg write FTotalPg;
    property OnChanged: TNotifyEvent read FOnChangedEvent write FOnChangedEvent;
	end;


implementation

Uses
  StrUtils, SysUtils,
	UContainer, UUtil1, UFormConfig, UActiveForms,
  UFormInfo, UFileConvert, UFileUtils, UFileGlobals,
  UStatus, UGridMgr, UMathMgr, UUADUtils, uEditor;


	
{******************************************}
{        	                                 }
{               TDocForm                   }
{                                          }
{******************************************}


constructor TDocForm.Create(docParent: TComponent);
begin
	inherited;

  frmOwner := nil;               //this is ref to Forms Mgr Item that will own the form
	frmInfo := nil;                //it is similar to TFormDesc except it separates
	frmSpecs := nil;               //the page view and the page description
	FPageList := TDocPageList.Create;//form desc belongs to ActiveFrmMgr, pgView belongs to TContainer

  FInstance := 0;                //the occurance of this form in the container
	FParentDoc := docParent as TContainer;
	FModified := False;            //has form been modified
  FActiveLayer := alStdEntry;    //What is active layer: forms, annotation, inking
	FImportPgIdx := 0;             //Indexes to keep from overrunning
	FImportCellIdx := 0;           //maybe its better to do a Try..Except
end;

destructor TDocForm.Destroy;
var
	pg: integer;
begin
	if frmPage <> nil then
		for pg := frmPage.Count - 1 downto 0 do  //free its TDocPages
			TObject(frmPage.Extract(frmPage[pg])).Free;

  FreeAndNil(FPageList);
	inherited destroy;                 //now kill ourselves
end;

/// summary: Dispatches an event message up the document hierarchy until the
///          specified scope has been reached, and then queues the message for
//           delivery to the objects within the scope.
procedure TDocForm.Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer);
var
  Notification: PNotificationMessageData;
begin
  if (Scope <> DMS_FORM) then
    begin
      // forward message to parent
      ParentDocument.Dispatch(Msg, Scope, Data);
    end
  else
    begin
      // add to message queue
      New(Notification);
      Notification.Msg := Msg;
      Notification.Scope := Scope;
      Notification.Data := Data;
      Notification.NotifyProc := @TDocForm.Notify;
      Notification.NotifyInstance := Self;
      PostMessage(ParentDocument.Handle, WM_DOCUMENT_NOTIFICATION, 0, Integer(Notification));
    end;
end;

/// summary: Notifies the object and child objects of event messages received.
procedure TDocForm.Notify(const Msg: TDocumentMessageID; const Data: Pointer);
var
  Index: Integer;
  PageList: TDocPageList;
begin
  // process message
  case Msg of
    DM_LOAD_COMPLETE: Loaded;
  end;

  // notify pages
  if Assigned(FPageList) then
    begin
      PageList := TDocPageList.Create;
      try
        PageList.Assign(FPageList);
        for Index := 0 to PageList.Count - 1 do
          PageList.Pages[Index].Notify(Msg, Data);
      finally
        FreeAndNil(PageList);
      end;
    end;
end;

procedure TDocForm.ResetImportIndexes;
begin
	FImportPgIdx := 0;             //Indexes to keep from overrunning
	FImportCellIdx := 0;           //maybe its better to do a Try..Except
end;

function TDocForm.GetFormID: Integer;
begin
  if frmInfo <> nil then
    result := frmInfo.fFormUID
  else
    result := 0;
end;

function TDocForm.GetMainType: Boolean;
begin
  result := (frmInfo.fFormKindID = fkMain);
end;

function TDocForm.GetMainExtType: Boolean;
begin
  result := (frmInfo.fFormKindID = fkMainExt);
end;

procedure TDocForm.SetActiveLayer(const Value: Integer);
var
  p: Integer;
begin
  FActiveLayer := Value;
  if assigned(frmPage) then
    for p := 0 to frmPage.Count-1 do
      frmPage[p].pgDisplay.PgBody.ActiveLayer := Value;
end;

procedure TDocForm.SetActiveTool(const value: Integer);
var
  p: Integer;
begin
  FActiveLayer := Value;
  if assigned(frmPage) then
    for p := 0 to frmPage.Count-1 do
      frmPage[p].pgDisplay.PgBody.ActiveTool := Value;
end;

procedure TDocForm.FixLegacyCellLocking;
var
  CellIndex: Integer;
  PageIndex: Integer;
begin
  // locking is now performed at the report level, not on forms, pages, or cells
  // "disabled" used to be the mechanism for locking
  if (Disabled) then
    begin
      if Assigned(FPageList) then
        for PageIndex := 0 to FPageList.Count - 1 do
          if Assigned(FPageList.Pages[PageIndex].pgData) then
            for CellIndex := 0 to FPageList.Pages[PageIndex].pgData.Count - 1 do
              FPageList.Pages[PageIndex].pgData.DataCell[CellIndex].Disabled := False;

      Disabled := False;
    end;
end;

procedure TDocForm.SetDisabled(const Value: Boolean);
begin
  inherited;
  (FParentDoc as TContainer).docView.Invalidate;
end;

procedure TDocForm.Loaded;
begin
  FixLegacyCellLocking;
end;

function TDocForm.HasData: Boolean;
var
	pg: Integer;
begin
	pg := 0;
	result := False;
	if frmPage <> nil then
		while (not result) and (pg < frmPage.count) do
			begin
				result := FrmPage[pg].HasData;
				inc(pg);
			end;
end;

procedure TDocForm.UpdateSignature(const SigKind: String; SignIt, Setup: Boolean);
var
  p: Integer;
begin
  if (frmPage <> nil)and (frmPage.count > 0) then
    for p := 0 to frmPage.Count -1 do                  //for all pages
      TDocPage(frmPage[p]).UpdateSignature(SigKind, SignIt, Setup);   //tell page to update signature
end;

procedure TDocForm.UpdateInfoCell(icKind, icIndex: Integer; Value:Double; Caption: String);
var
  p: Integer;
begin
  if (frmPage <> nil)and (frmPage.count > 0) then
    for p := 0 to frmPage.Count -1 do                  //for all pages
      TDocPage(frmPage[p]).UpdateInfoCell(icKind, icIndex, Value, Caption);   //tell page to update
end;

function TDocForm.HasContext: Boolean;
var
	pg: Integer;
begin
	pg := 0;
	result := False;
	if frmPage <> nil then
		while (not result) and (pg < frmPage.count) do
			begin
				result := FrmPage[pg].HasContext;
				inc(pg);
			end;
end;

function TDocForm.GetNumPages: Integer;
begin
	result := frmPage.Count;
end;

Procedure TDocForm.SetModifiedFlag;
begin
	FModified := True;                          //this form has changed
	TContainer(FParentDoc).SetModifiedFlag;     //tell the container
end;

procedure TDocForm.SetDataModified(Value: Boolean);
begin
  TContainer(FParentDoc).DataModified := Value;     //tell doc its data has changed
end;

Procedure TDocForm.SetFormatModified(Value: Boolean);
begin
	FModified := Value;                                     //this form's format has changed
	TContainer(FParentDoc).FormatModified := Value;         //tell the container
end;

function TDocForm.SaveFormatChanges: Boolean;
var
  p: Integer;
begin
  result := True;
  //only save if the form has changed
  if FormatModified then
    begin
      for p := 0 to frmPage.Count -1 do
        result := TDocPage(frmPage[p]).SaveFormatChanges;

      TActiveFormItem(frmOwner).DefinitionChanged := True;   //set flag in FormsMgr Item
      FModified := False;    //reset flag here, do not pass to doc, may have other forms
    end;
end;

function IsHttp(str:String):Boolean;
begin
  str := lowerCase(Copy(str,1,4));
  result := CompareText(str, 'http') = 0;
end;

Procedure TDocForm.SetImportText(str: String; MergeData: Boolean; Broadcast: Boolean);
var
  GSEStr, NonGSEStr: String;
  PosGSE: Integer;
begin
  Trim(Str);
  PosGSE := Pos('GSE=', str);
  if (PosGSE >= 2) and (Copy(str, Pred(PosGSE), 1) = #9) then
    begin
      NonGSEStr := Copy(str, 1, (PosGSE - 2));
      // 050912 Null the GSEData as we no longer use data points. Leave this
      //  GSE detection code for legacy processing.
      //  Was: GSEStr := Copy(str, (PosGSE + 4), Length(str));
      GSEStr := '';
    end
  else
    begin
      NonGSEStr := str;
      // Special handling of GSE basement so the second cell is not blank
      if (NonGSEStr = '') and
         (frmPage[FImportPgIdx].pgData[FImportCellIdx].FCellXID = 1008) then
        if (frmPage[FImportPgIdx].pgData[FImportCellIdx - 2].GSEData <> '') then
          NonGSEStr := ' ';
      GSEStr := '';
    end;

	if (FImportPgIdx < frmPage.count) and (FImportCellIdx < frmPage[FImportPgIdx].pgData.count) then
		begin
      if MergeData then
        begin
          if not(NonGSEStr = '') then   //when merging don't insert blanks
			      frmPage[FImportPgIdx].pgData[FImportCellIdx].LoadContent(NonGSEStr, Broadcast);
        end
      else //straight importing
       frmPage[FImportPgIdx].pgData[FImportCellIdx].LoadContent(NonGSEStr, Broadcast);

      //Setup for next cell
			Inc(FImportCellIdx);                                              //go to next cell
			if FImportCellIdx = frmPage[FImportPgIdx].pgData.count then       //at end, go to next page
				begin
					FImportCellIdx := 0;
					Inc(FImportPgIdx);
				end;
		end;
end;

function TDocForm.SetImportText2(str: String; MergeData: Boolean; Broadcast: Boolean;Overwrite: Boolean=False):String;
var
  GSEStr, NonGSEStr: String;
  PosGSE: Integer;
  aStr, aImageFile: String;
  docPage: TDocPage;
begin
  str := Trim(Str);
  result := '';
  PosGSE := Pos('GSE=', str);
    docPage := frmPage[FImportPgIdx];

  if (PosGSE >= 2) and (Copy(str, Pred(PosGSE), 1) = #9) then
    begin
      NonGSEStr := Copy(str, 1, (PosGSE - 2));
      // 050912 Null the GSEData as we no longer use data points. Leave this
      //  GSE detection code for legacy processing.
      //  Was: GSEStr := Copy(str, (PosGSE + 4), Length(str));
      GSEStr := '';
    end
  else
    begin
      NonGSEStr := str;
      // Special handling of GSE basement so the second cell is not blank
      if (NonGSEStr = '') and
         (docPage.pgData[FImportCellIdx].FCellXID = 1008) then
        if (docPage.pgData[FImportCellIdx - 2].GSEData <> '') then
          NonGSEStr := ' ';
      GSEStr := '';
    end;

   if (FImportPgIdx < frmPage.count) and (FImportCellIdx < docPage.pgData.count) then
     begin
        if MergeData then
          begin
            if overWrite then
              begin
                if not(NonGSEStr = '') then
                  begin
                    if IsHttp(NonGSEStr) then //this is an image from web
                      begin
                        aImageFile := GetuRLImageFile(NonGSEStr);
                        docPage.pgData[FImportCellIdx].LoadContent(aImageFile, Broadcast);
                      end
                    else
                      docPage.pgData[FImportCellIdx].LoadContent2(NonGSEStr, Broadcast);
                  end;
                 //else if (NonGSEStr = '') and (docPage.pgData[FImportCellIdx].FContextID > 0) then
                 // docPage.pgData[FImportCellIdx].ReplicateGlobal;  //performance issue here.  Do it at the end and at form level
              end
            else if not(NonGSEStr = '') and (docPage.pgData[FImportCellIdx].Text='') then
              begin
                if IsHttp(NonGSEStr)  then //this is an image from web
                  begin
                    aImageFile := GetuRLImageFile(NonGSEStr);
                    docPage.pgData[FImportCellIdx].LoadContent(aImageFile, Broadcast);
                  end
                else
                  begin
                    docPage.pgData[FImportCellIdx].LoadContent2(NonGSEStr, Broadcast);
                  end;
              end;
          end
        else //straight importing
          begin
          if not(NonGSEStr = '') then
            begin
              if IsHttp(NonGSEStr) then
                begin
                  aImageFile := GetuRLImageFile(NonGSEStr);
                  docPage.pgData[FImportCellIdx].LoadContent(aImageFile, Broadcast);
                end
              else
                frmPage[FImportPgIdx].pgData[FImportCellIdx].LoadContent2(NonGSEStr, Broadcast);
            end;
          end;

      //Setup for next cell
      Inc(FImportCellIdx);                                              //go to next cell
      if FImportCellIdx = docPage.pgData.count then       //at end, go to next page
        begin
          FImportCellIdx := 0;
          Inc(FImportPgIdx);
        end;
     end;
end;





procedure TDocForm.SetImportTextUnSystem(str: String; MergeData: Boolean; flName: String; Broadcast: Boolean);
var
  pageType: Integer;
  impStr: String;
  cl :TBaseCell;
  strm: TFileStream;
  txt: String;
begin
  Trim(Str);
  if (FImportPgIdx < frmPage.count) and (FImportCellIdx < frmPage[FImportPgIdx].pgData.count) then
		begin
      pageType:= frmPage[FImportPgIdx].pgDesc.PgType;
      cl := frmPage[FImportPgIdx].pgData[FImportCellIdx];
      if (pageType = ptComments) and (cl is TMLnTextCell) then
        begin
          impStr := BuildAbsolutePath(flName,str);
          if FileExists(impStr) then    //it is not file just regular text
            begin
              strm := TFileStream.Create(impStr,fmOpenRead);
              try
                setLength(txt, strm.Size);
                strm.Read(pChar(txt)^,length(txt));
                impStr := txt;
              finally
                strm.Free;
              end;
            end
          else     //it is just a regular comment rather than a file reference
              impStr := str;
        end
      else
        if cl is TPhotoCell then
            impStr := BuildAbsolutePath(flName,str)
       else
          impStr := str;
      if not (MergeData and (length(impStr) = 0)) then
        cl.LoadContent(impStr, Broadcast);

      //Setup for next cell
			Inc(FImportCellIdx);                                              //go to next cell
			if FImportCellIdx = frmPage[FImportPgIdx].pgData.count then       //at end, go to next page
				begin
					FImportCellIdx := 0;
					Inc(FImportPgIdx);
				end;
		end;
end;

procedure TDocForm.BroadcastLocalCellContext(LocalCTxID: Integer; Str: String);
var
  p: Integer;
begin
  for p := 0 to frmPage.Count -1 do
    TDocPage(frmPage[p]).BroadcastLocalCellContext(LocalCTxID, Str); //doc tells pages
end;

procedure TDocForm.BroadcastLocalCellContext(LocalCTxID: Integer; const Source: TBaseCell);
var
  p: Integer;
begin
  for p := 0 to frmPage.Count -1 do
    TDocPage(frmPage[p]).BroadcastLocalCellContext(LocalCTxID, Source); //doc tells pages
end;

procedure TDocForm.InstallBookMarkMenuItems;
var
  p: Integer;
begin
  for p := 0 to frmPage.Count -1 do
    frmPage[p].InstallBookMarkMenuItems;
end;

procedure TDocForm.RemoveBookMarkMenuItems;
var
  p: Integer;
begin
  for p := 0 to frmPage.Count -1 do
    frmPage[p].RemoveBookMarkMenuItems;
end;

procedure TDocForm.PopulateFromSimilarMain(Container: TComponent);
var
  similarForm: TDocForm;
begin
  similarForm := FindSimilarForm(container);
  PopulateFromSimilarForm(similarForm);
end;

procedure TDocForm.PopulateFromSimilarMainExt(Container: TComponent);
var
  similarForm: TDocForm;
begin
  similarForm := FindSimilarUniqueForm(container, True);  //true = match comps
  PopulateFromSimilarForm(similarForm);
end;

//finds a similar form- Category and Kind match
function TDocForm.FindSimilarForm(Container: TComponent): TDocForm;
var
  i,myType,myKind: Integer;
  doc: TContainer;
begin
  myType := self.frmInfo.fFormCategoryID;
  myKind := self.frmInfo.fFormKindID;

  doc := TContainer(Container);
  i := 0;
  result := doc.GetFormTypeByOccurance(myType, myKind, i);
  while (result = self) do
    begin
      inc(i);   //get the next form of this category type
      result := doc.GetFormTypeByOccurance(myType, myKind, i);
    end;
end;

//finds a similar form- Category and Kind match, but the forms have to
//be different. This prevents Comps 456 from copying to comps 789
//if matchComps = true then table type and compID have to be identical
//this is so we can copy a urar Comps456 to a 2055 comps456 and not some other comps
function TDocForm.FindSimilarUniqueForm(Container: TComponent; matchComps: Boolean): TDocForm;
var
  i,myID, myType, myKind: Integer;
  doc: TContainer;
  sameComps: Boolean;
begin
  sameComps := False;
  myID :=   self.frmInfo.fFormUID;
  myType := self.frmInfo.fFormCategoryID;
  myKind := self.frmInfo.fFormKindID;

  doc := TContainer(Container);
  i := 0;
  if matchComps then
    begin
      repeat
        result := doc.GetFormTypeByOccurance(myType, myKind, i);
        while (result = self) or ((result <> nil) and (result.frmInfo.fFormUID = myID)) do
          begin
            inc(i);
            result := doc.GetFormTypeByOccurance(myType, myKind, i);
          end;
        if (result <> nil) then
          sameComps := HasSimilarTables(result, matchComps);
        inc(i); //incase we have to try again, inc to next occurance
      until (result=nil) or sameComps;
    end
  else
    begin
      result := doc.GetFormTypeByOccurance(myType, myKind, i);
      while (result = self) or ((result <> nil) and (result.frmInfo.fFormUID = myID)) do
        begin
          inc(i);
          result := doc.GetFormTypeByOccurance(myType, myKind, i);
        end;
    end;
end;
(*
//returns the type of the tables that are similar
function TDocForm.HasSimilarTables(similarForm: TDocForm; matchComps: Boolean): Boolean;
var
  similar: Boolean;
  aGrid, similarGrid: TGridMgr;
  GridKind: Integer;
begin
  result := False;
  aGrid := TGridMgr.Create(True);     //true = OwnsObjects
  similarGrid := TGridMgr.Create(True);
  try
    aGrid.BuildFormGrid(Self, gridKind);
    similarGrid.BuildFormGrid(similarForm, gridKind);
    result := aGrid.SimilarGrid(similarGrid);
  finally
    aGrid.Free;
    similarGrid.Free;
  end;
end;
*)

//returns the type of the tables that are similar
function TDocForm.HasSimilarTables(similarForm: TDocForm; matchComps: Boolean): Boolean;
var
  similar: Boolean;
  aTableList, similarTableList: TTableList;
  aGrid, similarGrid: TGridMgr;
  GridKind: Integer;
begin
  result := False;  //no match

  aTableList := Self.frmPage[0].pgDesc.PgCellTables;
  similarTableList := similarForm.frmPage[0].pgDesc.PgCellTables;

  if assigned(aTableList) and assigned(similarTableList) then  //both have tables
    begin
      gridKind := 1;
      similar := Assigned(aTableList.TableOfType(GridKind)) and Assigned(similarTableList.TableOfType(GridKind));
      while not similar and (gridKind <= gtListing) do
        begin
          inc(gridKind);
          similar := Assigned(aTableList.TableOfType(GridKind)) and Assigned(similarTableList.TableOfType(GridKind));
        end;

      if similar then //both have tables of this type
        begin
          aGrid := TGridMgr.Create(True);     //true = OwnsObjects
          similarGrid := TGridMgr.Create(True);
          try
            aGrid.BuildFormGrid(Self, gridKind);
            similarGrid.BuildFormGrid(similarForm, gridKind);

            result := aGrid.SimilarGrid(similarGrid);

          finally
            aGrid.Free;
            similarGrid.Free;
          end;
        end;
    end;
end;

procedure TDocForm.PopulateFromSimilarForm(similarForm: TDocForm);
var
  i,p: Integer;
  aGrid, similarGrid: TGridMgr;
  toComp, fromComp: TCompColumn;
begin
  if assigned(similarForm) then
    begin
      //copy the general text cells
      for p := 0 to frmPage.Count -1 do
        TDocPage(frmPage[p]).PopulateFromSimilarForm(similarForm);


      //copy the grid between the two forms
      aGrid := TGridMgr.Create(True);     //true = OwnsObjects
      similarGrid := TGridMgr.Create(True);
      try
        //populate sales grid
        aGrid.BuildFormGrid(Self, gtSales);
        similarGrid.BuildFormGrid(similarForm, gtSales);

        if (aGrid.count > 0) and (similarGrid.count > 0) then   //both have comps
          for i := 1 to aGrid.count-1 do                    //for all comps
            if (i < similarGrid.count) then                     //max of simGrid.count
              begin
                toComp := aGrid.Comp[i];
                fromComp := similarGrid.Comp[i];
                toComp.AssignTextByID(fromComp);
              end;

        //populate rental grid
        aGrid.BuildFormGrid(Self, gtRental);
        similarGrid.BuildFormGrid(similarForm, gtRental);

        if (aGrid.count > 0) and (similarGrid.count > 0) then   //both have comps
          for i := 1 to aGrid.count-1 do                    //for all comps
            if (i < similarGrid.count) then                     //max of simGrid.count
              begin
                toComp := aGrid.Comp[i];
                fromComp := similarGrid.Comp[i];
                toComp.AssignTextByID(fromComp);
              end;

        ProcessMathCmd(UpdateNetGrossID);     //update math
      finally
        aGrid.Free;
        similarGrid.Free;
      end;
  end;
end;

procedure TDocForm.ClearFormText;
var
  p: Integer;
begin
  for p := 0 to frmPage.Count -1 do
    with TDocPage(frmPage[p]) do
      begin
        ClearPageText;
        InvalidatePage;
      end;
end;

procedure TDocForm.ShowFormProperties;
var
  fInfo:TFormInfo;
begin
  fInfo := TFormInfo.create(TComponent(FParentDoc));
  try
    fInfo.SetFormProperties(Self);
    fInfo.ShowModal;
  finally
    fInfo.Free;
  end;
end;

procedure TDocForm.ConvertFormData(oldVersion: Integer; Stream: TStream; Version: Integer);
var
  nPage, i: Integer;
  RevisionMap: TFormRevMap;
  newCells: TList;
  cl, nCls : Integer;
  locContent: String;
  curCell: TBaseCell;
begin
  RevisionMap := TFormRevMap.Create;
  newCells := TList.Create;
  try
    if RevisionMap.GetRevisionMap(frmInfo.fFormUID, oldVersion, frmInfo.fFormVers) then
      begin
        for nPage := 0 to frmPage.count-1 do           //iterate thru form pages
          if RevisionMap.PageRevised(nPage, i) then    //does it need to be mapped
            begin
              frmPage[nPage].ConvertPageData(RevisionMap, i, Stream, Version, newCells);
            end
          else                                                //no mapping needed
            frmPage[nPage].ReadPageData(stream, Version);     //just read as usual
      end
    else
      begin
        ShowNotice('A newer version of "'+frmInfo.fFormName+'" was encountered and the conversion map was not found. The data will be skipped and may be lost if you save.');
        try
          for nPage := 0 to frmPage.Count-1 do				        // for each page...
            frmPage[nPage].SkipPageData(stream, Version);  		// skip the data from the file
        except
        end;
      end;
  finally
    RevisionMap.Free;
  end;
  //populate local content into the new cells
  nCls := newCells.Count;
  if nCls > 0 then
    for cl := 0 to nCls - 1 do
      begin
        locContent := '';
        curCell := TBaseCell(newCells[cl]);
        if assigned(curCell) and (curCell.FLocalCTxID > 0) then
          begin
            for nPage := 0 to frmPage.count-1 do
              begin
                locContent := frmPage[nPage].GetLocalContext(curCell.FLocalCTxID);
                if length(locContent) > 0 then
                  begin
                    curCell.DoSetText(locContent);
                    break;
                  end;
              end;
          end;
  end;
end;

function TDocForm.ConvertFormData2(oldVersion: Integer; Stream: TStream; Version: Integer; bShowMessage:Boolean=True):Boolean;
var
  nPage, i: Integer;
  RevisionMap: TFormRevMap;
  newCells: TList;
  cl, nCls : Integer;
  locContent: String;
  curCell: TBaseCell;
begin
  result := True;
  RevisionMap := TFormRevMap.Create;
  newCells := TList.Create;
  try
    if RevisionMap.GetRevisionMap(frmInfo.fFormUID, oldVersion, frmInfo.fFormVers) then
      begin
        for nPage := 0 to frmPage.count-1 do           //iterate thru form pages
          begin
            Application.ProcessMessages;
            if RevisionMap.PageRevised(nPage, i) then    //does it need to be mapped
            begin
              try
                frmPage[nPage].ConvertPageData(RevisionMap, i, Stream, Version, newCells);
              except on E:Exception do
                result := False;
              end;
            end
            else                                                //no mapping needed
              frmPage[nPage].ReadPageData(stream, Version);     //just read as usual
          end;
      end
    else
      begin
        result := False;
        if bShowMessage then
          ShowNotice('A newer version of "'+frmInfo.fFormName+'" was encountered and the conversion map was not found. The data will be skipped and may be lost if you save.')
        else
          exit;
        try
          for nPage := 0 to frmPage.Count-1 do				        // for each page...
          begin
            Application.ProcessMessages;
            frmPage[nPage].SkipPageData(stream, Version);  		// skip the data from the file
          end;
        except
          result := False;
        end;
      end;
  finally
    RevisionMap.Free;
  end;
  //populate local content into the new cells
  nCls := newCells.Count;
  if nCls > 0 then
    for cl := 0 to nCls - 1 do
      begin
        locContent := '';
        Application.ProcessMessages;
        curCell := TBaseCell(newCells[cl]);
        if assigned(curCell) and (curCell.FLocalCTxID > 0) then
          begin
            for nPage := 0 to frmPage.count-1 do
              begin
                Application.ProcessMessages;
                locContent := frmPage[nPage].GetLocalContext(curCell.FLocalCTxID);
                if length(locContent) > 0 then
                  begin
                    curCell.DoSetText(locContent);
                    break;
                  end;
              end;
          end;
  end;
end;


function TDocForm.GetCell(P,C: Integer): TBaseCell;
begin
  result := nil;
	dec(p); dec(c);		                      //zero based
	if (p < frmPage.count) and              //pg within range
     (frmPage[p].pgData <> nil) and       //there are some cells
     (c < frmPage[p].pgData.count) then   //cell within range
	result := frmPage[P].pgData[c];
end;

Function TDocForm.GetCellByID(ID: Integer): TBaseCell;
var
  p:Integer;
begin
  result := nil;
  p := 0;
  if (frmPage <> nil) then
    while (result = nil) and (p < frmPage.count) do
      begin
        result := frmPage[P].GetCellByID(ID);
        inc(p);
      end;
end;

Function TDocForm.GetCellByCellClass(clName: String): TBaseCell;
var
  p:Integer;
begin
  result := nil;
  p := 0;
  if (frmPage <> nil) then
    while (result = nil) and (p < frmPage.count) do
      begin
        result := frmPage[P].GetCellByCellClass(clName);
        inc(p);
      end;
end;

{ this method assumes that the CID matches the XID, which is not always the case }
{ this code is maintained for backward compatability of the MISMO code }
function TDocForm.GetCellByXID_MISMO(ID: Integer): TBaseCell;
var
  p:Integer;
begin
  result := nil;
  p := 0;
  if (frmPage <> nil) then
    while (result = nil) and (p < frmPage.count) do
      begin
        result := frmPage[P].GetCellByID(ID);
        inc(p);
      end;
end;

function TDocForm.GetCellByXID(const XID: integer): TBaseCell;
var
  cell: integer;
  page: integer;
begin
  result := nil;
  if Assigned(frmPage) then
    for page := 0 to frmPage.Count - 1 do
      if Assigned(frmPage[page].pgData) then
        for cell := 0 to frmPage[page].pgData.Count - 1 do
          if ((frmPage[page].pgData[cell] as TBaseCell).FCellXID = XID) then
            begin
              result := frmPage[page].pgData[cell] as TBaseCell;
              break;
            end;
end;

Function TDocForm.GetCellValueByID(ID: Integer): Double;
var
  Cell: TBaseCell;
begin
  result := 0;
  cell := GetCellByID(ID);
  if assigned(cell) then
    result := cell.GetRealValue;
end;

Function TDocForm.GetCellTextByID(ID: Integer): String;
var
  Cell: TBaseCell;
begin
  result := '';
  cell := GetCellByID(ID);
  if assigned(cell) then
    result := cell.GetText;
end;

{ this method calls GetCellByXID_MISMO maintained for backward compatability }
Function TDocForm.GetCellTextByXID_MISMO(ID: Integer): String;
var
  Cell: TBaseCell;
begin
  result := '';
  cell := GetCellByXID_MISMO(ID);
  if assigned(cell) then
    result := cell.GetText;
end;

Function TDocForm.GetCellValue(P,C: Integer): Double;
begin
	result := 0;
	dec(p); dec(c);		//zero based
	if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
		result := frmPage[P].pgData[c].GetRealValue;
end;

Function TDocForm.GetCellUADError(P,C: Integer): Boolean;
begin
	result := False;
	dec(p); dec(c);		//zero based
	if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
	 result := frmPage[P].pgData[c].HasValidationError;
end;

Function TDocForm.GetCellText(P,C: Integer): String;
begin
	result := '';
	dec(p); dec(c);		//zero based
	if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
	 result := frmPage[P].pgData[c].GetText;
end;

Procedure TDocForm.SetCellValue(P,C: Integer; V: Double);
begin
	dec(p); dec(c);		//zero based
	if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
	frmPage[P].pgData[c].SetValue(V);
end;

Procedure TDocForm.SetCellText(P,C: Integer; S: String);
begin
	dec(p); dec(c);		//zero based
	if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
	  frmPage[P].pgData[c].SetText(S);
end;

procedure TDocForm.SetCellData(P,C: Integer; S: String);
var
  cell: TBaseCell;
begin
	dec(p); dec(c);		//zero based
	if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
    begin
      cell := frmPage[P].pgData[c];
      S := Cell.Format(S);                        //do format
      Cell.SetText(S);                            //set it
      Cell.Display;                               //display it
      Cell.PostProcess;                           //do any math
    end;
end;

procedure TDocForm.SetCellDataNP(P,C: Integer; S: String);
var
  cell: TBaseCell;
begin
	dec(p); dec(c);		//zero based
	if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
    begin
      cell := frmPage[P].pgData[c];
      S := Cell.Format(S);            //do format
      Cell.SetText(S);                //set it
    end;
end;

procedure TDocForm.SetAllCellsTextSize(value: Integer);
var
  p,c: Integer;
  cell: TBaseCell;
begin
  for p := 0 to frmPage.Count -1 do
    if frmPage[p].pgData <> nil then   //make sure we have Pagecells to change
      for c := 0 to frmPage[p].pgData.count-1 do
        begin
          cell := frmPage[p].pgData[c];
          cell.TextSize := value;
        end;
end;

procedure TDocForm.SetAllCellsFontStyle(fStyle: TFontStyles);
var
  p,c: Integer;
  cell: TBaseCell;
begin
  for p := 0 to frmPage.Count -1 do
    if frmPage[p].pgData <> nil then   //make sure we have Pagecells to change
      for c := 0 to frmPage[p].pgData.count-1 do
        begin
          cell := frmPage[p].pgData[c];
          cell.FTxStyle := fStyle;
        end;
end;

procedure TDocForm.SetGlobalCellFormating(doIt: Boolean);
var
  p, gKind: Integer;
begin
  try
    if doIt then
      for p := 0 to frmPage.Count-1 do
        if frmpage[p].pgData <> nil then   //make sure we have Pagecells to change
          begin
            //set the user Co and Lic cell
            if (appPref_AutoTxAlignCoCell <> atjJustNone) or (appPref_AutoTxAlignLicCell <> atjJustNone) then
              frmPage[p].SetGlobalUserCellFormating;

            //set all long cells
            if (appPref_AutoTxAlignLongCell <> atjJustNone) then
              frmPage[p].SetGlobalLongCellFormating;

            //set all short cells
            if (appPref_AutoTxAlignShortCell <> atjJustNone) then
              frmPage[p].SetGlobalShortCellFormating;

            //Set header cell justification
            if (appPref_AutoTxAlignHeaders <> atjJustNone) then
              frmPage[p].SetGlobalHeaderCellFormating;

            //set grid description and adjustment cell justfication/formats
            if (appPref_AutoTxAlignGridDesc <> atjJustNone) then
              begin
                if Assigned(frmpage[p].pgDesc.PgCellTables) then   //do we have tables
                  begin
                    for gKind := gtSales to gtListing do    //what type of grid
                      if Assigned(frmpage[p].pgDesc.PgCellTables.TableOfType(gKind)) then //tables of this kind?
                        begin
                          frmPage[p].SetGlobalGridFormating(gKind);
                        end;
                  end;
              end;
          end;
  except
    ShowNotice('A problem was encountered while trying to set the new formats.');
  end;
end;

procedure TDocForm.LoadUserLogo;
var
  p:Integer;
begin
  p := 0;
  if (frmPage <> nil) then
    while (p < frmPage.count) do
      begin
        frmPage[P].LoadUserLogo;
        inc(p);
      end;
end;

function TDocForm.GetSignatureTypes: TStringList;
var
  p,i: Integer;
  formSigList: TStringList;
  pageSigList: TStringList;
begin
  formSigList := TStringList.Create;
  try
    try
      formSigList.Sorted := True;
      formSigList.Duplicates := dupIgnore;

      pageSigList := nil;
      for p := 0 to frmPage.count-1 do
        begin
          pageSigList := frmPage[p].GetSignatureTypes;
          if assigned(pageSigList)then
            begin
              for i := 0 to pageSigList.count-1 do
                formSigList.Add(pageSigList[i]);
              FreeAndNil(pageSigList);
            end;
        end;
    except
      if assigned(pageSigList) then pageSigList.Free;
      FreeAndNil(formSigList);
    end;
  finally
    if (formSigList <> nil) and (formSigList.Count = 0) then
      FreeAndNil(formSigList);   //nothing to sendback

    result := formSigList;
  end;
end;

procedure TDocForm.ProcessMathCmd(CmdID: Integer);
var
  FormUID: Integer;
  Cell: TBaseCell;
begin
  Cell := self.GetCell(1,1);           //first cell on page 1;
  FormUID := self.frmInfo.fFormUID;    //Set CellID
  if assigned(Cell) then
    ProcessCurCellMath(TContainer(FParentDoc), FormUID, CmdID, Cell);
end;

procedure TDocForm.WriteFormData(Stream: TStream);
var
	i, amt, nPage: Integer;
	FSpec: FormSpecRec;
begin
	FSpec.fFormUID := frmSpecs.fFormUID;				  {unique form identifer}
	FSpec.fFormVers := frmSpecs.fFormVers;				{revision no. of this form}
	FSpec.fFormName := copy(frmSpecs.fFormName, 1, cNameMaxChars);	{name of this form}
	FSpec.fNumPages:= frmSpecs.fNumPages;				  {number of pages in form includes c-addms}
	FSpec.fFormFlags := frmSpecs.fFormFlags;			{32 flags to indiccate what data is in file}
	FSpec.fNextSectionID := 1;						 				{version id of the following page definition structure}
  FSpec.fLockCount := Ord(Disabled);            //form is disabled (formerly lock count)

	for i := 1 to 19 do
		FSpec.ExtraSpace[i] := 0;										//buffer for expanding the header

	amt := SizeOf(FormSpecRec);
	stream.WriteBuffer(FSpec, amt);              //write the spec

  for nPage := 0 to frmPage.Count-1 do					// and for each page...
    frmPage[nPage].WritePageData(stream);  			// write the data to a file
end;

procedure TDocForm.ReadFormData(Stream: TStream);
begin
end;




{***** These read write functions are for **}
{***** future data expansion on the page  **}


function TDocForm.ReadFutureData1(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData1(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData2(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData2(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData3(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData3(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData4(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData4(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData5(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData5(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData6(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData6(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData7(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData7(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData8(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData8(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData9(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData9(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData10(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData10(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData11(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData11(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData12(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData12(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData13(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData13(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData14(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData14(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TDocForm.ReadFutureData15(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := dataSize > 0;
end;

function TDocForm.WriteFutureData15(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

procedure TDocForm.SetCellImageFromCell(P,C: Integer; imageCell: TBaseCell);
var
  cell: TBaseCell;
begin
  if assigned(imageCell) then
    begin
      dec(p); dec(c);		//zero based
      if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
        begin
          cell := frmPage[P].pgData[c];
          if (cell is TPhotoCell) and (imageCell is TPhotoCell) then
            begin
              TPhotoCell(Cell).AssignImage(TPhotoCell(imageCell).FImage);
            end;
        end;
    end;
end;

procedure TDocForm.SetCellBitmap(P,C: Integer; ABitMap: TBitMap);
var
  cell: TBaseCell;
  aStream: TMemoryStream;
begin
  if assigned(ABitMap) then
    begin
      dec(p); dec(c);		//zero based
      if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
        begin
          cell := frmPage[P].pgData[c];
          if (cell is TGraphicCell) then
            begin
              aStream := TMemoryStream.Create;
              try
                ABitMap.SaveToStream(aStream);
                aStream.Position := 0;
                TGraphicCell(cell).LoadStreamData(aStream, aStream.Size, True);
                cell.Display;
              finally
                aStream.Free;
              end;
            end;
        end;
    end;
end;

procedure TDocForm.SetCellJPEG(P,C: Integer; AJpeg: TJPEGImage);
var
  cell: TBaseCell;
  aStream: TMemoryStream;
begin
  if assigned(AJpeg) then
    begin
      dec(p); dec(c);		//zero based
      if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
        begin
          cell := frmPage[P].pgData[c];
          if (cell is TGraphicCell) then
            begin
              aStream := TMemoryStream.Create;
              try
                AJpeg.SaveToStream(aStream);
                aStream.Position := 0;
                TGraphicCell(cell).LoadStreamData(aStream, aStream.Size, True);
              finally
                aStream.Free;
              end;

              Cell.Display;    //this will create large DIBitmap
            end;
        end;
    end;
end;

procedure TDocForm.ClearCellJPEG(P,C: Integer);
var
  cell: TBaseCell;
begin
  dec(p); dec(c);		//zero based
  if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
    begin
      cell := frmPage[P].pgData[c];
      if (cell is TGraphicCell) then
        begin
          TGraphicCell(cell).Clear;
          TGraphicCell(cell).Display;
        end;
    end;
end;



(*
Procedure TDocForm.LoadCellContent(P,C: Integer; S: String);
begin
	dec(p); dec(c);		//zero based
	if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
	frmPage[P].pgData[c].SetText(S);
end;
*)

{******************************************}
{        	                                 }
{             TDocFormList                 }
{                                          }
{******************************************}

constructor TDocFormList.Create(AOwner: TComponent);
begin
  Inherited Create;

  FDoc := TContainer(AOwner);  //set the doc owner
	Capacity := 100;             //start with slots for 100 forms

  FDisplayPgNums := True;      //display the pages numbers
  FAutoPgNum := True;          //auto number the pages
  FStartPg := 0;               //manual page numbering - start page
  FTotalPg := 0;               //manual page numbering - of total pages
	FReportPgTotal := 0;         //number in Page Total cell
end;

//Frees the objects in the list only.
procedure TDocFormList.FreeContents;
begin
  while Count > 0 do
    TObject(Extract(Last)).Free;
end;

function TDocFormList.FirstForm: TDocForm;
begin
	result := TDocForm(inherited First);
end;

function TDocFormList.GetForm(Index: Integer): TDocForm;
begin
	result := TDocForm(inherited Get(index));
end;

procedure TDocFormList.PutForm(Index: Integer; Item: TDocForm);
begin
  inherited Put(Index, item);
end;

function TDocFormList.IndexOf(Item: TDocForm): Integer;
begin
	result := inherited IndexOf(Item);
end;

function TDocFormList.AddForm(Item: TDocForm): Integer;
var
  i,nFID: Integer;
begin
  if count > 0 then   //before adding count instances of form
    begin
      nFID := Item.frmSpecs.fFormUID;
      for i := 0 to count-1 do
        if (nFID = forms[i].frmSpecs.fFormUID) then   //we have another instance
          Inc(Item.FInstance);                        //inc instance count
    end;

  result := inherited Add(Item);
end;

procedure TDocFormList.InsertForm(Item: TDocForm; Index: Integer);
var
  i,nFID: Integer;
  pgCount, nextPgIdx: Integer;
  doc: TContainer;
begin
  doc := TContainer(FDoc);

  //before inserting count instances of form
  if count > 0 then
    begin
      nFID := Item.frmSpecs.fFormUID;
      for i := 0 to count-1 do
        if (nFID = forms[i].frmSpecs.fFormUID) then   //we have another instance
          Inc(Item.FInstance);                        //inc instance count
    end;

  //Find the starting page index for the new form
  if (Index > Count) or (Index = -1) then Index := Count;
  pgCount := Item.frmSpecs.fNumPages;
  nextPgIdx := 0;
	if Count > 0 then
		for i := 0 to Index-1 do                            //iterate thru forms
      nextPgIdx := nextPgIdx + forms[i].frmPage.count;  //total the pages

  //add the forms' pages to docGoToList and docView.PageList
  for i := 0 to pgCount-1 do
    begin
      doc.docView.InsertPage(Item.frmPage[i].PgDisplay, nextPgIdx + i);    //add the page to container's viewer
			doc.InsertInPageMgrList(Item.frmPage[i], nextPgIdx + i);              //add the page to the goto page List
    end;

  //Append if index is after count or -1, else insert at Index
  if (index >= count) or (Index < 0) then
    inherited Add(Item)
  else
    inherited Insert(index, Item);
end;

function TDocFormList.LastForm: TDocForm;
begin
	result := TDocForm(inherited Last);
end;

function TDocFormList.RemoveForm(Item: TDocForm): Integer;
begin
  Result := inherited Remove(Item);
end;

Function TDocFormList.GetFirstInputCell: TBaseCell;
var
	fm, pg, c: Integer;
	cell: TBaseCell;
	done: Boolean;
begin
	done := False;
	cell := nil;
	fm := 0;
	pg := 0;
	If count > 0 then           //make sure we have some forms
		repeat
			cell := Forms[fm].frmPage[Pg].GetFirstCellInSequence(c);
			if cell = nil then
				if Pg < Forms[fm].frmPage.Count-1 then
					inc(pg)
				else
					if fm < Count -1 then
						begin
							inc(fm);
							Pg := 0
						end
					else
						done := true;
		until (cell <> nil) or done;
	result := Cell;
end;

function TDocFormList.GetFirstInputCell2: CellUID;
var
	canMove, Skipped: Boolean;
	firstCell: CellUID;
	cellPref: Integer;
begin
	firstCell.form := 0;       //remeber: zero based
	firstCell.Pg := 0;
	firstCell.num := -1;			 //assume no cell

	if Count > 0 then
		repeat
			canMove := True;

      //get the cell
			if firstCell.Num + 1 <= GetForm(firstCell.form).frmPage[firstCell.Pg].PgDesc.PgNumCells then
				firstCell.Num := firstCell.Num + 1
			else if NextValidPage(firstCell, goDown) then
				firstCell.num := 0    //first cell
			else
				canMove := False;

			//check if it is valid
//			cellPref := GetForm(firstCell.form).frmPage[firstCell.Pg].PgDesc.PgFormCells[firstCell.Num].CPref;
      cellPref := GetForm(firstCell.form).frmPage[firstCell.Pg].PgData[firstCell.Num].FCellPref;
			Skipped := IsBitSet(CellPref, bCelSkip);
			if not skipped then
      begin
//###        cTyp := GetForm(firstCell.form).frmPage[firstCell.Pg].PgDesc.PgFormCells[firstCell.Num].CType;
//###        skipped :=(CTyp = COName) | (CTyp = PhotoInfo);	{we skip it anyway}
			end;

    Until not Skipped or not canMove;

  GetFirstInputCell2 := firstCell;
end;

//When the forms are moved around, reconfig the instance settings
procedure TDocFormList.ReconfigMultiInstances;
var
  i,j, FID,Num: Integer;
begin
  if count > 0 then
    begin
      for i := 0 to count-1 do                   //reset all instances
        forms[i].FInstance := 0;

      for i := 0 to count-1 do                  //count instances
        if forms[i].FInstance = 0 then          // make sure we don't count twice
          begin
            Num := 0;
            FID := forms[i].frmSpecs.fFormUID;   //remember the FID
            for j := i+1 to count-1 do
              if FID = forms[j].frmSpecs.fFormUID then
                begin
                  Inc(Num);
                  forms[j].FInstance := Num;
                end;
          end;

      for i := 0 to count-1 do
        ConfigureFormInstances(forms[i]);
    end;
end;

//Occurance is zero based //### change to 1 based
function TDocFormList.GetFormIndexByOccurance(formID, Occur: Integer): Integer;
var
  curOccur: Integer;
  indx : Integer;
begin
  result := -1;
  curOccur := 0;
  if count > 0 then
    begin
      for indx := 0 to count - 1 do
        if Forms[indx].frmInfo.fFormUID = formID  then
          begin
            if curOccur = occur then
              break
            else
              Inc(curOccur);
          end;
      if indx < count then
        result := indx;
    end;
end;

function TDocFormList.GetFormIndexByOccurance2(formID, Occur, CID: Integer; AName: string): Integer;
var
  curOccur: Integer;
  indx : Integer;
  cell: TBaseCell;
  Form: TDocForm;
begin
  result := -1;
  curOccur := 0;

  if count > 0 then
  begin
    for indx := 0 to count - 1 do
    begin
       if Forms[indx].frmInfo.fFormUID = formID  then  //GH# 1132: should use this line, we need to check if the form in the container = the formid
      //if ((Forms[indx].frmInfo.fFormUID > 200) and (Forms[indx].frmInfo.fFormUID <206)) or (Forms[indx].frmInfo.fFormUID =385) then
      begin
        form := Forms[indx];
        cell := form.GetCellByID(CID);

        if cell <> nil then
        begin
          if cell.Text = AName then
          begin
            if curOccur = occur then
            begin
              result := indx;
              exit;
            end else
              Inc(curOccur);
          end;  // name
        end  // cell
      end;  // form
    end;  // loop
  end;  // count
end;

function TDocFormList.GetFormCountIndexByOccurance2(formID, CID: Integer; AName: string): Integer;
var
  //curOccur: Integer;
  indx : Integer;
  cell: TBaseCell;
  Form: TDocForm;
begin
  result := 0;
  if count > 0 then
    begin
      for indx := 0 to count - 1 do
        if Forms[indx].frmInfo.fFormUID = formID  then
          begin
            form := Forms[indx];
            cell := form.GetCellByID(CID);
            if cell<>nil then
             if cell.Text=AName then
                result := result+1;
          end;
    end;
end;

function TDocFormList.GetFormByOccurance(formID, Occur: Integer): TDocForm;
var
  idx: Integer;
begin
  result := nil;
  idx := GetFormIndexByOccurance(formID, Occur);
  if idx > -1 then
    result := Forms[idx];
end;

function TDocFormList.GetFormTypeByOccurance(fCatID, fKindID, Occur: Integer): TDocForm;
var
  curOccur: Integer;
  indx : Integer;
begin
  result := nil;
  curOccur := 0;
  if count > 0 then
    begin
      for indx := 0 to count - 1 do
        if (Forms[indx].frmInfo.fFormCategoryID = fCatID)
        and (Forms[indx].frmInfo.fFormKindID = fKindID) then
          begin
            if curOccur = occur then
              break
            else
              Inc(curOccur);
          end;
      if indx < count then
        result := Forms[indx];
    end;
end;

//Configure this NForm based on its FInstances value
procedure TDocFormList.ConfigInstance(nForm: TDocForm);
begin
  //calls UFormConfig which parses out to math routinues to handle cell data

  ConfigureFormInstances(nForm);         //configure for correct instances
end;

procedure TDocFormList.RenumberPages;
var
	i,j,k, PgNum: Integer;
begin
	PgNum := 0;
	FPageTotal := 0;
	FReportPgTotal := 0;

  if not FAutoPgNum then             //set manual page starts if not auto numbering
    begin
	    PgNum := FStartPg;
	    FReportPgTotal := FTotalPg;
    end;

  k := 0;
	if Count > 0 then
		for i := 0 to count -1 do                         //iterate thru forms
			with forms[i] do
				for j := 0 to frmPage.count-1 do              //iterate thru pages
					begin
						Inc(FPageTotal);													//count it in total
            if frmPage[j].CountThisPage then
              begin
                if FAutoPgNum then
                  begin
                    Inc(PgNum);
                    Inc(FReportPgTotal);
                    frmPage[j].FPageNum := PgNum;
                  end
                else //being handled manually
                  begin
                    frmPage[j].FPageNum := PgNum + k;
                    inc(k);
                  end;
              end;
					end;

  // force windowed editor controls to reposition and rescale
  if Assigned( (FDoc as TContainer).docEditor ) then
    (FDoc as TContainer).docEditor.ResetScale;
end;

//Setup PageTag which is the offset into the Table of Contents array of fields
//The offset has to be set at runtime since we do not know how may TofC pages
//we will have.
Procedure TDocFormList.SetupTableContentPages;
var
	i,Index: Integer;
begin
  Index := 0;
	if Count > 0 then
		for i := 0 to count -1 do            //iterate thru forms
			with forms[i] do
        if (frmPage[0].pgDesc.PgType = ptTofC_Continued) then
          begin
            index := index + cTableContsEntries;
            frmPage[0].FPageTag := index;        //only one page in TC form
          end;
end;

function TDocFormList.PageIsOpen(Cell: CellUID): Boolean;
begin
	result := not Forms[Cell.form].frmPage[Cell.Pg].PgDisplay.PgCollapsed;
end;

function TDocFormList.PageHasCells(cell: CellUID): Boolean;
begin
	result := (Forms[Cell.form].frmPage[Cell.Pg].PgDesc.PgFormCells.Count > 0);
end;

function TDocFormList.NextValidForm(var StartCell: CellUID; direction: Integer): Boolean;
	var
		ValidForm, noMore: Boolean;
		nextCell: CellUID;
begin
  ValidForm := False;
	noMore := False;

  NextCell := StartCell;
  if direction = goUp then                   //going up,
    begin
      repeat
        NextCell.Form := NextCell.Form - 1;  //dec the form index
        if (NextCell.Form >= 0) then
          ValidForm := true
        else
					noMore := True;
      until ValidForm or noMore;
    end

  else if direction = goDown then
    begin
      repeat
        NextCell.Form := NextCell.Form + 1;
        if NextCell.Form <= Count-1 then
					ValidForm := true
        else
					noMore := True;
      until validForm or noMore;
    end;

  if validForm then							{return the right form/page}
    StartCell := NextCell;

	NextValidForm := ValidForm;
end;

function TDocFormList.NextValidPage (var StartCell: CellUID; direction: Integer): Boolean;
	var
		ValidPg, noMore: Boolean;
		NextCell: CellUID;
begin
	ValidPg := False;
	noMore := False;

	NextCell := StartCell;
	if direction = goUp then
		begin
			repeat
				NextCell.Pg := NextCell.Pg - 1;
				if NextCell.Pg < 0 then									{top of cur form, goto next form}
					if NextValidForm(NextCell, direction) then
						begin
							NextCell.Pg := Forms[NextCell.form].frmPage.Count-1;     //-1 because count from 0
							if PageIsOpen(NextCell) and PageHasCells(NextCell) then begin
								NextCell.num := Forms[nextCell.form].frmPage[nextCell.pg].GetCellIndexOf(false);
								ValidPg := True;
							end;
						end
					else
						noMore := True

				else if (NextCell.Pg >= 0) and PageIsOpen(NextCell) and PageHasCells(NextCell) then
					begin
						ValidPg := true;
						NextCell.num := Forms[nextCell.form].frmPage[nextCell.pg].GetCellIndexOf(false);
					end;
			until ValidPg or noMore;
		end

	else if direction = goDown then
    begin
      repeat
				NextCell.Pg := NextCell.Pg + 1;
				if (NextCell.Pg < Forms[nextCell.form].frmPage.Count) and PageIsOpen(NextCell) and PageHasCells(NextCell) then
					begin
						ValidPg := true;
						NextCell.num := Forms[nextCell.form].frmPage[nextCell.pg].GetCellIndexOf(true);
					end
				else if NextCell.Pg >= Forms[nextCell.form].frmPage.Count then
					if NextValidForm(NextCell, direction) then
						begin
							NextCell.Pg := 0;    //first page
							if PageIsOpen(NextCell) and PageHasCells(NextCell) then begin
								NextCell.num := Forms[nextCell.form].frmPage[nextCell.pg].GetCellIndexOf(true);
								ValidPg := True;
							end;
						end
          else
            noMore := True;

			until ValidPg or noMore;
    end;

	if validPg then							{return the right form/page}
		StartCell := NextCell;

  NextValidPage := ValidPg;
end;

function TDocFormList.GoToNextCell(CurCell: CellUID; direction: Integer; Var NextCell: CellUID): Boolean;
var
	canMove, Skipped: Boolean;
	firstLeft, firstRight: Boolean;
	cellPref: LongInt;
	cellNum: Integer;
	loopChk: Integer;		//remember incase we hit an endless loop
begin
	firstLeft := True;
	firstRight := True;
	loopChk := 0;
	NextCell := CurCell;
	repeat
		canMove := True;
//JJ		Skipped := False;
		case direction of
      goNoWhere:
        begin
          canMove := False;
          NextCell := NullUID;
        end;
			goNext:
				begin
					cellNum := Forms[NextCell.form].frmPage[nextCell.Pg].PgDesc.PgCellSeq^[nextCell.Num].SNext;
					if cellNum >= 0 then
						nextCell.Num := cellNum
					else if not NextValidPage(NextCell, goDown) then
						canMove := False;
					firstLeft := True;
					firstRight := True;
					loopChk := 0;
				end;
			goPrev:
				begin
					cellNum := Forms[NextCell.form].frmPage[nextCell.Pg].PgDesc.PgCellSeq^[nextCell.Num].SPrev;
					if cellNum >= 0 then
						nextCell.Num := cellNum
					else if not NextValidPage(NextCell, goUp) then
						canMove := False;
					firstLeft := True;
					firstRight := True;
					loopChk := 0;
				end;
			goUp:
				begin
					cellNum := Forms[NextCell.form].frmPage[nextCell.Pg].PgDesc.PgCellSeq^[nextCell.Num].SUp;
					if cellNum >= 0 then
						nextCell.Num := cellNum
					else if not NextValidPage(NextCell, goUp) then
						canMove := False;
					firstLeft := True;
					firstRight := True;
					loopChk := 0;
				end;
			goDown:
        begin
					cellNum := Forms[NextCell.form].frmPage[nextCell.Pg].PgDesc.PgCellSeq^[nextCell.Num].SDown;
					if cellNum >= 0 then
						nextCell.Num := cellNum
					else if not NextValidPage(NextCell, goDown) then
						canMove := False;
			(*
					firstLeft := True;
					firstRight := True;
					loopChk := 0;
			*)
					firstleft := True;
					firstRight := True;
					loopChk := 0;
				end;
      goLeft:
        begin
					cellNum := Forms[NextCell.form].frmPage[nextCell.Pg].PgDesc.PgCellSeq^[nextCell.Num].SLeft;
					if cellNum >= 0 then
						begin
							nextCell.Num := cellNum;
							if firstLeft then        //set the loop check
                begin
                  firstLeft := False;
                  loopChk := cellNum;
                end
							else if (loopChk = cellNum) then   //maybe a loop, try going up
								direction := goUp
              else if (CurCell.Num = cellNum) then   // a loop, we're back to the original cell
                canMove := False;
						end
					else if not NextValidPage(NextCell, goUp) then
						canMove := False;

					firstRight := True;
				end;
			goRight:
				begin
					cellNum := Forms[NextCell.form].frmPage[nextCell.Pg].PgDesc.PgCellSeq^[nextCell.Num].SRight;
					if cellNum >= 0 then
						begin
							nextCell.Num := cellNum;
							if firstRight then        //set the loop check
                begin
                  firstRight := False;
                  loopChk := cellNum;
                end
							else if (loopChk = cellNum) then   //maybe a loop, try going down
								direction := goDown
							else if (CurCell.Num = cellNum) then   // a loop, we're back to the original cell
                canMove := False;
						end
					else if not NextValidPage(NextCell, goDown) then
						canMove := False;
				end;
    else
      begin
        canMove := False;
        NextCell := NullUID;
      end;
		end;
		//test the new cell to see if we skip it

//###		cellPref := Forms[NextCell.form].frmPage[NextCell.Pg].PgDesc.PgFormCells[NextCell.Num].CPref;
    cellPref := Forms[NextCell.form].frmPage[NextCell.Pg].PgData[NextCell.Num].FCellPref;
		Skipped := IsBitSet(cellPref, bCelSkip);
	until not Skipped or not canMove;

  result := canMove;
end;

function TDocFormList.ReportMainType: Integer;
var
  f: Integer;
begin
  result := 0;
  f := 0;
  while f < count do
    begin
      if Forms[f].frmInfo.fFormKindID = fkMain then    //find first main form
        begin
          result := Forms[f].frmInfo.fFormUID;         //this is it
          break;
        end;
      inc(f);
    end;
end;

procedure TDocFormList.SetAutoPgNumbering(const Value: Boolean);
begin
  FAutoPgNum := Value;
  ReNumberPages;
end;

/// summary: Raises the OnChanged event when the list has changed.
procedure TDocFormList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited;
  if Assigned(FOnChangedEvent) then
    FOnChangedEvent(Self);
end;

function TDocForm.CellImageEmpty(P, C: Integer):Boolean;
var
  Cell: TBaseCell;
begin
  result := False;
  Cell := getCell(P, C);
  if assigned(Cell) then
    if (Cell is TGraphicCell) then
      begin
        if (TGraphicCell(Cell).FImage = nil) then
          result := True
        else
          result := not TGraphicCell(Cell).FImage.HasGraphic;
      end;
end;

//Insert a data array of bytes that represent an image and put it into a JPEG
procedure LoadJPEGFromByteArray(const dataArray: String; var JPGImg: TJPEGImage);
var
  msByte: TMemoryStream;
  iSize: Integer;
begin
  msByte := TMemoryStream.Create;
  try
    iSize := Length(DataArray);
    msByte.WriteBuffer(PChar(DataArray)^, iSize);
    msByte.Position:=0;

    if not assigned(JPGImg) then
      JPGImg := TJPEGImage.Create;

    JPGImg.LoadFromStream(msByte);
  finally
    msByte.Free;
  end;
end;


//#special code to set image paste from RedStone
Procedure TDocForm.SetImportImage(str: String; MergeData: Boolean; Broadcast: Boolean);
var
  JPGImg : TJPEGImage;
  imagedata : String;
  cell: TBaseCell;
  aStream: TMemoryStream;
begin
  imagedata := Base64Decode(str);
  if Length(imagedata) > 0 then
   begin
    JPGImg := TJPEGImage.Create;
    try
     cell := frmPage[FImportPgIdx].pgData[FImportCellIdx];
     LoadJPEGFromByteArray(imagedata,JPGImg);
     if (cell is TGraphicCell) then
       begin
         aStream := TMemoryStream.Create;
         try
          JPGImg.SaveToStream(aStream);
          aStream.Position := 0;
          TGraphicCell(cell).LoadStreamData(aStream, aStream.Size, True);
          cell.Display;
         finally
          aStream.Free;
         end;
       end;
    finally
      JPGImg.Free;
    end;
   end;
  //Setup for next cell
	Inc(FImportCellIdx);                                              //go to next cell
	if FImportCellIdx = frmPage[FImportPgIdx].pgData.count then       //at end, go to next page
		begin
	  	FImportCellIdx := 0;
	  	Inc(FImportPgIdx);
		end;
end;

//Special SetData routine that checks for manual entry and does not overwrite it
procedure TDocForm.SetCellDataEx(P,C: Integer; S: String; ForceData: Boolean = False);
var
  cell: TBaseCell;
begin
	dec(p); dec(c);		//zero based
	if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
    begin
      cell := frmPage[P].pgData[c];
      if ForceData or (not Cell.FManualEntry) then
        begin
          S := Cell.Format(S);                        //do format
          Cell.SetText(S);                            //set it
          Cell.Display;                               //display it
          Cell.PostProcess;                           //do any math
        end;
    end;
end;

procedure TDocForm.SetCellComment(P,C: Integer; AComment: String);
var
 Cell: TBaseCell;
 MLEditor: TMLEditor;
begin
  if Trim(AComment) <> '' then  //only set comment if it's not EMPTY
  begin
    dec(p); dec(c);		//zero based
    if (p < frmPage.count) and (c < frmPage[p].pgData.count) then
      begin
        cell := frmPage[P].pgData[c];
        if Cell.FIsActive and (Cell.Editor <> nil) and (Cell.Editor is TTextEditor) then
          begin
            (CEll.Editor as TTextEditor).Text := AComment;
          end
        else begin
            MLEditor := TMLEditor.Create(FParentDoc);
            try
              ClearLF(AComment);                      //strip any LF chars before displaying
              ClearNULLs(AComment);
              Cell.SetText(AComment);                 //set it
              MLEditor.LoadCell(cell, NullUID);       //does calcWrap
              MLEditor.CalcTextWrap;
              MLEditor.CheckTextOverFlow;
              MLEditor.Modified := True;
              MLEditor.SaveChanges;                   //save the text to the cell
              Cell.Display;
            finally
              if assigned(MLEditor) then
                MLEditor.Free;
            end;
        end;
      end;
    end;
end;



end.
