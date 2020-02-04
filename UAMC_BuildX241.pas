unit UAMC_BuildX241;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  UContainer, UAMC_Base, UAMC_WorkflowBaseFrame;

type
  TAMC_BuildX241 = class(TWorkflowBaseFrame)
    stxStatusNote: TStaticText;
    btnCreateXML: TButton;
    procedure btnCreateXMLClick(Sender: TObject);
  private
    FXMLFile: String;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage); override;
    procedure InitPackageData;     override;
    procedure StartProcess;        override;
    procedure DoProcessData;       override;
    procedure CreateXML_Mismo241;
    procedure DoCreateXML_Mismo241;
    procedure ShowStatusNote(success: Boolean);
    procedure SaveXMLToFile;
  end;

implementation

{$R *.dfm}

uses
  UUtil1, UWindowsInfo, UGlobals, UMISMOInterface, UStatus, UAMC_XMLUtils, UMyClickForms, UAMC_Delivery;

{ TAMC_CreateXMLBase }

constructor TAMC_BuildX241.CreateFrame(AOwner: TComponent; ADoc: TContainer; AData: TDataPackage);
begin
  inherited;

  stxStatusNote.Caption := 'Creating XML file';
  FXMLFile := '';
end;

procedure TAMC_BuildX241.InitPackageData;
begin
  inherited;
//** Set btnCreateXML enabled when previous or next button is enabled
  btnCreateXML.Enabled := UAMC_Delivery.AMCDeliveryProcess.btnPrev.Enabled or UAMC_Delivery.AMCDeliveryProcess.btnNext.Enabled;
  //
end;

procedure TAMC_BuildX241.btnCreateXMLClick(Sender: TObject);
begin
  CreateXML_Mismo241;
end;

procedure TAMC_BuildX241.StartProcess;
begin
  CreateXML_Mismo241;
end;

procedure TAMC_BuildX241.CreateXML_Mismo241;
begin
  PushMouseCursor(crHourGlass);
  try
    try
      DoCreateXML_Mismo241;

      btnCreateXML.Caption := 'Re-Check XML';

      AdvanceToNextProcess;        //auto advance
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

procedure TAMC_BuildX241.DoCreateXML_Mismo241;
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

    FXMLFile := ComposeAppraisalXMLReport(FDoc, formList, miscInfo, nil);

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

procedure TAMC_BuildX241.DoProcessData;
var
  dFile: TDataFile;
begin
  inherited;

  PackageData.FGoToNextOk := False;
  PackageData.FHardStop := True;
  PackageData.FAlertMsg := 'You need to create the XML file before preceding to the next step.';
  if (Length(FXMLFile)> 0) then
    begin
      // Recreate the XML in case the user made last minute changes.
      //  This ensures that the XML and PDF match.
      DoCreateXML_Mismo241;
      dFile := PackageData.DataFiles.GetDataFileObj(fTypXML241, True);    //Should NEVER have to create it
      dFile.FData := FXMLFile;

      PackageData.FGoToNextOk := True;
      PackageData.FHardStop := False;
      PackageData.FAlertMsg := '';
      // No 2.4.1 schema so use the following for debug only
//      SaveXMLToFile;
    end;
end;

procedure TAMC_BuildX241.SaveXMLToFile;
var
  fName, myClkDir: String;
  SaveDialog: TSaveDialog;
  XMLStream: TFileStream;
begin
  myClkDir := MyFolderPrefs.MyClickFormsDir;
  fName := GetNameOnly(FDoc.docFileName) + '_MISMO_XML';

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

procedure TAMC_BuildX241.ShowStatusNote(success: Boolean);
begin
  if success then
    stxStatusNote.caption := 'The XML file was created.'
  else
    begin
      stxStatusNote.caption := 'There was a problem creating the XML file.';
      stxStatusNote.Font.Color := clRed;
    end;
end;

end.
