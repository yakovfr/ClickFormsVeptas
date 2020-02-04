unit UAMC_BuildENV;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit builds the ENV file or it exports the AIReady XML to the }
{ FNC Uploader where AppraisalPort takes over.                       }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ComCtrls, Grids_ts, TSGrid, osAdvDbGrid,
  UContainer, UAMC_Base, UAMC_WorkflowBaseFrame, UViewHTML, UGlobals, UXMLConst;

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

  TAMC_BuildENV = class(TWorkflowBaseFrame)
    FormGrid: TosAdvDbGrid;
    btnHelp: TButton;
    btnUpload: TButton;
    lblSaveNote: TLabel;
    stxtSuccess: TStaticText;
    procedure btnHelpClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
   private
    FConvForms: TFormStrList;
    FNeedsAltForm: Boolean;
    FCountNoForm: Integer;
    FCountMaybe: Integer;
    FOK2Move: Boolean;
    FUpLoading: Boolean;   //either save or upload ENV
    function GetFormsToImage: IntegerArray;
    procedure InitFormGrid;
  public
   procedure InitPackageData; override;
   procedure DoProcessData;   override;
   procedure DisplayFormCompatibility;
   procedure CheckFormCompatibility(r, f: Integer);
   procedure ShowAppraisalPortHelp;
   procedure MoveToFinish(goodUpload: Boolean);
   function GetFormConversionInfo(rec: String): FormConvRec;
   procedure DoENVProcess;
   function ProcessENVFile(aiReadyFile: String; saveENV: Boolean): Boolean;
  end;

  const
    colFormName = 1;
    colFormIndex = 2;
    colFormAvailable = 3;
    colConvertToImage = 4;

implementation

{$R *.dfm}

Uses
  UStatus, UExportXMLPackage, UExportApprPortXML2, UAMC_Delivery,
  UAMC_Workflow, UServices, uCustomerServices, ULicUser, UStatusService,
  UCRMServices,UStrings;

const
  tab = #09;
  ConvFormList  = 'ConvertableForms.lst';   //'ConvFormList.txt';
  ENVTipsURL    = 'http://bradfordsoftware.com/help/tellmehow/AIReady_Tips.htm';



{ TAMC_BuildENV }

procedure TAMC_BuildENV.InitPackageData;
begin
  Inherited;

  FOK2Move := False;

  FUpLoading := False;
  if PackageData.WorkFlowID = wfAppraisalPort then
    FUpLoading := True;

  if not FUpLoading then
    begin
      btnUpload.Caption := 'Create ENV';
      lblSaveNote.Visible := True;
    end;
  InitFormGrid;

  DisplayFormCompatibility;
//** Set btnupload enabled when previous or next button is enabled
  btnUpload.Enabled := UAMC_Delivery.AMCDeliveryProcess.btnPrev.Enabled or UAMC_Delivery.AMCDeliveryProcess.btnNext.Enabled;
end;

procedure TAMC_BuildENV.DoProcessData;
begin
  inherited;

  //assume everything fine
  PackageData.FGoToNextOk := True;
  PackageData.FHardStop := False;
  PackageData.FAlertMsg := '';

  //processing did not take place
  if not FOK2Move then
    begin
      PackageData.FGoToNextOk := False;
      if FUpLoading then
        begin
          PackageData.FHardStop := True;
          PackageData.FAlertMsg := 'You must upload the report before preceding to the next step.';
        end
      else //saveing a file
        begin
          PackageData.FHardStop := False;
          PackageData.FAlertMsg := 'You must create the ENV file before preceding to the next step.';
        end;
    end;
end;

procedure TAMC_BuildENV.btnUploadClick(Sender: TObject);
var
  VendorTokenKey:String;
begin
  try
    if CurrentUser.OK2UseCustDBOrAWProduct(pidAppraisalPort) then
      DoENVProcess
    else if GetCRM_PersmissionOnly(CRM_AppraisalPortProdUID,CRM_AppraisalPort_ServiceMethod,CurrentUser.AWUserInfo,true,VendorTokenKey) then
      DoENVProcess
    else
       ShowExpiredMsg('The AppraisalPort service needs to be purchased before you can use it');
   except on E:Exception do
     ShowAlert(atWarnAlert,msgServiceNotAvaible);
   end;
