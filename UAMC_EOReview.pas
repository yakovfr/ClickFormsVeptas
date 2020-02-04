unit UAMC_EOReview;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons, osAdvDbGrid, ExtCtrls, dcsystem, dcscript,
  Grids_ts, TSGrid, ComCtrls,
  UContainer,UForm, AdvGlowButton, UAMC_Base, UAMC_WorkFlowBaseFrame, UGridMgr, UBase, UUADUtils,
  uCell, UUtil2, TsGridReport;

type
  TAMC_EOReview = class(TWorkflowBaseFrame)
    CFReviewErrorGrid: TosAdvDbGrid;
    Scripter: TDCScripter;
    bbtnReview: TBitBtn;
    bbtnToggleView: TBitBtn;
    stxWarnings: TStaticText;
    StaticText1: TStaticText;
    lblCriticalErrs: TLabel;
    lblCriticalWarning: TStaticText;
    btnPrint: TBitBtn;
    osGridReport1: TosGridReport;
    procedure CFReviewErrorGridButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure CFReviewErrorGridDblClickCell(Sender: TObject; DataCol,
      DataRow: Integer; Pos: TtsClickPosition);
    procedure bbtnReviewClick(Sender: TObject);
    procedure btnToggleViewClick(Sender: TObject);
    procedure CFReviewErrorGridGetDrawInfo(Sender: TObject; DataCol,
      DataRow: Integer; var DrawInfo: TtsDrawInfo);
    procedure btnPrintClick(Sender: TObject);
  private
    FErrorOverride: Boolean;
    FReviewErrFound: Boolean;
    FCriticalErrCount: Integer;
    FWarningErrCount: Integer;
    FReviewList: TStringList;
    FIsExpanded: Boolean;
    FReviewCritialWarningFound: Boolean;
    FCriticalWarningCount: Integer;
    FPrinting: Boolean;
    function GetScriptFileName(RevFileID, amcID:Integer):String;
    function GetReviewSriptFilePath(UADEnabled:Boolean; ScriptsPath:String):String;
    procedure SetGridColumnsReadOnly;
    procedure AdjustGridHeigh(var Grid:TosAdvDBGrid; aCol,aRow:Integer);
    function SkipZeroRoomsAdjustment(f,p,c:integer;CellText:String):boolean;

    procedure Review_byForm;
    procedure ValidateSalesDate_EffDate(SalesDate,EffDate:String; sCell: TBaseCell; f: Integer);
    function ReviewGrid(gridType: Integer; isUAD: boolean): Boolean;



  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    procedure StartProcess;         override;
    function ProcessedOK: Boolean;  override;
    procedure AddRecord(text: String; frm,pg,cl: Integer);
    procedure AddRecordDirect(text: String; frm,pg, cl: Integer; cellRelated: Boolean);
    procedure InsertTitle(text: String; index: Integer);
    function ReviewForm(AForm: TDocForm; formIndex: Integer; scriptFullPath: String; UADRpt:Boolean=False): Boolean;
    procedure ValidateCheckBoxes(AForm: TDocForm; frmIndex: integer);
    procedure ReviewReport;
    procedure DoReviewReport(overrideResults: Boolean);
    procedure LocateReviewErrOnForm(Index: Integer);
    procedure ClearReviewErrorGrid;
  end;


implementation

{$R *.dfm}

uses
  OleCtrls, SHDocVw,
  UGlobals, UUtil1, UWindowsInfo, UStatus, UStrings, UPage,
  UAMC_Delivery, UReviewRules, UAMC_Globals;

