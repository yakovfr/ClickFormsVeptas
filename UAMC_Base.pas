unit UAMC_Base;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  SysUtils,Forms, Contnrs,Classes,
  UGlobals, UAMC_Globals, UContainer;

const
{ The types of data contained in TDataFile}
  fTypXML241   = 'MISMO241';
  fTypXML26    = 'MISMO26';
  fTypXML26GSE = 'MISMO26GSE';
  fTypPDF      = 'PDFfile';
  fTypENV      = 'ENVfile';

type
{ Each type of data file that is required by the AMC will be }
{ held in a TDataFile object. This object will know everything}
{ about the data file.                                        }
  TDataFile = class(TObject)
    FType: String;
    FData: String;
    FEmbedPDF: Boolean;         //not used
    FB64Encoded: Boolean;       //not used
    function GetHasData: Boolean;
  public
    constructor Create(fileType: String);
    destructor Destroy; override;
    procedure LoadFromFile(fPath: String);
    procedure SaveToFile(fPath: String);
    procedure LoadFromStream(AStream: TFileStream);
    procedure SaveToStream(AStream: TFileStream);
    property HasData: Boolean read GetHasData;
  end;

{ The list of TDataFiles will be held in a TListObject so that}
{ all the data files can be handled easily as an array. Note }
{ that the TListObject will own the DataFile objects.        }
  TDataFileList = class(TObjectList)
    procedure InitDataFile(thisFormat: String);                //creates empty DataFile Obj or inits existing FData
    procedure DeleteDataFile(thisFormat: String);              //deletes form list
    function NeedsDataFile(thisFormat: String): Boolean;       //package requires this file type
    function GetDataFileObj(thisFormat: String; createIt: Boolean): TDataFile;
    function DataFileHasData(thisFormat: String): Boolean;
  end;

