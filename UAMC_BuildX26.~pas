unit UAMC_BuildX26;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, MSXML6_TLB, {UAMC_CheckUAD_SaxWrapper,}
  UContainer, UAMC_Base, UAMC_WorkflowBaseFrame, ImgList, ExtCtrls, Gauges;

type
  TAMC_BuildX26 = class(TWorkflowBaseFrame)
    btnCreateXML: TButton;
    stxStatusNote: TStaticText;
    procedure btnCreateXMLClick(Sender: TObject);
  private
    FXMLFile: String;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);  override;
    procedure InitPackageData;     override;
    procedure StartProcess;        override;
    procedure DoProcessData;       override;
    procedure CreateXML_Mismo26;
    procedure DoCreateXML_Mismo26;
    function XMLValidatedAginstSchema: Boolean;
    procedure ShowStatusNote(success: Boolean);
    procedure SaveXMLToFile;
  end;

implementation
                                                                                                                          
{$R *.dfm}

uses
  Commctrl,
  UUtil1, UWindowsInfo, UGlobals, UGSEInterface, UStatus,
  UAMC_XMLUtils, UAMC_Delivery, UMyClickForms;
//  UAMC_CheckUAD_Globals, UAMC_CheckUAD_Rules {InfoForm};
{uses  GSEConstants, GSERules, InfoForm, Commctrl; }


{ TAMC_BuildX26 }

constructor TAMC_BuildX26.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;

  stxStatusNote.Caption := 'Creating XML file';
  FXMLFile := '';
end;

procedure TAMC_BuildX26.InitPackageData;
begin
  inherited;
  //
//** Set btnCreateXML enabled when previous or next button is enabled
  btnCreateXML.Enabled := UAMC_Delivery.AMCDeliveryProcess.btnPrev.Enabled or UAMC_Delivery.AMCDeliveryProcess.btnNext.Enabled;
end;

procedure TAMC_BuildX26.btnCreateXMLClick(Sender: TObject);
begin
  CreateXML_Mismo26;
end;

procedure TAMC_BuildX26.StartProcess;
begin
  CreateXML_Mismo26;
end;

procedure TAMC_BuildX26.CreateXML_Mismo26;
begin
  PushMouseCursor(crHourGlass);
  try
    try
      DoCreateXML_Mismo26;

      btnCreateXML.Caption := 'Re-Check XML';

      AdvanceToNextProcess;        //auto advance
(*
      Gauge1.Progress := 0;
      lblProgress.caption := 'Validating XML';
      DoCheckUADCompliance;
      lblProgress.caption := 'XML Review Complete';
*)
    except
      on E : Exception do
        begin
          PopMouseCursor;
          ShowAlert(atWarnAlert, E.Message);
        end;
    end;
  finally
    PopMouseCursor;
  end;
end;

procedure TAMC_BuildX26.DoCreateXML_Mismo26;
var
  xmlVer: String;
  formList: BooleanArray;
  miscInfo: TMiscInfo;
begin
  xmlVer := NonUADVer;
  formList := PackageData.FFormList;
  miscInfo := TMiscInfo.Create;
  try
    miscInfo.FEmbedPDF := False;
    miscInfo.FPDFFileToEmbed := '';

    FXMLFile := ComposeGSEAppraisalXMLReport(FDoc, xmlVer, formList, miscInfo, nil);

    if length(FXMLFile)>0 then
      begin
        ShowStatusNote(True);
        btnCreateXML.Enabled := False;
      end
    else
      ShowStatusNote(False);
  finally
    miscInfo.Free;
  end;
end;

procedure TAMC_BuildX26.DoProcessData;
var
  dFile: TDataFile;
  ok:Boolean;
begin
  inherited;

  PackageData.FGoToNextOk := False;
  PackageData.FHardStop := True;
  PackageData.FAlertMsg := 'You need to create the XML file before preceding to the next step.';
  if (Length(FXMLFile)> 0) then
    begin
      ok := XMLValidatedAginstSchema;
      if ok then
        begin
          // Recreate the XML in case the user made last minute changes.
          //  This ensures that the XML and PDF match.
          DoCreateXML_Mismo26;
          dFile := PackageData.DataFiles.GetDataFileObj(fTypXML26, True);    //Should NEVER have to create it
          dFile.FData := FXMLFile;

          PackageData.FGoToNextOk := True;
          PackageData.FHardStop := False;
          PackageData.FAlertMsg := '';
        end
      else begin
          ShowAlert(atWarnAlert, 'ClickFORMS is unable to create a valid XML file. ' +
            'You cannot proceed to the next step until a valid XML file is created. ' +
            'For assistance please e-mail your ClickFORMS file (the "clk" file) to support@bradfordsoftware.com.');
          PackageData.FAlertMsg := '';
          ShowStatusNote(False);

  //DEBUG         SaveXMLToFile;
        end;
    end;
