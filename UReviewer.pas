unit UReviewer;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, ExtCtrls, Grids, ComCtrls, DCSystem, DCScript,
  UForm, UStrings, UContainer, UEditor, UForms, UUADUtils, Grids_ts, TSGrid,
  osAdvDbGrid, TsGridReport, uCell, uGridMgr, uGlobals;

const
  msgCantReview: String = 'Can not Review ';
  formObjectName: String = 'form';
  scripterObjectName: String = 'scripter';
  fnGetCellName: String = 'GetCellText';
  fnAddRecordName: String = 'AddRecord';
  fnInsertTitleName: String = 'InsertTitle';
  fnGetCellValue: String = 'GetCellValue';
  // 102411 JWyatt New constant for capturing the UAD vaildation error flag
  fnGetCellUADError: String = 'GetCellUADError';
  fnCellImageEmpty: String  = 'CellImageEmpty';

  cScriptHeaderFileName = 'ScriptHeader.vbs';     //name of definition review script file
  cUADScriptHeaderFileName = 'UADScriptHeader.vbs'; //name of definition review script file
  {     //never used
  cTmpScriptFileName = 'realScript.vbs';          //name of united (header and checks) review script

  defsScrFileName = 'defsscr.vbs';         //name of definition review script file
  tmpScrFileName = 'realscr.vbs';          //name of united (definition and form) review script    }

  //Set up Grid column
  colLocate = 1;
  colForm   = 2;
  colPg     = 3;
  colCell   = 4;
  colErrorMessage = 5;
  CriticalError_Color = clRed;
  CriticalWarning_Color = colorSalmon;

type
  TTDocFormGetCellText = function(page: Integer; cell: Integer): String of Object;
  TTDocFormGetCellValue = function(page: Integer; cell: Integer): Double of Object;
  TTReviewerAddRecord = procedure(text: String; form,page,cell: Integer) of Object;
  TTReviewerInsertTitle = procedure(text: String; index: Integer) of Object;
  // 102411 JWyatt New type to capture the UAD vaildation error flag
  TTDocFormGetCellUADError = function(page: Integer; cell: Integer): Boolean of Object;
  TTDocFormCellImageEmpty = function(page: Integer; cell: Integer): Boolean of Object;

  TCellID = class(TObject)   //YF Reviewer 04.08.02
    Form: Integer;          //form index in formList
    Pg: Integer;            //page index in form's pageList
    Num: Integer;            //cell index in page's cellList
    constructor Create;
  end;

  TReviewer = class(TAdvancedForm)
    Panel1: TPanel;
    StatusBar: TStatusBar;
    Splitter1: TSplitter;
    FormList: TCheckListBox;
    scripter: TDCScripter;
    BtnGroup: TGroupBox;
    btnReview: TButton;
    btnCancel: TButton;
    btnPrint: TButton;
    PanelWarning: TPanel;
    lblCriticalErrs: TLabel;
    StaticText1: TStaticText;
    stxWarnings: TStaticText;
    ReviewGrid: TosAdvDbGrid;
    osGridReport1: TosGridReport;
    lblCriticalWarning: TStaticText;
    procedure btnReviewClick(Sender: TObject);
    procedure OnRecDblClick(Sender: TObject);
    procedure OnCancel(Sender: TObject);
    procedure OnPrint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ReviewGridButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure ReviewGridDblClickCell(Sender: TObject; DataCol,
      DataRow: Integer; Pos: TtsClickPosition);
    procedure ReviewGridGetDrawInfo(Sender: TObject; DataCol,
      DataRow: Integer; var DrawInfo: TtsDrawInfo);
    procedure btnPrintClick(Sender: TObject);


  private
    { Private declarations }

    FReviewErrFound: Boolean;
    FCriticalErrCount: Integer;
    FWarningErrCount: Integer;
    FReviewList: TStringList;
    FPrinting: Boolean;
    FReviewCritialWarningFound: Boolean;
    FCriticalWarningCount: Integer;
    procedure AddRecord(text: String; frm,pg,cl: Integer);
    procedure AdjustDPISettings;
    procedure LocateReviewErrOnForm(Index: Integer);
    procedure ClearReviewErrorGrid;
    procedure Review_byForm;


  public

    doc: TContainer;  //YF Reviewer 04.08.02
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function ReviewForm(form: TDocForm; formIndex: Integer; scriptFullPath: String; UADRpt:Boolean=False): Boolean;
    procedure InsertTitle(text: String; index: Integer);
  end;

implementation

uses
  Printers,   //modified Delphi Printer Unit
  UUtil1, UMain, UStatus, uReviewRules;


{$R *.DFM}
constructor TCellID.Create;
begin
  inherited Create;

  Form := - 1;
  Pg := -1;
  Num := -1;
end;

{ TReviewer }

constructor TReviewer.Create(AOwner: TComponent);
var
  i,n,RevFileID: Integer;
  ScriptFilePath, ScriptName: String;
  reviewOK: Boolean;
begin
  inherited;
  FReviewList := TStringList.Create;
  if AOwner <> nil then
    begin
      doc := TContainer(AOwner);
      FReviewList := TStringList.Create;
      Caption := Caption + ': ' + doc.docFileName;
      i :=0;  //# of items in formList
      for n := 0 to doc.docForm.count-1 do
      begin
        if doc.docForm[n].frmPage.Count > 1 then    //YF 05.24.02
          formList.Items.Append(doc.docForm[n].frmInfo.fFormName)
        else  //to get the right title for comps
          formList.Items.Append(doc.docForm[n].frmPage[0].PgTitleName);

        RevFileID := doc.docForm[n].frmInfo.fFormUID;
        ScriptName := Format('REV%5.5d.vbs',[RevFileID]);               //YF Reviewer 04.05.02
        ScriptFilePath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) + ScriptName;
        reviewOK := FileExists(ScriptFilePath);
        formList.ItemEnabled[i] := reviewOK;
        formList.checked[i] := reviewOK;
        inc(i);
      end;
    end;


  RegisterProc(TDocForm,fnGetCellName,mtMethod,TypeInfo(TTDocFormGetCellText),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(String)],
        Addr(TDocForm.GetCellText),cRegister);
  RegisterProc(TDocForm,fnGetCellValue,mtMethod,TypeInfo(TTDocFormGetCellValue),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(Double)],
        Addr(TDocForm.GetCellValue),cRegister);
  RegisterProc(TReviewer,fnAddRecordName,mtMethod,TypeInfo(TTReviewerAddRecord),
        [TypeInfo(String),TypeInfo(Integer),TypeInfo(Integer),TypeInfo(integer)],
        Addr(TReviewer.AddRecord),cRegister);
  RegisterProc(TReviewer,fnInsertTitleName,mtMethod,TypeInfo(TTReviewerInsertTitle),
        [TypeInfo(String),TypeInfo(Integer)],
        Addr(TReviewer.InsertTitle),cRegister);
  // 102411 JWyatt New procedure definition for capturing the UAD vaildation error flag
  RegisterProc(TDocForm,fnGetCellUADError,mtMethod,TypeInfo(TTDocFormGetCellUADError),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(Boolean)],
        Addr(TDocForm.GetCellUADError),cRegister);

  RegisterProc(TDocForm,fnCellImageEmpty,mtMethod,TypeInfo(TTDocFormCellImageEmpty),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(Boolean)],
        Addr(TDocForm.CellImageEmpty),cRegister);

  scripter.AddObjectToScript(self,scripterObjectName,false);
  scripter.Language := 'VBScript';

