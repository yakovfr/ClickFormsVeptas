unit UAMC_Workflow;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This is the unit where the workflow manager is implemented. Eash step or    }
{ process in the workflow is created here as well. The process sequence is    }
{ also defined here. Each AMC may have a different sequence and they may have }
{ very specific processes. Generic and AMC-specific processes make up the     }
{ workflow that the manager contorls.                                         }
{ Each process has a User interface based on a base Frame                     }


interface

uses
  Classes, Contnrs, Types, ComCtrls,
  Messages, SysUtils, Variants, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,

  UGlobals, UContainer, UAMC_Globals, UAMC_Base, UAMC_WorkflowBaseFrame,
  UAMC_Select, UAMC_UserID, UAMC_EOReview, UAMC_OptImages, UAMC_SelectForms,
  UAMC_PackageDef, UAMC_SendPak, UAMC_AckSend, UAMC_SavePak,
  UAMC_BuildX241, UAMC_BuildX26, UAMC_BuildX26GSE, UAMC_BuildENV, UAMC_BuildPDF,
  UAMC_UserID_StreetLinks, UAMC_SendPak_StreetLinks, UAMC_UserID_ISGN, UAMC_SendPak_ISGN,
  UAMC_UserID_TitleSource, UAMC_SendPak_TitleSource, UAMC_UserID_Landmark,UAMC_SendPak_Landmark,
  UAMC_PDSReview,UAMC_UserID_MercuryNetwork, UAMC_SendPak_MercuryNetwork, UAMC_DigitalSignature;

const
  //ProcessStep IDs
  cDeliveryOpt    = 0;     //select Delivery Method & client
  cUserIdentity   = 1;     //UserID - generic
  cPackAMCDef     = 2;     //the appraisal package is defined by the AMC
  cPackUserDef    = 2;      //the appraisal package is defined by the User
  cSelectForms    = 3;     //specify which forms/pages compose the report
  cOptImages      = 4;     //optimize the images
  cEOReview       = 5;     //perform the E&O reviews
  cBuildX241      = 6;     //Create the different types of XML
  cBuildX26GSE    = 7;
  cBuildX26       = 8;
  cPDSReview      = 9;
  cBuildENV       = 10;
  cBuildPDF       = 11;     //preview / save copy of PDF
  cDigitallySign    = 12;      //digitally sign MISMO XML
  cUploadXPak     = 13;     //cUpEmSavXPak
  cEmailXPak      = 13;     //goes in same step
  cSaveXPak       = 14;
  cAckSend        = 15;

  cUserID_RELS    = 16;    //UserID - RELS specific
  cUserID_StLinks = 17;    //UserID - streetlinks

  //differnt workflows
  wfUndefined     = -1;
  wfSaveFiles     = 0;
  wfEMailFiles    = 1;
  wfRELS          = 2;
  wfValulink      = 3;
  wfKylptix       = 4;
  wfClearCapital  = 5;
  wfStreetLinks   = 6;
  wfPCVMurcor     = 7;
  wfAppraisalPort = 8;
  wfCoreLogic     = 9;
  wfISGN          = 10;
  wfTitleSource   = 11;
  wfLandMark      = 12;
  wfEadPortal     = 13;
  wfMercuryNetwork = 21;   //1202  add workflow for Mercury Network
  wfVeptas         = 22;
//  wfWoodfinn      = 901;

  SPACE = #32#32#32#32#32#32#32#32#32#32#32#32#32#32#32;   //give it 15 spaces for spaces between the process label and the hint
  HINT  = 'Double Click the Error to Locate it Within the Report';


type
{ Each step in the process has a TAMCProcessStep object. This object manages}
{ the association between the workflow mgr and the user display. The way data}
{ flows between processes is with the data object FData which the workflowMgr }
{ owns. FData is passed from one process to the next. At each step in the   }
{ process it collects more information, until it gets to the last step in the}
{ workflow where the data (appraisal package) is actually sent, emailed or saved}
{ to the desktop.}


  TAMCProcessMgr = class;                 //Mgr of list of TAMCProcessStep

{ This object will be subclassed to hold the specific }
{ TFrame user interface that will be associated with it }
  TAMCProcessStep = class(TObject)        //generic Workflow ProcessStep class
    FDoc: TContainer;
    FData: TDataPackage;                  //just a ref to TDataPackage owned by WorkflowMgr
    FDisplay: TTabSheet;                  //this is the tabsheet that owns the TFrame
    FUserDisplay: TWorkflowBaseFrame;     //Frame holds the user interface
    FProcessMgr: TAMCProcessMgr;          //WorkFlowMgr, it owns this object
    FName: String;                        //Title for this step that is displayed to user
    FStepUID: Integer;                    //Unique identifier for this step
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); virtual;
    function GetProcessTitle: String;  virtual;
  public
    constructor CreateProcess(AOwner: TAMCProcessMgr; ADoc: TContainer; ADisplay: TTabSheet; AData: TDataPackage);
    procedure InitData;  virtual;
    procedure AutoStartProcess;
    procedure DoProcessData;  virtual;
    function ProcessCompleted: Boolean; virtual;
    function ProcessedOK: Boolean;  virtual;
    procedure AlertUser;
    property Name: String read GetProcessTitle write FName;
    property StepID: Integer read FStepUID write FStepUID;
    property PackageData: TDataPackage read FData write FData;
    property DisplaySheet: TTabSheet read FDisplay write FDisplay;
  end;

  TAMCProcess_Selection = Class(TAMCProcessStep)          //Select delivery option
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_UserID = Class(TAMCProcessStep)             //Gets User IDs
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCPorcess_DefPackage = Class(TAMCProcessStep)         //define the package contents
  public
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_ReportContent = Class(TAMCProcessStep)    //Appraisal Report Contents
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_EOReview = Class(TAMCProcessStep)           //E&O Review Process
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_PDSReview = Class(TAMCProcessStep)           //E&O Review Process
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_ImageOptize = Class(TAMCProcessStep)      //Image Optimizer Process
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_BuildX241 = Class(TAMCProcessStep)      //generate the XML 241
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_BuildX26 = Class(TAMCProcessStep)      //generate the XML 26
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_BuildX26GSE = Class(TAMCProcessStep)      //generate the XML 26 GSE
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_BuildENV = Class(TAMCProcessStep)       //check the XML intercatively
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_BuildPDF = Class(TAMCProcessStep)       //preview & save the PDF
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_DigitalSignature = Class(TAMCProcessStep)  //Digitally sign MISMO XML
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_SendPak = Class(TAMCProcessStep)      //actually upload the package
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;

  TAMCProcess_SavePak = Class(TAMCProcessStep)      //save the files (for records or manual sending)
     procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
     function GetProcessTitle: String; override;
  end;

  TAMCProcess_AckSend = Class(TAMCProcessStep)         //last step - acknowledge package send/received
    procedure LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer); override;
  end;