const
  msgCantReview:      String = 'Cannot Review ';
  formObjectName:     String = 'form';
  gridObjectName:     String = 'grid';
  scripterObjectName: String = 'scripter';
  fnGetCellName:      String = 'GetCellText';
  fnAddRecordName:    String = 'AddRecord';
  fnInsertTitleName:  String = 'InsertTitle';
  fnGetCellValue:     String = 'GetCellValue';
  fnGetCellUADError:  String = 'GetCellUADError';
  fnCellImageEmpty: String  = 'CellImageEmpty';
  fnGetCompDescription: String = 'GetCompDescription';
  fnGetCompCellLocation: String = 'GetCompCellLocation';
  fnGridValidateCellID: String = 'ValidateCellID';
  fnisColumnEmpty: String = 'isColumnEmpty';

  cScriptHeaderFileName = 'ScriptHeader.vbs';     //name of definition review script file
  cUADScriptHeaderFileName = 'UADScriptHeader.vbs'; //name of definition review script file
  {     //never used
  cTmpScriptFileName    = 'RealScript.vbs';       //name of united (header and checks) review script

  defsScrFileName = 'defsscr.vbs';         //name of definition review script file
  tmpScrFileName  = 'realscr.vbs';          //name of united (definition and form) review script     }

  {PCV is not part Workflow. It handled in UGSEUploadXML
  cPCVScriptHeaderFileName = 'PCVScriptHeader.vbs';     //name of definition review script file
  cPCVUADScriptHeaderFileName = 'PCVUADScriptHeader.vbs'; //name of definition review script file
  wfPCVMurcor     = 7;   }


type
  TTDocFormGetCellText  = function(page: Integer; cell: Integer): String of Object;
  TTDocFormGetCellValue = function(page: Integer; cell: Integer): Double of Object;
  TTReviewerAddRecord   = procedure(text: String; form,page,cell: Integer) of Object;
  TTReviewerInsertTitle = procedure(text: String; index: Integer) of Object;
  TTDocFormGetCellUADError = function(page: Integer; cell: Integer): Boolean of Object; //UAD vaildation error flag
  TTDocFormCellImageEmpty = function(page: Integer; cell: Integer): Boolean of Object;
  TTDocGridGetCompDescription = function(compNo, cellID: Integer): string of Object;
  TTDocGridGetCompCellLocation = function(compNo, cellID: Integer): string of Object;
  TTDocGridValidateCellID = function(cellID: Integer): boolean of Object;
  TTDocGridisColumnEmpty = function(compNo: Integer):boolean of Object;

  TCellID = class(TObject)    //Special Cell identifier for Reviewer
    Form: Integer;            //form index in formList
    Pg: Integer;              //page index in form's pageList
    Num: Integer;             //cell index in page's cellList
    constructor Create;
  end;



{ TCellID }

constructor TCellID.Create;
begin
  inherited Create;

  Form := - 1;
  Pg   := -1;
  Num  := -1;
end;


{ TAMC_EOReview }

constructor TAMC_EOReview.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;
  //Make all column as ReadOnly except locate button column
///  SetGridColumnsReadOnly;
  if assigned(FDoc) then
    FReviewList := TStringList.Create;

  //these are the calls needed to run the review scripts
  RegisterProc(TDocForm, fnGetCellName, mtMethod, TypeInfo(TTDocFormGetCellText),
        [TypeInfo(Integer), TypeInfo(Integer), TypeInfo(String)],
        Addr(TDocForm.GetCellText), cRegister);

  RegisterProc(TDocForm, fnGetCellValue, mtMethod, TypeInfo(TTDocFormGetCellValue),
        [TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Double)],
        Addr(TDocForm.GetCellValue), cRegister);

  RegisterProc(TAMC_EOReview, fnAddRecordName, mtMethod, TypeInfo(TTReviewerAddRecord),
        [TypeInfo(String), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(integer)],
        Addr(TAMC_EOReview.AddRecord),cRegister);

  RegisterProc(TAMC_EOReview, fnInsertTitleName, mtMethod, TypeInfo(TTReviewerInsertTitle),
        [TypeInfo(String), TypeInfo(Integer)],
        Addr(TAMC_EOReview.InsertTitle), cRegister);

  RegisterProc(TDocForm,fnGetCellUADError,mtMethod,TypeInfo(TTDocFormGetCellUADError),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(Boolean)],
        Addr(TDocForm.GetCellUADError),cRegister);

  RegisterProc(TDocForm,fnCellImageEmpty,mtMethod,TypeInfo(TTDocFormCellImageEmpty),
        [TypeInfo(Integer),TypeInfo(Integer),TypeInfo(Boolean)],
        Addr(TDocForm.CellImageEmpty),cRegister);
  RegisterProc(TGridMgr, fnGetCompDescription, mtMethod, TypeInfo(TTDocGridGetCompDescription),
        [TypeInfo(Integer), TypeInfo(Integer), TypeInfo(String)],
        Addr(TgridMgr.GetCompDescription), cRegister);
  RegisterProc(TGridMgr, fnGetCompCellLocation, mtMethod, TypeInfo(TTDocGridGetCompCellLocation),
        [TypeInfo(Integer), TypeInfo(Integer), TypeInfo(String)],
        Addr(TgridMgr.GetCompCellLocation), cRegister);
  RegisterProc(TGridMgr, fnGridValidateCellID, mtMethod, TypeInfo(TTDocGridValidateCellID),
        [TypeInfo(Integer), TypeInfo(Boolean)],
        Addr(TgridMgr.ValidateCellID), cRegister);
  RegisterProc(TGridMgr, fnisColumnEmpty, mtMethod, TypeInfo(TTDocGridisColumnEmpty),
        [TypeInfo(Integer), TypeInfo(Boolean)],
        Addr(TgridMgr.isColumnEmpty), cRegister);

  scripter.AddObjectToScript(self,scripterObjectName,false);
  scripter.Language := 'VBScript';

  FIsExpanded := True;
end;