{ TDataPackage is the key object that moves form one process to }
{ the next. At each step (or process) it collects more data until}
{ it reaches the end of the workflow where it now has all the data}
{ and is ready to be delivered to the designated client. Note, there}
{ is only one TDataPackage object. It is just forwarded between steps}

  TDataPackage  = class(TObject)          //holds data each process needs
    FNeedsXML: Boolean;                   //does an XML file need to be created?
    FIsUAD: Boolean;                      //is doc UAD?
    FXMLVersion: Integer;
    FPgList: BooleanArray;                //Pages that will be PDF'ed
    FFormList: BooleanArray;              //Forms that will be exported in XML

    FImgOptimized: Boolean;               //True if the images have been optimized
    FHasImgToOptmize: Boolean;            //True if the Doc has images that can be optimized

    //the AMC or client order ID
    FOrderID: String;                     //the AMC OrderID

    //property address of this order
    FAddress: String;                     //subject address used to auto-assoc orderID with appraisal
    FCity: String;                        //subject city
    FState: String;                       //subject state
    FZip: String;                         //subject zip
    FUnitNo: String;                      //subject unitNo
    FFullAddress: String;                 //used to display subject address for user

    FEmbbedPDF: Boolean;                  //True if the PDF needs to be embedded in XML
    FPDFTmpFilePath: String;              //path to tmp PDF. Its deleted at the end of delivery process

    FSavePDFCopy: Boolean;                //REMOVE user wants a copy of PDF
    FSaveXMLCopy: Boolean;                //REMOVE user wants a copy of XML

    FForceContents: Boolean;              //True if User has no choice in package contents
    FFixedWorkflow: Boolean;              //True if user cannot skip any workflow steps - such as uploading to AppraisalPort
    FReviewOverride: Boolean;             //if the user skips any hard errors during review

    FMainFormName: String;                //needed to set UAD Checker rules
    FNeedXML241: Boolean;                 //requires XML 241 - this is RELS only (user cannot select this)
    FNeedXML26: Boolean;                  //requires MISMO 26; embedded PDF if FEmbbedPDF = True
    FNeedXML26GSE: Boolean;               //requires MISMO 26 GSE; embedded PDF if FEmbbedPDF = True
    FNeedPDF: Boolean;                    //requires PDF file (selected if separate or embedded)
    FNeedENV: Boolean;                    //requires ENV file

    FDataFiles: TDataFileList;            //array where all data files (XML, ENV, PDF, etc) are stored

    FDeliveryType: Integer;               //Appraisal Delivery Type
    FAMC_UID: Integer;                    //Unique identifier of AMC if delivery Type is adUpload
    FWorkFlowUID: Integer;                //UID for the workflow
    FAMCData: TObject;                    //specific data for AMC (each AMC has it own instructions)

    FAutoAdvance: Boolean;                //True if each step auto advances to next step
    FDisplayPDF: Boolean;                 //True if PDF is to be displayed upon creation
    FProtectPDF: Boolean;                 //True if PDF is to be protected. Default = True

    FGoToNextOk: Boolean;                 //Has to be True to move to next process step.
    FHardStop: Boolean;                   //True if this ia hard stop at this step.
    FAutoNext: Boolean;                   //if True, automatically move to next station
    FAutoSkip: Boolean;                   //if True, skip the next station
    FAlertMsg: String;                    //If FNextStepOK=False, this is user instruction on how to make it True
    FEndMsg: String;                      //message that user sees at end of process
    FModified: Boolean;                   //tracks if its been modified in the current process step (reset at each step)
  private
    FTotalImgSize: Integer;
    procedure SetDeliveryType(const Value: Integer);
    procedure SetAMCIdentifier(const Value: Integer);
    procedure SetIsUAD(const Value: Boolean);
    procedure SetNeedPDF(const Value: Boolean);
    procedure SetNeedENV(const Value: Boolean);
    procedure SetNeedsXML(const Value: Boolean);
    procedure SetXMLVersion(const Value: Integer);
    procedure SetPgList(const Value: BooleanArray);
    procedure SetFormList(const Value: BooleanArray);
    procedure SetImgOptimized(const Value: Boolean);
    procedure SetTotalImgSize(const Value: Integer);
    procedure SetOrderID(const Value: String);
    function GetNeedENV: Boolean;
    function GetNeedPDF: Boolean;
    function GetNeedXML241: Boolean;
    function GetNeedXML26: Boolean;
    function GetNeedXML26GSE: Boolean;
  public
    constructor Create;
    destructor Destroy;  override;
    procedure SetSubjectAddress(ADoc: TContainer);
    procedure CheckForImages(ADoc: TContainer);
    property Modified: Boolean read FModified write FModified;
    property DeliveryType : Integer read FDeliveryType write SetDeliveryType;
    property AMCIdentifier: Integer read FAMC_UID write SetAMCIdentifier;
    property IsUAD: Boolean read FIsUAD  write SetIsUAD;
    property XMLVersion: Integer read FXMLVersion write SetXMLVersion;
    property PgList: BooleanArray read FPgList write SetPgList;
    property FormList: BooleanArray read FFormList write SetFormList;
    property HasImages: Boolean read FHasImgToOptmize write FHasImgToOptmize;
    property ImagesOptimized: Boolean read FImgOptimized write SetImgOptimized;
    property TotalImageSize: Integer read FTotalImgSize write SetTotalImgSize;
    property NeedsXML: Boolean read FNeedsXML write SetNeedsXML;
    property NeedX26GSE: Boolean read GetNeedXML26GSE write FNeedXML26GSE;
    property NeedX26: Boolean read GetNeedXML26 write FNeedXML26;
    property NeedX241: Boolean read GetNeedXML241 write FNeedXML241;
    property NeedPDF: Boolean read GetNeedPDF write SetNeedPDF;
    property NeedENV: Boolean read GetNeedENV write SetNeedENV;
    property OrderID: String read FOrderID write SetOrderID;
    property WorkflowID: Integer read FWorkFlowUID write FWorkFlowUID;
    property FixedWorkflow: Boolean read FFixedWorkflow write FFixedWorkflow;
    property DataFiles: TDataFileList read FDataFiles write FDataFiles;
    property SubjectAddress: String read FFullAddress write FFullAddress;
    property AutoAdvance: Boolean read FAutoAdvance write FAutoAdvance;
    property TempPDFFile: String read FPDFTmpFilePath write FPDFTmpFilePath;
    property ProtectPDF: Boolean read FProtectPDF write FProtectPDF;
  end;


  //Object for associating AMC display with ID
  TAMC_UID = class(TObject)               //object to hold the name & ID of AMC
    FName: String;                        //this is so we can list in any order & still identiy
    FUID: Integer;
    FActive: Boolean;
  end;



  //Base untility routines for woking with AMC Workflow
  function CreateAMC_UID(AMCName: String; AMCUID: Integer; IsEnabled: Boolean): TAMC_UID;



implementation


uses
  UCell, UGraphics, UFileUtils, UStatus;



  
{ Base Utility Routines for working with AMC Workflow}

function CreateAMC_UID(AMCName: String; AMCUID: Integer; IsEnabled: Boolean): TAMC_UID;
begin
  result := TAMC_UID.Create;
  result.FName := AMCName;
  result.FUID := AMCUID;
  result.FActive := IsEnabled;
end;


{ TDataPackage }