end;

procedure TAMC_BuildENV.btnHelpClick(Sender: TObject);
begin
  ShowAppraisalPortHelp;
end;

procedure TAMC_BuildENV.DisplayFormCompatibility;
var
  f, r, nForms: Integer;
  frmListPath: String;
  formList: BooleanArray;
begin
  FNeedsAltForm := False;
  FCountMaybe   := 0;
  FCountNoForm  := 0;

  formList := PackageData.FFormList;     //this came in form the SelectForms step

  FConvForms := TFormStrList.Create;
  FConvForms.Sorted := False;
  try
    try
      frmListPath := IncludeTrailingPathDelimiter(appPref_DirAppraisalWorld) + ConvFormList;

      if not FileExists(frmListPath) then
        raise Exception.CreateFmt('Cannot find the AIReady form compatibility guide "%s".',[ConvFormList]);

      FConvForms.LoadFromFile(frmListPath);

      nForms := FDoc.docForm.count;
      r := 1;                              //row in the grid
      for f := 0 to nForms - 1 do
        if formList[f] then              //if the user selected it.
          begin
            CheckFormCompatibility(r, f);     //check for compatibility
            r := r + 1;
          end;
    except
      on E:Exception do
        begin
          ShowAlert(atWarnAlert, E.Message);
        end;
    end;
  finally
    FConvForms.free;
  end;
end;

//this routine checks a file (that was read in) that compability table
//for AppraisalPort and Lighthouse (LH not sure anymore)
procedure TAMC_BuildENV.CheckFormCompatibility(r, f: Integer);
var
  fID, indx: Integer;
  fName: String;
  frmRec: FormConvRec;
begin
  fID := FDoc.docForm[f].FormID;
  fName := FDoc.docForm[f].frmSpecs.fFormName;

  FormGrid.Cell[colFormName, r] := fName;            //put the current form in list.

  //if the form is not in the list, it cannot be converted
  //if it is in the list, it may still not be convertable
  if FConvForms.Find(IntToStr(fID),indx) then
    begin
      frmRec := GetFormConversionInfo(FConvForms.Strings[indx]);
      if frmRec.bAir then   //it can be converted
        begin
          FormGrid.Cell[colFormAvailable, r] := 'Compatible';
        end
      else if length(frmRec.altForm) > 0 then     //there IS an alternate form
        begin
          FormGrid.Cell[colFormAvailable, r] := 'Use " ' + frmRec.altForm + '" instead';
          FormGrid.CellColor[colFormAvailable,r] := clYellow;
          FNeedsAltForm := True;
          FCountMaybe := FCountMaybe + 1;
        end
      else
        begin
          FormGrid.Cell[colFormAvailable, r] := 'Available As Image only';
          FormGrid.CellColor[colFormAvailable,r] := clLtGray;
          FormGrid.CellReadOnly[colConvertToImage,r] := roOff;    //may be edit
          FormGrid.CellButtonType[colConvertToImage,r] := btDefault;
          formGrid.CellControlType[colConvertToImage,r] := ctCheck;
          FormGrid.CellCheckBoxState[colConvertToImage,r] := cbChecked;
          formGrid.Cell[colFormIndex,r] := f;
          FNeedsAltForm := True;
          FCountNoForm := FCountNoForm + 1;
        end
    end
  else
    begin
      FormGrid.Cell[colFormAvailable, r] := 'Available As Image only';
      FormGrid.CellColor[colFormAvailable,r] := clLtGray;
      FormGrid.CellReadOnly[colConvertToImage,r] := roOff;  //may be edit
      FormGrid.CellButtonType[colConvertToImage,r] := btDefault;
      formGrid.CellControlType[colConvertToImage,r] := ctCheck;
      FormGrid.CellCheckBoxState[colConvertToImage,r] := cbChecked;
      formGrid.Cell[colFormIndex,r] := f;
      FNeedsAltForm := True;
      FCountNoForm := FCountNoForm + 1;
    end;

  FormGrid.Rows := r+1;      //get set for next form
end;