end;

destructor TReviewer.Destroy;
var idx: Integer;
begin
  for idx := 0 to Pred(FReviewList.Count) do
    FReviewList.Objects[idx] := nil;
  FReviewList.Free;

  inherited Destroy;
end;

procedure TReviewer.btnReviewClick(Sender: TObject);
var
  n,RevFileID: Integer;
  ScriptFilePath, ScriptName: String;
  reviewOK: Boolean;
  signLIst: TStringList;
  formKind,i: Integer;
  sl: TStringList;
  cCount: Integer;
  aFormList: BooleanArray;

begin
  try
    aFormlist:=nil;
    SetLength(aFormlist, FormList.Count);

    sl:=TStringList.Create;
    doc.docHasBeenReviewed := True;   //no need to review on close.
    FReviewList.Clear;
    FReviewErrFound := False;
    FCriticalErrCount := 0;
    FWarningErrCount := 0;
    FReviewCritialWarningFound := False;
    FCriticalWarningCount := 0;
    ClearReviewErrorGrid;
    formList.Enabled := True;
    RevFileID := 0;
    try
      if Assigned(doc.docEditor) and (doc.docEditor is TEditor) then
        (doc.docEditor as TEditor).SaveChanges;
      //*** Hard Stop: Form Mismatch Rule: If main form does not match with cert page or XComp page, show stop
      for i:=0 to FormList.Count-1 do
          aFormList[i] := FormList.Checked[i];
      cCount := CheckRuleMisMatch(aFormList,doc.docForm,FReviewList,sl,ReviewGrid);

      for n := 0 to doc.docForm.count-1 do
        begin
          //attempt review of this form
            //// Do not include UAD, CVR and workflow worksheets for now
            formKind := doc.docForm[n].frmInfo.fFormKindID;
            //attempt review of this form
            i := formList.Items.IndexOf(doc.docForm[n].frmInfo.fFormName);
            if i = -1 then
              i := formList.Items.Indexof(doc.docForm[n].frmPage[0].PgTitleName);
            if i <> -1 then
            begin
              if formList.Checked[i] then
              begin
                RevFileID := doc.docForm[n].frmInfo.fFormUID;
                // V6.8.0 modified 062409 JWyatt to change format so name is auto-padded
                //  with zeros
                ScriptName := Format('REV%5.5d.vbs',[RevFileID]);               //YF Reviewer 04.05.02
                ScriptFilePath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) + ScriptName;
                if FileExists(ScriptFilePath) then
                begin
                  reviewOK := ReviewForm(doc.docForm[n], n, ScriptFilePath, doc.UADEnabled);
                  formList.ItemEnabled[i] := reviewOK;
                end
                else
                begin
                  formList.Items.Strings[i] := doc.docForm[n].frmInfo.fFormName +' -> Review script unavailable';
                  formList.ItemEnabled[i] := False;
                end;
              end;
            end;
        end;
        Review_byForm;
        // about signature
        if AppIsClickFORMS then //only do the signature if it's clickFORMS
        begin
          signList := doc.GetSignatureTypes;
          if assigned(signList) then //the report needs the signature
            if doc.docSignatures.Count = 0 then //the report is not signed
              scripter.CallNoParamsMethod('Signature');
        end;
        FCriticalErrCount := FCriticalErrCount + cCount;
        //***
        if true then //bReviewed then
          scripter.DispatchMethod('AddReviewHeader',[doc.docFileName]);
      FWarningErrCount := ReviewGrid.Rows - (FCriticalErrCount + FCriticalWarningCount);
      stxWarnings.caption := Format('%d Warning(s)',[FWarningErrCount]);
      lblCriticalErrs.Caption := Format('%d Critical Error(s)',[FCriticalErrCount]);
      lblCriticalWarning.Caption := Format('%d Critical Warning(s)',[FCriticalWarningCount]);

      FReviewErrFound := FCriticalErrCount > 0;   //there are errors

      if FReviewErrFound then
        btnReview.Caption := 'Re-Review'
      else
        btnReview.Caption := 'Refresh';
      ReviewGrid.Invalidate;

    except on E:Exception do
      ShowNotice('There was a problem reviewing form #'+IntToStr(RevFileID));
    end;
    btnCancel.Caption := 'Close';
  Finally
    sl.Free;
  end;
