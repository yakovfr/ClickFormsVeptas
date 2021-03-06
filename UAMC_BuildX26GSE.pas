unit UAMC_BuildX26GSE;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted � 1998-2012 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, MSXML6_TLB, UAMC_CheckUAD_SaxWrapper, Types,
  UContainer, UAMC_Base, UAMC_WorkflowBaseFrame, ExtCtrls, Gauges, ImgList,
  Buttons, Grids_ts, TSGrid, osAdvDbGrid, TSImageList,UCell,osSortLib,UForm,
  TsGridReport;

type


  TAMC_BuildX26GSE = class(TWorkflowBaseFrame)
    lblProgress: TLabel;
    Panel1: TPanel;
    Gauge1: TGauge;
    lblFormType: TLabel;
    btnCreateUADXML: TButton;
    bbtnToggleView: TBitBtn;
    tsImageList1: TtsImageList;
    Grid: TosAdvDbGrid;
    ErrorPanel: TPanel;
    Label1: TLabel;
    ErrorLabel: TLabel;
    Button5: TButton;
    btnPrint: TButton;
    osGridReport1: TosGridReport;
    procedure btnCreateUADXMLClick(Sender: TObject);
    procedure bbtnToggleViewClick(Sender: TObject);
    procedure GridButtonClick(Sender: TObject; DataCol, DataRow: Integer);
    procedure GridDblClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    FIsExpanded: Boolean;
    FXMLFile: String;
    FXmlSax: IVBSAXXMLReader;   // use sax reader interface
    procedure ClearGrid;
    procedure LocateCompCell(aRow: Integer);
    procedure SetAllGridColumn;
    procedure SetGridColumnsReadOnly;



  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    procedure InitPackageData;        override;
    procedure StartProcess;           override;
    procedure DoProcessData;          override;
    procedure CreateXML_MismoGSE26;
    procedure DoCreateXML_MismoGSE26;
    procedure DoCheckUADCompliance(doc: TContainer);
    procedure GetUADErrWarnCount(var ErrQty, WarnQty: Integer);
    function XMLValidatedAginstSchema: Boolean;
    function GetFormNumber(formName: String): String;
    procedure SaveXMLToFile;
  end;

implementation

{$R *.dfm}


Uses
  UUtil1, UWindowsInfo, UGlobals, UGSEInterface, UStatus,
  UAMC_XMLUtils, UAMC_Delivery, UMyClickForms, UWinUtils,
  UAMC_CheckUAD_Globals, UAMC_CheckUAD_Rules, UUtil2, UAMC_Globals, UGridMgr {InfoForm};
{uses  GSEConstants, GSERules, InfoForm, Commctrl; }

{ TAMC_BuildX26GSE }


const

  ColType         = 1;
  ColLocate       = 2;
  ColFieldLabel   = 3;
  ColDataPoint    = 4;
  ColCurrentValue = 5;
  ColErrorMessage = 6;
  ColSuggestion   = 7;
  ColIniID        = 8;
  ColXID          = 9;
  colCompCell     = 10;




constructor TAMC_BuildX26GSE.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
var
  formNo: String;
begin
  inherited;

  formNo := GetFormNumber(PackageData.FMainFormName);

  FXmlSax := CoSAXXMLReader.Create;
  FXmlSax.ContentHandler := TXMLSaxHandler.Create(Grid, Gauge1, formNo);
  FXmlSax.ErrorHandler := TXMLSaxErrorHandler.Create(ErrorLabel);

  Gauge1.Progress := 0;
  lblFormType.Caption := formNo;

  FXMLFile := '';
  FIsExpanded := True;

///  SetGridColumnsReadOnly;
end;

procedure TAMC_BuildX26GSE.InitPackageData;
begin
  inherited;
//
end;

procedure TAMC_BuildX26GSE.btnCreateUADXMLClick(Sender: TObject);
begin
  CreateXML_MismoGSE26;
end;