{ This is the Workflow or ProcessMgr - it controls everything}

  TAMCProcessMgr = class(TObjectList)
    FDoc: TContainer;
    FData: TDataPackage;              //package data moves from process to process, to be delivered to AMC
    FDisplayMgr: TPageControl;        //owner that displays the Process Frames
    FCurIndex: Integer;               //sequence index of the current process
    FCurProcess: TAMCProcessStep;
    nMandatorySteps: Integer; //# of processes before BuildWorkFlow run
  private
    function GetCurStep: TAMCProcessStep;
    function GetLastStep: TAMCProcessStep;
    function GetNextStep: TAMCProcessStep;
    function GetPrevStep: TAMCProcessStep;
    procedure SetDoc(const Value: TContainer);
    procedure SetDisplayMgr(const Value: TPageControl);
    function GetNewProcessStep(ProcessID: Integer): TAMCProcessStep;
    function GetWorkFlowSequence(WorkflowID: Integer): IntegerArray;
    function GetMaxSteps: Integer;
    function SkipToNextValidStep: TAMCProcessStep;
    function SkipToPrevValidStep: TAMCProcessStep;
  public
    constructor Create(AOwnsObjects: Boolean; ADoc: TContainer; ADisplayMgr: TPageControl);
    destructor Destroy; override;
    procedure InitStartUpProcess;
    function GetWorkFlowUID(AData: TDataPackage): Integer;
    function GetAMCWorkFlowUID(AMC_UID: Integer): Integer;
    procedure SetProcessTitle(ATitle: String);
    procedure SetWorkFlowPrefs(workflowID: Integer);
    procedure BuildSequenceFor(workflowID: Integer);
    procedure BuildWorkFlow;
    procedure ClearWorkflow;
    procedure Switch2NewProcess(NewProcess: TAMCProcessStep; MovingForward: Boolean);
    procedure MoveToNextProcess;
    procedure MoveToPrevProcess;
    procedure DisplayCurProcess;
    procedure MakeProcessCurrent(Value: TAMCProcessStep);
    function CurProcessIsFirst: Boolean;

    property Doc: TContainer read FDoc write SetDoc;
    property DisplayMgr: TPageControl read FDisplayMgr write SetDisplayMgr;
    Property PackageData: TDataPackage read FData write FData;
    property CurStep: TAMCProcessStep read GetCurStep;
    property NextStep: TAMCProcessStep read GetNextStep;
    property PrevStep: TAMCProcessStep read GetPrevStep;
    property LastStep: TAMCProcessStep read GetLastStep;
    property MaxSteps: Integer read GetMaxSteps;
    property CurIndex: Integer read FCurIndex;  // write SetCurIndex;
    property CurProcess: TAMCProcessStep read FCurProcess;
  end;

  function GetAMCList: TObjectList;      //untility for creating the display list of AMCs

implementation

uses
  Graphics, UUtil1, UStatus, UAMC_Delivery;

const
{ Appraisal Package Delivery Workflow Steps}
{ Each process displays itself in one of these steps or TabSheets in the }
{ PageControl. There are 12 TabSheets, so 12 possible steps in the workflow}
{ These are the steps, but the TabSheets are blank, anything can go in them}
{ So we insert TFrames to show the different users interfaces of each step.}

  //UIDs of the WorkFlow Steps
  cStep0_SelectAMC   = 0;     //select Delivery Method & client
  cStep1_UserID      = 1;     //identify the user
  cStep2_PackDef     = 2;     //the appraisal package is defined by the AMC
  cStep3_SelectPgs   = 3;     //specify which forms/pages compose the report
  cStep4_OptImgs     = 4;     //optimize the images
  cStep5_EOReview    = 5;     //perform the E&O reviews
  cStep6_BuildX241   = 6;     //Build MISMO XML 241
  cStep7_BuildX26GSE = 7;     //Build MISMO XML 26 GSE
  cStep8_BuildX26    = 8;     //Build MISMO XML 26
  cStep9_PDSReview   = 9;     //Platinum Data Solution Reviews
  cStep10_BuildENV   = 10;     //Build ENV file
  cStep11_BuildPDF   = 11;    //BUild PDF file
  cStep12_DigitallySign = 12;    //Digitally sign MISMO XML
  cStep13_SendPak    = 13;    //email/uploading XML
  cStep14_SavePak    = 14;    //save the files
  cStep15_AckSend    = 15;    //acknowledge success- ask for suggestions


{ Utility Routines }

function GetAMCList: TObjectList;
var
  AMCList: TObjectList;
begin
  AMCList := TObjectList.Create(True);
  if assigned(AMCList) then
    begin
///PAM      AMCList.Add(CreateAMC_UID('StreetLinks',   AMC_StreetLinks,  True));  //Ticket #1399: replace StreetLinks with Xome
      AMCList.Add(CreateAMC_UID('Xome',   AMC_StreetLinks,  True));
      AMCList.Add(CreateAMC_UID('AppraisalPort', AMC_FNC,          True));
      AMCList.Add(CreateAMC_UID('ISGN',          AMC_ISGN,         True));
      AMCList.Add(CreateAMC_UID('Amrock',   AMC_TitleSource,  True)); //Ticket #1237:  Replace TSI with Amrock
      AMCList.Add(CreateAMC_UID('FHA/EAD Portal',     AMC_EadPortal,    True));
      AMCList.Add(CreateAMC_UID('MercuryNetwork', AMC_MercuryNetwork, True)); //Ticket 1202
      AMCList.Add(CreateAMC_UID('Veptas', AMC_Veptas, True));
//      AMCList.Add(CreateAMC_UID('Clear Capital', AMC_ClearCapital, False));
//      AMCList.Add(CreateAMC_UID('CoreLigic',     AMC_CoreLogic,    False));
//      AMCList.Add(CreateAMC_UID('PCV Murcor',    AMC_PCVMurcor,    False));
///      AMCList.Add(CreateAM/C_UID('PCV Murcor',    AMC_PCVMurcor,    True));  //Turn on PCV
//      AMCList.Add(CreateAMC_UID('RELS/VSS',      AMC_RELS,         False));
//      AMCList.Add(CreateAMC_UID('ValueLink',     AMC_ValuLink,     False));
//      AMCList.Add(CreateAMC_UID('LSI',           AMC_LSI,          False));
    end;
  result := AMCList;
end;


{ TAMCProcessMgr }

constructor TAMCProcessMgr.Create(AOwnsObjects: Boolean; ADoc: TContainer; ADisplayMgr: TPageControl);
begin
  inherited Create(AOwnsObjects);

  // Clear any prior AMC Lender ID and ENV required flag so that validation depends on the
  //  values, if any, returned by the AMC - see UAMC_Util_ISGN.ISGNConvertRespToOrd function.
  AMCLenderID := '';
  AMCENV_Req := '';

  FDoc := ADoc;
  FDisplayMgr := ADisplayMgr;

  FCurIndex := 0;                       //first object will be default
  FData := TDataPackage.Create;         //the data that moves from process to process
  nMandatorySteps := 0;