function TAMC_EOReview.ProcessedOK: Boolean;
begin
  //assume everything fine
  PackageData.FGoToNextOk := True;
  PackageData.FHardStop := False;
  PackageData.FAlertMsg := '';
  PackageData.FReviewOverride := FErrorOverride;    //remember for RELS

  //were critical errors found?
  if not FErrorOverride then
    if FCriticalErrCount > 0 then
      begin
        PackageData.FGoToNextOk := False;
        PackageData.FHardStop := True;
        PackageData.FAlertMsg := IntToStr(FCriticalErrCount) + ' Critical errors were found. Please fix them before moving to the next step.';
      end
    else if FCriticalWarningCount > 0 then
      begin
        PackageData.FGoToNextOk := Not WarnOK2Continue(IntToStr(FCriticalWarningCount) + ' Critical Warning(s) were found. Do you want to fix them before proceeding to the next step?');
      end
    else if FWarningErrCount > 0 then
      begin
        PackageData.FGoToNextOk := Not WarnOK2Continue(IntToStr(FWarningErrCount) + ' Warning issues were found. Do you want to fix them before proceeding to the next step?');
      end;

  result := PackageData.FGoToNextOk;
end;

//set column 1-5 to readonly except locate button column
procedure TAMC_EOReview.SetGridColumnsReadOnly;
var acol:Integer;
begin
    for aCol:= 1 to CFReviewErrorGrid.Cols do
        if aCol = colLocate then
           CFReviewErrorGrid.Col[aCol].ReadOnly := False
        else
           CFReviewErrorGrid.Col[aCol].ReadOnly := True;
end;

procedure TAMC_EOReview.CFReviewErrorGridButtonClick(Sender: TObject; DataCol, DataRow: Integer);
begin
  if TCellID(FReviewList.Objects[DataRow - 1]).Form >= 0 then //form defined
    LocateReviewErrOnForm(DataRow-1); //zero based
end;

procedure TAMC_EOReview.CFReviewErrorGridDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  if DataRow > 0 then     //header
    if TCellID(FReviewList.Objects[DataRow - 1]).Form >= 0 then  //form defined
      LocateReviewErrOnForm(DataRow-1); //zero based
end;

procedure TAMC_EOReview.LocateReviewErrOnForm(Index: Integer);
var
  curForm: TDocForm;
  clID: TCellID;
  clUID: CellUID;
begin
  clID := TCellID(FReviewList.Objects[Index]);
  if clID.form >= 0 then
    begin
      curForm := Fdoc.docForm[clID.Form];
      clUID.Form    := clID.Form;
      clUID.Pg      := clID.Pg - 1;
      clUID.Num     := clID.Num - 1;
      clUID.FormID  := curForm.frmInfo.fFormUID;

      BringWindowToTop(FDoc.Handle);
      FDoc.SetFocus;
      FDoc.Switch2NewCell(FDoc.GetCell(clUID),cNotClicked);
    end;
end;

procedure TAMC_EOReview.bbtnReviewClick(Sender: TObject);
begin
  ReviewReport;
end;

procedure TAMC_EOReview.StartProcess;
begin
  PackageData.FGoToNextOk := False;    //do not move to the next peocess untill current completed
  ReviewReport;
end;

procedure TAMC_EOReview.ReviewReport;
begin
  FDoc.CommitEdits;                   //in case the user did not tab out of cell
  FDoc.Save;                          //or save
  FErrorOverride := ShiftKeyDown;    //send this flag to XML Exporter
  FCriticalWarningCount := 0;        //Initialze the counter to 0 when we first run
  DoReviewReport(FErrorOverride);
  AdvanceToNextProcess;               //auto aaadvance
end;

function TAMC_EOReview.GetScriptFileName(RevFileID, amcID:Integer):String;
begin
  {PCV is not part Workflow. It handled in UGSEUploadXML
  //use PCV review script for PCV
  if PackageData.FWorkflowUID = wfPCVMurcor then
  begin
      result := Format('REV%5.5d_PCV.vbs',[RevFileID]);
  end
  else }
  case amcID of
    AMC_GENERAL:
      result := Format('REV%5.5d.vbs',[RevFileID]);
    AMC_EADPortal:
      result := Format('REV%5.5d_ead.vbs',[RevFileID]);
    else
      result := '';
  end;
end;

//This will skip the warning error for adjustment above grade room count Empty
function TAMC_EOReview.SkipZeroRoomsAdjustment(f,p,c:integer;CellText:String):boolean;
var aFormID:Integer;
begin
   result := False;
   if CellText<>'' then exit;
   if assigned(FDoc) then
      aFormID := FDoc.docForm[f].FormID;
   case aFormID of
    340,4218,355, 4365: result := (p = 1) and ((c = 73) or (c = 133) or (c = 193));
    345,347: result := (p = 2) and ((c = 86) or (c = 154) or (c = 222));
    363: result := (c = 77) or (c = 138) or (c = 199);  //1004 & 2055 extra comp
    367: result := (c = 89) or (c = 158) or (c = 227);  //1073 & 1075 extra comp
   end;
end;

procedure TAMC_EOReview.DoReviewReport(overrideResults: Boolean);
const
 cSubjCondXID = 520;
 MismatchCond = '**The subject property condition code (C1-C6) does not match the code';
 MismatchKit = '**The subject property kitchen status (Kitchen-...) does not match the status';
 MismatchBath = '**The subject property bathroom status (Bathrooms-...) does not match the status';
 MismatchUse = ' in the UAD Comments Addendum. Use the UAD: Subject Condition dialog to ensure that the items match.';
 adjustWarn1 = 'The Subject and Comparable Descriptions are Different-If no Adjustment is Warranted, please enter zero (0) in the Adjustments Column.';
 adjustWarn2 = 'The Subject and Comparable Descriptions are Identical-If no Adjustment is Warranted, please remove the zero (0) from the Adjustments Column.';