//NOTE: Make sure defaults sync with delivery selection Frame
constructor TDataPackage.Create;
begin
  inherited;

  FPgList := nil;                     //Pages that will be PDF'ed
  FFormList := nil;                   //Forms that will be exported in XML

  FHasImgToOptmize := True;           //assume we have images
  FImgOptimized    := False;          //not optimized

  FNeedsXML       := False;
  FIsUAD          := False;
  FXMLVersion     := cNoXML;

  FForceContents  := False;          //True if User has no choice in package contents
  FFixedWorkflow  := True;           //True if no workflow steps can be skipped, does not allow user to set preference
  FReviewOverride := False;          //review had errors and was overridden.
  FEmbbedPDF      := True;           //default is True - this typical

  FDataFiles := TDataFileList.Create(True);   //TListObj owns the objects

  FSavePDFCopy := True;               //user wants a copy of PDF
  FSaveXMLCopy := True;               //user wants a copy of XML

  FDeliveryType := adSavePack;        //Appraisal Delivery Type
  FAMC_UID      := -1;                //Unique identifier of AMC
  FWorkFlowUID  := -1;                //no workflow defined yet
  FAMCData      := nil;               //no AMC object at startup

  FOrderID      := '';                //standard holder for the order ID - everyone has one

  FAddress      := '';                //subject address used to auto-assoc orderID with appraisal
  FCity         := '';                //subject city
  FState        := '';                //subject state
  FZip          := '';                //subject zip
  FUnitNo       := '';                //subject unitNo
  FFullAddress  := '';                //used to display subject address for user

  FMainFormName := '';                //no main form name yet

  FAutoAdvance  := False;             //is reset from global preferences
  FDisplayPDF   := True;              //is reset from global preferences
  FProtectPDF   := True;              //is reset from global preferences

  FGoToNextOk   := True;              //Has to be True to move to next process step.
  FHardStop     := False;             //This is a hard stop at this step!
  FAutoNext     := False;             //if True, automatically move to next station
  FAutoSkip     := False;             //if True, skip the next station
  FAlertMsg     := '';                //If FNextStepOK=False, this is user instruction on how to make it True
  FEndMsg       := '';                //message at end of porcess, last step sets it

  FModified     := False;             //lets us know if something has happened.
end;

destructor TDataPackage.Destroy;
begin
  if assigned(FPgList) then
    FPgList := nil;          //frees the list

  if assigned(FFormList) then
    FFormList := nil;

  if assigned(FAMCData) then
    FAMCData.Free;

  if assigned(FDataFiles) then
    FDataFiles.Free;

  inherited;
end;

procedure TDataPackage.SetAMCIdentifier(const Value: Integer);
begin
  FAMC_UID := Value;
  FModified := True;
end;

procedure TDataPackage.SetDeliveryType(const Value: Integer);
begin
  FDeliveryType := Value;
  FModified := True;
end;

procedure TDataPackage.SetFormList(const Value: BooleanArray);
begin
  FFormList := Value;
  FModified := True;
end;

procedure TDataPackage.SetImgOptimized(const Value: Boolean);
begin
  FImgOptimized := Value;
  FModified := True;
end;

procedure TDataPackage.SetNeedENV(const Value: Boolean);
begin
  FNeedENV := Value;
  FModified := True;
end;

function TDataPackage.GetNeedENV: Boolean;
begin
  result := DataFiles.NeedsDataFile(fTypENV);
end;

procedure TDataPackage.SetNeedPDF(const Value: Boolean);
begin
  FNeedPDF := Value;
  FModified := True;
end;

function TDataPackage.GetNeedPDF: Boolean;
begin
  result := DataFiles.NeedsDataFile(fTypPDF);
end;

function TDataPackage.GetNeedXML241: Boolean;
begin
  result := DataFiles.NeedsDataFile(fTypXML241);
end;

function TDataPackage.GetNeedXML26: Boolean;
begin
  result := DataFiles.NeedsDataFile(fTypXML26);
end;

function TDataPackage.GetNeedXML26GSE: Boolean;
begin
  result := DataFiles.NeedsDataFile(fTypXML26GSE);
end;

//Don't set FModified, this is called on Init, not by user
procedure TDataPackage.SetIsUAD(const Value: Boolean);
begin
  FIsUAD := Value;
  if value then
    begin
      FNeedsXML := value;
      FXMLVersion := cMISMO26GSE;
    end;
//  FModified := True; 
end;

procedure TDataPackage.SetNeedsXML(const Value: Boolean);
begin
  FNeedsXML := Value;
  FModified := True;
end;

procedure TDataPackage.SetPgList(const Value: BooleanArray);
begin
  FPgList := Value;
  Fmodified := True;
end;

procedure TDataPackage.SetTotalImgSize(const Value: Integer);
begin
  FTotalImgSize := Value;
  Fmodified := True;
end;

procedure TDataPackage.SetXMLVersion(const Value: Integer);
begin
  FXMLVersion := Value;
  Fmodified := True;
end;

procedure TDataPackage.SetOrderID(const Value: String);
begin
  FOrderID := Value;
  Fmodified := True;
end;

