unit UExportLighthouse;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UGlobals,
  UContainer, UForms, Grids_ts, TSGrid, osAdvDbGrid;

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

  TExportLighthouse = class(TVistaAdvancedForm)
    Panel1: TPanel;
    btnClose: TButton;
    Image1: TImage;
    FormGrid: TosAdvDbGrid;
    Panel2: TPanel;
    Label2: TLabel;
    edtCurReport: TEdit;
    btnExport: TButton;
    procedure btnExportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FDoc: TContainer;
    FConvForms: TFormStrList;
    FNeedsAltForm: Boolean;
    FCountNoForm: Integer;
    FCountMaybe: Integer;
    procedure AdjustDPISettings;
  public
    constructor Create(AOwner: TComponent); override;
    function CanUseService: Boolean;
    function DoExport: Boolean;
    procedure CheckFormCompatibility(Doc: TContainer);
    procedure CheckForAlternates(N: Integer; doc: TContainer);
    function GetFormConversionInfo(rec: String): FormConvRec;
    procedure SendToLighthouse(expPackPath: String);
  end;


  procedure ExportReportToLighthouse(ADoc: TContainer);


var
  ExportLighthouse: TExportLighthouse;



implementation

{$R *.dfm}

Uses
  Math,
  UStatus, UStatusService, ULicUser, UFileExport,
  UExportXMLPackage, UStrings;

const
  ConvFormList  = 'ConvertableForms.lst';   //'ConvFormList.txt';
  tab = #09;



procedure ExportReportToLighthouse(ADoc: TContainer);
var
  ExpLH: TExportLighthouse;
begin
  ExpLH := TExportLighthouse.Create(ADoc);
  try
    try
      ExpLH.ShowModal;
    except
      ShowAlert(atWarnAlert, 'Problems were encountered exporting to LH.');
    end;
  finally
    ExpLH.Free;
  end;
end;


{ TExportLighthouse }

constructor TExportLighthouse.Create(AOwner: TComponent);
var
  alertStr, alertStr1, alertStr2: String;
begin
  inherited Create(Nil);
  SettingsName := CFormSettings_ExportLighthouse;

  FDoc := TContainer(AOwner);
  if assigned(FDoc) then
    begin
      //setup interface
      btnExport.Enabled := True;
      edtCurReport.Text := FDoc.docFileName;
      CheckFormCompatibility(FDoc);
      if FNeedsAltForm then
        begin
          alertStr  := 'The LH Compatibility Reviewer has detected that '+ IntToStr(FCountNoForm + FCountMaybe) + ' forms in your report have compatibility issues. ';
          alertStr1 := IntToStr(FCountNoForm) + ' form(s) have NO corresponding form in LH. ';
          alertStr2 := IntToStr(FCountMaybe) + ' form(s) do have an alternative form you can switch to for compatibility';
          if FCountNoForm > 0 then
            alertStr := alertStr + alertStr1;
          if FCountMaybe > 0 then
            alertStr := alertStr + alertStr2;
          alertStr := alertStr + '.';
          ShowAlert(atWarnAlert, alertStr);
        end
      else
        begin
          alertStr := 'The LH Compatibility Reviewer has verfied that all the forms in your report are compatibile with LH forms.';
          ShowAlert(atInfoAlert, alertStr);
        end;
    end;
end;

function TExportLighthouse.CanUseService: Boolean;
begin
  result := CurrentUser.OK2UseCustDBOrAWProduct(pidLightHouse, TestVersion) or CurrentUser.OK2UseCustDBOrAWProduct(pidAppWorldConnection, TestVersion);
end;

procedure TExportLighthouse.btnExportClick(Sender: TObject);
begin
  If CanUseService then
    begin
      if DoExport then
        Close;
    end;
end;

function TExportLighthouse.DoExport: Boolean;
var
  alertStr: String;
  CF_XMLPackPath: String;
  doIt: Boolean;
  FormsToImage: Integerarray;