procedure TAMC_BuildX26GSE.StartProcess;
begin
  CreateXML_MismoGSE26;
end;

procedure TAMC_BuildX26GSE.CreateXML_MismoGSE26;
begin
  if not FIsExpanded then           //make sure the window is expanded.
    bbtnToggleViewClick(nil);

  PushMouseCursor(crHourGlass);
  try
    FDoc.CommitEdits;          //in case the user did not tab out of cell
    FDoc.Save;                 //or save
    try
      Gauge1.Progress := 0;
      lblProgress.caption := 'Creating UAD XML File';
      lblProgress.Invalidate;
      Application.ProcessMessages;
      DoCreateXML_MismoGSE26;

      Gauge1.Progress := 0;
      lblProgress.caption := 'Validating UAD XML';
      if PackageData.AMCIdentifier <>  AMC_Veptas then     //skip for veptas
        DoCheckUADCompliance(FDoc);

      btnCreateUADXML.Caption := 'Re-Check XML';
      lblProgress.caption := 'UAD XML Review Complete';
      Application.ProcessMessages;

      AdvanceToNextProcess;        //auto advance

    except
      on E : Exception do
        begin
          ShowAlert(atWarnAlert, E.Message);
        end;
    end;
  finally
    PopMouseCursor;
  end;
end;

procedure TAMC_BuildX26GSE.DoCreateXML_MismoGSE26;
var
  xmlVer: String;
  formList: BooleanArray;
  miscInfo: TMiscInfo;
begin
  xmlVer := '';
  formList := PackageData.FFormList;
  miscInfo := TMiscInfo.Create;
  try
    miscInfo.FEmbedPDF := False;
    miscInfo.FPDFFileToEmbed := '';
    FXMLFile := ComposeGSEAppraisalXMLReport(FDoc, xmlVer, formList, miscInfo, nil);
  finally
    miscInfo.Free;
  end;
end;

procedure TAMC_BuildX26GSE.GetUADErrWarnCount(var ErrQty, WarnQty: Integer);
var
  Cntr: Integer;
begin
  ErrQty := 0;
  WarnQty := 0;
  if Grid.Rows > 0 then
    for Cntr := 1 to Grid.Rows do
      if Grid.Cell[1,Cntr] = Grid.ImageList.Image[3].name then
        ErrQty := Succ(ErrQty)
      else
        WarnQty := Succ(WarnQty);
end;

procedure TAMC_BuildX26GSE.DoProcessData;
var
  dFile: TDataFile;
  errorCount, warnCount: Integer;
  errOverride, moveOn: Boolean;
  errStr: String;
begin
  inherited;
  errOverride := ShiftKeyDown;         //was shift key down when Next clicked

  PackageData.FGoToNextOk := False;
  PackageData.FHardStop := True;
  PackageData.FAlertMsg := 'You need to create the XML file before moving to the next step.';
  if (Length(FXMLFile)> 0) then
    begin
      moveOn := True;                     //for time being, let user move past even with errors
      if PackageData.AMCIdentifier <> AMC_Veptas then   //we din do UAD check for Veptas
      begin
      GetUADErrWarnCount(errorCount, warnCount);
      if errorCount > 0 then
        begin
          moveOn := False;
          if errorCount = 1 then
            errStr := 'error was found. The error'
          else
            errStr := 'errors were found. All errors';
          PackageData.FAlertMsg := IntToStr(errorCount) + ' UAD ' + errStr + ' must be corrected before proceeding to the next step.';
        end
      else if warnCount > 0 then
        begin
          if warnCount = 1 then
            errStr := 'warning was found. Do you want to fix it'
          else
            errStr := 'warnings were found. Do you want to fix them';
          moveOn := not WarnOK2Continue(IntToStr(warnCount) + ' UAD ' + errStr + ' before proceeding to the next step?');
          PackageData.FAlertMsg := '';  //msg already shown
        end;
        end;