var
  n,RevFileID: Integer;
  ScriptFilePath, ScriptName: String;
  signList: TStringList;
  CurCell: TBaseCell;
  formList: BooleanArray;
	toForm: TDocForm;
  toPage: TDocPage;
  f,p,c: Integer;
  CellLenStr: String;
  pageGrid: TCompMgr2;
  sl: TStringList;
  cCount: Integer;
  isUADreport: Boolean;
  isInvoiceIncluded: Boolean;
begin
  PushMouseCursor(crHourGlass);
  isUADReport := PackageData.IsUAD;
  sl := TStringList.Create;
  try
    formList := PackageData.FormList;

    FReviewErrFound := False;
    FCriticalErrCount := 0;
    FWarningErrCount := 0;
    ClearReviewErrorGrid;

    FReviewList.Clear;

    RevFileID := 0;
    try
      // process non blank UAD cells and post any UAD validation errors
      //*** Hard Stop: Form Mismatch Rule: If main form does not match with cert page or XComp page, show stop
      cCount := 0; //always show at the first line if fails
      cCount := CheckRuleMisMatch(FormList,Fdoc.docForm,FReviewList,sl,CFReviewErrorGrid);
      //***
      if (PackageData.NeedX26GSE) or (PackageData.IsUAD) then //The NeedX26GSE is not set yet but the IsUAD is
        for f := 0 to (FDoc.docForm.Count - 1) do
          if formList[f] then                                          //only selected forms
            begin
              toForm := FDoc.docForm[f];                               //for each form
              for p := 0 to (toForm.frmPage.count - 1) do              //and for each form page
                begin
                  toPage := toForm.frmPage[p];
                  pageGrid := TCompMgr2.Create(true);
                  try
                    pageGrid.BuildPageGrid(toPage,gtSales);
                    for c := 0 to (toPage.pgData.Count - 1) do          //and for each page cell
                      begin
                        CurCell := toPage.pgData[c];
                        if assigned(CurCell) and (CurCell.Text <> '') then
                            begin
                              if CurCell.HasValidationError then
                                begin
                                  CellLenStr := IntToStr(Length(CurCell.Text));
                                  if (CurCell.FMaxLength > 0) and (Length(CurCell.Text) > CurCell.FMaxLength) then
                                    AddRecordDirect('The text length of ' + CellLenStr + ' is greater than the UAD maximum of ' + IntToStr(CurCell.FMaxLength) + '.', f, Succ(p), Succ(c), true)
                                  else if (CurCell.FMinLength > 0) and (Length(CurCell.Text) < CurCell.FMinLength) then
                                    AddRecordDirect('The text length of ' + CellLenStr + ' is less than the UAD minimum of ' + IntToStr(CurCell.FMinLength) + '.', f, Succ(p), Succ(c),true)
                                  else  //Get rid of the ** to avoid hard stop for text length checking
                                    AddRecordDirect('Cell contents do not comply with UAD standards.', f, Succ(p), Succ(c), true);
                                end;

                            end;
                      end;
                  finally
                    pageGrid.Free;
                  end;
                end;
            end;

      //now process any regular errors
      isInvoiceIncluded := false;
      for n := 0 to FDoc.docForm.count-1 do
        if formList[n] then                  //this form is going to be exported
          begin
            //attempt regular review of this form
            RevFileID := Fdoc.docForm[n].frmInfo.fFormUID;
            isInvoiceIncluded := isInvoiceIncluded or (Fdoc.docForm[n].frmInfo.fFormKindID = fkInvoice);
            ScriptName := GetScriptFileName(RevFileID, AMC_GENERAL);
            ScriptFilePath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) + ScriptName;

            if FileExists(ScriptFilePath) then
              ReviewForm(Fdoc.docForm[n], n, ScriptFilePath, (PackageData.NeedX26GSE or PackageData.IsUAD));  //The NeedX26GSE is not set yet but the IsUAD is
           { else    //absolutely the same as above
            begin  //use std
              ScriptName := Format('REV%5.5d.vbs',[RevFileID]);
              ScriptFilePath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) + ScriptName;
              if fileExists(ScriptFilePath) then
                ReviewForm(Fdoc.docForm[n], n, ScriptFilePath, (PackageData.NeedX26GSE or PackageData.IsUAD)); //The NeedX26GSE is not set yet but the IsUAD is
            end;     }
          {  //if additional script exists for the form
            ScriptName := GetScriptFileName(RevFileID, PackageData.FAMC_UID);
            ScriptFilePath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) + ScriptName;

            if FileExists(ScriptFilePath) then
              ReviewForm(Fdoc.docForm[n], n, ScriptFilePath, (PackageData.NeedX26GSE or PackageData.IsUAD));    }
          end;
      if (CompareText(PackageData.FState, 'NY') = 0) and not isInvoiceIncluded then
        AddRecordDirect('*Your state requires the invoice be included as part of the report',0,0,0, false);

      ReviewGrid(gtSales, isUADReport);
      ReviewGrid(gtListing, isUADReport);
      Review_byForm;

      // about signature
      signList := Fdoc.GetSignatureTypes;
      if assigned(signList) then //the report needs the signature
        if Fdoc.docSignatures.Count = 0 then //the report is not signed
          scripter.CallNoParamsMethod('Signature');
      if true then //bReviewed then
        scripter.DispatchMethod('AddReviewHeader',[Fdoc.docFileName]);

      //now let's add special review for given AMC
      for n := 0 to FDoc.docForm.count-1 do
        if formList[n] then                  //this form is going to be exported
          begin
            //attempt regular review of this form
            RevFileID := Fdoc.docForm[n].frmInfo.fFormUID;
            ScriptName := GetScriptFileName(RevFileID, PackageData.FAMC_UID);
            ScriptFilePath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) + ScriptName;

            if FileExists(ScriptFilePath) then
              ReviewForm(Fdoc.docForm[n], n, ScriptFilePath, (PackageData.NeedX26GSE or PackageData.IsUAD));
          end;

    except
      ShowNotice('There was a problem reviewing Form ID: '+IntToStr(RevFileID));
    end;
  finally
    sl.Free;
    PopMouseCursor;
    Fdoc.docHasBeenReviewed := True;   //no need to review on close.
    FCriticalErrCount := FCriticalErrCount + cCount;
    FWarningErrCount := CFReviewErrorGrid.Rows - (FCriticalErrCount + FCriticalWarningCount);
    stxWarnings.caption := IntToStr(FWarningErrCount) + ' Warning(s)';
    lblCriticalWarning.Caption := Format('%d Critical Warning(s)',[FCriticalWarningCount]);
    lblCriticalErrs.Caption := IntToStr(FCriticalErrCount) + ' Critical Error(s)';

    FReviewErrFound := CFReviewErrorGrid.Rows > 0;   //there are errors

    if FReviewErrFound then
      bbtnReview.Caption := 'Re-Review';

    self.SetFocus;  //due to drawing bugs
    Self.Repaint;   //due to drawing bugs
  end;