end;

destructor TAMCProcessMgr.Destroy;
begin
  if assigned(FData) then
    FData.Free;
end;

procedure TAMCProcessMgr.SetDoc(const Value: TContainer);
begin
  FDoc := Value;
end;

procedure TAMCProcessMgr.SetDisplayMgr(const Value: TPageControl);
begin
  FDisplayMgr := Value;
end;

procedure TAMCProcessMgr.InitStartUpProcess;
var
  step: TAMCProcessStep;
begin
  //there 2 mandatory processes: TAMCProcess_ReportContent and TAMCProcess_Selection
  //the rest will be added to the process list in BuildSequence for later
  step := GetNewProcessStep(cSelectForms);
(*
  if assigned(FirstStep) then
    Add(FirstStep);
  //PAM: Ticket #1328 = the problem is here, should only MakeProcessCurrent if FirstStep is not Nil
  MakeProcessCurrent(FirstStep);                    //make it current
  FDisplayMgr.ActivePage := FirstStep.FDisplay;     //display it
*)
  if assigned(step) then //PAM: Ticket #1328 = do it this way, only process if FirstStep is not nil
    begin
      Add(step);
      MakeProcessCurrent(step);                    //make it current
      FDisplayMgr.ActivePage := step.FDisplay;     //display it
    end;

  step := GetNewProcessStep(cDeliveryOpt);
  if Assigned(step) then
    Add(step);

  nMandatorySteps := count;
end;

procedure TAMCProcessMgr.BuildSequenceFor(workflowID: Integer);
var
  WFSteps: IntegerArray;
  Step, NumSteps: Integer;
  AStep: TAMCProcessStep;
begin
  WFSteps := GetWorkFlowSequence(workflowID);    //get the workflow or the particular AMC or need
  NumSteps := Length(WFSteps);

  for Step := 0 to NumSteps-1 do
    begin
      AStep := GetNewProcessStep(WFSteps[Step]);  //build the workflow steps in specified sequence
      if assigned(AStep) then
        Add(AStep);
    end;
end;

procedure TAMCProcessMgr.BuildWorkFlow;
var
  workflowID: Integer;
begin
  workflowID := GetWorkFlowUID(FData);    //get WorkflowID from AMCs
  FData.FWorkFlowUID := workflowID;
  try
    SetWorkFlowPrefs(workflowID);
    //we already have 2 processes in process menager: Select form, and select delivery options
    // let's add the rest
    if workflowID > wfUndefined then
      BuildSequenceFor(workflowID);
  except
    //else set some flag that process was not completed
  end;
end;

//Undo BildWorkflow; retain mandatory processes
procedure TAMCProcessMgr.ClearWorkflow;
var
  FrameCntl: TControl;
  Process: TAMCProcessStep;
  i, n: Integer;
begin
  if Count > nMandatorySteps then
    begin
       //remove the TFrame form the display steps
      for i := nMandatorySteps to count-1 do
        begin
          Process := TAMCProcessStep(Items[i]);
          FrameCntl := Process.FDisplay.Controls[0];    //there is only one control (TFrame) per TabSheet
          Process.FDisplay.RemoveControl(FrameCntl);
          FrameCntl.Free;
        end;

      //now delete the Process Step objects
      n := count-1;
      for i := N downto nMandatorySteps do
        Delete(i);
    end;
end;

function TAMCProcessMgr.GetWorkFlowUID(AData: TDataPackage): Integer;
begin
  case AData.FDeliveryType of
    //save xml to a file
    adSavePack:
      result := wfSaveFiles;

    //email xml to a file
    adEmailPack:
      result := wfEMailFiles;

    //upload xml to an AMC
    adUploadPack:
      result := GetAMCWorkFlowUID(AData.FAMC_UID);
  else
    result := wfUndefined;
  end;

  //also set the result in the TDataPackage object
  AData.FWorkFlowUID := result;  //Set in Data; pass back as result.
end;

function TAMCProcessMgr.GetAMCWorkFlowUID(AMC_UID: Integer): Integer;
begin
  case AMC_UID of
    AMC_ValuLink:     result := wfValulink;
//    AMC_Landmark:     result := wfLandmark;
    AMC_StreetLinks:  result := wfStreetLinks;
    AMC_ISGN:         result := wfISGN;
    AMC_PCVMurcor:    result := wfPCVMurcor;
    AMC_RELS:         result := wfUndefined;
    AMC_ClearCapital: result := wfUndefined;
    AMC_LSI:          result := wfUndefined;
    AMC_CoreLogic:    result := wfCorelogic;
    AMC_FNC:          result := wfAppraisalPort;
//    AMC_Woodfinn:     result := wfWoodfinn;
    AMC_TitleSource:  result := wfTitleSource;
    AMC_EadPortal:    result := wfEadPortal;
    AMC_MercuryNetwork: result := wfMercuryNetWork;    //Ticket 1202
    AMC_Veptas:       result := wfVeptas;
   else
    result := wfUndefined;
  end;
end;

procedure TAMCProcessMgr.SetWorkFlowPrefs(workflowID: Integer);
begin
  case workflowID of
    wfSaveFiles:
      begin
        FData.FixedWorkFlow := False;
        FData.FForceContents := False;
      end;
    wfEMailFiles:
      begin
        FData.FixedWorkFlow := False;
        FData.FForceContents := False;
      end;
    wfRELS:
      begin
        FData.FixedWorkFlow := True;
      end;
    wfKylptix:
      begin
        FData.FixedWorkFlow := False;
      end;
    wfClearCapital:
      begin
        FData.FixedWorkFlow := True;
        FData.FForceContents := True;
      end;
    wfStreetLinks:
      begin
        FData.FixedWorkFlow := False;
        FData.FForceContents := True;
      end;
    wfPCVMurcor:
      begin
        FData.FixedWorkFlow := False;
        if TestVersion then
           FData.FForceContents := False  //to enable all the xml check boxes for us to test.
        else
           FData.FForceContents := True;
      end;
    wfAppraisalPort:
      begin
        FData.FixedWorkFlow := True;
        FData.FForceContents := True;
      end;
    wfCoreLogic:
      begin
        FData.FixedWorkFlow := True;
      end;
    wfISGN:
      begin
        FData.FixedWorkFlow := False;
        FData.FForceContents := True;
      end;
    wfTitleSource:
      begin
        FData.FixedWorkFlow := true;
        FData.FForceContents := True;
      end;
    wfEadPortal:
      begin
        FData.FixedWorkFlow := False;
        FData.FForceContents := True;
      end;
    wfMercuryNetwork:  //Ticket #1202
      begin
        FData.FixedWorkFlow := False;
        FData.FForceContents := True;
      end;
    else
      begin
        FData.FixedWorkFlow := True;
      end;
  end;