begin
  result := True;
  CheckFormCompatibility(FDoc);
  SetLength(FormsToImage,0);
  doIt := True;
  if FNeedsAltForm then  //result from CheckFormCompatibility
    begin
      alertStr  := 'The LH Compatibility Reviewer has detected that '+ IntToStr(FCountNoForm + FCountMaybe) + ' forms in your report have compatibility issues. Do you want to continue?';
      doIt := WarnOK2Continue(alertStr);
    end;

  if doIt then
    try
      CF_XMLPackPath := CreateExportPackage(FDoc, FormsToImage);

      if not FileExists(CF_XMLPackPath) then
        begin
          ShowAlert(atStopAlert, 'The tools necesary to convert to the LH format were not found. The conversion cannot be performed.');
          exit;
        end;

      SendToLighthouse(CF_XMLPackPath);
    except
      on e: Exception do
        begin
          ShowAlert(atStopAlert, E.message);
          result := False;
        end;
    end;
end;

procedure TExportLighthouse.CheckFormCompatibility(Doc: TContainer);
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
        raise Exception.CreateFmt('Cannot find the LH form conpatibility guide %s',[ConvFormList]);

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

procedure TExportLighthouse.CheckForAlternates(N: Integer; doc: TContainer);
var
  fID, indx: Integer;
  fName: String;
  frmRec: FormConvRec;
begin
  fID := doc.docForm[N].FormID;
  fName := doc.docForm[N].frmSpecs.fFormName;
  N := N + 1;       //grid is 1 based

  FormGrid.Cell[1, n] := fName;            //put the current form in list.

  //if the form is not in the list, it cannot be converted
  //if it is in the list, it may still not be convertable
  if FConvForms.Find(IntToStr(fID),indx) then
    begin
      frmRec := GetFormConversionInfo(FConvForms.Strings[indx]);
      if frmRec.bLH then   //it can be converted
        begin
          FormGrid.Cell[2, n] := 'Compatible';
        end
      else if length(frmRec.altForm) > 0 then     //there IS an alternate form
        begin                                     //show it in yellow
          FormGrid.Cell[2, n] := frmRec.altForm;
          FormGrid.CellColor[2,n] := clYellow;
          FNeedsAltForm := True;
          FCountMaybe := FCountMaybe + 1;
        end
      else
        begin
          FormGrid.Cell[2, n] := 'No Alternate Available';
          FormGrid.CellColor[2,n] := clRed;
          FNeedsAltForm := True;
          FCountNoForm := FCountNoForm + 1;
        end
    end
  else
    begin
      FormGrid.Cell[2, n] := 'No Alternate Available';
      FormGrid.CellColor[2,n] := clRed;
      FNeedsAltForm := True;
      FCountNoForm := FCountNoForm + 1;
    end;

  FormGrid.Rows := n+1;      //get set for next form
end;


function TExportLighthouse.GetFormConversionInfo(rec: String): FormConvRec;
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

  curStr := Copy(curStr,delimPos + 1,length(curStr));          //remove form id text

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
  if delimPos = 0 then exit;                                   //if none - there is no alternate form names

  curStr := Copy(curStr, delimPos + 1, length(curStr));        //if there is, skip the leading tab

  //goto next tab - get only the lightHouse alternate form name
  delimPos := min(length(curStr), Pos(tab, curStr)-1);           //find next tab that seperates LH & AI form names
  if delimPos <= 0 then exit;

  //else get the LH alternate form name
  result.altForm := Copy(curStr, 1, delimPos);
end;

procedure TExportLighthouse.SendToLighthouse(expPackPath: String);
var
  cmdLine: String;
  startInfo: STARTUPINFO;
  procInfo: PROCESS_INFORMATION;
begin
  cmdLine := '"' + appPref_LighthousePath + '" "' + expPackPath  + '"';
  if FileExists(expPackPath) and FileExists(appPref_LighthousePath)then
    begin
      fillChar(startInfo,sizeof(startInfo),0);
      startInfo.cb := sizeof(startInfo);
      if not CreateProcess(nil,PChar(cmdLine),nil,nil,False,NORMAL_PRIORITY_CLASS,nil,nil,startInfo,procInfo) then
        raise EFCreateError.CreateFmt(errCannotRunTool,[ExtractFileName(appPref_LighthousePath)]);
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


//Fix DPI issues
procedure TExportLighthouse.AdjustDPISettings;
begin
   self.Width := btnExport.Left + btnExport.width + 150;
   self.Height := Panel1.Height + Panel2.Height + FormGrid.Height + 50;
   self.Constraints.MinWidth := self.Width;
   self.Constraints.MinHeight := self.Height;
end;


procedure TExportLighthouse.FormShow(Sender: TObject);
begin
   AdjustDPISettings;
end;

end.
