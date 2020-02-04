unit UExportAppraisalPort;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, XMLDoc,
  UContainer, UForms, UGlobals, CheckLst, Grids, Grids_ts, TSGrid, osAdvDbGrid;

type
  FormConvRec = record
    id: Integer;
    bLH: Boolean;
    bAir: Boolean;
    altForm: String;   //50 char string
  end;

  //special string object for finding string (formID) within a set of strings
  TFormStrList = class(TStringList)
    function Find(const S: string; var Index: Integer): Boolean; override;
  end;

  TExportAppraisalPort = class(TVistaAdvancedForm)
    Panel1: TPanel;
    btnClose: TButton;
    Image1: TImage;
    FormGrid: TosAdvDbGrid;
    Panel2: TPanel;
    Label2: TLabel;
    edtCurReport: TEdit;
    Button1: TButton;
    btnExport: TButton;
    procedure btnExportClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OnCellShiftClick(Sender: TObject; DataColDown, DataRowDown,
      DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
  private
    FDoc: TContainer;
    FConvForms: TFormStrList;
    FNeedsAltForm: Boolean;
    FCountNoForm: Integer;
    FCountMaybe: Integer;
    FConvToImageAll: Boolean; //flag to switch all checked/all unchecked
    procedure AdjustDPISettings;
    function GetFormsToImage: IntegerArray;
    procedure InitFormGrid;
  public
    FMismoXML: String;
    constructor Create(AOwner: TComponent); override;
    function CanUseService: Boolean;
    function DoExport: Boolean;
    procedure CheckFormCompatibility(Doc: TContainer);
    procedure CheckForAlternates(N: Integer; doc: TContainer);
    function GetFormConversionInfo(rec: String): FormConvRec;
    procedure ShowAppraisalPortHelp;
  end;

  {This is the procedure that starts the export process}
  procedure ExportReportToAppraisalPort(ADoc: TContainer; mismoXML: String = '');

const
    colFormName = 1;
    colFormAvailable = 2;
    colConvertToImage = 3;

implementation

{$R *.dfm}

Uses
  UStatus, UStatusService, ULicUser, UFileExport,UStrings,
  UExportXMLPackage, UExportApprPortXML2, UViewHTML, UUtil1,UXMLConst,UCRMServices;

const
  ConvFormList  = 'ConvertableForms.lst';   //'ConvFormList.txt';
  tab = #09;
  ENVTipsURL    = 'http://bradfordsoftware.com/help/tellmehow/AIReady_Tips.htm';




procedure ExportReportToAppraisalPort(ADoc: TContainer; mismoXML: String = '');
var
  ExpAP: TExportAppraisalPort;
begin
  ExpAP := TExportAppraisalPort.Create(ADoc);
  ExpAP.FMismoXML := mismoXML;
  try
    try
      ExpAP.ShowModal;
    except
      ShowAlert(atWarnAlert, 'Problems were encountered exporting to AppraisalPort.');
    end;
  finally
    ExpAP.Free;
  end;
end;


{ TExportAppraisalPort }

constructor TExportAppraisalPort.Create(AOwner: TComponent);
var
  alertStr, alertStr1, alertStr2: String;
begin
  inherited Create(nil);
  SettingsName := CFormSettings_ExportApprPort;

  FDoc := TContainer(AOwner);
  if assigned(FDoc) then
    begin
      //setup interface
      btnExport.Enabled := True;
      edtCurReport.Text := FDoc.docFileName;
      InitFormGrid;
      FConvToImageAll := false;
      CheckFormCompatibility(FDoc);
      if FNeedsAltForm then
        begin
          alertStr  := 'The AppraisalPort Compatibility Reviewer has detected that '+ IntToStr(FCountNoForm + FCountMaybe) + ' forms in your report have compatibility issues. ';
          alertStr1 := IntToStr(FCountNoForm) + ' form(s) have NO corresponding form in AppraisalPort. ';
          alertStr2 := IntToStr(FCountMaybe) + ' form(s) do have an alternative form you can switch to for compatibility.';
          if FCountNoForm > 0 then
            alertStr := alertStr + alertStr1;
          if FCountMaybe > 0 then
            alertStr := alertStr + alertStr2;
          ShowAlert(atWarnAlert, alertStr);
        end;
//      else
//        begin
//          alertStr := 'The AppraisalPort Compatibility Reviewer has verfied that all the forms in your report are compatibile with AppraisalPort forms.';
//          ShowAlert(atInfoAlert, alertStr);
//        end;
    end;
end;

function TExportAppraisalPort.CanUseService: Boolean;
var
  VendorTokenKey: String;
begin
  try
    result := CurrentUser.OK2UseCustDBOrAWProduct(pidAppraisalPort, True);// or CurrentUser.OK2UseCustDBOrAWProduct(pidAppWorldConnection, TestVersion);
    if not result then
      result := GetCRM_PersmissionOnly(CRM_AppraisalPortProdUID,CRM_AppraisalPort_ServiceMethod,CurrentUser.AWUserInfo,False,VendorTokenKey);
  except ON E:Exception do
     begin
       ShowAlert(atWarnAlert,msgServiceNotAvaible);
       result := False;
     end;
  end;
end;

procedure TExportAppraisalPort.btnExportClick(Sender: TObject);
begin
  If CanUseService then
    begin
      if DoExport then
        Close;
    end;
end;

function TExportAppraisalPort.DoExport: Boolean;
var
  //alertStr: String;
  CF_XMLPackPath: String;
  //doIt: Boolean;
  xmlDoc: TXMLDocument;
  mismoXmlPath: String;
begin
  result := True;

  {doIt := True;
  if FNeedsAltForm then  //result from CheckFormCompatibility
    begin
      alertStr  := 'The AppraisalPort Compatibility Reviewer has detected that '+ IntToStr(FCountNoForm + FCountMaybe) + ' forms in your report have compatibility issues. Do you want to continue?';
      doIt := WarnOK2Continue(alertStr);
    end;

  if doIt then     }
    try
      CF_XMLPackPath := CreateExportPackage(FDoc,GetFormsToImage);

      if not FileExists(CF_XMLPackPath) then
        begin
          ShowAlert(atStopAlert, 'The tools necesary to convert to the AIReady format were not found. The conversion cannot be performed.');
          exit;
        end;
      //add MISMO XML
      if length(FMismoXML) > 0 then
        begin
          try
            xmlDoc := TXMLDocument.Create(nil);
            xmldoc.loadFromXML(FMismoXML);
            mismoXMLPath := IncludeTrailingPathDelimiter(ExtractFileDir(CF_XMLPackPath)) + arMismoXML;
            xmlDoc.SaveToFile(mismoXMLPath);
          except
          end;
        end;
      result := CreateAppraisalPortXML(CF_XMLPackPath, true);  //save ENV file
    except
      on e: Exception do
        begin
          ShowAlert(atStopAlert, E.message);
          result := False;
        end;
    end;
end;

procedure TExportAppraisalPort.CheckFormCompatibility(Doc: TContainer);
var
  f, nForms: Integer;
  frmListPath: String;
begin
  FNeedsAltForm     := False;
  FConvForms        := TFormStrList.Create;
  FConvForms.Sorted := False;
  FCountMaybe       := 0;
  FCountNoForm      := 0;
  try
    try
      frmListPath := IncludeTrailingPathDelimiter(appPref_DirAppraisalWorld) + ConvFormList;

      if not FileExists(frmListPath) then
        raise Exception.CreateFmt('Cannot find the AIReady form conpatibility guide %s',[ConvFormList]);

      FConvForms.LoadFromFile(frmListPath);

      nForms := doc.docForm.count;
      for f := 0 to nForms - 1 do
        begin
          CheckForAlternates(f, doc);
        end;
    except
    end;
  finally
    FConvForms.free;
  end;
end;

procedure TExportAppraisalPort.CheckForAlternates(N: Integer; doc: TContainer);
var
  fID, indx: Integer;
  fName: String;
  frmRec: FormConvRec;
begin
  fID := doc.docForm[N].FormID;
  fName := doc.docForm[N].frmSpecs.fFormName;
  N := N + 1;       //grid is 1 based

  FormGrid.Cell[colFormName, n] := fName;            //put the current form in list.

  //if the form is not in the list, it cannot be converted
  //if it is in the list, it may still not be convertable
  if FConvForms.Find(IntToStr(fID),indx) then
    begin
      frmRec := GetFormConversionInfo(FConvForms.Strings[indx]);
      if frmRec.bAir then   //it can be converted
        begin
          FormGrid.Cell[colFormAvailable, n] := 'Compatible';
        end
      else if length(frmRec.altForm) > 0 then     //there IS an alternate form
        begin
          FormGrid.Cell[colFormAvailable, n] := frmRec.altForm;
          FormGrid.CellColor[colFormAvailable,n] := clYellow;
          FNeedsAltForm := True;
          FCountMaybe := FCountMaybe + 1;
        end
      else
        begin
          FormGrid.Cell[colFormAvailable, N] := 'Available As Image only';
          FormGrid.CellColor[colFormAvailable,N] := clLtGray;
          FormGrid.CellReadOnly[colConvertToImage,N] := roOff;    //may be edit
          FormGrid.CellButtonType[colConvertToImage,N] := btDefault;
          formGrid.CellControlType[colConvertToImage,N] := ctCheck;
          FormGrid.CellCheckBoxState[colConvertToImage,N] := cbChecked;
          FNeedsAltForm := True;
          FCountNoForm := FCountNoForm + 1;
        end
    end
  else
    begin
      FormGrid.Cell[colFormAvailable, N] := 'Available As Image only';
      FormGrid.CellColor[colFormAvailable,N] := clLtGray;
      FormGrid.CellReadOnly[colConvertToImage,N] := roOff;  //may be edit
      FormGrid.CellButtonType[colConvertToImage,N] := btDefault;
      formGrid.CellControlType[colConvertToImage,N] := ctCheck;
      FormGrid.CellCheckBoxState[colConvertToImage,N] := cbChecked;
      FNeedsAltForm := True;
      FCountNoForm := FCountNoForm + 1;
    end;

  FormGrid.Rows := n+1;      //get set for next form
end;


function TExportAppraisalPort.GetFormConversionInfo(rec: String): FormConvRec;
var
  delimPos: Integer;
  curStr: String;
begin
  result.bLH := False;
  result.bAir := False;
  result.id := 0;

  curStr := rec;

  delimPos := Pos(tab,curStr);    //get first tab
  if delimPos = 0  then exit;     //there is no text

  result.id := StrToIntDef(Copy(curStr,1,delimPos - 1),0);     //get the formID

  curStr := Copy(curStr,delimPos + 1,length(curStr));          //remove text

  delimPos := Pos(tab,curStr);                                 //find next tab
  if delimPos = 0 then exit;
  
  curStr := Copy(curStr,delimPos + 1, length(curStr));         //skip the form name

  //get the AI Ready flag
  result.bAir := StrToIntDef(Copy(curStr,1, 1),0) = 1;         //first char is =1 or tab

  //go to next tab
  delimPos := Pos(tab, curStr);                                //find next tab
  if delimPos = 0 then exit;
  curStr := Copy(curStr, delimPos + 1, length(curStr));        //skip the tab

  //get the Lighthouse flag
  result.bLH := StrToIntDef(Copy(curStr,1, 1),0) = 1;          //first char is =1 or tab

  //goto next tab
  delimPos := Pos(tab, curStr);                                //find next tab
  if delimPos = 0 then exit;
  curStr := Copy(curStr, delimPos + 1, length(curStr));        //skip the tab

  //goto next tab - skip the lightHouse alternate formames
  delimPos := Pos(tab, curStr);                                //find next tab
  if delimPos = 0 then exit;
  curStr := Copy(curStr, delimPos + 1, length(curStr));        //skip the tab

  //get the AIReady alternate form name
  result.altForm := Copy(curStr, 1, length(curStr));          // get the name
end;

//this loads in URl to AppraisalPortHelp in a browser 
procedure TExportAppraisalPort.ShowAppraisalPortHelp;
begin
  DisplayPDFFromURL(Self, 'AppraisalPort Tips', ENVTipsURL);
end;

function TExportAppraisalPort.GetFormsToImage: IntegerArray;
var
  rec: Integer;
  curIndex: Integer;
begin
  SetLength(result,0);
  with formGrid do
    for rec := 1 to Rows do
      if (CellControlType[colConvertToImage,rec] = ctCheck)
            and (CellCheckBoxState[colConvertToImage,rec] = cbChecked) then
        begin
          curIndex := length(result);
          setLength(result,curIndex + 1);
          result[curIndex] := rec - 1;
        end;
end;

procedure TExportAppraisalPort.InitformGrid;
begin
  with FormGrid do
    begin
      Col[colFormName].ReadOnly := True;      //form name
      Col[colFormName].ButtonType := btDefault;
      Col[colFormName].ControlType := ctDefault;
      Col[colFormAvailable].ReadOnly := True;       // compatible, there is aternative, or there is not alternative
      Col[colFormAvailable].ButtonType := btDefault;
      Col[colFormAvailable].ControlType := ctDefault;
      Col[colConvertToImage].ReadOnly := True;      //check boxes for option: have image of the form
      Col[colConvertToImage].ButtonType := btNone; //will be displayed only for no alternative form
      Col[colConvertToImage].ControlType := ctdefault;
    end;
end;


{ TFormStrList }

//look for the formID in the string of characters
//the formID str needs to be followed by a tab char, so it not confused by
//the occurance of the same characters in other places in the strings
function TFormStrList.Find(const S: string; var Index: Integer): Boolean;
var
  i: Integer;
  StrID: String;

  function GetFormIDStr(const Str: String): String;
  var
    delimPos: Integer;
  begin
    delimPos := Pos(tab,Str);                     //get first tab
    if delimPos = 0 then
      result := ''
    else
      result := Copy(Str, 1, delimPos - 1);     //get the formID
  end;

begin
  result := False;
  index := -1;
  for i := 0 to count-1 do
    begin
      StrID := GetFormIDStr(Strings[i]);   //get only the ID part of the string
      result := (compareText(S,trim(strID)) = 0);
      if result then
        begin
          index := i;
          break;
        end;
    end;
end;

procedure TExportAppraisalPort.Button1Click(Sender: TObject);
begin
  ShowAppraisalPortHelp;
end;

//Fix DPI issues
procedure TExportAppraisalPort.AdjustDPISettings;
begin
   self.Width := FormGrid.Width + 20 ;
   self.Height := FormGrid.Top + FormGrid.Height + 50;
end;

procedure TExportAppraisalPort.FormShow(Sender: TObject);
begin
      AdjustDPISettings;
end;


procedure TExportAppraisalPort.OnCellShiftClick(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
var
  curRow: Integer;
begin
  with formGrid do
    if ShiftKeydown and (DataColDown = colConvertToImage) and (DataColUp = colConvertToImage) then
      for curRow := 1 to Rows do
        if CellControlType[colConvertToImage,curRow] = ctCheck then
          if FConvToImageall then
            CellCheckBoxState[colConvertToImage,curRow] := cbUnchecked
          else
            CellCheckBoxState[colConvertToImage,curRow] := cbChecked;
  FConvToImageall := not FConvToImageall;
end;

end.