end;

procedure TReviewer.Review_byForm;
var
  f,p,c: Integer;
  CurCell, CurCellSettle: TBaseCell;
  aComp: TCompColumn;
  CompID: Integer;
  NumSettle, formNum: Integer;
  ErrorMsg, SubjAddr: String;
begin
  try
    NumSettle := 0;
    for f := 0 to (doc.docForm.Count - 1) do
      for p := 0 to (doc.docForm[f].frmPage.count - 1) do              //and for each form page
        begin
          aComp := TCompColumn.Create;
          try
          aComp.FCX.FormID := doc.docForm[f].frmInfo.fFormUID;
          aComp.FCX.Form := f;
          aComp.FCX.Pg := p;
          CompID := aComp.FCompID;
          finally
           aComp.Free;
          end;
          for c := 0 to (doc.docForm[f].frmPage[p].pgData.Count - 1) do          //and for each page cell
            begin
              CurCell := doc.docForm[f].frmPage[p].pgData[c];
              case CurCell.FCellID of
               925: //address
                 begin
                   SubjAddr := CurCell.Text;
                 end;
               960: //Handle settle date rule
                 begin
                   if SubjAddr <> '' then
                   begin
                     if POS('S', UpperCase(CurCell.Text)) > 0 then
                       begin
                         inc(NumSettle);
                       end
                       else
                       begin
                         CurCellSettle := CurCell;
                         formNum := f;
                       end;
                   end;
                 end;
                 else
                 begin
                   ErrorMsg := ProcessFormRules(f,CompID, CurCell, doc);
                   if ErrorMsg <> '' then
                     AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
                 end;
              end;
            end;
        end;
        //check for settle date
        if NumSettle < 3 then
        begin
          if assigned(CurCellSettle) then
          begin
            if doc.UADEnabled then
            begin //Rule #FNM0085: only apply for UAD
              ErrorMsg := '* Less than three settled sales were used as comparables.';
              AddRecord(ErrorMsg, formNum, CurCellSettle.UID.Pg+1, CurCellSettle.UID.Num+1);
            end;
          end;
        end;
  except end;