end;

procedure TAMC_BuildX26.SaveXMLToFile;
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

procedure TAMC_BuildX26.ShowStatusNote(success: Boolean);
begin
  if success then
    stxStatusNote.caption := 'The XML file was created.'
  else
    begin
      stxStatusNote.caption := 'There was a problem creating the XML file.';
      stxStatusNote.Font.Color := clRed;
    end;
end;


//this is a good function to put in UAMC_XMLUtils
function TAMC_BuildX26.XMLValidatedAginstSchema: Boolean;
var
  XSD_FileName: String;
  cache: IXMLDOMSchemaCollection;
  srcXMLDoc: IXMLDomDocument2;
  XMLVer: String;
begin
  result := false;

  {if FDoc.UADEnabled then
    XMLVer := UADVer
  else}
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

//      result := srcXMLDoc.parseError.errorCode = 0;  //this is not reliable, even we got the valid xml the errorcode return some negative #
      result := True;
    end
  else
    ShowAlert(atStopAlert, 'The XML validation schema file, "' + ExtractFileName(XSD_FileName) +
               '," cannot be found. The XML file cannot be properly validated.');
end;
(*
procedure TAMC_BuildX26.ListView1AdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  if Item.Index mod 2 = 0 then
    (Sender as TListView).Canvas.Brush.Color := $f5f5f5 ;
end;

procedure TAMC_BuildX26.ListView1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  i, j: Word;
begin
  i := StrToInt(Item1.SubItems[Item1.SubItems.Count - 1]) ;
  j := StrToInt(Item2.SubItems[Item2.SubItems.Count - 1]) ;

  if i < j then
    Compare := -1
  else
  if i > j then
    Compare := 1
  else
    Compare := 0;
end;

procedure TAMC_BuildX26.ListView1DblClick(Sender: TObject);
//var
//  i: Byte;
//  InfoType: String;
begin
  if ListView1.ItemIndex < 0 then
    Exit;
  //ShowMessage(ListView1.Items[ListView1.ItemIndex].Caption);
  frmInfo.ListView1.Items.Clear;

  frmInfo.ListView1.AddItem(ListView1.Columns[0].Caption, nil);
  frmInfo.ListView1.Items[frmInfo.ListView1.Items.Count - 1].SubItems.Add(ListView1.Items[ListView1.ItemIndex].Caption);

  for i := 0 to ListView1.Items[ListView1.ItemIndex].SubItems.Count - 1 do
  begin

    if i + 1 <= ListView1.Columns.Count - 1 then
      InfoType := ListView1.Columns[i + 1].Caption
    else
      case i  of
        4: InfoType := 'XPath';
        5: InfoType := 'Current Value (diagnostic)';
        6: InfoType := 'UAD Ref';
        7: InfoType := 'Ini ID'
      end;


    frmInfo.ListView1.AddItem(InfoType, nil);
    frmInfo.ListView1.Items[frmInfo.ListView1.Items.Count - 1].SubItems.Add(ListView1.Items[ListView1.ItemIndex].SubItems[i]);

  end;

  case ListView1.Items[ListView1.ItemIndex].ImageIndex of
    0:  frmInfo.Panel1.Color := clRed;
    1:  frmInfo.Panel1.Color := clYellow;
    2:  frmInfo.Panel1.Color := clGreen;
    3:  frmInfo.Panel1.Color := clRed;
  end;


  frmInfo.ShowModal;
end;

procedure TAMC_BuildX26.ListView1InfoTip(Sender: TObject; Item: TListItem; var InfoTip: String);
begin
//  if not Hints1.Checked then
//    Exit;

 if Item.ImageIndex = 0 then
 begin
  InfoTip := #13 + '    Error: ' + Item.SubItems[2] + '    ' + #13 + #13  +
             '    Suggestion: ' + Item.SubItems[3] + '    '+ #13;

  Application.HintColor := RGB(255, 160, 160);
 end;


 if Item.ImageIndex = 1 then
 begin
  InfoTip := #13 + '    Warning: ' + Item.SubItems[2] + '    '+ #13;


  Application.HintColor := RGB(255, 255, 128);
 end;

 if Item.ImageIndex = 2 then
 begin
  InfoTip := #13 + '    Current Value: ' + Item.SubItems[1] + '    ' + #13;


  Application.HintColor := RGB(128, 255, 128);
 end;


 if Item.ImageIndex = 3 then
 begin
  InfoTip := #13 + '    Error: ' + Item.SubItems[2] + '    ' + #13 + #13  +
             '    Path: ' + Item.SubItems[0] + '    '+ #13 + #13 +
             '    Used by UAD: ' + Item.SubItems[6] + '    ' + #13;

  Application.HintColor := RGB(255, 80, 80);
 end;

end;
*)

end.