end;


//SalesDate can be: sMM/YY; cMM/YY
procedure  TAMC_EOReview.ValidateSalesDate_EffDate(SalesDate,EffDate:String; sCell: TBaseCell; f: Integer);
var
  sDate, eDate: TDateTime;
  settle, contract: String;
  m, d, y : String;
  ErrorMsg: String;
  isUADReport: Boolean;
begin
  try
    isUADReport := PackageData.IsUAD;
    SalesDate := UpperCase(SalesDate);
    if POS('S', SalesDate) > 0 then  //we have settle date
      begin
        settle := popStr(SalesDate, ';');
        contract := SalesDate;  //this is contract date
        //Get Settle date
        if pos('/', settle) > 0 then
          begin  //extract mm and yy
            m := popStr(settle, '/');
            y := settle;
            if (GetFirstIntValue(m) > 0) and (GetFirstIntValue(y) > 0) then
            settle := Format('%d/01/%d',[GetFirstIntValue(m), GetFirstIntValue(y)]);
            sDate := StrToDate(settle);
          end;
        if isValidDate(EffDate, eDate, True) then
          if (eDate < sDate) then  //if settle date is After the effective date, show error
            begin
               if isUADReport then
                 ErrorMsg := Format('** Sales Date AFTER Effective Date.',[EffDate])
               else
                 ErrorMsg := Format('Sales Date AFTER Effective Date.',[EffDate]);
               AddRecordDirect(ErrorMsg, f, sCell.UID.pg+1, sCell.UID.Num+1, true);
            end;
      end
    else if POS(';', SalesDate) = 0 then
      begin //Non UAD sales date
        //Get Settle date
        if IsValidDate(SalesDate, sDate, True) then
          begin
            if isValidDate(EffDate, eDate, True) then
              if (eDate < sDate) then
              begin
                if isUADReport then
                  ErrorMsg := Format('** Sales Date AFTER Effective Date.',[EffDate])
                else
                  ErrorMsg := Format('Sales Date AFTER Effective Date.',[EffDate]);
                AddRecordDirect(ErrorMsg, f, sCell.UID.pg+1, sCell.UID.Num+1, true);
              end;
          end;
      end;
  except ; end;
end;


procedure TAMC_EOReview.Review_byForm;
var
  f,p,c: Integer;
  CurCell, CurCellSettle, eCell: TBaseCell;
  aComp: TCompColumn;
  CompID: Integer;

  NumSettle, formNum: Integer;
  ErrorMsg, SubjAddr, aTemp: String;
  effDate, salesDate: String;
  formList: BooleanArray;
  isUADReport: Boolean;