end;

procedure TAMCProcessMgr.SetProcessTitle(ATitle: String);
begin
  TAMCDeliveryProcess(FDisplayMgr.Owner).lblProcessName.Caption := ATitle;
end;

function TAMCProcessMgr.GetNewProcessStep(ProcessID: Integer): TAMCProcessStep;
begin
  case ProcessID of
    cDeliveryOpt:
      result := TAMCProcess_Selection.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep0_SelectAMC], FData);
    cUserIdentity:
      result := TAMCProcess_UserID.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep1_UserID], FData);
    cPackAMCDef:
      result := TAMCPorcess_DefPackage.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep2_PackDef], FData);
    cSelectForms:
      result := TAMCProcess_ReportContent.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep3_SelectPgs], FData);
    cOptImages:
      if appPref_AMCDelivery_SkipImageOpt then
        result := nil
      else  
        result := TAMCProcess_ImageOptize.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep4_OptImgs], FData);
    cEOReview:
      result := TAMCProcess_EOReview.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep5_EOReview], FData);
    cBuildX241:
      result := TAMCProcess_BuildX241.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep6_BuildX241], FData);
    cBuildX26GSE:
      result := TAMCProcess_BuildX26GSE.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep7_BuildX26GSE], FData);
    cBuildX26:
      result := TAMCProcess_BuildX26.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep8_BuildX26], FData);
//GH #1136: remove PDSReview
    cPDSReview:
//      if appPref_AMCDelivery_SkipPDSReview then
        result := nil;
//      else
//      result := TAMCProcess_PDSReview.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep8_BuildX26], FData);
    cBuildENV:
      result := TAMCProcess_BuildENV.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep10_BuildENV], FData);
    cBuildPDF:
      result := TAMCProcess_BuildPDF.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep11_BuildPDF], FData);
    cDigitallySign:
      result := TAMCProcess_DigitalSignature.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep12_DigitallySign], FData);
    cUploadXPak:
      result := TAMCProcess_SendPak.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep13_SendPak], FData);
    cSaveXPak:
      result := TAMCProcess_SavePak.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep14_SavePak], FData);
    cAckSend:
      result := TAMCProcess_AckSend.CreateProcess(Self, FDoc, FDisplayMgr.Pages[cStep15_AckSend], FData);
  else
    begin
      result := nil;
      ShowAlert(atWarnAlert, 'Process with Frame ID = ' + IntToStr(ProcessID) + ' does not exist.');
    end;
  end;
end;

//we need to read this from an INI file
function TAMCProcessMgr.GetWorkFlowSequence(WorkflowID: Integer): IntegerArray;
var
  WFSteps: IntegerArray;
  isUadXML: boolean;
