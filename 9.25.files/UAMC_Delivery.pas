unit UAMC_Delivery;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  UlicUtility, UGlobals, UForms, UAMC_Globals, UAMC_Workflow, UContainer;

type
  TAMCDeliveryProcess = class(TAdvancedForm)
    btnNext: TButton;
    btnCancel: TButton;
    StatusBar1: TStatusBar;
    PgCntl: TPageControl;
    Step_SelectAMC: TTabSheet;
    Step_UserID: TTabSheet;
    Step_PakSpec: TTabSheet;
    Step_SelectForms: TTabSheet;
    Step_OptImages: TTabSheet;
    Step_EOReview: TTabSheet;
    Step_BuildX241: TTabSheet;
    Step_BuildPDF: TTabSheet;
    Step_SendPak: TTabSheet;
    Step_AckSend: TTabSheet;
    lblProcessName: TLabel;
    btnPrev: TButton;
    Panel1: TPanel;
    Step_BuildENV: TTabSheet;
    ResizeAnimationTimer: TTimer;
    Step_BuildX26: TTabSheet;
    Step_BuildX26GSE: TTabSheet;
    Step_SavePak: TTabSheet;
    Step_PDSReview: TTabSheet;
    Step_DigitallySign: TTabSheet;
    procedure MoveToNextProcess(Sender: TObject);
    procedure MoveToPrevProcess(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ResizeAnimationTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
  private
    FDoc: TContainer;
    FProcessMgr: TAMCProcessMgr;
    FCollapsedSize: TSize;        //size of the form when collapsed
    FExpandedSize: TSize;         //size of the form when expanded
    FTargetSize: TSize;           //size of the form once the resize animation has finished
    FIsExpanded: Boolean;         //is the window in the expanded state
    FResizeAnimationTimeFrame: TDateTime; //time of the last resize animation frame
    procedure CheckUADConsistency;

  public
    constructor Create(AOwner: TComponent; menuItemID: Integer);// override;
    destructor Destroy; override;
    procedure SetButtonState(StepIndex: Integer);
    procedure InitWorkFlow;
    procedure SaveWindowPlacement;   override;
    procedure RestoreWindowPlacement; override;
    procedure ToggleWindowSize;
    property ProcessMgr: TAMCProcessMgr read FProcessMgr write FProcessMgr;
  end;

  //main call to start delivery process
  procedure DeliverAppraisal(doc: TContainer; menuItemID: Integer = cmdExportWorkflow);

var
  AMCDeliveryProcess: TAMCDeliveryProcess;

implementation

{$R *.dfm}

uses
  Math,
  UWindowsInfo, UUtil1, UStatus, uUADConsistency, UMain;


procedure DeliverAppraisal(doc: TContainer; menuItemID: Integer = cmdExportWorkflow);
begin
  if IsClickFORMSVersionOK2(True) then
    begin
      if Assigned(AMCDeliveryProcess) then    //if previous version
        AMCDeliveryProcess.Show              //bring it to the front

      else begin
        AMCDeliveryProcess := TAMCDeliveryProcess.Create(doc, menuItemID);
        try
          AMCDeliveryProcess.Show;
        except
          on E: Exception do
            begin
              ShowAlert(atWarnAlert, errProblem + E.message);
              FreeAndNil(AMCDeliveryProcess);
            end;
        end;
      end;
    end;
end;


{ TAMCDeliveryProcess }

constructor TAMCDeliveryProcess.Create(AOwner: TComponent; menuItemID: Integer);
const
  IsVisible = False;
begin
  inherited Create(nil);

  SettingsName := CFormSettings_AMCDelivery;   //remember our location

  FDoc := TContainer(AOwner);

  //show or hide the tabs - on Release, isVisible = FALSE
  //show tabs just for debugging
  Step_SelectAMC.TabVisible   := isVisible;
  Step_UserID.TabVisible      := isVisible;
  Step_PakSpec.TabVisible     := isVisible;
  Step_SelectForms.TabVisible := isVisible;
  Step_OptImages.TabVisible   := isVisible;
  Step_EOReview.TabVisible    := isVisible;
  Step_BuildX241.TabVisible   := isVisible;
  Step_BuildX26.TabVisible    := isVisible;
  Step_BuildX26GSE.TabVisible := isVisible;
  Step_PDSReview.TabVisible   := isVisible;
  Step_BuildENV.TabVisible    := isVisible;
  Step_BuildPDF.TabVisible    := isVisible;
  Step_DigitallySign.TabVisible := isVisible;
  Step_SendPak.TabVisible     := isVisible;
  Step_SavePak.TabVisible     := isVisible;
  Step_AckSend.TabVisible     := isVisible;

  FProcessMgr := TAMCProcessMgr.Create(True, FDoc, PgCntl);
  case menuItemID of
    cmdExportAIReady:
      begin
        ProcessMgr.PackageData.AMCIdentifier := AMC_FNC;
        ProcessMgr.PackageData.DeliveryType := adUploadPack;
      end;
    cmdMercuryUpload:  //Ticket #1202
      begin
        ProcessMgr.PackageData.AMCIdentifier := AMC_MercuryNetWork;
        ProcessMgr.PackageData.DeliveryType  := adUploadPack;
      end;
    cmdExportEAD:
      begin
        ProcessMgr.PackageData.AMCIdentifier := AMC_EadPortal;
        ProcessMgr.PackageData.DeliveryType := adUploadPack;
      end;
  end;

  InitWorkFlow;                                  //setup first step

  btnCancel.Left := Panel1.Width - btnCancel.Width - 18;
  btnNext.Left := btnCancel.Left - btnNext.Width - 21;
  btnPrev.Left := btnNext.Left - btnPrev.Width - 21;
  btnPrev.Enabled := False;
//** Make Previous button visible
//  btnPrev.Visible := False;
end;

destructor TAMCDeliveryProcess.Destroy;
begin
  AMCDeliveryProcess := nil;

  inherited;
end;

procedure TAMCDeliveryProcess.CheckUADConsistency;
var
  uCon:TUADConsistency;
begin
  uCon := TUADConsistency.Create(nil);
  try
    uCon.doc := TContainer(main.ActiveContainer);
    uCon.ShowModal;
  finally
    uCon.Free;
//    refreshCompList(-1);
  end;
end;


procedure TAMCDeliveryProcess.InitWorkFlow;
var
  ok: Boolean;
  aMsg: String;
begin
  ProcessMgr.InitStartUpProcess;

  lblProcessName.Caption := ProcessMgr.CurProcess.Name;
  if appPref_AMCDelivery_UADConsistency then
    begin
      aMsg := 'Do you want to check if the comparables in your report are consistent with the comparables in your Comps Database?';
      Ok := OK2Continue(aMsg);
      if Ok then
        CheckUADConsistency;
    end;

end;

//user has pressed the Next button
procedure TAMCDeliveryProcess.MoveToNextProcess(Sender: TObject);
begin
  //01/15/19 Yakov
  //TAMCProcess.Selection.DoProcesssData now called Directly;
  //Moved BuildWorkflow to ProcessMgr.SwitchToNextProcess
  //ClearWorkFlow never calledd any way, Before BuildWorkfow ProcessMGR.count = 1
  //So no needs for special handling TAMCProcess_Selection

 { //before we attempt to move, process any PackageData items
  //processing may set skipping options, workflow options, etc
  //ProcessMgr.CurProcess.DoProcessData; --moved to ProcessMgr.MoveToNextProcess;

  //Special Case: need to build workflow on first Next click
  //we could do this in ProcessData in first Step, decided to do it here
  //Are we at first step and have the selections changed?
  if ProcessMgr.CurProcessIsFirst then
    begin
      PushMouseCursor(crHourGlass);
      try
        //was there a change in workflow selection - changed AMC or delivery options?
        ProcessMgr.CurProcess.DoProcessData;
        if ProcessMgr.PackageData.FHardStop then
          exit;  //Ticket #1245: if hard stop, stop the process
        If (ProcessMgr.count > 1) and ProcessMgr.PackageData.Modified then
          ProcessMgr.ClearWorkFlow;
        //do we need to build (or rebuild) the workflow
        if (ProcessMgr.count = 1) then
          ProcessMgr.BuildWorkFlow;     //build workflow & set prefs
      finally
        PopMouseCursor;
      end;
    end;     }

  ProcessMgr.MoveToNextProcess;

  SetButtonState(ProcessMgr.CurIndex);
end;

//user has pressed the Prev button
procedure TAMCDeliveryProcess.MoveToPrevProcess(Sender: TObject);
begin
  ProcessMgr.MoveToPrevProcess;

  lblProcessName.Caption := ProcessMgr.CurProcess.Name;
  SetButtonState(ProcessMgr.CurIndex);
end;

procedure TAMCDeliveryProcess.SetButtonState(StepIndex: Integer);
var
 MaxIndex: Integer;
begin

  MaxIndex := ProcessMgr.MaxSteps - 1;    //max steps are in the workflow (zero based)

  if StepIndex = 0 then       //at the beginning

    begin
      btnNext.caption := 'Next';
      btnNext.enabled := True;
      btnPrev.enabled := False;
    end
 else if StepIndex = MaxIndex then       //just need to close
    begin
      btnCancel.caption := 'Close';
//** This is the last step and we allow user to go back to previous as will
//      btnPrev.Visible := False;
//      btnNext.Visible := False;
      btnPrev.Enabled := True;
      if ProcessMgr.CurProcess is TAMCProcess_Selection then
        btnNext.Enabled := true   // we are going to build workflow and encrease Process Mgr process's list
      else   
        btnNext.Enabled := False;
    end
  else                                    //somewhere in the middle
    begin
      btnNext.caption := 'Next';
      btnNext.enabled := True;
      btnPrev.enabled := True;
    end;
end;

procedure TAMCDeliveryProcess.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TAMCDeliveryProcess.btnCancelClick(Sender: TObject);
var
  lastProcess: TAMCProcessStep;
begin
  //do cleanup - call ProcessData of the last step
  //for now it deletes the tmp PDF file
  lastProcess := ProcessMgr.LastStep;
  if lastProcess.ClassNameIs('TAMCProcess_AckSend') then
    lastProcess.DoProcessData;

  Close;
end;


{----------------------------------------------------}
{  routines for resizing the window                  }
{----------------------------------------------------}

procedure TAMCDeliveryProcess.FormResize(Sender: TObject);
begin
  if not FIsExpanded and not ResizeAnimationTimer.Enabled then
    begin
      FExpandedSize.cx := ClientWidth;
      FExpandedSize.cy := ClientHeight;
    end;
end;

// summary: Expands the form prior to saving the window placement.
procedure TAMCDeliveryProcess.SaveWindowPlacement;
begin
  ClientWidth := FExpandedSize.cx;
  ClientHeight := FExpandedSize.cy;

  inherited;
end;

/// summary: Configures the expanded and collapsed sizes of the form
///          after the saved window placement has been restored.
procedure TAMCDeliveryProcess.RestoreWindowPlacement;
const
  CCollapsedHeight = 122;
begin
  inherited;

  FExpandedSize.cx := ClientWidth;
  FExpandedSize.cy := ClientHeight;
  FCollapsedSize.cx := FExpandedSize.cx;
  FCollapsedSize.cy := CCollapsedHeight;
  FTargetSize := FExpandedSize;
end;

procedure TAMCDeliveryProcess.ToggleWindowSize;
begin
  if (FIsExpanded = false) then
    begin
//      btnToggleTest.Caption := 'Expand';
      FTargetSize := FCollapsedSize;
      FResizeAnimationTimeFrame := Now;
      ResizeAnimationTimer.Enabled := True;
      FIsExpanded := True;
    end
  else
    begin
//      btnToggleTest.Caption := 'Collapse';
      FTargetSize := FExpandedSize;
      FResizeAnimationTimeFrame := Now;
      ResizeAnimationTimer.Enabled := True;
      FIsExpanded := False;
    end;
end;

procedure TAMCDeliveryProcess.ResizeAnimationTimerTimer(Sender: TObject);
const
  CMillisecondsPerFrame = 50;
  CSizeAdjustmentPerFrame = 10;
var
  CurrentSize: TSize;
  FramesTranspired: Integer;
  MillisecondsPerFrame: TDateTime;
  NewSize: TSize;
  SizeAdjustment: Integer;
  TimeDelta: TDateTime;
begin
  CurrentSize.cx := ClientWidth;
  CurrentSize.cy := ClientHeight;
  MillisecondsPerFrame := EncodeTime(0, 0, 0, CMillisecondsPerFrame);

  TimeDelta := Now - FResizeAnimationTimeFrame;
  FramesTranspired := Trunc(TimeDelta / MillisecondsPerFrame);
  SizeAdjustment := CSizeAdjustmentPerFrame * FramesTranspired;

  if (CurrentSize.cx > FTargetSize.cx) then
    NewSize.cx := Max(CurrentSize.cx - SizeAdjustment, FTargetSize.cx)
  else if (CurrentSize.cx < FTargetSize.cx) then
    NewSize.cx := Min(CurrentSize.cx + SizeAdjustment, FTargetSize.cx)
  else
    NewSize.cx := FTargetSize.cx;

  if (CurrentSize.cy > FTargetSize.cy) then
    NewSize.cy := Max(CurrentSize.cy - SizeAdjustment, FTargetSize.cy)
  else if (CurrentSize.cy < FTargetSize.cy) then
    NewSize.cy := Min(CurrentSize.cy + SizeAdjustment, FTargetSize.cy)
  else
    NewSize.cy := FTargetSize.cy;

  ResizeAnimationTimer.Enabled := (NewSize.cx <> FTargetSize.cx) or (NewSize.cy <> FTargetSize.cy);

  ClientWidth := NewSize.cx;
  ClientHeight := NewSize.cy;
end;

end.