end;


procedure TReviewer.AddRecord(text: String; frm,pg,cl: Integer);
var
  curCellID: TCellID;
  i: integer;
  criticalErr, criticalWarning: Boolean;
  theErrWarn: String;
begin
  if (pos('=====',text)<1) and (text<>'') and (pg>-1) and (frm>-1) then
    begin
      criticalErr := (Pos('**', text)= 1);
      criticalWarning := (Pos('*', text)= 1);
      if criticalErr then
        theErrWarn := Text    //keep ** in the grid
      else if criticalWarning then
        theErrWarn := Text
      else
        theErrWarn := Text;

      if theErrWarn <> '' then
        begin
          ReviewGrid.Rows := ReviewGrid.Rows + 1;   //Review MUST start at 0 rows
          i := ReviewGrid.Rows;

          curCellID := TCellID.Create;
          curCellID.Form := frm;
          curCellID.Pg := pg;
          curCellId.Num := cl;

          FReviewList.AddObject(theErrWarn, curCellID);    //so we can locate the cell accurately

          if criticalErr then          //set the global ReviewErr flag
            begin
              FReviewErrFound := True;
              Inc(FCriticalErrCount);
            end
          else if criticalWarning then
            begin
              FReviewCritialWarningFound := True;
              Inc(FCriticalWarningCount);
            end;
          ReviewGrid.Cell[colForm,i] := doc.docForm[frm].frmInfo.fFormName;
          ReviewGrid.Cell[colPg,i] := IntToStr(Pg);
          ReviewGrid.Cell[colCell,i] := IntToStr(cl);
          ReviewGrid.Cell[colErrorMessage,i] := theErrWarn;
          if criticalErr then
            ReviewGrid.RowColor[i] := CriticalError_Color
          else if criticalWarning then
            ReviewGrid.RowColor[i] := CriticalWarning_Color;

          AdjustGridHeigh(ReviewGrid,colErrorMessage,i);   //readjust the height of the error message column to fit long message
          ReviewGrid.Repaint;
        end;
    end;
end;




procedure TReviewer.InsertTitle(text: String; index: Integer);
var
  curCellID: TCellID;
begin
//  curCellID := TCellID.Create;
//  ReviewList.Items.InsertObject(index, text, curCellID);
end;

function GetReviewSriptHeaderFilePath(UADEnabled:Boolean; ScriptsPath:String):String;
begin
  if UADEnabled then
    result := scriptsPath + cUADScriptHeaderFileName
  else
    result := scriptsPath + cScriptHeaderFileName;
end;


function TReviewer.ReviewForm(form: TDocForm; formIndex: Integer; scriptFullPath: String; UADRpt:Boolean=False): Boolean;
var
  strmScr, strmFormScr: TMemoryStream;
  scriptsPath, filePath,frmName: String;
  script: TStringList;
  UADEnabled: Boolean;
begin
  result := False;
  scripter.AddObjectToScript(form, formObjectName,false);
  scriptsPath := IncludeTrailingPathDelimiter (ExtractFileDir(scriptFullPath));
//  filePath := scriptsPath + cScriptHeaderFileName;
//This will return either ScriptHeader.vbs or UADScriptHeader.vbs if UAD enable
  UADEnabled:=(Form.ParentDocument as TContainer).UADEnabled;
  filePath := GetReviewSriptHeaderFilePath(UADEnabled,ScriptsPath);
  if not FileExists(filePath) then
    begin
      ShowNotice(errCannotOpenFile + filePath);
      exit;
    end;
  strmScr := TMemoryStream.Create;
  strmScr.LoadFromFile(filePath);
  strmScr.Seek(0,soFromEnd);
  if not FileExists(scriptFullPath) then
    begin
      ShowNotice(errCannotOpenFile + scriptFullPath);
      exit;
    end;
  strmFormScr := TMemoryStream.Create;
  strmFormScr.LoadFromFile(scriptFullPath);
  strmScr.CopyFrom(strmFormScr,0);

  script := TStringList.Create;
  try
    scripter.StopScripts;
    strmScr.Position := 0;
    script.LoadFromStream(strmScr);
    scripter.Script := script;
    scripter.Run;

    if form.frmPage.Count > 1 then    //YF 05.24.02
      frmName := form.frmInfo.fFormName
    else  //to get the right title for comps
      frmName := form.frmPage[0].PgTitleName;
    scripter.DispatchMethod('Review',[frmName, formIndex, UADRpt]);
    if scripter.RunFailed then
      begin
        ShowNotice(msgCantReview + form.frmSpecs.fFormName);
        result := False;
      end
    else
      result := True;
  finally
    strmScr.Free;
    strmFormScr.Free;
    script.Free;
  end;
  scripter.RemoveItem(formObjectName);