begin
  //Yakov 01/15/19 Remove Select Forms ptocess from arrays
  //Now the process is created before calling BuildWorkflow
  isUadXML := FData.IsUAD;  //set by TAMC_SelectForms
  case WorkflowID of
    wfSaveFiles: //Excludes cOptImages and cEOReview
      //if doc.UADEnabled then
      if isUadXML then
      begin
        SetLength(WFSteps, 9);
        WFSteps[0] := cPackAMCDef;
        //WFSteps[1] := cSelectForms;
        WFSteps[1] := cOptImages;
        WFSteps[2] := cEOReview;
        WFSteps[3] := cBuildX26GSE;
        WFSteps[4] := cPDSReview;
        WFSteps[5] := cBuildENV;
        WFSteps[6] := cBuildPDF;
        WFSteps[7] := cSaveXPak;
        WFSteps[8] := cAckSend;
      end
      else
        begin
          SetLength(WFSteps, 9);
          WFSteps[0] := cPackAMCDef;
          //WFSteps[1] := cSelectForms;
          WFSteps[1] := cOptImages;
          WFSteps[2] := cEOReview;
          WFSteps[3] := cBuildX26;
          WFSteps[4] := cBuildX241;
          WFSteps[5] := cBuildENV;
          WFSteps[6] := cBuildPDF;
          WFSteps[7] := cSaveXPak;
          WFSteps[8] := cAckSend;
        end;
    wfEMailFiles:
      begin
        SetLength(WFSteps, 11);
        WFSteps[0] := cPackAMCDef;
        //WFSteps[1] := cSelectForms;
        WFSteps[1] := cOptImages;
        WFSteps[2] := cEOReview;
        WFSteps[3] := cBuildX26GSE;
        WFSteps[4] := cBuildX26;
        WFSteps[5] := cBuildX241;
        WFSteps[6] := cBuildENV;
        WFSteps[7] := cBuildPDF;
        WFSteps[8] := cUploadXPak;
        WFSteps[9] := cSaveXPak;
        WFSteps[10] := cAckSend;
      end;
    wfRELS:
      begin
        SetLength(WFSteps, 10);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX241;
        WFSteps[5] := cBuildX26GSE;
        WFSteps[6] := cBuildX26;
        WFSteps[7] := cBuildPDF;
        WFSteps[8] := cUploadXPak;
        WFSteps[9] := cAckSend;
      end;
    wfValulink:
      begin
        SetLength(WFSteps, 9);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX241;
        WFSteps[5] := cBuildENV;
        WFSteps[6] := cBuildPDF;
        WFSteps[7] := cUploadXPak;
        WFSteps[8] := cAckSend;
      end;
    wfKylptix:
      begin
        SetLength(WFSteps, 9);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX241;
        WFSteps[5] := cBuildENV;
        WFSteps[6] := cBuildPDF;
        WFSteps[7] := cUploadXPak;
        WFSteps[8] := cAckSend;
      end;
    wfClearCapital:
      begin
        SetLength(WFSteps, 5);
        //WFSteps[0] := cSelectForms;
        WFSteps[0] := cOptImages;
        WFSteps[1] := cEOReview;
        WFSteps[2] := cBuildENV;
        WFSteps[3] := cSaveXPak;
        WFSteps[4] := cAckSend;
      end;
    wfStreetLinks:
      //if doc.UADEnabled then
      if isUadXML then
      begin
        SetLength(WFSteps, 11);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX26GSE;
        WFSteps[5] := cPDSReview;
        WFSteps[6] := cBuildENV;
        WFSteps[7] := cBuildPDF;
        WFSteps[8] := cUploadXPak;
        WFSteps[9] := cSaveXPak;
        WFSteps[10] := cAckSend;
      end
      else
        begin
        SetLength(WFSteps, 10);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX26;
        WFSteps[5] := cBuildENV;
        WFSteps[6] := cBuildPDF;
        WFSteps[7] := cUploadXPak;
        WFSteps[8] := cSaveXPak;
        WFSteps[9] := cAckSend;
      end;
    wfPCVMurcor:
      begin
        //put in this code here for testing, for release will always go to else statement.
        if TestVersion then
        begin
          SetLength(WFSteps, 4);
          //WFSteps[0] := cUserIdentity;
          WFSteps[0] := cPackAMCDef;
          //WFSteps[1] := cSelectForms;
          //WFSteps[3] := cOptImages;
          WFSteps[1] := cEOReview;
          WFSteps[2] := cBuildX241;
          //WFSteps[6] := cBuildENV;
          //WFSteps[7] := cBuildPDF;
          //WFSteps[4] := cUploadXPak;
          WFSteps[3] := cAckSend;
        end
        else
        begin
          SetLength(WFSteps, 9);
          WFSteps[0] := cUserIdentity;
          WFSteps[1] := cPackAMCDef;
          //WFSteps[2] := cSelectForms;
          WFSteps[2] := cOptImages;
          WFSteps[3] := cEOReview;
          WFSteps[4] := cBuildX241;
          WFSteps[5] := cBuildENV;
          WFSteps[6] := cBuildPDF;
          WFSteps[7] := cUploadXPak;
          WFSteps[8] := cAckSend;
        end;
      end;
    wfAppraisalPort: //Excludes cOptImages, cEOReview and inclue BuildX26, BuildPDF, SaveXPak
      begin
        //if doc.UADEnabled then   //this is UAD compliance
        if isUadXML then
        begin
          SetLength(WFSteps, 6);
          //WFSteps[0] := cSelectForms;
          WFSteps[0] := cOptImages;
          WFSteps[1] := cEOReview;
          WFSteps[2] := cBuildX26GSE;
          WFSteps[3] := cPDSReview;
          WFSteps[4] := cBuildENV;
          //WFSteps[3] := cBuildPDF;
          //WFSteps[4] := cSaveXPak;
          WFSteps[5] := cAckSend;
        end
        else  //this is NON UAD
        begin
          SetLength(WFSteps, 5);
          //WFSteps[0] := cSelectForms;
          WFSteps[0] := cOptImages;
          WFSteps[1] := cEOReview;
          WFSteps[2] := cBuildX26;
          WFSteps[3] := cBuildENV;
          //WFSteps[3] := cBuildPDF;
          //WFSteps[4] := cSaveXPak;
          WFSteps[4] := cAckSend;
        end;
      end;
    wfVeptas:
      if isUADXML then
        begin
          SetLength(WFSteps, 5);
          WFSteps[0] := cOptImages;
          WFSteps[1] := cBuildX26GSE;
          WFSteps[2] := cBuildPDF;
          WFSteps[3] := cSaveXPak;
          WFSteps[4] := cAckSend;
        end
      else
        begin
          SetLength(WFSteps, 5);
          WFSteps[0] := cOptImages;
          WFSteps[1] := cBuildX26;
          WFSteps[2] := cBuildPDF;
          WFSteps[3] := cSaveXPak;
          WFSteps[4] := cAckSend;
        end;
    wfCoreLogic:
      begin
        SetLength(WFSteps, 10);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX26GSE;
        WFSteps[5] := cBuildX26;
        WFSteps[6] := cBuildENV;
        WFSteps[7] := cBuildPDF;
        WFSteps[8] := cUploadXPak;
        WFSteps[9] := cAckSend;
      end;
    wfISGN:
      //if doc.UADEnabled then
      if isUadXML then
      begin
        SetLength(WFSteps, 11);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX26GSE;
        WFSteps[5] := cPDSReview;
        WFSteps[6] := cBuildENV;
        WFSteps[7] := cBuildPDF;
        WFSteps[8] := cUploadXPak;
        WFSteps[9] := cSaveXPak;
        WFSteps[10] := cAckSend;
      end
      else
      begin
        SetLength(WFSteps, 11);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX26GSE;
        WFSteps[5] := cBuildX26;
        WFSteps[6] := cBuildENV;
        WFSteps[7] := cBuildPDF;
        WFSteps[8] := cUploadXPak;
        WFSteps[9] := cSaveXPak;
        WFSteps[10] := cAckSend;
      end;
    wfTitleSource:
      //if doc.UADEnabled then
      if isUadXML then
      begin
        SetLength(WFSteps, 9);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX26GSE;
        WFSteps[5] := cPDSReview;
        WFSteps[6] := cBuildPDF;
        WFSteps[7] := cUploadXPak;
        WFSteps[8] := cAckSend;
      end
      else
      begin
        SetLength(WFSteps, 8);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX26;
        WFSteps[5] := cBuildPDF;
        WFSteps[6] := cUploadXPak;
        WFSteps[7] := cAckSend;
      end;
    wfLandmark:
      //if doc.UADEnabled then
      if isUadXML then
      begin
        SetLength(WFSteps, 9);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX26GSE;
        WFSteps[5] := cPDSReview;
        WFSteps[6] := cBuildPDF;
        WFSteps[7] := cUploadXPak;
        WFSteps[8] := cAckSend;
      end
      else
      begin
        SetLength(WFSteps, 8);
        WFSteps[0] := cUserIdentity;
        WFSteps[1] := cPackAMCDef;
        //WFSteps[2] := cSelectForms;
        WFSteps[2] := cOptImages;
        WFSteps[3] := cEOReview;
        WFSteps[4] := cBuildX26;
        WFSteps[5] := cBuildPDF;
        WFSteps[6] := cUploadXPak;
        WFSteps[7] := cAckSend;
      end;
    wfEadPortal:
      begin
        //if doc.UADEnabled then
        if isUadXML then
        begin
          SetLength(WFSteps, 8);
          //WFSteps[0] := cSelectForms;
          WFSteps[0] := cOptImages;
          WFSteps[1] := cEOReview;
          WFSteps[2] := cBuildX26GSE;
          WFSteps[3] := cPDSReview;
          WFSteps[4] := cBuildPDF;
          WFSteps[5] := cDigitallySign;
          WFSteps[6] := cSaveXPak;
          WFSteps[7] := cAckSend;
        end
        else   //Ticket #1229
          begin
            SetLength(WFSteps, 7);
            //WFSteps[0] := cSelectForms;
            WFSteps[0] := cOptImages;
            WFSteps[1] := cEOReview;
            WFSteps[2] := cBuildX26;
            WFSteps[3] := cBuildPDF;
            WFSteps[4] := cDigitallySign;;
            WFSteps[5] := cSaveXPak;
            WFSteps[6] := cAckSend;
          end;
      end;
    wfMercuryNetwork:  //Ticket #1202
      begin
        if Doc.FAMCOrderInfo.RequireXML then
          begin
            SetLength(WFSteps, 11);
            WFSteps[0]  := cUserIdentity;
            WFSteps[1]  := cPackAMCDef;
            //WFSteps[2]  := cSelectForms;
            WFSteps[2]  := cOptImages;
            WFSteps[3]  := cEOReview;
            WFSteps[4]  := cBuildX26GSE;
            WFSteps[5]  := cPDSReview;
            WFSteps[6]  := cBuildENV;
            WFSteps[7]  := cBuildPDF;
            WFSteps[8]  := cSaveXPak;
            WFSteps[9]  := cUploadXPak;
            WFSteps[10] := cAckSend;
          end
        else
          begin
            SetLength(WFSteps, 10);
            WFSteps[0]  := cUserIdentity;
            WFSteps[1]  := cPackAMCDef;
            //WFSteps[2]  := cSelectForms;
            WFSteps[2]  := cOptImages;
            WFSteps[3]  := cEOReview;
            WFSteps[4]  := cBuildX26GSE;
            WFSteps[5]  := cPDSReview;
            WFSteps[6]  := cBuildENV;
            WFSteps[7]  := cBuildPDF;
            //WFSteps[9]  := cSaveXPak;
            WFSteps[8]  := cUploadXPak;
            WFSteps[9] := cAckSend;
          end;
      end
  end;

  result := WFSteps;
