unit UProcessingForm;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  ActnList,
  Classes,
  Controls,
  ControlWorkingIndicator,
  StdCtrls,
  UForms,
  UTaskThread;

type
  { an event procedure occuring when task processing is finished }
  TTaskTerminateEvent = procedure(const ErrorCode: Integer; const Message: String) of object;

  { a form for displaying an activity indicator while performing background }
  { tasks in another thread }
  TProcessingForm = class(TAdvancedForm)
    actCancel: TAction;
    alProcessing: TActionList;
    btnCancel: TButton;
    lblProcessing: TLabel;
    wiProcessing: TWorkingIndicator;
    procedure actCancelExecute(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);
  private
    FTaskTerminateEvent: TTaskTerminateEvent;
    FTaskThread: TTaskThread;
  protected
    procedure DoTaskTerminate(Sender: TObject);
  public
    destructor Destroy; override;
    function CloseQuery: Boolean; override;
    function RunTask(const TaskProcedure: TTaskProcedure; TaskData: Pointer): Integer;
    procedure EndTask;
  published
    property OnTaskTerminate: TTaskTerminateEvent read FTaskTerminateEvent write FTaskTerminateEvent;
  end;

implementation

uses
  Windows,
  SysUtils;

{$R *.dfm}

{ --- TProcessingForm --------------------------------------------------------}

procedure TProcessingForm.actCancelExecute(Sender: TObject);
begin
  EndTask;
end;

procedure TProcessingForm.actCancelUpdate(Sender: TObject);
begin
  actCancel.Enabled := Assigned(FTaskThread) and not FTaskThread.Terminated;
end;

procedure TProcessingForm.DoTaskTerminate(Sender: TObject);
begin
  Hide;
  ModalResult := mrOK;
  if Assigned(FTaskTerminateEvent) then
    FTaskTerminateEvent(FTaskThread.ReturnValue, FTaskThread.ExceptionMessage);
end;

destructor TProcessingForm.Destroy;
begin
  FreeAndNil(FTaskThread);
  inherited;
end;

function TProcessingForm.CloseQuery: Boolean;
begin
  if Assigned(FTaskThread) then
    Result := FTaskThread.Terminated and inherited CloseQuery
  else
    Result := inherited CloseQuery;
end;

function TProcessingForm.RunTask(const TaskProcedure: TTaskProcedure; TaskData: Pointer): Integer;
begin
  if Assigned(FTaskThread) and not FTaskThread.Terminated then
    raise Exception.Create('Another task is already running');

  FreeAndNil(FTaskThread);
  FTaskThread := TTaskThread.Create(TaskProcedure, TaskData);
  FTaskThread.OnTerminate := DoTaskTerminate;
  FTaskThread.Resume;
  ShowModal;

  Result := FTaskThread.ReturnValue;
end;

procedure TProcessingForm.EndTask;
begin
  if Assigned(FTaskThread) then
    begin
      FTaskThread.Suspend;
      FTaskThread.Terminate;
      FTaskThread.ReturnValue := E_ABORT;
      TerminateThread(FTaskThread.Handle, Cardinal(E_ABORT));
      FTaskThread.OnTerminate(FTaskThread);
    end;
end;

end.