begin
  try
    formList := PackageData.FFormList;
    isUADReport := PackageData.IsUAD;
    NumSettle := 0;
    for f := 0 to (Fdoc.docForm.Count - 1) do
      if formList[f] then
      for p := 0 to (Fdoc.docForm[f].frmPage.count - 1) do              //and for each form page
        begin
          aComp := TCompColumn.Create;
          try
          aComp.FCX.FormID := Fdoc.docForm[f].frmInfo.fFormUID;
          aComp.FCX.Form := f;
          aComp.FCX.Pg := p;
          CompID := aComp.FCompID;
          finally
           aComp.Free;
          end;
          for c := 0 to (Fdoc.docForm[f].frmPage[p].pgData.Count - 1) do          //and for each page cell
            begin
              CurCell := Fdoc.docForm[f].frmPage[p].pgData[c];
              case CurCell.FCellID of
               925: //address
                 begin
                   SubjAddr := CurCell.Text;
                 end;
               960: //Handle settle date rule
                 begin
                   if SubjAddr <> '' then
                   begin
(*  Hold off: since we put this rule in Review script file already...
                     eCell := Fdoc.GetCellByID(1132);   //effective date
                     if assigned(eCell) then
                       begin
                         EffDate := eCell.Text;
                         SalesDate := CurCell.Text;
                         if (SalesDate <> '') and (EffDate <> '') then
                           ValidateSalesDate_EffDate(SalesDate,EffDate, curCell, f);
                       end;
*)
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
                   ErrorMsg := ProcessFormRules(f,CompID, CurCell, Fdoc);
                   if ErrorMsg <> '' then
                     AddRecordDirect(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1, true);
                 end;
              end;
            end;
        end;
        //check for settle date
        if (NumSettle > 0) and (NumSettle < 3) then
        begin
          if assigned(CurCellSettle) then
          begin
            if isUADReport then
            begin  //down grade to critical warning
              ErrorMsg := '* Less than three settled sales were used as comparables.';
              AddRecordDirect(ErrorMsg, formNum, CurCellSettle.UID.Pg+1, CurCellSettle.UID.Num+1, true);
            end;
          end;
        end;
  except end;
end;


procedure TAMC_EOReview.ClearReviewErrorGrid;
begin
  FReviewList.Clear;
  CFReviewErrorGrid.BeginUpdate;
  CFReviewErrorGrid.Rows := 0;
  CFReviewErrorGrid.EndUpdate;
end;

//Registered Review Script Routine
procedure TAMC_EOReview.AddRecord(text: String; frm,pg,cl: Integer);
var
  curCellID: TCellID;
  i: integer;
  criticalErr,criticalWarning: Boolean;
  theErrWarn: String;
begin
  if (pos('=====',text)<1) and (text<>'') and (pg>-1) and (frm>-1) then
    begin
      criticalErr := (Pos('**', text)= 1);
      criticalWarning := (Pos('*', text)= 1);
      if criticalErr then
        theErrWarn := StringReplace(Text, '**', '', [])
      else if criticalWarning then //and appPref_AMCDelivery_EOWarnings and PackageData.IsUAD then //always show critical warnings
        theErrWarn := StringReplace(Text, '*', '', [])
      else if appPref_AMCDelivery_EOWarnings then
        theErrWarn := Text
      else
        theErrWarn := '';
      if theErrWarn <> '' then
        begin
          CFReviewErrorGrid.Rows := CFReviewErrorGrid.Rows + 1;   //Review MUST start at 0 rows
          i := CFReviewErrorGrid.Rows;

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
          else if criticalWarning then //and appPref_AMCDelivery_EOWarnings and (PackageData.IsUAD)  then
            begin
              FReviewCritialWarningFound := True;
              Inc(FCriticalWarningCount);
            end;

          CFReviewErrorGrid.Cell[colForm,i] := Fdoc.docForm[frm].frmInfo.fFormName;
          CFReviewErrorGrid.Cell[colPg,i] := IntToStr(Pg);
          CFReviewErrorGrid.Cell[colCell,i] := IntToStr(cl);
          CFReviewErrorGrid.Cell[colErrorMessage,i] := theErrWarn;
          if criticalErr then
            CFReviewErrorGrid.RowColor[i] := CriticalError_Color
          else if criticalWarning then //and appPref_AMCDelivery_EOWarnings and (PackageData.IsUAD) then
            CFReviewErrorGrid.RowColor[i] := CriticalWarning_Color;

          AdjustGridHeigh(CFReviewErrorGrid,colErrorMessage,i);   //readjust the height of the error message column to fit long message
          CFReviewErrorGrid.Repaint;
        end;
    end;
end;

//unlike AddRecord function called from running VB script and registered with VB script engine (dee unit dcscript)
// this one calling from ClickFoms code and does not neet registration
//Some times the erorr has report range and can not be located with form, page, and cell
procedure TAMC_EOReview.AddRecordDirect(text: String; frm,pg,cl: Integer; cellRelated: Boolean);
var
  curCellID: TCellID;
  i: integer;
  criticalErr,criticalWarning: Boolean;
  theErrWarn: String;