end;

procedure TAMCProcessMgr.DisplayCurProcess;
begin
  if assigned(FCurProcess) then
    FDisplayMgr.ActivePage := FCurProcess.FDisplay;
end;

//Note: CurProcess.DoProcessData; is called when attempting to move to determine
// which is the next station that requires processing. When we get to here,
// we alerady know which step is next and we just need to decide if we can switch or not.

//YF 01/17/2019  Moved DoProcessData and ProcessCompleted into MoveToNextProcess:
//We need results  of user interaction with UAMC_Select frame to get Workflow ID and build Workflow.
//In existing code AMCSelect was the first step  and loaded from InitStartUpProcess without clicking Next.
//Now it he 2nd step after select form. We need to know selected forms to define report type andbuild Workflow.
procedure TAMCProcessMgr.Switch2NewProcess(NewProcess: TAMCProcessStep; MovingForward: Boolean);
//var
// ok2Switch: Boolean;
begin
  {ok2Switch := True;
  if assigned(FCurProcess) and MovingForward then  //make sure we complete the process
    begin
      //CurProcess.DoProcessData;                    //do whatever its does with new data
      ok2Switch := CurProcess.ProcessCompleted;    //was process completed ok?
      if not ok2Switch then   }
          (*
        begin
          //github #109: allow user to get past the process if it's stepid = 5 (EOReview)
          case CurProcess.StepID of
            cEOReview:  //EOReview
            begin
              if length(PackageData.FAlertMsg) > 0 then  //make sure we have msg
                if PackageData.FHardStop then
                  begin
                    ok2Switch := not OK2Continue(PackageData.FAlertMsg);
                    if ok2Switch then  //pop up are you sure dialog before let user continue
                       ok2Switch := OK2Continue('Are you sure you would like to bypass the critical errors?');
                  end
                else
                  ok2Switch := OK2Continue(PackageData.FAlertMsg);
            end;
            cBuildX26GSE: //UAD Review
            begin
              if length(PackageData.FAlertMsg) > 0 then  //make sure we have msg
                if PackageData.FHardStop then
                  begin
                    ok2Switch := not OK2Continue(PackageData.FAlertMsg);
                    if ok2Switch then  //pop up are you sure dialog before let user continue
                       ok2Switch := OK2Continue('If UAD critical errors are bypassed, XML file will not be created. However, PDF file can be created. Are you sure you would like to continue?');
                  end
                else
                  ok2Switch := OK2Continue(PackageData.FAlertMsg);
            end;
            *)
        //   else
          //github 109 - revert back to not allowing user to bypass critical errors
            //CurProcess.AlertUser;
        //  end;
     //  end;
    //end;

  if assigned(NewProcess) then
    begin
      MakeProcessCurrent(NewProcess);
      NewProcess.InitData;
      SetProcessTitle(NewProcess.Name);
      FDisplayMgr.ActivePage := NewProcess.FDisplay;
      FDisplayMgr.ActivePage.Show;
      Application.ProcessMessages;      //give it a chance to display
      if MovingForward then
        NewProcess.AutoStartProcess;    //autoStart if next step allows it
    end;
end;

function TAMCProcessMgr.SkipToNextValidStep: TAMCProcessStep;
var
  nextIndex: Integer;
  nextStep: TAMCProcessStep;
  skipIt: Boolean;
begin
  nextStep := nil;                 //start here
  nextIndex := FCurIndex + 1;      //next index
  if nextIndex < Count then        //don't go over
    repeat
      nextStep := TAMCProcessStep(Items[nextIndex]);
      skipIt := False;

      if nextStep.StepID = cStep4_OptImgs then
        skipIt := not PackageData.HasImages or (FDoc.ImagesToOptimize(PreferableOptDPI, PackageData.FFormList) = 0) //github 205

      else if nextStep.StepID = cStep6_BuildX241 then
        skipIt := not PackageData.DataFiles.NeedsDataFile(fTypXML241)

      else if nextStep.StepID = cStep7_BuildX26GSE then
        skipIt := not PackageData.DataFiles.NeedsDataFile(fTypXML26GSE)

      else if nextStep.StepID = cStep8_BuildX26 then
        skipIt := not PackageData.DataFiles.NeedsDataFile(fTypXML26)

      else if nextStep.StepID = cStep9_PDSReview then
        skipIt := not PackageData.DataFiles.NeedsDataFile(fTypXML26GSE)

      else if nextStep.StepID = cStep10_BuildENV then
        skipIt := not PackageData.DataFiles.NeedsDataFile(fTypENV)

      else if nextStep.StepID = cStep11_BuildPDF then
        skipIt := not PackageData.DataFiles.NeedsDataFile(fTypPDF)

      else if nextStep.StepID = cStep12_DigitallySign then
        skipIt := not (PackageData.DataFiles.NeedsDataFile(fTypXML26GSE) or PackageData.DataFiles.NeedsDataFile(fTypXML26));

      nextIndex := nextIndex + 1;
    until not skipIt or (nextIndex = Count);

  result := nextStep;
end;

function TAMCProcessMgr.SkipToPrevValidStep: TAMCProcessStep;
var
  prevIndex: Integer;
  prevStep: TAMCProcessStep;
  skipIt: Boolean;