function TAMC_BuildENV.GetFormConversionInfo(rec: String): FormConvRec;
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

function TAMC_BuildENV.ProcessENVFile(aiReadyFile: String; saveENV: Boolean): Boolean;
var
  ExpAP: TExportApprPortXML;
  dataFile: TDataFile;
  tmpEnvfPath: String;

begin
  //result := True;
  ExpAP := TExportApprPortXML.Create;
  try
    try
      ExpAP.FXMLPackagePath := aiReadyFile;
      ExpAP.FMISMOXMLPath := IncludeTrailingPathDelimiter(ExtractFileDir(aiReadyFile)) + arMismoXml;
      ExpAP.SaveENV := saveENV;   //if false, then we are uploading ENV file
      result := ExpAP.StartConversion;

      if result and saveENV then
        begin
          tmpEnvfPath := ExpAP.ENVFilePath;
          if FileExists(tmpEnvfPath) then //ENV was saved to this path
            begin
              dataFile := PackageData.DataFiles.GetDataFileObj(fTypENV, True);
              dataFile.LoadFromFile(tmpEnvfPath);
            end;

          btnUpload.Enabled := False;
          stxtSuccess.Visible := True;
        end;
    except
      ShowAlert(atWarnAlert, 'Problems were encountered processing the ENV file.');
      result := False;
    end;
  finally
   try
     if assigned(ExpAP) then
       ExpAP.Free;
   except ; end;
  end;
end;

procedure TAMC_BuildENV.DoENVProcess;
var
  CF_XMLPackPath: String;
  //doIt: Boolean;
  //alertStr: String;
  mismoData: TDataFile;
begin
  inherited;

  //doIt := True;
  {if FNeedsAltForm then  //result from CheckFormCompatibility
    begin
      alertStr  := 'The AppraisalPort Compatibility Reviewer has detected that '+ IntToStr(FCountNoForm + FCountMaybe) + ' forms in your report have compatibility issues. Do you want to continue?';
      doIt := WarnOK2Continue(alertStr);
    end;    }

  try
    FOK2Move := False;
    //if doIt then
      begin
//        CF_XMLPackPath := CreateExportPackage(FDoc, GetformsToImage);
        CF_XMLPackPath := CreateExportPackage2(FDoc, GetformsToImage,PackageData);
        if not FileExists(CF_XMLPackPath) then
          begin
            ShowAlert(atStopAlert, 'The tools necesary to convert to the AIReady format were not found. The conversion cannot be performed.');
            exit;
          end;
        //add MISMO XML to Package
        mismoData := nil;
        if PackageData.DataFiles.DataFileHasData(fTypXML26) then
          mismoData := PackageData.DataFiles.GetDataFileObj(fTypXML26, false)
        else
          if PackageData.DataFiles.DataFileHasData(fTypXML26GSE) then
            mismoData := PackageData.DataFiles.GetDataFileObj(fTypXML26GSE,false);
        if assigned(mismoData) and mismoData.HasData then
          mismoData.SaveToFile(extractFilePath(CF_XMLPackPath) + arMismoXML);
        FOK2Move := ProcessENVFile(CF_XMLPackPath, not FUpLoading);
        if FOK2Move then
          CheckServiceAvailable(stAppraisalPort);
      end;
  except
    on e: Exception do
      begin
        ShowAlert(atStopAlert, E.message);
      end;
  end;
end;

procedure TAMC_BuildENV.ShowAppraisalPortHelp;
begin
  DisplayPDFFromURL(Self, 'AppraisalPort Tips', ENVTipsURL);
end;

procedure TAMC_BuildENV.MoveToFinish(goodUpload: Boolean);
begin
  PackageData.FAlertMsg := 'Your Appraisal Report Package has been successfully uploaded.';
  TAMCDeliveryProcess(TPageControl(TTabSheet(Self.Owner).PageControl).Owner).MoveToNextProcess(nil);
end;

function TAMC_BuildENV.GetFormsToImage: IntegerArray;
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
          result[curIndex] := cell[colFormIndex,rec];
        end;
end;

procedure TAMC_BuildENV.InitformGrid;
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
      Col[colFormIndex].Visible := false;
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


end.