end;

procedure TReviewer.OnRecDblClick(Sender: TObject);
var
  index: Integer;
  curForm: TDocForm;
  clID: TCellID;
  clUID: CellUID;
begin
  with TListBox(Sender) do
  begin
    index := itemIndex;
    clID := TCellID(Items.Objects[index]);
    if clID.form >= 0 then
      begin
        curForm := doc.docForm[clID.Form];
        clUID.Form := clID.Form;
        clUID.Pg := clID.Pg - 1;
        clUID.Num := clID.Num - 1;
        clUID.FormID := curForm.frmInfo.fFormUID;
        BringWindowToTop(doc.Handle);
        doc.SetFocus;
        doc.Switch2NewCell(doc.GetCell(clUID),cNotClicked);
    end;
  end;
end;

procedure TReviewer.OnCancel(Sender: TObject);
begin
  Release;
end;

procedure TReviewer.OnPrint(Sender: TObject);
var
  nLines, line: Integer;
  PrintText: TextFile;
begin
(*
  nLines := ReviewList.Items.Count;
  if nLines = 0 then
    exit;

//This line TMain is giving problems in
  if  TMain(Application.MainForm).PrintDialog.Execute then
  begin
    AssignPrn(PrintText);   {assigns PrintText to the printer}
    Rewrite(PrintText);     {creates and opens the output file}
    Printer.Canvas.Font := ReviewList.Canvas.Font;  {assigns Font settings to the canvas}
    for Line := 0 to nLines - 1 do
      Writeln(PrintText, ReviewList.Items[line]);	{writes the contents of the Memo1 to the printer object}
    CloseFile(PrintText); {Closes the printer variable}
  end;
*)
end;

procedure TReviewer.AdjustDPISettings;
begin
   Panel1.width := FormList.Width + btnGroup.Width + 10;
   self.Width := Panel1.width;
   self.Height := Panel1.height + ReviewGrid.Height + StatusBar.height + 120;
end;

procedure TReviewer.FormShow(Sender: TObject);
begin
   AdjustDPISettings;
end;


procedure TReviewer.LocateReviewErrOnForm(Index: Integer);
var
  curForm: TDocForm;
  clID: TCellID;
  clUID: CellUID;
begin
  clID := TCellID(FReviewList.Objects[Index]);
  if clID.form >= 0 then
    begin
      curForm := doc.docForm[clID.Form];
      clUID.Form    := clID.Form;
      clUID.Pg      := clID.Pg - 1;
      clUID.Num     := clID.Num - 1;
      clUID.FormID  := curForm.frmInfo.fFormUID;

      BringWindowToTop(Doc.Handle);
      Doc.SetFocus;
      Doc.Switch2NewCell(Doc.GetCell(clUID),cNotClicked);
    end;
end;

procedure TReviewer.ClearReviewErrorGrid;
begin
  FReviewList.Clear;
  ReviewGrid.BeginUpdate;
  ReviewGrid.Rows := 0;
  ReviewGrid.EndUpdate;
end;




procedure TReviewer.ReviewGridButtonClick(Sender: TObject; DataCol,
  DataRow: Integer);
begin
  LocateReviewErrOnForm(DataRow-1); //zero based
end;

procedure TReviewer.ReviewGridDblClickCell(Sender: TObject; DataCol,
  DataRow: Integer; Pos: TtsClickPosition);
begin
  if DataRow > 0 then     //header
    LocateReviewErrOnForm(DataRow-1); //zero based
end;

procedure TReviewer.ReviewGridGetDrawInfo(Sender: TObject; DataCol,
  DataRow: Integer; var DrawInfo: TtsDrawInfo);
begin
  if FPrinting then exit;
  //Change the font color to white if the cell color is Red
  if ReviewGrid.RowColor[DataRow]=clRed then
     DrawInfo.Font.Color := clWhite;
end;


procedure TReviewer.btnPrintClick(Sender: TObject);
begin
  if ReviewGrid.Rows = 0 then exit;
  FPrinting := True;
  ReviewGrid.PrintOptions.PrintTitle := 'ClickFORMS Review Scripts';
  ReviewGrid.Print;
  FPrinting := False;
end;

end.