begin
  prevStep := nil;                //start here
  prevIndex := FCurIndex - 1;     //prev index
  if prevIndex > -1 then          //don't go past zero
    repeat
      if prevIndex <> -1 then  //PAM: Ticket #1328 = avoid list index out of bound
        prevStep := TAMCProcessStep(Items[prevIndex]);
      skipIt := False;

      if prevStep.StepID = cStep4_OptImgs then
        skipIt := not PackageData.HasImages

      else if prevStep.StepID = cStep6_BuildX241 then
        skipIt := not PackageData.DataFiles.NeedsDataFile(fTypXML241)

      else if prevStep.StepID = cStep7_BuildX26GSE then
        skipIt := not PackageData.DataFiles.NeedsDataFile(fTypXML26GSE)

      else if prevStep.StepID = cStep8_BuildX26 then
        skipIt := not PackageData.DataFiles.NeedsDataFile(fTypXML26)

      else if prevStep.StepID = cStep10_BuildENV then
        skipIt := not PackageData.DataFiles.NeedsDataFile(fTypENV)

      else if prevStep.StepID = cStep11_BuildPDF then
        skipIt := not PackageData.DataFiles.NeedsDataFile(fTypPDF);

      prevIndex := prevIndex - 1;
    until not skipIt or (prevIndex < 0);

  result := prevStep;
end;

procedure TAMCProcessMgr.MoveToNextProcess;
var
  NextProcess: TAMCProcessStep;
  ok2Switch: Boolean;
begin
  if assigned(FCurProcess) then  //make sure we complete the process
    begin
      CurProcess.DoProcessData;                    //do whatever its does with new data
      ok2Switch := CurProcess.ProcessCompleted;
    end;
  if not ok2switch then
    CurProcess.AlertUser
  else
    begin
      if (CurProcess is TAMCProcess_Selection) then
        BuildWorkFlow;
    if PackageData.FixedWorkflow then
      NextProcess := NextStep
    else
      NextProcess := SkipToNextValidStep;
    Switch2NewProcess(NextProcess, True);
  end;
end;

procedure TAMCProcessMgr.MoveToPrevProcess;
var
  prevProcess: TAMCProcessStep;
begin
  if PackageData.FixedWorkflow then
    prevProcess := PrevStep
  else
    prevProcess := SkipToPrevValidStep;
  if prevProcess is TAMCProcess_Selection then
    ClearWorkFlow;        
  Switch2NewProcess(prevProcess, False);
end;

function TAMCProcessMgr.GetCurStep: TAMCProcessStep;
begin
  if FCurIndex <> -1 then   //PAM: Ticket #1328 = avoid list index out of bound, check first
    result := TAMCProcessStep(Items[FCurIndex]);
end;

function TAMCProcessMgr.GetLastStep: TAMCProcessStep;
begin
  result := TAMCProcessStep(Last);
end;

//Note: This does not set the Next Step as the current step, just gets it
function TAMCProcessMgr.GetNextStep: TAMCProcessStep;
var
  nextIndex: Integer;
begin
  nextIndex := InRange(0, Count-1, FCurIndex + 1);
//  if nextIndex > FCurIndex then
  if (nextIndex > FCurIndex) and (nextIndex <> -1) then //PAM: Ticket #1328 = avoid list index out of bound
    result := TAMCProcessStep(Items[nextIndex])
  else
    result := nil;
end;

//Note: This does not set the Prev Step as the current step, just gets it
function TAMCProcessMgr.GetPrevStep: TAMCProcessStep;
var
  prevIndex: Integer;
begin
  prevIndex := InRange(0, Count-1, FCurIndex - 1);
//  if prevIndex < FCurIndex then
  if (prevIndex < FCurIndex) and (prevIndex <> -1) then  //PAM: Ticket #1328 = avoid list index out of bound
    result := TAMCProcessStep(Items[prevIndex])
  else
    result := nil;
end;

procedure TAMCProcessMgr.MakeProcessCurrent(Value: TAMCProcessStep);
begin
  FCurIndex := IndexOf(Value);
  if FCurIndex <> -1 then  //PAM: Ticket #1328 = to avoid list index out of bound error
    FCurProcess := TAMCProcessStep(Items[FCurIndex]);
end;

function TAMCProcessMgr.CurProcessIsFirst: Boolean;
begin
  result := (FCurIndex = 0);
end;


function TAMCProcessMgr.GetMaxSteps: Integer;
begin
  result := count;
end;

{ TAMCProcessStep }

constructor TAMCProcessStep.CreateProcess(AOwner: TAMCProcessMgr; ADoc: TContainer; ADisplay: TTabSheet; AData: TDataPackage);
begin
  inherited Create;

  FProcessMgr := AOwner;      //REF WorkFlowMgr
  FDoc := ADoc;               //REF to report
  FDisplay := ADisplay;       //REF to the TabSheet
  FData := AData;             //REF to the common PackageData that each process works on

  LoadProcessFrame(FDisplay, AData.FWorkFlowUID);    //Load Frame associated with selected workflow
end;

procedure TAMCProcessStep.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
//each individual TProcessStep will override this routine
end;

procedure TAMCProcessStep.InitData;
begin
  FUserDisplay.InitPackageData;    //each UserDisplay (TFrame) inits their part of TDataPackage

  FData.FModified := False;        //At eact step, we reset the modified flag
end;

procedure TAMCProcessStep.AutoStartProcess;
begin
  FUserDisplay.StartProcess;     //each UserDiaplay (TFrame) calls their own auto start process
end;

procedure TAMCProcessStep.DoProcessData;
begin
  FUserDisplay.DoProcessData;
end;

function TAMCProcessStep.ProcessedOK: Boolean;
begin
  result := FUserDisplay.ProcessedOK;
//  result := PackageData.FGoToNextOk;  //The data in package thinks its ok (or not)
end;

function TAMCProcessStep.ProcessCompleted: Boolean;
begin
  result := ProcessedOK;

//  if not result then
//    ShowAlert(atWarnAlert, 'There was a problem with the step in the delivery process');
end;

procedure TAMCProcessStep.AlertUser;
begin
  if length(PackageData.FAlertMsg) > 0 then  //make sure we have msg
    if PackageData.FHardStop then
      ShowAlert(atStopAlert, PackageData.FAlertMsg)
    else
      ShowAlert(atWarnAlert, PackageData.FAlertMsg);
end;

function TAMCProcessStep.GetProcessTitle: String;
begin
  Result := FName;
end;

{-------------------------------------------------}
{ The Individual Process TFrames are created here }
{-------------------------------------------------}

{ TAMCProcess_Selection }

procedure TAMCProcess_Selection.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_Selection.CreateFrame(DisplayPg, FDoc, FData);       {Step_SelectAMC}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Select Delivery Method and Recipient';
  StepID := cStep0_SelectAMC;
end;

{ TAMCProcess_UserID }