(*
      if (errorCount > 0) and not errOverride then
        begin
          PackageData.FGoToNextOk := False;
          PackageData.FHardStop := True;
          PackageData.FAlertMsg := '';
          PackageData.FAlertMsg := IntToStr(errorCount) + ' UAD errors were found. Please fix them before moving to the next step.';
        end
      else if XMLValidatedAginstSchema then  //no errors and valid against schema
*)
      if moveOn then
        if XMLValidatedAginstSchema then  //no errors and valid against schema
          begin
            // Recreate the XML in case the user made last minute changes.
            //  This ensures that the XML and PDF match.
            try
              PushMouseCursor(crHourGlass);
              DoCreateXML_MismoGSE26;       //it takes substantial time
            finally
              PopMouseCursor;
            end;
            dFile := PackageData.DataFiles.GetDataFileObj(fTypXML26GSE, True);    //Should NEVER have to create it
            dFile.FData := FXMLFile;

            PackageData.FGoToNextOk := True;
            PackageData.FHardStop := False;
            PackageData.FAlertMsg := '';
          end
        else begin
          ShowAlert(atStopAlert, 'ClickFORMS is unable to create a valid XML file. ' +
            'You cannot proceed to the next step until a valid XML is created. ' +
            'For assistance please e-mail your ClickFORMS file (the "clk" file) to support@bradfordsoftware.com.');
          PackageData.FAlertMsg := '';

  //DEBUG       SaveXMLToFile;
          end;
    end;
end;

procedure TAMC_BuildX26GSE.SaveXMLToFile;
var
  fName, myClkDir: String;
  SaveDialog: TSaveDialog;
  XMLStream: TFileStream;
begin
  myClkDir := MyFolderPrefs.MyClickFormsDir;
  fName := GetNameOnly(FDoc.docFileName) + '_UAD_XML';

  SaveDialog := TSaveDialog.Create(nil);
  try
    SaveDialog.InitialDir := VerifyInitialDir('', myClkDir);
    SaveDialog.FileName := fName;
    SaveDialog.DefaultExt := 'xml';
    SaveDialog.Filter := 'MISMO XML (*.xml)|*.xml';
    SaveDialog.FilterIndex := 1;

    if SaveDialog.Execute then
      if length(SaveDialog.Filename) > 0 then
        begin
          XMLStream := TFileStream.Create(SaveDialog.Filename, fmCreate);
          try
            XMLStream.Write(PChar(FXMLFile)^,length(FXMLFile));
          finally
            XMLStream.Free;
          end;
        end;
  finally
    SaveDialog.Free;
  end;
end;

(* sample code
      StringList.SaveToStream(Buffer);
      Buffer.Position := 0;
      OleStream := TStreamAdapter.Create(Buffer, soReference) as IStream;

      Buffer := TMemoryStream.Create;
      Buffer.Read(FXMLFile, length(FXMLFile));
      Buffer.Position := 0;
      OleXMLStream := TStreamAdapter.Create(Buffer, soReference) as TStream;

  fStream := TFileStream.Create('C:\ClickForms\StreetLink Integration\encodedPDFReport',fmCreate);
  try
    fStream.Write(PChar(strReport)^,length(strReport));
  finally
    fStream.Free;
  end;

*)
procedure TAMC_BuildX26GSE.DoCheckUADCompliance(doc: TContainer);
//  FileName := 'C:\\workflowSampleUploadFiles\UAD_1004_TEST.XML';
const
  ttSales     = 1;    //types of grids
  ttListings  = 3;
var
  SalesGridManager : TGridMgr;
begin
  if length(FXMLFile) > 0 then  //we have xml
    begin
      // set up sales and listing grid managers
      SalesGridManager := TGridMgr.Create;
//      SalesGridManager.BuildGrid(doc, ttSales);
      SalesGridManager.BuildGrid2(doc, ttSales,PackageData.FFormList);
      ListingGridManager := TGridMgr.Create;