begin
  if (pos('=====',text)<1) and (text<>'') and (pg>-1) and (frm>-1) then
    begin
      criticalErr := (Pos('**', text)= 1);
      criticalWarning := (Pos('*', text)= 1);
      if criticalErr then
        theErrWarn := StringReplace(Text, '**', '', [])
      else if criticalWarning then //and appPref_AMCDelivery_EOWarnings and PackageData.IsUAD then //always show critical warnings
        theErrWarn := StringReplace(Text, '*', '', [])
      else if appPref_AMCDelivery_EOWarnings then
        theErrWarn := Text
      else
        theErrWarn := '';
      if theErrWarn <> '' then
        begin
          CFReviewErrorGrid.Rows := CFReviewErrorGrid.Rows + 1;   //Review MUST start at 0 rows
          i := CFReviewErrorGrid.Rows;

          curCellID := TCellID.Create;
          if cellrelated then
            begin
              curCellID.Form := frm;
              curCellID.Pg := pg;
              curCellId.Num := cl;
            end
          else
            begin      //thre are no form, page, or cell to locate It is report scale error
              curCellID.Form := -1;
              curCellID.Pg := 0;
              curCellID.Num := 0;
            end;
          FReviewList.AddObject(theErrWarn, curCellID);    //so we can locate the cell accurately

          if criticalErr then          //set the global ReviewErr flag
            begin
              FReviewErrFound := True;
              Inc(FCriticalErrCount);
            end
          else if criticalWarning then //and appPref_AMCDelivery_EOWarnings and (PackageData.IsUAD)  then
            begin
              FReviewCritialWarningFound := True;
              Inc(FCriticalWarningCount);
            end;

          // some errors are report rather range than cell range; we do not have locate such errors
          if cellRelated then
            CFReviewErrorGrid.Cell[colForm,i] := Fdoc.docForm[frm].frmInfo.fFormName
          else
            CFReviewErrorGrid.Cell[colForm,i] := '';
          if cellRelated then
            CFReviewErrorGrid.Cell[colPg,i] := IntToStr(Pg)
          else
            CFReviewErrorGrid.Cell[colPg,i] := '';
          if cellRelated then
            CFReviewErrorGrid.Cell[colCell,i] := IntToStr(cl)
          else
            CFReviewErrorGrid.Cell[colCell,i] := '';
          CFReviewErrorGrid.Cell[colErrorMessage,i] := theErrWarn;
          if criticalErr then
            CFReviewErrorGrid.RowColor[i] := CriticalError_Color
          else if criticalWarning then //and appPref_AMCDelivery_EOWarnings and (PackageData.IsUAD) then
            CFReviewErrorGrid.RowColor[i] := CriticalWarning_Color;

          AdjustGridHeigh(CFReviewErrorGrid,colErrorMessage,i);   //readjust the height of the error message column to fit long message
          CFReviewErrorGrid.Repaint;
        end;
    end;
end;

//Registered Review Script Routine
procedure TAMC_EOReview.InsertTitle(Text: String; index: Integer);
begin
// Normally this is where review item list gets built
//  curCellID := TCellID.Create;
//  ReviewList.Items.InsertObject(index,text,curCellID);
end;

function TAMC_EOReview.GetReviewSriptFilePath(UADEnabled:Boolean; ScriptsPath:String):String;
begin
  {PCV is not part Workflow. It handled in UGSEUploadXML
  //use PCV review script for PCV
  if PackageData.FWorkflowUID = wfPCVMurcor then
  begin
    if UADEnabled then
    begin
       result := scriptsPath + cPCVUADScriptHeaderFileName;
       if not FileExists(result) then //if no pcv script file use the standard one
         result := scriptsPath + cUADScriptHeaderFileName;
    end
    else
    begin
       result := scriptsPath + cPCVScriptHeaderFileName;
       if not FileExists(result) then //if no pcv script file use the standard one
         result := scriptsPath + cScriptHeaderFileName;
    end;
  end
  else  }
  begin
    if UADEnabled then
       result := scriptsPath + cUADScriptHeaderFileName
    else
       result := scriptsPath + cScriptHeaderFileName;
  end;
end;


//Registered Review Script Routine
function TAMC_EOReview.ReviewForm(AForm: TDocForm; formIndex: Integer; scriptFullPath: String; UADRpt:Boolean=False): Boolean;
var
  strmScr, strmFormScr: TMemoryStream;
  scriptsPath, filePath,frmName: String;
  script: TStringList;