procedure TAMCProcess_UserID.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  case AWorkflowID of
    wfRELS:         begin end;
    wfStreetLinks:  FUserDisplay := TAMC_UserID_StreetLinks.CreateFrame(DisplayPg, FDoc, FData);      {Step_UserID}
    wfValulink:     begin end;
    wfPCVMurcor:    begin end;
    wfISGN:         FUserDisplay := TAMC_UserID_ISGN.CreateFrame(DisplayPg, FDoc, FData);             {Step_UserID}
    wfTitleSource:  FUserDisplay := TAMC_UserID_TitleSource.CreateFrame(DisplayPg, FDoc, FData);      {Step_UserID}
    wfLandMark:     FUserDisplay := TAMC_UserID_Landmark.CreateFrame(DisplayPg, FDoc, FData);      {Step_UserID}
    wfMercuryNetwork: FUserDisplay := TAMC_UserID_MercuryNetwork.CreateFrame(DisplayPg, FDoc, FData);      {Step_UserID}
  else
    FUserDisplay := TAMC_UserID.CreateFrame(DisplayPg, FDoc, FData);      {Step_UserID}
  end;
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.ParentBackground := False;
  FUserDisplay.ParentFont := True;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'User and Order Verification';
  StepID := cStep1_UserID;
end;


{ TAMCPorcess_DefPackage  }

//called by Workflow Mgr when creating process step
procedure TAMCPorcess_DefPackage.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_PackageDef.CreateFrame(DisplayPg, FDoc, FData);    {Step_PakSpec}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Specify the Appraisal "Package" contents';
  StepID := cStep2_PackDef;
end;

{ TAMCProcess_ReportContent }

procedure TAMCProcess_ReportContent.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_SelectForms.CreateFrame(DisplayPg, FDoc, FData);     {Step_SelectForms}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Select the forms to be included in the Appraisal Report';
  StepID := cStep3_SelectPgs;
end;

{ TAMCProcess_ImageOptize }

procedure TAMCProcess_ImageOptize.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_OptImages.CreateFrame(DisplayPg, FDoc, FData);  {Step_OptImages}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Optimize Images to Reduce Size in Memory';
  StepID := cStep4_OptImgs;
end;

{ TAMCProcess_EOReview  }

procedure TAMCProcess_EOReview.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_EOReview.CreateFrame(DisplayPg, FDoc, FData);         {Step_EOReview}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Errors and Omissions Review';
  FName := Format('%s%s%s',[FName,SPACE,HINT]);
  StepID := cStep5_EOReview;
end;

{ TAMCProcess_BuildX241 }

procedure TAMCProcess_BuildX241.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_BuildX241.CreateFrame(DisplayPg, FDoc, FData);      {Step_BuildXML241}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Create MISMO 241 XML File';
  FName := Format('%s%s%s',[FName,SPACE,HINT]);
  StepID := cStep6_BuildX241;
end;

{ TAMCProcess_BuildX26GSE  }

procedure TAMCProcess_BuildX26GSE.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);      //generate the XML 26 GSE
begin
  FUserDisplay := TAMC_BuildX26GSE.CreateFrame(DisplayPg, FDoc, FData);      {Step_BuildXML26GSE}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Create MISMO GSE 26 XML File';
  FName := Format('%s%s%s',[FName,SPACE,HINT]);
  StepID := cStep7_BuildX26GSE;
end;

{ TAMCProcess_BuildX26  }

procedure TAMCProcess_BuildX26.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);      //generate the XML 26
begin
  FUserDisplay := TAMC_BuildX26.CreateFrame(DisplayPg, FDoc, FData);      {Step_BuildXML26}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Create MISMO 26 XML File';
  FName := Format('%s%s%s',[FName,SPACE,HINT]);
  StepID := cStep8_BuildX26;
end;

{ TAMCProcess_BuildENV  }

procedure TAMCProcess_BuildENV.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_BuildENV.CreateFrame(DisplayPg, FDoc, FData);      {Step_BuildENV}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Create ENV file of Appraisal Report';
  StepID := cStep10_BuildENV;
end;

{ TAMCProcess_BuildPDF }

procedure TAMCProcess_BuildPDF.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_BuildPDF.CreateFrame(DisplayPg, FDoc, FData);  {Step_BuildPDF}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Create PDF file of Appraisal Report';
  StepID := cStep11_BuildPDF;
end;

{ TAMCProcess_SendPak  }

procedure TAMCProcess_SendPak.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  case AWorkflowID of
    wfRELS:         begin end;
    wfStreetLinks:  FUserDisplay := TAMC_SendPak_StreetLinks.CreateFrame(DisplayPg, FDoc, FData);
    wfISGN:         FUserDisplay := TAMC_SendPak_ISGN.CreateFrame(DisplayPg, FDoc, FData);
    wfValulink:     begin end;
    wfPCVMurcor:    begin end;
    wfTitleSource:  FUserDisplay := TAMC_SendPak_TitleSource.CreateFrame(DisplayPg, FDoc, FData);
    wfLandmark:     FUserDisplay := TAMC_SendPak_Landmark.CreateFrame(DisplayPg, FDoc, FData);
    wfMercuryNetwork: FUserDisplay := TAMC_SendPak_MercuryNetWork.CreateFrame(DisplayPg, FDoc, FData); //Ticket #1202
  else
    FUserDisplay := TAMC_SendPak.CreateFrame(DisplayPg, FDoc, FData);   {generic Step_SendPak}
  end;

  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  case AWorkflowID of
    wfSaveFiles:  FName := 'Appraisal Package ready for Saving';      //### - don't need these
    wfEMailFiles: FName := 'Appraisal Package ready for Emailing';
  else
    FName := 'Appraisal Package ready for Uploading';
  end;
  StepID := cStep13_SendPak;
end;

{ TAMCProcess_SavePak }

function TAMCProcess_SavePak.GetProcessTitle: String;
begin
  if PackageData.FWorkflowUID <> wfSaveFiles then
    result := FName + ' for your records.'        //default FName = 'Save Appraisal Files'
  else
    result := FName;
end;

procedure TAMCProcess_SavePak.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_SavePak.CreateFrame(DisplayPg, FDoc, FData);  {Step_SavePak}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Save the Appraisal Files';
  StepID := cStep14_SavePak;
end;


{ TAMCProcess_AckSend  }

procedure TAMCProcess_AckSend.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_AckSend.CreateFrame(DisplayPg, FDoc, FData);  {Step_AckSend}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Processing Complete';
  StepID := cStep15_AckSend;
end;

procedure TAMCProcess_PDSReview.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_PDSReview.CreateFrame(DisplayPg, FDoc, FData);         {Step_PDSReview}
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Platinum Data Solutions Review';
  //FName := Format('%s%s%s',[FName,SPACE,HINT]);
  StepID := cStep9_PDSReview;
end;

procedure TAMCProcess_DigitalSignature.LoadProcessFrame(DisplayPg: TTabSheet; AWorkflowID: Integer);
begin
  FUserDisplay := TAMC_DigitalSignature.CreateFrame(DisplayPg, FDoc, FData);
  FUserDisplay.Parent := DisplayPg;
  FUserDisplay.parentBackground := False;
  FUserDisplay.Brush.Color := clBtnFace;
  FUserDisplay.Align := AlClient;

  FName := 'Digitally Sign MISMO XML';
  StepID := cStep12_DigitallySign;
end;

end.