procedure TDataPackage.SetSubjectAddress(ADoc: TContainer);
var
  fullAddress: String;
begin
  FAddress := Trim(ADoc.GetCellTextByID(46));
  FCity    := Trim(ADoc.GetCellTextByID(47));
  FState   := Trim(ADoc.GetCellTextByID(48));
  FZip     := Trim(ADoc.GetCellTextByID(49));
  FUnitNo  := Trim(ADoc.GetCellTextByID(2141));

  fullAddress := FAddress + '  ' + FCity + ', ' + FState + ' ' + FZip;
  if length(FUnitNo) > 0 then
    fullAddress := fullAddress + ' #' + FUnitNo;

  FFullAddress := Trim(fullAddress);
end;

{ TDataFile }

constructor TDataFile.Create(fileType: String);
begin
  inherited Create;

  FData := '';
  FType := fileType;
  FEmbedPDF := False;
end;

destructor TDataFile.Destroy;
begin
   FData := '';
   FType := '';

  inherited;
end;


function TDataFile.GetHasData: Boolean;
begin
  result := Length(FData) > 0;
end;

procedure TDataFile.LoadFromFile(fPath: String);
var
  fileStream: TFileStream;
begin
  if FileExists(fPath) then
    begin
      fileStream := TFileStream.Create(fPath, fmOpenRead);
      try
        LoadFromStream(fileStream);
      finally
        fileStream.Free;
      end;
    end;
end;

procedure TDataFile.LoadFromStream(AStream: TFileStream);
var
  streamLen: LongInt;
begin
  if assigned(AStream) then
    begin
      AStream.Seek(0,soFromBeginning);
      streamLen := AStream.size;
      SetLength(FData, streamLen);
      AStream.Read(Pchar(FData)^, streamLen);
    end;
end;

procedure TDataFile.SaveToStream(AStream: TFileStream);
var
  dataLen: LongInt;
begin
  if assigned(AStream) then
    begin
      AStream.Seek(0,soFromBeginning);
      dataLen := length(FData);
      AStream.Write(Pchar(FData)^, dataLen);
    end;
end;

procedure TDataFile.SaveToFile(fPath: String);
var
  fileStream: TFileStream;
begin
  if CreateNewFile(fPath, fileStream) then
    try
      SaveToStream(fileStream);
    finally
      fileStream.Free;
    end;
end;

{ TDataFileList }

//If the file Object is in the list, this is the signal that that file
//type is required. We are not relying on boolean flags to indicate this.
function TDataFileList.NeedsDataFile(thisFormat: String): Boolean;
var
  n: Integer;
begin
  result := False;
  for n := 0 to count-1 do
    if TDataFile(Items[n]).FType = thisFormat then
      begin
        result := True;
        break;
      end;
end;

function TDataFileList.DataFileHasData(thisFormat: String): Boolean;
var
  dFile: TDataFile;
begin
  result := False;
  dFile := GetDataFileObj(thisFormat, False);
  if assigned(dFile) then
    result := dFile.HasData;
end;

procedure TDataFileList.DeleteDataFile(thisFormat: String);
var
  dFile: TDataFile;
begin
  dFile := GetDataFileObj(thisFormat, false);
  if assigned(dFile) then
    Remove(dFile);
end;

function TDataFileList.GetDataFileObj(thisFormat: String; createIt: Boolean): TDataFile;
var
  n: Integer;
  dFile: TDataFile;
begin
  result := nil;
  for n := 0 to count-1 do
    if TDataFile(Items[n]).FType = thisFormat then
      begin
        result := TDataFile(Items[n]);
        break;
      end;

  if (result = nil) and createIt then
    begin
      dFile := TDataFile.Create(thisFormat);    //create it
      Add(dFile);                               //add it
      result := dFile;                          //return it
    end;
end;

procedure TDataFileList.InitDataFile(thisFormat: String);
var
  dFile: TDataFile;
begin
  dFile := GetDataFileObj(thisFormat, True);
  dFile.FData := '';
end;

procedure TDataPackage.CheckForImages(ADoc: TContainer);
var
  f,p,c: Integer;
  aCell: TBaseCell;
begin
  HasImages := False;
  if assigned(ADoc) then
    with ADoc do
    for f := 0 to docForm.count-1 do
      for p := 0 to docForm[f].frmPage.count-1 do
        if assigned(docForm[f].frmPage[p].PgData) then          //does page have cells?
        for c := 0 to docForm[f].frmPage[p].PgData.count-1 do
          begin
            aCell := docForm[f].frmPage[p].PgData[c];
            if aCell is TGraphicCell then
              if TGraphicCell(aCell).FImage.HasDib then        //do not include metafiles
                begin
                  HasImages := True;                           //we have at least one image
                  break;
                end;
          end;
end;

end.