begin
  result := False;
  scripter.AddObjectToScript(AForm, formObjectName,false);
  scriptsPath := IncludeTrailingPathDelimiter(ExtractFileDir(scriptFullPath));
  //filePath := GetReviewSriptFilePath((AForm.ParentDocument as TContainer).UADEnabled, scriptsPath);
  filePath := GetReviewSriptFilePath(UADRpt, scriptsPath);
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

    if AForm.frmPage.Count > 1 then
      frmName := AForm.frmInfo.fFormName
    else
      frmName := AForm.frmPage[0].PgTitleName; //to get the right title for comps

    scripter.DispatchMethod('Review',[frmName, formIndex, UADRpt]);    //,UADRpt
    if scripter.RunFailed then
      begin
        ShowNotice(msgCantReview + AForm.frmSpecs.fFormName);
        result := False;
      end
    else
      begin
        result := True;
        ValidateCheckBoxes(AForm, formIndex);
      end;
  finally
    strmScr.Free;
    strmFormScr.Free;
    script.Free;
  end;
  scripter.RemoveItem(formObjectName);
end;

procedure TAMC_EOReview.ValidateCheckBoxes(AForm: TDocForm; frmIndex: integer);
var
  pg,idx: integer;
  xCel: TBaseCell;
begin
  for pg := 0 to AForm.frmPage.Count -1 do
    begin
      for idx := 0 to TDocPage(AForm.frmPage[pg]).pgData.Count -1 do
        begin
           xCel := TDocPage(AForm.frmPage[pg]).pgData.Items[idx];
           if xCel is TChkBoxCell then
             begin
               if (xCel.Text<>'') and (xCel.Text<>' ') then
                 if uppercase(xCel.Text)<>'X' then
                   AddRecordDirect('**Checkbox has Invalid Character',frmIndex,pg+1,xCel.GetCellIndex+1, true);
             end;
        end;
    end;
end;

procedure TAMC_EOReview.btnToggleViewClick(Sender: TObject);
begin
  TAMCDeliveryProcess(TPageControl(TTabSheet(Self.Owner).PageControl).Owner).ToggleWindowSize;

  //Toggle the Button caption
  FIsExpanded := not FIsExpanded;
  if FIsExpanded then
    bbtnToggleView.Caption := 'Collapse Window'
  else
    bbtnToggleView.Caption := 'Expand Window';
end;

procedure TAMC_EOReview.AdjustGridHeigh(var Grid:TosAdvDBGrid; aCol,aRow:Integer);
var
  aTextWidth,aColWidth: Integer;
  aText:String;
begin
  //go through grid column with the current row to find the max text width for that row
  aText := Grid.Cell[aCol,aRow];
  aTextWidth := Grid.Canvas.TextWidth(aText);
  acolWidth  := Grid.Col[aCol].Width;
  if aTextWidth  > acolWidth then
  begin
      Grid.RowHeight[aRow]   := Pred(Round(aTextWidth / aColWidth)) * Trunc(Grid.RowOptions.DefaultRowHeight / 2) + Grid.RowOptions.DefaultRowHeight;
      Grid.RowWordWrap[aRow] := wwOn;
  end;
end;


procedure TAMC_EOReview.CFReviewErrorGridGetDrawInfo(Sender: TObject;
  DataCol, DataRow: Integer; var DrawInfo: TtsDrawInfo);
begin
  inherited;
  if FPrinting then exit;
  //Change the font color to white if the cell color is Red
  if CFReviewErrorGrid.RowColor[DataRow]=clRed then
     DrawInfo.Font.Color := clWhite;
end;

function TAMC_EOReview.ReviewGrid(gridType: Integer; isUAD: boolean): Boolean;
var
  AGrid: TGridMgr;
  nComps: Integer;
  scriptName, scriptPath: String;
  script: TStringList;
begin
  result := false;
  try
  AGrid := TGridMgr.Create(true);
  try
    AGrid.BuildGrid(FDoc,gridType);
    nComps := AGrid.Count;     //including subject
    if nComps = 0 then
      exit;
    {if FData.AMCIdentifier = AMC_PCVMurcor then
      scriptName := 'REVGrid' + AGrid.GridName + '_PCV.vbs'
    else }
      scriptName := 'REVGrid' + AGrid.GridName + '.vbs';
    ScriptPath := IncludeTrailingPathDelimiter(appPref_DirReviewScripts) + ScriptName;
    if FileExists(scriptPath) then
    begin
      script := TStringList.Create;
      try
        Script.LoadFromFile(scriptPath);
        scripter.AddObjectToScript(AGrid,gridObjectName,false);
        try
          scripter.StopScripts;
          scripter.Script := script;
          scripter.Run;
          scripter.DispatchMethod('ReviewGrid',[nComps, isUAD]);
          if scripter.RunFailed then
            begin
              ShowNotice(msgCantReview + AGrid.GridName + 'grid!');
              result := False;
            end
          else
            result := True;
        finally
          scripter.RemoveItem(gridObjectName);
        end;
      finally
        script.Free;
      end;
    end;
  finally
    AGrid.Free;
  end;
  except end;
end;

procedure TAMC_EOReview.btnPrintClick(Sender: TObject);
begin
  if CFReviewErrorGrid.Rows = 0 then exit;
  FPrinting := True;
  CFReviewErrorGrid.PrintOptions.PrintTitle := 'ClickFORMS E&O Review';
  CFReviewErrorGrid.Print;
  FPrinting := False;
end;

end.