//      ListingGridManager.BuildGrid(doc, ttListings);
      ListingGridManager.BuildGrid2(doc, ttListings, PackageData.FFormList);
      UAMC_CheckUAD_Rules.SalesGridManager := SalesGridManager;
      UAMC_CheckUAD_Rules.ListingGridManager := ListingGridManager;

      UAMC_CheckUAD_Rules._ShowPassed := False;    //cbShowPassed.Checked;
      UAMC_CheckUAD_Rules._ShowWarnings := True;   //cbShowWarnings.Checked;

      ErrorPanel.Visible := False;
      SetAllGridColumn;
      ClearGrid;
      Gauge1.Progress := 0;
      try
        try
          UAMC_CheckUAD_Rules.FormTypeError := False;
          UAMC_CheckUAD_Rules.ComparableSaleError := False;
          UAMC_CheckUAD_Rules.InitVariables;
          UADReviewCycleNumber := 1;

          FXmlSax.parse(FXMLFile);

          if UAMC_CheckUAD_Rules.FormTypeError then
            MessageDlg('UAD Rule Error. ' + #13 + 'Invalid Form type. The document will not be processed.', mtError, [mbOk], 0)

          else if UAMC_CheckUAD_Rules.ComparableSaleError then
              MessageDlg('UAD Rule Error. ' + #13 + 'One of the COMPARABLE_SALE has an invalid sequence identifier.', mtError, [mbOk], 0)

          else begin
            UADReviewCycleNumber := 2;
            FXmlSax.Parse(FXMLFile);  // start parsing
            end;
        except
          //PN: only show ErrorPanel when we have something in the errorlabel.
          //This will solve the issue when we double click on recheck-XML
          //Exception occurs in FXmlSax.parse(FXMLFile) while there's no xml syntax error, the errorlable.caption is empty but the errorpanel pops up
          if Errorlabel.Caption <> '' then
             ErrorPanel.Visible := True;
        end;
      finally
        SalesGridManager.Free;
        ListingGridManager.Free;
      end;
   end;
end;

//this is a good function to put in UAMC_XMLUtils
function TAMC_BuildX26GSE.XMLValidatedAginstSchema: Boolean;
var
  XSD_FileName: String;
  cache: IXMLDOMSchemaCollection;
  srcXMLDoc: IXMLDomDocument2;
  XMLVer: String;
begin
  result := false;

  if FDoc.UADEnabled then
    XMLVer := UADVer
  else
    XMLVer := NonUADVer;

  XSD_FileName := IncludeTrailingPathDelimiter(appPref_DirMISMO) +
                  MISMO_XPathFilename + XMLVer + '.xsd';

  if FileExists(XSD_FileName) then
    begin
      cache := CoXMLSchemaCache60.Create;
      srcXMLDoc := CoDomDocument60.Create;
      srcXMLDoc.async := false;
      srcXMLDoc.setProperty('SelectionLanguage', 'XPath');
      cache.add('',XSD_FileName);
      srcXMLDoc.schemas := cache;
      srcXMLDoc.loadXML(FXMLFile);

      result := srcXMLDoc.parseError.errorCode = 0;
    end
  else
    ShowAlert(atStopAlert, 'The XML validation schema file, "' + ExtractFileName(XSD_FileName) +
               '," cannot be found. The XML file cannot be properly validated.');
end;

//we deal with only 4 UAD forms
function TAMC_BuildX26GSE.GetFormNumber(formName: String): String;
begin
  if CompareText(formName, 'FNM 1004') = 0 then
    result := '1004'
  else if CompareText(formName, 'FNM 1073') = 0 then
    result := '1073'
  else if CompareText(formName, 'FNM 1075') = 0 then
    result := '1075'
  else if CompareText(formName, 'FNM 2055') = 0 then
    result := '2055'
  else
    result := 'NonUAD';
end;




procedure TAMC_BuildX26GSE.bbtnToggleViewClick(Sender: TObject);
begin
  TAMCDeliveryProcess(TPageControl(TTabSheet(Self.Owner).PageControl).Owner).ToggleWindowSize;

  //Toggle the Button caption
  FIsExpanded := not FIsExpanded;
  if FIsExpanded then
    bbtnToggleView.Caption := 'Collapse Window'
  else
    bbtnToggleView.Caption := 'Expand Window';

end;

procedure TAMC_BuildX26GSE.ClearGrid;
begin
  Grid.BeginUpdate;
  Grid.rows := 0;
  Grid.EndUpdate;
end;

procedure TAMC_BuildX26GSE.LocateCompCell(aRow:Integer);
var
  aCell: TBaseCell;
  XID: Integer;
  ClUID: CellUID;
  aItem,aForm,aFormID,aPage,aCellNum: String;
begin
      XID := StrToIntDef(Grid.Cell[colXID,aRow],0);
      aItem    := Grid.Cell[ColCompCell,aRow];
      aFormID  := PopStr(aItem,',');
      aForm    := PopStr(aItem,',');
      aPage    := PopStr(aItem,',');
      aCellNum := aItem;
      clUID.Form    := StrToIntDef(aForm,0);
      clUID.Pg      := StrToIntDef(aPage,0);
      clUID.Num     := StrToIntDef(aCellNum,0);
      clUID.FormID  := StrToIntDef(aFormID,0);
      if clUID.Num > 0 then
      begin
        BringWindowToTop(FDoc.Handle);
        if FDoc.canFocus then
          FDoc.SetFocus;
        FDoc.Switch2NewCell(FDoc.GetCell(clUID),cNotClicked);
      end
      else
      begin
        aCell := FDoc.GetCellByXID(XID);
        if (aCell = nil) then exit;
        BringWindowToTop(FDoc.Handle);
        if FDoc.canFocus then
          FDoc.SetFocus;
        FDoc.Switch2NewCell(FDoc.GetCell(aCell.UID),cNotClicked);  
      end
end;


procedure TAMC_BuildX26GSE.GridButtonClick(Sender: TObject; DataCol,DataRow: Integer);
begin
  inherited;
  LocateCompCell(DataRow);
end;

procedure TAMC_BuildX26GSE.SetAllGridColumn;
begin
  Grid.Col[ColType].MinWidth         := 40;
  Grid.Col[ColType].MaxWidth         := 40;
  Grid.Col[ColLocate].MinWidth       := 0;
  Grid.Col[ColLocate].MaxWidth       := 0;
  Grid.Col[colFieldLabel].MinWidth   := 160;
  Grid.Col[ColDataPoint].MinWidth    := 220;
  Grid.Col[ColCurrentValue].MinWidth := 100;
  Grid.Col[colErrorMessage].MinWidth := 260;
  Grid.Col[colSuggestion].MinWidth   := 250;
//Hide sequence column
//  Grid.Col[ColIniID].MinWidth        := 30;
//  Grid.Col[ColIniID].MaxWidth        := 50;
  Grid.Col[ColXID].MinWidth          := 70;
  Grid.Col[ColXID].MaxWidth          := 70;
  Grid.Col[ColCompCell].MinWidth     := 120;
  Grid.Col[ColIniId].Width           := 0;  //hide sequence column
end;


procedure TAMC_BuildX26GSE.GridDblClick(Sender: TObject);
begin
  inherited;
  LocateCompCell(Grid.CurrentDataRow);
end;

procedure TAMC_BuildX26GSE.SetGridColumnsReadOnly;
var acol:Integer;
begin
    for aCol:= 1 to Grid.Cols do
        if aCol = ColLocate then
           Grid.Col[aCol].ReadOnly := False
        else
           Grid.Col[aCol].ReadOnly := True;
end;


procedure TAMC_BuildX26GSE.btnPrintClick(Sender: TObject);
begin
  inherited;
  Grid.Print;
  ShowMessage('Printing sent successfully!');
end;

end.
